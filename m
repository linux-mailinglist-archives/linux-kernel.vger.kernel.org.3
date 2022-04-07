Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116064F856B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 19:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbiDGRCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 13:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243250AbiDGRCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 13:02:18 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7751C8A85;
        Thu,  7 Apr 2022 09:59:54 -0700 (PDT)
X-UUID: 2fe14ab422b84b86bb4cc0d3a602ce48-20220408
X-UUID: 2fe14ab422b84b86bb4cc0d3a602ce48-20220408
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1444954338; Fri, 08 Apr 2022 00:59:51 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 8 Apr 2022 00:59:50 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 8 Apr
 2022 00:59:49 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 8 Apr 2022 00:59:49 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <pmladek@suse.com>
CC:     <acme@kernel.org>, <akpm@linux-foundation.org>,
        <alexander.shishkin@linux.intel.com>, <catalin.marinas@arm.com>,
        <davem@davemloft.net>, <jolsa@redhat.com>, <jthierry@redhat.com>,
        <keescook@chromium.org>, <kernelfans@gmail.com>,
        <lecopzer.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>, <mark.rutland@arm.com>,
        <masahiroy@kernel.org>, <matthias.bgg@gmail.com>, <maz@kernel.org>,
        <mcgrof@kernel.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
        <nixiaoming@huawei.com>, <peterz@infradead.org>,
        <sparclinux@vger.kernel.org>, <sumit.garg@linaro.org>,
        <wangqing@vivo.com>, <will@kernel.org>, <yj.chiang@mediatek.com>
Subject: Re: [PATCH v3 5/5] arm64: Enable perf events based hard lockup detector
Date:   Fri, 8 Apr 2022 00:59:49 +0800
Message-ID: <20220407165949.1903-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <YkxT9plntP0VeMl4@alley>
References: <YkxT9plntP0VeMl4@alley>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Tue 2022-04-05 20:53:04, Lecopzer Chen wrote:
> >  
> > > On Thu 2022-03-24 22:14:05, Lecopzer Chen wrote:
> > > > With the recent feature added to enable perf events to use pseudo NMIs
> > > > as interrupts on platforms which support GICv3 or later, its now been
> > > > possible to enable hard lockup detector (or NMI watchdog) on arm64
> > > > platforms. So enable corresponding support.
> > > > 
> > > > One thing to note here is that normally lockup detector is initialized
> > > > just after the early initcalls but PMU on arm64 comes up much later as
> > > > device_initcall(). To cope with that, overriding watchdog_nmi_probe() to
> > > > let the watchdog framework know PMU not ready, and inform the framework
> > > > to re-initialize lockup detection once PMU has been initialized.
> > > > 
> > > > [1]: http://lore.kernel.org/linux-arm-kernel/1610712101-14929-1-git-send-email-sumit.garg@linaro.org
> > > > 
> > > > --- /dev/null
> > > > +++ b/arch/arm64/kernel/watchdog_hld.c
> > > > @@ -0,0 +1,37 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +#include <linux/nmi.h>
> > > > +#include <linux/cpufreq.h>
> > > > +#include <linux/perf/arm_pmu.h>
> > > > +
> > > > +/*
> > > > + * Safe maximum CPU frequency in case a particular platform doesn't implement
> > > > + * cpufreq driver. Although, architecture doesn't put any restrictions on
> > > > + * maximum frequency but 5 GHz seems to be safe maximum given the available
> > > > + * Arm CPUs in the market which are clocked much less than 5 GHz. On the other
> > > > + * hand, we can't make it much higher as it would lead to a large hard-lockup
> > > > + * detection timeout on parts which are running slower (eg. 1GHz on
> > > > + * Developerbox) and doesn't possess a cpufreq driver.
> > > > + */
> > > > +#define SAFE_MAX_CPU_FREQ	5000000000UL // 5 GHz
> > > > +u64 hw_nmi_get_sample_period(int watchdog_thresh)
> > > > +{
> > > > +	unsigned int cpu = smp_processor_id();
> > > > +	unsigned long max_cpu_freq;
> > > > +
> > > > +	max_cpu_freq = cpufreq_get_hw_max_freq(cpu) * 1000UL;
> > > > +	if (!max_cpu_freq)
> > > > +		max_cpu_freq = SAFE_MAX_CPU_FREQ;
> > > > +
> > > > +	return (u64)max_cpu_freq * watchdog_thresh;
> > > > +}
> > > 
> > > This change is not mentioned in the commit message.
> > > Please, put it into a separate patch.
> > 
> > 
> > Actully, This cames from
> > [1]: http://lore.kernel.org/linux-arm-kernel/1610712101-14929-1-git-send-email-sumit.garg@linaro.org
> > And I didn't touch the commit message from the origin patch.
> > But of course, I could imporve it with proper description if
> > anyone thinks it's not good enough.
> 
> I see.
> 
> > Would you mean put this function hw_nmi_get_sample_period() in patch
> > 6th?
> > In the view of "arm64 uses delayed init with all the functionality it need to set up",
> > IMO, this make sense for me to put into a single patch.
> 
> Or you could split it in two patches and add
> hw_nmi_get_sample_period() in the earlier patch.
> 
> 
> > But if you still think this should put into a separate patch, I'll do it:)
> 
> It is always better to split the changes whenever possible. It makes
> the review easier. And it also helps to find the real culprit of
> a regression using bisection.

