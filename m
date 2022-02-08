Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1DF4AD9D0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350729AbiBHN3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357622AbiBHN2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 08:28:50 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A92C1DCB1D;
        Tue,  8 Feb 2022 05:24:38 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id p15so52239072ejc.7;
        Tue, 08 Feb 2022 05:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s2gKXuCGuMo1+8hjYi2Ki/qC2fMJ6xlt3gzOw+cIe1k=;
        b=l+K8KSmNlUs9aaqjwJWukCGd0o2XiojzbY0BzX0LACRA/f3KcSxGHCURDQGYEnuVM3
         OFrJoBD+5XM1r6tVWDL5noneT2ZPwLbwf44ZN8XTdgyn/hzjCe7KSnCGvTvQDhSPbrzl
         rXia9JxtXHQT7mu2UfyjBLoCadCA45LusypsUREitl3+7kxlXJqKNjpEejYMV5neWk1x
         usTl19pxhV4mVUu5E24gmE7P6j3cSiL6HWX6IXmFQgsBBdG+oK+ip0I6JVuTcemGJTwO
         fapx7fvkyJ765ZHxtX9k9MUDZpFUnJV///sNzE1P+IfJqHl+V8te64YQO55gvqRKdDYt
         WJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s2gKXuCGuMo1+8hjYi2Ki/qC2fMJ6xlt3gzOw+cIe1k=;
        b=mXS6XEjAxqm40qKh/t2eoWdGXol+v4y+Nr+c2ZkUSmheA1zEs7j0watiroNoABCtpA
         GFrZW5TZCcd95fppKv4i15E9FH5AsHFsHmPL9jynslOCqVlzC/nIWz8j6H+CiT6+1OVr
         Jlgv30TmY1ZsAfzWxWBwQFbeXZ3jZJbC6fjpvakfdeJpPa/xRZ9ymxb9CZ8xujrg0sWK
         TU8eBwBx60jx9Fwx5TARUJFJBFQd5Ai2RNucISgHWGyx7SbH39ku9b7U6z8wnBFlHgPf
         PicALpGjxE4c/7UoPUexx/8EsZwIKjQ0pgTrWdsAOKja1gQgCCaZv/vP9rIDK58Of0cm
         ELTw==
X-Gm-Message-State: AOAM532kAlOOgGkS10C3sX8yijijE+9O/6NKS0+NxyGdaSB9nw3tVsmd
        NE6x0CuXu9XvzBTq3fb/P8iWRwFvWaYweDz99ZQ=
X-Google-Smtp-Source: ABdhPJw3EhA0CqFcCP8d5QPcz068Sxel66gqn+hYlHAtJxvhj9XFIhbMhKjLeFZNzYl+ATKvF/DQ6a7agdWUq/3OlIc=
X-Received: by 2002:a17:906:99c5:: with SMTP id s5mr3800882ejn.497.1644326677005;
 Tue, 08 Feb 2022 05:24:37 -0800 (PST)
MIME-Version: 1.0
References: <20220208031944.3444-1-bjorn.andersson@linaro.org> <20220208031944.3444-7-bjorn.andersson@linaro.org>
In-Reply-To: <20220208031944.3444-7-bjorn.andersson@linaro.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 8 Feb 2022 15:24:00 +0200
Message-ID: <CAHp75VcQ+HAmaH6eS7vX-hxVFbBS50iYFpNTJRjs6Q40t7=1ww@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] usb: typec: mux: Add On Semi fsa4480 driver
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        USB <linux-usb@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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

On Tue, Feb 8, 2022 at 1:26 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> The ON Semiconductor FSA4480 is a USB Type-C port multimedia switch with
> support for analog audio headsets. It allows sharing a common USB Type-C
> port to pass USB2.0 signal, analog audio, sideband use wires and analog
> microphone signal.
>
> Due to lacking upstream audio support for testing, the audio muxing is
> left untouched, but implementation of muxing the SBU lines is provided
> as a pair of TypeC mux and switch devices. This provides the necessary
> support for enabling the DisplayPort altmode on devices with this
> circuit.

...

> +config TYPEC_MUX_FSA4480
> +       tristate "ON Semi FSA4480 Analog Audio Switch driver"
> +       depends on I2C
> +       select REGMAP_I2C
> +       help
> +         Driver for the ON Semiconductor FSA4480 Analog Audio Switch, which
> +         provides support for muxing analog audio and sideband signals on a
> +         common USB Type-C connector.

What would be the module name?

...

> +/*
> + * Copyright (C) 2021 Linaro Ltd.

2021-2022 ?

> + * Copyright (C) 2018-2020 The Linux Foundation
> + */

...

Missed mod_devicetable.h ?

...

> +#define FSA4480_ENABLE_DEVICE  BIT(7)
> +#define FSA4480_ENABLE_SBU     GENMASK(6, 5)
> +#define FSA4480_ENABLE_USB     GENMASK(4, 3)

Don't forget to include bits.h

...

> +       /* used to serialize concurrect change requests */

concurrent

...

> +static const struct regmap_config fsa4480_regmap_config = {
> +       .reg_bits = 8,
> +       .val_bits = 8,

> +       .max_register = FSA4480_RESET,

I would create a specific macro, to avoid confusion in case if there
will be more hw revisions with slightly different register layouts.

> +};


...

> +       fsa->regmap = devm_regmap_init_i2c(client, &fsa4480_regmap_config);
> +       if (IS_ERR(fsa->regmap)) {

> +               dev_err(dev, "failed to initialize regmap\n");
> +               return PTR_ERR(fsa->regmap);

return dev_err_probe();

> +       }

...

> +       fsa->sw = typec_switch_register(dev, &sw_desc);
> +       if (IS_ERR(fsa->sw)) {
> +               dev_err(dev, "failed to register typec switch: %ld\n", PTR_ERR(fsa->sw));
> +               return PTR_ERR(fsa->sw);

Ditto.

> +       }

...

> +       mux_desc.fwnode = dev->fwnode;

Please, avoid dereferencing fwnode, use dev_fwnode() instead.

...

> +       fsa->mux = typec_mux_register(dev, &mux_desc);
> +       if (IS_ERR(fsa->mux)) {
> +               typec_switch_unregister(fsa->sw);
> +               dev_err(dev, "failed to register typec mux: %ld\n", PTR_ERR(fsa->mux));
> +               return PTR_ERR(fsa->mux);

return dev_err_probe();

> +       }

...

> +static struct i2c_driver fsa4480_driver = {
> +       .driver = {
> +               .name = "fsa4480",
> +               .of_match_table = fsa4480_of_table,
> +       },
> +       .probe_new      = fsa4480_probe,
> +       .remove         = fsa4480_remove,
> +       .id_table       = fsa4480_table,
> +};

> +

Redundant blank line.

> +module_i2c_driver(fsa4480_driver);

-- 
With Best Regards,
Andy Shevchenko
