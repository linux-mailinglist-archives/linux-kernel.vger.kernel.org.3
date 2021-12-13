Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68054721E6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 08:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbhLMHrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 02:47:15 -0500
Received: from mail-ed1-f41.google.com ([209.85.208.41]:41567 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbhLMHrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 02:47:14 -0500
Received: by mail-ed1-f41.google.com with SMTP id g14so48267415edb.8;
        Sun, 12 Dec 2021 23:47:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=29Na8l9HSQY6t8KoZDjv9rPfcDNp7ry9p/f0nUa6Kko=;
        b=3Zs55Y5PHiixl7jygtw4gV6cGmSM8S+zdq1gh5+2BeTOqM94y9OS63s5czEGAmW8IF
         lR1U2B0NjrSTaYt7zJxsRYaxlxISOHpCYIsyWJq7b5hVCVhluKr+onp8n5rtuz9LZis7
         Vu8qzSv67DX/atpP6WY8+03bCcizzZy+LuOLYgQnS7Vu77OtmkXw6U8PEjnRp4gGcX5C
         PrIFHytmLgHhg0Rq6FhZek89rEweqov82c8STcy7gtA28QkqALxjy/ws43/tEjNFDQoj
         6qBPCeMGK3zPiAOcBlWfCr2h5xy6wJ7OWd4ynMX1h+C/0yffnZwBg93w0ujXD8RltUch
         jQ7A==
X-Gm-Message-State: AOAM533DyJClCcS2cLPstKCbLNBbycHNm+kgohohJhATkmkpycOSKwGb
        gFp5N0yoZzkIBfSWe5zZUCo=
X-Google-Smtp-Source: ABdhPJxTOFIJsVisxF3/oDaIL+NHez8N+HgYJUMn6fADkCqhcDAeQ2LjOSawHHtX0rycLwtakcEF5g==
X-Received: by 2002:a17:906:4787:: with SMTP id cw7mr45539102ejc.311.1639381633375;
        Sun, 12 Dec 2021 23:47:13 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id y15sm6252469eda.13.2021.12.12.23.47.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Dec 2021 23:47:12 -0800 (PST)
Message-ID: <61fefc9d-643d-ca31-9a6d-d2e10cd060bb@kernel.org>
Date:   Mon, 13 Dec 2021 08:47:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v5 2/2] serial:sunplus-uart:Add Sunplus SoC UART Driver
Content-Language: en-US
To:     Hammer Hsieh <hammerh0314@gmail.com>, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de
Cc:     wells.lu@sunplus.com, Hammer Hsieh <hammer.hsieh@sunplus.com>
References: <1639379407-28607-1-git-send-email-hammer.hsieh@sunplus.com>
 <1639379407-28607-3-git-send-email-hammer.hsieh@sunplus.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <1639379407-28607-3-git-send-email-hammer.hsieh@sunplus.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13. 12. 21, 8:10, Hammer Hsieh wrote:
> Add Sunplus SoC UART Driver
> 
> Signed-off-by: Hammer Hsieh <hammer.hsieh@sunplus.com>

...

> --- /dev/null
> +++ b/drivers/tty/serial/sunplus-uart.c

...

> +static void receive_chars(struct uart_port *port)
> +{
> +	unsigned int lsr = readl(port->membase + SUP_UART_LSR);
> +	unsigned int ch, flag;
> +
> +	do {
> +		ch = readl(port->membase + SUP_UART_DATA);
> +		flag = TTY_NORMAL;
> +		port->icount.rx++;
> +
> +		if (unlikely(lsr & SUP_UART_LSR_BRK_ERROR_BITS)) {
> +			if (lsr & SUP_UART_LSR_BC) {
> +				lsr &= ~(SUP_UART_LSR_FE | SUP_UART_LSR_PE);
> +				port->icount.brk++;
> +				if (uart_handle_break(port))
> +					goto ignore_char;
> +			} else if (lsr & SUP_UART_LSR_PE) {
> +				port->icount.parity++;
> +			} else if (lsr & SUP_UART_LSR_FE) {
> +				port->icount.frame++;
> +			}
> +
> +			if (lsr & SUP_UART_LSR_OE)
> +				port->icount.overrun++;
> +
> +			if (lsr & SUP_UART_LSR_BC)
> +				flag = TTY_BREAK;
> +			else if (lsr & SUP_UART_LSR_PE)
> +				flag = TTY_PARITY;
> +			else if (lsr & SUP_UART_LSR_FE)
> +				flag = TTY_FRAME;

Why do you handle these separately and not above?

> +		}
> +
> +		if (port->ignore_status_mask & SUP_DUMMY_READ)
> +			goto ignore_char;
> +
> +		if (uart_handle_sysrq_char(port, ch))
> +			goto ignore_char;
> +
> +		uart_insert_char(port, lsr, SUP_UART_LSR_OE, ch, flag);
> +
> +ignore_char:
> +		lsr = readl(port->membase + SUP_UART_LSR);
> +	} while (lsr & SUP_UART_LSR_RX);
> +
> +	tty_flip_buffer_push(&port->state->port);
> +}
> +
> +static irqreturn_t sunplus_uart_irq(int irq, void *args)
> +{
> +	struct uart_port *port = (struct uart_port *)args;

No need to cast here.

> +	unsigned int isc = readl(port->membase + SUP_UART_ISC);

Shouldn't this be under the spinlock?

And "if (!isc) return IRQ_NONE"?

> +	spin_lock(&port->lock);
> +
> +	if (isc & SUP_UART_ISC_RX)
> +		receive_chars(port);
> +
> +	if (isc & SUP_UART_ISC_TX)
> +		transmit_chars(port);
> +
> +	spin_unlock(&port->lock);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int sunplus_startup(struct uart_port *port)
> +{
> +	unsigned long flags;
> +	unsigned int isc;
> +	int ret;
> +
> +	ret = request_irq(port->irq, sunplus_uart_irq, 0, "sunplus_uart", port);

Cannot the interrupt be shared?

> +	if (ret)
> +		return ret;
> +
> +	spin_lock_irqsave(&port->lock, flags);
> +
> +	isc |= SUP_UART_ISC_RXM;
> +	writel(isc, port->membase + SUP_UART_ISC);
> +
> +	spin_unlock_irqrestore(&port->lock, flags);
> +
> +	return 0;
> +}
> +
> +static void sunplus_shutdown(struct uart_port *port)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&port->lock, flags);
> +	writel(0, port->membase + SUP_UART_ISC);

What bus is this -- posting?

> +	spin_unlock_irqrestore(&port->lock, flags);
> +
> +	free_irq(port->irq, port);
> +}

...

> +static void sunplus_release_port(struct uart_port *port)
> +{
> +}
> +
> +static int sunplus_request_port(struct uart_port *port)
> +{
> +	return 0;
> +}

These two are optional -- no need to provide them.

regards,
-- 
js
suse labs
