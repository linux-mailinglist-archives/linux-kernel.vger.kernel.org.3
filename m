Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1DC04A64F0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 20:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242318AbiBATYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 14:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242278AbiBATYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 14:24:53 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E55C061714;
        Tue,  1 Feb 2022 11:24:53 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id v74so16775655pfc.1;
        Tue, 01 Feb 2022 11:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WtH7J3WjmpcbZAmRlDiPtipYhiaSIsPLmtCwtZTQaEg=;
        b=fISu+HkAuf2TIGFzCTkNccdPeeMZDiwM8MEL7h1vd3cz9tNXhx297rf37ArL2vRaNu
         Dn0EDiHRycMoL8bX/iTXeoza8FQrwaDRyOgOx9d1a+9V0D5y1/MuNoMAYqfI6dDDvHnE
         SZki9pHC8doyCKPuI4SeHAgsLpfDmW3ytPwmwdd8mduOnySDIYdolsD+mVMVD/djYoas
         oD6i8ujIc6dU5ZpIu4ZvLp7M3j0I9eKBtAOqvVqmt16rYzmcoLL7nXheEsA7X+dvWoOy
         4BrbNSFaxsNqBUgpmA70I81v8YEv1l+ywXjj4FrZcf6pZUI4wyOGaynFWokpm1e/zeSX
         9nVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WtH7J3WjmpcbZAmRlDiPtipYhiaSIsPLmtCwtZTQaEg=;
        b=ytMov5feBQmwETESaYbLAXmN1MxD1DMuH4GsYooMIOA3Nu8I+W9zUjqHgu82aLrLiG
         DKDIA6AGAyqujTw+Aa9qfPiaPU15h6GaV4PI33fXzmFMxeqN90LqOxqAEq7DqhQ9CT3D
         1eBZ5ew6a94+AHPkfhEcX9RcncN3qQHjin6tf2f6I3XWQwI9LTeriSzdheDjyxK368cm
         LXESCH0BmI5jlpQwjg+JryNlALIj92qLRxWEg3LttH8BoA9Ha7dHy032Kl4dB+/eHhq8
         mrxIAknDhfc8bhCQKBkh92mefsuO7F06zhWN30Gi4XkJPcLGB1kw6o3gQqkRg14gKWHP
         WZBg==
X-Gm-Message-State: AOAM531tFmF91fZpfZ40Cn2l3aWUMcc/1I5i7o5IcA3XhRSdvjZz/RDR
        EtW/u9bV5AK0H+PqavTGIxM=
X-Google-Smtp-Source: ABdhPJztbYfkU+KttE8wtn650VxT8mj072Kn+nowKQeuvZyet6ZgN7WG6P6mqBVmuYIMdgqBVnIfCw==
X-Received: by 2002:a05:6a00:2cf:: with SMTP id b15mr12530341pft.0.1643743492539;
        Tue, 01 Feb 2022 11:24:52 -0800 (PST)
