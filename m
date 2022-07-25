Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D7D57FD7B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 12:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbiGYKa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 06:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbiGYKa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 06:30:57 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFE726F1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 03:30:56 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 70so10069838pfx.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 03:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1xGF5aFfgJ7JsFSzowx7exjTtEsle8A3v3zLVOTakyA=;
        b=EG5fUr3iThznm85cLXUOslnsHpTFUwpixcv/8sZ2g3CLIlM/kCwFlXQiIHWs/dnwGw
         wDU6PN8b+uWmrrLW+8ctX40y4g05jmheRhEIGS46PXR44PNpaN8tbd0RBEv08rPss6N3
         6hm96atbOFyLknMmH18KxKWLLpEBxMiBBMIxrVzfvKyuYOHm6W4wLDRIftfSERAmM/HV
         /fBbaw6Xi5I77o0txbbUXu8cuvzj4nnh2NKsDwvwHXKg5DlkjADcxsEyiG1G7iSYSf3T
         2x2t22AFVLHEvy0AVN6wHENDSm/KEwvBl2woopG2w5ui6Fck9fM4rY/sky27KJVEcgA+
         HNMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1xGF5aFfgJ7JsFSzowx7exjTtEsle8A3v3zLVOTakyA=;
        b=rHzxZoNqtaLX7IxAqcaT4TvE8x4/JdV8HDAmSsAUf4Md2QPQX9t0XMY/x8hD9QFW4C
         6AP4/ldPT0aAQ2QqCnENPEPt6xfQdSlmJO2wJihSniSwJmYmHLXWJeXwNoJjNhLV4Z7D
         IVMYwJq6e3GAJHlk61bNt8AgOQdEjzg3YzCSi1xxC+k+G+5SQkVQYLgvl9dt/f0Oh1uu
         t1KKZMDCK2k/L6WRL7X5xvnzaXZ1s2Zc3SvqAk/fepmBEHBHUC+TnTxL+b0e1K2xmdK6
         WiOMvPEFvoQBjPqqzLPgX6w3wKQilwesFxbvtkvoxVwRE8cf43uLwQmtu3gP5bmebOa7
         OJfw==
X-Gm-Message-State: AJIora8xfZebJo5xCE+aJ8wAaCe4wJ1TRS9nowSgzNSCUG72mHSRfCbL
        vrqUHyjIfnapgs75cn3MpDCO0w==
X-Google-Smtp-Source: AGRyM1vjAokCn70WjNP0yJgI/UhAc0WGLoWPLIyuJlNCIMbyXXC/NmZQZ+40z+hilq8a/U95N994RQ==
X-Received: by 2002:a05:6a00:1c94:b0:52a:b71d:5c65 with SMTP id y20-20020a056a001c9400b0052ab71d5c65mr12334582pfw.65.1658745056241;
        Mon, 25 Jul 2022 03:30:56 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id y14-20020a63180e000000b0041af82dacf7sm1783279pgl.73.2022.07.25.03.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 03:30:55 -0700 (PDT)
Date:   Mon, 25 Jul 2022 16:00:53 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Zhao Liu <zhao1.liu@linux.intel.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, trivial@kernel.org,
        Rusty Russell <rusty@rustcorp.com.au>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [patch] cpufreq: ondemand: Use cpumask_var_t for on-stack cpu
 mask
Message-ID: <20220725103053.o45ly6rnq7vyfdup@vireshk-i7>
References: <20220722025024.454626-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722025024.454626-1-zhao1.liu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-07-22, 10:50, Zhao Liu wrote:
> A cpumask structure on the stack can cause a warning with
> CONFIG_NR_CPUS=8192 (e.g. Ubuntu 22.04 uses this):
> 
> drivers/cpufreq/cpufreq_ondemand.c: In function 'od_set_powersave_bias':
> drivers/cpufreq/cpufreq_ondemand.c:449:1: warning: the frame size of
> 	1032 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>   449 | }
>       | ^
> 
> CONFIG_CPUMASK_OFFSTACK=y is enabled by default for most distros, and
> hence we can work around the warning by using cpumask_var_t.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@linux.intel.com>
> ---
>  drivers/cpufreq/cpufreq_ondemand.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
> index e8fbf970ff07..c52d19d67557 100644
> --- a/drivers/cpufreq/cpufreq_ondemand.c
> +++ b/drivers/cpufreq/cpufreq_ondemand.c
> @@ -416,10 +416,13 @@ static struct dbs_governor od_dbs_gov = {
>  static void od_set_powersave_bias(unsigned int powersave_bias)
>  {
>  	unsigned int cpu;
> -	cpumask_t done;
> +	cpumask_var_t done;
> +
> +	if (!alloc_cpumask_var(&done, GFP_KERNEL))
> +		return;
>  
>  	default_powersave_bias = powersave_bias;
> -	cpumask_clear(&done);
> +	cpumask_clear(done);
>  
>  	cpus_read_lock();
>  	for_each_online_cpu(cpu) {
> @@ -428,7 +431,7 @@ static void od_set_powersave_bias(unsigned int powersave_bias)
>  		struct dbs_data *dbs_data;
>  		struct od_dbs_tuners *od_tuners;
>  
> -		if (cpumask_test_cpu(cpu, &done))
> +		if (cpumask_test_cpu(cpu, done))
>  			continue;
>  
>  		policy = cpufreq_cpu_get_raw(cpu);
> @@ -439,13 +442,15 @@ static void od_set_powersave_bias(unsigned int powersave_bias)
>  		if (!policy_dbs)
>  			continue;
>  
> -		cpumask_or(&done, &done, policy->cpus);
> +		cpumask_or(done, done, policy->cpus);
>  
>  		dbs_data = policy_dbs->dbs_data;
>  		od_tuners = dbs_data->tuners;
>  		od_tuners->powersave_bias = default_powersave_bias;
>  	}
>  	cpus_read_unlock();
> +
> +	free_cpumask_var(done);
>  }
>  
>  void od_register_powersave_bias_handler(unsigned int (*f)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
