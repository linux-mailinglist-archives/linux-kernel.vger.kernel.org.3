Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F6B5632DE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 13:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235458AbiGALs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 07:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbiGALsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 07:48:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EEB5479719
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 04:48:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 083A0113E;
        Fri,  1 Jul 2022 04:48:52 -0700 (PDT)
Received: from wubuntu (unknown [10.57.84.222])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 54BA13F66F;
        Fri,  1 Jul 2022 04:48:49 -0700 (PDT)
Date:   Fri, 1 Jul 2022 12:48:46 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: fix rq lock recursion issue
Message-ID: <20220701114846.42o2tkm5fqt325df@wubuntu>
References: <20220624074240.13108-1-quic_satyap@quicinc.com>
 <20220630215310.wb3kab72tlh5pq2g@airbuntu>
 <Yr6xPWOReXNuDQqh@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yr6xPWOReXNuDQqh@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/22 10:33, Peter Zijlstra wrote:
> On Thu, Jun 30, 2022 at 10:53:10PM +0100, Qais Yousef wrote:
> > Hi Satya
> > 
> > On 06/24/22 00:42, Satya Durga Srinivasu Prabhala wrote:
> > > Below recursion is observed in a rare scenario where __schedule()
> > > takes rq lock, at around same time task's affinity is being changed,
> > > bpf function for tracing sched_switch calls migrate_enabled(),
> > > checks for affinity change (cpus_ptr != cpus_mask) lands into
> > > __set_cpus_allowed_ptr which tries acquire rq lock and causing the
> > > recursion bug.
> > > 
> > > Fix the issue by switching to preempt_enable/disable() for non-RT
> > > Kernels.
> > 
> > Interesting bug. Thanks for the report. Unfortunately I can't see this being
> > a fix as it just limits the bug visibility to PREEMPT_RT kernels, but won't fix
> > anything, no? ie: Kernels compiled with PREEMPT_RT will still hit this failure.
> 
> Worse, there's !RT stuff that grew to rely on the preemptible migrate
> disable stuff, so this actively breaks things.
> 
> > I'm curious how the race with set affinity is happening. I would have thought
> > user space would get blocked as __schedule() will hold the rq lock.
> > 
> > Do you have more details on that?
> 
> Yeah, I'm not seeing how this works either, in order for
> migrate_enable() to actually call __set_cpus_allowed_ptr(), it needs to
> have done migrate_disable() *before* schedule, schedule() will then have
> to call migrate_disable_swich(), and *then* migrate_enable() does this.
> 
> However, if things are nicely balanced (as they should be), then
> trace_call_bpf() using migrate_disable()/migrate_enable() should never
> hit this path.
> 
> If, OTOH, migrate_disable() was called prior to schedule() and we did do
> migrate_disable_switch(), then it should be impossible for the
> tracepoint/bpf stuff to reach p->migration_disabled == 0.

I think it's worth to confirm which kernel Satya is on too. If it's GKI, then
worth checking first this is actually reproducible on/applicable to mainline.


Cheers

--
Qais Yousef
