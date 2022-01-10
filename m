Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49AC489467
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242257AbiAJIzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:55:53 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:22026 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbiAJIzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:55:31 -0500
Received: from [10.18.29.173] (10.18.29.173) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Mon, 10 Jan
 2022 16:54:58 +0800
Message-ID: <79e4a4d1-eefd-9fa2-d365-192f28f4c9c8@amlogic.com>
Date:   Mon, 10 Jan 2022 16:54:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] tty: serial: meson: Change request_irq to
 devm_request_irq and move devm_request_irq to meson_uart_probe()
Content-Language: en-US
To:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20220110082616.13474-1-yu.tu@amlogic.com>
 <20220110082616.13474-2-yu.tu@amlogic.com>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <20220110082616.13474-2-yu.tu@amlogic.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.29.173]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
	I'm really sorry for sending the wrong specified file. Please ignore 
the email. I will resend V4.

On 2022/1/10 16:26, Yu Tu wrote:
> Because an interrupt error occurs when the user opens /dev/ttyAML* but
> don't close it, and then opens the same port again. This problem is
> encountered in actual projects.
> 
> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
> ---
>   drivers/tty/serial/meson_uart.c | 16 +++++++++-------
>   1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index 45e41f20cba3..0dd3f5b35768 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -135,8 +135,6 @@ static void meson_uart_shutdown(struct uart_port *port)
>   	unsigned long flags;
>   	u32 val;
>   
> -	free_irq(port->irq, port);
> -
>   	spin_lock_irqsave(&port->lock, flags);
>   
>   	val = readl(port->membase + AML_UART_CONTROL);
> @@ -284,7 +282,6 @@ static void meson_uart_reset(struct uart_port *port)
>   static int meson_uart_startup(struct uart_port *port)
>   {
>   	u32 val;
> -	int ret;
>   
>   	meson_uart_reset(port);
>   
> @@ -298,10 +295,7 @@ static int meson_uart_startup(struct uart_port *port)
>   	val = (AML_UART_RECV_IRQ(1) | AML_UART_XMIT_IRQ(port->fifosize / 2));
>   	writel(val, port->membase + AML_UART_MISC);
>   
> -	ret = request_irq(port->irq, meson_uart_interrupt, 0,
> -			  port->name, port);
> -
> -	return ret;
> +	return 0;
>   }
>   
>   static void meson_uart_change_speed(struct uart_port *port, unsigned long baud)
> @@ -908,6 +902,14 @@ static int meson_uart_probe(struct platform_device *pdev)
>   	meson_ports[pdev->id] = port;
>   	platform_set_drvdata(pdev, port);
>   
> +	ret = devm_request_irq(&pdev->dev, port->irq, meson_uart_interrupt,
> +			       0, dev_name(&pdev->dev), port);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to request uart irq: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
>   	/* reset port before registering (and possibly registering console) */
>   	meson_uart_reset(port);
>   
> 
> base-commit: b3a9e3b9622ae10064826dccb4f7a52bd88c7407
> prerequisite-patch-id: 97a514f3447511cb204179ce03ae99dc1d5902d9
> prerequisite-patch-id: a2e4756ff85f0df0efe111d7e2cb51b8e26e226f
> prerequisite-patch-id: af9e3acc8f6ff7602d3a68a57c008e5ec362b353
> prerequisite-patch-id: 7af8c81b4c2163240725e96625b1487c280f4f30
> prerequisite-patch-id: 8791f6362b14e7c4ff4f85cce550f06abeb1af7a
