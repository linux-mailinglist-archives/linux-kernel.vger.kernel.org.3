Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892B54DB9AE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 21:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358016AbiCPUtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 16:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbiCPUta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 16:49:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134E455BE6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 13:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2nBuvaSox1ZIHDm0IfB3PYfwUO2GPtBWwb4l0+ox9Zo=; b=vD56v3Od5nXi+2okgxAUp61768
        l5M2id4S/XEntn+AKOKfahfp08GfzMv5y1OhG8ZQ+KqXRiemvPipiTmzdeD/wQkurbVMU1/6gSKq/
        WaA9vfMrAX8CSYaQ8YVUmo13i8eRRX8TKuqto6xIi4uR8OAfFXBzwG4tK0i1LpdfR1qeEgDueePr7
        eiTJ6/+rIg8mIggvTf0mxS1oay/BRZW21sxY8bPibEtX+KlFe3jgoIyWf3YZteOfG9lIUK+x27Mh8
        tgb7x4Uar70xP6rW8DUuF/lqGImuKw0C0jfTgRHnA5J0yArMofoPpasXZT0iSezzVAVSP2iGXWu2X
        VvJnSmXQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUaYy-006MnA-GV; Wed, 16 Mar 2022 20:48:08 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id F0C119882AA; Wed, 16 Mar 2022 21:48:06 +0100 (CET)
Date:   Wed, 16 Mar 2022 21:48:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: failure to boot after dc6e0818bc9a "sched/cpuacct: Optimize away
 RCU read lock"
Message-ID: <20220316204806.GL8939@worktop.programming.kicks-ass.net>
References: <20220316174324.GA16511@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316174324.GA16511@fieldses.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 01:43:24PM -0400, J. Bruce Fields wrote:
> One of my test VMs has been failing to boot linux-next recently.  I
> finally got around to a bisect this morning, and it landed on the below.
> 
> What other information would be useful to debug this?

A more recent -next should have this commit in it:


commit f2aa197e4794bf4c2c0c9570684f86e6fa103e8b
Author: Chengming Zhou <zhouchengming@bytedance.com>
Date:   Sat Mar 5 11:41:03 2022 +0800

    cgroup: Fix suspicious rcu_dereference_check() usage warning
    
    task_css_set_check() will use rcu_dereference_check() to check for
    rcu_read_lock_held() on the read-side, which is not true after commit
    dc6e0818bc9a ("sched/cpuacct: Optimize away RCU read lock"). This
    commit drop explicit rcu_read_lock(), change to RCU-sched read-side
    critical section. So fix the RCU warning by adding check for
    rcu_read_lock_sched_held().
    
    Fixes: dc6e0818bc9a ("sched/cpuacct: Optimize away RCU read lock")
    Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
    Reported-by: syzbot+16e3f2c77e7c5a0113f9@syzkaller.appspotmail.com
    Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
    Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
    Acked-by: Tejun Heo <tj@kernel.org>
    Tested-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
    Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
    Link: https://lore.kernel.org/r/20220305034103.57123-1-zhouchengming@bytedance.com

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 1e356c222756..0d1ada8968d7 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -450,6 +450,7 @@ extern struct mutex cgroup_mutex;
 extern spinlock_t css_set_lock;
 #define task_css_set_check(task, __c)					\
 	rcu_dereference_check((task)->cgroups,				\
+		rcu_read_lock_sched_held() ||				\
 		lockdep_is_held(&cgroup_mutex) ||			\
 		lockdep_is_held(&css_set_lock) ||			\
 		((task)->flags & PF_EXITING) || (__c))
