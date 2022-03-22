Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0464E3F4D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 14:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235295AbiCVNSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 09:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235280AbiCVNSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 09:18:48 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC2885BF2;
        Tue, 22 Mar 2022 06:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647955041; x=1679491041;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uMUVcf+gEIjrdXadMEnObr5jiYSkzHM/l0NttbKfDx4=;
  b=AsQbe+Vm61YQ1EK7seYK6Y34B2GNZ9+cnRk3H/o2u5qeGHHOk7Orj0L+
   1bFULHxQ29uZ45UdB5+3otlp5dwO/2q7ibB2d/8IKlPxXUqFvv/jWYyCj
   x33yDQ0g7lqn22CzmRgsffIrtGnJygoAC7PpOiW1x1f8484jSvdq8SRCQ
   159Ndfu25gQO4QIVtC1RscMgv2IFFGtPmtlpjJJttsP3J4K7qTPGKzFzk
   eiGiztvV6MvHCT3GaQkTtV7LWLiXEyGIusb+bSYrmRFezyohFMECJ03U5
   WHcCiIXBz4RTGmw1grSNDFQB9k5dlqgLB5sXQrUNLMB1/ZrUYVitxI2UR
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="237755609"
X-IronPort-AV: E=Sophos;i="5.90,201,1643702400"; 
   d="scan'208";a="237755609"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 06:17:20 -0700
X-IronPort-AV: E=Sophos;i="5.90,201,1643702400"; 
   d="scan'208";a="543686441"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 06:17:19 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] rcu: Invert the locking dependency order between rcu_state.barrier_mutex and hotplug lock
Date:   Tue, 22 Mar 2022 21:17:53 +0800
Message-Id: <20220322131753.1680329-3-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220322131753.1680329-1-qiang1.zhang@intel.com>
References: <20220322131753.1680329-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When call rcutree_prepare_cpu(), the cpus write lock has been held,
just lock the barrier_mutex before calling rcu_nocb_rdp_deoffload()
from failure path. therefore, invert the locking dependency order.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tree_nocb.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 154934f3daa9..e3d1bd26d6eb 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1074,8 +1074,8 @@ int rcu_nocb_cpu_deoffload(int cpu)
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 	int ret = 0;
 
-	mutex_lock(&rcu_state.barrier_mutex);
 	cpus_read_lock();
+	mutex_lock(&rcu_state.barrier_mutex);
 	if (rcu_rdp_is_offloaded(rdp)) {
 		if (cpu_online(cpu)) {
 			ret = work_on_cpu(cpu, rcu_nocb_rdp_deoffload, rdp);
@@ -1086,8 +1086,8 @@ int rcu_nocb_cpu_deoffload(int cpu)
 			ret = -EINVAL;
 		}
 	}
-	cpus_read_unlock();
 	mutex_unlock(&rcu_state.barrier_mutex);
+	cpus_read_unlock();
 
 	return ret;
 }
@@ -1169,8 +1169,8 @@ int rcu_nocb_cpu_offload(int cpu)
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 	int ret = 0;
 
-	mutex_lock(&rcu_state.barrier_mutex);
 	cpus_read_lock();
+	mutex_lock(&rcu_state.barrier_mutex);
 	if (!rcu_rdp_is_offloaded(rdp)) {
 		if (cpu_online(cpu)) {
 			ret = work_on_cpu(cpu, rcu_nocb_rdp_offload, rdp);
@@ -1181,8 +1181,8 @@ int rcu_nocb_cpu_offload(int cpu)
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

