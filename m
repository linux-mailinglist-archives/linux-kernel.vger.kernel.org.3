Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1EC47D04E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 11:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244255AbhLVKty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 05:49:54 -0500
Received: from foss.arm.com ([217.140.110.172]:43550 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239538AbhLVKtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 05:49:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CC511FB;
        Wed, 22 Dec 2021 02:49:52 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF26B3F5A1;
        Wed, 22 Dec 2021 02:49:50 -0800 (PST)
Date:   Wed, 22 Dec 2021 10:49:47 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Michael Wu <michael@allwinnertech.com>
Cc:     ulf.hansson@linaro.org, mripard@kernel.org, wens@csie.org,
        samuel@sholland.org, jernej.skrabec@gmail.com,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mmc: sunxi-mmc: use pll to increase clock speed
Message-ID: <20211222104947.1d978864@donnerap.cambridge.arm.com>
In-Reply-To: <20211222031557.34242-1-michael@allwinnertech.com>
References: <20211222031557.34242-1-michael@allwinnertech.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Dec 2021 11:15:57 +0800
Michael Wu <michael@allwinnertech.com> wrote:

Hi Michael,

> Default clock soucre is 24M,if we want clock over 24M
> We should use pll as clock source

Can you say what this patch actually fixes? What is the problem?

As far as I know, we don't have any issues with MMC clock frequencies, and
are basically always using the PLL as the clock source. This is
handled automatically by the common clock framework, which knows about all
possible muxes and their parents:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clk/sunxi-ng/ccu-sun50i-a64.c#n417
In fact that also probably explains the issue you address in patch 2/3.

One more comment below.

> 
> Signed-off-by: Michael Wu <michael@allwinnertech.com>
> ---
>  drivers/mmc/host/sunxi-mmc.c | 57 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 56 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 7b47ec453fb6..0039ee58b303 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -756,6 +756,57 @@ static int sunxi_mmc_clk_set_phase(struct sunxi_mmc_host *host,
>  	return 0;
>  }
>  
> +/**
> + *
> + * sunxi_clk_get_parent() - get parent pll from dts
> + * @host:		sunxi_mmc_host struct point
> + * @@clock:		the clock frequency that requested
> + *
> + * Default clock source is 24M,if we want clock over 24M,We should use
> + * pll as clock soure
> + *
> + * Return:the 0:ok,other:failed
> + */
> +static int sunxi_clk_get_parent(struct sunxi_mmc_host *host, u32 clock)
> +{
> +	struct clk *sclk = NULL;
> +	char *sclk_name = NULL;
> +	u32 src_clk = 0;
> +	s32 err = 0;
> +	struct device *dev = mmc_dev(host->mmc);
> +
> +	sclk = clk_get(dev, "osc24m");
> +	sclk_name = "osc24m";

This "getting clocks by their global name" is not the way it should work,
you just reference clocks you get from your very own DT node (devm_clk_get()).
This is probably something that the BSP kernel does very differently?

Cheers,
Andre

> +
> +	if (IS_ERR(sclk)) {
> +		dev_err(mmc_dev(host->mmc), "Error to get source clock %s\n",
> +				sclk_name);
> +		return PTR_ERR(sclk);
> +	}
> +
> +	src_clk = clk_get_rate(sclk);
> +	if (clock > src_clk) {
> +		clk_put(sclk);
> +		sclk = clk_get(dev, "pll_periph");
> +		sclk_name = "pll_periph";
> +	}
> +	if (IS_ERR(sclk)) {
> +		dev_err(mmc_dev(host->mmc), "Error to get source clock %s\n",
> +				sclk_name);
> +		return PTR_ERR(sclk);
> +	}
> +
> +	err = clk_set_parent(host->clk_mmc, sclk);
> +	if (err) {
> +		dev_err(mmc_dev(host->mmc), "set parent failed\n");
> +		clk_put(sclk);
> +		return err;
> +	}
> +	clk_put(sclk);
> +	return 0;
> +}
> +
> +
>  static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
>  				  struct mmc_ios *ios)
>  {
> @@ -801,7 +852,11 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
>  			return ret;
>  		}
>  	}
> -
> +	/**
> +	 * No check return value,because dts may not have osc24M, and pll_periph,
> +	 * at that time,use default value from clk system
> +	 */
> +	sunxi_clk_get_parent(host, clock);
>  	rate = clk_round_rate(host->clk_mmc, clock);
>  	if (rate < 0) {
>  		dev_err(mmc_dev(mmc), "error rounding clk to %d: %ld\n",

