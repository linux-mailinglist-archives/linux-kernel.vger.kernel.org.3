Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0184E988B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 15:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243382AbiC1Nqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 09:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbiC1Nqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 09:46:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ACBC137BFA;
        Mon, 28 Mar 2022 06:44:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D6941FB;
        Mon, 28 Mar 2022 06:44:53 -0700 (PDT)
Received: from lakrids (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D43C3F718;
        Mon, 28 Mar 2022 06:44:51 -0700 (PDT)
Date:   Mon, 28 Mar 2022 14:44:46 +0100
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
Message-ID: <YkG7zqwFRtmUKVFc@lakrids>
References: <YjxTt3pFIcV3lt8I@zn.tnic>
 <CAKwvOdkw0Bbm+=ZyViXQhBE1L6uSbvkstHJuHpQ21tzJRftgAw@mail.gmail.com>
 <Yj2yYFloadFobRPx@lakrids>
 <Yj3OEI+WHV/A5uf8@hirez.programming.kicks-ass.net>
 <20220325151238.GB614@gate.crashing.org>
 <YkGFdtn0yDIPqXRl@FVFF77S0Q05N>
 <YkGL929QoFiTfMK7@tucnak>
 <YkGwSsXLBjReBhMf@lakrids>
 <YkG0LqWoBRqQ9Jxu@tucnak>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkG0LqWoBRqQ9Jxu@tucnak>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 03:12:14PM +0200, Jakub Jelinek wrote:
> On Mon, Mar 28, 2022 at 01:55:38PM +0100, Mark Rutland wrote:
> > > If coexistence of instrumented and non-instrumented memcpy etc. was the goal
> > > (it clearly wasn't), then the sanitizer libraries wouldn't be overriding
> > > memcpy calls, but instead the compiler would redirect calls to memcpy in
> > > instrumented functions to say __asan_memcpy which then would be
> > > instrumented.
> > 
> > FWIW, I think that approach would be fine for kernel usage.
> > 
> > > > Given the standard doesn't say *anything* about instrumentation, what does GCC
> > > > *require* instrumentation-wise of the memcpy implementation? What happens *in
> > > > practice* today?
> > > > 
> > > > For example, is the userspace implementation of memcpy() instrumented for
> > > > AddressSanitizer, or not?
> > > 
> > > It is, for all functions, whether compiled with -fsanitize=address or not,
> > > if user app is linked with -fsanitize=address, libasan is linked in and
> > > overrides the libc memcpy with its instrumented version.
> > 
> > Thanks for confirming! Just to check, how does libasan prevent recursing
> > within itself on implicitly generated calls to memcpy and friends? Is
> > anything special done to build the libasan code, is that all asm, or
> > something else?
> 
> Generally, most of the libasan wrappers look like
>   do something
>   call the original libc function (address from dlsym/dlvsym)
>   do something
> and the "do something" code isn't that complicated.  

I see; thanks!

> The compiler doesn't add calls to memcpy/memset etc. just to screw up
> users, they are added for a reason, such as copying or clearing very
> large aggregates (including for passing them by value), without -Os it
> will rarely use calls for smaller sizes and will instead expand them
> inline.

Sure; I understand that and (from my side at least) I'm not arguing that
there's malice or so on, just that I don't think we currently have the
tools for the kernel to be able to do the right thing reliably and
robustly. Thanks for helping! :)

> For malloc and the like wrappers I think it uses some TLS recursion
> counters so that say malloc called from dlsym doesn't cause problems.
> 
> Now, one way for the kernel to make kasan work (more) reliably even with
> existing compilers without special tweaks for this might be if those
> calls to no_sanitize_address code aren't mixed with sanitized code all the
> time might be set some per-thread flag when starting a "no sanitized" code
> execution and clear it at the end of the region (or vice versa) and test
> those flags in the kernel's memcpy/memset etc. implementation to decide if
> they should be sanitized or not.

Unfortunately, I don't think the setting a flag is workable, since e.g.
we need to ensure the flag is set before any implicitly-generated calls,
and I don't think we have a reliable way to do that from C. There's also
a number of portions of uninstrumentable code, so from a maintainability
and robustness PoV this option isn't great.

For `noinstr` code specifically (which gets placed into a distinct
section and can be identified by virtual address) we could have the
out-of-line functions look at their return address, but that's not going
to cover the general case of `__attribute__((no_sanitize_address))` or
compilation units built without `-fsanitize=address`.

From my PoV, distinguishing instrumentable/uninstrumentable calls at
compile time would be ideal. That, or placing the instrumentation into
the caller (omitting it when instrumentation is disabled for that
caller), and expecting the out-of-line forms are never instrumented. I
appreciate that latter option may not be workable due to potential size
bloat, though.

Similar will apply to TSAN, MSAN, etc, and I'm not sure whether those
are mutually exclusive from the compiler's PoV.

> As KASAN is (hopefully) just a kernel debugging aid and not something meant
> for production (in the userspace at least GCC strongly recommends against
> using the sanitizers in production), perhaps allocating one per-thread bool
> or int and changing it in a few spots and testing in the library functions
> might be acceptable.

I'm not sure whether folk are using KASAN in production, but IIRC there
was a desire to do so.

Thanks,
Mark.
