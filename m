Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D5F4FDC58
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379773AbiDLKTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 06:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356807AbiDLJzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 05:55:18 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE2111C23
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 01:58:50 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id c10so5567674wrb.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 01:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=CPUP1Iq5fK/bmBgD1XCDK9cdQZsBkT+LUZqC6FIYBEk=;
        b=ej+a3pcQfnw/MAwQO1KUZl+/MzVf9OjlW3toLX+V5ZSuj6Lygh+c53bbo4I0FoV8/a
         p8vakm0Jsw3ksH8U50KlfPdIlpLfa7owB0utMqfTJJqho+MpEgpubq/ic8KcX9sig5v2
         5PFZnLin2hJonUxw1sJ83AYtUmG9nzttIF+8MPSDAmTB6/5DoGzMePQGAzjTKjCKmU9J
         odRpwIOgtfuS3i1OiXnWCKw2VlC28PkjI/SPSFsfqh3jtmGyxC51bDyFNAYxafhLn+Mj
         2pgNVO1ZuF/1N3XZJETFpkBxoXbwy0LeF5SFvKQEr3ttl18GC/NavN60TWVeTDtaDrMr
         LWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=CPUP1Iq5fK/bmBgD1XCDK9cdQZsBkT+LUZqC6FIYBEk=;
        b=s1YUbxV/fMlkDEFi8PVVeQZjvGZDh5RgJBOz+o3ZY2Ut7/V2YHDuz5vswsPOIyhNO7
         B0IMdf9kmElu39B6uYBCpV/9pQMaruyWkTw/DYKxAxKmlVOlSs+bZnykS6Xy8Oqsigb+
         mBBt8CLjaPzJE2nGHa94mRv/UrDWGxm74Xg5Whzo0ZKKZ0V16DhfBA68Mf0+zBTRpNEt
         eWCEWIK8y+/1v15WmhFzcU3/6ZxDX2ClIGCcH3gf/yd+xL94SYEnSSlIWcer9grZsQZM
         Zs6Tm8qEURIJ9DhsVvWIqFG/NUa4O1VUQ/WmxP909Rfsrp9TnFW65W9TkKrN5zhoML08
         Yfrw==
X-Gm-Message-State: AOAM531nefx0IC8Uc7LmK6nM+8hVMIQMKnZXDi8Yg72jE4zGBkYOvcH/
        F6VIRDpXdUckWsV56snv6TIKbQ==
X-Google-Smtp-Source: ABdhPJyoMN7KH4PRi34uNSYqnK6SmghZOUl9xoVGecU6nVJPgukZNVMMheGJqnwEunGq2o9JuaTtOw==
X-Received: by 2002:a5d:64ae:0:b0:207:8830:fa57 with SMTP id m14-20020a5d64ae000000b002078830fa57mr19642993wrp.272.1649753928432;
        Tue, 12 Apr 2022 01:58:48 -0700 (PDT)
Received: from vingu-book ([2a01:e0a:f:6020:8808:91f3:6692:66dd])
        by smtp.gmail.com with ESMTPSA id i9-20020a5d5849000000b002058631cfacsm29504199wrf.61.2022.04.12.01.58.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Apr 2022 01:58:47 -0700 (PDT)
Date:   Tue, 12 Apr 2022 10:58:45 +0200
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     Kuyo Chang <kuyo.chang@mediatek.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/1] sched/pelt: Refine the enqueue_load_avg calculate
 method
Message-ID: <20220412085845.GA14088@vingu-book>
References: <20220411061702.22978-1-kuyo.chang@mediatek.com>
 <CAKfTPtAyhc-tAWXmXcHstmiBSMjj5GENizX__KRDab28NRum1A@mail.gmail.com>
 <5a90b20570ecacf457f68da7a106d3b2f8c2269e.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5a90b20570ecacf457f68da7a106d3b2f8c2269e.camel@mediatek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 12 avril 2022 à 10:51:23 (+0800), Kuyo Chang a écrit :
