Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3702E4A8076
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 09:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349512AbiBCIfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 03:35:54 -0500
Received: from mail-ej1-f54.google.com ([209.85.218.54]:35471 "EHLO
        mail-ej1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240103AbiBCIfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 03:35:53 -0500
Received: by mail-ej1-f54.google.com with SMTP id s5so6260738ejx.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 00:35:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bdY1K6T2ZRynEdWPlGYudbJJYLecFbRD2m9wj0sjMls=;
        b=Ptz2NVK3u1PzKfdUkurPO6GtVYhfC4TCNkTIeEn7rrqudGHcMAfP27ledHK/Xo4UsB
         3eqwHKjIcdDO0oPXrcZ59vofrESpgOHCnOiLT1rjB522RfJPw8QCSZ9G1yJPzix0G8Eq
         VRhi1CiFxtAbYR+ObEstbBu+O0yyPRW4RHUe/IXzXAccXIISlHS44nMN290hFx+WS4C/
         WVD1pEcI/Epyz07Bau70h+devRQF2UXI9fx2BBKogmIGhGBTWEUowar4xx6ZyCgqLrP/
         uvWDAAdAHi74K69mUPcXeLG5/ki8yOTOMKj+XUQV3GpQbvecQO3csXZgxiiu6VaYNOSR
         45jw==
X-Gm-Message-State: AOAM5313idQlVX47zgYqOm5aJ7Z/Kdo02PJZ1u2O8gc2+SCgM3gw0hSN
        7coGW7Ou3geRuIwcCm56pwRDlEjzJOA=
X-Google-Smtp-Source: ABdhPJyhISJLOhinLiZIjpKUbiBeko8PsGB1Ou07OiOW0Sc1S/Oq7h3T2kJMN6k1ufTKKZIW5AJJHw==
X-Received: by 2002:a17:906:2287:: with SMTP id p7mr29848867eja.239.1643877351976;
        Thu, 03 Feb 2022 00:35:51 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id de43sm16731779ejc.12.2022.02.03.00.35.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 00:35:51 -0800 (PST)
Message-ID: <40c7b561-46f3-6a83-401d-7a6b1bf57219@kernel.org>
Date:   Thu, 3 Feb 2022 09:35:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 1/1] amiserial: Drop duplicate NULL check in shutdown()
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20220202165655.5647-1-andriy.shevchenko@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220202165655.5647-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02. 02. 22, 17:56, Andy Shevchenko wrote:
> The free_page(addr), which becomes free_pages(addr, 0) checks addr
> against 0. No need to repeat this check in the caller.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Jiri Slaby <jirislaby@kernel.org>

> ---
>   drivers/tty/amiserial.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
> index 1e60dbef676c..533d02b38e02 100644
> --- a/drivers/tty/amiserial.c
> +++ b/drivers/tty/amiserial.c
> @@ -538,10 +538,8 @@ static void shutdown(struct tty_struct *tty, struct serial_state *info)
>   	 */
>   	free_irq(IRQ_AMIGA_VERTB, info);
>   
> -	if (info->xmit.buf) {
> -		free_page((unsigned long) info->xmit.buf);
> -		info->xmit.buf = NULL;
> -	}
> +	free_page((unsigned long)info->xmit.buf);
> +	info->xmit.buf = NULL;
>   
>   	info->IER = 0;
>   	amiga_custom.intena = IF_RBF | IF_TBE;


-- 
js
suse labs
