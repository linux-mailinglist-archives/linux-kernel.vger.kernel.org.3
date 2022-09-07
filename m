Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7045B009D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 11:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiIGJge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 05:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiIGJga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 05:36:30 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA748980B;
        Wed,  7 Sep 2022 02:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662543389; x=1694079389;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=tKw3aYgjO5ai6ZJTrD5+c07/ZCZv2dQ4amjcz1mH21A=;
  b=ixhGpUM1RP9CzCE4YKO5FpYO1IYSso6TJAjoRUQhmDYR0rGiGkcnndFI
   MbJgQwvwE/5Md9wo+HtQhjjxjgT+Sam9Fhl20M4e5k6gB43h9yvVJUR5e
   7Ei8BbSChyPlm9MIFfOhCO03prUBL6Hzm4WkvUUtlzcxvKoF1LLkDHCLN
   L+Ra1AmXEt6WFNJgLnciT9WmBBtb8QBt/eaoxMkTIQ3TipTM3ZAtSIY8G
   0fOl0eGnz9Yybl/tRNuPm7tIeyZc4GFSOqEvHVey62VXhAXWJEVeK/n6t
   c8ZsUm9RMyQN8bM7zJZ1hd6JTYO+ZnseWhlLaXXNp/QPieJdngVSp51V/
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="323011807"
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="323011807"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 02:36:29 -0700
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="676101846"
Received: from dmatouse-mobl.ger.corp.intel.com ([10.251.223.53])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 02:36:23 -0700
Date:   Wed, 7 Sep 2022 12:36:22 +0300 (EEST)
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
Subject: Re: [PATCH v2 12/13] tty: serial: atmel: Make the driver aware of
 the existence of GCLK
In-Reply-To: <20220906135511.144725-13-sergiu.moga@microchip.com>
Message-ID: <3f98d634-789-a0bd-84e-cfc2a1de70af@linux.intel.com>
References: <20220906135511.144725-1-sergiu.moga@microchip.com> <20220906135511.144725-13-sergiu.moga@microchip.com>
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

> Previously, the atmel serial driver did not take into account the
> possibility of using the more customizable generic clock as its
> baudrate generator. Unless there is a Fractional Part available to
> increase accuracy, there is a high chance that we may be able to
> generate a baudrate closer to the desired one by using the GCLK as the
> clock source. Now, depending on the error rate between
> the desired baudrate and the actual baudrate, the serial driver will
> fallback on the generic clock. The generic clock must be provided
> in the DT node of the serial that may need a more flexible clock source.
> 
> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
> ---
> 
> 
> 
> v1 -> v2:
> - take into account the different placement of the baudrate clock source
> into the IP's Mode Register (USART vs UART)
> - don't check for atmel_port->gclk != NULL
> - use clk_round_rate instead of clk_set_rate + clk_get_rate
> - remove clk_disable_unprepare from the end of the probe method
> 
> 
> 
>  drivers/tty/serial/atmel_serial.c | 52 ++++++++++++++++++++++++++++++-
>  1 file changed, 51 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 6aa01ca5489c..b2b6fd6ea2a5 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -15,6 +15,7 @@
>  #include <linux/init.h>
>  #include <linux/serial.h>
>  #include <linux/clk.h>
> +#include <linux/clk-provider.h>
>  #include <linux/console.h>
>  #include <linux/sysrq.h>
>  #include <linux/tty_flip.h>
> @@ -77,6 +78,8 @@ static void atmel_stop_rx(struct uart_port *port);
>  #endif
>  
>  #define ATMEL_ISR_PASS_LIMIT	256
> +#define ERROR_RATE(desired_value, actual_value) \
> +	((int)(100 - ((desired_value) * 100) / (actual_value)))

Make a function instead.

Is percent accurate enough or would you perhaps want something slightly 
more accurate?

Given you've abs() at the caller side, the error rate could be 
underestimated, is underestimating OK?

-- 
 i.

