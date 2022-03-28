Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7EF4E9724
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 14:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242660AbiC1M5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 08:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240038AbiC1M51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 08:57:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EDCBB35DD5;
        Mon, 28 Mar 2022 05:55:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F150D6E;
        Mon, 28 Mar 2022 05:55:45 -0700 (PDT)
Received: from lakrids (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E1623F718;
        Mon, 28 Mar 2022 05:55:44 -0700 (PDT)
Date:   Mon, 28 Mar 2022 13:55:38 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Jakub Jelinek <jakub@redhat.com>
Cc:     Segher Boessenkool <segher@kernel.crashing.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Nathan Chancellor <nathan@kernel.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-toolchains@vger.kernel.org
Subject: Re: clang memcpy calls
Message-ID: <YkGwSsXLBjReBhMf@lakrids>
References: <YjxTt3pFIcV3lt8I@zn.tnic>
 <CAKwvOdkw0Bbm+=ZyViXQhBE1L6uSbvkstHJuHpQ21tzJRftgAw@mail.gmail.com>
 <Yj2yYFloadFobRPx@lakrids>
 <Yj3OEI+WHV/A5uf8@hirez.programming.kicks-ass.net>
 <20220325151238.GB614@gate.crashing.org>
 <YkGFdtn0yDIPqXRl@FVFF77S0Q05N>
 <YkGL929QoFiTfMK7@tucnak>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkGL929QoFiTfMK7@tucnak>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 12:20:39PM +0200, Jakub Jelinek wrote:
> On Mon, Mar 28, 2022 at 10:52:54AM +0100, Mark Rutland wrote:
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
> no_sanitize_address or lack thereof is whether the current function
> shouldn't be or should be ASan instrumented, not on whether other functions
> it calls are instrumented or not.

I understand this. :)

> memcpy/memmove/memset are just a tiny bit special case because the
> compiler can add them on their own even if they aren't present in the
> source (there are a few others the compiler can pattern match too) and
> various builtins can be on the other side expanded inline instead of
> called, so one then gets the sanitization status of the function in
> which it is used rather than whether the out of line implementation of
> the function is sanitized.

Yep, and this is the point I'm getting at. If the compiler *implicitly*
generates a call to one of these from a function which was marked with
__attribute__((no_sanitize_address)), then either:

1) This renders __attribute__((no_sanitize_address)) useless, since
   instrumentation is being added in a way the code author cannot
   reliably prevent. If so, I'd argue that this is a compiler bug, and
   that the transformation of inserting the call is unsound.

2) There's an expectation that those out-of-line implementations are
   *NOT* instrumented, and this is fine so long as those are not
   instrumented.

I appreciate that this isn't necessarily something which was considered
when the feature was originally designed, and maybe this is fine for
userspace, but for kernel usage we need to be able to reliably prevent
instrumentation.

> If coexistence of instrumented and non-instrumented memcpy etc. was the goal
> (it clearly wasn't), then the sanitizer libraries wouldn't be overriding
> memcpy calls, but instead the compiler would redirect calls to memcpy in
> instrumented functions to say __asan_memcpy which then would be
> instrumented.

FWIW, I think that approach would be fine for kernel usage.

> > Given the standard doesn't say *anything* about instrumentation, what does GCC
> > *require* instrumentation-wise of the memcpy implementation? What happens *in
> > practice* today?
> > 
> > For example, is the userspace implementation of memcpy() instrumented for
> > AddressSanitizer, or not?
> 
> It is, for all functions, whether compiled with -fsanitize=address or not,
> if user app is linked with -fsanitize=address, libasan is linked in and
> overrides the libc memcpy with its instrumented version.

Thanks for confirming! Just to check, how does libasan prevent recursing
within itself on implicitly generated calls to memcpy and friends? Is
anything special done to build the libasan code, is that all asm, or
something else?

> Note that the default shadow memory value is 0 which means accessible,
> so even when memcpy is instrumented, when called from non-instrumented code
> often it will not do anything beyond normal behavior

That might be true in userspace, but is not the case within the kernel
as the shadow might not be mapped (and is one reason we need to inhibit
instrumentation in the first place).

For example, consider the code which *creates* the page tables for the
shadow memory. Until that's run, accessing the shadow will result in a
(fatal) fault, and while the compilation unit with that code is compiled
*without* `-fsantize=address`, it may call into the common
implementation of memcpy() and friends shared by all kernel code.

Thanks,
Mark.

> , as non-instrumented
> functions don't poison the paddings in between variable (there even doesn't
> have to be any) etc.  But e.g. malloc/operator new etc. is also overridden,
> so buffer overflows/underflows on memory allocated that way from
> uninstrumented code using memcpy etc. will be diagnosed.
> 
> 	Jakub
> 
