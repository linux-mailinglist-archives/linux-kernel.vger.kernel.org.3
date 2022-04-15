Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5D9502669
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 09:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351247AbiDOHy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 03:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbiDOHyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 03:54:24 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E333F972D2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 00:51:56 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id f17so13342742ybj.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 00:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vjeWsXtASX/pNdd1ytDVNPBBDW64/hMWWfZY9eBg7LI=;
        b=xoDv3eqs+rVNnZOMFDMatQSlOO+Oh2JidainIPEyXj7/VxIkfWsCvMx47tlEEQ4cPd
         wwe05acalMrHzk17kOQKWglkeuawgCZX2z+7XIdvW3nvud7Z7KdOxGJXn2cYw49Fg9Z2
         1P6AXdSVXzYsFvrJPGTayFqxXdpYLuvu8erf9L4OrIaLv+XXNapVnLYPOy74ayWHpACB
         jRZxZvNA4/xrXxKK0+trJt8tpZ/rW8gl9Xp9kihrn+05MJ8ZdBEIhO/wCOxejkHL5njL
         gwkdiSZ/59TUysp7LT7YOqybcyDEepPMrc2ejk0rdyDcmQp6TkFqV3wdgbJB7iPijVlN
         5a3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vjeWsXtASX/pNdd1ytDVNPBBDW64/hMWWfZY9eBg7LI=;
        b=ccRrBnuhY3plhC5U8zBNPd5IE+PMFx91C4lWiuRE0Ee+Fq3x796v3ZK/7hirpWqELg
         z7yp6h9Azew9jsYeTmJ5fwHYoSsWl38CKUFh5aEHOJUuhDBEdfuRRwyNbCe0Cqngr5Fh
         N2S+oQKXENNM0f5p5+6dUu7rbVL6hkUX1BOLHuBv7En1JpPDbLV+UuCUx0+wEqhCVyQD
         KXjObGmTHDfPa7aKNzAi938gcUBquQa1V4sM/bHiTL/GSriF6rsHXHqatawzMWRMSy/9
         y7AvoKiwLQjh+iz4rMOTFeDNJZyXl147UZ2/r8L903hd4ByJwBynZMFexTb+ZL0bc+li
         FC5A==
X-Gm-Message-State: AOAM531VD1Au2PU6EZyydJpX5HvI8ZmRdYmCGf8XqhBHDA39+hOaQ3pc
        h9tIYv3m35SvK/RhaASP1QbgyEEjmbts2YAS9Ezhzw==
X-Google-Smtp-Source: ABdhPJwu6CpPPMo6+Thi32FKkTi3JSvcjedkwLD2X/1tKpILNAtz5S5HDkNGACs1TaTeyx0s6MCzJNY8nDCpgBhYNdU=
X-Received: by 2002:a25:32c3:0:b0:641:4d40:3065 with SMTP id
 y186-20020a2532c3000000b006414d403065mr4412521yby.403.1650009115424; Fri, 15
 Apr 2022 00:51:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220413041627.41521-1-zhouchengming@bytedance.com>
 <xm26h76wvql9.fsf@bsegall-linux.svl.corp.google.com> <14737e0f-3d33-125b-57cc-966de00430be@bytedance.com>
In-Reply-To: <14737e0f-3d33-125b-57cc-966de00430be@bytedance.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 15 Apr 2022 09:51:44 +0200
Message-ID: <CAKfTPtBWXyamX0jFSvgP3VnZacd5SNb_Yg9jAq1y0koHwr7DxQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] sched/fair: update tg->load_avg and
 se->load in throttle_cfs_rq()
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     Benjamin Segall <bsegall@google.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com,
        zhengqi.arch@bytedance.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Apr 2022 at 07:42, Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> On 2022/4/14 01:30, Benjamin Segall wrote:
> > Chengming Zhou <zhouchengming@bytedance.com> writes:
> >
> >> We use update_load_avg(cfs_rq, se, 0) in throttle_cfs_rq(), so the
> >> cfs_rq->tg_load_avg_contrib and task_group->load_avg won't be updated
> >> even when the cfs_rq's load_avg has changed.
> >>
> >> And we also don't call update_cfs_group(se), so the se->load won't
> >> be updated too.
> >>
> >> Change to use update_load_avg(cfs_rq, se, UPDATE_TG) and add
> >> update_cfs_group(se) in throttle_cfs_rq(), like we do in
> >> dequeue_task_fair().
> >
> > Hmm, this does look more correct; Vincent, was having this not do
> > UPDATE_TG deliberate, or an accident that we all missed when checking?

The cost of UPDATE_TG/update_tg_load_avg() is not free and the parent
cfs->load_avg should not change because of the throttling but only the
cfs->weight so I don't see a real benefit of UPDATE_TG.

Chengming,
have you faced an issue or this change is based on code review ?

> >
> > It looks like the unthrottle_cfs_rq side got UPDATE_TG added later in
> > the two-loops pass, but not the throttle_cfs_rq side.
>
> Yes, UPDATE_TG was added in unthrottle_cfs_rq() in commit 39f23ce07b93
> ("sched/fair: Fix unthrottle_cfs_rq() for leaf_cfs_rq list").
>
> >
> > Also unthrottle_cfs_rq I'm guessing could still use update_cfs_group(se)
>
> It looks like we should also add update_cfs_group(se) in unthrottle_cfs_rq().
>
> Thanks.
>
> >
> >
> >>
> >> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> >> ---
> >>  kernel/sched/fair.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index d4bd299d67ab..b37dc1db7be7 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -4936,8 +4936,9 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
> >>              if (!se->on_rq)
> >>                      goto done;
> >>
> >> -            update_load_avg(qcfs_rq, se, 0);
> >> +            update_load_avg(qcfs_rq, se, UPDATE_TG);
> >>              se_update_runnable(se);
> >> +            update_cfs_group(se);
> >>
> >>              if (cfs_rq_is_idle(group_cfs_rq(se)))
> >>                      idle_task_delta = cfs_rq->h_nr_running;
