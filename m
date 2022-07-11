Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60EA65703D5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 15:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiGKNHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 09:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiGKNHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 09:07:21 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AFA2E6AB;
        Mon, 11 Jul 2022 06:07:20 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-31c89111f23so48489747b3.0;
        Mon, 11 Jul 2022 06:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BNM3kXV0AhjO7ZOLKGan+F0enyHnlLAuy8cjbGSut0s=;
        b=EDountau261E7xzsz1ChRdtIc71Impr3p7bkOtYbBZ6t0z1yRxs9dA2G+OCWDXn8CB
         gVX0Zpbba4P1uf0huN9Q/b4S/031ZmrxZxA6N4LSycaLuaUZ+T8j7qhx6d9WE6R8wRrb
         o5sH0zfAPkUzG366bx0hNOLaRa553G+b4s0pjc+q9ds5SkFiHefrJYDpbu2RDqx9fJgs
         tqHHupuVYZwzpU6D2ActxljwtHeFn7WkK97/6CwJepkrYhQ59HjYa/GNIMBc+FKkb5iS
         yf3DBg8CBnf3IuE2Oz7BFKC6p224HiJT7XHoI86ujQjnHmyFH2HJCWc4OCZ3XwpLXFav
         GOXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BNM3kXV0AhjO7ZOLKGan+F0enyHnlLAuy8cjbGSut0s=;
        b=VGtn+7wl6aEzjbW8vhMTbr2sQIYOjmKAnZwFEa3sTR5RsnanTgqPuDFx1NaKmt70IW
         SO7kFcJKLVrGuZxyoAjnK6VMBlEOrirjmzfT8SkQFc8zEKpzo8MPPHwzrQTRroE87kAd
         sTGRpM3P0PbDeT8dePvWSdpJthL8hfZXwqKG1apxuRcL95W5IHuhKNE5+EVwILyuUSfK
         K5TTlAqo42lzapHAaWF/uip3l43BPf/JBh8EO/aLm/BbJzw+fB2701YYc1nTBMAqsvAQ
         DaW1OamEa9AS/n/OEdQAhEd7SE11I4pa8f4VunI4jXZ2V6HCZLolosbm3KWXmpVN98D/
         7Onw==
X-Gm-Message-State: AJIora8QgG312j8GDpuRr2/AoxmnwBzGFGkZ29M4zh2PZBYilTYtod2b
        84c3mBcw/y275Ny/6icj+xVBewFOdNHXVQrOwxs=
X-Google-Smtp-Source: AGRyM1tQShar12PLw4rye1Bt58JXUEhApqx2qQjKZjoLh/LoBLWeLqS7wREroNbGzIyfz7ZQyE1A/Ybr1d7l4V+VBv0=
X-Received: by 2002:a81:4986:0:b0:31d:388b:d08d with SMTP id
 w128-20020a814986000000b0031d388bd08dmr14422466ywa.185.1657544839207; Mon, 11
 Jul 2022 06:07:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220711112900.61363-1-shreeya.patel@collabora.com> <20220711112900.61363-3-shreeya.patel@collabora.com>
In-Reply-To: <20220711112900.61363-3-shreeya.patel@collabora.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 11 Jul 2022 15:06:42 +0200
Message-ID: <CAHp75Vf3NDsep5_819=e8yrna_AGh5cew=fs+hHe1q8LCa-PyA@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] iio: light: Add support for ltrf216a sensor
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>, Zhigang.Shi@liteon.com,
        krisman@collabora.com, linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        alvaro.soliverez@collabora.com, dmitry.osipenko@collabora.com
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

On Mon, Jul 11, 2022 at 1:30 PM Shreeya Patel
<shreeya.patel@collabora.com> wrote:
>
> From: Zhigang Shi <Zhigang.Shi@liteon.com>
>
> Add initial support for ltrf216a ambient light sensor.
>
> Datasheet: https://gitlab.steamos.cloud/shreeya/iio/-/blob/main/LTRF216A.pdf
> Co-developed-by: Shreeya Patel <shreeya.patel@collabora.com>
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> Signed-off-by: Zhigang Shi <Zhigang.Shi@liteon.com>

Submitter's SoB always has to be last among SoBs in the proposed change.
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

...

> +static int ltrf216a_set_power_state(struct ltrf216a_data *data, bool on)
> +{
> +       struct device *dev = &data->client->dev;
> +       int ret;
> +
> +       if (on) {
> +               ret = pm_runtime_resume_and_get(dev);
> +               if (ret < 0) {
> +                       dev_err(dev, "Failed to resume runtime PM: %d\n", ret);
> +                       return ret;
> +               }

> +

Unneeded blank line.

> +       } else {
> +               pm_runtime_mark_last_busy(dev);
> +               ret = pm_runtime_put_autosuspend(dev);
> +       }
> +
> +       return ret;
> +}

...

> +       ret = regmap_read_poll_timeout(data->regmap, LTRF216A_MAIN_STATUS,
> +                                      val, val & LTRF216A_ALS_DATA_STATUS,
> +                                      LTRF216A_ALS_READ_DATA_DELAY_US,
> +                                      LTRF216A_ALS_READ_DATA_DELAY_US * 50);
> +       if (ret) {
> +               dev_err(dev, "Timed out waiting for valid data from LTRF216A_MAIN_STATUS reg: %d\n",
> +                       ret);

THe message is a bit misleading. The loop might be broken by the I/O error.

> +               return ret;
> +       }
> +
> +       ret = regmap_bulk_read(data->regmap, addr, buf, sizeof(buf));
> +       if (ret < 0) {
> +               dev_err(dev, "Error reading measurement data: %d\n", ret);
> +               return ret;
> +       }

...

> +static const struct regmap_config ltrf216a_regmap_config = {
> +       .name = LTRF216A_DRV_NAME,
> +       .reg_bits = 8,
> +       .val_bits = 8,
> +       .max_register = LTRF216A_MAX_REG,

Why do you use regmap locking? What for?

> +};

...

> +       data->regmap = devm_regmap_init_i2c(client, &ltrf216a_regmap_config);
> +       if (IS_ERR(data->regmap)) {
> +               dev_err(&client->dev, "Regmap initialization failed.\n");
> +               return PTR_ERR(data->regmap);

return dev_err_probe(...);

> +       }

...

> +       ret = devm_pm_runtime_enable(&client->dev);
> +       if (ret < 0) {
> +               dev_err_probe(&client->dev, ret, "Failed to enable runtime PM\n");
> +               return ret;

Ditto.

> +       }

...

> +               ret = ltrf216a_init(indio_dev);
> +               if (ret) {
> +                       dev_err_probe(&client->dev, ret, "Failed to enable the sensor\n");
> +                       return ret;

Ditto.

> +               }

...

> +       if (ret < 0)

For all these  ' < 0', please explain what positive return value means
there, if any, and why it's being ignored.

...

> +static const struct i2c_device_id ltrf216a_id[] = {
> +       { LTRF216A_DRV_NAME, 0 },

Please, use the string literal directly since it's kinda an ABI,
defining above for potential changes is not a good idea. Also you may
drop the ', 0' part.

> +       {}
> +};

...

> +static struct i2c_driver ltrf216a_driver = {
> +       .driver = {

> +               .name = LTRF216A_DRV_NAME,

Ditto.

> +               .pm = pm_ptr(&ltrf216a_pm_ops),
> +               .of_match_table = ltrf216a_of_match,
> +       },
> +       .probe_new      = ltrf216a_probe,
> +       .id_table       = ltrf216a_id,
> +};

-- 
With Best Regards,
Andy Shevchenko
