Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E106D46D439
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 14:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhLHNVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 08:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbhLHNVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 08:21:32 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF31C0617A1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 05:18:00 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id g14so8182111edb.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 05:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f1C2XMALRqUxMKamwSGI4XRtJrpSBCcZ7f42PdWgTTQ=;
        b=S/o1FSBwdEQX4yRmrkEgFJTTTLgQXG3Hju2WpJqjSDNp22nHUhbnfNw6yaXbOMMnmy
         866RWxDbiK9NyFuanca1Y2cn3fQYcCmFb3hC/CP2XQ7RVa44hRPNIiLklFLylzjly7J4
         Ased7VljxR7mudSiy6DGGTzRBBhm+y3R4NEgnW9xDmUzJGt/R3Zc5TKbIt8h7NUGrLZW
         TX4QiL7ULa9JRrn/9IDRvxQETKzphS+VFqANOgGMd8dvatKmtdecEf8/xRY5XJ2suAAg
         Hff4xvUaXDcZbQ/YUHR15ylOBATJ6MkW5ovLygB1eJgW+mj2F4NByoxjHuZNeWCkgQls
         Zyrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f1C2XMALRqUxMKamwSGI4XRtJrpSBCcZ7f42PdWgTTQ=;
        b=feZ74zmC7AvWcgr2cgFB6EYcOICa/Xo2liUFXP3mmJ0b9t/1hGpFhtw3PaSiiGTG74
         Q15u67mcdvRcaaEHL4ZP/BAaQm5WZgM75/wUfcZSzpNqpGU5XjGBcGjfhVfwUJY38oT6
         GY2UZtexmyIOVeIT17/JRy2uufujkJRVc/j2vEFH6LAWYMNjul5ko20Pft7cXhagXZYP
         rI1pcpbTNjVWfMPAr2Jm9mANB++3Jm1vdrPUeslGnClVaF02lpyXnYG+PLpP1Vx1N/cE
         PlnMpFG9a1FSiD3FSOdH4eeJn+94pEIEfY8Rz2THjgYz9e43wL0cDHL0Wl6lUqbckqGV
         /Ajw==
X-Gm-Message-State: AOAM531RjqDBHR2g/PVwZuF/x+5xnwP9ytsjLisD8AaiFC+/We73n75x
        jijuVHGrVFskQI/MBzG/45LqQg==
X-Google-Smtp-Source: ABdhPJyxmxcF192VGmGLUTaU86PkWz7/dpExas+Dv1oI7Wn/2vbdXn8US6JiysEv3D9tPLZlh4x+aw==
X-Received: by 2002:a17:907:6e16:: with SMTP id sd22mr7015589ejc.542.1638969479299;
        Wed, 08 Dec 2021 05:17:59 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([104.245.96.202])
        by smtp.gmail.com with ESMTPSA id j17sm2095850edj.0.2021.12.08.05.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 05:17:58 -0800 (PST)
Date:   Wed, 8 Dec 2021 21:17:53 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     mathieu.poirier@linaro.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, Mike Leach <mike.leach@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf cs-etm: Remove duplicate and incorrect aux size
 checks
Message-ID: <20211208131753.GC273781@leoy-ThinkPad-X240s>
References: <20211208115435.610101-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208115435.610101-1-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Wed, Dec 08, 2021 at 11:54:35AM +0000, James Clark wrote:
> There are two checks, one is for size when running without admin, but
> this one is covered by the driver and reported on in more detail here
> (builtin-record.c):
> 
>   pr_err("Permission error mapping pages.\n"
>          "Consider increasing "
>          "/proc/sys/kernel/perf_event_mlock_kb,\n"
>          "or try again with a smaller value of -m/--mmap_pages.\n"
>          "(current value: %u,%u)\n",

I looked into the kernel code and found:

  sysctl_perf_event_mlock = 512 + (PAGE_SIZE / 1024);  // 512KB + 1 page

If the system have multiple cores, let's say 8 cores, then kernel even
can relax the limitaion with:

  user_lock_limit *= num_online_cpus();

So means the memory lock limitation is:

  (512KB + 1 page) * 8 = 4MB + 8 pages.

Seems to me, it's much relax than the user space's limitaion 128KB.
And let's imagine for Arm server, the permitted buffer size can be a
huge value (e.g. for a system with 128 cores).

Could you confirm if this is right?

Thanks,
Leo

> This had the effect of artificially limiting the aux buffer size to a
> value smaller than what was allowed because perf_event_mlock_kb wasn't
> taken into account.
> 
> The second is to check for a power of two, but this is covered here
> (evlist.c):
> 
>   pr_info("rounding mmap pages size to %s (%lu pages)\n",
>           buf, pages);
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/arch/arm/util/cs-etm.c | 19 -------------------
>  1 file changed, 19 deletions(-)
> 
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> index 293a23bf8be3..8a3d54a86c9c 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -407,25 +407,6 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
>  
>  	}
>  
> -	/* Validate auxtrace_mmap_pages provided by user */
> -	if (opts->auxtrace_mmap_pages) {
> -		unsigned int max_page = (KiB(128) / page_size);
> -		size_t sz = opts->auxtrace_mmap_pages * (size_t)page_size;
> -
> -		if (!privileged &&
> -		    opts->auxtrace_mmap_pages > max_page) {
> -			opts->auxtrace_mmap_pages = max_page;
> -			pr_err("auxtrace too big, truncating to %d\n",
> -			       max_page);
> -		}
> -
> -		if (!is_power_of_2(sz)) {
> -			pr_err("Invalid mmap size for %s: must be a power of 2\n",
> -			       CORESIGHT_ETM_PMU_NAME);
> -			return -EINVAL;
> -		}
> -	}
> -
>  	if (opts->auxtrace_snapshot_mode)
>  		pr_debug2("%s snapshot size: %zu\n", CORESIGHT_ETM_PMU_NAME,
>  			  opts->auxtrace_snapshot_size);
> -- 
> 2.28.0
> 
