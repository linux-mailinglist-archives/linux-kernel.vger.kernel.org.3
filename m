Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC0154764F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 18:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238625AbiFKQDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 12:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbiFKQDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 12:03:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77E21115E;
        Sat, 11 Jun 2022 09:03:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53E726114E;
        Sat, 11 Jun 2022 16:03:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F1DC34116;
        Sat, 11 Jun 2022 16:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654963426;
        bh=pXHToWyY4mQlOO2SpdBWrNbDgW1ppK7DRYcXS5SEyLY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uwuPyfLgxPj2gsic7f2BhqkH5xVXwidkQq9VAN0ltcK0I6r804hmrQwTTpOF5QIHd
         uXy5fSoBEPOSosIa3OpoK0MIezJFgnXjHErvmsSIKjZqpy63mD2f1WwDaukkaxYmuf
         zQ/KJU5IJ82sTzb6/XhUsi9VU9zhn24o76wG/Z649z3gHYQk+/VAFYPBVDC8f6UEu+
         y2rhrimXdZtLOE29TPlhdDkeGhzHSlM//EkV3QpCtWSgpE/Z+whCiPgIhg2Hy1lQce
         skzlD5swkGL11Ax5ZdaqtvPDh9sKZHspPm30rb37TMBMIdghRO+QtMLbd6gpMfW6+g
         qJ7qr+aD/GCdQ==
Date:   Sat, 11 Jun 2022 17:12:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Olivier Moysan <olivier.moysan@foss.st.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Wan Jiabing <wanjiabing@vivo.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH] iio: adc: stm32: fix vrefint wrong calibration value
 handling
Message-ID: <20220611171255.6cbc16c0@jic23-huawei>
In-Reply-To: <20220609095856.376961-1-olivier.moysan@foss.st.com>
References: <20220609095856.376961-1-olivier.moysan@foss.st.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jun 2022 11:58:56 +0200
Olivier Moysan <olivier.moysan@foss.st.com> wrote:

> If the vrefint calibration is zero, the vrefint channel output value
> cannot be computed. Currently, in such case, the raw conversion value
> is returned, which is not relevant.
> Do not expose the vrefint channel when the output value cannot be
> computed, instead.
> 
> Fixes: 0e346b2cfa85 ("iio: adc: stm32-adc: add vrefint calibration support")
> 
No line break here. Fixes is part of the tag block (and a pull request sent with
this gap will get rejected). Fixed up whilst applying.
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>

Applied to the fixes-togreg branch of iiogit.

I initially wondered if using -ENOENT for this was safe in that it couldn't
come from anywhere else.  Looks like it is given how little this function does
so fair enough.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/stm32-adc.c | 27 +++++++++++++++++----------
>  1 file changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index a68ecbda6480..f13c112f540f 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -1365,7 +1365,7 @@ static int stm32_adc_read_raw(struct iio_dev *indio_dev,
>  		else
>  			ret = -EINVAL;
>  
> -		if (mask == IIO_CHAN_INFO_PROCESSED && adc->vrefint.vrefint_cal)
> +		if (mask == IIO_CHAN_INFO_PROCESSED)
>  			*val = STM32_ADC_VREFINT_VOLTAGE * adc->vrefint.vrefint_cal / *val;
>  
>  		iio_device_release_direct_mode(indio_dev);
> @@ -1979,10 +1979,10 @@ static int stm32_adc_populate_int_ch(struct iio_dev *indio_dev, const char *ch_n
>  
>  	for (i = 0; i < STM32_ADC_INT_CH_NB; i++) {
>  		if (!strncmp(stm32_adc_ic[i].name, ch_name, STM32_ADC_CH_SZ)) {
> -			adc->int_ch[i] = chan;
> -
> -			if (stm32_adc_ic[i].idx != STM32_ADC_INT_CH_VREFINT)
> -				continue;
> +			if (stm32_adc_ic[i].idx != STM32_ADC_INT_CH_VREFINT) {
> +				adc->int_ch[i] = chan;
> +				break;
> +			}
>  
>  			/* Get calibration data for vrefint channel */
>  			ret = nvmem_cell_read_u16(&indio_dev->dev, "vrefint", &vrefint);
> @@ -1990,10 +1990,15 @@ static int stm32_adc_populate_int_ch(struct iio_dev *indio_dev, const char *ch_n
>  				return dev_err_probe(indio_dev->dev.parent, ret,
>  						     "nvmem access error\n");
>  			}
> -			if (ret == -ENOENT)
> -				dev_dbg(&indio_dev->dev, "vrefint calibration not found\n");
> -			else
> -				adc->vrefint.vrefint_cal = vrefint;
> +			if (ret == -ENOENT) {
> +				dev_dbg(&indio_dev->dev, "vrefint calibration not found. Skip vrefint channel\n");
> +				return ret;
> +			} else if (!vrefint) {
> +				dev_dbg(&indio_dev->dev, "Null vrefint calibration value. Skip vrefint channel\n");
> +				return -ENOENT;
> +			}
> +			adc->int_ch[i] = chan;
> +			adc->vrefint.vrefint_cal = vrefint;
>  		}
>  	}
>  
> @@ -2030,7 +2035,9 @@ static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
>  			}
>  			strncpy(adc->chan_name[val], name, STM32_ADC_CH_SZ);
>  			ret = stm32_adc_populate_int_ch(indio_dev, name, val);
> -			if (ret)
> +			if (ret == -ENOENT)
> +				continue;
> +			else if (ret)
>  				goto err;
>  		} else if (ret != -EINVAL) {
>  			dev_err(&indio_dev->dev, "Invalid label %d\n", ret);

