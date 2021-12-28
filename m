Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91882480C60
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 19:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236927AbhL1SND convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Dec 2021 13:13:03 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:55282 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbhL1SNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 13:13:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83DC5612B1;
        Tue, 28 Dec 2021 18:13:02 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id DBFA4C36AE9;
        Tue, 28 Dec 2021 18:12:58 +0000 (UTC)
Date:   Tue, 28 Dec 2021 18:18:43 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Oleksij Rempel <linux@rempel-privat.de>
Subject: Re: [PATCH v2 16/23] counter: interrupt-cnt: Convert to new counter
 registration
Message-ID: <20211228181843.7b812d5f@jic23-huawei>
In-Reply-To: <20211227094526.698714-17-u.kleine-koenig@pengutronix.de>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
        <20211227094526.698714-17-u.kleine-koenig@pengutronix.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Dec 2021 10:45:19 +0100
Uwe Kleine-König         <u.kleine-koenig@pengutronix.de> wrote:

> This fixes device lifetime issues where it was possible to free a live
> struct device.
> 
> Fixes: a55ebd47f21f ("counter: add IRQ or GPIO based counter")
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/counter/interrupt-cnt.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cnt.c
> index 4bf706ef46e2..9e99702470c2 100644
> --- a/drivers/counter/interrupt-cnt.c
> +++ b/drivers/counter/interrupt-cnt.c
> @@ -16,7 +16,6 @@
>  
>  struct interrupt_cnt_priv {
>  	atomic_t count;
> -	struct counter_device counter;
>  	struct gpio_desc *gpio;
>  	int irq;
>  	bool enabled;
> @@ -148,12 +147,14 @@ static const struct counter_ops interrupt_cnt_ops = {
>  static int interrupt_cnt_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> +	struct counter_device *counter;
>  	struct interrupt_cnt_priv *priv;
>  	int ret;
>  
> -	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> -	if (!priv)
> +	counter = devm_counter_alloc(dev, sizeof(*priv));
> +	if (!counter)
>  		return -ENOMEM;
> +	priv = counter_priv(counter);
>  
>  	priv->irq = platform_get_irq_optional(pdev,  0);
>  	if (priv->irq == -ENXIO)
> @@ -184,8 +185,8 @@ static int interrupt_cnt_probe(struct platform_device *pdev)
>  	if (!priv->signals.name)
>  		return -ENOMEM;
>  
> -	priv->counter.signals = &priv->signals;
> -	priv->counter.num_signals = 1;
> +	counter->signals = &priv->signals;
> +	counter->num_signals = 1;
>  
>  	priv->synapses.actions_list = interrupt_cnt_synapse_actions;
>  	priv->synapses.num_actions = ARRAY_SIZE(interrupt_cnt_synapse_actions);
> @@ -199,12 +200,11 @@ static int interrupt_cnt_probe(struct platform_device *pdev)
>  	priv->cnts.ext = interrupt_cnt_ext;
>  	priv->cnts.num_ext = ARRAY_SIZE(interrupt_cnt_ext);
>  
> -	priv->counter.priv = priv;
> -	priv->counter.name = dev_name(dev);
> -	priv->counter.parent = dev;
> -	priv->counter.ops = &interrupt_cnt_ops;
> -	priv->counter.counts = &priv->cnts;
> -	priv->counter.num_counts = 1;
> +	counter->name = dev_name(dev);
> +	counter->parent = dev;
> +	counter->ops = &interrupt_cnt_ops;
> +	counter->counts = &priv->cnts;
> +	counter->num_counts = 1;
>  
>  	irq_set_status_flags(priv->irq, IRQ_NOAUTOEN);
>  	ret = devm_request_irq(dev, priv->irq, interrupt_cnt_isr,
> @@ -213,7 +213,11 @@ static int interrupt_cnt_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	return devm_counter_register(dev, &priv->counter);
> +	ret = devm_counter_add(dev, counter);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to add counter\n");
> +
> +	return 0;
>  }
>  
>  static const struct of_device_id interrupt_cnt_of_match[] = {

