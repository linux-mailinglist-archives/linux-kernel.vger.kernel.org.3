Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7AD34E425E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 15:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235397AbiCVO4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 10:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233916AbiCVO4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 10:56:04 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B445725EB8;
        Tue, 22 Mar 2022 07:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=IyEyyyLp7CYjq7iHJyZOebnWhuBnlbEkqJ9KJHuUjqU=; b=bvNsfba/pLCkZmmO32VNaQDO+I
        Fm5hcse+2Iyy+gymlv7KRm1RmKpFPt1hPZv0z6qeNmrq3ISp1EZCNoxTJUlPavl9f7kN4bmyMoTHV
        jMNvF+rnyxqmTRCGyyWnCV13aJwwNd9mfFMD0rWmmU0M4nLEfzUzFYNLgA9RidJHwUm7NG5dxbHIg
        mHY5rAylFZ6LsUlw+eRQ2/CEe6lN49j6Fvq3YM2PEvM3315xGG2v8qJ5UntnbRLemchthP8eeu+OR
        AOqBEBT5t69+j5swyrBn7or1hlf09intjkqvTCPXN+oGFdH+rkEVVVZ2wtF5oTJnDgLU2nVnjdWVW
        D8MkiVKg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWftv-003UL4-3X; Tue, 22 Mar 2022 14:54:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CE0D83001CD;
        Tue, 22 Mar 2022 15:54:20 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AECB0201861FD; Tue, 22 Mar 2022 15:54:20 +0100 (CET)
Date:   Tue, 22 Mar 2022 15:54:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, eranian@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com
Subject: Re: [External] Re: [PATCH v2 1/6] perf/core: Fix incosistency
 between cgroup sched_out and sched_in
Message-ID: <YjnjHPuNjo8YTwiQ@hirez.programming.kicks-ass.net>
References: <20220322120834.98637-1-zhouchengming@bytedance.com>
 <20220322120834.98637-2-zhouchengming@bytedance.com>
 <YjnIKCIRV+ePJVCN@hirez.programming.kicks-ass.net>
 <b55676c3-07da-f4f1-e4c8-252cd9d4fac2@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b55676c3-07da-f4f1-e4c8-252cd9d4fac2@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 09:38:21PM +0800, Chengming Zhou wrote:
> On 2022/3/22 8:59 下午, Peter Zijlstra wrote:
> > On Tue, Mar 22, 2022 at 08:08:29PM +0800, Chengming Zhou wrote:
> >> There is a race problem that can trigger WARN_ON_ONCE(cpuctx->cgrp)
> >> in perf_cgroup_switch().
> >>
> >> CPU1					CPU2
> >> (in context_switch)			(attach running task)
> >> perf_cgroup_sched_out(prev, next)
> >> 	cgrp1 == cgrp2 is True
> >> 					next->cgroups = cgrp3
> >> 					perf_cgroup_attach()
> >> perf_cgroup_sched_in(prev, next)
> >> 	cgrp1 == cgrp3 is False
> >>
> >> The commit a8d757ef076f ("perf events: Fix slow and broken cgroup
> >> context switch code") would save cpuctx switch out/in when the
> >> perf_cgroup of "prev" and "next" are the same.
> >>
> >> But perf_cgroup of task can change in concurrent with context_switch.
> > 
> > Can you clarify? IIRC then a task changes cgroup it goes throught the
> > whole ->attach() dance, and that serializes against the context switch
> > code.
> > 
> 
> task->cgroups changed before perf_cgroup_attach(), and is not serialized
> against the context switch, since task->cgroups can be changed without
> rq lock held. (cgroup v1 or cgroup v2 with PSI disabled)
> 
> So perf_cgroup_from_task() in perf_cgroup_switch() may see the old or
> new perf_cgroup when do context switch.

__schedule()
  local_irq_disable();				<--- IRQ disable
  rq_lock();

  ...

  context_switch()
    prepare_task_switch()
      perf_event_task_sched_out()
        __perf_event_task_sched_out()
	  perf_cgroup_sched_out();

  switch_to()
  finish_task_switch()
    perf_event_task_sched_in()
      __perf_event_task_sched_in()
        perf_cgroup_sched_in();
    finish_lock_switch()
      raw_spin_irq_unlock_irq();		<--- IRQ enable


vs

perf_event_cgrp_subsys.attach = perf_cgroup_attach()
  cgroup_taskset_for_each()
    task_function_call(task, __perf_cgroup_move) <--- sends IPI


Please explain how this can interleave.
