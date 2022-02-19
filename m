Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818334BC93A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 16:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242570AbiBSPxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 10:53:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233978AbiBSPxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 10:53:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC130C34;
        Sat, 19 Feb 2022 07:53:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AECC60B64;
        Sat, 19 Feb 2022 15:53:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F10FBC004E1;
        Sat, 19 Feb 2022 15:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645285995;
        bh=11WW/0CiWWZWGKAlkXmLRY9zQt6EZ/inhLlfKd2t1A4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NrQkJ89IEx40yyfAVF3VfET136xZuCzqYWcRFvS5ee2ja7Ft4X6napM2LZkJuwNBz
         MWrPpGQVMACJwNX7COvOz67F/vFv0MbXghjvG33HGxVKrMn6cZHJ3QdIt2lkaeoUmq
         uZj8JaNHbKDtXl9Ru43GMDMQ/LzR/MRIPQS0d5xh1viDi01JVO/YwSMw746uSYEFL7
         eFCyEvtSSiZakS7BIqO5lEHFCXGYY0MqIH/pvBDHZxmZM8TFopsizZwu7VKuvxQi1i
         4ghNAtBMLKwQIfnoFp+34PqnlScK51VwXPSsIfol3WS7fiGCJMGBnnGKVVUPvJTk+R
         vghP+RdHubACA==
Date:   Sat, 19 Feb 2022 16:00:02 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     <lars@metafoo.de>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <colin.king@canonical.com>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        Konstantin Klubnichkin <kitsok@yandex-team.ru>
Subject: Re: [PATCH] iio: adc: aspeed: Add divider flag to fix incorrect
 voltage reading.
Message-ID: <20220219160002.46e301b8@jic23-huawei>
In-Reply-To: <20220218085708.8194-1-billy_tsai@aspeedtech.com>
References: <20220218085708.8194-1-billy_tsai@aspeedtech.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Feb 2022 16:57:08 +0800
Billy Tsai <billy_tsai@aspeedtech.com> wrote:

> The formula for the ADC sampling period in ast2400/ast2500 is:
> ADC clock period = PCLK * 2 * (ADC0C[31:17] + 1) * (ADC0C[9:0])
> When ADC0C[9:0] is set to 0 the sampling voltage will be lower than
> expected, because the hardware may not have enough time to
> charge/discharge to a stable voltage.
> 
> Reported-by: Konstantin Klubnichkin <kitsok@yandex-team.ru>
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
Hi Billy,

Fixes tag?

Also, would be good to call out in the patch description that
CLK_DIVIDER_ONE_BASED rules at 0 as a valid value and hence
avoids the ADC0C[9:0] value of 0 that is causing problems.

That may be obvious to people who make frequent use of clk dividers
but it's not locally obvious when looking at this patch.

Otherwise looks good to me.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/aspeed_adc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
> index a957cad1bfab..ffae64f39221 100644
> --- a/drivers/iio/adc/aspeed_adc.c
> +++ b/drivers/iio/adc/aspeed_adc.c
> @@ -539,7 +539,9 @@ static int aspeed_adc_probe(struct platform_device *pdev)
>  	data->clk_scaler = devm_clk_hw_register_divider(
>  		&pdev->dev, clk_name, clk_parent_name, scaler_flags,
>  		data->base + ASPEED_REG_CLOCK_CONTROL, 0,
> -		data->model_data->scaler_bit_width, 0, &data->clk_lock);
> +		data->model_data->scaler_bit_width,
> +		data->model_data->need_prescaler ? CLK_DIVIDER_ONE_BASED : 0,
> +		&data->clk_lock);
>  	if (IS_ERR(data->clk_scaler))
>  		return PTR_ERR(data->clk_scaler);
>  

