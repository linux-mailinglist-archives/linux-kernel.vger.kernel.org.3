Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348594A8693
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351484AbiBCOe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:34:58 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53664 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351362AbiBCOds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:33:48 -0500
Date:   Thu, 03 Feb 2022 14:33:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643898827;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R44uwkv7g4zfdo4eZg6/5vut+o9kvuWC0I6fZ0LM2bw=;
        b=rleyOzZfiv1+7X7edaMydvCXq1Wb4aYAydBKhTwIKiOH3KXH+QuVAvrFQFAY7zlqAGYxBi
        XPoLuDG4zXRrfg+rG05FBmRDneXnV77C85f6WrdwHR/d21r5JC4ziNMJUcBeWrg3xKW7Ht
        BXahzS62FqOonkVz/xPOVUnUfWP6DQWr5GCTKBfFcDbfIQPPY+Wry0ITU9HrKQfLa49QCC
        KBB0qPXT/cTDoYf/XurNKBzH0Bwc6THCu9NnNRt7jlVhZt0FzA5bJwimbFmFaTJMlos2kq
        iDL9WSf9mK5L/WkzzU3dsDK5eYJXYYeXsAyJb4Dz9gAB0toPRrUS2frzk6d1MA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643898827;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R44uwkv7g4zfdo4eZg6/5vut+o9kvuWC0I6fZ0LM2bw=;
        b=c+xF8oqhQRTj9H6+c7W9mOE8kra3B6Vnv8Ycy7waPe+6G0YKXQSRIzSdjk0a6UiLxy+9gR
        dzusQfh/xsevblDQ==
From:   "tip-bot2 for Mathieu Desnoyers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] selftests/rseq: Fix ppc32 missing instruction
 selection "u" and "x" for load/store
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220124171253.22072-10-mathieu.desnoyers@efficios.com>
References: <20220124171253.22072-10-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Message-ID: <164389882630.16921.3992027943592142683.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     de6b52a21420a18dc8a36438d581efd1313d5fe3
Gitweb:        https://git.kernel.org/tip/de6b52a21420a18dc8a36438d581efd1313d5fe3
Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate:    Mon, 24 Jan 2022 12:12:47 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 02 Feb 2022 13:11:36 +01:00

selftests/rseq: Fix ppc32 missing instruction selection "u" and "x" for load/store

Building the rseq basic test  with
gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.12)
Target: powerpc-linux-gnu

leads to these errors:

