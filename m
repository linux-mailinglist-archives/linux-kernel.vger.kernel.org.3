Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92C74E1AE8
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 10:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243693AbiCTJka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 05:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243465AbiCTJkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 05:40:16 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A32ADF4D
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 02:38:54 -0700 (PDT)
Received: from integral2.. (unknown [182.2.42.189])
        by gnuweeb.org (Postfix) with ESMTPSA id 4FF1E7E330;
        Sun, 20 Mar 2022 09:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1647769134;
        bh=aEfE9CLxI0sxWAhv7IlCmtmu0aC+hA6/IQ9IGhanNbs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n+n4WgnLrhp8p2OXLuYusMr1M3M9aqB41+ilomgxOrpC1ocIT+TYfwshpgHz3whOM
         V14BlNdO6aQAElqIRrY0FCjBnHwAIgBQXrrVbIkAyzIv02pDrl3mTIjOzhH2lGRURQ
         Y51ubU1zK2XBxPwKWQZcJGjza1Y33aSdXokoO07oq/3m41cctEmMAtRKfTfP8DHVtT
         uKdB4RpsuKdi7YW8zrtUI1leYiU9EPe5hEOksGDt2DDKT4j8Tv21Jr8AsyFYEURtZD
         ouSLTmUJSFoD8JyL2Nc/m3u3dUCBJPQ9mbmOiIJ34OJR0AY+7yBrZglFNSisBmH5dJ
         rhetl2I0p5vpA==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>, x86@kernel.org,
        llvm@lists.linux.dev
Subject: [RFC PATCH v1 3/6] tools/nolibc: i386: Implement syscall with 6 arguments
Date:   Sun, 20 Mar 2022 16:37:47 +0700
Message-Id: <20220320093750.159991-4-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220320093750.159991-1-ammarfaizi2@gnuweeb.org>
References: <20220320093750.159991-1-ammarfaizi2@gnuweeb.org>
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

In i386, the 6th argument of syscall goes in %ebp. However, both Clang
and GCC cannot use %ebp in the clobber list and in the "r" constraint
without using -fomit-frame-pointer. To make it always available for any
kind of compilation, the below workaround is implemented.

For clang (the Assembly statement can't clobber %ebp):
  1) Save the %ebp value to the redzone area -4(%esp).
  2) Load the 6-th argument from memory to %ebp.
  3) Subtract the %esp by 4.
  4) Do the syscall (int $0x80).
  5) Pop %ebp.

For GCC, fortunately it has a #pragma that can force a specific function
to be compiled with -fomit-frame-pointer, so it can always use "r"(var)
where `var` is a variable bound to %ebp.

Cc: x86@kernel.org
Cc: llvm@lists.linux.dev
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 tools/include/nolibc/arch-i386.h | 64 ++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/tools/include/nolibc/arch-i386.h b/tools/include/nolibc/arch-i386.h
index 82bf797849ae..10de54d4b4d6 100644
--- a/tools/include/nolibc/arch-i386.h
+++ b/tools/include/nolibc/arch-i386.h
@@ -167,6 +167,70 @@ struct sys_stat_struct {
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
+ *   1) Save the %ebp value to the redzone area -4(%esp).
+ *   2) Load the 6-th argument from memory to %ebp.
+ *   3) Subtract the %esp by 4.
+ *   4) Do the syscall (int $0x80).
+ *   5) Pop %ebp.
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
+		"movl	%%ebp, -4(%%esp)\n\t"
+		"movl	%[arg6], %%ebp\n\t"
+		"subl	$4, %%esp\n\t"
+		"int	$0x80\n\t"
+		"popl	%%ebp\n\t"
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
+static inline long ____do_syscall6(long eax, long ebx, long ecx, long edx,
+				   long esi, long edi, long ebp)
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

