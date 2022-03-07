Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B3F4CF215
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 07:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbiCGGmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 01:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiCGGmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 01:42:15 -0500
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941A622B3F;
        Sun,  6 Mar 2022 22:41:20 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id qx21so29593468ejb.13;
        Sun, 06 Mar 2022 22:41:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=w7AhWoK6FaFeo0ankE4ro2FLIhca/LPgPQ4m12g4JkE=;
        b=jge2W13x1acKtcobhS7X9tbl8rrgvA2XL7vcrRN2Brl9dbmHT/X3nqPZOYfsTTU8Ec
         Hmzr9oG6o6wyEy3FSzfRRSKyT3Gwn7aa9vN1TpvERRfKuBCtNMAUHaXiRIen9a2xa+qJ
         eLqkO1HxR+P8QimPAGgqdRIddShlks2ZFV3A/bxTnqWeKpnr9Ah6c5rQXRsYJApi2C0a
         CMKd5QjFLJx4Chs5Hu0BTTl7OiVFqucJKc53xOklVcdHBbEVgwAd5XIB/bwrf9Dcnwou
         u0wEQvRA86RZLH/GPVgieJqhY9mUl/3T1GW3gyScdLnsy9yFtFcNnVAScvAs1eMMGIMx
         3vvQ==
X-Gm-Message-State: AOAM530v+Sx9VnROxvVJlO+CxP0OCSwlHMi43eCTkXI3LlS8LSMcmyeh
        fQIoJkkMslYsTcB745NFTYo=
X-Google-Smtp-Source: ABdhPJwcyvksUmb5yXRXUAci1GuZgvQOyx9bSys5o8xmG1dpyqKy2z0ELjX7N3EJE4oZLfiRozxaTA==
X-Received: by 2002:a17:907:c16:b0:6db:1dfc:ca73 with SMTP id ga22-20020a1709070c1600b006db1dfcca73mr3638521ejc.192.1646635279091;
        Sun, 06 Mar 2022 22:41:19 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id l20-20020a1709066b9400b006dabdbc8350sm3138104ejr.30.2022.03.06.22.41.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Mar 2022 22:41:18 -0800 (PST)
Message-ID: <ea609e2e-a61c-f5d5-26c7-1dacc99406c0@kernel.org>
Date:   Mon, 7 Mar 2022 07:41:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 6/7] tty: serial: samsung: constify variables and pointers
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220304080348.218581-1-krzysztof.kozlowski@canonical.com>
 <20220304080348.218581-6-krzysztof.kozlowski@canonical.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220304080348.218581-6-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04. 03. 22, 9:03, Krzysztof Kozlowski wrote:
