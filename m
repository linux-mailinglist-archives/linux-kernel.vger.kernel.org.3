Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3BB14E5F7D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 08:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348685AbiCXHeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348651AbiCXHcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:32:48 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC6A996BA
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 00:31:08 -0700 (PDT)
Received: from integral2.. (unknown [182.2.71.236])
        by gnuweeb.org (Postfix) with ESMTPSA id 9B2BE7E712;
        Thu, 24 Mar 2022 07:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1648107067;
        bh=waHrXoHOW/pPU9BrI5hKUWTpbkCQhESmBtk6btYk9uw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D1dwyjBP51HYddOWHyVExRSy2yUV84oMLstAlS37ZkQfV9ZYBnCvqsEzOQ6HoTsYT
         AOmW6z04EnOc5KSEz3E3mTXKEvrgWIrBuiS7u8IQPllVS1PUNInB2rmuTcy0FMufq3
         hZ5aGwQ5LqIGL17HYYTpgxirIUocCxPdSMh7VlPyuL3hvEnj+wpyBxptkSMc0taLaZ
         lysSrIH7IvSTYaU8J6CFhdnzBrCfTlagqllMQnTOauCuYJdYrJAHmXXjrPkE+iM2OR
         deDbA23BnqZ9aDM7hpJw0Rpcf/4gI10USOQp4D5O9OsKYFNV5BgdZ71heippfdzuZi
         5V9agKtsLezXQ==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        David Laight <David.Laight@ACULAB.COM>
Subject: [PATCH v1 05/11] tools/nolibc: i386: Use appropriate register constraints if exist
Date:   Thu, 24 Mar 2022 14:30:33 +0700
Message-Id: <20220324073039.140946-6-ammarfaizi2@gnuweeb.org>
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
outside %eax, %ebx, %ecx, %edx, %esi, %edi).

It also simplifies the macro definition.

Link: https://lore.kernel.org/lkml/3d2cfdeecddc45dc8e4beada305b5948@AcuMS.aculab.com
Suggested-by: David Laight <David.Laight@ACULAB.COM>
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 tools/include/nolibc/arch-i386.h | 162 +++++++++++++------------------
 1 file changed, 70 insertions(+), 92 deletions(-)

