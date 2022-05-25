Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E5A53463F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 00:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345418AbiEYWL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 18:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345347AbiEYWLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 18:11:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75B513CEC;
        Wed, 25 May 2022 15:11:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 708C961AD8;
        Wed, 25 May 2022 22:11:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C9DC34119;
        Wed, 25 May 2022 22:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653516671;
        bh=3zniIbPdy7+9dNP1xUFhfBA0uM9hAlLVYqm9/0P36DE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z8awa+Mbgjc4sfpESzBF+k72TBoJ7yG8rlly8BaIhqNwqCWJo7o3y2eFhWB/l0oa/
         Tx9HTmfhNaH8d0u3VIhejG1rh+HTjQoCl1sxu8p01i1l1CqQ/I7ed0yfpF1oYnfFbi
         WYR8VsejPW7OgHmrYM2C8Qv1wSQg6lYsJb2iTz0s8qsaHKM1vhwd41ipcYjV8i9K+e
         EQV5HAP3JHE5qGcLYvVPHawJ4dUWU1B7VvMbCTcx4aj0sA86BqyH6BkFEVMnyO5R8o
         lQOG8ZIbKnqb1yW6wrf27ZJ7engpEfr1QDykVVdZX25aSp9zlokvqbB75qWZE1OF04
         k3q6HHEXq4MUQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Waiman Long <longman@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        rcu@vger.kernel.org
Subject: [PATCH 3/4] sched/isolation: Infrastructure to support rcu nocb cpumask changes
Date:   Thu, 26 May 2022 00:10:54 +0200
Message-Id: <20220525221055.1152307-4-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220525221055.1152307-1-frederic@kernel.org>
References: <20220525221055.1152307-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a minimal infrastructure to change the housekeeping cpumasks.
For now only RCU NOCB cpumask is handled.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Zefan Li <lizefan.x@bytedance.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Phil Auld <pauld@redhat.com>
Cc: Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 include/linux/sched/isolation.h | 13 +++++++++++
 kernel/sched/isolation.c        | 38 +++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index 8c15abd67aed..c6d0e3f83a20 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -25,6 +25,8 @@ extern const struct cpumask *housekeeping_cpumask(enum hk_type type);
 extern bool housekeeping_enabled(enum hk_type type);
 extern void housekeeping_affine(struct task_struct *t, enum hk_type type);
 extern bool housekeeping_test_cpu(int cpu, enum hk_type type);
+extern int housekeeping_cpumask_set(struct cpumask *cpumask, enum hk_type type);
+extern int housekeeping_cpumask_clear(struct cpumask *cpumask, enum hk_type type);
 extern void __init housekeeping_init(void);
 
 #else
@@ -46,6 +48,17 @@ static inline bool housekeeping_enabled(enum hk_type type)
 
 static inline void housekeeping_affine(struct task_struct *t,
 				       enum hk_type type) { }
+
+static inline int housekeeping_cpumask_set(struct cpumask *cpumask, enum hk_type type)
+{
+	return -EINVAL;
+}
+
+static inline int housekeeping_cpumask_clear(struct cpumask *cpumask, enum hk_type type)
+{
+	return -EINVAL;
+}
+
 static inline void housekeeping_init(void) { }
 #endif /* CONFIG_CPU_ISOLATION */
 
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 373d42c707bc..ab4aba795c01 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -79,6 +79,44 @@ bool housekeeping_test_cpu(int cpu, enum hk_type type)
 }
 EXPORT_SYMBOL_GPL(housekeeping_test_cpu);
 
+static int housekeeping_cpumask_update(struct cpumask *cpumask,
+				       enum hk_type type, bool on)
+{
+	int err;
+
+	switch (type) {
+	case HK_TYPE_RCU:
+		err = rcu_nocb_cpumask_update(cpumask, on);
+		break;
+	default:
+		err = -EINVAL;
+	}
+
+	if (err >= 0) {
+		if (on) {
+			cpumask_or(housekeeping.cpumasks[type],
+				   housekeeping.cpumasks[type],
+				   cpumask);
+		} else {
+			cpumask_andnot(housekeeping.cpumasks[type],
+				       housekeeping.cpumasks[type],
+				       cpumask);
+		}
+	}
+
+	return err;
+}
+
+int housekeeping_cpumask_set(struct cpumask *cpumask, enum hk_type type)
+{
+	return housekeeping_cpumask_update(cpumask, type, true);
+}
+
+int housekeeping_cpumask_clear(struct cpumask *cpumask, enum hk_type type)
+{
+	return housekeeping_cpumask_update(cpumask, type, false);
+}
+
 void __init housekeeping_init(void)
 {
 	enum hk_type type;
-- 
2.25.1

