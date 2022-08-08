Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6CF58C4D7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 10:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242179AbiHHITi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 04:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242158AbiHHITg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 04:19:36 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F30267F;
        Mon,  8 Aug 2022 01:19:35 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id z3so5967321qtv.5;
        Mon, 08 Aug 2022 01:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=mB/ZzfWdJoIS3oTr0PkJvIc6irfj78kiKiinUX1GRmM=;
        b=ios1kHcl8dRErlRe2EfnCBc0bozrsMZlWdvKY+wK+AL1TJ0v5YHcqlJymv0y5GqeB/
         7+yTCT1W1vmPF6JzxlCe/mHewuX8/oIX0jvK+ZewY4ZFZYo0pzJUFB6mX3y93ZRLFecM
         Hm698sopiCYGTl+cX6iVmHhS6julPRrUl4KIcb6HahZ95tRGuvTaoL4Z2SpIP3qV2Jse
         kgXSs/MHIqJujmDi/SuXDEiycFW/Gu/1rdpjNllB/9Wqt3oqGjHYTECFQs+6RToHCC1g
         +0H0Y02YpIsSRC4S1wfPae3dc+GaVh3cNr1wwVmmShmDqiSgPwiiyC6mKZ6fnSadjYaG
         2+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=mB/ZzfWdJoIS3oTr0PkJvIc6irfj78kiKiinUX1GRmM=;
        b=Dn0puFgs4NCR2kEE6X+uo1q7aEh/O/EhvThfloi1JpbdO3H0zthQ42ThA8XUhqW8Nk
         fcnt4G+p1EFtR9ivF0Y1jBRsqesQvJHAyHDTU3WQSe4wyFbfpCKfSwpBodVrmyuD4ecx
         JuPHkUbhEd8Kr0WIwXBlwEjJUsys0oS5u6MjnLDP5eYRlEDLjPFTRtkbf3KBPSRYrlF5
         aucVgI9il5BB3D3dtKGPvAynKyLGP/xK9K/H1HoHD9rMNngTcW75MUM2L//R3ly3ZRl+
         goQ13n3MQNd8mIHJbeEl98iaYZfraLc5uLlAN3wNuIZjGealXPvOwRxtwiBz/KQK15HZ
         XQaQ==
X-Gm-Message-State: ACgBeo2N/kEFPTtr188Nw6Ak2oNCESvHNOShQzyov69Sy1pE7YwS6gq1
        rZGD367g2XYHOXEm1mDQOB9V5zZ2bzVNGgzc0w5P18eEAuY=
X-Google-Smtp-Source: AA6agR6pV3o9RUqlDD5037CU9aWbXHKNWNLj4N74CWQhS0FKuLM8ercOS7AUuTqcnMB8BgiklPD95/PQgEw1dpddkN0=
X-Received: by 2002:ac8:5784:0:b0:31f:24e:93f5 with SMTP id
 v4-20020ac85784000000b0031f024e93f5mr15117163qta.429.1659946774176; Mon, 08
 Aug 2022 01:19:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1659872590.git.ang.iglesiasg@gmail.com> <602f032955b56eb367177d1de7536f18ad94bc87.1659872590.git.ang.iglesiasg@gmail.com>
In-Reply-To: <602f032955b56eb367177d1de7536f18ad94bc87.1659872590.git.ang.iglesiasg@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Aug 2022 10:18:57 +0200
Message-ID: <CAHp75VezCZFSzBfMw92uRpirU32Ac685v-P1=JakofrhNgoN=g@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] iio: pressure: bmp280: simplify driver
 initialization logic
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
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

On Sun, Aug 7, 2022 at 1:55 PM Angel Iglesias <ang.iglesiasg@gmail.com> wrote:
>
> Simplified common initialization logic of different sensor types
> unifying calibration and initial configuration recovery.
>
> Default config param values of each sensor type are stored inside
> chip_info structure and used to initialize sensor data struct instance.
>
> The helper functions for read each sensor type calibration are converted
> to a callback available on the chip_info struct.
>
> Revised BMP180 and BMP280 definitions and code functions to use GENMASK
> and FIELD_PREP/FIELD_GET utilities to homogenize structure with more
> recent drivers, in preparation for the patches adding support for the
> BMP380 sensors.

...

>         int ret;
>         unsigned int tmp;
>         __le16 l16;
>         __be16 b16;
>         struct device *dev = data->dev;
> +       struct bmp280_calib *calib = &data->calib.bmp280;

When you add longer lines, try to put them to be first.

>         __le16 t_buf[BMP280_COMP_TEMP_REG_COUNT / 2];
>         __le16 p_buf[BMP280_COMP_PRESS_REG_COUNT / 2];

...

>         int ret;
> -       u8 osrs = BMP280_OSRS_TEMP_X(data->oversampling_temp + 1) |
> -                 BMP280_OSRS_PRESS_X(data->oversampling_press + 1);
> +       u8 osrs = FIELD_PREP(BMP280_OSRS_TEMP_MASK, data->oversampling_temp + 1) |
> +                 FIELD_PREP(BMP280_OSRS_PRESS_MASK, data->oversampling_press + 1);

Ditto, move it to be before `int ret;` at the same time. Same for
other similar cases.

...

> +       /* apply initial values from chip info structure */

Make (one-line) comments consistent...

>         /* Bring up regulators */

...see the difference?

-- 
With Best Regards,
Andy Shevchenko
