Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11EA4572D15
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 07:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbiGMF2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 01:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbiGMF2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 01:28:02 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAF6DC887
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 22:27:59 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id s206so9501301pgs.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 22:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jsIU21GxY0jw7A6ZuL2G44lOx42iYhHsc9FwP7Pd2+E=;
        b=BdmCytb6jqaYcl+01RLbP3+SQ2r+Tm1g5/hhbXs1xwXGdQmAG9BgbrFcBzX2Jpdf+r
         TALseKQqYevr3OWcUKDwUtngPrNC3bqioFe9KG8tMrYGOxNM+EfKq3q0UjmRsoHI8gVr
         aFIPyQx0abU6MLdDR9ed3FgbshXI9zGOKhBDBg+ZtH5UTTesu/PvZmmBYMcE8NtJFfBq
         3BzH4tROg82AIn5ctWwAVIoFft5TfhibpqJINWeHLMj7gJY2C3BTOIxGZmwGyfM2lw/w
         BqmRMAWAS9K9VHzO51LyzLNVwP10PGmawwBhlju4mJqOu2mnd4YI2KiV1nwhOuwmewo3
         5+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jsIU21GxY0jw7A6ZuL2G44lOx42iYhHsc9FwP7Pd2+E=;
        b=YolAStEB7+8EH8nTJbgx1oIYEtmYNUIbPuw+ThSX1jOCpYidr8s9xWvZufeOpbZTNY
         Y/IJJ8rJBTbGsiAXk+/nCYbpnRbKpGe04S8xQEEILZUfBYvX7kC5TlydnnlDdC7EvH4Q
         okKQ2uqtOtUJIyjGwBWKwtFNuLt/7D5TwfArYRynFFv1xR/6euRfGtO39zeYn5cpwN/3
         auTd9OHUxqC5d6cBvQAY5bHZFNCC2UwUIPgIIV6TtACWIyurCvGEIifOUpZr7kcBHjAs
         Gr2jkayHChERQM7RN9INrI3M1STAXMxeSNPfiZPBGjo8HhHK81yYXXyjt0IEN0vd+7h7
         9pUA==
X-Gm-Message-State: AJIora+591dNmbu4jsH1Ga7G0J96YLqs52O0kPDjP4/CQUIW7HXfo9F5
        F5h3TRY1AeljRVcxcJz18uuSOA==
X-Google-Smtp-Source: AGRyM1vFqH0Nq+hBZtZoJjedjibqVrcZPfKtR03x3CxqjPh01L0IqZOy1iYLH3qy5n2Q7dzA+pty3A==
X-Received: by 2002:a63:8441:0:b0:415:d595:a7d6 with SMTP id k62-20020a638441000000b00415d595a7d6mr1498052pgd.441.1657690078628;
        Tue, 12 Jul 2022 22:27:58 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id 31-20020a63165f000000b00416073ced8csm4430560pgw.73.2022.07.12.22.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 22:27:58 -0700 (PDT)
Date:   Wed, 13 Jul 2022 10:57:54 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Perry Yuan <Perry.Yuan@amd.com>
Cc:     rafael.j.wysocki@intel.com, Ray.Huang@amd.com,
        Deepak.Sharma@amd.com, Mario.Limonciello@amd.com,
        Nathan.Fontenot@amd.com, Alexander.Deucher@amd.com,
        Jinzhou.Su@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
        Li.Meng@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 06/13] cpufreq: amd_pstate: fix wrong lowest perf fetch
Message-ID: <20220713052754.25grlxfrc5bow67p@vireshk-i7>
References: <cover.1657638462.git.Perry.Yuan@amd.com>
 <f722668e668e4f77370ad3485b6a80da52168ca6.1657638462.git.Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f722668e668e4f77370ad3485b6a80da52168ca6.1657638462.git.Perry.Yuan@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-07-22, 11:41, Perry Yuan wrote:
> Fix the wrong lowest perf value reading which is used for new
> des_perf calculation by governor requested, the incorrect min_perf will
> get incorrect des_perf to be set , that will cause the system frequency
> changing unexpectedly.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> Signed-off-by: Su Jinzhou <jinzhou.su@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index fc0de9fd643b..7c51f4125263 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -308,7 +308,7 @@ static int amd_pstate_target(struct cpufreq_policy *policy,
>  		return -ENODEV;
>  
>  	cap_perf = READ_ONCE(cpudata->highest_perf);
> -	min_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
> +	min_perf = READ_ONCE(cpudata->lowest_perf);
>  	max_perf = cap_perf;
>  
>  	freqs.old = policy->cur;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
