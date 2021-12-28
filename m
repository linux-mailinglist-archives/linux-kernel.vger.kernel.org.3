Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB26480C5D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 19:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236916AbhL1SL5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Dec 2021 13:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbhL1SL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 13:11:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D471FC061574;
        Tue, 28 Dec 2021 10:11:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F392B612DF;
        Tue, 28 Dec 2021 18:11:54 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 1A19EC36AEC;
        Tue, 28 Dec 2021 18:11:50 +0000 (UTC)
Date:   Tue, 28 Dec 2021 18:17:35 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Syed Nayyar Waris <syednwaris@gmail.com>
Subject: Re: [PATCH v2 15/23] counter: 104-quad-8: Convert to new counter
 registration
Message-ID: <20211228181735.7d0c32b7@jic23-huawei>
In-Reply-To: <20211227094526.698714-16-u.kleine-koenig@pengutronix.de>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
        <20211227094526.698714-16-u.kleine-koenig@pengutronix.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Dec 2021 10:45:18 +0100
Uwe Kleine-König         <u.kleine-koenig@pengutronix.de> wrote:

> This fixes device lifetime issues where it was possible to free a live
> struct device.
> 
> Fixes: f1d8a071d45b ("counter: 104-quad-8: Add Generic Counter interface support")
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
LGTM

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/counter/104-quad-8.c | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
> index 6e5286cd1d4e..4315b14f239e 100644
> --- a/drivers/counter/104-quad-8.c
> +++ b/drivers/counter/104-quad-8.c
> @@ -52,7 +52,6 @@ MODULE_PARM_DESC(irq, "ACCES 104-QUAD-8 interrupt line numbers");
>   */
>  struct quad8 {
>  	spinlock_t lock;
> -	struct counter_device counter;
>  	unsigned int fck_prescaler[QUAD8_NUM_COUNTERS];
>  	unsigned int preset[QUAD8_NUM_COUNTERS];
>  	unsigned int count_mode[QUAD8_NUM_COUNTERS];
> @@ -1127,6 +1126,7 @@ static irqreturn_t quad8_irq_handler(int irq, void *private)
>  
>  static int quad8_probe(struct device *dev, unsigned int id)
>  {
> +	struct counter_device *counter;
>  	struct quad8 *priv;
>  	int i, j;
>  	unsigned int base_offset;
> @@ -1138,19 +1138,19 @@ static int quad8_probe(struct device *dev, unsigned int id)
>  		return -EBUSY;
>  	}
>  
> -	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> -	if (!priv)
> +	counter = devm_counter_alloc(dev, sizeof(*priv));
> +	if (!counter)
>  		return -ENOMEM;
> +	priv = counter_priv(counter);
>  
>  	/* Initialize Counter device and driver data */
> -	priv->counter.name = dev_name(dev);
> -	priv->counter.parent = dev;
> -	priv->counter.ops = &quad8_ops;
> -	priv->counter.counts = quad8_counts;
> -	priv->counter.num_counts = ARRAY_SIZE(quad8_counts);
> -	priv->counter.signals = quad8_signals;
> -	priv->counter.num_signals = ARRAY_SIZE(quad8_signals);
> -	priv->counter.priv = priv;
> +	counter->name = dev_name(dev);
> +	counter->parent = dev;
> +	counter->ops = &quad8_ops;
> +	counter->counts = quad8_counts;
> +	counter->num_counts = ARRAY_SIZE(quad8_counts);
> +	counter->signals = quad8_signals;
> +	counter->num_signals = ARRAY_SIZE(quad8_signals);
>  	priv->base = base[id];
>  
>  	spin_lock_init(&priv->lock);
> @@ -1192,11 +1192,15 @@ static int quad8_probe(struct device *dev, unsigned int id)
>  	outb(QUAD8_CHAN_OP_ENABLE_INTERRUPT_FUNC, base[id] + QUAD8_REG_CHAN_OP);
>  
>  	err = devm_request_irq(dev, irq[id], quad8_irq_handler, IRQF_SHARED,
> -			       priv->counter.name, priv);
> +			       counter->name, priv);
>  	if (err)
>  		return err;
>  
> -	return devm_counter_register(dev, &priv->counter);
> +	err = devm_counter_add(dev, counter);
> +	if (err < 0)
> +		return dev_err_probe(dev, err, "Failed to add counter\n");
> +
> +	return 0;
>  }
>  
>  static struct isa_driver quad8_driver = {

