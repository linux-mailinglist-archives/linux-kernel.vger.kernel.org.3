Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F71557309
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 08:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiFWGYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 02:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiFWGYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 02:24:36 -0400
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE9B1F2F3;
        Wed, 22 Jun 2022 23:24:34 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id z19so10184629edb.11;
        Wed, 22 Jun 2022 23:24:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LAvZX/HQkXO+elF8yokNflr5QirVV5UEMq0oc8yUmpE=;
        b=H1QCGFAiKimL121wWL7ryTlUzVoy18ZZo3ogiU97f2XBKIP1gT7+BfV+JrJ8SG6ddx
         +QWf7TOYL29iZXfZ4YE9KXE0PiGC5R8NREQfQEAT9ca3Wj/3FZcjlPSTrMFCju0y4kP7
         jTW6DPoahiDSIE7luo3aLAqDdH8yRutlMSRLTJArI6F5elUFe9IhURLEEdzVHxahOQ+N
         EjBmT12wFFbfNRtUOmcHuJWVZLo7QTuHBx9UAS/0S2lCHlbZV+qKcDIKOUp+XPHuRvtv
         EHoUIguLSpWragDO7l11nrq3w/DT5vtfqIGvJEzufO7xXQI5QNRhgqZfUReVcqiVe0cG
         72Xw==
X-Gm-Message-State: AJIora/EcFNa2Lrhjih4T/99Ry10ot0ISgloPoHl26rWG2UiMCu5PbUf
        bYwxVia7I81h5/me1mlq2io=
X-Google-Smtp-Source: AGRyM1tXK+zbk/q7v6rZQSSUdcFgCIHc2bT1UPKLfaDfqrsExbpJ5FIF9I+SeCqIjTwcP9jNNt1zeQ==
X-Received: by 2002:a50:9f6a:0:b0:435:5804:e07 with SMTP id b97-20020a509f6a000000b0043558040e07mr8785271edf.178.1655965473018;
        Wed, 22 Jun 2022 23:24:33 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id r1-20020a170906280100b006fefd1d5c2bsm10374858ejc.148.2022.06.22.23.24.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 23:24:32 -0700 (PDT)
Message-ID: <469ba743-69bd-b322-9e14-2f15cd1f9bda@kernel.org>
Date:   Thu, 23 Jun 2022 08:24:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 1/6] serial: msm: Convert container_of UART_TO_MSM to
 static inline
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220621124958.3342-1-ilpo.jarvinen@linux.intel.com>
 <20220621124958.3342-2-ilpo.jarvinen@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220621124958.3342-2-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21. 06. 22, 14:49, Ilpo Järvinen wrote:
> Create static inline instead of define.

I know it's obvious, but next time, it would be nice if you specify why 
you're doing things, not what you're doing. I.e. amending something 
like: ", because it's more obvious, type safer, much more readable, and 
avoids bad macro expansion -- uart_port can "escape" as it is not in 
parentheses."

> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> ---
>   drivers/tty/serial/msm_serial.c | 49 +++++++++++++++++----------------
>   1 file changed, 26 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
> index e676ec761f18..15cab9c4b295 100644
> --- a/drivers/tty/serial/msm_serial.c
> +++ b/drivers/tty/serial/msm_serial.c
> @@ -181,7 +181,10 @@ struct msm_port {
>   	struct msm_dma		rx_dma;
>   };
>   
> -#define UART_TO_MSM(uart_port)	container_of(uart_port, struct msm_port, uart)
> +static inline struct msm_port *to_msm_port(struct uart_port *up)
> +{
> +	return container_of(up, struct msm_port, uart);
> +}
>   
>   static
>   void msm_write(struct uart_port *port, unsigned int val, unsigned int off)
> @@ -221,7 +224,7 @@ static void msm_serial_set_mnd_regs_tcxoby4(struct uart_port *port)
>   
>   static void msm_serial_set_mnd_regs(struct uart_port *port)
>   {
> -	struct msm_port *msm_port = UART_TO_MSM(port);
> +	struct msm_port *msm_port = to_msm_port(port);
>   
>   	/*
>   	 * These registers don't exist so we change the clk input rate
> @@ -404,7 +407,7 @@ static inline void msm_wait_for_xmitr(struct uart_port *port)
>   
>   static void msm_stop_tx(struct uart_port *port)
>   {
> -	struct msm_port *msm_port = UART_TO_MSM(port);
> +	struct msm_port *msm_port = to_msm_port(port);
>   
>   	msm_port->imr &= ~UART_IMR_TXLEV;
>   	msm_write(port, msm_port->imr, UART_IMR);
> @@ -412,7 +415,7 @@ static void msm_stop_tx(struct uart_port *port)
>   
>   static void msm_start_tx(struct uart_port *port)
>   {
> -	struct msm_port *msm_port = UART_TO_MSM(port);
> +	struct msm_port *msm_port = to_msm_port(port);
>   	struct msm_dma *dma = &msm_port->tx_dma;
>   
>   	/* Already started in DMA mode */
> @@ -690,7 +693,7 @@ static void msm_start_rx_dma(struct msm_port *msm_port)
>   
>   static void msm_stop_rx(struct uart_port *port)
>   {
> -	struct msm_port *msm_port = UART_TO_MSM(port);
> +	struct msm_port *msm_port = to_msm_port(port);
>   	struct msm_dma *dma = &msm_port->rx_dma;
>   
>   	msm_port->imr &= ~(UART_IMR_RXLEV | UART_IMR_RXSTALE);
> @@ -702,7 +705,7 @@ static void msm_stop_rx(struct uart_port *port)
>   
>   static void msm_enable_ms(struct uart_port *port)
>   {
> -	struct msm_port *msm_port = UART_TO_MSM(port);
> +	struct msm_port *msm_port = to_msm_port(port);
>   
>   	msm_port->imr |= UART_IMR_DELTA_CTS;
>   	msm_write(port, msm_port->imr, UART_IMR);
> @@ -714,7 +717,7 @@ static void msm_handle_rx_dm(struct uart_port *port, unsigned int misr)
>   	struct tty_port *tport = &port->state->port;
>   	unsigned int sr;
>   	int count = 0;
> -	struct msm_port *msm_port = UART_TO_MSM(port);
> +	struct msm_port *msm_port = to_msm_port(port);
>   
>   	if ((msm_read(port, UART_SR) & UART_SR_OVERRUN)) {
>   		port->icount.overrun++;
> @@ -837,7 +840,7 @@ static void msm_handle_rx(struct uart_port *port)
>   static void msm_handle_tx_pio(struct uart_port *port, unsigned int tx_count)
>   {
>   	struct circ_buf *xmit = &port->state->xmit;
> -	struct msm_port *msm_port = UART_TO_MSM(port);
> +	struct msm_port *msm_port = to_msm_port(port);
>   	unsigned int num_chars;
>   	unsigned int tf_pointer = 0;
>   	void __iomem *tf;
> @@ -883,7 +886,7 @@ static void msm_handle_tx_pio(struct uart_port *port, unsigned int tx_count)
>   
>   static void msm_handle_tx(struct uart_port *port)
>   {
> -	struct msm_port *msm_port = UART_TO_MSM(port);
> +	struct msm_port *msm_port = to_msm_port(port);
>   	struct circ_buf *xmit = &msm_port->uart.state->xmit;
>   	struct msm_dma *dma = &msm_port->tx_dma;
>   	unsigned int pio_count, dma_count, dma_min;
> @@ -947,7 +950,7 @@ static void msm_handle_delta_cts(struct uart_port *port)
>   static irqreturn_t msm_uart_irq(int irq, void *dev_id)
>   {
>   	struct uart_port *port = dev_id;
> -	struct msm_port *msm_port = UART_TO_MSM(port);
> +	struct msm_port *msm_port = to_msm_port(port);
>   	struct msm_dma *dma = &msm_port->rx_dma;
>   	unsigned long flags;
>   	unsigned int misr;
> @@ -1002,7 +1005,7 @@ static unsigned int msm_get_mctrl(struct uart_port *port)
>   
>   static void msm_reset(struct uart_port *port)
>   {
> -	struct msm_port *msm_port = UART_TO_MSM(port);
> +	struct msm_port *msm_port = to_msm_port(port);
>   	unsigned int mr;
>   
>   	/* reset everything */
> @@ -1055,7 +1058,7 @@ static const struct msm_baud_map *
>   msm_find_best_baud(struct uart_port *port, unsigned int baud,
>   		   unsigned long *rate)
>   {
> -	struct msm_port *msm_port = UART_TO_MSM(port);
> +	struct msm_port *msm_port = to_msm_port(port);
>   	unsigned int divisor, result;
>   	unsigned long target, old, best_rate = 0, diff, best_diff = ULONG_MAX;
>   	const struct msm_baud_map *entry, *end, *best;
> @@ -1124,7 +1127,7 @@ static int msm_set_baud_rate(struct uart_port *port, unsigned int baud,
>   			     unsigned long *saved_flags)
>   {
>   	unsigned int rxstale, watermark, mask;
> -	struct msm_port *msm_port = UART_TO_MSM(port);
> +	struct msm_port *msm_port = to_msm_port(port);
>   	const struct msm_baud_map *entry;
>   	unsigned long flags, rate;
>   
> @@ -1185,7 +1188,7 @@ static int msm_set_baud_rate(struct uart_port *port, unsigned int baud,
>   
>   static void msm_init_clock(struct uart_port *port)
>   {
> -	struct msm_port *msm_port = UART_TO_MSM(port);
> +	struct msm_port *msm_port = to_msm_port(port);
>   
>   	clk_prepare_enable(msm_port->clk);
>   	clk_prepare_enable(msm_port->pclk);
> @@ -1194,7 +1197,7 @@ static void msm_init_clock(struct uart_port *port)
>   
>   static int msm_startup(struct uart_port *port)
>   {
> -	struct msm_port *msm_port = UART_TO_MSM(port);
> +	struct msm_port *msm_port = to_msm_port(port);
>   	unsigned int data, rfr_level, mask;
>   	int ret;
>   
> @@ -1246,7 +1249,7 @@ static int msm_startup(struct uart_port *port)
>   
>   static void msm_shutdown(struct uart_port *port)
>   {
> -	struct msm_port *msm_port = UART_TO_MSM(port);
> +	struct msm_port *msm_port = to_msm_port(port);
>   
>   	msm_port->imr = 0;
>   	msm_write(port, 0, UART_IMR); /* disable interrupts */
> @@ -1262,7 +1265,7 @@ static void msm_shutdown(struct uart_port *port)
>   static void msm_set_termios(struct uart_port *port, struct ktermios *termios,
>   			    struct ktermios *old)
>   {
> -	struct msm_port *msm_port = UART_TO_MSM(port);
> +	struct msm_port *msm_port = to_msm_port(port);
>   	struct msm_dma *dma = &msm_port->rx_dma;
>   	unsigned long flags;
>   	unsigned int baud, mr;
> @@ -1416,7 +1419,7 @@ static int msm_verify_port(struct uart_port *port, struct serial_struct *ser)
>   static void msm_power(struct uart_port *port, unsigned int state,
>   		      unsigned int oldstate)
>   {
> -	struct msm_port *msm_port = UART_TO_MSM(port);
> +	struct msm_port *msm_port = to_msm_port(port);
>   
>   	switch (state) {
>   	case 0:
> @@ -1435,7 +1438,7 @@ static void msm_power(struct uart_port *port, unsigned int state,
>   #ifdef CONFIG_CONSOLE_POLL
>   static int msm_poll_get_char_single(struct uart_port *port)
>   {
> -	struct msm_port *msm_port = UART_TO_MSM(port);
> +	struct msm_port *msm_port = to_msm_port(port);
>   	unsigned int rf_reg = msm_port->is_uartdm ? UARTDM_RF : UART_RF;
>   
>   	if (!(msm_read(port, UART_SR) & UART_SR_RX_READY))
> @@ -1489,7 +1492,7 @@ static int msm_poll_get_char(struct uart_port *port)
>   {
>   	u32 imr;
>   	int c;
> -	struct msm_port *msm_port = UART_TO_MSM(port);
> +	struct msm_port *msm_port = to_msm_port(port);
>   
>   	/* Disable all interrupts */
>   	imr = msm_read(port, UART_IMR);
> @@ -1509,7 +1512,7 @@ static int msm_poll_get_char(struct uart_port *port)
>   static void msm_poll_put_char(struct uart_port *port, unsigned char c)
>   {
>   	u32 imr;
> -	struct msm_port *msm_port = UART_TO_MSM(port);
> +	struct msm_port *msm_port = to_msm_port(port);
>   
>   	/* Disable all interrupts */
>   	imr = msm_read(port, UART_IMR);
> @@ -1677,7 +1680,7 @@ static void msm_console_write(struct console *co, const char *s,
>   	BUG_ON(co->index < 0 || co->index >= UART_NR);
>   
>   	port = msm_get_port_from_line(co->index);
> -	msm_port = UART_TO_MSM(port);
> +	msm_port = to_msm_port(port);
>   
>   	__msm_console_write(port, s, count, msm_port->is_uartdm);
>   }
> @@ -1808,7 +1811,7 @@ static int msm_serial_probe(struct platform_device *pdev)
>   
>   	port = msm_get_port_from_line(line);
>   	port->dev = &pdev->dev;
> -	msm_port = UART_TO_MSM(port);
> +	msm_port = to_msm_port(port);
>   
>   	id = of_match_device(msm_uartdm_table, &pdev->dev);
>   	if (id)


-- 
js
suse labs
