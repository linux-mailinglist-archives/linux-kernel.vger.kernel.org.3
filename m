Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7D3565E3F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 22:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbiGDUI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 16:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiGDUI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 16:08:56 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63256391;
        Mon,  4 Jul 2022 13:08:55 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-317a66d62dfso90606167b3.7;
        Mon, 04 Jul 2022 13:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uDON4GKcFateM6U6tfidXipO/ui/nHlP7AqK1/YgWJU=;
        b=oW/O8G6n/F4h9yZYy7KdlikCtuHTQhZtcspHHz4iGaY55lNlv31kgg2WHK4QZ3CLy8
         CnTclKDfjPs/CeC682ZY3Y20vHLu6zjOPdTxqDl27zpqI1QehzI+kwGbqeOeb/vtyg/0
         BnokSerelqWkDhckGKX34VO8AGuxzicOAWmVk6dAsEeZaObGr1hmOBgMOpVsLfVzWy9L
         8NJeZzK/3NFgA+8FxJapi67nEGP+T6L+/R4PH84o8wG/7el3f5vuEXe+ZdWEdM2vZiGJ
         I5UTgNguRJPMEO8mND7eCKBh/PhM3qKSm84eZRwWFKD2c0hpaqaCF4ej5NJYf3uOAFA8
         uBrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uDON4GKcFateM6U6tfidXipO/ui/nHlP7AqK1/YgWJU=;
        b=DaPH2HzjnDGU8bqqmfpC6gibQZLDqWtHeqQ5Te4OijndnFZNXgxGUCe5TdvIA37yda
         +hqjdHFDeVncHkxVHMAA5hHojX3fSxXdMzGfUjYfvt0AydNSxDDf7wtvkpt7zUE5Ldbj
         thsgXlCSaP3WGfSi/PZPxzGsT0GsMUZYU893VHwvxIgr3FUgNimfzGD7u4ZMbkdp8O+q
         4NKmCsLv4GJ/HF4teh6g7NTdRKAAhjkTs4aia3Zb2v4ArzfBXI9Lx1VQIiHNfMCy3VlG
         J15tqQIv07xuUvP2KHAWunFv4H6F7Gx0UJITKyXeW+hlW362pnJ5Lr8p/Vtht2n+1WuS
         PlBg==
X-Gm-Message-State: AJIora9c2fIs5EvmE0TRJv0loCgTobK4kygELgeZWzNSnQvvTbVKt0wz
        nLPVH5LlO0Y83MyICZOkCtbwAiuSo7w7HRbhuHM=
X-Google-Smtp-Source: AGRyM1ugCdfzKBzzsCykcON/RBZqvjOvuKqV2FGWy3hz9r6za+WmM06hV29cWwmEvAbbnnyK9HS0lX+3j+xQfctRD3A=
X-Received: by 2002:a81:468b:0:b0:318:4cac:6576 with SMTP id
 t133-20020a81468b000000b003184cac6576mr33977015ywa.277.1656965335086; Mon, 04
 Jul 2022 13:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220704003337.208696-1-ang.iglesiasg@gmail.com>
In-Reply-To: <20220704003337.208696-1-ang.iglesiasg@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 4 Jul 2022 22:08:18 +0200
Message-ID: <CAHp75VdBv8BJVzBCMzWKpm0RrqX=K_QPQ4cgdshqXP3Uy+hVHQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] iio: pressure: bmp280: Adds more tunable config
 parameters for BMP380
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
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

On Mon, Jul 4, 2022 at 2:41 AM Angel Iglesias <ang.iglesiasg@gmail.com> wrote:
>
> Allows to configure the IIR filter coefficient and the sampling frequency
> The IIR filter coefficient is exposed using the sysfs attribute
> "filter_low_pass_3db_frequency"

In all your commit messages, please pay attention to English grammar.
Here you forgot all the periods.

...

> +       BMP380_ODR_0_0015HZ

Keep a comma here.

...

> +       /* BMP380 devices introduce sampling frequecy configuration. See

frequency.

> +        * datasheet sections 3.3.3. and 4.3.19.
> +        *
> +        * BMx280 devices allowed indirect configuration of sampling frequency
> +        * changing the t_standby duration between measurements. See datasheet
> +        * section 3.6.3
> +        */

/*
 * Multi-line comment style
 * example. Use it.
 */

...

> +               if (unlikely(!data->chip_info->sampling_freq_avail)) {

Why unlikely() ? How does this improve code generation / performance?

...

> +               if (unlikely(!data->chip_info->iir_filter_coeffs_avail)) {

Ditto.

...

> +                               /*
> +                                * Error applying new configuration. Might be
> +                                * an invalid configuration, will try to
> +                                * restore previous value just to be sure

Missed period. Please, check all your texts (commit messages,
comments, etc) for proper English grammar.

> +                                */

...

> +                               /*
> +                                * Error applying new configuration. Might be
> +                                * an invalid configuration, will try to
> +                                * restore previous value just to be sure

Ditto.

> +                                */

...

> +                               /*
> +                                * Error applying new configuration. Might be
> +                                * an invalid configuration, will try to
> +                                * restore previous value just to be sure

Ditto.

> +                                */

...

> +                               /*
> +                                * Error applying new configuration. Might be
> +                                * an invalid configuration, will try to
> +                                * restore previous value just to be sure

Ditto.

> +                                */

...

> +                               /*
> +                                * Error applying new configuration. Might be
> +                                * an invalid configuration, will try to
> +                                * restore previous value just to be sure

Ditto.

> +                                */

Why do you need to copy'n'paste dozens of the very same comment?
Wouldn't it be enough to explain it somewhere at the top of the file
or in the respective documentation (if it exists)?

...

>         u8 osrs;
>         unsigned int tmp;
>         int ret;
> +       bool change, aux;

Move them up, and probably use reversed xmas tree ordering ("longest
line first" rule).

Also should be
  bool change = false, aux;

...

> +       change = change || aux;

change ||= aux;

And in other cases.

...

> +               /* cycle sensor state machine to reset any measurement in progress
> +                * configuration errors are detected in a measurment cycle.

measurement

> +                * If the sampling frequency is too low, it is faster to reset
> +                * measurement cycle and restart measurements
> +                */

Completely wrong comment style. Be consistent and follow the common
standards in the Linux kernel.

...

> +               /* wait before checking the configuration error flag.
> +                * Worst case value for measure time indicated in the datashhet

datasheet

> +                * in section 3.9.1 is used.
> +                */

Ditto.

-- 
With Best Regards,
Andy Shevchenko
