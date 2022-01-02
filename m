Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9383A482AB2
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 11:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbiABKHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 05:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbiABKHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 05:07:15 -0500
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219A1C061574;
        Sun,  2 Jan 2022 02:07:13 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 14395100DA1A7;
        Sun,  2 Jan 2022 11:07:11 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id E21914A82A; Sun,  2 Jan 2022 11:07:10 +0100 (CET)
Date:   Sun, 2 Jan 2022 11:07:10 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     jmades <jochen@mades.net>
Cc:     gregkh@linuxfoundation.org, Russell King <linux@armlinux.org.uk>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Philipp Rosenberger <p.rosenberger@kunbus.com>
Subject: Re: [PATCH] Bugfix RTS line config in RS485 mode is overwritten in
 pl011_set_mctrl() function.
Message-ID: <20220102100710.GA29858@wunner.de>
References: <20211231171516.18407-1-jochen@mades.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211231171516.18407-1-jochen@mades.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 31, 2021 at 05:15:14PM +0000, jmades wrote:
> Based on the "0001-serial-amba-pl011-add-RS485-support.patch" this change is necesarry otherwise the RTS-line will be pulled up in SER_RS485_RTS_BEFORE_SEND mode before sending data. This hinders the driver to receive data, f.ex. when the device is an RS485 slave device.
> 
> Signed-off-by: jmades <jochen@mades.net>

Patch is correct, but commit message could be improved:

* Subject should be in imperative mood (by convention), it should be
  prepended by "serial: pl011: " (in line with previous commits touching
  this driver, use "git log --oneline amba-pl011.c") and the trailing dot
  is unnecessary, e.g.:

  "serial: pl011: Fix incorrect rs485 RTS polarity on set_mctrl"

* Commit message should be wrapped at 72 characters (so that it appears
  centered when displayed with "git log" on an 80 chars terminal).
  The reference to "0001-serial-amba-pl011-add-RS485-support.patch"
  should be replaced with a reference to the offending commit, e.g.:

  "Commit 8d479237727c ("serial: amba-pl011: add RS485 support") sought
  to keep RTS deasserted on set_mctrl if rs485 is enabled.  However it
  did so only if deasserted RTS polarity is high.  Fix it in case it's
  low."

  Feel free to copy this to a v2 of your patch and amend as you see fit.

* Add tags for the offending commit:

  Fixes: 8d479237727c ("serial: amba-pl011: add RS485 support")
  Cc: stable@vger.kernel.org # v5.15+

* Be sure to cc the author of the offending commit.

Thanks,

Lukas

> ---
>  drivers/tty/serial/amba-pl011.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 537f37ac4..1749c1498 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -1646,8 +1646,12 @@ static void pl011_set_mctrl(struct uart_port *port, unsigned int mctrl)
>  	    container_of(port, struct uart_amba_port, port);
>  	unsigned int cr;
>  
> -	if (port->rs485.flags & SER_RS485_ENABLED)
> -		mctrl &= ~TIOCM_RTS;
> +	if (port->rs485.flags & SER_RS485_ENABLED) {
> +		if (port->rs485.flags & SER_RS485_RTS_AFTER_SEND)
> +			mctrl &= ~TIOCM_RTS;
> +		else
> +			mctrl |= TIOCM_RTS;
> +	}
>  
>  	cr = pl011_read(uap, REG_CR);
