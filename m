Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0E0480C37
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 18:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbhL1R66 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Dec 2021 12:58:58 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41760 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbhL1R65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 12:58:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0BF58B8125E;
        Tue, 28 Dec 2021 17:58:56 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id B56E1C36AED;
        Tue, 28 Dec 2021 17:58:51 +0000 (UTC)
Date:   Tue, 28 Dec 2021 18:04:36 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Oleksij Rempel <linux@rempel-privat.de>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: Re: [PATCH v2 06/23] counter: interrupt-cnt: Convert to
 counter_priv() wrapper
Message-ID: <20211228180436.421636bd@jic23-huawei>
In-Reply-To: <20211227094526.698714-7-u.kleine-koenig@pengutronix.de>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
        <20211227094526.698714-7-u.kleine-koenig@pengutronix.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Dec 2021 10:45:09 +0100
Uwe Kleine-König         <u.kleine-koenig@pengutronix.de> wrote:

> This is a straight forward conversion to the new counter_priv() wrapper.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/counter/interrupt-cnt.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cnt.c
> index 8514a87fcbee..4bf706ef46e2 100644
> --- a/drivers/counter/interrupt-cnt.c
> +++ b/drivers/counter/interrupt-cnt.c
> @@ -37,7 +37,7 @@ static irqreturn_t interrupt_cnt_isr(int irq, void *dev_id)
>  static int interrupt_cnt_enable_read(struct counter_device *counter,
>  				     struct counter_count *count, u8 *enable)
>  {
> -	struct interrupt_cnt_priv *priv = counter->priv;
> +	struct interrupt_cnt_priv *priv = counter_priv(counter);
>  
>  	*enable = priv->enabled;
>  
> @@ -47,7 +47,7 @@ static int interrupt_cnt_enable_read(struct counter_device *counter,
>  static int interrupt_cnt_enable_write(struct counter_device *counter,
>  				      struct counter_count *count, u8 enable)
>  {
> -	struct interrupt_cnt_priv *priv = counter->priv;
> +	struct interrupt_cnt_priv *priv = counter_priv(counter);
>  
>  	if (priv->enabled == enable)
>  		return 0;
> @@ -85,7 +85,7 @@ static int interrupt_cnt_action_read(struct counter_device *counter,
>  static int interrupt_cnt_read(struct counter_device *counter,
>  			      struct counter_count *count, u64 *val)
>  {
> -	struct interrupt_cnt_priv *priv = counter->priv;
> +	struct interrupt_cnt_priv *priv = counter_priv(counter);
>  
>  	*val = atomic_read(&priv->count);
>  
> @@ -95,7 +95,7 @@ static int interrupt_cnt_read(struct counter_device *counter,
>  static int interrupt_cnt_write(struct counter_device *counter,
>  			       struct counter_count *count, const u64 val)
>  {
> -	struct interrupt_cnt_priv *priv = counter->priv;
> +	struct interrupt_cnt_priv *priv = counter_priv(counter);
>  
>  	if (val != (typeof(priv->count.counter))val)
>  		return -ERANGE;
> @@ -122,7 +122,7 @@ static int interrupt_cnt_signal_read(struct counter_device *counter,
>  				     struct counter_signal *signal,
>  				     enum counter_signal_level *level)
>  {
> -	struct interrupt_cnt_priv *priv = counter->priv;
> +	struct interrupt_cnt_priv *priv = counter_priv(counter);
>  	int ret;
>  
>  	if (!priv->gpio)

