Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D466E4D42CB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 09:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240470AbiCJIqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 03:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbiCJIqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 03:46:36 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2892C8189A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 00:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7CNkExPZGr37ETx08CFw0OJRaskcsi0wkihRq0QBeX8=; b=eFOdIQsQ4S7hjurF+puepjPscW
        lpDc504LNqvHSPzx2aDl/wKyQcYqlglZW0P1cMhzBuAQpj3YB74QO0NY6yF6pnJjNuSj5i+VIB645
        9hv1FHIn2hu+JbtB5+RK4bGENiIg2Cuxnfx89jJJjcG5MtlEkPIG9UUGObtpOhlh1ifB0zAr2RuMm
        GgwTT5vKYqGKOP5qrM8tu3nFfunT4nDSvDXsmkUTauwJLpI54OLYGTaIGpTVuYfZ+rjTg0BtVgaYN
        o2C3JK2yGrpttn7yxUZ6JYjpBmJRffyXq3zADCxkC4w9t0ikhI5RZDPycehdlqP/u3X+LnjillSJ8
        BDhu9qAw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nSEQC-000Lwu-ID; Thu, 10 Mar 2022 08:45:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3E1403000E6;
        Thu, 10 Mar 2022 09:45:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B7BEF201699FB; Thu, 10 Mar 2022 09:45:17 +0100 (CET)
Date:   Thu, 10 Mar 2022 09:45:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Chengming Zhou <zhouchengming@bytedance.com>, mingo@redhat.com,
        vincent.guittot@linaro.org, bristot@redhat.com,
        zhaolei@cn.fujitsu.com, tj@kernel.org, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] sched/cpuacct: optimize away RCU read lock
Message-ID: <Yim6nUmfGk5FHv6K@hirez.programming.kicks-ass.net>
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

I don't understand... Since the flavours got merged regular RCU has it's
quescent state held off by preempt_disable. So how can relying on that
cause bugs?

And if we can rely on that, then surely rcu_dereferenced_check() ought
to play by the same rules, otherwise we get silly warnings like these at
hand.

Specifically, we removed the rcu_read_lock() here because this has
rq->lock held, which is a raw_spinlock_t which very much implies preempt
disable, on top of that, it's also an IRQ-safe lock and thus IRQs will
be disabled.

There is no possible way for RCU to make progress.
