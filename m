Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF385507B54
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 22:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244295AbiDSU4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 16:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241627AbiDSU4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 16:56:42 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765C241984
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 13:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=ntDM2QbultQ2Oq/wSSfxRfuV3IDfjkzlXCCdjZHRS4I=; b=ZxOeb+DFZ3CW/oOlvMJRxEvrRD
        ztThrGlPYg01asCkNkY8wEH9LPxVjFm7hQgl3JeSN/PI9ns9fpr+Svt1Qbdx1O0/plQrtMvwB/qq0
        /DMRC/gE3Eq70uWIFTm2tRGe3xV/CztYFUYxU8fUCrfHHfcMWtv3tmuzUJb5fx4C2hs6fMsDZ66HU
        1jXmRHzcDhwC09pkpQpd9HB5Gv47pXoido+ZymLrDQGJ5gn9Mwlp9aUS4jZTes2yuRvANvJZ6wF22
        ihYZH6kblcgmugmSjWeSBJ6apQtpoBkUfLrS4Sm7trLqBwQJRxPj1DDWVd+sSRs6dFw+XGW4Htf5a
        n13gZOmQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ngur2-006uzO-N7; Tue, 19 Apr 2022 20:53:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 57E033003AA;
        Tue, 19 Apr 2022 22:53:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3AA702B526F01; Tue, 19 Apr 2022 22:53:44 +0200 (CEST)
Message-ID: <20220419205241.280037046@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 19 Apr 2022 22:41:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, brgerst@gmail.com,
        jiangshanlai@gmail.com, Andrew.Cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 1/2] x86: Simplify Retpoline thunk
References: <20220419204109.520779286@infradead.org>
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

Now that we rewrite all the indirect call sites, per commit:

  750850090081 ("x86/alternative: Implement .retpoline_sites support")

it doesn't make sense to have the retpoline thunks be an ALTERNATIVE_2
that still includes a 'naked' indirect jump.

(this accidentally 'defunnels' i386 by going back to full retpolines)

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/lib/retpoline.S |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -32,9 +32,9 @@
 SYM_INNER_LABEL(__x86_indirect_thunk_\reg, SYM_L_GLOBAL)
 	UNWIND_HINT_EMPTY
 
-	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), \
-		      __stringify(RETPOLINE \reg), X86_FEATURE_RETPOLINE, \
-		      __stringify(lfence; ANNOTATE_RETPOLINE_SAFE; jmp *%\reg; int3), X86_FEATURE_RETPOLINE_LFENCE
+	ALTERNATIVE __stringify(RETPOLINE \reg), \
+		    __stringify(lfence; ANNOTATE_RETPOLINE_SAFE; jmp *%\reg; int3), \
+		    X86_FEATURE_RETPOLINE_LFENCE
 
 .endm
 


