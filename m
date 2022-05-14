Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90832527243
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 16:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbiENOxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 10:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233555AbiENOx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 10:53:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C142D26E1;
        Sat, 14 May 2022 07:53:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33E34B8075F;
        Sat, 14 May 2022 14:53:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94FF1C340EE;
        Sat, 14 May 2022 14:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652540004;
        bh=bpAnSgbKbpEuUOV+tfGFIueXUqhCgoUh4Jsix+lUMh8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BeSTDOZ4g7BCrmn7Ii4QuWE7xIvg0eXaIIvdYNl7fs+92AGyqoOkUpMABOWbwLyZT
         CnwJvpxY56r3KyzWmWm4gkfex5l4XmJVMkHnQPsR/mfHcIk1Ge2fN3t2eLcrY7zoIN
         bSv+72xFPPyV0PhawW5dE3Otxtb00eOe9Dnw+YxwI4xuLxXlMGOD6go+b5quHLCs8l
         kF81rjF2/QJ0OgEqBUFFoif2g229GXRLhaI3f8okfeZwYI5Y836sNwDe0ED5lMGTZf
         BvvGPiwjYjmExfLMW7Pcojk+c1fehU8mk4ZtM/t/4j8g/L4htg7aYcIPprUUGe/W+3
         fYNVzMgucUqjw==
Date:   Sat, 14 May 2022 16:02:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, joel@jms.id.au
Subject: Re: [PATCH] iio: pressure: dps310: Reset chip if MEAS_CFG is
 corrupt
Message-ID: <20220514160200.091d40ca@jic23-huawei>
In-Reply-To: <20220511192724.51845-1-eajames@linux.ibm.com>
References: <20220511192724.51845-1-eajames@linux.ibm.com>
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

On Wed, 11 May 2022 14:27:24 -0500
Eddie James <eajames@linux.ibm.com> wrote:

> Corruption of the MEAS_CFG register has been observed soon after
> system boot. In order to recover this scenario, check MEAS_CFG if
> measurement isn't ready, and if it's incorrect, reset the DPS310
> and write all the necessary registers.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
It's a large patch, so not an ideal 'fix' to backport, but
if we need to for platforms to work we should do so.

Hence, please add a Fixes tag (which I'm guessing will be the driver
being added in the first place).

Whilst tidying up might be nice, we shouldn't do refactoring that's not
strictly necessary in a fix patch.  Hence I'd prefer this as a two patch
series. Refactor with no functional changes, then the actual change.

A couple of minor queries inline,

Thanks,

Jonathan



> ---
>  drivers/iio/pressure/dps310.c | 280 +++++++++++++++++++++-------------
>  1 file changed, 173 insertions(+), 107 deletions(-)
> 
> diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
> index 36fb7ae0d0a9..39f84614f44e 100644
> --- a/drivers/iio/pressure/dps310.c
> +++ b/drivers/iio/pressure/dps310.c
> @@ -159,6 +159,106 @@ static int dps310_get_coefs(struct dps310_data *data)
>  	return 0;
>  }
>  
> +/*
> + * Some verions of chip will read temperatures in the ~60C range when
> + * its actually ~20C. This is the manufacturer recommended workaround
> + * to correct the issue. The registers used below are undocumented.
> + */
> +static int dps310_temp_workaround(struct dps310_data *data)
> +{
> +	int rc;
> +	int reg;
> +
> +	rc = regmap_read(data->regmap, 0x32, &reg);
> +	if (rc < 0)
> +		return rc;
> +
> +	/*
> +	 * If bit 1 is set then the device is okay, and the workaround does not
> +	 * need to be applied
> +	 */
> +	if (reg & BIT(1))
> +		return 0;
> +
> +	rc = regmap_write(data->regmap, 0x0e, 0xA5);
> +	if (rc < 0)
> +		return rc;
> +
> +	rc = regmap_write(data->regmap, 0x0f, 0x96);
> +	if (rc < 0)
> +		return rc;
> +
> +	rc = regmap_write(data->regmap, 0x62, 0x02);
> +	if (rc < 0)
> +		return rc;
> +
> +	rc = regmap_write(data->regmap, 0x0e, 0x00);
> +	if (rc < 0)
> +		return rc;
> +
> +	return regmap_write(data->regmap, 0x0f, 0x00);
> +}
> +
> +static int dps310_startup(struct dps310_data *data)
> +{
> +	int rc;
> +	int ready;
> +
> +	/*
> +	 * Set up pressure sensor in single sample, one measurement per second
> +	 * mode
> +	 */
> +	rc = regmap_write(data->regmap, DPS310_PRS_CFG, 0);
> +	if (rc < 0)
> +		return rc;
> +
> +	/*
> +	 * Set up external (MEMS) temperature sensor in single sample, one
> +	 * measurement per second mode
> +	 */
> +	rc = regmap_write(data->regmap, DPS310_TMP_CFG, DPS310_TMP_EXT);
> +	if (rc < 0)
> +		return rc;
> +
> +	/* Temp and pressure shifts are disabled when PRC <= 8 */
> +	rc = regmap_write_bits(data->regmap, DPS310_CFG_REG,
> +			       DPS310_PRS_SHIFT_EN | DPS310_TMP_SHIFT_EN, 0);
> +	if (rc < 0)
> +		return rc;
> +
> +	/* MEAS_CFG doesn't update correctly unless first written with 0 */
> +	rc = regmap_write_bits(data->regmap, DPS310_MEAS_CFG,
> +			       DPS310_MEAS_CTRL_BITS, 0);
> +	if (rc < 0)
> +		return rc;
> +
> +	/* Turn on temperature and pressure measurement in the background */
> +	rc = regmap_write_bits(data->regmap, DPS310_MEAS_CFG,
> +			       DPS310_MEAS_CTRL_BITS, DPS310_PRS_EN |
> +			       DPS310_TEMP_EN | DPS310_BACKGROUND);
> +	if (rc < 0)
> +		return rc;
> +
> +	/*
> +	 * Calibration coefficients required for reporting temperature.
> +	 * They are available 40ms after the device has started
> +	 */
> +	rc = regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG, ready,
> +				      ready & DPS310_COEF_RDY, 10000, 40000);
> +	if (rc < 0)
> +		return rc;
> +
> +	rc = dps310_get_coefs(data);
> +	if (rc < 0)
> +		return rc;
> +
> +	rc = dps310_temp_workaround(data);
> +	if (rc < 0)
> +		return rc;
> +
> +	return 0;
> +}
> +
>  static int dps310_get_pres_precision(struct dps310_data *data)
>  {
>  	int rc;
> @@ -297,6 +397,38 @@ static int dps310_get_temp_k(struct dps310_data *data)
>  	return scale_factors[ilog2(rc)];
>  }
>  
> +/* Called with lock held */
> +static int dps310_verify_meas_cfg(struct dps310_data *data, int ready_bit)

