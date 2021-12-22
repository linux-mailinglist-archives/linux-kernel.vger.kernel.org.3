Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFF047CFE5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 11:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244142AbhLVKXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 05:23:22 -0500
Received: from foss.arm.com ([217.140.110.172]:43254 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239964AbhLVKXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 05:23:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 756301FB;
        Wed, 22 Dec 2021 02:23:17 -0800 (PST)
Received: from [10.57.5.178] (unknown [10.57.5.178])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 625723F718;
        Wed, 22 Dec 2021 02:23:15 -0800 (PST)
Subject: Re: [PATCH] serial: mps2-uart: Check for error irq
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, liviu.dudau@arm.com, sudeep.holla@arm.com,
        lorenzo.pieralisi@arm.com
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20211222033604.1049339-1-jiasheng@iscas.ac.cn>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <7147a531-2537-81e6-6c4b-2c3c98c6ec59@arm.com>
Date:   Wed, 22 Dec 2021 10:23:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211222033604.1049339-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/22/21 3:36 AM, Jiasheng Jiang wrote:
> I find that platform_get_irq() will not always succeed.
> It will return error irq in case there is no suitable irq.
> Therefore, it might be better to check it if order to avoid the use of
> error irq.
> 
> Fixes: 041f031def33 ("serial: mps2-uart: add MPS2 UART driver")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/tty/serial/mps2-uart.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/tty/serial/mps2-uart.c b/drivers/tty/serial/mps2-uart.c
> index 587b42f754cb..117d9896051f 100644
> --- a/drivers/tty/serial/mps2-uart.c
> +++ b/drivers/tty/serial/mps2-uart.c
> @@ -585,10 +585,20 @@ static int mps2_init_port(struct platform_device *pdev,
>  
>  	if (mps_port->flags & UART_PORT_COMBINED_IRQ) {
>  		mps_port->port.irq = platform_get_irq(pdev, 0);
> +		if (mps_port->port.irq < 0)
> +			return mps_port->port.irq;
>  	} else {
>  		mps_port->rx_irq = platform_get_irq(pdev, 0);
> +		if (mps_port->rx_irq < 0)
> +			return mps_port->rx_irq;
> +
>  		mps_port->tx_irq = platform_get_irq(pdev, 1);
> +		if (mps_port->tx_irq < 0)
> +			return mps_port->tx_irq;
> +
>  		mps_port->port.irq = platform_get_irq(pdev, 2);
> +		if (mps_port->port.irq < 0)
> +			return mps_port->port.irq;
>  	}
>  
>  	return ret;
> 

Acked-by: Vladimir Murzin <vladimir.murzin@arm.com>
