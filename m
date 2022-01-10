Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E335548946B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242413AbiAJI4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:56:25 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:19223 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242048AbiAJIzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:55:44 -0500
Received: from [10.18.29.173] (10.18.29.173) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Mon, 10 Jan
 2022 16:55:05 +0800
Message-ID: <b553aea7-cb78-830a-4a4c-51d2ee2a1850@amlogic.com>
Date:   Mon, 10 Jan 2022 16:55:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] tty: serial: meson: Make the bit24 and bit [26,27] of the
 UART_REG5 register writable
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
 <20220110082616.13474-3-yu.tu@amlogic.com>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <20220110082616.13474-3-yu.tu@amlogic.com>
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
> The UART_REG5 register defaults to 0. The console port is set in
> ROMCODE. But other UART ports default to 0, so make bit24 and
> bit[26,27] writable so that the UART can choose a more
> appropriate clock.
> 
> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
> ---
>   drivers/tty/serial/meson_uart.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
> index 7c3f30cea68e..b0551750dff8 100644
> --- a/drivers/tty/serial/meson_uart.c
> +++ b/drivers/tty/serial/meson_uart.c
> @@ -693,7 +693,7 @@ static int meson_uart_probe_clocks(struct uart_port *port)
>   							CLK_SET_RATE_NO_REPARENT,
>   							port->membase + AML_UART_REG5,
>   							26, 2,
> -							CLK_DIVIDER_READ_ONLY,
> +							CLK_DIVIDER_ROUND_CLOSEST,
>   							xtal_div_table, NULL);
>   		if (IS_ERR(hw))
>   			return PTR_ERR(hw);
> @@ -719,7 +719,7 @@ static int meson_uart_probe_clocks(struct uart_port *port)
>   					CLK_SET_RATE_PARENT,
>   					port->membase + AML_UART_REG5,
>   					24, 0x1,
> -					CLK_MUX_READ_ONLY,
> +					CLK_MUX_ROUND_CLOSEST,
>   					NULL, NULL);
>   	if (IS_ERR(hw))
>   		return PTR_ERR(hw);
> 
> base-commit: 93a770b7e16772530196674ffc79bb13fa927dc6
> prerequisite-patch-id: 95191c926509964c8e9bf4128b8bbad8a277b84a
> prerequisite-patch-id: a2e4756ff85f0df0efe111d7e2cb51b8e26e226f
> prerequisite-patch-id: 4e4d909acabcb7533da20e2207207be73454a88c
