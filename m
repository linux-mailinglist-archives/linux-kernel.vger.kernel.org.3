Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415D9581489
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 15:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiGZNxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 09:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiGZNxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 09:53:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1772529C
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 06:53:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 965B0B81649
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 13:53:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60604C433C1;
        Tue, 26 Jul 2022 13:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658843622;
        bh=Q8EDUoUoIfZ8TB6aJhkSBmIUfxX4ZXZBCvhBlkyNBC0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lrmPROKxwKLYn+8T+AWGXjuFFwZuJlVmYnEMm5/H9JXJVhicdtk4NjdTPeNoV0v5W
         qx42zzf60YxTytQx+FjH7haQ1TP1ImunoAiRFWfH8+yIeeNW+GVW4rMUVdVvmJUehb
         CSiOGSwGg9c6PfTJzbhZTfNqPx7yEXJn1g0rLrkxHpcFzK4SKxa5gzPXS9egjdm0gr
         LjI+h6LmFHSeQsYRZq3Zwc7QymIii47mwS70b8VUagFJfibaNXM79J1Cgyg91KATlH
         NeTxpOSKhH52iyMi1cpSAQgjsQpew0+Dm8ZNXzBFMBLgN5xYb+v5ce9KIAHUc0TbZe
         H1yVRQazZUJMQ==
Date:   Tue, 26 Jul 2022 21:44:40 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: save movk instructions in mov_q when the lower
 16|32 bits are all zero
Message-ID: <Yt/vyClCGr5XRPoO@xhacker>
References: <20220709084830.3124-1-jszhang@kernel.org>
 <20220719181340.GC14526@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220719181340.GC14526@willie-the-truck>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 07:13:41PM +0100, Will Deacon wrote:
> On Sat, Jul 09, 2022 at 04:48:30PM +0800, Jisheng Zhang wrote:
> > Currently mov_q is used to move a constant into a 64-bit register,
> > when the lower 16 or 32bits of the constant are all zero, the mov_q
> > emits one or two useless movk instructions. If the mov_q macro is used
> > in hot code path, we want to save the movk instructions as much as
> > possible. For example, when CONFIG_ARM64_MTE is 'Y' and
> > CONFIG_KASAN_HW_TAGS is 'N', the following code in __cpu_setup()
> > routine is the pontential optimization target:
> > 
> >         /* set the TCR_EL1 bits */
> >         mov_q   x10, TCR_MTE_FLAGS
> > 
> > Before the patch:
> > 	mov	x10, #0x10000000000000
> > 	movk	x10, #0x40, lsl #32
> > 	movk	x10, #0x0, lsl #16
> > 	movk	x10, #0x0
> > 
> > After the patch:
> > 	mov	x10, #0x10000000000000
> > 	movk	x10, #0x40, lsl #32
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  arch/arm64/include/asm/assembler.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> > index 8c5a61aeaf8e..09f408424cae 100644
> > --- a/arch/arm64/include/asm/assembler.h
> > +++ b/arch/arm64/include/asm/assembler.h
> > @@ -568,9 +568,13 @@ alternative_endif
> >  	movz	\reg, :abs_g3:\val
> >  	movk	\reg, :abs_g2_nc:\val
> >  	.endif
> > +	.if ((((\val) >> 16) & 0xffff) != 0)
> >  	movk	\reg, :abs_g1_nc:\val
> >  	.endif
> > +	.endif
> > +	.if (((\val) & 0xffff) != 0)
> >  	movk	\reg, :abs_g0_nc:\val
> > +	.endif
> 
> Please provide some numbers showing that this is worthwhile.
> 

No, I have no performance numbers, but here are my opnion
about this patch: the two checks doesn't add maintaince effort, its
readability is good, if the two checks can save two movk instructions,
it's worthwhile to add the checks.


Thanks
