Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996FA4C578A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 19:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbiBZSiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 13:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbiBZSiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 13:38:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E8D793A1;
        Sat, 26 Feb 2022 10:37:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E1BFB807ED;
        Sat, 26 Feb 2022 18:37:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4122FC340E8;
        Sat, 26 Feb 2022 18:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645900666;
        bh=jHdv8TslOgixwk58VM7A8maJnFfS6HoZABigDdSO7is=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vGI6m8bUo5pHatGP6Isqpu2AmgwdATtD3oU6NxWFZ8pt1oetiAKuPyfDtcytcaYwC
         zOKthwY7fdGp+T74NhOAbX8AUndQObiP3IG85sGiGJdWKQIOXtibN8jdzhXwBjH+W3
         QeuS7jFPcBxTL/pXdA0V2oUl+n1BGKCWAvhSMwrTcWvAGQ/seWrt1M3kge1EQTNScg
         xGkit97pEi2IE0e18i+xvd2uoxR+wlohP+j8PXRJnwo6/q/G2IcYdaMTt4r+someiL
         x5tYl5KORMaHwT7FAP93Upwhj7hNPkE3LR8kxGCUqYQKMWxqOZ+sBp/vBpYTjXdzMo
         I2qKylzQbkkBQ==
Date:   Sat, 26 Feb 2022 18:44:48 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     lars@metafoo.de, tangbin@cmss.chinamobile.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: Add check for devm_request_threaded_irq
Message-ID: <20220226184448.0a2a49b1@jic23-huawei>
In-Reply-To: <20220224062849.3280966-1-jiasheng@iscas.ac.cn>
References: <20220224062849.3280966-1-jiasheng@iscas.ac.cn>
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

On Thu, 24 Feb 2022 14:28:49 +0800
Jiasheng Jiang <jiasheng@iscas.ac.cn> wrote:

> As the potential failure of the devm_request_threaded_irq(),
> it should be better to check the return value and return
> error if fails.
> 
> Fixes: fa659a40b80b ("iio: adc: twl6030-gpadc: Use devm_* API family")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
Good find.

That one has been there a long time so I'm not going to rush this in
before the next merge window.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to see if we missed anything,

Thanks,

Jonathan

> ---
>  drivers/iio/adc/twl6030-gpadc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gpadc.c
> index afdb59e0b526..d0223e39d59a 100644
> --- a/drivers/iio/adc/twl6030-gpadc.c
> +++ b/drivers/iio/adc/twl6030-gpadc.c
> @@ -911,6 +911,8 @@ static int twl6030_gpadc_probe(struct platform_device *pdev)
>  	ret = devm_request_threaded_irq(dev, irq, NULL,
>  				twl6030_gpadc_irq_handler,
>  				IRQF_ONESHOT, "twl6030_gpadc", indio_dev);
> +	if (ret)
> +		return ret;
>  
>  	ret = twl6030_gpadc_enable_irq(TWL6030_GPADC_RT_SW1_EOC_MASK);
>  	if (ret < 0) {

