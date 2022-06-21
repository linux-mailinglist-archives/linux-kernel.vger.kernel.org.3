Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46CC3552C00
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 09:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347164AbiFUH2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 03:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347160AbiFUH1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 03:27:45 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B5F23BE0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:27:32 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LRyk16LVSzkWj6;
        Tue, 21 Jun 2022 15:26:17 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 21 Jun 2022 15:26:58 +0800
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 21 Jun 2022 15:26:56 +0800
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
Subject: [PATCH -next v6 06/10] arm64: extable: cleanup redundant extable type EX_TYPE_FIXUP
Date:   Tue, 21 Jun 2022 07:26:34 +0000
Message-ID: <20220621072638.1273594-7-tongtiangen@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220621072638.1273594-1-tongtiangen@huawei.com>
References: <20220621072638.1273594-1-tongtiangen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

Currently, extable type EX_TYPE_FIXUP is no place to use, We can safely
remove it.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/include/asm/asm-extable.h | 23 ++++-------------------
 arch/arm64/mm/extable.c              |  9 ---------
 2 files changed, 4 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/include/asm/asm-extable.h b/arch/arm64/include/asm/asm-extable.h
index b97213d292ce..980d1dd8e1a3 100644
--- a/arch/arm64/include/asm/asm-extable.h
+++ b/arch/arm64/include/asm/asm-extable.h
@@ -6,11 +6,10 @@
 #include <asm/gpr-num.h>
 
 #define EX_TYPE_NONE			0
-#define EX_TYPE_FIXUP			1
-#define EX_TYPE_BPF			2
-#define EX_TYPE_UACCESS_ERR_ZERO	3
-#define EX_TYPE_KACCESS_ERR_ZERO	4
-#define EX_TYPE_LOAD_UNALIGNED_ZEROPAD	5
+#define EX_TYPE_BPF			1
+#define EX_TYPE_UACCESS_ERR_ZERO	2
+#define EX_TYPE_KACCESS_ERR_ZERO	3
+#define EX_TYPE_LOAD_UNALIGNED_ZEROPAD	4
 
 /* Data fields for EX_TYPE_UACCESS_ERR_ZERO */
 #define EX_DATA_REG_ERR_SHIFT	0
@@ -35,9 +34,6 @@
 	.short		(data);				\
 	.popsection;
 
-#define _ASM_EXTABLE(insn, fixup)	\
-	__ASM_EXTABLE_RAW(insn, fixup, EX_TYPE_FIXUP, 0)
-
 #define EX_DATA_REG(reg, gpr)	\
 	(.L__gpr_num_##gpr << EX_DATA_REG_##reg##_SHIFT)
 
@@ -55,14 +51,6 @@
 #define _ASM_EXTABLE_UACCESS(insn, fixup)				\
 	_ASM_EXTABLE_UACCESS_ERR_ZERO(insn, fixup, wzr, wzr)
 
-/*
- * Create an exception table entry for `insn`, which will branch to `fixup`
- * when an unhandled fault is taken.
- */
-	.macro		_asm_extable, insn, fixup
-	_ASM_EXTABLE(\insn, \fixup)
-	.endm
-
 /*
  * Create an exception table entry for uaccess `insn`, which will branch to `fixup`
  * when an unhandled fault is taken.
@@ -94,9 +82,6 @@
 	".short		(" data ")\n"			\
 	".popsection\n"
 
-#define _ASM_EXTABLE(insn, fixup) \
-	__ASM_EXTABLE_RAW(#insn, #fixup, __stringify(EX_TYPE_FIXUP), "0")
-
 #define EX_DATA_REG(reg, gpr)						\
 	"((.L__gpr_num_" #gpr ") << " __stringify(EX_DATA_REG_##reg##_SHIFT) ")"
 
diff --git a/arch/arm64/mm/extable.c b/arch/arm64/mm/extable.c
index 056591e5ca80..228d681a8715 100644
--- a/arch/arm64/mm/extable.c
+++ b/arch/arm64/mm/extable.c
@@ -16,13 +16,6 @@ get_ex_fixup(const struct exception_table_entry *ex)
 	return ((unsigned long)&ex->fixup + ex->fixup);
 }
 
-static bool ex_handler_fixup(const struct exception_table_entry *ex,
-			     struct pt_regs *regs)
-{
-	regs->pc = get_ex_fixup(ex);
-	return true;
-}
-
 static bool ex_handler_uaccess_err_zero(const struct exception_table_entry *ex,
 					struct pt_regs *regs)
 {
@@ -72,8 +65,6 @@ bool fixup_exception(struct pt_regs *regs)
 		return false;
 
 	switch (ex->type) {
-	case EX_TYPE_FIXUP:
-		return ex_handler_fixup(ex, regs);
 	case EX_TYPE_BPF:
 		return ex_handler_bpf(ex, regs);
 	case EX_TYPE_UACCESS_ERR_ZERO:
-- 
2.25.1

