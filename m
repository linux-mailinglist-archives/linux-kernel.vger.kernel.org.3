Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242F94CF1EA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 07:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235581AbiCGGcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 01:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233739AbiCGGcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 01:32:13 -0500
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB8513CCA;
        Sun,  6 Mar 2022 22:31:19 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id kt27so29714467ejb.0;
        Sun, 06 Mar 2022 22:31:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tcP2V1vWKMWM9jKLMoMB47VypO0vlzwdfd5gY8DsMpI=;
        b=nbCv/O/dRKnCOZuBI8BrYmo5xX7lH+SUG3t8myZAosucNE/w69v6ybXJQE9C2rk9YN
         PfW4Zf/TGZIfkYdcs8YUyJNhEa6NovvSqp5EihALsu+aFsZhbPTxCbN+hwcfrYTSkOy+
         MH74wtxWF94J0rBhmIJ+PCw3gB4Y0Ob5BFoYDLsSF2xUoJBEKtIKX6BIgK7nSFIjmeE4
         yi4c9c2QSyg9yNNChOKb6yOf0Y8Cx7iYc2XGF0VH3X6e+cSarSpkDsHVKBDIZzBgbW+T
         /anQVPiLOTzl9MGS2IY0yEjXEzV84Xn3Siyg549JO7Y3fmxTLgcBTXr4aUZGlgd4O09s
         1UsA==
X-Gm-Message-State: AOAM532c//E1OU9AryEKK2mKRSSDw0ZT4RF8kHY8oiSwuXDSqWr9l7rO
        1TpHpT+6JTWyoL4DvdWy+no=
X-Google-Smtp-Source: ABdhPJzo3uYcG3w5zpPi6zGX5rpCwtIqdZS5fbpY8IxRFHM2nlvH9k+xQzWlIVAbAfNMPxJw7ELv1w==
X-Received: by 2002:a17:906:698a:b0:6ce:b983:babf with SMTP id i10-20020a170906698a00b006ceb983babfmr7874720ejr.553.1646634678081;
        Sun, 06 Mar 2022 22:31:18 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id g13-20020a50bf4d000000b00410d407da2esm5786341edk.13.2022.03.06.22.31.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Mar 2022 22:31:17 -0800 (PST)
Message-ID: <e1cb34ab-2ed4-0855-b59b-aa6e5a9206f8@kernel.org>
Date:   Mon, 7 Mar 2022 07:31:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 2/7] tty: serial: samsung: embed s3c2410_uartcfg in parent
 structure
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220304080348.218581-1-krzysztof.kozlowski@canonical.com>
 <20220304080348.218581-2-krzysztof.kozlowski@canonical.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220304080348.218581-2-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04. 03. 22, 9:03, Krzysztof Kozlowski wrote:
> Embed "struct s3c2410_uartcfg" directly as a member of "struct
> s3c24xx_serial_drv_data" instead of keeping it as a pointer.  This makes
> the code clearer (obvious ownership of "s3c2410_uartcfg
> s3c24xx_serial_drv_data") and saves one pointer.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>


> ---
>   drivers/tty/serial/samsung_tty.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index aa5678d03704..a9a75b5b9705 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -86,7 +86,7 @@ struct s3c24xx_uart_info {
>   
>   struct s3c24xx_serial_drv_data {
>   	struct s3c24xx_uart_info	info;
> -	struct s3c2410_uartcfg		*def_cfg;
> +	struct s3c2410_uartcfg		def_cfg;
>   	unsigned int			fifosize[CONFIG_SERIAL_SAMSUNG_UARTS];
>   };
>   
> @@ -2200,7 +2200,7 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
>   	ourport->info = &ourport->drv_data->info;
>   	ourport->cfg = (dev_get_platdata(&pdev->dev)) ?
>   			dev_get_platdata(&pdev->dev) :
> -			ourport->drv_data->def_cfg;
> +			&ourport->drv_data->def_cfg;
>   
>   	switch (ourport->info->type) {
>   	case TYPE_S3C24XX:
> @@ -2632,7 +2632,7 @@ static struct s3c24xx_serial_drv_data s3c2410_serial_drv_data = {
>   		.clksel_mask	= S3C2410_UCON_CLKMASK,
>   		.clksel_shift	= S3C2410_UCON_CLKSHIFT,
>   	},
> -	.def_cfg = &(struct s3c2410_uartcfg) {
> +	.def_cfg = {
>   		.ucon		= S3C2410_UCON_DEFAULT,
>   		.ufcon		= S3C2410_UFCON_DEFAULT,
>   	},
> @@ -2661,7 +2661,7 @@ static struct s3c24xx_serial_drv_data s3c2412_serial_drv_data = {
>   		.clksel_mask	= S3C2412_UCON_CLKMASK,
>   		.clksel_shift	= S3C2412_UCON_CLKSHIFT,
>   	},
> -	.def_cfg = &(struct s3c2410_uartcfg) {
> +	.def_cfg = {
>   		.ucon		= S3C2410_UCON_DEFAULT,
>   		.ufcon		= S3C2410_UFCON_DEFAULT,
>   	},
> @@ -2692,7 +2692,7 @@ static struct s3c24xx_serial_drv_data s3c2440_serial_drv_data = {
>   		.clksel_shift	= S3C2412_UCON_CLKSHIFT,
>   		.ucon_mask	= S3C2440_UCON0_DIVMASK,
>   	},
> -	.def_cfg = &(struct s3c2410_uartcfg) {
> +	.def_cfg = {
>   		.ucon		= S3C2410_UCON_DEFAULT,
>   		.ufcon		= S3C2410_UFCON_DEFAULT,
>   	},
> @@ -2721,7 +2721,7 @@ static struct s3c24xx_serial_drv_data s3c6400_serial_drv_data = {
>   		.clksel_mask	= S3C6400_UCON_CLKMASK,
>   		.clksel_shift	= S3C6400_UCON_CLKSHIFT,
>   	},
> -	.def_cfg = &(struct s3c2410_uartcfg) {
> +	.def_cfg = {
>   		.ucon		= S3C2410_UCON_DEFAULT,
>   		.ufcon		= S3C2410_UFCON_DEFAULT,
>   	},
> @@ -2749,7 +2749,7 @@ static struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
>   		.clksel_mask	= S5PV210_UCON_CLKMASK,
>   		.clksel_shift	= S5PV210_UCON_CLKSHIFT,
>   	},
> -	.def_cfg = &(struct s3c2410_uartcfg) {
> +	.def_cfg = {
>   		.ucon		= S5PV210_UCON_DEFAULT,
>   		.ufcon		= S5PV210_UFCON_DEFAULT,
>   	},
> @@ -2778,7 +2778,7 @@ static struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
>   		.clksel_mask	= 0,				\
>   		.clksel_shift	= 0,				\
>   	},							\
> -	.def_cfg = &(struct s3c2410_uartcfg) {			\
> +	.def_cfg = {						\
>   		.ucon		= S5PV210_UCON_DEFAULT,		\
>   		.ufcon		= S5PV210_UFCON_DEFAULT,	\
>   		.has_fracval	= 1,				\
> @@ -2827,7 +2827,7 @@ static struct s3c24xx_serial_drv_data s5l_serial_drv_data = {
>   		.clksel_mask	= 0,
>   		.clksel_shift	= 0,
>   	},
> -	.def_cfg = &(struct s3c2410_uartcfg) {
> +	.def_cfg = {
>   		.ucon		= APPLE_S5L_UCON_DEFAULT,
>   		.ufcon		= S3C2410_UFCON_DEFAULT,
>   	},


-- 
js
suse labs
