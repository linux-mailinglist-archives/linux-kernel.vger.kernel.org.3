Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E095358B4D6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 11:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241430AbiHFJpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 05:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiHFJpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 05:45:12 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC43267;
        Sat,  6 Aug 2022 02:45:10 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id j11so3296952qvt.10;
        Sat, 06 Aug 2022 02:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=s8hays+t4s+HbAaR0Q2fvODVpO1gL6BOZFTgfgEYjg0=;
        b=RBVbL4pHi2cB/0frRoq+TdMbSjx32MvuhYiLUqKfxcVyDNQha7aBnTFbYm9hn8/tQU
         ktMscYdD5jVpVPqqa3YdWT5lDWyFpaNmsEyylVn8RsWcbSQmAjD52SaqRXqwmQ2v/0l+
         v0GVWlcCq3Ld5gHjSqhynAfhpvAP6e14DPIyRubhoM9kRDYAnJa5lPcHZDPOOISrhK7/
         XuyHD2X9vC0x5WxqFCzxQgI4L+qE1Y2Pq/Cs7x9n731WDd3em2KPbSxaxS0gG92S76V4
         KOQJ/EgYxvQaAHsYPIRyxkiVxwA9Dxlxkgm4m7ySbFJeLUkDFqktVI/x0hSLYrTHoGZI
         sRNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=s8hays+t4s+HbAaR0Q2fvODVpO1gL6BOZFTgfgEYjg0=;
        b=vuXTWne2yyVArlyuQol9JLu7Nh5yZvGhPdnSK7FX2PBJAk04Trq30K0uSlITc72Yon
         Vn3AujUKDN+PYHHLNZ0bzKQu7sB1NRKYezBXUxk17B2xAuZhBEzTUdZO6ODuhQQKWTe/
         zfSFYcOloosZXCNqiBFR+meLy72KgKmt5dstSGLMTEoOPzQwusGF+l060Euj3uWKqIiW
         WqAiJ3g1HQAbr+VdPVcuxchVXABB1cwT97+nFK5ARlCt+yJz6t6Z4/jp9ABo2uwHS0Ct
         ENL16DoWs+QuCRHh9PNB3IC0IhussXtAOfo2mOFr47H8tjj7KLUaYpOGWpvyPATDEIfz
         +isw==
X-Gm-Message-State: ACgBeo3V2orKLe0seZZcN3/rNjeOsHU9L+8HwDY8MSCQb2OBRo/QItYm
        AIzpeUNZTiI3vK7zIQ2Mg/3TQNGkh5LlO0mqWTA=
X-Google-Smtp-Source: AA6agR4L8XzBVrJgJv8PpdCF1enk2ZP25pUwz8h+zgUF6XM3L3QkBTbWcbrwRD3gjKOJsssFdu4W0ulAOe7IncXM7YI=
X-Received: by 2002:a05:6214:d07:b0:476:c32f:f4f4 with SMTP id
 7-20020a0562140d0700b00476c32ff4f4mr9121208qvh.11.1659779109993; Sat, 06 Aug
 2022 02:45:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220805081909.10962-1-luke@ljones.dev> <20220805081909.10962-2-luke@ljones.dev>
In-Reply-To: <20220805081909.10962-2-luke@ljones.dev>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 6 Aug 2022 11:44:33 +0200
Message-ID: <CAHp75Ve-oo=pGkpD10kbOVtrYtzQLscFq9HO0-Y5a6M_fpXDNw@mail.gmail.com>
Subject: Re: [PATCH 1/5] asus-wmi: Add basic support for TUF laptop keyboard RGB
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

On Fri, Aug 5, 2022 at 10:20 AM Luke D. Jones <luke@ljones.dev> wrote:
>
> Adds support for TUF laptop RGB control via the multicolor LED API.
>
> As this is the base essentials for adjusting the RGB, it sets the

these are
...or...
essential

> default mode of the keyboard to static. This overwrites the booted
> state of the keyboard.

...

>  #include <linux/leds.h>
> +#include <linux/led-class-multicolor.h>

