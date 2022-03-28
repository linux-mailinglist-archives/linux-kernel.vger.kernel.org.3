Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F5F4E9205
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 11:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240056AbiC1Jys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 05:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239800AbiC1Jyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 05:54:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 168CC54BD7;
        Mon, 28 Mar 2022 02:53:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1405D6E;
        Mon, 28 Mar 2022 02:53:03 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.8.66])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0BE283F66F;
        Mon, 28 Mar 2022 02:53:01 -0700 (PDT)
Date:   Mon, 28 Mar 2022 10:52:54 +0100
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
Message-ID: <YkGFdtn0yDIPqXRl@FVFF77S0Q05N>
References: <YjxTt3pFIcV3lt8I@zn.tnic>
 <CAKwvOdkw0Bbm+=ZyViXQhBE1L6uSbvkstHJuHpQ21tzJRftgAw@mail.gmail.com>
 <Yj2yYFloadFobRPx@lakrids>
 <Yj3OEI+WHV/A5uf8@hirez.programming.kicks-ass.net>
 <20220325151238.GB614@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325151238.GB614@gate.crashing.org>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 10:12:38AM -0500, Segher Boessenkool wrote:
> Hi!
> 
> On Fri, Mar 25, 2022 at 03:13:36PM +0100, Peter Zijlstra wrote:
> > 
> > +linux-toolchains
> > 
> > On Fri, Mar 25, 2022 at 12:15:28PM +0000, Mark Rutland wrote:

> > > a) The compiler expects the out-of-line implementations of functions
> > >    ARE NOT instrumented by address-sanitizer.
> > > 
> > >    If this is the case, then it's legitimate for the compiler to call
> > >    these functions anywhere, and we should NOT instrument the kernel
> > >    implementations of these. If the compiler wants those instrumented it
> > >    needs to add the instrumentation in the caller.
> 
> The compiler isn't assuming anything about asan.  The compiler generates
> its code without any consideration of what asan will or will not do.
> The burden of making things work is on asan.

I think we're talking past each other here, so let me be more precise. :)

The key thing is that when the user passes `-fsantize=address`, instrumentation
is added by (a part of) the compiler. That instrumentation is added under some
assumptions as to how the compiler as a whole will behave.

With that in mind, the question is how is __attribute__((no_sanitize_address))
intended to work when considering all the usual expectations around how the
compiler can play with memcpy and similar?

I think the answer to that is "this hasn't been thought about in great detail",
which leads to the question of "how could/should this be made to work?", which
is what I'm on about below.

> It is legitimate to call (or not call!) memcpy anywhere.  memcpy always
> is __builtin_memcpy, which either or not does a function call.
> 
> > >    AFAICT The two options for the compiler here are:
> > > 
> > >    1) Always inline an uninstrumented form of the function in this case
> > > 
> > >    2) Have distinct instrumented/uninstrumented out-of-line
> > >       implementations, and call the uninstrumented form in this case.
> 
> The compiler should not do anything differently here if it uses asan.
> The address sanitizer and the memcpy function implementation perhaps
> have to cooperate somehow, or asan needs more smarts.  This needs to
> happen no matter what, to support other things calling memcpy, say,
> assembler code.

I appreciate where you're coming from here, but I think you're approaching the
problem sideways.

> > > So from those examples it seems GCC falls into bucket (a), and assumes the
> > > blessed functions ARE NOT instrumented.
> 
> No, it doesn't show GCC assumes anything.  No testing of this kind can
> show anything alike.

I appreciate that; hence "it seems".

What I'm getting at is that the *instrumentation* is added under some
assumptions (those of whoever wrote the instrumentation code), and those
assumptions might not match the behaviour of the compiler, or the behaviour we
expect for __attribute__((no_sanitize_address)).

We need to define *what the semantics are* so that we can actually solve the
problem, e.g. is a memcpy implementation expected to be instrumented or not?

> > > I think something has to change on the compiler side here (e.g. as per
> > > options above), and we should align GCC and clang on the same
> > > approach...
> 
> GCC *requires* memcpy to be the standard memcpy always (i.e. to have the
> standard-specified semantics).  This means that it will have the same
> semantics as __builtin_memcpy always, and either or not be a call to an
> external function.  It can also create calls to it out of thin air.

I understand all of that.

Given the standard doesn't say *anything* about instrumentation, what does GCC
*require* instrumentation-wise of the memcpy implementation? What happens *in
practice* today?

For example, is the userspace implementation of memcpy() instrumented for
AddressSanitizer, or not?

Thanks,
Mark.
