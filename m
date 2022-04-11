Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D664FB22C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 05:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244487AbiDKDMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 23:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244483AbiDKDMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 23:12:31 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A6D2F397
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 20:10:18 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 125so12977254pgc.11
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 20:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CVRkw5t01Nmk7+snBxeMb6nwWxRUV60F+573FtVvM4g=;
        b=rW8dhQVTF8QXZlGn920I+WmVa8D4tfousyRnOKkpTEyItN4m8iub7IdWlSPz3yhhX4
         Av5Z01m90bIWD2j18yFGtIKqUPH7vPASznvVdTGPPj08sv7TFQibmQlIm6vU02f+iu6s
         e5zZCICOyquFz9LECrvqnLGIiQKNq1hnAnOCfs7T7Umqf9Ta4gdljRbKwVEoz7MwuKMr
         omgbvQC12sHZSjdSBuJS5865uamehhxSvk8z9x/pmH7YUuobSXms14+vRkoY8LVTdXxY
         VFj3Tb7r0rFOV8tmMePPd2fkmdo5ecWjKwg4/C/jWEwrHIDi2gp9ketaR6tk1zOa+mBF
         0asA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CVRkw5t01Nmk7+snBxeMb6nwWxRUV60F+573FtVvM4g=;
        b=DM4vnYZdeaoI4Fc2NeBu4U83FG2LoLOgni8rZ1w+0bfOpdzUcIByosEyKx6u8a0F8x
         xiv4/505c5VHEs+NxTkT5whpXiHvcr7LF9BhapukPbQQQfX5do2kppuUB04dIcq8Mqej
         PnmAWauoybeaWHqR/tDtnosXQvEQ6kahZ19L8l6s/YQFI7mPBqSeBKXxnsHWJbxyZINX
         3nYGegW89g6gcR9FyzpPOKu2/q0IpRe8onzD99gKjqLPqxFZ2iQDpxEArSMoGQ/DM5xk
         XWA+WG/eSIpk1Ep1xVEDtp0yZkyMUrW/4ck2O7HNDJoMMz7kk4gGyJNYUlJydYCrGzyi
         YtNA==
X-Gm-Message-State: AOAM533JuBMsfveUWSeIRuqZoEmiBK3UD1G7zVEwnkleYN0gefh0gVab
        APRNX+fppJ0+omqiweqtDYaKwg==
X-Google-Smtp-Source: ABdhPJxg4yYcjh2Dq5/RErpsuz/VEb4T1OWkzBJyXOmI8/phcTmcB+ZGdOOv6tCpGAqTuazx/k7KXw==
X-Received: by 2002:a05:6a02:19c:b0:399:3007:c8fb with SMTP id bj28-20020a056a02019c00b003993007c8fbmr24674158pgb.571.1649646617709;
        Sun, 10 Apr 2022 20:10:17 -0700 (PDT)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id g14-20020a65580e000000b0039ce0873289sm9445205pgr.84.2022.04.10.20.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 20:10:17 -0700 (PDT)
Date:   Mon, 11 Apr 2022 08:40:15 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org, Ionela.Voinescu@arm.com,
        Lukasz.Luba@arm.com, Morten.Rasmussen@arm.com,
        Dietmar.Eggemann@arm.com, maz@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Fuad Tabba <tabba@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] cpufreq: CPPC: Add cppc_cpufreq_search_cpu_data
Message-ID: <20220411031015.skh3dw6vcbtn5f4u@vireshk-i7>
References: <20220407081620.1662192-1-pierre.gondois@arm.com>
 <20220407081620.1662192-2-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407081620.1662192-2-pierre.gondois@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-04-22, 10:16, Pierre Gondois wrote:
> From: Pierre Gondois <Pierre.Gondois@arm.com>
> 
> cppc_cpufreq_get_cpu_data() allocates a new struct cppc_cpudata
> for the input CPU at each call.
> 
> To search the struct associated with a cpu without allocating
> a new one, add cppc_cpufreq_search_cpu_data().
> Also add an early prototype.
> 
> This will be used in a later patch, when generating artificial
> performance states to register an artificial Energy Model in the
> cppc_cpufreq driver and enable the Energy Aware Scheduler for ACPI
> based systems.
> 
> Signed-off-by: Pierre Gondois <Pierre.Gondois@arm.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 82d370ae6a4a..ffcd9704add2 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -41,6 +41,8 @@
>   */
>  static LIST_HEAD(cpu_data_list);
>  
> +static struct cppc_cpudata *cppc_cpufreq_search_cpu_data(unsigned int cpu);
> +
>  static bool boost_supported;
>  
>  struct cppc_workaround_oem_info {
> @@ -479,6 +481,19 @@ static void cppc_cpufreq_put_cpu_data(struct cpufreq_policy *policy)
>  	policy->driver_data = NULL;
>  }
>  
> +static struct cppc_cpudata *
> +cppc_cpufreq_search_cpu_data(unsigned int cpu)
> +{
> +	struct cppc_cpudata *iter, *tmp;
> +
> +	list_for_each_entry_safe(iter, tmp, &cpu_data_list, node) {
> +		if (cpumask_test_cpu(cpu, iter->shared_cpu_map))
> +			return iter;
> +	}
> +
> +	return NULL;
> +}

Did you miss this in cppc_cpufreq_cpu_init() ?

	policy->driver_data = cpu_data;

The data is saved inside the policy and it shouldn't be difficult to
fetch it from there, instead of going through the list.

-- 
viresh
