Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFE95103B1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 18:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353044AbiDZQmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 12:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235466AbiDZQl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 12:41:59 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA831183B3;
        Tue, 26 Apr 2022 09:38:46 -0700 (PDT)
X-UUID: cea183affb84489b997e4120d009dd1d-20220427
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:c9cc3d3b-73c9-4588-84f3-2f2f0df50254,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:faefae9,CLOUDID:9cbe8ec6-85ee-4ac1-ac05-bd3f1e72e732,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:-5,EDM:-3,File:nil,QS:0,BEC:ni
        l
X-UUID: cea183affb84489b997e4120d009dd1d-20220427
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1666426999; Wed, 27 Apr 2022 00:38:42 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 27 Apr 2022 00:38:40 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 27 Apr 2022 00:38:40 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <lecopzer.chen@mediatek.com>, <pmladek@suse.com>
CC:     <acme@kernel.org>, <akpm@linux-foundation.org>,
        <alexander.shishkin@linux.intel.com>, <catalin.marinas@arm.com>,
        <davem@davemloft.net>, <jolsa@redhat.com>, <jthierry@redhat.com>,
        <keescook@chromium.org>, <kernelfans@gmail.com>,
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
Date:   Wed, 27 Apr 2022 00:38:40 +0800
Message-ID: <20220426163840.18871-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220421163035.26402-1-lecopzer.chen@mediatek.com>
References: <20220421163035.26402-1-lecopzer.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > The call path for hardlockup_detector_perf_init() is really complicated,
> > 
> > I have some approach about this:
> >   1. abstract second variable with Kconfig.
> >     a. Add a ARCH_SUPPORTS_HARDLOCKUP_DETECTOR_DLAYED_INIT
> >        (the naming is a little bit long, may have better naming)
> >        in "lib/Kconfig.debug" if ARCH knew they do need delayed init for
> >        lockup detector.
> > 
> >        + select ARCH_SUPPORTS_HARDLOCKUP_DETECTOR_DLAYED_INIT if HAVE_HARDLOCKUP_DETECTOR_PERF
> > 
> >     b. and the watchdog_nmi_probe would look like.
> > 
> >     +int __init watchdog_nmi_probe(void)
> >     +{
> >     +	int ret;
> >     +
> >     + /* comment here... */
> >     +	if (!arm_pmu_irq_is_nmi())
> >     +		return -ENODEV;
> >     +
> >     +	ret = hardlockup_detector_perf_init();
> >     +	if (ret &&
> >     +		  IS_ENABLED(ARCH_SUPPORTS_HARDLOCKUP_DETECTOR_DLAYED_INIT))
> >     +		return -EBUSY;
> >     +
> >     + return ret;
> >     +}
> > 
> >     and than we can have only one variable (allow_lockup_detector_init_retry)
> >     in 4th patch.
> > 
> >  
> >   2. base on ARCH_SUPPORTS_HARDLOCKUP_DETECTOR_DLAYED_INIT, change
> >      inside hardlockup_detector_perf_init().
> > 
> > int __init hardlockup_detector_perf_init(void)
> > {
> > 	int ret = hardlockup_detector_event_create();
> > 
> > 	if (ret) {
> > 		pr_info("Perf NMI watchdog permanently disabled\n");
> > +
> > +		/* comment here... */
> > +		if (IS_ENABLED(ARCH_SUPPORTS_HARDLOCKUP_DETECTOR_DLAYED_INIT))
> > +			ret = -EBUSY;
> > 	} else {
> > 		perf_event_release_kernel(this_cpu_read(watchdog_ev));
> > 		this_cpu_write(watchdog_ev, NULL);
> > 	}
> > 	return ret;
> > }
> > 
> >   3. Don't add any other config, try to find a proper location
> >      to return -EBUSY in hardlockup_detector_event_create().
> >      IMHO, this may involve the PMU subsys and should be
> >      the hardest approach.
> 
> Honestly, everything looks a bit ugly and complicated to me.
> 
> OKAY, is the return value actually important?
> 
> What about just introducing the API that will allow to try to
> initialize the hardlockup detector later:
> 
> /*
>  * Retry hardlockup detector init. It is useful when it requires some
>  * functionality that has to be initialized later on a particular
>  * platform.
>  */
> void __init retry_lockup_detector_init(void)
> {
> 	/* Must be called before late init calls. */
> 	if (!allow_lockup_detector_init_retry)
> 		return 0;
> 
> 	queue_work_on(__smp_processor_id(), system_wq, &detector_work);
> }
> 
> /*
>  * Ensure that optional delayed hardlockup init is proceed before
>  * the init code and memory is freed.
>  */
> static int __init lockup_detector_check(void)
> {
> 	/* Prevent any later retry. */
> 	allow_lockup_detector_init_retry = false;
> 
> 	/* Make sure no work is pending. */
> 	flush_work(&detector_work);
> }
> late_initcall_sync(lockup_detector_check);
> 
> You could leave lockup_detector_init() as it is. It does not really
> matter what was the exact error value returned by watchdog_nmi_probe().
> 
> Then you could call retry_lockup_detector_init() in
> armv8_pmu_driver_init() and be done with it.
> 
> It will be universal API that might be used on any architecture
> for any reason. If nobody calls retry_lockup_detector_init()
> then nohing will happen and the code will work as before.
> 
> It might make sense to provide the API only on architectures that
> really need it. We could hide it under
> 
>    ARCH_NEED_DELAYED_HARDLOCKUP_DETECTOR_INIT
> 
> , similar to ARCH_NEEDS_CPU_IDLE_COUPLE.
> 

During implementation, if I add ARCH_NEED_DELAYED_..., there will contain
many enclosed ifdef-endif and is a little bit ugly.
Also, I didn't find a must-have reason to this Kconfig after I rebase from
your suggestion.

The one calls retry_lockup_detector_init() must fail at lockup_detector_init,
so I think anyone who has aleady failed at lockup_detector_init() has right
to retry no matter HW, SW or Arch reason.
Thus I might not introduce a new Kconfig in v4, and I would be glad to see
if any further commet on this.