/tmp/ccieEWxU.s: Assembler messages:
/tmp/ccieEWxU.s:118: Error: syntax error; found `,', expected `('
/tmp/ccieEWxU.s:118: Error: junk at end of line: `,8'
/tmp/ccieEWxU.s:121: Error: syntax error; found `,', expected `('
/tmp/ccieEWxU.s:121: Error: junk at end of line: `,8'
/tmp/ccieEWxU.s:626: Error: syntax error; found `,', expected `('
/tmp/ccieEWxU.s:626: Error: junk at end of line: `,8'
/tmp/ccieEWxU.s:629: Error: syntax error; found `,', expected `('
/tmp/ccieEWxU.s:629: Error: junk at end of line: `,8'
/tmp/ccieEWxU.s:735: Error: syntax error; found `,', expected `('
/tmp/ccieEWxU.s:735: Error: junk at end of line: `,8'
/tmp/ccieEWxU.s:738: Error: syntax error; found `,', expected `('
/tmp/ccieEWxU.s:738: Error: junk at end of line: `,8'
/tmp/ccieEWxU.s:741: Error: syntax error; found `,', expected `('
/tmp/ccieEWxU.s:741: Error: junk at end of line: `,8'
Makefile:581: recipe for target 'basic_percpu_ops_test.o' failed

Based on discussion with Linux powerpc maintainers and review of
the use of the "m" operand in powerpc kernel code, add the missing
%Un%Xn (where n is operand number) to the lwz, stw, ld, and std
instructions when used with "m" operands.

Using "WORD" to mean either a 32-bit or 64-bit type depending on
the architecture is misleading. The term "WORD" really means a
32-bit type in both 32-bit and 64-bit powerpc assembler. The intent
here is to wrap load/store to intptr_t into common macros for both
32-bit and 64-bit.

Rename the macros with a RSEQ_ prefix, and use the terms "INT"
for always 32-bit type, and "LONG" for architecture bitness-sized
type.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220124171253.22072-10-mathieu.desnoyers@efficios.com
---
 tools/testing/selftests/rseq/rseq-ppc.h | 55 ++++++++++++------------
 1 file changed, 28 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/rseq/rseq-ppc.h b/tools/testing/selftests/rseq/rseq-ppc.h
index c4ba137..87befda 100644
--- a/tools/testing/selftests/rseq/rseq-ppc.h
+++ b/tools/testing/selftests/rseq/rseq-ppc.h
@@ -47,10 +47,13 @@ do {									\
 
 #ifdef __PPC64__
 
-#define STORE_WORD	"std "
-#define LOAD_WORD	"ld "
-#define LOADX_WORD	"ldx "
-#define CMP_WORD	"cmpd "
+#define RSEQ_STORE_LONG(arg)	"std%U[" __rseq_str(arg) "]%X[" __rseq_str(arg) "] "	/* To memory ("m" constraint) */
+#define RSEQ_STORE_INT(arg)	"stw%U[" __rseq_str(arg) "]%X[" __rseq_str(arg) "] "	/* To memory ("m" constraint) */
+#define RSEQ_LOAD_LONG(arg)	"ld%U[" __rseq_str(arg) "]%X[" __rseq_str(arg) "] "	/* From memory ("m" constraint) */
+#define RSEQ_LOAD_INT(arg)	"lwz%U[" __rseq_str(arg) "]%X[" __rseq_str(arg) "] "	/* From memory ("m" constraint) */
+#define RSEQ_LOADX_LONG		"ldx "							/* From base register ("b" constraint) */
+#define RSEQ_CMP_LONG		"cmpd "
+#define RSEQ_CMP_LONG_INT	"cmpdi "
 
 #define __RSEQ_ASM_DEFINE_TABLE(label, version, flags,				\
 			start_ip, post_commit_offset, abort_ip)			\
@@ -89,10 +92,13 @@ do {									\
 
 #else /* #ifdef __PPC64__ */
 
-#define STORE_WORD	"stw "
-#define LOAD_WORD	"lwz "
-#define LOADX_WORD	"lwzx "
-#define CMP_WORD	"cmpw "
+#define RSEQ_STORE_LONG(arg)	"stw%U[" __rseq_str(arg) "]%X[" __rseq_str(arg) "] "	/* To memory ("m" constraint) */
+#define RSEQ_STORE_INT(arg)	RSEQ_STORE_LONG(arg)					/* To memory ("m" constraint) */
+#define RSEQ_LOAD_LONG(arg)	"lwz%U[" __rseq_str(arg) "]%X[" __rseq_str(arg) "] "	/* From memory ("m" constraint) */
+#define RSEQ_LOAD_INT(arg)	RSEQ_LOAD_LONG(arg)					/* From memory ("m" constraint) */
+#define RSEQ_LOADX_LONG		"lwzx "							/* From base register ("b" constraint) */
+#define RSEQ_CMP_LONG		"cmpw "
+#define RSEQ_CMP_LONG_INT	"cmpwi "
 
 #define __RSEQ_ASM_DEFINE_TABLE(label, version, flags,				\
 			start_ip, post_commit_offset, abort_ip)			\
@@ -125,7 +131,7 @@ do {									\
 		RSEQ_INJECT_ASM(1)						\
 		"lis %%r17, (" __rseq_str(cs_label) ")@ha\n\t"			\
 		"addi %%r17, %%r17, (" __rseq_str(cs_label) ")@l\n\t"		\
-		"stw %%r17, %[" __rseq_str(rseq_cs) "]\n\t"			\
+		RSEQ_STORE_INT(rseq_cs) "%%r17, %[" __rseq_str(rseq_cs) "]\n\t"	\
 		__rseq_str(label) ":\n\t"
 
 #endif /* #ifdef __PPC64__ */
@@ -136,7 +142,7 @@ do {									\
 
 #define RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, label)			\
 		RSEQ_INJECT_ASM(2)						\
-		"lwz %%r17, %[" __rseq_str(current_cpu_id) "]\n\t"		\
+		RSEQ_LOAD_INT(current_cpu_id) "%%r17, %[" __rseq_str(current_cpu_id) "]\n\t" \
 		"cmpw cr7, %[" __rseq_str(cpu_id) "], %%r17\n\t"		\
 		"bne- cr7, " __rseq_str(label) "\n\t"
 
@@ -153,25 +159,25 @@ do {									\
  * 	RSEQ_ASM_OP_* (else): doesn't have hard-code registers(unless cr7)
  */
 #define RSEQ_ASM_OP_CMPEQ(var, expect, label)					\
-		LOAD_WORD "%%r17, %[" __rseq_str(var) "]\n\t"			\
-		CMP_WORD "cr7, %%r17, %[" __rseq_str(expect) "]\n\t"		\
+		RSEQ_LOAD_LONG(var) "%%r17, %[" __rseq_str(var) "]\n\t"		\
+		RSEQ_CMP_LONG "cr7, %%r17, %[" __rseq_str(expect) "]\n\t"		\
 		"bne- cr7, " __rseq_str(label) "\n\t"
 
 #define RSEQ_ASM_OP_CMPNE(var, expectnot, label)				\
-		LOAD_WORD "%%r17, %[" __rseq_str(var) "]\n\t"			\
-		CMP_WORD "cr7, %%r17, %[" __rseq_str(expectnot) "]\n\t"		\
+		RSEQ_LOAD_LONG(var) "%%r17, %[" __rseq_str(var) "]\n\t"		\
+		RSEQ_CMP_LONG "cr7, %%r17, %[" __rseq_str(expectnot) "]\n\t"		\
 		"beq- cr7, " __rseq_str(label) "\n\t"
 
 #define RSEQ_ASM_OP_STORE(value, var)						\
-		STORE_WORD "%[" __rseq_str(value) "], %[" __rseq_str(var) "]\n\t"
+		RSEQ_STORE_LONG(var) "%[" __rseq_str(value) "], %[" __rseq_str(var) "]\n\t"
 
 /* Load @var to r17 */
 #define RSEQ_ASM_OP_R_LOAD(var)							\
-		LOAD_WORD "%%r17, %[" __rseq_str(var) "]\n\t"
+		RSEQ_LOAD_LONG(var) "%%r17, %[" __rseq_str(var) "]\n\t"
 
 /* Store r17 to @var */
 #define RSEQ_ASM_OP_R_STORE(var)						\
-		STORE_WORD "%%r17, %[" __rseq_str(var) "]\n\t"
+		RSEQ_STORE_LONG(var) "%%r17, %[" __rseq_str(var) "]\n\t"
 
 /* Add @count to r17 */
 #define RSEQ_ASM_OP_R_ADD(count)						\
@@ -179,11 +185,11 @@ do {									\
 
 /* Load (r17 + voffp) to r17 */
 #define RSEQ_ASM_OP_R_LOADX(voffp)						\
-		LOADX_WORD "%%r17, %[" __rseq_str(voffp) "], %%r17\n\t"
+		RSEQ_LOADX_LONG "%%r17, %[" __rseq_str(voffp) "], %%r17\n\t"
 
 /* TODO: implement a faster memcpy. */
 #define RSEQ_ASM_OP_R_MEMCPY() \
-		"cmpdi %%r19, 0\n\t" \
+		RSEQ_CMP_LONG_INT "%%r19, 0\n\t" \
 		"beq 333f\n\t" \
 		"addi %%r20, %%r20, -1\n\t" \
 		"addi %%r21, %%r21, -1\n\t" \
@@ -191,16 +197,16 @@ do {									\
 		"lbzu %%r18, 1(%%r20)\n\t" \
 		"stbu %%r18, 1(%%r21)\n\t" \
 		"addi %%r19, %%r19, -1\n\t" \
-		"cmpdi %%r19, 0\n\t" \
+		RSEQ_CMP_LONG_INT "%%r19, 0\n\t" \
 		"bne 222b\n\t" \
 		"333:\n\t" \
 
 #define RSEQ_ASM_OP_R_FINAL_STORE(var, post_commit_label)			\
-		STORE_WORD "%%r17, %[" __rseq_str(var) "]\n\t"			\
+		RSEQ_STORE_LONG(var) "%%r17, %[" __rseq_str(var) "]\n\t"			\
 		__rseq_str(post_commit_label) ":\n\t"
 
 #define RSEQ_ASM_OP_FINAL_STORE(value, var, post_commit_label)			\
-		STORE_WORD "%[" __rseq_str(value) "], %[" __rseq_str(var) "]\n\t" \
+		RSEQ_STORE_LONG(var) "%[" __rseq_str(value) "], %[" __rseq_str(var) "]\n\t" \
 		__rseq_str(post_commit_label) ":\n\t"
 
 static inline __attribute__((always_inline))
@@ -743,9 +749,4 @@ error2:
 #endif
 }
 
-#undef STORE_WORD
-#undef LOAD_WORD
-#undef LOADX_WORD
-#undef CMP_WORD
-
 #endif /* !RSEQ_SKIP_FASTPATH */
