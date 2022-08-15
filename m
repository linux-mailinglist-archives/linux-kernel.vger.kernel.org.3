Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603F6593141
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 17:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbiHOPFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 11:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbiHOPFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 11:05:08 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C34125C5E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 08:05:07 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id bs25so9404594wrb.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 08:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc;
        bh=MCA1hMQpnK0HqQOnzHElmz2K5YEbzgNOiGm5uNlZ9NM=;
        b=Kmg/AxbZYKOPjhL9GdG0ZtbGCzN/x6MlyF7w1qWVxszZaTa6DzYAiUIyMK6D43sBmE
         1/RgiW2RkwefP4mHRZ/d5qn2bkkIlxyJFabI3FYdMPxFGsFyTzij2L6PdTA6l7A10eeX
         qX8jQLxf74Uott7b+i0zoHasT0h1WC6y+YLaZJ2gyXBzKxeyEOIZ6WeLEAdAlUA4GMOw
         3kikrHmwEzPApOF1VS6FFv4Omz29xI0QyN/bVBeFfVhi7FlDMs8VDIGKc3wdy+QHKHVh
         rVBI8O6abcJJibQqm06mH0iHAdhiIWGNPH7pOMszw2u40cY9I5extrzN/QDPnulZHkxT
         AZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=MCA1hMQpnK0HqQOnzHElmz2K5YEbzgNOiGm5uNlZ9NM=;
        b=OWjO4XcZdODFvJAxn/+1H+sdDlR51+8UTGJBhslDcZXCZJFvbBqVHBy6oELff6P3nV
         GlvsZF7ZQfM906sxeoipzYEK0yhCBB6QZjgm8tvwrS4iSstNgJnaJ39whDq1k1F1bNIO
         B6eIHjNkodoBDvt73Fybt90X+n8BmpDZoKvfGM/bN1agaomza7s4+FaRzT+efXPXOZ4C
         38OBsVl/8EHhLPFecnKycLMQUJMbU1sjvUOAMKLqcWRF57OXVo9XvCYE9sN9VSvO2WEY
         3NWBsgfbWeahAvH1l9LVZkAk3DLz/7trj8bWc1szamoQPAdxPtPo5feFaAAR56yKFU8I
         fvCg==
X-Gm-Message-State: ACgBeo1G24cxVJ1AiTlh35vHRXYkHXmn5rOvu/X0VvNiNYyyPm0nqJS5
        M6P1HYFbhBn/RGwmM/Xh8omgtQ==
X-Google-Smtp-Source: AA6agR7apzivHJkSbKj554z1Y47byn8oha8XKoDHyC+cP39qavLHKfDRLWUUvu9uUHuaqergt2a3Ig==
X-Received: by 2002:a5d:59a2:0:b0:220:7a97:6215 with SMTP id p2-20020a5d59a2000000b002207a976215mr8767653wrr.556.1660575905741;
        Mon, 15 Aug 2022 08:05:05 -0700 (PDT)
Received: from localhost ([109.180.234.208])
        by smtp.gmail.com with ESMTPSA id h3-20020a05600c2ca300b003a5ea1cc63csm6376348wmc.39.2022.08.15.08.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 08:05:05 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@bytedance.com>
To:     Perry Yuan <Perry.Yuan@amd.com>
Cc:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>, <Deepak.Sharma@amd.com>,
        <Mario.Limonciello@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Jinzhou.Su@amd.com>,
        <Shimmer.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 4/7] cpufreq: amd_pstate: fix wrong lowest perf fetch
References: <20220814163548.326686-1-Perry.Yuan@amd.com>
        <20220814163548.326686-5-Perry.Yuan@amd.com>
Date:   Mon, 15 Aug 2022 16:05:04 +0100
In-Reply-To: <20220814163548.326686-5-Perry.Yuan@amd.com> (Perry Yuan's
        message of "Mon, 15 Aug 2022 00:35:45 +0800")
Message-ID: <87edxhim3j.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Perry,

Perry Yuan <Perry.Yuan@amd.com> writes:

> Fix the wrong lowest perf value reading which is used for new
> des_perf calculation by governor requested, the incorrect min_perf will
> get incorrect des_perf to be set , that will cause the system frequency
> changing unexpectedly.
>
> Reviewed-by: Huang Rui <ray.huang@amd.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> Signed-off-by: Su Jinzhou <jinzhou.su@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 5cdef6638681..183cdd4ba00e 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -307,7 +307,7 @@ static int amd_pstate_target(struct cpufreq_policy *policy,
>  		return -ENODEV;
>  
>  	cap_perf = READ_ONCE(cpudata->highest_perf);
> -	min_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
> +	min_perf = READ_ONCE(cpudata->lowest_perf);
>  	max_perf = cap_perf;
>  
>  	freqs.old = policy->cur;

This looks to be a pretty big change (lowest nonlinear vs lowest). Does
the patch need to be backported to older kernels?
