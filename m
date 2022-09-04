Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8701F5AC4E2
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 17:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbiIDPOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 11:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiIDPN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 11:13:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC152B186;
        Sun,  4 Sep 2022 08:13:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5AEC60C01;
        Sun,  4 Sep 2022 15:13:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D180C433D6;
        Sun,  4 Sep 2022 15:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662304435;
        bh=dUPQky2AZP/daBJ+WCLfjU4Lh5mjjWRGW9AKzo0FMS8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rTkB2jGhbwukZ3RctEH34zq0KIcXPqsRhBxZmUK3p5fgEgtAkRv3w6O7KQ8umRVnz
         6n4n4EXoA6S18RfHLUyBt60BEvJyGO8rTHnosHcmeJMEyMfEylBVEKCz6QCFcVQ+QF
         EE+l9+/VA5rJm1CyxvB6q9Jb2lmZT1blUs6SvPgFxX1Qdj1bo+rkkfRjl1IfVOcEJt
         23XTi4/r5PCwDhXyRnhUTdP/T8BjOW/dsydeo4mG8xjp4KaUcU4ca15sTVHnFWps+n
         b/Bi7sm7SMj66Zjr/SCWfKHdHrKAaRzrstFparU1eJKPfBYAI7et7eQMcOWOaWTN24
         9cM78xD6/z+eg==
Date:   Sun, 4 Sep 2022 15:39:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     cmo@melexis.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 1/3] iio: temperature: mlx90632 Add runtime
 powermanagement modes
Message-ID: <20220904153947.2b61bbdf@jic23-huawei>
In-Reply-To: <20220903222336.3426005-1-cmo@melexis.com>
References: <20220903222336.3426005-1-cmo@melexis.com>
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

On Sun,  4 Sep 2022 00:23:36 +0200
cmo@melexis.com wrote:

> From: Crt Mori <cmo@melexis.com>
> 
> The sensor can operate in lower power modes and even make measurements when
> in those lower powered modes. The decision was taken that if measurement
> is not requested within 2 seconds the sensor will remain in SLEEP_STEP
> power mode, where measurements are triggered on request with setting the
> start of measurement bit (SOB). In this mode the measurements are taking
> a bit longer because we need to start it and complete it. Currently, in
> continuous mode we read ready data and this mode is activated if sensor
> measurement is requested within 2 seconds. The suspend timeout is
> increased to 6 seconds (instead of 3 before), because that enables more
> measurements in lower power mode (SLEEP_STEP), with the lowest refresh
> rate (2 seconds).
> 
> Signed-off-by: Crt Mori <cmo@melexis.com>

Hi Crt,

If you can fix the patch threading (patches should be replies to the cover letter)
that would be great.

The approach you've taken here looks good to me.  A few
comments inline on the implementation + requests for future possible
cleanup of the driver.

Thanks,

Jonathan
 
> ---
>  drivers/iio/temperature/mlx90632.c | 315 ++++++++++++++++++++++++-----
>  1 file changed, 269 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
> index 549c0ab5c2be..9acd819c76a6 100644
> --- a/drivers/iio/temperature/mlx90632.c
> +++ b/drivers/iio/temperature/mlx90632.c
> @@ -7,10 +7,12 @@
>   * Driver for the Melexis MLX90632 I2C 16-bit IR thermopile sensor
>   */
>  #include <linux/delay.h>
> +#include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/i2c.h>
>  #include <linux/iopoll.h>
> +#include <linux/jiffies.h>
>  #include <linux/kernel.h>
>  #include <linux/limits.h>
>  #include <linux/mod_devicetable.h>
> @@ -55,6 +57,12 @@
>  #define MLX90632_EE_Ha		0x2481 /* Ha customer calib value reg 16bit */
>  #define MLX90632_EE_Hb		0x2482 /* Hb customer calib value reg 16bit */
>  
> +#define MLX90632_EE_MEDICAL_MEAS1      0x24E1 /* Medical measurement 1 16bit */
> +#define MLX90632_EE_MEDICAL_MEAS2      0x24E2 /* Medical measurement 2 16bit */
> +#define MLX90632_EE_EXTENDED_MEAS1     0x24F1 /* Extended measurement 1 16bit */
> +#define MLX90632_EE_EXTENDED_MEAS2     0x24F2 /* Extended measurement 2 16bit */
> +#define MLX90632_EE_EXTENDED_MEAS3     0x24F3 /* Extended measurement 3 16bit */
> +
>  /* Register addresses - volatile */
>  #define MLX90632_REG_I2C_ADDR	0x3000 /* Chip I2C address register */
>  
> @@ -62,13 +70,16 @@
>  #define MLX90632_REG_CONTROL	0x3001 /* Control Register address */
>  #define   MLX90632_CFG_PWR_MASK		GENMASK(2, 1) /* PowerMode Mask */
>  #define   MLX90632_CFG_MTYP_MASK		GENMASK(8, 4) /* Meas select Mask */
> +#define   MLX90632_CFG_SOB_MASK BIT(11)
>  
>  /* PowerModes statuses */
>  #define MLX90632_PWR_STATUS(ctrl_val) (ctrl_val << 1)
As noted below. Using masks and FIELD_GET() / FIELD_PREP() will make the
driver a little bit easier to ready.  Not necessary to make that part of this
series though unless you want to.

