Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C375509C9
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 12:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbiFSKoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 06:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiFSKoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 06:44:54 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F112614;
        Sun, 19 Jun 2022 03:44:53 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id ej4so7505323edb.7;
        Sun, 19 Jun 2022 03:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yxOIwZjmxFnjMXJ6Xp1+MvDIzBj+ym+fo6gciVI2pfs=;
        b=erxRoeDeeSAHC7idu736MyEPQuGc5jmV4U1+5N3dAyB/Dl1ew9cIgM9IKFGMi/79J8
         zIdqn6oRCY0NvJH7Cm/T7TVHTiyZIeq6jMZ7HHmXrbiU/bD244DgcqOFQ7PdCsMcKcp9
         JrI6J6+jH2IiwMDWxNKTZGlWvdIvQOjWs1A7arLZYc66nwF093xRdkT9DuiOnnDqBvah
         +1hHLH6RSwEdUeOBI5i0cMSUnm5DpZyfcgsCoyAd5b68DY/tO7bIFLoD9n4FLY4Y6Yfv
         esN7+5TGs01Pcnc27tdEiE9xSxwTG4BIQy7hw2dKznlvL4r3NZ92yvJdyhKh4kaMdk+j
         8nQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yxOIwZjmxFnjMXJ6Xp1+MvDIzBj+ym+fo6gciVI2pfs=;
        b=ppogYeHJxlaer9oGeCo7jt1zEpQOIe3+RmUgbyOPQpgxpXLYzrIGa1LXfVFtlTzus0
         N9vvXb0cmnAw4RQSgGF+CwbxHNG2s6COfo3Tmcg5XT4n+nTihwFghRxUAsKFpOhGGTRq
         mJinwO5eY7+HPHic9wljfJjDbEubgzWTxViAB6BLCbnsje4qxds/yBJPmsK4/OvVTsR8
         Lh6zCcwaqWUnOZLdf9mnKdlubsHxmY3VU6w8G0Bkg/PI9vl8LfrdlPwK+Wca5fGwjTiL
         qs5l7oUQtqfHvMk+87Y98oQQbMmtYwpXdoThqAxRlI0yzN0aAUfEBrs5Op6zMbN4sSKj
         ha5w==
X-Gm-Message-State: AJIora+jQPiJwajqhpu/44sIDlfpGXMhl5DHFwoPFMua/Ql0OIgPPA7S
        G/dFtMmB8+zp9bdi5F4t7S8jTqNLuTiw1WGbT7M=
X-Google-Smtp-Source: AGRyM1uwpM39Y5hJukPhhAsF+Sd/ykgw+tW++s88t51mRboT6d8T2fs8H7237eve9IHtlfZjLFeZ60kSXT46gM9QNmY=
X-Received: by 2002:a05:6402:249e:b0:42d:bb88:865b with SMTP id
 q30-20020a056402249e00b0042dbb88865bmr22547322eda.141.1655635491659; Sun, 19
 Jun 2022 03:44:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220618214009.2178567-1-aidanmacdonald.0x0@gmail.com> <20220618214009.2178567-9-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220618214009.2178567-9-aidanmacdonald.0x0@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 19 Jun 2022 12:44:14 +0200
Message-ID: <CAHp75Ve7yyRfDOOcAbN1fQ9TNo-2okVr9jSyeEp8DfCY5K_wUg@mail.gmail.com>
Subject: Re: [PATCH v3 08/16] mfd: axp20x: Add support for AXP192
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
> The AXP192 PMIC is similar to the AXP202/AXP209, but with different
> regulators, additional GPIOs, and a different IRQ register layout.

...

> +static int axp192_get_irq_reg(unsigned int base_reg, int i)
> +{
> +       /* linear mapping for IRQ1 to IRQ4 */
> +       if (i < 4)
> +               return base_reg + i;
> +
> +       /* handle IRQ5 separately */
> +       if (base_reg == AXP192_IRQ1_EN)
> +               return AXP192_IRQ5_EN;

> +       else

Redundant 'else'.

> +               return AXP192_IRQ5_STATE;
> +}

...

> +enum {
> +       AXP192_DCDC1 = 0,
> +       AXP192_DCDC2,
> +       AXP192_DCDC3,
> +       AXP192_LDO1,
> +       AXP192_LDO2,
> +       AXP192_LDO3,
> +       AXP192_LDO_IO0,

> +       AXP192_REG_ID_MAX,

Comma is not needed for a terminator.

> +};

-- 
With Best Regards,
Andy Shevchenko
