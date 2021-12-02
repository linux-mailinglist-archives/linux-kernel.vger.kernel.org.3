Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54226465AFB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354546AbhLBAhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345031AbhLBAhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:37:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6F3C061574;
        Wed,  1 Dec 2021 16:33:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0FD1B82194;
        Thu,  2 Dec 2021 00:33:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7432FC53FCC;
        Thu,  2 Dec 2021 00:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638405228;
        bh=U7fCdPcsB3mfEwE0kNaIA9+TmTRIdtgOUoHdgn3oHhk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MX36HkjAp83NhZpWEm6BKnLuR+6ycX37WTlIM6V1Arfsj9B9fbKBqOzKy2wjUZk4L
         86w7QYMfUGGlKkrWorMEtFVuzr6CnMhjt7WFrkqTcLupBkZ55cLw8nLO4N5ssElgx4
         4hdTl65yawiTejtI4wbS4TctlaP2G/TOr6oI27wA1PzVtIHwO/kLI/ppntH/iV7jmK
         H2UNFgmnckiZ/G87UySlGuJeh7EP8vK6cz+Kze347kLSCBBkCZeb8QSJE51Nwsa0/C
         zujrPEEht/tuV1rKb2Eg9NHIMobY1/rMRKUsY42Kv/tJyQNi+ev2FzJYcQHh16ekqS
         YnSSIexE/Ymfw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 406465C1109; Wed,  1 Dec 2021 16:33:48 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Ammar Faizi <ammar.faizi@students.amikom.ac.id>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 4/6] tools/nolibc: x86: Remove `r8`, `r9` and `r10` from the clobber list
Date:   Wed,  1 Dec 2021 16:33:44 -0800
Message-Id: <20211202003346.3129110-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202003322.GA3128775@paulmck-ThinkPad-P17-Gen-1>
References: <20211202003322.GA3128775@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ammar Faizi <ammar.faizi@students.amikom.ac.id>

Linux x86-64 syscall only clobbers rax, rcx and r11 (and "memory").

  - rax for the return value.
  - rcx to save the return address.
  - r11 to save the rflags.

Other registers are preserved.

Having r8, r9 and r10 in the syscall clobber list is harmless, but this
results in a missed-optimization.

As the syscall doesn't clobber r8-r10, GCC should be allowed to reuse
their value after the syscall returns to userspace. But since they are
in the clobber list, GCC will always miss this opportunity.

Remove them from the x86-64 syscall clobber list to help GCC generate
better code and fix the comment.

See also the x86-64 ABI, section A.2 AMD64 Linux Kernel Conventions,
A.2.1 Calling Conventions [1].

Extra note:
Some people may think it does not really give a benefit to remove r8,
r9 and r10 from the syscall clobber list because the impression of
syscall is a C function call, and function call always clobbers those 3.

However, that is not the case for nolibc.h, because we have a potential
to inline the "syscall" instruction (which its opcode is "0f 05") to the
user functions.

All syscalls in the nolibc.h are written as a static function with inline
ASM and are likely always inline if we use optimization flag, so this is
a profit not to have r8, r9 and r10 in the clobber list.

Here is the example where this matters.

Consider the following C code:
```
  #include "tools/include/nolibc/nolibc.h"
  #define read_abc(a, b, c) __asm__ volatile("nop"::"r"(a),"r"(b),"r"(c))

  int main(void)
  {
  	int a = 0xaa;
  	int b = 0xbb;
  	int c = 0xcc;

  	read_abc(a, b, c);
  	write(1, "test\n", 5);
  	read_abc(a, b, c);

  	return 0;
  }
```

Compile with:
    gcc -Os test.c -o test -nostdlib

With r8, r9, r10 in the clobber list, GCC generates this:

0000000000001000 <main>:
    1000:	f3 0f 1e fa          	endbr64
    1004:	41 54                	push   %r12
    1006:	41 bc cc 00 00 00    	mov    $0xcc,%r12d
    100c:	55                   	push   %rbp
    100d:	bd bb 00 00 00       	mov    $0xbb,%ebp
    1012:	53                   	push   %rbx
    1013:	bb aa 00 00 00       	mov    $0xaa,%ebx
    1018:	90                   	nop
    1019:	b8 01 00 00 00       	mov    $0x1,%eax
    101e:	bf 01 00 00 00       	mov    $0x1,%edi
    1023:	ba 05 00 00 00       	mov    $0x5,%edx
    1028:	48 8d 35 d1 0f 00 00 	lea    0xfd1(%rip),%rsi
    102f:	0f 05                	syscall
    1031:	90                   	nop
    1032:	31 c0                	xor    %eax,%eax
    1034:	5b                   	pop    %rbx
    1035:	5d                   	pop    %rbp
    1036:	41 5c                	pop    %r12
    1038:	c3                   	ret

GCC thinks that syscall will clobber r8, r9, r10. So it spills 0xaa,
0xbb and 0xcc to callee saved registers (r12, rbp and rbx). This is
clearly extra memory access and extra stack size for preserving them.

But syscall does not actually clobber them, so this is a missed
optimization.

Now without r8, r9, r10 in the clobber list, GCC generates better code:

