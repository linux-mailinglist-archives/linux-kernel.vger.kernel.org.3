Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BACF1582240
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 10:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbiG0If3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 04:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbiG0IfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 04:35:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DCF635E
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 01:35:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49E0DB81F86
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 08:35:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA08FC433D6;
        Wed, 27 Jul 2022 08:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658910916;
        bh=W8KSTywxv8G2Xcs47/I9SxaBg1i/Qx1oNyD9P+Y/hyI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YElEd3TizsA4EYQUIS8rkxRr9rDFGkOWkakOmDP7qa1rolLCo+9Qxlyvp1kvgv5Fg
         tBNIMZN3fSyaVMYXTNdYbLahEwhEm2A+xMn8rotMKQf7BOzMHqX3BokHSxvfr1nQ9d
         cKOWSXwNGrg/NAxpEjTGcd6GVgnDRnGXT6wDVXgON6+VViYHoHHqciFQRimP3KQHqW
         wfw6Um+jGLqz+bK8CgMoGaJVrkp2C5ZNKjUiLVGcB8XzvsgXmbLeZ2HQiwPZii8wIX
         ai4Bq722OZ2FVI4dKlN9U3UvJQjiyDr5sQH5FrADWrWGpeaYQ+GD1a58hwRQPqDLoD
         D02lGJveRi1UA==
Date:   Wed, 27 Jul 2022 09:35:11 +0100
From:   Will Deacon <will@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: save movk instructions in mov_q when the lower
 16|32 bits are all zero
Message-ID: <20220727083510.GA22183@willie-the-truck>
References: <20220709084830.3124-1-jszhang@kernel.org>
 <20220719181340.GC14526@willie-the-truck>
 <Yt/vyClCGr5XRPoO@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yt/vyClCGr5XRPoO@xhacker>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 09:44:40PM +0800, Jisheng Zhang wrote:
> On Tue, Jul 19, 2022 at 07:13:41PM +0100, Will Deacon wrote:
> > On Sat, Jul 09, 2022 at 04:48:30PM +0800, Jisheng Zhang wrote:
> > > Currently mov_q is used to move a constant into a 64-bit register,
> > > when the lower 16 or 32bits of the constant are all zero, the mov_q
> > > emits one or two useless movk instructions. If the mov_q macro is used
> > > in hot code path, we want to save the movk instructions as much as
> > > possible. For example, when CONFIG_ARM64_MTE is 'Y' and
> > > CONFIG_KASAN_HW_TAGS is 'N', the following code in __cpu_setup()
> > > routine is the pontential optimization target:
> > > 
> > >         /* set the TCR_EL1 bits */
> > >         mov_q   x10, TCR_MTE_FLAGS
> > > 
> > > Before the patch:
> > > 	mov	x10, #0x10000000000000
> > > 	movk	x10, #0x40, lsl #32
> > > 	movk	x10, #0x0, lsl #16
> > > 	movk	x10, #0x0
> > > 
> > > After the patch:
> > > 	mov	x10, #0x10000000000000
> > > 	movk	x10, #0x40, lsl #32
> > > 
> > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > > ---
> > >  arch/arm64/include/asm/assembler.h | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> > > index 8c5a61aeaf8e..09f408424cae 100644
> > > --- a/arch/arm64/include/asm/assembler.h
> > > +++ b/arch/arm64/include/asm/assembler.h
> > > @@ -568,9 +568,13 @@ alternative_endif
> > >  	movz	\reg, :abs_g3:\val
> > >  	movk	\reg, :abs_g2_nc:\val
> > >  	.endif
> > > +	.if ((((\val) >> 16) & 0xffff) != 0)
> > >  	movk	\reg, :abs_g1_nc:\val
> > >  	.endif
> > > +	.endif
> > > +	.if (((\val) & 0xffff) != 0)
> > >  	movk	\reg, :abs_g0_nc:\val
> > > +	.endif
> > 
> > Please provide some numbers showing that this is worthwhile.
> > 
> 
> No, I have no performance numbers, but here are my opnion
> about this patch: the two checks doesn't add maintaince effort, its
> readability is good, if the two checks can save two movk instructions,
> it's worthwhile to add the checks.

Not unless you can measure a performance increase, no. The code is always
going to be more readable without this stuff added so we shouldn't clutter
our low-level assembly macros with nested conditionals just for fun.

Will
