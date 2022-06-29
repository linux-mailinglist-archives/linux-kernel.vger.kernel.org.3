Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC6A5606DC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 19:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbiF2RCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 13:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiF2RB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 13:01:56 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F400338D8E;
        Wed, 29 Jun 2022 10:01:54 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 0F0CA300002D8;
        Wed, 29 Jun 2022 19:01:53 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id E3F91A5783; Wed, 29 Jun 2022 19:01:52 +0200 (CEST)
Date:   Wed, 29 Jun 2022 19:01:52 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>, m.brock@vanmierlo.com,
        David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH] serial: Revert RS485 polarity change on UART open
Message-ID: <20220629170152.GA24851@wunner.de>
References: <20220329085050.311408-1-matthias.schiffer@ew.tq-group.com>
 <20220329100328.GA2090@wunner.de>
 <b2f29129f966685105e09781620b85c8f4f1a88e.camel@ew.tq-group.com>
 <383f5d66d6828a5f09f5705f6ff98e3727ecfdf2.camel@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <383f5d66d6828a5f09f5705f6ff98e3727ecfdf2.camel@ew.tq-group.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 10:40:36AM +0200, Matthias Schiffer wrote:
> On Tue, 2022-03-29 at 12:39 +0200, Matthias Schiffer wrote:
> > On Tue, 2022-03-29 at 12:03 +0200, Lukas Wunner wrote:
> > > On Tue, Mar 29, 2022 at 10:50:50AM +0200, Matthias Schiffer wrote:
> > > > While the change of the RS485 polarity in
> > > > commit d3b3404df318 ("serial: Fix incorrect rs485 polarity on uart
> > > > open")
> > > > might have made sense based on the original intention of the
> > > > rs485-rts-active-low flag (*), this is not how it is implemented in
> > > > various drivers:
> > > [...]
> > > > [(*) My understanding of the mentioned commit's description is that
> > > > rs485-rts-active-low should have referred to the electical signal
> > > > level
> > > > of the RTS pin, rather than the logical RTS state as understood by
> > > > the
> > > > UART controller.]
> 
> do you know if there has been any progress on this issue? I see that
> there has been quite a bit of activity in the RS485 code in linux-next, 
> but I didn't have time to check if that has any effect on the polarity
> issue so far.

No, the issue has not been resolved yet but at least I have inspected
all drivers now and compiled a list of their behavior:

          8250_bcm2835aux: identity (RTS in software)
          8250_dwlib:      identity (RTS in hardware, DE active high after POR)
                           inverse  (RTS in software em485)
          8250_exar:       identity (RTS in hardware)
          8250_fintek:     inverse  (RTS in hardware)
          8250_lpc18xx:    identity (RTS in hardware)
          8250_of:         inverse  (RTS in software em485)
                                    [ns8250, ns16550, lpc3220, da830, wpcm450]
          8250_omap:       inverse  (RTS in software em485)
          8250_pci:        identity (RTS in hardware)
          amba-pl011:      identity (RTS in software)
          ar933x_uart:     identity (RTS as gpio)
          atmel_serial:    identity (RTS in hardware, only high supported)
          fsl_lpuart:      inverse  (RTS in hardware)
          imx:             identity (RTS as gpio or CTS in software)
          max310x:         identity (RTS in hardware)
          mcf:             identity (RTS in hardware)
          omap-serial:     identity (RTS as gpio)
          sc16is7xx:       inverse  (RTS in hardware)
          stm32-usart:     identity (RTS in hardware)
                           identity (RTS as gpio)

Where "identity" means that SER_RS485_RTS_ON_SEND results in "high"
voltage level and "inverse" means it results in "low" voltage level.

Unless I've made any mistakes here, it looks like the majority of
drivers use "identity".  The only ones using inverse polarity are
8250-compatible UARTs using em485 software emulation (with the
exception of bcm2835aux), plus three UART drivers which use
hardware-driven RTS.

When you reported the issue, you claimed that i.MX, OMAP and STM32
drivers use inverse polarity.  I was only able to confirm that for
OMAP (if 8250_omap.c is used, not the older omap-serial.c).

When you refer to i.MX, I suppose you're referring to fsl_lpuart.c
(which uses hardware-controlled RTS assertion on newer i.MX SoCs),
not imx.c, right?  The latter offers two options to drive an RS-485
transceiver, either through CTS or through an mctrl_gpio.
imx_uart_rts_active() clears the CTS bit in the UCR2 register.
According to page 4679 of iMX53RM.pdf, that means "high" voltage level,
hence "identity".  And if an mctrl_gpio is used, mctrl_gpio_set()
sets the GPIO to "active", which likewise means "high" voltage level
unless you've specified the GPIO as active-low in the devicetree:
https://www.nxp.com/docs/en/reference-manual/iMX53RM.pdf

As for stm32-usart.c, the driver offers either hardware-controlled
RTS assertion or mctrl_gpio.  The hardware-controlled variant clears
the DEP bit in the USART_CR3 register if SER_RS485_RTS_ON_SEND is set.
According to page 1392 of the STM32 documentation this means that
"DE signal is active high", so it seems to me that this driver uses
"identity and not "inverse" as claimed:
https://www.st.com/resource/en/reference_manual/rm0351-stm32l47xxx-stm32l48xxx-stm32l49xxx-and-stm32l4axxx-advanced-armbased-32bit-mcus-stmicroelectronics.pdf

Anyway, I'll try to come up with a fix for the affected em485 drivers
by next week.  The "inverse" drivers with hardware-controlled RTS
should not be affected by d3b3404df318 (unless I'm missing something).

Thanks!

Lukas
