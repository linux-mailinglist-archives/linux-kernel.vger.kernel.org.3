Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539194AA9B2
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 16:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378364AbiBEPjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 10:39:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232649AbiBEPjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 10:39:47 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7EFC061348
        for <linux-kernel@vger.kernel.org>; Sat,  5 Feb 2022 07:39:46 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id s2-20020a17090ad48200b001b501977b23so15932293pju.2
        for <linux-kernel@vger.kernel.org>; Sat, 05 Feb 2022 07:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nGbHRD5XVCMknW2RtzGE511y/kY+NvIn6G7QKgbUiRA=;
        b=mEdnKXcFCc9nT7Y0b6DVWGlLMEDy3yxic6oSS4R7IQTrrMzssbdIwjtFqDeK2HYbPW
         MtH9pTqM1lIKmiz16QCsppZsDGCOALfMc/Wj940+3tolj/Yv5dE9y7xohPkN0LGqBLHz
         ZrcokuMAFUNOJz4ypT7Uqn1vALpHa+09znbCIUd5jW3u120bCCb8iaP4Zhm29mQ+By6j
         pUohvp8p3K8P1n1mU85/9sUFnVIVd13TRVLbHu93WM5E64XMjiUoXOECadAlEqUVy5kE
         4vjqwO2KD4CPIHPrkTHOZG4vCr2Kn38fDcS/cf2OJNNB0c9ZQVkuNJLGbhmPRs8cMERP
         CwDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nGbHRD5XVCMknW2RtzGE511y/kY+NvIn6G7QKgbUiRA=;
        b=RmUrQ0AYtWFyvIxqHimjD1/heT3scVuBMZYk+X0JOJ302oa+4JTi5o7IfQPLWlrnaI
         oG21DZUBhI943+mxbznzS+BBpnXBbsm/fJSuAmMJifOqeSdjjOPcUVH6f0+tsmCIXUdg
         N61vQhwLEJ4z0yyeuAaEjsE6R6hKOfMD+jJy8dudtSrhWeOM3up98gSK52UgXN8owOXt
         h4en/SO3/31NlHbeDqzi+xignaO8bRa5TIAA/ttmkEOyxvtA179ncByBEUltw5h46ARG
         ejUXTVdVnx2t3B+D0r2tAkO3Y8XB6E6ph57fH5orZHpu6DmxJGNDnhITQLfJdUYsBQOC
         UTMQ==
X-Gm-Message-State: AOAM532T4HGgIbPZSn3wI4T5kLU56M2BMPNIdIgz8+EDQfgnlTF6SiNg
        5w5mnSdihcTytQozZaS/Jk5OwQ==
X-Google-Smtp-Source: ABdhPJyCS1VCNMqFbv+/clocjG3uX1a5woCc/TRTjJ/X6duMPPDMlaJgf885l03v9s2lP2vL3gcEOw==
X-Received: by 2002:a17:90b:4a06:: with SMTP id kk6mr4885387pjb.140.1644075585365;
        Sat, 05 Feb 2022 07:39:45 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id rj1sm5449079pjb.49.2022.02.05.07.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Feb 2022 07:39:44 -0800 (PST)
Date:   Sat, 5 Feb 2022 23:39:40 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, mark.rutland@arm.com, james.clark@arm.com
Subject: Re: [RFC PATCH 1/2] perf: arm_spe: Fix consistency of PMSCR register
 bit CX
Message-ID: <20220205153940.GB391033@leoy-ThinkPad-X240s>
References: <20220117124432.3119132-1-german.gomez@arm.com>
 <20220117124432.3119132-2-german.gomez@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220117124432.3119132-2-german.gomez@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi German,