diff --git a/tools/include/nolibc/arch-i386.h b/tools/include/nolibc/arch-i386.h
index ff2e6bb453cf..6eb96ee8c4f7 100644
--- a/tools/include/nolibc/arch-i386.h
+++ b/tools/include/nolibc/arch-i386.h
@@ -63,108 +63,86 @@ struct sys_stat_struct {
  */
 #define __ARCH_WANT_SYS_OLD_SELECT
 
-#define my_syscall0(num)                                                      \
-({                                                                            \
-	long _ret;                                                            \
-	register long _num __asm__("eax") = (num);                            \
-	                                                                      \
-	__asm__ volatile (                                                    \
-		"int $0x80\n"                                                 \
-		: "=a" (_ret)                                                 \
-		: "0"(_num)                                                   \
-		: "memory", "cc"                                              \
-	);                                                                    \
-	_ret;                                                                 \
+#define my_syscall0(num)				\
+({							\
+	long _ret = (num);				\
+	__asm__ volatile (				\
+		"int $0x80\n"				\
+		: "+a"(_ret)	/* %eax */		\
+		:					\
+		: "memory", "cc"			\
+	);						\
+	_ret;						\
 })
 
-#define my_syscall1(num, arg1)                                                \
-({                                                                            \
-	long _ret;                                                            \
-	register long _num __asm__("eax") = (num);                            \
-	register long _arg1 __asm__("ebx") = (long)(arg1);                    \
-	                                                                      \
-	__asm__ volatile (                                                    \
-		"int $0x80\n"                                                 \
-		: "=a" (_ret)                                                 \
-		: "r"(_arg1),                                                 \
-		  "0"(_num)                                                   \
-		: "memory", "cc"                                              \
-	);                                                                    \
-	_ret;                                                                 \
+#define my_syscall1(num, arg1)				\
+({							\
+	long _ret = (num);				\
+	__asm__ volatile (				\
+		"int $0x80\n"				\
+		: "+a"(_ret)	/* %eax */		\
+		: "b"(arg1)	/* %ebx */		\
+		: "memory", "cc"			\
+	);						\
+	_ret;						\
 })
 
-#define my_syscall2(num, arg1, arg2)                                          \
-({                                                                            \
-	long _ret;                                                            \
-	register long _num __asm__("eax") = (num);                            \
-	register long _arg1 __asm__("ebx") = (long)(arg1);                    \
-	register long _arg2 __asm__("ecx") = (long)(arg2);                    \
-	                                                                      \
-	__asm__ volatile (                                                    \
-		"int $0x80\n"                                                 \
-		: "=a" (_ret)                                                 \
-		: "r"(_arg1), "r"(_arg2),                                     \
-		  "0"(_num)                                                   \
-		: "memory", "cc"                                              \
-	);                                                                    \
-	_ret;                                                                 \
+#define my_syscall2(num, arg1, arg2)			\
+({							\
+	long _ret = (num);				\
+	__asm__ volatile (				\
+		"int $0x80\n"				\
+		: "+a"(_ret)	/* %eax */		\
+		: "b"(arg1),	/* %ebx */		\
+		  "c"(arg2)	/* %ecx */		\
+		: "memory", "cc"			\
+	);						\
+	_ret;						\
 })
 
-#define my_syscall3(num, arg1, arg2, arg3)                                    \
-({                                                                            \
-	long _ret;                                                            \
-	register long _num __asm__("eax") = (num);                            \
-	register long _arg1 __asm__("ebx") = (long)(arg1);                    \
-	register long _arg2 __asm__("ecx") = (long)(arg2);                    \
-	register long _arg3 __asm__("edx") = (long)(arg3);                    \
-	                                                                      \
-	__asm__ volatile (                                                    \
-		"int $0x80\n"                                                 \
-		: "=a" (_ret)                                                 \
-		: "r"(_arg1), "r"(_arg2), "r"(_arg3),                         \
-		  "0"(_num)                                                   \
-		: "memory", "cc"                                              \
-	);                                                                    \
-	_ret;                                                                 \
+#define my_syscall3(num, arg1, arg2, arg3)		\
+({							\
+	long _ret = (num);				\
+	__asm__ volatile (				\
+		"int $0x80\n"				\
+		: "+a"(_ret)	/* %eax */		\
+		: "b"(arg1),	/* %ebx */		\
+		  "c"(arg2),	/* %ecx */		\
+		  "d"(arg3)	/* %edx */		\
+		: "memory", "cc"			\
+	);						\
+	_ret;						\
 })
 
-#define my_syscall4(num, arg1, arg2, arg3, arg4)                              \
-({                                                                            \
-	long _ret;                                                            \
-	register long _num __asm__("eax") = (num);                            \
-	register long _arg1 __asm__("ebx") = (long)(arg1);                    \
-	register long _arg2 __asm__("ecx") = (long)(arg2);                    \
-	register long _arg3 __asm__("edx") = (long)(arg3);                    \
-	register long _arg4 __asm__("esi") = (long)(arg4);                    \
-	                                                                      \
-	__asm__ volatile (                                                    \
-		"int $0x80\n"                                                 \
-		: "=a" (_ret)                                                 \
-		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4),             \
-		  "0"(_num)                                                   \
-		: "memory", "cc"                                              \
-	);                                                                    \
-	_ret;                                                                 \
+#define my_syscall4(num, arg1, arg2, arg3, arg4)	\
+({							\
+	long _ret = (num);				\
+	__asm__ volatile (				\
+		"int $0x80\n"				\
+		: "+a"(_ret)	/* %eax */		\
+		: "b"(arg1),	/* %ebx */		\
+		  "c"(arg2),	/* %ecx */		\
+		  "d"(arg3),	/* %edx */		\
+		  "S"(arg4)	/* %esi */		\
+		: "memory", "cc"			\
+	);						\
+	_ret;						\
 })
 
-#define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)                        \
-({                                                                            \
-	long _ret;                                                            \
-	register long _num __asm__("eax") = (num);                            \
-	register long _arg1 __asm__("ebx") = (long)(arg1);                    \
-	register long _arg2 __asm__("ecx") = (long)(arg2);                    \
-	register long _arg3 __asm__("edx") = (long)(arg3);                    \
-	register long _arg4 __asm__("esi") = (long)(arg4);                    \
-	register long _arg5 __asm__("edi") = (long)(arg5);                    \
-	                                                                      \
-	__asm__ volatile (                                                    \
-		"int $0x80\n"                                                 \
-		: "=a" (_ret)                                                 \
-		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), \
-		  "0"(_num)                                                   \
-		: "memory", "cc"                                              \
-	);                                                                    \
-	_ret;                                                                 \
+#define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)	\
+({							\
+	long _ret = (num);				\
+	__asm__ volatile (				\
+		"int $0x80\n"				\
+		: "+a"(_ret)	/* %eax */		\
+		: "b"(arg1),	/* %ebx */		\
+		  "c"(arg2),	/* %ecx */		\
+		  "d"(arg3),	/* %edx */		\
+		  "S"(arg4),	/* %esi */		\
+		  "D"(arg5)	/* %edi */		\
+		: "memory", "cc"			\
+	);						\
+	_ret;						\
 })
 
 /* startup code */
-- 
Ammar Faizi

