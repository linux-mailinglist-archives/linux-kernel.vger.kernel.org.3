Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0090C5B0054
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 11:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiIGJYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 05:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiIGJYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 05:24:02 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F5492F6A;
        Wed,  7 Sep 2022 02:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662542641; x=1694078641;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=JpKsKADH1rQTHje2jo2dXzK2ymAZXfmBxQpUVoLyhzo=;
  b=XmZMsJ5RGLKt07bT1AGVnFfZ8iX1ZoRn+g6/WjLAa87V7bM+aZwoZn5V
   K6R3tfrvS5MYptx7LtmR3+Gh5S749BmeDIW7fDC2nq+8UzxqdcWbSL114
   nX1ppn5Iyi/Lv3OiaTqSCCYgMWwFSfLFqZYrXoOVXixop60wSDZeqMZst
   iXLfX2O0a7kTyLIYc3s6F7iS+TqxRCcXXY6cHMqe0ee+WWMkbmFBGoxaP
   uOStiEFpqk7+Zpzkd8LokT7bYdnJhq3mZm1bTWL6eDqQIZ5dmKyjkwDNk
   QVfQCmn4Qr5Wpl3yf0FSE0H5w9PWbXTMH1kT3GcPehkV2zUZHhZ7H5p6q
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="323009239"
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="323009239"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 02:24:01 -0700
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="676097152"
Received: from dmatouse-mobl.ger.corp.intel.com ([10.251.223.53])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 02:23:56 -0700
Date:   Wed, 7 Sep 2022 12:23:55 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Sergiu Moga <sergiu.moga@microchip.com>
cc:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        richard.genoud@gmail.com, radu_nicolae.pirea@upb.ro,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        broonie@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        Jiri Slaby <jirislaby@kernel.org>, admin@hifiphile.com,
        kavyasree.kotagiri@microchip.com, tudor.ambarus@microchip.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, linux-spi@vger.kernel.org,
        linux-serial <linux-serial@vger.kernel.org>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 10/13] tty: serial: atmel: Only divide Clock Divisor
 if the IP is USART
In-Reply-To: <20220906135511.144725-11-sergiu.moga@microchip.com>
Message-ID: <6f7b4eb6-678a-dd4d-4927-31ae309ca49f@linux.intel.com>
References: <20220906135511.144725-1-sergiu.moga@microchip.com> <20220906135511.144725-11-sergiu.moga@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Sep 2022, Sergiu Moga wrote:

> Make sure that the driver only divides the clock divisor if the
> IP handled at that point is USART, since UART IP's do not support
> implicit peripheral clock division. Instead, in the case of UART,
> go with the highest possible clock divisor.
> 
> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
> ---
> 
> 
> v1 -> v2:
> - Nothing, this patch was not here before and is mainly meant as both cleanup
> and as a way to introduce a new field into struct atmel_uart_port that will be
> used by the last patch to diferentiate between USART and UART regarding the
> location of the Baudrate Clock Source bitmask.
> 
> 
> 
> 
>  drivers/tty/serial/atmel_serial.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 7450d3853031..6aa01ca5489c 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -150,6 +150,7 @@ struct atmel_uart_port {
>  	u32			rts_low;
>  	bool			ms_irq_enabled;
>  	u32			rtor;	/* address of receiver timeout register if it exists */
> +	bool			is_usart;
>  	bool			has_frac_baudrate;
>  	bool			has_hw_timer;
>  	struct timer_list	uart_timer;
> @@ -1825,6 +1826,7 @@ static void atmel_get_ip_name(struct uart_port *port)
>  	 */
>  	atmel_port->has_frac_baudrate = false;
>  	atmel_port->has_hw_timer = false;
> +	atmel_port->is_usart = false;
>  
>  	if (name == new_uart) {
>  		dev_dbg(port->dev, "Uart with hw timer");
> @@ -1834,6 +1836,7 @@ static void atmel_get_ip_name(struct uart_port *port)
>  		dev_dbg(port->dev, "Usart\n");
>  		atmel_port->has_frac_baudrate = true;
>  		atmel_port->has_hw_timer = true;
> +		atmel_port->is_usart = true;
>  		atmel_port->rtor = ATMEL_US_RTOR;
>  		version = atmel_uart_readl(port, ATMEL_US_VERSION);
>  		switch (version) {
> @@ -1863,6 +1866,7 @@ static void atmel_get_ip_name(struct uart_port *port)
>  			dev_dbg(port->dev, "This version is usart\n");
>  			atmel_port->has_frac_baudrate = true;
>  			atmel_port->has_hw_timer = true;
> +			atmel_port->is_usart = true;
>  			atmel_port->rtor = ATMEL_US_RTOR;
>  			break;
>  		case 0x203:
> @@ -2282,10 +2286,17 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
>  		cd = uart_get_divisor(port, baud);
>  	}
>  
> -	if (cd > 65535) {	/* BRGR is 16-bit, so switch to slower clock */
> +	/*
> +	 * BRGR is 16-bit, so switch to slower clock.
> +	 * Otherwise, keep the highest possible value for the clock divisor.
> +	 */
> +	if (atmel_port->is_usart && cd > 65535) {

Should this be cd > ATMEL_US_CD ?

>  		cd /= 8;
>  		mode |= ATMEL_US_USCLKS_MCK_DIV8;
> +	} else {
> +		cd &= 65535;

ATMEL_US_CD?

>  	}
> +
>  	quot = cd | fp << ATMEL_US_FP_OFFSET;
>  
>  	if (!(port->iso7816.flags & SER_ISO7816_ENABLED))
> 

-- 
 i.

