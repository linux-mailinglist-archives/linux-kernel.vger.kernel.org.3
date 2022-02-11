Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBB54B2B07
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351781AbiBKQwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:52:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbiBKQwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:52:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36BA8D
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 08:52:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F349610A1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 16:52:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56AC3C340E9;
        Fri, 11 Feb 2022 16:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644598341;
        bh=Nq7wUkLjA4LeOstJ8B2moCVuBVpMOf5sBh2q+m1uIM8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Us8eXHhr8UjO3qj5cZDTejvS34QUWwQF/EuyUqV+GMatvOQHFFHi4fLda9/XnLJgw
         IZu8lQ+coeorgYYPPhfmxPXAc+JI8F7h20pc4dk72t/+Nw/Zx82fOna2ByJ9ooO2zt
         oVnALjf4OD9yeUdWCnsLbKluV9bBNeJtAwgerzcgRrUeKimhBow9pCi2z4hP2VINMR
         L8WYO7SF3wF/hcMpQNjjDoxRkPa+tS2kxcoyM+30gqoJPbeWFujNUmDsvxFQB6yPTN
         JxPcXdXuyp3vhB/VGqTcm4nXpjGFLcMnBcg61cIXblzAsWwZwhYEGzGeV2QD1nPv01
         AJOCH2Ex+e2hw==
Date:   Fri, 11 Feb 2022 17:52:19 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@gentwo.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nitesh Lal <nilal@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Saenz <nsaenzju@redhat.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>
Subject: Re: Revisiting the current set of nohz / housekeeping flags before
 export
Message-ID: <20220211165219.GE588079@lothringen>
References: <20220208164749.GB230002@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208164749.GB230002@windriver.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 11:47:49AM -0500, Paul Gortmaker wrote:
> The isolation flags [some/all?] are someday going to be exposed via cgroups.
> Frederic has a series out for review now that moves us closer to doing that:
> 
> https://lore.kernel.org/all/20220207155910.527133-1-frederic@kernel.org/
> 
> They will be user exposed tuning knobs and no longer just hidden away in
> source with a subset linked to boot args used by a small set of people.
> 
> As such, we'll need clear user-facing descriptions of each, and specifics of
> what they control/alter.  Which was the initial thought that got me here.
> 
> When the 1st group of flags was introduced (2017) they were split at a fine
> grained level, leaving the door open to re-merge some flags later if natural
> groupings arose. (see de201559df8 log)
> 
> Prior to the elevated userspace exposure they'll get via cgroups (and via
> adding a Documentation/isolation.rst or similar) it probably makes sense
> to revisit possible flag merges now, before they become cemented into API
> and thus essentially leave us stuck with the choices forever.
> 
> Open questions:
> -should HK_FLAG_SCHED be squashed into HK_FLAG_MISC ?  It isnt set and the
>  name can be misleading to new users, in that it "sounds like" the main
>  isolation flag (vs the "real" one which is essentially !HK_FLAG_DOMAIN)
> 
> -should HK_FLAG_RCU be squashed into ... ?  HK_FLAG_MISC ?  It is only used
>  for rcu_online/offline of a CPU and the name might inadvertently suggest
>  that it is somehow related to rcu_nocbs= (when it isn't).
> 
> -do we need HK_FLAG_WQ ?  Currently always or'd with DOMAIN.  Or should we
>  change to select from WQ and then fall back to DOMAIN iff WQ set is empty?
> 
> To better address this, and answer "how did we get here, and who is using
> what flags and where currently" I found myself making some notes to gather
> all that kind of information in one place.
> 
> So what follows below are my rough notes on the housekeeping flags - a
> combination of snippets of source, and commit references etc.  Maybe it
> provides others a shortcut to the overall picture w/o duplicating the work.
> 
> From here, hopefully we can decide if we are OK with the flags as they are,
> and I can take what remains and try and address the documentation I think
> we'll need, as per what I outlined at the top.
> 
> Paul.

Wow, that's quite a deep analysis and archive digging you did!

So, I don't intend to necessarily map all HK_FLAG_* to cpuset. These should be
processed one by one as we add each cpuset.isolation.$FEATURE files over time.

But we certainly need to plan ahead:


1) Unbound features (HK_FLAG_TIMER, HK_FLAG_WQ, HK_FLAG_KTHREAD)

All unbound kernel works could be gathered into a single feature/file.
In this group we have:

_ HK_FLAG_TIMER: unbound timers
_ HK_FLAG_WQ: unbound workqueues
_ HK_FLAG_KTHREAD: unbound kthreads

Now the question is: do we want to keep things finegrained and have a seperate
file for each:

    cpuset.isolation.unbound_timers
    cpuset.isolation.unbound_workqueues
    cpuset.isolation.unbound_kthreads

or do we want to group them:

    cpuset.isolation.unbound

Also note that workqueues affinity can already be controlled over sysfs. We can
still have both interfaces relying on the same cpumask though.


2) HK_FLAG_TICK

Needs its own cpuset.isolation file

3) HK_FLAG_DOMAIN

Cpuset already produces a similar behaviour with cpuset.sched_load_balance. We
just need to map isolcpus to it somehow (add a "cpuset" flag to "isolcpus=" boot
parameter?)

4) HK_FLAG_RCU

A specialization of HK_FLAG_KTHREAD, not sure if it's necessary, could be merged
into HK_FLAG_KTHREAD?

5) HK_FLAG_MANAGED_IRQ

Needs its own cpuset.isolation file

6) The leftovers: HK_FLAG_SCHED and HK_FLAG_MISC

I seem to remember HK_FLAG_SCHED was a bit messy and not well defined. I'll
check your below references. And HK_FLAG_MISC as well...

Oh and I intend to add HK_FLAG_RCU_NOCB since this also should have its own
file just in case it's ever used without nohz_full.

Thanks!
