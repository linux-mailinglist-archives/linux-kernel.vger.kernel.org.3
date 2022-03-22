Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A28B4E3C5F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 11:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbiCVKXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 06:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbiCVKXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 06:23:12 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021CE80206
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 03:21:46 -0700 (PDT)
Received: from integral2.. (unknown [182.2.69.158])
        by gnuweeb.org (Postfix) with ESMTPSA id 5684D7E333;
        Tue, 22 Mar 2022 10:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1647944505;
        bh=dIEcw13d58BgwsAsKr9aSvq4e+T/YoaDZ/K+GATzEMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QZexaRnht7B/2rtHCZZKPWmZStsWAr7sC+7MfIHszEaGUn64SWrsVVwW7HPL8w9/q
         KZYqcFu8U8uiubFOfCuZq5WG1q3RMqDOc0vO1HjMtP0wX05X+LuCoSCkq2cimr5MI+
         kh1WqEvM/8aLv5FgILZ4kmkfBZBgWYqeKzYMloAuuRxeoe+qRcwx5VJ3V+GmVt0qQB
         r2dNYnisQwaR5IBq35gzpCQMbQAONpz+Oz3B9tL06rAO9RAPCt8bJx8YW+pqK6q4oY
         pT9gcnC85RsDmUxn3vQ4GHcZzE4Y8OYyQifp/IcZXABdMcN6YpWqGtYpIE3obQtxH6
         aJ/E9994dz62w==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>, x86@kernel.org,
        llvm@lists.linux.dev, David Laight <David.Laight@ACULAB.COM>
Subject: [RFC PATCH v2 3/8] tools/nolibc: i386: Implement syscall with 6 arguments
Date:   Tue, 22 Mar 2022 17:21:10 +0700
Message-Id: <20220322102115.186179-4-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220322102115.186179-1-ammarfaizi2@gnuweeb.org>
References: <20220322102115.186179-1-ammarfaizi2@gnuweeb.org>
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

For clang (the Assembly statement can't clobber %ebp):
  1) Push the 6-th argument.
  2) Push %ebp.
  3) Load the 6-th argument from 4(%esp) to %ebp.
  4) Do the syscall (int $0x80).
  5) Pop %ebp (restore the old value of %ebp).
  6) Add %esp by 4 (undo the stack pointer).

For GCC, fortunately it has a #pragma that can force a specific function
to be compiled with -fomit-frame-pointer, so it can use "r"(var) where
var is a variable bound to %ebp.

Cc: x86@kernel.org
Cc: llvm@lists.linux.dev
Link: https://lore.kernel.org/lkml/2e335ac54db44f1d8496583d97f9dab0@AcuMS.aculab.com
Suggested-by: David Laight <David.Laight@ACULAB.COM>
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---

@@ Changelog:

   Link RFC v1: https://lore.kernel.org/llvm/20220320093750.159991-4-ammarfaizi2@gnuweeb.org
   RFC v1 -> RFC v2:
    - Fix %ebp saving method. Don't use redzone, i386 doesn't have a redzone
      (comment from David and Alviro).
---
 tools/include/nolibc/arch-i386.h | 66 ++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/tools/include/nolibc/arch-i386.h b/tools/include/nolibc/arch-i386.h
index 125a691fc631..9f4dc36e6ac2 100644
--- a/tools/include/nolibc/arch-i386.h
+++ b/tools/include/nolibc/arch-i386.h
@@ -167,6 +167,72 @@ struct sys_stat_struct {
 	_ret;                                                                 \
 })
 
+
+/*
+ * Both Clang and GCC cannot use %ebp in the clobber list and in the "r"
+ * constraint without using -fomit-frame-pointer. To make it always
+ * available for any kind of compilation, the below workaround is
+ * implemented.
+ *
+ * For clang (the Assembly statement can't clobber %ebp):
+ *   1) Push the 6-th argument.
+ *   2) Push %ebp.
+ *   3) Load the 6-th argument from 4(%esp) to %ebp.
+ *   4) Do the syscall (int $0x80).
+ *   5) Pop %ebp (restore the old value of %ebp).
+ *   6) Add %esp by 4 (undo the stack pointer).
+ *
+ * For GCC, fortunately it has a #pragma that can force a specific function
+ * to be compiled with -fomit-frame-pointer, so it can use "r"(var) where
+ * var is a variable bound to %ebp.
+ *
+ */
+#if defined(__clang__)
+static inline long ____do_syscall6(long eax, long ebx, long ecx, long edx,
+				   long esi, long edi, long ebp)
+{
+	__asm__ volatile (
+		"pushl	%[arg6]\n\t"
+		"pushl	%%ebp\n\t"
+		"movl	4(%%esp), %%ebp\n\t"
+		"int	$0x80\n\t"
+		"popl	%%ebp\n\t"
+		"addl	$4,%%esp\n\t"
+		: "=a"(eax)
+		: "a"(eax), "b"(ebx), "c"(ecx), "d"(edx), "S"(esi), "D"(edi),
+		  [arg6]"m"(ebp)
+		: "memory", "cc"
+	);
+	return eax;
+}
+
+#else /* #if defined(__clang__) */
+#pragma GCC push_options
+#pragma GCC optimize "-fomit-frame-pointer"
+static long ____do_syscall6(long eax, long ebx, long ecx, long edx, long esi,
+			    long edi, long ebp)
+{
+	register long __ebp __asm__("ebp") = ebp;
+	__asm__ volatile (
+		"int	$0x80"
+		: "=a"(eax)
+		: "a"(eax), "b"(ebx), "c"(ecx), "d"(edx), "S"(esi), "D"(edi),
+		  "r"(__ebp)
+		: "memory", "cc"
+	);
+	return eax;
+}
+#pragma GCC pop_options
+#endif /* #if defined(__clang__) */
+
+#define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6) (   \
+	____do_syscall6((long)(num), (long)(arg1),               \
+			(long)(arg2), (long)(arg3),              \
+			(long)(arg4), (long)(arg5),              \
+			(long)(arg6))                            \
+)
+
+
 /* startup code */
 /*
  * i386 System V ABI mandates:
-- 
Ammar Faizi

