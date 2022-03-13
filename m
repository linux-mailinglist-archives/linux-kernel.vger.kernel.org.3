Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C814D73E8
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 10:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbiCMJDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 05:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbiCMJDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 05:03:44 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BE8BBE34
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 01:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=nnIwhci8XuuNrQx/+8PCV7USY7XxobulnmlQDzHN2IQ=; b=KAIa3WJgXPh2/MlA00OJCcAr5+
        R8OSxKAtAu5bmfdEiRQ0z1/2bFwMJtrofExPuQgxSHvHfwG7wX1i+eO0za9Z67PNg+LOrmDkyCJkT
        WzbSXELw47fbZcUmtJvNCFNJNzyCKp+S6eysvNEqhUXau3t3KYJcFoklVtVanqB34xdci5lcY0Z/M
        6g3ckYNTUh2/fcUeDzYKnAOElXS6+U0zXmi+jp35NbHAK8Vx5UTcQYZcrfJJQctc94DNQ4NTL/T6m
        rp0oPDOXQEguEinHsRx0T7kl5CRcugqvHHCl9bIcsmuoZyfzLqHF1fFJyrnup0nBC9RE6Et/fiOeE
        SD/UvGsA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nTK7K-000TXJ-IO; Sun, 13 Mar 2022 09:02:22 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 72B33987D0D; Sun, 13 Mar 2022 10:02:22 +0100 (CET)
Date:   Sun, 13 Mar 2022 10:02:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     chenying <chenying.kernel@bytedance.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bristot@redhat.com,
        bsegall@google.com, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, zhouchengming@bytedance.com,
        songmuchun@bytedance.com, zhengqi.arch@bytedance.com,
        zhoufeng.zf@bytedance.com, ligang.bdlg@bytedance.com
Subject: Re: [External] Re: Subject: [PATCH] sched/fair: prioritize normal
 task over sched_idle task with vruntime offset
Message-ID: <20220313090222.GL28057@worktop.programming.kicks-ass.net>
References: <f87a8c0d-527d-a9bc-9653-ff955e0e95b4@bytedance.com>
 <20220312120309.GB6235@worktop.programming.kicks-ass.net>
 <a528d7bf-a634-00b6-42ab-dcb516567c34@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a528d7bf-a634-00b6-42ab-dcb516567c34@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 13, 2022 at 01:37:37PM +0800, chenying wrote:
> 在 2022/3/12 20:03, Peter Zijlstra 写道:
> > On Fri, Mar 11, 2022 at 03:58:47PM +0800, chenying wrote:
> > > We add a time offset to the se->vruntime when the idle sched_entity
> > > is enqueued, so that the idle entity will always be on the right of
> > > the non-idle in the runqueue. This can allow non-idle tasks to be
> > > selected and run before the idle.
> > > 
> > > A use-case is that sched_idle for background tasks and non-idle
> > > for foreground. The foreground tasks are latency sensitive and do
> > > not want to be disturbed by the background. It is well known that
> > > the idle tasks can be preempted by the non-idle tasks when waking up,
> > > but will not distinguish between idle and non-idle when pick the next
> > > entity. This may cause background tasks to disturb the foreground.
> > > 
> > > Test results as below:
> > > 
> > > ~$ ./loop.sh &
> > > [1] 764
> > > ~$ chrt -i 0 ./loop.sh &
> > > [2] 765
> > > ~$ taskset -p 04 764
> > > ~$ taskset -p 04 765
> > > 
> > > ~$ top -p 764 -p 765
> > > top - 13:10:01 up 1 min,  2 users,  load average: 1.30, 0.38, 0.13
> > > Tasks:   2 total,   2 running,   0 sleeping,   0 stopped,   0 zombie
> > > %Cpu(s): 12.5 us,  0.0 sy,  0.0 ni, 87.4 id,  0.0 wa,  0.0 hi, 0.0 si,  0.0
> > > st
> > > KiB Mem : 16393492 total, 16142256 free,   111028 used,   140208 buff/cache
> > > KiB Swap:   385836 total,   385836 free,        0 used. 16037992 avail Mem
> > > 
> > >    PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM TIME+ COMMAND
> > >    764 chenyin+  20   0   12888   1144   1004 R 100.0  0.0 1:05.12 loop.sh
> > >    765 chenyin+  20   0   12888   1224   1080 R   0.0  0.0 0:16.21 loop.sh
> > > 
> > > The non-idle process (764) can run at 100% and without being disturbed by
> > > the idle process (765).
> > 
> > Did you just do a very complicated true idle time scheduler, with all
> > the problems that brings?
> 
> When colocating CPU-intensive jobs with latency-sensitive services can
> improve CPU utilization but it is difficult to meet the stringent
> tail-latency requirements of latency-sensitive services. We use a true idle
> time scheduler for CPU-intensive jobs to minimize the impact on
> latency-sensitive services.

Hard NAK on any true idle-time scheduler until you make the whole kernel
immune to lock holder starvation issues.

And as said; this is a terrible way to do a true idle-time scheduler.
