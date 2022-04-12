Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852734FD4E5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355620AbiDLIIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 04:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355318AbiDLH1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:27:25 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E40949264
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 00:07:29 -0700 (PDT)
Received: from kwepemi100002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Kcxbw3Jm3zdZqC;
        Tue, 12 Apr 2022 15:06:52 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi100002.china.huawei.com (7.221.188.188) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Apr 2022 15:07:26 +0800
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Apr 2022 15:07:25 +0800
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
Subject: [RFC PATCH -next V3 5/6] arm64: add {get, put}_user to machine check safe
Date:   Tue, 12 Apr 2022 07:25:51 +0000
Message-ID: <20220412072552.2526871-6-tongtiangen@huawei.com>
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

Add {get, put}_user() to machine check safe.

If get/put fail due to hardware memory error, if get/put fail due to
hardware memory error, only the relevant processes are affected, so killing
the user process and isolate the user page with hardware memory errors is a
more reasonable choice than kernel panic.

Add new extable type EX_TYPE_UACCESS_MC_ERR_ZERO which can be used for
uaccess that can be recovered from hardware memory errors. The difference
from EX_TYPE_UACCESS_MC is that this type also sets additional two target
register which save error code and value needs to be set zero.

Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
---
 arch/arm64/include/asm/asm-extable.h | 14 ++++++++++++++
 arch/arm64/include/asm/uaccess.h     |  4 ++--
 arch/arm64/mm/extable.c              |  3 +++
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/asm-extable.h b/arch/arm64/include/asm/asm-extable.h
index 8af4e7cc9578..62eafb651773 100644
--- a/arch/arm64/include/asm/asm-extable.h
+++ b/arch/arm64/include/asm/asm-extable.h
@@ -10,6 +10,7 @@
 
 /* _MC indicates that can fixup from machine check errors */
 #define EX_TYPE_UACCESS_MC		5
+#define EX_TYPE_UACCESS_MC_ERR_ZERO	6
 
 #ifdef __ASSEMBLY__
 
@@ -75,6 +76,15 @@
 #define EX_DATA_REG(reg, gpr)						\
 	"((.L__gpr_num_" #gpr ") << " __stringify(EX_DATA_REG_##reg##_SHIFT) ")"
 
+#define _ASM_EXTABLE_UACCESS_MC_ERR_ZERO(insn, fixup, err, zero)		\
+	__DEFINE_ASM_GPR_NUMS							\
+	__ASM_EXTABLE_RAW(#insn, #fixup,					\
+			  __stringify(EX_TYPE_UACCESS_MC_ERR_ZERO),		\
+			  "("							\
+			    EX_DATA_REG(ERR, err) " | "				\
+			    EX_DATA_REG(ZERO, zero)				\
+			  ")")
+
 #define _ASM_EXTABLE_UACCESS_ERR_ZERO(insn, fixup, err, zero)		\
 	__DEFINE_ASM_GPR_NUMS						\
 	__ASM_EXTABLE_RAW(#insn, #fixup, 				\
@@ -87,6 +97,10 @@
 #define _ASM_EXTABLE_UACCESS_ERR(insn, fixup, err)			\
 	_ASM_EXTABLE_UACCESS_ERR_ZERO(insn, fixup, err, wzr)
 
+
+#define _ASM_EXTABLE_UACCESS_MC_ERR(insn, fixup, err)			\
+	_ASM_EXTABLE_UACCESS_MC_ERR_ZERO(insn, fixup, err, wzr)
+
 #define EX_DATA_REG_DATA_SHIFT	0
 #define EX_DATA_REG_DATA	GENMASK(4, 0)
 #define EX_DATA_REG_ADDR_SHIFT	5
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index e8dce0cc5eaa..e41b47df48b0 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -236,7 +236,7 @@ static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
 	asm volatile(							\
 	"1:	" load "	" reg "1, [%2]\n"			\
 	"2:\n"								\
-	_ASM_EXTABLE_UACCESS_ERR_ZERO(1b, 2b, %w0, %w1)			\
+	_ASM_EXTABLE_UACCESS_MC_ERR_ZERO(1b, 2b, %w0, %w1)		\
 	: "+r" (err), "=&r" (x)						\
 	: "r" (addr))
 
@@ -325,7 +325,7 @@ do {									\
 	asm volatile(							\
 	"1:	" store "	" reg "1, [%2]\n"			\
 	"2:\n"								\
-	_ASM_EXTABLE_UACCESS_ERR(1b, 2b, %w0)				\
+	_ASM_EXTABLE_UACCESS_MC_ERR(1b, 2b, %w0)			\
 	: "+r" (err)							\
 	: "r" (x), "r" (addr))
 
diff --git a/arch/arm64/mm/extable.c b/arch/arm64/mm/extable.c
index 5de256a25464..ca7388f3923b 100644
--- a/arch/arm64/mm/extable.c
+++ b/arch/arm64/mm/extable.c
@@ -79,6 +79,7 @@ bool fixup_exception(struct pt_regs *regs)
 	case EX_TYPE_BPF:
 		return ex_handler_bpf(ex, regs);
 	case EX_TYPE_UACCESS_ERR_ZERO:
+	case EX_TYPE_UACCESS_MC_ERR_ZERO:
 		return ex_handler_uaccess_err_zero(ex, regs);
 	case EX_TYPE_LOAD_UNALIGNED_ZEROPAD:
 		return ex_handler_load_unaligned_zeropad(ex, regs);
@@ -98,6 +99,8 @@ bool fixup_exception_mc(struct pt_regs *regs)
 	switch (ex->type) {
 	case EX_TYPE_UACCESS_MC:
 		return ex_handler_fixup(ex, regs);
+	case EX_TYPE_UACCESS_MC_ERR_ZERO:
+		return ex_handler_uaccess_err_zero(ex, regs);
 	}
 
 	return false;
-- 
2.18.0.huawei.25

