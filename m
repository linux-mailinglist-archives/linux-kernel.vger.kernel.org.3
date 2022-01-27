Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE25749DC3E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 09:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237675AbiA0IJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 03:09:40 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:45765 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237652AbiA0IJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 03:09:38 -0500
Received: by mail-wr1-f46.google.com with SMTP id m14so2942341wrg.12;
        Thu, 27 Jan 2022 00:09:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Xfemw7qeQYACKDQXfDCB6b2IfX5Bg+ss0c6AscYx+Z0=;
        b=r88Hk2QE4Zk5Eod5QWbNlv8smr9oLpIJPDI/ev+AQDBBz6smZy829TTbNi8InQht2m
         jSwO6QX5Qhh4s7F84/2RmYTKW1EcCIPFJLkkrA8RHOxjxOkYFDhMZbT4aEWchCp+SipE
         bTeZjFU/qxmKj2Wh9lwWMGdodajbQji3VWH2HGzPZC7ikdJkqycZxWnTyyA3U4sGzVvA
         +EYI8MZGKlGKY9DYkHKO0n65YdVQBNtc5eUjd2P2HVilbTxohYL3/AQTmb1jEzWdRPRH
         UzfCw3Oo2+hlTus52+Nrm1jIBRo7g3Mzffpt30ZH4/bnke48V00aVeBQs9iozPCdav8q
         7q+Q==
X-Gm-Message-State: AOAM533sF71y4C/7nSLgjB+7RLf12uFShnxbTO4Nhwp3rLdUaTxLtMin
        ZPdecYYu1FfC2XDyLCSzLwE=
X-Google-Smtp-Source: ABdhPJyDT9LCAzsKdbJQlc9pdawhT+BPIXYRlYnRXcpfCk1/sg+wpi9XStsygRxPFlLPi1w52vjgOQ==
X-Received: by 2002:a5d:59a7:: with SMTP id p7mr1892075wrr.433.1643270976597;
        Thu, 27 Jan 2022 00:09:36 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id m5sm1476499wms.4.2022.01.27.00.09.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 00:09:36 -0800 (PST)
Message-ID: <c5702d8a-d561-31c4-965f-da8953d75ce3@kernel.org>
Date:   Thu, 27 Jan 2022 09:09:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 10/11] serial: make uart_console_write->putchar()'s
 character a char
Content-Language: en-US
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        johan@kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Tobias Klauser <tklauser@distanz.ch>,
        Russell King <linux@armlinux.org.uk>,
        Vineet Gupta <vgupta@kernel.org>,
        Richard Genoud <richard.genoud@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Baruch Siach <baruch@tkos.co.il>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Taichi Sugaya <sugaya.taichi@socionext.com>,
        Takao Orito <orito.takao@socionext.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Michal Simek <michal.simek@xilinx.com>
References: <20220124071430.14907-1-jslaby@suse.cz>
 <20220124071430.14907-11-jslaby@suse.cz>
 <alpine.DEB.2.21.2201261700460.58572@angie.orcam.me.uk>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <alpine.DEB.2.21.2201261700460.58572@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26. 01. 22, 18:57, Maciej W. Rozycki wrote:
> On Mon, 24 Jan 2022, Jiri Slaby wrote:
> 
>> diff --git a/drivers/tty/serial/dz.c b/drivers/tty/serial/dz.c
>> index e9edabc5a211..3493e201d67f 100644
>> --- a/drivers/tty/serial/dz.c
>> +++ b/drivers/tty/serial/dz.c
>> @@ -802,7 +802,7 @@ static void __init dz_init_ports(void)
>>    * restored.  Welcome to the world of PDP-11!
>>    * -------------------------------------------------------------------
>>    */
>> -static void dz_console_putchar(struct uart_port *uport, int ch)
>> +static void dz_console_putchar(struct uart_port *uport, char ch)
>>   {
>>   	struct dz_port *dport = to_dport(uport);
>>   	unsigned long flags;
> 
>   Hmm, this is unsafe, because on the MIPS target the lone `char' type is
> signed and therefore a call to `->putchar' will see `ch' sign-extended
> from bit #7 to the width of the argument register used.  Which means that
> if a character is sent to the console that has its bit #7 set, then the
> call to:
> 
> 		dz_out(dport, DZ_TDR, ch);
> 
> i.e.:
> 
> static void dz_out(struct dz_port *dport, unsigned offset, u16 value)
> 
> will send a value to DZ_TDR with bits #15:8 set to all-ones.  And bits
> #11:8 there are the BREAK control bits, active high, for serial lines #3:0
> respectively.
> 
>   We could handle this with a preparatory change by calling:
> 
> 		dz_out(dport, DZ_TDR, ch & 0xffu);
> 
> instead, but perhaps `->putchar' should simply take `unsigned char' or
> maybe even `u8' as its third argument?
> 
>> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
>> index c58cc142d23f..68e62703eaa6 100644
>> --- a/include/linux/serial_core.h
>> +++ b/include/linux/serial_core.h
>> @@ -399,7 +399,7 @@ int uart_set_options(struct uart_port *port, struct console
>> *co, int baud,
>>   struct tty_driver *uart_console_device(struct console *co, int *index);
>>   void uart_console_write(struct uart_port *port, const char *s,
>>   			unsigned int count,
>> -			void (*putchar)(struct uart_port *, int));
>> +			void (*putchar)(struct uart_port *, char));
>>   
>>   /*
>>    * Port/driver registration/removal
> 
>   I.e.:
> 
> 			void (*putchar)(struct uart_port *, unsigned char));
> 
> I can see we get it right already with:
> 
> 	unsigned char		x_char;			/* xon/xoff char */
> 
> and for `dz_transmit_chars' we have:
> 
> 	unsigned char tmp;
> [...]
> 	tmp = xmit->buf[xmit->tail];
> 	xmit->tail = (xmit->tail + 1) & (DZ_XMIT_SIZE - 1);
> 	dz_out(dport, DZ_TDR, tmp);
> 
> (because `struct circ_buf' is generic and not limited to unsigned buffer
> contents interpretation; it's not clear to me if that has been intended
> though).

Thanks, good point. I was considering unsigned char and concluded not go 
that path right now as the rest of the console world uses char -- 
starting from the printk code. OTOH the whole uart world uses 'unsigned 
char' except that circ_buf. But I am phasing circ_buf out in favor of 
kfifo+unsigned-char anyway.

So let me switch the whole uart (the console code in particular) to an 
unsigned world. Meaning printk will pass char, uart will receive it as 
unsigned char and will keep it unsigned in all cases.

thanks,
-- 
js
suse labs
