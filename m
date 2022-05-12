Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E80A5242FF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 05:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244786AbiELDGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 23:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244437AbiELDGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 23:06:43 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364FF37A9F
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 20:06:42 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id g8so3608450pfh.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 20:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1zm77XuKLZiFKCTXff9/DZf2N76nza4knTVrJw3dY7k=;
        b=d6ZqPlGqZU64GDD4AaDMtWZonPd74O6ETXNgB4PxggKQxFnT45BAv3MNchxszSGq7j
         ZhgXTpXcrDwIeX426COYuKuBgM/U+tU3IZHjmnoLieyXRgAEgKOcfGPzuzD8RbXISyrB
         82Pv0j/XIdHrQcdb32iFTjuE3h0ZSXGAE70DG3fpOdgp+OfwiYhxEUDaSLPLrq4lnt3Q
         Wq2TOJMTTlT0tBFZDbXRkdNJRYiCvheTmW131DugG073TzojAiGVGKX/RZWgrlu888Vr
         +LfMfKsgmleZ62f3O9ve2rXuyFTi/XbyEp80vqt4Ti/jOdPpFTaLUjOENmIBTfGI67Kh
         18aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1zm77XuKLZiFKCTXff9/DZf2N76nza4knTVrJw3dY7k=;
        b=lmHVTNQnYYp1yg1GCUtSU1cW8Q0RSpL4+B6uwC45isS3kLpPNP6aL0IkgXtrsRn4zf
         LyhRv30vGTnzRtgKcZlwbwOE5ra3GoiNF971MU4ZXrnc1oox5bKLOkM2etj1vtN435JW
         cUfW/ozu83ReeXHyc6NM4uXslj+hQ8BndFsA2UynTCtwKjNwPOJ20WFUifZhxxWBV2qY
         GrQdxgJzoE3Mhd3ofmQdi/lCe+makLMKKV40zrryOmNo2Rtu0MROyCQbtpVvSyLjSyft
         W/vNkYRv2vXtapxU2KYDgxwEmvuvFs43Dc5kthQQUyW28+nMf5y2X6nFS5bfT+Bq3LR7
         orIQ==
X-Gm-Message-State: AOAM532PAZjG8c6CPIz1sKGXm0UFhT7LbPB35UY79f/ZOKds9NNqW3fv
        TWPkX9i++ed6BNjqI6/CHw==
X-Google-Smtp-Source: ABdhPJz+qdiTcvw4bPKG8OCo9I2d73PxA49RGqUHPWRCJ9GqlXcyuwY3unb7/BI6LdSPeVzPvJ+2oA==
X-Received: by 2002:a62:7994:0:b0:4e1:58c4:ddfd with SMTP id u142-20020a627994000000b004e158c4ddfdmr9287569pfc.65.1652324801708;
        Wed, 11 May 2022 20:06:41 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id e13-20020aa7980d000000b0050dc762815bsm2488162pfl.53.2022.05.11.20.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 20:06:41 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mark Rutland <mark.rutland@arm.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Baokun Li <libaokun1@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        kexec@lists.infradead.org
Subject: [PATCHv4 1/2] cpu/hotplug: Keep cpu hotplug disabled until the rebooting cpu is stable
Date:   Thu, 12 May 2022 11:06:18 +0800
Message-Id: <20220512030619.13426-2-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220512030619.13426-1-kernelfans@gmail.com>
References: <20220512030619.13426-1-kernelfans@gmail.com>
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

smp_shutdown_nonboot_cpus() repeats the same code chunk as
migrate_to_reboot_cpu() to ensure that the rebooting happens on a valid
cpu.

	if (!cpu_online(primary_cpu))
		primary_cpu = cpumask_first(cpu_online_mask);

This is due to an unexpected cpu-down event like the following:
kernel_kexec()
   migrate_to_reboot_cpu();
   cpu_hotplug_enable();
                        -----------> comes a cpu_down(this_cpu) on other cpu
   machine_shutdown();
     smp_shutdown_nonboot_cpus();    which needs to re-check "if (!cpu_online(primary_cpu))"