>  #define MLX90632_PWR_STATUS_HALT MLX90632_PWR_STATUS(0) /* hold */
> -#define MLX90632_PWR_STATUS_SLEEP_STEP MLX90632_PWR_STATUS(1) /* sleep step*/
> +#define MLX90632_PWR_STATUS_SLEEP_STEP MLX90632_PWR_STATUS(1) /* sleep step */
>  #define MLX90632_PWR_STATUS_STEP MLX90632_PWR_STATUS(2) /* step */
> -#define MLX90632_PWR_STATUS_CONTINUOUS MLX90632_PWR_STATUS(3) /* continuous*/
> +#define MLX90632_PWR_STATUS_CONTINUOUS MLX90632_PWR_STATUS(3) /* continuous */
> +
> +#define MLX90632_EE_RR(ee_val) (ee_val & GENMASK(10, 8)) /* Only Refresh Rate bits */
>  
>  /* Measurement types */
>  #define MLX90632_MTYP_MEDICAL 0
> @@ -116,8 +127,9 @@
>  #define MLX90632_REF_12 	12LL /* ResCtrlRef value of Ch 1 or Ch 2 */
>  #define MLX90632_REF_3		12LL /* ResCtrlRef value of Channel 3 */
>  #define MLX90632_MAX_MEAS_NUM	31 /* Maximum measurements in list */
> -#define MLX90632_SLEEP_DELAY_MS 3000 /* Autosleep delay */
> +#define MLX90632_SLEEP_DELAY_MS 6000 /* Autosleep delay */
>  #define MLX90632_EXTENDED_LIMIT 27000 /* Extended mode raw value limit */
> +#define MLX90632_MEAS_MAX_TIME 2000 /* Max measurement time in ms for the lowest refresh rate */
>  
>  /**
>   * struct mlx90632_data - private data for the MLX90632 device
> @@ -130,6 +142,9 @@
>   * @object_ambient_temperature: Ambient temperature at object (might differ of
>   *                              the ambient temperature of sensor.
>   * @regulator: Regulator of the device
> + * @powerstatus: Current POWER status of the device
> + * @interraction_ts: Timestamp of the last temperature read that is used

interaction_ts (one r)

> + *		     for power management
>   */
>  struct mlx90632_data {
>  	struct i2c_client *client;
> @@ -139,6 +154,8 @@ struct mlx90632_data {
>  	u8 mtyp;
>  	u32 object_ambient_temperature;
>  	struct regulator *regulator;
> +	int powerstatus;
> +	unsigned long interraction_ts; /* in jiffies */

I'd just add the 'in jiffies' note to the kernel doc above.  Might well
get missed down here.

>  };
>  
>  static const struct regmap_range mlx90632_volatile_reg_range[] = {
> @@ -158,6 +175,8 @@ static const struct regmap_range mlx90632_read_reg_range[] = {
>  	regmap_reg_range(MLX90632_EE_VERSION, MLX90632_EE_Ka),
>  	regmap_reg_range(MLX90632_EE_CTRL, MLX90632_EE_I2C_ADDR),
>  	regmap_reg_range(MLX90632_EE_Ha, MLX90632_EE_Hb),
> +	regmap_reg_range(MLX90632_EE_MEDICAL_MEAS1, MLX90632_EE_MEDICAL_MEAS2),
> +	regmap_reg_range(MLX90632_EE_EXTENDED_MEAS1, MLX90632_EE_EXTENDED_MEAS3),
>  	regmap_reg_range(MLX90632_REG_I2C_ADDR, MLX90632_REG_CONTROL),
>  	regmap_reg_range(MLX90632_REG_I2C_CMD, MLX90632_REG_I2C_CMD),
>  	regmap_reg_range(MLX90632_REG_STATUS, MLX90632_REG_STATUS),
> @@ -198,16 +217,38 @@ static const struct regmap_config mlx90632_regmap = {
>  
>  static s32 mlx90632_pwr_set_sleep_step(struct regmap *regmap)
>  {
> -	return regmap_update_bits(regmap, MLX90632_REG_CONTROL,
> -				  MLX90632_CFG_PWR_MASK,
> -				  MLX90632_PWR_STATUS_SLEEP_STEP);
> +	struct mlx90632_data *data =
> +		iio_priv(dev_get_drvdata(regmap_get_device(regmap)));
> +	s32 ret;
> +
> +	if (data->powerstatus != MLX90632_PWR_STATUS_SLEEP_STEP) {

As below, flip the condition to help readability a little.

> +		ret = regmap_write_bits(regmap, MLX90632_REG_CONTROL,
> +					MLX90632_CFG_PWR_MASK,
> +					MLX90632_PWR_STATUS_SLEEP_STEP);
> +		if (ret < 0)
> +			return ret;
> +
> +		data->powerstatus = MLX90632_PWR_STATUS_SLEEP_STEP;
> +	}
> +	return 0;
>  }
>  
>  static s32 mlx90632_pwr_continuous(struct regmap *regmap)
>  {
> -	return regmap_update_bits(regmap, MLX90632_REG_CONTROL,
> -				  MLX90632_CFG_PWR_MASK,
> -				  MLX90632_PWR_STATUS_CONTINUOUS);
> +	struct mlx90632_data *data =
> +		iio_priv(dev_get_drvdata(regmap_get_device(regmap)));
> +	s32 ret;
> +
> +	if (data->powerstatus != MLX90632_PWR_STATUS_CONTINUOUS) {
I would prefer you flip this to reduce indent.

	if (data->powerstatus == MLX90632_PWR_STATUS_CONTINUOUS)
		return 0;

	ret = regmap....

a line more as you need to duplicate the return, but more readable code.

Same for other similar cases.

> +		ret = regmap_write_bits(regmap, MLX90632_REG_CONTROL,
> +					MLX90632_CFG_PWR_MASK,
> +					MLX90632_PWR_STATUS_CONTINUOUS);
> +		if (ret < 0)
> +			return ret;
> +
> +		data->powerstatus = MLX90632_PWR_STATUS_CONTINUOUS;
> +	}
> +	return 0;
>  }
>  
>  /**
> @@ -219,6 +260,63 @@ static void mlx90632_reset_delay(void)
>  	usleep_range(150, 200);
>  }
>  
> +static int mlx90632_get_measurement_time(struct regmap *regmap, u16 meas)
> +{
> +	unsigned int reg;
> +	int ret;
> +
> +	ret = regmap_read(regmap, meas, &reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	return MLX90632_MEAS_MAX_TIME >> (MLX90632_EE_RR(reg) >> 8);

Prefer FIELD_GET() and mask definition for extracting the field.
Obviously driver isn't doing that for any other fields though so I
guess that could be a nice cleanup follow up patch
(though only a couple of relevant places form a quick grep for >>)

> +}
> +


> +static int mlx90632_set_meas_type(struct mlx90632_data *data, u8 type)
> +{
> +	int current_powerstatus;
> +	int ret;
> +
> +	if (data->mtyp == type)
> +		return 0;
> +
> +	current_powerstatus = data->powerstatus;
> +	ret = mlx90632_pwr_continuous(data->regmap);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_write(data->regmap, MLX90632_REG_I2C_CMD, MLX90632_RESET_CMD);
>  	if (ret < 0)
>  		return ret;
>  
>  	mlx90632_reset_delay();
>  
> -	ret = regmap_write_bits(regmap, MLX90632_REG_CONTROL,
> +	ret = regmap_update_bits(data->regmap, MLX90632_REG_CONTROL,
>  				 (MLX90632_CFG_MTYP_MASK | MLX90632_CFG_PWR_MASK),
>  				 (MLX90632_MTYP_STATUS(type) | MLX90632_PWR_STATUS_HALT));
>  	if (ret < 0)
>  		return ret;
>  
> -	return mlx90632_pwr_continuous(regmap);
> +	data->mtyp = type;
> +	data->powerstatus = MLX90632_PWR_STATUS_HALT;
> +
> +	if (current_powerstatus == MLX90632_PWR_STATUS_SLEEP_STEP)
> +		return mlx90632_pwr_set_sleep_step(data->regmap);
I'd prefer this as a switch statement to make it clear there are only
two valid options and we want to match one of them.

Makes for a clearer relationship to the state machine you have
for this stuff.  At the cost of a few more lines of code.

At the moment you vary between explicitly checking each option and
only checking one of them.  If there are two options, a switch with
default error path makes that clear.
> +
> +	return mlx90632_pwr_continuous(data->regmap);
>  }
>  
>  static int mlx90632_channel_new_select(int perform_ret, uint8_t *channel_new,
> @@ -355,11 +503,24 @@ static int mlx90632_read_all_channel(struct mlx90632_data *data,
>  	s32 ret, measurement;
>  
>  	mutex_lock(&data->lock);
> -	measurement = mlx90632_perform_measurement(data);
> -	if (measurement < 0) {
> -		ret = measurement;
> +	ret = mlx90632_set_meas_type(data, MLX90632_MTYP_MEDICAL);
> +	if (ret < 0)
>  		goto read_unlock;
> +
> +	if (data->powerstatus == MLX90632_PWR_STATUS_CONTINUOUS) {
> +		measurement = mlx90632_perform_measurement(data);
> +		if (measurement < 0) {
> +			ret = measurement;
> +			goto read_unlock;
> +		}
> +	} else if (data->powerstatus == MLX90632_PWR_STATUS_SLEEP_STEP) {
Can power status be anything else?

Might be better to go with a switch statement so we have a default
that returns an error if nothing else is valid.  If there is another
option then at least a comment to say what it is would be useful.

> +		measurement = mlx90632_perform_measurement_burst(data);
> +		if (measurement < 0) {
> +			ret = measurement;
> +			goto read_unlock;
> +		}
>  	}
> +
>  	ret = mlx90632_read_ambient_raw(data->regmap, ambient_new_raw,
>  					ambient_old_raw);
>  	if (ret < 0)
> @@ -441,14 +602,20 @@ static int mlx90632_read_all_channel_extended(struct mlx90632_data *data, s16 *o
>  	s32 ret, meas;
>  
>  	mutex_lock(&data->lock);
> -	ret = mlx90632_set_meas_type(data->regmap, MLX90632_MTYP_EXTENDED);
> +	ret = mlx90632_set_meas_type(data, MLX90632_MTYP_EXTENDED);
>  	if (ret < 0)
>  		goto read_unlock;
>  
> -	ret = read_poll_timeout(mlx90632_perform_measurement, meas, meas == 19,
> -				50000, 800000, false, data);
> -	if (ret != 0)
> -		goto read_unlock;
> +	if (data->powerstatus == MLX90632_PWR_STATUS_CONTINUOUS) {
> +		ret = read_poll_timeout(mlx90632_perform_measurement, meas, meas == 19,
> +					50000, 800000, false, data);
> +		if (ret)
> +			goto read_unlock;
> +	} else if (data->powerstatus == MLX90632_PWR_STATUS_SLEEP_STEP) {
> +		ret = mlx90632_perform_measurement_burst(data);
> +		if (ret < 0)
> +			goto read_unlock;
> +	}
>  
>  	ret = mlx90632_read_object_raw_extended(data->regmap, object_new_raw);
>  	if (ret < 0)
> @@ -457,8 +624,6 @@ static int mlx90632_read_all_channel_extended(struct mlx90632_data *data, s16 *o
>  	ret = mlx90632_read_ambient_raw_extended(data->regmap, ambient_new_raw, ambient_old_raw);
>  
>  read_unlock:
> -	(void) mlx90632_set_meas_type(data->regmap, MLX90632_MTYP_MEDICAL);
> -
>  	mutex_unlock(&data->lock);
>  	return ret;
>  }
> @@ -743,12 +908,39 @@ static int mlx90632_calc_ambient_dsp105(struct mlx90632_data *data, int *val)
>  	return ret;
>  }
>  
> +static int mlx90632_pm_interraction_wakeup(struct mlx90632_data *data)

I'd suggest a comment for this function to briefly lay out the logic
under which it decides to switch the mode to continuous.

> +{
> +	unsigned long now;
> +	int ret;
> +
> +	now = jiffies;
> +	if (time_in_range(now, data->interraction_ts,
> +			  data->interraction_ts +
> +			  msecs_to_jiffies(MLX90632_MEAS_MAX_TIME + 100))) {
> +		if (data->powerstatus == MLX90632_PWR_STATUS_SLEEP_STEP) {
> +			ret = mlx90632_pwr_continuous(data->regmap);
> +			if (ret < 0)
> +				return ret;
> +		}
> +	}
> +
> +	data->interraction_ts = now;
> +
> +	return 0;
> +}
> +
>  static int mlx90632_read_raw(struct iio_dev *indio_dev,
>  			     struct iio_chan_spec const *channel, int *val,
>  			     int *val2, long mask)
>  {
>  	struct mlx90632_data *data = iio_priv(indio_dev);
>  	int ret;
> +	int cr;
> +
> +	pm_runtime_get_sync(&data->client->dev);
> +	ret = mlx90632_pm_interraction_wakeup(data);
> +	if (ret < 0)
> +		goto mlx90632_read_raw_pm;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_PROCESSED:
> @@ -756,16 +948,22 @@ static int mlx90632_read_raw(struct iio_dev *indio_dev,
>  		case IIO_MOD_TEMP_AMBIENT:
>  			ret = mlx90632_calc_ambient_dsp105(data, val);
>  			if (ret < 0)
> -				return ret;
> -			return IIO_VAL_INT;
> +				goto mlx90632_read_raw_pm;
> +
> +			ret = IIO_VAL_INT;
> +			break;
>  		case IIO_MOD_TEMP_OBJECT:
>  			ret = mlx90632_calc_object_dsp105(data, val);
>  			if (ret < 0)
> -				return ret;
> -			return IIO_VAL_INT;
> +				goto mlx90632_read_raw_pm;
> +
> +			ret = IIO_VAL_INT;
> +			break;
>  		default:
> -			return -EINVAL;
> +			ret = -EINVAL;
> +			break;
>  		}
> +		break;
>  	case IIO_CHAN_INFO_CALIBEMISSIVITY:
>  		if (data->emissivity == 1000) {
>  			*val = 1;
> @@ -774,13 +972,22 @@ static int mlx90632_read_raw(struct iio_dev *indio_dev,
>  			*val = 0;
>  			*val2 = data->emissivity * 1000;
>  		}
> -		return IIO_VAL_INT_PLUS_MICRO;
> +		ret = IIO_VAL_INT_PLUS_MICRO;
> +		break;
>  	case IIO_CHAN_INFO_CALIBAMBIENT:
>  		*val = data->object_ambient_temperature;
> -		return IIO_VAL_INT;
> +		ret = IIO_VAL_INT;
> +		break;
>  	default:
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		break;
>  	}
> +
> +mlx90632_read_raw_pm:
> +	mutex_unlock(&data->lock);

Where did the locking here come from?  I can't see why you'd
hold the lock at this point as we don't need it for the
runtime pm calls.

> +	pm_runtime_mark_last_busy(&data->client->dev);
> +	pm_runtime_put_autosuspend(&data->client->dev);
> +	return ret;
>  }
>  
>  static int mlx90632_write_raw(struct iio_dev *indio_dev,
> @@ -902,6 +1109,7 @@ static int mlx90632_probe(struct i2c_client *client,
>  	mlx90632->client = client;
>  	mlx90632->regmap = regmap;
>  	mlx90632->mtyp = MLX90632_MTYP_MEDICAL;
> +	mlx90632->powerstatus = MLX90632_PWR_STATUS_HALT;
>  
>  	mutex_init(&mlx90632->lock);
>  	indio_dev->name = id->name;
> @@ -961,16 +1169,18 @@ static int mlx90632_probe(struct i2c_client *client,
>  
>  	mlx90632->emissivity = 1000;
>  	mlx90632->object_ambient_temperature = 25000; /* 25 degrees milliCelsius */
> +	mlx90632->interraction_ts = jiffies; /* Set initial value */
>  
> -	pm_runtime_disable(&client->dev);
> +	pm_runtime_get_noresume(&client->dev);
>  	ret = pm_runtime_set_active(&client->dev);
>  	if (ret < 0) {
>  		mlx90632_sleep(mlx90632);
>  		return ret;
>  	}
> -	pm_runtime_enable(&client->dev);
> +	devm_pm_runtime_enable(&client->dev);

This automates disabling of runtime pm, but I'm not seeing changes to the remove()
function. Hence I think you are turning it off twice.

There is an ordering issue though in that if you remove the tear down in remove()
the sleep() call in there and the iio_device_unregister in there
will happen before runtime pm is disabled, thus leaving us with some potential
race conditions.  I would suggest registering a callback with
devm_add_action_or_reset() that puts the device to sleep (register that just
after wherever you turn it on).  Then the iio_device_register to the devm
form and drop the remove function entirely.  Ideally that conversion to devm
would be a separate patch, but it is a bit interwoven with this one so
I'm fine with you just calling it clearly in the patch description.

>  	pm_runtime_set_autosuspend_delay(&client->dev, MLX90632_SLEEP_DELAY_MS);
>  	pm_runtime_use_autosuspend(&client->dev);
> +	pm_runtime_put(&client->dev);
Hmm. I'd feel slightly happier if this were a pm_runtime_put_autosuspend() so
all paths use the same infrastructure.  Doubt it matters much though.

>  
>  	return iio_device_register(indio_dev);
>  }
> @@ -1003,30 +1213,43 @@ static const struct of_device_id mlx90632_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, mlx90632_of_match);
>  
> -static int __maybe_unused mlx90632_pm_suspend(struct device *dev)
> +static int mlx90632_pm_suspend(struct device *dev)
>  {
> -	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> -	struct mlx90632_data *data = iio_priv(indio_dev);
> +	struct mlx90632_data *data = iio_priv(dev_get_drvdata(dev));
> +	int ret;
> +
> +	ret = regulator_disable(data->regulator);

As the regulator may not be controllable, can we at least ensure we
do the same as in runtime suspend?  Obviously that will be irrelevant
if we do just turn the power off.  That would probably mean calling
pm_runtime_force_suspend()/resume() in these handlers.

> +	if (ret < 0)
> +		dev_err(regmap_get_device(data->regmap),
> +			"Failed to disable power regulator: %d\n", ret);
>  
> -	return mlx90632_sleep(data);
> +	return ret;
>  }
>  
> -static int __maybe_unused mlx90632_pm_resume(struct device *dev)
> +static int mlx90632_pm_resume(struct device *dev)
>  {
> -	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> -	struct mlx90632_data *data = iio_priv(indio_dev);
> +	struct mlx90632_data *data = iio_priv(dev_get_drvdata(dev));
> +
> +	return mlx90632_enable_regulator(data);
> +}
>  
> -	return mlx90632_wakeup(data);
> +static int mlx90632_pm_runtime_suspend(struct device *dev)
> +{
> +	struct mlx90632_data *data = iio_priv(dev_get_drvdata(dev));
> +
> +	return mlx90632_pwr_set_sleep_step(data->regmap);
>  }
>  

