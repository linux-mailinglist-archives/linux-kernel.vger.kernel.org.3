Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED9A748442A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 16:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234658AbiADPF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 10:05:27 -0500
Received: from mout01.posteo.de ([185.67.36.141]:47317 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233194AbiADPF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 10:05:26 -0500
X-Greylist: delayed 442 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Jan 2022 10:05:26 EST
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 3FE9524002A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 15:58:02 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4JSwhj2x3Mz9rwn;
        Tue,  4 Jan 2022 15:57:57 +0100 (CET)
Message-ID: <c5c4176f-2a55-6fc5-d5dd-ce3b43fd11ff@posteo.net>
Date:   Tue,  4 Jan 2022 14:57:56 +0000
MIME-Version: 1.0
Subject: Re: [PATCH] serial: atmel: Use platform_get_irq() to get the
 interrupt
Content-Language: fr-FR
To:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20211215224832.1985402-1-robh@kernel.org>
From:   Richard Genoud <richard.genoud@gmail.com>
In-Reply-To: <20211215224832.1985402-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 15/12/2021 à 23:48, Rob Herring a écrit :
> Accessing platform device resources directly has long been deprecated for
> DT as IRQ resources may not be available at device creation time. Drivers
> continuing to use static IRQ resources is blocking removing the static setup
> from the DT core code.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
Acked-by: Richard Genoud <richard.genoud@gmail.com>

> ---
>   drivers/tty/serial/atmel_serial.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 2c99a47a2535..9e57bfe523cf 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -2479,7 +2479,7 @@ static int atmel_init_port(struct atmel_uart_port *atmel_port,
>   	port->fifosize		= 1;
>   	port->dev		= &pdev->dev;
>   	port->mapbase		= mpdev->resource[0].start;
> -	port->irq		= mpdev->resource[1].start;
> +	port->irq		= platform_get_irq(mpdev, 0);
>   	port->rs485_config	= atmel_config_rs485;
>   	port->iso7816_config	= atmel_config_iso7816;
>   	port->membase		= NULL;

Thanks !
