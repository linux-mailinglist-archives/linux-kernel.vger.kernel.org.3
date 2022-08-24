Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC0E5A043E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 00:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiHXWqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 18:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbiHXWqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 18:46:19 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0DFD44F644;
        Wed, 24 Aug 2022 15:46:17 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 27OMflBA008099;
        Wed, 24 Aug 2022 17:41:47 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 27OMfjUS008095;
        Wed, 24 Aug 2022 17:41:45 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 24 Aug 2022 17:41:44 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        Michael Matz <matz@suse.de>, linux-toolchains@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/sev: Mark snp_abort() noreturn
Message-ID: <20220824224144.GC25951@gate.crashing.org>
References: <20220824152420.20547-1-bp@alien8.de> <20220824172929.GA25951@gate.crashing.org> <YwaN2HtMyM0YEdSB@worktop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwaN2HtMyM0YEdSB@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Wed, Aug 24, 2022 at 10:45:12PM +0200, Peter Zijlstra wrote:
> On Wed, Aug 24, 2022 at 12:29:29PM -0500, Segher Boessenkool wrote:
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
> to guess at it.

It is!  A noreturn function (that doesn't warn like "warning: 'noreturn'
function does return") does not have whatever your architecture uses for
function returns in it.  Just like most non-noreturn functions that do
not return btw: the attribute affects code generation of the *caller* of
such functions.

> STT_FUNC_NORETURN would do I suppose, except then all
> the tools will need to be taught how to deal with that, which is also
> very painful.

What is that?  Even Google has no idea.  Hrm.

> Another options is something like .symtab.noreturn which is another
> symbol table explicitly listing the noreturn functions. Since it's an
> extra section tools that don't know about it can freely ignore it and
> carry on as usual.

The noreturn attribute, like any attribute, is informing the compiler
about some attributes of the code it is compiling.  Trying to use it
at a completely different level, for a completely different purpose,
will only end in tears.  Say no to tears.

The only thing a compiler does with it (not counting diagnostics) is it
says that calls to such a function never return, are really just a jump,
not a call.  This allows the compiler to generate slightly faster code
(smaller, and it won't realistically be in any hot path).

   - - -

What fundamental problem does objtool have in dealing with any normal
compiled code itself?  Does it try to understand the semantics of the
machine code (not very tractable), does it expect some magic markup to
be generated together with the machine code, does it want to have
compilers hamstrung wrt what kind of code they can generate?

There is some serious disconnect here, and I'm not even completely sure
what it is :-(


Segher
