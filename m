Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFEF5AE548
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 12:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239425AbiIFKXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 06:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238931AbiIFKW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 06:22:57 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BA175384;
        Tue,  6 Sep 2022 03:22:13 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id g16so7738277qkl.11;
        Tue, 06 Sep 2022 03:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=R+EsRMwhAJL6reNgigEEkPZ+8PK8s8vUUJZ58y82zQ8=;
        b=j8FFOOeKXaqA3GQRW/kfYM1Z7pogywrJRdIgYY9J35Gd3wMfTdcNepLPoFJXv0T085
         jGiuSGUrBdyGwq7l+DO78MdQitkJlqJ7VKzliB9tPTSAwUoz4mhOK5mARlLAL03SVESU
         uksPjRDAUPeZFMC60ipnOuX40xvu62a00NkSB2bdNksJFkOv7zY+cdMlqIOJW5maxddz
         NqY9THB0BoJkjuQO8iprFXIOROfrUGku/ZE9ZtETd8StlnQJewBkTs82gtDAX+DdC9Md
         yHz2HaatnjOB6BhCSncx2ZCFIukbRowAwm3U4/dUgekfJnkzPNuaf+FXCQT4Nrm3+rZl
         n4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=R+EsRMwhAJL6reNgigEEkPZ+8PK8s8vUUJZ58y82zQ8=;
        b=zSH4ET1fZmiGwb18tPC3RlorZjcRV5DD6au6oM4HtDWkbqv36dTDM569ttooFJb+mi
         UxPWbnvzjiuM27dv6s2OT96gEGVtzdi5/vn9TPnETSkFKtOr7j2zXhyuIXMHEyV0tZzQ
         o4XhD9Z1RkWR4089pFYZcLmRcqBtHCvVPb5Sx7nG2XwjDnKlq/bLg/hdsBvn7Bf+/nNx
         +oN9WdambAiJm/3b1J+0SJMR0Ehg70Wl2gxKcwJ94I9tESgf2R/+nOqc6O8yScOnsKLU
         GJ69Bj9b8OkrEmNPo8BasTOblkzjDzgrGbIDrUsXpCGgE1LExkOcR2yVgjXdKl6reEH4
         e3Yw==
X-Gm-Message-State: ACgBeo1CPL1jHnbUMNjJ5wTzeuijWnT1I/AHnf9vFz0W2Z1g48gVIxx3
        QnXLFMnV5hRBsHAY8mlszm+WCL0vylQbwTmQcpc=
X-Google-Smtp-Source: AA6agR6k8vA1Xw5dLlWbt+wBtCugSLXUX1OT6OYXRD+dbce9Vu1/nEtLS3s71Pc9UBfDfkSM/1ovdBH4wmElS650MRk=
X-Received: by 2002:a05:620a:2987:b0:6ba:dc04:11ae with SMTP id
 r7-20020a05620a298700b006badc0411aemr35035703qkp.748.1662459731927; Tue, 06
 Sep 2022 03:22:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1662454215.git.cmo@melexis.com> <8d206235a7241fe764d9d51649061a4fd1b534d6.1662454215.git.cmo@melexis.com>
