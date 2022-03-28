Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94EE4E9A4C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 17:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244164AbiC1PBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 11:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244159AbiC1O77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 10:59:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 51380EAA;
        Mon, 28 Mar 2022 07:58:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09F86D6E;
        Mon, 28 Mar 2022 07:58:17 -0700 (PDT)
Received: from lakrids (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B75763F73B;
        Mon, 28 Mar 2022 07:58:15 -0700 (PDT)
Date:   Mon, 28 Mar 2022 15:58:10 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Nathan Chancellor <nathan@kernel.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-toolchains@vger.kernel.org
Subject: Re: clang memcpy calls
Message-ID: <YkHNArCbWUEojGjL@lakrids>
References: <YjxTt3pFIcV3lt8I@zn.tnic>
 <CAKwvOdkw0Bbm+=ZyViXQhBE1L6uSbvkstHJuHpQ21tzJRftgAw@mail.gmail.com>
 <Yj2yYFloadFobRPx@lakrids>
 <Yj3OEI+WHV/A5uf8@hirez.programming.kicks-ass.net>
 <20220325151238.GB614@gate.crashing.org>
 <YkGFdtn0yDIPqXRl@FVFF77S0Q05N>
 <20220328142220.GI614@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328142220.GI614@gate.crashing.org>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 09:22:20AM -0500, Segher Boessenkool wrote:
> Hi!
> 
> On Mon, Mar 28, 2022 at 10:52:54AM +0100, Mark Rutland wrote:
> > On Fri, Mar 25, 2022 at 10:12:38AM -0500, Segher Boessenkool wrote:
> > > The compiler isn't assuming anything about asan.  The compiler generates
> > > its code without any consideration of what asan will or will not do.
> > > The burden of making things work is on asan.
> > 
> > I think we're talking past each other here, so let me be more precise. :)
> > 
> > The key thing is that when the user passes `-fsantize=address`, instrumentation
> > is added by (a part of) the compiler. That instrumentation is added under some
> > assumptions as to how the compiler as a whole will behave.
> > 
> > With that in mind, the question is how is __attribute__((no_sanitize_address))
> > intended to work when considering all the usual expectations around how the
> > compiler can play with memcpy and similar?
> 
> The attribute is about how the *current* function is instrumented, not
> about anything called by this function.  This is clearly documented:
> 'no_sanitize_address'
> 'no_address_safety_analysis'
>      The 'no_sanitize_address' attribute on functions is used to inform
>      the compiler that it should not instrument memory accesses in the
>      function when compiling with the '-fsanitize=address' option.  The
>      'no_address_safety_analysis' is a deprecated alias of the
>      'no_sanitize_address' attribute, new code should use
>      'no_sanitize_address'.

I understand this, and I have read the documentation.

I'm not claiming any *individual* semantic is wrong, just that in
combination this doesn't provide what people *need* (even if it strictly
matches what is documented).

My argument is: if the compiler is permitted to implictly and
arbitrarily add calls to instrumented functions within a function marked
with `no_sanitize_address`, the `no_sanitize_address` attribute is
effectively useless, and therefore *something* needs to change.

> > > The compiler should not do anything differently here if it uses asan.
> > > The address sanitizer and the memcpy function implementation perhaps
> > > have to cooperate somehow, or asan needs more smarts.  This needs to
> > > happen no matter what, to support other things calling memcpy, say,
> > > assembler code.
> > 
> > I appreciate where you're coming from here, but I think you're approaching the
> > problem sideways.
> 
> I am stating facts, I am not trying to solve your problem there.  It
> seemed to me (and still does) that you didn't grasp all facts here.

Sorry, but I think you're reading my replies uncharitably if you think
that.

> > We need to define *what the semantics are* so that we can actually solve the
> > problem, e.g. is a memcpy implementation expected to be instrumented or not?
> 
> That is up to the memcpy implementation itself, of course.

Sorry, but that doesn't make sense to me. When the compiler instruments
a function with AddressSanitizer, it must have *some* assumption about
whether memcpy() itself will be instrumented, such that it won't miss
some necessary instrumentation (and ideally, for performance reasons
doesn't have redundant instrumentation).

If the story is "memcpy may or may not be instrumented", then the only
way to guarantee necessary instrumentation is for the compiler to
*always* place it in the caller (unless forbidden by
`no_sanitize_address`). If that were the case, the kernel can make
things work by simply not instrumenting memcpy and friends.

IIUC today those assumptions are not documented. Is the behaviour
consistent?

> > > GCC *requires* memcpy to be the standard memcpy always (i.e. to have the
> > > standard-specified semantics).  This means that it will have the same
> > > semantics as __builtin_memcpy always, and either or not be a call to an
> > > external function.  It can also create calls to it out of thin air.
> > 
> > I understand all of that.
> 
> And still you want us to do something that is impossible under those
> existing constraints :-(

If that's truly impossible, that's very unfortunate.

FWIW, I can believe this would require tremendous effort to change, even
if it's not truly impossible.

If that is the case, it means that kernel side we have to never
instrument our implementation of memcpy and friends for correctness
reasons, which has the unfortunate property of losing coverage in the
cases we *would* like to use an instrumented memcpy.

> If you want the external memcpy called by modules A, B, C to not be
> instrumented, you have to link A, B, and C against an uninstrumented
> memcpy.  This is something the kernel will have to do, the compiler has
> no say in how the kernel is linked together.

Unfortunately that options doesn't really fix the `no_sanitize_address`
semantic, and forces us to move *all* uninstrumentable code out into
separate compilation units, etc.

This isn't *impossible*, but is *very* painful.

Thanks,
Mark.
