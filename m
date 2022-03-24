Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB45A4E5F6B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 08:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbiCXHci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345962AbiCXHcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:32:32 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E7F98F7E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 00:31:00 -0700 (PDT)
Received: from integral2.. (unknown [182.2.71.236])
        by gnuweeb.org (Postfix) with ESMTPSA id CF2EC7E70E;
        Thu, 24 Mar 2022 07:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1648107060;
        bh=9Y4BF60b+K5tZ061HB4ZZEZJAlIbgKRx7wjz7Yn5BQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RzI9NZikD6qowaipBowXN0j+aqxJXPwotzpj7HqST5YQeLGrQhzgscyqpRRIhK1zm
         XimvqFARj/rjk1zn4HD2g9Jal7yBLDB5DMKfCy2cVCWVBlmlcy3yYhpSYYccMMJNYQ
         7kw2pITXvXb20QomVbosKN2NLYtXdztVMo+tdxl5SnFcdDd1qu2LiPU6oxqTDE8JIx
         lWI1VvVcYP4OX1S1I/ra3GJXCG+/4/j/fDP84LwjNLqYvpiRms8+A+s/rNUjttZWc2
         yTrDQhcxUuyODu+F5hzqexMoItcPP+wm36EDVXbC7AG27EWkt968QhGEBWOSkEsMm6
         1xbF59qm1B3dQ==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: [PATCH v1 03/11] tools/nolibc: Replace `asm` with `__asm__`
Date:   Thu, 24 Mar 2022 14:30:31 +0700
Message-Id: <20220324073039.140946-4-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220324073039.140946-1-ammarfaizi2@gnuweeb.org>
References: <20220324073039.140946-1-ammarfaizi2@gnuweeb.org>
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
---

In private conversation with Alviro, we found that using -std flag hits
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
---
 tools/include/nolibc/arch-aarch64.h | 72 ++++++++++++++--------------
 tools/include/nolibc/arch-arm.h     | 58 +++++++++++-----------
 tools/include/nolibc/arch-i386.h    | 56 +++++++++++-----------
 tools/include/nolibc/arch-mips.h    | 62 ++++++++++++------------
 tools/include/nolibc/arch-riscv.h   | 74 ++++++++++++++---------------
 tools/include/nolibc/arch-x86_64.h  | 72 ++++++++++++++--------------
 6 files changed, 197 insertions(+), 197 deletions(-)

