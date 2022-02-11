Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946FF4B244F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 12:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349455AbiBKLck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 06:32:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234009AbiBKLci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 06:32:38 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 691AEE86
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 03:32:37 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D23A51042;
        Fri, 11 Feb 2022 03:32:36 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.87.94])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 54B423F73B;
        Fri, 11 Feb 2022 03:32:32 -0800 (PST)
Date:   Fri, 11 Feb 2022 11:32:27 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>, acme@redhat.com,
        ardb@kernel.org, bp@alien8.de, broonie@kernel.org,
        catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        jpoimboe@redhat.com, jslaby@suse.cz,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        mingo@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        will@kernel.org, llvm@lists.linux.dev,
        James Y Knight <jyknight@google.com>
Subject: Re: [PATCH v2 2/7] linkage: add SYM_{ENTRY,START,END}_AT()
Message-ID: <YgZJS6mDoAgVqC4l@FVFF77S0Q05N>
References: <20220125113200.3829108-1-mark.rutland@arm.com>
 <20220125113200.3829108-3-mark.rutland@arm.com>
 <YgUmvuJYfycnhODA@FVFF77S0Q05N>
 <CAKwvOdmWV6AL2RM2SQNYQ7fu3kQwPf+W57LZ_szrfZm2eLtBcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdmWV6AL2RM2SQNYQ7fu3kQwPf+W57LZ_szrfZm2eLtBcw@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 05:20:10PM -0800, Nick Desaulniers wrote:
> On Thu, Feb 10, 2022 at 6:52 AM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > Both GCC and clang are happy to treat labels as constant expressions:
> >
> > | [mark@lakrids:~/asm-test]% cat test-label.S
> > |         .text
> > |
> > | start:
> > |         nop
> > | end:
> > |
> > |         .if (end - start) == 0
> > |         .err
> > |         .endif
> > |
> > | [mark@lakrids:~/asm-test]% usekorg 11.1.0 aarch64-linux-gcc -c test-label.S
> > | [mark@lakrids:~/asm-test]% usellvm 13.0.0 clang --target=aarch64-linux -c test-label.S
> >
> > ... but only GCC is happy to treat symbol definitions as constants:
> >
> > | [mark@lakrids:~/asm-test]% cat test-symbol.S
> > |         .text
> > |
> > | .set start, .;
> > |         nop
> > | .set end, .;
> > |
> > |         .if (end - start) == 0
> > |         .err
> > |         .endif
> > |
> > | [mark@lakrids:~/asm-test]% usekorg 11.1.0 aarch64-linux-gcc -c test-symbol.S
> > | [mark@lakrids:~/asm-test]% usellvm 13.0.0 clang --target=aarch64-linux -c test-symbol.S
> > | test-symbol.S:7:6: error: expected absolute expression
> > |  .if (end - start) == 0
> > |      ^
> > | test-symbol.S:8:2: error: .err encountered
> > |  .err
> > |  ^
> >
> > This is obviously a behavioural difference, but I'm not sure whether it's
> > intentional, or just an artifact of the differing implementation of GNU as and
> > LLVM's integrated assembler. Nich, Nathan, any thoughts on that?
> >
> > Does clang have any mechanism other than labels to define location constants
> > that can be used as absolute expressions? e.g. is there any mechanism to alias
> > a label which results in the alias also being a constant?
> 
> s/constant/absolute/

Sorry, yes. I wasn't clear on the terminology when I wrote this, and I realise
now what I said was a bit confused.

IIUC the symbols themselves are relocatable (rather than absolute) whether
they're labels or created via `.set`, since the base of the section hasn't been
set yet. The difference between the two *should* be absolute (since they're
both relocatable relative to the same base), and LLVM can figure that out for
two labels, but not when either is created via `.set`, so it seems some
information is tracked differently for labels and othey symbols?

I note LLVM *can* treat the result of a `.set` as absolute, eg. if I do:

	.set sym_offset (label_end - label_start)
	.if sym_offset == 0
	.err
	.endif

... LLVM treats `sym_offset` as an absolute value.

> Nothing off the top of my head comes to mind as a substitute that will
> work as expected today.
> 
> I've filed https://github.com/llvm/llvm-project/issues/53728 to
> discuss more with folks that understand our AsmParser better.

Thanks!

> From what I can tell, our AsmParser is falling down because the
> operands of the binary expression themselves are not considered
> absolute.

IIUC even in the label case the operands aren't absolute, but rather that
they're relocatable relative to the same base, and hence the expression can be
evaluate to be absolute (since the base gets cancelled out, removing the
relocation).

So is there something that gets tracked differently for labels and other
symbols?

> I doubt we will be able to handle the general case of symbol
> differencing; the symbol reference operands could refer to symbols in
> different sections that haven't been laid out yet (or whose order
> could be shuffled by the linker).  But if they're in the same section
> (or "fragment" of a section), we might be able to special case this.

Sure, I think the only case that needs to work (or can work conceptually) is
when they're in the same section (of fragment thereof), and that's all the GNU
assembler supports.

> For the expression
> 
> > .if (qwerty_fiqin_end - qwerty_fiqin_start) > (0x200 - 0x1c)
> 
> can you use local labels (`.L` prefix) rather than symbolic
> references? or is there a risk of them not being unique per TU?

For the problem in this patch I might be able to do something of that shape,
but I'll need to factor the SYM_*() helpers differently so that I can use
labels for the primary definition.

I can't do that for the aliases, since I don't know the set of aliases until
after the primary definition is created. Since there's no label aliasing
mechanism, I must use symbol references. However, I think I can propagate the
size by calculating alongside the primary definition, e.g.

	primary_start:
		nop
	primary_end:
	.set primary_size, (primary_end - primary_start)

	.set alias_start, primary_start
	.set alias_end,   primary_end
	.set alias_size,  primary_size

... so I'll have a go at that.

However, that still means I can't treat aliases as entirely equivalent to the
primary definition, e.g.

	.if (alias_end - alias_start) == 0
	.err
	.endif

... and there might be more things of that sort of shape, so it'd be good if
LLVM could handle this for symbol references (in the same section or fragment
thereof), so that we have the chance to use that in future.

Thanks,
Mark.
