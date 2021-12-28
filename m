Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24BCF480C76
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 19:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236997AbhL1STm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Dec 2021 13:19:42 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57882 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233595AbhL1STm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 13:19:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E68A612E8;
        Tue, 28 Dec 2021 18:19:41 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 7F351C36AE9;
        Tue, 28 Dec 2021 18:19:36 +0000 (UTC)
Date:   Tue, 28 Dec 2021 18:25:21 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 20/23] counter: stm32-timer-cnt: Convert to new
 counter registration
Message-ID: <20211228182521.1774dc79@jic23-huawei>
In-Reply-To: <20211227094526.698714-21-u.kleine-koenig@pengutronix.de>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
        <20211227094526.698714-21-u.kleine-koenig@pengutronix.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Dec 2021 10:45:23 +0100
Uwe Kleine-König         <u.kleine-koenig@pengutronix.de> wrote:

> This fixes device lifetime issues where it was possible to free a live
> struct device.
> 
> Fixes: ad29937e206f ("counter: Add STM32 Timer quadrature encoder")
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Same basic form as all the others so easy to review (hopefully :)

Jonathan

> ---
>  drivers/counter/stm32-timer-cnt.c | 30 ++++++++++++++++++------------
>  1 file changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
> index 4b05b198a8d8..5779ae7c73cf 100644
> --- a/drivers/counter/stm32-timer-cnt.c
> +++ b/drivers/counter/stm32-timer-cnt.c
> @@ -29,7 +29,6 @@ struct stm32_timer_regs {
>  };
>  
>  struct stm32_timer_cnt {
> -	struct counter_device counter;
>  	struct regmap *regmap;
>  	struct clk *clk;
>  	u32 max_arr;
> @@ -317,31 +316,38 @@ static int stm32_timer_cnt_probe(struct platform_device *pdev)
>  	struct stm32_timers *ddata = dev_get_drvdata(pdev->dev.parent);
>  	struct device *dev = &pdev->dev;
>  	struct stm32_timer_cnt *priv;
> +	struct counter_device *counter;
> +	int ret;
>  
>  	if (IS_ERR_OR_NULL(ddata))
>  		return -EINVAL;
>  
> -	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> -	if (!priv)
> +	counter = devm_counter_alloc(dev, sizeof(*priv));
> +	if (!counter)
>  		return -ENOMEM;
>  
> +	priv = counter_priv(counter);
> +
>  	priv->regmap = ddata->regmap;
>  	priv->clk = ddata->clk;
>  	priv->max_arr = ddata->max_arr;
>  
> -	priv->counter.name = dev_name(dev);
> -	priv->counter.parent = dev;
> -	priv->counter.ops = &stm32_timer_cnt_ops;
> -	priv->counter.counts = &stm32_counts;
> -	priv->counter.num_counts = 1;
> -	priv->counter.signals = stm32_signals;
> -	priv->counter.num_signals = ARRAY_SIZE(stm32_signals);
> -	priv->counter.priv = priv;
> +	counter->name = dev_name(dev);
> +	counter->parent = dev;
> +	counter->ops = &stm32_timer_cnt_ops;
> +	counter->counts = &stm32_counts;
> +	counter->num_counts = 1;
> +	counter->signals = stm32_signals;
> +	counter->num_signals = ARRAY_SIZE(stm32_signals);
>  
>  	platform_set_drvdata(pdev, priv);
>  
>  	/* Register Counter device */
> -	return devm_counter_register(dev, &priv->counter);
> +	ret = devm_counter_add(dev, counter);
> +	if (ret < 0)
> +		dev_err_probe(dev, ret, "Failed to add counter\n");
> +
> +	return ret;
>  }
>  
>  static int __maybe_unused stm32_timer_cnt_suspend(struct device *dev)

