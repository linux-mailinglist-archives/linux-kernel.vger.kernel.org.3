Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9D04E77CE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 16:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377671AbiCYPdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 11:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377136AbiCYPXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 11:23:49 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C9B3DCE07;
        Fri, 25 Mar 2022 08:17:25 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 22PFCcBg022474;
        Fri, 25 Mar 2022 10:12:38 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 22PFCcbT022473;
        Fri, 25 Mar 2022 10:12:38 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 25 Mar 2022 10:12:38 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Nathan Chancellor <nathan@kernel.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-toolchains@vger.kernel.org
Subject: Re: clang memcpy calls
Message-ID: <20220325151238.GB614@gate.crashing.org>
References: <YjxTt3pFIcV3lt8I@zn.tnic> <CAKwvOdkw0Bbm+=ZyViXQhBE1L6uSbvkstHJuHpQ21tzJRftgAw@mail.gmail.com> <Yj2yYFloadFobRPx@lakrids> <Yj3OEI+WHV/A5uf8@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yj3OEI+WHV/A5uf8@hirez.programming.kicks-ass.net>
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

On Fri, Mar 25, 2022 at 03:13:36PM +0100, Peter Zijlstra wrote:
> 
> +linux-toolchains
> 
> On Fri, Mar 25, 2022 at 12:15:28PM +0000, Mark Rutland wrote:
> > On Thu, Mar 24, 2022 at 11:43:46AM -0700, Nick Desaulniers wrote:
> > > On Thu, Mar 24, 2022 at 4:19 AM Borislav Petkov <bp@alien8.de> wrote:
> > > > The issue is that clang generates a memcpy() call when a struct copy
> > > > happens:
> > > >
> > > >         if (regs != eregs)
> > > >                 *regs = *eregs;
> > > 
> > > Specifically, this is copying one struct pt_regs to another. It looks
> > > like the sizeof struct pt_regs is just large enough to have clang emit
> > > the libcall.
> > > https://godbolt.org/z/scx6aa8jq
> > > Otherwise clang will also use rep; movsq; when -mno-sse -O2 is set and
> > > the structs are below ARBITRARY_THRESHOLD.  Should ARBITRARY_THRESHOLD
> > > be raised so that we continue to inline the memcpy? *shrug*

I win't talk for LLVM, of course...  all of what I'll write here is
assuming LLVM copied the GCC requirement that memcpy is the standard
function, even if freestanding (and also memmove, memset, memcmp).

It is valid to replace any call to memcpy with some open-coded machine
code, or conversely, insert calls to memcpy wherever its semantics are
wanted.

> > > As Mark said in the sibling reply; I don't know of general ways to
> > > inhibit libcall optimizations on the level you're looking for, short
> > > of heavy handy methods of disabling optimizations entirely.  There's
> > > games that can be played with -fno-builtin-*, but they're not super
> > > portable, and I think there's a handful of *blessed* functions that
> > > must exist in any env, freestanding or not: memcpy, memmove, memset,
> > > and memcmp for which you cannot yet express "these do not exist."

The easy, fool-proof, and correct way to prevent a function ending in
a sibling call is to simply not let it end in a call at all.  The best
way I know to do that is insert
  asm("");
right before the end of the function.

> > a) The compiler expects the out-of-line implementations of functions
> >    ARE NOT instrumented by address-sanitizer.
> > 
> >    If this is the case, then it's legitimate for the compiler to call
> >    these functions anywhere, and we should NOT instrument the kernel
> >    implementations of these. If the compiler wants those instrumented it
> >    needs to add the instrumentation in the caller.

The compiler isn't assuming anything about asan.  The compiler generates
its code without any consideration of what asan will or will not do.
The burden of making things work is on asan.

It is legitimate to call (or not call!) memcpy anywhere.  memcpy always
is __builtin_memcpy, which either or not does a function call.

> >    AFAICT The two options for the compiler here are:
> > 
> >    1) Always inline an uninstrumented form of the function in this case
> > 
> >    2) Have distinct instrumented/uninstrumented out-of-line
> >       implementations, and call the uninstrumented form in this case.

The compiler should not do anything differently here if it uses asan.
The address sanitizer and the memcpy function implementation perhaps
have to cooperate somehow, or asan needs more smarts.  This needs to
happen no matter what, to support other things calling memcpy, say,
assembler code.

> > So from those examples it seems GCC falls into bucket (a), and assumes the
> > blessed functions ARE NOT instrumented.

No, it doesn't show GCC assumes anything.  No testing of this kind can
show anything alike.

> > I think something has to change on the compiler side here (e.g. as per
> > options above), and we should align GCC and clang on the same
> > approach...

GCC *requires* memcpy to be the standard memcpy always (i.e. to have the
standard-specified semantics).  This means that it will have the same
semantics as __builtin_memcpy always, and either or not be a call to an
external function.  It can also create calls to it out of thin air.

All of this has been true for thirty years, and it won't change today
either.


Segher
