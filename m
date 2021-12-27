Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2778647FC13
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 12:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236270AbhL0LCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 06:02:20 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:36338 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbhL0LCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 06:02:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16F69B80E71;
        Mon, 27 Dec 2021 11:02:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6293EC36AEA;
        Mon, 27 Dec 2021 11:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640602936;
        bh=WnYxvRQc11JuND77MpzMHcuBOMDaLj0Ue1gg2X1vU5E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h3v34jpnQKG5Coyk+iTcemjQgAmMCHECdQaYFuqHA7SI95QSU8jFEK7Ace6nkcBWt
         Yqp80VHOHgzBYif2De4wl1XxtzD1FMzoRRdqwsF40i/9hCFibMn1bcN3EJLtPG5GXv
         rZPwWfuOQITIMf0gWWfD7nZogexjWS47gj1hY3gI=
Date:   Mon, 27 Dec 2021 12:02:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/23] counter: Provide a wrapper to access device
 private data
Message-ID: <YcmdNr8Y1jcMCwQQ@kroah.com>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
 <20211227094526.698714-5-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211227094526.698714-5-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 27, 2021 at 10:45:07AM +0100, Uwe Kleine-König wrote:
> For now this just wraps accessing struct counter_device::priv. However
> this is about to change and converting drivers to this helper
> individually makes fixing device lifetime issues result in easier to
> review patches.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/counter/counter-core.c | 12 ++++++++++++
>  include/linux/counter.h        |  2 ++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-core.c
> index f053a43c6c04..00c41f28c101 100644
> --- a/drivers/counter/counter-core.c
> +++ b/drivers/counter/counter-core.c
> @@ -45,6 +45,18 @@ static struct bus_type counter_bus_type = {
>  
>  static dev_t counter_devt;
>  
> +/**
> + * counter_priv - access counter device private data
> + * @counter: counter device
> + *
> + * Get the counter device private data
> + */
> +void *counter_priv(const struct counter_device *const counter)
> +{
> +	return counter->priv;
> +}
> +EXPORT_SYMBOL_GPL(counter_priv);

Shouldn't this be usin gdev_get_drvdata() and using the private data
pointer that is already on the struct device structure itself?  The void
*priv; should be dropped from struct counter_device entirely.

Oh ick, I just now looked at 'struct counter_device', there are other
reference counting issues in there (hint, struct cdev has a reference
count...)  But that's independent of this patch series...

thanks,

greg k-h
