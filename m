Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0814E5BAF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 00:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345465AbiCWXI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 19:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345483AbiCWXIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 19:08:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2827790FDA;
        Wed, 23 Mar 2022 16:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mj8PXvWr7idtmZWEBEDAzY/76f/xydcoSsKld+xUHEU=; b=BcZYwqNU0fJX+RTgM9TtGhxWDh
        YTQv4IH3xPlj9fadook3ZkO+aXwhLbNnZwX/hrXAKl282yxqKSsKMPkQQtP8tA+PwU817c4ruS/6A
        MtI5Ux3w6w8WsLShgZDkTfiJjzFZZocwMC8OCsBQbA2za8hM91edmovyj5CPoEIrIMZLfxwiUJwpW
        7FT9ycmr65iiHIM4yGG4ulHoRyCWGepvvqvq/nT3IlDV4SKKN9zNAqMmCLi8+5HBueHWd5h9a7WNq
        tNV6rba/qtUufF+CbMJ/BKb1ni1ZpNIhmRbnElnILHuOjCc0gdoMPW/1JIxZeVPicprnQeR9qrB/e
        ZO7O1c/w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nXA4O-00CvCt-PW; Wed, 23 Mar 2022 23:07:12 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 64BA5986200; Thu, 24 Mar 2022 00:07:12 +0100 (CET)
Date:   Thu, 24 Mar 2022 00:07:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        ebiggers@google.com, herbert@gondor.apana.org.au, Jason@zx2c4.com,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH 4/2] objtool: Fix SLS validation for KCOV tail-call
 replacement
Message-ID: <20220323230712.GA8939@worktop.programming.kicks-ass.net>
References: <20220322114809.381992456@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322114809.381992456@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Since not all compilers have a function attribute to disable KCOV
instrumentation, objtool can rewrite KCOV instrumentation in noinstr
functions as per commit:

  f56dae88a81f ("objtool: Handle __sanitize_cov*() tail calls")

However, this has subtle interaction with the SLS validation from
commit:

  1cc1e4c8aab4 ("objtool: Add straight-line-speculation validation")

In that when a tail-call instrucion is replaced with a RET an
additional INT3 instruction is also written, but is not represented in
the decoded instruction stream.

This then leads to false positive missing INT3 objtool warnings in
noinstr code.

Instead of adding additional struct instruction objects, mark the RET
instruction with retpoline_safe to suppress the warning (since we know
there really is an INT3).

Fixes: 1cc1e4c8aab4 ("objtool: Add straight-line-speculation validation")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c |   43 +++++++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 14 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1090,6 +1099,17 @@ static void annotate_call_site(struct ob
 			               : arch_nop_insn(insn->len));
 
 		insn->type = sibling ? INSN_RETURN : INSN_NOP;
+
+		if (sibling) {
+			/*
+			 * We've replaced the tail-call JMP insn by two new
+			 * insn: RET; INT3, except we only have a single struct
+			 * insn here. Mark it retpoline_safe to avoid the SLS
+			 * warning, instead of adding another insn.
+			 */
+			insn->retpoline_safe = true;
+		}
+
 		return;
 	}
 
