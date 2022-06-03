Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8069753CCFE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 18:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343664AbiFCQMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 12:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343659AbiFCQMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 12:12:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3CC24591;
        Fri,  3 Jun 2022 09:12:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3765D61988;
        Fri,  3 Jun 2022 16:12:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3980C385A9;
        Fri,  3 Jun 2022 16:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654272737;
        bh=O9M5jqdylfIYfPPpysrTSvpb5Slsp0Ov8SEYrUNJiRs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KQVT60gjcauzcYjwva9tzOpQ2w+i89jrkPNenFv4Y74edbsCMOv5m50Ec+jofIe6c
         C+EqPf6Wd3vnsieZ/Pj72WbHbtO8ihiv/EcpJaRbpkB0gwr2vdde1wEzgaSkkO7kWI
         U1ZXQjPAAzB3ZfvBZp3sdsRAf+PUn9shAuYbCmnvdPzmWIZu8nO/z8+jRdxvnLqHXS
         0l9fy9HXF4CPmfmAPCluDMT7BySyzznnWyM3jXzsNjHORYgGJ2P6vjq3ZRY+rU0lqk
         xfiWFz79f+EI8EyMMyihqFD0APlz6dfM/abhxLHRhYVy4w+6P01L1/3Ew+ftJQjmKe
         wiOfUL8KR8bLA==
Date:   Fri, 3 Jun 2022 17:21:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v3 2/6] iio: adc: meson_saradc: Align messages to be
 with physical device prefix
Message-ID: <20220603172117.792ce869@jic23-huawei>
In-Reply-To: <20220603100004.70336-2-andriy.shevchenko@linux.intel.com>
References: <20220603100004.70336-1-andriy.shevchenko@linux.intel.com>
        <20220603100004.70336-2-andriy.shevchenko@linux.intel.com>
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

On Fri,  3 Jun 2022 13:00:00 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Align messages to be printed with the physical device prefix as it's done
> everywhere else in this driver.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Here I'm fine with the use of the parent as can only happen after all
the setup is done, so it's obvious the parent will be assigned
(some might argue it is obvious in the previous patch, but I had to check
as I couldn't remember when we set it :)

Anyhow, LGTM. 
> ---
> v3: new patch (inspired by previous change)
>  drivers/iio/adc/meson_saradc.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> index 4fe6b997cd03..658047370db0 100644
> --- a/drivers/iio/adc/meson_saradc.c
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -345,6 +345,7 @@ static int meson_sar_adc_read_raw_sample(struct iio_dev *indio_dev,
>  					 int *val)
>  {
>  	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
> +	struct device *dev = indio_dev->dev.parent;
>  	int regval, fifo_chan, fifo_val, count;
>  
>  	if (!wait_for_completion_timeout(&priv->done,
> @@ -353,16 +354,14 @@ static int meson_sar_adc_read_raw_sample(struct iio_dev *indio_dev,
>  
>  	count = meson_sar_adc_get_fifo_count(indio_dev);
>  	if (count != 1) {
> -		dev_err(&indio_dev->dev,
> -			"ADC FIFO has %d element(s) instead of one\n", count);
> +		dev_err(dev, "ADC FIFO has %d element(s) instead of one\n", count);
>  		return -EINVAL;
>  	}
>  
>  	regmap_read(priv->regmap, MESON_SAR_ADC_FIFO_RD, &regval);
>  	fifo_chan = FIELD_GET(MESON_SAR_ADC_FIFO_RD_CHAN_ID_MASK, regval);
>  	if (fifo_chan != chan->address) {
> -		dev_err(&indio_dev->dev,
> -			"ADC FIFO entry belongs to channel %d instead of %lu\n",
> +		dev_err(dev, "ADC FIFO entry belongs to channel %d instead of %lu\n",
>  			fifo_chan, chan->address);
>  		return -EINVAL;
>  	}

