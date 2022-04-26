Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1CC651034A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 18:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352974AbiDZQ15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 12:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiDZQ14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 12:27:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A951869D2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:24:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E68F7B81FE5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 16:24:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 995B9C385A0;
        Tue, 26 Apr 2022 16:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650990285;
        bh=bguQYe/Z3sr/CK/WmU84OklDRkcT9+TU/F8iGf4R2Og=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=oPGD9rCssxyklaOVcRKspz5zMDUyp5jQUT7Hm4FTukRklwi8JZZ33rYRs4SnZ5IMR
         Q94IJpFWWZ52eqkkUNfPdgVg67hkvURyVrEK8E+NUB+2Jeb5M9XcwscbTJfUqIQKgG
         yoOA0YGft+Ixx/7nSUVhd2iU1egbTVFC0pk3ySNduq3vQgQBe46tyVN0E7eeMNqmLP
         vIYpkxvWZ1pZyfIluMWgWJIKrx43tIEhQU3orvcCpLgRXV5zpo2ryANWtU1XGOnB5D
         cQcNz1uDPLqxODzXcn8FRBcqRliRViWxYNWgCt2chh6Zs04LJS7BW3aSzvvaSipW0h
         0a2A98Vv+8B8g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3F13F5C0460; Tue, 26 Apr 2022 09:24:45 -0700 (PDT)
Date:   Tue, 26 Apr 2022 09:24:45 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Subject: Re: "Dying CPU not properly vacated" splat
Message-ID: <20220426162445.GG4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220421193821.GA173010@paulmck-ThinkPad-P17-Gen-1>
 <xhsmh4k2h9m26.mognet@vschneid.remote.csb>
 <20220425173320.GX4285@paulmck-ThinkPad-P17-Gen-1>
 <xhsmh1qxkakof.mognet@vschneid.remote.csb>
 <20220426000328.GY4285@paulmck-ThinkPad-P17-Gen-1>
 <xhsmhy1zr99zt.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhy1zr99zt.mognet@vschneid.remote.csb>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 03:48:06PM +0100, Valentin Schneider wrote:
> On 25/04/22 17:03, Paul E. McKenney wrote:
> > On Mon, Apr 25, 2022 at 10:59:44PM +0100, Valentin Schneider wrote:
> >> On 25/04/22 10:33, Paul E. McKenney wrote:
> >> >
> >> > So what did rcu_torture_reader() do wrong here?  ;-)
> >> >
> >>
> >> So on teardown, CPUHP_AP_SCHED_WAIT_EMPTY->sched_cpu_wait_empty() waits for
> >> the rq to be empty. Tasks must *not* be enqueued onto that CPU after that
> >> step has been run - if there are per-CPU tasks bound to that CPU, they must
> >> be unbound in their respective hotplug callback.
> >>
> >> For instance for workqueue.c, we have workqueue_offline_cpu() as a hotplug
> >> callback which invokes unbind_workers(cpu), the interesting bit being:
> >>
> >>                 for_each_pool_worker(worker, pool) {
> >>                         kthread_set_per_cpu(worker->task, -1);
> >>                         WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);
> >>                 }
> >>
> >> The rcu_torture_reader() kthreads aren't bound to any particular CPU are
> >> they? I can't find any code that would indicate they are - and in that case
> >> it means we have a problem with is_cpu_allowed() or related.
> >
> > I did not intend that the rcu_torture_reader() kthreads be bound, and
> > I am not seeing anything that binds them.
> >
> > Thoughts?  (Other than that validating any alleged fix will be quite
> > "interesting".)
> 
> IIUC the bogus scenario is is_cpu_allowed() lets one of those kthreads be
> enqueued on the outgoing CPU *after* CPUHP_AP_SCHED_WAIT_EMPTY.teardown() has
> been run, and hilarity ensues.
> 
> The cpu_dying() condition should prevent a regular kthread from getting
> enqueued there, most of the details have been evinced from my brain but I
> recall we got the ordering conditions right...
> 
> The only other "obvious" thing here is migrate_disable() which lets the
> enqueue happen, but then balance_push()->select_fallback_rq() should punt
> it away on context switch.
> 
> I need to rediscover those paths, I don't see any obvious clue right now.

Thank you for looking into this!

The only thought that came to me was to record that is_cpu_allowed()
returned true do to migration being disabled, and then use that in later
traces, printk()s or whatever.

My own favorite root-cause hypothesis was invalidated by the fact that
is_cpu_allowed() returns cpu_online(cpu) rather than just true.  ;-)

							Thanx, Paul
