Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E085536B2D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 08:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355815AbiE1G3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 02:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354965AbiE1G3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 02:29:33 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BE331341
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 23:29:31 -0700 (PDT)
Received: from kwepemi500004.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L9BZf6BgtzjX87;
        Sat, 28 May 2022 14:28:42 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi500004.china.huawei.com (7.221.188.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 28 May 2022 14:29:28 +0800
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 28 May 2022 14:29:27 +0800
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
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>
CC:     <linuxppc-dev@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Xie XiuQi <xiexiuqi@huawei.com>,
        Guohanjun <guohanjun@huawei.com>,
        Tong Tiangen <tongtiangen@huawei.com>
Subject: [PATCH -next v5 2/8] arm64: extable: make uaaccess helper use extable type EX_TYPE_UACCESS_ERR_ZERO
Date:   Sat, 28 May 2022 06:50:50 +0000
Message-ID: <20220528065056.1034168-3-tongtiangen@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220528065056.1034168-1-tongtiangen@huawei.com>
References: <20220528065056.1034168-1-tongtiangen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currnetly, the extable type used by __arch_copy_from/to_user() is
EX_TYPE_FIXUP. In fact, It is more clearly to use meaningful
EX_TYPE_UACCESS_*.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
---
 arch/arm64/include/asm/asm-extable.h |  8 ++++++++
 arch/arm64/include/asm/asm-uaccess.h | 12 ++++++------
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/asm-extable.h b/arch/arm64/include/asm/asm-extable.h
index 56ebe183e78b..9c94ac1f082c 100644
--- a/arch/arm64/include/asm/asm-extable.h
+++ b/arch/arm64/include/asm/asm-extable.h
@@ -28,6 +28,14 @@
 	__ASM_EXTABLE_RAW(\insn, \fixup, EX_TYPE_FIXUP, 0)
 	.endm
 
+/*
+ * Create an exception table entry for uaccess `insn`, which will branch to `fixup`
+ * when an unhandled fault is taken.
+ * ex->data = ~0 means both reg_err and reg_zero is set to wzr(x31).
+ */
+	.macro          _asm_extable_uaccess, insn, fixup
+	__ASM_EXTABLE_RAW(\insn, \fixup, EX_TYPE_UACCESS_ERR_ZERO, ~0)
+	.endm
 /*
  * Create an exception table entry for `insn` if `fixup` is provided. Otherwise
  * do nothing.
diff --git a/arch/arm64/include/asm/asm-uaccess.h b/arch/arm64/include/asm/asm-uaccess.h
index 0557af834e03..75b211c98dea 100644
--- a/arch/arm64/include/asm/asm-uaccess.h
+++ b/arch/arm64/include/asm/asm-uaccess.h
@@ -61,7 +61,7 @@ alternative_else_nop_endif
 
 #define USER(l, x...)				\
 9999:	x;					\
-	_asm_extable	9999b, l
+	_asm_extable_uaccess	9999b, l
 
 /*
  * Generate the assembly for LDTR/STTR with exception table entries.
@@ -73,8 +73,8 @@ alternative_else_nop_endif
 8889:		ldtr	\reg2, [\addr, #8];
 		add	\addr, \addr, \post_inc;
 
-		_asm_extable	8888b,\l;
-		_asm_extable	8889b,\l;
+		_asm_extable_uaccess	8888b, \l;
+		_asm_extable_uaccess	8889b, \l;
 	.endm
 
 	.macro user_stp l, reg1, reg2, addr, post_inc
@@ -82,14 +82,14 @@ alternative_else_nop_endif
 8889:		sttr	\reg2, [\addr, #8];
 		add	\addr, \addr, \post_inc;
 
-		_asm_extable	8888b,\l;
-		_asm_extable	8889b,\l;
+		_asm_extable_uaccess	8888b,\l;
+		_asm_extable_uaccess	8889b,\l;
 	.endm
 
 	.macro user_ldst l, inst, reg, addr, post_inc
 8888:		\inst		\reg, [\addr];
 		add		\addr, \addr, \post_inc;
 
-		_asm_extable	8888b,\l;
+		_asm_extable_uaccess	8888b, \l;
 	.endm
 #endif
-- 
2.25.1

