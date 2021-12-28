Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9AB480C6F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 19:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236972AbhL1SRz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Dec 2021 13:17:55 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50868 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233411AbhL1SRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 13:17:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D2CBB8168C;
        Tue, 28 Dec 2021 18:17:53 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id A8AF9C36AE9;
        Tue, 28 Dec 2021 18:17:48 +0000 (UTC)
Date:   Tue, 28 Dec 2021 18:23:32 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        Patrick Havelange <patrick.havelange@essensium.com>
Subject: Re: [PATCH v2 18/23] counter: ftm-quaddec: Convert to new counter
 registration
Message-ID: <20211228182332.7a96041e@jic23-huawei>
In-Reply-To: <20211227094526.698714-19-u.kleine-koenig@pengutronix.de>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
        <20211227094526.698714-19-u.kleine-koenig@pengutronix.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Dec 2021 10:45:21 +0100
Uwe Kleine-König         <u.kleine-koenig@pengutronix.de> wrote:

> This fixes device lifetime issues where it was possible to free a live
> struct device.
> 
> Fixes: a3b9a99980d9 ("counter: add FlexTimer Module Quadrature decoder counter driver")
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Assuming you move the 104-quad-8 stuff to the earlier patch.


> ---
>  drivers/counter/104-quad-8.c  |  7 ++++---
>  drivers/counter/ftm-quaddec.c | 27 +++++++++++++--------------
>  2 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
> index 4315b14f239e..680c7ba943a4 100644
> --- a/drivers/counter/104-quad-8.c
> +++ b/drivers/counter/104-quad-8.c

Block in wrong patch. I'll assume you'll fix that and ignore it beyond saying
this change is fine so keep my RB on the earlier patch once you've added this block.

> @@ -1084,7 +1084,8 @@ static struct counter_count quad8_counts[] = {
>  
>  static irqreturn_t quad8_irq_handler(int irq, void *private)
>  {
> -	struct quad8 *const priv = private;
> +	struct counter_device *counter = private;
> +	struct quad8 *const priv = counter_priv(counter);
>  	const unsigned long base = priv->base;
>  	unsigned long irq_status;
>  	unsigned long channel;
> @@ -1115,7 +1116,7 @@ static irqreturn_t quad8_irq_handler(int irq, void *private)
>  			continue;
>  		}
>  
> -		counter_push_event(&priv->counter, event, channel);
> +		counter_push_event(counter, event, channel);
>  	}
>  
>  	/* Clear pending interrupts on device */
> @@ -1192,7 +1193,7 @@ static int quad8_probe(struct device *dev, unsigned int id)
>  	outb(QUAD8_CHAN_OP_ENABLE_INTERRUPT_FUNC, base[id] + QUAD8_REG_CHAN_OP);
>  
>  	err = devm_request_irq(dev, irq[id], quad8_irq_handler, IRQF_SHARED,
> -			       counter->name, priv);
> +			       counter->name, counter);
>  	if (err)
>  		return err;
>  
> diff --git a/drivers/counter/ftm-quaddec.c b/drivers/counter/ftm-quaddec.c
> index f5d92df6a611..c636183b1337 100644
> --- a/drivers/counter/ftm-quaddec.c
> +++ b/drivers/counter/ftm-quaddec.c
> @@ -26,7 +26,6 @@
>  	})
>  
>  struct ftm_quaddec {
> -	struct counter_device counter;
>  	struct platform_device *pdev;
>  	void __iomem *ftm_base;
>  	bool big_endian;
> @@ -259,15 +258,16 @@ static struct counter_count ftm_quaddec_counts = {
>  
>  static int ftm_quaddec_probe(struct platform_device *pdev)
>  {
> +	struct counter_device *counter;
>  	struct ftm_quaddec *ftm;
> -

Try to avoid white space changes in a patch like these even if they seem
trivial.  The 'noise' adds up.

>  	struct device_node *node = pdev->dev.of_node;
>  	struct resource *io;
>  	int ret;
>  
> -	ftm = devm_kzalloc(&pdev->dev, sizeof(*ftm), GFP_KERNEL);
> -	if (!ftm)
> +	counter = devm_counter_alloc(&pdev->dev, sizeof(*ftm));
> +	if (!counter)
>  		return -ENOMEM;
> +	ftm = counter_priv(counter);
>  
>  	io = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (!io) {
> @@ -283,14 +283,13 @@ static int ftm_quaddec_probe(struct platform_device *pdev)
>  		dev_err(&pdev->dev, "Failed to map memory region\n");
>  		return -EINVAL;
>  	}
> -	ftm->counter.name = dev_name(&pdev->dev);
> -	ftm->counter.parent = &pdev->dev;
> -	ftm->counter.ops = &ftm_quaddec_cnt_ops;
> -	ftm->counter.counts = &ftm_quaddec_counts;
> -	ftm->counter.num_counts = 1;
> -	ftm->counter.signals = ftm_quaddec_signals;
> -	ftm->counter.num_signals = ARRAY_SIZE(ftm_quaddec_signals);
> -	ftm->counter.priv = ftm;
> +	counter->name = dev_name(&pdev->dev);
> +	counter->parent = &pdev->dev;
> +	counter->ops = &ftm_quaddec_cnt_ops;
> +	counter->counts = &ftm_quaddec_counts;
> +	counter->num_counts = 1;
> +	counter->signals = ftm_quaddec_signals;
> +	counter->num_signals = ARRAY_SIZE(ftm_quaddec_signals);
>  
>  	mutex_init(&ftm->ftm_quaddec_mutex);
>  
> @@ -300,9 +299,9 @@ static int ftm_quaddec_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	ret = devm_counter_register(&pdev->dev, &ftm->counter);
> +	ret = devm_counter_add(&pdev->dev, counter);
>  	if (ret)
> -		return ret;
> +		return dev_err_probe(&pdev->dev, ret, "Failed to add counter\n");
>  
>  	return 0;
>  }

