Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FED8572198
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 19:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbiGLROO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 13:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiGLROM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 13:14:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 79B102E9E1;
        Tue, 12 Jul 2022 10:14:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7FD1165C;
        Tue, 12 Jul 2022 10:14:11 -0700 (PDT)
Received: from wubuntu (unknown [10.57.85.79])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB4583F73D;
        Tue, 12 Jul 2022 10:14:08 -0700 (PDT)
Date:   Tue, 12 Jul 2022 18:14:07 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Xuewen Yan <xuewen.yan@unisoc.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        ke.wang@unisoc.com, xuewyan@foxmail.com, linux-pm@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] sched/schedutil: Fix deadlock between cpuset and cpu
 hotplug when using schedutil
Message-ID: <20220712171407.ns67p7nygltydupx@wubuntu>
References: <20220705123705.764-1-xuewen.yan@unisoc.com>
 <20220711174629.uehfmqegcwn2lqzu@wubuntu>
 <YsyO9GM9mCydaybo@slm.duckdns.org>
 <20220712125702.yg4eqbaakvj56k6m@wubuntu>
 <Ys2duuPDNq/q+oOz@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ys2duuPDNq/q+oOz@slm.duckdns.org>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/22 06:13, Tejun Heo wrote:
> On Tue, Jul 12, 2022 at 01:57:02PM +0100, Qais Yousef wrote:
> > Is there a lot of subsystems beside cpuset that needs the cpus_read_lock()?
> > A quick grep tells me it's the only one.
> > 
> > Can't we instead use cpus_read_trylock() in cpuset_can_attach() so that we
> > either hold the lock successfully then before we go ahead and call
> > cpuset_attach(), or bail out and cancel the whole attach operation which should
> > unlock the threadgroup_rwsem() lock?
> 
> But now we're failing user-initiated operations randomly. I have a hard time

True. That might appear more random than necessary. It looked neat and
I thought since hotplug operations aren't that common and users must be
prepared for failures for other reasons, it might be okay.

> seeing that as an acceptable solution. The only thing we can do, I think, is
> establishing a locking order between the two locks by either nesting

That might be enough if no other paths can exist which would hold them in
reverse order again. It would be more robust to either hold them both or wait
until we can. Then potential ordering problems can't happen again, because of
this path at least.

> threadgroup_rwsem under cpus_read_lock or disallowing thread creation during
> hotplug operations.

I think that's what Xuewen tried to do in the proposed patch. But it fixes it
for a specific user. If we go with that we'll need nuts and bolts to help warn
when other users do that.


Thanks

--
Qais Yousef
