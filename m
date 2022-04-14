Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7855002E8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 02:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238045AbiDNALO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 20:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbiDNALM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 20:11:12 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DC9554A7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 17:08:48 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id m132so6653089ybm.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 17:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KRjESF5FJIppkqvq7rWvqVyiT3uWKLMco+KRyugPGuY=;
        b=bL8WjOj97hcTkM3aWTWjot6/IEfmif43UxKTHCD8UiyXMbdT1G05tw7JE+5DJDIiDT
         4OkR3EJYpd0Skz6FhTbv9fwuSsEPniUelRLmy6pn58XwX1bReuKb/eJ6DQOeV3Pw7eyI
         pyxCTUWSysLQHJ4g4+xfgZqSw4R/76YX8XuvPGLstjWPhqTP35JvlOVDNfIYYYS2QF9X
         l86l9p5I0pRfZfpp1MS63SsJfeVWtWYRSVRjXZH8op+5hOSe5ZdSrDGviJN6JJ/xyNfn
         j+F2/LfRfk5BW2PH44Q4T4oB5chqnDjanpPLeGce2mkfStni3RrNBvJQUm5gShUi/zL1
         0v2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KRjESF5FJIppkqvq7rWvqVyiT3uWKLMco+KRyugPGuY=;
        b=YHrn3m6NXEiiiTBmn4eXl862nxcfuBZtuTOrs1PlLbs8Ae+HZbW0dlIbIdW7FhpSVY
         4k2WeJew5AcMJ3cbtRf5dNVQYcQCvS+ydy1blouDGViQl/IvKd4yJ9Re6M0W+ux+IDLJ
         DYEZgvhk0SRQidAzOXu4m684sxumSIOVcVDIb7EZZIhI5TkRJHQ4a1pwOr3rOB3jTAsn
         BYhU+SHsXBfGIMdIDO6k72goKHyISe7a5/AC8LXIC/+9bNXki19LhA3v3ml27hgZ9FsZ
         h4mSaP25aguF2YmuWWKx4UVdSnZJt9OR8yosCL/jmWZ8rzMNdezZ4l3nsXKzo7VdaNKH
         /cKQ==
X-Gm-Message-State: AOAM531kdiUtKTqIzuRdhroFk1OgrnohPdTfDmVo67M8NRYsBsAnkbiP
        t3XyyS6NEBNGH9jigi4uEhNSi1bUlY3pzuZWWlRGFw==
X-Google-Smtp-Source: ABdhPJzW/dDw/Hsb3IEmOz2O/HeynYs0/0G7haokqptUKTA4rWSGKT6X3OtLVB+WpFnMycjX8kuX+ga4ZIXjrBZg/ow=
X-Received: by 2002:a25:41cf:0:b0:641:1857:ac7c with SMTP id
 o198-20020a2541cf000000b006411857ac7cmr19703yba.281.1649894927444; Wed, 13
 Apr 2022 17:08:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220409135104.3733193-1-wuyun.abel@bytedance.com>
 <20220409135104.3733193-3-wuyun.abel@bytedance.com> <CABk29NvE=Fmgo4xqQLfy-K8j0hNS-+ppGdYt37yDUnRJiqjZ5w@mail.gmail.com>
 <801da029-6bbe-2a0c-7de0-afffc3d5de02@bytedance.com>
In-Reply-To: <801da029-6bbe-2a0c-7de0-afffc3d5de02@bytedance.com>
From:   Josh Don <joshdon@google.com>
Date:   Wed, 13 Apr 2022 17:08:36 -0700
Message-ID: <CABk29Nu9QTUKHP3cyx3qpiGcNM-PbaSxCvfhvBvOs++67KeXCw@mail.gmail.com>
Subject: Re: [RFC v2 2/2] sched/fair: introduce sched-idle balance
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >>   /*
> >>    * Use locality-friendly rq->overloaded to cache the status of the rq
> >>    * to minimize the heavy cost on LLC shared data.
> >> @@ -7837,6 +7867,22 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
> >>          if (kthread_is_per_cpu(p))
> >>                  return 0;
> >>
> >> +       if (unlikely(task_h_idle(p))) {
> >> +               /*
> >> +                * Disregard hierarchically idle tasks during sched-idle
> >> +                * load balancing.
> >> +                */
> >> +               if (env->idle == CPU_SCHED_IDLE)
> >> +                       return 0;
> >> +       } else if (!static_branch_unlikely(&sched_asym_cpucapacity)) {
> >> +               /*
> >> +                * It's not gonna help if stacking non-idle tasks on one
> >> +                * cpu while leaving some idle.
> >> +                */
> >> +               if (cfs_rq_busy(env->src_rq) && !need_pull_cfs_task(env->dst_rq))
> >> +                       return 0;
> >
> > These checks don't involve the task at all, so this kind of check
> > should be pushed into the more general load balance function. But, I'm
> > not totally clear on the motivation here. If we have cpu A with 1
> > non-idle task and 100 idle tasks, and cpu B with 1 non-idle task, we
> > should definitely try to load balance some of the idle tasks from A to
> > B. idle tasks _do_ get time to run (although little), and this can add
> > up and cause antagonism to the non-idle task if there are a lot of
> > idle threads.
>
> CPU_SCHED_IDLE means triggered by sched_idle_balance() in which pulls
> a non-idle task for the unoccupied cpu from the overloaded ones, so
> idle tasks are not the target and should be skipped.
>
> The second part is: if we have cpu A with 1 non-idle task and 100 idle
> tasks, and B with >=1 non-idle task, we don't migrate the last non-idle
> task on A to B.

It could be possible that we do want to migrate the last non-idle task
from A to B, if the weight sum of idle tasks on A is very high (easily
possible with affinity restrictions). So I think we should leave
regular load balance alone here if it really wants to move the
non-idle task, and wrap this entire block in an if (env->idle ==
CPU_SCHED_IDLE).

Thanks,
Josh
