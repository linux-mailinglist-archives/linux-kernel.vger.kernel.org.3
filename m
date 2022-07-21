Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4424257CD11
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 16:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbiGUOOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 10:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbiGUOOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 10:14:04 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1997A558DD
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 07:14:03 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id i14so3001638yba.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 07:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pMvbL5rXnaaHRfS4CHseNqOPVLapmfnpz0FRVAY74sQ=;
        b=WDJTGzLcaU1MWFAEN7HhqpcpC5ouFJlwyCUd1FxVg1PWMaCbcPX3UqOI8SjZ1P5bW7
         7MavWF7hZqW30MqymhJpovW8BODXOOAen8JcJiLB0p0t7CxY40qtjMreb/QwRY99odMr
         aSE7kxYfk9N+qk87fJFA3ElOvs7VuMeq0eBj7HFb3E60z+19HjB4GFVJ1MZ3sBhkj1Ur
         NczHm9pCWGVA4NN1eRMgm+Ab0pSKi7HwGT9MVvcy55XqgPcjUe625j1NvgzBrsaMi2w/
         n0F/sdliAJiTVgm7VnIHsnZC+LaNn1XQTO9/JtDBNxaroSEKc4rGk00B48CJJ5wQrr9p
         iJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pMvbL5rXnaaHRfS4CHseNqOPVLapmfnpz0FRVAY74sQ=;
        b=iEATX1KgQE6JQSdynMdhnAdYsfzDw8v3uquSWu6bbZPL0E8+VAjT5QyrvYQAvkZFjy
         Y19LJ6nEovMOD0Iymhcaupj5JD2tCssf3qYay2ZeWBJw14sAoCQJfaJKugJZbusV/5FV
         Ai84VOR9RU2rfCkrxAuLcSvLahXAsPmNmRlJtuS/eJIRKchnZ8kHvIMLsAXB9E1rSJMF
         Z04TZr2Rjbkzp7dP0zFHqva9VETxBsFeeWnrkl6T87kdjrmKqC/fvTswaEp5jgIU8Y8E
         7pZZpbNdblXzUHvTRv1iecClCiQdb0qGbDqdosCoxTDeOQtz0dfYgweEgI75r9/V/IIf
         FFEw==
X-Gm-Message-State: AJIora96S8k1llDsPz3ItyTUJodXM49KGlaM5Tu8bzmGbPnSrfegNIOR
        HgJ6niZA4ZIUQK11v/t/jIw66IBW9D4Xc31DCY8QBw==
X-Google-Smtp-Source: AGRyM1uMBcNHC44oJ6Zd1hHpd+OzCl2WXis8vymmrMC38oiVvjhqfqoulFVFUe8VSS/QZ+CmzzB71LNlQOUVZ2ScLdk=
X-Received: by 2002:a25:3085:0:b0:66e:4440:f42e with SMTP id
 w127-20020a253085000000b0066e4440f42emr40440432ybw.403.1658412842097; Thu, 21
 Jul 2022 07:14:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220713040430.25778-1-zhouchengming@bytedance.com>
 <20220713040430.25778-8-zhouchengming@bytedance.com> <e838ac28-f68e-2282-94d5-616ea3bdf8d0@arm.com>
 <88062fb6-e2fe-cf4e-10b5-7694c4d30941@bytedance.com> <CAKfTPtCsd2RkOZoa10SSwKhm0NRzmOphAVNW7_JykqzxqfkSXg@mail.gmail.com>
 <107763fc-7eab-a807-fa15-024178bdf57e@bytedance.com> <CAKfTPtBo9GgkT1VeVA+1CBhiVZ8Vf+kp0XV3PWcBLGuZaz_hKQ@mail.gmail.com>
 <3cc8def4-54ef-9ca5-7da9-eaa38ad9bd4c@bytedance.com>
