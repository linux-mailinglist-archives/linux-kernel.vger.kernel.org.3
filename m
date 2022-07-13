Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3C3572D10
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 07:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbiGMF1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 01:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiGMF1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 01:27:32 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16686DC1BF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 22:27:32 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id r186so2281967pgr.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 22:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uFdlTFZaziEXd0kF/pDUESISiZMiiJ98nmUQPL+vTzE=;
        b=fZZFRIzIy2WPrWHGwM/glKxoP+BsaESKtozPw+qSkaqbKLG3xvoxCAXN2T9P5+R9S2
         N4Ymvja1AnhZN5Ctb2JCEySJmdasLqN5LNkY9qrEjYUwsFLYUgHbxxWkDpGns6/AXMkn
         qQ0i3nsP9lXjb/u2Q0OMVNpjXdD4t7zfMRBG/Ywb+LCauYjQ1pzy6dBL3muX+4eUcYUz
         YGQKXHrAD6H6FHbL69Cb2zOcRJczoCd+DGTrLCydFYS6W2bpoBOB8PC1asSb/PVnbSSN
         nVuuc+1v6t1P2ZxnqRgXIMNkFiq2mBrXEulEF9cMPp+nPbnQ/25FiTETWAJgiSajlKUr
         Si7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uFdlTFZaziEXd0kF/pDUESISiZMiiJ98nmUQPL+vTzE=;
        b=LVXHaBRMZxrO2WqyVS8wn6NEcBQy3xHG1O9fWwdRZIg2ml/1hj6gUgHsDjbOAHzD/x
         j9hEiDs1itpvoeHkqD+nh96bITARbIuiKBax5c+N4rTT+HKBRqQYyYvM0qHKRH9PcQXH
         DL8UOAJNq29D3qtsWwyhTCijI758GqCwkYr1r3Qjhn9gycn8/dclHT0Pv2kLsKPHDokL
         1SjDLBUAUPbY/8zbk0OSjrRjhgLJNBgoX6BI0kawngDpxfXEKiD0yqiVU4DUidgsuRPe
         k1TX0N35yeQk/MAxp81oEVQkn3j76Y5Mmqa3bNcGWXIap9bsYJE3JE77vc//gZ9+viyc
         OKyg==
X-Gm-Message-State: AJIora+KOq8/Dcs9irB5KCLnk8/lx57Tnc3A+36BEbJDMiY+2wSsld+/
        pyrzu7SV0Wg+iBjOt97uabH21Q==
X-Google-Smtp-Source: AGRyM1u7ftyeHhBnp/xvjRpWSqLg9LcV90frO07w9pRJdZdL/Kc+fLhv4zEULbXgulgC+htMl8eFgw==
X-Received: by 2002:a62:fb0c:0:b0:52a:b71d:5c6b with SMTP id x12-20020a62fb0c000000b0052ab71d5c6bmr1630377pfm.34.1657690051560;
        Tue, 12 Jul 2022 22:27:31 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id y11-20020aa79aeb000000b00525203c2847sm7793340pfp.128.2022.07.12.22.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 22:27:31 -0700 (PDT)
Date:   Wed, 13 Jul 2022 10:57:27 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Perry Yuan <Perry.Yuan@amd.com>
Cc:     rafael.j.wysocki@intel.com, Ray.Huang@amd.com,
        Deepak.Sharma@amd.com, Mario.Limonciello@amd.com,
        Nathan.Fontenot@amd.com, Alexander.Deucher@amd.com,
        Jinzhou.Su@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
        Li.Meng@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 05/13] cpufreq: amd-pstate: simplify cpudata pointer
 assignment
Message-ID: <20220713052727.sscawtpp3okwi7dv@vireshk-i7>
References: <cover.1657638462.git.Perry.Yuan@amd.com>
 <34465aace57a9ace28f9fb2c4599bcc8cdae8286.1657638462.git.Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34465aace57a9ace28f9fb2c4599bcc8cdae8286.1657638462.git.Perry.Yuan@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-07-22, 11:40, Perry Yuan wrote:
> move the cpudata assignment to cpudata declaration which
> will simplify the functions.
> 
> No functional change intended.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index e4904da54541..fc0de9fd643b 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -571,9 +571,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  
>  static int amd_pstate_cpu_exit(struct cpufreq_policy *policy)
>  {
> -	struct amd_cpudata *cpudata;
> -
> -	cpudata = policy->driver_data;
> +	struct amd_cpudata *cpudata = policy->driver_data;
>  
>  	freq_qos_remove_request(&cpudata->req[1]);
>  	freq_qos_remove_request(&cpudata->req[0]);
> @@ -615,9 +613,7 @@ static ssize_t show_amd_pstate_max_freq(struct cpufreq_policy *policy,
>  					char *buf)
>  {
>  	int max_freq;
> -	struct amd_cpudata *cpudata;
> -
> -	cpudata = policy->driver_data;
> +	struct amd_cpudata *cpudata = policy->driver_data;
>  
>  	max_freq = amd_get_max_freq(cpudata);
>  	if (max_freq < 0)
> @@ -630,9 +626,7 @@ static ssize_t show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *poli
>  						     char *buf)
>  {
>  	int freq;
> -	struct amd_cpudata *cpudata;
> -
> -	cpudata = policy->driver_data;
> +	struct amd_cpudata *cpudata = policy->driver_data;
>  
>  	freq = amd_get_lowest_nonlinear_freq(cpudata);
>  	if (freq < 0)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
