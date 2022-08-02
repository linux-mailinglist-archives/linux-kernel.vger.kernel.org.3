Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F2F58802D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 18:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237263AbiHBQXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 12:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237198AbiHBQXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 12:23:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B1CF1CFE2
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 09:23:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8B141480;
        Tue,  2 Aug 2022 09:23:01 -0700 (PDT)
Received: from wubuntu (unknown [10.57.10.13])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2FF73F70D;
        Tue,  2 Aug 2022 09:22:59 -0700 (PDT)
Date:   Tue, 2 Aug 2022 17:22:57 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, Wei Wang <wvw@google.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hank <han.lin@mediatek.com>
Subject: Re: [PATCH 1/7] sched/uclamp: Fix relationship between uclamp and
 migration margin
Message-ID: <20220802162257.chvokc2kjyvvhitb@wubuntu>
References: <20220629194632.1117723-1-qais.yousef@arm.com>
 <20220629194632.1117723-2-qais.yousef@arm.com>
 <CAB8ipk-PzwsfTzJtfrq6vJJdDNHsnGKrHjFR+527SoxBNQy0YA@mail.gmail.com>
 <20220721102417.cf6ukxpvkh4grjeh@wubuntu>
 <CAB8ipk98A5XOSXMwmJGugi-9R=TkVNGcvZA3ky_iem_Mg5COOw@mail.gmail.com>
 <20220727162531.466btzfk7lfibf6u@wubuntu>
 <CAB8ipk8+pfFmHJxuGks1tOVCit3UMk4AevKhORAwAOY7whrk0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAB8ipk8+pfFmHJxuGks1tOVCit3UMk4AevKhORAwAOY7whrk0A@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xuewen

On 08/01/22 10:46, Xuewen Yan wrote:
> Hi Qais
> 
> On Thu, Jul 28, 2022 at 12:25 AM Qais Yousef <qais.yousef@arm.com> wrote:

[...]

> > I do have a patch to add kernel doc to better explain what uclamp is. Hopefully
> > I'll send this out soon. I've been sleeping on it for a long while but too many
> > things to do, too little time :-)
> Ah, Could this patch loop me in the future? I want to learn more from
> you, Thanks!

Will do! I'll be going on holidays soon, so hopefully once I'm back I'll be
able to post it.

[...]

> > > I agree with you, but I'm still a bit concerned that such a setup will
> > > cause performance issues.
> > > As you say, may one want the background tasks running on the little
> > > cpus, he can use cpuset to control them completely.
> >
> > We are actually hoping that we can enable using uclamp_max as weak affinity
> > instead of the aggressive cpusets. But there's still a bit more work to do
> > before we can get there.
> >
> > > When there are many processes in the system, if such processes always
> > > fit small cores, do we need to consider more when load balancing?
> >
> > Oh, you're worried about packing these tasks on small cores?
> >
> > We've looked at that, and this should be hard to happen.
> >
> > EAS will always distribute tasks on max_spare_capacity cpu in the performance
> > domain. Only exception I'm aware of is if a lot of tasks wake up at the same
> > time. Then there's a chance (race) they all see the same max_spare capacity
> > before any of these tasks gets enqueue to adjust the rq->util_avg.
> >
> > Packing can't happen outside of EAS AFAICT. The default behavior of the
> > scheduler is to distribute tasks on idle cpus or based on load.
> >
> > If we're in overutilized, then select_idle_capacity() should consider the idle
> > cpus only. And in load balance in general should distribute tasks based on
> > idle/load.
> 
> Yes, you're right, I'm thinking a little bit less...Thanks!

It's complicated inter-relationship. Glad you asked! :-)


Thanks!

--
Qais Yousef
