Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE1B470F02
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 00:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345265AbhLJXza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 18:55:30 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40264 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243927AbhLJXzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 18:55:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 665EDB82A13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 23:51:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD33AC341CA;
        Fri, 10 Dec 2021 23:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639180306;
        bh=H54hX6Y+M0l4q1tVGcaVg3FQsEWlleKRCHcnPIccLFU=;
        h=From:To:Cc:Subject:Date:From;
        b=Sixt37nKjFxPhMTfPiR2gFlBkzdVgtmZbWli6uL8rI2NXFXxNzdY2xYyBa4wifdpw
         2N0UBCB+KoS21K0WcS/1MnMnCTH5K4ndvqK33gxB53/PQ2wNJSHm7YoKA1y25kJAWf
         z001Yh1rnlBG5PqwWq7fRlS5FpldKghuNegmDMbJOVvI981XLERcaPk66xZOOdG3eJ
         xeddRh6IXM7RhyO/a8IkI02qRvS2Oo9PYp0vyV/iNkebJytC/991DbfrL5oc4YPfbL
         3UWSLVr5NB1k2TGPhGRhveH5qEJdd7ZfzOrOpuUuYtk+ACI+TRCGcFHy+yQmgzsBQL
         BNx5I7pPUqxkw==
From:   Nathan Chancellor <nathan@kernel.org>
To:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] x86/extable: Fix extable_type_reg macro with Clang LTO
Date:   Fri, 10 Dec 2021 16:49:54 -0700
Message-Id: <20211210234953.3420108-1-nathan@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building x86_64_defconfig + CONFIG_LTO_CLANG_FULL=y after
commit a90a845d94b4 ("x86/extable: Extend extable functionality"), the
build fails during linking:

ld.lld: error: <inline asm>:64:2: macro 'extable_type_reg' is already defined
        .macro extable_type_reg type:req reg:req
        ^

The build failures happens because the definition of extable_type_reg
happens in every source file that includes asm.h, which all get combined
together during LTO.

Commit be604c616ca7 ("arm64: sysreg: Make mrs_s and msr_s macros work
with Clang and LTO") ran into a similar issue and the solution was to
define, use, then undefine the macro within each inline asm block it was
needed in.

Break apart the inline asm macro definition into two macros
({,UN}DEFINE_EXTABLE_TYPE_REG) and use them in _ASM_EXTABLE_TYPE so
there is no more error with LTO.

Link: https://github.com/ClangBuiltLinux/linux/issues/1513
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---

I expect this to be squashed into commit a90a845d94b4 ("x86/extable:
Extend extable functionality") in Peter's x86/wip.extable branch to
avoid bisect issues. The description and link are there for archaeology.

 arch/x86/include/asm/asm.h | 52 ++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index 95bb23082b87..c878fed3056f 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -152,30 +152,32 @@
 
 #else /* ! __ASSEMBLY__ */
 
-asm(
-"	.macro extable_type_reg type:req reg:req\n"
-"	.set found, 0\n"
-"	.set regnr, 0\n"
-"	.irp rs,rax,rcx,rdx,rbx,rsp,rbp,rsi,rdi,r8,r9,r10,r11,r12,r13,r14,r15\n"
-"	.ifc \\reg, %\\rs\n"
-"	.set found, found+1\n"
-"	.long \\type + (regnr << 8)\n"
-"	.endif\n"
-"	.set regnr, regnr+1\n"
-"	.endr\n"
-"	.set regnr, 0\n"
-"	.irp rs,eax,ecx,edx,ebx,esp,ebp,esi,edi,r8d,r9d,r10d,r11d,r12d,r13d,r14d,r15d\n"
-"	.ifc \\reg, %\\rs\n"
-"	.set found, found+1\n"
-"	.long \\type + (regnr << 8)\n"
-"	.endif\n"
-"	.set regnr, regnr+1\n"
-"	.endr\n"
-"	.if (found != 1)\n"
-"	.error \"extable_type_reg: bad register argument\"\n"
-"	.endif\n"
-"	.endm\n"
-);
+# define DEFINE_EXTABLE_TYPE_REG \
+	".macro extable_type_reg type:req reg:req\n"						\
+	".set found, 0\n"									\
+	".set regnr, 0\n"									\
+	".irp rs,rax,rcx,rdx,rbx,rsp,rbp,rsi,rdi,r8,r9,r10,r11,r12,r13,r14,r15\n"		\
+	".ifc \\reg, %%\\rs\n"									\
+	".set found, found+1\n"									\
+	".long \\type + (regnr << 8)\n"								\
+	".endif\n"										\
+	".set regnr, regnr+1\n"									\
+	".endr\n"										\
+	".set regnr, 0\n"									\
+	".irp rs,eax,ecx,edx,ebx,esp,ebp,esi,edi,r8d,r9d,r10d,r11d,r12d,r13d,r14d,r15d\n"	\
+	".ifc \\reg, %%\\rs\n"									\
+	".set found, found+1\n"									\
+	".long \\type + (regnr << 8)\n"								\
+	".endif\n"										\
+	".set regnr, regnr+1\n"									\
+	".endr\n"										\
+	".if (found != 1)\n"									\
+	".error \"extable_type_reg: bad register argument\"\n"					\
+	".endif\n"										\
+	".endm\n"
+
+# define UNDEFINE_EXTABLE_TYPE_REG \
+	".purgem extable_type_reg\n"
 
 # define _ASM_EXTABLE_TYPE(from, to, type)			\
 	" .pushsection \"__ex_table\",\"a\"\n"			\
@@ -190,7 +192,9 @@ asm(
 	" .balign 4\n"								\
 	" .long (" #from ") - .\n"						\
 	" .long (" #to ") - .\n"						\
+	DEFINE_EXTABLE_TYPE_REG							\
 	"extable_type_reg reg=" __stringify(reg) ", type=" __stringify(type) " \n"\
+	UNDEFINE_EXTABLE_TYPE_REG						\
 	" .popsection\n"
 
 /* For C file, we already have NOKPROBE_SYMBOL macro */

base-commit: fa04e38818aeac177f730cfeadfbdb6f7c25f5b4
-- 
2.34.1

