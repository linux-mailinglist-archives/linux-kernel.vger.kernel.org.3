Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5AB46F7DC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 01:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbhLJALq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 19:11:46 -0500
Received: from gate.crashing.org ([63.228.1.57]:56158 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231592AbhLJALp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 19:11:45 -0500
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 1BA01m5F024581;
        Thu, 9 Dec 2021 18:01:48 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 1BA01ljO024580;
        Thu, 9 Dec 2021 18:01:47 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Thu, 9 Dec 2021 18:01:47 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     Marco Elver <elver@google.com>,
        Kees Cook <keescook@www.chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>,
        Peter Collingbourne <pcc@google.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-toolchains@vger.kernel.org
Subject: Re: randomize_kstack: To init or not to init?
Message-ID: <20211210000147.GZ614@gate.crashing.org>
References: <YbHTKUjEejZCLyhX@elver.google.com> <202112091232.51D0DE5535@keescook> <CANpmjNPJpbKzO46APQgxeirYV=K5YwCw3yssnkMKXG2SGorUPw@mail.gmail.com> <CAG_fn=WEOb_3_u3CrAG36=j_moeHu0hmFmqM+sXSTepnN8kLjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=WEOb_3_u3CrAG36=j_moeHu0hmFmqM+sXSTepnN8kLjw@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 10:11:19PM +0100, Alexander Potapenko wrote:
> On Thu, Dec 9, 2021 at 9:54 PM Marco Elver <elver@google.com> wrote:
> >
> > On Thu, 9 Dec 2021 at 21:48, Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Thu, Dec 09, 2021 at 10:58:01AM +0100, Marco Elver wrote:
> > > > Clang supports CONFIG_INIT_STACK_ALL_ZERO, which appears to be the
> > > > default since dcb7c0b9461c2, which is why this came on my radar. And
> > > > Clang also performs auto-init of allocas when auto-init is on
> > > > (https://reviews.llvm.org/D60548), with no way to skip. As far as I'm
> > > > aware, GCC 12's upcoming -ftrivial-auto-var-init= doesn't yet auto-init
> > > > allocas.
> > > >
> > > > add_random_kstack_offset() uses __builtin_alloca() to add a stack
> > > > offset. This means, when CONFIG_INIT_STACK_ALL_{ZERO,PATTERN} is
> > > > enabled, add_random_kstack_offset() will auto-init that unused portion
> > > > of the stack used to add an offset.
> > > >
> > > > There are several problems with this:
> > > >
> > > >       1. These offsets can be as large as 1023 bytes. Performing
> > > >          memset() on them isn't exactly cheap, and this is done on
> > > >          every syscall entry.
> > > >
> > > >       2. Architectures adding add_random_kstack_offset() to syscall
> > > >          entry implemented in C require them to be 'noinstr' (e.g. see
> > > >          x86 and s390). The potential problem here is that a call to
> > > >          memset may occur, which is not noinstr.
> > > >
> > > > A defconfig kernel with Clang 11 and CONFIG_VMLINUX_VALIDATION shows:
> > > >
> > > >  | vmlinux.o: warning: objtool: do_syscall_64()+0x9d: call to memset() leaves .noinstr.text section
> > > >  | vmlinux.o: warning: objtool: do_int80_syscall_32()+0xab: call to memset() leaves .noinstr.text section
> > > >  | vmlinux.o: warning: objtool: __do_fast_syscall_32()+0xe2: call to memset() leaves .noinstr.text section
> > > >  | vmlinux.o: warning: objtool: fixup_bad_iret()+0x2f: call to memset() leaves .noinstr.text section
> > > >
> > > > Switching to INIT_STACK_ALL_NONE resolves the warnings as expected.
> > > >
> > > > To figure out what the right solution is, the first thing to figure out
> > > > is, do we actually want that offset portion of the stack to be
> > > > auto-init'd?
> > > >
> > > > There are several options:
> > > >
> > > >       A. Make memset (and probably all other mem-transfer functions)
> > > >          noinstr compatible, if that is even possible. This only solves
> > > >          problem #2.
> > >
> > > I'd agree: "A" isn't going to work well here.
> > >
> > > >
> > > >       B. A workaround could be using a VLA with
> > > >          __attribute__((uninitialized)), but requires some restructuring
> > > >          to make sure the VLA remains in scope and other trickery to
> > > >          convince the compiler to not give up that stack space.
> > >
> > > I was hoping the existing trickery would work for a VLA, but it seems
> > > not. It'd be nice if it could work with a VLA, which could just gain the
> > > attribute and we'd be done.
> > >
> > > >       C. Introduce a new __builtin_alloca_uninitialized().
> > >
> > > Hrm, this means conditional logic between compilers, too. :(
> >
> > And as Segher just pointed out, I think Clang has a "bug" because
> > explicit alloca() calls aren't "automatic storage". I think Clang
> > needs a new -mllvm param.
> 
> I don't think the original Clang flag was built with just "automatic
> storage" in mind.

My comment was about the GCC -ftrivial-auto-var-init= flag.  It only
influences automatic variables, as the name suggests :-)

What it does is it adds an initialiser for the variable early on, long
before it is generating anything like target code.  Handling alloca has
to be done somewhere different (and probably should have its own flag
anyway).

> Now that there's a single call to __builtin_alloca() that happens to
> suffer from initialization, it is hard to justify that initializing
> allocas is a good thing to do.

The same argument holds for *all* unnecessary initialisations, btw; it
just isn't obvious what it costs for a single simple variable, but it
all adds up.

> But I believe developers in other projects don't want to worry about
> how they allocate their memory when turning stack initialization on -
> they just want to be on the safe side.

Sure.  And the kernel has a tiny stack anyway, so unless that alloca is
in a hot path (or wastefully allocates way more than is actually used),
initialising stuff isn't worse than anywhere else, just more obvious to
spot in your profiles (everything will easily fit in cache after all).


Segher
