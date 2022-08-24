Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A2059F8F6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 14:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236618AbiHXMCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 08:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236657AbiHXMCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 08:02:43 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DA432D99;
        Wed, 24 Aug 2022 05:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661342561; x=1692878561;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=CrWyZLJD2SRdNlJrJZciJFk6p2Q2ugSTZKjZU9gzjJ4=;
  b=nawCodA2IvAmgPyxTUNGTRJjZgxk9n43KY+CAw9shzjvMc+Ak4OubF3I
   Bqnjz46iIAyY0OQ07xikid/4El63IjPddgvBQVweWHQssHotbs2XCebqO
   K4gYBaB0hQoNShZ7Z/f+Ir+CXxx+PwyDBqx4B1iDQ7JKTkps7bTMADwtJ
   j8g5lHZaXGsSxUD+O6mqaKyVLeQL+nk+CQiFF2Mm0l0jNUu8x+jWxBArP
   o5SQoVVL+DdG3/BoMAfPha+TfNmxTqzktG11zEL190byq4UtIejHK2Ogx
   ZBoZmzphUarYk9uDzNshEOFTs5HcL3+7noUy2HtrKooPXUgqQ8WtyRvb1
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="355672888"
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="355672888"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 05:02:41 -0700
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="670474495"
Received: from cdenk-mobl.ger.corp.intel.com ([10.252.40.24])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 05:02:36 -0700
Date:   Wed, 24 Aug 2022 15:02:30 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Sergiu Moga <sergiu.moga@microchip.com>
cc:     richard.genoud@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        rmk+kernel@arm.linux.org.uk, claudio@evidence.eu.com, rick@efn.org,
        michael@evidence.eu.com, ryan@bluewatersys.com,
        linux-serial <linux-serial@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tty: serial: atmel: Preserve previous USART mode if
 RS485 disabled
In-Reply-To: <20220824114255.444655-1-sergiu.moga@microchip.com>
Message-ID: <2cab23a2-7a82-9321-dca1-5c7c71484ad@linux.intel.com>
References: <20220824114255.444655-1-sergiu.moga@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-121819602-1661342560=:1558"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-121819602-1661342560=:1558
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Wed, 24 Aug 2022, Sergiu Moga wrote:

> Whenever the atmel_rs485_config driver method would be called,
> the USART mode is reset to normal mode before even checking if
> RS485 flag is set, thus resulting in losing the previous USART
> mode in the case where the checking fails. Some tools, such as
> `linux-serial-test`, lead to the driver calling this method
> when doing the setup of the serial port: after setting the port
> mode (Hardware Flow Control, Normal Mode, RS485 Mode, etc.),
> `linux-serial-test` tries to enable/disable RS485 depending on
> the commandline arguments passed. If we were to, for example, enable
> Hardware Flow Control through `linux-serial-test`, the tool would
> make the driver set the corresponding bit to 1 (ATMEL_US_USMODE_HWHS
> bit in the ATMEL_US_MR register) through the atmel_set_termios method
> and then proceed to disabling RS485. This, in turn, causes the
> ATMEL_US_USMODE_HWHS bit of the ATMEL_US_MR mode register to be unset
> and, if the checking for RS485 fails, leads to having the mode set
> back to the ATMEL_US_USMODE_NORMAL normal mode. Since in hardware
> flow control mode the meanings of the ATMEL_US_RTSDIS and
> ATMEL_US_RTSEN bits are swapped, this leads to our endpoint leaving
> the RTS line to high when wanting to receive, which is the opposite
> of what the other endpoint is expecting in order to start transmitting.
> This fix ensures that this reset is done only if the checking for RS485
> succeeds.

Could you please try to split this long paragraph to a slightly shorter 
bits such that it would be easier to read.

> Fixes: e8faff7330a35 ("ARM: 6092/1: atmel_serial: support for RS485 communications")
> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
> ---
>  drivers/tty/serial/atmel_serial.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 0a0b46ee0955..c29b1fb48694 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -298,9 +298,6 @@ static int atmel_config_rs485(struct uart_port *port, struct ktermios *termios,
>  
>  	mode = atmel_uart_readl(port, ATMEL_US_MR);
>  
> -	/* Resetting serial mode to RS232 (0x0) */
> -	mode &= ~ATMEL_US_USMODE;
> -
>  	if (rs485conf->flags & SER_RS485_ENABLED) {
>  		dev_dbg(port->dev, "Setting UART to RS485\n");
>  		if (rs485conf->flags & SER_RS485_RX_DURING_TX)
> @@ -310,6 +307,7 @@ static int atmel_config_rs485(struct uart_port *port, struct ktermios *termios,
>  
>  		atmel_uart_writel(port, ATMEL_US_TTGR,
>  				  rs485conf->delay_rts_after_send);
> +		mode &= ~ATMEL_US_USMODE;
>  		mode |= ATMEL_US_USMODE_RS485;
>  	} else {
>  		dev_dbg(port->dev, "Setting UART to RS232\n");
> 

Makes sense.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Unrelated to this patch but I came across it while reviewing yours... Do 
you BTW have any idea why atmel_serial_probe() sets ATMEL_US_USMODE_NORMAL 
inside rs485_enabled block? I'd have expected it wanted to do 
ATMEL_US_USMODE_RS485 there too like is done in atmel_config_rs485().


-- 
 i.

--8323329-121819602-1661342560=:1558--
