Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50D54ACD19
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245058AbiBHBEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245737AbiBGX3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 18:29:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E0D65C061355
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 15:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644276576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Dl50fvdeDVHYYafqXS8rgfNHdVMJ0arMNo9zcfmZaw=;
        b=D5Vq5GP0XdidXehhk5wUgsR6tU7vKRFerTlZZYumPIZ/pn/5dQJL+UPElYobQkw1whkODp
        EMPZW+svzqTgLDOfLHVF01BjlxPZFOEZl9c4r7hSbdwqDN9ZXEOldc/smd866G6t39HKEv
        bERlmXmPMQW7fKNxcEpUFnxObDxKcW0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-A2Aosm06M1ewqGVz4Al-GQ-1; Mon, 07 Feb 2022 18:29:35 -0500
X-MC-Unique: A2Aosm06M1ewqGVz4Al-GQ-1
Received: by mail-qv1-f70.google.com with SMTP id w14-20020a0cfc4e000000b0042c1ac91249so910032qvp.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 15:29:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9Dl50fvdeDVHYYafqXS8rgfNHdVMJ0arMNo9zcfmZaw=;
        b=iSkc8Yr9lVZqUS+jnYaOjeieoDZ/YLHk4neHz/4rvfAefYNZzns5Ot3aWKzv89Ow+p
         p0vkIPr4idjeqe2FtuFmadlA5zPpgVlt6jPXFoZeJkOH6dlmIiGoEzmWubpMv1Bb5W0n
         QoBb3dIyArIuhe8Bg7oP7dvG53Xx8XKV+IWu9HS8DL7djqqP+0dJOo60N5h/RbrUmpH6
         Nw9kN2BwhMrwVcB8BIkXj1qIJ+1ruiq6Z3MF2r5TevKiYyLxgWcYCcRylfwsKvNFvyC9
         raw4bZ52VelIq7cGHP6DX7l/uVRNUZVSDUdP+8+bxRthCjcYKkciC1pBFAuMXAG/zd4a
         u1ng==
X-Gm-Message-State: AOAM531tNgR6gWY16jc4H2hexC/KKWnMTlwtR4D1lm9peq1PzIqtpweR
        JAmNehEVPowcDbjYUZKd3IgUkdWOVhLXxgw6pcMhNwNj3DPEJWQnoDx0e9sv/qdv1rAw22BsO5h
        abyiCZIQqDm/+WMkqjAjzZMAW
X-Received: by 2002:a05:620a:109c:: with SMTP id g28mr1301548qkk.560.1644276574677;
        Mon, 07 Feb 2022 15:29:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxRCWy8A39FHJDiaR3HWfSH2PQB5nFtWfWVP+5EnDyIq9AZyugGWgg4wvMnqxvuxjrnVcI/LA==
X-Received: by 2002:a05:620a:109c:: with SMTP id g28mr1301534qkk.560.1644276574401;
        Mon, 07 Feb 2022 15:29:34 -0800 (PST)
Received: from fedora (modemcable200.11-22-96.mc.videotron.ca. [96.22.11.200])
        by smtp.gmail.com with ESMTPSA id 195sm6132729qkf.30.2022.02.07.15.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 15:29:34 -0800 (PST)
Date:   Mon, 7 Feb 2022 18:29:32 -0500
From:   Adrien Thierry <athierry@redhat.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-rpi-kernel@lists.infradead.org" 
        <linux-rpi-kernel@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: [PATCH v2] serial: 8250_bcm2835aux: Add ACPI support
Message-ID: <YgGrXFCsmt4vPcRm@fedora>
References: <20220203213408.441407-1-athierry@redhat.com>
 <CAHp75VcCza4A5Yn+yn1HTpyPxuxbyheFQKZFZ_U6UHxcyHY0fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VcCza4A5Yn+yn1HTpyPxuxbyheFQKZFZ_U6UHxcyHY0fQ@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 05, 2022 at 01:58:43AM +0200, Andy Shevchenko wrote:
