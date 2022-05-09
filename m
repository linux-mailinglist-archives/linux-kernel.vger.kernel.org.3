Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C7051F416
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 08:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbiEIFtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 01:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235007AbiEIFq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 01:46:29 -0400
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F7A15E498;
        Sun,  8 May 2022 22:42:36 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id 125-20020a1c1983000000b003941f354c62so7614128wmz.0;
        Sun, 08 May 2022 22:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PgUJQCGuVuN7RMUt/u/GB2vkYIZJaEjDbMnifyGw+XM=;
        b=uWYHN/OTPaoS3Qf10LSpocUCCLihQH0lh6ZiwjMj9Rtsb3OJYGFaBLfkbhP2sRjEEo
         +MQtww0LFDu9g394XKJlkHNE9/F3jnwxdbpWjb0Tp/HRV75iiQzEMiXWRfeZt5xnH0R1
         7PfJmAJrL7NxAP3Ack+LcTXerTbXkUKnIXIuLOq4U9WBzXUIqoaSKHgfSYNCOfp9aWOl
         LMRF1A9EQWp3P/YotgFrhDZMAEf8w4NtIq3E5FdHQDgJcYyxZI5H3la0gYa2pdFmumrR
         d2Tukv0VeIb5JILapRcrBya/+8ZhjsN5AR8MqMWmaqbJZKjxUdIxO/uqKnnbDVDlhjAy
         JgZA==
X-Gm-Message-State: AOAM530hKvIzA/eORU6ymucSZcLJqZ6PB5mgmD8qAeZSP2GWo4WnM1Ia
        uuAqbTGB3HU1geQ2IkqPWus=
X-Google-Smtp-Source: ABdhPJwc4eYBOaGWeOZpzdHrP/EzHMr+8axHRm30/zjzwNtxs/nJxF3qH+zPotS6vDu9D2X/XzPbUQ==
X-Received: by 2002:a05:600c:3b11:b0:394:57eb:c58b with SMTP id m17-20020a05600c3b1100b0039457ebc58bmr20723567wms.3.1652074950839;
        Sun, 08 May 2022 22:42:30 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id d7-20020adffbc7000000b0020c66310845sm9972919wrs.55.2022.05.08.22.42.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 May 2022 22:42:30 -0700 (PDT)
Message-ID: <c0eac83f-8483-7709-b558-561ff7a382b0@kernel.org>
Date:   Mon, 9 May 2022 07:42:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v1] serial: meson: acquire port->lock in startup()
Content-Language: en-US
To:     John Ogness <john.ogness@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20220508103547.626355-1-john.ogness@linutronix.de>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220508103547.626355-1-john.ogness@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08. 05. 22, 12:35, John Ogness wrote:
> The uart_ops startup() callback is called without interrupts
> disabled and without port->lock locked, relatively late during the
> boot process (from the call path of console_on_rootfs()). If the
> device is a console, it was already previously registered and could
> be actively printing messages.
> 
> Since the startup() callback is reading/writing registers used by
> the console write() callback (AML_UART_CONTROL), its access must
> be synchronized using the port->lock. Currently it is not.
> 
> The startup() callback is the only function that explicitly enables
> interrupts. Without the synchronization, it is possible that
> interrupts become accidentally permanently disabled.
> 
> CPU0                           CPU1
> meson_serial_console_write     meson_uart_startup
> --------------------------     ------------------
> spin_lock(port->lock)
> val = readl(AML_UART_CONTROL)
> uart_console_write()
>                                 writel(INT_EN, AML_UART_CONTROL)
> writel(val, AML_UART_CONTROL)
> spin_unlock(port->lock)
> 
> Add port->lock synchronization to meson_uart_startup() to avoid
> racing with meson_serial_console_write().
> 
> Also add detailed comments to meson_uart_reset() explaining why it
> is *not* using port->lock synchronization.
> 
> Link: https://lore.kernel.org/lkml/2a82eae7-a256-f70c-fd82-4e510750906e@samsung.com
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Makes sense to me.

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> ---
>   drivers/tty/serial/meson_uart.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index 2bf1c57e0981..39021dac09cc 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -253,6 +253,14 @@ static const char *meson_uart_type(struct uart_port *port)
>   	return (port->type == PORT_MESON) ? "meson_uart" : NULL;
>   }
>   
> +/*
> + * This function is called only from probe() using a temporary io mapping
> + * in order to perform a reset before setting up the device. Since the
> + * temporarily mapped region was successfully requested, there can be no
> + * console on this port at this time. Hence it is not necessary for this
> + * function to acquire the port->lock. (Since there is no console on this
> + * port at this time, the port->lock is not initialized yet.)
> + */
>   static void meson_uart_reset(struct uart_port *port)
>   {
>   	u32 val;
> @@ -267,9 +275,12 @@ static void meson_uart_reset(struct uart_port *port)
>   
>   static int meson_uart_startup(struct uart_port *port)
>   {
> +	unsigned long flags;
>   	u32 val;
>   	int ret = 0;
>   
> +	spin_lock_irqsave(&port->lock, flags);
> +
>   	val = readl(port->membase + AML_UART_CONTROL);
>   	val |= AML_UART_CLEAR_ERR;
>   	writel(val, port->membase + AML_UART_CONTROL);
> @@ -285,6 +296,8 @@ static int meson_uart_startup(struct uart_port *port)
>   	val = (AML_UART_RECV_IRQ(1) | AML_UART_XMIT_IRQ(port->fifosize / 2));
>   	writel(val, port->membase + AML_UART_MISC);
>   
> +	spin_unlock_irqrestore(&port->lock, flags);
> +
>   	ret = request_irq(port->irq, meson_uart_interrupt, 0,
>   			  port->name, port);
>   
> 
> base-commit: 672c0c5173427e6b3e2a9bbb7be51ceeec78093a


-- 
js
suse labs