Although the kexec-reboot task can get through a cpu_down() on its cpu,
this code looks a little confusing.

Tracing down the git history, the cpu_hotplug_enable() called by
kernel_kexec() is introduced by commit 011e4b02f1da ("powerpc, kexec:
Fix "Processor X is stuck" issue during kexec from ST mode"), which
wakes up all offline cpu by cpu_up(cpu). Later, it is required by the
architectures(arm/arm64/ia64/riscv) which resort to cpu hot-removing to
achieve kexec-reboot by
smp_shutdown_nonboot_cpus()->cpu_down_maps_locked().

Hence, the cpu_hotplug_enable() in kernel_kexec() is an architecture
requirement.

By deferring the cpu hotplug enable to a more proper point, where
smp_shutdown_nonboot_cpus() holds cpu_add_remove_lock, the
unexpected cpu-down event is squashed out and the rebooting cpu can keep
unchanged. (For powerpc, no gains from this change.)

As a result, the repeated code chunk can be removed and in [2/2], the
callsites of smp_shutdown_nonboot_cpus() can be consistent.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vincent Donnefort <vincent.donnefort@arm.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: YueHaibing <yuehaibing@huawei.com>
Cc: Baokun Li <libaokun1@huawei.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: kexec@lists.infradead.org
To: linuxppc-dev@lists.ozlabs.org
To: linux-kernel@vger.kernel.org
---
 arch/powerpc/kexec/core_64.c |  1 +
 kernel/cpu.c                 | 10 +++++-----
 kernel/kexec_core.c          | 11 +++++------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kexec/core_64.c b/arch/powerpc/kexec/core_64.c
index 6cc7793b8420..8ccf22197f08 100644
--- a/arch/powerpc/kexec/core_64.c
+++ b/arch/powerpc/kexec/core_64.c
@@ -224,6 +224,7 @@ static void wake_offline_cpus(void)
 
 static void kexec_prepare_cpus(void)
 {
+	cpu_hotplug_enable();
 	wake_offline_cpus();
 	smp_call_function(kexec_smp_down, NULL, /* wait */0);
 	local_irq_disable();
diff --git a/kernel/cpu.c b/kernel/cpu.c
index d0a9aa0b42e8..4415370f0e91 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1236,12 +1236,12 @@ void smp_shutdown_nonboot_cpus(unsigned int primary_cpu)
 	cpu_maps_update_begin();
 
 	/*
-	 * Make certain the cpu I'm about to reboot on is online.
-	 *
-	 * This is inline to what migrate_to_reboot_cpu() already do.
+	 * At this point, the cpu hotplug is still disabled by
+	 * migrate_to_reboot_cpu() to guarantee that the rebooting happens on
+	 * the selected CPU.  But cpu_down_maps_locked() returns -EBUSY, if
+	 * cpu_hotplug_disabled. So re-enable CPU hotplug here.
 	 */
-	if (!cpu_online(primary_cpu))
-		primary_cpu = cpumask_first(cpu_online_mask);
+	__cpu_hotplug_enable();
 
 	for_each_online_cpu(cpu) {
 		if (cpu == primary_cpu)
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 68480f731192..1bd5a8c95a20 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1168,14 +1168,13 @@ int kernel_kexec(void)
 		kexec_in_progress = true;
 		kernel_restart_prepare("kexec reboot");
 		migrate_to_reboot_cpu();
-
 		/*
-		 * migrate_to_reboot_cpu() disables CPU hotplug assuming that
-		 * no further code needs to use CPU hotplug (which is true in
-		 * the reboot case). However, the kexec path depends on using
-		 * CPU hotplug again; so re-enable it here.
+		 * migrate_to_reboot_cpu() disables CPU hotplug and pin the
+		 * rebooting thread on the selected CPU. If an architecture
+		 * requires CPU hotplug to achieve kexec reboot, it should
+		 * enable the hotplug in the architecture specific code
 		 */
-		cpu_hotplug_enable();
+
 		pr_notice("Starting new kernel\n");
 		machine_shutdown();
 	}
-- 
2.31.1

