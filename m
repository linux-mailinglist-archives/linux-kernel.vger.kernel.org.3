Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFAA58C547
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 11:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242094AbiHHJJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 05:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241930AbiHHJJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 05:09:08 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6085813EA9;
        Mon,  8 Aug 2022 02:09:07 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id a4so1291397qto.10;
        Mon, 08 Aug 2022 02:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=nEEIrIvWN47IH3QMuqVPDH3enZPAu+YeFiqGwIC6KfU=;
        b=ZqBmh1pqiRw40lzEj4iSj/Ci1oosYin/mVEzAjbZrrV+YYPr2fIV43m8IQDNRc+hqq
         twq9usTmB6wdSdCTbhT6Gfu6jBQaRI5rU/KZt+lp643ZgyLns11mOI07HdeAa/F0TZcs
         6VfymG2z6KP4jq7M5cUtSOgykTE+tcScnJKTh0h866tyAqVuyUlPeWyQ25s4qB+50i4V
         cWi3/Fg1xjO/QIz77m2jpkVS19g2MfQG7xvrvdUmRk5vofSxnHoAKgS1STJEkOFy97Va
         m8NtvBypistw5Aw7fnQPudvxegpBjIKieAcZ2NhWUXDBkIFbkLHQmAijskf7iDk/ZI/6
         D0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=nEEIrIvWN47IH3QMuqVPDH3enZPAu+YeFiqGwIC6KfU=;
        b=38+Sh3hIFQCuHJTe0GFxMpfR8AJxOiNP/LdQ1kfTpGHvm86ZOEYVfIj2JhA15apy22
         4DGj0mV/xKa+33nFiH2Caq/gIzjCBMWmOany0YqUV32pK5w0rg4Fk74wb5rUi4RbQrQ+
         O+AYYc6ahlXW+mwoFrCcS0Or3C5kj2yrZqPpifNBGZfHTFw869pnl+2RDuOa0dUswATT
         dCGTCnLuOMvBgvZ3UZFhZ8ccFdiaVPVcd/qmhqLXlNP/4GBwB4y2ZTl01GQDo15JeweF
         OChFQTgq0G3skTSYpTUYqiTz+oHyXlKHtlMGsxzIhkwSSeruCUrJVvbXRFmeUHghcuei
         vUgA==
X-Gm-Message-State: ACgBeo1KvvOVZK7++dMsqZUKwciZDi/eb9PGbUQ2/Ptu6fPtkux+oCZJ
        qP/w8ADNKoxDDlCqln6gYQKKjzSioVa+sv0CB/c=
X-Google-Smtp-Source: AA6agR4+FhHoWal/6FmuHj45ZghWbxeowTRq+EbXS/r4OSsSBckNGqvl/0UiALFyA2OcaPBptHCSeoPVLg474wLFWJs=
X-Received: by 2002:ac8:7fd1:0:b0:31e:e9c0:c071 with SMTP id
 b17-20020ac87fd1000000b0031ee9c0c071mr15247089qtk.481.1659949746464; Mon, 08
 Aug 2022 02:09:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1659872590.git.ang.iglesiasg@gmail.com> <462251c4bca30b53f06307043ad52d859eb8d5c1.1659872590.git.ang.iglesiasg@gmail.com>
In-Reply-To: <462251c4bca30b53f06307043ad52d859eb8d5c1.1659872590.git.ang.iglesiasg@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Aug 2022 11:08:29 +0200
Message-ID: <CAHp75VexAQ5BQEyoAJq9r8uY1MussTy12bUyLd5z6GtJSbf0NQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] iio: pressure: bmp280: Add support for BMP380
 sensor family
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
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

On Sun, Aug 7, 2022 at 1:56 PM Angel Iglesias <ang.iglesiasg@gmail.com> wrote:
>
> Adds compatibility with the new generation of this sensor, the BMP380
>
> Includes basic sensor initialization to do pressure and temp
> measurements and allows tuning oversampling settings for each channel.
>
> The compensation algorithms are adapted from the device datasheet and
> the repository https://github.com/BoschSensortec/BMP3-Sensor-API

