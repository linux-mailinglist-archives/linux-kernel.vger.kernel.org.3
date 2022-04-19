Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90169506C61
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 14:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352282AbiDSM0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 08:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352267AbiDSM0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 08:26:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF3636307
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 05:23:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6378D61508
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 12:23:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F28C385A7;
        Tue, 19 Apr 2022 12:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650371012;
        bh=8W6J/a2HTyChmb/5v1B4Mtw37/myuTcF67qxGda3gHM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PrnnTIh5AhzFhFoiXFiPXVu0FlkRXtlQ3HNnyB87U+3oHWL62p6aqVpjH2CjoD9Qw
         rVNXDXaKYNlRH46rsCWqQ/rDkFuTNJ0NWgp5lbdWodabP+WEoUOdXbk2Zz2f55mHTn
         D66oyolipfrjgR9N+54XaFaFj2JgZuktzNU3kbfhF6vr/xInMS0eUtgdhmwzWHE6vk
         s1rSjrVj4nTqVqX0vyxCUIg7+PQ8353LFQ5XMxy3bEsz3tGeXBRccTPLT/lfWdQXXF
         LQvV7GaUaSaieGzU73Ugif9/EMWehKogd0Nzav8vWeZOV04SBt+PZkkreplJG6osYB
         ijL+HbKpXs8Hg==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Zqiang <qiang1.zhang@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 2/3] rcu/nocb: Invert rcu_state.barrier_mutex VS hotplug lock locking order
Date:   Tue, 19 Apr 2022 14:23:19 +0200
Message-Id: <20220419122320.2060902-3-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220419122320.2060902-1-frederic@kernel.org>
References: <20220419122320.2060902-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang1.zhang@intel.com>

In case of failure to spawn either rcuog or rcuo[p] kthreads for a given
rdp, rcu_nocb_rdp_deoffload() needs to be called with the hotplug
lock and the barrier_mutex held. However cpus write lock is already held
while calling rcutree_prepare_cpu(). It's not possible to call
rcu_nocb_rdp_deoffload() from there with just locking the barrier_mutex
or this would result in a locking inversion against
rcu_nocb_cpu_deoffload() which holds both locks in the reverse order.

Simply solve this with inverting the locking order inside
rcu_nocb_cpu_[de]offload(). This will be a pre-requisite to toggle NOCB
states toward cpusets anyway.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree_nocb.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index dac74952e1d1..f2f2cab6285a 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1055,8 +1055,8 @@ int rcu_nocb_cpu_deoffload(int cpu)
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 	int ret = 0;
 
-	mutex_lock(&rcu_state.barrier_mutex);
 	cpus_read_lock();
+	mutex_lock(&rcu_state.barrier_mutex);
 	if (rcu_rdp_is_offloaded(rdp)) {
 		if (cpu_online(cpu)) {
 			ret = work_on_cpu(cpu, rcu_nocb_rdp_deoffload, rdp);
@@ -1067,8 +1067,8 @@ int rcu_nocb_cpu_deoffload(int cpu)
 			ret = -EINVAL;
 		}
 	}
-	cpus_read_unlock();
 	mutex_unlock(&rcu_state.barrier_mutex);
+	cpus_read_unlock();
 
 	return ret;
 }
@@ -1134,8 +1134,8 @@ int rcu_nocb_cpu_offload(int cpu)
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 	int ret = 0;
 
-	mutex_lock(&rcu_state.barrier_mutex);
 	cpus_read_lock();
+	mutex_lock(&rcu_state.barrier_mutex);
 	if (!rcu_rdp_is_offloaded(rdp)) {
 		if (cpu_online(cpu)) {
 			ret = work_on_cpu(cpu, rcu_nocb_rdp_offload, rdp);
@@ -1146,8 +1146,8 @@ int rcu_nocb_cpu_offload(int cpu)
 			ret = -EINVAL;
 		}
 	}
-	cpus_read_unlock();
 	mutex_unlock(&rcu_state.barrier_mutex);
+	cpus_read_unlock();
 
 	return ret;
 }
-- 
2.25.1

