Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274DD563820
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 18:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbiGAQkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 12:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbiGAQkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 12:40:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BDB27FF5;
        Fri,  1 Jul 2022 09:40:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CCFA62135;
        Fri,  1 Jul 2022 16:40:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE950C341C7;
        Fri,  1 Jul 2022 16:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656693605;
        bh=ELXcZJElN/A6bSufZdnLypdmVgxyKZbLEyPYVr2U9m8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NRbf97Pq0eVt5tY1lxoCOAIiR0L+FCltn/9eUPXin+K8U00JkLeSw82d2wvNisxQU
         xp1iu+by40cirjRZjFpMl2rcHotmdwM/xzLlLKRbMSBVUjuAvdPaUVuUXFTsJSKQq/
         7nAC6N2lUEBaQ2zy2mRvWqAmGtm6eGDcxkiEtEck9dxpJpqh4EgNHHzOch/ZFCbvHt
         Ag6DbswQiHoAenv7SzVPchZwJCSG4KfWzJf/0VhgUSRiMkW7nRCCW/CeuDa+oyLbsX
         D+jmjOLgepL1yD7kB/WECX7oHeOQENs0xFrLpaO5cmXsisim49DPOrLlKiITc3BshU
         Lu8UcMs1fRUjA==
Date:   Fri, 1 Jul 2022 17:49:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/1] iio: adc: tsc2046: silent spi_device_id
 warning
Message-ID: <20220701174940.6a0f3e02@jic23-huawei>
In-Reply-To: <20220630075155.2718293-1-o.rempel@pengutronix.de>
References: <20220630075155.2718293-1-o.rempel@pengutronix.de>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jun 2022 09:51:55 +0200
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Add spi_device_id to silent following warning:
>  SPI driver tsc2046 has no spi_device_id for ti,tsc2046e-adc
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
If the device was probed via this path (old school board file
or similar) then the device_get_matchdata() call will fail.

So I think we need to add handling for this case.  Usually
along lines of
if (dev_fwnode)
	.. device_get_match_data()
else
	.. handle what is the spi_device_id structure


> ---
>  drivers/iio/adc/ti-tsc2046.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/iio/adc/ti-tsc2046.c b/drivers/iio/adc/ti-tsc2046.c
> index 55b35570ad8b..27dc959aee37 100644
> --- a/drivers/iio/adc/ti-tsc2046.c
> +++ b/drivers/iio/adc/ti-tsc2046.c
> @@ -833,11 +833,18 @@ static const struct of_device_id ads7950_of_table[] = {
>  };
>  MODULE_DEVICE_TABLE(of, ads7950_of_table);
>  
> +static const struct spi_device_id tsc2046_adc_spi_ids[] = {
> +	{ "tsc2046e-adc" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(spi, tsc2046_adc_spi_ids);
> +
>  static struct spi_driver tsc2046_adc_driver = {
>  	.driver = {
>  		.name = "tsc2046",
>  		.of_match_table = ads7950_of_table,
>  	},
> +	.id_table = tsc2046_adc_spi_ids,
>  	.probe = tsc2046_adc_probe,
>  };
>  module_spi_driver(tsc2046_adc_driver);

