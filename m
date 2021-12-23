Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5D1247E3C5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 13:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348470AbhLWMyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 07:54:21 -0500
Received: from foss.arm.com ([217.140.110.172]:41548 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232966AbhLWMyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 07:54:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28C55D6E;
        Thu, 23 Dec 2021 04:54:20 -0800 (PST)
Received: from [10.57.66.229] (unknown [10.57.66.229])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 846F23F5A1;
        Thu, 23 Dec 2021 04:54:18 -0800 (PST)
Message-ID: <bd63bad8-df67-4d98-8dd0-26af33ae961b@arm.com>
Date:   Thu, 23 Dec 2021 12:54:06 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v3] serial: mps2-uart: Check for error irq
Content-Language: en-GB
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, andy.shevchenko@gmail.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        liviu.dudau@arm.com, sudeep.holla@arm.com,
        lorenzo.pieralisi@arm.com
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20211223121418.1330239-1-jiasheng@iscas.ac.cn>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211223121418.1330239-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-23 12:14, Jiasheng Jiang wrote:
> Because of the possible failure of the platform_get_irq(), it should be
> better to check it to avoid the use of error irq.

As far as I can see, the only "use" of error values is that they will be 
passed to request_irq(), which will then return -EINVAL because they are 
not valid IRQ numbers, and that error will be handled appropriately. I 
think that's a relatively common pattern, so your commit message should 
really describe why you think it's a problem and why this addition is a 
meaningful improvement.

Robin.

> Fixes: 041f031def33 ("serial: mps2-uart: add MPS2 UART driver")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
> Changelog:
> 
> v2 -> v3
> 
> *Change 1. Using error variable to check.
> *Change 2. Add new commit message.
> ---
>   drivers/tty/serial/mps2-uart.c | 26 ++++++++++++++++++++++----
>   1 file changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/mps2-uart.c b/drivers/tty/serial/mps2-uart.c
> index 587b42f754cb..24a52300d8d9 100644
> --- a/drivers/tty/serial/mps2-uart.c
> +++ b/drivers/tty/serial/mps2-uart.c
> @@ -584,11 +584,29 @@ static int mps2_init_port(struct platform_device *pdev,
>   
>   
>   	if (mps_port->flags & UART_PORT_COMBINED_IRQ) {
> -		mps_port->port.irq = platform_get_irq(pdev, 0);
> +		ret = platform_get_irq(pdev, 0);
> +		if (ret < 0)
> +			return ret;
> +
> +		mps_port->port.irq = ret;
>   	} else {
> -		mps_port->rx_irq = platform_get_irq(pdev, 0);
> -		mps_port->tx_irq = platform_get_irq(pdev, 1);
> -		mps_port->port.irq = platform_get_irq(pdev, 2);
> +		ret = platform_get_irq(pdev, 0);
> +		if (ret < 0)
> +			return ret;
> +
> +		mps_port->rx_irq = ret;
> +
> +		ret = platform_get_irq(pdev, 1);
> +		if (ret < 0)
> +			return ret;
> +
> +		mps_port->tx_irq = ret;
> +
> +		ret = platform_get_irq(pdev, 2);
> +		if (ret < 0)
> +			return ret;
> +
> +		mps_port->port.irq = ret;
>   	}
>   
>   	return ret;
