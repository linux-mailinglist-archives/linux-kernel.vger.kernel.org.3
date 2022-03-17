Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC924DD125
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 00:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiCQX1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 19:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiCQX1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 19:27:50 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0DA8728AC7B;
        Thu, 17 Mar 2022 16:26:32 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 22HNK0JT030658;
        Thu, 17 Mar 2022 18:20:00 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 22HNJxhb030657;
        Thu, 17 Mar 2022 18:19:59 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Thu, 17 Mar 2022 18:19:59 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Bill Wendling <morbo@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, llvm@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        linux-toolchains <linux-toolchains@vger.kernel.org>
Subject: Re: [PATCH v5] x86: use builtins to read eflags
Message-ID: <20220317231959.GN614@gate.crashing.org>
References: <CAGG=3QVu5QjQK8m2FWiYn-XQuVBjUGXcbznSbK22jVMB5GAutw@mail.gmail.com> <F5296439-4CA3-4F31-BD91-5ED1510BC382@zytor.com> <CAKwvOdkk-C8HMemKs4+yoxvNDgTLmvZG1rmwjVXBqhsQ-cED5g@mail.gmail.com> <CAHk-=whJfKN8Jag=8DS=pbZR3TY90znUOP6Km+TLRJ9dZEgNqw@mail.gmail.com> <CAGG=3QW2ey2w91TxqJ6tzfJOswhTce2e0QTW7kAWyvxeiO+VNg@mail.gmail.com> <CAHk-=whn3iYE7gZM4vHx1kFhWBD2P9Wvmcyj8OOqv=y_7nemGQ@mail.gmail.com> <CAGG=3QWC9VS9RdGFTwY8VGqujDnFYnRTT1dQ6kkVr+0SRk6COg@mail.gmail.com> <CAHk-=wh=x7oCk05JD1=6XNsvvgpsidRWupoqySw1zODmvNy9Ug@mail.gmail.com> <CAGG=3QWcKof_NXrC0kznM2ikwTA00AgUJrcWhKBTitmjCuOxqw@mail.gmail.com> <CAHk-=wj=aK2T+h=rRJL4jDDTgV2U533E_duroCoVSUfkvYd0OQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj=aK2T+h=rRJL4jDDTgV2U533E_duroCoVSUfkvYd0OQ@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 03:51:28PM -0700, Linus Torvalds wrote:
> On Thu, Mar 17, 2022 at 2:45 PM Bill Wendling <morbo@google.com> wrote:
> > I'm NOT saying that it WILL change or that it SHOULD change. I'm also
> > not saying that your concern isn't justified. What I am saying is that
> > unless you're using a compiler feature that's DEFINED as having a
> > certain effect, then you are not using that feature correctly,
> > regardless of how it's acted in the past. And it has the potential to
> > bite you in the ass sooner or later. We've all seen such things happen
> > before.
> 
> So I think most of inline asm constraints are fairly well defined.
> Certainly "memory" clobbers are.
> 
> The unfortunate exception to this is, I think, "volatile".  It has
> always had somewhat undefined semantics (iirc originally gcc talked
> about it not being "moved significantly" etc), and it ends up getting
> mixed reasons for existing.

"asm volatile" has always meant "has some unspecified side effect", in
parallel with what a volatile object is in C (there, all *accesses* to
such objects have the side effects).  All such side effects have to
happen on the real machine in the same order (and exactly as often) as
on the abstract C machine.  This is all it means, nothing more, nothing
less.

This is a little hard to understand, certainly for most users, who do
not often have heard of the abstract machine before (which is a shame,
because *all* of C semantics are defined wrt that).

> The *natural* semantics would be to literally make it have the same
> rules as volatile data accesses: something like "'volatile' marks the
> asm as having visible side effects in the virtual machine".

Not necessarily visible, that is the point even, but yes :-)

> So I think natural semantics for "asm volatile" - and the ones that
> would be simple to document - would literally be to compare it to
> those volatile memory accesses, and say that it can't be optimized
> away, and it's ordered wrt other volatile operations (whether volatile
> data accesses or other volatile asm instructions).

"Cannot be optimised away" means something else to everyone, and almost
all of those meanings do not correspond to the truth very well.

> And then we in the kernel have then also co-opted 'asm volatile' to
> just fix some compiler bugs, so we end up using "asm volatile goto"
> because of
> 
>       http://gcc.gnu.org/bugzilla/show_bug.cgi?id=58670
> 
> although *that* particular issue is probably historical now that we
> require more modern compiler versions.

Thankfully.  The barrier_before_unreachable() thing in compiler-gcc.h
needs some newer GCC 7 (.3 or .4 I think?), so that is still needed for
a while more.  The barrier() one in compiler.h is probably not a bug
anymore since decades, it is from before the kernel started documenting
what versions of required tools have what known bugs, apparently ;-)

> I still think that from a sanity standpoint, it would be good to
> actually strengthen the semantics of "asm volatile" to literally act
> as - and be ordered with - volatile memory accesses.
> 
> But I guess that's water under the bridge.

That is what it has actually done since forever.  See C 5.1.2.3.  For
GCC, "asm volatile" has a side effect like in /2 there as well, as does
unspec_volatile (an internal GCC thing used to implement certain
builtins, among other things).

"asm volatile" does not mean, and has never meant, anything like "can
not be deleted" or "can not be cloned".  "Cannot be moved significantly"
is vague enough that it isn't untrue (but isn't very helpful either).


Segher
