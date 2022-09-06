Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21175AE539
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 12:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239265AbiIFKVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 06:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239221AbiIFKVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 06:21:07 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9B64F1AC;
        Tue,  6 Sep 2022 03:21:04 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id b2so7735935qkh.12;
        Tue, 06 Sep 2022 03:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=rxQ2ugWyumT9rsmXCf7YEzLdKjtuqwCbMN0w8MqUp1A=;
        b=hv329vjQyhsNQXiqc2aEo4va9FQJLcZFnb1ERuvyiJRX269VVST+mEHbusmHMB00AZ
         SQuafJKD0LGwoInHX0g27X4F4agqv98dCWqbEgNaUno7D6t64NDflI9VazE/CNpuykoY
         5N7UVawPefyG93cPlmssBHnKjcPeYrqTmuj8xoYVTFCtmk9g9gvNyXIY4+D2pYW9ebWW
         5nKvkT6F5dxWTSRcFQLiJ3C5VN3DnuwDUszV0M559AWTMoX8xrIt+GOgMxMBkXfBPctV
         3ncVunWNNvzbH4QtVJ6hgD4q2ZIcqEOtyWL9PVpdIJHtCr8BrEViZyWiAbGn7DNizCbp
         Vo+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=rxQ2ugWyumT9rsmXCf7YEzLdKjtuqwCbMN0w8MqUp1A=;
        b=XjjKkU3CAVWFHE9BDt9SLXNa1KQf3+oqC9za+JYOkXEK2R90cekA7JTrdPXGospwNU
         QyxyKgailsWvTnhJm6F4RN6QJaX+yUWj12+XAg/cLZ4kjDFv6SUwi21T6G1zxg1bWLKT
         tJB3hOtBkzREg42lFo3pxTeecFvLjfzce4eXCxMYByJB2tsCz7QL7IvIHSO6nVrC2AkZ
         OBcVLJdJaZWc+TaZi4FobBPGV2UVuE/Rm50MQl1dLT2qiekxmjyWcINmd+lZIuLm4JHm
         YMRriz35pkRBBp1FOXF1LtfGzl98bkLw2u5KAesiJisUWCACH6JCH0m72PwcFo1Ecapw
         i2/Q==
X-Gm-Message-State: ACgBeo2aB5G1Ubh0uj6xo9YL1QQWkO8beZgl74cRYiWW7OOmb6ne2vU9
        HkYR1gguqzDjsmzXmqdg4hocGQMqNvRmctWkCxM=
X-Google-Smtp-Source: AA6agR4aA8dWYa5cOU+wPfsXNK4vY1xGOrVyw78PoeFYgLguYdK7OyryeNBmvotbJ8wYIqJvx3ckw+HSpHkfJnFXjnY=
X-Received: by 2002:ae9:e311:0:b0:6ba:e711:fb27 with SMTP id
 v17-20020ae9e311000000b006bae711fb27mr35272596qkf.320.1662459663079; Tue, 06
 Sep 2022 03:21:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1662454215.git.cmo@melexis.com> <32c4b72624e4a3480b202f24f506ca91029e47f7.1662454215.git.cmo@melexis.com>
In-Reply-To: <32c4b72624e4a3480b202f24f506ca91029e47f7.1662454215.git.cmo@melexis.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 6 Sep 2022 13:20:27 +0300
Message-ID: <CAHp75VezNufWGW6sC+ALmX9H4yavWRCmpHuv9ZVoRycQxZ-uQg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] iio: temperature: mlx90632 Add runtime
 powermanagement modes
To:     Crt Mori <cmo@melexis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 6, 2022 at 12:04 PM <cmo@melexis.com> wrote:
>
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

