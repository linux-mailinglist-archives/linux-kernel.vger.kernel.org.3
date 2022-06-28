Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E3755D41F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344833AbiF1LDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 07:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244961AbiF1LDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:03:06 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B76CF02;
        Tue, 28 Jun 2022 04:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656414185; x=1687950185;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=tmcuaM74oHFDosztSfqtfVClZZM3GQ1qkVfJb8PuWl8=;
  b=miyeKzR21gn85GxE2Jn37OkKPtzPP8sO4G1/ZH3cNtWEDO5oFu+tt7ra
   yCupHW16nOy/QvH/QmNrNRn4sV4DcUbZi/YB+2c+FlNRzAGYlxmYVwpC2
   Vvnp7tUuDcSjTE42g3s4cOCCzGr+f9KKan+KiX8Lvbd4aqZxEmJ7w8eHK
   oYOYN9RBan6XF0HzyyesKX+1svJHbrw2Li4NnVVLWh/Gi5G4tGTV4J+Ah
   k6ZVX8l62csP12auTFsO55OERdiWG+x1b3ZYuIOV/Fd1A3Vg8Muf4ULbD
   Emua6ZSk5YiKpIDV6Xi73Fei2kGucNyyhDHddSf3EFFzSaDnHrvZiifG3
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="281747245"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="281747245"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 04:03:04 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="587832347"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 04:03:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o68zi-000wkW-MB;
        Tue, 28 Jun 2022 14:02:58 +0300
Date:   Tue, 28 Jun 2022 14:02:58 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: Re: [PATCH v9 1/6] serial: 8250: make saved LSR larger
Message-ID: <Yrrf4nYDhq//1OUD@smile.fi.intel.com>
References: <20220624204210.11112-1-ilpo.jarvinen@linux.intel.com>
 <20220624204210.11112-2-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220624204210.11112-2-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 11:42:05PM +0300, Ilpo Järvinen wrote:
