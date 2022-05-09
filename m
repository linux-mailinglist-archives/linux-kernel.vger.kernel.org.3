Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC6351F32F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 06:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiEIELK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 00:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234585AbiEIEB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 00:01:58 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FDBB12
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 20:58:06 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id t11-20020a17090ad50b00b001d95bf21996so15911264pju.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 20:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gdbezs0QmBsyjnJi5dwyJ2MtwfEgGmuJOx5ViW85kao=;
        b=pKaEHAkqHRxaceAW3KrzSAPAXOT8XmNW8DmvaG0eoQhTmuJf8v/CeftvVCKs4Rhlsx
         55WIx8ekBj0GNrJdEvifFk/9mF+kCO2cE4K2Cj65LGe+RPnsm6zsrszXXVYvRD0EXBzD
         9QeyY00ZIqUX/viojKFP/1AVmSs2BJw2px8TbQU8kteHBzGiOaZBkuSNP4K3UiYNH5cK
         VHSrRln3xyKEW7+w8sXdY+OOCfEOPZ/PJaZ7eAEprQZqsbpVprhVwKJl7yd0D8PKdsXr
         vrp5xl0kJJT2SPllAhJeE4OHUENlq/3+4dcA1ownNrN2Kdg45yAx0BBlOSIT/YfupI+m
         FFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gdbezs0QmBsyjnJi5dwyJ2MtwfEgGmuJOx5ViW85kao=;
        b=32k0KAON4dWn3dr7LvcAeKJH9fplaEKUr0gr9VQ9tHdEvc3Uzkl7VoOTFKEeF92SKz
         7CIiG6iM7DWVroZDZjglDuSJdQQjvsUrhWfDnooSSyD9NW6R2zL6AsxdoF77qB1eAEol
         qtTOMKzUgmUHOX5l+hhwaKpRL4KO3loeyqLxk8fRRaBu77ttBUl42ummWp6FoaGjv8Zn
         b8kUOWPOsKKwSG/EAONE1evXD8JSTNe/PXRmZglINc8PD8S4FgSlyQkqBVHxDf/uiAuq
         SZMOMaj/I0mIGVAgwGDJFbov04HeXXhzjUnZIX6UJWFM+t5PNemjumJyU9z3By4/R3DV
         aKcw==
X-Gm-Message-State: AOAM530iutZ2ltk5JGItPeyC79Ky4yAs9a4j2v7EFTUi4d02R0l6DS2h
        3hYlRiRYkpcNiVPOYK2ZM8ID3Q==
X-Google-Smtp-Source: ABdhPJwLuzll0sYEUNqhAy55UlGop9LH5++hnDqvhVxvsTdWwNCtvZkn/Lox795XDN0xKI+UOQsoJQ==
X-Received: by 2002:a17:90b:3850:b0:1dc:2948:bd38 with SMTP id nl16-20020a17090b385000b001dc2948bd38mr16060443pjb.29.1652068669261;
        Sun, 08 May 2022 20:57:49 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id u7-20020a170902b28700b0015e8d4eb24bsm5842376plr.149.2022.05.08.20.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 20:57:48 -0700 (PDT)
Date:   Mon, 9 May 2022 09:27:46 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Schspa Shi <schspa@gmail.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: fix race on cpufreq online
Message-ID: <20220509035746.aeggm4cut2ewcmmk@vireshk-i7>
References: <20220420191541.99528-1-schspa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420191541.99528-1-schspa@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I had to dig the old patch first before starting to review what your
next one does.

On 21-04-22, 03:15, Schspa Shi wrote:
> When cpufreq online failed, policy->cpus are not empty while
> cpufreq sysfs file available, we may access some data freed.
> 
> Take policy->clk as an example:
> 
> static int cpufreq_online(unsigned int cpu)
> {
>   ...
>   // policy->cpus != 0 at this time
>   down_write(&policy->rwsem);
>   ret = cpufreq_add_dev_interface(policy);

Please keep some code to help understand where we went from here. I am
sure you meant that we will error out in this case, but you removed
the relevant code.

>   up_write(&policy->rwsem);
> 
>   return 0;
> 
> out_destroy_policy:
> 	for_each_cpu(j, policy->real_cpus)
> 		remove_cpu_dev_symlink(policy, get_cpu_device(j));
>     up_write(&policy->rwsem);
> ...
> out_exit_policy:
>   if (cpufreq_driver->exit)
>     cpufreq_driver->exit(policy);
>       clk_put(policy->clk);
>       // policy->clk is a wild pointer
> ...
>                                     ^
>                                     |
>                             Another process access
>                             __cpufreq_get
>                               cpufreq_verify_current_freq
>                                 cpufreq_generic_get
>                                   // acces wild pointer of policy->clk;
>                                     |
>                                     |
> out_offline_policy:                 |
>   cpufreq_policy_free(policy);      |
>     // deleted here, and will wait for no body reference
>     cpufreq_policy_put_kobj(policy);
> }
> 
> Signed-off-by: Schspa Shi <schspa@gmail.com>
> ---
>  drivers/cpufreq/cpufreq.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 80f535cc8a75..0d58b0f8f3af 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1533,8 +1533,6 @@ static int cpufreq_online(unsigned int cpu)
>  	for_each_cpu(j, policy->real_cpus)
>  		remove_cpu_dev_symlink(policy, get_cpu_device(j));
>  
> -	up_write(&policy->rwsem);
> -
>  out_offline_policy:
>  	if (cpufreq_driver->offline)
>  		cpufreq_driver->offline(policy);
> @@ -1543,6 +1541,9 @@ static int cpufreq_online(unsigned int cpu)
>  	if (cpufreq_driver->exit)
>  		cpufreq_driver->exit(policy);
>  
> +	cpumask_clear(policy->cpus);
> +	up_write(&policy->rwsem);

This is simply buggy as now an error out to out_offline_policy or
out_exit_policy will try to release a semaphore which was never taken
in the first place. This works fine only if we failed late, i.e. via
out_destroy_policy.

The very first thing we need to do now is revert this patch. Lemme
send a patch for that and you can send a fresh fix over that once you
have a stable fix.

-- 
viresh
