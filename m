Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A203F54B3D0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 16:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245037AbiFNOt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 10:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235039AbiFNOt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 10:49:57 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEF91EEDB;
        Tue, 14 Jun 2022 07:49:56 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id u12so17637492eja.8;
        Tue, 14 Jun 2022 07:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9qHhTGxxY9/waiBpfU6mqYtlay9MtThobDAeZOTJkHQ=;
        b=fiNUu/SiNf33k6dJaZ95un7DWP2Yv+shAdb6ZksmWhtZDwHnC1BMu7T0xWkn4OuqOQ
         X8vMKc7WNB9H83uqjV2aYPfLzniZmqsHRgljLiyxXBgOVblJUN9EOlIZJLes941Jh1+I
         7qdhMuxy4eRi1VAj2ttGP3MatHBgada6EUAhrycVnCJSxHu/wIV/iUdvQlglzhLIoVpX
         N02iJ4d85ICFofTyXu3SKW0M/jixATZbrzpdwh/QcdrN2OoXD97YAamPIE2pT+ANVCib
         RzZdCGdvoCQb1NLCuU0ftoW8xMaMaDmf+/0+4MW6k0ImoMOgBg/wp8CGFGnyXZ+PI9JS
         EHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9qHhTGxxY9/waiBpfU6mqYtlay9MtThobDAeZOTJkHQ=;
        b=Dt4ybsnn2cfzbGqFcrmvATMWx824DSpR4LJvG+nNehsMoXx94CHKnhLJaj7RSXfUL5
         CN9FHd6iNOvEjlVBxQ9xSjSRTSZCyyuQBwy+M1ZDqWXHEPb5vaJd0id7vdSGiweAPlbo
         inEHnJxnliBRTDw0agI22S1Kjn3WNFqEFVyNqrDolxirRt9VeQsRWQdZ7Z8/vbUhmWhx
         JFDp0bU+GhqyxivYCJ3WrAOk+CBw+sYEB60CQaijtb9tdSeFXpcipfPKp2MOdGXi3Jg5
         hEuW7+RVx3i8OlenCGhDNlBeClWUulWGb6LiM5RVhKznyv1Tczn1mgkYfsNghljGkyV+
         J7pw==
X-Gm-Message-State: AOAM533DBUHfsKswlUH1AX98sD+YVGirrs/DeBB4kSlj80+IMz3ilw02
        c1RJqOGIMz7A7fbEYYPHQdAlwq6PTEcq95bmgMTcg00XtH3phA==
X-Google-Smtp-Source: ABdhPJykAc4fFrO2Ai+35/pU6BtImZMf+AWI71ybB0/OdOr3BkqeJxAkOP/SXOpcaHNU5Q0y3C5hAET/hbdgSlfXFsQ=
X-Received: by 2002:a17:906:c7c1:b0:711:d2e9:99d0 with SMTP id
 dc1-20020a170906c7c100b00711d2e999d0mr4636129ejb.639.1655218195050; Tue, 14
 Jun 2022 07:49:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220614142704.155496-1-jjhiblot@traphandler.com> <20220614142704.155496-3-jjhiblot@traphandler.com>
In-Reply-To: <20220614142704.155496-3-jjhiblot@traphandler.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 14 Jun 2022 16:49:13 +0200
Message-ID: <CAHp75Vc1=hNzrVeA9J_TbVEWFO4b-8+VjdsyJVMRTRkX5yhNhQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] leds: Add driver for the TLC5925 LED controller
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

On Tue, Jun 14, 2022 at 4:27 PM Jean-Jacques Hiblot
<jjhiblot@traphandler.com> wrote:
>
> The TLC5925 is a 16-channels constant-current LED sink driver.
> It is controlled via SPI but doesn't offer a register-based interface.
> Instead it contains a shift register and latches that convert the
> serial input into a parallel output.
>
> Datasheet: https://www.ti.com/lit/ds/symlink/tlc5925.pdf

>

No blank lines are allowed in the tag block.

> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>

...

> +#include <linux/err.h>
> +#include <linux/leds.h>
> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <linux/spi/spi.h>

This misses a few headers that this code is direct user of:
container_of.h
gpio/consumer.h
types.h

...

> +       // assign_bit() is atomic, no need for lock

Comment is useless, since it's a pattern that is used in the kernel:
__op is non-atomic, op is atomic.

...

> +
> +

One blank line is enough

...

> +
> +

Ditto.

...

> +       gpios = devm_gpiod_get_array(dev, "output-enable-b", GPIOD_OUT_LOW);
> +       if (IS_ERR(gpios)) {
> +               return dev_err_probe(dev, PTR_ERR(gpios),
> +                             "Unable to get the 'output-enable-b' gpios\n");
> +       }

{} are not needed, and you may put the return on one line.

...

> +       count = device_get_child_node_count(dev);
> +       if (!count) {
> +               dev_err(dev, "no led defined.\n");
> +               return -ENODEV;
> +       }

It's fine to use return dev_err_probe() in such cases like above, it's
written in the documentation.

...

> +               ret = fwnode_property_read_u32(child, "reg", &idx);
> +               if (ret || idx >= max_num_leds) {
> +                       dev_warn(dev, "%s: invalid reg value. Ignoring.\n",
> +                               fwnode_get_name(child));

%pfw / %pfwP ?

> +                       fwnode_handle_put(child);
> +                       continue;
> +               }

...

> +               ret = devm_led_classdev_register_ext(dev, cdev, &init_data);
> +               if (ret) {
> +                       dev_warn(dev, "%s: cannot create LED device.\n",
> +                               fwnode_get_name(child));

Ditto.

> +                       fwnode_handle_put(child);
> +                       continue;
> +               }

-- 
With Best Regards,
Andy Shevchenko
