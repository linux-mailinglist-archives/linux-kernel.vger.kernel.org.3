Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1815558BB28
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 16:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbiHGOIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 10:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233849AbiHGOIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 10:08:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5519A460;
        Sun,  7 Aug 2022 07:08:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DDE360EE7;
        Sun,  7 Aug 2022 14:08:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BAE0C433D7;
        Sun,  7 Aug 2022 14:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659881297;
        bh=vQJxMRNWo4+kR/062cQxsou4ml9ZapoIw81lPoLiEuw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e6de5Q3lpUx9P8TwlLfMtthooVNj6Uj2FuTy+WGn/b4PfsSxC/pldx7Zmo1Lg7PCc
         fCcSsiztTZTtW7sJ2Ne1nwPiLvtChtyXpzM1dGS7JP2/VpqEwo3vT9QB5JXkSmKDml
         nqJu2hS4hX+LtsmxBsCDCFZIL5mWjfDnOWIGabckVSGMvvvXt30kh+J3ymWt7/xrTV
         obFa4Njfq5WPwr+NkVrVishM3AGBjVTSFFoK/V7P5VIXFltzE3YdrnknB1xH3f9v+e
         ffy+cly0aYgHFMeSZXrkJE4kPbBfUfw7MtDGUbM0T53tc2fN3XKQqeXmEYUKh9N+11
         YRRSsbnIOEHDQ==
Date:   Sun, 7 Aug 2022 15:18:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Kevin Tsai <ktsai@capellamicro.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: light: cm3605: Fix an error handling path in
 cm3605_probe()
Message-ID: <20220807151836.5300af2b@jic23-huawei>
In-Reply-To: <0e186de2c125b3e17476ebf9c54eae4a5d66f994.1659854238.git.christophe.jaillet@wanadoo.fr>
References: <0e186de2c125b3e17476ebf9c54eae4a5d66f994.1659854238.git.christophe.jaillet@wanadoo.fr>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  7 Aug 2022 08:37:43 +0200
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> The commit in Fixes also introduced a new error handling path which should
> goto the existing error handling path.
> Otherwise some resources leak.
> 
> Fixes: 0d31d91e6145 ("iio: light: cm3605: Make use of the helper function dev_err_probe()")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
oops. 

Applied to the fixes-togreg branch of iio.git.

I've just move that branch forwards to current char-misc-linus which includes
Greg's pull requests for this cycle via Linus' tree, but may well
rebase on rc1 once that's available.

Thanks,

Jonathan

> ---
>  drivers/iio/light/cm3605.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/cm3605.c b/drivers/iio/light/cm3605.c
> index c721b69d5095..0b30db77f78b 100644
> --- a/drivers/iio/light/cm3605.c
> +++ b/drivers/iio/light/cm3605.c
> @@ -226,8 +226,10 @@ static int cm3605_probe(struct platform_device *pdev)
>  	}
>  
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0)
> -		return dev_err_probe(dev, irq, "failed to get irq\n");
> +	if (irq < 0) {
> +		ret = dev_err_probe(dev, irq, "failed to get irq\n");
> +		goto out_disable_aset;
> +	}
>  
>  	ret = devm_request_threaded_irq(dev, irq, cm3605_prox_irq,
>  					NULL, 0, "cm3605", indio_dev);

