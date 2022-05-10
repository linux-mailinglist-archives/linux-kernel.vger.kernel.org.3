Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36744520D8F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 08:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236988AbiEJGJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 02:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236993AbiEJGJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 02:09:07 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE512A3769;
        Mon,  9 May 2022 23:05:11 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id c1-20020a17090a558100b001dca2694f23so1262012pji.3;
        Mon, 09 May 2022 23:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dCUvLZt4bW4Bwx47k7lt8egIN7aXjve5QVb8kto9Q5c=;
        b=qMwt8n8AMkpQzdatj6CPAFD88YO9ZdgrtcOQhIhxVWM/PkCmtBgC8aQ9e7/IJG3xO6
         PgKxHjKa+vPyoxeT6rJRU1eVtxTULaBsFufBr6d6Fz/RkY6xg53cz9LRLo2pCyBVGlwp
         8jKx/0J8KaASU5wWShn/yBqj/oKQNl7GJTY+sV0nI2251rhremIIRZ9Da0lppXvX1SqC
         HQL3dqKxwGQyuhW+FM5tC43c5ZIn25e/ievE8ZUNgryUHuWLx0UB8oXIO+clmqc4mdMy
         1F7sdUO28cPklXeSn2pXWvrOhelWDG1YtzLhsgB39qnHN+sUddt7ytqp3LBgVkWnUqJ9
         O6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dCUvLZt4bW4Bwx47k7lt8egIN7aXjve5QVb8kto9Q5c=;
        b=WpDeCvpuqPVlhDnkt2UaL/NOuzP97egm8sLS2RB14yVu7qnS9tOy1Rj9m/KxKbmQa8
         g0LzxvoRiQL8HJlwrDTX7a/51ELFA8HRWaLsZjb/yQhhheFYlKEm4CF2sKO/eIllhvvD
         lwdSdXqE44CUT7ttgl5LHw4zsZ16vU9eeXZIkHqUvOLotF+C5/4WZYUvdn/vs7VlqvDT
         FdrTaJWUqIyjBrfUXvJq/Z+x6akDrCZJ+luXaDK0H1elhky93U3FblOwAOBOKr3nCfKn
         65cRghB+Vlxsbm3OkmXlfrly4Gzum9wLL8fDsxw0t1n735fBA5Au0413x7rzS356gvDV
         BfwQ==
X-Gm-Message-State: AOAM530tgMs/H+2dQpF0NHoOz7+QZdr1YAYI7JxtZNy0x8pjOkth9BD7
        tn/bnfSpwDHtV3/ngj3UzUWyZIztPF7qfOSMJNXfxQav
X-Google-Smtp-Source: ABdhPJzAnMbNWoNEIgJFUaEv804fULylo089WZP4AMgo/qxTFvk6wup/QyXuxwCddXLySq20QcnBBV6h9+iE72TywwQ=
X-Received: by 2002:a17:90b:4f81:b0:1dc:681e:248 with SMTP id
 qe1-20020a17090b4f8100b001dc681e0248mr30228183pjb.98.1652162710460; Mon, 09
 May 2022 23:05:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220509134629.440965-1-Qing-wu.Li@leica-geosystems.com.cn> <20220509134629.440965-3-Qing-wu.Li@leica-geosystems.com.cn>
In-Reply-To: <20220509134629.440965-3-Qing-wu.Li@leica-geosystems.com.cn>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Tue, 10 May 2022 09:04:59 +0300
Message-ID: <CA+U=DsqAbUmSpGGc4=-QHhROh99ASKfGAcF7=EFfawLgKxkkFw@mail.gmail.com>
Subject: Re: [PATCH V1 2/5] iio: accel: bmi088: Add support for bmi085 accel.
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
> Add supports for BMI085, an Inertial Measurement Unit,
> with an accelerometer and gyroscope.
> The commit adds the accelerometer driver for the SPI interface.
> The gyroscope part is already supported by the BMG160 driver.
> Different from BMI088, the BMI085 accelerometer has the range of
> +/-2, 4, 6, and 8g.
>

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

> Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> ---
>  drivers/iio/accel/bmi088-accel-core.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/iio/accel/bmi088-accel-core.c b/drivers/iio/accel/bmi088-accel-core.c
> index 0c58ffdd00e3..ac8acf6e2ff0 100644
> --- a/drivers/iio/accel/bmi088-accel-core.c
> +++ b/drivers/iio/accel/bmi088-accel-core.c
> @@ -435,6 +435,13 @@ static const struct bmi088_accel_chip_info bmi088_accel_chip_info_tbl[] = {
>                 .num_channels = ARRAY_SIZE(bmi088_accel_channels),
>                 .scale_table = {{0, 897}, {0, 1795}, {0, 3590}, {0, 7179}},
>         },
> +       [1] = {
> +               .name = "bmi085-accel",
> +               .chip_id = 0x1F,
> +               .channels = bmi088_accel_channels,
> +               .num_channels = ARRAY_SIZE(bmi088_accel_channels),
> +               .scale_table = {{0, 598}, {0, 1196}, {0, 2393}, {0, 4785}},
> +       },
>  };
>
>  static const struct iio_info bmi088_accel_info = {
> --
> 2.25.1
>
