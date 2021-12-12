Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22CF0471BF7
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 18:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbhLLRuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 12:50:11 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:41020
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230476AbhLLRuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 12:50:09 -0500
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2D4A13F1B3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 17:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639331408;
        bh=WCCvwpT22jrWbgMHRE3RsRLnwwEuukRNrzKAgDnW7I4=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=rFQvdsnNMngDF6QWIFABlSQt8Z7G25XrMKHi9Yr6eS+ar7uzP509feHDS2kcqZBCt
         qziLQ1hsk9nwAoQKq2uK5EX9fwKR8QazszNPM+5jeH0RD/n35XHn/v3jBEuYZzmSao
         zDUgPfI1o+LT+vcc5HsOnLhyhcyzUWfUaS75fXyLKBtcQjH2P6zhD/x5RncXFm1w3N
         LR68mi0weyaXsSrMmJwdA5XtPfTwqfWu6DuCTeeURmt+kMKveJ82+fhgukES2HpC6B
         K4QGhczfdDDGxaIF3YuuDl+YoYLgIgw4DjhEe7t8p6vETEGgq6ebmwW4mGJ2AJ/aRj
         VeMEwD112GRNA==
Received: by mail-lf1-f70.google.com with SMTP id o11-20020a056512230b00b0041ca68ddf35so6453898lfu.22
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 09:50:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WCCvwpT22jrWbgMHRE3RsRLnwwEuukRNrzKAgDnW7I4=;
        b=64/B+LTfut3L5qioHm4ikTbJCRfR4iUimL7gEgBzpN+bJKrtxxJvmpMRiYz2aAGbxG
         iFiWj/RsN14Ei9abyhf+Wcu7yTSLZypy7CDjnBDzANpBMSOrK4BHjRh5Xe6ZvzL0+Vlk
         EA0KmFWajjvkQrB81bYcJMWGq+S4PYPv5Vbkc+KFeJRw44VCbfdD3Eexf4XIhCO71lyK
         rbHRjeutEtWEPHQ3WyINwmDIBeKsSMxHKNRNgj9FCLtj1+pEgmML3/Uh8l6VjVQuJN3G
         2PXy9wmfPOL6VsYMTfLm0QKNHbLe4dE406hSlQeBt7xH9Tkg42WlnaV3k7eUgLWfBNli
         hJtQ==
X-Gm-Message-State: AOAM530H6s+PONQ9o5FNxHSNOzxQKtVoyK9CL0ILCcwgAaU5b2OeWxTx
        BagmPowNb4XZixaf4y+nZYC2yS4Yq2kGG+T88bSIWwoKEcUggmBnq5vJxqFo0y4NHuD0oEpI8A3
        636kUAGkp9z0LtFdp2GPtFilvb6pjIMzOIrjgJxG8pA==
X-Received: by 2002:a05:6512:2820:: with SMTP id cf32mr24881732lfb.510.1639331407210;
        Sun, 12 Dec 2021 09:50:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzUu1cZVv3akhdYGI1KReu7wig7sZszq46hRcYvBeAwNUtzmKOFPO3wTQxMzJmtsBvtBD/ddg==
X-Received: by 2002:a05:6512:2820:: with SMTP id cf32mr24881715lfb.510.1639331407044;
        Sun, 12 Dec 2021 09:50:07 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id u7sm1135220lja.58.2021.12.12.09.50.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Dec 2021 09:50:06 -0800 (PST)
Message-ID: <b618ff5b-ee41-2c29-5074-24fd4d0f0933@canonical.com>
Date:   Sun, 12 Dec 2021 18:50:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] watchdog: s3c2410: Fix getting the optional clock
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211212170247.30646-1-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211212170247.30646-1-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/2021 18:02, Sam Protsenko wrote:
> "watchdog_src" clock is optional and may not be present for some SoCs
> supported by this driver. Nevertheless, in case the clock is provided
> but some error happens during its getting, that error should be handled
> properly. Use devm_clk_get_optional() API for that. Also report possible
> errors using dev_err_probe() to handle properly -EPROBE_DEFER error (if
> clock provider is not ready by the time WDT probe function is executed).
> 
> Fixes: a4f3dc8d5fbc ("watchdog: s3c2410: Support separate source clock")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Suggested-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  drivers/watchdog/s3c2410_wdt.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
