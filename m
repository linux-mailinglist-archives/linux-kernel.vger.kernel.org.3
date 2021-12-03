Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC78467316
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 09:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379122AbhLCIIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 03:08:32 -0500
Received: from mleia.com ([178.79.152.223]:60400 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351105AbhLCIIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 03:08:31 -0500
X-Greylist: delayed 475 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Dec 2021 03:08:31 EST
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id 0E5EB3809A0;
        Fri,  3 Dec 2021 07:56:42 +0000 (UTC)
Received: from [192.168.1.102] (88-113-46-102.elisa-laajakaista.fi [88.113.46.102])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.mleia.com (Postfix) with ESMTPSA id A95D23808DE;
        Fri,  3 Dec 2021 07:56:41 +0000 (UTC)
Subject: Re: [PATCH RESEND] gpio: lpc32xx: Handle devm_gpiochip_add_data error
 codes
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com
Cc:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20211203074934.1559805-1-jiasheng@iscas.ac.cn>
From:   Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <0b6c05ec-638a-10d5-a3e7-e6bf69adb678@mleia.com>
Date:   Fri, 3 Dec 2021 09:56:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20211203074934.1559805-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20211203_075642_081474_F9ADD3D4 
X-CRM114-Status: GOOD (  18.07  )
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/21 9:49 AM, Jiasheng Jiang wrote:
> The return value of devm_gpiochip_add_data() is not always 0.
> To catch the exception in case of the failure.
> 
> Fixes: 69c0a0a52cde ("gpio: lpc32xx: Use devm_gpiochip_add_data() for gpio registration")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>   drivers/gpio/gpio-lpc32xx.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpio-lpc32xx.c b/drivers/gpio/gpio-lpc32xx.c
> index 4e626c4235c2..e3b734302b76 100644
> --- a/drivers/gpio/gpio-lpc32xx.c
> +++ b/drivers/gpio/gpio-lpc32xx.c
> @@ -505,6 +505,7 @@ static int lpc32xx_of_xlate(struct gpio_chip *gc,
>   static int lpc32xx_gpio_probe(struct platform_device *pdev)
>   {
>   	int i;
> +	int err;

This was missed in v1, so formally it is not a resend, but a v2 change.

>   	void __iomem *reg_base;
>   
>   	reg_base = devm_platform_ioremap_resource(pdev, 0);
> @@ -518,8 +519,10 @@ static int lpc32xx_gpio_probe(struct platform_device *pdev)
>   			lpc32xx_gpiochip[i].chip.of_node = pdev->dev.of_node;
>   			lpc32xx_gpiochip[i].reg_base = reg_base;
>   		}
> -		devm_gpiochip_add_data(&pdev->dev, &lpc32xx_gpiochip[i].chip,
> +		err = devm_gpiochip_add_data(&pdev->dev, &lpc32xx_gpiochip[i].chip,
>   				  &lpc32xx_gpiochip[i]);
> +		if (err)
> +			return err;
>   	}
>   
>   	return 0;
> 

Thank you for the fix.

Acked-by: Vladimir Zapolskiy <vz@mleia.com>

--
Best wishes,
Vladimir
