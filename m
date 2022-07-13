Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B6E572D19
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 07:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbiGMF3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 01:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbiGMF2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 01:28:50 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1175E0D7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 22:28:44 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so1814332pjl.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 22:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wBDDOn3da9vCDzF6d+13O6shNTvgGuS119y+7OCvFQY=;
        b=g6MvlMZ34ZM8Ba1107yZ01iF8OzzD/YEfOrW7OyPc0pvxWNTzrpIR5Fmfm6b5b2RCl
         /qKEFeZUMkeyPsM7a8UC8dUAp9z4P7OMQ1xHCV5jn0qYw/lWUml2p5zh6FqIgzDJSheF
         /dYJkFqKOCU74ksw5Qa3T1jbaENOCD9gNOXSXHl+fe86q21uPBDAqy4qPvGmP4LErdND
         QBpPNH91SUDth4e33uA0t8L0XlPf/cI0BaEI5BgnCVQp3ZOxibJIr/entwlEPXGVncdF
         p1OdU84kyDsovGgqJsBVBQyeWixlCYmCk8ZFjjqOZd73irIXyHHqoSResCEfhlNW7QoD
         XwdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wBDDOn3da9vCDzF6d+13O6shNTvgGuS119y+7OCvFQY=;
        b=zL1YphKzMMpbvspredkkt0FKbLAolOipO5AuUDbKdejOdVVl06A8YLAle9beP/nLab
         CYCoRpIHkPLH+hh+qesVWJzSrvpDohmumVYp/Or0axufctxxRvOWnGMLFvy9yY6sQQLG
         KChsFcyOI+QYK5VNpu23CDbB7a0AdlwUa4SMWnS7UERbsBIJRXhydKS6aS15Nww0lEP5
         onnGgZ6RpmqxY8FXFvWjWy9IBvzaPiGZIoSOlgSPHweJdGpVDGYnqgVvuIY/ATN+dRL8
         Qp3QfydjdKqRUnD9aO9EknJlkBPCJoPv+G+xfF6+4eEdCgjmF4aO04uKjGmdoMs+N7Y3
         7iwg==
X-Gm-Message-State: AJIora9tokvbPIYqGrCiWO0UaNrdf1TO0VvvHI/BgeSUDQHPpdZpqJ7D
        AFYx7Aqv6eRZhab1bkAqdq00ww==
X-Google-Smtp-Source: AGRyM1tGl4R970THpmGe8F0G/zSyYr1GGyWarOzfLRHBAndJN/1Q/QSkmL1djlW3zwlQbXpyZRn9eg==
X-Received: by 2002:a17:903:245:b0:16b:9b6d:20bc with SMTP id j5-20020a170903024500b0016b9b6d20bcmr1497275plh.14.1657690123752;
        Tue, 12 Jul 2022 22:28:43 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id a21-20020aa794b5000000b00525b61f4792sm7810057pfl.109.2022.07.12.22.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 22:28:43 -0700 (PDT)
Date:   Wed, 13 Jul 2022 10:58:39 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Perry Yuan <Perry.Yuan@amd.com>
Cc:     rafael.j.wysocki@intel.com, Ray.Huang@amd.com,
        Deepak.Sharma@amd.com, Mario.Limonciello@amd.com,
        Nathan.Fontenot@amd.com, Alexander.Deucher@amd.com,
        Jinzhou.Su@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
        Li.Meng@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 08/13] cpufreq: amd-pstate: fix white-space
Message-ID: <20220713052839.525epx5eurgsetaj@vireshk-i7>
References: <cover.1657638462.git.Perry.Yuan@amd.com>
 <79c21c72c13a25aea0fe9b6eb3d3072c757f1017.1657638462.git.Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79c21c72c13a25aea0fe9b6eb3d3072c757f1017.1657638462.git.Perry.Yuan@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-07-22, 11:41, Perry Yuan wrote:
> Remove the white space and correct mixed-up indentation
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index f359b1b20140..312ccef62f58 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -115,7 +115,7 @@ struct amd_cpudata {
>  	struct amd_aperf_mperf cur;
>  	struct amd_aperf_mperf prev;
>  
> -	u64 freq;
> +	u64 	freq;
>  	bool	boost_supported;
>  	u64 	cppc_hw_conf_cached;
>  };
> @@ -671,7 +671,7 @@ static struct cpufreq_driver amd_pstate_driver = {
>  	.resume		= amd_pstate_cpu_resume,
>  	.set_boost	= amd_pstate_set_boost,
>  	.name		= "amd-pstate",
> -	.attr           = amd_pstate_attr,
> +	.attr		= amd_pstate_attr,
>  };
>  
>  static int __init amd_pstate_init(void)
> -- 

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
