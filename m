Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985494E48E5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 23:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237490AbiCVWI3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 22 Mar 2022 18:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237461AbiCVWIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 18:08:24 -0400
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7AA6FA06;
        Tue, 22 Mar 2022 15:06:52 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id 17so25878143lji.1;
        Tue, 22 Mar 2022 15:06:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kDi0ElDfwv7raMtrGS6/o0GRWTFIadUpbRr6cdzN0hQ=;
        b=r6BZW1Nzx9SlEgkpoMs34SSB1LJE3abPQNUsG6ixdiEuzQnQMmE5J57gF3iOLcdu9j
         YZTwcfC9D5FcWRPcGDimLWnTToganm568seh/0bFUu5pY9tmeY8ywvQJOgGR+8ZSo+F+
         gRNM2yKcEvncm0xi4yk9R+HpHyuIMLnyN+U0ofF2RFbpYHnhyKBOQvuw/QvaxwJKb0db
         Iuhq7WaHZRy+i1b9Zdciqgwqcn87m2MrEFDiEECpxr6QJ+zlQOWFlsu97nLi9nt1QhCM
         b0mxIDYOKnGY5gAEfNeKn5uqyHpNU3+GznbwCX0v6qJKhltsfTLkMZvEGpeEXyG+sdme
         mN9g==
X-Gm-Message-State: AOAM5315caVL+nlqqwZpPUMPr1nNPs8GYNZO5yh/1RwyE828wRh16AuP
        7u6OPQxpl+DQhoJ0/PJYtKaIvqXKbR+Xu+RDgmxPseU5
X-Google-Smtp-Source: ABdhPJy4/yQGyC8WGywWNtwTlaGRAtK/gK8etfico+dncZPNBBr/re+Z6ySrWQQfWRnAN1N9oQa8R3kERFjUwlNIDKU=
X-Received: by 2002:a05:651c:1544:b0:249:8c80:4282 with SMTP id
 y4-20020a05651c154400b002498c804282mr5923865ljp.202.1647986811117; Tue, 22
 Mar 2022 15:06:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220322120834.98637-1-zhouchengming@bytedance.com>
 <20220322120834.98637-2-zhouchengming@bytedance.com> <YjnIKCIRV+ePJVCN@hirez.programming.kicks-ass.net>
 <b55676c3-07da-f4f1-e4c8-252cd9d4fac2@bytedance.com> <YjnjHPuNjo8YTwiQ@hirez.programming.kicks-ass.net>
 <cdfb252e-9bfc-bee3-7ebe-b8ef401c85dd@bytedance.com> <1c9f2383-ec9f-f819-d7be-23aed2bf121a@bytedance.com>
In-Reply-To: <1c9f2383-ec9f-f819-d7be-23aed2bf121a@bytedance.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 22 Mar 2022 15:06:39 -0700
Message-ID: <CAM9d7chL6r=4Ay6udSv-heyH3pAdH=Cp+2mXU2-+Z7yHt+aH7w@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 1/6] perf/core: Fix incosistency between
 cgroup sched_out and sched_in
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Mar 22, 2022 at 8:28 AM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> On 2022/3/22 11:16 下午, Chengming Zhou wrote:
> > Hi peter,
> >
> > On 2022/3/22 10:54 下午, Peter Zijlstra wrote:
> >> On Tue, Mar 22, 2022 at 09:38:21PM +0800, Chengming Zhou wrote:
> >>> On 2022/3/22 8:59 下午, Peter Zijlstra wrote:
> >>>> On Tue, Mar 22, 2022 at 08:08:29PM +0800, Chengming Zhou wrote:
> >>>>> There is a race problem that can trigger WARN_ON_ONCE(cpuctx->cgrp)
> >>>>> in perf_cgroup_switch().
> >>>>>
> >>>>> CPU1                                      CPU2
> >>>>> (in context_switch)                       (attach running task)
> >>>>> perf_cgroup_sched_out(prev, next)
> >>>>>   cgrp1 == cgrp2 is True
> >>>>>                                   next->cgroups = cgrp3
> >>>>>                                   perf_cgroup_attach()
> >>>>> perf_cgroup_sched_in(prev, next)
> >>>>>   cgrp1 == cgrp3 is False
>
> I see, you must have been misled by my wrong drawing above ;-)
> I'm sorry, perf_cgroup_attach() on the right should be put at the bottom.
>
> CPU1                                            CPU2
> (in context_switch)                             (attach running task)
> perf_cgroup_sched_out(prev, next)
>         cgrp1 == cgrp2 is True
>                                                 next->cgroups = cgrp3
> perf_cgroup_sched_in(prev, next)
>         cgrp1 == cgrp3 is False
>                                                 __perf_cgroup_move()
>

Yep, this is a real race and I saw the warnings reported sometimes.
The perf_cgroup_attach() is called after the task's cgroup is changed.

Thanks,
Namhyung
