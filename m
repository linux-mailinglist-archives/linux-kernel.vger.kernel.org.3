Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBFB546896
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 16:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348497AbiFJOmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 10:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiFJOmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 10:42:19 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313FE3B4EF6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 07:42:18 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id w2so47338169ybi.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 07:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E2+18wsRQKBqACgyEiy7YR4UKEf+NL8qKOG7yjXEJbs=;
        b=o1aHQ+SxzEci93Bf30u5GX3LcHCOHczIl6or1LgYx3BikufnMalpsCAITxudivmoYR
         3LaC0fVsq7pifzUMSsnQ2ItcO/DhG+cZN3l4w0re5GeEg7foTgL+DqoJ/x+z7jfb/QAN
         MMXPegeit2b53KYAltBDD4G9k987aFUnmeQnniXMcneKSqHOSuZDX4zgYxkp1Sw9E0bp
         soYw+txPFWEgyto75uPA8pfR5YGAGCRE84F0+nCzcgGgYTKCSR6wdV8+vbwiuHx6pS11
         uyZzLgWO3TIlL3c2WhtmlPvSu5z8qQTjtDOFO5O8t/EZ/5KL1DAGTi0PtC9n2jh+H3N3
         uvsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E2+18wsRQKBqACgyEiy7YR4UKEf+NL8qKOG7yjXEJbs=;
        b=l+UWiS8A5cHB7G/YasCmc1Yjq3qWqWKE/81ODh+9SPJPxnJIwc2pRPXbaLUo+Gkkx2
         +FYiutSKvhAWiz+zUYIPkQ2iCOzfzxiv83OFKRwzVbKn6OArhM4fdGWJ0xApQ+ouI7wm
         ziSg23DhKozGWoPykA9snDL7cY7qxr6RRfKIsOyhoA/UTZ2BYuLZfs0MeGLr3Aopx9NI
         WX04H+Mfe3ihFI560JtC7+v60MscLZdKECj9lOZXv3sL5IqB7FnL4o8Es43P0XHwZQl+
         ZSeNQpk9IZ/QMCS5LkRLoKx4XA7vAyrqjJcoLUGOUgIWmNbbBqIyZ6jdkapXvvRJhVlE
         r3bw==
X-Gm-Message-State: AOAM531jqrYtX1U4wOdpHk7i84dPubkpa+4rjo/bWXU/tDps2RE40p/V
        vEXauDW1es8WReY7M1IG66Pg/xp1qSsyzr588IvJ4Q==
X-Google-Smtp-Source: ABdhPJzluUVtpyV8DUxo87pS27ish5N040MnXdRz+KjoyeGNY9YeDd7NTEFkG6iJMnaSAYRD8kTjVvlUKADn2tT3dMk=
X-Received: by 2002:a25:6041:0:b0:663:6f4c:b3b8 with SMTP id
 u62-20020a256041000000b006636f4cb3b8mr28799842ybb.236.1654872137379; Fri, 10
 Jun 2022 07:42:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220407111222.22649-1-kprateek.nayak@amd.com>
 <YqHfdn9O81Ir1+bI@worktop.programming.kicks-ass.net> <xhsmhr13w7pp2.mognet@vschneid.remote.csb>
 <YqNR+y5I/3UeVa/g@hirez.programming.kicks-ass.net>
In-Reply-To: <YqNR+y5I/3UeVa/g@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 10 Jun 2022 16:42:05 +0200
Message-ID: <CAKfTPtBDqgpjR2tkgQ6hwYnZ2b1azMX0EKQL1cbuUVbK48MnHA@mail.gmail.com>
Subject: Re: [PATCH v7] sched/fair: Consider cpu affinity when allowing NUMA
 imbalance in find_idlest_group
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Valentin Schneider <vschneid@redhat.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        aubrey.li@linux.intel.com, efault@gmx.de, gautham.shenoy@amd.com,
        linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        mingo@kernel.org, song.bao.hua@hisilicon.com,
        srikar@linux.vnet.ibm.com, valentin.schneider@arm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jun 2022 at 16:15, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jun 10, 2022 at 11:55:37AM +0100, Valentin Schneider wrote:
> > On 09/06/22 13:54, Peter Zijlstra wrote:
> > > Now, I can (and have) fixed up the conflict, but it did make me look at
> > > this in a little more detail; and the thing I noticed is that your:
> > >
> > >   'p->nr_cpus_allowed != num_online_cpus()'
> > >
> > > test makes no sense. That's basically 'true'. The thing is,
> > > nr_cpus_allowed is initialized to NR_CPUS, and unless someone somewhere
> > > did set_cpus_allowed() on it, it'll still be NR_CPUS.
> > >
> > > Also, CPU hotplug doesn't change nr_cpus_allowed, so num_online_cpus()
> > > is just plain wrong.
> > >
> > > Now, something that might work is:
> > >
> > >   'p->nr_cpus_allowed < num_online_cpus()'
> > >
> > > And even that is no guarantee. You can construct a situation where this
> > > is still false even though you actually have a constrained set.
> > > Consider a machine with 8 CPUs. Then set the mask to: 0x55, which has 4
> > > CPUs set. Then offline the last 4 so that the online mask becomes 0x0f.
> > >
> > > Then the effective mask is 0x05, and the number we're looking for above
> > > is 2, but the suggested test would still be false, because
> > > nr_cpus_allowed would be 4, as would num_online_cpus().
> > >
> >
> > IIUC we want to pay special attention when the task isn't allowed to run on
> > all online CPUs, wouldn't the below do that?
> >
> >   !cpumask_subset(cpu_online_mask, p->cpus_ptr)
>
> At that point we might just as well do the whole cpumask_and() thing,
> no? There's not much cost difference between these two operations.

The test was there to not do the computation with cpumask_and() if the
task's affinity has not been modified so maybe it would be enough to
test (p->nr_cpus_allowed != NR_CPUS) to check if the task's affinity
has been modified and we have we do the cpumask_and()  and
cpumask_weight()

>
> > The task affinity can be a superset of the online mask, obvious case is
> > init_task's CPU_MASK_ALL, and the above test is still false if both masks
> > are equal.
> >
> > (Additionnaly we could add a step in sched_init() to "properly" initialize
> > the init_task mask and remove the NR_CPUS faff).
>
> I'm confused, NR_CPUS is the right value for CPU_MASK_ALL.
