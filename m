Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB8424778DC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 17:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239675AbhLPQZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 11:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236632AbhLPQZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 11:25:20 -0500
Received: from haggis.mythic-beasts.com (haggis.mythic-beasts.com [IPv6:2a00:1098:0:86:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BF4C06173F;
        Thu, 16 Dec 2021 08:25:19 -0800 (PST)
Received: from [81.101.6.87] (port=52582 helo=jic23-huawei)
        by haggis.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1mxtZC-00055i-Lp; Thu, 16 Dec 2021 16:25:15 +0000
Date:   Thu, 16 Dec 2021 16:30:37 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Xiaoke Wang <xkernel.wang@foxmail.com>
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dummy: iio_simple_dummy: check the return value of
 kstrdup()
Message-ID: <20211216163019.570d6aed@jic23-huawei>
In-Reply-To: <tencent_4014A4E1394AA4FF7620EBCC47B9701C9D08@qq.com>
References: <tencent_4014A4E1394AA4FF7620EBCC47B9701C9D08@qq.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 4
X-Spam-Status: No, score=0.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2021 17:18:21 +0800
Xiaoke Wang <xkernel.wang@foxmail.com> wrote:

> kstrdup() is also a memory allocation-related function, it return NULL
> when some memory errors happen. So it is better to check the return
> value of it so to catch the memory error in time.
> 
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
Hi.

Good spot, but there is more to do to fix this.  The error path doesn't
clear up the allocation if we get a failure later in this function.

So should have a kfree() error case.

Also, a side note is the error labels in that function are terrible!
(given I probably wrote them I can be rude about them:) 

So cleaning that up as well might be a good thing to do whilst here.
Make them reflect what they are cleaning up rather that the crazy
naming there currently.  When error_ret label goes to a place where
it does more than just return it's not good.

Also drop the first error_kzalloc label and goto in favour of direct return.

Great if you can tidy this up, if not I'll do it at somepoint.

Jonathan

> ---
>  drivers/iio/dummy/iio_simple_dummy.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iio/dummy/iio_simple_dummy.c b/drivers/iio/dummy/iio_simple_dummy.c
> index c0b7ef9..a5e8071 100644
> --- a/drivers/iio/dummy/iio_simple_dummy.c
> +++ b/drivers/iio/dummy/iio_simple_dummy.c
> @@ -616,6 +616,10 @@ static struct iio_sw_device *iio_dummy_probe(const char *name)
>  	 *    indio_dev->name = spi_get_device_id(spi)->name;
>  	 */
>  	indio_dev->name = kstrdup(name, GFP_KERNEL);
> +	if (!indio_dev->name) {
> +		ret = -ENOMEM;
> +		goto error_free_device;
> +	}
>  
>  	/* Provide description of available channels */
>  	indio_dev->channels = iio_dummy_channels;

