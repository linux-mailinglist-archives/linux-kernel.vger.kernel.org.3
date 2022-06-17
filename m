Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61E654FF8E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 23:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236157AbiFQV5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 17:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiFQV53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 17:57:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208825AECC
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 14:57:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D0107B8282A
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 21:57:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A6AC3411B;
        Fri, 17 Jun 2022 21:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655503045;
        bh=1IJ4AD9SFq1euCFzTE9wQhHs0AjfzBgxpQDgrJLIjZo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gMupJjjJouPpcTAJQqVmLCnYU3ixmW3TvO4hicl5a8u2ILov4CQTNdjOoZieWnwLw
         /GunKKORzBj/3fU9+9q5N5TT6GyTamJoqCr61uuK51ky07zN9Kn0Fo47fTadK9FMAx
         eNpt6kC6KTtp/olRvIbqQ+shxi0Ga8+Om7JhyE4qDu54f7pcXbJxcPDdfWJQ0tg4S7
         vl0msjqPtlzKa/R5N4gs5CLiz1JYBFJCHH9hFc91nSAmm+peJ2vHAjxAEieejkT1+6
         W3b9J+fL2u8OjHil3SaC/lD4UxQR8oREFDHnl7/lQkg2GOSKkXfrvSJ0N9CyZKVD1F
         FB263p5UBj7Mg==
Date:   Fri, 17 Jun 2022 14:57:23 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        ndesaulniers@google.com, heiko@sntech.de,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev, jrtc27@jrtc27.com
Subject: Re: [PATCH] riscv: Fix ALT_THEAD_PMA's asm parameters
Message-ID: <Yqz4w3Udrsti3gnm@dev-arch.thelio-3990X>
References: <YqedafxlnoXauefj@dev-arch.thelio-3990X>
 <mhng-9c9a8588-72a2-4e97-85d4-e843e77e3117@palmer-mbp2014>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-9c9a8588-72a2-4e97-85d4-e843e77e3117@palmer-mbp2014>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 02:54:37PM -0700, Palmer Dabbelt wrote:
> On Mon, 13 Jun 2022 13:26:17 PDT (-0700), nathan@kernel.org wrote:
> > On Wed, May 25, 2022 at 07:40:37PM -0700, Nathan Chancellor wrote:
> > > Small ping on this and https://lore.kernel.org/20220516214520.3252074-1-nathan@kernel.org/.
> > > 
> > > Our builds on -next have been broken for a week now. Hopefully these can
> > > make the first RISC-V pull request to avoid mainline being broken in the
> > > same fashion.
> > 
> > One more small ping. The patch linked above made it into 5.19-rc1 but
> > this one has not been applied so our builds are still broken.
> 
> Sorry I dropped the ball on this one, it's in fixes.  Thanks!

Better late than never :) thanks a lot!

Cheers,
Nathan

> > > On Wed, May 18, 2022 at 11:45:29AM -0700, Nathan Chancellor wrote:
> > > > After commit a35707c3d850 ("riscv: add memory-type errata for T-Head"),
> > > > builds with LLVM's integrated assembler fail like:
> > > >
> > > >   In file included from arch/riscv/kernel/asm-offsets.c:10:
> > > >   In file included from ./include/linux/mm.h:29:
> > > >   In file included from ./include/linux/pgtable.h:6:
> > > >   In file included from ./arch/riscv/include/asm/pgtable.h:114:
> > > >   ./arch/riscv/include/asm/pgtable-64.h:210:2: error: invalid input constraint '0' in asm
> > > >           ALT_THEAD_PMA(prot_val);
> > > >           ^
> > > >   ./arch/riscv/include/asm/errata_list.h:88:4: note: expanded from macro 'ALT_THEAD_PMA'
> > > >           : "0"(_val),                                                    \
> > > >             ^
> > > >
> > > > This was reported upstream to LLVM where Jessica pointed out a couple of
> > > > issues with the existing implementation of ALT_THEAD_PMA:
> > > >
> > > > * t3 is modified but not listed in the clobbers list.
> > > >
> > > > * "+r"(_val) marks _val as both an input and output of the asm but then
> > > >   "0"(_val) marks _val as an input matching constraint, which does not
> > > >   make much sense in this situation, as %1 is not actually used in the
> > > >   asm and matching constraints are designed to be used for different
> > > >   inputs that need to use the same register.
> > > >
> > > > Drop the matching contraint and shift all the operands by one, as %1 is
> > > > unused, and mark t3 as clobbered. This resolves the build error and goes
> > > > not cause any problems with GNU as.
> > > >
> > > > Fixes: a35707c3d850 ("riscv: add memory-type errata for T-Head")
> > > > Link: https://github.com/ClangBuiltLinux/linux/issues/1641
> > > > Link: https://github.com/llvm/llvm-project/issues/55514
> > > > Link: https://gcc.gnu.org/onlinedocs/gcc/Simple-Constraints.html
> > > > Suggested-by: Jessica Clarke <jrtc27@jrtc27.com>
> > > > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > > > ---
> > > >  arch/riscv/include/asm/errata_list.h | 14 +++++++-------
> > > >  1 file changed, 7 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
> > > > index 9e2888dbb5b1..416ead0f9a65 100644
> > > > --- a/arch/riscv/include/asm/errata_list.h
> > > > +++ b/arch/riscv/include/asm/errata_list.h
> > > > @@ -75,20 +75,20 @@ asm volatile(ALTERNATIVE(						\
> > > >  	"nop\n\t"							\
> > > >  	"nop\n\t"							\
> > > >  	"nop",								\
> > > > -	"li      t3, %2\n\t"						\
> > > > -	"slli    t3, t3, %4\n\t"					\
> > > > +	"li      t3, %1\n\t"						\
> > > > +	"slli    t3, t3, %3\n\t"					\
> > > >  	"and     t3, %0, t3\n\t"					\
> > > >  	"bne     t3, zero, 2f\n\t"					\
> > > > -	"li      t3, %3\n\t"						\
> > > > -	"slli    t3, t3, %4\n\t"					\
> > > > +	"li      t3, %2\n\t"						\
> > > > +	"slli    t3, t3, %3\n\t"					\
> > > >  	"or      %0, %0, t3\n\t"					\
> > > >  	"2:",  THEAD_VENDOR_ID,						\
> > > >  		ERRATA_THEAD_PBMT, CONFIG_ERRATA_THEAD_PBMT)		\
> > > >  	: "+r"(_val)							\
> > > > -	: "0"(_val),							\
> > > > -	  "I"(_PAGE_MTMASK_THEAD >> ALT_THEAD_PBMT_SHIFT),		\
> > > > +	: "I"(_PAGE_MTMASK_THEAD >> ALT_THEAD_PBMT_SHIFT),		\
> > > >  	  "I"(_PAGE_PMA_THEAD >> ALT_THEAD_PBMT_SHIFT),			\
> > > > -	  "I"(ALT_THEAD_PBMT_SHIFT))
> > > > +	  "I"(ALT_THEAD_PBMT_SHIFT)					\
> > > > +	: "t3")
> > > >  #else
> > > >  #define ALT_THEAD_PMA(_val)
> > > >  #endif
> > > >
> > > > base-commit: 93c0651617a62a69717299f1464dda798af8bebb
> > > > --
> > > > 2.36.1
> > > >
> > > >
> > > > _______________________________________________
> > > > linux-riscv mailing list
> > > > linux-riscv@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> > > 
