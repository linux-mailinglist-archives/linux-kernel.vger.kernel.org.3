Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5429D467BD7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 17:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382223AbhLCQzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 11:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352889AbhLCQzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 11:55:40 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B7AC061751;
        Fri,  3 Dec 2021 08:52:15 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id t23so6969660oiw.3;
        Fri, 03 Dec 2021 08:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y3kND0JWuv17IoM/sVq9SwFXUCMZwIS/XbeDe0iK9O8=;
        b=nUc6VrAFXTlirzOfUH9m3h89phlfg/mlC/9jys5RuNWB8Ltq2FrRIaz6mdk/5qLGtW
         x0QY59sn9Uyeq1lhsR/19IucI89RR4A5dTfY/MzfK0yzbjWnZz2GHpsAd+RzHeQnwJXl
         ZkTrpt1bMNWGmM446S7AYtLKpcEC9poteEFJUec+3tdiWB6ddhSfAykjk/TTDrGuKlqP
         n59Q0SvfnvDNS8ji61JD7I3ZVCvyAPdFC8oOTB6VHG5pqxCRZN8bbDsgo1qHcmUu9LRT
         d39dx5ZcmQsMNMkcPG6hRFI7mUk52WGqpo18GnNIIzhFEVKUPb2T38JoJa7AKtJzMtmc
         UeMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y3kND0JWuv17IoM/sVq9SwFXUCMZwIS/XbeDe0iK9O8=;
        b=2dMQxotWx8qi5AMZpVhlNXsiQTbolhfzjX4Ci+uPLmLdvb5ThoaFTDCbm3XhbCWibx
         xMoItPgQu2uz2XvX3lahQzzVT+GywaGiifuHmz0COgJyirXEFYzbZV3pzPlH12a+Lo5e
         jYvWkYA6kh8qRHoZvnin3ekK+R/QKzxQt0AWUGdW14j6hCpyJe7EwTC1EsCIZNgOS13a
         4REySPpQl7hlzyoZNV6zRW/Ep70WJfxsr9CTceyQO564p4CxFMCf1pVxQPOpBA1qcxr4
         SxspHsen4IJXTc2WXHH+7gQ2JUUNp6crXIcuKeOzlGxnvTuDy2aYtMASRRBEDI2c519F
         faHQ==
X-Gm-Message-State: AOAM532vJlvBRINeG5oY2pEhH3fL+74Yp+ZEP3OcLzDq6Mfy4gF6cGYH
        XLD7J6h9D7que1EzJonny2kzfs0Qgl0=
X-Google-Smtp-Source: ABdhPJxfihtEVi4VnJAw6xrFpgT0S+LoX9yuoVA/2JX3SvwtZOj6+taEjIxWulknrqEz2xc8t4xidA==
X-Received: by 2002:aca:accd:: with SMTP id v196mr11073423oie.108.1638550335100;
        Fri, 03 Dec 2021 08:52:15 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y192sm744443oie.21.2021.12.03.08.52.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 08:52:14 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [RFC PATCH] watchdog: da9062: Correct the timeout values
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Andrej Picej <andrej.picej@norik.com>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211203163539.91870-1-cniedermaier@dh-electronics.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <dc6a432c-79a3-881c-eac4-32620040d11b@roeck-us.net>
Date:   Fri, 3 Dec 2021 08:52:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211203163539.91870-1-cniedermaier@dh-electronics.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/21 8:35 AM, Christoph Niedermaier wrote:
> I measured the timeout values of my DA9061 chip. According to the
> information in the data sheet the formula should be:
> 
> timeout = 2.048 * 2^(regval - 1)
> 
> But my measured values differ from that.
> Accoring to my measured values the formula must be:
> 
> timeout = 3.2 * 2^(regval - 1)
> 
> Is there something wrong with my chip, or has anyone else noticed this as well?

The driver assumes a static and well defined clock rate. Maybe that rate
is different in your system (if that is possible) ?

Guenter

> 
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> Cc: Support Opensource <support.opensource@diasemi.com>
> Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Andrej Picej <andrej.picej@norik.com>
> Cc: linux-watchdog@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> To: linux-arm-kernel@lists.infradead.org
> ---
>   drivers/watchdog/da9062_wdt.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/da9062_wdt.c b/drivers/watchdog/da9062_wdt.c
> index f02cbd530538..d2576aba9ca5 100644
> --- a/drivers/watchdog/da9062_wdt.c
> +++ b/drivers/watchdog/da9062_wdt.c
> @@ -20,7 +20,8 @@
>   #include <linux/regmap.h>
>   #include <linux/of.h>
>   
> -static const unsigned int wdt_timeout[] = { 0, 2, 4, 8, 16, 32, 65, 131 };
> +static const unsigned int wdt_timeout[] = { 0, 3, 6, 12, 25, 51, 102, 204 };
> +
>   #define DA9062_TWDSCALE_DISABLE		0
>   #define DA9062_TWDSCALE_MIN		1
>   #define DA9062_TWDSCALE_MAX		(ARRAY_SIZE(wdt_timeout) - 1)
> 