On Mon, Jan 17, 2022 at 12:44:31PM +0000, German Gomez wrote:
> The arm_spe_pmu driver will enable the CX bit of the PMSCR register in
> order to add CONTEXT packets into the traces if the owner of the perf
> event runs with capabilities CAP_PERFMON or CAP_SYS_ADMIN.
> 
> The value of the bit is computed in the arm_spe_event_to_pmscr function
> [1], and the check for capabilities happens in [2] in the pmu init
> callback. This suggests that the value of the CX bit should remain
> consistent for the duration of the perf session.
> 
> However, the function arm_spe_event_to_pmscr may be called later during
> the start callback [3] when the "current" process is not the owner of
> the perf session, so the CX bit is currently not consistent. Consider
> the following example:
> 
>   1. Run a process in the background with capability CAP_SYS_ADMIN in CPU0.
> 
>     $ taskset --cpu-list 0 sudo dd if=/dev/random of=/dev/null &
>     [3] 3806
> 
>   2. Begin a perf session _without_ capabilities (we shouldn't see CONTEXT packets).
> 
>     $ perf record -e arm_spe_0// -C0 -- sleep 1
>     $ perf report -D | grep CONTEXT
>     .  0000000e:  65 df 0e 00 00                                  CONTEXT 0xedf el2
>     .  0000004e:  65 df 0e 00 00                                  CONTEXT 0xedf el2
>     .  0000008e:  65 df 0e 00 00                                  CONTEXT 0xedf el2
>     [...]

Could you confirm if you still can reproduce this issue on the latest
mainline kernel?  I cannot reproduce this issue on the latest mainline
kernel, I suspect this is impacted by recent refactoring evlist
patches from Ian Rogers (though I am not for this).

> As can be seen, the traces begin showing CONTEXT packets when the pid is
> 0xedf (3807). This happens because the pmu start callback is run when
> the current process is not the owner of the perf session, so the CX
> register bit is set.

I can image a potential issue is: the "dd" program running in background
with capability CAP_SYS_ADMIN on CPU0, and then perf session sends an
IPI remotely from any other CPU to CPU0, the dd process (on CPU0) is
interrupted to handle ioctl PERF_EVENT_IOC_ENABLE, thus perfmon_capable()
returns the capability of dd process, finally it leads to the wrong
setting for PMSCR.

I reviewed the code and also traced the backtrace for the function
arm_spe_pmu_start(), I can confirm that every time perf session will
execute below flow:

  evlist__enable()
    __evlist__enable()
      evlist__for_each_cpu() {  -> call affinity__set()
        evsel__enable_cpu()
      }

We can see the macro evlist__for_each_cpu() will extend to invoke
evlist__cpu_begin() and affinity__set(); affinity__set() will set CPU
affinity to the target CPU, thus perf process will firstly migrate to
the target CPU and enable event on the target CPU.  This means perf
will not send remote IPI and it directly runs on target CPU, and the
dd program will not interfere capabilities for perf session.

Thanks,
Leo

> One way to fix this is by caching the value of the CX bit during the
> initialization of the PMU event, so that it remains consistent for the
> duration of the session.
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/perf/arm_spe_pmu.c?h=v5.16#n275
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/perf/arm_spe_pmu.c?h=v5.16#n713
> [3]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/perf/arm_spe_pmu.c?h=v5.16#n751
> 
> Signed-off-by: German Gomez <german.gomez@arm.com>
> ---
>  drivers/perf/arm_spe_pmu.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> index d44bcc29d..8515bf85c 100644
> --- a/drivers/perf/arm_spe_pmu.c
> +++ b/drivers/perf/arm_spe_pmu.c
> @@ -57,6 +57,7 @@ struct arm_spe_pmu {
>  	u16					pmsver;
>  	u16					min_period;
>  	u16					counter_sz;
> +	bool					pmscr_cx;
>  
>  #define SPE_PMU_FEAT_FILT_EVT			(1UL << 0)
>  #define SPE_PMU_FEAT_FILT_TYP			(1UL << 1)
> @@ -260,6 +261,7 @@ static const struct attribute_group *arm_spe_pmu_attr_groups[] = {
>  static u64 arm_spe_event_to_pmscr(struct perf_event *event)
>  {
>  	struct perf_event_attr *attr = &event->attr;
> +	struct arm_spe_pmu *spe_pmu = to_spe_pmu(event->pmu);
>  	u64 reg = 0;
>  
>  	reg |= ATTR_CFG_GET_FLD(attr, ts_enable) << SYS_PMSCR_EL1_TS_SHIFT;
> @@ -272,7 +274,7 @@ static u64 arm_spe_event_to_pmscr(struct perf_event *event)
>  	if (!attr->exclude_kernel)
>  		reg |= BIT(SYS_PMSCR_EL1_E1SPE_SHIFT);
>  
> -	if (IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR) && perfmon_capable())
> +	if (IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR) && spe_pmu->pmscr_cx)
>  		reg |= BIT(SYS_PMSCR_EL1_CX_SHIFT);
>  
>  	return reg;
> @@ -709,10 +711,10 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
>  	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_LAT))
>  		return -EOPNOTSUPP;
>  
> +	spe_pmu->pmscr_cx = perfmon_capable();
>  	reg = arm_spe_event_to_pmscr(event);
>  	if (!perfmon_capable() &&
>  	    (reg & (BIT(SYS_PMSCR_EL1_PA_SHIFT) |
> -		    BIT(SYS_PMSCR_EL1_CX_SHIFT) |
>  		    BIT(SYS_PMSCR_EL1_PCT_SHIFT))))
>  		return -EACCES;
>  
> -- 
> 2.25.1
> 
