Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8A134A3684
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 14:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354899AbiA3Nph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 08:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245308AbiA3Npg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 08:45:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3822C061714;
        Sun, 30 Jan 2022 05:45:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 57E15B82858;
        Sun, 30 Jan 2022 13:45:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6798DC340E4;
        Sun, 30 Jan 2022 13:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643550332;
        bh=m5SoGhxE2jsXwlJrfSO3HNBwfLis8cOAHvfvYSbMfMA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EE6wuEUeiY6C/QwgIGPnIS83ir9kyumhK7H4KGMBOvBd4T/brGvDoD/t/gIegWjDB
         SpXJFn69FiUcCZg51Ct+82w/xgyTVSRelwdk+FtOGXk8opWccuEjIT+LJuKveU6q5s
         ZyA4julKR+64w8aIjwzRqGEpIYoh19fSLZajixQ4ETaG6KAEa5p6i9bHYdtEHzPqnT
         HVHsE0C978BdDeHWy6BmigLiZ/vyKIwSKGb4eeRy91UpXyHJt1/IHuyxQaPAF6xHm3
         pF6yQ+jbLaPaJD0DNapJQxs66Nq23WzJJ6s/4qzaAo+rOks41ANqHeODrFJyLrTZXO
         EySX5o2+ARv2A==
Date:   Sun, 30 Jan 2022 13:51:55 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Thumshirn <johannes.thumshirn@men.de>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: men_z188_adc: Fix a resource leak in an error
 handling path
Message-ID: <20220130135155.024e08a2@jic23-huawei>
In-Reply-To: <320fc777863880247c2aff4a9d1a54ba69abf080.1643445149.git.christophe.jaillet@wanadoo.fr>
References: <320fc777863880247c2aff4a9d1a54ba69abf080.1643445149.git.christophe.jaillet@wanadoo.fr>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Jan 2022 09:32:47 +0100
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> If iio_device_register() fails, a previous ioremap() is left unbalanced.
> 
> Update the error handling path and add the missing iounmap() call, as
> already done in the remove function.
> 
> Fixes: 74aeac4da66f ("iio: adc: Add MEN 16z188 ADC driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
This is a good target for a devm_ conversion at somepoint, but this
is indeed the minimal fix so we should do this first.

Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/men_z188_adc.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/men_z188_adc.c b/drivers/iio/adc/men_z188_adc.c
> index 42ea8bc7e780..adc5ceaef8c9 100644
> --- a/drivers/iio/adc/men_z188_adc.c
> +++ b/drivers/iio/adc/men_z188_adc.c
> @@ -103,6 +103,7 @@ static int men_z188_probe(struct mcb_device *dev,
>  	struct z188_adc *adc;
>  	struct iio_dev *indio_dev;
>  	struct resource *mem;
> +	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(&dev->dev, sizeof(struct z188_adc));
>  	if (!indio_dev)
> @@ -128,8 +129,14 @@ static int men_z188_probe(struct mcb_device *dev,
>  	adc->mem = mem;
>  	mcb_set_drvdata(dev, indio_dev);
>  
> -	return iio_device_register(indio_dev);
> +	ret = iio_device_register(indio_dev);
> +	if (ret)
> +		goto err_unmap;
> +
> +	return 0;
>  
> +err_unmap:
> +	iounmap(adc->base);
>  err:
>  	mcb_release_mem(mem);
>  	return -ENXIO;

