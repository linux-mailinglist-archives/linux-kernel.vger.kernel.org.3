Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F095159AEBB
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 16:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345561AbiHTOtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 10:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344493AbiHTOs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 10:48:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9F819017
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 07:48:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58681B80025
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 14:48:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8CBC433C1;
        Sat, 20 Aug 2022 14:48:50 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: Cleanup reset routines with new API
Date:   Sat, 20 Aug 2022 22:48:42 +0800
Message-Id: <20220820144842.531266-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup reset routines by using new do_kernel_power_off() instead of old
pm_power_off(), and then simplify the whole file (reset.c) organization
by inlining some functions. This cleanup also fix a poweroff error if EFI
runtime is disabled.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/reboot.h | 10 -----
 arch/loongarch/kernel/reset.c       | 69 +++++++++--------------------
 2 files changed, 21 insertions(+), 58 deletions(-)
 delete mode 100644 arch/loongarch/include/asm/reboot.h

diff --git a/arch/loongarch/include/asm/reboot.h b/arch/loongarch/include/asm/reboot.h
deleted file mode 100644
index 51151749d8f0..000000000000
--- a/arch/loongarch/include/asm/reboot.h
+++ /dev/null
@@ -1,10 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
- */
-#ifndef _ASM_REBOOT_H
-#define _ASM_REBOOT_H
-
-extern void (*pm_restart)(void);
-
-#endif /* _ASM_REBOOT_H */
diff --git a/arch/loongarch/kernel/reset.c b/arch/loongarch/kernel/reset.c
index 800c965a17ea..8c82021eb2f4 100644
--- a/arch/loongarch/kernel/reset.c
+++ b/arch/loongarch/kernel/reset.c
@@ -15,10 +15,16 @@
 #include <acpi/reboot.h>
 #include <asm/idle.h>
 #include <asm/loongarch.h>
-#include <asm/reboot.h>
 
-static void default_halt(void)
+void (*pm_power_off)(void);
+EXPORT_SYMBOL(pm_power_off);
+
+void machine_halt(void)
 {
+#ifdef CONFIG_SMP
+	preempt_disable();
+	smp_send_stop();
+#endif
 	local_irq_disable();
 	clear_csr_ecfg(ECFG0_IM);
 
@@ -30,18 +36,29 @@ static void default_halt(void)
 	}
 }
 
-static void default_poweroff(void)
+void machine_power_off(void)
 {
+#ifdef CONFIG_SMP
+	preempt_disable();
+	smp_send_stop();
+#endif
+	do_kernel_power_off();
 #ifdef CONFIG_EFI
 	efi.reset_system(EFI_RESET_SHUTDOWN, EFI_SUCCESS, 0, NULL);
 #endif
+
 	while (true) {
 		__arch_cpu_idle();
 	}
 }
 
-static void default_restart(void)
+void machine_restart(char *command)
 {
+#ifdef CONFIG_SMP
+	preempt_disable();
+	smp_send_stop();
+#endif
+	do_kernel_restart(command);
 #ifdef CONFIG_EFI
 	if (efi_capsule_pending(NULL))
 		efi_reboot(REBOOT_WARM, NULL);
@@ -55,47 +72,3 @@ static void default_restart(void)
 		__arch_cpu_idle();
 	}
 }
-
-void (*pm_restart)(void);
-EXPORT_SYMBOL(pm_restart);
-
-void (*pm_power_off)(void);
-EXPORT_SYMBOL(pm_power_off);
-
-void machine_halt(void)
-{
-#ifdef CONFIG_SMP
-	preempt_disable();
-	smp_send_stop();
-#endif
-	default_halt();
-}
-
-void machine_power_off(void)
-{
-#ifdef CONFIG_SMP
-	preempt_disable();
-	smp_send_stop();
-#endif
-	pm_power_off();
-}
-
-void machine_restart(char *command)
-{
-#ifdef CONFIG_SMP
-	preempt_disable();
-	smp_send_stop();
-#endif
-	do_kernel_restart(command);
-	pm_restart();
-}
-
-static int __init loongarch_reboot_setup(void)
-{
-	pm_restart = default_restart;
-	pm_power_off = default_poweroff;
-
-	return 0;
-}
-
-arch_initcall(loongarch_reboot_setup);
-- 
2.31.1

