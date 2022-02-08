Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2CA4AD210
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 08:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348015AbiBHHSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 02:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235298AbiBHHSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 02:18:22 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F6B4C0401F2;
        Mon,  7 Feb 2022 23:18:19 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5BFD2B;
        Mon,  7 Feb 2022 23:18:18 -0800 (PST)
Received: from [192.168.122.164] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63F4E3F73B;
        Mon,  7 Feb 2022 23:18:18 -0800 (PST)
Message-ID: <827f3c8b-b89a-018f-a5af-3984c7bc8492@arm.com>
Date:   Tue, 8 Feb 2022 01:18:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v3] serial: 8250_bcm2835aux: Add ACPI support
Content-Language: en-US
To:     Adrien Thierry <athierry@redhat.com>, linux-serial@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
References: <20220207232129.402882-1-athierry@redhat.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <20220207232129.402882-1-athierry@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/7/22 17:21, Adrien Thierry wrote:
> Add ACPI support to 8250_bcm2835aux driver. This makes it possible to
> use the miniuart on the Raspberry Pi with the tianocore/edk2 UEFI
> firmware.

I merged this to 5.17rc3, switched the console to this device and it now 
works in linux! Thanks for doing this!

Tested-by: Jeremy Linton <jeremy.linton@arm.com>

> 
> Signed-off-by: Adrien Thierry <athierry@redhat.com>
> ---
> V1 -> V2: Refactored code to remove unnecessary conditional paths and
> intermediate variables
> V2 -> V3: Cleaned up coding style and addressed review comments
> 
>   drivers/tty/serial/8250/8250_bcm2835aux.c | 52 ++++++++++++++++++++---
>   1 file changed, 46 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/serial/8250/8250_bcm2835aux.c
> index fd95860cd661..2a1226a78a0c 100644
> --- a/drivers/tty/serial/8250/8250_bcm2835aux.c
> +++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
> @@ -17,6 +17,7 @@
>   #include <linux/module.h>
>   #include <linux/of.h>
>   #include <linux/platform_device.h>
> +#include <linux/property.h>
>   
>   #include "8250.h"
>   
> @@ -44,6 +45,10 @@ struct bcm2835aux_data {
>   	u32 cntl;
>   };
>   
> +struct bcm2835_aux_serial_driver_data {
> +	resource_size_t offset;
> +};
> +
>   static void bcm2835aux_rs485_start_tx(struct uart_8250_port *up)
>   {
>   	if (!(up->port.rs485.flags & SER_RS485_RX_DURING_TX)) {
> @@ -80,9 +85,12 @@ static void bcm2835aux_rs485_stop_tx(struct uart_8250_port *up)
>   
>   static int bcm2835aux_serial_probe(struct platform_device *pdev)
>   {
> +	const struct bcm2835_aux_serial_driver_data *bcm_data;
>   	struct uart_8250_port up = { };
>   	struct bcm2835aux_data *data;
> +	resource_size_t offset = 0;
>   	struct resource *res;
> +	unsigned int uartclk;
>   	int ret;
>   
>   	/* allocate the custom structure */
> @@ -109,9 +117,7 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
>   	platform_set_drvdata(pdev, data);
>   
>   	/* get the clock - this also enables the HW */
> -	data->clk = devm_clk_get(&pdev->dev, NULL);
> -	if (IS_ERR(data->clk))
> -		return dev_err_probe(&pdev->dev, PTR_ERR(data->clk), "could not get clk\n");
> +	data->clk = devm_clk_get_optional(&pdev->dev, NULL);
>   
>   	/* get the interrupt */
>   	ret = platform_get_irq(pdev, 0);
> @@ -125,8 +131,24 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
>   		dev_err(&pdev->dev, "memory resource not found");
>   		return -EINVAL;
>   	}
> -	up.port.mapbase = res->start;
> -	up.port.mapsize = resource_size(res);
> +
> +	bcm_data = device_get_match_data(&pdev->dev);
> +
> +	/* Some UEFI implementations (e.g. tianocore/edk2 for the Raspberry Pi)
> +	 * describe the miniuart with a base address that encompasses the auxiliary
> +	 * registers shared between the miniuart and spi.
> +	 *
> +	 * This is due to historical reasons, see discussion here :
> +	 * https://edk2.groups.io/g/devel/topic/87501357#84349
> +	 *
> +	 * We need to add the offset between the miniuart and auxiliary
> +	 * registers to get the real miniuart base address.
> +	 */
> +	if (bcm_data)
> +		offset = bcm_data->offset;
> +
> +	up.port.mapbase = res->start + offset;
> +	up.port.mapsize = resource_size(res) - offset;
>   
>   	/* Check for a fixed line number */
>   	ret = of_alias_get_id(pdev->dev.of_node, "serial");
> @@ -141,12 +163,19 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
>   		return ret;
>   	}
>   
> +	uartclk = clk_get_rate(data->clk);
> +	if (!uartclk) {
> +		ret = device_property_read_u32(&pdev->dev, "clock-frequency", &uartclk);
> +		if (ret)
> +			return dev_err_probe(&pdev->dev, ret, "could not get clk rate\n");
> +	}
> +
>   	/* the HW-clock divider for bcm2835aux is 8,
>   	 * but 8250 expects a divider of 16,
>   	 * so we have to multiply the actual clock by 2
>   	 * to get identical baudrates.
>   	 */
> -	up.port.uartclk = clk_get_rate(data->clk) * 2;
> +	up.port.uartclk = uartclk * 2;
>   
>   	/* register the port */
>   	ret = serial8250_register_8250_port(&up);
> @@ -173,16 +202,27 @@ static int bcm2835aux_serial_remove(struct platform_device *pdev)
>   	return 0;
>   }
>   
> +static const struct bcm2835_aux_serial_driver_data bcm2835_acpi_data = {
> +	.offset = 0x40,
> +};
> +
>   static const struct of_device_id bcm2835aux_serial_match[] = {
>   	{ .compatible = "brcm,bcm2835-aux-uart" },
>   	{ },
>   };
>   MODULE_DEVICE_TABLE(of, bcm2835aux_serial_match);
>   
> +static const struct acpi_device_id bcm2835aux_serial_acpi_match[] = {
> +	{ "BCM2836", (kernel_ulong_t)&bcm2835_acpi_data },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, bcm2835aux_serial_acpi_match);
> +
>   static struct platform_driver bcm2835aux_serial_driver = {
>   	.driver = {
>   		.name = "bcm2835-aux-uart",
>   		.of_match_table = bcm2835aux_serial_match,
> +		.acpi_match_table = bcm2835aux_serial_acpi_match,
>   	},
>   	.probe  = bcm2835aux_serial_probe,
>   	.remove = bcm2835aux_serial_remove,
> 
> base-commit: 2ade8eef993c37a2a43e51a9b1f6c25509a2acce
> 

