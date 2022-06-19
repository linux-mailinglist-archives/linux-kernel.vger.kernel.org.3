Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBD05509D2
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 12:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235146AbiFSKrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 06:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbiFSKrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 06:47:14 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0231810553;
        Sun, 19 Jun 2022 03:47:14 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id y19so16110997ejq.6;
        Sun, 19 Jun 2022 03:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QumzxwcdQFbr7DumOzZDU4ULnvbRxcCjjd1yvsSCMC8=;
        b=CgQhvGC9XaFMuG1ZbQZ//ZMXTWvB8Ate2VXW+w2gOQ7cG/HCT0K1Q6XZ0OoWPgz46T
         Ea/v62UYhLARrPQM7a8nL3RCludaGDrpwchL2uGAN42/a/nZYi0AAjDB0S1Uc7sybDAJ
         sCdgdV0zRuxkPegZjUmXVoMjaAZppzJribXjuX9fxE/U0dkJGfzFbzMMm7UWw0y1ePrp
         xG7eTU8lPSdIiDBaRS6eXCdOr1tlIJPiZmQPqWEDfwgIQkpr1xBl+XqL3lkvZSslY9Q7
         Ki1GqgSSsCqtUM1/eSrCOCZOuqlLfyW8RKWx57xB51n7LrtLra71x82AvIF9EX6jSNzy
         f/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QumzxwcdQFbr7DumOzZDU4ULnvbRxcCjjd1yvsSCMC8=;
        b=nLgI/YX7ZENCiDnb3gveuGOnBJ1cN9Lt0AXyM7vnHJIBNhM2qv4AnGgkVVtQ7Q4N+C
         MHTbW2mVD5xwVtA0oP89VSLNlYAjSvxa7Zv3ASlQvTE0Z9JXIs7o8tKyhDxtMAwooiJY
         RPlDfbAX3E19O7rtS5nDRY8catiPcK9wFgSKydWqvky9ejDbuBneY400HqZM/RG6eO8/
         XcgdG16rML7gVtkLvYOXaPizUCZWbMhaxyUdmEaR0jsLGM1n2Dp7OTXCNM3BnVIz2ldV
         rv3aUrMAb4De+AohGoC8tK/KN9YHnBjIIEeS/NzxiRvm0bZIFiCcyRYIaBUI4YRJYcmm
         Pp8Q==
X-Gm-Message-State: AJIora/LVVpSdKEAyUDxij71pLMU/cL2NpnMX29StJIBE/mUdOamQ0Xd
        c76tPISiT5+EroZAiIc+55E/oGYe6YwaB8upeoc=
X-Google-Smtp-Source: AGRyM1v5G1MuJuXyOzRmyVXR4oV6123M8wojC41noXFWxC2vdQAXZ9u7b2GPfG49TsaNEueV6IGaXpufmGunJYn7jpU=
X-Received: by 2002:a17:906:149:b0:711:fca6:bc2f with SMTP id
 9-20020a170906014900b00711fca6bc2fmr16729199ejh.497.1655635632572; Sun, 19
 Jun 2022 03:47:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220618214009.2178567-1-aidanmacdonald.0x0@gmail.com> <20220618214009.2178567-10-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220618214009.2178567-10-aidanmacdonald.0x0@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 19 Jun 2022 12:46:36 +0200
Message-ID: <CAHp75Vdz3N2Ov2hMLjN7Ux9dDByvFna43q=0+Eh0smvBz5bFhg@mail.gmail.com>
Subject: Re: [PATCH v3 09/16] regulator: axp20x: Add support for AXP192
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
> Add support for the AXP192 PMIC.

...

> @@ -401,6 +431,7 @@ static int axp20x_set_ramp_delay(struct regulator_dev *rdev, int ramp)
>                         break;
>
>                 fallthrough;
> +
>         default:
>                 /* Not supported for this regulator */
>                 return -ENOTSUPP;

Stray change?

-- 
With Best Regards,
Andy Shevchenko
