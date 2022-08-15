Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B70593145
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 17:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbiHOPGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 11:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242623AbiHOPFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 11:05:51 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D046463
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 08:05:50 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id k6-20020a05600c1c8600b003a54ecc62f6so4034254wms.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 08:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc;
        bh=a9389HMELxJaALXWoZVA9uSSCnD92DID1O+kWIz5Q7Y=;
        b=l9idI3EXeXwoiHGPTiYG510sBtkNxnGlSmTuGO9OHaOzaotpxkME6sArmmJ3bEzq4l
         n8JQhllUV8VfzTLYKXX0uvgpq7br5CW3lfHPJOZgPv3eWnfbH1HkmMtk2t0mn6MQ+TQL
         ARUERBgY2SC8dKEijOhJ7izRiAd5zMJH3oH40ApIeIrvNWT5LiPf44IfjPTPeqUwJSHO
         bVvYWyvtu+tm3e41Ac5aa2WLLb2XAh4It6xlNKQLa12pGgBNfIF54Ef5iTuvMxGXtl9l
         3qMry9ey+PVw6Ir18jJAwDpP6yEkvQw9segjDYXfrQwVmkcCf1z4J+zxP2Ij2KBNe+8J
         5G0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=a9389HMELxJaALXWoZVA9uSSCnD92DID1O+kWIz5Q7Y=;
        b=jZl/EpFho/jBpYNzhu0sThSneWR1tcatF4lgSJWBtgRrtYhx5PzWMY9KIPSbPDlDK0
         0bANGTOJXZZ+IlLUg2TxoKzUsAFdb7gmYxY6X5OEVoRR7XMX0qOLxpYgC8hiITWXklEo
         iIKUEvJylQNeV2mbJNGoIpzExIzqttKP9uKCgqLO/DqbDAwPhvcJBjl/U25CfVGutK09
         55W7VDMX7ixDJ9DfPG7KVO5W9uI4sHwmvn09Z4ZGnpGv5eYiRuk7w+5RRhUQjheeWRxO
         jVVrFM6ip994K2WwlVDj0myra9k8O/1m9vyytYbvzRADVtegsG+SKHeS/AxCbi2GcNIQ
         U20g==
X-Gm-Message-State: ACgBeo2XtpumrmIXiSgDqQsriiM6TppQi4ManWsqqqc4OTi+oxvvCesd
        D/Q9+GiPON53z113Gy8Gs3M2Vg==
X-Google-Smtp-Source: AA6agR67ROI7beQv+IqveURxbMA5xPmG6QPx4r0Z2Q9VyaAMdMfXjtq1yAvi/Sb4/KdUH0SgX3To6Q==
X-Received: by 2002:a05:600c:5102:b0:3a5:a46d:5d4b with SMTP id o2-20020a05600c510200b003a5a46d5d4bmr11081106wms.68.1660575948565;
        Mon, 15 Aug 2022 08:05:48 -0700 (PDT)
Received: from localhost ([109.180.234.208])
        by smtp.gmail.com with ESMTPSA id j15-20020a05600c190f00b003a5f54e3bbbsm4550660wmq.38.2022.08.15.08.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 08:05:48 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@bytedance.com>
To:     Perry Yuan <Perry.Yuan@amd.com>
Cc:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>, <Deepak.Sharma@amd.com>,
        <Mario.Limonciello@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Jinzhou.Su@amd.com>,
        <Shimmer.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 6/7] cpufreq: amd-pstate: update pstate frequency
 transition delay time
References: <20220814163548.326686-1-Perry.Yuan@amd.com>
        <20220814163548.326686-7-Perry.Yuan@amd.com>
Date:   Mon, 15 Aug 2022 16:05:47 +0100
In-Reply-To: <20220814163548.326686-7-Perry.Yuan@amd.com> (Perry Yuan's
        message of "Mon, 15 Aug 2022 00:35:47 +0800")
Message-ID: <87bkslim2c.fsf@stealth>
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

Perry Yuan <Perry.Yuan@amd.com> writes:

> Change the default transition latency to be 20ms that is more
> reasonable transition delay for AMD processors in non-EPP driver mode.
>
> Update transition delay time to 1ms, in the AMD CPU autonomous mode and
> non-autonomous mode, CPPC firmware will decide frequency at 1ms timescale
> based on the workload utilization.
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index e40177d14310..9cb051d61422 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -41,8 +41,8 @@
>  #include <asm/msr.h>
>  #include "amd-pstate-trace.h"
>  
> -#define AMD_PSTATE_TRANSITION_LATENCY	0x20000
> -#define AMD_PSTATE_TRANSITION_DELAY	500
> +#define AMD_PSTATE_TRANSITION_LATENCY	20000
> +#define AMD_PSTATE_TRANSITION_DELAY	1000

How were these values derived? If from documentation, it'll be good to
add a link to the relevant documentation. And if they were derived from
testing, please mention this in the commit log (along with some details
of the tests used to determine the value).

>  
>  /*
>   * TODO: We need more time to fine tune processors with shared memory solution
