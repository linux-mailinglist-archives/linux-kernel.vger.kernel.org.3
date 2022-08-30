Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E765A5ADB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 06:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiH3Eqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 00:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiH3Eqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 00:46:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74BAAB42E;
        Mon, 29 Aug 2022 21:46:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4385861124;
        Tue, 30 Aug 2022 04:46:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5405FC433D6;
        Tue, 30 Aug 2022 04:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661834789;
        bh=NiW3r5AK9XWrE8Z5VmpCFINbdcTHRs8dHUrAnKvR0Xk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X+yq7rtjeemMtmVvWMk7Sd8Pdgf1d8zFw/0WgqgA2FJnF9SLa/PRFDT5Bbb/oExuk
         o6py24wiaAtOqp8C0FU2RTrC6BeW5ZW9MzeG1buK8mQDfl6W/VjXtoF0yWzfC0Bm9D
         wzlfyYW6TUBcnw5IClQptlumSJGd23PuNgNUqkQyjtT6r/NRddEGUE7D60FBYc1iFm
         8fCYyRDTHnd85hH7BuYlCH46kkn8+Tbtla1Ly0ZW41k9Y/pKxrXHmqvQRAZyDk9EuH
         bLo8LaCs8LpiCfRs+ahf3cOnSARZ16cSz0ENKyAiHTBNQIXGRnK0i4oTTZLj8G4Eg2
         FKmcFtANjhD7g==
Date:   Mon, 29 Aug 2022 21:46:27 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Segher Boessenkool <segher@kernel.crashing.org>,
        Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        Michael Matz <matz@suse.de>, linux-toolchains@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/sev: Mark snp_abort() noreturn
Message-ID: <20220830044627.t37gkqjdknu4wgz6@treble>
References: <20220824152420.20547-1-bp@alien8.de>
 <20220824172929.GA25951@gate.crashing.org>
 <YwaN2HtMyM0YEdSB@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YwaN2HtMyM0YEdSB@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 10:45:12PM +0200, Peter Zijlstra wrote:
> On Wed, Aug 24, 2022 at 12:29:29PM -0500, Segher Boessenkool wrote:
> > Hi!
> > 
> > On Wed, Aug 24, 2022 at 05:24:20PM +0200, Borislav Petkov wrote:
> > > Mark both the function prototype and definition as noreturn in order to
> > > prevent the compiler from doing transformations which confuse objtool
> > > like so:
> > > 
> > >   vmlinux.o: warning: objtool: sme_enable+0x71: unreachable instruction
> > 
> > Would -Wmissing-noreturn have caught this?  It sounds like you need this
> > (and then fix all resulting warnings) to not upset objtool?
> > 
> > It is nice to have this anyway (if there aren't a zillion false
> > positives), but it seems objtool is very fragile.
> 
> Well, just like gcc has noreturn heuristics so has objtool, it just
> turns into pain when they don't agree with one another.
> 
> Ideally noreturn would be reflected in the object file so we don't have
> to guess at it. STT_FUNC_NORETURN would do I suppose, except then all
> the tools will need to be taught how to deal with that, which is also
> very painful.
> 
> Another options is something like .symtab.noreturn which is another
> symbol table explicitly listing the noreturn functions. Since it's an
> extra section tools that don't know about it can freely ignore it and
> carry on as usual.

We're planning to talk about this at the LPC toolchains microconference.

My proposal is similar to yours except I called it .annotate.noreturn.
It would be enabled with a --annotate=noreturn compiler option.  It
would report both explicit noreturns (with the "noreturn" function
attribute) and implicit noreturns (static functions which only call
other noreturn functions).

There would also be an --annotate=jump_table option which creates an
.annotate.jump_table to describe switch statement jump table flow.

Those are the two biggest challenges for objtool.

-- 
Josh
