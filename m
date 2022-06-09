Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A30D54528B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 18:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344874AbiFIQ6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 12:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238833AbiFIQ6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 12:58:03 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65E9BE176;
        Thu,  9 Jun 2022 09:58:01 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id s12so41485578ejx.3;
        Thu, 09 Jun 2022 09:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VeJH2GjgTNv55jeCpCfZ1ujKSjcX5p8lHDW19F4+qv0=;
        b=eU51bgefzD4BjSWwpiGbcxgEQEXO5kaPih1MD0/kJ8dKtUTbxN1L+VPH8x71j31XaQ
         215GBGMNb8eotwEdhZpA0DuYQud1RfSg2bN1RSAONgW4D/x21ylx2sAoouEVuqH5kBG5
         uCfISMSgZMxlya10bCwA1qOrBD5OxxBHgVqocUc/pQLAeo4as0p9eq6JKTl7y0GnBmyq
         NCDQl7i7pNzhR7yIIh8sddZilQChCu4q568RtEoo46P+w+xhJTHTcBSN9mSP89ZP7X8W
         EkbW9sMwsxhAQW6q8zgEqLtlqlZ+9hEBsjW7l4pBijYq8hnVZqhpBfsCJN3buf3UsTpt
         Pq8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VeJH2GjgTNv55jeCpCfZ1ujKSjcX5p8lHDW19F4+qv0=;
        b=rd4rPCQot3aAtdTQhIp2vhlxOz/8nFeRgPgtmvf++rSNTFN1txdh+OA95kdJffN3eP
         bIACF6kd+ulEB0svU3nXT91T1WrQJVaj7QMpwGrLThz33KFEYCA4pn141+f+W5IcyXB+
         xQCmejK8Mvwt46n+4P8xyEXTMqJUYnpJZsmvwc8PBTTVyZwMEeKTVpKRAU+eakINt2pl
         65SlrHSDQQUJ5n0QLym3YjcSq80hwvRFf/EyeKPnuIIletRDLLWO2on933ZX/Xm5kLpm
         zsOKJ2jgg6e37Sowqr7C07wOUTGGu6OdWTytr8H9msUAB5SQx+vXvXElvN9DRlipMyMu
         nnBg==
X-Gm-Message-State: AOAM532HLOV2gI3hqt4pyShwtoqt/8JmYp8os2T+lyu7X1EaoFMDhReZ
        c0snWnMu47+6fsWOIQVMqS0gZmDTPzFojCEcisw=
X-Google-Smtp-Source: ABdhPJz/bLVGa94IUhnQGtuYBTuAjqeCnsYqrJUHvGlOch8tOQQBrYNlJ4iNmC+EQIqmuResN1kzJ7b4XtO4YLokwhs=
X-Received: by 2002:a17:906:1193:b0:70d:cf39:a4db with SMTP id
 n19-20020a170906119300b0070dcf39a4dbmr31577671eja.44.1654793880193; Thu, 09
 Jun 2022 09:58:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220609162734.1462625-1-jjhiblot@traphandler.com> <20220609162734.1462625-3-jjhiblot@traphandler.com>
In-Reply-To: <20220609162734.1462625-3-jjhiblot@traphandler.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 9 Jun 2022 18:57:24 +0200
Message-ID: <CAHp75Veurvhxi0Pg1Sjxav+3XpDTVOdan8WFFmZmdhJbZJiCaQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] leds: Add driver for the TLC5925 LED controller
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     Pavel Machek <pavel@ucw.cz>, krzk+dt@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
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

On Thu, Jun 9, 2022 at 6:30 PM Jean-Jacques Hiblot
<jjhiblot@traphandler.com> wrote:
>
> The TLC5925 is a 16-channels constant-current LED sink driver.
> It is controlled via SPI but doesn't offer a register-based interface.
> Instead it contains a shift register and latches that convert the
> serial input into a parallel output.

Can you add Datasheet: tag here with the corresponding URL? Rationale
is to get a link to the datasheet by just browsing Git log without
browsing the source code, which will benefit via Web UIs.
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>

