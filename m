Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB81647FC0E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 11:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236254AbhL0K7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 05:59:06 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:34522 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbhL0K7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 05:59:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07CE360F71;
        Mon, 27 Dec 2021 10:59:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFBA6C36AEA;
        Mon, 27 Dec 2021 10:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640602744;
        bh=sS3SI/T458VqRdSJf5FLeOcz6HgoryLioZ7KE5iROXk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bATFLExh4sppzuBHnP1xfDHTvTQgM+xWvTrfvVlAoCcXABbtXzwCSTGqVHgpw9S4x
         KBneiArqF1oaW7/1lG+r1Kd/92n53X7dEzDXFXduL0o864J0pem3JcR8Qej0wFTJCe
         dHtDaWkuH7/PeNiBHbDvuKQQ5rmpZBphyrjWDYEE=
Date:   Mon, 27 Dec 2021 11:59:01 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Oleksij Rempel <linux@rempel-privat.de>
Subject: Re: [PATCH v2 16/23] counter: interrupt-cnt: Convert to new counter
 registration
Message-ID: <YcmcdftX3YO06nD1@kroah.com>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
 <20211227094526.698714-17-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211227094526.698714-17-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 27, 2021 at 10:45:19AM +0100, Uwe Kleine-König wrote:
> This fixes device lifetime issues where it was possible to free a live
> struct device.
> 
> Fixes: a55ebd47f21f ("counter: add IRQ or GPIO based counter")
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
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

I just picked one of these patches at random, nothing specific about
this driver...

You can not have a 'struct device' in memory allocated by devm_*()
functions for the obvious reason that now that memory is being
controlled by a reference count that is OUTSIDE of the structure itself.

So while your goal might be good here, this is not the correct solution
at all, sorry.

thanks,

greg k-h
