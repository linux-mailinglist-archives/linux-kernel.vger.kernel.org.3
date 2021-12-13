Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E5F4726D3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 10:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236198AbhLMJy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 04:54:57 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33616 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236550AbhLMJuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 04:50:12 -0500
Date:   Mon, 13 Dec 2021 09:50:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639389011;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7XJMU7z9C3xn3MtfsVXRxr2yvW26q0ONHGKPQvusRyQ=;
        b=PBRpJrIrtuCHMgWTnydzQzgwu0dRM5NvEh9RggBg2uJZFDRkfmU6YKIJ0P0Q9ByiO/6D9j
        WMiOvytjdMcAg+Zllk3ghk0qmJS/ycMNSQVc78NEjOJgmuykFtvkyzA+D2+F1AcZ3RkkqS
        JfO8jSXGA2Z1NtVleHzMnyi3GZ4o2XO4/2InU+zL+quwUkGKaaTaxVpIh2+NlWF7iH8Wpt
        BDnQGzT/xl4u3arVxZsQkJDYPsmnQyQ02oIVl2iA2/9kro8K4v9hAz+ZmD2Sn1CgRwf06V
        xiZWEKTp/i4g2SjMTQNG2YvPDCuyOnLXgbMRLdA20O4RFEzqhiiq0eZRoOOGpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639389011;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7XJMU7z9C3xn3MtfsVXRxr2yvW26q0ONHGKPQvusRyQ=;
        b=5VRaH5oFLVpyv6IfA7P9ka+hXjVLgm4/31pE5im/sX8LAF/GEIcm+aYcbPqABxchR7VQvv
        KyrZcujJwwg6RtCg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/usercopy: Remove .fixup usage
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211110101326.081701085@infradead.org>
References: <20211110101326.081701085@infradead.org>
MIME-Version: 1.0
Message-ID: <163938901043.23020.17375439568539779215.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     d5d797dcbd781cb7c526ad32f31c7fd96babfdb2
Gitweb:        https://git.kernel.org/tip/d5d797dcbd781cb7c526ad32f31c7fd96babfdb2
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 10 Nov 2021 11:01:22 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 11 Dec 2021 09:09:50 +01:00

x86/usercopy: Remove .fixup usage

Typically usercopy does whole word copies followed by a number of byte
copies to finish the tail. This means that on exception it needs to
compute the remaining length as: words*sizeof(long) + bytes.

Create a new extable handler to do just this.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20211110101326.081701085@infradead.org
---
 arch/x86/include/asm/extable_fixup_types.h |  5 ++++-
 arch/x86/lib/usercopy_32.c                 | 28 +++------------------
 arch/x86/lib/usercopy_64.c                 |  8 ++----
 arch/x86/mm/extable.c                      |  9 +++++++-
 4 files changed, 22 insertions(+), 28 deletions(-)

diff --git a/arch/x86/include/asm/extable_fixup_types.h b/arch/x86/include/asm/extable_fixup_types.h
index 8278ed2..b5ab333 100644
--- a/arch/x86/include/asm/extable_fixup_types.h
+++ b/arch/x86/include/asm/extable_fixup_types.h
@@ -50,4 +50,9 @@
 
 #define	EX_TYPE_FAULT_SGX		18
 
+#define	EX_TYPE_UCOPY_LEN		19 /* cx := reg + imm*cx */
+#define	EX_TYPE_UCOPY_LEN1		(EX_TYPE_UCOPY_LEN | EX_DATA_IMM(1))
+#define	EX_TYPE_UCOPY_LEN4		(EX_TYPE_UCOPY_LEN | EX_DATA_IMM(4))
+#define	EX_TYPE_UCOPY_LEN8		(EX_TYPE_UCOPY_LEN | EX_DATA_IMM(8))
+
 #endif
diff --git a/arch/x86/lib/usercopy_32.c b/arch/x86/lib/usercopy_32.c
index 1eb1506..422257c 100644
--- a/arch/x86/lib/usercopy_32.c
+++ b/arch/x86/lib/usercopy_32.c
@@ -42,11 +42,7 @@ do {									\
 		"	movl %2,%0\n"					\
 		"1:	rep; stosb\n"					\
 		"2: " ASM_CLAC "\n"					\
-		".section .fixup,\"ax\"\n"				\
-		"3:	lea 0(%2,%0,4),%0\n"				\
-		"	jmp 2b\n"					\
-		".previous\n"						\
-		_ASM_EXTABLE_UA(0b, 3b)					\
+		_ASM_EXTABLE_TYPE_REG(0b, 2b, EX_TYPE_UCOPY_LEN4, %2)	\
 		_ASM_EXTABLE_UA(1b, 2b)					\
 		: "=&c"(size), "=&D" (__d0)				\
 		: "r"(size & 3), "0"(size / 4), "1"(addr), "a"(0));	\
@@ -148,10 +144,6 @@ __copy_user_intel(void __user *to, const void *from, unsigned long size)
 		       "36:    movl %%eax, %0\n"
 		       "37:    rep; movsb\n"
 		       "100:\n"
-		       ".section .fixup,\"ax\"\n"
-		       "101:   lea 0(%%eax,%0,4),%0\n"
-		       "       jmp 100b\n"
-		       ".previous\n"
 		       _ASM_EXTABLE_UA(1b, 100b)
 		       _ASM_EXTABLE_UA(2b, 100b)
 		       _ASM_EXTABLE_UA(3b, 100b)
