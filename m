Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA2E520BB7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 05:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235141AbiEJDLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 23:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235113AbiEJDLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 23:11:40 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6042620D27B;
        Mon,  9 May 2022 20:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652152063; x=1683688063;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=a8LomB+K+mSpY8RQelZ8YHj1Jqz2+yRpAtEIK/y86CU=;
  b=DRSGag+NPI8jGvp18JfRGftUWxekMLG5VlmT6zbI+GlTYJGWk8eUsI1V
   er3iGRu2rlakz59GUtTwxJHOKk9ATTnB6DOCANTz+8cgpytMlWMozH5sw
   zA8LhFTJ97NesyrRsA0pROqE0uGXsRRyCE8r+0hbiuXmwpySiGASKYKhP
   tn15gvqQixMhTxTv+HLzqdhm8/0MuBcygvmN9aWTGEhZ/jVq60CeiYcfs
   N10CdHQ+wn0ARCj8Nvc2aLgB8j1g6gYzLyDryYSbywe3zFIv0ASxTKyWu
   XRJDpRIBngyQfF2YTIkaWh4HK7RxbC+GiFuuiz6KdCSd+RCdKQ/3ifJwT
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="249774000"
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; 
   d="scan'208";a="249774000"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 20:07:43 -0700
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; 
   d="scan'208";a="565417962"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 20:07:41 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcu: Remove debug_object_active_state() from debug_rcu_head_queue/unqueue()
Date:   Tue, 10 May 2022 11:07:48 +0800
Message-Id: <20220510030748.1814004-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the double call_rcu() detected only need call
debug_object_activate() to check whether the rcu head object is
activated, the rcu head object usage state check is not necessary
and when call rcu_test_debug_objects() the debug_object_active_state()
will output same callstack as debug_object_activate(). so remove
debug_object_active_state() to reduce the output of repeated callstack.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/rcu.h | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 15b96f990774..0604ecd16627 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -179,27 +179,16 @@ static inline unsigned long rcu_seq_diff(unsigned long new, unsigned long old)
  */
 
 #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD
-# define STATE_RCU_HEAD_READY	0
-# define STATE_RCU_HEAD_QUEUED	1
 
 extern const struct debug_obj_descr rcuhead_debug_descr;
 
 static inline int debug_rcu_head_queue(struct rcu_head *head)
 {
-	int r1;
-
-	r1 = debug_object_activate(head, &rcuhead_debug_descr);
-	debug_object_active_state(head, &rcuhead_debug_descr,
-				  STATE_RCU_HEAD_READY,
-				  STATE_RCU_HEAD_QUEUED);
-	return r1;
+	return debug_object_activate(head, &rcuhead_debug_descr);
 }
 
 static inline void debug_rcu_head_unqueue(struct rcu_head *head)
 {
-	debug_object_active_state(head, &rcuhead_debug_descr,
-				  STATE_RCU_HEAD_QUEUED,
-				  STATE_RCU_HEAD_READY);
 	debug_object_deactivate(head, &rcuhead_debug_descr);
 }
 #else	/* !CONFIG_DEBUG_OBJECTS_RCU_HEAD */
-- 
2.25.1

