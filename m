Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD2C4E3DD8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 12:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbiCVLxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 07:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234393AbiCVLxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 07:53:36 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3409E8022D;
        Tue, 22 Mar 2022 04:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=+yXAkHolJgqVk/BtNf4Ef0TWb84m7vRf+K9XWHBKc4Q=; b=ly7pY/NnbBHKXcqHpNl17W1Z37
        Gecx5+lTJas19UAtgWyPuNbhZDmgsUwZLMAtktWlOJ0OFErpcvHR8urBqd5oTbSGqgI7Q9GAEDENx
        fICWGT1kE8Wk4fX8WY1DOPC3++56OPXm6tyNCFHtDpbdgkfnVVHcPBnW3mYhUxd/A9Vp7206PRVrN
        vVYcyGhWhIhmqoCwdV2bYvCwvjH0Yit/85oFfXv0WC+Z9aiTZJzS7DX9oBTUMrzzuF2vacyRC8RSB
        7ltHfEGyMF/mmBiYYif5dIXgg91qF+49ZvWTtzKFD/Dh325K+9KR30S7ZiEc8eTKuXbG+jmxTXnAA
        NPODUChA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWd3I-003S9p-PB; Tue, 22 Mar 2022 11:51:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 40AB1300727;
        Tue, 22 Mar 2022 12:51:50 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A6EA32D273A03; Tue, 22 Mar 2022 12:51:50 +0100 (CET)
Message-ID: <20220322115125.811582125@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 22 Mar 2022 12:48:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        linux-crypto@vger.kernel.org, ebiggers@google.com,
        herbert@gondor.apana.org.au, Jason@zx2c4.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 2/2] objtool: Fix IBT tail-call detection
References: <20220322114809.381992456@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 tools/objtool/check.c |   19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1239,11 +1239,20 @@ static bool same_function(struct instruc
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
@@ -1327,7 +1336,7 @@ static int add_jump_destinations(struct
 				insn->jump_dest->func->pfunc = insn->func;
 
 			} else if (!same_function(insn, insn->jump_dest) &&
-				   is_first_func_insn(insn->jump_dest)) {
+				   is_first_func_insn(file, insn->jump_dest)) {
 				/* internal sibling call (without reloc) */
 				add_call_dest(file, insn, insn->jump_dest->func, true);
 			}


