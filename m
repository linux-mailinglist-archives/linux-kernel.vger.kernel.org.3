Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A86A5009E0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241198AbiDNJcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241807AbiDNJcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:32:02 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE7D64CD
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 02:29:34 -0700 (PDT)
X-UUID: a1734ec1a9c849708e20aea0a5f7ee0e-20220414
X-UUID: a1734ec1a9c849708e20aea0a5f7ee0e-20220414
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <kuyo.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1359392002; Thu, 14 Apr 2022 17:29:29 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 14 Apr 2022 17:29:29 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 14 Apr 2022 17:29:28 +0800
Message-ID: <f2579de9b0555568eff94ff83f8695af7b218349.camel@mediatek.com>
Subject: Re: [PATCH 1/1] [PATCH v2]sched/pelt: Refine the enqueue_load_avg
 calculate method
From:   Kuyo Chang <kuyo.chang@mediatek.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        "Mel Gorman" <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <wsd_upstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Thu, 14 Apr 2022 17:29:28 +0800
In-Reply-To: <f7913fea-d110-9140-6dfa-72561c3fbefd@arm.com>
References: <20220414015940.9537-1-kuyo.chang@mediatek.com>
         <f7913fea-d110-9140-6dfa-72561c3fbefd@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-04-14 at 11:02 +0200, Dietmar Eggemann wrote:
> On 14/04/2022 03:59, Kuyo Chang wrote:
> > From: kuyo chang <kuyo.chang@mediatek.com>
> 
> [...]
> 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index d4bd299d67ab..159274482c4e 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -3829,10 +3829,12 @@ static void attach_entity_load_avg(struct
> > cfs_rq *cfs_rq, struct sched_entity *s
> >  
> >  	se->avg.runnable_sum = se->avg.runnable_avg * divider;
> >  
> > -	se->avg.load_sum = divider;
> > -	if (se_weight(se)) {
> > +	se->avg.load_sum = se->avg.load_avg * divider;
> > +	if (se_weight(se) < se->avg.load_sum) {
> >  		se->avg.load_sum =
> > -			div_u64(se->avg.load_avg * se->avg.load_sum,
> > se_weight(se));
> > +			div_u64(se->avg.load_sum, se_weight(se));
> 
> Seems that this will fit on one line now. No braces needed then.

Thanks for your friendly reminder.

> 
> > +	} else {
> > +		se->avg.load_sum = 1;
> >  	}
> >  
> >  	enqueue_load_avg(cfs_rq, se);
> 
> Looks like taskgroups are not affected since they get always online
> with cpu.shares/weight = 1024 (cgroup v1):
> 
> cpu_cgroup_css_online() -> online_fair_sched_group() ->
> attach_entity_cfs_rq() -> attach_entity_load_avg()
> 
> And reweight_entity() does not have this issue.
> 
> Tested with `qemu-system-x86_64 ... cores=64 ... -enable-kvm` and
> weight=88761 for nice=0 tasks plus forcing se->avg.load_avg = 1
> before
> the div_u64() in attach_entity_load_avg().
> 
> Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