In-Reply-To: <3cc8def4-54ef-9ca5-7da9-eaa38ad9bd4c@bytedance.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 21 Jul 2022 16:13:50 +0200
Message-ID: <CAKfTPtCscXjUoOY2EwSwDZ=Qsx0+TPO_ejP5Fh+ds==_hetMfA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 07/10] sched/fair: use update_load_avg()
 to attach/detach entity load_avg
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org, bsegall@google.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jul 2022 at 15:56, Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> On 2022/7/20 23:34, Vincent Guittot wrote:
> > On Wed, 20 Jul 2022 at 15:41, Chengming Zhou
> > <zhouchengming@bytedance.com> wrote:
> >>
> >> On 2022/7/19 18:29, Vincent Guittot wrote:
> >>> On Fri, 15 Jul 2022 at 18:21, Chengming Zhou
> >>> <zhouchengming@bytedance.com> wrote:
> >>>>
> >
> > ...
> >
> >>>>
> >>>>>
> >>>>> Looks to me that you want to replace this by your `freeze PELT when
> >>>>> outside fair` model.
> >>>>
> >>>> Yes, want to freeze PELT for two !fair cases:
> >>>>
> >>>> 1. !fair task hasn't been fair before: will still have its init load_avg
> >>>>    when switch to fair.
> >>>
> >>> But I'm not sure it makes sense to keep these init values. As an
> >>> example, the util_avg is set according to the cpu utilization at the
> >>> time of the task creation. I would tend to decay them as these init
> >>> values become less and less relevant.
> >>>
> >>> so we should return early in post_init_entity_util_avg() and don't set
> >>> util_avg if sched class is not cfs
> >>
> >> Yes, this indeed is a problem if we attach this init sched_avg of !fair task.
> >> I'm also not sure whether it make sense to keep them to 0 ? Will it cause
> >> unfairness problem between cfs_rqs?
> >
> > Why should it cause an unfairness problem ? !fair tasks are not
> > accounted and their pelt values will be decayed down to 0 after 320ms
> > anyway (with the current implementation). So it's just like if you
> > started directly after those 320ms
>
> Thanks for your patient explain. IMHO, I am thinking if we have init sched_avg
> for new fair task (A), but have 0 for new task switched from !fair (B). Then
> what's the point of init sched_avg for the fair task?

For fair task, the util_avg is set according to cpu's util_avg at fork
time as an estimate of its coming utilization. The load_is also set to
max to ensure an min share. But these init value have a real impact on
the first 320ms. after they have just disappear from the *_avg.

For !fair task, these init value will be decayed when
swicthed_to_fair(). This means that if a !fair task stays more than
320ms in !fair class (running, runnable or sleeping) before switching
into fair class, those init pelt value will be decayed to 0.
If we keep these init value, the initial util_avg value which has been
set according to the cpu's util_avg at fork will stay at this value
which is no more relevant

>
> The B task will need some time to reach its stable load value, so in this process
> its cfs_rq may can't get enough shares? Imaging below scenario, if we have fair
> task A and switched from !fair task B at the same time, could cause unfairness
> between cfs0 and cfs1 ?
>
> CPU0   tg   CPU1
>   |  /    \  |
>   | /      \ |
> cfs0        cfs1
>  (A)         (B)
>
> If runnable_avg and util_avg are 0 when switched from !fair, so we need more time
> to do load balance or CPU frequency adjust? I think it's the reason why we have
> init sched_avg for new fair task. Should we care about these, or it will be no problem?

But the util_avg which has been set at fork time,  has been set
according to a cpu util_avg which is maybe hundreds of seconds old.

>
> I'm not sure, I must have missed something :-)
>
> Thanks!
>
> >
> >>
> >>>
> >>>>
> >>>> 2. !fair task has been switched_from_fair(): will still keep its lastest
> >>>>    load_avg when switch to fair.
> >>>>
> >>>>>
> >>>>>> This patch make update_load_avg() the only location of attach/detach,
> >>>>>> and can handle these corner cases like change cgroup of NEW tasks,
> >>>>>> by checking last_update_time before attach/detach.
> >>>>>
> >>>>> [...]
> >>>>>
> >>>>>> @@ -11527,9 +11522,7 @@ static void detach_entity_cfs_rq(struct sched_entity *se)
> >>>>>>      struct cfs_rq *cfs_rq = cfs_rq_of(se);
> >>>>>>
> >>>>>>      /* Catch up with the cfs_rq and remove our load when we leave */
> >>>>>> -    update_load_avg(cfs_rq, se, 0);
> >>>>>> -    detach_entity_load_avg(cfs_rq, se);
> >>>>>> -    update_tg_load_avg(cfs_rq);
> >>>>>> +    update_load_avg(cfs_rq, se, UPDATE_TG | DO_DETACH);
> >>>>>
> >>>>> IMHO, the DO_[DE|AT]TACH comments in update_load_avg() would have to be
> >>>>> updated in this case.
> >>>>
> >>>> Correct, will do.
> >>>>
> >>>> Thanks.
> >>>>
> >>>>>
> >>>>> [...]
