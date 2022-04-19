Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36E4507ACD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 22:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357601AbiDSULv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 16:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357120AbiDSUL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 16:11:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2066D3BF81;
        Tue, 19 Apr 2022 13:08:41 -0700 (PDT)
Date:   Tue, 19 Apr 2022 20:08:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650398919;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8l7reSWjkYXMhIWsUQJFyIZ1inBA/aa7459JhwsivbA=;
        b=xkafwJnCxELjwjqbRJmg9QC1kwhMVRnAlYwqyjoYX9OmjDUeVsXhgfns3AI+7MAMLAqDg5
        TmdVWYM0EmdosP02KSNt3QNGzYil4vaZ4C0xbvGwfn6P/boiCgEqAIT6lMEd2SjyE3Udt6
        6GmAYXuY5UWCotxxZ7ROunf7ozC/JYSnVyMxojV8EZhOdjKPDKiRo38CymMoWEeJ1sw3qS
        t5RQhFtgzret5DEhMbibmZ3RZyFJ03Xiqt1aqg8tRiD/OkfYiZCBAHngUOuKCstffAxYNv
        d5jBbz7jb0+cCE0Y6dn46urME2HFNo8zDBJyfXxkrEPu6tBPEXHTvtM3fTHC1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650398919;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8l7reSWjkYXMhIWsUQJFyIZ1inBA/aa7459JhwsivbA=;
        b=bPj4zu2ZE8UMBRycrWk2oeLvnxBX3BiFZ7OSFYAy/PwIQDaNU5a3wOTO2DxgAif5UBbr4i
        rrksebYDGMld1oBQ==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/retpoline: Add ANNOTATE_NOENDBR for retpolines
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <b6ec963dfd9301b6b1d74ef7758fcb0b540d6c6c.1650300597.git.jpoimboe@redhat.com>
References: <b6ec963dfd9301b6b1d74ef7758fcb0b540d6c6c.1650300597.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <165039891874.4207.2931765503619062389.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     1c0513dec41e4d40eb21402dff397ad84ca13a44
Gitweb:        https://git.kernel.org/tip/1c0513dec41e4d40eb21402dff397ad84ca13a44
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Mon, 18 Apr 2022 09:50:23 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 19 Apr 2022 21:58:49 +02:00

x86/retpoline: Add ANNOTATE_NOENDBR for retpolines

The retpolines are exported, so they're referenced by ksymtab sections.
But they're never indirect-branched to, so add ANNOTATE_NOENDBR.

Fixes: ed53a0d97192 ("x86/alternative: Use .ibt_endbr_seal to seal indirect calls")
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/b6ec963dfd9301b6b1d74ef7758fcb0b540d6c6c.1650300597.git.jpoimboe@redhat.com
---
 arch/x86/lib/retpoline.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 5f87bab..b2b2366 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -31,6 +31,7 @@
 	.align RETPOLINE_THUNK_SIZE
 SYM_INNER_LABEL(__x86_indirect_thunk_\reg, SYM_L_GLOBAL)
 	UNWIND_HINT_EMPTY
+	ANNOTATE_NOENDBR
 
 	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), \
 		      __stringify(RETPOLINE \reg), X86_FEATURE_RETPOLINE, \
@@ -55,7 +56,6 @@ SYM_INNER_LABEL(__x86_indirect_thunk_\reg, SYM_L_GLOBAL)
 
 	.align RETPOLINE_THUNK_SIZE
 SYM_CODE_START(__x86_indirect_thunk_array)
-	ANNOTATE_NOENDBR // apply_retpolines
 
 #define GEN(reg) THUNK reg
 #include <asm/GEN-for-each-reg.h>
