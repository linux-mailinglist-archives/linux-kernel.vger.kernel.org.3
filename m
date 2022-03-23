Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671EE4E5548
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 16:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245182AbiCWPeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 11:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237226AbiCWPeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 11:34:24 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B023B7521D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 08:32:53 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id q14so2326556ljc.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 08:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3H7kYTWGOKByBeRGhg0g6QqaJCC+13o4cUWhxE7gY6s=;
        b=s7+/vkHvY+LtL+FymJbJ86/XfUCJIy0KGLBM1hHJkCDoRmzpAIM7DKNQCR17XQvmKH
         oSNua5dCAS9I+sKyNB/FQbDZMZNiYby5Ty7Qs8LCtLL8USuUj349ajwT15sbsUH8/txb
         RvPgGt6O4BkZ8WqfB9zTaWLQZJR2N3SSVqgBWiHpFBz9H9jKIAfq/W8nSf42ytIncqqc
         o/ousIFsqBmJ/RDje662Ca8TNlr4YrSw3wQ+nOYmwMClokV7WTt65rB+2b6XbNrXjzuT
         9uRV8ir3qkMb0fBjU8ZgNUO6fFNl14e0kMN5qJNLtbPCdGCXh7H3xQIO0t7XJWgK2Cc7
         alAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3H7kYTWGOKByBeRGhg0g6QqaJCC+13o4cUWhxE7gY6s=;
        b=dSDago4ZxLU+wv3UUrPz9kshBQLIskxsE4TwbxyvkqJ8Hu0CWpSCNpRuMhQzuD0Whg
         l0QyFtW+8ZJCEFncHOj78Xvrvfz3JaFccvRUCcRy/3pCmE9dqj6/UHGUXwnXjRpAavtY
         B3SNzH4330SsmAE0hs9vPEHfGo3eryLqefa3i0/13VutZkltKAE8OqiwNvbVRqRGnibj
         6UuCgsOwhIeVOSpwx4r2LpfVk7bwpeYsAYdgHmEH6Xl0xMe9P/qthL2EE6VoO9Qek9Ry
         7xzHKldpDLdRklof7f89WvHDpDphzO3y2nefGGpa01CQsA5kGzICL45hCFFat2H/0Bk9
         iZng==
X-Gm-Message-State: AOAM532FnGfkkHRmrlCPRRBaRVG18io6ANywcHZNWIKKwSHcS3jOTAJ0
        P1ZIVS+Poskr+E1TI1CFIUnRAVXSQ1yqjBF/sTFfbQ==
X-Google-Smtp-Source: ABdhPJxkFDr9m8hd8IWdikO+ZStXqoXOY/H5zi8SJNuDApN++uCqA2whsw6zKnXVjWP1uDkkwDco4Zpk7zbp+GXKwwg=
X-Received: by 2002:a2e:a78f:0:b0:249:a0c4:7584 with SMTP id
 c15-20020a2ea78f000000b00249a0c47584mr439169ljf.494.1648049571951; Wed, 23
 Mar 2022 08:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220311161406.23497-1-vincent.guittot@linaro.org> <20220322163911.3jge4unswuap3pjh@wubuntu>
In-Reply-To: <20220322163911.3jge4unswuap3pjh@wubuntu>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 23 Mar 2022 16:32:40 +0100
Message-ID: <CAKfTPtBYuEt=JuLLKFVJfzq_rNRoKPYfAnq7a2Jw=fBKMj6a3g@mail.gmail.com>
Subject: Re: [PATCH 0/6] Add latency_nice priority
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        chris.hyser@oracle.com, pkondeti@codeaurora.org,
        Valentin.Schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, dhaval.giani@oracle.com, qperret@google.com,
        tim.c.chen@linux.intel.com
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

On Tue, 22 Mar 2022 at 17:39, Qais Yousef <qais.yousef@arm.com> wrote:
>
> Hi Vincent
>
> Thanks for reviving this patchset!
>
> On 03/11/22 17:14, Vincent Guittot wrote:
> > This patchset restarts the work about adding a latency nice priority to
> > describe the latency tolerance of cfs tasks.
> >
> > The patches [1-4] have been done by Parth:
> > https://lore.kernel.org/lkml/20200228090755.22829-1-parth@linux.ibm.com/
> >
> > I have just rebased and moved the set of latency priority outside the
> > priority update. I have removed the reviewed tag because the patches
> > are 2 years old.
>
> AFAIR the blocking issue we had then is on agreement on the interface. Has this
> been resolved now? I didn't see any further discussion since then.

I think that there was an agreement about using a latency nice
priority in the range [-20:19] with -20 meaning sensitive to latency
whereas 19 means that task doesn't care about scheduling latency.  The
open point was about how to use this input in the scheduler with some
behavior being opposed.

>
> >
> > The patches [5-6] use latency nice priority to decide if a cfs task can
> > preempt the current running task. Patch 5 gives some tests results with
> > cyclictests and hackbench to highlight the benefit of latency nice
> > priority for short interactive task or long intensive tasks.
>
> This is a new use case AFAICT. For Android, we want to do something in EAS path

I don't think it's new, it's about being able to run some tasks in
priority as long as they haven't use all their cpu bandwidth. ANd this
has the main advantage of not being impact by finding an idle cpu. If
the task is latency sensitive, it will run 1st on the cpu being idle
or not.

