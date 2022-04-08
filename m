Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D2E4F9E3B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 22:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239512AbiDHUer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 16:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiDHUeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 16:34:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407E61B0;
        Fri,  8 Apr 2022 13:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=F/vMULxwPA3PweIjUbWnlp7vWLOZb8eeWiid2cEkC1k=; b=n11aCZbtUGp7/Bm8HOKJrNWqjs
        7HEJamwcKvRmKUHgVkDE7V/jCc4UruPMQFILZtdaJVevLhXAjGiyguzzzJj2udu13Su5Hc4wPS0Ld
        qjm5UMobIaT0uMHGBLLEUyQj8rRZpNll+kWxIPAcz60NO7wALUv1G2Ighe9ALXzDdn5dLwtNrg4AR
        bLvUKQ5Gu4LTVthCSP4teTXZZIb5p1VPie5v1GMjPly4EDFPzVW6TrTIfS/mvxgaZ89etzyEJiSzN
        t3y/KpyH8tWAMCo8soRGwSh7cGnRRnTEEfysQdcgjtS57wVjsUgawP4OoI92d/8R1Kx/TojkBnVUS
        SkUcZekQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ncvHS-00A8fd-G5; Fri, 08 Apr 2022 20:32:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4915F300130;
        Fri,  8 Apr 2022 22:32:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2374832233310; Fri,  8 Apr 2022 22:32:28 +0200 (CEST)
Date:   Fri, 8 Apr 2022 22:32:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Changbin Du <changbin.du@gmail.com>,
        linux-toolchains@vger.kernel.org,
        clang-built-linux <llvm@lists.linux.dev>
Subject: Re: [PATCH] kbuild: Remove CONFIG_DEBUG_SECTION_MISMATCH
Message-ID: <YlCb3L7ByWwszbaA@hirez.programming.kicks-ass.net>
References: <7fad83ecde03540e65677959034315f8fbb3755e.1649434832.git.jpoimboe@redhat.com>
 <CAK7LNARvFcQgEB1b0L6giwx0vD7wU9L-OZ5jvm1c5+StLjeOYQ@mail.gmail.com>
 <YlCJm8iQBPSOWIT5@hirez.programming.kicks-ass.net>
 <CAKwvOd=2xeZOg+0HosLPgCegKZxe7F-Cprw0MjOiWf2q=AbNDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=2xeZOg+0HosLPgCegKZxe7F-Cprw0MjOiWf2q=AbNDQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 01:08:47PM -0700, Nick Desaulniers wrote:
> Lore thread start for newly cc'ed ML readers:
> https://lore.kernel.org/lkml/7fad83ecde03540e65677959034315f8fbb3755e.1649434832.git.jpoimboe@redhat.com/
> 
> On Fri, Apr 8, 2022 at 12:14 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Sat, Apr 09, 2022 at 03:29:21AM +0900, Masahiro Yamada wrote:
> > > Is [2] caused by dead code that was not optimized out
> > > due to the unusual inlining decisions by the compiler ?
> >
> > The complaint is due to SMAP validation; objtool will scream if there's
> > a CALL in between STAC/CLAC. The thinking is that since they open a
> > security window, we want tight code between them. We also very much
> > don't want tracing and other funnies to happen there. As such, any CALL
> > is dis-allowed.
> 
> Just indirect calls, which might be manipulated, or static calls, too?

Any CALL instruction is a no-no. Only 'simple' code is allowed between
STAC and CLAC.

> > This weird option is having us upgrade quite a few 'inline' to
> > '__always_inline'.
> 
> As is, the assumption that __init functions only call other __init
> functions or __always_inline is a brittle house of cards that leads to
> a "what color is your function" [0] scenario, and leads to code that
> happens to not emit warnings for compiler X (or compiler X version Y).
> There's also curious exceptions in modpost that look like memory leaks
> to me.
> 
> We already have such toolchain portability issues for different
> toolchains and different configs; warnings from section mismatches,
> and objtool STAC/CLAC checks.  I feel that Josh's patch would sweep
> more of those under the rug, so I'm not in favor of it, but could be
> convinced otherwise.
> 
> TBH, I kind of think that we could use a C extension to permit
> __attribute__((always_inline)) to additionally be a statement
> attribute, rather than just a function attribute because of cases like
> this; we need the flexibility to make one call site __always_inline
> without necessarily forcing ALL callsites to be __always_inline'd.
> 
> void y (void);
> void x (void) { __attribute__((always_inline)) y(); };
> 
> (This is already expressable in LLVM IR; not (yet) in C. I'm not sure
> yet _why_ this was added to LLVM; whether a different language front
> end can express this, if C can and I'm mistaken, or whether it's only
> used for optimizations).
> 
> I think that would give developers maximal flexibility to defer as
> much to the compiler's inlining decisions when they don't care, and
> express precisely what they need when they do [care].
> 
> [0] https://journal.stuffwithstuff.com/2015/02/01/what-color-is-your-function/

So in the case of that latest __always_inline patch, there was only a
single caller. New syntax would buy us absolutely nothing there.

If we're talking extentions, I'd much rather have function spaces. That
is, being able to tag functions *AND* function pointers with an address
space qualifier.

I want to be able to create a function pointer that can only be assigned
functions from the noinstr space for example. Ideally calling such a
functino pointer would only be possible from within that space.

Anyway, let me go read that blog you linked.
