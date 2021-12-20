Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCC447B07E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 16:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbhLTPlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 10:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbhLTPlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 10:41:36 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C080EC061574;
        Mon, 20 Dec 2021 07:41:35 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id i5-20020a05683033e500b0057a369ac614so13016768otu.10;
        Mon, 20 Dec 2021 07:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gVWl0i8n106mWJcBhB3y1eHdItsmrKdB0+w/8KTHv7E=;
        b=QOqdjnZ1X0g0LZDlhAUr+/00ndMzUv3cJPwZenbSIL8bP/88ouw2UzByBnJwsduojN
         Zvnh01LKgQx6EHOqFTzGDN0c1oGyzETeufxGZ+DkuYWvR4bAxzHUvP8AcLFtdX/vXDDz
         hfF6tuNoy/RXYNhJ38yYpULolmLu17QTcyOjKAH0PCd/Fz6H0of5dIsTDgCuQkpOd2EM
         4ollzMqj1P7AvHCr0PWGU3vD8B1wqoQNYvjkhEb/rKtLhJZbfhhOnC/D2JUwKNmrcvr/
         vfVs2NC1DwIpGA99mVq0k8h6TNva1adlKR1jD1HOz7IDBr6XJLqt/FJ3zY7Qls2G2xaG
         Yfeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gVWl0i8n106mWJcBhB3y1eHdItsmrKdB0+w/8KTHv7E=;
        b=Da6QfrwX9g2deE///lLy5a6QDXWmZRRgS7wZ8DORwgJ8SfYhlbO5/hzjYNN4tBlbsM
         WCd2ZgNSY4ZKS8dlrgmDxDJ0uzBX6X9JbFRfQSJfq6Whhm3SiBA9zKANb1C7dOnPzNuL
         sTMKKa3hGIWzqN4yPycrf6XI8c4SdBskGHnMUCuKbc8UDV3IeFhYMCQDPb5TCOrMYW5E
         +MBI40dArFPKHo/ZOcj/elkNNNhFOeFabdhTMnViSYnt723HE2hFQMt1fyCD8oS0gqzV
         eBEVlNEF83ZUO47AsOHH86fWFmibxNML2Aj/WZSsfaYDsy/GWTgtSXxxKrGcIiv9u5h7
         +hcw==
X-Gm-Message-State: AOAM530TnUt2OLd3VN0LRVS6O0yKWAxT2p100TW3C03Q12vQS5qPFiKZ
        voDzwaUHt/cFsElUiBJNRolh5ZIw8sQ=
X-Google-Smtp-Source: ABdhPJxxgN6rnhLZIOu8PToDcjNCzruMimoFyEOWt0hfti36VH2KCcDqj+KcYXSQqlOYpUgDJ8X39g==
X-Received: by 2002:a9d:75d4:: with SMTP id c20mr11681918otl.85.1640014894210;
        Mon, 20 Dec 2021 07:41:34 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h1sm3113895oog.26.2021.12.20.07.41.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 07:41:33 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, wim@linux-watchdog.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211220062104.770247-1-jiasheng@iscas.ac.cn>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2] watchdog: ie6xx_wdt: Check for null res pointer
Message-ID: <0bb5823d-fba0-cd14-6c5b-ac3032b31c2d@roeck-us.net>
Date:   Mon, 20 Dec 2021 07:41:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211220062104.770247-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/21 10:21 PM, Jiasheng Jiang wrote:
> The return value of platform_get_resource() needs to be checked.
> To avoid use of error pointer in case that there is no suitable resource.
> 

How would that resource disappear since the probe function ?

That driver could use a lot of cleanup (use devm_request_region(),
use watchdog_stop_on_unregister(), stop using a static data structure,
use devm_add_action_or_reset to trigger the call to debugfs_remove,
use devm_watchdog_register_device and drop the remove function),
but this change addresses a non-existing problem.

Guenter

> Fixes: 101ce87b3bdd ("watchdog: Add watchdog driver for Intel Atom E6XX")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
> Changelog:
> 
> v1 -> v2
> 
> *Change 1. Correct the commit message.
> ---
>   drivers/watchdog/ie6xx_wdt.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/watchdog/ie6xx_wdt.c b/drivers/watchdog/ie6xx_wdt.c
> index 8f28993fab8b..ee5b68d2e271 100644
> --- a/drivers/watchdog/ie6xx_wdt.c
> +++ b/drivers/watchdog/ie6xx_wdt.c
> @@ -271,6 +271,9 @@ static int ie6xx_wdt_remove(struct platform_device *pdev)
>   	struct resource *res;
>   
>   	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
> +	if (!res)
> +		return -EINVAL;
> +
>   	ie6xx_wdt_stop(NULL);
>   	watchdog_unregister_device(&ie6xx_wdt_dev);
>   	ie6xx_wdt_debugfs_exit();
> 

