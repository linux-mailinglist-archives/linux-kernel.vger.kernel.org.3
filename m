Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F765A1159
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 15:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242283AbiHYNDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 09:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242190AbiHYNC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 09:02:58 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A7B39E8A5;
        Thu, 25 Aug 2022 06:02:45 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 27PCwEnu008838;
        Thu, 25 Aug 2022 07:58:14 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 27PCwDAs008837;
        Thu, 25 Aug 2022 07:58:13 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Thu, 25 Aug 2022 07:58:13 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        Michael Matz <matz@suse.de>, linux-toolchains@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/sev: Mark snp_abort() noreturn
Message-ID: <20220825125813.GE25951@gate.crashing.org>
References: <20220824152420.20547-1-bp@alien8.de> <20220824172929.GA25951@gate.crashing.org> <YwaN2HtMyM0YEdSB@worktop.programming.kicks-ass.net> <20220824224144.GC25951@gate.crashing.org> <YwcZjxVkO/lspvmv@worktop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwcZjxVkO/lspvmv@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 08:41:19AM +0200, Peter Zijlstra wrote:
> On Wed, Aug 24, 2022 at 05:41:44PM -0500, Segher Boessenkool wrote:
> 
> > It is!  A noreturn function (that doesn't warn like "warning: 'noreturn'
> > function does return") does not have whatever your architecture uses for
> > function returns in it.  Just like most non-noreturn functions that do
> > not return btw: the attribute affects code generation of the *caller* of
> > such functions.
> 
> Yeah, but objtool can't tell if the compiler just spazzed out and
> stopped generating code or if it was intentional.

I don't understand what you mean.  If the compiler malfunctioned, all
bets are off.

If not, then the compiler correctly decided the function does not return
in a normal way, and it generated machine code accordingly.

Or you mean something else by "stopped generating code"?

> > What fundamental problem does objtool have in dealing with any normal
> > compiled code itself?  Does it try to understand the semantics of the
> > machine code (not very tractable), does it expect some magic markup to
> > be generated together with the machine code, does it want to have
> > compilers hamstrung wrt what kind of code they can generate?
> > 
> > There is some serious disconnect here, and I'm not even completely sure
> > what it is :-(
> 
> Objtool follows control flow. As you said above, noreturn functions
> behave differently and code-gen after a call to a noreturn function
> stops.

The noreturn attribute only informs the compiler that this function is
one that does not return.  There are other functions that do the same.
Most (or hopefully all!) functions flagged by -Wmissing-noreturn for
example.

You cannot require all functions that do not return have the attribute.

> Typically objtool expects a call instruction to return and continue on
> the next instruction; if all of a sudden there's nothing there, it gets
> suspicious and says the compiler messed up.

That is a shortcoming in objtool then.

The fundamental problem is that you cannot really parse machine code as
much as you apparently want to.  And limiting yourself to "machine code
a compiler would generate" breaks down if a) the compiler changes, or b)
your assumptions of what compilers do or do not generate are faulty.


Segher
