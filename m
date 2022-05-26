Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95EAC535099
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 16:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347637AbiEZO2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 10:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiEZO2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 10:28:46 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85151C5E73;
        Thu, 26 May 2022 07:28:45 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-f2c296d320so2355158fac.8;
        Thu, 26 May 2022 07:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zD1tykVhXikMZCSvJDlW1fV+0q4vJMuokHitqc0dVX4=;
        b=kqGiKeW/Q+eQLqib+/I5kXYt+IGhKxnt7OcEBcFKQRIojruiJWKJinwsvYmrQKXG7T
         CqUmQ122h57gHGK+sUaMgms7/t19fQVjf04473VvM/ZsUftnR1+/hEg3uH03vCoLJFJo
         1YngMVmbZ+24vusqUNrXBSBwPH/kXUGFtmrJgIIJPCYBHhbRR7YmFtqrYPa1qkEfd+7w
         89d42XFWfFuSYvP1qYnSGGBySa9ER/TOA3VVOrdfOmlEjhgqgQPjqf1T2CHmjGxFXNX8
         meWJhKvtTqT5GRMky3KhfRUVqC5fHv+WDPbW2fqZkziQoVnmt2fDILDlOQKqI83AIWSc
         uexw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zD1tykVhXikMZCSvJDlW1fV+0q4vJMuokHitqc0dVX4=;
        b=Hlbrr+DII46Pt7WeazO78QrLmfTtJ2zaZiOA3GKREBR1gd5dffXeCQrmY/gwdM5vGh
         9X2BMi5fWc0eqXLytg9Iws3AuvhicTesq9T4uXh4uATASEz0gZ+uisr/93x+iVa1zCbz
         LcdL3V8OCr9S/qve45Y7P49b9w7BzdzYlieX6Sex/8UeLt1rj6jLvNa4zAPUW8eddAxo
         bHWNU79AMSsAPE/bRBkoO9sig554kxOencfTVzeJHq+gPs2BHaPaPc6ZhCsCwyPRVqid
         gxm+bQqRYj7KNcxalxhyQ6CPz8TALT13px1UEREZ/kuijAlda9bpimEtLJ4JtW8/pUWh
         qYBQ==
X-Gm-Message-State: AOAM533Sr3jlcSY159ilHtUWJRkJJbyhs7HIsRimebLPUxqDwBZe9lEo
        DiMwip3KJ/TafNUHzNIMFoY=
X-Google-Smtp-Source: ABdhPJwShhJB/K0OACBBFmQw8TveuQWb5lYavZbLiMKJvXPxoWiS6icyi2dvW+mue/WuNUh8cs7fEg==
X-Received: by 2002:a05:6870:a689:b0:ed:e8f2:fe14 with SMTP id i9-20020a056870a68900b000ede8f2fe14mr1383085oam.199.1653575324517;
        Thu, 26 May 2022 07:28:44 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bj39-20020a05680819a700b0032b7b588f3asm666938oib.46.2022.05.26.07.28.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 07:28:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1c732733-69c1-f1e4-5d5a-486dc6effb39@roeck-us.net>
Date:   Thu, 26 May 2022 07:28:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] watchdog: f71808e_wdt: Add check for
 platform_driver_register
Content-Language: en-US
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, wim@linux-watchdog.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220526080303.1005063-1-jiasheng@iscas.ac.cn>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220526080303.1005063-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/22 01:03, Jiasheng Jiang wrote:
> As platform_driver_register() could fail, it should be better
> to deal with the return value in order to maintain the code
> consisitency.
> 
> Fixes: 27e0fe00a5c6 ("watchdog: f71808e_wdt: refactor to platform device/driver pair")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/f71808e_wdt.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/f71808e_wdt.c b/drivers/watchdog/f71808e_wdt.c
> index 7f59c680de25..6a16d3d0bb1e 100644
> --- a/drivers/watchdog/f71808e_wdt.c
> +++ b/drivers/watchdog/f71808e_wdt.c
> @@ -634,7 +634,9 @@ static int __init fintek_wdt_init(void)
>   
>   	pdata.type = ret;
>   
> -	platform_driver_register(&fintek_wdt_driver);
> +	ret = platform_driver_register(&fintek_wdt_driver);
> +	if (ret)
> +		return ret;
>   
>   	wdt_res.name = "superio port";
>   	wdt_res.flags = IORESOURCE_IO;

