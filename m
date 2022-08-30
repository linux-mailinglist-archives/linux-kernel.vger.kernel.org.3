Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFBA5A6DE1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 21:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbiH3TyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 15:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiH3TyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 15:54:09 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0647C7FF83;
        Tue, 30 Aug 2022 12:54:08 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id g16so9282893qkl.11;
        Tue, 30 Aug 2022 12:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=HDvx5qq2TktlH+XG3IMEp193NvmgngiqFhetAK/Kh8A=;
        b=Ef0wJXfuq+YrxUPaXTRwS/3lyBY/HXwIDwWHGDZPYv28XIBEYC92T/zlDyfA81b93N
         aPty68md8N6eR1RV9681ZuP0Ik7qSjE1H/07kIhBmAt/W7OezjcxlGv4I52OoGmnTMgm
         ZJSQFBaKvj3rdYBC9j4cPMIq+2CqL1IJZFNjjCOqM8/8TXJwPBidgYVkzfFobP/CCFfi
         V/+BD2tteQklRxJFFsaUEd0+FaBfnEFaZ429vVF2tNx4Dn2Za/hqJQHqly7hlHW+G53Q
         wZ80HeNheSv8PDgbfJTY6uCn3O7sLoeopaa5RzJVLv9RJykdFOED2Uq82YvmVrBelU+Z
         m7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=HDvx5qq2TktlH+XG3IMEp193NvmgngiqFhetAK/Kh8A=;
        b=IHJDQ38rA7bnx0ixmhB9w/ycgdTWFo9VeCUVsaFVlnO/ktB6WCWT8nAWwmG0vwICnd
         EM+KbVk00+AhkbybKYceEelN45rynVCeHRXkNld/XR9wvMqY3RBO4fhRLS2o4bcf8QIE
         j1MwXZYHDEno0uqTDFW6YeYMIkBGjfZ6yddes3lRW25jszyA5JyGFO8gqExOwEeuzbOY
         w/K3JLr6J7/XCvVLxIqsQy31Kz+bzxY9UwVi/hkjaP3LbQ2n6vjJghrznAjIiNmThf+j
         IW7eWpIA/hz52ofCE6OU2PSOZxdsst0wWpMugancnJjC2KSF5uO4lx78QDEQcSNN6as9
         Stsw==
X-Gm-Message-State: ACgBeo1rCZkyo0WTDUOs2q2PfuNdltNYOGqRhnOc8xJ1ceuECMzgrixt
        OKu7hE/x78fW1ZHUn/WYijDi3oMrq7T6KlRPoIpmhe+UHpY=
X-Google-Smtp-Source: AA6agR7ZLWiU1NJHbYCGVfkGQkSKB3WphctLbGYQq9Fdsjun8ED1GZhI537ald0MFENd16QgXy2l6WltXNxm+Lhk2Ns=
X-Received: by 2002:a05:620a:288a:b0:6b8:fcfe:db02 with SMTP id
 j10-20020a05620a288a00b006b8fcfedb02mr13684360qkp.504.1661889247085; Tue, 30
 Aug 2022 12:54:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220830180054.1998296-1-kumaravel.thiagarajan@microchip.com> <20220830180054.1998296-2-kumaravel.thiagarajan@microchip.com>
In-Reply-To: <20220830180054.1998296-2-kumaravel.thiagarajan@microchip.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 30 Aug 2022 22:53:31 +0300
Message-ID: <CAHp75VfraADCTmZATWTSsYtC5uk5bc=WDVVm0jtUVO90xdFd9g@mail.gmail.com>
Subject: Re: [PATCH v1 tty-next 1/2] 8250: microchip: pci1xxxx: Add driver for
 the quad-uart function in the multi-function endpoint of pci1xxxx device.
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Johan Hovold <johan@kernel.org>,
        Wander Lairson Costa <wander@redhat.com>,
        Eric Tremblay <etremblay@distech-controls.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jeremy Kerr <jk@ozlabs.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Lukas Wunner <lukas@wunner.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
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

On Tue, Aug 30, 2022 at 9:01 PM Kumaravel Thiagarajan
<kumaravel.thiagarajan@microchip.com> wrote:
>
> pci1xxxx is a PCIe switch with a multi-function endpoint on one of its
> downstream ports. Quad-uart is one of the functions in the
> multi-function endpoint. This driver loads for the quad-uart and
> enumerates single or multiple instances of uart based on the PCIe
> subsystem device ID.

Thanks for the contribution!
Brief looking into the code I can see that you may easily reduce it by ~20%.
Think about it. You may take other examples, that are servicing PCI based
devices (8250_exar, 8250_lpss, 8250_mid) on how to shrink the code base.

...

> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/string.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/delay.h>
> +#include <linux/tty.h>
> +#include <linux/serial_reg.h>
> +#include <linux/serial_core.h>
> +#include <linux/8250_pci.h>
> +#include <linux/serial_8250.h>
> +#include <linux/bitops.h>
> +#include <linux/io.h>

Why not sorted?
Do you need all of them?

...

