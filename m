Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBA84E5F6A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 08:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344172AbiCXHdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348673AbiCXHcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:32:48 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE9399EDD
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 00:31:12 -0700 (PDT)
Received: from integral2.. (unknown [182.2.71.236])
        by gnuweeb.org (Postfix) with ESMTPSA id 7F7B67E70D;
        Thu, 24 Mar 2022 07:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1648107072;
        bh=7Qv9rqJeI71GjuDbibmCUuv1gIB+xsY2a5HJtFAGzSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c2wjHqCEEFZBwwM/AnDUHRZ7THc3ZYWMO2IQGdjSZlJUx9OKGqCMGa6hRY7rhHZKy
         NuAfEBuK6szkDs8V1AEHY/homXOqmjWqmDamMyxjFw/ewWOFZlk9g7kUwy7MK+u4+D
         b/kTypmIgEiV6G1yMaSGgUZztnYeKXAQ0hTlhGfp/ghO8JwjROlYQnXA6E3OGB4JNi
         O2FSemAgJDeDmAFhhuIHG21kEYS4Tk6MHLri2c6OHb5kIbZ7eXKLiFGr0lcasmx9Iq
         hlysp6THpzOVv9HlUZo0qIsC5unxIbeiLav0Sjet7Gi7Ye5Mf7dmSsDANk5CrQ+hWt
         POnW7ZKIC2XFg==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>, x86@kernel.org,
        llvm@lists.linux.dev, David Laight <David.Laight@ACULAB.COM>
Subject: [PATCH v1 06/11] tools/nolibc: i386: Implement syscall with 6 arguments
Date:   Thu, 24 Mar 2022 14:30:34 +0700
Message-Id: <20220324073039.140946-7-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220324073039.140946-1-ammarfaizi2@gnuweeb.org>
References: <20220324073039.140946-1-ammarfaizi2@gnuweeb.org>
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
---

@@ Changelog:

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
index 6eb96ee8c4f7..cdffd99664ae 100644
--- a/tools/include/nolibc/arch-i386.h
+++ b/tools/include/nolibc/arch-i386.h
@@ -145,6 +145,29 @@ struct sys_stat_struct {
 	_ret;						\
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

