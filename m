Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6336B58CBD6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 18:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243825AbiHHQIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 12:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiHHQIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 12:08:44 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B18B95A2;
        Mon,  8 Aug 2022 09:08:43 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d16so6816238qtw.8;
        Mon, 08 Aug 2022 09:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=D6H3FWkvPgAyi8KcndKPUMxUb6100sFw7ExbmjwXTbI=;
        b=IFbQVJhlIBsaHJiiXp3oauZaR0IAyt7xdm/OlK7D72eCbkdePMuZZ1hTWIdB+i1I8B
         lTjuKAaamm1v5OnKxpw/kCU8mOL6eNEoZAlrH/Sm8uNI3swdhnHSZvsturuVbCR8+sBU
         sAhnJeuC5hw0EHIaf5IdYrYykxnt0vlrKBRH7eMylODmVgtt9uAJ9DQJedtUrtykUPcP
         v7ekaS9OrK21ckc4jaQf/Ima2OSG32xgTS0Xqcg+fsq3ilG4/ahTUqtzTEvPLb7k1a6m
         YmDtMGcekKH5ojVDL1iKBlVsu+/tm3thgN3uzhoHpPxRWZPzOUTMh2zFJm2Pi23RZyG3
         VC8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=D6H3FWkvPgAyi8KcndKPUMxUb6100sFw7ExbmjwXTbI=;
        b=xXT2fQMQ641vLQ//j9CG5CBQragrHtopksE83+Vpw9/QucyPyBjg2OTk7dW8UtmQtu
         Q1QQgVG6T7NuSIS42dzSva473ko2Xze5I7p2c8nq4jWv2Vej0A2KcH5DAe2tJJrczlUi
         URMW82AVFD7fkS8WzKtCXso0+LXvBC9EPxHAXykjTzNHKj1ZiwRrOrOEOtTVhRVVLTFu
         oVKAo/UKXAF5AKTpmTV5NwC8bQhHanU7swcTmiCuFrqDLQGRTBoXXp8FWac/pXIG6ZZf
         gtHaS1D1X5pV8nTQx90ieazPmC4Sr5pEtTPubC64eNcsBDHKb583eZj59zqOe5KLuXiK
         S4Qg==
X-Gm-Message-State: ACgBeo2WT/4cYoOUUCDov/1HIUusY5GO1c7Z2N9acczTrfcwol8P3feW
        za/dqAkHo2RZ6y8hfA4wm6SvzoFD5sd4Kf39LOc=
X-Google-Smtp-Source: AA6agR58PRbpaqSPrt63xFozfeaOJB5yDow6p+0r5CZrmaGgnD2oxSE5whd8ETpPyoTz83nWgeVYJqOx3IFb3pKBB/0=
X-Received: by 2002:a05:622a:48f:b0:343:463:351a with SMTP id
 p15-20020a05622a048f00b003430463351amr1168316qtx.61.1659974922729; Mon, 08
 Aug 2022 09:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220808030420.8633-1-luke@ljones.dev> <20220808030420.8633-4-luke@ljones.dev>
In-Reply-To: <20220808030420.8633-4-luke@ljones.dev>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Aug 2022 18:08:06 +0200
Message-ID: <CAHp75VdNa8csSF5Je87kOzC3EQ4yetZqpxXFZu1D7C4A6XCTNg@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] asus-wmi: Implement TUF laptop keyboard power states
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
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

On Mon, Aug 8, 2022 at 5:09 AM Luke D. Jones <luke@ljones.dev> wrote:
>
> Adds support for setting various power states of TUF keyboards.
> These states are combinations of:
> - boot, set if a boot animation is shown on keyboard
> - awake, set if the keyboard LEDs are visible while laptop is on
> - sleep, set if an animation is displayed while the laptop is suspended
> - keyboard (unknown effect)
>
> Adds two sysfs attributes to asus-nb-wmi:
> - keyboard_rgb_state
> - keyboard_rgb_state_index

...

> +       flags = 0;

This can be done before 'if (boot)'

> +       if (sscanf(buf, "%hhd %hhd %hhd %hhd %hhd", &save, &boot, &awake, &sleep, &keyboard) != 5)
> +               return -EINVAL;

Same Q here: wouldn't it be better to put each of the parameters to a
separate sysfs node? Or look at the LED ABI (that what Pavel mentioned
for multi-color patterns) and see if there are already some
established ways of how to represent necessary information?

> +       save = save == 0 ? 0x0100 : 0x0000;

  if (save)
    flags = BIT(8);

> +       if (boot)
> +               flags |= 0x02;
> +       if (awake)
> +               flags |= 0x08;
> +       if (sleep)
> +               flags |= 0x20;
> +       if (keyboard)
> +               flags |= 0x80;

Use BIT() for flags.

...

> +       err = asus_wmi_evaluate_method3(ASUS_WMI_METHODID_DEVS,
> +                       ASUS_WMI_DEVID_TUF_RGB_STATE, 0xBD | save | (flags << 16), 0, &ret);

Why not provide flags to be a full 32-bit value?

Also 0xBD can be lower-cased and explained somehow?

...

> +

No need for a blank line.

> +static DEVICE_ATTR_WO(keyboard_rgb_state);

...

> +
> +static DEVICE_ATTR_RO(keyboard_rgb_state_index);

Ditto and same for many other similar cases.

...

>  #define ASUS_WMI_DSTS_STATUS_BIT       0x00000001

BIT(0) ? (This might require to add bits.h inclusion)

-- 
With Best Regards,
Andy Shevchenko
