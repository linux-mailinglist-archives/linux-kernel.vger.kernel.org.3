Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40738552C05
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 09:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347221AbiFUH2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 03:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347213AbiFUH1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 03:27:45 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED1423BD5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:27:31 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LRyk15dcCzkWhr;
        Tue, 21 Jun 2022 15:26:17 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 21 Jun 2022 15:26:53 +0800
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 21 Jun 2022 15:26:51 +0800
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
Subject: [PATCH -next v6 03/10] arm64: asm-extable: add asm uacess helpers
Date:   Tue, 21 Jun 2022 07:26:31 +0000
Message-ID: <20220621072638.1273594-4-tongtiangen@huawei.com>
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

In subsequent patches we want to explciitly annotate uaccess fixups in
assembly files.

We have existing helpers for this for inline assembly, but due to
differing stringification requirements it's not possible to have a
single definition that we can use for both inline asm and plain asm
files. So as with other cases (e.g. gpr-regnum.h), we must prove
separate helprs for plain asm and inline asm.

So that we can do so, this patch adds helpers to define
EX_TYPE_UACCESS_ERR_ZERO fixups in plain assembly. These correspond 1-1
with the inline assembly versions except for the absence of
stringification. No plain assmebly heleprs are added for
EX_TYPE_LOAD_UNALIGNED_ZEROPAD fixups as these only exist for a single C
function.

For copy_{to,from}_user() we'll need fixups with regs and err, so I've
added _ASM_EXTABLE_UACCESS(insn, fixup), where both the error and zero
registers are WZR.

For clarity, the existing `_asm_extable` assemgbly maco is now defined
in terms of the _ASM_EXTABLE() CPP macro, making the CPP macros
canonical in all cases.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
---
 arch/arm64/include/asm/asm-extable.h | 31 ++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/asm-extable.h b/arch/arm64/include/asm/asm-extable.h
index 204b30bf78b3..2e1e6bc33bcd 100644
--- a/arch/arm64/include/asm/asm-extable.h
+++ b/arch/arm64/include/asm/asm-extable.h
@@ -2,6 +2,9 @@
 #ifndef __ASM_ASM_EXTABLE_H
 #define __ASM_ASM_EXTABLE_H
 
+#include <linux/bits.h>
+#include <asm/gpr-num.h>
+
 #define EX_TYPE_NONE			0
 #define EX_TYPE_FIXUP			1
 #define EX_TYPE_BPF			2
@@ -32,12 +35,32 @@
 	.short		(data);				\
 	.popsection;
 
+#define _ASM_EXTABLE(insn, fixup)	\
+	__ASM_EXTABLE_RAW(insn, fixup, EX_TYPE_FIXUP, 0)
+
+#define EX_DATA_REG(reg, gpr)	\
+	(.L__gpr_num_##gpr << EX_DATA_REG_##reg##_SHIFT)
+
+#define _ASM_EXTABLE_UACCESS_ERR_ZERO(insn, fixup, err, zero)		\
+	__ASM_EXTABLE_RAW(insn, fixup, 					\
+			  EX_TYPE_UACCESS_ERR_ZERO,			\
+			  (						\
+			    EX_DATA_REG(ERR, err) |			\
+			    EX_DATA_REG(ZERO, zero)			\
+			  ))
+
+#define _ASM_EXTABLE_UACCESS_ERR(insn, fixup, err)			\
+	_ASM_EXTABLE_UACCESS_ERR_ZERO(insn, fixup, err, wzr)
+
+#define _ASM_EXTABLE_UACCESS(insn, fixup)				\
+	_ASM_EXTABLE_UACCESS_ERR_ZERO(insn, fixup, wzr, wzr)
+
 /*
  * Create an exception table entry for `insn`, which will branch to `fixup`
  * when an unhandled fault is taken.
  */
 	.macro		_asm_extable, insn, fixup
-	__ASM_EXTABLE_RAW(\insn, \fixup, EX_TYPE_FIXUP, 0)
+	_ASM_EXTABLE(\insn, \fixup)
 	.endm
 
 /*
@@ -52,11 +75,8 @@
 
 #else /* __ASSEMBLY__ */
 
-#include <linux/bits.h>
 #include <linux/stringify.h>
 
-#include <asm/gpr-num.h>
-
 #define __ASM_EXTABLE_RAW(insn, fixup, type, data)	\
 	".pushsection	__ex_table, \"a\"\n"		\
 	".align		2\n"				\
@@ -93,6 +113,9 @@
 #define _ASM_EXTABLE_UACCESS_ERR(insn, fixup, err)			\
 	_ASM_EXTABLE_UACCESS_ERR_ZERO(insn, fixup, err, wzr)
 
+#define _ASM_EXTABLE_UACCESS(insn, fixup)				\
+	_ASM_EXTABLE_UACCESS_ERR_ZERO(insn, fixup, wzr, wzr)
+
 #define _ASM_EXTABLE_KACCESS_ERR(insn, fixup, err)			\
 	_ASM_EXTABLE_KACCESS_ERR_ZERO(insn, fixup, err, wzr)
 
-- 
2.25.1

