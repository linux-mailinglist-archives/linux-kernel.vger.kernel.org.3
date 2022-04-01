Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0FD4EE766
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 06:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244876AbiDAEiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 00:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbiDAEhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 00:37:52 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18FA243713;
        Thu, 31 Mar 2022 21:36:03 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id h23so2431141wrb.8;
        Thu, 31 Mar 2022 21:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=olW/xLwuiQra0w+84+rmqpMcAO9wN+Sku9gVx0ollFo=;
        b=julqckNObXM5HJ743nwZ/yFGool+34eAu9o9Dq86iWJm4//8lJfAkR+Al1BtsdHe7n
         4M23xx4jDPhF103GFAshfFbY3/wLfBe8lVINtum20ueiYYKtWHj4uqTlReIjm+x9Q/qU
         HoFrNCPLWU/+qEQlvLkKB0NgUqC+l/iLS8VRL/0QXbTF15nF74FF5C/7+uTptMZ0dK2H
         4Ocn2tuclJo4mwGN0NzF7qTd2qWnVk71e5xYdyXIeVyy9UYJbmDK1ncN63USvZB5mQTD
         GvaVCFxFg/l1EoiItvawcdsfMUfJbXPTYl6Us+XzvJ/sfv6MZK8bAqQG+R1CSj3hbn/o
         +a3g==
X-Gm-Message-State: AOAM531CTqouTuPUpIWtlbKng/GZrSCMrc1LGMfBhxYt7GPCeegRBfwp
        ziqpBt9dRlnBqXixQBTiQXY=
X-Google-Smtp-Source: ABdhPJyv+IBI4CGl6Q1AzmNDsJMYYp7uyj/VURBMSErPvxbpLB2F+eOKSl02X9xcbUiYDXLPR3jLeQ==
X-Received: by 2002:a05:6000:f:b0:203:d97a:947 with SMTP id h15-20020a056000000f00b00203d97a0947mr6366606wrx.654.1648787762171;
        Thu, 31 Mar 2022 21:36:02 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id t6-20020a05600c198600b0038cafe3d47dsm857337wmq.42.2022.03.31.21.36.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 21:36:01 -0700 (PDT)
Message-ID: <4767809d-5818-ad40-a0e7-b3af40aa071e@kernel.org>
Date:   Fri, 1 Apr 2022 06:35:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v5 1/1] serial/8250: Use fifo in 8250 console driver
Content-Language: en-US
To:     Wander Lairson Costa <wander@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     rostedt@goodmis.org, senozhatsky@chromium.org,
        andre.goddard@gmail.com, sudipm.mukherjee@gmail.com,
        andy.shevchenko@gmail.com, David.Laight@aculab.com,
        jonathanh@nvidia.com, phil@raspberrypi.com
References: <20220331190257.101781-1-wander@redhat.com>
 <20220331190257.101781-2-wander@redhat.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220331190257.101781-2-wander@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 31. 03. 22, 21:02, Wander Lairson Costa wrote:
