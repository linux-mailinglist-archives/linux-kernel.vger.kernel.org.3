Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07BB572D13
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 07:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiGMF17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 01:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbiGMF1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 01:27:47 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD10DC898
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 22:27:43 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 89-20020a17090a09e200b001ef7638e536so1826170pjo.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 22:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XqTuQNpYgAFNMslOblHbiqhABkix/enKQHhkfVPgUnc=;
        b=XxvAN2gkIX5nSIxbHctLeSRQ8iE3Dxy0ySkGfEa2nPghNYqrNjx1xelprweW+ETUHX
         PfVWiNeq2MASKwWKbDQ6tlpLSNnpT1kKDYaL490pe0NVqTIXKDscS6NBuvIbJlGZ8DK0
         G4thAjqRd5XNa3ufnXHt3Ftn2SnCb3PCKgXvvdqVvyAJo1sTShnH4HKwnD/SyoLXNcZv
         whtt2euFL00kZB0lmwXBSfApRn9Z3woV+d6MbplnZcIAEjXlZI/pya2mYA1gpa82xRvi
         pFWe6XHypUNo8QQMvNiZoKw63voLS6Px1xqssm7l1O2H/edAoXoRQ8O2pzebB/HL6gbd
         qrVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XqTuQNpYgAFNMslOblHbiqhABkix/enKQHhkfVPgUnc=;
        b=E83nOiP4wwt5I8z8mGkyJ8K75jZkP0sQXfP37ly9J0Rav0kuEnC1lkAEG5o5sM8kAV
         4MKi3ip1eRB1CldPMXqn9H0R1RHHKhUZ+ZPrkosye3g2H23oDJtQKWGFKr1VHHI0xDgw
         F13wvltJ3AlKhGt+/c96w9vYXtH6q/jpHeFvyMdsz7y7ZD3/XqDHch/DnNV+45z/TpPH
         UVIhT6yWLRCFra/Cfnzvn8TEDEPAkW/B/WglCNNcXyUsldCCSq3FsFqQDFOWuvDLM096
         4anecFy1uwUh0NWNIXLatauz4/0TLeaZEIRT4xRBmNdzT/YMAGfVtgEmua9VJ6HS2XYQ
         MyHg==
X-Gm-Message-State: AJIora/ITlYU1yOBIwHh4XjXG+a9c17pPKYC47mOD6mlWKP0FE6UeRBm
        nRMmtGx/kILvZ/6b6wahd7amYA==
X-Google-Smtp-Source: AGRyM1vUhM6pdpPjtZVdS1GtP48cG64AXWjLzKlm+baajw4aJXlS07YxVJjy0NIR/YfeCdps97LPGg==
X-Received: by 2002:a17:90b:4a4e:b0:1ef:b091:c7c6 with SMTP id lb14-20020a17090b4a4e00b001efb091c7c6mr7993289pjb.185.1657690062742;
        Tue, 12 Jul 2022 22:27:42 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id w12-20020a170902e88c00b0016bdc520f8bsm7859641plg.299.2022.07.12.22.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 22:27:41 -0700 (PDT)
Date:   Wed, 13 Jul 2022 10:57:37 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Perry Yuan <Perry.Yuan@amd.com>
Cc:     rafael.j.wysocki@intel.com, Ray.Huang@amd.com,
        Deepak.Sharma@amd.com, Mario.Limonciello@amd.com,
        Nathan.Fontenot@amd.com, Alexander.Deucher@amd.com,
        Jinzhou.Su@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
        Li.Meng@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 03/13] cpufreq: amd-pstate: cleanup the unused and
 duplicated headers declaration
Message-ID: <20220713052737.wy4c2nzs6fr5wu6t@vireshk-i7>
References: <cover.1657638462.git.Perry.Yuan@amd.com>
 <064c323b016dd0cb369d3f2d1301b218abb2b6e7.1657638462.git.Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <064c323b016dd0cb369d3f2d1301b218abb2b6e7.1657638462.git.Perry.Yuan@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-07-22, 11:40, Perry Yuan wrote:
> Cleanup the headers declaration which are not used
> actually and some duplicated declaration which is declarated in some
> other headers already, it will help to simplify the header part.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 188e055e24a2..43e6df9f67f6 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -31,19 +31,14 @@
>  #include <linux/compiler.h>
>  #include <linux/dmi.h>
>  #include <linux/slab.h>
> -#include <linux/acpi.h>
>  #include <linux/io.h>
>  #include <linux/delay.h>
>  #include <linux/uaccess.h>
>  #include <linux/static_call.h>
>  
> -#include <acpi/processor.h>
>  #include <acpi/cppc_acpi.h>
>  
>  #include <asm/msr.h>
> -#include <asm/processor.h>
> -#include <asm/cpufeature.h>
> -#include <asm/cpu_device_id.h>
>  #include "amd-pstate-trace.h"
>  
>  #define AMD_PSTATE_TRANSITION_LATENCY	0x20000

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
