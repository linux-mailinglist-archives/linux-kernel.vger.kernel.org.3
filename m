Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2223E5A43BF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 09:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiH2H1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 03:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiH2H1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 03:27:06 -0400
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4664DB7E;
        Mon, 29 Aug 2022 00:27:04 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id w19so13920933ejc.7;
        Mon, 29 Aug 2022 00:27:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=ihc40JxKK2nHoxN+hvEaP8iMq51h54dF712kIrTQgIE=;
        b=ScdtI89OV3/qtD1Hx3MQotHqp49oxhLaULxVqi8437l9VCjmvNHGtEfHul7HLYM4yH
         zFpn8jbiXHYw0bUub042VZRScwoD8LNFm2GETkTT17B7+ac9k0s5choM6DhtBQX2Ko4i
         4T6DvkOefEhFYU2thtaWT5mc4aRp/VJgkNEtmSoB7S0+6x+7aRtzDTgOuJWYg/Cmbp59
         XJGejykXKMGKU0lif0GH4Qg5EUYT2ob5A2ELig8pQ5W4LnZeot0h9Z9J82GXi3WwVMJJ
         vUHmpXsymUwvMOf0Xat95x5iqhUci1iEj1hxUIziqlbNplYpqX3KA/a//Rs+qz0VLqHb
         GLMg==
X-Gm-Message-State: ACgBeo1wnUiS/R1VpfUhyEfeXhTglLXwDJ2J+7H39dNGWug6FKLmRvSL
        dDA7NIwvNVix5O0J8dwcD2qt4d4rje8=
X-Google-Smtp-Source: AA6agR64SosFnzlC166YRLWgO0I/pGAqsn6f1OpyAro7yNC4sZLuSkZTPC6B3a4D0wt1cImVL6TQKQ==
X-Received: by 2002:a17:907:2e19:b0:73e:f770:eddd with SMTP id ig25-20020a1709072e1900b0073ef770edddmr9117697ejc.249.1661758023429;
        Mon, 29 Aug 2022 00:27:03 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id h3-20020a0564020e0300b00446a5fdaf0fsm5323090edh.45.2022.08.29.00.27.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 00:27:02 -0700 (PDT)
Message-ID: <0a1f4ce9-4158-b8ab-1837-68da06f20407@kernel.org>
Date:   Mon, 29 Aug 2022 09:27:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 3/3] tty: serial: use uart_port_tx_limit() helper
Content-Language: en-US
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>
References: <20220411105405.9519-1-jslaby@suse.cz>
 <20220411105405.9519-4-jslaby@suse.cz> <20220411115141.o2i3rlfcyzg6qlnz@pali>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220411115141.o2i3rlfcyzg6qlnz@pali>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 11. 04. 22, 13:51, Pali Rohár wrote:
> On Monday 11 April 2022 12:54:05 Jiri Slaby wrote:
>> uart_port_tx_limit() is a new helper to send characters to the device.
>> Use it in these drivers.
>>
>> It means we have to define two new uart hooks: tx_ready() and put_char()
>> to do the real job now.
>>
>> And mux.c also needs to define tx_done(). But I'm not sure if the driver
>> really wants to wait for all the characters to dismiss from the HW fifo
>> at this code point. Hence I marked this as FIXME.
>>
>> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
>> Cc: Russell King <linux@armlinux.org.uk>
>> Cc: Florian Fainelli <f.fainelli@gmail.com>
>> Cc: bcm-kernel-feedback-list@broadcom.com
>> Cc: "Pali Rohár" <pali@kernel.org>
>> Cc: Kevin Cernekee <cernekee@gmail.com>
>> Cc: Palmer Dabbelt <palmer@dabbelt.com>
>> Cc: Paul Walmsley <paul.walmsley@sifive.com>
>> Cc: Orson Zhai <orsonzhai@gmail.com>
>> Cc: Baolin Wang <baolin.wang7@gmail.com>
>> Cc: Chunyan Zhang <zhang.lyra@gmail.com>
>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>> Cc: linux-riscv@lists.infradead.org
>> ---
>>   drivers/tty/serial/21285.c           | 40 +++++++--------------
>>   drivers/tty/serial/altera_jtaguart.c | 43 ++++++----------------
>>   drivers/tty/serial/amba-pl010.c      | 40 ++++-----------------
>>   drivers/tty/serial/apbuart.c         | 37 ++++---------------
>>   drivers/tty/serial/bcm63xx_uart.c    | 48 ++++++-------------------
>>   drivers/tty/serial/mux.c             | 48 ++++++++-----------------
>>   drivers/tty/serial/mvebu-uart.c      | 47 +++++++-----------------
>>   drivers/tty/serial/omap-serial.c     | 53 +++++++---------------------
>>   drivers/tty/serial/pxa.c             | 43 +++++-----------------
>>   drivers/tty/serial/rp2.c             | 36 ++++++-------------
>>   drivers/tty/serial/serial_txx9.c     | 40 ++++-----------------
>>   drivers/tty/serial/sifive.c          | 48 ++++---------------------
>>   drivers/tty/serial/sprd_serial.c     | 41 ++++-----------------
>>   drivers/tty/serial/st-asc.c          | 51 ++++----------------------
>>   drivers/tty/serial/vr41xx_siu.c      | 42 ++++------------------
>>   15 files changed, 143 insertions(+), 514 deletions(-)
> ...
>> diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
>> index 0429c2a54290..3d07ab9eb15e 100644
>> --- a/drivers/tty/serial/mvebu-uart.c
>> +++ b/drivers/tty/serial/mvebu-uart.c
>> @@ -194,6 +194,16 @@ static unsigned int mvebu_uart_tx_empty(struct uart_port *port)
>>   	return (st & STAT_TX_EMP) ? TIOCSER_TEMT : 0;
>>   }
>>   
>> +static bool mvebu_uart_tx_ready(struct uart_port *port)
>> +{
>> +	return !(readl(port->membase + UART_STAT) & STAT_TX_FIFO_FUL);
> 
> mvebu-uart.c driver in its tx_ready function should probably use
> STAT_TX_RDY macro (access to STAT_TX_RDY bit in register).
> 
> Documentation for UART1 (STD) about this bit says:
> 
> This bit is set when TRANS_HLD (our UART_TSH macro) is empty and ready
> for the CPU to write the next character to be transmitted out. The TSR
> can still shift out the previous character when this bit is set. This
> bit is cleared when the CPU writes to TRANS_HLD.
> 
> For UART2 (EXT) there is just information: UART Tx Ready for 1 Byte
> Write. UART2 (EXT) has also bit (bit 5) which indicates that CPU can
> load 4 bytes, but seems that this is not used by mvebu-uart.c driver.
> 
> Macro STAT_TX_RDY() is polled also in wait_for_xmitr() function.

Hi,
so care to send fixes for the two issues :)? The series is not meant to 
change behavior...

