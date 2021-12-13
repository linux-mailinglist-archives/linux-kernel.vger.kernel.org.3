Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEACC4728D5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240706AbhLMKPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241531AbhLMKEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 05:04:48 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3D7C0A552F;
        Mon, 13 Dec 2021 01:50:25 -0800 (PST)
Date:   Mon, 13 Dec 2021 09:50:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639389022;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PuQOZrpLHlzZdDyicO0I+AGaAInkEzSF0mLDgy578xE=;
        b=HtSJtTpoAl8kZ29PyDdPlN2k9y7BmdALWNS+cWJAnA4wQXmrPwSeEdyJsYfQvNps/3i7Hg
        x/G20tnwoRLRIExdW8KE1Ezk5bPAw5Hn1BiYnoOYwigyXvdOVQSXCADHwwf8NdjG6lJJte
        DOFAe+yGjAidUTXWQBlIwz5k4rihtbD1j9NbM7SEuVyyk1Si/5/01WrOcdgymkIfhBVloH
        6ol1aGtfbreYwE/SDgoSVnFa6sbjsDg+dugPzoxyR1+7u/0T959aYvz1KQF6ebwmCKMPUO
        MKouOum5TMF1vmKQJOqikp8ZlUDw+hT38snFIVkDW5VQAkZTeDZ+8kXgQzROaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639389022;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PuQOZrpLHlzZdDyicO0I+AGaAInkEzSF0mLDgy578xE=;
        b=h+P8y92WIFmWuioGe4gpEQT8yH4Qe31/9C0OZYxMfFWhmJIJWtZ/jyYfLtUNw4xma9o/Px
        G19iUKhwmFPWOpDQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/entry_64: Remove .fixup usage
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@suse.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211110101325.186049322@infradead.org>
References: <20211110101325.186049322@infradead.org>
MIME-Version: 1.0
Message-ID: <163938902200.23020.11160955191812398203.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     16e617d05ef0c521d000c989796412ce713f28c9
Gitweb:        https://git.kernel.org/tip/16e617d05ef0c521d000c989796412ce713f28c9
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 10 Nov 2021 11:01:07 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 11 Dec 2021 09:09:46 +01:00

x86/entry_64: Remove .fixup usage

Place the anonymous .fixup code at the tail of the regular functions.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>
Link: https://lore.kernel.org/r/20211110101325.186049322@infradead.org
---
 arch/x86/entry/entry_64.S | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index e23319a..1ffdbfa 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -739,13 +739,9 @@ SYM_FUNC_START(asm_load_gs_index)
 	swapgs
 	FRAME_END
 	RET
-SYM_FUNC_END(asm_load_gs_index)
-EXPORT_SYMBOL(asm_load_gs_index)
 
-	_ASM_EXTABLE(.Lgs_change, .Lbad_gs)
-	.section .fixup, "ax"
 	/* running with kernelgs */
-SYM_CODE_START_LOCAL_NOALIGN(.Lbad_gs)
+.Lbad_gs:
 	swapgs					/* switch back to user gs */
 .macro ZAP_GS
 	/* This can't be a string because the preprocessor needs to see it. */
@@ -756,8 +752,11 @@ SYM_CODE_START_LOCAL_NOALIGN(.Lbad_gs)
 	xorl	%eax, %eax
 	movl	%eax, %gs
 	jmp	2b
-SYM_CODE_END(.Lbad_gs)
-	.previous
+
+	_ASM_EXTABLE(.Lgs_change, .Lbad_gs)
+
+SYM_FUNC_END(asm_load_gs_index)
+EXPORT_SYMBOL(asm_load_gs_index)
 
 #ifdef CONFIG_XEN_PV
 /*
