Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828964EAB1D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 12:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235080AbiC2KTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 06:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235048AbiC2KTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 06:19:47 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47AC23F398
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 03:18:01 -0700 (PDT)
Received: from integral2.. (unknown [182.2.70.161])
        by gnuweeb.org (Postfix) with ESMTPSA id 632E27E72A;
        Tue, 29 Mar 2022 10:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1648549081;
        bh=sOa5bTrQEKERvFJedlayh1Unbt9LOKPwsCzeI50Bj1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lx/7IuFTk6fAH3rYLwr/TJtsTaUHd3qTJqK3lcjI/hhU25WOBbGYuKY+Mj8ceN5r9
         rokZey+MbRFLdlrhTRRWlmeJS4uX3W41mpW/z5cNbO74neTuvt2hHNNEqWCcuw56nS
         AdbA0hKG4w7mjEtBtJloml4CGj8b9N6IdAvEIMz+7/m2h7tbq+d1kSMmUfHo9fBJo0
         BTd0yG2LtbHaaNTVdBo2IcvtDE8cRCH1Kg2CIuIQ+a0COLQOrxORp/xmVZqTQ5TgsN
         xTEBIWaqDWvCTOV2N+UyIQ9IDxTUUsIJ+pRkhnKO2lY6sr4/NGjUq7iypI17bKvJWJ
         N3kZ5duH8YYuA==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        x86@kernel.org, llvm@lists.linux.dev,
        David Laight <David.Laight@ACULAB.COM>
Subject: [PATCH v2 4/9] tools/nolibc: i386: Implement syscall with 6 arguments
Date:   Tue, 29 Mar 2022 17:17:32 +0700
Message-Id: <20220329101737.58985-5-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220329101737.58985-1-ammarfaizi2@gnuweeb.org>
References: <20220329101737.58985-1-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On i386, the 6th argument of syscall goes in %ebp. However, both Clang
and GCC cannot use %ebp in the clobber list and in the "r" constraint
without using -fomit-frame-pointer. To make it always available for
any kind of compilation, the below workaround is implemented.

  1) Push the 6-th argument.
  2) Push %ebp.
  3) Load the 6-th argument from 4(%esp) to %ebp.
  4) Do the syscall (int $0x80).
  5) Pop %ebp (restore the old value of %ebp).
  6) Add %esp by 4 (undo the stack pointer).

Cc: x86@kernel.org
Cc: llvm@lists.linux.dev
Link: https://lore.kernel.org/lkml/2e335ac54db44f1d8496583d97f9dab0@AcuMS.aculab.com
Suggested-by: David Laight <David.Laight@ACULAB.COM>
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
===
@@ Changelog:

   Link v1: https://lore.gnuweeb.org/gwml/20220324073039.140946-7-ammarfaizi2@gnuweeb.org
   v1 -> v2:
    * No changes *

   Link RFC v2: https://lore.kernel.org/lkml/20220322102115.186179-4-ammarfaizi2@gnuweeb.org
   RFC v2 -> v1:
    - Use the same pattern for syscall6, regardless using GCC or Clang
      (comment from David).
    - Use appropriate constraints for syscall6 instead of always using
      register variables (comment from David).

   Link RFC v1: https://lore.kernel.org/llvm/20220320093750.159991-4-ammarfaizi2@gnuweeb.org
   RFC v1 -> RFC v2:
    - Fix %ebp saving method. Don't use redzone, i386 doesn't have a redzone
      (comment from David and Alviro).
---
 tools/include/nolibc/arch-i386.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/include/nolibc/arch-i386.h b/tools/include/nolibc/arch-i386.h
index 10aada40680d..d7e7212346e2 100644
--- a/tools/include/nolibc/arch-i386.h
+++ b/tools/include/nolibc/arch-i386.h
@@ -167,6 +167,29 @@ struct sys_stat_struct {
 	_ret;                                                                 \
 })
 
+#define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)	\
+({								\
+	long _eax  = (long)(num);				\
+	long _arg6 = (long)(arg6); /* Always in memory */	\
+	__asm__ volatile (					\
+		"pushl	%[_arg6]\n\t"				\
+		"pushl	%%ebp\n\t"				\
+		"movl	4(%%esp),%%ebp\n\t"			\
+		"int	$0x80\n\t"				\
+		"popl	%%ebp\n\t"				\
+		"addl	$4,%%esp\n\t"				\
+		: "+a"(_eax)		/* %eax */		\
+		: "b"(arg1),		/* %ebx */		\
+		  "c"(arg2),		/* %ecx */		\
+		  "d"(arg3),		/* %edx */		\
+		  "S"(arg4),		/* %esi */		\
+		  "D"(arg5),		/* %edi */		\
+		  [_arg6]"m"(_arg6)	/* memory */		\
+		: "memory", "cc"				\
+	);							\
+	_eax;							\
+})
+
 /* startup code */
 /*
  * i386 System V ABI mandates:
-- 
Ammar Faizi