> DW flags address received as BIT(8) in LSR. In order to not lose that
> on read, enlarge lsr_saved_flags to u16.
> 
> Adjust lsr/status variables and related call chains to use u16.
> Technically, some of these type conversion would not be needed but it
> doesn't hurt to be consistent.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/tty/serial/8250/8250.h         |  4 ++--
>  drivers/tty/serial/8250/8250_exar.c    |  2 +-
>  drivers/tty/serial/8250/8250_fsl.c     |  2 +-
>  drivers/tty/serial/8250/8250_ingenic.c |  2 +-
>  drivers/tty/serial/8250/8250_omap.c    |  7 +++----
>  drivers/tty/serial/8250/8250_port.c    | 17 +++++++++--------
>  include/linux/serial_8250.h            |  6 +++---
>  7 files changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
> index b120da57c61f..0ff5688ba90c 100644
> --- a/drivers/tty/serial/8250/8250.h
> +++ b/drivers/tty/serial/8250/8250.h
> @@ -133,9 +133,9 @@ static inline void serial_out(struct uart_8250_port *up, int offset, int value)
>   *
>   *	Returns LSR value or'ed with the preserved flags (if any).
>   */
> -static inline unsigned int serial_lsr_in(struct uart_8250_port *up)
> +static inline u16 serial_lsr_in(struct uart_8250_port *up)
>  {
> -	unsigned int lsr = up->lsr_saved_flags;
> +	u16 lsr = up->lsr_saved_flags;
>  
>  	lsr |= serial_in(up, UART_LSR);
>  	up->lsr_saved_flags = lsr & LSR_SAVE_FLAGS;
> diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
> index 528779b40049..3d999eec4087 100644
> --- a/drivers/tty/serial/8250/8250_exar.c
> +++ b/drivers/tty/serial/8250/8250_exar.c
> @@ -195,11 +195,11 @@ static int xr17v35x_startup(struct uart_port *port)
>  
>  static void exar_shutdown(struct uart_port *port)
>  {
> -	unsigned char lsr;
>  	bool tx_complete = false;
>  	struct uart_8250_port *up = up_to_u8250p(port);
>  	struct circ_buf *xmit = &port->state->xmit;
>  	int i = 0;
> +	u16 lsr;
>  
>  	do {
>  		lsr = serial_in(up, UART_LSR);
> diff --git a/drivers/tty/serial/8250/8250_fsl.c b/drivers/tty/serial/8250/8250_fsl.c
> index 9c01c531349d..fd4005fcd0d6 100644
> --- a/drivers/tty/serial/8250/8250_fsl.c
> +++ b/drivers/tty/serial/8250/8250_fsl.c
> @@ -25,8 +25,8 @@
>  
>  int fsl8250_handle_irq(struct uart_port *port)
>  {
> -	unsigned char lsr, orig_lsr;
>  	unsigned long flags;
> +	u16 lsr, orig_lsr;
>  	unsigned int iir;
>  	struct uart_8250_port *up = up_to_u8250p(port);
>  
> diff --git a/drivers/tty/serial/8250/8250_ingenic.c b/drivers/tty/serial/8250/8250_ingenic.c
> index cff91aa03f29..2b2f5d8d24b9 100644
> --- a/drivers/tty/serial/8250/8250_ingenic.c
> +++ b/drivers/tty/serial/8250/8250_ingenic.c
> @@ -54,7 +54,7 @@ static void early_out(struct uart_port *port, int offset, uint8_t value)
>  
>  static void ingenic_early_console_putc(struct uart_port *port, unsigned char c)
>  {
> -	uint8_t lsr;
> +	u16 lsr;
>  
>  	do {
>  		lsr = early_in(port, UART_LSR);
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> index ac8bfa042391..0dcecbbc3967 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -1115,8 +1115,7 @@ static bool handle_rx_dma(struct uart_8250_port *up, unsigned int iir)
>  	return omap_8250_rx_dma(up);
>  }
>  
> -static unsigned char omap_8250_handle_rx_dma(struct uart_8250_port *up,
> -					     u8 iir, unsigned char status)
> +static u16 omap_8250_handle_rx_dma(struct uart_8250_port *up, u8 iir, u16 status)
>  {
>  	if ((status & (UART_LSR_DR | UART_LSR_BI)) &&
>  	    (iir & UART_IIR_RDI)) {
> @@ -1130,7 +1129,7 @@ static unsigned char omap_8250_handle_rx_dma(struct uart_8250_port *up,
>  }
>  
>  static void am654_8250_handle_rx_dma(struct uart_8250_port *up, u8 iir,
> -				     unsigned char status)
> +				     u16 status)
>  {
>  	/*
>  	 * Queue a new transfer if FIFO has data.
> @@ -1164,7 +1163,7 @@ static int omap_8250_dma_handle_irq(struct uart_port *port)
>  {
>  	struct uart_8250_port *up = up_to_u8250p(port);
>  	struct omap8250_priv *priv = up->port.private_data;
> -	unsigned char status;
> +	u16 status;
>  	u8 iir;
>  
>  	serial8250_rpm_get(up);
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index c860f5964138..19c612d732cf 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1508,7 +1508,7 @@ static inline void __stop_tx(struct uart_8250_port *p)
>  	struct uart_8250_em485 *em485 = p->em485;
>  
>  	if (em485) {
> -		unsigned char lsr = serial_lsr_in(p);
> +		u16 lsr = serial_lsr_in(p);
>  		u64 stop_delay = 0;
>  
>  		if (!(lsr & UART_LSR_THRE))
> @@ -1565,7 +1565,7 @@ static inline void __start_tx(struct uart_port *port)
>  
>  	if (serial8250_set_THRI(up)) {
>  		if (up->bugs & UART_BUG_TXEN) {
> -			unsigned char lsr = serial_lsr_in(up);
> +			u16 lsr = serial_lsr_in(up);
>  
>  			if (lsr & UART_LSR_THRE)
>  				serial8250_tx_chars(up);
> @@ -1719,7 +1719,7 @@ static void serial8250_enable_ms(struct uart_port *port)
>  	serial8250_rpm_put(up);
>  }
>  
> -void serial8250_read_char(struct uart_8250_port *up, unsigned char lsr)
> +void serial8250_read_char(struct uart_8250_port *up, u16 lsr)
>  {
>  	struct uart_port *port = &up->port;
>  	unsigned char ch;
> @@ -1788,7 +1788,7 @@ EXPORT_SYMBOL_GPL(serial8250_read_char);
>   * (such as THRE) because the LSR value might come from an already consumed
>   * character.
>   */
> -unsigned char serial8250_rx_chars(struct uart_8250_port *up, unsigned char lsr)
> +u16 serial8250_rx_chars(struct uart_8250_port *up, u16 lsr)
>  {
>  	struct uart_port *port = &up->port;
>  	int max_count = 256;
> @@ -1908,10 +1908,10 @@ static bool handle_rx_dma(struct uart_8250_port *up, unsigned int iir)
>   */
>  int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
>  {
> -	unsigned char status;
>  	struct uart_8250_port *up = up_to_u8250p(port);
>  	bool skip_rx = false;
>  	unsigned long flags;
> +	u16 status;
>  
>  	if (iir & UART_IIR_NO_INT)
>  		return 0;
> @@ -1994,7 +1994,7 @@ static unsigned int serial8250_tx_empty(struct uart_port *port)
>  {
>  	struct uart_8250_port *up = up_to_u8250p(port);
>  	unsigned long flags;
> -	unsigned int lsr;
> +	u16 lsr;
>  
>  	serial8250_rpm_get(up);
>  
> @@ -2117,8 +2117,8 @@ static void wait_for_xmitr(struct uart_8250_port *up, int bits)
>  static int serial8250_get_poll_char(struct uart_port *port)
>  {
>  	struct uart_8250_port *up = up_to_u8250p(port);
> -	unsigned char lsr;
>  	int status;
> +	u16 lsr;
>  
>  	serial8250_rpm_get(up);
>  
> @@ -2173,8 +2173,9 @@ int serial8250_do_startup(struct uart_port *port)
>  {
>  	struct uart_8250_port *up = up_to_u8250p(port);
>  	unsigned long flags;
> -	unsigned char lsr, iir;
> +	unsigned char iir;
>  	int retval;
> +	u16 lsr;
>  
>  	if (!port->fifosize)
>  		port->fifosize = uart_config[port->type].fifo_size;
> diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
> index ff84a3ed10ea..4565f25ba9a2 100644
> --- a/include/linux/serial_8250.h
> +++ b/include/linux/serial_8250.h
> @@ -119,7 +119,7 @@ struct uart_8250_port {
>  	 * be immediately processed.
>  	 */
>  #define LSR_SAVE_FLAGS UART_LSR_BRK_ERROR_BITS
> -	unsigned char		lsr_saved_flags;
> +	u16			lsr_saved_flags;
>  #define MSR_SAVE_FLAGS UART_MSR_ANY_DELTA
>  	unsigned char		msr_saved_flags;
>  
> @@ -170,8 +170,8 @@ extern void serial8250_do_set_divisor(struct uart_port *port, unsigned int baud,
>  				      unsigned int quot_frac);
>  extern int fsl8250_handle_irq(struct uart_port *port);
>  int serial8250_handle_irq(struct uart_port *port, unsigned int iir);
> -unsigned char serial8250_rx_chars(struct uart_8250_port *up, unsigned char lsr);
> -void serial8250_read_char(struct uart_8250_port *up, unsigned char lsr);
> +u16 serial8250_rx_chars(struct uart_8250_port *up, u16 lsr);
> +void serial8250_read_char(struct uart_8250_port *up, u16 lsr);
>  void serial8250_tx_chars(struct uart_8250_port *up);
>  unsigned int serial8250_modem_status(struct uart_8250_port *up);
>  void serial8250_init_port(struct uart_8250_port *up);
> -- 
> 2.30.2
> 

-- 
With Best Regards,
Andy Shevchenko