0000000000001000 <main>:
    1000:	f3 0f 1e fa          	endbr64
    1004:	41 b8 aa 00 00 00    	mov    $0xaa,%r8d
    100a:	41 b9 bb 00 00 00    	mov    $0xbb,%r9d
    1010:	41 ba cc 00 00 00    	mov    $0xcc,%r10d
    1016:	90                   	nop
    1017:	b8 01 00 00 00       	mov    $0x1,%eax
    101c:	bf 01 00 00 00       	mov    $0x1,%edi
    1021:	ba 05 00 00 00       	mov    $0x5,%edx
    1026:	48 8d 35 d3 0f 00 00 	lea    0xfd3(%rip),%rsi
    102d:	0f 05                	syscall
    102f:	90                   	nop
    1030:	31 c0                	xor    %eax,%eax
    1032:	c3                   	ret

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: David Laight <David.Laight@ACULAB.COM>
Acked-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Ammar Faizi <ammar.faizi@students.amikom.ac.id>
Link: https://gitlab.com/x86-psABIs/x86-64-ABI/-/wikis/x86-64-psABI [1]
Link: https://lore.kernel.org/lkml/20211011040344.437264-1-ammar.faizi@students.amikom.ac.id/
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/nolibc.h | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 3e2c6f2ed587f..f9afe89ec6f26 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -265,12 +265,17 @@ struct stat {
  *   - arguments are in rdi, rsi, rdx, r10, r8, r9 respectively
  *   - the system call is performed by calling the syscall instruction
  *   - syscall return comes in rax
- *   - rcx and r8..r11 may be clobbered, others are preserved.
+ *   - rcx and r11 are clobbered, others are preserved.
  *   - the arguments are cast to long and assigned into the target registers
  *     which are then simply passed as registers to the asm code, so that we
  *     don't have to experience issues with register constraints.
  *   - the syscall number is always specified last in order to allow to force
  *     some registers before (gcc refuses a %-register at the last position).
+ *   - see also x86-64 ABI section A.2 AMD64 Linux Kernel Conventions, A.2.1
+ *     Calling Conventions.
+ *
+ * Link x86-64 ABI: https://gitlab.com/x86-psABIs/x86-64-ABI/-/wikis/x86-64-psABI
+ *
  */
 
 #define my_syscall0(num)                                                      \
@@ -280,9 +285,9 @@ struct stat {
 									      \
 	asm volatile (                                                        \
 		"syscall\n"                                                   \
-		: "=a" (_ret)                                                 \
+		: "=a"(_ret)                                                  \
 		: "0"(_num)                                                   \
-		: "rcx", "r8", "r9", "r10", "r11", "memory", "cc"             \
+		: "rcx", "r11", "memory", "cc"                                \
 	);                                                                    \
 	_ret;                                                                 \
 })
@@ -295,10 +300,10 @@ struct stat {
 									      \
 	asm volatile (                                                        \
 		"syscall\n"                                                   \
-		: "=a" (_ret)                                                 \
+		: "=a"(_ret)                                                  \
 		: "r"(_arg1),                                                 \
 		  "0"(_num)                                                   \
-		: "rcx", "r8", "r9", "r10", "r11", "memory", "cc"             \
+		: "rcx", "r11", "memory", "cc"                                \
 	);                                                                    \
 	_ret;                                                                 \
 })
@@ -312,10 +317,10 @@ struct stat {
 									      \
 	asm volatile (                                                        \
 		"syscall\n"                                                   \
-		: "=a" (_ret)                                                 \
+		: "=a"(_ret)                                                  \
 		: "r"(_arg1), "r"(_arg2),                                     \
 		  "0"(_num)                                                   \
-		: "rcx", "r8", "r9", "r10", "r11", "memory", "cc"             \
+		: "rcx", "r11", "memory", "cc"                                \
 	);                                                                    \
 	_ret;                                                                 \
 })
@@ -330,10 +335,10 @@ struct stat {
 									      \
 	asm volatile (                                                        \
 		"syscall\n"                                                   \
-		: "=a" (_ret)                                                 \
+		: "=a"(_ret)                                                  \
 		: "r"(_arg1), "r"(_arg2), "r"(_arg3),                         \
 		  "0"(_num)                                                   \
-		: "rcx", "r8", "r9", "r10", "r11", "memory", "cc"             \
+		: "rcx", "r11", "memory", "cc"                                \
 	);                                                                    \
 	_ret;                                                                 \
 })
@@ -349,10 +354,10 @@ struct stat {
 									      \
 	asm volatile (                                                        \
 		"syscall\n"                                                   \
-		: "=a" (_ret), "=r"(_arg4)                                    \
+		: "=a"(_ret)                                                  \
 		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4),             \
 		  "0"(_num)                                                   \
-		: "rcx", "r8", "r9", "r11", "memory", "cc"                    \
+		: "rcx", "r11", "memory", "cc"                                \
 	);                                                                    \
 	_ret;                                                                 \
 })
@@ -369,10 +374,10 @@ struct stat {
 									      \
 	asm volatile (                                                        \
 		"syscall\n"                                                   \
-		: "=a" (_ret), "=r"(_arg4), "=r"(_arg5)                       \
+		: "=a"(_ret)                                                  \
 		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), \
 		  "0"(_num)                                                   \
-		: "rcx", "r9", "r11", "memory", "cc"                          \
+		: "rcx", "r11", "memory", "cc"                                \
 	);                                                                    \
 	_ret;                                                                 \
 })
@@ -390,7 +395,7 @@ struct stat {
 									      \
 	asm volatile (                                                        \
 		"syscall\n"                                                   \
-		: "=a" (_ret), "=r"(_arg4), "=r"(_arg5)                       \
+		: "=a"(_ret)                                                  \
 		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), \
 		  "r"(_arg6), "0"(_num)                                       \
 		: "rcx", "r11", "memory", "cc"                                \
-- 
2.31.1.189.g2e36527f23

