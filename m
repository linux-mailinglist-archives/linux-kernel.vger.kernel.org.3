Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7FE50ED1C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 02:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237023AbiDZAGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 20:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233872AbiDZAGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 20:06:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7889C107723
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 17:03:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A801B81A2F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:03:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2EFBC385A4;
        Tue, 26 Apr 2022 00:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650931409;
        bh=4DGNRQMwZS5moIWZt8jrpX+2iyLoadcvdjza5BBk2LA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=eqAtPC6q5+ar4x9PPOmHzKWXDrvJi0Z0xoctzuLgKw52lYIsjo2eldHjyU5Ew1Ge7
         wn+LLWJ1xG3wT5zock1LNou6wu7GhXU2VliVQbTtRtZ4eU2Eve053fRobsfnyDBCa/
         q2yKptp7nRcefMslq9bW9yQGsw20uirBkVcHM/b59L0F8HyvRoUW5p10a69+49htgv
         UYZ1SKtiVnWz9yuO2SvCeYbTiPtAfLUm/FvHyVX0wtLbVaE/t4MK+YRr0RXsUv0Xgs
         TGKqETAEg2prGTsqHNyYIZkUsnvU+/BibxNsajJQzEYZeKu62K9aJ1bMxHvnv5F6xS
         lvTjh4GQRreMQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 908425C042D; Mon, 25 Apr 2022 17:03:28 -0700 (PDT)
Date:   Mon, 25 Apr 2022 17:03:28 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Subject: Re: "Dying CPU not properly vacated" splat
Message-ID: <20220426000328.GY4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220421193821.GA173010@paulmck-ThinkPad-P17-Gen-1>
 <xhsmh4k2h9m26.mognet@vschneid.remote.csb>
 <20220425173320.GX4285@paulmck-ThinkPad-P17-Gen-1>
 <xhsmh1qxkakof.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmh1qxkakof.mognet@vschneid.remote.csb>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 10:59:44PM +0100, Valentin Schneider wrote:
> On 25/04/22 10:33, Paul E. McKenney wrote:
> > On Mon, Apr 25, 2022 at 05:15:13PM +0100, Valentin Schneider wrote:
> >>
> >> Hi Paul,
> >>
> >> On 21/04/22 12:38, Paul E. McKenney wrote:
> >> > Hello!
> >> >
> >> > The rcutorture TREE03 scenario got the following splat, which appears
> >> > to be a one-off, or if not, having an MTBF in the thousands of hours,
> >> > even assuming that it is specific to TREE03.  (If it is not specific to
> >> > TREE03, we are talking tens of thousands of hours of rcutorture runtime.)
> >> >
> >> > So just in case this rings any bells or there are some diagnostics I
> >> > should add in case this ever happens again.  ;-)
> >>
> >> There should be a dump of the enqueued tasks right after the snippet you've
> >> sent, any chance you could share that if it's there? That should tell us
> >> which tasks are potentially misbehaving.
> >
> > And now that I know to look for them, there they are!  Thank you!!!
> >
> > CPU7 enqueued tasks (2 total):
> >  pid: 52, name: migration/7
> >  pid: 135, name: rcu_torture_rea
> > smpboot: CPU 7 is now offline
> >
> > So what did rcu_torture_reader() do wrong here?  ;-)
> >
> 
> So on teardown, CPUHP_AP_SCHED_WAIT_EMPTY->sched_cpu_wait_empty() waits for
> the rq to be empty. Tasks must *not* be enqueued onto that CPU after that
> step has been run - if there are per-CPU tasks bound to that CPU, they must
> be unbound in their respective hotplug callback.
> 
> For instance for workqueue.c, we have workqueue_offline_cpu() as a hotplug
> callback which invokes unbind_workers(cpu), the interesting bit being:
> 
>                 for_each_pool_worker(worker, pool) {
>                         kthread_set_per_cpu(worker->task, -1);
>                         WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);
>                 }
> 
> The rcu_torture_reader() kthreads aren't bound to any particular CPU are
> they? I can't find any code that would indicate they are - and in that case
> it means we have a problem with is_cpu_allowed() or related.

I did not intend that the rcu_torture_reader() kthreads be bound, and
I am not seeing anything that binds them.

Thoughts?  (Other than that validating any alleged fix will be quite
"interesting".)

							Thanx, Paul
