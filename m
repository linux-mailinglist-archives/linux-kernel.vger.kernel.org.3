Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048DE510F6E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 05:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346947AbiD0DVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 23:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiD0DVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 23:21:14 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A96415720
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 20:18:04 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id s14so456830plk.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 20:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XTLOas78RQ0/UyRSC2YDKTpbOeiAeOZCtumqdgYp4Z4=;
        b=mqSgWBPiZA5AOZKT6FykeD6jPdOPAmSH9NV6sFOFz8a3i0AnRvCiTCjNYuwdZ+tCCv
         gdE8VRhUJ1oNfG49hKS+xFeQCJFqTPR+nGg32RdalHPbCtc04r2U6JmyfhYwR+z8ou5m
         4SnX8J6xEUt2YGkfpLEX0TGC8aaSGfCSFpEE0+KmW8uI4Bb/QPUCzL+gWClk2JGHjQpz
         cVZQCTFmoR3RKcmVKCSvRTV3H8WEBItqH9wYErn1W2xSRGex0COZsSCofAonYxX3KTtI
         U0yxOkGL5qvKzKZ3GoAcCZ8ny3+D0vAJ2+PiStmirta8ou5U2iW+YVvBU17MqF2twsC9
         BBVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XTLOas78RQ0/UyRSC2YDKTpbOeiAeOZCtumqdgYp4Z4=;
        b=X5790KnronEwOVvmDCdkxxEYyMAxxPU3bzEw/p62qmGEsZBCwfG0T7aAezyjrkSVvf
         Ug8FzwE/+klNfuX24ax9wyb8t8aRxu99lSjlf3dZeHJr5njEWt44Zwq8e9xsIvRnEOWg
         IgHP7kd8ZMtbh50pLrWMnL7GpXmha+fj39BvYGgwqQ2VCu7Zqj+YHOoT+KVo+iLtoE0+
         8g9waJnP0PiBZM7+JYrtTtvXp4RjkzNh9Bb93XO1Lwv/9o1U0lPmQN4v324MN5Dg8yeH
         TZ+Df9fIO1KfsUyzXRXPuMMSvnA/i7vxkv75sbqb4EYCmxCxn4HaoZZs0Tz/SJ3h3EnS
         PCHg==
X-Gm-Message-State: AOAM530pJ+VBxym/zjKu8pDHvmKXcMcGhpBB0NXbYYNWNcZ4QQxBr9k7
        eclmzFn/dRCFQCR/6JUeGSCtDA==
X-Google-Smtp-Source: ABdhPJwUEsxKcRCpJmBZnAvMHtBIhDnOJS4DjfdCieo7LC2EPJV6RP0uzxjZi6XmsQoPF1XA84D7ag==
X-Received: by 2002:a17:90b:17c6:b0:1d2:8450:49b3 with SMTP id me6-20020a17090b17c600b001d2845049b3mr41331569pjb.246.1651029483817;
        Tue, 26 Apr 2022 20:18:03 -0700 (PDT)
Received: from localhost ([122.177.141.190])
        by smtp.gmail.com with ESMTPSA id e17-20020a637451000000b003c144b70a7csm609775pgn.77.2022.04.26.20.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 20:18:03 -0700 (PDT)
Date:   Wed, 27 Apr 2022 08:48:01 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] cpufreq: mediatek: Fix NULL pointer dereference in
 mediatek-cpufreq
Message-ID: <20220427031801.tlph5uyougr55yri@vireshk-i7>
References: <20220426111715.627609-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426111715.627609-1-wanjiabing@vivo.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-04-22, 19:17, Wan Jiabing wrote:
> Fix following coccicheck error:
> drivers/cpufreq/mediatek-cpufreq.c:464:16-23: ERROR: info is NULL but dereferenced.
> 
> Use pr_err instead of dev_err to avoid dereferring a NULL pointer.
> 
> Fixes: f52b16ba9fe4 ("cpufreq: mediatek: Use device print to show logs")
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  drivers/cpufreq/mediatek-cpufreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index bcabb3726a5b..901042e9a240 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -461,8 +461,8 @@ static int mtk_cpufreq_init(struct cpufreq_policy *policy)
>  
>  	info = mtk_cpu_dvfs_info_lookup(policy->cpu);
>  	if (!info) {
> -		dev_err(info->cpu_dev,
> -			"dvfs info for cpu%d is not initialized.\n", policy->cpu);
> +		pr_err("dvfs info for cpu%d is not initialized.\n",
> +			policy->cpu);
>  		return -EINVAL;
>  	}

Applied. Thanks.

-- 
viresh
