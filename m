Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A93F480BDC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 18:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236623AbhL1RJH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Dec 2021 12:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236046AbhL1RJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 12:09:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9491BC061574;
        Tue, 28 Dec 2021 09:09:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE8FD61252;
        Tue, 28 Dec 2021 17:09:05 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 1C73AC36AE8;
        Tue, 28 Dec 2021 17:09:01 +0000 (UTC)
Date:   Tue, 28 Dec 2021 17:14:45 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/23] counter: Use container_of instead of drvdata
 to track counter_device
Message-ID: <20211228171445.62c03d8c@jic23-huawei>
In-Reply-To: <20211227094526.698714-2-u.kleine-koenig@pengutronix.de>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
        <20211227094526.698714-2-u.kleine-koenig@pengutronix.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Dec 2021 10:45:04 +0100
Uwe Kleine-König         <u.kleine-koenig@pengutronix.de> wrote:

> The counter core uses drvdata to find a struct counter_device from a
> struct device. However as the device is a member of struct counter_device,
> the lookup can be done faster (and a bit type safe) using container_of.
> 
> There are no other users of drvdata, so the call to dev_set_drvdata can
> go away, too.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
LGTM

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/counter/counter-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-core.c
> index 5acc54539623..f053a43c6c04 100644
> --- a/drivers/counter/counter-core.c
> +++ b/drivers/counter/counter-core.c
> @@ -26,7 +26,8 @@ static DEFINE_IDA(counter_ida);
>  
>  static void counter_device_release(struct device *dev)
>  {
> -	struct counter_device *const counter = dev_get_drvdata(dev);
> +	struct counter_device *const counter =
> +		container_of(dev, struct counter_device, dev);
>  
>  	counter_chrdev_remove(counter);
>  	ida_free(&counter_ida, dev->id);
> @@ -78,7 +79,6 @@ int counter_register(struct counter_device *const counter)
>  		dev->of_node = counter->parent->of_node;
>  	}
>  	device_initialize(dev);
> -	dev_set_drvdata(dev, counter);
>  
>  	err = counter_sysfs_add(counter);
>  	if (err < 0)

