Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49FFA52729A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 17:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbiENP1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 11:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiENP1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 11:27:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C911012;
        Sat, 14 May 2022 08:27:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0ADAC60FB3;
        Sat, 14 May 2022 15:27:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B03C34116;
        Sat, 14 May 2022 15:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652542031;
        bh=n/uYS2og+nIqpY1BuF18pdnIzuHVyZ379mqFScc8ROE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NS1zbsuXNIaVh40QB7ufU68p6KW/wTh4AU04qV3RU8kHRNwrKkc9CaLj5sPkeI0rk
         NcQFkwcfEP6WaxSVIZ2RIHPWvRrbpa7mzHfB0JwXGQKeF76f65BJSoLQggomZaRPbL
         K29NtcynPkjpaPV2TdSddRkSctSsdIwUrSrmjbmsRXTE3RxIsl1SHggF91mAOYvIrX
         4smxbPi6xby+gYBPQ1r/AaY4UiENmkCpNbdFP+Y4X4M961mBhXWGD9E+B05ZZLazQQ
         44pJqRn6P6+xyKmhM2TONQWaJ33cuVPXU/U1RQtJdMSOtp5rz0O2WvhTjghE/ve0mc
         VK7KU2bRbLIOg==
Date:   Sat, 14 May 2022 16:35:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc:     lars@metafoo.de, mchehab+huawei@kernel.org, ardeleanalex@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mike.looijmans@topic.nl,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V2 2/6] iio: accel: bmi088: Make it possible to config
 scales
Message-ID: <20220514163546.59ac8512@jic23-huawei>
In-Reply-To: <20220510141753.3878390-3-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220510141753.3878390-1-Qing-wu.Li@leica-geosystems.com.cn>
        <20220510141753.3878390-3-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-pc-linux-gnu)
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

On Tue, 10 May 2022 14:17:49 +0000
LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn> wrote:

> The sensor can set the scales by writing the range register 0x41,
> The current driver has no interface to configure it.
> The commit adds the interface for config the scales.
> 
> Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
> Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Hi.

A few minor requested changes inline,

Thanks,

Jonathan

> ---
>  drivers/iio/accel/bmi088-accel-core.c | 32 ++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/bmi088-accel-core.c b/drivers/iio/accel/bmi088-accel-core.c
> index 9300313b63cb..8fee1d02e773 100644
> --- a/drivers/iio/accel/bmi088-accel-core.c
> +++ b/drivers/iio/accel/bmi088-accel-core.c
> @@ -237,6 +237,21 @@ static int bmi088_accel_set_sample_freq(struct bmi088_accel_data *data, int val)
>  				  BMI088_ACCEL_MODE_ODR_MASK, regval);
>  }
>  
> +static int bmi088_accel_set_scale(struct bmi088_accel_data *data, int val, int val2)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < 4; i++)
> +		if (val == data->chip_info->scale_table[i][0] &&
> +		    val2 == data->chip_info->scale_table[i][1])
> +			break;
> +
> +	if (i >= 4)
== 4

If it's > 4 something very odd happened :)

> +		return -EINVAL;
> +
> +	return regmap_write(data->regmap, BMI088_ACCEL_REG_ACC_RANGE, i);
> +}
> +
>  static int bmi088_accel_get_temp(struct bmi088_accel_data *data, int *val)
>  {
>  	int ret;
> @@ -368,7 +383,13 @@ static int bmi088_accel_read_avail(struct iio_dev *indio_dev,
>  			     const int **vals, int *type, int *length,
>  			     long mask)
>  {
> +	struct bmi088_accel_data *data = iio_priv(indio_dev);
>  	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		*vals = (const int *)data->chip_info->scale_table;
> +		*length = 8;
> +		*type = IIO_VAL_INT_PLUS_MICRO;
> +		return IIO_AVAIL_LIST;
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		*type = IIO_VAL_INT_PLUS_MICRO;
>  		*vals = bmi088_sample_freqs;
> @@ -388,6 +409,14 @@ static int bmi088_accel_write_raw(struct iio_dev *indio_dev,
>  	int ret;
>  
>  	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		ret = pm_runtime_resume_and_get(dev);
> +		if (ret)
> +			return ret;

Blank line here.  That separates a functional call and it's error handling from
what happens next and makes the code a tiny bit easier to read.

Also consistent with SAMP_FREQ block that follows.

> +		ret = bmi088_accel_set_scale(data, val, val2);
> +		pm_runtime_mark_last_busy(dev);
> +		pm_runtime_put_autosuspend(dev);
> +		return ret;
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		ret = pm_runtime_resume_and_get(dev);
>  		if (ret)
> @@ -409,7 +438,8 @@ static int bmi088_accel_write_raw(struct iio_dev *indio_dev,
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
>  	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) | \
>  				BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> -	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> +	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
> +				BIT(IIO_CHAN_INFO_SCALE), \
>  	.scan_index = AXIS_##_axis, \
>  }
>  