> to skip feec() and revert to select_idle_capacity() (prefer_idle). I think
> Oracle's use case was control the search depth in the LB.
>
> I am not keen on this new use case. It looks awefully similar to how nice
> works. And if I tweak nice values I can certainly achieve similar effects
> without this new addition:

nice is about the cpu bandwidth allocated to a task and not about
scheduling task priori to another one. If you provide all cpu
bandwidth to a task, it will most probably have low latency because
others will always have consumed all their time slice.

>
>
>         --::((TESTING NICE 0))::--
>
>           hackbench -l $((2560 / $group)) -g $group
>
>                count     mean       std    min  ...     90%      95%      99%    max
>         group                                   ...
>         1       20.0  0.69315  0.119378  0.545  ...  0.8309  0.84725  0.97265  1.004
>         4       20.0  0.54650  0.063123  0.434  ...  0.6363  0.64840  0.65448  0.656
>         8       20.0  0.51025  0.042268  0.441  ...  0.5725  0.57830  0.59806  0.603
>         16      20.0  0.54545  0.031041  0.483  ...  0.5824  0.58655  0.59491  0.597
>
>           hackbench -p -l $((2560 / $group)) -g $group
>
>                count     mean       std    min  ...     90%     95%      99%    max
>         group                                   ...
>         1       20.0  0.48135  0.036292  0.430  ...  0.5300  0.5481  0.54962  0.550
>         4       20.0  0.42925  0.050890  0.339  ...  0.4838  0.5094  0.51548  0.517
>         8       20.0  0.33655  0.049839  0.269  ...  0.4002  0.4295  0.43710  0.439
>         16      20.0  0.31775  0.031001  0.280  ...  0.3530  0.3639  0.39278  0.400
>
>           hackbench -l 10000 -g 16 &
>           cyclictest --policy other -D 5 -q -H 20000 --histfile data.txt
>
>         # Min Latencies: 00005
>         # Avg Latencies: 00342
>         # Max Latencies: 23562
>
>
>         --::((TESTING NICE -20))::--
>
>           hackbench -l $((2560 / $group)) -g $group
>
>                count     mean       std    min  ...     90%     95%      99%    max
>         group                                   ...
>         1       20.0  0.76990  0.126582  0.585  ...  0.9169  0.9316  1.03192  1.057
>         4       20.0  0.67715  0.105558  0.505  ...  0.8202  0.8581  0.85962  0.860
>         8       20.0  0.75715  0.061286  0.631  ...  0.8276  0.8425  0.85010  0.852
>         16      20.0  0.72085  0.089566  0.578  ...  0.8493  0.8818  0.92436  0.935
>
>           hackbench -p -l $((2560 / $group)) -g $group
>
>                count     mean       std    min  ...     90%      95%      99%    max
>         group                                   ...
>         1       20.0  0.50245  0.055636  0.388  ...  0.5839  0.60185  0.61477  0.618
>         4       20.0  0.56280  0.139277  0.354  ...  0.7280  0.75075  0.82295  0.841
>         8       20.0  0.58005  0.091819  0.412  ...  0.6969  0.71400  0.71400  0.714
>         16      20.0  0.52110  0.081465  0.323  ...  0.6169  0.63685  0.68017  0.691
>
>           hackbench -l 10000 -g 16 &
>           cyclictest --policy other -D 5 -q -H 20000 --histfile data.txt
>
>         # Min Latencies: 00007
>         # Avg Latencies: 00081
>         # Max Latencies: 20560
>
>
>         --::((TESTING NICE 19))::--
>
>           hackbench -l $((2560 / $group)) -g $group
>
>                count     mean       std    min  ...     90%      95%      99%    max
>         group                                   ...
>         1       20.0  0.46560  0.013694  0.448  ...  0.4782  0.49805  0.49881  0.499
>         4       20.0  0.43705  0.014979  0.414  ...  0.4550  0.45540  0.46148  0.463
>         8       20.0  0.45800  0.013471  0.436  ...  0.4754  0.47925  0.48305  0.484
>         16      20.0  0.53025  0.007239  0.522  ...  0.5391  0.54040  0.54648  0.548
>
>           hackbench -p -l $((2560 / $group)) -g $group
>
>                count     mean       std    min  ...     90%      95%      99%    max
>         group                                   ...
>         1       20.0  0.27480  0.013725  0.247  ...  0.2892  0.29125  0.29505  0.296
>         4       20.0  0.25095  0.011637  0.234  ...  0.2700  0.27010  0.27162  0.272
>         8       20.0  0.25250  0.010097  0.240  ...  0.2632  0.27415  0.27643  0.277
>         16      20.0  0.26700  0.007595  0.257  ...  0.2751  0.27645  0.28329  0.285
>
>           hackbench -l 10000 -g 16 &
>           cyclictest --policy other -D 5 -q -H 20000 --histfile data.txt
>
>         # Min Latencies: 00058
>         # Avg Latencies: 77232
>         # Max Latencies: 696375
>
> For hackbench, the relationship seems to be inversed. Better nice value
> produces worse result. But for the cycletest, the avg goes down considerably
> similar to your results.
>
> Aren't we just manipulating the same thing with your new proposal or did
> I miss something? Can we impact preemption in isolation without having any
> impact on bandwidth?
>
> I am worried about how userspace can reason about the expected outcome when
> nice and latency_nice are combined together.
>
>
> Thanks
>
> --
> Qais Yousef
