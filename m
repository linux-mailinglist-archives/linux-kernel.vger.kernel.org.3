Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5724DD5CD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 09:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbiCRIIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 04:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbiCRIID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 04:08:03 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB907234573;
        Fri, 18 Mar 2022 01:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647590805; x=1679126805;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MDKfpbmqsYBc9QIWNSmIFA0nJUUciIBV2RazBxDZDXk=;
  b=C15T3OZd5fOvNc2Og9VzbjO5UKbIro+Tc7ySpgVwA1ZVITjpmaSmFf0W
   bc2OzvCQewAMXz43eIq7anLCshJg4KxtWknsIfUtc0ymZrw3TojKVJZbs
   PMmw5LII1RolMdbsJzg/1onyc0OxAqq5JUc08wdh5fqS2bh/WPG4391Pm
   Mr6t8mlGfQX6s1G+NDqgqZq0A57XiT2Q24Tbv1M4ArAaH0v8KqMu787Cu
   ELz6MiosDFeHHQxbij1iYtdEZaj4tUNUfl6gB/LHaHPokTdjJ8UTgGH26
   Pnx7sCamyHJHGy+VNpJCP4n5tBc7e9xfHHVlcF425mrbXGMsQcv9HL1GD
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="256817481"
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="256817481"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 01:06:44 -0700
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="541734794"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 01:06:42 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] rcu: Invert the locking dependency order between rcu_state.barrier_mutex and hotplug lock
Date:   Fri, 18 Mar 2022 16:07:19 +0800
Message-Id: <20220318080719.1501471-3-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220318080719.1501471-1-qiang1.zhang@intel.com>
References: <20220318080719.1501471-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index e8265e4ec5ee..fe0063a23fbb 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1072,8 +1072,8 @@ int rcu_nocb_cpu_deoffload(int cpu)
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 	int ret = 0;
 
-	mutex_lock(&rcu_state.barrier_mutex);
 	cpus_read_lock();
+	mutex_lock(&rcu_state.barrier_mutex);
 	if (rcu_rdp_is_offloaded(rdp)) {
 		if (cpu_online(cpu)) {
 			ret = work_on_cpu(cpu, rcu_nocb_rdp_deoffload, rdp);
@@ -1084,8 +1084,8 @@ int rcu_nocb_cpu_deoffload(int cpu)
 			ret = -EINVAL;
 		}
 	}
-	cpus_read_unlock();
 	mutex_unlock(&rcu_state.barrier_mutex);
+	cpus_read_unlock();
 
 	return ret;
 }
@@ -1167,8 +1167,8 @@ int rcu_nocb_cpu_offload(int cpu)
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 	int ret = 0;
 
-	mutex_lock(&rcu_state.barrier_mutex);
 	cpus_read_lock();
+	mutex_lock(&rcu_state.barrier_mutex);
 	if (!rcu_rdp_is_offloaded(rdp)) {
 		if (cpu_online(cpu)) {
 			ret = work_on_cpu(cpu, rcu_nocb_rdp_offload, rdp);
@@ -1179,8 +1179,8 @@ int rcu_nocb_cpu_offload(int cpu)
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

