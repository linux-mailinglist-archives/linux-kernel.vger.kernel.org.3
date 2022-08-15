Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB4659401E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 23:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348949AbiHOViK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 17:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348971AbiHOVgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 17:36:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB934D7CDE;
        Mon, 15 Aug 2022 12:25:36 -0700 (PDT)
Date:   Mon, 15 Aug 2022 19:25:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660591535;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AW8wlvmAfRlXs2t6Er7Hw3fJpuJ1f7y/tb8vSRpcsew=;
        b=SEP/qbLZC5c6AZWKsWTTnlU19LiNx0U454boeD9+e3cgnoFW89lGtrfoa0LZUZVq7+/iKA
        7TH6W5YPBCLeY+hRg/3eEdSQEGBYuRjIB5zoW4vYRmOffipFZzyRQCydoY/Qq8bggPy6rS
        7FJFiDX48Jm4bOWBpsZ/JFFuixUU6vZUdd5BDJgrNz1EyhPN14JU+nrLcuNdasfrAenFaM
        OJv8cEuq7N/d+PlqQq4tytXhJ2V9vSDBtbcc38BPJBBpiKs3rRsnwIxgA4amAgCcBbGxCS
        AssKyXcVMGjvNsn/A5itR6VSjdMcVqmx9ZeJv4EUA3v8DH8qN9r8zcyT2A/KpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660591535;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AW8wlvmAfRlXs2t6Er7Hw3fJpuJ1f7y/tb8vSRpcsew=;
        b=H3rPNalh0Q5Ypr6ULoxX8woMyoEbxB1OASiTxpBeiBxNnf1fxNUEr/gU/kGgu2SRZ40rg4
        RI2GaqIwktFSa3DA==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/uaccess: Improve __try_cmpxchg64_user_asm()
 for x86_32
Cc:     Uros Bizjak <ubizjak@gmail.com>, Borislav Petkov <bp@suse.de>,
        Sean Christopherson <seanjc@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220628161612.7993-1-ubizjak@gmail.com>
References: <20220628161612.7993-1-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <166059153374.401.4511445076917339745.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     4630535c64725bcd722eb59fb8d92be8db943d3d
Gitweb:        https://git.kernel.org/tip/4630535c64725bcd722eb59fb8d92be8db943d3d
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Tue, 28 Jun 2022 18:16:12 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 15 Aug 2022 19:18:12 +02:00

x86/uaccess: Improve __try_cmpxchg64_user_asm() for x86_32

Improve __try_cmpxcgh64_user_asm() for !CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT
by relaxing the output register constraint from "c" to "q" constraint,
which allows the compiler to choose between %ecx or %ebx register.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/r/20220628161612.7993-1-ubizjak@gmail.com
---
 arch/x86/include/asm/uaccess.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 913e593..b0583c1 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -448,7 +448,7 @@ do {									\
 
 #ifdef CONFIG_X86_32
 /*
- * Unlike the normal CMPXCHG, hardcode ECX for both success/fail and error.
+ * Unlike the normal CMPXCHG, use output GPR for both success/fail and error.
  * There are only six GPRs available and four (EAX, EBX, ECX, and EDX) are
  * hardcoded by CMPXCHG8B, leaving only ESI and EDI.  If the compiler uses
  * both ESI and EDI for the memory operand, compilation will fail if the error
@@ -461,11 +461,12 @@ do {									\
 	__typeof__(*(_ptr)) __new = (_new);				\
 	asm volatile("\n"						\
 		     "1: " LOCK_PREFIX "cmpxchg8b %[ptr]\n"		\
-		     "mov $0, %%ecx\n\t"				\
-		     "setz %%cl\n"					\
+		     "mov $0, %[result]\n\t"				\
+		     "setz %b[result]\n"				\
 		     "2:\n"						\
-		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG, %%ecx) \
-		     : [result]"=c" (__result),				\
+		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG,	\
+					   %[result])			\
+		     : [result] "=q" (__result),			\
 		       "+A" (__old),					\
 		       [ptr] "+m" (*_ptr)				\
 		     : "b" ((u32)__new),				\