In-Reply-To: <8d206235a7241fe764d9d51649061a4fd1b534d6.1662454215.git.cmo@melexis.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 6 Sep 2022 13:21:36 +0300
Message-ID: <CAHp75VdF+Qe_QvKqchZPYM4E6oG0=kJcK-32H0hejyT8nJNhdw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] iio: temperature: mlx90632 Read sampling frequency
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
> Allow users to read sensor sampling frequency to better plan the
> application measurement requests.
>
> Signed-off-by: Crt Mori <cmo@melexis.com>
> ---
>  drivers/iio/temperature/mlx90632.c | 51 ++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>
> diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
> index e41a18edbc65..6b33284eb0b6 100644
> --- a/drivers/iio/temperature/mlx90632.c
> +++ b/drivers/iio/temperature/mlx90632.c
> @@ -81,6 +81,9 @@
>  #define MLX90632_PWR_STATUS_CONTINUOUS MLX90632_PWR_STATUS(3) /* continuous */
>
>  #define MLX90632_EE_RR GENMASK(10, 8) /* Only Refresh Rate bits */
> +#define MLX90632_REFRESH_RATE(ee_val) FIELD_GET(MLX90632_EE_RR, ee_val)
> +                                       /* Extract Refresh Rate from ee register */
> +#define MLX90632_REFRESH_RATE_STATUS(refresh_rate) (refresh_rate << 8)
>
>  /* Measurement types */
>  #define MLX90632_MTYP_MEDICAL 0
> @@ -915,6 +918,24 @@ static int mlx90632_calc_ambient_dsp105(struct mlx90632_data *data, int *val)
>         return ret;
>  }
>
> +static int mlx90632_get_refresh_rate(struct mlx90632_data *data,
> +                                    int *refresh_rate)
> +{
> +       unsigned int meas1;
> +       int ret;
> +
> +       ret = regmap_read(data->regmap, MLX90632_EE_MEDICAL_MEAS1, &meas1);
> +       if (ret < 0)
> +               return ret;
> +
> +       *refresh_rate = MLX90632_REFRESH_RATE(meas1);
> +
> +       return ret;
> +}
> +
> +static const int mlx90632_freqs[][2] = { {0, 500000}, {1, 0}, {2, 0}, {4, 0},
> +                                         {8, 0}, {16, 0}, {32, 0}, {64, 0} };

I would indent this as
_freqs ... = {
  ...pairs...
};

Either way,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> +
>  /**
>   * mlx90632_pm_interraction_wakeup() - Measure time between user interactions to change powermode
>   * @data: pointer to mlx90632_data object containing interaction_ts information
> @@ -993,6 +1014,15 @@ static int mlx90632_read_raw(struct iio_dev *indio_dev,
>                 *val = data->object_ambient_temperature;
>                 ret = IIO_VAL_INT;
>                 break;
> +       case IIO_CHAN_INFO_SAMP_FREQ:
> +               ret = mlx90632_get_refresh_rate(data, &cr);
> +               if (ret < 0)
> +                       goto mlx90632_read_raw_pm;
> +
> +               *val = mlx90632_freqs[cr][0];
> +               *val2 = mlx90632_freqs[cr][1];
> +               ret = IIO_VAL_INT_PLUS_MICRO;
> +               break;
>         default:
>                 ret = -EINVAL;
>                 break;
> @@ -1026,12 +1056,30 @@ static int mlx90632_write_raw(struct iio_dev *indio_dev,
>         }
>  }
>
> +static int mlx90632_read_avail(struct iio_dev *indio_dev,
> +                              struct iio_chan_spec const *chan,
> +                              const int **vals, int *type, int *length,
> +                              long mask)
> +{
> +       switch (mask) {
> +       case IIO_CHAN_INFO_SAMP_FREQ:
> +               *vals = (int *)mlx90632_freqs;
> +               *type = IIO_VAL_INT_PLUS_MICRO;
> +               *length = 2 * ARRAY_SIZE(mlx90632_freqs);
> +               return IIO_AVAIL_LIST;
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
>  static const struct iio_chan_spec mlx90632_channels[] = {
>         {
>                 .type = IIO_TEMP,
>                 .modified = 1,
>                 .channel2 = IIO_MOD_TEMP_AMBIENT,
>                 .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +               .info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +               .info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>         },
>         {
>                 .type = IIO_TEMP,
> @@ -1039,12 +1087,15 @@ static const struct iio_chan_spec mlx90632_channels[] = {
>                 .channel2 = IIO_MOD_TEMP_OBJECT,
>                 .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
>                         BIT(IIO_CHAN_INFO_CALIBEMISSIVITY) | BIT(IIO_CHAN_INFO_CALIBAMBIENT),
> +               .info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +               .info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>         },
>  };
>
>  static const struct iio_info mlx90632_info = {
>         .read_raw = mlx90632_read_raw,
>         .write_raw = mlx90632_write_raw,
> +       .read_avail = mlx90632_read_avail,
>  };
>
>  static int mlx90632_sleep(struct mlx90632_data *data)
> --
> 2.34.1
>


-- 
With Best Regards,
Andy Shevchenko
