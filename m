Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599D056B9C8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 14:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238240AbiGHMfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 08:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238250AbiGHMfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 08:35:19 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04AA87B362
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 05:35:16 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id r14so24584097wrg.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 05:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=egqAfIk8HNdnnnVuacIUZ+kM7234sBqyRaupSrWdbPc=;
        b=obzdgixXttw3w4RBLfM4lF/m6ddMQiKfnFk/rQhmB9aWSRQg4kZ2hf4T6gLBoyNXsx
         LxmuQRx8xJFfEiHqu6dXZc6FrbXqvhiw0R2i1Sv+8WiGtClevYonNPDbUivdwnX/rYv5
         fWnQrkES4zbChbg+34deuBbI+gBCcIvKVWE3exhzkPfwMNvp3H7PMZGR+hFnkjoRk28k
         qyzOeU/J042Ngj7CF1mYg0uZRK9ZiEDbtEODB1ykiybZqPL3TA9+hEQnGMy7DYBSJxJ8
         3Bfsb4++T5P7UU2K+X/TLbwlf7foL1uwyUbAf3u06JXrCuywG0ly1ozvu3usyhcUZoFs
         UznA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=egqAfIk8HNdnnnVuacIUZ+kM7234sBqyRaupSrWdbPc=;
        b=I3ElQCwHFDCx3cRUZBYGh+ZEc3XVWg45Y8U49ZdBZuK0xg1lDj/C0mkPcCoN7qdai5
         tP6e+F6lSLKueTiPwMtRr+cTZ1asdGiV3QSK5WLuV8XuIlJK7T2DxAhN3ow7BqhBjrgp
         +g+u9qQlHaSsIK/xhQ4GwdlCtBuyk3IcnCI74OYwDyTnwugmfYXIfWYg4XbV2e2fKpEH
         fZZJU0WZsFxZcecF7FB1SSx426++NKZJlBDeJoQKdQlU9VrDntRO137baNSa+l20iVOY
         JN1ffEAPrAPsOofJSYCGRS5iFVfswwnYDyzgQMfDO7pHmYuWXKflikMneMyvfgiHEwwU
         P2PA==
X-Gm-Message-State: AJIora84aHo4FYjjHfwcc6ahkUsfTR38RWLk9aW1g2vTB7B00MbJnVB2
        LoJUeCHGXiB6y0cm9HjvgeJjXg==
X-Google-Smtp-Source: AGRyM1veyA3D/svZALdt0plBqMx98kvHBy2yZCB50hHNI8PHVRQKNVemDpc3LxX5tm/tS34UVsyMyA==
X-Received: by 2002:adf:da45:0:b0:21d:8f3e:a3e0 with SMTP id r5-20020adfda45000000b0021d8f3ea3e0mr3164859wrl.310.1657283714480;
        Fri, 08 Jul 2022 05:35:14 -0700 (PDT)
Received: from vingu-book (91-160-61-128.subs.proxad.net. [91.160.61.128])
        by smtp.gmail.com with ESMTPSA id i133-20020a1c3b8b000000b003a02c21b7easm2093177wma.11.2022.07.08.05.35.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Jul 2022 05:35:13 -0700 (PDT)
Date:   Fri, 8 Jul 2022 14:35:11 +0200
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, david.chen@nutanix.com,
        zhangqiao22@huawei.com
Subject: Re: [PATCH] sched/fair: fix case with reduced capacity CPU
Message-ID: <20220708123511.GA22615@vingu-book>
References: <20220702045254.22922-1-vincent.guittot@linaro.org>
 <88fab4b6-8e5c-3a4e-e32b-a0867d51398b@arm.com>
 <CAKfTPtA07H=nkXdyCto9=7Zzixwnu_N_4L-vfn+0ONCQ464biA@mail.gmail.com>
 <063c4695-a9d4-f77a-55a7-7c554b765c7e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <063c4695-a9d4-f77a-55a7-7c554b765c7e@arm.com>
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

