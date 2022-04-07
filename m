Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447244F7C16
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243954AbiDGJsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbiDGJsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:48:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41A4DB2EE;
        Thu,  7 Apr 2022 02:46:45 -0700 (PDT)
Date:   Thu, 07 Apr 2022 09:46:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649324803;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DbcNs/iB+XHJ6Q7gAFJap5zTd8ARrfJfHlYKmBThiXE=;
        b=yS2L3KDCPdDnM1D+svjkOqGnCGy+g/T+BW7rt79b64zOGMbnxb4L78BL2rIFzxGXjtQbkb
        cozBd4ez5LQQTcqTHK6GU1vy8EZvVgu456SSeelQ7FeMzAHkDD0Qka+GNNRPPWw4lX5jV+
        9r9WGXmDjo++ugGQWfyFzZCsWw71Ip5bfbiPYMlq7opuymJcu+GQThbUXe3QZ4hJ9KDtlZ
        pt6QRuMMBk5vh3Jcpp2n5Na0NSMlEP8L++E13SWq34WJNmcxIkRNaLdFvgsYpNCpRtDPdN
        Gi5q9nLRdIMrvOP//QPo5X3yZdZmMAojSLN5W9nVfukLf9XDzZYTK61BDb4DJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649324803;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DbcNs/iB+XHJ6Q7gAFJap5zTd8ARrfJfHlYKmBThiXE=;
        b=nFn9IhC+LEQo8j6MKUVQ7N9LkK9Y7US2MlV3tVCIh2O+oLGvtrBgc8bhLFKenMuGj2B7Ww
        Qda4RmOOKjyPBbDA==
From:   "tip-bot2 for Nick Desaulniers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/extable: Prefer local labels in .set directives
Cc:     Bernardo Meurer Costa <beme@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220329202148.2379697-1-ndesaulniers@google.com>
References: <20220329202148.2379697-1-ndesaulniers@google.com>
MIME-Version: 1.0
Message-ID: <164932480205.389.17976490285637093019.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     334865b2915c33080624e0d06f1c3e917036472c
Gitweb:        https://git.kernel.org/tip/334865b2915c33080624e0d06f1c3e917036472c
Author:        Nick Desaulniers <ndesaulniers@google.com>
AuthorDate:    Tue, 29 Mar 2022 13:21:45 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 07 Apr 2022 11:27:02 +02:00

x86/extable: Prefer local labels in .set directives

Bernardo reported an error that Nathan bisected down to
(x86_64) defconfig+LTO_CLANG_FULL+X86_PMEM_LEGACY.

    LTO     vmlinux.o
  ld.lld: error: <instantiation>:1:13: redefinition of 'found'
  .set found, 0
              ^

  <inline asm>:29:1: while in macro instantiation
  extable_type_reg reg=%eax, type=(17 | ((0) << 16))
  ^

This appears to be another LTO specific issue similar to what was folded
into commit 4b5305decc84 ("x86/extable: Extend extable functionality"),
where the `.set found, 0` in DEFINE_EXTABLE_TYPE_REG in
arch/x86/include/asm/asm.h conflicts with the symbol for the static
function `found` in arch/x86/kernel/pmem.c.

Assembler .set directive declare symbols with global visibility, so the
assembler may not rename such symbols in the event of a conflict. LTO
could rename static functions if there was a conflict in C sources, but
it cannot see into symbols defined in inline asm.

The symbols are also retained in the symbol table, regardless of LTO.

Give the symbols .L prefixes making them locally visible, so that they
may be renamed for LTO to avoid conflicts, and to drop them from the
symbol table regardless of LTO.

Fixes: 4b5305decc84 ("x86/extable: Extend extable functionality")
Reported-by: Bernardo Meurer Costa <beme@google.com>
Debugged-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/r/20220329202148.2379697-1-ndesaulniers@google.com
---
 arch/x86/include/asm/asm.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index c878fed..fbcfec4 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -154,24 +154,24 @@
 
 # define DEFINE_EXTABLE_TYPE_REG \
 	".macro extable_type_reg type:req reg:req\n"						\
-	".set found, 0\n"									\
-	".set regnr, 0\n"									\
+	".set .Lfound, 0\n"									\
+	".set .Lregnr, 0\n"									\
 	".irp rs,rax,rcx,rdx,rbx,rsp,rbp,rsi,rdi,r8,r9,r10,r11,r12,r13,r14,r15\n"		\
 	".ifc \\reg, %%\\rs\n"									\
-	".set found, found+1\n"									\
-	".long \\type + (regnr << 8)\n"								\
+	".set .Lfound, .Lfound+1\n"								\
+	".long \\type + (.Lregnr << 8)\n"							\
 	".endif\n"										\
-	".set regnr, regnr+1\n"									\
+	".set .Lregnr, .Lregnr+1\n"								\
 	".endr\n"										\
-	".set regnr, 0\n"									\
+	".set .Lregnr, 0\n"									\
 	".irp rs,eax,ecx,edx,ebx,esp,ebp,esi,edi,r8d,r9d,r10d,r11d,r12d,r13d,r14d,r15d\n"	\
 	".ifc \\reg, %%\\rs\n"									\
-	".set found, found+1\n"									\
-	".long \\type + (regnr << 8)\n"								\
+	".set .Lfound, .Lfound+1\n"								\
+	".long \\type + (.Lregnr << 8)\n"							\
 	".endif\n"										\
-	".set regnr, regnr+1\n"									\
+	".set .Lregnr, .Lregnr+1\n"								\
 	".endr\n"										\
-	".if (found != 1)\n"									\
+	".if (.Lfound != 1)\n"									\
 	".error \"extable_type_reg: bad register argument\"\n"					\
 	".endif\n"										\
 	".endm\n"
