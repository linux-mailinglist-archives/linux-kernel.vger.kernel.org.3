Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79ADE55A909
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 12:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbiFYKkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 06:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbiFYKkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 06:40:23 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079D313F90;
        Sat, 25 Jun 2022 03:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656153623; x=1687689623;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=AVgIL2E9QEAvAwfWoBXfauto0LB7PQrrTcs8Zw/nbNA=;
  b=ayG0qF1AhtB8wQpRZ+PbtLpuiH0srWlnGqD00I1vlUTmr5GN/LM/2puy
   6qo339oqvuwD0887Zd7wvDqbgPKbPGTZhEyC3CLaR7rlNQKpxEHudwYeS
   5ITTk9+KUpqwGlM7tr2vjWPoqBcWQdLXbi1jiGHMWX0kMf+5G9yJAt36N
   X+zWKyNmDSucY5cGLNKVeUKRE3h5YQRctSi4xzWuPCQXPfzsWwaKGcDhC
   991oRFdWT84YdAi1UWnqPgK1mu+hAMesnheb8yPiGCb7IlMeFowlpQspL
   RGY42l1oT2LYyy63fKibcsDMgzKOBIjnz62mbruoVFQJiXU8DKeJg9wVh
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="342861243"
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; 
   d="scan'208";a="342861243"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 03:40:22 -0700
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; 
   d="scan'208";a="645655106"
Received: from selvaku-mobl.ger.corp.intel.com ([10.252.60.244])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 03:40:18 -0700
Date:   Sat, 25 Jun 2022 13:40:16 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        vz@mleia.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lukas@wunner.de,
        p.rosenberger@kunbus.com, Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH 2/8] serial: core, 8250: set RS485 termination gpio in
 serial core
In-Reply-To: <20220622154659.8710-3-LinoSanfilippo@gmx.de>
Message-ID: <83762813-70ec-93c3-4015-5676ce9534fd@linux.intel.com>
References: <20220622154659.8710-1-LinoSanfilippo@gmx.de> <20220622154659.8710-3-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jun 2022, Lino Sanfilippo wrote:

> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> In serial8250_em485_config() the termination GPIO is set with the uart_port
> spinlock held. This is an issue if setting the GPIO line can sleep (e.g.
> since the concerning GPIO expander is connected via SPI or I2C).
> 
> Fix this by setting the termination line outside of the uart_port spinlock
> in the serial core.
> 
> This also makes setting the termination GPIO generic for all uart drivers.
> 
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> ---
>  drivers/tty/serial/8250/8250_port.c |  3 ---
>  drivers/tty/serial/serial_core.c    | 12 ++++++++++++
>  2 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 3e3d784aa628..5245c179cc51 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -675,9 +675,6 @@ int serial8250_em485_config(struct uart_port *port, struct serial_rs485 *rs485)
>  		rs485->flags &= ~SER_RS485_RTS_AFTER_SEND;
>  	}
>  
> -	gpiod_set_value(port->rs485_term_gpio,
> -			rs485->flags & SER_RS485_TERMINATE_BUS);
> -
>  	/*
>  	 * Both serial8250_em485_init() and serial8250_em485_destroy()
>  	 * are idempotent.
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 015f4e1da647..b387376e6fa2 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1352,12 +1352,23 @@ static void uart_sanitize_serial_rs485(struct uart_port *port, struct serial_rs4
>  	memset(rs485->padding, 0, sizeof(rs485->padding));
>  }
>  
> +static void uart_set_rs485_termination(struct uart_port *port,
> +				       const struct serial_rs485 *rs485)
> +{
> +	if (!port->rs485_term_gpio || !(rs485->flags & SER_RS485_ENABLED))
> +		return;
> +
> +	gpiod_set_value_cansleep(port->rs485_term_gpio,
> +				 !!(rs485->flags & SER_RS485_TERMINATE_BUS));
> +}
> +
>  int uart_rs485_config(struct uart_port *port)
>  {
>  	struct serial_rs485 *rs485 = &port->rs485;
>  	int ret;
>  
>  	uart_sanitize_serial_rs485(port, rs485);
> +	uart_set_rs485_termination(port, rs485);
>  
>  	ret = port->rs485_config(port, rs485);
>  	if (ret)
> @@ -1400,6 +1411,7 @@ static int uart_set_rs485_config(struct uart_port *port,
>  	if (ret)
>  		return ret;
>  	uart_sanitize_serial_rs485(port, &rs485);
> +	uart_set_rs485_termination(port, &rs485);
>  
>  	spin_lock_irqsave(&port->lock, flags);
>  	ret = port->rs485_config(port, &rs485);

When port->rs485_config(port, &rs485) returns non-zero, the input got 
partially applied?


-- 
 i.

