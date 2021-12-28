Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09978480C32
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 18:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236505AbhL1Rz7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Dec 2021 12:55:59 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40126 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbhL1Rz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 12:55:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94DF1B8125E;
        Tue, 28 Dec 2021 17:55:57 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 0B08DC36AEC;
        Tue, 28 Dec 2021 17:55:52 +0000 (UTC)
Date:   Tue, 28 Dec 2021 18:01:37 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/23] counter: Provide a wrapper to access device
 private data
Message-ID: <20211228180137.59c3859c@jic23-huawei>
In-Reply-To: <20211227094526.698714-5-u.kleine-koenig@pengutronix.de>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
        <20211227094526.698714-5-u.kleine-koenig@pengutronix.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Dec 2021 10:45:07 +0100
Uwe Kleine-König         <u.kleine-koenig@pengutronix.de> wrote:

> For now this just wraps accessing struct counter_device::priv. However
> this is about to change and converting drivers to this helper
> individually makes fixing device lifetime issues result in easier to
> review patches.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

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
> +
>  /**
>   * counter_register - register Counter to the system
>   * @counter:	pointer to Counter to register
> diff --git a/include/linux/counter.h b/include/linux/counter.h
> index b7d0a00a61cf..8daaa38c71d8 100644
> --- a/include/linux/counter.h
> +++ b/include/linux/counter.h
> @@ -329,6 +329,8 @@ struct counter_device {
>  	struct mutex ops_exist_lock;
>  };
>  
> +void *counter_priv(const struct counter_device *const counter);
> +
>  int counter_register(struct counter_device *const counter);
>  void counter_unregister(struct counter_device *const counter);
>  int devm_counter_register(struct device *dev,

