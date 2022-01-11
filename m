Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 823A048A95C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 09:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348925AbiAKI3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 03:29:13 -0500
Received: from mail-ed1-f43.google.com ([209.85.208.43]:38799 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348918AbiAKI3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 03:29:12 -0500
Received: by mail-ed1-f43.google.com with SMTP id u21so41424632edd.5;
        Tue, 11 Jan 2022 00:29:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HLfFV+bY2Dj5UwJM9aU9W649JzY157duB65QvuOzkf4=;
        b=3kQMyEOeDRvbq/t8GKKUlNY81weZxmyUriXhJlcyHrA+gVWvqUrck0M7OMybowptvK
         mDMn+qP5ttqzOEYxoJSgJQ75ddoob5qzB+Bae7VjsBRDJdH2ALm00xQtEKdragrTocMS
         xM8I9pRStOOv/WFv6jfbHySZKGhy86hjEGYsa38MX2UklHx+nL9TdaBenEi/K65aenpV
         3rMVjNM5aooFC28yUvyfddod3Ek/KN5rOVlboDRAqPfHAUb2nYo5zSsCnbC1htHxmdyi
         N4ZMvn7G7BvZ/WZc6BYfz+HqfKBV23tux1FwzhzmNQd1KcAX3rIejHjA85tms++wZHDp
         3MnQ==
X-Gm-Message-State: AOAM531vck9luJRrafiUoaVWrX6+v4l+lqDTM/F9YimuFG0V3Z7b6Vn+
        VNIvkjha0Q0eMp271JjG9lU=
X-Google-Smtp-Source: ABdhPJz/j4NU7oQT+G1S3gM3uEPvf0rwZ54H+Cg2WOyQtau9JzE67LSnMxiBQ/oUdji5CpgqIfNfLA==
X-Received: by 2002:a17:906:dc8a:: with SMTP id cs10mr2754811ejc.622.1641889750866;
        Tue, 11 Jan 2022 00:29:10 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id qk11sm3303229ejc.110.2022.01.11.00.29.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 00:29:10 -0800 (PST)
Message-ID: <7b6faabc-bbf9-2d93-274a-93df725e4aca@kernel.org>
Date:   Tue, 11 Jan 2022 09:29:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH V2] tty: serial: fsl_lpuart: count tty buffer overruns
Content-Language: en-US
To:     Sherry Sun <sherry.sun@nxp.com>, gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
References: <20220111082229.5117-1-sherry.sun@nxp.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220111082229.5117-1-sherry.sun@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11. 01. 22, 9:22, Sherry Sun wrote:
> Added support for counting the tty buffer overruns in fsl_lpuart driver
> like other uart drivers.
> 
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> 
> ---
> changes in V2
> 1. Change the copied type to int to avoid implicit conversion, as the
> tty_insert_flip_string return type is int.
> ---
>   drivers/tty/serial/fsl_lpuart.c | 20 +++++++++++++-------
>   1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index ce3e26144689..82a1a2817750 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
...
> @@ -1116,7 +1118,7 @@ static void lpuart_copy_rx_to_tty(struct lpuart_port *sport)
>   	struct dma_chan *chan = sport->dma_rx_chan;
>   	struct circ_buf *ring = &sport->rx_ring;
>   	unsigned long flags;
> -	int count = 0;
> +	int count = 0, copied = 0;

Why is it necessary to initialize copied?

Actually neither count needs to be initialized AFAICT. Care to fix that 
too (in a separate patch).

thanks,
-- 
js
suse labs
