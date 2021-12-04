Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0457046835E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 09:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384294AbhLDIbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 03:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384278AbhLDIbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 03:31:16 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64F5C061751
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 00:27:50 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id k2so10752953lji.4
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 00:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vaVQ9EF+zBy4WNuvJqK/FTH7aVljNykn6dqdxn1AsfI=;
        b=i+M9ZXngnViEH8TaXdUBL+LY1P7NAgLK/yKYJCdNM+XtQVQBfBi7RmsnqeKlBu5vz6
         V8l5Z5O3PJtycqfLNOQCz9bjaZaPy81VGd7GYBjMIrlBzPUdxyWzPkwNjh/9rbMz3pNq
         ImoewmxgL3NUosAGf51/xXuhn6ekS68iy+jG0dQ9uFO0/fLej2IjLT4WJBY3qdFdQuhX
         E70e2rjZ1koqkS8/rzXfglYzlM0QLwXExLzviCU1aHzSCyTr3mw9U68hBIHnltfGHiBA
         peIDAu4Wi85jYed3bQQEkh1RzB6ibnuSMjRzWrJlSPPVaMVIZwamahQNrmQvmzcAkK4u
         arvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vaVQ9EF+zBy4WNuvJqK/FTH7aVljNykn6dqdxn1AsfI=;
        b=rRcYFe1yYy3NugnFE7GjGqdfCWIydekhUUrjg3IhCyD9RTmHvSc+32b3it7KjHpixX
         NFu/O6b8k2w4FwHlVfY6XSB7jLwbBOf5eVUBTMar88sJ+CMbKeIdlsgoABwH8FLEgUGM
         0AbnB8WiuNki5jvaOFUi8urJNaQ7y3tXEig2W0bWN2Ky7TQ9eXHMfaBCjZno43pQmIhV
         6OcqUZIe2cd7R+NWacP7hXxgzSbJOWKsiNOodevwU39Hl4Vs63Z1lryodUVlqvvqbb9v
         OQM7PhH8Mk7E7Dy199RcixG+PBaguTcOmePK/w/5MNG5ggIEPSgzG01Y3XvRQaFObXah
         9DNA==
X-Gm-Message-State: AOAM5315vHCsWw/9FB7Yz76ZyOdv6pAmBtuBdVSrSoX8vMuKIcDNVaYW
        XmucCDkP6rGOymlIqtZPoVNmh8Xl9G5aew==
X-Google-Smtp-Source: ABdhPJwmHL8+M7o93dIJozcXFDCb0rWtmIJL/HJAEBQgQgicG2bRtLRcuKpkvbYiwnJ+MpSDPffVhg==
X-Received: by 2002:a2e:b7d4:: with SMTP id p20mr22799012ljo.248.1638606468786;
        Sat, 04 Dec 2021 00:27:48 -0800 (PST)
Received: from [192.168.1.11] ([94.103.229.236])
        by smtp.gmail.com with ESMTPSA id j19sm741553lji.94.2021.12.04.00.27.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Dec 2021 00:27:48 -0800 (PST)
Message-ID: <e0fea904-1861-0003-1b04-6d2e966657da@gmail.com>
Date:   Sat, 4 Dec 2021 11:27:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] staging: vt6655: refactor byMinChannel to min_channel
Content-Language: en-US
To:     Alberto Merciai <alb3rt0.m3rciai@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tommaso Merciai <tomm.merciai@gmail.com>,
        =?UTF-8?B?QWxkYXMgVGFyYcWha2V2acSNaXVz?= <aldas60@gmail.com>,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20211204004041.3825744-1-alb3rt0.m3rciai@gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20211204004041.3825744-1-alb3rt0.m3rciai@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/21 03:40, Alberto Merciai wrote:
> Replace camelcase hungarian notated variable "byMinChannel"
> into linux kernel coding style equivalent variable "min_channel".
> 
> Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
> ---
>   drivers/staging/vt6655/device.h      | 2 +-
>   drivers/staging/vt6655/device_main.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
> index 6ea4165e4929..109d20a010ab 100644
> --- a/drivers/staging/vt6655/device.h
> +++ b/drivers/staging/vt6655/device.h
> @@ -200,7 +200,7 @@ struct vnt_private {
>   	unsigned char byTopOFDMBasicRate;
>   	unsigned char byTopCCKBasicRate;
>   
> -	unsigned char byMinChannel;
> +	unsigned char min_channel;
>   	unsigned char max_channel;
>   
>   	unsigned char preamble_type;
> diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
> index 313f0241d989..4d92b5df5312 100644
> --- a/drivers/staging/vt6655/device_main.c
> +++ b/drivers/staging/vt6655/device_main.c
> @@ -228,7 +228,7 @@ static void device_init_registers(struct vnt_private *priv)
>   	spin_unlock_irqrestore(&priv->lock, flags);
>   
>   	/* Get Channel range */
> -	priv->byMinChannel = 1;
> +	priv->min_channel = 1;
>   	priv->max_channel = CB_MAX_CHANNEL;
>   
>   	/* Get Antena */
> 

Looks like this variable is set, but never used. Shouldn't it be just 
removed?

Same for max_channel (or byMaxChannel).




With regards,
Pavel Skripkin
