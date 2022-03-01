Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393FE4C8EF5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 16:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235714AbiCAPZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 10:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235680AbiCAPZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 10:25:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFDF8AE56;
        Tue,  1 Mar 2022 07:24:43 -0800 (PST)
Date:   Tue, 01 Mar 2022 15:24:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646148282;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vB05i6VO2kiE1iLsrpoIRbGB7PP5Uf95p6Jj2oPbYGE=;
        b=Z90yrbGafXSwJTeNGeROFZ3tAVpaj3t3BbzO+Q8akQ1bwYCkRJI0k7BgWn/kfnAM2X4FSl
        AADRPfpsMsu3NhMG0m94qOpPLenjnHy8tCDwrzKvPKIFQsj2s5D8YI6ZPQmxTMGgY4oWNW
        h9ie3ifSXNVKmMbXiu+0iSJuWvJFM00Y77AGJ27pCKE5KfmYZIWzFXIdVJUamQDY0lkz1B
        Fu+oezOlJ3P6mEcmzyf4yolQIbBp8E1Bh2PyOhdQo09W+hRpl18Yvn36LrmRFm1uOtlY9s
        suFBE0qjX4bD9T/INKpW7n3abk+7mnstw7eqwbET+gjpzrYd6VwKSAMVskhWlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646148282;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vB05i6VO2kiE1iLsrpoIRbGB7PP5Uf95p6Jj2oPbYGE=;
        b=kgRy8UyS6jThrd/YRlQZFvnyLxtTHGh8+cIa9+Jmzrdqu1MzYjDrMFqBfsX7apQBqhK+PY
        N5YsVRo3qs3p9QBw==
From:   "tip-bot2 for Chengming Zhou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/cpuacct: Remove redundant RCU read lock
Cc:     Tejun Heo <tj@kernel.org>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220220051426.5274-3-zhouchengming@bytedance.com>
References: <20220220051426.5274-3-zhouchengming@bytedance.com>
MIME-Version: 1.0
Message-ID: <164614828103.16921.3200748862262912069.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     3eba0505d03a9c1eb30d40c2330c0880b22d1b3a
Gitweb:        https://git.kernel.org/tip/3eba0505d03a9c1eb30d40c2330c0880b22d1b3a
Author:        Chengming Zhou <zhouchengming@bytedance.com>
AuthorDate:    Sun, 20 Feb 2022 13:14:26 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 01 Mar 2022 16:18:38 +01:00

sched/cpuacct: Remove redundant RCU read lock

The cpuacct_account_field() and it's cgroup v2 wrapper
cgroup_account_cputime_field() is only called from cputime
in task_group_account_field(), which is already in RCU read-side
critical section. So remove these redundant RCU read lock.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220220051426.5274-3-zhouchengming@bytedance.com
---
 include/linux/cgroup.h | 2 --
 kernel/sched/cpuacct.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 9a109c6..1e356c2 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -804,11 +804,9 @@ static inline void cgroup_account_cputime_field(struct task_struct *task,
 
 	cpuacct_account_field(task, index, delta_exec);
 
-	rcu_read_lock();
 	cgrp = task_dfl_cgroup(task);
 	if (cgroup_parent(cgrp))
 		__cgroup_account_cputime_field(cgrp, index, delta_exec);
-	rcu_read_unlock();
 }
 
 #else	/* CONFIG_CGROUPS */
diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
index f79f884..d269ede 100644
--- a/kernel/sched/cpuacct.c
+++ b/kernel/sched/cpuacct.c
@@ -352,10 +352,8 @@ void cpuacct_account_field(struct task_struct *tsk, int index, u64 val)
 {
 	struct cpuacct *ca;
 
-	rcu_read_lock();
 	for (ca = task_ca(tsk); ca != &root_cpuacct; ca = parent_ca(ca))
 		__this_cpu_add(ca->cpustat->cpustat[index], val);
-	rcu_read_unlock();
 }
 
 struct cgroup_subsys cpuacct_cgrp_subsys = {
