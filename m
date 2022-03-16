Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9AD4DBB04
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 00:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345175AbiCPX2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 19:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238816AbiCPX2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 19:28:20 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76D064C9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 16:27:04 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 178F148F; Wed, 16 Mar 2022 19:27:04 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 178F148F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1647473224;
        bh=oRYsFvRyGnJC9jPCSEJDJXYHIXXhCY6to725MbmUgcw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c/dnTlCDgHcQLb45RiI7tGWzeG/aLYl7l5F6vMHl9LneBnVLLw5B1R9pluHIyW7Kl
         AYcTtNDv/fFDSyVu+OGXskiHqBGnzXo7gl83PbnzoSdvqP3Gmf+1Fjc6BI2a5EunGD
         qYGFderD8x4GKOeOQnqq1Jjs+gawz3GxkuaXPKR8=
Date:   Wed, 16 Mar 2022 19:27:04 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: failure to boot after dc6e0818bc9a "sched/cpuacct: Optimize away
 RCU read lock"
Message-ID: <20220316232704.GE16511@fieldses.org>
References: <20220316174324.GA16511@fieldses.org>
 <20220316204806.GL8939@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316204806.GL8939@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 09:48:06PM +0100, Peter Zijlstra wrote:
> On Wed, Mar 16, 2022 at 01:43:24PM -0400, J. Bruce Fields wrote:
> > One of my test VMs has been failing to boot linux-next recently.  I
> > finally got around to a bisect this morning, and it landed on the below.
> > 
> > What other information would be useful to debug this?
> 
> A more recent -next should have this commit in it:

Ah, yep, it's booting again with today's -next.  Thanks.--b.

> 
> 
> commit f2aa197e4794bf4c2c0c9570684f86e6fa103e8b
> Author: Chengming Zhou <zhouchengming@bytedance.com>
> Date:   Sat Mar 5 11:41:03 2022 +0800
> 
>     cgroup: Fix suspicious rcu_dereference_check() usage warning
>     
>     task_css_set_check() will use rcu_dereference_check() to check for
>     rcu_read_lock_held() on the read-side, which is not true after commit
>     dc6e0818bc9a ("sched/cpuacct: Optimize away RCU read lock"). This
>     commit drop explicit rcu_read_lock(), change to RCU-sched read-side
>     critical section. So fix the RCU warning by adding check for
>     rcu_read_lock_sched_held().
>     
>     Fixes: dc6e0818bc9a ("sched/cpuacct: Optimize away RCU read lock")
>     Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>     Reported-by: syzbot+16e3f2c77e7c5a0113f9@syzkaller.appspotmail.com
>     Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>     Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>     Acked-by: Tejun Heo <tj@kernel.org>
>     Tested-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
>     Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>     Link: https://lore.kernel.org/r/20220305034103.57123-1-zhouchengming@bytedance.com
> 
> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> index 1e356c222756..0d1ada8968d7 100644
> --- a/include/linux/cgroup.h
> +++ b/include/linux/cgroup.h
> @@ -450,6 +450,7 @@ extern struct mutex cgroup_mutex;
>  extern spinlock_t css_set_lock;
>  #define task_css_set_check(task, __c)					\
>  	rcu_dereference_check((task)->cgroups,				\
> +		rcu_read_lock_sched_held() ||				\
>  		lockdep_is_held(&cgroup_mutex) ||			\
>  		lockdep_is_held(&css_set_lock) ||			\
>  		((task)->flags & PF_EXITING) || (__c))