>> +}
>> +
>> +static void mvebu_uart_put_char(struct uart_port *port, unsigned char ch)
>> +{
>> +	writel(ch, port->membase + UART_TSH(port));
>> +}
>> +
>>   static unsigned int mvebu_uart_get_mctrl(struct uart_port *port)
>>   {
>>   	return TIOCM_CTS | TIOCM_DSR | TIOCM_CAR;
>> @@ -324,40 +334,7 @@ static void mvebu_uart_rx_chars(struct uart_port *port, unsigned int status)
>>   
>>   static void mvebu_uart_tx_chars(struct uart_port *port, unsigned int status)
>>   {
>> -	struct circ_buf *xmit = &port->state->xmit;
>> -	unsigned int count;
>> -	unsigned int st;
>> -
>> -	if (port->x_char) {
>> -		writel(port->x_char, port->membase + UART_TSH(port));
>> -		port->icount.tx++;
>> -		port->x_char = 0;
>> -		return;
>> -	}
>> -
>> -	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
>> -		mvebu_uart_stop_tx(port);
>> -		return;
>> -	}
>> -
>> -	for (count = 0; count < port->fifosize; count++) {
>> -		writel(xmit->buf[xmit->tail], port->membase + UART_TSH(port));
>> -		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
>> -		port->icount.tx++;
>> -
>> -		if (uart_circ_empty(xmit))
>> -			break;
>> -
>> -		st = readl(port->membase + UART_STAT);
>> -		if (st & STAT_TX_FIFO_FUL)
>> -			break;
> 
> I see that driver here currently use STAT_TX_FIFO_FUL for checking if it
> can do next iteration and write next character to UART_TSH.
> 
> Documentation about this bit says that ... the FIFO is full, which is
> indicated by TX_FIFO_FULL. TX_READY status is set as long as the FIFO is
> not full. The Tx ready status is cleared when in THR FIFO is full.
> 
> In case driver does not use 4 byte loads for UART2, TX_READY and
> !TX_FIFO_FULL are probably same...
> 
> Anyway, mvebu_uart_tx_chars() is called from the mvebu_uart_tx_isr()
> interrupt handler which is registered for CTRL_RX_RDY_INT interrupt
> which should signal when TX_READY is set.
> 
>> -	}
>> -
>> -	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
>> -		uart_write_wakeup(port);
>> -
>> -	if (uart_circ_empty(xmit))
>> -		mvebu_uart_stop_tx(port);
>> +	uart_port_tx_limit(port, port->fifosize);
>>   }
>>   
>>   static irqreturn_t mvebu_uart_isr(int irq, void *dev_id)
>> @@ -654,6 +631,8 @@ static void mvebu_uart_put_poll_char(struct uart_port *port, unsigned char c)
>>   
>>   static const struct uart_ops mvebu_uart_ops = {
>>   	.tx_empty	= mvebu_uart_tx_empty,
>> +	.tx_ready	= mvebu_uart_tx_ready,
>> +	.put_char	= mvebu_uart_put_char,
>>   	.set_mctrl	= mvebu_uart_set_mctrl,
>>   	.get_mctrl	= mvebu_uart_get_mctrl,
>>   	.stop_tx	= mvebu_uart_stop_tx,

thanks,
-- 
js
suse labs

