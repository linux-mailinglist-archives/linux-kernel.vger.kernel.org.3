Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B7D59CC96
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 01:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238480AbiHVX4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 19:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiHVX4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 19:56:37 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BBA5142D
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 16:56:36 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27MNuGWA101777;
        Mon, 22 Aug 2022 18:56:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1661212576;
        bh=uRSflq3dI94CdsfcAqGZMQZPBgEhNCjV5o0i5fgeBdM=;
        h=From:To:CC:Subject:Date;
        b=ptH+8UbUYITe1Esjb7G/5an2OYxTFgGGcAosFSRSn2uvhutiCLPBag9rWnxKriy5l
         z266kpXtOUo4Gl+7k3VAsSdUgp/PtbzIjNoNvBDUQcrqTovT6kRdPXGANgYmGSoTIw
         EcD2hfN/4f+Cmm5oF5lmawYbjxy7WrGRsJpxWksw=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27MNuGYd027535
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Aug 2022 18:56:16 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 22
 Aug 2022 18:56:16 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 22 Aug 2022 18:56:16 -0500
Received: from ula0226330.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27MNuFhr037995;
        Mon, 22 Aug 2022 18:56:16 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Andrew Davis <afd@ti.com>
Subject: [PATCH] ARM: keystone: Replace platform SMP with PSCI
Date:   Mon, 22 Aug 2022 18:56:15 -0500
Message-ID: <20220822235615.7788-1-afd@ti.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The KS2 boot monitor supports PSCI commands. These are already defined
in DT for KS2. We can drop this platform override and remove related
code without changing SMP. Do this here.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/mach-keystone/Makefile   |  4 +--
 arch/arm/mach-keystone/keystone.c |  2 --
 arch/arm/mach-keystone/keystone.h |  5 ----
 arch/arm/mach-keystone/platsmp.c  | 41 -------------------------------
 arch/arm/mach-keystone/smc.S      | 26 --------------------
 5 files changed, 1 insertion(+), 77 deletions(-)
 delete mode 100644 arch/arm/mach-keystone/platsmp.c
 delete mode 100644 arch/arm/mach-keystone/smc.S

diff --git a/arch/arm/mach-keystone/Makefile b/arch/arm/mach-keystone/Makefile
index 739b38be5696..0c1d54aec60f 100644
--- a/arch/arm/mach-keystone/Makefile
+++ b/arch/arm/mach-keystone/Makefile
@@ -1,7 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-y					:= keystone.o smc.o
-
-obj-$(CONFIG_SMP)			+= platsmp.o
+obj-y					:= keystone.o
 
 # PM domain driver for Keystone SOCs
 obj-$(CONFIG_ARCH_KEYSTONE)		+= pm_domain.o
diff --git a/arch/arm/mach-keystone/keystone.c b/arch/arm/mach-keystone/keystone.c
index 2c647bdf8d25..aa352c2de313 100644
--- a/arch/arm/mach-keystone/keystone.c
+++ b/arch/arm/mach-keystone/keystone.c
@@ -18,7 +18,6 @@
 #include <asm/mach/map.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
-#include <asm/smp_plat.h>
 #include <asm/memory.h>
 
 #include "memory.h"
@@ -103,7 +102,6 @@ DT_MACHINE_START(KEYSTONE, "Keystone")
 #if defined(CONFIG_ZONE_DMA) && defined(CONFIG_ARM_LPAE)
 	.dma_zone_size	= SZ_2G,
 #endif
-	.smp		= smp_ops(keystone_smp_ops),
 	.init_machine	= keystone_init,
 	.dt_compat	= keystone_match,
 	.pv_fixup	= keystone_pv_fixup,
diff --git a/arch/arm/mach-keystone/keystone.h b/arch/arm/mach-keystone/keystone.h
index 438e531cc007..71ff8cd2ee4a 100644
--- a/arch/arm/mach-keystone/keystone.h
+++ b/arch/arm/mach-keystone/keystone.h
@@ -8,13 +8,8 @@
 #ifndef __KEYSTONE_H__
 #define __KEYSTONE_H__
 
-#define KEYSTONE_MON_CPU_UP_IDX		0x00
-
 #ifndef __ASSEMBLER__
 
-extern const struct smp_operations keystone_smp_ops;
-extern void secondary_startup(void);
-extern u32 keystone_cpu_smc(u32 command, u32 cpu, u32 addr);
 extern int keystone_pm_runtime_init(void);
 
 #endif /* __ASSEMBLER__ */
diff --git a/arch/arm/mach-keystone/platsmp.c b/arch/arm/mach-keystone/platsmp.c
deleted file mode 100644
index 673fcf3b34b1..000000000000
--- a/arch/arm/mach-keystone/platsmp.c
+++ /dev/null
@@ -1,41 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Keystone SOC SMP platform code
- *
- * Copyright 2013 Texas Instruments, Inc.
- *	Cyril Chemparathy <cyril@ti.com>
- *	Santosh Shilimkar <santosh.shillimkar@ti.com>
- *
- * Based on platsmp.c, Copyright (C) 2002 ARM Ltd.
- */
-
-#include <linux/init.h>
-#include <linux/smp.h>
-#include <linux/io.h>
-#include <linux/pgtable.h>
-
-#include <asm/smp_plat.h>
-#include <asm/prom.h>
-#include <asm/tlbflush.h>
-
-#include "keystone.h"
-
-static int keystone_smp_boot_secondary(unsigned int cpu,
-						struct task_struct *idle)
-{
-	unsigned long start = virt_to_idmap(&secondary_startup);
-	int error;
-
-	pr_debug("keystone-smp: booting cpu %d, vector %08lx\n",
-		 cpu, start);
-
-	error = keystone_cpu_smc(KEYSTONE_MON_CPU_UP_IDX, cpu, start);
-	if (error)
-		pr_err("CPU %d bringup failed with %d\n", cpu, error);
-
-	return error;
-}
-
-const struct smp_operations keystone_smp_ops __initconst = {
-	.smp_boot_secondary	= keystone_smp_boot_secondary,
-};
diff --git a/arch/arm/mach-keystone/smc.S b/arch/arm/mach-keystone/smc.S
deleted file mode 100644
index 21ef75cf5370..000000000000
--- a/arch/arm/mach-keystone/smc.S
+++ /dev/null
@@ -1,26 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Keystone Secure APIs
- *
- * Copyright (C) 2013 Texas Instruments, Inc.
- * 	Santosh Shilimkar <santosh.shilimkar@ti.com>
- */
-
-#include <linux/linkage.h>
-
-/**
- * u32 keystone_cpu_smc(u32 command, u32 cpu, u32 addr)
- *
- * Low level CPU monitor API
- * @command:	Monitor command.
- * @cpu:	CPU Number
- * @addr:	Kernel jump address for boot CPU
- *
- * Return: Non zero value on failure
- */
-	.arch_extension sec
-ENTRY(keystone_cpu_smc)
-	stmfd   sp!, {r4-r11, lr}
-	smc	#0
-	ldmfd   sp!, {r4-r11, pc}
-ENDPROC(keystone_cpu_smc)
-- 
2.36.1

