Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F173552712
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244457AbiFTWpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244303AbiFTWpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:45:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4674014022;
        Mon, 20 Jun 2022 15:45:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4C866137C;
        Mon, 20 Jun 2022 22:45:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ADD3C341C5;
        Mon, 20 Jun 2022 22:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765105;
        bh=J/mJiAf5BiNxtLCxXf+imq/vEjNCEVMz8bfuRKWJtpg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pVgRaCDO9Jrh+30vuXL5TFNTmAzz0mYEbk0girSTVzUOWTuuhvAnw08sAkbtxUFkt
         bwLW5H7tG2b2NQF8jHls7oLlq+Nf1x6a00skS3xRGeHn7vqAOIiNtrGVzdbcHYWFEt
         ra0SYmO4z+9cL4RVX9Oi9YFk4uzxKz0UwrtstPiF2jv9Ep4omLSAC/P/o3tuG6l+P2
         0UZ0nIwBrJB+kI441fxtpMTJ0TXq9HVrw7ERgcUjdatdWgrdgOeNpnPNy4Lr9Ml0aV
         kE/HqfTIrrOnvm3kaeL74/8X/iTD7fOQ/GFqWAb08hWlQOu6Q0jybxst4NnOGm2IL7
         ikMJv1z/mnUYg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E97AA5C05C8; Mon, 20 Jun 2022 15:45:04 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Zqiang <qiang1.zhang@intel.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 2/7] rcu/nocb: Invert rcu_state.barrier_mutex VS hotplug lock locking order
Date:   Mon, 20 Jun 2022 15:44:58 -0700
Message-Id: <20220620224503.3841196-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620224455.GA3840881@paulmck-ThinkPad-P17-Gen-1>
References: <20220620224455.GA3840881@paulmck-ThinkPad-P17-Gen-1>
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
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_nocb.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index dac74952e1d1b..f2f2cab6285a1 100644
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
2.31.1.189.g2e36527f23

