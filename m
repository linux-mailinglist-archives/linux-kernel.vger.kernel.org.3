Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8938E5509F7
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 13:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235846AbiFSLDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 07:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiFSLDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 07:03:31 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6079ABCB1;
        Sun, 19 Jun 2022 04:03:30 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id p8so1241008edc.2;
        Sun, 19 Jun 2022 04:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iH9YiWKluS7r8EhqqGQoDhsnGXyBo36qoUVwRM2zGLY=;
        b=J/Oxt9NqCQB7vE32FfxF+FWLksuzaDWZGsC9Hl6TA6d2ea3DmRLwTxMTeXgxR+CF0z
         1VPObYA6cT2qN4lcylruVWmeLYRMpi2aG8kad48SGI3O9g1k63ZG3xSO5aMJIugDwz/g
         gDrPEIZ7LStQGAhKxBv39ut9rGwXXJwW/4ug6lpq+ujaQ1rvy4cpbc41bzB5kkuoS7JK
         Wt+/dsaZncwhVR/60kXgPaXqtn6OWq47Titxn+ElHUOuATWK+2YYgHZ2/vWBLIJy6grH
         rwrteYOVcCJVnJcXPWyyMe0PiCI9BFqUzZCZxN5NLuVlABzF51WFUb9Nc7a0dqK1o0bV
         CJkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iH9YiWKluS7r8EhqqGQoDhsnGXyBo36qoUVwRM2zGLY=;
        b=iiHhjQZzwbuRuTe8z/OKhneXjRCrdV/DcyD2z9DHLy/ML8Mv7KNWpdKWUSZCNyLMG1
         AIeSkt0ZLJbpIUvPz9V5rjRjcjrYWp1Ccuq4vQIeloezpY6tU3R57WWiy73XgGXjxcgX
         S+uBRwq62bdDYcn1lOn91hkdj5YDoioLIhTxcwvg5Z706m95IW7BWYkiAl4A6pyzk0hZ
         XQIGMGHXbcaExfKfGldSK4ojcaA7yaCRBEyYbOOPmDxIwKkZRa8MNFaiYPegrA6aUmgC
         CKKhl4O1gu1vUguPjpquedFbuCxqNC5LCixHgrWlEZFKvfOiLf8f/Q7tpK6JZdFWkze4
         RpAg==
X-Gm-Message-State: AJIora+n6FqFLFQFNoE7N6NwwI+1UXjOt0KD3MqRfyUHzRBiRorBKbPm
        ExCSijXLkVONNzYXRm+4wXBXtPVUUmWkram3bjU=
X-Google-Smtp-Source: AGRyM1ufQsqNszSusF3NpIULBftOTax3t39ZyIOxU0KfXQnbLw7OZBm5dwhDi7V2fIRBaf7QNMQMXl1Pcze53OuSmxQ=
X-Received: by 2002:a05:6402:f8d:b0:435:6df2:68a with SMTP id
 eh13-20020a0564020f8d00b004356df2068amr8621835edb.209.1655636608887; Sun, 19
 Jun 2022 04:03:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220618214009.2178567-1-aidanmacdonald.0x0@gmail.com> <20220618214009.2178567-13-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220618214009.2178567-13-aidanmacdonald.0x0@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 19 Jun 2022 13:02:52 +0200
Message-ID: <CAHp75VfgeCExmPto-9-Yfe1W=KfUdv=h+PK9vajp+aQ17vCGPg@mail.gmail.com>
Subject: Re: [PATCH v3 12/16] power: supply: axp20x_usb_power: Add support for AXP192
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
> The AXP192 is mostly the same as the AXP202 but has a different
> current limit.

...

> +       int ret = regmap_read(power->regmap, AXP20X_VBUS_IPSOUT_MGMT, &v);
> +
> +       if (ret)
> +               return ret;

Please, split assignment, so it will be like

  int ret;

  ret = ...
  if (ret)

...

> +static int axp192_usb_power_set_current_max(struct axp20x_usb_power *power,
> +                                           int intval)
> +{
> +       int val = AXP192_VBUS_CLIMIT_EN;
> +       const int mask = AXP192_VBUS_CLIMIT_EN | AXP192_VBUS_CLIMIT_100mA;
> +
> +       switch (intval) {
> +       case 100000:
> +               val |= AXP192_VBUS_CLIMIT_100mA;

> +               fallthrough;

It's harder to part and error prone, can't you simply call a
regmap_update_bits with different arguments?

With this suggestion consider the defaults like these:

      const int mask = AXP192_VBUS_CLIMIT_EN | AXP192_VBUS_CLIMIT_100mA;
      int val = mask;

Then use  val & ~AXP192_VBUS_CLIMIT_100mA in the below case.

> +       case 500000:
> +               return regmap_update_bits(power->regmap,
> +                                         AXP20X_VBUS_IPSOUT_MGMT, mask, val);
> +       default:
> +               return -EINVAL;
> +       }
> +}

-- 
With Best Regards,
Andy Shevchenko
