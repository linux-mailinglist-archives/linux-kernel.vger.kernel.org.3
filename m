Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA5FB480C79
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 19:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237004AbhL1SUw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Dec 2021 13:20:52 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52012 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233411AbhL1SUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 13:20:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52BCEB816F2;
        Tue, 28 Dec 2021 18:20:49 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 77F78C36AEC;
        Tue, 28 Dec 2021 18:20:43 +0000 (UTC)
Date:   Tue, 28 Dec 2021 18:26:27 +0000
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
Subject: Re: [PATCH v2 21/23] counter: stm32-lptimer-cnt: Convert to new
 counter registration
Message-ID: <20211228182627.10dddf72@jic23-huawei>
In-Reply-To: <20211227094526.698714-22-u.kleine-koenig@pengutronix.de>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
        <20211227094526.698714-22-u.kleine-koenig@pengutronix.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Dec 2021 10:45:24 +0100
Uwe Kleine-König         <u.kleine-koenig@pengutronix.de> wrote:

> This fixes device lifetime issues where it was possible to free a live
> struct device.
> 
> Fixes: 597f55e3f36c ("counter: stm32-lptimer: add counter device")
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/counter/stm32-lptimer-cnt.c | 33 +++++++++++++++++------------
>  1 file changed, 19 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm32-lptimer-cnt.c
> index 9cf00e929cc0..68031d93ce89 100644
> --- a/drivers/counter/stm32-lptimer-cnt.c
> +++ b/drivers/counter/stm32-lptimer-cnt.c
> @@ -20,7 +20,6 @@
>  #include <linux/types.h>
>  
>  struct stm32_lptim_cnt {
> -	struct counter_device counter;
>  	struct device *dev;
>  	struct regmap *regmap;
>  	struct clk *clk;
> @@ -411,14 +410,17 @@ static struct counter_count stm32_lptim_in1_counts = {
>  static int stm32_lptim_cnt_probe(struct platform_device *pdev)
>  {
>  	struct stm32_lptimer *ddata = dev_get_drvdata(pdev->dev.parent);
> +	struct counter_device *counter;
>  	struct stm32_lptim_cnt *priv;
> +	int ret;
>  
>  	if (IS_ERR_OR_NULL(ddata))
>  		return -EINVAL;
>  
> -	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> -	if (!priv)
> +	counter = devm_counter_alloc(&pdev->dev, sizeof(*priv));
> +	if (!counter)
>  		return -ENOMEM;
> +	priv = counter_priv(counter);
>  
>  	priv->dev = &pdev->dev;
>  	priv->regmap = ddata->regmap;
> @@ -426,23 +428,26 @@ static int stm32_lptim_cnt_probe(struct platform_device *pdev)
>  	priv->ceiling = STM32_LPTIM_MAX_ARR;
>  
>  	/* Initialize Counter device */
> -	priv->counter.name = dev_name(&pdev->dev);
> -	priv->counter.parent = &pdev->dev;
> -	priv->counter.ops = &stm32_lptim_cnt_ops;
> +	counter->name = dev_name(&pdev->dev);
> +	counter->parent = &pdev->dev;
> +	counter->ops = &stm32_lptim_cnt_ops;
>  	if (ddata->has_encoder) {
> -		priv->counter.counts = &stm32_lptim_enc_counts;
> -		priv->counter.num_signals = ARRAY_SIZE(stm32_lptim_cnt_signals);
> +		counter->counts = &stm32_lptim_enc_counts;
> +		counter->num_signals = ARRAY_SIZE(stm32_lptim_cnt_signals);
>  	} else {
> -		priv->counter.counts = &stm32_lptim_in1_counts;
> -		priv->counter.num_signals = 1;
> +		counter->counts = &stm32_lptim_in1_counts;
> +		counter->num_signals = 1;
>  	}
> -	priv->counter.num_counts = 1;
> -	priv->counter.signals = stm32_lptim_cnt_signals;
> -	priv->counter.priv = priv;
> +	counter->num_counts = 1;
> +	counter->signals = stm32_lptim_cnt_signals;
>  
>  	platform_set_drvdata(pdev, priv);
>  
> -	return devm_counter_register(&pdev->dev, &priv->counter);
> +	ret = devm_counter_add(&pdev->dev, counter);
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret, "Failed to add counter\n");
> +
> +	return 0;
>  }
>  
>  #ifdef CONFIG_PM_SLEEP

