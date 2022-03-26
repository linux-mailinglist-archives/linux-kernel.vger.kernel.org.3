Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6267D4E81CC
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 16:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbiCZPrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 11:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbiCZPrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 11:47:15 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BE6DEF2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 08:45:39 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id r11so7112713ila.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 08:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/AI6srTwL5Cc8UTXFlaDV8kEwi4+NdYHhCe+vJb0ym8=;
        b=f9Hvrxi4T6wHlX9wIe8AofFqx/aAZmZiAlnmqRzi4GfuENFsQIYYL+upfLXTTBfFWI
         xXm/kbJaSnqGzjA26f3SmhnbBKFDR1PJqbvJ82SX+Rhp6GCEru+deVlcoT3t1HBNWDPh
         gQPuMFGjyQ4aFhK6rfXOEaUDaSyYQwp4VIPAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/AI6srTwL5Cc8UTXFlaDV8kEwi4+NdYHhCe+vJb0ym8=;
        b=otAlOm7eQcCv5KkdZG9kgeJEHjCkJ9ysgwXSElmWlk4MVdIyddr8E3nQZUodGgRktf
         7xLFwrHySks9aMYWvrqmYxu/VRWwWLTZz2fKdtcfXtBJcdmAjq13F0LygtAqFblb9DnJ
         3lrlcw/LH7ZcTnw5d67DX/SdOwFZy23XogagRFaVIWRmg8SPvAWUXQCLKPgc1z/LF9Hm
         uvex32+e4n1ys2f9w4ngWp8NnBhMm9LZeqIOo4eQ2QXksuQlOUPOwd+m9/Nbn7LLF1n7
         cEnowGmib4LEmfjvZ+Ri0K0M+BhC88//cJSAjHNHVc8wGYckW3n0wIuyfgE53+Tt328z
         MeSA==
X-Gm-Message-State: AOAM530MA8uFTT7cPcJYtIDWRGBp1DsQJcH/7P7m9vtitXIFqtZwIPY4
        vnaMC/7+LwvQadWh56vlcoVyhAGK8UoDtsGt5zi6mHgvK68tDw==
X-Google-Smtp-Source: ABdhPJziYsztPyrx/p3/DHfv803VJ+ceWuch2mNwiAmCh/fucM2cFVJHu0F8xjeDLmdMdytMA/NOY2v4o4weynwQwd4=
X-Received: by 2002:a05:6e02:2162:b0:2c8:47b8:d3e1 with SMTP id
 s2-20020a056e02216200b002c847b8d3e1mr1894168ilv.59.1648309538534; Sat, 26 Mar
 2022 08:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220324222928.874522-1-swboyd@chromium.org>