> +       const unsigned int standard_baud_list[] = {50, 75, 110, 134, 150, 300,
> +                                               600, 1200, 1800, 2000, 2400, 3600,
> +                                               4800, 7200, 9600, 19200, 38400, 57600,
> +                                               115200, 125000, 136400, 150000, 166700,
> +                                               187500, 214300, 250000, 300000, 375000,
> +                                               500000, 750000, 1000000, 1500000};

Why?!

...

> +       if (baud == 38400 && (port->flags & UPF_SPD_MASK) == UPF_SPD_CUST) {

No. We don't want to have this in the new drivers. There is BOTHER
which might be used instead.

> +               writel((port->custom_divisor & 0x3FFFFFFF),
> +                      (port->membase + CLK_DIVISOR_REG));

...

> +                       frac = (((1000000000 - (quot * baud *
> +                               UART_BIT_SAMPLE_CNT)) / UART_BIT_SAMPLE_CNT)
> +                               * 255) / baud;

Funny indentation.

...

> +static int pci1xxxx_serial_probe(struct pci_dev *dev,
> +                                const struct pci_device_id *ent)
> +{
> +       struct pci1xxxx_8250 *priv;
> +       struct uart_8250_port uart;
> +       unsigned int nr_ports, i;
> +       int num_vectors = 0;
> +       int rc;
> +
> +       rc = pcim_enable_device(dev);

> +       pci_save_state(dev);

Why is this call here?

> +       if (rc)
> +               return rc;
> +
> +       nr_ports = pci1xxxx_get_num_ports(dev);
> +
> +       priv = devm_kzalloc(&dev->dev, struct_size(priv, line, nr_ports), GFP_KERNEL);
> +
> +       priv->membase = pcim_iomap(dev, 0, 0);
> +       priv->dev = dev;
> +       priv->nr =  nr_ports;

> +       if (!priv)
> +               return -ENOMEM;

You are dereferencing a NULL pointer before checking, how did you test
your code?

> +       pci_set_master(dev);
> +
> +       num_vectors  = pci_alloc_irq_vectors(dev, 1, 4, PCI_IRQ_ALL_TYPES);
> +       if (num_vectors < 0)
> +               return rc;

What does this mean?

> +       memset(&uart, 0, sizeof(uart));
> +       uart.port.flags = UPF_SHARE_IRQ | UPF_FIXED_TYPE | UPF_FIXED_PORT;
> +       uart.port.uartclk = 48000000;
> +       uart.port.dev = &dev->dev;
> +
> +       if (num_vectors == 4)
> +               writeb(UART_PCI_CTRL_SET_MULTIPLE_MSI, (priv->membase + UART_PCI_CTRL_REG));
> +       else
> +               uart.port.irq = pci_irq_vector(dev, 0);
> +
> +       for (i = 0; i < nr_ports; i++) {
> +               if (num_vectors == 4)
> +                       mchp_pci1xxxx_irq_assign(priv, &uart, i);
> +               rc = mchp_pci1xxxx_setup(priv, &uart, i);
> +               if (rc) {
> +                       dev_err(&dev->dev, "Failed to setup port %u\n", i);
> +                       break;
> +               }
> +               priv->line[i] = serial8250_register_8250_port(&uart);
> +
> +               if (priv->line[i] < 0) {
> +                       dev_err(&dev->dev,
> +                               "Couldn't register serial port %lx, irq %d, type %d, error %d\n",
> +                               uart.port.iobase, uart.port.irq,
> +                               uart.port.iotype, priv->line[i]);
> +                       break;
> +               }
> +       }
> +
> +       pci_set_drvdata(dev, priv);
> +
> +       return 0;
> +}

...

> +static const struct pci_device_id pci1xxxx_pci_tbl[] = {
> +       { PCI_DEVICE(PCI_VENDOR_ID_MCHP_PCI1XXXX, PCI_DEVICE_ID_MCHP_PCI11010) },
> +       { PCI_DEVICE(PCI_VENDOR_ID_MCHP_PCI1XXXX, PCI_DEVICE_ID_MCHP_PCI11101) },
> +       { PCI_DEVICE(PCI_VENDOR_ID_MCHP_PCI1XXXX, PCI_DEVICE_ID_MCHP_PCI11400) },
> +       { PCI_DEVICE(PCI_VENDOR_ID_MCHP_PCI1XXXX, PCI_DEVICE_ID_MCHP_PCI11414) },
> +       { PCI_DEVICE(PCI_VENDOR_ID_MCHP_PCI1XXXX, PCI_DEVICE_ID_MCHP_PCI12000) },

> +       {0,}

{ } is enough

> +};

...

> +

Unneeded blank line

> +module_pci_driver(pci1xxxx_pci_driver);

...

> +       [PORT_MCHP16550A] = {
> +               .name           = "MCHP16550A",
> +               .fifo_size      = 256,
> +               .tx_loadsz      = 256,
> +               .fcr            = UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_01,
> +               .rxtrig_bytes   = {2, 66, 130, 194},
> +               .flags          = UART_CAP_FIFO,
> +       },

Why do you need this?

...

> +/* MCHP 16550A UART with 256 byte FIFOs */
> +#define PORT_MCHP16550A        124

...and this?
If you really need this, try to find a gap in the numbering, there are some.

-- 
With Best Regards,
Andy Shevchenko
