Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2934E1C54
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 16:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245392AbiCTPpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 11:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbiCTPpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 11:45:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822773E5F0;
        Sun, 20 Mar 2022 08:43:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67392B80E74;
        Sun, 20 Mar 2022 15:43:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC25C340E9;
        Sun, 20 Mar 2022 15:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647791012;
        bh=zxmWQbehggNtjF6+CkF/nt9Ix1JKc/x8aOpG8KI8m6c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EvJg2B3VEvfq03Z0eu5RinKsFDXIMZpAMhSaDyvQjcyY483d+xBQAZAoMLaih1wyX
         yZg5DriQaDBAiStCLNyoJKQuiYUKQWkK2n9zQu7Bsi7IIdkKjc5S5TwkMfkrK6L18v
         E8HnjkCmFy85bdZDU2GYpk9U+JlDJysBJ2IFWf4K7eWEZ6QV6TdsjtumQzVqw3efbK
         TMJ1vqrbq3rsxVAPSb3HYhckMhbBdAvPZTvAqL3mw1vTQZuKvIdx6D5HeODJ0cMEKh
         AJnrA6E4WR/9bO3T757O1NexbPGat29OJ9j5R3vpxEpKNjNXnvGZ9Zaq2wxSPFg8Tc
         mNvhSiWiOXICg==
Date:   Sun, 20 Mar 2022 15:50:56 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     xkernel.wang@foxmail.com
Cc:     jic23@jic23.retrosnub.co.uk, lars@metafoo.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: dummy: iio_simple_dummy: check the return value
 of kstrdup()
Message-ID: <20220320155056.5e365972@jic23-huawei>
In-Reply-To: <tencent_C920CFCC33B9CC1C63141FE1334A39FF8508@qq.com>
References: <tencent_C920CFCC33B9CC1C63141FE1334A39FF8508@qq.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  5 Mar 2022 11:14:05 +0800
xkernel.wang@foxmail.com wrote:

> From: Xiaoke Wang <xkernel.wang@foxmail.com>
> 
> kstrdup() is also a memory allocation-related function, it returns NULL
> when some memory errors happen. So it is better to check the return
> value of it so to catch the memory error in time. Besides, there should
> have a kfree() to clear up the allocation if we get a failure later in
> this function to prevent memory leak.
> 
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>

I made a small tweak whilst applying.  It added an extra label but
I think makes the flow easier to follow than relying on the kfree(NULL)
so two error paths can share the same handling.

Applied with that tweak to the togreg branch of iio.git and pushed out
as testing for 0-day to see if it can find anything we missed.

Note I will rebase that tree on rc1 once available so it is not a
stable base to use for anything else.

Thanks,

Jonathan


> ---
> I am sorry that I forgot to send this.
> Changelogs:
> v1->v2 add kfree() on the error path.
> v2->v3 change the err lable.
>  drivers/iio/dummy/iio_simple_dummy.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/dummy/iio_simple_dummy.c b/drivers/iio/dummy/iio_simple_dummy.c
> index c0b7ef9..99e7731 100644
> --- a/drivers/iio/dummy/iio_simple_dummy.c
> +++ b/drivers/iio/dummy/iio_simple_dummy.c
> @@ -575,10 +575,9 @@ static struct iio_sw_device *iio_dummy_probe(const char *name)
>  	 */
>  
>  	swd = kzalloc(sizeof(*swd), GFP_KERNEL);
> -	if (!swd) {
> -		ret = -ENOMEM;
> -		goto error_kzalloc;
> -	}
> +	if (!swd)
> +		return ERR_PTR(-ENOMEM);
> +
>  	/*
>  	 * Allocate an IIO device.
>  	 *
> @@ -590,7 +589,7 @@ static struct iio_sw_device *iio_dummy_probe(const char *name)
>  	indio_dev = iio_device_alloc(parent, sizeof(*st));
>  	if (!indio_dev) {
>  		ret = -ENOMEM;
> -		goto error_ret;
> +		goto error_free_swd;
>  	}
>  
>  	st = iio_priv(indio_dev);
> @@ -616,6 +615,10 @@ static struct iio_sw_device *iio_dummy_probe(const char *name)
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
> @@ -650,10 +653,10 @@ static struct iio_sw_device *iio_dummy_probe(const char *name)
>  error_unregister_events:
>  	iio_simple_dummy_events_unregister(indio_dev);
>  error_free_device:
> +	kfree(indio_dev->name);
I'm going to tweak this a tiny bit whilst applying and have separate label for
the two bits of cleanup.

Whilst it is of course correct to kfree(NULL) the flow isn't as obvious as it will be with
the extra label.

>  	iio_device_free(indio_dev);
> -error_ret:
> +error_free_swd:
>  	kfree(swd);
> -error_kzalloc:
>  	return ERR_PTR(ret);
>  }
>  

