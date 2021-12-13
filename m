Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D37D4728D9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239503AbhLMKP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241446AbhLMKEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 05:04:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AE0C09CE63;
        Mon, 13 Dec 2021 01:50:18 -0800 (PST)
Date:   Mon, 13 Dec 2021 09:50:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639389017;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TejmWI27ftDL72J54rxEn40sSoogJ85YsDcBKLRCtl8=;
        b=F1jssB9BorpTDGtCoAoML0+GH9ceqJzX5WviGigGraKXIzQ3bfqx9iKq31GpVm6qCpHD46
        v/mmkPKDoH6i9FgZuXUTEbwNY7/M1RUn0l1XHgG85vqVTAw8CIwQFViX73HK75E1zOmAOm
        elmJCyy0ecQ7kOh7GK8tMVbR3Bx3zK0OzmyCtUsZCB0CQUcOZypr+Qapsn6SGFaBbhgjQ3
        yU8Q2ZQXToV/dXqrKFTfBhz4GQNHO8P0Ldwonf7KcI+//mBZEEnTzUPUFwQWJxiuQwyiAI
        I0I4JEEHdLhWFB4BJnRDUkIbn4EF2EQAQn8oKx9+54n9PW1BO/w6WEHqzMyY7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639389017;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TejmWI27ftDL72J54rxEn40sSoogJ85YsDcBKLRCtl8=;
        b=4SpD2hwKunfX8QlRlIQNB4jprQ9IpBYjtiU0n+a/WgbgRv5OYzmKh67sh6NbE2PqkcqSVF
        +eeqDMnn7U2uQbAQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/fpu: Remove .fixup usage
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211110101325.604494664@infradead.org>
References: <20211110101325.604494664@infradead.org>
MIME-Version: 1.0
Message-ID: <163938901656.23020.17012305903531393136.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     1c3b9091d084d92c70a4260553853509637276b9
Gitweb:        https://git.kernel.org/tip/1c3b9091d084d92c70a4260553853509637276b9
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 10 Nov 2021 11:01:14 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 11 Dec 2021 09:09:48 +01:00

x86/fpu: Remove .fixup usage

Employ EX_TYPE_EFAULT_REG to store '-EFAULT' into the %[err] register
on exception. All the callers only ever test for 0, so the change
from -1 to -EFAULT is immaterial.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20211110101325.604494664@infradead.org
---
 arch/x86/kernel/fpu/legacy.h | 6 +-----
 arch/x86/kernel/fpu/xstate.h | 6 +-----
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/fpu/legacy.h b/arch/x86/kernel/fpu/legacy.h
index 17c26b1..098f367 100644
--- a/arch/x86/kernel/fpu/legacy.h
+++ b/arch/x86/kernel/fpu/legacy.h
@@ -35,11 +35,7 @@ static inline void ldmxcsr(u32 mxcsr)
 	int err;							\
 	asm volatile("1:" #insn "\n\t"					\
 		     "2:\n"						\
-		     ".section .fixup,\"ax\"\n"				\
-		     "3:  movl $-1,%[err]\n"				\
-		     "    jmp  2b\n"					\
-		     ".previous\n"					\
-		     _ASM_EXTABLE(1b, 3b)				\
+		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG, %[err]) \
 		     : [err] "=r" (err), output				\
 		     : "0"(0), input);					\
 	err;								\
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index 86ea7c0..e0c9264 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -108,11 +108,7 @@ static inline u64 xfeatures_mask_independent(void)
 		     "\n"						\
 		     "xor %[err], %[err]\n"				\
 		     "3:\n"						\
-		     ".pushsection .fixup,\"ax\"\n"			\
-		     "4: movl $-2, %[err]\n"				\
-		     "jmp 3b\n"						\
-		     ".popsection\n"					\
-		     _ASM_EXTABLE(661b, 4b)				\
+		     _ASM_EXTABLE_TYPE_REG(661b, 3b, EX_TYPE_EFAULT_REG, %[err]) \
 		     : [err] "=r" (err)					\
 		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
 		     : "memory")
