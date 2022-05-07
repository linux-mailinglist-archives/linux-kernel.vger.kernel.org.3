Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C8C51E7B3
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 16:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391985AbiEGOPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 10:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236242AbiEGOO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 10:14:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702C74889C;
        Sat,  7 May 2022 07:11:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22838B80688;
        Sat,  7 May 2022 14:11:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B80BDC385A5;
        Sat,  7 May 2022 14:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651932668;
        bh=yYbW1VYEkBgjUdJEWnHpf9fQF+9II7U7hTlVk4opQww=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DZaQZ602znpG9kKXvb6U3e1b76WAn84ZMPGk96M+A8YTLWZfwQBTKM2VzF34a5NPm
         xE8ZgFMZebGSGTtzARm52yrtc7RkcYtqGaNKXHedPnnk0nJDxmSQaZf1+us2w7bRRW
         3Q2mUyUlOo/bZ0BirakaLJ4rvo8KwBdhrbVSl/tkSvOmOx1N2+SOd521O2mGqfq86o
         2xS9EavlzWbQ9gji/Z5aM+a/4i0UYTbHVlG9ufFKWIDAJdSRYEihs5iOtiqsk0Bov/
         E+T/dWiQxLA3pxWNEW8ccSIjTpNa9SvsB6NP39eP8MgZzCxooXsreTa+krPwBUqrkG
         NZtajDqUQzZ7Q==
Date:   Sat, 7 May 2022 15:19:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Yannick Brosseau <yannick.brosseau@gmail.com>
Cc:     lars@metafoo.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, fabrice.gasnier@foss.st.com,
        olivier.moysan@foss.st.com, paul@crapouillou.net,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: stm32: Fix check for spurious IRQs on
 STM32F4
Message-ID: <20220507151935.3d3fa270@jic23-huawei>
In-Reply-To: <20220506225617.1774604-3-yannick.brosseau@gmail.com>
References: <20220506225617.1774604-1-yannick.brosseau@gmail.com>
        <20220506225617.1774604-3-yannick.brosseau@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  6 May 2022 18:56:17 -0400
Yannick Brosseau <yannick.brosseau@gmail.com> wrote:

> The check for spurious IRQs introduced in 695e2f5c289bb assumed that the bits
> in the control and status registers are aligned. This is true for the H7 and MP1
> version, but not the F4.
> 
> Instead of comparing both registers bitwise, we check the bit in the status and control
> for each interrupt we are interested in.
> 
> Signed-off-by: Yannick Brosseau <yannick.brosseau@gmail.com>

I don't entirely follow the flow here, so will be relying on the driver
maintainers for feedback on this one (even more than normal!)

One question inline.

Jonathan

> ---
>  drivers/iio/adc/stm32-adc.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index a68ecbda6480..5b0f138333ee 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -1422,9 +1422,10 @@ static irqreturn_t stm32_adc_threaded_isr(int irq, void *data)
>  		return IRQ_HANDLED;
>  	}
>  
> -	if (!(status & mask))
> +	if(!((status & regs->isr_eoc.mask) && (mask & regs->ier_eoc.mask)) ||
> +           ((status & regs->isr_ovr.mask) && (mask & regs->ier_ovr.mask)))

For this second condition if it is true, have we not already entered the previous
if (status & regs->isr_ovr.mask) and hence never reached this check?
There is a comment above that to say if we get there over mask should already be
disable. If that's not true for some reason then we should also adjust that check
and the comment.

Or perhaps I'm getting confused by the bracketing and operator precedence.
Should this not be...

> +	if(!(((status & regs->isr_eoc.mask) && (mask & regs->ier_eoc.mask)) ||
> +          ((status & regs->isr_ovr.mask) && (mask & regs->ier_ovr.mask))))
? So as to be the equivalent of the !(status & mask) just checking bits separately.

>  		dev_err_ratelimited(&indio_dev->dev,
> -				    "Unexpected IRQ: IER=0x%08x, ISR=0x%08x\n",
> +				    "Unexpected IRQ: CR1/IER=0x%08x, SR/ISR=0x%08x\n",
>  				    mask, status);
>  
>  	return IRQ_NONE;
> @@ -1438,7 +1439,9 @@ static irqreturn_t stm32_adc_isr(int irq, void *data)
>  	u32 status = stm32_adc_readl(adc, regs->isr_eoc.reg);
>  	u32 mask = stm32_adc_readl(adc, regs->ier_eoc.reg);
>  
> -	if (!(status & mask))
> +	/* Check that we have the interrupt we care about are enabled and active */
> +        if(!((status & regs->isr_eoc.mask) && (mask & regs->ier_eoc.mask)) ||
> +           ((status & regs->isr_ovr.mask) && (mask & regs->ier_ovr.mask)))
>  		return IRQ_WAKE_THREAD;
>  
>  	if (status & regs->isr_ovr.mask) {

