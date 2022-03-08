Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B3D4D26F0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbiCIBik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 20:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbiCIBid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:38:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A14C084A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 17:37:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 100A9B81E54
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 23:44:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94FD8C340EB;
        Tue,  8 Mar 2022 23:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646783043;
        bh=nPkEjaPhmtz1uf+m6q2s3D/aBNBOZk/4dRNGJTjE+po=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=g2KHv2w1DD8nnoXcxphbD/Tdgd3lvFHi6myhOHmxIHbrcT9/wjnAo9/nDf23FyY+M
         OFGF2fJb4308pNtVVO7vYdsPGC6rSu2bJGP9u+ZCaPMwlId4cUFooAoLJ/oGJzTviz
         5nIRfso90rrKJacBorbLQuWrUC+vjNLabNUqRAt840jKojACvomYHSzKj3u/UWSrTi
         6vxANSijjWcMDFHE48+Kjr7FELwXww9zhKDludygGsiN+u/XX1txk/SRSP99cl7e72
         kXS8bdprUp1APZJCWFrGa2qzkfvHbtfbloxXSIDQ5Z8SlplYGvNSyFfOl92LUrSKbV
         tXhLd1NlpVDAg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 35D6C5C14AE; Tue,  8 Mar 2022 15:44:03 -0800 (PST)
Date:   Tue, 8 Mar 2022 15:44:03 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Chengming Zhou <zhouchengming@bytedance.com>, mingo@redhat.com,
        vincent.guittot@linaro.org, bristot@redhat.com,
        zhaolei@cn.fujitsu.com, tj@kernel.org, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] sched/cpuacct: optimize away RCU read lock
Message-ID: <20220308234403.GC4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220220051426.5274-1-zhouchengming@bytedance.com>
 <20220220051426.5274-2-zhouchengming@bytedance.com>
 <CGME20220308232034eucas1p2b0f39cee0f462af6004ebdfbe5bacb9f@eucas1p2.samsung.com>
 <f4bc652b-115f-35b5-91db-bad3b30fed9b@samsung.com>
 <YifniVyoJ9NNU+pv@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YifniVyoJ9NNU+pv@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 12:32:25AM +0100, Peter Zijlstra wrote:
> On Wed, Mar 09, 2022 at 12:20:33AM +0100, Marek Szyprowski wrote:
> > On 20.02.2022 06:14, Chengming Zhou wrote:
> > > Since cpuacct_charge() is called from the scheduler update_curr(),
> > > we must already have rq lock held, then the RCU read lock can
> > > be optimized away.
> > >
> > > And do the same thing in it's wrapper cgroup_account_cputime(),
> > > but we can't use lockdep_assert_rq_held() there, which defined
> > > in kernel/sched/sched.h.
> > >
> > > Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> > 
> > This patch landed recently in linux-next as commit dc6e0818bc9a 
> > ("sched/cpuacct: Optimize away RCU read lock"). On my test systems I 
> > found that it triggers a following warning in the early boot stage:
> > 
> > Calibrating delay loop (skipped), value calculated using timer 
> > frequency.. 48.00 BogoMIPS (lpj=240000)
> > pid_max: default: 32768 minimum: 301
> > Mount-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
> > Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
> > CPU: Testing write buffer coherency: ok
> > CPU0: Spectre v2: using BPIALL workaround
> > 
> > =============================
> > WARNING: suspicious RCU usage
> > 5.17.0-rc5-00050-gdc6e0818bc9a #11458 Not tainted
> > -----------------------------
> > ./include/linux/cgroup.h:481 suspicious rcu_dereference_check() usage!
> 
> Arguably, with the flavours folded again, rcu_dereference_check() ought
> to default include rcu_read_lock_sched_held() or its equivalent I
> suppose.
> 
> Paul?

That would reduce the number of warnings, but it also would hide bugs.

So, are you sure you really want this?

							Thanx, Paul