> On Thursday, February 3, 2022, Adrien Thierry <athierry@redhat.com> wrote:
> 
> > Add ACPI support to 8250_bcm2835aux driver. This makes it possible to
> > use the miniuart on the Raspberry Pi with the tianocore/edk2 UEFI
> > firmware.
> >
> > Signed-off-by: Adrien Thierry <athierry@redhat.com>
> > ---
> > V1 -> V2: Refactored code to remove unnecessary conditional paths and
> > intermediate variables
> >
> >  drivers/tty/serial/8250/8250_bcm2835aux.c | 87 ++++++++++++++++++-----
> >  1 file changed, 69 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c
> > b/drivers/tty/serial/8250/8250_bcm2835aux.c
> > index fd95860cd661..b7cec2a3b5f7 100644
> > --- a/drivers/tty/serial/8250/8250_bcm2835aux.c
> > +++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
> > @@ -12,6 +12,7 @@
> >   * simultaneously to rs485.
> >   */
> >
> > +#include <linux/acpi.h>
> 
> 
> For what purposes?
> Can’t you use device_get_match_data()?
> 
> 
> 
> >  #include <linux/clk.h>
> >  #include <linux/io.h>
> >  #include <linux/module.h>
> 
> 
> property.h?
> 
> 
> > @@ -44,6 +45,10 @@ struct bcm2835aux_data {
> >         u32 cntl;
> >  };
> >
> > +struct bcm2835_aux_serial_acpi_driver_data {
> > +       resource_size_t offset;
> > +};
> > +
> >  static void bcm2835aux_rs485_start_tx(struct uart_8250_port *up)
> >  {
> >         if (!(up->port.rs485.flags & SER_RS485_RX_DURING_TX)) {
> > @@ -82,8 +87,11 @@ static int bcm2835aux_serial_probe(struct
> > platform_device *pdev)
> >  {
> >         struct uart_8250_port up = { };
> >         struct bcm2835aux_data *data;
> > +       struct bcm2835_aux_serial_acpi_driver_data *acpi_data;
> >         struct resource *res;
> >         int ret;
> > +       resource_size_t offset = 0;
> > +       unsigned int uartclk;
> 
> 
> 
> Keep reversed Xmas tree order?
> 
> 
> 
> >
> >         /* allocate the custom structure */
> >         data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> > @@ -110,8 +118,11 @@ static int bcm2835aux_serial_probe(struct
> > platform_device *pdev)
> >
> >         /* get the clock - this also enables the HW */
> >         data->clk = devm_clk_get(&pdev->dev, NULL);
> > -       if (IS_ERR(data->clk))
> > -               return dev_err_probe(&pdev->dev, PTR_ERR(data->clk),
> > "could not get clk\n");
> > +       if (IS_ERR(data->clk)) {
> > +               ret = device_property_read_u32(&pdev->dev,
> > "clock-frequency", &uartclk);
> > +               if (ret)
> > +                       return dev_err_probe(&pdev->dev, ret, "could not
> > get clk\n");
> > +       }
> >
> >         /* get the interrupt */
> >         ret = platform_get_irq(pdev, 0);
> > @@ -125,20 +136,47 @@ static int bcm2835aux_serial_probe(struct
> > platform_device *pdev)
> >                 dev_err(&pdev->dev, "memory resource not found");
> >                 return -EINVAL;
> >         }
> > -       up.port.mapbase = res->start;
> > -       up.port.mapsize = resource_size(res);
> > -
> > -       /* Check for a fixed line number */
> > -       ret = of_alias_get_id(pdev->dev.of_node, "serial");
> > -       if (ret >= 0)
> > -               up.port.line = ret;
> > -
> > -       /* enable the clock as a last step */
> > -       ret = clk_prepare_enable(data->clk);
> > -       if (ret) {
> > -               dev_err(&pdev->dev, "unable to enable uart clock - %d\n",
> > -                       ret);
> > -               return ret;
> > +
> > +       if (has_acpi_companion(&pdev->dev)) {
> > +               const struct acpi_device_id *match;
> > +
> > +               match = acpi_match_device(pdev->dev.driver->acpi_match_table,
> > &pdev->dev);
> > +               if (!match)
> > +                       return -ENODEV;
> > +
> > +               acpi_data = (struct bcm2835_aux_serial_acpi_driver_data
> > *)match->driver_data;
> 
> 
> acpi_data naming is fragile. Use something with local namespace or without
> it completely (bcm_data, data, ddata, etc).
> 
> 
> > +
> > +               /* Some UEFI implementations (e.g. tianocore/edk2 for the
> > Raspberry Pi)
> > +                * describe the miniuart with a base address that
> > encompasses the auxiliary
> > +                * registers shared between the miniuart and spi.
> > +                *
> > +                * This is due to historical reasons, see discussion here :
> > +                * https://edk2.groups.io/g/devel/topic/87501357#84349
> > +                *
> > +                * We need to add the offset between the miniuart and
> > auxiliary
> > +                * registers to get the real miniuart base address.
> > +                */
> > +               offset = acpi_data->offset;
> 
> 
> 
> 
> > +       }
> > +
> > +       up.port.mapbase = res->start + offset;
> > +       up.port.mapsize = resource_size(res) - offset;
> > +
> > +       if (dev_of_node(&pdev->dev)) {
> > +               /* Check for a fixed line number */
> > +               ret = of_alias_get_id(pdev->dev.of_node, "serial");
> > +               if (ret >= 0)
> > +                       up.port.line = ret;
> > +
> > +               /* enable the clock as a last step */
> > +               ret = clk_prepare_enable(data->clk);
> > +               if (ret) {
> > +                       dev_err(&pdev->dev, "unable to enable uart clock -
> > %d\n",
> > +                               ret);
> > +                       return ret;
> > +               }
> > +
> > +               uartclk = clk_get_rate(data->clk);
> >         }
> >
> >         /* the HW-clock divider for bcm2835aux is 8,
> > @@ -146,7 +184,7 @@ static int bcm2835aux_serial_probe(struct
> > platform_device *pdev)
> >          * so we have to multiply the actual clock by 2
> >          * to get identical baudrates.
> >          */
> > -       up.port.uartclk = clk_get_rate(data->clk) * 2;
> > +       up.port.uartclk = uartclk * 2;
> >
> >         /* register the port */
> >         ret = serial8250_register_8250_port(&up);
> > @@ -159,7 +197,9 @@ static int bcm2835aux_serial_probe(struct
> > platform_device *pdev)
> >         return 0;
> >
> >  dis_clk:
> > -       clk_disable_unprepare(data->clk);
> > +       if (dev_of_node(&pdev->dev))
> > +               clk_disable_unprepare(data->clk);
> > +
> 
> 
> Why do you change this? CCF is null-aware.
> 
> 
> >         return ret;
> >  }
> >
> > @@ -173,16 +213,27 @@ static int bcm2835aux_serial_remove(struct
> > platform_device *pdev)
> >         return 0;
> >  }
> >
> > +static const struct bcm2835_aux_serial_acpi_driver_data
> > bcm2835_acpi_data = {
> > +       .offset = 0x40
> 
> 
> 
>  + comma
> 
> 
> +};
> > +
> >  static const struct of_device_id bcm2835aux_serial_match[] = {
> >         { .compatible = "brcm,bcm2835-aux-uart" },
> >         { },
> >  };
> >  MODULE_DEVICE_TABLE(of, bcm2835aux_serial_match);
> >
> > +static const struct acpi_device_id bcm2835aux_serial_acpi_match[] = {
> > +       { "BCM2836", (kernel_ulong_t)&bcm2835_acpi_data },
> > +       { },
> 
> 
> No comma for terminator entry.
> 
> 
> > +};
> > +MODULE_DEVICE_TABLE(acpi, bcm2835aux_serial_acpi_match);
> > +
> >  static struct platform_driver bcm2835aux_serial_driver = {
> >         .driver = {
> >                 .name = "bcm2835-aux-uart",
> >                 .of_match_table = bcm2835aux_serial_match,
> > +               .acpi_match_table = bcm2835aux_serial_acpi_match,
> >         },
> >         .probe  = bcm2835aux_serial_probe,
> >         .remove = bcm2835aux_serial_remove,
> >
> > base-commit: 1f2cfdd349b7647f438c1e552dc1b983da86d830
> > --
> > 2.34.1
> >
> >
> 
> -- 
> With Best Regards,
> Andy Shevchenko

Thanks for your feedback! I've submitted a v3 addressing your comments.

Adrien

