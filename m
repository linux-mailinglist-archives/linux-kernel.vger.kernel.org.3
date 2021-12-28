Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097E3480C7B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 19:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237012AbhL1SXv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Dec 2021 13:23:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbhL1SXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 13:23:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B12C061574;
        Tue, 28 Dec 2021 10:23:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35262B81259;
        Tue, 28 Dec 2021 18:23:49 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id D50D7C36AEC;
        Tue, 28 Dec 2021 18:23:44 +0000 (UTC)
Date:   Tue, 28 Dec 2021 18:29:28 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, David Lechner <david@lechnology.com>
Subject: Re: [PATCH v2 22/23] counter: ti-eqep: Convert to new counter
 registration
Message-ID: <20211228182928.72517f26@jic23-huawei>
In-Reply-To: <20211227094526.698714-23-u.kleine-koenig@pengutronix.de>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
        <20211227094526.698714-23-u.kleine-koenig@pengutronix.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Dec 2021 10:45:25 +0100
Uwe Kleine-König         <u.kleine-koenig@pengutronix.de> wrote:

> This fixes device lifetime issues where it was possible to free a live
> struct device.
> 
> Fixes: f213729f6796 ("counter: new TI eQEP driver")
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
It's nice that all these drivers are so similar...

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/counter/ti-eqep.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
> index abeda966e7be..3b49b492d182 100644
> --- a/drivers/counter/ti-eqep.c
> +++ b/drivers/counter/ti-eqep.c
> @@ -368,13 +368,15 @@ static const struct regmap_config ti_eqep_regmap16_config = {
>  static int ti_eqep_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> +	struct counter_device *counter;
>  	struct ti_eqep_cnt *priv;
>  	void __iomem *base;
>  	int err;
>  
> -	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> -	if (!priv)
> +	counter = devm_counter_alloc(dev, sizeof(*priv));
> +	if (!counter)
>  		return -ENOMEM;
> +	priv = counter_priv(counter);
>  
>  	base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(base))
> @@ -390,16 +392,15 @@ static int ti_eqep_probe(struct platform_device *pdev)
>  	if (IS_ERR(priv->regmap16))
>  		return PTR_ERR(priv->regmap16);
>  
> -	priv->counter.name = dev_name(dev);
> -	priv->counter.parent = dev;
> -	priv->counter.ops = &ti_eqep_counter_ops;
> -	priv->counter.counts = ti_eqep_counts;
> -	priv->counter.num_counts = ARRAY_SIZE(ti_eqep_counts);
> -	priv->counter.signals = ti_eqep_signals;
> -	priv->counter.num_signals = ARRAY_SIZE(ti_eqep_signals);
> -	priv->counter.priv = priv;
> +	counter->name = dev_name(dev);
> +	counter->parent = dev;
> +	counter->ops = &ti_eqep_counter_ops;
> +	counter->counts = ti_eqep_counts;
> +	counter->num_counts = ARRAY_SIZE(ti_eqep_counts);
> +	counter->signals = ti_eqep_signals;
> +	counter->num_signals = ARRAY_SIZE(ti_eqep_signals);
>  
> -	platform_set_drvdata(pdev, priv);
> +	platform_set_drvdata(pdev, counter);
>  
>  	/*
>  	 * Need to make sure power is turned on. On AM33xx, this comes from the
> @@ -409,7 +410,7 @@ static int ti_eqep_probe(struct platform_device *pdev)
>  	pm_runtime_enable(dev);
>  	pm_runtime_get_sync(dev);
>  
> -	err = counter_register(&priv->counter);
> +	err = counter_add(counter);
>  	if (err < 0) {
>  		pm_runtime_put_sync(dev);
>  		pm_runtime_disable(dev);
> @@ -421,10 +422,10 @@ static int ti_eqep_probe(struct platform_device *pdev)
>  
>  static int ti_eqep_remove(struct platform_device *pdev)
>  {
> -	struct ti_eqep_cnt *priv = platform_get_drvdata(pdev);
> +	struct counter_device *counter = platform_get_drvdata(pdev);
>  	struct device *dev = &pdev->dev;
>  
> -	counter_unregister(&priv->counter);
> +	counter_unregister(counter);
>  	pm_runtime_put_sync(dev);
>  	pm_runtime_disable(dev);
>  

