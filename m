Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA48F4DB787
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 18:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356574AbiCPRon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 13:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355558AbiCPRok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 13:44:40 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252D717046
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 10:43:25 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 1CD1648F; Wed, 16 Mar 2022 13:43:24 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 1CD1648F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1647452604;
        bh=Wl8eLmn2EyVMIbzbpeaNnxsMHJboV9nFjzpk/4KzOkE=;
        h=Date:To:Cc:Subject:From:From;
        b=zBBxlsA1m1y04DG77zWHK91zWwZexpegElKCeRRQsAAOGVz6jkaRT4Y43z0tHKno0
         ZbEWWlpkHiM5RaWK4xfrJMEwtApTqrkUtJ91AFw/+uLgUfHBkRoDUS6MR6k2rG1mMv
         u9zB9cXONokvgYmVbxprMe628XN95oMI3ESiscUE=
Date:   Wed, 16 Mar 2022 13:43:24 -0400
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: failure to boot after dc6e0818bc9a "sched/cpuacct: Optimize away RCU
 read lock"
Message-ID: <20220316174324.GA16511@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of my test VMs has been failing to boot linux-next recently.  I
finally got around to a bisect this morning, and it landed on the below.

What other information would be useful to debug this?

--b.

commit dc6e0818bc9a
Author: Chengming Zhou <zhouchengming@bytedance.com>
Date:   Sun Feb 20 13:14:25 2022 +0800

    sched/cpuacct: Optimize away RCU read lock
    
    Since cpuacct_charge() is called from the scheduler update_curr(),
    we must already have rq lock held, then the RCU read lock can
    be optimized away.
    
    And do the same thing in it's wrapper cgroup_account_cputime(),
    but we can't use lockdep_assert_rq_held() there, which defined
    in kernel/sched/sched.h.
    
    Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
    Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
    Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
    Link: https://lore.kernel.org/r/20220220051426.5274-2-zhouchengming@bytedance.com

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 75c151413fda..9a109c6ac0e0 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -791,11 +791,9 @@ static inline void cgroup_account_cputime(struct task_struct *task,
 
 	cpuacct_charge(task, delta_exec);
 
-	rcu_read_lock();
 	cgrp = task_dfl_cgroup(task);
 	if (cgroup_parent(cgrp))
 		__cgroup_account_cputime(cgrp, delta_exec);
-	rcu_read_unlock();
 }
 
 static inline void cgroup_account_cputime_field(struct task_struct *task,
diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
index 307800586ac8..f79f88456d72 100644
--- a/kernel/sched/cpuacct.c
+++ b/kernel/sched/cpuacct.c
@@ -337,12 +337,10 @@ void cpuacct_charge(struct task_struct *tsk, u64 cputime)
 	unsigned int cpu = task_cpu(tsk);
 	struct cpuacct *ca;
 
-	rcu_read_lock();
+	lockdep_assert_rq_held(cpu_rq(cpu));
 
 	for (ca = task_ca(tsk); ca; ca = parent_ca(ca))
 		*per_cpu_ptr(ca->cpuusage, cpu) += cputime;
-
-	rcu_read_unlock();
 }
 
 /*
