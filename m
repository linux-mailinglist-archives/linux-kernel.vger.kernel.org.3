Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3CD54C5732
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 18:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbiBZR5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 12:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiBZR5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 12:57:10 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD6FA9A59;
        Sat, 26 Feb 2022 09:56:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 23BA3CE02C8;
        Sat, 26 Feb 2022 17:56:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96DD9C340E8;
        Sat, 26 Feb 2022 17:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645898192;
        bh=f1rXPWhnxCOFRUgklAr10oBR5V9QeViM4cIzoipAr0I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gTFgsu3oqSxeTGW6t4K99u6bsKuLnM0Z0zDuE0FpogEYbof8dxbRy9WpK66gdCPh2
         a3wNnLegXNfyAFYn+o69ya7tvPS7SklitRNtbi6RCO3m4kzO71tKk3n4qjTlxY1Bmc
         EReZOzuSxN5b8RLqED+4CbzODhCHwyo6pNSelFkmAZZ2jt6FyJveP0gBuVRitIGA1u
         CnJets7xbFOk7DLYu+kJ5/oplp3UY1NZoPsoQ6GVWCntJKG/kk0O3JQEe9c7oVHPG7
         Es5X/9gbaE5BhyWXt6UOG3lNsMTTVtHT/VNXE7SNATHT65wanxPoW3pWjCrCaxuQqJ
         gwtIapBiqF1kQ==
Date:   Sat, 26 Feb 2022 18:03:32 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] iio: accel: adxl367: Fix uninitialized variable
 handled
Message-ID: <20220226180332.379a0ac2@jic23-huawei>
In-Reply-To: <20220224215149.146181-1-colin.i.king@gmail.com>
References: <20220224215149.146181-1-colin.i.king@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Feb 2022 21:51:49 +0000
Colin Ian King <colin.i.king@gmail.com> wrote:

> Variable handle is not initialized leading to potential garbage
> results with the or operations. Fix this by replacing the first
> or operation to an assignment to ensure handled is initialized
> correctly.
> 
> Fixes: cbab791c5e2a ("iio: accel: add ADXL367 driver")
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Hi Colin,

Nathan's patch hit my inbox first so I applied his but added
an additional Reported-by: for you to reflect you also reported it
via this patch.

Thanks

Jonathan

> ---
>  drivers/iio/accel/adxl367.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
> index b452d74b1d4d..350a89b61179 100644
> --- a/drivers/iio/accel/adxl367.c
> +++ b/drivers/iio/accel/adxl367.c
> @@ -884,7 +884,7 @@ static irqreturn_t adxl367_irq_handler(int irq, void *private)
>  	if (ret)
>  		return IRQ_NONE;
>  
> -	handled |= adxl367_push_event(indio_dev, status);
> +	handled = adxl367_push_event(indio_dev, status);
>  	handled |= adxl367_push_fifo_data(indio_dev, status, fifo_entries);
>  
>  	return handled ? IRQ_HANDLED : IRQ_NONE;