Le vendredi 08 juil. 2022 à 12:10:40 (+0200), Dietmar Eggemann a écrit :
> On 08/07/2022 09:17, Vincent Guittot wrote:
> > On Thu, 7 Jul 2022 at 18:43, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> >>
> >> On 02/07/2022 06:52, Vincent Guittot wrote:
> 
> [...]
> 
> >>> The rework of the load balance has filterd the case when the CPU is
> 
> s/filterd/filtered
> 
> >>> classified to be fully busy but its capacity is reduced.
> >>>
> >>> Check if CPU's capacity is reduced while gathering load balance statistics
> >>> and classify it group_misfit_task instead of group_fully_busy so we can
> 
> enum group_type {
> 
>    ...
>    /*
>     * SD_ASYM_CPUCAPACITY only: One task doesn't fit with CPU's capacity
>     * and must be migrated to a more powerful CPU.
>     */
>    group_misfit_task
>    ...
> 
> This `SD_ASYM_CPUCAPACITY only:` should be removed now.

Yes

> 
> [...]
> 
> >>> @@ -8798,6 +8798,19 @@ sched_asym(struct lb_env *env, struct sd_lb_stats *sds,  struct sg_lb_stats *sgs
> >>>       return sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu);
> >>>  }
> >>>
> >>> +static inline bool
> >>> +sched_reduced_capacity(struct rq *rq, struct sched_domain *sd)
> 
> minor: Why not `static inline int check_reduced_capacity()` ? All
> similar functions like check_cpu_capacity(), check_cpu_capacity() follow
> this approach.

Mainly because it aims to return true or false.
IIRC check_cpu_capacity has replaced fix_small_capacity which was not a bool but the
number of task a group could handle but kept the int

> 
> [...]
> 
> >>> @@ -8851,11 +8865,17 @@ static inline void update_sg_lb_stats(struct lb_env *env,
> >>>               if (local_group)
> >>>                       continue;
> >>>
> >>> -             /* Check for a misfit task on the cpu */
> >>> -             if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
> >>> -                 sgs->group_misfit_task_load < rq->misfit_task_load) {
> >>> -                     sgs->group_misfit_task_load = rq->misfit_task_load;
> >>> -                     *sg_status |= SG_OVERLOAD;
> >>> +             if (env->sd->flags & SD_ASYM_CPUCAPACITY) {
> >>> +                     /* Check for a misfit task on the cpu */
> >>> +                     if (sgs->group_misfit_task_load < rq->misfit_task_load) {
> >>> +                             sgs->group_misfit_task_load = rq->misfit_task_load;
> >>> +                             *sg_status |= SG_OVERLOAD;
> >>> +                     }
> >>> +             } else if ((env->idle != CPU_NOT_IDLE) &&
> >>> +                        sched_reduced_capacity(rq, env->sd) &&
> >>> +                        (sgs->group_misfit_task_load < load)) {
> >>> +                     /* Check for a task running on a CPU with reduced capacity */
> >>> +                     sgs->group_misfit_task_load = load;
> >>>               }
> 
> Minor:
> 
> This now has if(A)
>               if(B)
> 	     else if(C && B')
> 
> little bit harder to read.
> 

yeah I started with the below but then optimized it. I can come back to the
version below if it's easier to read

		if (env->sd->flags & SD_ASYM_CPUCAPACITY) {
			/* Check for a misfit task on the cpu */
			if (sgs->group_misfit_task_load < rq->misfit_task_load) {
				sgs->group_misfit_task_load = rq->misfit_task_load;
				*sg_status |= SG_OVERLOAD;
			}
		} else if ((env->idle != CPU_NOT_IDLE) &&
			   sched_reduced_capacity(rq, env->sd)) {
			/* Check for a task running on a CPU with reduced capacity */
			if (sgs->group_misfit_task_load < load))
				sgs->group_misfit_task_load = load;
		}


> [...]
> 
> >> I'm wondering why you've chosen that hybrid approach `group_misfit_task
> >> -> migrate_load` and not `group_misfit_task -> migrate_misfit`.
> > 
> > because, it means enabling the tracking of misfit task on rq at each
> > task enqueue/dequeue/tick ...  Then mistfit for heterogeneous platform
> > checks max_cpu_capacity what we don't care and will trigger unwanted
> > misfit migration for smp
> 
> Agreed, rq->misfit_task_load can't be used here.
> 
> >> It looks like this `rq->cfs.h_nr_running = 1` case almost (since we
> >> check `busiest->nr_running > 1`) always ends up in the load_balance()
> >> `if (!ld_moved)` condition and need_active_balance() can return 1 in
> >> case `if ((env->idle != CPU_NOT_IDLE) && ...` condition. This leads to
> >> active load_balance and this
> >>
> >> IMHO, the same you can achieve when you would stay with
> >> `group_misfit_task -> migrate_misfit`.
> >>
> >> I think cpu_load(rq) can be used instead of `rq->misfit_task_load` in
> >> the migrate_misfit case of find_busiest_queue() too.
> > 
> > I don't think because you can have a higher cpu_load() but not being misfit
> 
> You're right, I forgot about this. Essentially we would need extra state
> (e.g. in lb_env) to save which CPU in the busiest group has the misfit.