Hmm. I'm not immediately coming up with a better name, but it does
seem odd that a verify function would do a reset.

> +{
> +	int en = DPS310_PRS_EN | DPS310_TEMP_EN | DPS310_BACKGROUND;
> +	int meas_cfg;
> +	int rc = regmap_read(data->regmap, DPS310_MEAS_CFG, &meas_cfg);
> +
> +	if (rc < 0)
> +		return rc;
> +
> +	if (meas_cfg & ready_bit)
> +		return 0;
> +
> +	if ((meas_cfg & en) != en) {
> +		/* DPS310 register state corrupt, better start from scratch */
> +		rc = regmap_write(data->regmap, DPS310_RESET, DPS310_RESET_MAGIC);
> +		if (rc < 0)
> +			return rc;
> +
> +		/* Wait for device chip access: 2.5ms in specification */
> +		usleep_range(2500, 12000);
> +		rc = dps310_startup(data);
> +		if (rc)
> +			return rc;
> +
> +		dev_info(&data->client->dev,
> +			 "recovered from corrupted MEAS_CFG=%02x\n", meas_cfg);
> +	}
> +
> +	return 1;
> +}
> +
>  static int dps310_read_pres_raw(struct dps310_data *data)
>  {
>  	int rc;
> @@ -309,15 +441,25 @@ static int dps310_read_pres_raw(struct dps310_data *data)
>  	if (mutex_lock_interruptible(&data->lock))
>  		return -EINTR;
>  
> -	rate = dps310_get_pres_samp_freq(data);
> -	timeout = DPS310_POLL_TIMEOUT_US(rate);
> -
> -	/* Poll for sensor readiness; base the timeout upon the sample rate. */
> -	rc = regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG, ready,
> -				      ready & DPS310_PRS_RDY,
> -				      DPS310_POLL_SLEEP_US(timeout), timeout);
> -	if (rc)
> -		goto done;
> +	rc = dps310_verify_meas_cfg(data, DPS310_PRS_RDY);
> +	if (rc) {

So at this point we potentially reset. Is there a race condition against
the device register state corrupting again?  If so I guess we are relying
on the timeout and userspace trying again.  Maybe worth adding a comment
if that is the case.

> +		if (rc < 0)
> +			goto done;
> +
> +		rate = dps310_get_pres_samp_freq(data);
> +		timeout = DPS310_POLL_TIMEOUT_US(rate);
> +
> +		/*
> +		 * Poll for sensor readiness; base the timeout upon the sample
> +		 * rate.
> +		 */
> +		rc = regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG,
> +					      ready, ready & DPS310_PRS_RDY,
> +					      DPS310_POLL_SLEEP_US(timeout),
> +					      timeout);
> +		if (rc)
> +			goto done;
> +	}
>  
>  	rc = regmap_bulk_read(data->regmap, DPS310_PRS_BASE, val, sizeof(val));
>  	if (rc < 0)
> @@ -358,15 +500,25 @@ static int dps310_read_temp_raw(struct dps310_data *data)
>  	if (mutex_lock_interruptible(&data->lock))
>  		return -EINTR;
>  
> -	rate = dps310_get_temp_samp_freq(data);
> -	timeout = DPS310_POLL_TIMEOUT_US(rate);
> -
> -	/* Poll for sensor readiness; base the timeout upon the sample rate. */
> -	rc = regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG, ready,
> -				      ready & DPS310_TMP_RDY,
> -				      DPS310_POLL_SLEEP_US(timeout), timeout);
> -	if (rc < 0)
> -		goto done;
> +	rc = dps310_verify_meas_cfg(data, DPS310_TMP_RDY);
> +	if (rc) {
> +		if (rc < 0)
> +			goto done;
> +
> +		rate = dps310_get_temp_samp_freq(data);
> +		timeout = DPS310_POLL_TIMEOUT_US(rate);
> +
> +		/*
> +		 * Poll for sensor readiness; base the timeout upon the sample
> +		 * rate.
> +		 */
> +		rc = regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG,
> +					      ready, ready & DPS310_TMP_RDY,
> +					      DPS310_POLL_SLEEP_US(timeout),
> +					      timeout);
> +		if (rc < 0)
> +			goto done;
> +	}
>  
>  	rc = dps310_read_temp_ready(data);
>  
> @@ -677,52 +829,12 @@ static const struct iio_info dps310_info = {
>  	.write_raw = dps310_write_raw,
>  };
>  
> -/*
> - * Some verions of chip will read temperatures in the ~60C range when
> - * its actually ~20C. This is the manufacturer recommended workaround
> - * to correct the issue. The registers used below are undocumented.
> - */
> -static int dps310_temp_workaround(struct dps310_data *data)
> -{
> -	int rc;
> -	int reg;
> -
> -	rc = regmap_read(data->regmap, 0x32, &reg);
> -	if (rc < 0)
> -		return rc;
> -
> -	/*
> -	 * If bit 1 is set then the device is okay, and the workaround does not
> -	 * need to be applied
> -	 */
> -	if (reg & BIT(1))
> -		return 0;
> -
> -	rc = regmap_write(data->regmap, 0x0e, 0xA5);
> -	if (rc < 0)
> -		return rc;
> -
> -	rc = regmap_write(data->regmap, 0x0f, 0x96);
> -	if (rc < 0)
> -		return rc;
> -
> -	rc = regmap_write(data->regmap, 0x62, 0x02);
> -	if (rc < 0)
> -		return rc;
> -
> -	rc = regmap_write(data->regmap, 0x0e, 0x00);
> -	if (rc < 0)
> -		return rc;
> -
> -	return regmap_write(data->regmap, 0x0f, 0x00);
> -}
> -
>  static int dps310_probe(struct i2c_client *client,
>  			const struct i2c_device_id *id)
>  {
>  	struct dps310_data *data;
>  	struct iio_dev *iio;
> -	int rc, ready;
> +	int rc;
>  
>  	iio = devm_iio_device_alloc(&client->dev,  sizeof(*data));
>  	if (!iio)
> @@ -747,54 +859,8 @@ static int dps310_probe(struct i2c_client *client,
>  	if (rc)
>  		return rc;
>  
> -	/*
> -	 * Set up pressure sensor in single sample, one measurement per second
> -	 * mode
> -	 */
> -	rc = regmap_write(data->regmap, DPS310_PRS_CFG, 0);

Lack of error checking in original code is odd. Deliberate or not is the
question... (probably not deliberate as rc = is there).

> -
> -	/*
> -	 * Set up external (MEMS) temperature sensor in single sample, one
> -	 * measurement per second mode
> -	 */
> -	rc = regmap_write(data->regmap, DPS310_TMP_CFG, DPS310_TMP_EXT);
> -	if (rc < 0)
> -		return rc;
> -
> -	/* Temp and pressure shifts are disabled when PRC <= 8 */
> -	rc = regmap_write_bits(data->regmap, DPS310_CFG_REG,
> -			       DPS310_PRS_SHIFT_EN | DPS310_TMP_SHIFT_EN, 0);
> -	if (rc < 0)
> -		return rc;
> -
> -	/* MEAS_CFG doesn't update correctly unless first written with 0 */
> -	rc = regmap_write_bits(data->regmap, DPS310_MEAS_CFG,
> -			       DPS310_MEAS_CTRL_BITS, 0);
> -	if (rc < 0)
> -		return rc;
> -
> -	/* Turn on temperature and pressure measurement in the background */
> -	rc = regmap_write_bits(data->regmap, DPS310_MEAS_CFG,
> -			       DPS310_MEAS_CTRL_BITS, DPS310_PRS_EN |
> -			       DPS310_TEMP_EN | DPS310_BACKGROUND);
> -	if (rc < 0)
> -		return rc;
> -
> -	/*
> -	 * Calibration coefficients required for reporting temperature.
> -	 * They are available 40ms after the device has started
> -	 */
> -	rc = regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG, ready,
> -				      ready & DPS310_COEF_RDY, 10000, 40000);
> -	if (rc < 0)
> -		return rc;
> -
> -	rc = dps310_get_coefs(data);
> -	if (rc < 0)
> -		return rc;
> -
> -	rc = dps310_temp_workaround(data);
> -	if (rc < 0)
> +	rc = dps310_startup(data);
> +	if (rc)
>  		return rc;
>  
>  	rc = devm_iio_device_register(&client->dev, iio);

