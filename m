Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1874799D1
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 09:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbhLRI5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 03:57:50 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:29139 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232382AbhLRI5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 03:57:47 -0500
Received: from dggeme762-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JGKRP17jQz1DK5N;
        Sat, 18 Dec 2021 16:54:41 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.44) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Sat, 18 Dec 2021 16:57:44 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <linux@armlinux.org.uk>, <krzysztof.kozlowski@canonical.com>,
        <andrew@lunn.ch>, <gregory.clement@bootlin.com>,
        <sebastian.hesselbarth@gmail.com>, <vireshk@kernel.org>,
        <shiraz.linux.kernel@gmail.com>, <soc@kernel.org>,
        <linus.walleij@linaro.org>, <ardb@kernel.org>,
        <cuigaosheng1@huawei.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <gongruiqi1@huawei.com>,
        <wangweiyang2@huawei.com>
Subject: [PATCH -next 1/3] arm-soc: exynos: replace open coded VA->PA conversions
Date:   Sat, 18 Dec 2021 16:58:41 +0800
Message-ID: <20211218085843.212497-2-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20211218085843.212497-1-cuigaosheng1@huawei.com>
References: <20211218085843.212497-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.44]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

This replaces a couple of open coded calculations to obtain the
physical address of a far symbol with calls to the new adr_l etc
macros.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 arch/arm/mach-exynos/headsmp.S |  9 +--------
 arch/arm/mach-exynos/sleep.S   | 26 +++++---------------------
 2 files changed, 6 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-exynos/headsmp.S b/arch/arm/mach-exynos/headsmp.S
index 0ac2cb9a7355..be7cd0eebe1d 100644
--- a/arch/arm/mach-exynos/headsmp.S
+++ b/arch/arm/mach-exynos/headsmp.S
@@ -19,10 +19,7 @@ ENTRY(exynos4_secondary_startup)
 ARM_BE8(setend	be)
 	mrc	p15, 0, r0, c0, c0, 5
 	and	r0, r0, #15
-	adr	r4, 1f
-	ldmia	r4, {r5, r6}
-	sub	r4, r4, r5
-	add	r6, r6, r4
+	adr_l	r6, exynos_pen_release
 pen:	ldr	r7, [r6]
 	cmp	r7, r0
 	bne	pen
@@ -33,7 +30,3 @@ pen:	ldr	r7, [r6]
 	 */
 	b	secondary_startup
 ENDPROC(exynos4_secondary_startup)
-
-	.align 2
-1:	.long	.
-	.long	exynos_pen_release
diff --git a/arch/arm/mach-exynos/sleep.S b/arch/arm/mach-exynos/sleep.S
index ed93f91853b8..ed27515a4458 100644
--- a/arch/arm/mach-exynos/sleep.S
+++ b/arch/arm/mach-exynos/sleep.S
@@ -8,6 +8,7 @@
 
 #include <linux/linkage.h>
 #include <asm/asm-offsets.h>
+#include <asm/assembler.h>
 #include <asm/hardware/cache-l2x0.h>
 #include "smc.h"
 
@@ -54,19 +55,13 @@ ENTRY(exynos_cpu_resume_ns)
 	cmp	r0, r1
 	bne	skip_cp15
 
-	adr	r0, _cp15_save_power
-	ldr	r1, [r0]
-	ldr	r1, [r0, r1]
-	adr	r0, _cp15_save_diag
-	ldr	r2, [r0]
-	ldr	r2, [r0, r2]
+	ldr_l	r1, cp15_save_power
+	ldr_l	r2, cp15_save_diag
 	mov	r0, #SMC_CMD_C15RESUME
 	dsb
 	smc	#0
 #ifdef CONFIG_CACHE_L2X0
-	adr	r0, 1f
-	ldr	r2, [r0]
-	add	r0, r2, r0
+	adr_l	r0, l2x0_saved_regs
 
 	/* Check that the address has been initialised. */
 	ldr	r1, [r0, #L2X0_R_PHY_BASE]
@@ -85,9 +80,7 @@ ENTRY(exynos_cpu_resume_ns)
 	smc	#0
 
 	/* Reload saved regs pointer because smc corrupts registers. */
-	adr	r0, 1f
-	ldr	r2, [r0]
-	add	r0, r2, r0
+	adr_l	r0, l2x0_saved_regs
 
 	ldr	r1, [r0, #L2X0_R_PWR_CTRL]
 	ldr	r2, [r0, #L2X0_R_AUX_CTRL]
@@ -106,15 +99,6 @@ skip_cp15:
 	b	cpu_resume
 ENDPROC(exynos_cpu_resume_ns)
 
-	.align
-_cp15_save_power:
-	.long	cp15_save_power - .
-_cp15_save_diag:
-	.long	cp15_save_diag - .
-#ifdef CONFIG_CACHE_L2X0
-1:	.long	l2x0_saved_regs - .
-#endif /* CONFIG_CACHE_L2X0 */
-
 	.data
 	.align	2
 	.globl cp15_save_diag
-- 
2.30.0

