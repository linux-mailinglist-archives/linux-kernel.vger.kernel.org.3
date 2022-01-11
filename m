Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C17A48A820
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 08:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348408AbiAKHJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 02:09:02 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:39898 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiAKHJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 02:09:01 -0500
Received: by mail-ed1-f49.google.com with SMTP id c71so51741266edf.6;
        Mon, 10 Jan 2022 23:09:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tUOEL7PT1f3o+oRqmZZ4B0vpjJgHIeHOoPDC9Wj1Tzw=;
        b=x0PQ3buLdCVkEh12HM/w42+DGqMoE/efmgRfUG/Y6CWR9bIxkerm4WZmiTuUF+TfYT
         +n1YPUNijGA5kjfCS3dstiwQjkL34Vmzq3B+4PernhtqG8YGiSKZNfhldkpSl3fIZGe2
         CMPm/Hk64dxpjJH/q7vF0/zIY/Q0WvH+azdYBzHxxzhITKviMC3Xrw3ziYWth1E3hsAp
         XyS1G++KWH7OXpL62fiusOtIJuANBJmT6NYHkYPraMaxRkLg+vn9uC1em4F21o0zZLI2
         gkSNOy3x+X0Hjtf9P1jK/p2H+Bxa++/JAHVkdTLrdhxUqMKNOaND72hVhBiBnBC43zA6
         B0Sw==
X-Gm-Message-State: AOAM531BvZiqOeMuwL8TulkqhyRw04hsjR4+Dbyx+9IId1eKQG+5wOMZ
        0/saDoMnWhav+PkvSJMNxISnyMcOP3U=
X-Google-Smtp-Source: ABdhPJylTRQ/giaGNkX5z1g00ZEFdgh3DZy3BoJ7klvQv7KICHjlG1p94+VF1waIIGAe6BWxxk9yEg==
X-Received: by 2002:a17:906:9948:: with SMTP id zm8mr2527728ejb.396.1641884939743;
        Mon, 10 Jan 2022 23:08:59 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id d9sm4550464edy.55.2022.01.10.23.08.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 23:08:59 -0800 (PST)
Message-ID: <e6315e6b-78a6-0a8b-c693-9797a4519bd4@kernel.org>
Date:   Tue, 11 Jan 2022 08:08:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] tty: serial: fsl_lpuart: count tty buffer overruns
Content-Language: en-US
To:     Sherry Sun <sherry.sun@nxp.com>, gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
References: <20220111061036.12638-1-sherry.sun@nxp.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220111061036.12638-1-sherry.sun@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11. 01. 22, 7:10, Sherry Sun wrote:
> Added support for counting the tty buffer overruns in fsl_lpuart driver
> like other uart drivers.
> 
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>   drivers/tty/serial/fsl_lpuart.c | 19 +++++++++++++------
>   1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index ce3e26144689..1e6f924d8507 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
...
> @@ -1117,6 +1119,7 @@ static void lpuart_copy_rx_to_tty(struct lpuart_port *sport)
>   	struct circ_buf *ring = &sport->rx_ring;
>   	unsigned long flags;
>   	int count = 0;
> +	unsigned int copied = 0;
>   
>   	if (lpuart_is_32(sport)) {
>   		unsigned long sr = lpuart32_read(&sport->port, UARTSTAT);
> @@ -1218,20 +1221,24 @@ static void lpuart_copy_rx_to_tty(struct lpuart_port *sport)
>   	if (ring->head < ring->tail) {
>   		count = sport->rx_sgl.length - ring->tail;
>   
> -		tty_insert_flip_string(port, ring->buf + ring->tail, count);
> +		copied = tty_insert_flip_string(port, ring->buf + ring->tail, count);
> +		if (copied != count)

Overall looks good, except tty_insert_flip_string returns an int and 
count is also an int. Wouldn't it be more consistent to declare copied 
as int too? This comparison would be without implicit conversion then.

thanks,
-- 
js
suse labs
