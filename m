Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFDA534C9E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 11:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346889AbiEZJkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 05:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346877AbiEZJkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 05:40:01 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82E4101C8;
        Thu, 26 May 2022 02:39:59 -0700 (PDT)
X-UUID: 725030e9a4f3465ba644ee7626842f8b-20220526
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:ee36ea4f-556f-4edf-be46-bdf688264eb1,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:51
X-CID-INFO: VERSION:1.1.5,REQID:ee36ea4f-556f-4edf-be46-bdf688264eb1,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:51
X-CID-META: VersionHash:2a19b09,CLOUDID:3a0557b8-3c45-407b-8f66-25095432a27a,C
        OID:16e5598ec9f1,Recheck:0,SF:28|17|19|48,TC:nil,Content:-5,EDM:-3,IP:nil,
        URL:0,File:nil,QS:0,BEC:nil
X-UUID: 725030e9a4f3465ba644ee7626842f8b-20220526
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 312405798; Thu, 26 May 2022 17:39:56 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 26 May 2022 17:39:55 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 26 May 2022 17:39:54 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 26 May 2022 17:39:54 +0800
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
Subject: Re: [PATCH v4 4/6] kernel/watchdog: Adapt the watchdog_hld interface for async model
Date:   Thu, 26 May 2022 17:39:54 +0800
Message-ID: <20220526093954.19319-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <YodhoxG0xmfrNYoN@alley>
References: <YodhoxG0xmfrNYoN@alley>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu 2022-04-28 00:13:38, Lecopzer Chen wrote:
> > When lockup_detector_init()->watchdog_nmi_probe(), PMU may be not ready
> > yet. E.g. on arm64, PMU is not ready until
> > device_initcall(armv8_pmu_driver_init).  And it is deeply integrated
> > with the driver model and cpuhp. Hence it is hard to push this
> > initialization before smp_init().
> > 
> > But it is easy to take an opposite approach and try to initialize
> > the watchdog once again later.
> > The delayed probe is called using workqueues. It need to allocate
> > memory and must be proceed in a normal context.
> > The delayed probe is able to use if watchdog_nmi_probe() returns
> > non-zero which means the return code returned when PMU is not ready yet.
> > 
> > Provide an API - retry_lockup_detector_init() for anyone who needs
> > to delayed init lockup detector if they had ever failed at
> > lockup_detector_init().
> > 
> > The original assumption is: nobody should use delayed probe after
> > lockup_detector_check() which has __init attribute.
> > That is, anyone uses this API must call between lockup_detector_init()
> > and lockup_detector_check(), and the caller must have __init attribute
> > 
> > --- a/kernel/watchdog.c
> > +++ b/kernel/watchdog.c
> > +/*
> > + * retry_lockup_detector_init - retry init lockup detector if possible.
> > + *
> > + * Retry hardlockup detector init. It is useful when it requires some
> > + * functionality that has to be initialized later on a particular
> > + * platform.
> > + */
> > +void __init retry_lockup_detector_init(void)
> > +{
> > +	/* Must be called before late init calls */
> > +	if (!allow_lockup_detector_init_retry)
> > +		return;
> > +
> > +	queue_work_on(__smp_processor_id(), system_wq, &detector_work);
> 
> Just a small nit. This can be simplified by calling:
> 
> 	schedule_work(&detector_work);
> 
> It uses "system_wq" that uses CPU-bound workers. It prefers
> the current CPU. But the exact CPU is not important. Any CPU-bound
> worker is enough.

Thanks!! I'll tweak this on -rc1
> 
> > +}
> > +
> 
> With the above change, feel free to use:
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>

Really appreciate your review and idea, thank you ver much.


BRs,
Lecopzer



