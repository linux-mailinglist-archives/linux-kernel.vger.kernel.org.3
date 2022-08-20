Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0231459AD68
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 13:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344966AbiHTLKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 07:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344938AbiHTLKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 07:10:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3324C81B11;
        Sat, 20 Aug 2022 04:10:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBDBA61142;
        Sat, 20 Aug 2022 11:10:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E13C433C1;
        Sat, 20 Aug 2022 11:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660993845;
        bh=SpKcHb9Mx7w7JSXRfOmqDCXQ+vL+4rbX9cOzYzRr/qw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C9i25GzTaM97Nx6qFmZVqM5XnwClDgfjAfOyZgIA4mUQmDgUoq4KIw+2+UKr2zJP5
         fSzFWqIX3eeBIv5fLRYtGMcepwt4nzjEuYHcAJ7ilCe3wM5fbeMEFUfJrmeHY07lEj
         GdnOmZASXD7tf8pEPtalvWpeUQdS0O3AHK0pAxRrL97kot8JE8H20OBAjZ+UMB2b/A
         PauyahnJl6QTu9quHAD5/0z+D1pWloVVQsOghZ/udf9qmXHmE5gWUAgt8+iyw2Tazi
         ao196c5R4aof9vkcznSxt4ogG43s/UrtlM2ziL3jZUUlSMQcHhEwTOBUbccBfOyOkH
         CpTCly2FSZmmw==
Date:   Sat, 20 Aug 2022 12:21:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 07/14] iio: ltc2688: Simplify using
 devm_regulator_*get_enable()
Message-ID: <20220820122120.57dddcab@jic23-huawei>
In-Reply-To: <a29493f594c84b3bd852e462bbd3e591a8575a27.1660934107.git.mazziesaccount@gmail.com>
References: <cover.1660934107.git.mazziesaccount@gmail.com>
        <a29493f594c84b3bd852e462bbd3e591a8575a27.1660934107.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Fri, 19 Aug 2022 22:19:17 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Use devm_regulator_bulk_get_enable() instead of open coded bulk-get,
> bulk-enable, add-action-to-disable-at-detach - pattern.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> ---
> v2 => v3
> Split to own patch.
> ---
>  drivers/iio/dac/ltc2688.c | 23 +++--------------------
>  1 file changed, 3 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iio/dac/ltc2688.c b/drivers/iio/dac/ltc2688.c
> index 28bdde2d3088..fcad3efe62ea 100644
> --- a/drivers/iio/dac/ltc2688.c
> +++ b/drivers/iio/dac/ltc2688.c
> @@ -84,7 +84,6 @@ struct ltc2688_chan {
>  struct ltc2688_state {
>  	struct spi_device *spi;
>  	struct regmap *regmap;
> -	struct regulator_bulk_data regulators[2];
>  	struct ltc2688_chan channels[LTC2688_DAC_CHANNELS];
>  	struct iio_chan_spec *iio_chan;
>  	/* lock to protect against multiple access to the device and shared data */
> @@ -902,13 +901,6 @@ static int ltc2688_setup(struct ltc2688_state *st, struct regulator *vref)
>  			       LTC2688_CONFIG_EXT_REF);
>  }
>  
> -static void ltc2688_disable_regulators(void *data)
> -{
> -	struct ltc2688_state *st = data;
> -
> -	regulator_bulk_disable(ARRAY_SIZE(st->regulators), st->regulators);
> -}
> -
>  static void ltc2688_disable_regulator(void *regulator)
>  {
>  	regulator_disable(regulator);
> @@ -970,6 +962,7 @@ static int ltc2688_probe(struct spi_device *spi)
>  	struct regulator *vref_reg;
>  	struct device *dev = &spi->dev;
>  	int ret;
> +	static const char * const regulators[] = {"vcc", "iovcc"};
trivial - slight preference for 
 { "vcc", "iovcc" };

This isn't as important as for numeric values as we get some readability
from the quotes but still nice to have.

For the whole static / vs non static. My personal preference is not
to have the static marking but I don't care that much.

>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
>  	if (!indio_dev)
> @@ -988,21 +981,11 @@ static int ltc2688_probe(struct spi_device *spi)
>  		return dev_err_probe(dev, PTR_ERR(st->regmap),
>  				     "Failed to init regmap");
>  
> -	st->regulators[0].supply = "vcc";
> -	st->regulators[1].supply = "iovcc";
> -	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(st->regulators),
> -				      st->regulators);
> -	if (ret)
> -		return dev_err_probe(dev, ret, "Failed to get regulators\n");
> -
> -	ret = regulator_bulk_enable(ARRAY_SIZE(st->regulators), st->regulators);
> +	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulators),
> +					     regulators);
>  	if (ret)
>  		return dev_err_probe(dev, ret, "Failed to enable regulators\n");
>  
> -	ret = devm_add_action_or_reset(dev, ltc2688_disable_regulators, st);
> -	if (ret)
> -		return ret;
> -
>  	vref_reg = devm_regulator_get_optional(dev, "vref");
>  	if (IS_ERR(vref_reg)) {
>  		if (PTR_ERR(vref_reg) != -ENODEV)