In-Reply-To: <20220324222928.874522-1-swboyd@chromium.org>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Sat, 26 Mar 2022 08:45:27 -0700
Message-ID: <CAPUE2uv9wBz72+BPHNWd-P46pxh66GiMs7ChpRfH6wv63avmAg@mail.gmail.com>
Subject: Re: [PATCH v2] iio:proximity:sx9324: Fix hardware gain read/write
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 3:29 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> There are four possible gain values according to 'sx9324_gain_vals[]':
>
>         1, 2, 4, and 8
>
> The values are off by one when writing and reading the register. The
> bits should be set according to this equation:
>
>         ilog2(<gain>) + 1
>
> so that a gain of 8 is 0x3 in the register field and a gain of 4 is 0x2
> in the register field, etc. Note that a gain of 0 is reserved per the
> datasheet. The default gain (SX9324_REG_PROX_CTRL0_GAIN_1) is also
> wrong. It should be 0x1 << 3, i.e. 0x8, not 0x80 which is setting the
> reserved bit 7.
>
> Fix this all up to properly handle the hardware gain and return errors
> for invalid settings.
>
> Fixes: 4c18a890dff8 ("iio:proximity:sx9324: Add SX9324 support")
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>
> Changes from v1 (https://lore.kernel.org/r/)20220318204808.3404542-1-swboyd@chromium.org:
>  * Reject invalid settings
>  * Fix default value
>  * More commit text details
>
>  drivers/iio/proximity/sx9324.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
> index 0d9bbbb50cb4..6e90917e3e36 100644
> --- a/drivers/iio/proximity/sx9324.c
> +++ b/drivers/iio/proximity/sx9324.c
> @@ -76,7 +76,10 @@
>
>  #define SX9324_REG_PROX_CTRL0          0x30
>  #define SX9324_REG_PROX_CTRL0_GAIN_MASK        GENMASK(5, 3)
> -#define SX9324_REG_PROX_CTRL0_GAIN_1           0x80
> +#define SX9324_REG_PROX_CTRL0_GAIN_SHIFT       3
> +#define SX9324_REG_PROX_CTRL0_GAIN_RSVD                0x0
> +#define SX9324_REG_PROX_CTRL0_GAIN_1           0x1
> +#define SX9324_REG_PROX_CTRL0_GAIN_8           0x4
>  #define SX9324_REG_PROX_CTRL0_RAWFILT_MASK     GENMASK(2, 0)
>  #define SX9324_REG_PROX_CTRL0_RAWFILT_1P50     0x01
>  #define SX9324_REG_PROX_CTRL1          0x31
> @@ -379,7 +382,14 @@ static int sx9324_read_gain(struct sx_common_data *data,
>         if (ret)
>                 return ret;
>
> -       *val = 1 << FIELD_GET(SX9324_REG_PROX_CTRL0_GAIN_MASK, regval);
> +       regval = FIELD_GET(SX9324_REG_PROX_CTRL0_GAIN_MASK, regval);
> +       if (regval)
> +               regval--;
> +       else if (regval == SX9324_REG_PROX_CTRL0_GAIN_RSVD ||
> +                regval > SX9324_REG_PROX_CTRL0_GAIN_8)
> +               return -EINVAL;
> +
> +       *val = 1 << regval;
>
>         return IIO_VAL_INT;
>  }
> @@ -725,8 +735,12 @@ static int sx9324_write_gain(struct sx_common_data *data,
>         unsigned int gain, reg;
>         int ret;
>
> -       gain = ilog2(val);
>         reg = SX9324_REG_PROX_CTRL0 + chan->channel / 2;
> +
> +       gain = ilog2(val) + 1;
> +       if (val <= 0 || gain > SX9324_REG_PROX_CTRL0_GAIN_8)
> +               return -EINVAL;
> +
>         gain = FIELD_PREP(SX9324_REG_PROX_CTRL0_GAIN_MASK, gain);
>
>         mutex_lock(&data->mutex);
> @@ -784,9 +798,11 @@ static const struct sx_common_reg_default sx9324_default_regs[] = {
>         { SX9324_REG_AFE_CTRL8, SX9324_REG_AFE_CTRL8_RESFILTN_4KOHM },
>         { SX9324_REG_AFE_CTRL9, SX9324_REG_AFE_CTRL9_AGAIN_1 },
>
> -       { SX9324_REG_PROX_CTRL0, SX9324_REG_PROX_CTRL0_GAIN_1 |
> +       { SX9324_REG_PROX_CTRL0,
> +               SX9324_REG_PROX_CTRL0_GAIN_1 << SX9324_REG_PROX_CTRL0_GAIN_SHIFT |
>                 SX9324_REG_PROX_CTRL0_RAWFILT_1P50 },
> -       { SX9324_REG_PROX_CTRL1, SX9324_REG_PROX_CTRL0_GAIN_1 |
> +       { SX9324_REG_PROX_CTRL1,
> +               SX9324_REG_PROX_CTRL0_GAIN_1 << SX9324_REG_PROX_CTRL0_GAIN_SHIFT |
>                 SX9324_REG_PROX_CTRL0_RAWFILT_1P50 },
>         { SX9324_REG_PROX_CTRL2, SX9324_REG_PROX_CTRL2_AVGNEG_THRESH_16K },
>         { SX9324_REG_PROX_CTRL3, SX9324_REG_PROX_CTRL3_AVGDEB_2SAMPLES |
>
> base-commit: a8ee3b32f5da6c77a5ccc0e42c2250d61ba54fe0
> --
> https://chromeos.dev
>
