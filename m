Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4B949ABC0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 06:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S256460AbiAYFWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 00:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S254233AbiAYFOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 00:14:05 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2138AC0613E8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 19:39:32 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id a8so12760136pfa.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 19:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1/t/LTv3BwozphL5p05dyEQg+e9Cml3D90Rm6GRzREI=;
        b=QpMGce0huLlDs/bNOVExpgYsJpVCHQPqQus5faZryBaS7Uv4vB8IwZYiZMvKnvR3a9
         RoCEFlOK+fL5MkY5EpUxataCZzvxmRk/o3tR9f905hKmMLChUNDsmHkK34PdfeHNYNzI
         qHoo1RKI7bkekdO3yzSwAxmQlWqyi31SI9VTSgmDfg1IaYkA1Wt88XkqrKj+FuuYc50l
         Nh5/NoxpbCEfTwnHR6oHbZh0cdu9cWJ2MLjn9f5EH6qS+LxkcHmSBOaV4Z5BoNH9MQxZ
         TQmg5WxmhPehKDbynH+lmoxbgPyAK2+TMa/bmIbl8stcSBfI2/w1GLvMtEnpLv17UuW7
         XAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1/t/LTv3BwozphL5p05dyEQg+e9Cml3D90Rm6GRzREI=;
        b=t2pWfrPNkKyfemAlimsLiMsSmzyxaH8FNL0aB8gcHlbebLSyn16gcfnRlyzVTrgknt
         YmxwrwM/aLVzSPexb8Wy+Ij/jKUlv1Ju4f3chO3oLTVWQsHr/4ZK9+3QLxp1XI8DXW/7
         LFEl9qyzQ3omTQJCYz+hC2aGZv3xY0xuUJWrgC7gbZCDGlucGAnlwhoY/shbf5P3lz2y
         3wFkJAbzcRbaFJ92JwSBYwDJ2d2aeUMp7Co7tas7X9CaKluK6yB1m4P0+oYeCzwOKhqF
         G0CFH6LAtpChulQKndJ5cTkA5Uj8Bv0HwM9lxTbifCo+fV3bwOZBe+IeF2qAtdzggjTt
         l38w==
X-Gm-Message-State: AOAM532K/5cePwiif1hkA8Mqn8v/J9i3A1F25YNCFHyTEaasBl659LiC
        le41hLmJxwvXzWE3KzCLJ1fMVcj+FQ==
X-Google-Smtp-Source: ABdhPJzasIzAlVBfEuBbUoqIpJMyA5k4/iugrUlkSkLMFb5GGVYVhgYGh8ATL+f1tyYyZnIiVJJh5g==
X-Received: by 2002:a63:6ac1:: with SMTP id f184mr9558238pgc.455.1643081971364;
        Mon, 24 Jan 2022 19:39:31 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id ck21sm708777pjb.51.2022.01.24.19.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 19:39:29 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Baokun Li <libaokun1@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org
Subject: [PATCH] kexec: disable cpu hotplug until the rebooting cpu is stable
Date:   Tue, 25 Jan 2022 11:39:13 +0800
Message-Id: <20220125033913.15374-1-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following identical code piece appears in both
migrate_to_reboot_cpu() and smp_shutdown_nonboot_cpus():

	if (!cpu_online(primary_cpu))
		primary_cpu = cpumask_first(cpu_online_mask);

Although the kexec-reboot task can get through a cpu_down() on its cpu,
this code looks a little confusing.

Make things straight forward by keep cpu hotplug disabled until
smp_shutdown_nonboot_cpus() holds cpu_add_remove_lock. By this way, the
rebooting cpu can keep unchanged.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Vincent Donnefort <vincent.donnefort@arm.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: YueHaibing <yuehaibing@huawei.com>
Cc: Baokun Li <libaokun1@huawei.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: kexec@lists.infradead.org
To: linux-kernel@vger.kernel.org
---
 kernel/cpu.c        | 16 ++++++++++------
 kernel/kexec_core.c | 10 ++++------
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 407a2568f35e..bc687d59ca90 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1227,20 +1227,24 @@ int remove_cpu(unsigned int cpu)
 }
 EXPORT_SYMBOL_GPL(remove_cpu);
 
+/* primary_cpu keeps unchanged after migrate_to_reboot_cpu() */
 void smp_shutdown_nonboot_cpus(unsigned int primary_cpu)
 {
 	unsigned int cpu;
 	int error;
 
+	/*
+	 * Block other cpu hotplug event, so primary_cpu is always online if
+	 * it is not touched by us
+	 */
 	cpu_maps_update_begin();
-
 	/*
-	 * Make certain the cpu I'm about to reboot on is online.
-	 *
-	 * This is inline to what migrate_to_reboot_cpu() already do.
+	 * migrate_to_reboot_cpu() disables CPU hotplug assuming that
+	 * no further code needs to use CPU hotplug (which is true in
+	 * the reboot case). However, the kexec path depends on using
+	 * CPU hotplug again; so re-enable it here.
 	 */
-	if (!cpu_online(primary_cpu))
-		primary_cpu = cpumask_first(cpu_online_mask);
+	__cpu_hotplug_enable();
 
 	for_each_online_cpu(cpu) {
 		if (cpu == primary_cpu)
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 68480f731192..db4fa6b174e3 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1168,14 +1168,12 @@ int kernel_kexec(void)
 		kexec_in_progress = true;
 		kernel_restart_prepare("kexec reboot");
 		migrate_to_reboot_cpu();
-
 		/*
-		 * migrate_to_reboot_cpu() disables CPU hotplug assuming that
-		 * no further code needs to use CPU hotplug (which is true in
-		 * the reboot case). However, the kexec path depends on using
-		 * CPU hotplug again; so re-enable it here.
+		 * migrate_to_reboot_cpu() disables CPU hotplug. If an arch
+		 * relies on the cpu teardown to achieve reboot, it needs to
+		 * re-enable CPU hotplug there.
 		 */
-		cpu_hotplug_enable();
+
 		pr_notice("Starting new kernel\n");
 		machine_shutdown();
 	}
-- 
2.31.1

