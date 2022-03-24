Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03004E5F6F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 08:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348618AbiCXHd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348615AbiCXHch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:32:37 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27B2996AC
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 00:31:04 -0700 (PDT)
Received: from integral2.. (unknown [182.2.71.236])
        by gnuweeb.org (Postfix) with ESMTPSA id 908C77E710;
        Thu, 24 Mar 2022 07:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1648107063;
        bh=XnHIMtKCHpfViYs+NxhkaGxPrB2QEF9blnFlAgHfvkI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F92q9FjqXDVM9H1BYBGp8Wfp2b6LxgegpwJdJda/NuQWnG+3dbYM+Quy4CLRDNysC
         tdhKWMp4QFB17yfx4pwPmS1MQA8Lt/3C9DFlxOVT/ZIuN0DlyBfB3Ok9WyIy+YL5QS
         FPu9x2vXgZCzQMTMTLicEB7j0jzuw3uG4G6+4lTe8R5cUrIORtvjGTm8YNUiEUFtpk
         NlVh2lk2BbvCRfQsmg/D8oiVxcLmWU8w2utTO7GTQ9PAV25jc/VCG6KRP3UEsBS9te
         oPyt8tOksHFXOODMaI/auE8NgAfYpQ6aM4nnZsWht0WP4RF16T+wDOAHFOANiyy/rr
         2sUzIjkK4Fqkg==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        David Laight <David.Laight@ACULAB.COM>
Subject: [PATCH v1 04/11] tools/nolibc: x86-64: Use appropriate register constraints if exist
Date:   Thu, 24 Mar 2022 14:30:32 +0700
Message-Id: <20220324073039.140946-5-ammarfaizi2@gnuweeb.org>
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

Use appropriate register constraints if exist. Don't use register
variables for all inputs.

Register variables with "r" constraint should be used when we need to
pass data through a specific register to extended inline assembly that
doesn't have a specific register constraint associated with it (anything
outside %rax, %rbx, %rcx, %rdx, %rsi, %rdi).

It also simplifies the macro definition.

Link: https://lore.kernel.org/lkml/3d2cfdeecddc45dc8e4beada305b5948@AcuMS.aculab.com
Suggested-by: David Laight <David.Laight@ACULAB.COM>
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 tools/include/nolibc/arch-x86_64.h | 202 +++++++++++++----------------
 1 file changed, 91 insertions(+), 111 deletions(-)