Received: from [10.230.2.88] ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id mi18sm3531329pjb.35.2022.02.01.11.24.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 11:24:51 -0800 (PST)
Message-ID: <412a456d-7294-a124-8a01-f052915348b4@gmail.com>
Date:   Tue, 1 Feb 2022 11:24:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] serial: 8250_bcm2835aux: Add ACPI support
Content-Language: en-US
To:     Adrien Thierry <athierry@redhat.com>, linux-serial@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Jeremy Linton <jeremy.linton@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
References: <20220201185001.926338-1-athierry@redhat.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220201185001.926338-1-athierry@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/1/2022 10:50 AM, Adrien Thierry wrote:
> Add ACPI support to 8250_bcm2835aux driver. This makes it possible to
> use the miniuart on the Raspberry Pi with the tianocore/edk2 UEFI
> firmware.
> 
> Signed-off-by: Adrien Thierry <athierry@redhat.com>
> ---
>   drivers/tty/serial/8250/8250_bcm2835aux.c | 103 +++++++++++++++++-----
>   1 file changed, 83 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/serial/8250/8250_bcm2835aux.c
> index fd95860cd..b904b321e 100644
> --- a/drivers/tty/serial/8250/8250_bcm2835aux.c
> +++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
> @@ -12,6 +12,7 @@
>    * simultaneously to rs485.
>    */
>   
> +#include <linux/acpi.h>
>   #include <linux/clk.h>
>   #include <linux/io.h>
>   #include <linux/module.h>
> @@ -44,6 +45,10 @@ struct bcm2835aux_data {
>   	u32 cntl;
>   };
>   
> +struct bcm2835_aux_serial_acpi_driver_data {
> +	resource_size_t offset;
> +};
> +
>   static void bcm2835aux_rs485_start_tx(struct uart_8250_port *up)
>   {
>   	if (!(up->port.rs485.flags & SER_RS485_RX_DURING_TX)) {
> @@ -82,8 +87,12 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
>   {
>   	struct uart_8250_port up = { };
>   	struct bcm2835aux_data *data;
> +	struct bcm2835_aux_serial_acpi_driver_data *acpi_data;
>   	struct resource *res;
>   	int ret;
> +	resource_size_t mapbase;
> +	resource_size_t mapsize;
> +	unsigned int uartclk;
>   
>   	/* allocate the custom structure */
>   	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> @@ -108,10 +117,12 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
>   
>   	platform_set_drvdata(pdev, data);
>   
> -	/* get the clock - this also enables the HW */
> -	data->clk = devm_clk_get(&pdev->dev, NULL);
> -	if (IS_ERR(data->clk))
> -		return dev_err_probe(&pdev->dev, PTR_ERR(data->clk), "could not get clk\n");
> +	if (dev_of_node(&pdev->dev)) {
> +		/* get the clock - this also enables the HW */
> +		data->clk = devm_clk_get(&pdev->dev, NULL);
> +		if (IS_ERR(data->clk))
> +			return dev_err_probe(&pdev->dev, PTR_ERR(data->clk), "could not get clk\n");
> +	}

This does not seem necessary, if the clk is NULL when probed via ACPI, 
all of the clk_* APIs will deal with that gracefully. If you need not to 
treat -ENOENT as a hard error here, consider switching to 
devm_clk_get_optional(). Given that you look at the 'clock-frequency' 
property, you can still have some generic code, something like:

	if (IS_ERR(data->clk)) {
		ret = device_property_read_u32(&pdev->dev, "clock-frequency", &uartclk);
		if (ret)
			return dev_err_probe(&pdev->dev, ret, "could not get clk\n");
	}

>   
>   	/* get the interrupt */
>   	ret = platform_get_irq(pdev, 0);
> @@ -125,20 +136,59 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
>   		dev_err(&pdev->dev, "memory resource not found");
>   		return -EINVAL;
>   	}
> -	up.port.mapbase = res->start;
> -	up.port.mapsize = resource_size(res);
> -
> -	/* Check for a fixed line number */
> -	ret = of_alias_get_id(pdev->dev.of_node, "serial");
> -	if (ret >= 0)
> -		up.port.line = ret;
> -
> -	/* enable the clock as a last step */
> -	ret = clk_prepare_enable(data->clk);
> -	if (ret) {
> -		dev_err(&pdev->dev, "unable to enable uart clock - %d\n",
> -			ret);
> -		return ret;

All of that path can be common, and you can just define an offset to 
apply to the resource at the top after you fetched the memory resource. 
The offset will be non-0 for ACPI and 0 for non-ACPI. That is, no need 
for the intermediate variables and conditional paths whether this is 
ACPI apply this offset, or not.

> +
> +	mapbase = res->start;
> +	mapsize = resource_size(res);
> +
> +	if (has_acpi_companion(&pdev->dev)) {
> +		const struct acpi_device_id *match;
> +
> +		match = acpi_match_device(pdev->dev.driver->acpi_match_table, &pdev->dev);
> +		if (!match)
> +			return -ENODEV;
> +
> +		acpi_data = (struct bcm2835_aux_serial_acpi_driver_data *)match->driver_data;
> +
> +		/* Some UEFI implementations (e.g. tianocore/edk2 for the Raspberry Pi)
> +		 * describe the miniuart with a base address that encompasses the auxiliary
> +		 * registers shared between the miniuart and spi.
> +		 *
> +		 * This is due to historical reasons, see discussion here :
> +		 * https://edk2.groups.io/g/devel/topic/87501357#84349
> +		 *
> +		 * We need to add the offset between the miniuart and auxiliary
> +		 * registers to get the real miniuart base address.

And ACPI on the Pi4 is so widely deployed that fixing the miniuart 
resources is not an option at all? This really really continues to 
contribute to my impression that ACPI on the Pi4 is a fad more than a 
real thing, sorry.
-- 
Florian