>  struct atmel_dma_buffer {
>  	unsigned char	*buf;
> @@ -110,6 +113,7 @@ struct atmel_uart_char {
>  struct atmel_uart_port {
>  	struct uart_port	uart;		/* uart */
>  	struct clk		*clk;		/* uart clock */
> +	struct clk		*gclk;		/* uart generic clock */
>  	int			may_wakeup;	/* cached value of device_may_wakeup for times we need to disable it */
>  	u32			backup_imr;	/* IMR saved during suspend */
>  	int			break_active;	/* break being received */
> @@ -2117,6 +2121,8 @@ static void atmel_serial_pm(struct uart_port *port, unsigned int state,
>  		 * This is called on uart_close() or a suspend event.
>  		 */
>  		clk_disable_unprepare(atmel_port->clk);
> +		if (__clk_is_enabled(atmel_port->gclk))
> +			clk_disable_unprepare(atmel_port->gclk);
>  		break;
>  	default:
>  		dev_err(port->dev, "atmel_serial: unknown pm %d\n", state);
> @@ -2131,7 +2137,8 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
>  {
>  	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
>  	unsigned long flags;
> -	unsigned int old_mode, mode, imr, quot, baud, div, cd, fp = 0;
> +	unsigned int old_mode, mode, imr, quot, div, cd, fp = 0;
> +	unsigned int baud, actual_baud, gclk_rate;
>  
>  	/* save the current mode register */
>  	mode = old_mode = atmel_uart_readl(port, ATMEL_US_MR);
> @@ -2297,6 +2304,43 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
>  		cd &= 65535;
>  	}
>  
> +	/*
> +	 * If there is no Fractional Part, there is a high chance that
> +	 * we may be able to generate a baudrate closer to the desired one
> +	 * if we use the GCLK as the clock source driving the baudrate
> +	 * generator.
> +	 */
> +	if (!atmel_port->has_frac_baudrate) {
> +		if (__clk_is_enabled(atmel_port->gclk))
> +			clk_disable_unprepare(atmel_port->gclk);
> +		gclk_rate = clk_round_rate(atmel_port->gclk, 16 * baud);
> +		actual_baud = clk_get_rate(atmel_port->clk) / (16 * cd);
> +		if (gclk_rate && abs(ERROR_RATE(baud, actual_baud)) >
> +		    abs(ERROR_RATE(baud, gclk_rate / 16))) {
> +			clk_set_rate(atmel_port->gclk, 16 * baud);
> +			if (!clk_prepare_enable(atmel_port->gclk)) {
> +				if (atmel_port->is_usart) {
> +					mode &= ~ATMEL_US_USCLKS;
> +					mode |= ATMEL_US_USCLKS_GCLK;
> +				} else {
> +					mode &= ~ATMEL_UA_BRSRCCK;
> +					mode |= ATMEL_UA_BRSRCCK_GCLK;
> +				}
> +
> +				/*
> +				 * Set the Clock Divisor for GCLK to 1.
> +				 * Since we were able to generate the smallest
> +				 * multiple of the desired baudrate times 16,
> +				 * then we surely can generate a bigger multiple
> +				 * with the exact error rate for an equally increased
> +				 * CD. Thus no need to take into account
> +				 * a higher value for CD.
> +				 */
> +				cd = 1;
> +			}
> +		}
> +	}
> +
>  	quot = cd | fp << ATMEL_US_FP_OFFSET;
>  
>  	if (!(port->iso7816.flags & SER_ISO7816_ENABLED))
> @@ -2892,6 +2936,12 @@ static int atmel_serial_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err;
>  
> +	atmel_port->gclk = devm_clk_get_optional(&pdev->dev, "gclk");
> +	if (IS_ERR(atmel_port->gclk)) {
> +		ret = PTR_ERR(atmel_port->gclk);
> +		goto err;
> +	}
> +
>  	ret = atmel_init_port(atmel_port, pdev);
>  	if (ret)
>  		goto err_clk_disable_unprepare;
> 
