Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBCE57B1A3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 09:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238622AbiGTHWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 03:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238045AbiGTHWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 03:22:02 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C12B766B83
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 00:22:00 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.2.5.185])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxKeEQrddivyMqAA--.15305S2;
        Wed, 20 Jul 2022 15:21:53 +0800 (CST)
From:   Bibo Mao <maobibo@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] LoongArch: Remove clock setting during cpu hotplug stage
Date:   Wed, 20 Jul 2022 15:21:51 +0800
Message-Id: <20220720072152.3894559-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9AxKeEQrddivyMqAA--.15305S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw4UCw1rCF4UJrWftF4fXwb_yoW8trWrpr
        n3u3Z7KrWkKwn7uw1ktryDCr15Cwn7J343ZFy7Ga4rAFyDAr18uFy5tF97XFWft3sFvayF
        gr1ku3yYka4DWrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UUUUUUUUU==
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On physical machine we can save power by disabling clock of hot removed cpu.
However there will be problem, since different platforms have different clock
setting methods, the code is platform relative. Also it can be in firmware/pmu
compoments or cpu regulator driver, rather than general loongarch cpu booting
flow.

Also on qemu virt machine, device clock/freq setting is not
emulated, there is no such registers.

This patch removes hard-coded register accessing in generic
loongarch cpu boot flow.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
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