> Constify variables, data pointed by several pointers and
> "udivslot_table" static array.  This makes code a bit safer.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> ---
>   drivers/tty/serial/samsung_tty.c | 38 ++++++++++++++++----------------
>   1 file changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index eecefff5c4a4..00e7c34fad46 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -164,7 +164,7 @@ static void s3c24xx_serial_tx_chars(struct s3c24xx_uart_port *ourport);
>   #define portaddrl(port, reg) \
>   	((unsigned long *)(unsigned long)((port)->membase + (reg)))
>   
> -static u32 rd_reg(struct uart_port *port, u32 reg)
> +static u32 rd_reg(const struct uart_port *port, u32 reg)
>   {
>   	switch (port->iotype) {
>   	case UPIO_MEM:
> @@ -179,7 +179,7 @@ static u32 rd_reg(struct uart_port *port, u32 reg)
>   
>   #define rd_regl(port, reg) (readl_relaxed(portaddr(port, reg)))
>   
> -static void wr_reg(struct uart_port *port, u32 reg, u32 val)
> +static void wr_reg(const struct uart_port *port, u32 reg, u32 val)
>   {
>   	switch (port->iotype) {
>   	case UPIO_MEM:
> @@ -195,7 +195,7 @@ static void wr_reg(struct uart_port *port, u32 reg, u32 val)
>   
>   /* Byte-order aware bit setting/clearing functions. */
>   
> -static inline void s3c24xx_set_bit(struct uart_port *port, int idx,
> +static inline void s3c24xx_set_bit(const struct uart_port *port, int idx,
>   				   unsigned int reg)
>   {
>   	unsigned long flags;
> @@ -208,7 +208,7 @@ static inline void s3c24xx_set_bit(struct uart_port *port, int idx,
>   	local_irq_restore(flags);
>   }
>   
> -static inline void s3c24xx_clear_bit(struct uart_port *port, int idx,
> +static inline void s3c24xx_clear_bit(const struct uart_port *port, int idx,
>   				     unsigned int reg)
>   {
>   	unsigned long flags;
> @@ -221,19 +221,19 @@ static inline void s3c24xx_clear_bit(struct uart_port *port, int idx,
>   	local_irq_restore(flags);
>   }
>   
> -static inline struct s3c24xx_uart_port *to_ourport(const struct uart_port *port)
> +static inline struct s3c24xx_uart_port *to_ourport(struct uart_port *port)
>   {
>   	return container_of(port, struct s3c24xx_uart_port, port);
>   }
>   
>   /* translate a port to the device name */
>   
> -static inline const char *s3c24xx_serial_portname(struct uart_port *port)
> +static inline const char *s3c24xx_serial_portname(const struct uart_port *port)
>   {
>   	return to_platform_device(port->dev)->name;
>   }
>   
> -static int s3c24xx_serial_txempty_nofifo(struct uart_port *port)
> +static int s3c24xx_serial_txempty_nofifo(const struct uart_port *port)
>   {
>   	return rd_regl(port, S3C2410_UTRSTAT) & S3C2410_UTRSTAT_TXE;
>   }
> @@ -358,7 +358,7 @@ static void s3c24xx_serial_tx_dma_complete(void *args)
>   
>   static void enable_tx_dma(struct s3c24xx_uart_port *ourport)
>   {
> -	struct uart_port *port = &ourport->port;
> +	const struct uart_port *port = &ourport->port;
>   	u32 ucon;
>   
>   	/* Mask Tx interrupt */
> @@ -387,7 +387,7 @@ static void enable_tx_dma(struct s3c24xx_uart_port *ourport)
>   
>   static void enable_tx_pio(struct s3c24xx_uart_port *ourport)
>   {
> -	struct uart_port *port = &ourport->port;
> +	const struct uart_port *port = &ourport->port;
>   	u32 ucon, ufcon;
>   
>   	/* Set ufcon txtrig */
> @@ -580,9 +580,9 @@ static inline const struct s3c24xx_uart_info
>   }
>   
>   static inline const struct s3c2410_uartcfg
> -	*s3c24xx_port_to_cfg(struct uart_port *port)
> +	*s3c24xx_port_to_cfg(const struct uart_port *port)
>   {
> -	struct s3c24xx_uart_port *ourport;
> +	const struct s3c24xx_uart_port *ourport;
>   
>   	if (port->dev == NULL)
>   		return NULL;
> @@ -591,7 +591,7 @@ static inline const struct s3c2410_uartcfg
>   	return ourport->cfg;
>   }
>   
> -static int s3c24xx_serial_rx_fifocnt(struct s3c24xx_uart_port *ourport,
> +static int s3c24xx_serial_rx_fifocnt(const struct s3c24xx_uart_port *ourport,
>   				     unsigned long ufstat)
>   {
>   	const struct s3c24xx_uart_info *info = ourport->info;
> @@ -947,8 +947,8 @@ static irqreturn_t s3c24xx_serial_tx_irq(int irq, void *id)
>   /* interrupt handler for s3c64xx and later SoC's.*/
>   static irqreturn_t s3c64xx_serial_handle_irq(int irq, void *id)
>   {
> -	struct s3c24xx_uart_port *ourport = id;
> -	struct uart_port *port = &ourport->port;
> +	const struct s3c24xx_uart_port *ourport = id;
> +	const struct uart_port *port = &ourport->port;
>   	unsigned int pend = rd_regl(port, S3C64XX_UINTP);
>   	irqreturn_t ret = IRQ_HANDLED;
>   
> @@ -966,8 +966,8 @@ static irqreturn_t s3c64xx_serial_handle_irq(int irq, void *id)
>   /* interrupt handler for Apple SoC's.*/
>   static irqreturn_t apple_serial_handle_irq(int irq, void *id)
>   {
> -	struct s3c24xx_uart_port *ourport = id;
> -	struct uart_port *port = &ourport->port;
> +	const struct s3c24xx_uart_port *ourport = id;
> +	const struct uart_port *port = &ourport->port;
>   	unsigned int pend = rd_regl(port, S3C2410_UTRSTAT);
>   	irqreturn_t ret = IRQ_NONE;
>   
> @@ -1499,7 +1499,7 @@ static unsigned int s3c24xx_serial_getclk(struct s3c24xx_uart_port *ourport,
>    * This table takes the fractional value of the baud divisor and gives
>    * the recommended setting for the UDIVSLOT register.
>    */
> -static u16 udivslot_table[16] = {
> +static const u16 udivslot_table[16] = {
>   	[0] = 0x0000,
>   	[1] = 0x0080,
>   	[2] = 0x0808,
> @@ -1675,7 +1675,7 @@ static void s3c24xx_serial_set_termios(struct uart_port *port,
>   
>   static const char *s3c24xx_serial_type(struct uart_port *port)
>   {
> -	struct s3c24xx_uart_port *ourport = to_ourport(port);
> +	const struct s3c24xx_uart_port *ourport = to_ourport(port);
>   
>   	switch (ourport->info->type) {
>   	case TYPE_S3C24XX:
> @@ -2450,7 +2450,7 @@ s3c24xx_port_configured(unsigned int ucon)
>   
>   static int s3c24xx_serial_get_poll_char(struct uart_port *port)
>   {
> -	struct s3c24xx_uart_port *ourport = to_ourport(port);
> +	const struct s3c24xx_uart_port *ourport = to_ourport(port);
>   	unsigned int ufstat;
>   
>   	ufstat = rd_regl(port, S3C2410_UFSTAT);


-- 
js
suse labs
