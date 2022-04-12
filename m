Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C094FDC71
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347154AbiDLK1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 06:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358236AbiDLKUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 06:20:54 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B1E4FC79
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 02:28:20 -0700 (PDT)
X-UUID: 1c074ba5c47e4697b18b2313055fe597-20220412
X-UUID: 1c074ba5c47e4697b18b2313055fe597-20220412
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <kuyo.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 740492044; Tue, 12 Apr 2022 17:28:11 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 12 Apr 2022 17:28:10 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 12 Apr 2022 17:28:10 +0800
Message-ID: <354ea7554096b0745d4f947685add33c8c8d2d62.camel@mediatek.com>
Subject: Re: [PATCH 1/1] sched/pelt: Refine the enqueue_load_avg calculate
 method
From:   Kuyo Chang <kuyo.chang@mediatek.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Ben Segall" <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <wsd_upstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Tue, 12 Apr 2022 17:28:10 +0800
In-Reply-To: <20220412085845.GA14088@vingu-book>
References: <20220411061702.22978-1-kuyo.chang@mediatek.com>
         <CAKfTPtAyhc-tAWXmXcHstmiBSMjj5GENizX__KRDab28NRum1A@mail.gmail.com>
         <5a90b20570ecacf457f68da7a106d3b2f8c2269e.camel@mediatek.com>
         <20220412085845.GA14088@vingu-book>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        RDNS_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-04-12 at 10:58 +0200, Vincent Guittot wrote:
> Le mardi 12 avril 2022 à 10:51:23 (+0800), Kuyo Chang a écrit :
> > On Mon, 2022-04-11 at 10:39 +0200, Vincent Guittot wrote:
> > > On Mon, 11 Apr 2022 at 08:17, Kuyo Chang <kuyo.chang@mediatek.com
> > > >
> > > wrote:
> > > > 
> > > > From: kuyo chang <kuyo.chang@mediatek.com>
> > > > 
> > > > I meet the warning message at cfs_rq_is_decayed at below code.
> > > > 
> > > > SCHED_WARN_ON(cfs_rq->avg.load_avg ||
> > > >                     cfs_rq->avg.util_avg ||
> > > >                     cfs_rq->avg.runnable_avg)
> > > > 
> > > > Following is the calltrace.
> > > > 
> > > > Call trace:
> > > > __update_blocked_fair
> > > > update_blocked_averages
> > > > newidle_balance
> > > > pick_next_task_fair
> > > > __schedule
> > > > schedule
> > > > pipe_read
> > > > vfs_read
> > > > ksys_read
> > > > 
> > > > After code analyzing and some debug messages, I found it exits
> > > > a
> > > > corner
> > > > case at attach_entity_load_avg which will cause load_sum is
> > > > zero
> > > > and
> > > > load_avg is not.
> > > > Consider se_weight is 88761 according by sched_prio_to_weight
> > > > table.
> > > > And assume the get_pelt_divider() is 47742, se->avg.load_avg is
> > > > 1.
> > > > By the calculating for se->avg.load_sum as following will
> > > > become
> > > > zero
> > > > as following.
> > > > se->avg.load_sum =
> > > >         div_u64(se->avg.load_avg * se->avg.load_sum,
> > > > se_weight(se));
> > > > se->avg.load_sum = 1*47742/88761 = 0.
> > > 
> > > The root problem is there, se->avg.load_sum must not be null if
> > > se->avg.load_avg is not null because the correct relation between
> > > _avg
> > > and _sum is:
> > > 
> > > load_avg = weight * load_sum / divider.
> > > 
> > > so the fix should be attach_entity_load_avg() and probably the
> > > below
> > > is enough
> > > 
> > > se->avg.load_sum = div_u64(se->avg.load_avg * se->avg.load_sum,
> > > se_weight(se)) + 1;
> > 
> > Thanks for your kindly suggestion.
> > +1 would make the calcuation for load_sum may be overestimate?
> > How about the below code make sense for fix the corner case?
> > 
> > --- 
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -3832,7 +3832,8 @@ static void attach_entity_load_avg(struct
> > cfs_rq
> > *cfs_rq, struct sched_entity *s
> >  	se->avg.load_sum = divider;
> >  	if (se_weight(se)) {
> >  		se->avg.load_sum =
> > -			div_u64(se->avg.load_avg * se->avg.load_sum,
> > se_weight(se));
> > +			(se->avg.load_avg * se->avg.load_sum >
> > se_weight(se)) ?
> > +			div_u64(se->avg.load_avg * se->avg.load_sum,
> > se_weight(se)) : 1;
> >  	}
> >  
> >  	enqueue_load_avg(cfs_rq, se);
> > -- 
> > 2.18.0
> 
> In this case, the below is easier to read
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1658a9428d96..2c685474db23 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3836,10 +3836,12 @@ static void attach_entity_load_avg(struct
> cfs_rq *cfs_rq, struct sched_entity *s
> 
>         se->avg.runnable_sum = se->avg.runnable_avg * divider;
> 
> -       se->avg.load_sum = divider;
> -       if (se_weight(se)) {
> +       se->avg.load_sum = se->avg.load_avg * divider;
> +       if (se_weight(se) < se->avg.load_sum) {
>                 se->avg.load_sum =
> -                       div_u64(se->avg.load_avg * se->avg.load_sum,
> se_weight(se));
> +                       div_u64(se->avg.load_sum, se_weight(se));
> +       } else {
> +               se->avg.load_sum = 1;
>         }
> 
>         enqueue_load_avg(cfs_rq, se);

It really easier to read.
Thanks for your kindly suggestion.


> 
> 
> > 
> > 
> > > > 
> > > > After enqueue_load_avg code as below.
> > > > cfs_rq->avg.load_avg += se->avg.load_avg;
> > > > cfs_rq->avg.load_sum += se_weight(se) * se->avg.load_sum;
> > > > 
> > > > Then the load_sum for cfs_rq will be 1 while the load_sum for
> > > > cfs_rq is 0.
> > > > So it will hit the warning message.
> > > > 
> > > > After all, I refer the following commit patch to do the similar
> > > > thing at
> > > > enqueue_load_avg.
> > > > sched/pelt: Relax the sync of load_sum with load_avg
> > > > 
> > > > After long time testing, the kernel warning was gone and the
> > > > system
> > > > runs
> > > > as well as before.
> > > > 
> > > > Signed-off-by: kuyo chang <kuyo.chang@mediatek.com>
> > > > ---
> > > >  kernel/sched/fair.c | 6 ++++--
> > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > index d4bd299d67ab..30d8b6dba249 100644
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > > @@ -3074,8 +3074,10 @@ account_entity_dequeue(struct cfs_rq
> > > > *cfs_rq, struct sched_entity *se)
> > > >  static inline void
> > > >  enqueue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity
> > > > *se)
> > > >  {
> > > > -       cfs_rq->avg.load_avg += se->avg.load_avg;
> > > > -       cfs_rq->avg.load_sum += se_weight(se) * se-
> > > > >avg.load_sum;
> > > > +       add_positive(&cfs_rq->avg.load_avg, se->avg.load_avg);
> > > > +       add_positive(&cfs_rq->avg.load_sum, se_weight(se) * se-
> > > > > avg.load_sum);
> > > > 
> > > > +       cfs_rq->avg.load_sum = max_t(u32, cfs_rq->avg.load_sum,
> > > > +                                         cfs_rq->avg.load_avg
> > > > *
> > > > PELT_MIN_DIVIDER);
> > > >  }
> > > > 
> > > >  static inline void
> > > > --
> > > > 2.18.0
> > > > 

