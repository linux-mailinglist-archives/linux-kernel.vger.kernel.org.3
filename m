Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71BBC4F14DC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 14:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345282AbiDDMcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 08:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345159AbiDDMcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 08:32:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4320725285;
        Mon,  4 Apr 2022 05:30:02 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5CEDE210FD;
        Mon,  4 Apr 2022 12:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649075400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5dxs/pcLdXVxeVJIQ9J2D1RRV7VKB03Pri2wjxQxkWM=;
        b=lqtei1y56bozHx6RUQbYqp2K2A7ftAXKmlCZ9e+v0g0SgL9cP7EAMhkpt1OmwdUQ8K/FcZ
        2yxYu6iHiH4hQ9VxGX3qGwd7+U7i0ZMZ7FrqBYl8ksOdylX32wqqr5hlPsTJKJVytO8PFT
        K1Ms4xnqI4b/aexn+8LnahmkZZRbyEY=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7DFA0A3B87;
        Mon,  4 Apr 2022 12:29:59 +0000 (UTC)
Date:   Mon, 4 Apr 2022 14:29:59 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        Ke Wang <ke.wang@unisoc.com>
Subject: Re: [RFC PATCH] cgroup: introduce dynamic protection for memcg
Message-ID: <Ykrkx4JML4c81gBV@dhcp22.suse.cz>
References: <CAGWkznHxAD0757m1i1Csw1CVRDtQddfCL08dYf12fa47=-uYYQ@mail.gmail.com>
 <YkbjNYMY8VjHoSHR@dhcp22.suse.cz>
 <CAGWkznF7cSyPU0ceYwH6zweJzf-X1bQnS6AJ2-J+WEL0u8jzng@mail.gmail.com>
 <CAJuCfpHneDZMXO_MmQDPA+igAOdAPRUChiq+zftFXGfDzPHNhQ@mail.gmail.com>
 <CAGWkznFTQCm0cusVxA_55fu2WfT-w2coVHrT=JA1D_9_2728mQ@mail.gmail.com>
 <YkqxpEW4m6iU3zMq@dhcp22.suse.cz>
 <CAGWkznG4L3w=9bpZp8TjyWHmqFyZQk-3m4xCZ96zhHCLPawBgQ@mail.gmail.com>
 <CAGWkznGMRohE2_at4Qh8KbwSqNmNqOAG2N1EM+7uE9wKqzRm0A@mail.gmail.com>
 <Ykq7KUleuAg5QnNU@dhcp22.suse.cz>
 <CAGWkznGbd5TOTHZE8uUhak3SnHqEWx_9QCJVtUFUSg9rk3xYEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznGbd5TOTHZE8uUhak3SnHqEWx_9QCJVtUFUSg9rk3xYEQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 04-04-22 19:23:03, Zhaoyang Huang wrote:
> On Mon, Apr 4, 2022 at 5:32 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Mon 04-04-22 17:23:43, Zhaoyang Huang wrote:
> > > On Mon, Apr 4, 2022 at 5:07 PM Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
> > > >
> > > > On Mon, Apr 4, 2022 at 4:51 PM Michal Hocko <mhocko@suse.com> wrote:
> > > > >
> > > > > On Mon 04-04-22 10:33:58, Zhaoyang Huang wrote:
> > > > > [...]
> > > > > > > One thing that I don't understand in this approach is: why memory.low
> > > > > > > should depend on the system's memory pressure. It seems you want to
> > > > > > > allow a process to allocate more when memory pressure is high. That is
> > > > > > > very counter-intuitive to me. Could you please explain the underlying
> > > > > > > logic of why this is the right thing to do, without going into
> > > > > > > technical details?
> > > > > > What I want to achieve is make memory.low be positive correlation with
> > > > > > timing and negative to memory pressure, which means the protected
> > > > > > memcg should lower its protection(via lower memcg.low) for helping
> > > > > > system's memory pressure when it's high.
> > > > >
> > > > > I have to say this is still very confusing to me. The low limit is a
> > > > > protection against external (e.g. global) memory pressure. Decreasing
> > > > > the protection based on the external pressure sounds like it goes right
> > > > > against the purpose of the knob. I can see reasons to update protection
> > > > > based on refaults or other metrics from the userspace but I still do not
> > > > > see how this is a good auto-magic tuning done by the kernel.
> > > > >
> > > > > > The concept behind is memcg's
> > > > > > fault back of dropped memory is less important than system's latency
> > > > > > on high memory pressure.
> > > > >
> > > > > Can you give some specific examples?
> > > > For both of the above two comments, please refer to the latest test
> > > > result in Patchv2 I have sent. I prefer to name my change as focus
> > > > transfer under pressure as protected memcg is the focus when system's
> > > > memory pressure is low which will reclaim from root, this is not
> > > > against current design. However, when global memory pressure is high,
> > > > then the focus has to be changed to the whole system, because it
> > > > doesn't make sense to let the protected memcg out of everybody, it
> > > > can't
> > > > do anything when the system is trapped in the kernel with reclaiming work.
> > > Does it make more sense if I describe the change as memcg will be
> > > protect long as system pressure is under the threshold(partially
> > > coherent with current design) and will sacrifice the memcg if pressure
> > > is over the threshold(added change)
> >
> > No, not really. For one it is still really unclear why there should be any
> > difference in the semantic between global and external memory pressure
> > in general. The low limit is always a protection from the external
> > pressure. And what should be the actual threshold? Amount of the reclaim
> > performed, effectivness of the reclaim or what?
> Please find bellowing for the test result, which shows current design
> has more effective protection when system memory pressure is high. It
> could be argued that the protected memcg lost the protection as its
> usage dropped too much.

Yes, this is exactly how I do see it. The memory low/min is a
clear decision of the administrator to protect the memory consumption of
the said memcg (or hierarchy) from external memory pressure.

> I would like to say that this is just the goal
> of the change. Is it reasonable to let the whole system be trapped in
> memory pressure while the memcg holds the memory?

I would argue that this is expected and reasonable indeed. You cannot
provide a protection withtout pushing the pressure to others. The memory
is a finite resource.

> With regard to
> threshold, it is a dynamic decayed watermark value which represents
> the historic(watermark) and present(update to new usage if it expands
> again) usage. Actually, I have update the code by adding opt-in code
> which means this is a opt type of the memcg. This patch is coherent to
> the original design if user want to set the fixed value by default and
> also provide a new way of dynamic protected memcg without external
> monitor and interactivation.

The more I read here to more I am convinced that hooking into low/min
limits is simply wrong. If you want to achieve a more "clever" way to
balance memory reclaim among existing memcgs then fine but trying to
achieve that by dynamically interpreting low limits is just an abuse of
an existing interface IMO. What has led you to (ab)use low limit in the
first place?

> We simply test above change by comparing it with current design on a v5.4 based
> system in 3GB RAM in bellowing steps, via which we can find that fixed
> memory.low have the system experience high memory pressure with holding too
> much memory.
> 
> 1. setting up the topology seperatly as [1]
> 2. place a memory cost process into B and have it consume 1GB memory
> from userspace.
> 3. generating global memory pressure via mlock 1GB memory.
> 4. watching B's memory.current and PSI_MEM.
> 5. repeat 3,4 twice.

This is effectively an OOM test, isn't it? Memory low protection will
be enforced as long as there is something reclaimable but your memory
pressure is unreclaimable due to mlock so it has a stronger guarantee
than low limit so the protected memcg is going to be reclaimed.

Maybe I am just not following but this makes less and less sense as I am
reading through. So either I am missing something really significant or
we are just not on the same page.
-- 
Michal Hocko
SUSE Labs
