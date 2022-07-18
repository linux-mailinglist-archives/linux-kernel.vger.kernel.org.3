Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74823578D6A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 00:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbiGRWRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 18:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbiGRWRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 18:17:01 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7D531659A;
        Mon, 18 Jul 2022 15:17:00 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 26IM8fqS005455;
        Mon, 18 Jul 2022 17:08:41 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 26IM8dBn005451;
        Mon, 18 Jul 2022 17:08:39 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 18 Jul 2022 17:08:39 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-hardening@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: mainline build failure of powerpc allmodconfig for prom_init_check
Message-ID: <20220718220839.GF25951@gate.crashing.org>
References: <Ys/aDKZNhhsENH9S@debian> <CADVatmO9XzFnX+N0TuOtr0FYyxKr1oe5RAhCEJjmnvjteT5QNw@mail.gmail.com> <87cze3docs.fsf@mpe.ellerman.id.au> <CAHk-=wgJCTaY5FeNpcw6U-c1Z6c-A2WWQfCVa=1WW3Hdf9_eww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgJCTaY5FeNpcw6U-c1Z6c-A2WWQfCVa=1WW3Hdf9_eww@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 12:06:52PM -0700, Linus Torvalds wrote:
> On Sun, Jul 17, 2022 at 9:41 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
> > >         li 4,254                 #,
> >
> > Here we load 254 into r4, which is the 2nd parameter to memset (c).
> 
> I love how even powerpc people know that "4" is bogus, and have to
> make it clear that it means "r4".

This is compiler output.  Compiler output is mainly meant for the
assembler to produce object code from.  It isn't meant to be readable
(and e.g. -fverbose-asm didn't help much here, that's the "#," ;-) ).

The mnemonic determines what the operands mean.  It is much easier to
read and write "li 4,254" than "li r4,254" or "li %r4,254", all of which
are valid.  You can also write "li 3+1,2*127", but not with the other
forms (this is useful if you use assembler macros, which are way more
powerful and appropriate than abusing the C preprocessor, when writing
assembler code).

It matters more if you have three or four or five or six operands to an
assembler instruction, all the extra line noise makes things illegible.

The "%r4" variant hails from winnt.  It is a bit problematic in inline
assembler, because you need to escape the % in extended inline asm, but
not in basic inline asm.  It also is pure line noise to read.

The "r4" variant is problematic if you have symbols named the same.
When you use the -mregnames assembler option it is taken to mean the
register; you can write "(r6)" to mean the symbol.  (There also are "sp"
and "rtos" and "xer" and whatnot, not just "r4").

> I don't understand why the powerpc assembler is so messed up, and uses
> random integer constants for register "names".

360 was the same.  370 was the same.  390 is the same.  801 was the
same.  RIOS (aka POWER) was the same.  So yes, PowerPC inherited it, I
don't know how much thought was put into this, don't change a winning
team etc.

> And it gets even worse, when you start mixing FP, vector and integer "names".

It is clear from the mnemonic what the operands are: some register, an
immediate, a constant, etc.  An expression (which can include object
symbols) can be any of those.

Assembler language is unforgiving.  It isn't easy to write, and most
mistakes will not be diagnosed.  If the assmbler language makes it
easier to read the code, that makes it more likely correct code will be
written, and that correct code will be written in less time.

> I've seen many bad assemblers (in fact, I have *written* a couple of
> bad assemblers myself), but I have never seen anything quite that
> broken on any other architecture.
> 
> Oddities, yes ("$" as a prefix for register? Alpha asm is also very
> odd), but nothing *quite* as broken as "simple constants have entirely
> different meanings depending on the exact instruction and argument
> position".

What is broken about that?  It makes everything very consistent, and
very readable.  Sigils are just nasty, and having the register names the
same as valid symbol names is also problematic.

> It's not even an IBM thing. S390 uses perfectly sane register syntax,
> and calls things '%r4" etc.

s390 has the same syntax, and even inherited the GAS code for this from
the ppc port.

> The human-written asm files have those #define's in headers just to
> make things slightly more legible, because apparently the assembler
> doesn't even *accept* the sane names.

That was true a long time ago.  And the "#define r0 0" thing caused
quite a few bugs itself btw.

> So it's not even a "the compiler
> generates this abbreviated illegible mess". It's literally that the
> assembler is so horrid.

The disassembler has shown "r4" etc. by default since ages.  The
assembler needs -mregnames to accept it; enabling this by default would
be a compatibility break, not acceptable.

> Why do people put up with that?

Why are people misinformed?

Is there anything in particular in the documentation we could improve?


Hope this helps,


Segher
