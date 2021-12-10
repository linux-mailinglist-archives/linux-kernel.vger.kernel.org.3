Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 439ED47055F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239730AbhLJQP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:15:57 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:52546 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236753AbhLJQP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:15:56 -0500
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.1)
 id f00c592c3ba2d407; Fri, 10 Dec 2021 17:12:20 +0100
Received: from kreacher.localnet (unknown [213.134.162.58])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id C5C0666AD3B;
        Fri, 10 Dec 2021 17:12:19 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Drop redundant intel_pstate_get_hwp_cap() call
Date:   Fri, 10 Dec 2021 17:12:18 +0100
Message-ID: <5782812.lOV4Wx5bFT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.162.58
X-CLIENT-HOSTNAME: 213.134.162.58
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvuddrkedvgdekiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhephfegtdffjeehkeegleejveevtdeugfffieeijeduuddtkefgjedvheeujeejtedvnecukfhppedvudefrddufeegrdduiedvrdehkeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpedvudefrddufeegrdduiedvrdehkedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It is not necessary to call intel_pstate_get_hwp_cap() from
intel_pstate_update_perf_limits(), because it gets called from
intel_pstate_verify_cpu_policy() which is either invoked directly
right before intel_pstate_update_perf_limits(), in
intel_cpufreq_verify_policy() in the passive mode, or called
from driver callbacks in a sequence that causes it to be followed
by an immediate intel_pstate_update_perf_limits().

Namely, in the active mode intel_cpufreq_verify_policy() is called
by intel_pstate_verify_policy() which is the ->verify() callback
routine of intel_pstate and gets called by the cpufreq core right
before intel_pstate_set_policy(), which is the driver's ->setoplicy()
callback routine, where intel_pstate_update_perf_limits() is called.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -2486,18 +2486,14 @@ static void intel_pstate_update_perf_lim
 	 * HWP needs some special consideration, because HWP_REQUEST uses
 	 * abstract values to represent performance rather than pure ratios.
 	 */
-	if (hwp_active) {
-		intel_pstate_get_hwp_cap(cpu);
+	if (hwp_active && cpu->pstate.scaling != perf_ctl_scaling) {
+		int scaling = cpu->pstate.scaling;
+		int freq;
 
-		if (cpu->pstate.scaling != perf_ctl_scaling) {
-			int scaling = cpu->pstate.scaling;
-			int freq;
-
-			freq = max_policy_perf * perf_ctl_scaling;
-			max_policy_perf = DIV_ROUND_UP(freq, scaling);
-			freq = min_policy_perf * perf_ctl_scaling;
-			min_policy_perf = DIV_ROUND_UP(freq, scaling);
-		}
+		freq = max_policy_perf * perf_ctl_scaling;
+		max_policy_perf = DIV_ROUND_UP(freq, scaling);
+		freq = min_policy_perf * perf_ctl_scaling;
+		min_policy_perf = DIV_ROUND_UP(freq, scaling);
 	}
 
 	pr_debug("cpu:%d min_policy_perf:%d max_policy_perf:%d\n",