Very good and documented code, thanks!
I believe you better to use DEFINE_.*_PM_OPS instead of legacy ones
(due to pm_ptr() usage).
Otherwise, with some nitpicks that wouldn't prevent a green light,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Crt Mori <cmo@melexis.com>
> ---
>  drivers/iio/temperature/mlx90632.c | 347 +++++++++++++++++++++++++----
>  1 file changed, 302 insertions(+), 45 deletions(-)
>
> diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
> index 549c0ab5c2be..e41a18edbc65 100644
> --- a/drivers/iio/temperature/mlx90632.c
> +++ b/drivers/iio/temperature/mlx90632.c
> @@ -6,11 +6,14 @@
>   *
>   * Driver for the Melexis MLX90632 I2C 16-bit IR thermopile sensor
>   */
> +#include <linux/bitfield.h>
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
> @@ -55,6 +58,12 @@
>  #define MLX90632_EE_Ha         0x2481 /* Ha customer calib value reg 16bit */
>  #define MLX90632_EE_Hb         0x2482 /* Hb customer calib value reg 16bit */
>
> +#define MLX90632_EE_MEDICAL_MEAS1      0x24E1 /* Medical measurement 1 16bit */
> +#define MLX90632_EE_MEDICAL_MEAS2      0x24E2 /* Medical measurement 2 16bit */
> +#define MLX90632_EE_EXTENDED_MEAS1     0x24F1 /* Extended measurement 1 16bit */
> +#define MLX90632_EE_EXTENDED_MEAS2     0x24F2 /* Extended measurement 2 16bit */
> +#define MLX90632_EE_EXTENDED_MEAS3     0x24F3 /* Extended measurement 3 16bit */
> +
>  /* Register addresses - volatile */
>  #define MLX90632_REG_I2C_ADDR  0x3000 /* Chip I2C address register */
>
> @@ -62,13 +71,16 @@
>  #define MLX90632_REG_CONTROL   0x3001 /* Control Register address */
>  #define   MLX90632_CFG_PWR_MASK                GENMASK(2, 1) /* PowerMode Mask */
>  #define   MLX90632_CFG_MTYP_MASK               GENMASK(8, 4) /* Meas select Mask */
> +#define   MLX90632_CFG_SOB_MASK BIT(11)
>
>  /* PowerModes statuses */
>  #define MLX90632_PWR_STATUS(ctrl_val) (ctrl_val << 1)
>  #define MLX90632_PWR_STATUS_HALT MLX90632_PWR_STATUS(0) /* hold */
> -#define MLX90632_PWR_STATUS_SLEEP_STEP MLX90632_PWR_STATUS(1) /* sleep step*/
> +#define MLX90632_PWR_STATUS_SLEEP_STEP MLX90632_PWR_STATUS(1) /* sleep step */
>  #define MLX90632_PWR_STATUS_STEP MLX90632_PWR_STATUS(2) /* step */
> -#define MLX90632_PWR_STATUS_CONTINUOUS MLX90632_PWR_STATUS(3) /* continuous*/
> +#define MLX90632_PWR_STATUS_CONTINUOUS MLX90632_PWR_STATUS(3) /* continuous */
> +
> +#define MLX90632_EE_RR GENMASK(10, 8) /* Only Refresh Rate bits */
>
>  /* Measurement types */
>  #define MLX90632_MTYP_MEDICAL 0
> @@ -116,8 +128,9 @@
>  #define MLX90632_REF_12        12LL /* ResCtrlRef value of Ch 1 or Ch 2 */
>  #define MLX90632_REF_3         12LL /* ResCtrlRef value of Channel 3 */
>  #define MLX90632_MAX_MEAS_NUM  31 /* Maximum measurements in list */
> -#define MLX90632_SLEEP_DELAY_MS 3000 /* Autosleep delay */
> +#define MLX90632_SLEEP_DELAY_MS 6000 /* Autosleep delay */
>  #define MLX90632_EXTENDED_LIMIT 27000 /* Extended mode raw value limit */
> +#define MLX90632_MEAS_MAX_TIME 2000 /* Max measurement time in ms for the lowest refresh rate */
>
>  /**
>   * struct mlx90632_data - private data for the MLX90632 device
> @@ -130,6 +143,9 @@
>   * @object_ambient_temperature: Ambient temperature at object (might differ of
>   *                              the ambient temperature of sensor.
>   * @regulator: Regulator of the device
> + * @powerstatus: Current POWER status of the device
> + * @interaction_ts: Timestamp of the last temperature read that is used
> + *                 for power management in jiffies
>   */
>  struct mlx90632_data {
>         struct i2c_client *client;
> @@ -139,6 +155,8 @@ struct mlx90632_data {
>         u8 mtyp;
>         u32 object_ambient_temperature;
>         struct regulator *regulator;
> +       int powerstatus;
> +       unsigned long interaction_ts;
>  };
>
>  static const struct regmap_range mlx90632_volatile_reg_range[] = {
> @@ -158,6 +176,8 @@ static const struct regmap_range mlx90632_read_reg_range[] = {
>         regmap_reg_range(MLX90632_EE_VERSION, MLX90632_EE_Ka),
>         regmap_reg_range(MLX90632_EE_CTRL, MLX90632_EE_I2C_ADDR),
>         regmap_reg_range(MLX90632_EE_Ha, MLX90632_EE_Hb),
> +       regmap_reg_range(MLX90632_EE_MEDICAL_MEAS1, MLX90632_EE_MEDICAL_MEAS2),
> +       regmap_reg_range(MLX90632_EE_EXTENDED_MEAS1, MLX90632_EE_EXTENDED_MEAS3),
>         regmap_reg_range(MLX90632_REG_I2C_ADDR, MLX90632_REG_CONTROL),
>         regmap_reg_range(MLX90632_REG_I2C_CMD, MLX90632_REG_I2C_CMD),
>         regmap_reg_range(MLX90632_REG_STATUS, MLX90632_REG_STATUS),
> @@ -198,16 +218,38 @@ static const struct regmap_config mlx90632_regmap = {
>
>  static s32 mlx90632_pwr_set_sleep_step(struct regmap *regmap)
>  {
> -       return regmap_update_bits(regmap, MLX90632_REG_CONTROL,
> -                                 MLX90632_CFG_PWR_MASK,
> -                                 MLX90632_PWR_STATUS_SLEEP_STEP);
> +       struct mlx90632_data *data =
> +               iio_priv(dev_get_drvdata(regmap_get_device(regmap)));
> +       s32 ret;
> +
> +       if (data->powerstatus == MLX90632_PWR_STATUS_SLEEP_STEP)
> +               return 0;
> +
> +       ret = regmap_write_bits(regmap, MLX90632_REG_CONTROL, MLX90632_CFG_PWR_MASK,
> +                               MLX90632_PWR_STATUS_SLEEP_STEP);
> +       if (ret < 0)
> +               return ret;
> +
> +       data->powerstatus = MLX90632_PWR_STATUS_SLEEP_STEP;
> +       return ret;
>  }
>
>  static s32 mlx90632_pwr_continuous(struct regmap *regmap)
>  {
> -       return regmap_update_bits(regmap, MLX90632_REG_CONTROL,
> -                                 MLX90632_CFG_PWR_MASK,
> -                                 MLX90632_PWR_STATUS_CONTINUOUS);
> +       struct mlx90632_data *data =
> +               iio_priv(dev_get_drvdata(regmap_get_device(regmap)));
> +       s32 ret;
> +
> +       if (data->powerstatus == MLX90632_PWR_STATUS_CONTINUOUS)
> +               return 0;
> +
> +       ret = regmap_write_bits(regmap, MLX90632_REG_CONTROL, MLX90632_CFG_PWR_MASK,
> +                               MLX90632_PWR_STATUS_CONTINUOUS);
> +       if (ret < 0)
> +               return ret;
> +
> +       data->powerstatus = MLX90632_PWR_STATUS_CONTINUOUS;
> +       return ret;
>  }
>
>  /**
> @@ -219,6 +261,63 @@ static void mlx90632_reset_delay(void)
>         usleep_range(150, 200);
>  }
>
> +static int mlx90632_get_measurement_time(struct regmap *regmap, u16 meas)
> +{
> +       unsigned int reg;
> +       int ret;
> +
> +       ret = regmap_read(regmap, meas, &reg);
> +       if (ret < 0)
> +               return ret;
> +
> +       return MLX90632_MEAS_MAX_TIME >> FIELD_GET(MLX90632_EE_RR, reg);
> +}
> +
> +static int mlx90632_calculate_dataset_ready_time(struct mlx90632_data *data)
> +{
> +       unsigned int refresh_time;
> +       int ret;
> +
> +       if (data->mtyp == MLX90632_MTYP_MEDICAL) {
> +               ret = mlx90632_get_measurement_time(data->regmap,
> +                                                   MLX90632_EE_MEDICAL_MEAS1);
> +               if (ret < 0)
> +                       return ret;
> +
> +               refresh_time = ret;
> +
> +               ret = mlx90632_get_measurement_time(data->regmap,
> +                                                   MLX90632_EE_MEDICAL_MEAS2);
> +               if (ret < 0)
> +                       return ret;
> +
> +               refresh_time += ret;
> +       } else {
> +               ret = mlx90632_get_measurement_time(data->regmap,
> +                                                   MLX90632_EE_EXTENDED_MEAS1);
> +               if (ret < 0)
> +                       return ret;
> +
> +               refresh_time = ret;
> +
> +               ret = mlx90632_get_measurement_time(data->regmap,
> +                                                   MLX90632_EE_EXTENDED_MEAS2);
> +               if (ret < 0)
> +                       return ret;
> +
> +               refresh_time += ret;
> +
> +               ret = mlx90632_get_measurement_time(data->regmap,
> +                                                   MLX90632_EE_EXTENDED_MEAS3);
> +               if (ret < 0)
> +                       return ret;
> +
> +               refresh_time += ret;
> +       }
> +
> +       return refresh_time;
> +}
> +
>  /**
>   * mlx90632_perform_measurement() - Trigger and retrieve current measurement cycle
>   * @data: pointer to mlx90632_data object containing regmap information
> @@ -249,26 +348,76 @@ static int mlx90632_perform_measurement(struct mlx90632_data *data)
>         return (reg_status & MLX90632_STAT_CYCLE_POS) >> 2;
>  }
>
> -static int mlx90632_set_meas_type(struct regmap *regmap, u8 type)
> +/**
> + * mlx90632_perform_measurement_burst() - Trigger and retrieve current measurement
> + * cycle in step sleep mode
> + * @data: pointer to mlx90632_data object containing regmap information
> + *
> + * Perform a measurement and return 2 as measurement cycle position reported
> + * by sensor. This is a blocking function for amount dependent on the sensor
> + * refresh rate.
> + */
> +static int mlx90632_perform_measurement_burst(struct mlx90632_data *data)
>  {
> +       unsigned int reg_status;
>         int ret;
>
> -       if ((type != MLX90632_MTYP_MEDICAL) && (type != MLX90632_MTYP_EXTENDED))
> -               return -EINVAL;
> +       ret = regmap_write_bits(data->regmap, MLX90632_REG_CONTROL,
> +                               MLX90632_CFG_SOB_MASK, MLX90632_CFG_SOB_MASK);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = mlx90632_calculate_dataset_ready_time(data);
> +       if (ret < 0)
> +               return ret;
> +
> +       msleep(ret); /* Wait minimum time for dataset to be ready */
> +
> +       ret = regmap_read_poll_timeout(data->regmap, MLX90632_REG_STATUS,
> +                                      reg_status,
> +                                      (reg_status & MLX90632_STAT_BUSY) == 0,
> +                                      10000, 100 * 10000);
> +       if (ret < 0) {
> +               dev_err(&data->client->dev, "data not ready");
> +               return -ETIMEDOUT;
> +       }
> +
> +       return 2;
> +}
> +
> +
> +static int mlx90632_set_meas_type(struct mlx90632_data *data, u8 type)
> +{
> +       int current_powerstatus;
> +       int ret;
> +
> +       if (data->mtyp == type)
> +               return 0;
>
> -       ret = regmap_write(regmap, MLX90632_REG_I2C_CMD, MLX90632_RESET_CMD);
> +       current_powerstatus = data->powerstatus;
> +       ret = mlx90632_pwr_continuous(data->regmap);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = regmap_write(data->regmap, MLX90632_REG_I2C_CMD, MLX90632_RESET_CMD);
>         if (ret < 0)
>                 return ret;
>
>         mlx90632_reset_delay();
>
> -       ret = regmap_write_bits(regmap, MLX90632_REG_CONTROL,
> +       ret = regmap_update_bits(data->regmap, MLX90632_REG_CONTROL,
>                                  (MLX90632_CFG_MTYP_MASK | MLX90632_CFG_PWR_MASK),
>                                  (MLX90632_MTYP_STATUS(type) | MLX90632_PWR_STATUS_HALT));
>         if (ret < 0)
>                 return ret;
>
> -       return mlx90632_pwr_continuous(regmap);
> +       data->mtyp = type;
> +       data->powerstatus = MLX90632_PWR_STATUS_HALT;
> +
> +       if (current_powerstatus == MLX90632_PWR_STATUS_SLEEP_STEP)
> +               return mlx90632_pwr_set_sleep_step(data->regmap);
> +
> +       return mlx90632_pwr_continuous(data->regmap);
>  }
>
>  static int mlx90632_channel_new_select(int perform_ret, uint8_t *channel_new,
> @@ -355,11 +504,30 @@ static int mlx90632_read_all_channel(struct mlx90632_data *data,
>         s32 ret, measurement;
>
>         mutex_lock(&data->lock);
> -       measurement = mlx90632_perform_measurement(data);
> -       if (measurement < 0) {
> -               ret = measurement;
> +       ret = mlx90632_set_meas_type(data, MLX90632_MTYP_MEDICAL);
> +       if (ret < 0)
> +               goto read_unlock;
> +
> +       switch (data->powerstatus) {
> +       case MLX90632_PWR_STATUS_CONTINUOUS:
> +               measurement = mlx90632_perform_measurement(data);
> +               if (measurement < 0) {
> +                       ret = measurement;
> +                       goto read_unlock;
> +               }
> +               break;
> +       case MLX90632_PWR_STATUS_SLEEP_STEP:
> +               measurement = mlx90632_perform_measurement_burst(data);
> +               if (measurement < 0) {
> +                       ret = measurement;
> +                       goto read_unlock;
> +               }
> +               break;
> +       default:
> +               ret = -ENOTSUPP;
>                 goto read_unlock;
>         }
> +
>         ret = mlx90632_read_ambient_raw(data->regmap, ambient_new_raw,
>                                         ambient_old_raw);
>         if (ret < 0)
> @@ -441,14 +609,20 @@ static int mlx90632_read_all_channel_extended(struct mlx90632_data *data, s16 *o
>         s32 ret, meas;
>
>         mutex_lock(&data->lock);
> -       ret = mlx90632_set_meas_type(data->regmap, MLX90632_MTYP_EXTENDED);
> +       ret = mlx90632_set_meas_type(data, MLX90632_MTYP_EXTENDED);
>         if (ret < 0)
>                 goto read_unlock;
>
> -       ret = read_poll_timeout(mlx90632_perform_measurement, meas, meas == 19,
> -                               50000, 800000, false, data);
> -       if (ret != 0)
> -               goto read_unlock;
> +       if (data->powerstatus == MLX90632_PWR_STATUS_CONTINUOUS) {
> +               ret = read_poll_timeout(mlx90632_perform_measurement, meas, meas == 19,
> +                                       50000, 800000, false, data);
> +               if (ret)
> +                       goto read_unlock;
> +       } else if (data->powerstatus == MLX90632_PWR_STATUS_SLEEP_STEP) {
> +               ret = mlx90632_perform_measurement_burst(data);
> +               if (ret < 0)
> +                       goto read_unlock;
> +       }
>
>         ret = mlx90632_read_object_raw_extended(data->regmap, object_new_raw);
>         if (ret < 0)
> @@ -457,8 +631,6 @@ static int mlx90632_read_all_channel_extended(struct mlx90632_data *data, s16 *o
>         ret = mlx90632_read_ambient_raw_extended(data->regmap, ambient_new_raw, ambient_old_raw);
>
>  read_unlock:
> -       (void) mlx90632_set_meas_type(data->regmap, MLX90632_MTYP_MEDICAL);
> -
>         mutex_unlock(&data->lock);
>         return ret;
>  }
> @@ -743,12 +915,47 @@ static int mlx90632_calc_ambient_dsp105(struct mlx90632_data *data, int *val)
>         return ret;
>  }
>
> +/**
> + * mlx90632_pm_interraction_wakeup() - Measure time between user interactions to change powermode
> + * @data: pointer to mlx90632_data object containing interaction_ts information
> + *
> + * Switch to continuous mode when interaction is faster than MLX90632_MEAS_MAX_TIME. Update the
> + * interaction_ts for each function call with the jiffies to enable measurement between function
> + * calls. Initial value of the interaction_ts needs to be set before this function call.
> + */
> +static int mlx90632_pm_interraction_wakeup(struct mlx90632_data *data)
> +{
> +       unsigned long now;
> +       int ret;
> +
> +       now = jiffies;
> +       if (time_in_range(now, data->interaction_ts,
> +                         data->interaction_ts +
> +                         msecs_to_jiffies(MLX90632_MEAS_MAX_TIME + 100))) {
> +               if (data->powerstatus == MLX90632_PWR_STATUS_SLEEP_STEP) {
> +                       ret = mlx90632_pwr_continuous(data->regmap);
> +                       if (ret < 0)
> +                               return ret;
> +               }
> +       }
> +
> +       data->interaction_ts = now;
> +
> +       return 0;
> +}
> +
>  static int mlx90632_read_raw(struct iio_dev *indio_dev,
>                              struct iio_chan_spec const *channel, int *val,
>                              int *val2, long mask)
>  {
>         struct mlx90632_data *data = iio_priv(indio_dev);
>         int ret;
> +       int cr;
> +
> +       pm_runtime_get_sync(&data->client->dev);
> +       ret = mlx90632_pm_interraction_wakeup(data);
> +       if (ret < 0)
> +               goto mlx90632_read_raw_pm;
>
>         switch (mask) {
>         case IIO_CHAN_INFO_PROCESSED:
> @@ -756,16 +963,22 @@ static int mlx90632_read_raw(struct iio_dev *indio_dev,
>                 case IIO_MOD_TEMP_AMBIENT:
>                         ret = mlx90632_calc_ambient_dsp105(data, val);
>                         if (ret < 0)
> -                               return ret;
> -                       return IIO_VAL_INT;
> +                               goto mlx90632_read_raw_pm;
> +
> +                       ret = IIO_VAL_INT;
> +                       break;
>                 case IIO_MOD_TEMP_OBJECT:
>                         ret = mlx90632_calc_object_dsp105(data, val);
>                         if (ret < 0)
> -                               return ret;
> -                       return IIO_VAL_INT;
> +                               goto mlx90632_read_raw_pm;
> +
> +                       ret = IIO_VAL_INT;
> +                       break;
>                 default:
> -                       return -EINVAL;
> +                       ret = -EINVAL;
> +                       break;
>                 }
> +               break;
>         case IIO_CHAN_INFO_CALIBEMISSIVITY:
>                 if (data->emissivity == 1000) {
>                         *val = 1;
> @@ -774,13 +987,21 @@ static int mlx90632_read_raw(struct iio_dev *indio_dev,
>                         *val = 0;
>                         *val2 = data->emissivity * 1000;
>                 }
> -               return IIO_VAL_INT_PLUS_MICRO;
> +               ret = IIO_VAL_INT_PLUS_MICRO;
> +               break;
>         case IIO_CHAN_INFO_CALIBAMBIENT:
>                 *val = data->object_ambient_temperature;
> -               return IIO_VAL_INT;
> +               ret = IIO_VAL_INT;
> +               break;
>         default:
> -               return -EINVAL;
> +               ret = -EINVAL;
> +               break;
>         }
> +
> +mlx90632_read_raw_pm:
> +       pm_runtime_mark_last_busy(&data->client->dev);
> +       pm_runtime_put_autosuspend(&data->client->dev);
> +       return ret;
>  }
>
>  static int mlx90632_write_raw(struct iio_dev *indio_dev,
> @@ -875,6 +1096,15 @@ static int mlx90632_enable_regulator(struct mlx90632_data *data)
>         return ret;
>  }
>
> +static void mlx90632_pm_disable(void *data)
> +{
> +       struct device *dev = data;
> +
> +       pm_runtime_get_sync(dev);
> +       pm_runtime_put_noidle(dev);
> +       pm_runtime_disable(dev);
> +}
> +
>  static int mlx90632_probe(struct i2c_client *client,
>                           const struct i2c_device_id *id)
>  {
> @@ -902,6 +1132,7 @@ static int mlx90632_probe(struct i2c_client *client,
>         mlx90632->client = client;
>         mlx90632->regmap = regmap;
>         mlx90632->mtyp = MLX90632_MTYP_MEDICAL;
> +       mlx90632->powerstatus = MLX90632_PWR_STATUS_HALT;
>
>         mutex_init(&mlx90632->lock);
>         indio_dev->name = id->name;
> @@ -961,16 +1192,25 @@ static int mlx90632_probe(struct i2c_client *client,
>
>         mlx90632->emissivity = 1000;
>         mlx90632->object_ambient_temperature = 25000; /* 25 degrees milliCelsius */
> +       mlx90632->interaction_ts = jiffies; /* Set initial value */
>
> -       pm_runtime_disable(&client->dev);
> +       pm_runtime_get_noresume(&client->dev);
>         ret = pm_runtime_set_active(&client->dev);
>         if (ret < 0) {
>                 mlx90632_sleep(mlx90632);
>                 return ret;
>         }
> +
>         pm_runtime_enable(&client->dev);
>         pm_runtime_set_autosuspend_delay(&client->dev, MLX90632_SLEEP_DELAY_MS);
>         pm_runtime_use_autosuspend(&client->dev);
> +       pm_runtime_put_autosuspend(&client->dev);
> +
> +       ret = devm_add_action_or_reset(&client->dev, mlx90632_pm_disable, &client->dev);
> +       if (ret) {
> +               mlx90632_sleep(mlx90632);
> +               return ret;
> +       }
>
>         return iio_device_register(indio_dev);
>  }
> @@ -1003,30 +1243,47 @@ static const struct of_device_id mlx90632_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, mlx90632_of_match);
>
> -static int __maybe_unused mlx90632_pm_suspend(struct device *dev)
> +static int mlx90632_pm_suspend(struct device *dev)
>  {
> -       struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> -       struct mlx90632_data *data = iio_priv(indio_dev);
> +       struct mlx90632_data *data = iio_priv(dev_get_drvdata(dev));
> +       int ret;
> +
> +       ret = mlx90632_pwr_set_sleep_step(data->regmap);
> +       if (ret < 0)
> +               return ret;
>
> -       return mlx90632_sleep(data);
> +       ret = regulator_disable(data->regulator);
> +       if (ret < 0)
> +               dev_err(regmap_get_device(data->regmap),
> +                       "Failed to disable power regulator: %d\n", ret);
> +
> +       return ret;
>  }
>
> -static int __maybe_unused mlx90632_pm_resume(struct device *dev)
> +static int mlx90632_pm_resume(struct device *dev)
>  {
> -       struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> -       struct mlx90632_data *data = iio_priv(indio_dev);
> +       struct mlx90632_data *data = iio_priv(dev_get_drvdata(dev));
>
> -       return mlx90632_wakeup(data);
> +       return mlx90632_enable_regulator(data);
>  }
>
> -static UNIVERSAL_DEV_PM_OPS(mlx90632_pm_ops, mlx90632_pm_suspend,
> -                           mlx90632_pm_resume, NULL);
> +static int mlx90632_pm_runtime_suspend(struct device *dev)
> +{
> +       struct mlx90632_data *data = iio_priv(dev_get_drvdata(dev));
> +
> +       return mlx90632_pwr_set_sleep_step(data->regmap);
> +}
> +
> +const struct dev_pm_ops mlx90632_pm_ops = {
> +       SYSTEM_SLEEP_PM_OPS(mlx90632_pm_suspend, mlx90632_pm_resume)
> +       RUNTIME_PM_OPS(mlx90632_pm_runtime_suspend, NULL, NULL)
> +};
>
>  static struct i2c_driver mlx90632_driver = {
>         .driver = {
>                 .name   = "mlx90632",
>                 .of_match_table = mlx90632_of_match,
> -               .pm     = &mlx90632_pm_ops,
> +               .pm     = pm_ptr(&mlx90632_pm_ops),
>         },
>         .probe = mlx90632_probe,
>         .remove = mlx90632_remove,
> --
> 2.34.1
>


-- 
With Best Regards,
Andy Shevchenko
