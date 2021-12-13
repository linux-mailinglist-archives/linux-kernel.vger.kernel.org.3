Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 787CC4728DD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241319AbhLMKPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239681AbhLMKE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 05:04:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E6CC08E842;
        Mon, 13 Dec 2021 01:50:12 -0800 (PST)
Date:   Mon, 13 Dec 2021 09:50:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639389010;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6UnHO4ITwWk7782R+Nwfh0cQlSe5N9kk42AaTaPRerk=;
        b=1YcBIhzilFvR+2zlOC4s/FxD+hMB9pCy9cYKVBF/QYSMLfGScLmsPd1SR3emZ4wzPMi1WA
        c6uj+3DTU3DTYuMxvc5FQ06xMrYgk9Ch5mYSXmBoN7iswK8VsE00CUQIY0nv9MEPKFgT3c
        z44djtZXml4leta2P81nP995gx5FU/YFYt/Hgaz+Tp/zmZrqd5zEqSbKMAIlJ0ol0ZuMey
        0PtKg4kwzYa+D5H39gxvpsKC5UaiEi8kFXVg0uBFasSQka5jpVcTvRjYXnCafBUfLnlYcP
        FfBnpShpnUGEShE+p82EsUS9u3lQ4HUP2l/siGI4qfd5JvtJjoRD6ub5ipBjag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639389010;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6UnHO4ITwWk7782R+Nwfh0cQlSe5N9kk42AaTaPRerk=;
        b=/YAnuK/1PWzg0l7xH+FtAVO7pmJxpHZI+1c4Z053zwGDiVyEFIxqKtQITbN0AGIxgdf1VY
        KV96HsptgYqXUUAw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/word-at-a-time: Remove .fixup usage
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211110101326.141775772@infradead.org>
References: <20211110101326.141775772@infradead.org>
MIME-Version: 1.0
Message-ID: <163938900955.23020.14868045137660023155.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     b7760780257354bb14de62abed868405b844fa13
Gitweb:        https://git.kernel.org/tip/b7760780257354bb14de62abed868405b844fa13
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 10 Nov 2021 11:01:23 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 11 Dec 2021 09:09:50 +01:00

x86/word-at-a-time: Remove .fixup usage

Rewrite load_unaligned_zeropad() to not require .fixup text.

This is easiest done using asm-goto-output, where we can stick a C
label in the exception table entry. The fallback version isn't nearly
so nice but should work.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20211110101326.141775772@infradead.org
---
 arch/x86/include/asm/word-at-a-time.h | 66 ++++++++++++++++++--------
 1 file changed, 47 insertions(+), 19 deletions(-)

diff --git a/arch/x86/include/asm/word-at-a-time.h b/arch/x86/include/asm/word-at-a-time.h
index 06006b0..8338b04 100644
--- a/arch/x86/include/asm/word-at-a-time.h
+++ b/arch/x86/include/asm/word-at-a-time.h
@@ -77,30 +77,58 @@ static inline unsigned long find_zero(unsigned long mask)
  * and the next page not being mapped, take the exception and
  * return zeroes in the non-existing part.
  */
+#ifdef CONFIG_CC_HAS_ASM_GOTO_OUTPUT
+
 static inline unsigned long load_unaligned_zeropad(const void *addr)
 {
-	unsigned long ret, dummy;
+	unsigned long offset, data;
+	unsigned long ret;
+
+	asm_volatile_goto(
+		"1:	mov %[mem], %[ret]\n"
+
+		_ASM_EXTABLE(1b, %l[do_exception])
+
+		: [ret] "=r" (ret)
+		: [mem] "m" (*(unsigned long *)addr)
+		: : do_exception);
+
+	return ret;
+
+do_exception:
+	offset = (unsigned long)addr & (sizeof(long) - 1);
+	addr = (void *)((unsigned long)addr & ~(sizeof(long) - 1));
+	data = *(unsigned long *)addr;
+	ret = data >> offset * 8;
+
+	return ret;
+}
 
-	asm(
-		"1:\tmov %2,%0\n"
+#else /* !CONFIG_CC_HAS_ASM_GOTO_OUTPUT */
+
+static inline unsigned long load_unaligned_zeropad(const void *addr)
+{
+	unsigned long offset, data;
+	unsigned long ret, err = 0;
+
+	asm(	"1:	mov %[mem], %[ret]\n"
 		"2:\n"
-		".section .fixup,\"ax\"\n"
-		"3:\t"
-		"lea %2,%1\n\t"
-		"and %3,%1\n\t"
-		"mov (%1),%0\n\t"
-		"leal %2,%%ecx\n\t"
-		"andl %4,%%ecx\n\t"
-		"shll $3,%%ecx\n\t"
-		"shr %%cl,%0\n\t"
-		"jmp 2b\n"
-		".previous\n"
-		_ASM_EXTABLE(1b, 3b)
-		:"=&r" (ret),"=&c" (dummy)
-		:"m" (*(unsigned long *)addr),
-		 "i" (-sizeof(unsigned long)),
-		 "i" (sizeof(unsigned long)-1));
+
+		_ASM_EXTABLE_FAULT(1b, 2b)
+
+		: [ret] "=&r" (ret), "+a" (err)
+		: [mem] "m" (*(unsigned long *)addr));
+
+	if (unlikely(err)) {
+		offset = (unsigned long)addr & (sizeof(long) - 1);
+		addr = (void *)((unsigned long)addr & ~(sizeof(long) - 1));
+		data = *(unsigned long *)addr;
+		ret = data >> offset * 8;
+	}
+
 	return ret;
 }
 
+#endif /* CONFIG_CC_HAS_ASM_GOTO_OUTPUT */
+
 #endif /* _ASM_WORD_AT_A_TIME_H */
