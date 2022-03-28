Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79B04E9975
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 16:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243808AbiC1O2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 10:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243801AbiC1O2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 10:28:38 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3744B46B1A;
        Mon, 28 Mar 2022 07:26:58 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 22SEMLX6009684;
        Mon, 28 Mar 2022 09:22:21 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 22SEMKu7009683;
        Mon, 28 Mar 2022 09:22:20 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 28 Mar 2022 09:22:20 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Nathan Chancellor <nathan@kernel.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-toolchains@vger.kernel.org
Subject: Re: clang memcpy calls
Message-ID: <20220328142220.GI614@gate.crashing.org>
References: <YjxTt3pFIcV3lt8I@zn.tnic> <CAKwvOdkw0Bbm+=ZyViXQhBE1L6uSbvkstHJuHpQ21tzJRftgAw@mail.gmail.com> <Yj2yYFloadFobRPx@lakrids> <Yj3OEI+WHV/A5uf8@hirez.programming.kicks-ass.net> <20220325151238.GB614@gate.crashing.org> <YkGFdtn0yDIPqXRl@FVFF77S0Q05N>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkGFdtn0yDIPqXRl@FVFF77S0Q05N>
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

On Mon, Mar 28, 2022 at 10:52:54AM +0100, Mark Rutland wrote:
> On Fri, Mar 25, 2022 at 10:12:38AM -0500, Segher Boessenkool wrote:
> > The compiler isn't assuming anything about asan.  The compiler generates
> > its code without any consideration of what asan will or will not do.
> > The burden of making things work is on asan.
> 
> I think we're talking past each other here, so let me be more precise. :)
> 
> The key thing is that when the user passes `-fsantize=address`, instrumentation
> is added by (a part of) the compiler. That instrumentation is added under some
> assumptions as to how the compiler as a whole will behave.
> 
> With that in mind, the question is how is __attribute__((no_sanitize_address))
> intended to work when considering all the usual expectations around how the
> compiler can play with memcpy and similar?

The attribute is about how the *current* function is instrumented, not
about anything called by this function.  This is clearly documented:
'no_sanitize_address'
'no_address_safety_analysis'
     The 'no_sanitize_address' attribute on functions is used to inform
     the compiler that it should not instrument memory accesses in the
     function when compiling with the '-fsanitize=address' option.  The
     'no_address_safety_analysis' is a deprecated alias of the
     'no_sanitize_address' attribute, new code should use
     'no_sanitize_address'.

> > The compiler should not do anything differently here if it uses asan.
> > The address sanitizer and the memcpy function implementation perhaps
> > have to cooperate somehow, or asan needs more smarts.  This needs to
> > happen no matter what, to support other things calling memcpy, say,
> > assembler code.
> 
> I appreciate where you're coming from here, but I think you're approaching the
> problem sideways.

I am stating facts, I am not trying to solve your problem there.  It
seemed to me (and still does) that you didn't grasp all facts here.

> We need to define *what the semantics are* so that we can actually solve the
> problem, e.g. is a memcpy implementation expected to be instrumented or not?

That is up to the memcpy implementation itself, of course.

> > GCC *requires* memcpy to be the standard memcpy always (i.e. to have the
> > standard-specified semantics).  This means that it will have the same
> > semantics as __builtin_memcpy always, and either or not be a call to an
> > external function.  It can also create calls to it out of thin air.
> 
> I understand all of that.

And still you want us to do something that is impossible under those
existing constraints :-(

If you want the external memcpy called by modules A, B, C to not be
instrumented, you have to link A, B, and C against an uninstrumented
memcpy.  This is something the kernel will have to do, the compiler has
no say in how the kernel is linked together.


Segher
