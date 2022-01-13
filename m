Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8340448D2C4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 08:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbiAMHXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 02:23:45 -0500
Received: from mail-ed1-f47.google.com ([209.85.208.47]:34400 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiAMHXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 02:23:44 -0500
Received: by mail-ed1-f47.google.com with SMTP id u25so19714667edf.1;
        Wed, 12 Jan 2022 23:23:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UEq18oBhYps436zVanPwwyctMSav8alYIJngzImKUPE=;
        b=ihHlB0XbYvIv1SkdDSegaN+hWVrs0iOGCwhDYgJEkytDcWmqwRVKb+KmZ7e62r1emq
         FRMDOy9wKfeKGfrpwPgEj/+pLBARUR25Q3esHMUy0Lm0MwvdfKDO9m3jPuZqh6ZadDNL
         MOeiNiTfJ6eD2tVflETsvmZV3yZeZy0ENyKZRVlgxe07JpMt+3ovMBAnK1iC+Js061eF
         RFgJPtv/iBibVUFzpJpBHed9qzxCigo4ZGzw8RzsO8t5CEJzdnG7iDkEv36jK2esarMb
         08bxzYF6rdI6E3JSQ/LUZWWmpQqPN+gNoNRVtjoDfZWpYcAok2mapo3RRkSbJu7VGyUP
         N9fA==
X-Gm-Message-State: AOAM533NnQlzYKJkOlkF50EQlKkH9KJzUiHI4qlZzLtHvc0QckVZN1A6
        sSh+qUIvvKCff3kTU9C1//I=
X-Google-Smtp-Source: ABdhPJxfPuZjU/HgLjaqBITVvqUbzOKdn+VX96JTyfIdLRsLdf9E4TfAFBed5ljiyujKsRzO23gg+w==
X-Received: by 2002:a05:6402:348b:: with SMTP id v11mr3030297edc.309.1642058623137;
        Wed, 12 Jan 2022 23:23:43 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id c8sm771665edu.60.2022.01.12.23.23.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 23:23:42 -0800 (PST)
Message-ID: <96b68539-d561-8ed6-f87f-d7fd2f9fe685@kernel.org>
Date:   Thu, 13 Jan 2022 08:23:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH V3] tty: serial: fsl_lpuart: count tty buffer overruns
Content-Language: en-US
To:     Sherry Sun <sherry.sun@nxp.com>, gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
References: <20220111085130.5817-1-sherry.sun@nxp.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220111085130.5817-1-sherry.sun@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11. 01. 22, 9:51, Sherry Sun wrote:
> Added support for counting the tty buffer overruns in fsl_lpuart driver
> like other uart drivers.
> 
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> ---
> changes in V3
> 
> 1. Remove the initialization for copied as it is not necessary.
> ---
>   drivers/tty/serial/fsl_lpuart.c | 20 +++++++++++++-------
>   1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index ce3e26144689..7d90c5a530ee 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -931,7 +931,8 @@ static void lpuart_rxint(struct lpuart_port *sport)
>   			sport->port.sysrq = 0;
>   		}
>   
> -		tty_insert_flip_char(port, rx, flg);
> +		if (tty_insert_flip_char(port, rx, flg) == 0)
> +			sport->port.icount.buf_overrun++;
>   	}
>   
>   out:
> @@ -1024,7 +1025,8 @@ static void lpuart32_rxint(struct lpuart_port *sport)
>   				flg = TTY_OVERRUN;
>   		}
>   
> -		tty_insert_flip_char(port, rx, flg);
> +		if (tty_insert_flip_char(port, rx, flg) == 0)
> +			sport->port.icount.buf_overrun++;
>   	}
>   
>   out:
> @@ -1116,7 +1118,7 @@ static void lpuart_copy_rx_to_tty(struct lpuart_port *sport)
>   	struct dma_chan *chan = sport->dma_rx_chan;
>   	struct circ_buf *ring = &sport->rx_ring;
>   	unsigned long flags;
> -	int count = 0;
> +	int count = 0, copied;
>   
>   	if (lpuart_is_32(sport)) {
>   		unsigned long sr = lpuart32_read(&sport->port, UARTSTAT);
> @@ -1218,20 +1220,24 @@ static void lpuart_copy_rx_to_tty(struct lpuart_port *sport)
>   	if (ring->head < ring->tail) {
>   		count = sport->rx_sgl.length - ring->tail;
>   
> -		tty_insert_flip_string(port, ring->buf + ring->tail, count);
> +		copied = tty_insert_flip_string(port, ring->buf + ring->tail, count);
> +		if (copied != count)
> +			sport->port.icount.buf_overrun++;
>   		ring->tail = 0;
> -		sport->port.icount.rx += count;
> +		sport->port.icount.rx += copied;
>   	}
>   
>   	/* Finally we read data from tail to head */
>   	if (ring->tail < ring->head) {
>   		count = ring->head - ring->tail;
> -		tty_insert_flip_string(port, ring->buf + ring->tail, count);
> +		copied = tty_insert_flip_string(port, ring->buf + ring->tail, count);
> +		if (copied != count)
> +			sport->port.icount.buf_overrun++;
>   		/* Wrap ring->head if needed */
>   		if (ring->head >= sport->rx_sgl.length)
>   			ring->head = 0;
>   		ring->tail = ring->head;
> -		sport->port.icount.rx += count;
> +		sport->port.icount.rx += copied;
>   	}
>   
>   exit:


-- 
js
suse labs
