Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA1158AB49
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 15:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240735AbiHENHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 09:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240858AbiHENHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 09:07:16 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899511A812;
        Fri,  5 Aug 2022 06:06:58 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id j4so1761557qkl.10;
        Fri, 05 Aug 2022 06:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=3FEi1CuKFHPWHETXS5rrQ8s9GwbgPfiuBefvLvAoBsk=;
        b=KgL/Ti/Sw5zH9EmMfo00bYbabUMlHnfPxzlYp138btnOZ5iHJws2jxCG33uwIKAM57
         ZH9pcxSaQ3WAvKMK+rlXSIpmF9goTDadcJBOaraf9vF+AYXYuuUCk1nn9mZTAv7A84VS
         IGN53sF6SexwC9WgkegcjbT+ydEtt7SJLKzuOXSjM7pv7pItuF3vkyrASesCL/DMFAma
         rvrzVZQfTooocv0qvKbynXnxhJZQrwyBscixkLCW31xTQ5ekgGyzVfdw4/3LfOktLn40
         aBpsyR98kiE/cfno9Vr7LLF4YuYZgav13rVMy6A3nxoUQo28k9pfuse69foAmsjNPvze
         VLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=3FEi1CuKFHPWHETXS5rrQ8s9GwbgPfiuBefvLvAoBsk=;
        b=ySiFODdYM7al7IA01RtrIGmH8x7fqHG1ACFrx2XxZCLAPHNiP4uI6FWcaVt5ihXIxM
         /NDhDkXyJj00/ToPSxMfihJbHA60Elhg5NFJuSkHUxTfRWlQBmAbM3AxsrFcCGaEkBVf
         g603QBriJxvLZtRsomS4977AYJ8F7BU4rbJb12InVW+KOIBS9Bg3gaUtek/pLH/zjGDQ
         qa9WBkDfbe5ydGLWVe+qcDVJYqVOAYXZiTKJJEI1T2LDA+7PHXWesewlOsyKtxZsq9Cw
         JYoBlpOxM+/xdR+C1hx3vP0LMoNMdmLx3qtkBw+b6D7QIkvs6ODZEGIQTugaRCYJ0yLc
         zePw==
X-Gm-Message-State: ACgBeo13FHeALHTaMh/wRLuHWKumYi2K83YMPXfoKbLtHiLHxaWUIdY6
        dZkOLa22jGGEHNUZNpnyIqBoz/QbE7DmnFPz0P4=
X-Google-Smtp-Source: AA6agR4j0zsJqZaQf0Yu4UVNEf1JelHQhvwq9j519MOA8iXjVXlQvyGrJ/GntjcmyE7xYpQsU0Y5iOHVvVZTTJcjLGA=
X-Received: by 2002:a05:620a:31a:b0:6b9:1f1a:7e13 with SMTP id
 s26-20020a05620a031a00b006b91f1a7e13mr727146qkm.748.1659704817063; Fri, 05
 Aug 2022 06:06:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220805070610.3516-1-peterwu.pub@gmail.com> <20220805070610.3516-14-peterwu.pub@gmail.com>
In-Reply-To: <20220805070610.3516-14-peterwu.pub@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 5 Aug 2022 15:06:19 +0200
Message-ID: <CAHp75VfiYNzmcPN8LNqvU0jKuWVFR3ODY3iWaJwpDxUdSORTOg@mail.gmail.com>
Subject: Re: [PATCH v7 13/13] video: backlight: mt6370: Add MediaTek MT6370 support
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Helge Deller <deller@gmx.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Alice Chen <alice_chen@richtek.com>,
        cy_huang <cy_huang@richtek.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        szuni chen <szunichen@gmail.com>
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

On Fri, Aug 5, 2022 at 9:08 AM ChiaEn Wu <peterwu.pub@gmail.com> wrote:
>
> From: ChiaEn Wu <chiaen_wu@richtek.com>
>
> MediaTek MT6370 is a SubPMIC consisting of a single cell battery charger
> with ADC monitoring, RGB LEDs, dual channel flashlight, WLED backlight
> driver, display bias voltage supply, one general purpose LDO, and the
> USB Type-C & PD controller complies with the latest USB Type-C and PD
> standards.
>
> Add a support for the MediaTek MT6370 backlight driver.
> It controls 4 channels of 8 series WLEDs in
> 2048 (only for MT6370/MT6371) / 16384 (only for MT6372)
> current steps (30 mA) in exponential or linear mapping curves.

...

> +#include <linux/backlight.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/kernel.h>
> +#include <linux/minmax.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>

> +#include <linux/of_device.h>

Why? Since below drop this and use fully fwnode / device property APIs.

> +#include <linux/platform_device.h>

Missed property.h which is heavily used in.the driver

> +#include <linux/regmap.h>

...

> +       /*
> +        * MT6372 uses 14 bits to control the brightness but MT6370 and MT6371
> +        * use 11 bits. They are different so we have to use this function to
> +        * check the vendor ID and use different mask, shift and default
> +        * maxiimum brightness value.

Use spell-checker for all your patches.

> +        */

-- 
With Best Regards,
Andy Shevchenko