> On Mon, 2022-04-11 at 10:39 +0200, Vincent Guittot wrote:
> > On Mon, 11 Apr 2022 at 08:17, Kuyo Chang <kuyo.chang@mediatek.com>
> > wrote:
> > > 
> > > From: kuyo chang <kuyo.chang@mediatek.com>
> > > 
> > > I meet the warning message at cfs_rq_is_decayed at below code.
> > > 
> > > SCHED_WARN_ON(cfs_rq->avg.load_avg ||
> > >                     cfs_rq->avg.util_avg ||
> > >                     cfs_rq->avg.runnable_avg)
> > > 
> > > Following is the calltrace.
> > > 
> > > Call trace:
> > > __update_blocked_fair
> > > update_blocked_averages
> > > newidle_balance
> > > pick_next_task_fair
> > > __schedule
> > > schedule
> > > pipe_read
> > > vfs_read
> > > ksys_read
> > > 
> > > After code analyzing and some debug messages, I found it exits a
> > > corner
> > > case at attach_entity_load_avg which will cause load_sum is zero
> > > and
> > > load_avg is not.
> > > Consider se_weight is 88761 according by sched_prio_to_weight
> > > table.
> > > And assume the get_pelt_divider() is 47742, se->avg.load_avg is 1.
> > > By the calculating for se->avg.load_sum as following will become
> > > zero
> > > as following.
> > > se->avg.load_sum =
> > >         div_u64(se->avg.load_avg * se->avg.load_sum,
> > > se_weight(se));
> > > se->avg.load_sum = 1*47742/88761 = 0.
> > 
> > The root problem is there, se->avg.load_sum must not be null if
> > se->avg.load_avg is not null because the correct relation between
> > _avg
> > and _sum is:
> > 
> > load_avg = weight * load_sum / divider.
> > 
> > so the fix should be attach_entity_load_avg() and probably the below
> > is enough
> > 
> > se->avg.load_sum = div_u64(se->avg.load_avg * se->avg.load_sum,
> > se_weight(se)) + 1;
> 
> Thanks for your kindly suggestion.
> +1 would make the calcuation for load_sum may be overestimate?
> How about the below code make sense for fix the corner case?
> 
> --- 
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3832,7 +3832,8 @@ static void attach_entity_load_avg(struct cfs_rq
> *cfs_rq, struct sched_entity *s
>  	se->avg.load_sum = divider;
>  	if (se_weight(se)) {
>  		se->avg.load_sum =
> -			div_u64(se->avg.load_avg * se->avg.load_sum,
> se_weight(se));
> +			(se->avg.load_avg * se->avg.load_sum >
> se_weight(se)) ?
> +			div_u64(se->avg.load_avg * se->avg.load_sum,
> se_weight(se)) : 1;
>  	}
>  
>  	enqueue_load_avg(cfs_rq, se);
> -- 
> 2.18.0

In this case, the below is easier to read

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1658a9428d96..2c685474db23 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3836,10 +3836,12 @@ static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s

        se->avg.runnable_sum = se->avg.runnable_avg * divider;

-       se->avg.load_sum = divider;
-       if (se_weight(se)) {
+       se->avg.load_sum = se->avg.load_avg * divider;
+       if (se_weight(se) < se->avg.load_sum) {
                se->avg.load_sum =
-                       div_u64(se->avg.load_avg * se->avg.load_sum, se_weight(se));
+                       div_u64(se->avg.load_sum, se_weight(se));
+       } else {
+               se->avg.load_sum = 1;
        }

        enqueue_load_avg(cfs_rq, se);



> 
> 
> > > 
> > > After enqueue_load_avg code as below.
> > > cfs_rq->avg.load_avg += se->avg.load_avg;
> > > cfs_rq->avg.load_sum += se_weight(se) * se->avg.load_sum;
> > > 
> > > Then the load_sum for cfs_rq will be 1 while the load_sum for
> > > cfs_rq is 0.
> > > So it will hit the warning message.
> > > 
> > > After all, I refer the following commit patch to do the similar
> > > thing at
> > > enqueue_load_avg.
> > > sched/pelt: Relax the sync of load_sum with load_avg
> > > 
> > > After long time testing, the kernel warning was gone and the system
> > > runs
> > > as well as before.
> > > 
> > > Signed-off-by: kuyo chang <kuyo.chang@mediatek.com>
> > > ---
> > >  kernel/sched/fair.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index d4bd299d67ab..30d8b6dba249 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -3074,8 +3074,10 @@ account_entity_dequeue(struct cfs_rq
> > > *cfs_rq, struct sched_entity *se)
> > >  static inline void
> > >  enqueue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
> > >  {
> > > -       cfs_rq->avg.load_avg += se->avg.load_avg;
> > > -       cfs_rq->avg.load_sum += se_weight(se) * se->avg.load_sum;
> > > +       add_positive(&cfs_rq->avg.load_avg, se->avg.load_avg);
> > > +       add_positive(&cfs_rq->avg.load_sum, se_weight(se) * se-
> > > >avg.load_sum);
> > > +       cfs_rq->avg.load_sum = max_t(u32, cfs_rq->avg.load_sum,
> > > +                                         cfs_rq->avg.load_avg *
> > > PELT_MIN_DIVIDER);
> > >  }
> > > 
> > >  static inline void
> > > --
> > > 2.18.0
> > > 
> 
