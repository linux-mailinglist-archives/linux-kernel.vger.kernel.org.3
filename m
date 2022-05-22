Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E125302B6
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 13:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245537AbiEVLnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 07:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236361AbiEVLnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 07:43:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5490252A1;
        Sun, 22 May 2022 04:43:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0E7EB80AFD;
        Sun, 22 May 2022 11:43:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A22C385AA;
        Sun, 22 May 2022 11:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653219817;
        bh=/LjKyFCVKnu8SbI3/hspGFymhV3tKLeWdAdgdzZr/V0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I8cG2+0puRdQ1SRZidbGWrY4KcIguBqPat+daeeXXZXmx42QNTr+TzxJ6Ksqvtqei
         YJ0Hf/I/Axup5VCd8viaD/RzHD/7wnlaSRtQjxJzuHXNB5Dpw4vzoFoHfPpF8jZv/t
         peauXIWmCb17S1pVkepfNsWyX+YrAKwXBHfe4JQ/XUEfHurJL3anuWiXnQS7XdFAgD
         cbaI4jcphl5wtTvceZtCLbfouUwN9CxZIUIiyJQJhcMu5q6vRiEDpB+vdMx6CPIf8D
         2JEVCuMgyhiMsJ5ko+5P38Pz7EL7ELg6dVnOJJyz2YT1cvLgmfRSAswFDK6dkFnhFI
         PM9IQrjgVvt7A==
Date:   Sun, 22 May 2022 12:52:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: Re: [PATCH] iio: accel: adxl367: do not update FIFO watermark on
 scan mode update
Message-ID: <20220522125223.1b310ede@jic23-huawei>
In-Reply-To: <20220514182010.152784-1-cosmin.tanislav@analog.com>
References: <20220514182010.152784-1-cosmin.tanislav@analog.com>
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

On Sat, 14 May 2022 21:20:10 +0300
Cosmin Tanislav <demonsingur@gmail.com> wrote:

> Currently, the driver updates the FIFO watermark inside both
> update_scan_mode() and hwfifo_set_watermark(). Inside the IIO core,
> hwfifo_set_watermark() is called immediately after update_scan_mode(),
> making the first call to set_fifo_samples() redundant.
> 
> Remove the first call to set_fifo_samples(), and merge the
> set_fifo_samples() function into the set_fifo_watermark()
> function. Also, since fifo_set_size is always set inside of
> update_scan_mode(), and it cannot be set to 0, remove the
> zero check from set_fifo_samples().
> 
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>

Applied to the togreg branch of iio.git and pushed out as testing
for 0-day to have it's fun

Thanks,

Jonathan

> ---
>  drivers/iio/accel/adxl367.c | 46 ++++++++-----------------------------
>  1 file changed, 9 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
> index 0289ed8cf2c6..72a8c3fb27b9 100644
> --- a/drivers/iio/accel/adxl367.c
> +++ b/drivers/iio/accel/adxl367.c
> @@ -447,21 +447,17 @@ static int adxl367_set_fifo_format(struct adxl367_state *st,
>  					     fifo_format));
>  }
>  
> -static int adxl367_set_fifo_samples(struct adxl367_state *st,
> -				    unsigned int fifo_watermark,
> -				    unsigned int fifo_set_size)
> +static int adxl367_set_fifo_watermark(struct adxl367_state *st,
> +				      unsigned int fifo_watermark)
>  {
> -	unsigned int fifo_samples = fifo_watermark * fifo_set_size;
> +	unsigned int fifo_samples = fifo_watermark * st->fifo_set_size;
>  	unsigned int fifo_samples_h, fifo_samples_l;
>  	int ret;
>  
>  	if (fifo_samples > ADXL367_FIFO_MAX_WATERMARK)
>  		fifo_samples = ADXL367_FIFO_MAX_WATERMARK;
>  
> -	if (fifo_set_size == 0)
> -		return 0;
> -
> -	fifo_samples /= fifo_set_size;
> +	fifo_samples /= st->fifo_set_size;
>  
>  	fifo_samples_h = FIELD_PREP(ADXL367_SAMPLES_H_MASK,
>  				    FIELD_GET(ADXL367_SAMPLES_VAL_H_MASK,
> @@ -475,30 +471,8 @@ static int adxl367_set_fifo_samples(struct adxl367_state *st,
>  	if (ret)
>  		return ret;
>  
> -	return regmap_update_bits(st->regmap, ADXL367_REG_FIFO_SAMPLES,
> -				  ADXL367_SAMPLES_L_MASK, fifo_samples_l);
> -}
> -
> -static int adxl367_set_fifo_set_size(struct adxl367_state *st,
> -				     unsigned int fifo_set_size)
> -{
> -	int ret;
> -
> -	ret = adxl367_set_fifo_samples(st, st->fifo_watermark, fifo_set_size);
> -	if (ret)
> -		return ret;
> -
> -	st->fifo_set_size = fifo_set_size;
> -
> -	return 0;
> -}
> -
> -static int adxl367_set_fifo_watermark(struct adxl367_state *st,
> -				      unsigned int fifo_watermark)
> -{
> -	int ret;
> -
> -	ret = adxl367_set_fifo_samples(st, fifo_watermark, st->fifo_set_size);
> +	ret = regmap_update_bits(st->regmap, ADXL367_REG_FIFO_SAMPLES,
> +				 ADXL367_SAMPLES_L_MASK, fifo_samples_l);
>  	if (ret)
>  		return ret;
>  
> @@ -1276,14 +1250,11 @@ static int adxl367_update_scan_mode(struct iio_dev *indio_dev,
>  {
>  	struct adxl367_state *st  = iio_priv(indio_dev);
>  	enum adxl367_fifo_format fifo_format;
> -	unsigned int fifo_set_size;
>  	int ret;
>  
>  	if (!adxl367_find_mask_fifo_format(active_scan_mask, &fifo_format))
>  		return -EINVAL;
>  
> -	fifo_set_size = bitmap_weight(active_scan_mask, indio_dev->masklength);
> -
>  	mutex_lock(&st->lock);
>  
>  	ret = adxl367_set_measure_en(st, false);
> @@ -1294,11 +1265,12 @@ static int adxl367_update_scan_mode(struct iio_dev *indio_dev,
>  	if (ret)
>  		goto out;
>  
> -	ret = adxl367_set_fifo_set_size(st, fifo_set_size);
> +	ret = adxl367_set_measure_en(st, true);
>  	if (ret)
>  		goto out;
>  
> -	ret = adxl367_set_measure_en(st, true);
> +	st->fifo_set_size = bitmap_weight(active_scan_mask,
> +					  indio_dev->masklength);
>  
>  out:
>  	mutex_unlock(&st->lock);

