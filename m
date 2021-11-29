Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83E77461705
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 14:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240377AbhK2Nx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 08:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234041AbhK2NvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 08:51:15 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D306C0619DF;
        Mon, 29 Nov 2021 04:32:58 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id f18so44174550lfv.6;
        Mon, 29 Nov 2021 04:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/OQtXxuCDkkNA+SGk/D8GbzeLEBGDJ8sMmutv4kMImU=;
        b=UAJVXxJDvZLKj8P0QbMduAXwc/nUDbhPh7ns9/q/FBDSGGMMeuUIm5yXX3F2LApWQV
         9gK2E2EbhwmzZ3mxZUnV9OIzoCYUEnBWcsMsx3hcB6hCX5EHovEUJch9nIygp5QnS8e8
         wpiR5r0oc+4K6rrk09aS1cSE8m4/CTNnZ9jKuqUzSCk6qdhH9IPIKZVL2jLfBKBS1zVp
         j/ElSqfkEeHNTHZpBVNxLrsV7aAah1zRapssVutZgAjmVaeM9swaJ7IriSKvX9EGTs/t
         h6vsF+Cw9HChi8N11fgNvqQ9lioQyJHg9Oyvmp+5GFPqgR0vUcm1rHUwzb4YCGjbxIJf
         yFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/OQtXxuCDkkNA+SGk/D8GbzeLEBGDJ8sMmutv4kMImU=;
        b=ryWFqiNc/WsOtiH9Wgd9u83Gt0Gy6EMegrd4+M13kYMudycNDI4MDNxWg2t4MPnY+g
         bI52kvtAfJotLGPqbPvm1x71EGNgQLfWftRXnINSg5PgfRM98UTk/4Lvfx6EpVswuoMU
         Tv1hZ2ceD0w9bcwWDE6yDIlAGpPkTpSa+GXIzGPbeHwh2Me/K/T1BHeuaG3ya7azNfBn
         vuY0L1RwuoXYendB1gYaqqhMkqdExFAt8bMM8i6pW89r1ioM5IfVfXeJKJKHVBwMqXeP
         JTirfKK+variQ3WhwO0ohDkV0rqjBA5PK6lt8qD44J2nw8nEPbS3cH3YwRWvf3i+44wy
         FAQw==
X-Gm-Message-State: AOAM531XZCVbBYvVE99cseiHyUNm08u544n01soCkDl4zmqV2wMhDeA1
        bWG5qwJOz0m6YmHcFulheX9j4i78BXM=
X-Google-Smtp-Source: ABdhPJyDmjUALtzfXXFYhG5PHPNGpxAIa/tzWJ+yzKmnLLTJ9T3mBov4hgppZMKMu5BCjGFV6R24Lw==
X-Received: by 2002:a05:6512:ba8:: with SMTP id b40mr48676735lfv.114.1638189175856;
        Mon, 29 Nov 2021 04:32:55 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.googlemail.com with ESMTPSA id v2sm1285755ljg.46.2021.11.29.04.32.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 04:32:55 -0800 (PST)
Subject: Re: [PATCH] serial: tegra: Fixes lower tolerance baud rate limit for
 older tegra chips introduced by d781ec21bae6
To:     Patrik John <patrik.john@u-blox.com>, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, ldewangan@nvidia.com,
        thierry.reding@gmail.com, jonathan@nvidia.com,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org
References: <sig.096060f39c.20211122124425.74031-1-patrik.john@u-blox.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <0165046b-c8bc-ec8e-05c7-bf9aea14339b@gmail.com>
Date:   Mon, 29 Nov 2021 15:32:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <sig.096060f39c.20211122124425.74031-1-patrik.john@u-blox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

22.11.2021 15:44, Patrik John пишет:
> The current implementation uses 0 as lower limit for the baud rate tolerance which contradicts the initial commit description (https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git/commit/drivers/tty/serial/serial-tegra.c?h=for-next&id=d781ec21bae6ff8f9e07682e8947a654484611f5) of +4/-4% tolerance for older tegra chips other than Tegra186 and Tegra194.
> This causes issues on UART initilization as soon as the actual baud rate clock is slightly lower than required which we have seen on the Tegra124-based Toradex Apalis TK1 which also uses tegra30-hsuart as compatible in the DT serial node (for reference line 1540ff https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git/tree/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi?h=for-next)
> 
> The standard baud rate tolerance limits are also stated in the tegra20-hsuart driver description (https://www.kernel.org/doc/Documentation/devicetree/bindings/serial/nvidia%2Ctegra20-hsuart.txt).
> 
> The previously introduced check_rate_in_range() always fails due to the lower limit set to 0 even if the actual baud rate is within the required -4% tolerance.
> 
> static int tegra_check_rate_in_range(struct tegra_uart_port *tup)
> {
>     long diff;
>     diff = ((long)(tup->configured_rate - tup->required_rate) * 10000)
>         / tup->required_rate;
>     if (diff < (tup->cdata->error_tolerance_low_range * 100) ||
>         diff > (tup->cdata->error_tolerance_high_range * 100)) {
>         dev_err(tup->uport.dev,
>             "configured baud rate is out of range by %ld", diff);
>         return -EIO;
>     }
>     return 0;
> }
> 
> Changing the lower tolerance limit to the actual -4% resolved the issues for the Tegra124 and should resolve potential issues for other Tegra20/Tegra30 based platforms as well.


Hi,

1. The text of commit message should be wrapped around 75 chars. Please
run "./scripts/checkpatch.pl example.patch" and fix all reported
problems before sending out the patch.

2. This patch should have v2 in the title. Please use the "git
format-patch -v3" next time, it will generate patch with v3 in the title.

3. Use "Link" tag and put all http links here, before the Signed-off-by
tag, like this:

Link:
https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git/commit/drivers/tty/serial/serial-tegra.c?h=for-next&id=d781ec21bae6ff8f9e07682e8947a654484611f5
Link:
https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git/tree/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi?h=for-next
Link:
https://www.kernel.org/doc/Documentation/devicetree/bindings/serial/nvidia%2Ctegra20-hsuart.txt

> Signed-off-by: Patrik John <patrik.john@u-blox.com>
> ---
>  drivers/tty/serial/serial-tegra.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
> index 45e2e4109acd..b6223fab0687 100644
> --- a/drivers/tty/serial/serial-tegra.c
> +++ b/drivers/tty/serial/serial-tegra.c
> @@ -1506,7 +1506,7 @@ static struct tegra_uart_chip_data tegra20_uart_chip_data = {
>  	.fifo_mode_enable_status	= false,
>  	.uart_max_port			= 5,
>  	.max_dma_burst_bytes		= 4,
> -	.error_tolerance_low_range	= 0,
> +	.error_tolerance_low_range	= -4,
>  	.error_tolerance_high_range	= 4,
>  };
>  
> @@ -1517,7 +1517,7 @@ static struct tegra_uart_chip_data tegra30_uart_chip_data = {
>  	.fifo_mode_enable_status	= false,
>  	.uart_max_port			= 5,
>  	.max_dma_burst_bytes		= 4,
> -	.error_tolerance_low_range	= 0,
> +	.error_tolerance_low_range	= -4,
>  	.error_tolerance_high_range	= 4,
>  };
>  
> 