Not sure about the ordering ('-' vs. 's') in locale C.

...

> +static int tuf_rgb_brightness_set(struct led_classdev *cdev,
> +       enum led_brightness brightness)
> +{
> +       u8 r, g, b;
> +       int err;
> +       u32 ret;

> +
> +       struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(cdev);

No need to put blank lines in the definition block. Also it would be
better to move the longest line to be first.

> +       led_mc_calc_color_components(mc_cdev, brightness);
> +       r = mc_cdev->subled_info[0].brightness;
> +       g = mc_cdev->subled_info[1].brightness;
> +       b = mc_cdev->subled_info[2].brightness;
> +
> +       /* Writing out requires some defaults. This will overwrite boot mode */
> +       err = asus_wmi_evaluate_method3(ASUS_WMI_METHODID_DEVS, ASUS_WMI_DEVID_TUF_RGB_MODE,
> +                       1 | 0 | (r << 16) | (g << 24), (b) | 0, &ret);

What the point in those ' | 0'  additions?

> +       if (err) {
> +               pr_err("Unable to set TUF RGB data?\n");

Why not dev_err() ?

> +               return err;
> +       }
> +       return 0;

return err;

> +}

...

> +       if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE)) {
> +               struct led_classdev_mc *mc_cdev;
> +               struct mc_subled *mc_led_info;
> +               u8 brightness = 127;

> +               mc_cdev = &asus->keyboard_rgb_mode.dev;

Join this with the definition above. It's fine if it's a bit longer
than 80 characters.

> +               /*
> +                * asus::kbd_backlight still controls a base 3-level backlight and when
> +                * it is on 0, the RGB is not visible at all. RGB should be treated as
> +                * an additional step.
> +                */
> +               mc_cdev->led_cdev.name = "asus::multicolour::kbd_backlight";
> +               mc_cdev->led_cdev.flags = LED_CORE_SUSPENDRESUME | LED_RETAIN_AT_SHUTDOWN;
> +               mc_cdev->led_cdev.brightness_set_blocking = tuf_rgb_brightness_set;
> +               mc_cdev->led_cdev.brightness_get = tuf_rgb_brightness_get;
> +
> +               /* Let the multicolour LED own the info */
> +               mc_led_info = devm_kmalloc_array(
> +                       &asus->platform_device->dev,

With a temporary variable you may make this one line shorter and nicer looking

  struct device *dev = &asus->platform_device->dev;

> +                       3,
> +                       sizeof(*mc_led_info),
> +                       GFP_KERNEL | __GFP_ZERO);
> +
> +               if (!mc_led_info)
> +                       return -ENOMEM;
> +
> +               mc_led_info[0].color_index = LED_COLOR_ID_RED;
> +               mc_led_info[1].color_index = LED_COLOR_ID_GREEN;
> +               mc_led_info[2].color_index = LED_COLOR_ID_BLUE;
> +
> +               /*
> +                * It's not possible to get last set data from device so set defaults
> +                * to make it safe for a user to change either RGB or modes. We don't
> +                * write these defaults to the device because they will overwrite a
> +                * users last saved boot setting (in NVRAM).
> +                */
> +               mc_cdev->led_cdev.brightness = brightness;
> +               mc_cdev->led_cdev.max_brightness = brightness;
> +               mc_led_info[0].intensity = brightness;
> +               mc_led_info[0].brightness = mc_cdev->led_cdev.brightness;
> +               mc_led_info[1].brightness = mc_cdev->led_cdev.brightness;
> +               mc_led_info[2].brightness = mc_cdev->led_cdev.brightness;
> +               led_mc_calc_color_components(mc_cdev, brightness);
> +
> +               mc_cdev->subled_info = mc_led_info;
> +               mc_cdev->num_colors = 3;
> +
> +               rv = led_classdev_multicolor_register(&asus->platform_device->dev, mc_cdev);

This also becomes shorter.

> +       }

-- 
With Best Regards,
Andy Shevchenko
