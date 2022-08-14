Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62805592370
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 18:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240758AbiHNQVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 12:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbiHNQVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 12:21:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41820BCAB;
        Sun, 14 Aug 2022 09:12:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD51660F4E;
        Sun, 14 Aug 2022 16:12:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD51C433C1;
        Sun, 14 Aug 2022 16:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660493524;
        bh=xTjMqD+IdoL1cpjFNN0IwBiI/zTHumM+62VySxWgwE8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D9BtwFwuLZCIOcFsE8XcTPKPF0bsxRj+Le2Fu6fpsqSkDz8bx6I3WMCGMvbRfOogn
         pxFW7N3WIW/mHJVetpltFKKCIPKg9jpXvRXQYK2aog8h0Rx3KNgxVEZAh8dO/H1L7j
         XR47qTGXluq4KaYUXoioa27EG+gTFTnrPi/SX3U6Hwo5LKFEOKF76kFeKXwZ8jpZc2
         Vi0UREx02oVqDhq7QPiOClxjSCmp61rQkiLHDBPo58rPptlZ/d8hLbyS/KRZxZq/0Z
         WMF6413ezVDjgMHxETzyuRCFUzMImqdpUSEmtA8cMGNX72PHeRxAh0UwriY9jRVeuC
         Sr4xX6trRFekg==
Date:   Sun, 14 Aug 2022 17:22:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, krisman@collabora.com,
        kernel@collabora.com, alvaro.soliverez@collabora.com
Subject: Re: [PATCH v2] iio: light: ltrf216a: Add raw attribute
Message-ID: <20220814172232.4caeaf1c@jic23-huawei>
In-Reply-To: <20220812100424.529425-1-shreeya.patel@collabora.com>
References: <20220812100424.529425-1-shreeya.patel@collabora.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Fri, 12 Aug 2022 15:34:24 +0530
Shreeya Patel <shreeya.patel@collabora.com> wrote:

> Add IIO_CHAN_INFO_RAW to the mask to be able to read raw values
> from the light sensor.
> 
> The userspace code for brightness control in steam deck uses the
> in_illuminance_input value through sysfs and multiplies it
> with a constant stored in BIOS at factory calibration time.
> 
> The downstream driver for LTRF216A that we have been using
> has incorrect formula for LUX calculation which we corrected
> in the upstreamed driver.
> 
> Now to be able to use the upstreamed driver, we need to add some
> magic in userspace so that the brightness control works like before
> even with the updated LUX formula.
> 
> Hence, we need the raw data to calculate a constant that can be
> added in userspace code.
> 
> Downstream driver LUX formula :-
> (greendata*8*LTRF216A_WIN_FAC) / (data->als_gain_fac*data->int_time_fac*10)
> 
> Upstreamed driver LUX formula :-
> (greendata*45*LTRF216A_WIN_FAC) / (data->als_gain_fac*data->int_time_fac)
> 
> greendata is the ALS_DATA which we would like to get through sysfs using
> the raw attribute.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>

Hi Shreeya.

Your description above makes me wonder though if we should support
this as an intensity channel as we did for many of the early Ambient light
sensors.  Not sure why it's called 'greendata' btw!
For those early tsl2583 IIRC and similar, we had two sensors with infrared vs
visible+infrared (which is basically what clear is here).
The readings given were of those two sensors then we did a bunch of maths
to convert those to LUX (in simplest drivers we simply subtracted
the infrared part from visible and applied a scale factor)

That lead to IIO_TYPE_BOTH though we later added IIO_TYPE_CLEAR which is
subtly different as that was for color sensors with RGB and clearish
filters.  The value you want here doesn't really correspond to any of
those modifiers

I guess that brings us back around to LIGHT(illuminance) + raw as you have it.
or adding a 'visible' modifier which is also rather ugly and hard
to define.

Let's leave this on list a while longer to see if others comment.
For now I'm inclined to just accept this as a dirty hack needed for this
corner case.

Jonathan

> ---
> 
> Changes in v2
>   - Add a better commit message explaining why we want this change.
>   - Call ltrf216a_set_power_state(data, false) before return.
> 
> 
>  drivers/iio/light/ltrf216a.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/iio/light/ltrf216a.c b/drivers/iio/light/ltrf216a.c
> index e6e24e70d2b9..4b8ef36b6912 100644
> --- a/drivers/iio/light/ltrf216a.c
> +++ b/drivers/iio/light/ltrf216a.c
> @@ -93,6 +93,7 @@ static const struct iio_chan_spec ltrf216a_channels[] = {
>  	{
>  		.type = IIO_LIGHT,
>  		.info_mask_separate =
> +			BIT(IIO_CHAN_INFO_RAW) |
>  			BIT(IIO_CHAN_INFO_PROCESSED) |
>  			BIT(IIO_CHAN_INFO_INT_TIME),
>  		.info_mask_separate_available =
> @@ -259,6 +260,18 @@ static int ltrf216a_read_raw(struct iio_dev *indio_dev,
>  	int ret;
>  
>  	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = ltrf216a_set_power_state(data, true);
> +		if (ret)
> +			return ret;
> +		mutex_lock(&data->lock);
> +		ret = ltrf216a_read_data(data, LTRF216A_ALS_DATA_0);
> +		mutex_unlock(&data->lock);
> +		ltrf216a_set_power_state(data, false);
> +		if (ret < 0)
> +			return ret;
> +		*val = ret;
> +		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_PROCESSED:
>  		mutex_lock(&data->lock);
>  		ret = ltrf216a_get_lux(data);