diff --git a/tools/include/nolibc/arch-aarch64.h b/tools/include/nolibc/arch-aarch64.h
index 2dbd80d633cb..d7f4fcf46d51 100644
--- a/tools/include/nolibc/arch-aarch64.h
+++ b/tools/include/nolibc/arch-aarch64.h
@@ -64,10 +64,10 @@ struct sys_stat_struct {
 
 #define my_syscall0(num)                                                      \
 ({                                                                            \
-	register long _num  asm("x8") = (num);                                \
-	register long _arg1 asm("x0");                                        \
+	register long _num  __asm__("x8") = (num);                            \
+	register long _arg1 __asm__("x0");                                    \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__ volatile (                                                    \
 		"svc #0\n"                                                    \
 		: "=r"(_arg1)                                                 \
 		: "r"(_num)                                                   \
@@ -78,10 +78,10 @@ struct sys_stat_struct {
 
 #define my_syscall1(num, arg1)                                                \
 ({                                                                            \
-	register long _num  asm("x8") = (num);                                \
-	register long _arg1 asm("x0") = (long)(arg1);                         \
+	register long _num  __asm__("x8") = (num);                            \
+	register long _arg1 __asm__("x0") = (long)(arg1);                     \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__ volatile (                                                    \
 		"svc #0\n"                                                    \
 		: "=r"(_arg1)                                                 \
 		: "r"(_arg1),                                                 \
@@ -93,11 +93,11 @@ struct sys_stat_struct {
 
 #define my_syscall2(num, arg1, arg2)                                          \
 ({                                                                            \
-	register long _num  asm("x8") = (num);                                \
-	register long _arg1 asm("x0") = (long)(arg1);                         \
-	register long _arg2 asm("x1") = (long)(arg2);                         \
+	register long _num  __asm__("x8") = (num);                            \
+	register long _arg1 __asm__("x0") = (long)(arg1);                     \
+	register long _arg2 __asm__("x1") = (long)(arg2);                     \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__ volatile (                                                    \
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
+	register long _num  __asm__("x8") = (num);                            \
+	register long _arg1 __asm__("x0") = (long)(arg1);                     \
+	register long _arg2 __asm__("x1") = (long)(arg2);                     \
+	register long _arg3 __asm__("x2") = (long)(arg3);                     \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__ volatile (                                                    \
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
+	register long _num  __asm__("x8") = (num);                            \
+	register long _arg1 __asm__("x0") = (long)(arg1);                     \
+	register long _arg2 __asm__("x1") = (long)(arg2);                     \
+	register long _arg3 __asm__("x2") = (long)(arg3);                     \
+	register long _arg4 __asm__("x3") = (long)(arg4);                     \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__ volatile (                                                    \
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
+	register long _num  __asm__("x8") = (num);                            \
+	register long _arg1 __asm__("x0") = (long)(arg1);                     \
+	register long _arg2 __asm__("x1") = (long)(arg2);                     \
+	register long _arg3 __asm__("x2") = (long)(arg3);                     \
+	register long _arg4 __asm__("x3") = (long)(arg4);                     \
+	register long _arg5 __asm__("x4") = (long)(arg5);                     \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__ volatile (                                                    \
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
+	register long _num  __asm__("x8") = (num);                            \
+	register long _arg1 __asm__("x0") = (long)(arg1);                     \
+	register long _arg2 __asm__("x1") = (long)(arg2);                     \
+	register long _arg3 __asm__("x2") = (long)(arg3);                     \
+	register long _arg4 __asm__("x3") = (long)(arg4);                     \
+	register long _arg5 __asm__("x4") = (long)(arg5);                     \
+	register long _arg6 __asm__("x5") = (long)(arg6);                     \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__ volatile (                                                    \
 		"svc #0\n"                                                    \
 		: "=r" (_arg1)                                                \
 		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), \
diff --git a/tools/include/nolibc/arch-arm.h b/tools/include/nolibc/arch-arm.h
index 1191395b5acd..0e88cbe42588 100644
--- a/tools/include/nolibc/arch-arm.h
+++ b/tools/include/nolibc/arch-arm.h
@@ -77,10 +77,10 @@ struct sys_stat_struct {
 
 #define my_syscall0(num)                                                      \
 ({                                                                            \
-	register long _num asm("r7") = (num);                                 \
-	register long _arg1 asm("r0");                                        \
+	register long _num __asm__("r7") = (num);                             \
+	register long _arg1 __asm__("r0");                                    \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__ volatile (                                                    \
 		"svc #0\n"                                                    \
 		: "=r"(_arg1)                                                 \
 		: "r"(_num)                                                   \
@@ -91,10 +91,10 @@ struct sys_stat_struct {
 
 #define my_syscall1(num, arg1)                                                \
 ({                                                                            \
-	register long _num asm("r7") = (num);                                 \
-	register long _arg1 asm("r0") = (long)(arg1);                         \
+	register long _num __asm__("r7") = (num);                             \
+	register long _arg1 __asm__("r0") = (long)(arg1);                     \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__ volatile (                                                    \
 		"svc #0\n"                                                    \
 		: "=r"(_arg1)                                                 \
 		: "r"(_arg1),                                                 \
@@ -106,11 +106,11 @@ struct sys_stat_struct {
 
 #define my_syscall2(num, arg1, arg2)                                          \
 ({                                                                            \
-	register long _num asm("r7") = (num);                                 \
-	register long _arg1 asm("r0") = (long)(arg1);                         \
-	register long _arg2 asm("r1") = (long)(arg2);                         \
+	register long _num __asm__("r7") = (num);                             \
+	register long _arg1 __asm__("r0") = (long)(arg1);                     \
+	register long _arg2 __asm__("r1") = (long)(arg2);                     \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__ volatile (                                                    \
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
+	register long _num __asm__("r7") = (num);                             \
+	register long _arg1 __asm__("r0") = (long)(arg1);                     \
+	register long _arg2 __asm__("r1") = (long)(arg2);                     \
+	register long _arg3 __asm__("r2") = (long)(arg3);                     \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__ volatile (                                                    \
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
+	register long _num __asm__("r7") = (num);                             \
+	register long _arg1 __asm__("r0") = (long)(arg1);                     \
+	register long _arg2 __asm__("r1") = (long)(arg2);                     \
+	register long _arg3 __asm__("r2") = (long)(arg3);                     \
+	register long _arg4 __asm__("r3") = (long)(arg4);                     \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__ volatile (                                                    \
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
+	register long _num __asm__("r7") = (num);                             \
+	register long _arg1 __asm__("r0") = (long)(arg1);                     \
+	register long _arg2 __asm__("r1") = (long)(arg2);                     \
+	register long _arg3 __asm__("r2") = (long)(arg3);                     \
+	register long _arg4 __asm__("r3") = (long)(arg4);                     \
+	register long _arg5 __asm__("r4") = (long)(arg5);                     \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__ volatile (                                                    \
 		"svc #0\n"                                                    \
 		: "=r" (_arg1)                                                \
 		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), \
@@ -175,7 +175,7 @@ struct sys_stat_struct {
 })
 
 /* startup code */
-asm(".section .text\n"
+__asm__(".section .text\n"
     ".weak _start\n"
     "_start:\n"
 #if defined(__THUMBEB__) || defined(__THUMBEL__)
diff --git a/tools/include/nolibc/arch-i386.h b/tools/include/nolibc/arch-i386.h
index 125a691fc631..ff2e6bb453cf 100644
--- a/tools/include/nolibc/arch-i386.h
+++ b/tools/include/nolibc/arch-i386.h
@@ -66,9 +66,9 @@ struct sys_stat_struct {
 #define my_syscall0(num)                                                      \
 ({                                                                            \
 	long _ret;                                                            \
-	register long _num asm("eax") = (num);                                \
+	register long _num __asm__("eax") = (num);                            \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__ volatile (                                                    \
 		"int $0x80\n"                                                 \
 		: "=a" (_ret)                                                 \
 		: "0"(_num)                                                   \
@@ -80,10 +80,10 @@ struct sys_stat_struct {
 #define my_syscall1(num, arg1)                                                \
 ({                                                                            \
 	long _ret;                                                            \
-	register long _num asm("eax") = (num);                                \
-	register long _arg1 asm("ebx") = (long)(arg1);                        \
+	register long _num __asm__("eax") = (num);                            \
+	register long _arg1 __asm__("ebx") = (long)(arg1);                    \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__ volatile (                                                    \
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
+	register long _num __asm__("eax") = (num);                            \
+	register long _arg1 __asm__("ebx") = (long)(arg1);                    \
+	register long _arg2 __asm__("ecx") = (long)(arg2);                    \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__ volatile (                                                    \
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
+	register long _num __asm__("eax") = (num);                            \
+	register long _arg1 __asm__("ebx") = (long)(arg1);                    \
+	register long _arg2 __asm__("ecx") = (long)(arg2);                    \
+	register long _arg3 __asm__("edx") = (long)(arg3);                    \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__ volatile (                                                    \
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
+	register long _num __asm__("eax") = (num);                            \
+	register long _arg1 __asm__("ebx") = (long)(arg1);                    \
+	register long _arg2 __asm__("ecx") = (long)(arg2);                    \
+	register long _arg3 __asm__("edx") = (long)(arg3);                    \
+	register long _arg4 __asm__("esi") = (long)(arg4);                    \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__ volatile (                                                    \
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
+	register long _num __asm__("eax") = (num);                            \
+	register long _arg1 __asm__("ebx") = (long)(arg1);                    \
+	register long _arg2 __asm__("ecx") = (long)(arg2);                    \
+	register long _arg3 __asm__("edx") = (long)(arg3);                    \
+	register long _arg4 __asm__("esi") = (long)(arg4);                    \
+	register long _arg5 __asm__("edi") = (long)(arg5);                    \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__ volatile (                                                    \
 		"int $0x80\n"                                                 \
 		: "=a" (_ret)                                                 \
 		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), \
@@ -174,7 +174,7 @@ struct sys_stat_struct {
  * 2) The deepest stack frame should be set to zero
  *
  */
-asm(".section .text\n"
+__asm__(".section .text\n"
     ".weak _start\n"
     "_start:\n"
     "pop %eax\n"                // argc   (first arg, %eax)
diff --git a/tools/include/nolibc/arch-mips.h b/tools/include/nolibc/arch-mips.h
index 1a124790c99f..b43da77fde0e 100644
--- a/tools/include/nolibc/arch-mips.h
+++ b/tools/include/nolibc/arch-mips.h
@@ -69,10 +69,10 @@ struct sys_stat_struct {
 
 #define my_syscall0(num)                                                      \
 ({                                                                            \
-	register long _num asm("v0") = (num);                                 \
-	register long _arg4 asm("a3");                                        \
+	register long _num __asm__("v0") = (num);                             \
+	register long _arg4 __asm__("a3");                                    \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__ volatile (                                                    \
 		"addiu $sp, $sp, -32\n"                                       \
 		"syscall\n"                                                   \
 		"addiu $sp, $sp, 32\n"                                        \
@@ -86,11 +86,11 @@ struct sys_stat_struct {
 
 #define my_syscall1(num, arg1)                                                \
 ({                                                                            \
-	register long _num asm("v0") = (num);                                 \
-	register long _arg1 asm("a0") = (long)(arg1);                         \
-	register long _arg4 asm("a3");                                        \
+	register long _num __asm__("v0") = (num);                             \
+	register long _arg1 __asm__("a0") = (long)(arg1);                     \
+	register long _arg4 __asm__("a3");                                    \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__ volatile (                                                    \
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
+	register long _num __asm__("v0") = (num);                             \
+	register long _arg1 __asm__("a0") = (long)(arg1);                     \
+	register long _arg2 __asm__("a1") = (long)(arg2);                     \
+	register long _arg4 __asm__("a3");                                    \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__ volatile (                                                    \
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
+	register long _num __asm__("v0")  = (num);                            \
+	register long _arg1 __asm__("a0") = (long)(arg1);                     \
+	register long _arg2 __asm__("a1") = (long)(arg2);                     \
+	register long _arg3 __asm__("a2") = (long)(arg3);                     \
+	register long _arg4 __asm__("a3");                                    \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__ volatile (                                                    \
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
+	register long _num __asm__("v0") = (num);                             \
+	register long _arg1 __asm__("a0") = (long)(arg1);                     \
+	register long _arg2 __asm__("a1") = (long)(arg2);                     \
+	register long _arg3 __asm__("a2") = (long)(arg3);                     \
+	register long _arg4 __asm__("a3") = (long)(arg4);                     \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__ volatile (                                                    \
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
+	register long _num __asm__("v0") = (num);                             \
+	register long _arg1 __asm__("a0") = (long)(arg1);                     \
+	register long _arg2 __asm__("a1") = (long)(arg2);                     \
+	register long _arg3 __asm__("a2") = (long)(arg3);                     \
+	register long _arg4 __asm__("a3") = (long)(arg4);                     \
 	register long _arg5 = (long)(arg5);                                   \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__ volatile (                                                    \
 		"addiu $sp, $sp, -32\n"                                       \
 		"sw %7, 16($sp)\n"                                            \
 		"syscall\n  "                                                 \
@@ -189,7 +189,7 @@ struct sys_stat_struct {
 })
 
 /* startup code, note that it's called __start on MIPS */
-asm(".section .text\n"
+__asm__(".section .text\n"
     ".weak __start\n"
     ".set nomips16\n"
     ".set    noreorder\n"
diff --git a/tools/include/nolibc/arch-riscv.h b/tools/include/nolibc/arch-riscv.h
index 511d67fc534e..100bc71da344 100644
--- a/tools/include/nolibc/arch-riscv.h
+++ b/tools/include/nolibc/arch-riscv.h
@@ -66,10 +66,10 @@ struct sys_stat_struct {
 
 #define my_syscall0(num)                                                      \
 ({                                                                            \
-	register long _num  asm("a7") = (num);                                \
-	register long _arg1 asm("a0");                                        \
+	register long _num  __asm__("a7") = (num);                            \
+	register long _arg1 __asm__("a0");                                    \
 									      \
-	asm volatile (                                                        \
+	__asm__ volatile (                                                    \
 		"ecall\n\t"                                                   \
 		: "=r"(_arg1)                                                 \
 		: "r"(_num)                                                   \
@@ -80,10 +80,10 @@ struct sys_stat_struct {
 
 #define my_syscall1(num, arg1)                                                \
 ({                                                                            \
-	register long _num  asm("a7") = (num);                                \
-	register long _arg1 asm("a0") = (long)(arg1);		              \
+	register long _num  __asm__("a7") = (num);                            \
+	register long _arg1 __asm__("a0") = (long)(arg1);		      \
 									      \
-	asm volatile (                                                        \
+	__asm__ volatile (                                                    \
 		"ecall\n"                                                     \
 		: "+r"(_arg1)                                                 \
 		: "r"(_num)                                                   \
@@ -94,11 +94,11 @@ struct sys_stat_struct {
 
 #define my_syscall2(num, arg1, arg2)                                          \
 ({                                                                            \
-	register long _num  asm("a7") = (num);                                \
-	register long _arg1 asm("a0") = (long)(arg1);                         \
-	register long _arg2 asm("a1") = (long)(arg2);                         \
+	register long _num  __asm__("a7") = (num);                            \
+	register long _arg1 __asm__("a0") = (long)(arg1);                     \
+	register long _arg2 __asm__("a1") = (long)(arg2);                     \
 									      \
-	asm volatile (                                                        \
+	__asm__ volatile (                                                    \
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
+	register long _num  __asm__("a7") = (num);                            \
+	register long _arg1 __asm__("a0") = (long)(arg1);                     \
+	register long _arg2 __asm__("a1") = (long)(arg2);                     \
+	register long _arg3 __asm__("a2") = (long)(arg3);                     \
 									      \
-	asm volatile (                                                        \
+	__asm__ volatile (                                                    \
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
+	register long _num  __asm__("a7") = (num);                            \
+	register long _arg1 __asm__("a0") = (long)(arg1);                     \
+	register long _arg2 __asm__("a1") = (long)(arg2);                     \
+	register long _arg3 __asm__("a2") = (long)(arg3);                     \
+	register long _arg4 __asm__("a3") = (long)(arg4);                     \
 									      \
-	asm volatile (                                                        \
+	__asm__ volatile (                                                    \
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
+	register long _num  __asm__("a7") = (num);                            \
+	register long _arg1 __asm__("a0") = (long)(arg1);                     \
+	register long _arg2 __asm__("a1") = (long)(arg2);                     \
+	register long _arg3 __asm__("a2") = (long)(arg3);                     \
+	register long _arg4 __asm__("a3") = (long)(arg4);                     \
+	register long _arg5 __asm__("a4") = (long)(arg5);                     \
 									      \
-	asm volatile (                                                        \
+	__asm__ volatile (                                                    \
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
+	register long _num  __asm__("a7") = (num);                            \
+	register long _arg1 __asm__("a0") = (long)(arg1);                     \
+	register long _arg2 __asm__("a1") = (long)(arg2);                     \
+	register long _arg3 __asm__("a2") = (long)(arg3);                     \
+	register long _arg4 __asm__("a3") = (long)(arg4);                     \
+	register long _arg5 __asm__("a4") = (long)(arg5);                     \
+	register long _arg6 __asm__("a5") = (long)(arg6);                     \
 									      \
-	asm volatile (                                                        \
+	__asm__ volatile (                                                    \
 		"ecall\n"                                                     \
 		: "+r"(_arg1)                                                 \
 		: "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), "r"(_arg6), \
@@ -183,7 +183,7 @@ struct sys_stat_struct {
 })
 
 /* startup code */
-asm(".section .text\n"
+__asm__(".section .text\n"
     ".weak _start\n"
     "_start:\n"
     ".option push\n"
diff --git a/tools/include/nolibc/arch-x86_64.h b/tools/include/nolibc/arch-x86_64.h
index 84c174181425..afc50f84a036 100644
--- a/tools/include/nolibc/arch-x86_64.h
+++ b/tools/include/nolibc/arch-x86_64.h
@@ -68,9 +68,9 @@ struct sys_stat_struct {
 #define my_syscall0(num)                                                      \
 ({                                                                            \
 	long _ret;                                                            \
-	register long _num  asm("rax") = (num);                               \
+	register long _num  __asm__("rax") = (num);                           \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__ volatile (                                                    \
 		"syscall\n"                                                   \
 		: "=a"(_ret)                                                  \
 		: "0"(_num)                                                   \
@@ -82,10 +82,10 @@ struct sys_stat_struct {
 #define my_syscall1(num, arg1)                                                \
 ({                                                                            \
 	long _ret;                                                            \
-	register long _num  asm("rax") = (num);                               \
-	register long _arg1 asm("rdi") = (long)(arg1);                        \
+	register long _num  __asm__("rax") = (num);                           \
+	register long _arg1 __asm__("rdi") = (long)(arg1);                    \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__ volatile (                                                    \
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
+	register long _num  __asm__("rax") = (num);                           \
+	register long _arg1 __asm__("rdi") = (long)(arg1);                    \
+	register long _arg2 __asm__("rsi") = (long)(arg2);                    \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__ volatile (                                                    \
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
+	register long _num  __asm__("rax") = (num);                           \
+	register long _arg1 __asm__("rdi") = (long)(arg1);                    \
+	register long _arg2 __asm__("rsi") = (long)(arg2);                    \
+	register long _arg3 __asm__("rdx") = (long)(arg3);                    \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__ volatile (                                                    \
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
+	register long _num  __asm__("rax") = (num);                           \
+	register long _arg1 __asm__("rdi") = (long)(arg1);                    \
+	register long _arg2 __asm__("rsi") = (long)(arg2);                    \
+	register long _arg3 __asm__("rdx") = (long)(arg3);                    \
+	register long _arg4 __asm__("r10") = (long)(arg4);                    \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__ volatile (                                                    \
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
+	register long _num  __asm__("rax") = (num);                           \
+	register long _arg1 __asm__("rdi") = (long)(arg1);                    \
+	register long _arg2 __asm__("rsi") = (long)(arg2);                    \
+	register long _arg3 __asm__("rdx") = (long)(arg3);                    \
+	register long _arg4 __asm__("r10") = (long)(arg4);                    \
+	register long _arg5 __asm__("r8")  = (long)(arg5);                    \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__ volatile (                                                    \
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
+	register long _num  __asm__("rax") = (num);                           \
+	register long _arg1 __asm__("rdi") = (long)(arg1);                    \
+	register long _arg2 __asm__("rsi") = (long)(arg2);                    \
+	register long _arg3 __asm__("rdx") = (long)(arg3);                    \
+	register long _arg4 __asm__("r10") = (long)(arg4);                    \
+	register long _arg5 __asm__("r8")  = (long)(arg5);                    \
+	register long _arg6 __asm__("r9")  = (long)(arg6);                    \
 	                                                                      \
-	asm volatile (                                                        \
+	__asm__ volatile (                                                    \
 		"syscall\n"                                                   \
 		: "=a"(_ret)                                                  \
 		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), \
@@ -197,7 +197,7 @@ struct sys_stat_struct {
  * 2) The deepest stack frame should be zero (the %rbp).
  *
  */
-asm(".section .text\n"
+__asm__(".section .text\n"
     ".weak _start\n"
     "_start:\n"
     "pop %rdi\n"                // argc   (first arg, %rdi)
-- 
Ammar Faizi