diff --git a/tools/include/nolibc/arch-x86_64.h b/tools/include/nolibc/arch-x86_64.h
index afc50f84a036..3067f553c03c 100644
--- a/tools/include/nolibc/arch-x86_64.h
+++ b/tools/include/nolibc/arch-x86_64.h
@@ -65,129 +65,109 @@ struct sys_stat_struct {
  *
  */
 
-#define my_syscall0(num)                                                      \
-({                                                                            \
-	long _ret;                                                            \
-	register long _num  __asm__("rax") = (num);                           \
-	                                                                      \
-	__asm__ volatile (                                                    \
-		"syscall\n"                                                   \
-		: "=a"(_ret)                                                  \
-		: "0"(_num)                                                   \
-		: "rcx", "r11", "memory", "cc"                                \
-	);                                                                    \
-	_ret;                                                                 \
+#define my_syscall0(num)					\
+({								\
+	long _ret = (num);					\
+	__asm__ volatile (					\
+		"syscall\n"					\
+		: "+a"(_ret)	/* %rax */			\
+		:						\
+		: "rcx", "r11", "memory", "cc"			\
+	);							\
+	_ret;							\
 })
 
-#define my_syscall1(num, arg1)                                                \
-({                                                                            \
-	long _ret;                                                            \
-	register long _num  __asm__("rax") = (num);                           \
-	register long _arg1 __asm__("rdi") = (long)(arg1);                    \
-	                                                                      \
-	__asm__ volatile (                                                    \
-		"syscall\n"                                                   \
-		: "=a"(_ret)                                                  \
-		: "r"(_arg1),                                                 \
-		  "0"(_num)                                                   \
-		: "rcx", "r11", "memory", "cc"                                \
-	);                                                                    \
-	_ret;                                                                 \
+#define my_syscall1(num, arg1)					\
+({								\
+	long _ret = (num);					\
+	__asm__ volatile (					\
+		"syscall\n"					\
+		: "+a"(_ret)	/* %rax */			\
+		: "D"(arg1)	/* %rdi */			\
+		: "rcx", "r11", "memory", "cc"			\
+	);							\
+	_ret;							\
 })
 
-#define my_syscall2(num, arg1, arg2)                                          \
-({                                                                            \
-	long _ret;                                                            \
-	register long _num  __asm__("rax") = (num);                           \
-	register long _arg1 __asm__("rdi") = (long)(arg1);                    \
-	register long _arg2 __asm__("rsi") = (long)(arg2);                    \
-	                                                                      \
-	__asm__ volatile (                                                    \
-		"syscall\n"                                                   \
-		: "=a"(_ret)                                                  \
-		: "r"(_arg1), "r"(_arg2),                                     \
-		  "0"(_num)                                                   \
-		: "rcx", "r11", "memory", "cc"                                \
-	);                                                                    \
-	_ret;                                                                 \
+#define my_syscall2(num, arg1, arg2)				\
+({								\
+	long _ret = (num);					\
+	__asm__ volatile (					\
+		"syscall\n"					\
+		: "+a"(_ret)	/* %rax */			\
+		: "D"(arg1),	/* %rdi */			\
+		  "S"(arg2)	/* %rsi */			\
+		: "rcx", "r11", "memory", "cc"			\
+	);							\
+	_ret;							\
 })
 
-#define my_syscall3(num, arg1, arg2, arg3)                                    \
-({                                                                            \
-	long _ret;                                                            \
-	register long _num  __asm__("rax") = (num);                           \
-	register long _arg1 __asm__("rdi") = (long)(arg1);                    \
-	register long _arg2 __asm__("rsi") = (long)(arg2);                    \
-	register long _arg3 __asm__("rdx") = (long)(arg3);                    \
-	                                                                      \
-	__asm__ volatile (                                                    \
-		"syscall\n"                                                   \
-		: "=a"(_ret)                                                  \
-		: "r"(_arg1), "r"(_arg2), "r"(_arg3),                         \
-		  "0"(_num)                                                   \
-		: "rcx", "r11", "memory", "cc"                                \
-	);                                                                    \
-	_ret;                                                                 \
+#define my_syscall3(num, arg1, arg2, arg3)			\
+({								\
+	long _ret = (num);					\
+	__asm__ volatile (					\
+		"syscall\n"					\
+		: "+a"(_ret)	/* %rax */			\
+		: "D"(arg1),	/* %rdi */			\
+		  "S"(arg2),	/* %rsi */			\
+		  "d"(arg3)	/* %rdx */			\
+		: "rcx", "r11", "memory", "cc"			\
+	);							\
+	_ret;							\
 })
 
-#define my_syscall4(num, arg1, arg2, arg3, arg4)                              \
-({                                                                            \
-	long _ret;                                                            \
-	register long _num  __asm__("rax") = (num);                           \
-	register long _arg1 __asm__("rdi") = (long)(arg1);                    \
-	register long _arg2 __asm__("rsi") = (long)(arg2);                    \
-	register long _arg3 __asm__("rdx") = (long)(arg3);                    \
-	register long _arg4 __asm__("r10") = (long)(arg4);                    \
-	                                                                      \
-	__asm__ volatile (                                                    \
-		"syscall\n"                                                   \
-		: "=a"(_ret)                                                  \
-		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4),             \
-		  "0"(_num)                                                   \
-		: "rcx", "r11", "memory", "cc"                                \
-	);                                                                    \
-	_ret;                                                                 \
+#define my_syscall4(num, arg1, arg2, arg3, arg4)		\
+({								\
+	long _ret = (num);					\
+	register long _arg4 __asm__("r10") = (long)(arg4);	\
+	__asm__ volatile (					\
+		"syscall\n"					\
+		: "+a"(_ret)	/* %rax */			\
+		: "D"(arg1),	/* %rdi */			\
+		  "S"(arg2),	/* %rsi */			\
+		  "d"(arg3),	/* %rdx */			\
+		  "r"(_arg4)	/* %r10 */			\
+		: "rcx", "r11", "memory", "cc"			\
+	);							\
+	_ret;							\
 })
 
-#define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)                        \
-({                                                                            \
-	long _ret;                                                            \
-	register long _num  __asm__("rax") = (num);                           \
-	register long _arg1 __asm__("rdi") = (long)(arg1);                    \
-	register long _arg2 __asm__("rsi") = (long)(arg2);                    \
-	register long _arg3 __asm__("rdx") = (long)(arg3);                    \
-	register long _arg4 __asm__("r10") = (long)(arg4);                    \
-	register long _arg5 __asm__("r8")  = (long)(arg5);                    \
-	                                                                      \
-	__asm__ volatile (                                                    \
-		"syscall\n"                                                   \
-		: "=a"(_ret)                                                  \
-		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), \
-		  "0"(_num)                                                   \
-		: "rcx", "r11", "memory", "cc"                                \
-	);                                                                    \
-	_ret;                                                                 \
+#define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)		\
+({								\
+	long _ret = (num);					\
+	register long _arg4 __asm__("r10") = (long)(arg4);	\
+	register long _arg5 __asm__("r8")  = (long)(arg5);	\
+	__asm__ volatile (					\
+		"syscall\n"					\
+		: "+a"(_ret)	/* %rax */			\
+		: "D"(arg1),	/* %rdi */			\
+		  "S"(arg2),	/* %rsi */			\
+		  "d"(arg3),	/* %rdx */			\
+		  "r"(_arg4),	/* %r10 */			\
+		  "r"(_arg5)	/* %r8  */			\
+		: "rcx", "r11", "memory", "cc"			\
+	);							\
+	_ret;							\
 })
 
-#define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)                  \
-({                                                                            \
-	long _ret;                                                            \
-	register long _num  __asm__("rax") = (num);                           \
-	register long _arg1 __asm__("rdi") = (long)(arg1);                    \
-	register long _arg2 __asm__("rsi") = (long)(arg2);                    \
-	register long _arg3 __asm__("rdx") = (long)(arg3);                    \
-	register long _arg4 __asm__("r10") = (long)(arg4);                    \
-	register long _arg5 __asm__("r8")  = (long)(arg5);                    \
-	register long _arg6 __asm__("r9")  = (long)(arg6);                    \
-	                                                                      \
-	__asm__ volatile (                                                    \
-		"syscall\n"                                                   \
-		: "=a"(_ret)                                                  \
-		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), \
-		  "r"(_arg6), "0"(_num)                                       \
-		: "rcx", "r11", "memory", "cc"                                \
-	);                                                                    \
-	_ret;                                                                 \
+#define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)	\
+({								\
+	long _ret = (num);					\
+	register long _arg4 __asm__("r10") = (long)(arg4);	\
+	register long _arg5 __asm__("r8")  = (long)(arg5);	\
+	register long _arg6 __asm__("r9")  = (long)(arg6);	\
+	__asm__ volatile (					\
+		"syscall\n"					\
+		: "+a"(_ret)	/* %rax */			\
+		: "D"(arg1),	/* %rdi */			\
+		  "S"(arg2),	/* %rsi */			\
+		  "d"(arg3),	/* %rdx */			\
+		  "r"(_arg4),	/* %r10 */			\
+		  "r"(_arg5),	/* %r8  */			\
+		  "r"(_arg6)	/* %r9  */			\
+		: "rcx", "r11", "memory", "cc"			\
+	);							\
+	_ret;							\
 })
 
 /* startup code */
-- 
Ammar Faizi