@@ -189,7 +181,7 @@ __copy_user_intel(void __user *to, const void *from, unsigned long size)
 		       _ASM_EXTABLE_UA(35b, 100b)
 		       _ASM_EXTABLE_UA(36b, 100b)
 		       _ASM_EXTABLE_UA(37b, 100b)
-		       _ASM_EXTABLE_UA(99b, 101b)
+		       _ASM_EXTABLE_TYPE_REG(99b, 100b, EX_TYPE_UCOPY_LEN4, %%eax)
 		       : "=&c"(size), "=&D" (d0), "=&S" (d1)
 		       :  "1"(to), "2"(from), "0"(size)
 		       : "eax", "edx", "memory");
@@ -254,10 +246,6 @@ static unsigned long __copy_user_intel_nocache(void *to,
 	       "        movl %%eax,%0\n"
 	       "7:      rep; movsb\n"
 	       "8:\n"
-	       ".section .fixup,\"ax\"\n"
-	       "9:      lea 0(%%eax,%0,4),%0\n"
-	       "        jmp 8b\n"
-	       ".previous\n"
 	       _ASM_EXTABLE_UA(0b, 8b)
 	       _ASM_EXTABLE_UA(1b, 8b)
 	       _ASM_EXTABLE_UA(2b, 8b)
@@ -276,7 +264,7 @@ static unsigned long __copy_user_intel_nocache(void *to,
 	       _ASM_EXTABLE_UA(81b, 8b)
 	       _ASM_EXTABLE_UA(14b, 8b)
 	       _ASM_EXTABLE_UA(91b, 8b)
-	       _ASM_EXTABLE_UA(6b, 9b)
+	       _ASM_EXTABLE_TYPE_REG(6b, 8b, EX_TYPE_UCOPY_LEN4, %%eax)
 	       _ASM_EXTABLE_UA(7b, 8b)
 	       : "=&c"(size), "=&D" (d0), "=&S" (d1)
 	       :  "1"(to), "2"(from), "0"(size)
@@ -314,14 +302,8 @@ do {									\
 		"	movl %3,%0\n"					\
 		"1:	rep; movsb\n"					\
 		"2:\n"							\
-		".section .fixup,\"ax\"\n"				\
-		"5:	addl %3,%0\n"					\
-		"	jmp 2b\n"					\
-		"3:	lea 0(%3,%0,4),%0\n"				\
-		"	jmp 2b\n"					\
-		".previous\n"						\
-		_ASM_EXTABLE_UA(4b, 5b)					\
-		_ASM_EXTABLE_UA(0b, 3b)					\
+		_ASM_EXTABLE_TYPE_REG(4b, 2b, EX_TYPE_UCOPY_LEN1, %3)	\
+		_ASM_EXTABLE_TYPE_REG(0b, 2b, EX_TYPE_UCOPY_LEN4, %3)	\
 		_ASM_EXTABLE_UA(1b, 2b)					\
 		: "=&c"(size), "=&D" (__d0), "=&S" (__d1), "=r"(__d2)	\
 		: "3"(size), "0"(size), "1"(to), "2"(from)		\
diff --git a/arch/x86/lib/usercopy_64.c b/arch/x86/lib/usercopy_64.c
index 508c81e..0402a74 100644
--- a/arch/x86/lib/usercopy_64.c
+++ b/arch/x86/lib/usercopy_64.c
@@ -35,12 +35,10 @@ unsigned long __clear_user(void __user *addr, unsigned long size)
 		"	incq   %[dst]\n"
 		"	decl %%ecx ; jnz  1b\n"
 		"2:\n"
-		".section .fixup,\"ax\"\n"
-		"3:	lea 0(%[size1],%[size8],8),%[size8]\n"
-		"	jmp 2b\n"
-		".previous\n"
-		_ASM_EXTABLE_UA(0b, 3b)
+
+		_ASM_EXTABLE_TYPE_REG(0b, 2b, EX_TYPE_UCOPY_LEN8, %[size1])
 		_ASM_EXTABLE_UA(1b, 2b)
+
 		: [size8] "=&c"(size), [dst] "=&D" (__d0)
 		: [size1] "r"(size & 7), "[size8]" (size / 8), "[dst]"(addr));
 	clac();
diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index c869f43..41eaa64 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -145,6 +145,13 @@ static bool ex_handler_imm_reg(const struct exception_table_entry *fixup,
 	return ex_handler_default(fixup, regs);
 }
 
+static bool ex_handler_ucopy_len(const struct exception_table_entry *fixup,
+				  struct pt_regs *regs, int trapnr, int reg, int imm)
+{
+	regs->cx = imm * regs->cx + *pt_regs_nr(regs, reg);
+	return ex_handler_uaccess(fixup, regs, trapnr);
+}
+
 int ex_get_fixup_type(unsigned long ip)
 {
 	const struct exception_table_entry *e = search_exception_tables(ip);
@@ -217,6 +224,8 @@ int fixup_exception(struct pt_regs *regs, int trapnr, unsigned long error_code,
 		return ex_handler_imm_reg(e, regs, reg, imm);
 	case EX_TYPE_FAULT_SGX:
 		return ex_handler_sgx(e, regs, trapnr);
+	case EX_TYPE_UCOPY_LEN:
+		return ex_handler_ucopy_len(e, regs, trapnr, reg, imm);
 	}
 	BUG();
 }