...

> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/leds.h>
> +#include <linux/err.h>
> +#include <linux/spi/spi.h>
> +#include <linux/property.h>
> +#include <linux/workqueue.h>

Keep it sorted?

...

> +struct single_led_priv {
> +       int idx;
> +       struct led_classdev cdev;

For pointer arithmetics it's better to swap these two members.

> +};
> +
> +struct tlc5925_leds_priv {
> +       int max_num_leds;
> +       u8 *state;

unsigned long? DECLARE_BITMAP() ?

> +       spinlock_t lock;
> +       struct single_led_priv leds[];
> +};

...

> +       if (brightness)
> +               priv->state[index / 8] |= (1 << (index % 8));
> +       else
> +               priv->state[index / 8] &= ~(1 << (index % 8));

assign_bit()

...

> +       return spi_write(spi, priv->state, priv->max_num_leds / 8);

BITS_TO_BYTES() ?

...

> +       count = device_get_child_node_count(dev);
> +       if (!count) {
> +               dev_err(dev, "no led defined.\n");
> +               return -ENODEV;

  return dev_err_probe(...);

here and everywhere in ->probe() and Co.

> +       }

...

> +       ret = device_property_read_u32_array(dev, "ti,shift-register-length",
> +                                            &max_num_leds, 1);

Always an array of 1 element? call device_property_read_u32().

...

> +       if (max_num_leds % 8) {
> +               dev_err(dev, "'ti,shift-register-length' must be a multiple of 8\n");
> +               return -EINVAL;
> +       }

Is this really fatal? I would rather issue a warning and go on if it
has at least 8 there. So the idea is to use a minimum that holds
multiple of 8.

...

> +       /* Assert all the OE/ lines */
> +       gpios = devm_gpiod_get_array(dev, "output-enable-b", GPIOD_OUT_LOW);
> +       if (IS_ERR(gpios)) {
> +               dev_err(dev, "Unable to get the 'output-enable-b' gpios\n");
> +               return PTR_ERR(gpios);
> +       }

You have to use dev_err_probe() here, otherwise it will spam logs a
lot in case of deferred probe.

...

> +       priv->state = devm_kzalloc(dev, DIV_ROUND_UP(max_num_leds, 8), GFP_KERNEL);

devm_bitmap_zalloc()

...

> +       device_for_each_child_node(dev, child) {
> +               struct led_init_data init_data = {.fwnode = child};

Missed spaces.

> +               struct led_classdev *cdev;
> +               u32 idx;
> +
> +               ret = fwnode_property_read_u32_array(child, "reg", &idx, 1);

fwnode_property_read_u32()

> +               if (ret || idx >= max_num_leds) {
> +                       dev_err(dev, "%s: invalid reg value. Ignoring.\n",
> +                               fwnode_get_name(child));
> +                       fwnode_handle_put(child);
> +                       continue;

Either dev_warn + continue, or dev_err + return dev_err_probe().

> +               }
> +
> +               count--;
> +               priv->leds[count].idx = idx;
> +               cdev = &(priv->leds[count].cdev);
> +               cdev->brightness = LED_OFF;
> +               cdev->max_brightness = 1;
> +               cdev->brightness_set_blocking = tlc5925_brightness_set_blocking;
> +
> +               ret = devm_led_classdev_register_ext(dev, cdev, &init_data);
> +               if (ret) {

Ditto.

> +                       dev_err(dev, "%s: cannot create LED device.\n",
> +                               fwnode_get_name(child));
> +                       fwnode_handle_put(child);
> +                       continue;
> +               }
> +       }

...

> +static const struct of_device_id tlc5925_dt_ids[] = {
> +       { .compatible = "ti,tlc5925", },
> +       {},

No comma for terminator entry.

> +};

Where is the MODULE_DEVICE_TABLE() for this one?

...

> +

No  need for this blank line.

> +module_spi_driver(tlc5925_driver);

-- 
With Best Regards,
Andy Shevchenko
