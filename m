Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58934BCC43
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 06:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbiBTFQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 00:16:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbiBTFQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 00:16:00 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FD645042
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 21:15:35 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id q11-20020a17090a304b00b001b94d25eaecso12239352pjl.4
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 21:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=64iTeZETh1Oj8/n7z7np/F/etWY1j31KhxPIick85Eg=;
        b=Hjj26EPRbvFQBejGsBIyyk2tNc9EMzPxVBQttBqzoxeEPa3JA7s4858mE5xtvpNa/c
         NISc7nW6w167wBwFzoJ5IC36GqLH13QBX9m2IY1EATVqZ/7rcq/AELNqoTK1fA8QmGFG
         X3G8qz4dS9j2N2JwU+LdJ+zLns/OgdlglXEw0mXp5Ff7u5hW8eQHsMcH5kMBq2eItcoX
         wtpMTE2PCtaUr6j6qVXgUPQMb3L3pvXT1YHLW142zD6nncHw4cAkldlVwUdML+pEIP2z
         ujCKYzUTfGHbooYaB6eSi27so7VUHYlag1sMH7a8iW31UTVq7WYkEtdzH2WJx5rc+b+X
         hpPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=64iTeZETh1Oj8/n7z7np/F/etWY1j31KhxPIick85Eg=;
        b=P9rJbpqVY6xv3XpJf+LDFAMSdmNHy9HlYH048QfTBZwpGDAtgEnuYuKy6Le5ORMX4I
         q15akGSAoL2A3zMv3ACEZc/QhD6DlKD8GKPKtsYGT0F8gfXY4dsyhKZG1uh/9r/92nCe
         EBvnSmQ7YREBwfe5KT7WSZ2XgYdx7DSA+PW8XYOBunIuNufx1pZyNaoJNDSBnNjDRCLZ
         SZFjezkiaNP66f8bd9CVrZlwRtbRd8z3VItAsjcwRieUS0dE2F8Zdrpp1/wKShr1sl+r
         vJ6solkLFpQttgBOovpIWNFOsrjWQ9ESbeaY7nD3bX4BC9J1NQnk6beIH1j9In9mFLqx
         X58Q==
X-Gm-Message-State: AOAM5338YLBMH5vZ+g0jjw/nJEwb2Gdh8gTUrNRfN80jaXDhBuWJvmlW
        WrqFH4Mf4ESTGbvqykl9pQMLDw==
X-Google-Smtp-Source: ABdhPJwH6sHMbYw0bfibTBMFevu2APyyP5mfTzhGKY87iYxr9DGfr7SvZdOw18dmiDbafxIDfX+X4g==
X-Received: by 2002:a17:902:7c01:b0:14f:44f2:4fa with SMTP id x1-20020a1709027c0100b0014f44f204famr14212219pll.36.1645334134898;
        Sat, 19 Feb 2022 21:15:34 -0800 (PST)
Received: from localhost.localdomain ([2409:8a28:e61:5860:2995:483c:273c:28ec])
        by smtp.gmail.com with ESMTPSA id y23sm7737907pfa.67.2022.02.19.21.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 21:15:34 -0800 (PST)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        bristot@redhat.com, zhaolei@cn.fujitsu.com, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v3 3/3] sched/cpuacct: remove redundant RCU read lock
Date:   Sun, 20 Feb 2022 13:14:26 +0800
Message-Id: <20220220051426.5274-3-zhouchengming@bytedance.com>
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

The cpuacct_account_field() and it's cgroup v2 wrapper
cgroup_account_cputime_field() is only called from cputime
in task_group_account_field(), which is already in RCU read-side
critical section. So remove these redundant RCU read lock.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 include/linux/cgroup.h | 2 --
 kernel/sched/cpuacct.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 9a109c6ac0e0..1e356c222756 100644
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
index f79f88456d72..d269ede84e85 100644
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
-- 
2.20.1

