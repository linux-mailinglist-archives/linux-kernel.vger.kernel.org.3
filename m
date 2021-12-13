Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBE2F4728D6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240741AbhLMKPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241533AbhLMKEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 05:04:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CC2C021996;
        Mon, 13 Dec 2021 01:50:25 -0800 (PST)
Date:   Mon, 13 Dec 2021 09:50:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639389023;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=quSjqagO+d0Q/H3sd1z5d1VQoAI3YiPh/q3sm/MZPl4=;
        b=Bqj4VVXuarHl3KNHC2NDEmor4zeSiIPZ2DIIONXpUBps1B6xVrTZ/xPlCdM8ItGgskG6m6
        GN7ROcHlW31AaTHSFn5PbMoE9B/r6fBHiZQhWwnaFRYKkxxjhK6RRZYUUZNJUA+mUlM6cT
        MXeIxyeNtJ42KJWG67bIFH0oaMt3ouyKfoaOJqp65oHNwW8BMyWFaI7PEVJ5J1y6ugoE0F
        /uP/5+0xVWdCfi+W4YvyhpHyWq1xRUmiAc9UfOPHy8TZ2mV6ppanV1eWBSp5BQFYT9vr7I
        yeBygODLG64z50rdW1c3QoC0t7jfRwxoSqK0IX6QSJmHFX1Fcvr5pKhOgXyi5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639389023;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=quSjqagO+d0Q/H3sd1z5d1VQoAI3YiPh/q3sm/MZPl4=;
        b=THttYlsChfBUepOFGeIxFXjz6XYM9rQrr/Alg35nQ/YOJH7inlCLYy1F2NpsK/nvJRNfkP
        DIWGmoH65Ypx51BA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/copy_mc_64: Remove .fixup usage
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211110101325.127055887@infradead.org>
References: <20211110101325.127055887@infradead.org>
MIME-Version: 1.0
Message-ID: <163938902273.23020.14400054755238776615.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     ab0fedcc714aafaac6ac996b51791aee0d1cd8fd
Gitweb:        https://git.kernel.org/tip/ab0fedcc714aafaac6ac996b51791aee0d1cd8fd
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 10 Nov 2021 11:01:06 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 11 Dec 2021 09:09:46 +01:00

x86/copy_mc_64: Remove .fixup usage

Place the anonymous .fixup code at the tail of the regular functions.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20211110101325.127055887@infradead.org
---
 arch/x86/lib/copy_mc_64.S | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/x86/lib/copy_mc_64.S b/arch/x86/lib/copy_mc_64.S
index 2300979..c859a8a 100644
--- a/arch/x86/lib/copy_mc_64.S
+++ b/arch/x86/lib/copy_mc_64.S
@@ -78,9 +78,7 @@ SYM_FUNC_START(copy_mc_fragile)
 	xorl %eax, %eax
 .L_done:
 	RET
-SYM_FUNC_END(copy_mc_fragile)
 
-	.section .fixup, "ax"
 	/*
 	 * Return number of bytes not copied for any failure. Note that
 	 * there is no "tail" handling since the source buffer is 8-byte
@@ -105,14 +103,14 @@ SYM_FUNC_END(copy_mc_fragile)
 	movl	%ecx, %edx
 	jmp copy_mc_fragile_handle_tail
 
-	.previous
-
 	_ASM_EXTABLE_TYPE(.L_read_leading_bytes, .E_leading_bytes, EX_TYPE_DEFAULT_MCE_SAFE)
 	_ASM_EXTABLE_TYPE(.L_read_words, .E_read_words, EX_TYPE_DEFAULT_MCE_SAFE)
 	_ASM_EXTABLE_TYPE(.L_read_trailing_bytes, .E_trailing_bytes, EX_TYPE_DEFAULT_MCE_SAFE)
 	_ASM_EXTABLE(.L_write_leading_bytes, .E_leading_bytes)
 	_ASM_EXTABLE(.L_write_words, .E_write_words)
 	_ASM_EXTABLE(.L_write_trailing_bytes, .E_trailing_bytes)
+
+SYM_FUNC_END(copy_mc_fragile)
 #endif /* CONFIG_X86_MCE */
 
 /*
@@ -133,9 +131,7 @@ SYM_FUNC_START(copy_mc_enhanced_fast_string)
 	/* Copy successful. Return zero */
 	xorl %eax, %eax
 	RET
-SYM_FUNC_END(copy_mc_enhanced_fast_string)
 
-	.section .fixup, "ax"
 .E_copy:
 	/*
 	 * On fault %rcx is updated such that the copy instruction could
@@ -147,7 +143,7 @@ SYM_FUNC_END(copy_mc_enhanced_fast_string)
 	movq %rcx, %rax
 	RET
 
-	.previous
-
 	_ASM_EXTABLE_TYPE(.L_copy, .E_copy, EX_TYPE_DEFAULT_MCE_SAFE)
+
+SYM_FUNC_END(copy_mc_enhanced_fast_string)
 #endif /* !CONFIG_UML */
