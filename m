Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9B355109A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 08:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238945AbiFTGnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 02:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238918AbiFTGmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 02:42:53 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF12E086;
        Sun, 19 Jun 2022 23:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655707365; x=1687243365;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iGc2PxBwPlRkLk2QIWhr+rQbT0gr6aPIOezMrSngiUQ=;
  b=hWjHPYjmLlLGJCth9p+IkBaMoUqzV/bRhCvZSSgC0catCOdAqVk2i9a3
   PlR13NUouHQIMZAxkL6qqH7VG5H4eLcFbO0K/GHbfFwOO0gKxL6jiAcZ3
   W7mRCW0hAqKyUY0SiDpEdLL9ZAGZyaKie8PngtBv3kTn2jiJfoBCeteoK
   PczPq0ugumvc6foODXGPTbXVYhvzlmOp0ipKwmu4bVR0RNTmEIIWm1OXt
   cFz8lQgWmZsxQ6HoW/Szcy7aWodjQ0Dmr8yZi7lbxiZH0xxCMCdw+n3ke
   c0eB3MKyPqT8UJh1fSdSQfVTb9z7zgHeS45sH1wV4fyuoh41J+9RCgodE
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="280874190"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="280874190"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2022 23:42:45 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="832971352"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2022 23:42:43 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcu: Update rcu_preempt_deferred_qs() comments for no preemptible RCU
Date:   Mon, 20 Jun 2022 14:42:24 +0800
Message-Id: <20220620064224.2630382-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For no preemptible RCU, the rcu_preempt_deferred_qs() only report
expedited QS state of current CPU, since preemption does not occur
in RCU critical sections, there are no tasks insert to leaf rnp
blocked-tasks list, that is to say the tasks structure's ->rcu_blocked_node
and the leaf rnp structure's  ->blkd_tasks are always empty.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tree_plugin.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index dc78726b993f..99424c2da5db 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -932,10 +932,12 @@ static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
 	return false;
 }
 
-// Except that we do need to respond to a request by an expedited grace
-// period for a quiescent state from this CPU.  Note that requests from
-// tasks are handled when removing the task from the blocked-tasks list
-// below.
+/*
+ * Except that we do need to respond to a request by an expedited grace
+ * period for a quiescent state from this CPU.  Note that for no preemptible
+ * RCU, since preemption does not occur in RCU critical sections, so the
+ * leaf rnp's blocked-tasks list is always empty.
+ */
 void rcu_preempt_deferred_qs(struct task_struct *t)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
-- 
2.25.1

