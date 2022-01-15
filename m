Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF79448F8D8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 19:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbiAOSqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 13:46:08 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50410 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbiAOSqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 13:46:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B478B80A72;
        Sat, 15 Jan 2022 18:46:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D87FC36AE5;
        Sat, 15 Jan 2022 18:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642272363;
        bh=whQ8uNyDbpEy/G7Yas7JugsPMYKeBy4tvjBVcxsb8OA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cyLW0NJpUjExD1P4hjNorI3427pPrmzLCqGyMOSXtUPC/K9s3PGTvSeYrE8u0ae9w
         L5ZRqVkTsV2SOlhpx368Orw586/mpHsnNLq2v1Fw/LHnX4KW3GnPyIj0VOt0n+Z3Ua
         5HjfaIDIVKdBZRZCo9VZdbbzqMhiS+cLx3/kZrjeoxOwFV7OEoZn87L6D1dHdB0NU5
         6m74kQScYYNZdm4KNenXevLFwOQ/Tfc4yKFSrfz+O89CIkCyVUac8M4fZj+bHqrHVy
         AdxmOi2ZMO0/gyzFBefq4I1Sf+4k9p36+E3YCV8N3sD57P2dlMmbJfobOKQWmaReLo
         jS95InmSp0Lcw==
Date:   Sat, 15 Jan 2022 18:52:03 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v2 5/5] iio: afe: iio-rescale: Re-use generic struct
 s32_fract
Message-ID: <20220115185203.567780e8@jic23-huawei>
In-Reply-To: <20220110193104.75225-5-andriy.shevchenko@linux.intel.com>
References: <20220110193104.75225-1-andriy.shevchenko@linux.intel.com>
        <20220110193104.75225-5-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jan 2022 21:31:04 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Instead of custom data type re-use generic struct s32_fract.
> No changes intended.
> 
> The new member is put to be the first one to avoid additional
> pointer arithmetic. Besides that one may switch to use fract
> member to perform container_of(), which will be no-op in this
> case, to get struct rescale.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I'm not totally sold on this series showing there is a strong case for
these macros so interested to hear what others think.
Boiler plate removal is always nice of course...

One trivial comment inline on this one.

> ---
> 
> I found this better in order how code is structurally (re)organized.
> I may rebase this on top of ongoing AFE series.
> 
> Also reveals possibility to switch to rational best approximation.
> But this is another story...

Now that may well justify introducing this shared infrastructure :)

