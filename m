Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F9B4EAB1B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 12:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235051AbiC2KTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 06:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235035AbiC2KTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 06:19:37 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB38423EC63
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 03:17:53 -0700 (PDT)
Received: from integral2.. (unknown [182.2.70.161])
        by gnuweeb.org (Postfix) with ESMTPSA id B15C47E731;
        Tue, 29 Mar 2022 10:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1648549073;
        bh=IuxvxrijhzGvKD3N89ycTSu7sq6wYVroW0s6c2LHqVg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VyqTe1AuDKVPbt78dld8WdGOyjUkCC+n3hzW2myNYWxMuZH9lTIFZXSWd3GTr4PMo
         IuWc6lX8o+vkWO25sGxauEXQveKYeVjVVwv6FVLKJN28n7rz+mzQ11Nw2z1IbnxHi+
         YP2lS5PJLFcWpDPMlpp8Y0VH4xAzaOHsTENSCOIEYCGsDBsHDFGKtL89LMWp5fZ9Fp
         2P+Sim6y4X2l9UxSZR9HKby/ftd9A2PWmdrOMAWISY/o4V8uY2sn0p0QicHeIqCVPe
         PI49zhfzfHrr1ngIPBqsN3CYwtCQv8z5MQpAYzMnxuvkvNhdUvTfpxBzD75Q7z7ppk
         4vQQcMJMwYAsQ==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
Subject: [PATCH v2 2/9] tools/nolibc: Replace `asm` with `__asm__`
Date:   Tue, 29 Mar 2022 17:17:30 +0700
Message-Id: <20220329101737.58985-3-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220329101737.58985-1-ammarfaizi2@gnuweeb.org>
References: <20220329101737.58985-1-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace `asm` with `__asm__` to support compilation with -std flag.
Using `asm` with -std flag makes GCC think `asm()` is a function call
instead of an inline assembly.

GCC doc says:

  For the C language, the `asm` keyword is a GNU extension. When
  writing C code that can be compiled with `-ansi` and the `-std`
  options that select C dialects without GNU extensions, use
  `__asm__` instead of `asm`.

Link: https://gcc.gnu.org/onlinedocs/gcc/Basic-Asm.html
Reported-by: Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
===

In a private conversation with Alviro, we found that using -std flag hits
the following errors:
```
    In file included from arch.h:21,
                   from nolibc.h:97,
                   from test.c:2:
  arch-i386.h:177:5: error: expected declaration specifiers or ‘...’ before string constant
    177 | asm(".section .text\n"
        |     ^~~~~~~~~~~~~~~~~~
  sys.h: In function ‘sys_brk’:
  arch-i386.h:83:28: error: expected ‘=’, ‘,’, ‘;’, ‘asm’ or ‘__attribute__’ before ‘asm’
     83 |         register long _num asm("eax") = (num);                                \
        |                            ^~~
  sys.h:57:24: note: in expansion of macro ‘my_syscall1’
     57 |         return (void *)my_syscall1(__NR_brk, addr);
        |                        ^~~~~~~~~~~
  arch-i386.h:83:28: warning: implicit declaration of function ‘asm’ [-Wimplicit-function-declaration]
     83 |         register long _num asm("eax") = (num);                                \
        |                            ^~~
  sys.h:57:24: note: in expansion of macro ‘my_syscall1’
     57 |         return (void *)my_syscall1(__NR_brk, addr);
        |                        ^~~~~~~~~~~
  arch-i386.h:83:39: error: lvalue required as left operand of assignment
     83 |         register long _num asm("eax") = (num);                                \
        |                                       ^
  sys.h:57:24: note: in expansion of macro ‘my_syscall1’
     57 |         return (void *)my_syscall1(__NR_brk, addr);
        |                        ^~~~~~~~~~~
  arch-i386.h:84:29: error: expected ‘=’, ‘,’, ‘;’, ‘asm’ or ‘__attribute__’ before ‘asm’
     84 |         register long _arg1 asm("ebx") = (long)(arg1);                        \
```

It is because inline ASM is a GNU extension. So GCC thinks asm() is a
function call. To make it always available for any kind of compilation,
use `__asm__` instead of `asm`.

@@ Changelog:

   Link v1: https://lore.gnuweeb.org/gwml/20220324073039.140946-2-ammarfaizi2@gnuweeb.org
   v1 -> v2:
     - Switch the order with the patch that fixes clang build.
---
 tools/include/nolibc/arch-aarch64.h | 74 ++++++++++++++---------------
 tools/include/nolibc/arch-arm.h     | 58 +++++++++++-----------
 tools/include/nolibc/arch-i386.h    | 56 +++++++++++-----------
 tools/include/nolibc/arch-mips.h    | 62 ++++++++++++------------
 tools/include/nolibc/arch-riscv.h   | 74 ++++++++++++++---------------
 tools/include/nolibc/arch-x86_64.h  | 72 ++++++++++++++--------------
 6 files changed, 198 insertions(+), 198 deletions(-)

