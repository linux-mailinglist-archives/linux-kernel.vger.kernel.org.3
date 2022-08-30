Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62F55A6DF2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 21:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbiH3T6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 15:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiH3T63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 15:58:29 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B1280017;
        Tue, 30 Aug 2022 12:58:28 -0700 (PDT)
Received: by mail-qk1-f178.google.com with SMTP id a15so9311987qko.4;
        Tue, 30 Aug 2022 12:58:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=v+2PBzQnDqRl75a+Dvb/96lT7oLma7FyB0xvslJtYGk=;
        b=Ic8EHVrpdzcnhdd5GuI8gLgLf/0U3RcUHZhY7h8R+97bM0qbq8FoxAv4SMUhUIFZ44
         R8M3mBo2hAB6w01S7VfBGT9N/RegwPswSmHJYfJ+g56bH7h4zM3SWSiIHOd/7ZrdhtsE
         HnJPFV28WLo+6dO44R4+f5KVuNbVaJFXFEnbYyaYDwo4iK+GjGqHNeidI0WrAAFn4ydD
         AbhqKs4Y8Uljx3H6r2An13821GpFkNyJYJyyJ/E5wOQNJkYPkOuBKAp6Wm8ol2hK5Yz7
         GgupgWiSDDU+fniOjKqBbYUt0miFeAUOAJyWlIm8Tafac9gpKJ6zPdmdSPaWe2+E7tuf
         j84Q==
X-Gm-Message-State: ACgBeo084YaCsvnG8MEobq47NiJIAdIBDiCUJ72sELkILOk9PnxNa5iJ
        rPIlqjt34ekNudzsZkkCr27YL38qit5rYQ==
X-Google-Smtp-Source: AA6agR4ceMaBp7xGslk2gD/V6kvWpzceqNQPLriPxpPEPSCeo0HH2BzUw/X1+dMEFxpgEWsABqF64Q==
X-Received: by 2002:a05:620a:385:b0:6bb:5a16:54fc with SMTP id q5-20020a05620a038500b006bb5a1654fcmr13301193qkm.46.1661889507271;
        Tue, 30 Aug 2022 12:58:27 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id c6-20020a05620a268600b006be68f9bdddsm9088197qkp.133.2022.08.30.12.58.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 12:58:26 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-3321c2a8d4cso289226127b3.5;
        Tue, 30 Aug 2022 12:58:25 -0700 (PDT)
X-Received: by 2002:a0d:d691:0:b0:340:f6e7:5654 with SMTP id
 y139-20020a0dd691000000b00340f6e75654mr10226842ywd.502.1661889505614; Tue, 30
 Aug 2022 12:58:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220830180054.1998296-1-kumaravel.thiagarajan@microchip.com> <20220830180054.1998296-2-kumaravel.thiagarajan@microchip.com>
In-Reply-To: <20220830180054.1998296-2-kumaravel.thiagarajan@microchip.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 30 Aug 2022 21:58:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXePs4tE4xGT3uqe=Xrs4kr75BtUR2ueu8tJW+vx6WL0g@mail.gmail.com>
Message-ID: <CAMuHMdXePs4tE4xGT3uqe=Xrs4kr75BtUR2ueu8tJW+vx6WL0g@mail.gmail.com>
Subject: Re: [PATCH v1 tty-next 1/2] 8250: microchip: pci1xxxx: Add driver for
 the quad-uart function in the multi-function endpoint of pci1xxxx device.
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Johan Hovold <johan@kernel.org>,
        wander@redhat.com, etremblay@distech-controls.com,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Jeremy Kerr <jk@ozlabs.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Lukas Wunner <lukas@wunner.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kumaravel,

On Tue, Aug 30, 2022 at 8:01 PM Kumaravel Thiagarajan
<kumaravel.thiagarajan@microchip.com> wrote:
> pci1xxxx is a PCIe switch with a multi-function endpoint on one of its
> downstream ports. Quad-uart is one of the functions in the
> multi-function endpoint. This driver loads for the quad-uart and
> enumerates single or multiple instances of uart based on the PCIe
> subsystem device ID.
>
> Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>

Thanks for your patch!

> --- /dev/null
> +++ b/drivers/tty/serial/8250/8250_pci1xxxx.c

> +static struct pci_driver pci1xxxx_pci_driver = {
> +       .name           = "pci1xxxx serial",
> +       .probe          = pci1xxxx_serial_probe,
> +       .remove = pci1xxxx_serial_remove,
> +       .id_table       = pci1xxxx_pci_tbl,
> +};
> +
> +module_pci_driver(pci1xxxx_pci_driver);

> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -528,6 +528,15 @@ config SERIAL_8250_TEGRA
>           Select this option if you have machine with an NVIDIA Tegra SoC and
>           wish to enable 8250 serial driver for the Tegra serial interfaces.
>
> +config SERIAL_8250_PCI1XXXX
> +       tristate "Microchip 8250 based serial port"
> +       depends on SERIAL_8250

As this is a PCI driver, I guess it should depend on PCI
(|| COMPILE_TEST)?

> +       help
> +        Select this option if you have a setup with Microchip PCIe
> +        Switch with serial port enabled and wish to enable 8250
> +        serial driver for the serial interface. This driver support
> +        will ensure to support baud rates upto 1.5Mpbs.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