Missed period.

...

>   * https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BMP180-DS000-121.pdf
>   * https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BMP280-DS001-12.pdf
>   * https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BME280_DS001-11.pdf

Seems like the above links are unresponsive now? Perhaps you may fix
them as well in a separate patch?

> + * https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmp388-ds001.pdf

...

> +/* See datasheet Section 3.11.1. */

Again, a bit of consistency in (one-line) comments, please.

> +struct bmp380_calib {
> +       u16 T1;
> +       u16 T2;
> +       s8  T3;
> +       s16 P1;
> +       s16 P2;
> +       s8  P3;
> +       s8  P4;
> +       u16 P5;
> +       u16 P6;
> +       s8  P7;
> +       s8  P8;
> +       s16 P9;
> +       s8  P10;
> +       s8  P11;
> +};

__packed ?

...

> +/* Send a command to BMP3XX sensors */

> +       /* check if device is ready to process a command */
> +       /* send command to process */
> +       /* wait for 2ms for command to be processed */
> +       /* check for command processing error */

Consistency, please!

...

> +       dev_dbg(data->dev, "Command 0x%X processed successfully\n", cmd);

Useless.

...

> +/*
> + * Returns temperature in DegC, resolution is 0.01 DegC.  Output value of

DegC?! Perhaps "Celsius degrees"?

> + * "5123" equals 51.23 DegC.  t_fine carries fine temperature as global
> + * value.
> + *
> + * Taken from datasheet, Section Appendix 9, "Compensation formula" and repo
> + * https://github.com/BoschSensortec/BMP3-Sensor-API

Missed period.

> + */

...

> +       return (s32) comp_temp;

Do you need casting?

...

> +/*
> + * Returns pressure in Pa as unsigned 32 bit integer in fractional Pascal.

an unsigned
32-bit

> + * Output value of "9528709" represents 9528709/100 = 95287.09 Pa = 952.8709 hPa
> + *
> + * Taken from datasheet, Section 9.3. "Pressure compensation" and repository
> + * https://github.com/BoschSensortec/BMP3-Sensor-API

Missed period.

> + */

...

> +       var1 = ((s64)data->t_fine) * ((s64)data->t_fine);

Too many parentheses?

...

> +       /*
> +        * Dividing by 10 followed by multiplying by 10 to avoid
> +        * possible overflow caused by (uncomp_data->pressure * partial_data4)

Missed period.

> +        */

...

> +       return (u32)comp_press;

Do you need casting?

...

> +               /* reading was skipped */

The useless comment.

> +               dev_err(data->dev, "reading pressure skipped\n");

...

> +       /* Compensated pressure is in cPa (centipascals) */
> +       *val2 = 100000;

Anything to use from units.h?

...

> +       ret = regmap_write_bits(data->regmap, BMP380_REG_OSR,
> +                               BMP380_OSRS_TEMP_MASK | BMP380_OSRS_PRESS_MASK,
> +                               osrs);
> +       if (ret < 0) {

Do all these ' < 0' parts make any sense?

> +       }

...

> +       { .compatible = "bosch,bmp380", .data = (void *)BMP380_CHIP_ID },
>         { .compatible = "bosch,bme280", .data = (void *)BME280_CHIP_ID },
>         { .compatible = "bosch,bmp280", .data = (void *)BMP280_CHIP_ID },
>         { .compatible = "bosch,bmp180", .data = (void *)BMP180_CHIP_ID },

See below.

...

> +       {"bmp380", BMP380_CHIP_ID },
>         {"bmp280", BMP280_CHIP_ID },
>         {"bmp180", BMP180_CHIP_ID },
>         {"bmp085", BMP180_CHIP_ID },

Can we actually keep them forward-ordered? (Add 380 after 280 here and
in a separate patch sort the rest, or other way around, sort as a
prerequisite patch)

...

> +#define BMP380_MIN_TEMP                        -4000
> +#define BMP380_MAX_TEMP                        8500
> +#define BMP380_MIN_PRES                        3000000
> +#define BMP380_MAX_PRES                        12500000

Units?


--
With Best Regards,
Andy Shevchenko
