Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669C74BCC42
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 06:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbiBTFQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 00:16:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbiBTFQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 00:16:00 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A907F44775
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 21:15:29 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id q11-20020a17090a304b00b001b94d25eaecso12239216pjl.4
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 21:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BbSKVWodbN20blAPKYCyP8ZKLA8GgWcyo30Dlz3sTHQ=;
        b=GWDmfVZtO+VdWzOONsY4Dn4WamryrC1STwAcRCB2+rL5L7bsI3st6uUS7iRjlMzTfk
         3B2+ECc+nmXWYvbZMVnyRMQpHY1pTrBlSXIbKoN3NroGKPb3ljMsla+jER5Tu5z3X6U7
         WWBpLJ1IpzzFak56f5FyZBwkgKjluTjJdhrF9L0qppkc216XaCvh8lbkLXj//ynvy2k4
         3PaySNtgaga35Wb9y77uXjzFAf1IJPPEk2k3N5gjM8PZsXxM8j3Q8caEEQAN/s53U9DX
         1HBqbo+nh9JhVFwmao6wmlhM/+Q4qxB5zCirGsv5j8eyHsBZs7tdHgj6799zF83uR4bW
         t8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BbSKVWodbN20blAPKYCyP8ZKLA8GgWcyo30Dlz3sTHQ=;
        b=KJKGbgEWIR9UQd7IBL9LZ2Oe0mHCiFiozo+txr2VThv8MD5mefnSb0Mlkmq9vYb8Xv
         1U0zVK9DyISoduGAShNflAhI71RCw1WBPb/S8h7RT7R7REch+XEoNtQOsEQyOa4j9UCN
         bZnwISEl7kfVLNMG0j5c9WNda4mx3QYLBfLu4AX8cTEmETS07xnA44q2lwWyCBRyENJQ
         HM8mwHq+7JToAAP3RQUxjdY04lJYTz2iWtJpvWGL5ra4HDMRB0NXmYsVQUe3O+JXsfdL
         uQyfvku4XlZh3AVhsaMNqfFRm445xdaKaSJ2PpcGpBOZi4UMI3rQJcL4wH2xZL6q4PAD
         d2SQ==
X-Gm-Message-State: AOAM53350oyX3MTLL+XMxtR2xpKjenxVETXRWWJ56HEOcfalZSN5XT6T
        EidmrEZEttS9Q6wMhnAOj85M3A==
X-Google-Smtp-Source: ABdhPJx9AmlGHj1W1mlCcaxty7LWNnbMfeGaA1BECAfY9xWm73Rn/Z5Hx11SYY6++AUTh2YSidEEqA==
X-Received: by 2002:a17:90a:e7ca:b0:1b9:66c8:982c with SMTP id kb10-20020a17090ae7ca00b001b966c8982cmr19681462pjb.30.1645334129234;
        Sat, 19 Feb 2022 21:15:29 -0800 (PST)
Received: from localhost.localdomain ([2409:8a28:e61:5860:2995:483c:273c:28ec])
        by smtp.gmail.com with ESMTPSA id y23sm7737907pfa.67.2022.02.19.21.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 21:15:28 -0800 (PST)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        bristot@redhat.com, zhaolei@cn.fujitsu.com, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v3 2/3] sched/cpuacct: optimize away RCU read lock
Date:   Sun, 20 Feb 2022 13:14:25 +0800
Message-Id: <20220220051426.5274-2-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220220051426.5274-1-zhouchengming@bytedance.com>
References: <20220220051426.5274-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since cpuacct_charge() is called from the scheduler update_curr(),
we must already have rq lock held, then the RCU read lock can
be optimized away.

And do the same thing in it's wrapper cgroup_account_cputime(),
but we can't use lockdep_assert_rq_held() there, which defined
in kernel/sched/sched.h.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 include/linux/cgroup.h | 2 --
 kernel/sched/cpuacct.c | 4 +---
 2 files changed, 1 insertion(+), 5 deletions(-)

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
-- 
2.20.1

