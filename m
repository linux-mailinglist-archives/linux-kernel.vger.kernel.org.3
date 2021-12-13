Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C924728D8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240966AbhLMKPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241499AbhLMKEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 05:04:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3474C025487;
        Mon, 13 Dec 2021 01:50:22 -0800 (PST)
Date:   Mon, 13 Dec 2021 09:50:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639389019;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ALNQ/0frXhttsfvI6csGlaqEO6DgbF/XxWuZelGN2MA=;
        b=FILQDjPXWqux7v8W6QSOP+YmkwNW/6Y2YkN8UAU88UsoqtlitYJ+9o6Q6yp0T6KSLNXWg5
        I1Ps4wYn4F6pw2kVomFCwp92e+S0XxsOchxtyWOLPqsovI+kMG5AMdcMi6YOx9ofGK+p4r
        vXUJesPPSqzEm7O1MVJKpCAafUV072F9RwR/ukGHPRwOZDHJdw2ilX240YKvgV11+BB+Hk
        elfqDPcNhH8cTgZO0k7W5oHvi/sWHQmXHRFbOCQc9xFwr3/S9fSdtiocZRaBmuhv+/kv7u
        5by/ys1wFe5nG1mxmD/b1fc7ApN/ueyBBsqaoVdm9iKzMNK7FLhnRMN5Qkm0pg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639389019;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ALNQ/0frXhttsfvI6csGlaqEO6DgbF/XxWuZelGN2MA=;
        b=LOj1A8XyEAo6essPisuPa0E34JTjX9tiTgWjYGC3W8qAxi/lPEHc5I/t3HO0nUemn1cPmH
        2fmcMrXgVHPNHKAQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/futex: Remove .fixup usage
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211110101325.426016322@infradead.org>
References: <20211110101325.426016322@infradead.org>
MIME-Version: 1.0
Message-ID: <163938901896.23020.16781762374728391736.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     4c132d1d844a53fc4e4b5c34e36ef10d6124b783
Gitweb:        https://git.kernel.org/tip/4c132d1d844a53fc4e4b5c34e36ef10d6124b783
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 10 Nov 2021 11:01:11 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 11 Dec 2021 09:09:47 +01:00

x86/futex: Remove .fixup usage

Use the new EX_TYPE_IMM_REG to store -EFAULT into the designated 'ret'
register, this removes the need for anonymous .fixup code.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20211110101325.426016322@infradead.org
---
 arch/x86/include/asm/extable_fixup_types.h |  2 ++-
 arch/x86/include/asm/futex.h               | 28 ++++++---------------
 2 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/extable_fixup_types.h b/arch/x86/include/asm/extable_fixup_types.h
index 9d597fe..7469038 100644
--- a/arch/x86/include/asm/extable_fixup_types.h
+++ b/arch/x86/include/asm/extable_fixup_types.h
@@ -42,6 +42,8 @@
 #define	EX_TYPE_DEFAULT_MCE_SAFE	14
 #define	EX_TYPE_FAULT_MCE_SAFE		15
 #define	EX_TYPE_POP_ZERO		16
+
 #define	EX_TYPE_IMM_REG			17 /* reg := (long)imm */
+#define	EX_TYPE_EFAULT_REG		(EX_TYPE_IMM_REG | EX_DATA_IMM(-EFAULT))
 
 #endif
diff --git a/arch/x86/include/asm/futex.h b/arch/x86/include/asm/futex.h
index f9c0011..99d345b 100644
--- a/arch/x86/include/asm/futex.h
+++ b/arch/x86/include/asm/futex.h
@@ -17,13 +17,9 @@ do {								\
 	int oldval = 0, ret;					\
 	asm volatile("1:\t" insn "\n"				\
 		     "2:\n"					\
-		     "\t.section .fixup,\"ax\"\n"		\
-		     "3:\tmov\t%3, %1\n"			\
-		     "\tjmp\t2b\n"				\
-		     "\t.previous\n"				\
-		     _ASM_EXTABLE_UA(1b, 3b)			\
+		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG, %1) \
 		     : "=r" (oldval), "=r" (ret), "+m" (*uaddr)	\
-		     : "i" (-EFAULT), "0" (oparg), "1" (0));	\
+		     : "0" (oparg), "1" (0));	\
 	if (ret)						\
 		goto label;					\
 	*oval = oldval;						\
@@ -39,15 +35,11 @@ do {								\
 		     "3:\t" LOCK_PREFIX "cmpxchgl %3, %2\n"	\
 		     "\tjnz\t2b\n"				\
 		     "4:\n"					\
-		     "\t.section .fixup,\"ax\"\n"		\
-		     "5:\tmov\t%5, %1\n"			\
-		     "\tjmp\t4b\n"				\
-		     "\t.previous\n"				\
-		     _ASM_EXTABLE_UA(1b, 5b)			\
-		     _ASM_EXTABLE_UA(3b, 5b)			\
+		     _ASM_EXTABLE_TYPE_REG(1b, 4b, EX_TYPE_EFAULT_REG, %1) \
+		     _ASM_EXTABLE_TYPE_REG(3b, 4b, EX_TYPE_EFAULT_REG, %1) \
 		     : "=&a" (oldval), "=&r" (ret),		\
 		       "+m" (*uaddr), "=&r" (tem)		\
-		     : "r" (oparg), "i" (-EFAULT), "1" (0));	\
+		     : "r" (oparg), "1" (0));			\
 	if (ret)						\
 		goto label;					\
 	*oval = oldval;						\
@@ -95,15 +87,11 @@ static inline int futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 	if (!user_access_begin(uaddr, sizeof(u32)))
 		return -EFAULT;
 	asm volatile("\n"
-		"1:\t" LOCK_PREFIX "cmpxchgl %4, %2\n"
+		"1:\t" LOCK_PREFIX "cmpxchgl %3, %2\n"
 		"2:\n"
-		"\t.section .fixup, \"ax\"\n"
-		"3:\tmov     %3, %0\n"
-		"\tjmp     2b\n"
-		"\t.previous\n"
-		_ASM_EXTABLE_UA(1b, 3b)
+		_ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG, %0) \
 		: "+r" (ret), "=a" (oldval), "+m" (*uaddr)
-		: "i" (-EFAULT), "r" (newval), "1" (oldval)
+		: "r" (newval), "1" (oldval)
 		: "memory"
 	);
 	user_access_end();
