Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9AD951F377
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 06:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbiEIE04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 00:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234262AbiEIERW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 00:17:22 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEEF119231
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 21:13:28 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d22so12696656plr.9
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 21:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1JuimxFJZooT8f2Q6NkZ9f5I0ZgYX0YbblE3FHMmMBk=;
        b=qIr3y8xaiABqjUdW/TFHLdQ/U+nIycklpviv7Lt2ehDkyuK+ZbETlYJTfeOWWmp/Bc
         sF/RZu0mx82VCh8FVJmlyWed5PhBjg3zicl3m02iClay6AqMJ4Sv3akZ8mKV1m12129P
         IwzdMz3q+IfnC8byavEccOp3FHYTuLuCMxF/DK8wS4pZ/JF/i+4tJ0/oADvbjRDX/ACc
         HjVW6fwR3ElhCgj5QCGSkNXnwuU22lqkBnXCrN8Wn85i1RlolIPU3D0RHSQkGyAC7Kup
         yh6ALWZ2VWYB8KNEzXT58SAjs5NwyqxWyvT0QbOlNhZsi2Ld2A6jErGFR31nQ4b3jEn6
         sS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1JuimxFJZooT8f2Q6NkZ9f5I0ZgYX0YbblE3FHMmMBk=;
        b=5HYxDilvI3MAWDJ/SiWe+6BeqI07bUpjo+1okfmiOqr84U6zyIZ4jrgFJJF06srWrE
         maUlko2Y8BK5ZONwuMfLYvS9nG2SgSuUf/iOXUvJZFVhNgtxWHgj5bTdf94LiiduAuBS
         z2z59ej1lkho3nADX+JSLOvBK+7QWSS1zeYCOjhVV/zCt4Fa2lQxCHv7pSN9zt+mfeN9
         hc/YGqejz3BUdHK7GJj+N0a5G6DJ+xwdlj9XVFr9j1k0505zkOcrWZ2/ZaNrPOVNYOao
         pYDN1S8kSdpT47C+dLG5cQyzPqN9GryrSCBhX5SsDEKAcs5AV1xvZtbIbZce3USjvBTZ
         Am/A==
X-Gm-Message-State: AOAM5336pi8m5w7XZ91WN4SIr0B8rBH9n68r5KJzHMxNIrgA7Nj68CvE
        9/+cLENTwc8MasK1BFmzzlZaAvQmZA==
X-Google-Smtp-Source: ABdhPJxXBvvMk5ErpUETnMRmV2cb02nFaqWmb4dkcblP0/r/a8hqFiGGAhO1EPZVe8bfY2R62BNvww==
X-Received: by 2002:a17:902:a585:b0:14d:58ef:65 with SMTP id az5-20020a170902a58500b0014d58ef0065mr14472907plb.139.1652069606480;
        Sun, 08 May 2022 21:13:26 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id m19-20020a17090a7f9300b001cd60246575sm11478545pjl.17.2022.05.08.21.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 21:13:25 -0700 (PDT)
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
        Randy Dunlap <rdunlap@infradead.org>,
        Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org
Subject: [PATCHv3 1/2] cpu/hotplug: Keep cpu hotplug disabled until the rebooting cpu is stable
Date:   Mon,  9 May 2022 12:13:04 +0800
Message-Id: <20220509041305.15056-2-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220509041305.15056-1-kernelfans@gmail.com>
References: <20220509041305.15056-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following code chunk repeats in both
migrate_to_reboot_cpu() and smp_shutdown_nonboot_cpus():

	if (!cpu_online(primary_cpu))
		primary_cpu = cpumask_first(cpu_online_mask);

This is due to a breakage like the following:
kernel_kexec()
   migrate_to_reboot_cpu();
   cpu_hotplug_enable();
                        -----------> comes a cpu_down(this_cpu) on other cpu
   machine_shutdown();
     smp_shutdown_nonboot_cpus(); // re-check "if (!cpu_online(primary_cpu))" to protect against the former breakin

Although the kexec-reboot task can get through a cpu_down() on its cpu,
this code looks a little confusing.

Make things straight forward by keeping cpu hotplug disabled until
smp_shutdown_nonboot_cpus() holds cpu_add_remove_lock. By this way, the
breakage is squashed out and the rebooting cpu can keep unchanged.

Note: this patch only affects the kexec-reboot on arches(arm/arm64/ia64/riscv) ,
which rely on the cpu hot-removing mechanism.

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
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org
To: linux-kernel@vger.kernel.org
---
 kernel/cpu.c        | 16 ++++++++++------
 kernel/kexec_core.c | 10 ++++------
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index d0a9aa0b42e8..bf901fc90329 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1228,20 +1228,24 @@ int remove_cpu(unsigned int cpu)
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

