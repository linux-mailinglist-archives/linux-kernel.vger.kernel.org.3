Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267EE4F5E98
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbiDFMxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbiDFMv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:51:57 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3375DE71
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 01:54:34 -0700 (PDT)
Received: from kwepemi100007.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KYJB55Bx8zBryw;
        Wed,  6 Apr 2022 16:50:21 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi100007.china.huawei.com (7.221.188.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 6 Apr 2022 16:54:32 +0800
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 6 Apr 2022 16:54:31 +0800
From:   Tong Tiangen <tongtiangen@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Tong Tiangen <tongtiangen@huawei.com>
Subject: [RFC PATCH -next V2 5/7] arm64: add get_user to machine check safe
Date:   Wed, 6 Apr 2022 09:13:09 +0000
Message-ID: <20220406091311.3354723-6-tongtiangen@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
In-Reply-To: <20220406091311.3354723-1-tongtiangen@huawei.com>
References: <20220406091311.3354723-1-tongtiangen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

Add scenarios get_user to machine check safe. The processing of
EX_TYPE_UACCESS_ERR_ZERO and EX_TYPE_UACCESS_ERR_ZERO_UCE_RECOVERY is same
and both return -EFAULT.

Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
---
 arch/arm64/include/asm/asm-extable.h | 14 +++++++++++++-
 arch/arm64/include/asm/uaccess.h     |  2 +-
 arch/arm64/mm/extable.c              |  1 +
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/asm-extable.h b/arch/arm64/include/asm/asm-extable.h
index 74d1db74fd86..bfc2d224cbae 100644
--- a/arch/arm64/include/asm/asm-extable.h
+++ b/arch/arm64/include/asm/asm-extable.h
@@ -10,8 +10,11 @@
 
 /* _MC indicates that can fixup from machine check errors */
 #define EX_TYPE_FIXUP_MC		5
+#define EX_TYPE_UACCESS_ERR_ZERO_MC	6
 
-#define IS_EX_TYPE_MC(type) (type == EX_TYPE_FIXUP_MC)
+#define IS_EX_TYPE_MC(type)			\
+	(type == EX_TYPE_FIXUP_MC ||		\
+	 type == EX_TYPE_UACCESS_ERR_ZERO_MC)
 
 #ifdef __ASSEMBLY__
 
@@ -77,6 +80,15 @@
 #define EX_DATA_REG(reg, gpr)						\
 	"((.L__gpr_num_" #gpr ") << " __stringify(EX_DATA_REG_##reg##_SHIFT) ")"
 
+#define _ASM_EXTABLE_UACCESS_ERR_ZERO_MC(insn, fixup, err, zero)		\
+	__DEFINE_ASM_GPR_NUMS							\
+	__ASM_EXTABLE_RAW(#insn, #fixup,					\
+			  __stringify(EX_TYPE_UACCESS_ERR_ZERO_MC),		\
+			  "("							\
+			    EX_DATA_REG(ERR, err) " | "				\
+			    EX_DATA_REG(ZERO, zero)				\
+			  ")")
+
 #define _ASM_EXTABLE_UACCESS_ERR_ZERO(insn, fixup, err, zero)		\
 	__DEFINE_ASM_GPR_NUMS						\
 	__ASM_EXTABLE_RAW(#insn, #fixup, 				\
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index e8dce0cc5eaa..24b662407fbd 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -236,7 +236,7 @@ static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
 	asm volatile(							\
 	"1:	" load "	" reg "1, [%2]\n"			\
 	"2:\n"								\
-	_ASM_EXTABLE_UACCESS_ERR_ZERO(1b, 2b, %w0, %w1)			\
+	_ASM_EXTABLE_UACCESS_ERR_ZERO_MC(1b, 2b, %w0, %w1)		\
 	: "+r" (err), "=&r" (x)						\
 	: "r" (addr))
 
diff --git a/arch/arm64/mm/extable.c b/arch/arm64/mm/extable.c
index f1134c88e849..7c05f8d2bce0 100644
--- a/arch/arm64/mm/extable.c
+++ b/arch/arm64/mm/extable.c
@@ -95,6 +95,7 @@ bool fixup_exception(struct pt_regs *regs, unsigned int esr)
 	case EX_TYPE_BPF:
 		return ex_handler_bpf(ex, regs);
 	case EX_TYPE_UACCESS_ERR_ZERO:
+	case EX_TYPE_UACCESS_ERR_ZERO_MC:
 		return ex_handler_uaccess_err_zero(ex, regs);
 	case EX_TYPE_LOAD_UNALIGNED_ZEROPAD:
 		return ex_handler_load_unaligned_zeropad(ex, regs);
-- 
2.18.0.huawei.25

