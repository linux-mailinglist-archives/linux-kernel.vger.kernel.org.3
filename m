Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC404B6350
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 07:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234321AbiBOGPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 01:15:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbiBOGO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 01:14:59 -0500
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9B5F745F;
        Mon, 14 Feb 2022 22:14:49 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id lw4so11181779ejb.12;
        Mon, 14 Feb 2022 22:14:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dmLGmi/jb0sxVvWxeOL0tvmCWKAWUGwcOpsWGkrfDD4=;
        b=vEYcqR/WbLyVaIaxBOQMCwJ3B/shJjEoQoYJyInVyJJt8qOI0WVISK8BEOhgIc+I08
         0pQCDSMrWOVPmgRG0nZlIQAdfUui+4ph1pw5jsCoD1DFQKurQ7oZCHsotMxQxwRMfkN8
         CAJENVPcJHfbB7RnUOnfJfcnXZXduQ8fpYyKGBj/rFzQWicjnEuyNSQ8hVL01x5n7S4b
         +6n7wDV22TelZm4caycnmmLQqB7DOJKwqGUaEf4quJweJwVl6Zu4lWRe3V7aTln2q/JY
         SSQy/hgUJtDE0B5nc1nh1TjXhtrkuH101ym/GMBNo4r3WFHLauJxccORy8+DZRRtX8BZ
         Zjxw==
X-Gm-Message-State: AOAM530pEFamNSuh8yXNgc6xPttAhZWG2KqF62brmkZcHz+VHJ6yQpkT
        XzTyKOBu7RR4VTRgqWArJOs=
X-Google-Smtp-Source: ABdhPJyKYhLgz9cMjm/zKM9LTSN6EcKQmbtwOxntWyQ0i0XlaEcmgIzQMi1BNZ0JQ1KQPqkEhAq6GQ==
X-Received: by 2002:a17:907:6d94:: with SMTP id sb20mr1739357ejc.375.1644905688362;
        Mon, 14 Feb 2022 22:14:48 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id h6sm6727577edb.5.2022.02.14.22.14.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 22:14:47 -0800 (PST)
Message-ID: <a9b2899a-bbd4-ec15-6fcc-b7765455ea13@kernel.org>
Date:   Tue, 15 Feb 2022 07:14:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] tty: serial: add missing pci_dev_put() before return
Content-Language: en-US
To:     Qing Wang <wangqing@vivo.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1644890472-65306-1-git-send-email-wangqing@vivo.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <1644890472-65306-1-git-send-email-wangqing@vivo.com>
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

On 15. 02. 22, 3:01, Qing Wang wrote:
> From: Wang Qing <wangqing@vivo.com>
> 
> pci_get_slot() increases its reference count, the caller must
> decrement the reference count by calling pci_dev_put()
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---
>   drivers/tty/serial/pch_uart.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
> index f0351e6..da5a276
> --- a/drivers/tty/serial/pch_uart.c
> +++ b/drivers/tty/serial/pch_uart.c
> @@ -723,7 +723,7 @@ static void pch_request_dma(struct uart_port *port)
>   	if (!chan) {
>   		dev_err(priv->port.dev, "%s:dma_request_channel FAILS(Tx)\n",
>   			__func__);
> -		return;
> +		goto out;
>   	}
>   	priv->chan_tx = chan;
>   
> @@ -739,13 +739,16 @@ static void pch_request_dma(struct uart_port *port)
>   			__func__);
>   		dma_release_channel(priv->chan_tx);
>   		priv->chan_tx = NULL;
> -		return;
> +		goto out;
>   	}
>   
>   	/* Get Consistent memory for DMA */
>   	priv->rx_buf_virt = dma_alloc_coherent(port->dev, port->fifosize,
>   				    &priv->rx_buf_dma, GFP_KERNEL);
>   	priv->chan_rx = chan;
> +
> +out:
> +	pci_dev_put(dma_dev);

Again, dma_dev is stored to an internal structure and shouldn't be freed 
now.

>   }
>   
>   static void pch_dma_rx_complete(void *arg)


-- 
js
suse labs
