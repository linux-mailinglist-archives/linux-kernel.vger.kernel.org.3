Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB78748946D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbiAJI42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:56:28 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:22026 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242180AbiAJIzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:55:45 -0500
Received: from [10.18.29.173] (10.18.29.173) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Mon, 10 Jan
 2022 16:55:14 +0800
Message-ID: <f16770c3-fc9c-3353-8b5c-5f3029cda240@amlogic.com>
Date:   Mon, 10 Jan 2022 16:55:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] tty: serial: meson: meson_uart_shutdown omit clear
 AML_UART_TX_EN bit
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
 <20220110082616.13474-4-yu.tu@amlogic.com>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <20220110082616.13474-4-yu.tu@amlogic.com>
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
> This change is an improvement. The meson_uart_shutdown function
> should have the opposite operation to the meson_uart_startup
> function, but the meson_uart_shutdown of AML_UART_TX_EN is logically
> missing.
> 
> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
> ---
>   drivers/tty/serial/meson_uart.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index 9b07e3534969..c17109d6d441 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -140,7 +140,7 @@ static void meson_uart_shutdown(struct uart_port *port)
>   	spin_lock_irqsave(&port->lock, flags);
>   
>   	val = readl(port->membase + AML_UART_CONTROL);
> -	val &= ~AML_UART_RX_EN;
> +	val &= ~(AML_UART_RX_EN | AML_UART_TX_EN);
>   	val &= ~(AML_UART_RX_INT_EN | AML_UART_TX_INT_EN);
>   	writel(val, port->membase + AML_UART_CONTROL);
>   
> 
> base-commit: b3a9e3b9622ae10064826dccb4f7a52bd88c7407
> prerequisite-patch-id: 97a514f3447511cb204179ce03ae99dc1d5902d9
> prerequisite-patch-id: a2e4756ff85f0df0efe111d7e2cb51b8e26e226f
> prerequisite-patch-id: af9e3acc8f6ff7602d3a68a57c008e5ec362b353
> prerequisite-patch-id: a44e5da7009d9b815eb87395cbd7d14e7d953a09
