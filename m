Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA31501B4C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 20:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344772AbiDNSw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 14:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiDNSwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 14:52:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC06B0D32
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 11:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=htAtH74QLNG2Pf9ve+yTGgjemLxhIEb+MZlCbbE3qLs=; b=osof88Xv953F6ijLPdEtg5vkLD
        U6ChiSv17EqlP/tWlUhobobjxbmOWc4y11sFg0oeXs8BXDC+Or7zO8eqwHUsPTZKbDCBkZ7SfL4Ju
        iHHpaHaGgP+1vPGEqtampmXsLlIAXrDpzGuvGx0cvLANl84W7Sc1jLqCfsruxk05V5u78lt+6+oe/
        FcBlslM5sTTpqiLe15hdQAcPT9DRLliV2BP5SdNURwqvXoGoRUtAT3zT0FvBgn9ijr/Tea+QkQ3ps
        fjvxqHCSW0n1HG83HZdQv7PMT+MYLX6cWRIsnwBcWtmBclNeuGK7yYdnpI5PH3Yjq4O5nPKtGHVMa
        S9wu3/Lw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nf4XO-00FQ7y-RI; Thu, 14 Apr 2022 18:49:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B203E30027B;
        Thu, 14 Apr 2022 20:49:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 931A432328638; Thu, 14 Apr 2022 20:49:48 +0200 (CEST)
Date:   Thu, 14 Apr 2022 20:49:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH 10/18] objtool: Extricate ibt from stack validation
Message-ID: <YlhszNnqAnGHGmak@hirez.programming.kicks-ass.net>
References: <cover.1649891421.git.jpoimboe@redhat.com>
 <44a73f724b51c4a994edc43536b7a7ee5e972b40.1649891421.git.jpoimboe@redhat.com>
 <YlfS7twQVCHGgtCV@hirez.programming.kicks-ass.net>
 <20220414154449.5moa7xsczwybbqhd@treble>
 <YlhN+GFZlycwydSv@hirez.programming.kicks-ass.net>
 <20220414170550.v2jmdfhmz7zbuug6@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414170550.v2jmdfhmz7zbuug6@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 10:05:50AM -0700, Josh Poimboeuf wrote:
> On Thu, Apr 14, 2022 at 06:38:16PM +0200, Peter Zijlstra wrote:
> > On Thu, Apr 14, 2022 at 08:44:49AM -0700, Josh Poimboeuf wrote:
> > 
> > > Ok.  That was subtle, it needs a comment or two.  I had the distinct
> > > feeling I was introducing a bug, then I got distracted ;-)
> > 
> > Right, lemme try and not forget to write one ;-)
> 
> I'm rewriting the code anyway, I'll add some comments.
> 
> > > Doesn't the compiler give those special cases ENDBR anyway?  Just
> > > wondering why we avoid the warning for those.
> > 
> > Sure, but this is about not scribbling that ENDBR with a NOP.
> 
> Right, but it only prints warnings for data sections, despite marking
> others:
> 
> -                       dest = validate_ibt_reloc(file, reloc);
> -                       if (is_data && dest && !dest->noendbr)
> -                               warn_noendbr("data ", sec, reloc->offset, dest);
> 

Right, so validate_ibt_reloc() does two things:

 - it removes the instruction from the seal list (if it was still on it)
 - it returns the dest instruction if it isn't ENDBR (or a static call
   trampoline, which we know will never be indirectly called).

So that first thing is always important; we should not seal too many
things (.initcall and .ksymtab would be bad etc..), that second thing is
only useful if there is potential control flow.

That is, .ksymtab is not used for control flow (directly), it's the
symbol table for the module linker. OTOH .initcall does have control
flow, but it is 100% control flow.

In neither case does it really make sense to warn (then again, they also
should not trigger warns I suppose).

.data/.rodata otoh is more questionable, typically a code reference
there is a function pointer and we really want an ENDBR there, but it's
not always the case, hence the warns from there.

Now, I have some vague memories of getting a lot of noise from some
other sections, but I can't really remember now :-/
