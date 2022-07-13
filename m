Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDCCC572D1D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 07:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbiGMF32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 01:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbiGMF3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 01:29:23 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4886637F96
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 22:29:21 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id b8so9096503pjo.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 22:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HUozti81beYC0cvGR7fZyzvI+p1k+KO29s0kn2+X7Ik=;
        b=TguzphT4cR7VycMxRRdXsReDeFJExFdOLjtiCxkPMAYimQ0CJkhpNuWAigCN9bRqO6
         T7DNLJxZS8tuRgkKlMIcCDRsO3de/oV90tujevpYh7SfwdREpTYFcnisXkfvbIQA1mAo
         9FPgZLmp4eR47c1Gb9m9kqjbrtjo/E0MhvYVXiDCQkNtr+c+JmCjW7Jenj70Ml6R/93a
         cjmg2dmIgDCETss2lKW7LA/lSh2FhBbdy/oEyppp090Anz79HqyWfJ8skujXKztJzjPi
         pXFVtspWT1tiaXw7bLAkBCQX45gL0VlLLZlpXm83K+sYHCLg+G8M04CI076J6amMsZHR
         aMDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HUozti81beYC0cvGR7fZyzvI+p1k+KO29s0kn2+X7Ik=;
        b=5zMpKJVPgCiLDL4Q4ZsLJb8+vo3hz0tTVgpRPX/xDWkwYmLZnKh+edRbQU2fOGXBg8
         G8r1wXRLn0UiXr131d3VOwSTmEINrVK4QZ4//9u3hjKt4mJzKP3iHBMSgWg+sIEj+N7H
         CrnyCQmEfEZKX/E1Qu4KA78vguKxC8ZaHTwb68/GadB8DJLcn+jnAYM80OexQJAHh+7A
         Dp8U+OEz62KfKRcFf0Jy/X8H1RyOph8FKfTeRqoi4oj8U8FFBQ2gig5OKu/4sZYMSXWC
         TIuDX+JrjrAMimmgOQ6WliHxaX8oCKF5O9IL6brf3YNWsPH/hq7hjVZj2+8t0+zekPUF
         hEAQ==
X-Gm-Message-State: AJIora+drL0jk67vKQzt6X5HdbZ4eELTuM0koMysIxHLDBQWxyCf0KF/
        nurYYyUiUF2NPiFKqjXgbphglA==
X-Google-Smtp-Source: AGRyM1vk//Bn0hPLeFseIw8PUc72qLKwUYnGHzfcZfKtszc5nnb4Lt+qtKKj9lo4dD/pukW2odiuVQ==
X-Received: by 2002:a17:90b:247:b0:1f0:1192:7c22 with SMTP id fz7-20020a17090b024700b001f011927c22mr1995490pjb.232.1657690160833;
        Tue, 12 Jul 2022 22:29:20 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id s5-20020a170902ea0500b0016a058b7547sm7931507plg.294.2022.07.12.22.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 22:29:19 -0700 (PDT)
Date:   Wed, 13 Jul 2022 10:59:15 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Perry Yuan <Perry.Yuan@amd.com>
Cc:     rafael.j.wysocki@intel.com, Ray.Huang@amd.com,
        Deepak.Sharma@amd.com, Mario.Limonciello@amd.com,
        Nathan.Fontenot@amd.com, Alexander.Deucher@amd.com,
        Jinzhou.Su@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
        Li.Meng@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 11/13] cpufreq: amd_pstate: update transition delay
 time to 1ms
Message-ID: <20220713052915.fehpq5bearsof6ad@vireshk-i7>
References: <cover.1657638462.git.Perry.Yuan@amd.com>
 <b138d38ecd1aeef1121971071380ac538c07a747.1657638462.git.Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b138d38ecd1aeef1121971071380ac538c07a747.1657638462.git.Perry.Yuan@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-07-22, 11:42, Perry Yuan wrote:
> Update transition delay time to 1ms, in the AMD CPU autonomous mode and
> non-autonomous mode, CPPC firmware will decide frequency at 1ms timescale
> based on the workload utilization.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> Signed-off-by: Su Jinzhou <Jinzhou.Su@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index a9918728948a..83570acecc78 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -42,7 +42,7 @@
>  #include "amd-pstate-trace.h"
>  
>  #define AMD_PSTATE_TRANSITION_LATENCY	20000
> -#define AMD_PSTATE_TRANSITION_DELAY	500
> +#define AMD_PSTATE_TRANSITION_DELAY	1000
>  
>  /*
>   * TODO: We need more time to fine tune processors with shared memory solution

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
