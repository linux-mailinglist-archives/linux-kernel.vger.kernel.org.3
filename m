Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6672A5B2527
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 19:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbiIHRuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 13:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiIHRuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 13:50:13 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71D34DB40
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 10:50:11 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4MNmZ0175Tz9smQ;
        Thu,  8 Sep 2022 19:38:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id doxHdpMTK0lZ; Thu,  8 Sep 2022 19:38:32 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4MNmYj6R8Jz9smS;
        Thu,  8 Sep 2022 19:38:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7B0A98B792;
        Thu,  8 Sep 2022 19:38:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id PA9n5bkGlhPf; Thu,  8 Sep 2022 19:38:17 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.247])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 304888B790;
        Thu,  8 Sep 2022 19:38:17 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 288HcDim3449213
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 8 Sep 2022 19:38:14 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 288HcD933449212;
        Thu, 8 Sep 2022 19:38:13 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 18/19] powerpc: Cleanup idle for e500
Date:   Thu,  8 Sep 2022 19:37:51 +0200
Message-Id: <9ddb4b41a712c7c60c8ac72b55cbe96c99040c68.1662658653.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <4e7e6259e5af0e0e171f19ee1f85ab5b2553723f.1662658653.git.christophe.leroy@csgroup.eu>
References: <4e7e6259e5af0e0e171f19ee1f85ab5b2553723f.1662658653.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1662658668; l=4717; s=20211009; h=from:subject:message-id; bh=2++AAnzzOJYJGhhhMcfuX+a8XV2xZcg62ybaUo1obvs=; b=dumMQnvOhP7pxhuM+evcSR1zRszBI3bvPBH+g7CXHVGHtQ5iK1SV1vNnKVDxRHh9uyNn3dH6ch4w GLQgupIIBVpvlErhxZKGsMLXksYI9SfkAasY2jJwxUsLLI6SHUxu
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

e500 idle setup is a bit messy.

e500_idle() is used for PPC32 while book3e_idle() is used for PPC64.
As they are mutually exclusive, call them all e500_idle().

Use CONFIG_MPC_85xx instead of PPC32 + E500 in Makefile and rename
idle_e500.c to idle_85xx.c .

Rename idle_book3e.c to idle_64e.c and remove #ifdef PPC64 in
as it's only built on PPC64.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/machdep.h                | 1 -
 arch/powerpc/kernel/Makefile                      | 6 ++----
 arch/powerpc/kernel/{idle_book3e.S => idle_64e.S} | 8 ++------
 arch/powerpc/kernel/{idle_e500.S => idle_85xx.S}  | 0
 arch/powerpc/platforms/85xx/corenet_generic.c     | 4 ----
 arch/powerpc/platforms/85xx/qemu_e500.c           | 4 ----
 6 files changed, 4 insertions(+), 19 deletions(-)
 rename arch/powerpc/kernel/{idle_book3e.S => idle_64e.S} (93%)
 rename arch/powerpc/kernel/{idle_e500.S => idle_85xx.S} (100%)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 8cb83600c434..378b8d5836a7 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -204,7 +204,6 @@ struct machdep_calls {
 extern void e500_idle(void);
 extern void power4_idle(void);
 extern void ppc6xx_idle(void);
-extern void book3e_idle(void);
 
 /*
  * ppc_md contains a copy of the machine description structure for the
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 658c4dffaa56..1f121c188805 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -81,7 +81,7 @@ obj-$(CONFIG_PPC_DAWR)		+= dawr.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_ppc970.o cpu_setup_pa6t.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_power.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= mce.o mce_power.o
-obj-$(CONFIG_PPC_BOOK3E_64)	+= exceptions-64e.o idle_book3e.o
+obj-$(CONFIG_PPC_BOOK3E_64)	+= exceptions-64e.o idle_64e.o
 obj-$(CONFIG_PPC_BARRIER_NOSPEC) += security.o
 obj-$(CONFIG_PPC64)		+= vdso64_wrapper.o
 obj-$(CONFIG_ALTIVEC)		+= vecemu.o
@@ -100,9 +100,7 @@ obj-$(CONFIG_GENERIC_TBSYNC)	+= smp-tbsync.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 obj-$(CONFIG_FA_DUMP)		+= fadump.o
 obj-$(CONFIG_PRESERVE_FA_DUMP)	+= fadump.o
-ifdef CONFIG_PPC32
-obj-$(CONFIG_PPC_E500)		+= idle_e500.o
-endif
+obj-$(CONFIG_PPC_85xx)		+= idle_85xx.o
 obj-$(CONFIG_PPC_BOOK3S_32)	+= idle_6xx.o l2cr_6xx.o cpu_setup_6xx.o
 obj-$(CONFIG_TAU)		+= tau_6xx.o
 obj-$(CONFIG_HIBERNATION)	+= swsusp.o suspend.o
diff --git a/arch/powerpc/kernel/idle_book3e.S b/arch/powerpc/kernel/idle_64e.S
similarity index 93%
rename from arch/powerpc/kernel/idle_book3e.S
rename to arch/powerpc/kernel/idle_64e.S
index cc008de58b05..1736aad2afe9 100644
--- a/arch/powerpc/kernel/idle_book3e.S
+++ b/arch/powerpc/kernel/idle_64e.S
@@ -2,7 +2,7 @@
 /*
  * Copyright 2010 IBM Corp, Benjamin Herrenschmidt <benh@kernel.crashing.org>
  *
- * Generic idle routine for Book3E processors
+ * Generic idle routine for 64 bits e500 processors
  */
 
 #include <linux/threads.h>
@@ -16,8 +16,6 @@
 #include <asm/hw_irq.h>
 
 /* 64-bit version only for now */
-#ifdef CONFIG_PPC64
-
 .macro BOOK3E_IDLE name loop
 _GLOBAL(\name)
 	/* Save LR for later */
@@ -98,6 +96,4 @@ epapr_ev_idle_start:
 
 BOOK3E_IDLE epapr_ev_idle EPAPR_EV_IDLE_LOOP
 
-BOOK3E_IDLE book3e_idle BOOK3E_IDLE_LOOP
-
-#endif /* CONFIG_PPC64 */
+BOOK3E_IDLE e500_idle BOOK3E_IDLE_LOOP
diff --git a/arch/powerpc/kernel/idle_e500.S b/arch/powerpc/kernel/idle_85xx.S
similarity index 100%
rename from arch/powerpc/kernel/idle_e500.S
rename to arch/powerpc/kernel/idle_85xx.S
diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index 28d6b36f1ccd..2c539de2d629 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -200,9 +200,5 @@ define_machine(corenet_generic) {
 #endif
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
-#ifdef CONFIG_PPC64
-	.power_save		= book3e_idle,
-#else
 	.power_save		= e500_idle,
-#endif
 };
diff --git a/arch/powerpc/platforms/85xx/qemu_e500.c b/arch/powerpc/platforms/85xx/qemu_e500.c
index 64109ad6736c..1639e222cc33 100644
--- a/arch/powerpc/platforms/85xx/qemu_e500.c
+++ b/arch/powerpc/platforms/85xx/qemu_e500.c
@@ -68,9 +68,5 @@ define_machine(qemu_e500) {
 	.get_irq		= mpic_get_coreint_irq,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
-#ifdef CONFIG_PPC64
-	.power_save		= book3e_idle,
-#else
 	.power_save		= e500_idle,
-#endif
 };
-- 
2.37.1

