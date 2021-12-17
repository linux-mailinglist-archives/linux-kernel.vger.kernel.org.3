Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A158F479487
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 20:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240467AbhLQTGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 14:06:17 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:60308 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbhLQTGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 14:06:16 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 4.0.0)
 id 6f7a3e1d06ed3d75; Fri, 17 Dec 2021 20:06:15 +0100
Received: from kreacher.localnet (unknown [213.134.187.104])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id AD20766AF13;
        Fri, 17 Dec 2021 20:06:14 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Update cpuinfo.max_freq on HWP_CAP changes
Date:   Fri, 17 Dec 2021 20:06:08 +0100
Message-ID: <2628438.mvXUDI8C0e@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.187.104
X-CLIENT-HOSTNAME: 213.134.187.104
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvuddrleeigdduvddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpefhgedtffejheekgeeljeevvedtuefgffeiieejuddutdekgfejvdehueejjeetvdenucfkphepvddufedrudefgedrudekjedruddtgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddukeejrddutdegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

With HWP enabled, when the turbo range of performance levels is
disabled by the platform firmware, the CPU capacity is given by
the "guaranteed performance" field in MSR_HWP_CAPABILITIES which
is generally dynamic.  When it changes, the kernel receives an HWP
notification interrupt handled by notify_hwp_interrupt().

When the "guaranteed performance" value changes in the above
configuration, the CPU performance scaling needs to be adjusted so
as the use the new CPU capacity in computations, which means that
the cpuinfo.max_freq value needs to be update for that CPU.

Accordingly, modify intel_pstate_notify_work() to read
MSR_HWP_CAPABILITIES and update cpuinfo.max_freq to reflect the
new configuration (this update can be carried out even if the
configuration doesn't actually change, because it simply doesn't
matter then and it takes less time to update it than to do extra
checks to decide whether or not a change has really occurred).

Reported-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Tested-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -1124,19 +1124,22 @@ static void intel_pstate_update_policies
 		cpufreq_update_policy(cpu);
 }
 
+static void __intel_pstate_update_max_freq(struct cpudata *cpudata,
+					   struct cpufreq_policy *policy)
+{
+	policy->cpuinfo.max_freq = global.turbo_disabled_mf ?
+			cpudata->pstate.max_freq : cpudata->pstate.turbo_freq;
+	refresh_frequency_limits(policy);
+}
+
 static void intel_pstate_update_max_freq(unsigned int cpu)
 {
 	struct cpufreq_policy *policy = cpufreq_cpu_acquire(cpu);
-	struct cpudata *cpudata;
 
 	if (!policy)
 		return;
 
-	cpudata = all_cpu_data[cpu];
-	policy->cpuinfo.max_freq = global.turbo_disabled_mf ?
-			cpudata->pstate.max_freq : cpudata->pstate.turbo_freq;
-
-	refresh_frequency_limits(policy);
+	__intel_pstate_update_max_freq(all_cpu_data[cpu], policy);
 
 	cpufreq_cpu_release(policy);
 }
@@ -1584,8 +1592,15 @@ static void intel_pstate_notify_work(str
 {
 	struct cpudata *cpudata =
 		container_of(to_delayed_work(work), struct cpudata, hwp_notify_work);
+	struct cpufreq_policy *policy = cpufreq_cpu_acquire(cpudata->cpu);
+
+	if (policy) {
+		intel_pstate_get_hwp_cap(cpudata);
+		__intel_pstate_update_max_freq(cpudata, policy);
+
+		cpufreq_cpu_release(policy);
+	}
 
-	cpufreq_update_policy(cpudata->cpu);
 	wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_STATUS, 0);
 }
 



