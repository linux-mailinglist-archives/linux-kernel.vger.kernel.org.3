Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121CA5A5C10
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 08:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiH3Gqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 02:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiH3Gq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 02:46:28 -0400
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CE35E57A;
        Mon, 29 Aug 2022 23:46:27 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id u6so12853401eda.12;
        Mon, 29 Aug 2022 23:46:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=5Yaa0kovEFloTn1R4Z/IqbqPs448soNcE+Du57d7eds=;
        b=hdz6sZqtpfYfECKPxWE7Vj5UQzfla0QR0EWgQfeGPBHjmeNy4AuaFThoxd2VKB66vo
         NXCmQ4TQD4DCr7KeEg//VLe16N3jerH7DHWFcNa53txse3e+iIMyuevP5wno4Xk8QnS4
         Ebhq7oc6/bdBY/CiTAu4+fK3siroqO7tRfbaL1pv86RmvBY839B1EzmY8P6mQaugVkUy
         iy4pAZ+CyOUM7s6QsmhQ9ms+wLdBCNuBMXElq7dPr08DxZugXVjhJ57od49Ea4vPffy9
         o8xw5ljqEoSnNcSX5HGZdh0WoYhP+8pXRwy0y2wK1r95j/MGKw2JdxV+28+okONIJr+2
         GOxg==
X-Gm-Message-State: ACgBeo3eJv1aMLKU3L5sGyWf6ckxi3jgSrSxMrRKivjHLm9AmKtfbGlf
        mCrr6vEOSCGhRC7F0ErSlRq7VZv6SZ+reg==
X-Google-Smtp-Source: AA6agR5PUA7stEBakbVfcABDXRQcLNsi+cAHDXuEnG4nxGAwFnh6e5rfj6mKS9cu1xiiMlxsI6mxbg==
X-Received: by 2002:a05:6402:270b:b0:448:76f0:4f55 with SMTP id y11-20020a056402270b00b0044876f04f55mr6355483edd.215.1661841985955;
        Mon, 29 Aug 2022 23:46:25 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id t19-20020a056402525300b00445bda73fbesm4666707edd.33.2022.08.29.23.46.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 23:46:25 -0700 (PDT)
Message-ID: <0885a541-9ea5-ea8c-f3ee-61162ef77d8b@kernel.org>
Date:   Tue, 30 Aug 2022 08:46:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 3/3] serial: pch_uart: CIRC_CNT_TO_END() is enough
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220823141839.165244-1-ilpo.jarvinen@linux.intel.com>
 <20220823141839.165244-3-ilpo.jarvinen@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220823141839.165244-3-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 08. 22, 16:18, Ilpo Järvinen wrote:
> Testing also CIRC_CNT() with CIRC_CNT_TO_END() is unnecessary because
> to latter alone covers all necessary cases.

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>   drivers/tty/serial/pch_uart.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
> index 8a9065e4a903..116a2e76093d 100644
> --- a/drivers/tty/serial/pch_uart.c
> +++ b/drivers/tty/serial/pch_uart.c
> @@ -898,9 +898,7 @@ static unsigned int dma_handle_tx(struct eg20t_port *priv)
>   		fifo_size--;
>   	}
>   
> -	bytes = min((int)CIRC_CNT(xmit->head, xmit->tail,
> -			     UART_XMIT_SIZE), CIRC_CNT_TO_END(xmit->head,
> -			     xmit->tail, UART_XMIT_SIZE));
> +	bytes = CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE);
>   	if (!bytes) {
>   		dev_dbg(priv->port.dev, "%s 0 bytes return\n", __func__);
>   		pch_uart_hal_disable_interrupt(priv, PCH_UART_HAL_TX_INT);

-- 
js
suse labs

