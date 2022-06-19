Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFECC5509EC
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 12:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235591AbiFSK4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 06:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbiFSK4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 06:56:21 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527A69594;
        Sun, 19 Jun 2022 03:56:19 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id fd6so8724204edb.5;
        Sun, 19 Jun 2022 03:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m0ywi20rvMwf+A69ukm4ilfE8YyNyi5FpOBHrhUncaw=;
        b=GgDe22l8dWchMEZivxKCfNnrK3RMHQzpIOUH/cLZX99uGyOuj9FedzgCkDKtnzCAgL
         PPIpPLnjvAjJjF5tXNw70id9LeCLdDuJgovbQ9c8/FhEdFgda4ca+CjuqXFgaMlQLVEc
         t8zW3pdf8llLHbVepVISWOJrgYY8/LWQa69pyu3Z0ja78Khz7AtV4te8thHdld7xfa9U
         DOxG0WyksvGVrqDWi7LP55yTbAXi0oTEuc79yCfT9Nmnu2EZe3cdXMWN/DcbGplCWmWS
         LVpmYK6NJdiM27S23BwdzKpMrwNmgCBWSUaCxaOxFKwIJztxgw6kSBuyZCmHE3/C4JOu
         oaLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m0ywi20rvMwf+A69ukm4ilfE8YyNyi5FpOBHrhUncaw=;
        b=JcnavkxbAHHFac7EMECKvcDAWIwdL2ImbzlOQgpFanBezI7vMKaazhK3aEBNk5QllS
         vgebwnGFHkL/ErteJ8IwrZIYY3BCNxRb5bvc49v7JsiENIiIRNjk8sQPEhRwOjDa3qCP
         n4CkXCQLpBDXBq6zoa2wnW6PScZCUVPNlQ7In9q61Zy8FfS8xokoRknn0EZTYugdu0iw
         QwhAsH0jG/g+h5yoYV2b1+fTzpoohwy3LGfKl5HzkwI0sM5o0TdboD/bpcRB1hw0zy5I
         l1R1PullBafkBhQvrWcActxoy6KaImdb3//hgOieqx1i/NJ5gkBo4+IS2iFnQBa0broy
         /QWw==
X-Gm-Message-State: AJIora8IveTRoxvlAPgRznP52Y922Svzx+rvndMOXXRVpveYg+CHD1da
        RjQyMQkk250ZPr7boH4i8ATsln1Yrtt69hrDFRY=
X-Google-Smtp-Source: AGRyM1vCcmOfOZAgJE26JBD8dmE46Cj5ydNVR6OxyHO+aHgXjsRm1kFNmffTCwGvPKiUW6RcSC4gi6npztthWeg2oB8=
X-Received: by 2002:a05:6402:11d2:b0:42d:e68a:eae0 with SMTP id
 j18-20020a05640211d200b0042de68aeae0mr23095268edw.111.1655636177910; Sun, 19
 Jun 2022 03:56:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220618214009.2178567-1-aidanmacdonald.0x0@gmail.com> <20220618214009.2178567-12-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220618214009.2178567-12-aidanmacdonald.0x0@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 19 Jun 2022 12:55:41 +0200
Message-ID: <CAHp75VcMRAijXYGwVx8OPzMeafjT4Xa8rx_pRqRTs66Puw8qMA@mail.gmail.com>
Subject: Re: [PATCH v3 11/16] iio: adc: axp20x_adc: Add support for AXP192
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>, quic_gurus@quicinc.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Michael Walle <michael@walle.cc>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
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

On Sat, Jun 18, 2022 at 11:40 PM Aidan MacDonald
<aidanmacdonald.0x0@gmail.com> wrote:
>
> The AXP192 is identical to the AXP20x, except for the addition of
> two more GPIO ADC channels.

...

> +static int axp192_write_raw(struct iio_dev *indio_dev,
> +                           struct iio_chan_spec const *chan, int val, int val2,
> +                           long mask)
> +{
> +       struct axp20x_adc_iio *info = iio_priv(indio_dev);
> +       unsigned int regmask, regval;
> +
> +       /*
> +        * The AXP192 PMIC allows the user to choose between 0V and 0.7V offsets
> +        * for (independently) GPIO0-3 when in ADC mode.
> +        */
> +       if (mask != IIO_CHAN_INFO_OFFSET)
> +               return -EINVAL;
> +
> +       if (val != 0 && val != 700000)
> +               return -EINVAL;

> +       regval = val ? 1 : 0;
> +

As per comment against the previous patch use !!val directly?

> +       switch (chan->channel) {
> +       case AXP192_GPIO0_V:
> +               regmask = AXP192_GPIO30_IN_RANGE_GPIO0;
> +               regval = FIELD_PREP(AXP192_GPIO30_IN_RANGE_GPIO0, regval);
> +               break;
> +
> +       case AXP192_GPIO1_V:
> +               regmask = AXP192_GPIO30_IN_RANGE_GPIO1;
> +               regval = FIELD_PREP(AXP192_GPIO30_IN_RANGE_GPIO1, regval);
> +               break;
> +
> +       case AXP192_GPIO2_V:
> +               regmask = AXP192_GPIO30_IN_RANGE_GPIO2;
> +               regval = FIELD_PREP(AXP192_GPIO30_IN_RANGE_GPIO2, regval);
> +               break;
> +
> +       case AXP192_GPIO3_V:
> +               regmask = AXP192_GPIO30_IN_RANGE_GPIO3;
> +               regval = FIELD_PREP(AXP192_GPIO30_IN_RANGE_GPIO3, regval);
> +               break;
> +
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return regmap_update_bits(info->regmap, AXP192_GPIO30_IN_RANGE, regmask, regval);
> +}

-- 
With Best Regards,
Andy Shevchenko