diff --git a/tools/include/nolibc/arch-aarch64.h b/tools/include/nolibc/arch-aarch64.h
index 87d9e434820c..b68443f63980 100644
--- a/tools/include/nolibc/arch-aarch64.h
+++ b/tools/include/nolibc/arch-aarch64.h
@@ -64,10 +64,10 @@ struct sys_stat_struct {
 
 #define my_syscall0(num)                                                      \
 ({                                                                            \
-	register long _num  asm("x8") = (num);                                \
-	register long _arg1 asm("x0");                                        \
+	register long _num  __asm__ ("x8") = (num);                           \
+	register long _arg1 __asm__ ("x0");                                   \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__  volatile (                                                   \
 		"svc #0\n"                                                    \
 		: "=r"(_arg1)                                                 \
 		: "r"(_num)                                                   \
@@ -78,10 +78,10 @@ struct sys_stat_struct {
 
 #define my_syscall1(num, arg1)                                                \
 ({                                                                            \
-	register long _num  asm("x8") = (num);                                \
-	register long _arg1 asm("x0") = (long)(arg1);                         \
+	register long _num  __asm__ ("x8") = (num);                           \
+	register long _arg1 __asm__ ("x0") = (long)(arg1);                    \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__  volatile (                                                   \
 		"svc #0\n"                                                    \
 		: "=r"(_arg1)                                                 \
 		: "r"(_arg1),                                                 \
@@ -93,11 +93,11 @@ struct sys_stat_struct {
 
 #define my_syscall2(num, arg1, arg2)                                          \
 ({                                                                            \
-	register long _num  asm("x8") = (num);                                \
-	register long _arg1 asm("x0") = (long)(arg1);                         \
-	register long _arg2 asm("x1") = (long)(arg2);                         \
+	register long _num  __asm__ ("x8") = (num);                           \
+	register long _arg1 __asm__ ("x0") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("x1") = (long)(arg2);                    \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__  volatile (                                                   \
 		"svc #0\n"                                                    \
 		: "=r"(_arg1)                                                 \
 		: "r"(_arg1), "r"(_arg2),                                     \
@@ -109,12 +109,12 @@ struct sys_stat_struct {
 
 #define my_syscall3(num, arg1, arg2, arg3)                                    \
 ({                                                                            \
-	register long _num  asm("x8") = (num);                                \
-	register long _arg1 asm("x0") = (long)(arg1);                         \
-	register long _arg2 asm("x1") = (long)(arg2);                         \
-	register long _arg3 asm("x2") = (long)(arg3);                         \
+	register long _num  __asm__ ("x8") = (num);                           \
+	register long _arg1 __asm__ ("x0") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("x1") = (long)(arg2);                    \
+	register long _arg3 __asm__ ("x2") = (long)(arg3);                    \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__  volatile (                                                   \
 		"svc #0\n"                                                    \
 		: "=r"(_arg1)                                                 \
 		: "r"(_arg1), "r"(_arg2), "r"(_arg3),                         \
@@ -126,13 +126,13 @@ struct sys_stat_struct {
 
 #define my_syscall4(num, arg1, arg2, arg3, arg4)                              \
 ({                                                                            \
-	register long _num  asm("x8") = (num);                                \
-	register long _arg1 asm("x0") = (long)(arg1);                         \
-	register long _arg2 asm("x1") = (long)(arg2);                         \
-	register long _arg3 asm("x2") = (long)(arg3);                         \
-	register long _arg4 asm("x3") = (long)(arg4);                         \
+	register long _num  __asm__ ("x8") = (num);                           \
+	register long _arg1 __asm__ ("x0") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("x1") = (long)(arg2);                    \
+	register long _arg3 __asm__ ("x2") = (long)(arg3);                    \
+	register long _arg4 __asm__ ("x3") = (long)(arg4);                    \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__  volatile (                                                   \
 		"svc #0\n"                                                    \
 		: "=r"(_arg1)                                                 \
 		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4),             \
@@ -144,14 +144,14 @@ struct sys_stat_struct {
 
 #define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)                        \
 ({                                                                            \
-	register long _num  asm("x8") = (num);                                \
-	register long _arg1 asm("x0") = (long)(arg1);                         \
-	register long _arg2 asm("x1") = (long)(arg2);                         \
-	register long _arg3 asm("x2") = (long)(arg3);                         \
-	register long _arg4 asm("x3") = (long)(arg4);                         \
-	register long _arg5 asm("x4") = (long)(arg5);                         \
+	register long _num  __asm__ ("x8") = (num);                           \
+	register long _arg1 __asm__ ("x0") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("x1") = (long)(arg2);                    \
+	register long _arg3 __asm__ ("x2") = (long)(arg3);                    \
+	register long _arg4 __asm__ ("x3") = (long)(arg4);                    \
+	register long _arg5 __asm__ ("x4") = (long)(arg5);                    \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__  volatile (                                                   \
 		"svc #0\n"                                                    \
 		: "=r" (_arg1)                                                \
 		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), \
@@ -163,15 +163,15 @@ struct sys_stat_struct {
 
 #define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)                  \
 ({                                                                            \
-	register long _num  asm("x8") = (num);                                \
-	register long _arg1 asm("x0") = (long)(arg1);                         \
-	register long _arg2 asm("x1") = (long)(arg2);                         \
-	register long _arg3 asm("x2") = (long)(arg3);                         \
-	register long _arg4 asm("x3") = (long)(arg4);                         \
-	register long _arg5 asm("x4") = (long)(arg5);                         \
-	register long _arg6 asm("x5") = (long)(arg6);                         \
+	register long _num  __asm__ ("x8") = (num);                           \
+	register long _arg1 __asm__ ("x0") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("x1") = (long)(arg2);                    \
+	register long _arg3 __asm__ ("x2") = (long)(arg3);                    \
+	register long _arg4 __asm__ ("x3") = (long)(arg4);                    \
+	register long _arg5 __asm__ ("x4") = (long)(arg5);                    \
+	register long _arg6 __asm__ ("x5") = (long)(arg6);                    \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__  volatile (                                                   \
 		"svc #0\n"                                                    \
 		: "=r" (_arg1)                                                \
 		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), \
@@ -182,7 +182,7 @@ struct sys_stat_struct {
 })
 
 /* startup code */
-asm(".section .text\n"
+__asm__ (".section .text\n"
     ".weak _start\n"
     ".global _start\n"
     "_start:\n"
diff --git a/tools/include/nolibc/arch-arm.h b/tools/include/nolibc/arch-arm.h
index 001a3c8c9ad5..55fd9439b2e2 100644
--- a/tools/include/nolibc/arch-arm.h
+++ b/tools/include/nolibc/arch-arm.h
@@ -77,10 +77,10 @@ struct sys_stat_struct {
 
 #define my_syscall0(num)                                                      \
 ({                                                                            \
-	register long _num asm("r7") = (num);                                 \
-	register long _arg1 asm("r0");                                        \
+	register long _num __asm__ ("r7") = (num);                            \
+	register long _arg1 __asm__ ("r0");                                   \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__  volatile (                                                   \
 		"svc #0\n"                                                    \
 		: "=r"(_arg1)                                                 \
 		: "r"(_num)                                                   \
@@ -91,10 +91,10 @@ struct sys_stat_struct {
 
 #define my_syscall1(num, arg1)                                                \
 ({                                                                            \
-	register long _num asm("r7") = (num);                                 \
-	register long _arg1 asm("r0") = (long)(arg1);                         \
+	register long _num __asm__ ("r7") = (num);                            \
+	register long _arg1 __asm__ ("r0") = (long)(arg1);                    \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__  volatile (                                                   \
 		"svc #0\n"                                                    \
 		: "=r"(_arg1)                                                 \
 		: "r"(_arg1),                                                 \
@@ -106,11 +106,11 @@ struct sys_stat_struct {
 
 #define my_syscall2(num, arg1, arg2)                                          \
 ({                                                                            \
-	register long _num asm("r7") = (num);                                 \
-	register long _arg1 asm("r0") = (long)(arg1);                         \
-	register long _arg2 asm("r1") = (long)(arg2);                         \
+	register long _num __asm__ ("r7") = (num);                            \
+	register long _arg1 __asm__ ("r0") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("r1") = (long)(arg2);                    \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__  volatile (                                                   \
 		"svc #0\n"                                                    \
 		: "=r"(_arg1)                                                 \
 		: "r"(_arg1), "r"(_arg2),                                     \
@@ -122,12 +122,12 @@ struct sys_stat_struct {
 
 #define my_syscall3(num, arg1, arg2, arg3)                                    \
 ({                                                                            \
-	register long _num asm("r7") = (num);                                 \
-	register long _arg1 asm("r0") = (long)(arg1);                         \
-	register long _arg2 asm("r1") = (long)(arg2);                         \
-	register long _arg3 asm("r2") = (long)(arg3);                         \
+	register long _num __asm__ ("r7") = (num);                            \
+	register long _arg1 __asm__ ("r0") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("r1") = (long)(arg2);                    \
+	register long _arg3 __asm__ ("r2") = (long)(arg3);                    \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__  volatile (                                                   \
 		"svc #0\n"                                                    \
 		: "=r"(_arg1)                                                 \
 		: "r"(_arg1), "r"(_arg2), "r"(_arg3),                         \
@@ -139,13 +139,13 @@ struct sys_stat_struct {
 
 #define my_syscall4(num, arg1, arg2, arg3, arg4)                              \
 ({                                                                            \
-	register long _num asm("r7") = (num);                                 \
-	register long _arg1 asm("r0") = (long)(arg1);                         \
-	register long _arg2 asm("r1") = (long)(arg2);                         \
-	register long _arg3 asm("r2") = (long)(arg3);                         \
-	register long _arg4 asm("r3") = (long)(arg4);                         \
+	register long _num __asm__ ("r7") = (num);                            \
+	register long _arg1 __asm__ ("r0") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("r1") = (long)(arg2);                    \
+	register long _arg3 __asm__ ("r2") = (long)(arg3);                    \
+	register long _arg4 __asm__ ("r3") = (long)(arg4);                    \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__  volatile (                                                   \
 		"svc #0\n"                                                    \
 		: "=r"(_arg1)                                                 \
 		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4),             \
@@ -157,14 +157,14 @@ struct sys_stat_struct {
 
 #define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)                        \
 ({                                                                            \
-	register long _num asm("r7") = (num);                                 \
-	register long _arg1 asm("r0") = (long)(arg1);                         \
-	register long _arg2 asm("r1") = (long)(arg2);                         \
-	register long _arg3 asm("r2") = (long)(arg3);                         \
-	register long _arg4 asm("r3") = (long)(arg4);                         \
-	register long _arg5 asm("r4") = (long)(arg5);                         \
+	register long _num __asm__ ("r7") = (num);                            \
+	register long _arg1 __asm__ ("r0") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("r1") = (long)(arg2);                    \
+	register long _arg3 __asm__ ("r2") = (long)(arg3);                    \
+	register long _arg4 __asm__ ("r3") = (long)(arg4);                    \
+	register long _arg5 __asm__ ("r4") = (long)(arg5);                    \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__  volatile (                                                   \
 		"svc #0\n"                                                    \
 		: "=r" (_arg1)                                                \
 		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), \
@@ -175,7 +175,7 @@ struct sys_stat_struct {
 })
 
 /* startup code */
-asm(".section .text\n"
+__asm__ (".section .text\n"
     ".weak _start\n"
     ".global _start\n"
     "_start:\n"
diff --git a/tools/include/nolibc/arch-i386.h b/tools/include/nolibc/arch-i386.h
index d7e4d53325a3..136d5739e456 100644
--- a/tools/include/nolibc/arch-i386.h
+++ b/tools/include/nolibc/arch-i386.h
@@ -66,9 +66,9 @@ struct sys_stat_struct {
 #define my_syscall0(num)                                                      \
 ({                                                                            \
 	long _ret;                                                            \
-	register long _num asm("eax") = (num);                                \
+	register long _num __asm__ ("eax") = (num);                           \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__  volatile (                                                   \
 		"int $0x80\n"                                                 \
 		: "=a" (_ret)                                                 \
 		: "0"(_num)                                                   \
@@ -80,10 +80,10 @@ struct sys_stat_struct {
 #define my_syscall1(num, arg1)                                                \
 ({                                                                            \
 	long _ret;                                                            \
-	register long _num asm("eax") = (num);                                \
-	register long _arg1 asm("ebx") = (long)(arg1);                        \
+	register long _num __asm__ ("eax") = (num);                           \
+	register long _arg1 __asm__ ("ebx") = (long)(arg1);                   \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__  volatile (                                                   \
 		"int $0x80\n"                                                 \
 		: "=a" (_ret)                                                 \
 		: "r"(_arg1),                                                 \
@@ -96,11 +96,11 @@ struct sys_stat_struct {
 #define my_syscall2(num, arg1, arg2)                                          \
 ({                                                                            \
 	long _ret;                                                            \
-	register long _num asm("eax") = (num);                                \
-	register long _arg1 asm("ebx") = (long)(arg1);                        \
-	register long _arg2 asm("ecx") = (long)(arg2);                        \
+	register long _num __asm__ ("eax") = (num);                           \
+	register long _arg1 __asm__ ("ebx") = (long)(arg1);                   \
+	register long _arg2 __asm__ ("ecx") = (long)(arg2);                   \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__  volatile (                                                   \
 		"int $0x80\n"                                                 \
 		: "=a" (_ret)                                                 \
 		: "r"(_arg1), "r"(_arg2),                                     \
@@ -113,12 +113,12 @@ struct sys_stat_struct {
 #define my_syscall3(num, arg1, arg2, arg3)                                    \
 ({                                                                            \
 	long _ret;                                                            \
-	register long _num asm("eax") = (num);                                \
-	register long _arg1 asm("ebx") = (long)(arg1);                        \
-	register long _arg2 asm("ecx") = (long)(arg2);                        \
-	register long _arg3 asm("edx") = (long)(arg3);                        \
+	register long _num __asm__ ("eax") = (num);                           \
+	register long _arg1 __asm__ ("ebx") = (long)(arg1);                   \
+	register long _arg2 __asm__ ("ecx") = (long)(arg2);                   \
+	register long _arg3 __asm__ ("edx") = (long)(arg3);                   \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__  volatile (                                                   \
 		"int $0x80\n"                                                 \
 		: "=a" (_ret)                                                 \
 		: "r"(_arg1), "r"(_arg2), "r"(_arg3),                         \
@@ -131,13 +131,13 @@ struct sys_stat_struct {
 #define my_syscall4(num, arg1, arg2, arg3, arg4)                              \
 ({                                                                            \
 	long _ret;                                                            \
-	register long _num asm("eax") = (num);                                \
-	register long _arg1 asm("ebx") = (long)(arg1);                        \
-	register long _arg2 asm("ecx") = (long)(arg2);                        \
-	register long _arg3 asm("edx") = (long)(arg3);                        \
-	register long _arg4 asm("esi") = (long)(arg4);                        \
+	register long _num __asm__ ("eax") = (num);                           \
+	register long _arg1 __asm__ ("ebx") = (long)(arg1);                   \
+	register long _arg2 __asm__ ("ecx") = (long)(arg2);                   \
+	register long _arg3 __asm__ ("edx") = (long)(arg3);                   \
+	register long _arg4 __asm__ ("esi") = (long)(arg4);                   \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__  volatile (                                                   \
 		"int $0x80\n"                                                 \
 		: "=a" (_ret)                                                 \
 		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4),             \
@@ -150,14 +150,14 @@ struct sys_stat_struct {
 #define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)                        \
 ({                                                                            \
 	long _ret;                                                            \
-	register long _num asm("eax") = (num);                                \
-	register long _arg1 asm("ebx") = (long)(arg1);                        \
-	register long _arg2 asm("ecx") = (long)(arg2);                        \
-	register long _arg3 asm("edx") = (long)(arg3);                        \
-	register long _arg4 asm("esi") = (long)(arg4);                        \
-	register long _arg5 asm("edi") = (long)(arg5);                        \
+	register long _num __asm__ ("eax") = (num);                           \
+	register long _arg1 __asm__ ("ebx") = (long)(arg1);                   \
+	register long _arg2 __asm__ ("ecx") = (long)(arg2);                   \
+	register long _arg3 __asm__ ("edx") = (long)(arg3);                   \
+	register long _arg4 __asm__ ("esi") = (long)(arg4);                   \
+	register long _arg5 __asm__ ("edi") = (long)(arg5);                   \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__  volatile (                                                   \
 		"int $0x80\n"                                                 \
 		: "=a" (_ret)                                                 \
 		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), \
@@ -174,7 +174,7 @@ struct sys_stat_struct {
  * 2) The deepest stack frame should be set to zero
  *
  */
-asm(".section .text\n"
+__asm__ (".section .text\n"
     ".weak _start\n"
     ".global _start\n"
     "_start:\n"
diff --git a/tools/include/nolibc/arch-mips.h b/tools/include/nolibc/arch-mips.h
index c9a6aac87c6d..cd587e539d7d 100644
--- a/tools/include/nolibc/arch-mips.h
+++ b/tools/include/nolibc/arch-mips.h
@@ -69,10 +69,10 @@ struct sys_stat_struct {
 
 #define my_syscall0(num)                                                      \
 ({                                                                            \
-	register long _num asm("v0") = (num);                                 \
-	register long _arg4 asm("a3");                                        \
+	register long _num __asm__ ("v0") = (num);                            \
+	register long _arg4 __asm__ ("a3");                                   \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__  volatile (                                                   \
 		"addiu $sp, $sp, -32\n"                                       \
 		"syscall\n"                                                   \
 		"addiu $sp, $sp, 32\n"                                        \
@@ -86,11 +86,11 @@ struct sys_stat_struct {
 
 #define my_syscall1(num, arg1)                                                \
 ({                                                                            \
-	register long _num asm("v0") = (num);                                 \
-	register long _arg1 asm("a0") = (long)(arg1);                         \
-	register long _arg4 asm("a3");                                        \
+	register long _num __asm__ ("v0") = (num);                            \
+	register long _arg1 __asm__ ("a0") = (long)(arg1);                    \
+	register long _arg4 __asm__ ("a3");                                   \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__  volatile (                                                   \
 		"addiu $sp, $sp, -32\n"                                       \
 		"syscall\n"                                                   \
 		"addiu $sp, $sp, 32\n"                                        \
@@ -105,12 +105,12 @@ struct sys_stat_struct {
 
 #define my_syscall2(num, arg1, arg2)                                          \
 ({                                                                            \
-	register long _num asm("v0") = (num);                                 \
-	register long _arg1 asm("a0") = (long)(arg1);                         \
-	register long _arg2 asm("a1") = (long)(arg2);                         \
-	register long _arg4 asm("a3");                                        \
+	register long _num __asm__ ("v0") = (num);                            \
+	register long _arg1 __asm__ ("a0") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("a1") = (long)(arg2);                    \
+	register long _arg4 __asm__ ("a3");                                   \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__  volatile (                                                   \
 		"addiu $sp, $sp, -32\n"                                       \
 		"syscall\n"                                                   \
 		"addiu $sp, $sp, 32\n"                                        \
@@ -125,13 +125,13 @@ struct sys_stat_struct {
 
 #define my_syscall3(num, arg1, arg2, arg3)                                    \
 ({                                                                            \
-	register long _num asm("v0")  = (num);                                \
-	register long _arg1 asm("a0") = (long)(arg1);                         \
-	register long _arg2 asm("a1") = (long)(arg2);                         \
-	register long _arg3 asm("a2") = (long)(arg3);                         \
-	register long _arg4 asm("a3");                                        \
+	register long _num __asm__ ("v0")  = (num);                           \
+	register long _arg1 __asm__ ("a0") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("a1") = (long)(arg2);                    \
+	register long _arg3 __asm__ ("a2") = (long)(arg3);                    \
+	register long _arg4 __asm__ ("a3");                                   \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__  volatile (                                                   \
 		"addiu $sp, $sp, -32\n"                                       \
 		"syscall\n"                                                   \
 		"addiu $sp, $sp, 32\n"                                        \
@@ -146,13 +146,13 @@ struct sys_stat_struct {
 
 #define my_syscall4(num, arg1, arg2, arg3, arg4)                              \
 ({                                                                            \
-	register long _num asm("v0") = (num);                                 \
-	register long _arg1 asm("a0") = (long)(arg1);                         \
-	register long _arg2 asm("a1") = (long)(arg2);                         \
-	register long _arg3 asm("a2") = (long)(arg3);                         \
-	register long _arg4 asm("a3") = (long)(arg4);                         \
+	register long _num __asm__ ("v0") = (num);                            \
+	register long _arg1 __asm__ ("a0") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("a1") = (long)(arg2);                    \
+	register long _arg3 __asm__ ("a2") = (long)(arg3);                    \
+	register long _arg4 __asm__ ("a3") = (long)(arg4);                    \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__  volatile (                                                   \
 		"addiu $sp, $sp, -32\n"                                       \
 		"syscall\n"                                                   \
 		"addiu $sp, $sp, 32\n"                                        \
@@ -167,14 +167,14 @@ struct sys_stat_struct {
 
 #define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)                        \
 ({                                                                            \
-	register long _num asm("v0") = (num);                                 \
-	register long _arg1 asm("a0") = (long)(arg1);                         \
-	register long _arg2 asm("a1") = (long)(arg2);                         \
-	register long _arg3 asm("a2") = (long)(arg3);                         \
-	register long _arg4 asm("a3") = (long)(arg4);                         \
+	register long _num __asm__ ("v0") = (num);                            \
+	register long _arg1 __asm__ ("a0") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("a1") = (long)(arg2);                    \
+	register long _arg3 __asm__ ("a2") = (long)(arg3);                    \
+	register long _arg4 __asm__ ("a3") = (long)(arg4);                    \
 	register long _arg5 = (long)(arg5);                                   \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__  volatile (                                                   \
 		"addiu $sp, $sp, -32\n"                                       \
 		"sw %7, 16($sp)\n"                                            \
 		"syscall\n  "                                                 \
@@ -189,7 +189,7 @@ struct sys_stat_struct {
 })
 
 /* startup code, note that it's called __start on MIPS */
-asm(".section .text\n"
+__asm__ (".section .text\n"
     ".weak __start\n"
     ".set nomips16\n"
     ".global __start\n"
diff --git a/tools/include/nolibc/arch-riscv.h b/tools/include/nolibc/arch-riscv.h
index bc10b7b5706d..8ec4c05fa69b 100644
--- a/tools/include/nolibc/arch-riscv.h
+++ b/tools/include/nolibc/arch-riscv.h
@@ -66,10 +66,10 @@ struct sys_stat_struct {
 
 #define my_syscall0(num)                                                      \
 ({                                                                            \
-	register long _num  asm("a7") = (num);                                \
-	register long _arg1 asm("a0");                                        \
+	register long _num  __asm__ ("a7") = (num);                           \
+	register long _arg1 __asm__ ("a0");                                   \
 									      \
-	asm volatile (                                                        \
+	__asm__  volatile (                                                   \
 		"ecall\n\t"                                                   \
 		: "=r"(_arg1)                                                 \
 		: "r"(_num)                                                   \
@@ -80,10 +80,10 @@ struct sys_stat_struct {
 
 #define my_syscall1(num, arg1)                                                \
 ({                                                                            \
-	register long _num  asm("a7") = (num);                                \
-	register long _arg1 asm("a0") = (long)(arg1);		              \
+	register long _num  __asm__ ("a7") = (num);                           \
+	register long _arg1 __asm__ ("a0") = (long)(arg1);		      \
 									      \
-	asm volatile (                                                        \
+	__asm__  volatile (                                                   \
 		"ecall\n"                                                     \
 		: "+r"(_arg1)                                                 \
 		: "r"(_num)                                                   \
@@ -94,11 +94,11 @@ struct sys_stat_struct {
 
 #define my_syscall2(num, arg1, arg2)                                          \
 ({                                                                            \
-	register long _num  asm("a7") = (num);                                \
-	register long _arg1 asm("a0") = (long)(arg1);                         \
-	register long _arg2 asm("a1") = (long)(arg2);                         \
+	register long _num  __asm__ ("a7") = (num);                           \
+	register long _arg1 __asm__ ("a0") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("a1") = (long)(arg2);                    \
 									      \
-	asm volatile (                                                        \
+	__asm__  volatile (                                                   \
 		"ecall\n"                                                     \
 		: "+r"(_arg1)                                                 \
 		: "r"(_arg2),                                                 \
@@ -110,12 +110,12 @@ struct sys_stat_struct {
 
 #define my_syscall3(num, arg1, arg2, arg3)                                    \
 ({                                                                            \
-	register long _num  asm("a7") = (num);                                \
-	register long _arg1 asm("a0") = (long)(arg1);                         \
-	register long _arg2 asm("a1") = (long)(arg2);                         \
-	register long _arg3 asm("a2") = (long)(arg3);                         \
+	register long _num  __asm__ ("a7") = (num);                           \
+	register long _arg1 __asm__ ("a0") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("a1") = (long)(arg2);                    \
+	register long _arg3 __asm__ ("a2") = (long)(arg3);                    \
 									      \
-	asm volatile (                                                        \
+	__asm__  volatile (                                                   \
 		"ecall\n\t"                                                   \
 		: "+r"(_arg1)                                                 \
 		: "r"(_arg2), "r"(_arg3),                                     \
@@ -127,13 +127,13 @@ struct sys_stat_struct {
 
 #define my_syscall4(num, arg1, arg2, arg3, arg4)                              \
 ({                                                                            \
-	register long _num  asm("a7") = (num);                                \
-	register long _arg1 asm("a0") = (long)(arg1);                         \
-	register long _arg2 asm("a1") = (long)(arg2);                         \
-	register long _arg3 asm("a2") = (long)(arg3);                         \
-	register long _arg4 asm("a3") = (long)(arg4);                         \
+	register long _num  __asm__ ("a7") = (num);                           \
+	register long _arg1 __asm__ ("a0") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("a1") = (long)(arg2);                    \
+	register long _arg3 __asm__ ("a2") = (long)(arg3);                    \
+	register long _arg4 __asm__ ("a3") = (long)(arg4);                    \
 									      \
-	asm volatile (                                                        \
+	__asm__  volatile (                                                   \
 		"ecall\n"                                                     \
 		: "+r"(_arg1)                                                 \
 		: "r"(_arg2), "r"(_arg3), "r"(_arg4),                         \
@@ -145,14 +145,14 @@ struct sys_stat_struct {
 
 #define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)                        \
 ({                                                                            \
-	register long _num  asm("a7") = (num);                                \
-	register long _arg1 asm("a0") = (long)(arg1);                         \
-	register long _arg2 asm("a1") = (long)(arg2);                         \
-	register long _arg3 asm("a2") = (long)(arg3);                         \
-	register long _arg4 asm("a3") = (long)(arg4);                         \
-	register long _arg5 asm("a4") = (long)(arg5);                         \
+	register long _num  __asm__ ("a7") = (num);                           \
+	register long _arg1 __asm__ ("a0") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("a1") = (long)(arg2);                    \
+	register long _arg3 __asm__ ("a2") = (long)(arg3);                    \
+	register long _arg4 __asm__ ("a3") = (long)(arg4);                    \
+	register long _arg5 __asm__ ("a4") = (long)(arg5);                    \
 									      \
-	asm volatile (                                                        \
+	__asm__  volatile (                                                   \
 		"ecall\n"                                                     \
 		: "+r"(_arg1)                                                 \
 		: "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5),             \
@@ -164,15 +164,15 @@ struct sys_stat_struct {
 
 #define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)                  \
 ({                                                                            \
-	register long _num  asm("a7") = (num);                                \
-	register long _arg1 asm("a0") = (long)(arg1);                         \
-	register long _arg2 asm("a1") = (long)(arg2);                         \
-	register long _arg3 asm("a2") = (long)(arg3);                         \
-	register long _arg4 asm("a3") = (long)(arg4);                         \
-	register long _arg5 asm("a4") = (long)(arg5);                         \
-	register long _arg6 asm("a5") = (long)(arg6);                         \
+	register long _num  __asm__ ("a7") = (num);                           \
+	register long _arg1 __asm__ ("a0") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("a1") = (long)(arg2);                    \
+	register long _arg3 __asm__ ("a2") = (long)(arg3);                    \
+	register long _arg4 __asm__ ("a3") = (long)(arg4);                    \
+	register long _arg5 __asm__ ("a4") = (long)(arg5);                    \
+	register long _arg6 __asm__ ("a5") = (long)(arg6);                    \
 									      \
-	asm volatile (                                                        \
+	__asm__  volatile (                                                   \
 		"ecall\n"                                                     \
 		: "+r"(_arg1)                                                 \
 		: "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), "r"(_arg6), \
@@ -183,7 +183,7 @@ struct sys_stat_struct {
 })
 
 /* startup code */
-asm(".section .text\n"
+__asm__ (".section .text\n"
     ".weak _start\n"
     ".global _start\n"
     "_start:\n"
diff --git a/tools/include/nolibc/arch-x86_64.h b/tools/include/nolibc/arch-x86_64.h
index a7b70ea51b68..490530429ac9 100644
--- a/tools/include/nolibc/arch-x86_64.h
+++ b/tools/include/nolibc/arch-x86_64.h
@@ -68,9 +68,9 @@ struct sys_stat_struct {
 #define my_syscall0(num)                                                      \
 ({                                                                            \
 	long _ret;                                                            \
-	register long _num  asm("rax") = (num);                               \
+	register long _num  __asm__ ("rax") = (num);                          \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__  volatile (                                                   \
 		"syscall\n"                                                   \
 		: "=a"(_ret)                                                  \
 		: "0"(_num)                                                   \
@@ -82,10 +82,10 @@ struct sys_stat_struct {
 #define my_syscall1(num, arg1)                                                \
 ({                                                                            \
 	long _ret;                                                            \
-	register long _num  asm("rax") = (num);                               \
-	register long _arg1 asm("rdi") = (long)(arg1);                        \
+	register long _num  __asm__ ("rax") = (num);                          \
+	register long _arg1 __asm__ ("rdi") = (long)(arg1);                   \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__  volatile (                                                   \
 		"syscall\n"                                                   \
 		: "=a"(_ret)                                                  \
 		: "r"(_arg1),                                                 \
@@ -98,11 +98,11 @@ struct sys_stat_struct {
 #define my_syscall2(num, arg1, arg2)                                          \
 ({                                                                            \
 	long _ret;                                                            \
-	register long _num  asm("rax") = (num);                               \
-	register long _arg1 asm("rdi") = (long)(arg1);                        \
-	register long _arg2 asm("rsi") = (long)(arg2);                        \
+	register long _num  __asm__ ("rax") = (num);                          \
+	register long _arg1 __asm__ ("rdi") = (long)(arg1);                   \
+	register long _arg2 __asm__ ("rsi") = (long)(arg2);                   \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__  volatile (                                                   \
 		"syscall\n"                                                   \
 		: "=a"(_ret)                                                  \
 		: "r"(_arg1), "r"(_arg2),                                     \
@@ -115,12 +115,12 @@ struct sys_stat_struct {
 #define my_syscall3(num, arg1, arg2, arg3)                                    \
 ({                                                                            \
 	long _ret;                                                            \
-	register long _num  asm("rax") = (num);                               \
-	register long _arg1 asm("rdi") = (long)(arg1);                        \
-	register long _arg2 asm("rsi") = (long)(arg2);                        \
-	register long _arg3 asm("rdx") = (long)(arg3);                        \
+	register long _num  __asm__ ("rax") = (num);                          \
+	register long _arg1 __asm__ ("rdi") = (long)(arg1);                   \
+	register long _arg2 __asm__ ("rsi") = (long)(arg2);                   \
+	register long _arg3 __asm__ ("rdx") = (long)(arg3);                   \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__  volatile (                                                   \
 		"syscall\n"                                                   \
 		: "=a"(_ret)                                                  \
 		: "r"(_arg1), "r"(_arg2), "r"(_arg3),                         \
@@ -133,13 +133,13 @@ struct sys_stat_struct {
 #define my_syscall4(num, arg1, arg2, arg3, arg4)                              \
 ({                                                                            \
 	long _ret;                                                            \
-	register long _num  asm("rax") = (num);                               \
-	register long _arg1 asm("rdi") = (long)(arg1);                        \
-	register long _arg2 asm("rsi") = (long)(arg2);                        \
-	register long _arg3 asm("rdx") = (long)(arg3);                        \
-	register long _arg4 asm("r10") = (long)(arg4);                        \
+	register long _num  __asm__ ("rax") = (num);                          \
+	register long _arg1 __asm__ ("rdi") = (long)(arg1);                   \
+	register long _arg2 __asm__ ("rsi") = (long)(arg2);                   \
+	register long _arg3 __asm__ ("rdx") = (long)(arg3);                   \
+	register long _arg4 __asm__ ("r10") = (long)(arg4);                   \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__  volatile (                                                   \
 		"syscall\n"                                                   \
 		: "=a"(_ret)                                                  \
 		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4),             \
@@ -152,14 +152,14 @@ struct sys_stat_struct {
 #define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)                        \
 ({                                                                            \
 	long _ret;                                                            \
-	register long _num  asm("rax") = (num);                               \
-	register long _arg1 asm("rdi") = (long)(arg1);                        \
-	register long _arg2 asm("rsi") = (long)(arg2);                        \
-	register long _arg3 asm("rdx") = (long)(arg3);                        \
-	register long _arg4 asm("r10") = (long)(arg4);                        \
-	register long _arg5 asm("r8")  = (long)(arg5);                        \
+	register long _num  __asm__ ("rax") = (num);                          \
+	register long _arg1 __asm__ ("rdi") = (long)(arg1);                   \
+	register long _arg2 __asm__ ("rsi") = (long)(arg2);                   \
+	register long _arg3 __asm__ ("rdx") = (long)(arg3);                   \
+	register long _arg4 __asm__ ("r10") = (long)(arg4);                   \
+	register long _arg5 __asm__ ("r8")  = (long)(arg5);                   \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__  volatile (                                                   \
 		"syscall\n"                                                   \
 		: "=a"(_ret)                                                  \
 		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), \
@@ -172,15 +172,15 @@ struct sys_stat_struct {
 #define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)                  \
 ({                                                                            \
 	long _ret;                                                            \
-	register long _num  asm("rax") = (num);                               \
-	register long _arg1 asm("rdi") = (long)(arg1);                        \
-	register long _arg2 asm("rsi") = (long)(arg2);                        \
-	register long _arg3 asm("rdx") = (long)(arg3);                        \
-	register long _arg4 asm("r10") = (long)(arg4);                        \
-	register long _arg5 asm("r8")  = (long)(arg5);                        \
-	register long _arg6 asm("r9")  = (long)(arg6);                        \
+	register long _num  __asm__ ("rax") = (num);                          \
+	register long _arg1 __asm__ ("rdi") = (long)(arg1);                   \
+	register long _arg2 __asm__ ("rsi") = (long)(arg2);                   \
+	register long _arg3 __asm__ ("rdx") = (long)(arg3);                   \
+	register long _arg4 __asm__ ("r10") = (long)(arg4);                   \
+	register long _arg5 __asm__ ("r8")  = (long)(arg5);                   \
+	register long _arg6 __asm__ ("r9")  = (long)(arg6);                   \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__  volatile (                                                   \
 		"syscall\n"                                                   \
 		: "=a"(_ret)                                                  \
 		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), \
@@ -197,7 +197,7 @@ struct sys_stat_struct {
  * 2) The deepest stack frame should be zero (the %rbp).
  *
  */
-asm(".section .text\n"
+__asm__ (".section .text\n"
     ".weak _start\n"
     ".global _start\n"
     "_start:\n"
-- 
Ammar Faizi

