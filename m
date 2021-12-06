Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E0346A06F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 17:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389129AbhLFQEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 11:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387549AbhLFPyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:54:20 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8677C0698E2
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 07:40:00 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id d72-20020a1c1d4b000000b00331140f3dc8so144363wmd.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 07:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mCcIdVfqpMkg5UQ5BejYHI9LrriD6R4thQPfErSOuSE=;
        b=NtT3zlVEK+QLaYp1LGYXhPXs927Vj1YkFVcClX21sebLg8GJbk41O/N4+umG7DKnbJ
         q0i6s8149eKMO+WTMUtjOSZhJqkAK7kuFiRjzEVpFxVSLw4A0GZuq6a93jvV+tr4V1Z0
         u53xP6jB1PWvIpGF0COi9K43LcKe7dcLT+y2kCoJbLbrgjGvKQ31l6dSylDCzWktP0HL
         UutFe7IF6VuNnWl/N8iBpuuivGB1zveqtJc8hPk0oijZEZJ5NNP5cN4mKsWXA1WYNkqK
         L8PJSVwHJFFH7cCg21s/L3gZx07DTcFQe+vRfhX7MQVZ1ZgAmLN9hGFFY23R3Xw08lEY
         QMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mCcIdVfqpMkg5UQ5BejYHI9LrriD6R4thQPfErSOuSE=;
        b=rOQyaWEse5whCEPtLtC/gVs72glCDkjlGNy6hyyXlpnh6zLYL3fEd9CK2yf3vWvMRM
         ujhPZJXZKb4NBq58ZN3Y7bJXu8t6Q505pwYm7Mi0dCujnhWahIr4dCauYMZXKsIycabE
         POeTowfjfoEM8XQeVfmabJwbqRmgAMtYxWdvgda9hY5nfTxbwZhW0TaFaR88WRTP1Fq1
         iL7uRYl6n76UNY0vqvi6KgAMiO41n+/olYksIREIHMtp/6iV3Na7KUqhH3fOTEpj9xxA
         PVD0mFVebyBKSI+wxjgRDZSEnIkAstOlG+dZFIso22jdShDjlRfSxp8H48yG/Rgu/lGT
         wuuw==
X-Gm-Message-State: AOAM53324hxo4OP3HkKUJwt/3mzf1mqrvwLAilizt2HtPRUxpZQGf4Dl
        IHmGK/Za5i1z2fGLsZlAxoAJOQ==
X-Google-Smtp-Source: ABdhPJxfaNVDG+/hNhTbp/F9IaRl1DSEZ5QDk79u7mIA9aBJWTeKyNQxq/BvxmJ2QTsxLt7h5+ilyg==
X-Received: by 2002:a05:600c:1549:: with SMTP id f9mr40371779wmg.118.1638805199133;
        Mon, 06 Dec 2021 07:39:59 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:92e6:b95f:6ce2:9f04? ([2a01:e34:ed2f:f020:92e6:b95f:6ce2:9f04])
        by smtp.googlemail.com with ESMTPSA id l1sm590039wrn.15.2021.12.06.07.39.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 07:39:58 -0800 (PST)
Subject: Re: [PATCH] drivers/clocksource/dw_apb_timer_of: fixed probe failure
To:     Alexey Sheplyakov <asheplyakov@basealt.ru>,
        linux-kernel@vger.kernel.org
Cc:     "Vadim V . Vlasov" <vadim.vlasov@elpitech.ru>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20211109153401.157491-1-asheplyakov@basealt.ru>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <05e1ee4a-7718-9cec-607d-5ce3569636fc@linaro.org>
Date:   Mon, 6 Dec 2021 16:39:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211109153401.157491-1-asheplyakov@basealt.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2021 16:34, Alexey Sheplyakov wrote:
> The driver refuses to probe with -EINVAL since the commit
> 5d9814df0aec ("clocksource/drivers/dw_apb_timer_of: Add error handling if no clock available").
> 
> Before the driver used to probe successfully if either
> "clock-freq" or "clock-frequency" properties has been specified
> in the device tree.
> 
> That commit changed
> 
> if (A && B)
> 	panic("No clock nor clock-frequency property");
> 
> into
> 
> if (!A && !B)
> 	return 0;
> 
> That's a bug: the reverse of `A && B` is '!A || !B', not '!A && !B'
> 
> Signed-off-by: Vadim V. Vlasov <vadim.vlasov@elpitech.ru>
> Signed-off-by: Alexey Sheplyakov <asheplyakov@basealt.ru>
> Fixes: 5d9814df0aec56a6 ("clocksource/drivers/dw_apb_timer_of: Add error handling if no clock available").
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Vadim V. Vlasov <vadim.vlasov@elpitech.ru>
> ---

Applied, thanks

>  drivers/clocksource/dw_apb_timer_of.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/dw_apb_timer_of.c b/drivers/clocksource/dw_apb_timer_of.c
> index 3819ef5b7098..3245eb0c602d 100644
> --- a/drivers/clocksource/dw_apb_timer_of.c
> +++ b/drivers/clocksource/dw_apb_timer_of.c
> @@ -47,7 +47,7 @@ static int __init timer_get_base_and_rate(struct device_node *np,
>  			pr_warn("pclk for %pOFn is present, but could not be activated\n",
>  				np);
>  
> -	if (!of_property_read_u32(np, "clock-freq", rate) &&
> +	if (!of_property_read_u32(np, "clock-freq", rate) ||
>  	    !of_property_read_u32(np, "clock-frequency", rate))
>  		return 0;
>  
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
