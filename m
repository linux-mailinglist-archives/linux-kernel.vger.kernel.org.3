Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7944E3D15
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 12:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbiCVLA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 07:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233823AbiCVLAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 07:00:50 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC77C6AA60;
        Tue, 22 Mar 2022 03:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SFbSvFsAQMNlG74JQ4hhrBuNj24t/AZvLVG5UH4k9zY=; b=iSkb8T57dmBnvaEcOXsCG5QBE+
        1r/KMWko09MS3eEwdGl2h6836XauX5iDgMOI8nFzSFRiEkI2jLZvJND6qKxt0xSgd1TS1dWlC4btJ
        4FXS+5VLqHpNFBAR6lPF0gDesnqan+jy6XrRfoi5ZTvVV6J+tKcWAHl+1/axADj7XcqzvSvEzzhWS
        sV/PMzAwGK6czmM606IFBTjFyMwg8tBrMpPSuVsDqsJ/A5fxvVmWmYUhHAuB2V9jZbMsWEVtrV562
        ASrCtYnq8+ewsFkrnewsypc4M/9HWBUtQVt1MAtsntwGxfUjHhetI1EyPR+h8l58e8zwql3fbSd/D
        2laCqmCw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWcEE-003RYY-O3; Tue, 22 Mar 2022 10:59:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EDF9230021B;
        Tue, 22 Mar 2022 11:59:04 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D1C822C6ADE43; Tue, 22 Mar 2022 11:59:04 +0100 (CET)
Date:   Tue, 22 Mar 2022 11:59:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-crypto@vger.kernel.org, ebiggers@google.com,
        herbert@gondor.apana.org.au, Jason@zx2c4.com,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: linux-next: build warnings after merge of the tip tree
Message-ID: <Yjmr+BLAoBusQ0hh@hirez.programming.kicks-ass.net>
References: <20220321140327.777f9554@canb.auug.org.au>
 <Yjh11UjDZogc3foM@hirez.programming.kicks-ass.net>
 <Yjmo7KDlfR537J0W@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yjmo7KDlfR537J0W@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 11:46:04AM +0100, Peter Zijlstra wrote:
> On Mon, Mar 21, 2022 at 01:55:49PM +0100, Peter Zijlstra wrote:

> > > arch/x86/crypto/poly1305-x86_64.o: warning: objtool: poly1305_blocks_avx() falls through to next function poly1305_blocks_x86_64()
> > > arch/x86/crypto/poly1305-x86_64.o: warning: objtool: poly1305_emit_avx() falls through to next function poly1305_emit_x86_64()
> > > arch/x86/crypto/poly1305-x86_64.o: warning: objtool: poly1305_blocks_avx2() falls through to next function poly1305_blocks_x86_64()
> > 
> > Yes, those are somewhere on the todo list, lemme bump them.

The poly one is a little more involved since it's a perl script writing
asm O_O

Looking at the generated asm tough, the these are conditional tail-calls
and objtool *should* recognise them but doesn't...

This seems to cure.

---
 tools/objtool/check.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 6de5085e3e5a..b848e1ddd5d8 100644
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

