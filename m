Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2D35925B5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 19:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbiHNRCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 13:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241053AbiHNRCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 13:02:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B81A14096;
        Sun, 14 Aug 2022 10:01:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2490C60CF2;
        Sun, 14 Aug 2022 17:01:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD68C433D6;
        Sun, 14 Aug 2022 17:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660496503;
        bh=C+NBUIt/OAPZ5ok6KDEfnNIxE6j/hCtl+wI/5p8/VEQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CaIBR7n0o2HWHt1nvGMDVMISp52uros2CkV0utEBBDCCtSFEUS51UaxBQgqSX3yIW
         HVm5Um6vduPB3xRzdtFnFY4+QQE6Gl6UaJishPEYj0JmuEdosaZUWldiZEMtTXniQy
         sNtYKrbak2aDxp+g6gcl1uozBgennkKyCrz9Zt+qPoed7E8yKDeGYN1/X2ub9fI8hR
         dkMoG+C7q50ixHigMsmV0IpjVvj2uQaKsM5Ob9E35EUVI36J9Ce6itVxWFHoenEDrs
         iQDC9SFaU5vLbKM1HV5/eNKxfmxDNLK/rFWqDcLv6eCP8YphaS8SgFA7XulyPn/Hi5
         U0Yjho3XHxOkQ==
Date:   Sun, 14 Aug 2022 18:12:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     andy.shevchenko@gmail.com, hadess@hadess.net, hdegoede@redhat.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: accel: bma400: Add support for single and
 double tap events
Message-ID: <20220814181212.2171bd34@jic23-huawei>
In-Reply-To: <20220813071803.4692-3-jagathjog1996@gmail.com>
References: <20220813071803.4692-1-jagathjog1996@gmail.com>
        <20220813071803.4692-3-jagathjog1996@gmail.com>
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

On Sat, 13 Aug 2022 12:48:03 +0530
Jagath Jog J <jagathjog1996@gmail.com> wrote:

> Add support for single and double tap events based on the tap threshold
> value, minimum quiet time before and after the tap and minimum time
> between the taps in the double tap. The INT1 pin is used to interrupt
> and the event is pushed to userspace.
> 
> Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>

Hi Jagath,

As, for this series, the difficult bit from review point of view is the ABI
I've only taken a quick look at the implementation.  Basically looks fine to me,
but one trivial thing below (and that might just be me failing to read a diff)

...
>  		ret = bma400_steps_event_enable(data, state);
> @@ -1157,10 +1379,10 @@ static int bma400_read_event_value(struct iio_dev *indio_dev,
>  				   int *val, int *val2)
>  {
>  	struct bma400_data *data = iio_priv(indio_dev);
> -	int ret, reg;
> +	int ret, reg, reg_val, raw;
>  
> -	switch (chan->type) {
> -	case IIO_ACCEL:

We've lost the check on ACCEL I think.  Might be worth putting
it back as
	if (chan->type != ACCEL)
		return -EINVAL;

> +	switch (type) {
> +	case IIO_EV_TYPE_MAG:
>  		reg = get_gen_config_reg(dir);
>  		if (reg < 0)
>  			return -EINVAL;
> @@ -1196,6 +1418,39 @@ static int bma400_read_event_value(struct iio_dev *indio_dev,
>  		default:
>  			return -EINVAL;
>  		}
> +	case IIO_EV_TYPE_GESTURE:
> +		switch (info) {
> +		case IIO_EV_INFO_VALUE:
> +			ret = regmap_read(data->regmap, BMA400_TAP_CONFIG,
> +					  &reg_val);
> +			if (ret)
> +				return ret;
> +
> +			*val = FIELD_GET(BMA400_TAP_SEN_MSK, reg_val);
> +			return IIO_VAL_INT;
> +		case IIO_EV_INFO_RESET_TIMEOUT:
> +			ret = regmap_read(data->regmap, BMA400_TAP_CONFIG1,
> +					  &reg_val);
> +			if (ret)
> +				return ret;
> +
> +			raw = FIELD_GET(BMA400_TAP_QUIET_MSK, reg_val);
> +			*val = 0;
> +			*val2 = tap_timeout[raw];
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		case IIO_EV_INFO_TAP_2MIN_DELAY:
> +			ret = regmap_read(data->regmap, BMA400_TAP_CONFIG1,
> +					  &reg_val);
> +			if (ret)
> +				return ret;
> +
> +			raw = FIELD_GET(BMA400_TAP_QUIETDT_MSK, reg_val);
> +			*val = 0;
> +			*val2 = doubletap_2min_delay[raw];
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		default:
> +			return -EINVAL;
> +		}
>  	default:
>  		return -EINVAL;
>  	}

