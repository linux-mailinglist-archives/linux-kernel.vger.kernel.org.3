Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36054D2582
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 02:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiCIBHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 20:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiCIBHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:07:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E53237C7
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 16:46:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFC6160A50
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 00:22:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ADBBC340EB;
        Wed,  9 Mar 2022 00:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646785320;
        bh=F1kzKZpYMWhM9cQPPakX62bZJT5OiMykVQym1F03byg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=JX9rUkpPGmqfkiGs9+lC2Pj2bNqor0z2z5GIUl/W1U0nxVOriJZtRjF457Iuv4q5t
         EOl1exgG+SGmPNcMYfOyZxCMkXWbZn67HxiVe3j5Ug9SUgM9/iY8CMsdsW3XxVA5z9
         Ty3Ftn8Y7hdBVGb6KHOOuTL91hl47ZcBnx2yXrqejEUuFBgYziTKl4mkNblMfqVNQU
         1bAM3Pldi+mU3C10M7W/IPChuMC213XRc8o+ziI8laadTkIyqWRNkfdrRzMVPD8Scj
         /afRvGIJbVjw3u415mqlDuB3NFVTGSQA8uLYQ0Qm4qhTcNLPJ+3jt7zfuImlFeE4hH
         XNRg/JleKMl7Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DCCDD5C14AE; Tue,  8 Mar 2022 16:21:59 -0800 (PST)
Date:   Tue, 8 Mar 2022 16:21:59 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Chengming Zhou <zhouchengming@bytedance.com>, mingo@redhat.com,
        vincent.guittot@linaro.org, bristot@redhat.com,
        zhaolei@cn.fujitsu.com, tj@kernel.org, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] sched/cpuacct: optimize away RCU read lock
Message-ID: <20220309002159.GA3774636@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220220051426.5274-1-zhouchengming@bytedance.com>
 <20220220051426.5274-2-zhouchengming@bytedance.com>
 <CGME20220308232034eucas1p2b0f39cee0f462af6004ebdfbe5bacb9f@eucas1p2.samsung.com>
 <f4bc652b-115f-35b5-91db-bad3b30fed9b@samsung.com>
 <YifniVyoJ9NNU+pv@hirez.programming.kicks-ass.net>
 <20220308234403.GC4285@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308234403.GC4285@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 03:44:03PM -0800, Paul E. McKenney wrote:
> On Wed, Mar 09, 2022 at 12:32:25AM +0100, Peter Zijlstra wrote:
> > On Wed, Mar 09, 2022 at 12:20:33AM +0100, Marek Szyprowski wrote:
> > > On 20.02.2022 06:14, Chengming Zhou wrote:
> > > > Since cpuacct_charge() is called from the scheduler update_curr(),
> > > > we must already have rq lock held, then the RCU read lock can
> > > > be optimized away.
> > > >
> > > > And do the same thing in it's wrapper cgroup_account_cputime(),
> > > > but we can't use lockdep_assert_rq_held() there, which defined
> > > > in kernel/sched/sched.h.
> > > >
> > > > Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > > Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> > > 
> > > This patch landed recently in linux-next as commit dc6e0818bc9a 
> > > ("sched/cpuacct: Optimize away RCU read lock"). On my test systems I 
> > > found that it triggers a following warning in the early boot stage:
> > > 
> > > Calibrating delay loop (skipped), value calculated using timer 
> > > frequency.. 48.00 BogoMIPS (lpj=240000)
> > > pid_max: default: 32768 minimum: 301
> > > Mount-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
> > > Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
> > > CPU: Testing write buffer coherency: ok
> > > CPU0: Spectre v2: using BPIALL workaround
> > > 
> > > =============================
> > > WARNING: suspicious RCU usage
> > > 5.17.0-rc5-00050-gdc6e0818bc9a #11458 Not tainted
> > > -----------------------------
> > > ./include/linux/cgroup.h:481 suspicious rcu_dereference_check() usage!
> > 
> > Arguably, with the flavours folded again, rcu_dereference_check() ought
> > to default include rcu_read_lock_sched_held() or its equivalent I
> > suppose.
> > 
> > Paul?
> 
> That would reduce the number of warnings, but it also would hide bugs.
> 
> So, are you sure you really want this?

Of course, if you are designing a use case that really expects multiple
types of readers...

Another approach might be rcu_dereference_brs(), but hopefully with a
better name, that checks for either rcu_read_lock(), disabled BH, or
disabled preemption.  Or if you are looking only for rcu_read_lock()
or disabled preemption, rcu_dereference_rs(), again hopefully with a
better name.

Is that what you had in mind?

							Thanx, Paul