> Note: I am using a small test app + driver located at [0] for the
> problem description. serco is a driver whose write function dispatches
> to the serial controller. sertest is a user-mode app that writes n bytes
> to the serial console using the serco driver.
> 
> While investigating a bug in the RHEL kernel, I noticed that the serial
> console throughput is way below the configured speed of 115200 bps in
> a HP Proliant DL380 Gen9. I was expecting something above 10KB/s, but
> I got 2.5KB/s.
> 
> $ time ./sertest -n 2500 /tmp/serco
> 
> real    0m0.997s
> user    0m0.000s
> sys     0m0.997s
> 
> With the help of the function tracer, I then noticed the serial
> controller was taking around 410us seconds to dispatch one single byte:
> 
> $ trace-cmd record -p function_graph -g serial8250_console_write \
>     ./sertest -n 1 /tmp/serco
> 
> $ trace-cmd report
> 
>              |  serial8250_console_write() {
>   0.384 us   |    _raw_spin_lock_irqsave();
>   1.836 us   |    io_serial_in();
>   1.667 us   |    io_serial_out();
>              |    uart_console_write() {
>              |      serial8250_console_putchar() {
>              |        wait_for_xmitr() {
>   1.870 us   |          io_serial_in();
>   2.238 us   |        }
>   1.737 us   |        io_serial_out();
>   4.318 us   |      }
>   4.675 us   |    }
>              |    wait_for_xmitr() {
>   1.635 us   |      io_serial_in();
>              |      __const_udelay() {
>   1.125 us   |        delay_tsc();
>   1.429 us   |      }
> ...
> ...
> ...
>   1.683 us   |      io_serial_in();
>              |      __const_udelay() {
>   1.248 us   |        delay_tsc();
>   1.486 us   |      }
>   1.671 us   |      io_serial_in();
>   411.342 us |    }
> 
> In another machine, I measured a throughput of 11.5KB/s, with the serial
> controller taking between 80-90us to send each byte. That matches the
> expected throughput for a configuration of 115200 bps.
> 
> This patch changes the serial8250_console_write to use the 16550 fifo
> if available. In my benchmarks I got around 25% improvement in the slow
> machine, and no performance penalty in the fast machine.
> 
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> ---
>   drivers/tty/serial/8250/8250_port.c | 68 ++++++++++++++++++++++++++---
>   1 file changed, 62 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 318af6f13605..8f7eba5e71cf 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -2077,10 +2077,7 @@ static void serial8250_break_ctl(struct uart_port *port, int break_state)
>   	serial8250_rpm_put(up);
>   }
>   
> -/*
> - *	Wait for transmitter & holding register to empty
> - */
> -static void wait_for_xmitr(struct uart_8250_port *up, int bits)
> +static void wait_for_lsr(struct uart_8250_port *up, int bits)
>   {
>   	unsigned int status, tmout = 10000;
>   
> @@ -2097,6 +2094,16 @@ static void wait_for_xmitr(struct uart_8250_port *up, int bits)
>   		udelay(1);
>   		touch_nmi_watchdog();
>   	}
> +}
> +
> +/*
> + *	Wait for transmitter & holding register to empty
> + */
> +static void wait_for_xmitr(struct uart_8250_port *up, int bits)
> +{
> +	unsigned int tmout;
> +
> +	wait_for_lsr(up, bits);
>   
>   	/* Wait up to 1s for flow control if necessary */
>   	if (up->port.flags & UPF_CONS_FLOW) {
> @@ -3332,6 +3339,35 @@ static void serial8250_console_restore(struct uart_8250_port *up)
>   	serial8250_out_MCR(up, UART_MCR_DTR | UART_MCR_RTS);
>   }
>   
> +/*
> + * Print a string to the serial port using the device FIFO
> + *
> + * It sends fifosize bytes and then waits for the fifo
> + * to get empty.
> + */
> +static void serial8250_console_fifo_write(struct uart_8250_port *up,
> +					  const char *s, unsigned int count)
> +{
> +	int i;
> +	const char *end = s + count;
> +	unsigned int fifosize = up->tx_loadsz;
> +	bool cr_sent = false;
> +
> +	while (s != end) {
> +		wait_for_lsr(up, UART_LSR_THRE);
> +
> +		for (i = 0; i < fifosize && s != end; ++i) {
> +			if (*s == '\n' && !cr_sent) {
> +				serial_out(up, UART_TX, '\r');
> +				cr_sent = true;
> +			} else {
> +				serial_out(up, UART_TX, *s++);
> +				cr_sent = false;
> +			}
> +		}
> +	}
> +}
> +
>   /*
>    *	Print a string to the serial port trying not to disturb
>    *	any possible real use of the port...
> @@ -3347,7 +3383,7 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
>   	struct uart_8250_em485 *em485 = up->em485;
>   	struct uart_port *port = &up->port;
>   	unsigned long flags;
> -	unsigned int ier;
> +	unsigned int ier, use_fifo;
>   	int locked = 1;
>   
>   	touch_nmi_watchdog();
> @@ -3379,7 +3415,27 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
>   		mdelay(port->rs485.delay_rts_before_send);
>   	}
>   
> -	uart_console_write(port, s, count, serial8250_console_putchar);
> +	use_fifo = (up->capabilities & UART_CAP_FIFO) &&
> +		/*
> +		 * BCM283x requires to check the fifo
> +		 * after each byte.
> +		 */
> +		!(up->capabilities & UART_CAP_MINI) &&
> +		up->tx_loadsz > 1 &&
> +		(up->fcr & UART_FCR_ENABLE_FIFO) &&
> +		port-state &&

">" missing here. Doesn't a compiler warn about subtracting different types?

regards,
-- 
js
suse labs
