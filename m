Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23CE4F51B8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1847010AbiDFCMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449985AbiDEPu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:50:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5761C1700AD;
        Tue,  5 Apr 2022 07:36:41 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EA076210E5;
        Tue,  5 Apr 2022 14:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649169399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kSbep7KEvKMw5NA9dGHZ82B+/h6ENrK0h+ktGBnoonA=;
        b=HkEw9NRuL/3L34R2MOn6s81P7RCjKI+svCy8UEL8/p1egYa/TLjM/Di4T8JbZ+JWkLZbbY
        8KCdOqQyeK7SiD6m2NSd31cOFh+hO2QZg7v7aoibmkdtF5eErEqoWcx8YM6b9t+4AtAH2Q
        6g6UQ1Lw5l0W97aLfm5OXZUcrL+Q3BI=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 17E6DA3B93;
        Tue,  5 Apr 2022 14:36:38 +0000 (UTC)
Date:   Tue, 5 Apr 2022 16:36:38 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Lecopzer Chen <lecopzer.chen@mediatek.com>
Cc:     acme@kernel.org, akpm@linux-foundation.org,
        alexander.shishkin@linux.intel.com, catalin.marinas@arm.com,
        davem@davemloft.net, jolsa@redhat.com, jthierry@redhat.com,
        keescook@chromium.org, kernelfans@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        masahiroy@kernel.org, matthias.bgg@gmail.com, maz@kernel.org,
        mcgrof@kernel.org, mingo@redhat.com, namhyung@kernel.org,
        nixiaoming@huawei.com, peterz@infradead.org,
        sparclinux@vger.kernel.org, sumit.garg@linaro.org,
        wangqing@vivo.com, will@kernel.org, yj.chiang@mediatek.com
Subject: Re: [PATCH v3 5/5] arm64: Enable perf events based hard lockup
 detector
Message-ID: <YkxT9plntP0VeMl4@alley>
References: <20220404141709.GA26840@pathway.suse.cz>
 <20220405125304.3762-1-lecopzer.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405125304.3762-1-lecopzer.chen@mediatek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-04-05 20:53:04, Lecopzer Chen wrote:
>  
> > On Thu 2022-03-24 22:14:05, Lecopzer Chen wrote:
> > > With the recent feature added to enable perf events to use pseudo NMIs
> > > as interrupts on platforms which support GICv3 or later, its now been
> > > possible to enable hard lockup detector (or NMI watchdog) on arm64
> > > platforms. So enable corresponding support.
> > > 
> > > One thing to note here is that normally lockup detector is initialized
> > > just after the early initcalls but PMU on arm64 comes up much later as
> > > device_initcall(). To cope with that, overriding watchdog_nmi_probe() to
> > > let the watchdog framework know PMU not ready, and inform the framework
> > > to re-initialize lockup detection once PMU has been initialized.
> > > 
> > > [1]: http://lore.kernel.org/linux-arm-kernel/1610712101-14929-1-git-send-email-sumit.garg@linaro.org
> > > 
> > > --- /dev/null
> > > +++ b/arch/arm64/kernel/watchdog_hld.c
> > > @@ -0,0 +1,37 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +#include <linux/nmi.h>
> > > +#include <linux/cpufreq.h>
> > > +#include <linux/perf/arm_pmu.h>
> > > +
> > > +/*
> > > + * Safe maximum CPU frequency in case a particular platform doesn't implement
> > > + * cpufreq driver. Although, architecture doesn't put any restrictions on
> > > + * maximum frequency but 5 GHz seems to be safe maximum given the available
> > > + * Arm CPUs in the market which are clocked much less than 5 GHz. On the other
> > > + * hand, we can't make it much higher as it would lead to a large hard-lockup
> > > + * detection timeout on parts which are running slower (eg. 1GHz on
> > > + * Developerbox) and doesn't possess a cpufreq driver.
> > > + */
> > > +#define SAFE_MAX_CPU_FREQ	5000000000UL // 5 GHz
> > > +u64 hw_nmi_get_sample_period(int watchdog_thresh)
> > > +{
> > > +	unsigned int cpu = smp_processor_id();
> > > +	unsigned long max_cpu_freq;
> > > +
> > > +	max_cpu_freq = cpufreq_get_hw_max_freq(cpu) * 1000UL;
> > > +	if (!max_cpu_freq)
> > > +		max_cpu_freq = SAFE_MAX_CPU_FREQ;
> > > +
> > > +	return (u64)max_cpu_freq * watchdog_thresh;
> > > +}
> > 
> > This change is not mentioned in the commit message.
> > Please, put it into a separate patch.
> 
> 
> Actully, This cames from
> [1]: http://lore.kernel.org/linux-arm-kernel/1610712101-14929-1-git-send-email-sumit.garg@linaro.org
> And I didn't touch the commit message from the origin patch.
> But of course, I could imporve it with proper description if
> anyone thinks it's not good enough.

I see.

> Would you mean put this function hw_nmi_get_sample_period() in patch
> 6th?
> In the view of "arm64 uses delayed init with all the functionality it need to set up",
> IMO, this make sense for me to put into a single patch.

Or you could split it in two patches and add
hw_nmi_get_sample_period() in the earlier patch.


> But if you still think this should put into a separate patch, I'll do it:)

It is always better to split the changes whenever possible. It makes
the review easier. And it also helps to find the real culprit of
a regression using bisection.


> > > +int __init watchdog_nmi_probe(void)
> > > +{
> > > +	if (!allow_lockup_detector_init_retry)
> > > +		return -EBUSY;
> > 
> > How do you know that you should return -EBUSY
> > when retry in not enabled?
> > 
> > I guess that it is an optimization to make it fast
> > during the first call. But the logic is far from
> > obvious.
> > 
> 
> Yes, you can see this as an optimization, because arm64 PMU is not ready
> during lockup_detector_init(), so the watchdog_nmi_probe() must fail.
>
> Thus we only want to do watchdog_nmi_probe() in delayed init,
> so if not in the state (allow_lockup_detector_init_retry=true), just tell
> 
> if it's unclear

Yes, it is far from obvious.

> maybe a brief comment can be add like this:
> 
> +	/* arm64 is only able to initialize lockup detecor during delayed init */
> +	if (!allow_lockup_detector_init_retry)
> +		return -EBUSY;

No, please, remove this optimization. It just makes problems:

   + it requires a comment here because the logic is far from obvious.

   + it is the reason why we need another variable to avoid the race in
     lockup_detector_check(), see the discussion about the 4th patch.


> > > +
> > > +	if (!arm_pmu_irq_is_nmi())
> > > +		return -ENODEV;
> > > +
> > > +	return hardlockup_detector_perf_init();
> > > +}
> > 
> For arm_pmu_irq_is_nmi() checking, we do need it, becasue arm64 needs
> explictly turns on Pseudo-NMI to support base function for NMI.
>
> hardlockup_detector_perf_init() will success even if we haven't had
> Pseudo-NMI turns on, however, the pmu interrupts will act like a
> normal interrupt instead of NMI and the hardlockup detector would be broken.

I see. Please, explain this in a comment. It is another thing
that is far from obvious.

Best Regards,
Petr
