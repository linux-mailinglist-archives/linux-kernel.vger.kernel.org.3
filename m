Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B80CB49DF72
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 11:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239484AbiA0K3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 05:29:18 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:53749 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239472AbiA0K3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 05:29:14 -0500
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id B5EA8200007;
        Thu, 27 Jan 2022 10:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1643279353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rHeKMXAaLg6IuvGDnn0shLvzStT/hC8/1M7xoIXIxrI=;
        b=lzX/2ah9KiYW8ZzpNYXXE68QxFOx/BqCp/q9phw6VTvFjy1Z+CMRmnar/w4+3uL/1/02n6
        wlf+kTebg2zFVgPNmTWKW5WHy7rL+ZiOVEsTWaaTQvv2LbjVeNdu4Kihrv1fMZm4nC08BF
        ZgEzKg55761a9qoaWrxuVOxJGP1mqXYd+rx+b9hWZ5vw10W6Rfo7F0MYUf4b7Epxoww2Kd
        2qummBx7wXUKvEG11KWgcm4jGzbi+DFagpeHmR9DHSkX50GkzgmniBAlkwHUgjdQI1gjmr
        FIQ3RF1pbbk0X7+0MteEuJJ0xUN09ikmbp2z9FvsyQryydmfr4cmVJMmNSKd0w==
Date:   Thu, 27 Jan 2022 11:29:11 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        nicolas.ferre@microchip.com, ludovic.desroches@microchip.com,
        tudor.ambarus@microchip.com, UNGLinuxDriver@microchip.com,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: atmel: add support for AES and SHA IPs available
 on lan966x SoC
Message-ID: <YfJz91kchrcX9Xqe@piout.net>
References: <20220127080408.15791-1-kavyasree.kotagiri@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127080408.15791-1-kavyasree.kotagiri@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/2022 13:34:08+0530, Kavyasree Kotagiri wrote:
> This patch adds support for hardware version of AES and SHA IPs
> available on lan966x SoC.
> 
> Tested-by: Vradha Panchal <vradha.panchal@microchip.com>
> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> ---
>  drivers/crypto/atmel-aes.c | 2 ++
>  drivers/crypto/atmel-sha.c | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/crypto/atmel-aes.c b/drivers/crypto/atmel-aes.c
> index fe0558403191..358f1092d890 100644
> --- a/drivers/crypto/atmel-aes.c
> +++ b/drivers/crypto/atmel-aes.c
> @@ -2509,6 +2509,8 @@ static void atmel_aes_get_cap(struct atmel_aes_dev *dd)
>  
>  	/* keep only major version number */
>  	switch (dd->hw_version & 0xff0) {
> +	case 0x700:
> +		fallthrough;

I don't think fallthrough is needed in that case.
>  	case 0x500:
>  		dd->caps.has_dualbuff = 1;
>  		dd->caps.has_cfb64 = 1;
> diff --git a/drivers/crypto/atmel-sha.c b/drivers/crypto/atmel-sha.c
> index 1b13f601fd95..6c7bb91c8cce 100644
> --- a/drivers/crypto/atmel-sha.c
> +++ b/drivers/crypto/atmel-sha.c
> @@ -2508,6 +2508,8 @@ static void atmel_sha_get_cap(struct atmel_sha_dev *dd)
>  
>  	/* keep only major version number */
>  	switch (dd->hw_version & 0xff0) {
> +	case 0x700:
> +		fallthrough;
>  	case 0x510:
>  		dd->caps.has_dma = 1;
>  		dd->caps.has_dualbuff = 1;
> -- 
> 2.17.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
