Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0B64CF1E7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 07:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235569AbiCGGbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 01:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235519AbiCGGbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 01:31:19 -0500
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAC113CC0;
        Sun,  6 Mar 2022 22:30:24 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id qx21so29551570ejb.13;
        Sun, 06 Mar 2022 22:30:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MkSPdnyAeUKxX0kM80MyNU9CvUXu90j87BnnjXBHqBY=;
        b=uxI5VuDv90Cd9DiAIlMZGx9gfvD2XA3p5stoZYpviGmhDFC5pJ+u+GGxY3o4FnSM/X
         KWN4Wod13sLtTYxTx0IJdu62NDRb9k5I8m4mk67054sWsQO8q2JjsXzhsFWFMcwtlcKj
         MwyuFo496loLoEZTIeoghEjxM+QPkLnVO9ZxeApka4RkFKwumD8uOR3sU0V+mQF8k8Ld
         3sv7/8uQa++YsRCGNnuRzEjur0CTeqmDgY/LuU6uku7gYfGAO4NseUFd7/PJouyRQuRO
         GZsY/5HsiFJEzso1DXI2CmHYgIReTkiJnnlRZH8Zn0l14QM85AMnmyNESf6I2DRKzK1p
         Os7A==
X-Gm-Message-State: AOAM532Jo8ttnJFzsktnKZMoi7ENY5b7xJMTCi4BWtotCSY5kY2Ct1Zb
        fwARfQYlPtU3odBQo6T1IoUbJA6NvL4=
X-Google-Smtp-Source: ABdhPJzMTapDjVgFKnKGA113nvha2MqMEB17b0UDX5xUGuJnsLN0bPnqR6zwiRgZe21xWIPg8GM9FA==
X-Received: by 2002:a17:907:3da9:b0:6db:f3f:33c2 with SMTP id he41-20020a1709073da900b006db0f3f33c2mr4406449ejc.735.1646634623024;
        Sun, 06 Mar 2022 22:30:23 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id z11-20020a50e68b000000b00412ec8b2180sm5739486edm.90.2022.03.06.22.30.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Mar 2022 22:30:22 -0800 (PST)
Message-ID: <b10b87f9-2ccb-858c-dd88-5b8096acbb60@kernel.org>
Date:   Mon, 7 Mar 2022 07:30:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 1/7] tty: serial: samsung: embed s3c24xx_uart_info in
 parent structure
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220304080348.218581-1-krzysztof.kozlowski@canonical.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220304080348.218581-1-krzysztof.kozlowski@canonical.com>
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
> Embed "struct s3c24xx_uart_info" directly as a member of "struct
> s3c24xx_serial_drv_data" instead of keeping it as a pointer.  This makes
> the code clearer (obvious ownership of "struct s3c24xx_serial_drv_data")
> and saves one pointer.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> ---
>   drivers/tty/serial/samsung_tty.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index d002a4e48ed9..aa5678d03704 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -85,7 +85,7 @@ struct s3c24xx_uart_info {
>   };
>   
>   struct s3c24xx_serial_drv_data {
> -	struct s3c24xx_uart_info	*info;
> +	struct s3c24xx_uart_info	info;
>   	struct s3c2410_uartcfg		*def_cfg;
>   	unsigned int			fifosize[CONFIG_SERIAL_SAMSUNG_UARTS];
>   };
> @@ -2197,7 +2197,7 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
>   	}
>   
>   	ourport->baudclk = ERR_PTR(-EINVAL);
> -	ourport->info = ourport->drv_data->info;
> +	ourport->info = &ourport->drv_data->info;
>   	ourport->cfg = (dev_get_platdata(&pdev->dev)) ?
>   			dev_get_platdata(&pdev->dev) :
>   			ourport->drv_data->def_cfg;
> @@ -2616,7 +2616,7 @@ static struct console s3c24xx_serial_console = {
>   
>   #ifdef CONFIG_CPU_S3C2410
>   static struct s3c24xx_serial_drv_data s3c2410_serial_drv_data = {
> -	.info = &(struct s3c24xx_uart_info) {
> +	.info = {
>   		.name		= "Samsung S3C2410 UART",
>   		.type		= TYPE_S3C24XX,
>   		.port_type	= PORT_S3C2410,
> @@ -2644,7 +2644,7 @@ static struct s3c24xx_serial_drv_data s3c2410_serial_drv_data = {
>   
>   #ifdef CONFIG_CPU_S3C2412
>   static struct s3c24xx_serial_drv_data s3c2412_serial_drv_data = {
> -	.info = &(struct s3c24xx_uart_info) {
> +	.info = {
>   		.name		= "Samsung S3C2412 UART",
>   		.type		= TYPE_S3C24XX,
>   		.port_type	= PORT_S3C2412,
> @@ -2674,7 +2674,7 @@ static struct s3c24xx_serial_drv_data s3c2412_serial_drv_data = {
>   #if defined(CONFIG_CPU_S3C2440) || defined(CONFIG_CPU_S3C2416) || \
>   	defined(CONFIG_CPU_S3C2443) || defined(CONFIG_CPU_S3C2442)
>   static struct s3c24xx_serial_drv_data s3c2440_serial_drv_data = {
> -	.info = &(struct s3c24xx_uart_info) {
> +	.info = {
>   		.name		= "Samsung S3C2440 UART",
>   		.type		= TYPE_S3C24XX,
>   		.port_type	= PORT_S3C2440,
> @@ -2704,7 +2704,7 @@ static struct s3c24xx_serial_drv_data s3c2440_serial_drv_data = {
>   
>   #if defined(CONFIG_CPU_S3C6400) || defined(CONFIG_CPU_S3C6410)
>   static struct s3c24xx_serial_drv_data s3c6400_serial_drv_data = {
> -	.info = &(struct s3c24xx_uart_info) {
> +	.info = {
>   		.name		= "Samsung S3C6400 UART",
>   		.type		= TYPE_S3C6400,
>   		.port_type	= PORT_S3C6400,
> @@ -2733,7 +2733,7 @@ static struct s3c24xx_serial_drv_data s3c6400_serial_drv_data = {
>   
>   #ifdef CONFIG_CPU_S5PV210
>   static struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
> -	.info = &(struct s3c24xx_uart_info) {
> +	.info = {
>   		.name		= "Samsung S5PV210 UART",
>   		.type		= TYPE_S3C6400,
>   		.port_type	= PORT_S3C6400,
> @@ -2762,7 +2762,7 @@ static struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
>   
>   #if defined(CONFIG_ARCH_EXYNOS)
>   #define EXYNOS_COMMON_SERIAL_DRV_DATA()				\
> -	.info = &(struct s3c24xx_uart_info) {			\
> +	.info = {						\
>   		.name		= "Samsung Exynos UART",	\
>   		.type		= TYPE_S3C6400,			\
>   		.port_type	= PORT_S3C6400,			\
> @@ -2811,7 +2811,7 @@ static struct s3c24xx_serial_drv_data exynos850_serial_drv_data = {
>   
>   #ifdef CONFIG_ARCH_APPLE
>   static struct s3c24xx_serial_drv_data s5l_serial_drv_data = {
> -	.info = &(struct s3c24xx_uart_info) {
> +	.info = {
>   		.name		= "Apple S5L UART",
>   		.type		= TYPE_APPLE_S5L,
>   		.port_type	= PORT_8250,


-- 
js
suse labs