Okay, I'll split this part into another change, thanks.


> > > > +int __init watchdog_nmi_probe(void)
> > > > +{
> > > > +	if (!allow_lockup_detector_init_retry)
> > > > +		return -EBUSY;
> > > 
> > > How do you know that you should return -EBUSY
> > > when retry in not enabled?
> > > 
> > > I guess that it is an optimization to make it fast
> > > during the first call. But the logic is far from
> > > obvious.
> > > 
> > 
> > Yes, you can see this as an optimization, because arm64 PMU is not ready
> > during lockup_detector_init(), so the watchdog_nmi_probe() must fail.
> >
> > Thus we only want to do watchdog_nmi_probe() in delayed init,
> > so if not in the state (allow_lockup_detector_init_retry=true), just tell
> > 
> > if it's unclear
> 
> Yes, it is far from obvious.
> 
> > maybe a brief comment can be add like this:
> > 
> > +	/* arm64 is only able to initialize lockup detecor during delayed init */
> > +	if (!allow_lockup_detector_init_retry)
> > +		return -EBUSY;
> 
> No, please, remove this optimization. It just makes problems:
> 
>    + it requires a comment here because the logic is far from obvious.
> 
>    + it is the reason why we need another variable to avoid the race in
>      lockup_detector_check(), see the discussion about the 4th patch.

After some days studying, if I remove this if-condition which means the
following hardlockup_detector_perf_init() needs to return -EBUSY.
However, the default return value that if pmu is not ready is -ENOENT.

The call path for hardlockup_detector_perf_init() is really complicated,

I have some approach about this:
  1. abstract second variable with Kconfig.
    a. Add a ARCH_SUPPORTS_HARDLOCKUP_DETECTOR_DLAYED_INIT
       (the naming is a little bit long, may have better naming)
       in "lib/Kconfig.debug" if ARCH knew they do need delayed init for
       lockup detector.

       + select ARCH_SUPPORTS_HARDLOCKUP_DETECTOR_DLAYED_INIT if HAVE_HARDLOCKUP_DETECTOR_PERF

    b. and the watchdog_nmi_probe would look like.

    +int __init watchdog_nmi_probe(void)
    +{
    +	int ret;
    +
    + /* comment here... */
    +	if (!arm_pmu_irq_is_nmi())
    +		return -ENODEV;
    +
    +	ret = hardlockup_detector_perf_init();
    +	if (ret &&
    +		  IS_ENABLED(ARCH_SUPPORTS_HARDLOCKUP_DETECTOR_DLAYED_INIT))
    +		return -EBUSY;
    +
    + return ret;
    +}

    and than we can have only one variable (allow_lockup_detector_init_retry)
    in 4th patch.

 
  2. base on ARCH_SUPPORTS_HARDLOCKUP_DETECTOR_DLAYED_INIT, change
     inside hardlockup_detector_perf_init().

int __init hardlockup_detector_perf_init(void)
{
	int ret = hardlockup_detector_event_create();

	if (ret) {
		pr_info("Perf NMI watchdog permanently disabled\n");
+
+		/* comment here... */
+		if (IS_ENABLED(ARCH_SUPPORTS_HARDLOCKUP_DETECTOR_DLAYED_INIT))
+			ret = -EBUSY;
	} else {
		perf_event_release_kernel(this_cpu_read(watchdog_ev));
		this_cpu_write(watchdog_ev, NULL);
	}
	return ret;
}

  3. Don't add any other config, try to find a proper location
     to return -EBUSY in hardlockup_detector_event_create().
     IMHO, this may involve the PMU subsys and should be
     the hardest approach.



> > > > +
> > > > +	if (!arm_pmu_irq_is_nmi())
> > > > +		return -ENODEV;
> > > > +
> > > > +	return hardlockup_detector_perf_init();
> > > > +}
> > > 
> > For arm_pmu_irq_is_nmi() checking, we do need it, becasue arm64 needs
> > explictly turns on Pseudo-NMI to support base function for NMI.
> >
> > hardlockup_detector_perf_init() will success even if we haven't had
> > Pseudo-NMI turns on, however, the pmu interrupts will act like a
> > normal interrupt instead of NMI and the hardlockup detector would be broken.
> 
> I see. Please, explain this in a comment. It is another thing
> that is far from obvious.
> 

thank you, I'll just add the comment above like this.
/*
 * hardlockup_detector_perf_init() will success even if we haven't had
 * Pseudo-NMI turns on, however, the pmu interrupts will act like a
 * normal interrupt instead of NMI and the hardlockup detector would be broken.
 */
	if (!arm_pmu_irq_is_nmi())
		return -ENODEV;


thanks
BRs,
Lecopzer
