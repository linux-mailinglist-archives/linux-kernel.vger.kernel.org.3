Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E210950211C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 05:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343980AbiDOD7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 23:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237942AbiDOD7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 23:59:01 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0D3A56CC
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 20:56:33 -0700 (PDT)
X-UUID: 02f24ce5f2d342ed88708e41b49d6325-20220415
X-UUID: 02f24ce5f2d342ed88708e41b49d6325-20220415
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <kuyo.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 84804821; Fri, 15 Apr 2022 11:56:29 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 15 Apr 2022 11:56:28 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 15 Apr 2022 11:56:27 +0800
Message-ID: <231503cb93caabb5fc0e1027423e971560493075.camel@mediatek.com>
Subject: Re: [PATCH 1/1] [PATCH v3]sched/pelt: Fix the
 attach_entity_load_avg calculate method
From:   Kuyo Chang <kuyo.chang@mediatek.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Ben Segall" <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <wsd_upstream@mediatek.com>, Ingo Molnar <mingo@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Fri, 15 Apr 2022 11:56:27 +0800
In-Reply-To: <YlgzTS+laNNvMukT@hirez.programming.kicks-ass.net>
References: <20220414090229.342-1-kuyo.chang@mediatek.com>
         <YlgzTS+laNNvMukT@hirez.programming.kicks-ass.net>
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

On Thu, 2022-04-14 at 16:44 +0200, Peter Zijlstra wrote:
> I've taken the liberty of carrying over the tags from v2 and reworked
> the Changelog a little.

Thank you for all your assistance.

> ---
> Subject: sched/pelt: Fix attach_entity_load_avg() corner case
> From: kuyo chang <kuyo.chang@mediatek.com>
> Date: Thu, 14 Apr 2022 17:02:20 +0800
> 
> From: kuyo chang <kuyo.chang@mediatek.com>
> 
> The warning in cfs_rq_is_decayed() triggered:
> 
>     SCHED_WARN_ON(cfs_rq->avg.load_avg ||
> 		  cfs_rq->avg.util_avg ||
> 		  cfs_rq->avg.runnable_avg)
> 
> There exists a corner case in attach_entity_load_avg() which will
> cause load_sum to be zero while load_avg will not be.
> 
> Consider se_weight is 88761 as per the sched_prio_to_weight[] table.
> Further assume the get_pelt_divider() is 47742, this gives:
> se->avg.load_avg is 1.
> 
> However, calculating load_sum results in 0:
> 
>   se->avg.load_sum = div_u64(se->avg.load_avg * se->avg.load_sum,
> se_weight(se));
>   se->avg.load_sum = 1*47742/88761 = 0.
> 
> Then enqueue_load_avg() adds this to the cfs_rq totals:
> 
>   cfs_rq->avg.load_avg += se->avg.load_avg;
>   cfs_rq->avg.load_sum += se_weight(se) * se->avg.load_sum;
> 
> Resulting in load_avg being 1 with load_sum is 0, which will trigger
> the WARN.
> 
> Fixes: f207934fb79d ("sched/fair: Align PELT windows between cfs_rq
> and its se")
> Signed-off-by: kuyo chang <kuyo.chang@mediatek.com>
> [peterz: massage changelog]
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Link: 
> https://urldefense.com/v3/__https://lkml.kernel.org/r/20220414090229.342-1-kuyo.chang@mediatek.com__;!!CTRNKA9wMg0ARbw!35Im02xxIuUZdLYpPng37Yk7oVNJVJ1tfbu4XRzlq-6VhH3K29Por0gJCFlslT_CMgA$
>  
> ---
>  kernel/sched/fair.c |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3829,11 +3829,11 @@ static void attach_entity_load_avg(struc
>  
>  	se->avg.runnable_sum = se->avg.runnable_avg * divider;
>  
> -	se->avg.load_sum = divider;
> -	if (se_weight(se)) {
> -		se->avg.load_sum =
> -			div_u64(se->avg.load_avg * se->avg.load_sum,
> se_weight(se));
> -	}
> +	se->avg.load_sum = se->avg.load_avg * divider;
> +	if (se_weight(se) < se->avg.load_sum)
> +		se->avg.load_sum = div_u64(se->avg.load_sum,
> se_weight(se));
> +	else
> +		se->avg.load_sum = 1;
>  
>  	enqueue_load_avg(cfs_rq, se);
>  	cfs_rq->avg.util_avg += se->avg.util_avg;

