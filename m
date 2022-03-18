Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3174DD1C6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 01:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiCRANi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 20:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbiCRANd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 20:13:33 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 86E87141D9E;
        Thu, 17 Mar 2022 17:12:13 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 22I05gcE000704;
        Thu, 17 Mar 2022 19:05:42 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 22I05eqi000699;
        Thu, 17 Mar 2022 19:05:40 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Thu, 17 Mar 2022 19:05:40 -0500
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
Message-ID: <20220318000540.GO614@gate.crashing.org>
References: <CAKwvOdkk-C8HMemKs4+yoxvNDgTLmvZG1rmwjVXBqhsQ-cED5g@mail.gmail.com> <CAHk-=whJfKN8Jag=8DS=pbZR3TY90znUOP6Km+TLRJ9dZEgNqw@mail.gmail.com> <CAGG=3QW2ey2w91TxqJ6tzfJOswhTce2e0QTW7kAWyvxeiO+VNg@mail.gmail.com> <CAHk-=whn3iYE7gZM4vHx1kFhWBD2P9Wvmcyj8OOqv=y_7nemGQ@mail.gmail.com> <CAGG=3QWC9VS9RdGFTwY8VGqujDnFYnRTT1dQ6kkVr+0SRk6COg@mail.gmail.com> <CAHk-=wh=x7oCk05JD1=6XNsvvgpsidRWupoqySw1zODmvNy9Ug@mail.gmail.com> <CAGG=3QWcKof_NXrC0kznM2ikwTA00AgUJrcWhKBTitmjCuOxqw@mail.gmail.com> <CAHk-=wj=aK2T+h=rRJL4jDDTgV2U533E_duroCoVSUfkvYd0OQ@mail.gmail.com> <20220317231959.GN614@gate.crashing.org> <CAHk-=wgHgSJ-suTT6V6_2USPDrdmQweLR_M_YHjb8OsQvYWn-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wgHgSJ-suTT6V6_2USPDrdmQweLR_M_YHjb8OsQvYWn-w@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 04:31:19PM -0700, Linus Torvalds wrote:
> On Thu, Mar 17, 2022 at 4:25 PM Segher Boessenkool
> <segher@kernel.crashing.org> wrote:
> >
> > > I still think that from a sanity standpoint, it would be good to
> > > actually strengthen the semantics of "asm volatile" to literally act
> > > as - and be ordered with - volatile memory accesses.
> > >
> > > But I guess that's water under the bridge.
> >
> > That is what it has actually done since forever.  See C 5.1.2.3.  For
> > GCC, "asm volatile" has a side effect like in /2 there as well, as does
> > unspec_volatile (an internal GCC thing used to implement certain
> > builtins, among other things).
> 
> Oh, so two "asm volatile" statements _are_ in fact defined to be
> ordered wrt each other?

Colloquially you could say that.  But that statement can be understood
to mean more than the actual guarantee (and it is also much less than
it, oin the positive side).

> Because the gcc docs certainly don't say that ;(

Older GCC docs said
  You will also want to add the volatile keyword if the memory affected
  is not listed in the inputs or outputs of the asm, as the `memory'
  clobber does not count as a side-effect of the asm.

and
  The volatile keyword indicates that the instruction has important
  side-effects. GCC will not delete a volatile asm if it is reachable.
  (The instruction can still be deleted if GCC can prove that
  control-flow will never reach the location of the instruction.) Note
  that even a volatile asm instruction can be moved relative to other
  code, including across jump instructions.

and
  Similarly, you can't expect a sequence of volatile asm instructions to
  remain perfectly consecutive. If you want consecutive output, use a
  single asm. Also, GCC will perform some optimizations across a
  volatile asm instruction; GCC does not “forget everything” when it
  encounters a volatile asm instruction the way some other compilers do.

The internal assembler docs were rewritten later, because they were
considered too terse, too hard for users to understand.  But they may
have lost some clarity in the process.

> Yeah, yeah, dead code can be removed, whether volatile or not. That's
> true of "*(volatile int *)x" too. It's not the dead code that is the
> interesting case, though..

Internally to GCC this is the same in most ways, too; it's no accident
this things correspond so well :-)

> Is this also well-defined ordering-wise:
> 
>     asm volatile("do_something");
>     WRITE_ONCE(x, 1);
> 
> (where "WRITE_ONCE()" is that kernel macro that just uses a volatile
> pointer assignment to force the access)?

The macro in asm-generic is

#define __WRITE_ONCE(x, val)                                            \
do {                                                                    \
        *(volatile typeof(x) *)&(x) = (val);                            \
} while (0)

which will work fine given the undocumented C extension I mentioned in
https://gcc.gnu.org/PR33053 (this will be part of C2x as well btw).

I don't know if all arch-specific versions are fine.

> And could we get that documented?

Could you open a GCC PR for it?  I can do it, but you know better what
you want, and I might forget, etc.


Segher
