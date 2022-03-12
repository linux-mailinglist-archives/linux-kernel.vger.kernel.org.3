Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD514D70E7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 21:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbiCLUn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 15:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbiCLUn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 15:43:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA21337A9D
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 12:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647117740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=REpxEeemSRqUF4Ar9nlyx7YsY9wHYSjV79+IzjyLYl8=;
        b=bnyNdZZboTReae7Ts/Q9S702gQL3GehdrzpGQgsiCP+yMKAy85uENdWx3hZVs9w1WII0Ut
        tmvpWgSePFFfd2ZeXjW+jpVMqCDlu7cwBUul+OIaP2h5RKGpyXKQ3EFtKqdSyWNTZSQcwu
        HKWPXSi1ISaxKU/vtuxEEaTXKMV2IVI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588-Za7StQTaMx6OPw_D7go6zw-1; Sat, 12 Mar 2022 15:42:17 -0500
X-MC-Unique: Za7StQTaMx6OPw_D7go6zw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DF742800B21;
        Sat, 12 Mar 2022 20:42:16 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2EE6D202F2EB;
        Sat, 12 Mar 2022 20:41:58 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 2E883416CE5D; Sat, 12 Mar 2022 17:39:40 -0300 (-03)
Date:   Sat, 12 Mar 2022 17:39:40 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Minchan Kim <minchan@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [patch v5] mm: lru_cache_disable: replace work queue
 synchronization with synchronize_rcu
Message-ID: <Yi0FDFwVQUy50qbi@fuller.cnet>
References: <YhUI1wUtV8yguijO@fuller.cnet>
 <YhUKRzEKxMvlGQ5n@fuller.cnet>
 <YiI+a9gTr/UBCf0X@fuller.cnet>
 <20220304163554.8872fe5d5a9d634f7a2884f5@linux-foundation.org>
 <Yin7hDxdt0s/x+fp@fuller.cnet>
 <20220310182326.5b375da6b86e95f7e71acd90@linux-foundation.org>
 <YisJ5SLBijAbcwHD@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YisJ5SLBijAbcwHD@linutronix.de>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 09:35:49AM +0100, Sebastian Andrzej Siewior wrote:
> + sched division
> 
> On 2022-03-10 18:23:26 [-0800], Andrew Morton wrote:
> > On Thu, 10 Mar 2022 10:22:12 -0300 Marcelo Tosatti <mtosatti@redhat.com> wrote:
> > > On systems that run FIFO:1 applications that busy loop,
> > > any SCHED_OTHER task that attempts to execute
> > > on such a CPU (such as work threads) will not
> > > be scheduled, which leads to system hangs.
> …
> > 
> > Permitting a realtime thread to hang the entire system warrants a
> > -stable backport, I think.  That's just rude.
> 
> I'm not sure if someone is not willingly breaking the system. Based on
> my experience, a thread with an elevated priority (that FIFO, RR or DL)
> should not hog the CPU. A normal user (!root && !CAP_SYS_NICE) can't
> increase the priority of the task.
> To avoid a system hangup there is sched_rt_runtime_us which ensures that
> all RT threads are throttled once the RT class exceed a certain amount
> of runtime. This has been relaxed a little on systems with more CPUs so
> that the RT runtime can be shared but this sharing (RT_RUNTIME_SHARE)
> has been disabled by default a while ago. That safe switch
> (sched_rt_runtime_us) can be disabled and is usually disabled on RT
> system since the RT tasks usually run longer especially in corner cases.

Sebastian,

Certain classes of applications appear to benefit from very low latency 
(or rather very low, to zero, task interruption length). For example,
5G RAN processing might require maximum interruption of < 10us.

IIRC the resolution of sched_rt_runtime_us being too high led to the
creation of stalld:

https://github.com/bristot/stalld

The stalld program (which stands for 'stall daemon') is a mechanism to
prevent the starvation of operating system threads in a Linux system.
The premise is to start up on a housekeeping cpu (one that is not used
for real-application purposes) and to periodically monitor the state of
each thread in the system, looking for a thread that has been on a run
queue (i.e. ready to run) for a specifed length of time without being
run. This condition is usually hit when the thread is on the same cpu
as a high-priority cpu-intensive task and therefore is being given no
opportunity to run.

When a thread is judged to be starving, stalld changes that thread to
use the SCHED_DEADLINE policy and gives the thread a small slice of time
for that cpu (specified on the command line). The thread then runs and
when that timeslice is used, the thread is then returned to its original
scheduling policy and stalld then continues to monitor thread states.

---

Configuring 10us per second for time slice of lower priority tasks 
that stalld schedules, you'd still get a higher interruption than 
10us to the "RT" high priority application.

So our impression seems to be that for such low latency requirements its
better to avoid any lower priority work at all on the isolated CPUs.

Yes, there are still cases where work queues are required to do certain
things... we have been trying to reduce such cases.

> People often isolate CPUs and have busy-loop tasks running with
> SCHED_OTHER given that there is nothing else going on there will be no
> preemption. In this case, the worker would preempt the task.
> In this scenario I _can_ understand that one wants to avoid that
> preemption and try things differently like this patch suggests. We can
> even offload RCU thread from isolated CPUs.
> But I wouldn't say this requires a backport because there is way for a
> RT thread, that claims 100% of the CPU, to break the system.

On RHEL-8 we had patches (from -RT tree) to avoid workqueues for 
flushing memory. So for RHEL-8 -> RHEL-9 the lack of the patch above
is a regression (and the usage of workqueues and not performing
the flush remotely).

But one might still see the pagevecs not being empty at
__lru_add_drain_all:

                if (pagevec_count(&per_cpu(lru_pvecs.lru_add, cpu)) ||
                    data_race(pagevec_count(&per_cpu(lru_rotate.pvec, cpu))) ||
                    pagevec_count(&per_cpu(lru_pvecs.lru_deactivate_file, cpu)) ||
                    pagevec_count(&per_cpu(lru_pvecs.lru_deactivate, cpu)) ||
                    pagevec_count(&per_cpu(lru_pvecs.lru_lazyfree, cpu)) ||
                    need_activate_page_drain(cpu) ||
                    has_bh_in_lru(cpu, NULL)) {
                        INIT_WORK(work, lru_add_drain_per_cpu);
                        queue_work_on(cpu, mm_percpu_wq, work);
                        __cpumask_set_cpu(cpu, &has_work);
                }

Which needs fixing for a complete solution.