> 
> v2: no changes
> 
>  drivers/iio/afe/iio-rescale.c | 74 +++++++++++++++++------------------
>  1 file changed, 37 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
> index 774eb3044edd..0368bca8a485 100644
> --- a/drivers/iio/afe/iio-rescale.c
> +++ b/drivers/iio/afe/iio-rescale.c
> @@ -11,6 +11,7 @@
>  #include <linux/gcd.h>
>  #include <linux/iio/consumer.h>
>  #include <linux/iio/iio.h>
> +#include <linux/math.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> @@ -21,17 +22,16 @@ struct rescale;
>  
>  struct rescale_cfg {
>  	enum iio_chan_type type;
> -	int (*props)(struct device *dev, struct rescale *rescale);
> +	int (*props)(struct device *dev, struct s32_fract *fract);
>  };
>  
>  struct rescale {
> +	struct s32_fract fract;
>  	const struct rescale_cfg *cfg;
>  	struct iio_channel *source;
>  	struct iio_chan_spec chan;
>  	struct iio_chan_spec_ext_info *ext_info;
>  	bool chan_processed;
> -	s32 numerator;
> -	s32 denominator;
>  };
>  
>  static int rescale_read_raw(struct iio_dev *indio_dev,
> @@ -39,6 +39,7 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
>  			    int *val, int *val2, long mask)
>  {
>  	struct rescale *rescale = iio_priv(indio_dev);
> +	struct s32_fract *fract = &rescale->fract;
>  	unsigned long long tmp;
>  	int ret;
>  
> @@ -67,19 +68,19 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
>  		}
>  		switch (ret) {
>  		case IIO_VAL_FRACTIONAL:
> -			*val *= rescale->numerator;
> -			*val2 *= rescale->denominator;
> +			*val *= fract->numerator;
> +			*val2 *= fract->denominator;
>  			return ret;
>  		case IIO_VAL_INT:
> -			*val *= rescale->numerator;
> -			if (rescale->denominator == 1)
> +			*val *= fract->numerator;
> +			if (fract->denominator == 1)
>  				return ret;
> -			*val2 = rescale->denominator;
> +			*val2 = fract->denominator;
>  			return IIO_VAL_FRACTIONAL;
>  		case IIO_VAL_FRACTIONAL_LOG2:
>  			tmp = *val * 1000000000LL;
> -			do_div(tmp, rescale->denominator);
> -			tmp *= rescale->numerator;
> +			do_div(tmp, fract->denominator);
> +			tmp *= fract->numerator;
>  			do_div(tmp, 1000000000LL);
>  			*val = tmp;
>  			return ret;
> @@ -175,7 +176,7 @@ static int rescale_configure_channel(struct device *dev,
>  }
>  
>  static int rescale_current_sense_amplifier_props(struct device *dev,
> -						 struct rescale *rescale)
> +						 struct s32_fract *fract)
>  {
>  	u32 sense;
>  	u32 gain_mult = 1;
> @@ -199,22 +200,22 @@ static int rescale_current_sense_amplifier_props(struct device *dev,
>  	 * numerator/denominator from overflowing.
>  	 */
>  	factor = gcd(sense, 1000000);
> -	rescale->numerator = 1000000 / factor;
> -	rescale->denominator = sense / factor;
> +	fract->numerator = 1000000 / factor;
> +	fract->denominator = sense / factor;
>  
> -	factor = gcd(rescale->numerator, gain_mult);
> -	rescale->numerator /= factor;
> -	rescale->denominator *= gain_mult / factor;
> +	factor = gcd(fract->numerator, gain_mult);
> +	fract->numerator /= factor;
> +	fract->denominator *= gain_mult / factor;
>  
> -	factor = gcd(rescale->denominator, gain_div);
> -	rescale->numerator *= gain_div / factor;
> -	rescale->denominator /= factor;
> +	factor = gcd(fract->denominator, gain_div);
> +	fract->numerator *= gain_div / factor;
> +	fract->denominator /= factor;
>  
>  	return 0;
>  }
>  
>  static int rescale_current_sense_shunt_props(struct device *dev,
> -					     struct rescale *rescale)
> +					     struct s32_fract *fract)
>  {
>  	u32 shunt;
>  	u32 factor;
> @@ -228,35 +229,33 @@ static int rescale_current_sense_shunt_props(struct device *dev,
>  	}
>  
>  	factor = gcd(shunt, 1000000);
> -	rescale->numerator = 1000000 / factor;
> -	rescale->denominator = shunt / factor;
> +	fract->numerator = 1000000 / factor;
> +	fract->denominator = shunt / factor;
>  
>  	return 0;
>  }
>  
>  static int rescale_voltage_divider_props(struct device *dev,
> -					 struct rescale *rescale)
> +					 struct s32_fract *fract)
>  {
>  	int ret;
>  	u32 factor;
>  
> -	ret = device_property_read_u32(dev, "output-ohms",
> -				       &rescale->denominator);
> +	ret = device_property_read_u32(dev, "output-ohms", &fract->denominator);
>  	if (ret) {
>  		dev_err(dev, "failed to read output-ohms: %d\n", ret);
>  		return ret;
>  	}
>  
> -	ret = device_property_read_u32(dev, "full-ohms",
> -				       &rescale->numerator);
> +	ret = device_property_read_u32(dev, "full-ohms", &fract->numerator);
>  	if (ret) {
>  		dev_err(dev, "failed to read full-ohms: %d\n", ret);
>  		return ret;
>  	}
>  
> -	factor = gcd(rescale->numerator, rescale->denominator);
> -	rescale->numerator /= factor;
> -	rescale->denominator /= factor;
> +	factor = gcd(fract->numerator, fract->denominator);
> +	fract->numerator /= factor;
> +	fract->denominator /= factor;
>  
>  	return 0;
>  }
> @@ -299,6 +298,7 @@ static int rescale_probe(struct platform_device *pdev)
>  	struct iio_dev *indio_dev;
>  	struct iio_channel *source;
>  	struct rescale *rescale;
> +	struct s32_fract *fract;
>  	int sizeof_ext_info;
>  	int sizeof_priv;
>  	int i;
> @@ -322,24 +322,24 @@ static int rescale_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	rescale = iio_priv(indio_dev);
> -
> +	rescale->source = source;

There seems to be more reorganizing going on in here than is necessary
for the function of this patch. At very least, description should
call it out.  Why move setting source?

>  	rescale->cfg = of_device_get_match_data(dev);
> -	rescale->numerator = 1;
> -	rescale->denominator = 1;
>  
> -	ret = rescale->cfg->props(dev, rescale);
> +	fract = &rescale->fract;
> +	fract->numerator = 1;
> +	fract->denominator = 1;
> +
> +	ret = rescale->cfg->props(dev, fract);
>  	if (ret)
>  		return ret;
>  
> -	if (!rescale->numerator || !rescale->denominator) {
> +	if (!fract->numerator || !fract->denominator) {
>  		dev_err(dev, "invalid scaling factor.\n");
>  		return -EINVAL;
>  	}
>  
>  	platform_set_drvdata(pdev, indio_dev);
>  
> -	rescale->source = source;
> -
>  	indio_dev->name = dev_name(dev);
>  	indio_dev->info = &rescale_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;

