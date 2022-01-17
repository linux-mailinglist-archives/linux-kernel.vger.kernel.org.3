Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F230F490315
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 08:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237654AbiAQHqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 02:46:07 -0500
Received: from first.geanix.com ([116.203.34.67]:37718 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235289AbiAQHqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 02:46:05 -0500
Received: from skn-laptop.hadsten (unknown [185.233.254.173])
        by first.geanix.com (Postfix) with ESMTPSA id DFC6EE1C31;
        Mon, 17 Jan 2022 07:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1642405562; bh=wBNx6sRPedjd7oOlbFst7M+VLUAgT59jpgSY1ikPP7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=X32/OMSHN+GNr6594QlDkAddn6aARUQ1QKGj8fUVBstkMGs+FA4lP9BUWueau77iX
         ckhZCgHWi+gxefyNHYedwWppXP1H0eZ/jeNtxXnI+9UtQNTw72JfP5n+jMNY1e6ykD
         buFEJ9Y66eWy1AAxHnpMgxM39c9B+tDdYP8/rMm+fr1Bkaj7wBuappalehl+QO60ws
         XaBU1p1kJkx5RXls+hvFqkle5XTX08rZ9Z7w+dSkWa+kPWy+S7L5S/3FKSpxaeZHf2
         OgfeCtU16vTkYijkNia5yKlSdAjjRtMT4Tn9g4POFtJFBaR+1YKBt4Ck2LD2o2vhMP
         S2++UnNkCNCsg==
Date:   Mon, 17 Jan 2022 08:46:00 +0100
From:   Sean Nyekjaer <sean@geanix.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: fxls8962af: add padding to regmap for SPI
Message-ID: <20220117074600.gmfonh35ptx6kqbs@skn-laptop.hadsten>
References: <20211220125144.3630539-1-sean@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211220125144.3630539-1-sean@geanix.com>
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on 13e2a5895688
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 01:51:43PM +0100, Sean Nyekjaer wrote:
> Add missing don't care padding between address and
> data for SPI transfers
> 
> Fixes: a3e0b51884ee ("iio: accel: add support for FXLS8962AF/FXLS8964AF accelerometers")
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
>  drivers/iio/accel/fxls8962af-core.c | 12 ++++++++++--
>  drivers/iio/accel/fxls8962af-i2c.c  |  2 +-
>  drivers/iio/accel/fxls8962af-spi.c  |  2 +-
>  drivers/iio/accel/fxls8962af.h      |  3 ++-
>  4 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
> index 32989d91b982..f7fd9e046588 100644
> --- a/drivers/iio/accel/fxls8962af-core.c
> +++ b/drivers/iio/accel/fxls8962af-core.c
> @@ -173,12 +173,20 @@ struct fxls8962af_data {
>  	u16 upper_thres;
>  };
>  
> -const struct regmap_config fxls8962af_regmap_conf = {
> +const struct regmap_config fxls8962af_i2c_regmap_conf = {
>  	.reg_bits = 8,
>  	.val_bits = 8,
>  	.max_register = FXLS8962AF_MAX_REG,
>  };
> -EXPORT_SYMBOL_GPL(fxls8962af_regmap_conf);
> +EXPORT_SYMBOL_GPL(fxls8962af_i2c_regmap_conf);
> +
> +const struct regmap_config fxls8962af_spi_regmap_conf = {
> +	.reg_bits = 8,
> +	.pad_bits = 8,
> +	.val_bits = 8,
> +	.max_register = FXLS8962AF_MAX_REG,
> +};
> +EXPORT_SYMBOL_GPL(fxls8962af_spi_regmap_conf);
>  
>  enum {
>  	fxls8962af_idx_x,
> diff --git a/drivers/iio/accel/fxls8962af-i2c.c b/drivers/iio/accel/fxls8962af-i2c.c
> index cfb004b20455..6bde9891effb 100644
> --- a/drivers/iio/accel/fxls8962af-i2c.c
> +++ b/drivers/iio/accel/fxls8962af-i2c.c
> @@ -18,7 +18,7 @@ static int fxls8962af_probe(struct i2c_client *client)
>  {
>  	struct regmap *regmap;
>  
> -	regmap = devm_regmap_init_i2c(client, &fxls8962af_regmap_conf);
> +	regmap = devm_regmap_init_i2c(client, &fxls8962af_i2c_regmap_conf);
>  	if (IS_ERR(regmap)) {
>  		dev_err(&client->dev, "Failed to initialize i2c regmap\n");
>  		return PTR_ERR(regmap);
> diff --git a/drivers/iio/accel/fxls8962af-spi.c b/drivers/iio/accel/fxls8962af-spi.c
> index 57108d3d480b..6f4dff3238d3 100644
> --- a/drivers/iio/accel/fxls8962af-spi.c
> +++ b/drivers/iio/accel/fxls8962af-spi.c
> @@ -18,7 +18,7 @@ static int fxls8962af_probe(struct spi_device *spi)
>  {
>  	struct regmap *regmap;
>  
> -	regmap = devm_regmap_init_spi(spi, &fxls8962af_regmap_conf);
> +	regmap = devm_regmap_init_spi(spi, &fxls8962af_spi_regmap_conf);
>  	if (IS_ERR(regmap)) {
>  		dev_err(&spi->dev, "Failed to initialize spi regmap\n");
>  		return PTR_ERR(regmap);
> diff --git a/drivers/iio/accel/fxls8962af.h b/drivers/iio/accel/fxls8962af.h
> index b67572c3ef06..9cbe98c3ba9a 100644
> --- a/drivers/iio/accel/fxls8962af.h
> +++ b/drivers/iio/accel/fxls8962af.h
> @@ -17,6 +17,7 @@ int fxls8962af_core_probe(struct device *dev, struct regmap *regmap, int irq);
>  int fxls8962af_core_remove(struct device *dev);
>  
>  extern const struct dev_pm_ops fxls8962af_pm_ops;
> -extern const struct regmap_config fxls8962af_regmap_conf;
> +extern const struct regmap_config fxls8962af_i2c_regmap_conf;
> +extern const struct regmap_config fxls8962af_spi_regmap_conf;
>  
>  #endif				/* _FXLS8962AF_H_ */
> -- 
> 2.34.1
> 

Hi Jonathan,

Did you have time to look at this?

/Sean
