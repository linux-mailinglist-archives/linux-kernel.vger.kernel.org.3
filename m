Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C114CED59
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 20:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbiCFTWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 14:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiCFTW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 14:22:29 -0500
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D3D58E77;
        Sun,  6 Mar 2022 11:21:36 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 8DFB93000FD66;
        Sun,  6 Mar 2022 20:21:35 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 553A155BE5; Sun,  6 Mar 2022 20:21:35 +0100 (CET)
Date:   Sun, 6 Mar 2022 20:21:35 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Eric Tremblay <etremblay@distech-controls.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, heiko@sntech.de,
        giulio.benetti@micronovasrl.com
Subject: Re: [RFC PATCH 3/7] serial: 8250_dwlib: Implement SW half duplex
 support
Message-ID: <20220306192135.GC19394@wunner.de>
References: <20220302095606.14818-1-ilpo.jarvinen@linux.intel.com>
 <20220302095606.14818-4-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220302095606.14818-4-ilpo.jarvinen@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 11:56:02AM +0200, Ilpo Järvinen wrote:
> This patch enables support for SW half-duplex mode. Synopsys
> DesignWare UART has a build-in support for the RS485 protocol
> from IP version 4.0 onward with dedicated RE/DE_EN registers.
> This patch enables RS485 either using dedicated registers or
> em485 as fallback.
> 
> In order to select preference for SW half-duplex mode (em485 +
> RE/DE_EN) over HW managed one, as both are supported under
> some configurations, SER_RS485_SW_RX_OR_TX flag is added to
> serial_rs485.
> 
> This patch depends on UART_CAP_NOTEMT which is not provided
> by this series but another one:
>   https://lore.kernel.org/all/20210204161158.643-1-etremblay@distech-controls.com/

I don't see any benefit in using software emulated RTS assertion
if hardware support is present.  It just consumes more CPU time
and is slower to deassert RTS, thereby increasing bus turn-around time.

So if hardware support is present, I think you always want to
use that and you need to fallback to software emulation only
if hardware support is missing (i.e. on IP versions < 4).

The registers you're using here, DW_UART_RE_EN and DW_UART_DE_EN
don't seem to be present on older IP versions.  I'm looking at
the databook for version 3.04a and those registers aren't mentioned:

https://linux-sunxi.org/images/d/d2/Dw_apb_uart_db.pdf

So the software emulation you've implemented here won't help with
older IP and the newer IP doesn't need it because it supports
RTS assertion in hardware.  Is that correct?  If so, I'd suggest
not supporting DW_UART_TCR_XFER_MODE_SW_DE_OR_RE at all.

A number of people have attempted to add rs485 software emulation
to 8250_dw.c but noone ever pursued it into mainline.  The last
attempt was by Heiko Stübner, who used patches by Giulio Benetti (+cc):

https://lore.kernel.org/linux-serial/20200517215610.2131618-1-heiko@sntech.de/

FWIW, newer TI Sitara SoCs have also added hardware support for
rs485 and in this (not yet upstreamed) patch, I likewise chose
to use software emulation only if hardware support is not available:

https://github.com/l1k/linux/commit/82c989617a05

Thanks,

Lukas
