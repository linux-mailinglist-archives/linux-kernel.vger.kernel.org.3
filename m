Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7750F5323BE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 09:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbiEXHKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 03:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiEXHKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 03:10:46 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D842191581
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:10:44 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d22so15102587plr.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s4RgkpbA4+wgN1VIiXpbn55K/axUWaAjCqs3G3c0q8U=;
        b=HPfwIihDUCA8WLP358Tgf1BmDppGVMRBQaRhXYNELyfbtPLbUB23IpYKV9EPLfUhA+
         tY1nSqVndojxQJ/zwNFZyRrSv9qpVupad8svmuiE9KUM+MCh7jAXBhw/Nm75X6BZj9tC
         EaM75FCxGl641Yfgo0FlzHPOFAzoqI9aB4lSDcMKWBzuw2ZwFzZS7WBG/46unuUMQSLB
         wSOiluZRmSr2MnDU6ObRK18tf8D3BNL3Efgnig+97qC4tu4ZtXtTFXDVa7Qn8mvkptE6
         GZl9hPsEb4LupNTZ6jzP5AviK4IH8xSasaeFXopVWIYkDccIZ+hoZQ2tqUvCeyxjbMgG
         YqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s4RgkpbA4+wgN1VIiXpbn55K/axUWaAjCqs3G3c0q8U=;
        b=fI90XS9B1k32+m0IhuzEjWbFyMzJJWdhYvxnvk+PpgfB9EKPD+2Lu73MszpDN5CzeL
         pheSIOwqzP/71ZRHdtHwEOKtaBSpiV8izbi+R54WhuWndpQ1bgDicwA+6MKp+hrGCH/j
         F7gdPeDvBEjlNQbE7QoFUr7MU7tmjhKbtYaM/jSk2fufRfeWEhYNOaRUHrK23EREvhOF
         GcNyG9rLBGYuAE1iupkygF8nu8vHCoszumPllKGVxMwcSHPZpnuDL9FT4eDNGOkb0BO1
         pcNarOYlmM8P8rz7wG/46RpylhKEFfjikZNgLHpWHil90QOqqhIU/GKo1N0rwPVRen1b
         u5dw==
X-Gm-Message-State: AOAM533yH2TM70sDY3XvEp6GmypEZP9NGHtEjA/kVdpBld4Dh7afmud4
        5iB16NVy3q0sfLUju7dWrFXNLv6oX/oWLQ==
X-Google-Smtp-Source: ABdhPJwQ8qMw6FoYVNq9hR8cYXd3NG1VcOxK2FgDIOBBo0BkI22ZrjqhPCaFIq9VW3yxLeRcL++nvg==
X-Received: by 2002:a17:90a:408e:b0:1dd:4847:cbcc with SMTP id l14-20020a17090a408e00b001dd4847cbccmr3159917pjg.214.1653376244445;
        Tue, 24 May 2022 00:10:44 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id j6-20020a170902690600b001621ce92196sm4221269plk.86.2022.05.24.00.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 00:10:43 -0700 (PDT)
Date:   Tue, 24 May 2022 12:40:41 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yi Yang <yiyang13@huawei.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] cpufreq: Fix reserved space in cpufreq_show_cpus()
Message-ID: <20220524071041.4aw3cfo3x5wphziy@vireshk-i7>
References: <20220521063534.138930-1-yiyang13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521063534.138930-1-yiyang13@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-05-22, 14:35, Yi Yang wrote:
> Function scnprintf() would reserve space for the trailing '\0' and return 
> value is the number of characters written into buf not including the 
> trailing '\0'. internally meaning the next scnprintf() would write begin 
> the trailing '\0'. The code specifying "PAGE_SIZE - i - 2" here is trying 
> to reserve space for "\n\0" which would cause scnprintf() to reserve an 
> additional byte making the tail of the buf looks like this: "\n\0\0". 
> Thus. we should reserve only the space for one '\0'. passing in 
> "PAGE_SIZE - i - 1".
> 
> Additionally, each iteration would replace the trailing '\0' from the last 
> iteration with a space, and append 4 additional bytes to the string making 
> it a total of 5 additional bytes. That means we should stop printing into 
> the buffer if the remaining size is less than 7 bytes(1 for the ' ', 4 for 
> the %u and 2 for the tailing "\n\0")
> 
> Signed-off-by: Yi Yang <yiyang13@huawei.com>
> ---
>  drivers/cpufreq/cpufreq.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 1f6667ce43bd..60c005c9961e 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -844,9 +844,9 @@ ssize_t cpufreq_show_cpus(const struct cpumask *mask, char *buf)
>  
>  	for_each_cpu(cpu, mask) {
>  		if (i)
> -			i += scnprintf(&buf[i], (PAGE_SIZE - i - 2), " ");
> -		i += scnprintf(&buf[i], (PAGE_SIZE - i - 2), "%u", cpu);
> -		if (i >= (PAGE_SIZE - 5))
> +			i += scnprintf(&buf[i], (PAGE_SIZE - i - 1), " ");
> +		i += scnprintf(&buf[i], (PAGE_SIZE - i - 1), "%u", cpu);
> +		if (i >= (PAGE_SIZE - 6))
>  			break;
>  	}
>  	i += sprintf(&buf[i], "\n");

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
