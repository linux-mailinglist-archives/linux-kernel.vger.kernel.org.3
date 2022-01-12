Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 883CB48BD9F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 04:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349203AbiALDXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 22:23:37 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:31155 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349158AbiALDXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 22:23:37 -0500
Received: from dggeme706-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JYXrj2k2rz8wHk;
        Wed, 12 Jan 2022 11:20:53 +0800 (CST)
Received: from huawei.com (10.67.174.47) by dggeme706-chm.china.huawei.com
 (10.1.199.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.20; Wed, 12
 Jan 2022 11:23:35 +0800
From:   He Ying <heying24@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <mark.rutland@arm.com>, <marcan@marcan.st>, <maz@kernel.org>,
        <joey.gouly@arm.com>, <pcc@google.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <heying24@huawei.com>
Subject: [PATCH] arm64: entry: Save some nops when CONFIG_ARM64_PSEUDO_NMI is not set
Date:   Tue, 11 Jan 2022 22:24:10 -0500
Message-ID: <20220112032410.29231-1-heying24@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220107085536.214501-1-heying24@huawei.com>
References: <20220107085536.214501-1-heying24@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.47]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme706-chm.china.huawei.com (10.1.199.102)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arm64 pseudo-NMI feature code brings some additional nops
when CONFIG_ARM64_PSEUDO_NMI is not set, which is not
necessary. So add necessary ifdeffery to avoid it.

Signed-off-by: He Ying <heying24@huawei.com>
---
 arch/arm64/kernel/entry.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 2f69ae43941d..ffc32d3d909a 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -300,6 +300,7 @@ alternative_else_nop_endif
 	str	w21, [sp, #S_SYSCALLNO]
 	.endif
 
+#ifdef CONFIG_ARM64_PSEUDO_NMI
 	/* Save pmr */
 alternative_if ARM64_HAS_IRQ_PRIO_MASKING
 	mrs_s	x20, SYS_ICC_PMR_EL1
@@ -307,6 +308,7 @@ alternative_if ARM64_HAS_IRQ_PRIO_MASKING
 	mov	x20, #GIC_PRIO_IRQON | GIC_PRIO_PSR_I_SET
 	msr_s	SYS_ICC_PMR_EL1, x20
 alternative_else_nop_endif
+#endif
 
 	/* Re-enable tag checking (TCO set on exception entry) */
 #ifdef CONFIG_ARM64_MTE
@@ -330,6 +332,7 @@ alternative_else_nop_endif
 	disable_daif
 	.endif
 
+#ifdef CONFIG_ARM64_PSEUDO_NMI
 	/* Restore pmr */
 alternative_if ARM64_HAS_IRQ_PRIO_MASKING
 	ldr	x20, [sp, #S_PMR_SAVE]
@@ -339,6 +342,7 @@ alternative_if ARM64_HAS_IRQ_PRIO_MASKING
 	dsb	sy				// Ensure priority change is seen by redistributor
 .L__skip_pmr_sync\@:
 alternative_else_nop_endif
+#endif
 
 	ldp	x21, x22, [sp, #S_PC]		// load ELR, SPSR
 
-- 
2.17.1

