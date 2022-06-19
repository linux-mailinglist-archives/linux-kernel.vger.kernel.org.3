Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2404550A3A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 13:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236488AbiFSLac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 07:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233282AbiFSLaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 07:30:30 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6837E6153;
        Sun, 19 Jun 2022 04:30:29 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id b8so11504044edj.11;
        Sun, 19 Jun 2022 04:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dii8VuYLfhheu24I0H2mSS/JbdyBYyJrhuHrjEWNep8=;
        b=H73WJ5wS/lcH7ESxBi9N6v0fuq/imzTT243AhNEWbotV+kDycqp4amFwqxVGWPgrEM
         mfVge7TEHyEOTmFtB26nQkyyGsBe3M2dST4La+SYhuIxfRopySqhZB8tLTQdh4fC0oQr
         ubNBezbWf3L581nUvkDuv/j8WdvmkmkDzW5bR7EaaaJWHA7hrgI/tcQT2hpZ2l1TOcv4
         Kala75ia0q4xpBopGv1xYG9EwogOpWgZIY/Cdt5KP5wpcTqypPiom/w5jkKcqT0LzIz9
         SXoHX7rI+eNCdbZVojAgnX4Aq8Ftoy4DG0X0NA8OaRvqDnEdoEVdkiSZF2AWY/ZqjTl/
         MMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dii8VuYLfhheu24I0H2mSS/JbdyBYyJrhuHrjEWNep8=;
        b=jdK01oSusDBJYu9b9a7zClMmgZSdm13/MicFwTOpxzW+K8rKeTL8GrrcyQQbdTMISi
         FuCMw7xZR+/DWdL4aO/8MOOgWXIB+c8W8XDzou/6tHysSjA02tPnP29cRHu/oUnPxL6g
         jgCnQxb22gDt4BZijziP/dDd4efRlM3a4Us7bv9BAQ3+DLhSI64wE1JSXx6tZpMCcQoE
         2qSPzrfCHrU2Zu11kyBMc1gpMQ+j76U3ey9iISLa6j1sQCH1luqsCAKLrIY2uQoWA8KC
         fC/Ma8V90Hg1dBD3gQ2UDimqa2sHxkHamxjnjC/9yUXNYu8N25xCCw3YBPsBWhu0anEt
         2jMg==
X-Gm-Message-State: AJIora9dhvpwGbGy+Vuax1xaxLH/DKvXC7lriXB94u/lcJEMyDVHUIBQ
        5Nlj3aGA6tDrMMDcnTlMff09IjuC/PigmDOTTvc=
X-Google-Smtp-Source: AGRyM1tmCPFLldxcHibE0j0SJ2ekIyeJvZqio2SLPBqgBP6Z9t1TIuL93zuILFdc1FEXNfnQrLKTO/klpl+Lyo7EkCo=
X-Received: by 2002:aa7:d29a:0:b0:435:705f:1319 with SMTP id
 w26-20020aa7d29a000000b00435705f1319mr7652411edq.54.1655638227941; Sun, 19
 Jun 2022 04:30:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220618214009.2178567-1-aidanmacdonald.0x0@gmail.com> <20220618214009.2178567-15-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220618214009.2178567-15-aidanmacdonald.0x0@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 19 Jun 2022 13:29:51 +0200
Message-ID: <CAHp75Veftw80qGh69CMDTCniwJwN_-_2k_7xBACdAPa8ZJ4MGg@mail.gmail.com>
Subject: Re: [PATCH v3 14/16] power: axp20x_battery: Add constant charge
 current table
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
> Add a table-based lookup method for constant charge current,
> which is necessary when the setting cannot be represented as
> a linear range.
>
> This also replaces the hard-coded 300 mA default ccc setting
> if the DT-specified value is unsupported; the minimum value
> for the device is now set exactly instead of relying on the
> value being rounded down to a supported value.

...

> +static int axp20x_get_constant_charge_current_sel(struct axp20x_batt_ps *axp_batt,
> +                                                 int charge_current)
> +{
> +       int i;
> +
> +       if (axp_batt->data->ccc_table) {
> +               for (i = AXP20X_CHRG_CTRL1_TGT_CURR; i >= 0; --i) {

i-- should give the same result.

> +                       if (axp_batt->data->ccc_table[i] <= charge_current)
> +                               return i;
> +               }
> +
> +               return -EINVAL;
> +       }

> +       i = (charge_current - axp_batt->data->ccc_offset) / axp_batt->data->ccc_scale;

> +

No need to have a blank line here.

> +       if (i > AXP20X_CHRG_CTRL1_TGT_CURR || i < 0)
> +               return -EINVAL;
> +
> +       return i;
> +}

-- 
With Best Regards,
Andy Shevchenko
