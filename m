Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80487590AEA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 06:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236755AbiHLEFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 00:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbiHLEFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 00:05:49 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01CD8E9AC
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 21:05:48 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id p14-20020a17090a74ce00b001f4d04492faso6960953pjl.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 21:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=DmoyVSWXIDjWkDxD/535JqvNJLgG0ANofKgHtTi6tF0=;
        b=O8MvQcTfJgsSvxWkirUafK7Bh78DV5u3hBoBq3oc3JcYJo4pe4lUT4MNc97fBsEqUi
         aFmG1Z3hgKBODhGhMXoIZO6XlC8B1SAugGqY1xXfe1H87/cnD8E5xC7Wo2zTqTcsxiaC
         WUyhQgHRb+IelY0S2pzjWA5NFQFIc3HPfi5yg/OoUf9gGGPzSPM2lqOL0rjezrGLyWvG
         0sUOaH6MBfUsomr4jQQVayG03E1rki774FmLMCHEm8yQO7WchkoBu4uKzdbZTbEMUSQ2
         nynJ8MhfWO7vr68l/0I7GJ5RVbL1kWPveebTlrq9dswSjjSNuZ3Z6GGwn98GzHmII4nz
         xdeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=DmoyVSWXIDjWkDxD/535JqvNJLgG0ANofKgHtTi6tF0=;
        b=kIIyRmyl7TM5ExZFf6s3wB6trNL6Nr5kWGOQ0i6PP6mOMyzv2mSBXCQNvDG1gUVl+F
         V52uz1wg4nG0ID3lTfPAP8U44Wmy2IWZ6GxzSlAYO6bKxfqbWxP5mkB6LmiTDSQen6W5
         nUP5Drl7rPvNzQNcqPqtg8LzbNuOdJzuwV9udZaoLe3uRR6/SbBV/7B1bRC9Q1IDtWSn
         4p9In1a+ltaL30sZOT1oh8NvyU3lO11v6NQVvZTNFUgmDe2gJdZg697fnA2FEzkVHWTn
         Tt4/2Yo/6IgY0FusJEiN0SgdSutaPgAzWn+q7xsgrdCINajV+yP0R5TPoLdvaVyUWfVw
         l95Q==
X-Gm-Message-State: ACgBeo1+7oAZ07fXbkM2YtteJCtQuJOWA/5jxAUz8WZjcnyIgKEDjndy
        Cl7T07YNTHpcLSGUvPQVpafNQ4yIZy+s7A==
X-Google-Smtp-Source: AA6agR67PVkH2ZYPw4wvqs0B15TlDcQddT+dSsclrta1f5iFHLvGhbe9cJmamOHtST0r5/zQ1ThWow==
X-Received: by 2002:a17:903:1c7:b0:16f:1228:f632 with SMTP id e7-20020a17090301c700b0016f1228f632mr2218461plh.65.1660277148355;
        Thu, 11 Aug 2022 21:05:48 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id 14-20020a17090a190e00b001eff36b1f2asm576609pjg.0.2022.08.11.21.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 21:05:47 -0700 (PDT)
Date:   Fri, 12 Aug 2022 09:35:45 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: check only freq_table in __resolve_freq()
Message-ID: <20220812040545.gcmyjjpqfup3bo5u@vireshk-i7>
References: <20220811165408.23027-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811165408.23027-1-lukasz.luba@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-08-22, 17:54, Lukasz Luba wrote:
> The there is no need to check if the cpufreq driver implements callback

s/The there/There/

> cpufreq_driver::target_index. The logic in the __resolve_freq uses
> the frequency table available in the policy. It doesn't matter if the
> driver provides 'target_index' or 'target' callback. It just has to
> populate the 'policy->freq_table'.
> 
> Thus, check only frequency table during the frequency resolving call.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/cpufreq/cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 7820c4e74289..69b3d61852ac 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -532,7 +532,7 @@ static unsigned int __resolve_freq(struct cpufreq_policy *policy,
>  
>  	target_freq = clamp_val(target_freq, policy->min, policy->max);
>  
> -	if (!cpufreq_driver->target_index)
> +	if (!policy->freq_table)
>  		return target_freq;
>  
>  	idx = cpufreq_frequency_table_target(policy, target_freq, relation);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
