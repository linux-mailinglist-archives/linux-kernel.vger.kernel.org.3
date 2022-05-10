Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCCC520D93
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 08:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237025AbiEJGJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 02:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237000AbiEJGJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 02:09:18 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9C02A3BCA;
        Mon,  9 May 2022 23:05:22 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id x52so14082967pfu.11;
        Mon, 09 May 2022 23:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TYoKj9SDisXrVyQgu04AJWDh/BOmuXH5bGQRnrO9Pis=;
        b=oQ/LZEgPh8pL3Yje1n48XirpOlJKdNHpFt623KQmdcuNvr4b+e/Uh6TOS3zOH3c7cv
         N6OoGy+XjY1RKdcxwxmOy6C4jzd1EplkjBuIk2mfY8N0aor+f+wULGjIfSdeqXItp8b+
         mAZrQb9k4aQFnhdDjsytrENDEBXlmsVY8ndB6UNAFO2lmrNDa5U7lMFVFMKcomG4Mo5O
         fxfkpbbxpotlML+SH8TGvEPkf0IBiCW720DQWcxJ9uC4Rz3ByYzdyawgxa7ujW8guBZ4
         DhtvOpvw2jGpQd32I4afEkoDja9YdsNHXmKpbKTzqihpUZpASaqvNczTtcNxrl8mpOe6
         j8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TYoKj9SDisXrVyQgu04AJWDh/BOmuXH5bGQRnrO9Pis=;
        b=bcwbIPLsyuDJ15zx/DfRLjwn1nppVCIDFQsqfqN+r5V0vX35kiuAi6lxwQt0ny7paj
         jc/SqpDX/WwkrwybBiSmGzUpcufGfd15YH7q9TKT0xVD6Wrp2t/vprYGMzAZQfx6ief3
         qkomFQNAaMrjjCrmKSomnAUPoU1/mZYs8BG3ueOE4/8TihscIgxCIY1EykJVib1EL71m
         ZDdWqA4JSBPnyW6HZabvKkKX5KejXu2aYf/675TId/aHmkdT3YTgbSj31UNaUn4C9s2d
         +iIloWo1w1vqpXYNcVJYqeZndQvHSPhjw6b7R+VS8/NvFk/lr3ltwt1mfHBHa4QcBqBv
         l24g==
X-Gm-Message-State: AOAM531AMA2G9ZG70B67KMDXVk3PETCalhv3NRJwE18lQIKpEMs5YWgi
        D+kf/emwSCyvCPNMrOpo/BQo+ygq7S5WZ+Ezn/g=
X-Google-Smtp-Source: ABdhPJxl63vrCxM265OPPN2Xh/ht3Cuahd9Pze0ZH3b+3PqglcSrmqe8alm8j7HXbuOXdaxvwDZSUda8R+JsSjw5RkQ=
X-Received: by 2002:a63:84c8:0:b0:3c6:4013:9e90 with SMTP id
 k191-20020a6384c8000000b003c640139e90mr15689360pgd.415.1652162722100; Mon, 09
 May 2022 23:05:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220509134629.440965-1-Qing-wu.Li@leica-geosystems.com.cn> <20220509134629.440965-4-Qing-wu.Li@leica-geosystems.com.cn>
In-Reply-To: <20220509134629.440965-4-Qing-wu.Li@leica-geosystems.com.cn>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Tue, 10 May 2022 09:05:10 +0300
Message-ID: <CA+U=DsoRpNZY08R8vZSF9Wq1MUCq=U7ohUE9YSXF2GZeGFr7Qg@mail.gmail.com>
Subject: Re: [PATCH V1 3/5] iio: accel: bmi088: Add support for bmi090l accel
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        mchehab+huawei@kernel.org, linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Mon, May 9, 2022 at 4:46 PM LI Qingwu
<Qing-wu.Li@leica-geosystems.com.cn> wrote:
>
> Add supports for BMI090L, it's a high-performance Inertial
> Measurement Unit, with an accelerometer and gyroscope.
> The commit adds the accelerometer driver for the SPI interface.
> The gyroscope part is already supported by the BMG160 driver.
> Same as BMI088, BMI090L have the range of +/-3, 6, 12, and 24g.
>

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

> Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> ---
>  drivers/iio/accel/bmi088-accel-core.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/iio/accel/bmi088-accel-core.c b/drivers/iio/accel/bmi088-accel-core.c
> index ac8acf6e2ff0..44cbe098c093 100644
> --- a/drivers/iio/accel/bmi088-accel-core.c
> +++ b/drivers/iio/accel/bmi088-accel-core.c
> @@ -442,6 +442,13 @@ static const struct bmi088_accel_chip_info bmi088_accel_chip_info_tbl[] = {
>                 .num_channels = ARRAY_SIZE(bmi088_accel_channels),
>                 .scale_table = {{0, 598}, {0, 1196}, {0, 2393}, {0, 4785}},
>         },
> +       [2] = {
> +               .name = "bmi090l-accel",
> +               .chip_id = 0x1A,
> +               .channels = bmi088_accel_channels,
> +               .num_channels = ARRAY_SIZE(bmi088_accel_channels),
> +               .scale_table = {{0, 897}, {0, 1795}, {0, 3590}, {0, 7179}},
> +       },
>  };
>
>  static const struct iio_info bmi088_accel_info = {
> --
> 2.25.1
>
