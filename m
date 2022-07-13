Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8045573E2D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 22:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237214AbiGMUvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 16:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237203AbiGMUvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 16:51:08 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F883137E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 13:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657745466; x=1689281466;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p7AddPEbmNXipfnrDJYWSD6RDTq4SByDhh3kApijBTA=;
  b=Cu+Af2doW1X9hZSqNCEbRgw7VR3Z2aWuGFFB/San3/IQxnmdpEGJfFfh
   TDHmzsXKgLzo7BUVBt/DEgqjS437c8yItbdmkZNLJC7g2e8meFMFziAnb
   aeG+LpUOdZp8m8Tl86BOvAnUUWgziYSPhLQw26mhniSaTQyFOWwNAvKyq
   ROugqkuOskhK7rZtobbV8ny/SVQJ1SUrY5hTitEI0hYV5s0TtKzluLSxP
   tcUzfyb7F/c5MdmHiZXJYSXnMnMw0+x3HdkfLEE9fWKItLQ3urh2P7QAD
   z8GjjBUXLROSh2prfCiuzjGMcmEgpNGj6FQHpuNINIeNO8fJGMsfJbvxx
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="282896043"
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="282896043"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 13:51:06 -0700
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="685313799"
Received: from schen9-mobl.amr.corp.intel.com ([10.209.49.100])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 13:51:06 -0700
Message-ID: <ff27aa3bce81a4f9cdf9e71b989af7db5b0fa44a.camel@linux.intel.com>
Subject: Re: [PATCH] sched/fair: no sync wakeup from interrupt context
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Libo Chen <libo.chen@oracle.com>, peterz@infradead.org,
        vincent.guittot@linaro.org, mgorman@suse.de, 21cnbao@gmail.com,
        dietmar.eggemann@arm.com
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de
Date:   Wed, 13 Jul 2022 13:51:05 -0700
In-Reply-To: <0917f479-b6aa-19de-3d6a-6fd422df4d21@oracle.com>
References: <20220711224704.1672831-1-libo.chen@oracle.com>
         <2c0c61a1c4c54d06905279a9a724a9390d9ee5c3.camel@linux.intel.com>
         <0917f479-b6aa-19de-3d6a-6fd422df4d21@oracle.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-07-13 at 12:17 -0700, Libo Chen wrote:
> 
> 
> On 7/13/22 09:40, Tim Chen wrote:
> > On Mon, 2022-07-11 at 15:47 -0700, Libo Chen wrote:
> > > Barry Song first pointed out that replacing sync wakeup with regular wakeup
> > > seems to reduce overeager wakeup pulling and shows noticeable performance
> > > improvement.[1]
> > > 
> > > This patch argues that allowing sync for wakeups from interrupt context
> > > is a bug and fixing it can improve performance even when irq/softirq is
> > > evenly spread out.
> > > 
> > > For wakeups from ISR, the waking CPU is just the CPU of ISR and the so-called
> > > waker can be any random task that happens to be running on that CPU when the
> > > interrupt comes in. This is completely different from other wakups where the
> > > task running on the waking CPU is the actual waker. For example, two tasks
> > > communicate through a pipe or mutiple tasks access the same critical section,
> > > etc. This difference is important because with sync we assume the waker will
> > > get off the runqueue and go to sleep immedately after the wakeup. The
> > > assumption is built into wake_affine() where it discounts the waker's presence
> > > from the runqueue when sync is true. The random waker from interrupts bears no
> > > relation to the wakee and don't usually go to sleep immediately afterwards
> > > unless wakeup granularity is reached. Plus the scheduler no longer enforces the
> > > preepmtion of waker for sync wakeup as it used to before
> > > patch f2e74eeac03ffb7 ("sched: Remove WAKEUP_SYNC feature"). Enforcing sync
> > > wakeup preemption for wakeups from interrupt contexts doesn't seem to be
> > > appropriate too but at least sync wakeup will do what it's supposed to do.
> > 
> > Will there be scenarios where you do want the task being woken up be pulled
> > to the CPU where the interrupt happened, as the data that needs to be accessed is
> > on local CPU/NUMA that interrupt happened?  For example, interrupt associated with network
> > packets received.  Sync still seems desirable, at least if there is no task currently
> > running on the CPU where interrupt happened.  So maybe we should have some consideration
> > of the load on the CPU/NUMA before deciding whether we should do sync wake for such
> > interrupt.
> > 
>  There are only two places where sync wakeup matters: wake_affine_idle() and wake_affine_weight().
> In wake_affine_idle(), it considers pulling if there is one runnable on the waking CPU because
> of the belief that this runnable will voluntarily get off the runqueue. In wake_affine_weight(),
> it basically takes off the waker's load again assuming the waker goes to sleep after the wakeup.
> My argument is that this assumption doesn't really hold for wakeups from the interrupt contexts
> when the waking CPU is non-idle. Wakeups from task context? sure, it seems to be a reasonable
> assumption. 

I agree with you that the the sync case load computation for wake_affine_idle()
and wake_affine_weight() is incorrect when waking a task from the interrupt context.
In this light, your proposal makes sense.

> For your idle case, I totally agree but I don't think having sync or not will actually
> have any impacts here giving what the code does. Real impact comes from Mel's patch 7332dec055f2457c3
> which makes it less likely to pull tasks when the waking CPU is idle. I believe we should consider
> reverting 7332dec055f2 because a significant RDS latency regression has been spotted recently on our
> system due to this patch. 

The commit 7332dec055f2 prevented cross NUMA node pulling.  I think if the 
waking CPU's NUMA node's average load is less than the prev CPU's NUMA node, 
this cross NUMA node pull could be allowed for better load distribution.    

> > 
> > Can you provide some further insights on why pgebench is helped at low load
> > case?  Is it because the woken tasks tend to stay put and not get moved around with interrupts
> > and maintain cache warmth?
>  Yes, and for read-only database workloads, the cache (whether it's incoming packet or not) on the interrupt
> CPU isn't as performance critical as cache from its previous CPU where the db task run to process data.
> To give you an example, consider a db client/server case, a client sends a request for a select query
> through the network, the server accepts the query request and does all the heavy lifting and sends the result
> back. For the server, the incoming packet is just a line of query whereas the CPU and its L3 db process previously
> on has all the warm db caches, pulling it away from them is a crime :)  This may seem to be a little contradictory
> to what I said earlier about the idle case and Mel's patch, but ¯\_(ツ)_/¯ it's hard to make all the workloads out
> there happy. Anyway like I said earlier, this patch doesn't affect the idle case  
> 
> At higher load, sync in wake_affine_idle() doesn't really matter because the waking CPU could easily have more than
> 1 runnable tasks. Sync in wake_affine_weight() also doesn't matter much as both sides have work to do, and cache
> benefit of not pulling decreases simply because there are a lot more db processes under the same L3, they can compete
> for the same cachelines.
> 
> Hope my explanation helps!

Yes, that makes sense.

Tim


