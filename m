Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1885A6451
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 15:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbiH3NCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 09:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiH3NCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 09:02:33 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7AE7B2B4;
        Tue, 30 Aug 2022 06:02:32 -0700 (PDT)
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MH6s14Zqdz686l0;
        Tue, 30 Aug 2022 21:01:57 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 30 Aug 2022 15:02:29 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 30 Aug
 2022 14:02:29 +0100
Date:   Tue, 30 Aug 2022 14:02:28 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <kernel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v1 3/3] iio: adc: tsc2046: silent spi_device_id warning
Message-ID: <20220830140228.000013ca@huawei.com>
In-Reply-To: <20220830110709.2037302-3-o.rempel@pengutronix.de>
References: <20220830110709.2037302-1-o.rempel@pengutronix.de>
        <20220830110709.2037302-3-o.rempel@pengutronix.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Aug 2022 13:07:09 +0200
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Add spi_device_id to silent following warning:
>  SPI driver tsc2046 has no spi_device_id for ti,tsc2046e-adc
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/iio/adc/ti-tsc2046.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ti-tsc2046.c b/drivers/iio/adc/ti-tsc2046.c
> index bbc8b4137b0b1..b9a1fac659d46 100644
> --- a/drivers/iio/adc/ti-tsc2046.c
> +++ b/drivers/iio/adc/ti-tsc2046.c
> @@ -761,7 +761,15 @@ static int tsc2046_adc_probe(struct spi_device *spi)
>  		return -EINVAL;
>  	}
>  
> -	dcfg = device_get_match_data(dev);
> +	if (!dev_fwnode(dev)) {
> +		const struct spi_device_id *id;
> +
> +		id = spi_get_device_id(spi);
> +		dcfg = (const struct tsc2046_adc_dcfg *)id->driver_data;

Driver data not set below.

Otherwise this looks good to me.  An alternative more common form (I think...)
is call device_get_match_data() unconditionally and if that is null follow
the driver_data path. Either way is fine though.

Could you add to the patch description where
the warning is coming from?   Build time / runtime etc and what tool?

Thanks,

Jonathan


> +	} else {
> +		dcfg = device_get_match_data(dev);
> +	}
> +
>  	if (!dcfg)
>  		return -EINVAL;
>  
> @@ -878,11 +886,18 @@ static const struct of_device_id ads7950_of_table[] = {
>  };
>  MODULE_DEVICE_TABLE(of, ads7950_of_table);
>  
> +static const struct spi_device_id tsc2046_adc_spi_ids[] = {
> +	{ "tsc2046e-adc" },
> +	{ }
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
>  	.remove = tsc2046_adc_remove,
>  };

