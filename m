Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8360C49DD33
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 10:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238153AbiA0JCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 04:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238144AbiA0JCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 04:02:30 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF75C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 01:02:30 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id d12-20020a17090a628c00b001b4f47e2f51so6918270pjj.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 01:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NOr8pePWI+bJZ/oa++rpCFf9EpUKVjAXphwkR7CQVj4=;
        b=bqpl+VmnL4zn6FZ2t+qWfFzRvZTpzNcwwVlrsoIm6qABHP+3ui3yH+ggMWymZQNXHU
         8Gm4yFd/IBGoS4x8xsiBq+0UJDmjUz2MjNOcNBHxeXsVGUL3ULWGVsFAWdqSRSfrB78z
         YnRlweQDuiJvd1SB0/rWod5eUVZvuPtslmEWEHrXXU+HOvvd+5j2an/hACuR8ALlGEPB
         k174wF9pRRKIYQfynuSSr5ykmp4wa8C+hrQTtzRW63Gf+zOhjIoI6ITrdHE5awq73plW
         pUo+ZnbLuDaAvRz/mq3JAOCIn6EAg5swaGVg7pmWDprIDfCH7XoimT8W2LAdO3mf+z01
         k+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NOr8pePWI+bJZ/oa++rpCFf9EpUKVjAXphwkR7CQVj4=;
        b=h8kLCsl46H7nBc4wPKuhFM6Ku8ynoLMT+4QqmczLJN2vWhKVsZ32z9KpahHLWdxqi9
         6hkIWNyEe5Yxhf6aL4DO7qbDQKOFSWbcVJu0EMZr3k6mHfLkHUUy/s53+NKJcai30vg2
         RaA3s4Zh9O6I0EGTNGFcuNfa6YpoKQbOfZ0bFC8YytvwKqHfgycIHrO6m0+KFbyLMyJF
         p6EiQ9u2fY6j2njFpXSA+d9uwapfPdzzfepaztlHuib2x+8iyU72ip82LR7jYiMc34C6
         qUX7Xfl90fmF9WU7qWu5eUsCboLnkEHlVo6Rwsy6KeV401vcTQs6nNrxyi6T678g/WE8
         Lvrw==
X-Gm-Message-State: AOAM533Nml2uu3dV1OirLD2lb6xt47YKAPhDQ0q6V/cDxlJWvVHbMzAu
        CfmikT2HEaedxiRtMFCrUZByOcryzw==
X-Google-Smtp-Source: ABdhPJz0QpYxbPpTnkIgWlwr9AaijSub8zFBYNU/QsBUvRPB2SpOczpG2ksYXjXPcJ3XKCW3sxiDOA==
X-Received: by 2002:a17:90b:4ad1:: with SMTP id mh17mr3151428pjb.135.1643274149303;
        Thu, 27 Jan 2022 01:02:29 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id v17sm4614165pfm.10.2022.01.27.01.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 01:02:28 -0800 (PST)
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
Subject: [PATCHv2] kexec: disable cpu hotplug until the rebooting cpu is stable
Date:   Thu, 27 Jan 2022 17:02:15 +0800
Message-Id: <20220127090215.32000-1-kernelfans@gmail.com>
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

This is due to a breakage like the following:
   migrate_to_reboot_cpu();
   cpu_hotplug_enable();
                          --> comes a cpu_down(this_cpu) on other cpu
   machine_shutdown();

Although the kexec-reboot task can get through a cpu_down() on its cpu,
this code looks a little confusing.

Make things straight forward by keeping cpu hotplug disabled until
smp_shutdown_nonboot_cpus() holds cpu_add_remove_lock. By this way, the
breakage is squashed out and the rebooting cpu can keep unchanged.

Note: this patch only affects the kexec-reboot on arches, which rely on
cpu hotplug mechanism.

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
Cc: kexec@lists.infradead.org
To: linux-kernel@vger.kernel.org
---
v1 -> v2:
 improve commit log

 kernel/cpu.c        | 16 ++++++++++------
 kernel/kexec_core.c | 10 ++++------
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 9c92147f0812..87bdf21de950 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1240,20 +1240,24 @@ int remove_cpu(unsigned int cpu)
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

