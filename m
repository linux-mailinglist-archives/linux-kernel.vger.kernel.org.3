Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B6D4F2BDC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 13:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354611AbiDEKOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 06:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241213AbiDEIcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:32:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6495217AA1;
        Tue,  5 Apr 2022 01:29:40 -0700 (PDT)
Date:   Tue, 05 Apr 2022 08:29:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649147379;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xf02MVHN4JR7VuJJrUFdSIQZRkwuZ0C8MK8iLKWLcQk=;
        b=IIn3vSJNaAs7G+1rR35chBNTwK5Uw3lmT3weRbX9ql7RW3fJpF5x/Mu41mvNaywrFod2fi
        g/huQLKZ0oKi+IX5ETZ/tZjTzgFD5Ugw0GCyaufaEYvuR2K0WqafWUegg3p3LlNw4EQv3t
        vf49Zqm7o98czxEGexiR/nxsmGLYs+nMs8nJsgOWtwLCCvRsaivbYGTtkepClDbEhTLT1W
        +HyPOYSRQLz3E7ej2dbjvoMtvT0d4VUDtgnzH2lt77vlldTSsGbN+r12IYStBX9027jJHF
        gx+kqQ4hIh9w13mcgemb5pRUYSsXE+5gE1f7S0s5qn/POpOY/rtUe62CBupjCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649147379;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xf02MVHN4JR7VuJJrUFdSIQZRkwuZ0C8MK8iLKWLcQk=;
        b=vQlsxWAg09eKYJSZLGOM+Z+mAKAtN6pDD+sf1WKGWzRS0mSznZQxyrT/pq0T36eUNLyfe7
        l1LxaayzHjTqEQCw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] objtool: Fix IBT tail-call detection
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220322115125.811582125@infradead.org>
References: <20220322115125.811582125@infradead.org>
MIME-Version: 1.0
Message-ID: <164914737798.389.68339904332129316.tip-bot2@tip-bot2>
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

Commit-ID:     d139bca4b824ffb9731763c31b271a24b595948a
Gitweb:        https://git.kernel.org/tip/d139bca4b824ffb9731763c31b271a24b595948a
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 22 Mar 2022 12:33:31 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Apr 2022 10:24:40 +02:00

objtool: Fix IBT tail-call detection

Objtool reports:

  arch/x86/crypto/poly1305-x86_64.o: warning: objtool: poly1305_blocks_avx() falls through to next function poly1305_blocks_x86_64()
  arch/x86/crypto/poly1305-x86_64.o: warning: objtool: poly1305_emit_avx() falls through to next function poly1305_emit_x86_64()
  arch/x86/crypto/poly1305-x86_64.o: warning: objtool: poly1305_blocks_avx2() falls through to next function poly1305_blocks_x86_64()

Which reads like:

0000000000000040 <poly1305_blocks_x86_64>:
	 40:       f3 0f 1e fa             endbr64
	...

0000000000000400 <poly1305_blocks_avx>:
	400:       f3 0f 1e fa             endbr64
	404:       44 8b 47 14             mov    0x14(%rdi),%r8d
	408:       48 81 fa 80 00 00 00    cmp    $0x80,%rdx
	40f:       73 09                   jae    41a <poly1305_blocks_avx+0x1a>
	411:       45 85 c0                test   %r8d,%r8d
	414:       0f 84 2a fc ff ff       je     44 <poly1305_blocks_x86_64+0x4>
	...

These are simple conditional tail-calls and *should* be recognised as
such by objtool, however due to a mistake in commit 08f87a93c8ec
("objtool: Validate IBT assumptions") this is failing.

Specifically, the jump_dest is +4, this means the instruction pointed
at will not be ENDBR and as such it will fail the second clause of
is_first_func_insn() that was supposed to capture this exact case.

Instead, have is_first_func_insn() look at the previous instruction.

Fixes: 08f87a93c8ec ("objtool: Validate IBT assumptions")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220322115125.811582125@infradead.org
---
 tools/objtool/check.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 6de5085..b848e1d 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1239,11 +1239,20 @@ static bool same_function(struct instruction *insn1, struct instruction *insn2)
 	return insn1->func->pfunc == insn2->func->pfunc;
 }
 
-static bool is_first_func_insn(struct instruction *insn)
+static bool is_first_func_insn(struct objtool_file *file, struct instruction *insn)
 {
-	return insn->offset == insn->func->offset ||
-	       (insn->type == INSN_ENDBR &&
-		insn->offset == insn->func->offset + insn->len);
+	if (insn->offset == insn->func->offset)
+		return true;
+
+	if (ibt) {
+		struct instruction *prev = prev_insn_same_sym(file, insn);
+
+		if (prev && prev->type == INSN_ENDBR &&
+		    insn->offset == insn->func->offset + prev->len)
+			return true;
+	}
+
+	return false;
 }
 
 /*
@@ -1327,7 +1336,7 @@ static int add_jump_destinations(struct objtool_file *file)
 				insn->jump_dest->func->pfunc = insn->func;
 
 			} else if (!same_function(insn, insn->jump_dest) &&
-				   is_first_func_insn(insn->jump_dest)) {
+				   is_first_func_insn(file, insn->jump_dest)) {
 				/* internal sibling call (without reloc) */
 				add_call_dest(file, insn, insn->jump_dest->func, true);
 			}
