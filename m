Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F372A4FD8CE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245039AbiDLIPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 04:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355309AbiDLH1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:27:25 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA624924E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 00:07:27 -0700 (PDT)
Received: from kwepemi100004.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Kcxbv1gXmzdZLM;
        Tue, 12 Apr 2022 15:06:51 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi100004.china.huawei.com (7.221.188.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Apr 2022 15:07:25 +0800
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Apr 2022 15:07:24 +0800
From:   Tong Tiangen <tongtiangen@huawei.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Xie XiuQi <xiexiuqi@huawei.com>,
        Tong Tiangen <tongtiangen@huawei.com>
Subject: [RFC PATCH -next V3 4/6] arm64: add copy_{to, from}_user to machine check safe
Date:   Tue, 12 Apr 2022 07:25:50 +0000
Message-ID: <20220412072552.2526871-5-tongtiangen@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
In-Reply-To: <20220412072552.2526871-1-tongtiangen@huawei.com>
References: <20220412072552.2526871-1-tongtiangen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add copy_{to, from}_user() to machine check safe.

If copy fail due to hardware memory error, only the relevant processes are
affected, so killing the user process and isolate the user page with
hardware memory errors is a more reasonable choice than kernel panic.

Add new extable type EX_TYPE_UACCESS_MC which can be used for uaccess that
can be recovered from hardware memory errors.

Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
---
 arch/arm64/include/asm/asm-extable.h | 11 +++++++++++
 arch/arm64/include/asm/asm-uaccess.h | 16 ++++++++++++++++
 arch/arm64/lib/copy_from_user.S      | 15 ++++++++++-----
 arch/arm64/lib/copy_to_user.S        | 25 +++++++++++++++++--------
 4 files changed, 54 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/asm-extable.h b/arch/arm64/include/asm/asm-extable.h
index c39f2437e08e..8af4e7cc9578 100644
--- a/arch/arm64/include/asm/asm-extable.h
+++ b/arch/arm64/include/asm/asm-extable.h
@@ -8,6 +8,9 @@
 #define EX_TYPE_UACCESS_ERR_ZERO	3
 #define EX_TYPE_LOAD_UNALIGNED_ZEROPAD	4
 
+/* _MC indicates that can fixup from machine check errors */
+#define EX_TYPE_UACCESS_MC		5
+
 #ifdef __ASSEMBLY__
 
 #define __ASM_EXTABLE_RAW(insn, fixup, type, data)	\
@@ -27,6 +30,14 @@
 	__ASM_EXTABLE_RAW(\insn, \fixup, EX_TYPE_FIXUP, 0)
 	.endm
 
+/*
+ * Create an exception table entry for `insn`, which will branch to `fixup`
+ * when an unhandled fault(include sea fault) is taken.
+ */
+	.macro          _asm_extable_uaccess_mc, insn, fixup
+	__ASM_EXTABLE_RAW(\insn, \fixup, EX_TYPE_UACCESS_MC, 0)
+	.endm
+
 /*
  * Create an exception table entry for `insn` if `fixup` is provided. Otherwise
  * do nothing.
diff --git a/arch/arm64/include/asm/asm-uaccess.h b/arch/arm64/include/asm/asm-uaccess.h
index 0557af834e03..bb17f0829042 100644
--- a/arch/arm64/include/asm/asm-uaccess.h
+++ b/arch/arm64/include/asm/asm-uaccess.h
@@ -92,4 +92,20 @@ alternative_else_nop_endif
 
 		_asm_extable	8888b,\l;
 	.endm
+
+	.macro user_ldp_mc l, reg1, reg2, addr, post_inc
+8888:		ldtr	\reg1, [\addr];
+8889:		ldtr	\reg2, [\addr, #8];
+		add	\addr, \addr, \post_inc;
+
+		_asm_extable_uaccess_mc	8888b, \l;
+		_asm_extable_uaccess_mc	8889b, \l;
+	.endm
+
+	.macro user_ldst_mc l, inst, reg, addr, post_inc
+8888:		\inst		\reg, [\addr];
+		add		\addr, \addr, \post_inc;
+
+		_asm_extable_uaccess_mc	8888b, \l;
+	.endm
 #endif
diff --git a/arch/arm64/lib/copy_from_user.S b/arch/arm64/lib/copy_from_user.S
index 34e317907524..e32c0747a5f1 100644
--- a/arch/arm64/lib/copy_from_user.S
+++ b/arch/arm64/lib/copy_from_user.S
@@ -21,7 +21,7 @@
  */
 
 	.macro ldrb1 reg, ptr, val
-	user_ldst 9998f, ldtrb, \reg, \ptr, \val
+	user_ldst_mc 9998f, ldtrb, \reg, \ptr, \val
 	.endm
 
 	.macro strb1 reg, ptr, val
@@ -29,7 +29,7 @@
 	.endm
 
 	.macro ldrh1 reg, ptr, val
-	user_ldst 9997f, ldtrh, \reg, \ptr, \val
+	user_ldst_mc 9997f, ldtrh, \reg, \ptr, \val
 	.endm
 
 	.macro strh1 reg, ptr, val
@@ -37,7 +37,7 @@
 	.endm
 
 	.macro ldr1 reg, ptr, val
-	user_ldst 9997f, ldtr, \reg, \ptr, \val
+	user_ldst_mc 9997f, ldtr, \reg, \ptr, \val
 	.endm
 
 	.macro str1 reg, ptr, val
@@ -45,7 +45,7 @@
 	.endm
 
 	.macro ldp1 reg1, reg2, ptr, val
-	user_ldp 9997f, \reg1, \reg2, \ptr, \val
+	user_ldp_mc 9997f, \reg1, \reg2, \ptr, \val
 	.endm
 
 	.macro stp1 reg1, reg2, ptr, val
@@ -54,6 +54,7 @@
 
 end	.req	x5
 srcin	.req	x15
+esr	.req	x16
 SYM_FUNC_START(__arch_copy_from_user)
 	add	end, x0, x2
 	mov	srcin, x1
@@ -62,7 +63,11 @@ SYM_FUNC_START(__arch_copy_from_user)
 	ret
 
 	// Exception fixups
-9997:	cmp	dst, dstin
+9997:	mrs esr, esr_el1			// Check exception first
+	and esr, esr, #ESR_ELx_FSC
+	cmp esr, #ESR_ELx_FSC_EXTABT
+	b.eq 9998f
+	cmp	dst, dstin
 	b.ne	9998f
 	// Before being absolutely sure we couldn't copy anything, try harder
 USER(9998f, ldtrb tmp1w, [srcin])
diff --git a/arch/arm64/lib/copy_to_user.S b/arch/arm64/lib/copy_to_user.S
index 802231772608..afb53e45a21f 100644
--- a/arch/arm64/lib/copy_to_user.S
+++ b/arch/arm64/lib/copy_to_user.S
@@ -20,31 +20,35 @@
  *	x0 - bytes not copied
  */
 	.macro ldrb1 reg, ptr, val
-	ldrb  \reg, [\ptr], \val
+	1000:	ldrb  \reg, [\ptr], \val
+	_asm_extable_uaccess_mc 1000b, 9998f;
 	.endm
 
 	.macro strb1 reg, ptr, val
-	user_ldst 9998f, sttrb, \reg, \ptr, \val
+	user_ldst_mc 9998f, sttrb, \reg, \ptr, \val
 	.endm
 
 	.macro ldrh1 reg, ptr, val
-	ldrh  \reg, [\ptr], \val
+	1001:	ldrh  \reg, [\ptr], \val
+	_asm_extable_uaccess_mc 1001b, 9998f;
 	.endm
 
 	.macro strh1 reg, ptr, val
-	user_ldst 9997f, sttrh, \reg, \ptr, \val
+	user_ldst_mc 9997f, sttrh, \reg, \ptr, \val
 	.endm
 
 	.macro ldr1 reg, ptr, val
-	ldr \reg, [\ptr], \val
+	1002:	ldr \reg, [\ptr], \val
+	_asm_extable_uaccess_mc 1002b, 9998f;
 	.endm
 
 	.macro str1 reg, ptr, val
-	user_ldst 9997f, sttr, \reg, \ptr, \val
+	user_ldst_mc 9997f, sttr, \reg, \ptr, \val
 	.endm
 
 	.macro ldp1 reg1, reg2, ptr, val
-	ldp \reg1, \reg2, [\ptr], \val
+	1003:	ldp \reg1, \reg2, [\ptr], \val
+	_asm_extable_uaccess_mc 1003b, 9998f;
 	.endm
 
 	.macro stp1 reg1, reg2, ptr, val
@@ -53,6 +57,7 @@
 
 end	.req	x5
 srcin	.req	x15
+esr	.req	x16
 SYM_FUNC_START(__arch_copy_to_user)
 	add	end, x0, x2
 	mov	srcin, x1
@@ -61,7 +66,11 @@ SYM_FUNC_START(__arch_copy_to_user)
 	ret
 
 	// Exception fixups
-9997:	cmp	dst, dstin
+9997:	mrs esr, esr_el1			// Check exception first
+	and esr, esr, #ESR_ELx_FSC
+	cmp esr, #ESR_ELx_FSC_EXTABT
+	b.eq 9998f
+	cmp	dst, dstin
 	b.ne	9998f
 	// Before being absolutely sure we couldn't copy anything, try harder
 	ldrb	tmp1w, [srcin]
-- 
2.18.0.huawei.25

