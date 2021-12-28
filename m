Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFC6A480C71
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 19:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236985AbhL1SSj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Dec 2021 13:18:39 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57366 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbhL1SSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 13:18:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67626611C8;
        Tue, 28 Dec 2021 18:18:38 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 8C8BBC36AEC;
        Tue, 28 Dec 2021 18:18:34 +0000 (UTC)
Date:   Tue, 28 Dec 2021 18:24:18 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: Re: [PATCH v2 19/23] counter: microchip-tcb-capture: Convert to new
 counter registration
Message-ID: <20211228182418.35bebf23@jic23-huawei>
In-Reply-To: <20211227094526.698714-20-u.kleine-koenig@pengutronix.de>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
        <20211227094526.698714-20-u.kleine-koenig@pengutronix.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Dec 2021 10:45:22 +0100
Uwe Kleine-König         <u.kleine-koenig@pengutronix.de> wrote:

> This fixes device lifetime issues where it was possible to free a live
> struct device.
> 
> Fixes: 106b104137fd ("counter: Add microchip TCB capture counter")
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/counter/microchip-tcb-capture.c | 30 ++++++++++++++-----------
>  1 file changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
> index 1b56b7444668..70c1d28546be 100644
> --- a/drivers/counter/microchip-tcb-capture.c
> +++ b/drivers/counter/microchip-tcb-capture.c
> @@ -24,7 +24,6 @@
>  
>  struct mchp_tc_data {
>  	const struct atmel_tcb_config *tc_cfg;
> -	struct counter_device counter;
>  	struct regmap *regmap;
>  	int qdec_mode;
>  	int num_channels;
> @@ -296,6 +295,7 @@ static int mchp_tc_probe(struct platform_device *pdev)
>  	struct device_node *np = pdev->dev.of_node;
>  	const struct atmel_tcb_config *tcb_config;
>  	const struct of_device_id *match;
> +	struct counter_device *counter;
>  	struct mchp_tc_data *priv;
>  	char clk_name[7];
>  	struct regmap *regmap;
> @@ -303,9 +303,10 @@ static int mchp_tc_probe(struct platform_device *pdev)
>  	int channel;
>  	int ret, i;
>  
> -	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> -	if (!priv)
> +	counter = devm_counter_alloc(&pdev->dev, sizeof(*priv));
> +	if (!counter)
>  		return -ENOMEM;
> +	priv = counter_priv(counter);
>  
>  	match = of_match_node(atmel_tc_of_match, np->parent);
>  	tcb_config = match->data;
> @@ -360,16 +361,19 @@ static int mchp_tc_probe(struct platform_device *pdev)
>  
>  	priv->tc_cfg = tcb_config;
>  	priv->regmap = regmap;
> -	priv->counter.name = dev_name(&pdev->dev);
> -	priv->counter.parent = &pdev->dev;
> -	priv->counter.ops = &mchp_tc_ops;
> -	priv->counter.num_counts = ARRAY_SIZE(mchp_tc_counts);
> -	priv->counter.counts = mchp_tc_counts;
> -	priv->counter.num_signals = ARRAY_SIZE(mchp_tc_count_signals);
> -	priv->counter.signals = mchp_tc_count_signals;
> -	priv->counter.priv = priv;
> -
> -	return devm_counter_register(&pdev->dev, &priv->counter);
> +	counter->name = dev_name(&pdev->dev);
> +	counter->parent = &pdev->dev;
> +	counter->ops = &mchp_tc_ops;
> +	counter->num_counts = ARRAY_SIZE(mchp_tc_counts);
> +	counter->counts = mchp_tc_counts;
> +	counter->num_signals = ARRAY_SIZE(mchp_tc_count_signals);
> +	counter->signals = mchp_tc_count_signals;
> +
> +	ret = devm_counter_add(&pdev->dev, counter);
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret, "Failed to add counter\n");
> + 
> +	return 0;
>  }
>  
>  static const struct of_device_id mchp_tc_dt_ids[] = {

