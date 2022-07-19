Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6B357A642
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 20:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239986AbiGSSNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 14:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237451AbiGSSNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 14:13:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E476545C4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 11:13:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B56D261740
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 18:13:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC2A6C341C6;
        Tue, 19 Jul 2022 18:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658254425;
        bh=iZwXTyMNpEQ50zZbh05mNc14Gm/f4Z9Rfi+qabFvA1c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rDAtr2M2cuN2AdEV/FpoFht7BEurJGXY0+zVgHwFRwGe8PEQ0QFlpwr8/J64Y32Cx
         pGg8vvHiatg+JbJ+niUyUy/mFeuba0hXxxKfPaaKIflKDFuDVIYrjS01AkzIoNQNDM
         Eo/BpAJJDT1TgMSOIdLoQsJ75wLKNIkaJn8OsBfpnYE7cNrGzjo5Pdk8F8fSo0ygAQ
         YZ+6KjRU8ZwjcBDtxs1Tkq/3PXNx9OWOHyuie4PeOEeqn8eiKWD24jnYYVCaau36Pi
         47cl/iY9hFYoB19vd4e+WEtgyG7TZLYLxiEv78UzqFeQ8DOV+Bg+/KG+J1dim8KQh5
         fOU5YutpUA7Mw==
Date:   Tue, 19 Jul 2022 19:13:41 +0100
From:   Will Deacon <will@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: save movk instructions in mov_q when the lower
 16|32 bits are all zero
Message-ID: <20220719181340.GC14526@willie-the-truck>
References: <20220709084830.3124-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220709084830.3124-1-jszhang@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 09, 2022 at 04:48:30PM +0800, Jisheng Zhang wrote:
> Currently mov_q is used to move a constant into a 64-bit register,
> when the lower 16 or 32bits of the constant are all zero, the mov_q
> emits one or two useless movk instructions. If the mov_q macro is used
> in hot code path, we want to save the movk instructions as much as
> possible. For example, when CONFIG_ARM64_MTE is 'Y' and
> CONFIG_KASAN_HW_TAGS is 'N', the following code in __cpu_setup()
> routine is the pontential optimization target:
> 
>         /* set the TCR_EL1 bits */
>         mov_q   x10, TCR_MTE_FLAGS
> 
> Before the patch:
> 	mov	x10, #0x10000000000000
> 	movk	x10, #0x40, lsl #32
> 	movk	x10, #0x0, lsl #16
> 	movk	x10, #0x0
> 
> After the patch:
> 	mov	x10, #0x10000000000000
> 	movk	x10, #0x40, lsl #32
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/arm64/include/asm/assembler.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> index 8c5a61aeaf8e..09f408424cae 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -568,9 +568,13 @@ alternative_endif
>  	movz	\reg, :abs_g3:\val
>  	movk	\reg, :abs_g2_nc:\val
>  	.endif
> +	.if ((((\val) >> 16) & 0xffff) != 0)
>  	movk	\reg, :abs_g1_nc:\val
>  	.endif
> +	.endif
> +	.if (((\val) & 0xffff) != 0)
>  	movk	\reg, :abs_g0_nc:\val
> +	.endif

Please provide some numbers showing that this is worthwhile.

Will
