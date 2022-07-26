Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5D558101D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 11:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238104AbiGZJlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 05:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbiGZJlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 05:41:02 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B4C152B1A3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 02:41:00 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.2.5.185])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxv9Ghtt9i7Wk5AA--.17387S3;
        Tue, 26 Jul 2022 17:40:49 +0800 (CST)
From:   Bibo Mao <maobibo@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] LoongArch: Remove clock setting during cpu hotplug stage
Date:   Tue, 26 Jul 2022 17:40:48 +0800
Message-Id: <20220726094049.7200-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220726094049.7200-1-maobibo@loongson.cn>
References: <20220726094049.7200-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Dxv9Ghtt9i7Wk5AA--.17387S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kry5Jry8uryDGw1rurWDtwb_yoW8tFy5pr
        nxu3Z7Kr4kKwn7uw1ktryDCr15Cwn7Gw17ZFy7G34rAa4qyr1UuFyktFZ7XFWft3sFva1F
        gr1kurWjka4DWrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UUUUUUUUU==
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On physical machine we can save power by disabling clock of hot
removed cpu. However as different platforms require different
methods to configure clocks, the code is platform-specific, and
probably belongs to firmware/pmu or cpu regulator, rather than
generic arch/loongarch code.

Also there is no such register on QEMU virt machine since the
clock/frequency regulation is not emulated.

This patch removes the hard-coded clock register accessing in
generic loongarch cpu hotplug flow.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by:   WANG Xuerui <git@xen0n.name>
---
 arch/loongarch/kernel/smp.c | 29 -----------------------------
 include/linux/cpuhotplug.h  |  1 -
 2 files changed, 30 deletions(-)

diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index 73cec62504fb..98b3e059d344 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -359,35 +359,6 @@ void play_dead(void)
 	play_dead_uncached(state_addr);
 }
 
-static int loongson3_enable_clock(unsigned int cpu)
-{
-	uint64_t core_id = cpu_data[cpu].core;
-	uint64_t package_id = cpu_data[cpu].package;
-
-	LOONGSON_FREQCTRL(package_id) |= 1 << (core_id * 4 + 3);
-
-	return 0;
-}
-
-static int loongson3_disable_clock(unsigned int cpu)
-{
-	uint64_t core_id = cpu_data[cpu].core;
-	uint64_t package_id = cpu_data[cpu].package;
-
-	LOONGSON_FREQCTRL(package_id) &= ~(1 << (core_id * 4 + 3));
-
-	return 0;
-}
-
-static int register_loongson3_notifier(void)
-{
-	return cpuhp_setup_state_nocalls(CPUHP_LOONGARCH_SOC_PREPARE,
-					 "loongarch/loongson:prepare",
-					 loongson3_enable_clock,
-					 loongson3_disable_clock);
-}
-early_initcall(register_loongson3_notifier);
-
 #endif
 
 /*
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 19f0dbfdd7fe..b66c5f389159 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -130,7 +130,6 @@ enum cpuhp_state {
 	CPUHP_ZCOMP_PREPARE,
 	CPUHP_TIMERS_PREPARE,
 	CPUHP_MIPS_SOC_PREPARE,
-	CPUHP_LOONGARCH_SOC_PREPARE,
 	CPUHP_BP_PREPARE_DYN,
 	CPUHP_BP_PREPARE_DYN_END		= CPUHP_BP_PREPARE_DYN + 20,
 	CPUHP_BRINGUP_CPU,
-- 
2.31.1

