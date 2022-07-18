Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090705778F4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 02:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbiGRALZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 20:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiGRALW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 20:11:22 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FD81146B;
        Sun, 17 Jul 2022 17:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658103078; x=1689639078;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MhMxb972lT1cyCuWW992BzqSN/Kx1SNbxlpLCrfKF+w=;
  b=XYrICF4RWumwHtDKIwKgJB+ZIDO1O4fTLw9VD+VtpJswPjbKJ5dNUJ/H
   J24xNPgN4EpnKeq1wBae4JCLINg8N8bjDIQ7KoFiEyUrDHotbblfHZnMY
   4Xqp9KfVHiNEXA7xKAGIjejHR6Bq7rpgAUVo7iAEYO5zTiaozMmxxpaeX
   G8FMlSFhmXiPlpSc1X6arWPZbDUjcQXg2NrxUNMuz8TPHQIlbJIX3z4lA
   qHRO3wUUH7gc79CLsaMh4KnCLjFvvSN+024EuLn6NVmnyXifFh0Jx53MW
   6dSgCHMQX2ry9AOR9GIIIa1y1j6xunZ6v6lijF/8RRo5lM3WrIH6sQeT7
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="287246508"
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="287246508"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 17:11:18 -0700
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="655048444"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 17:11:16 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] rcu-tasks: Make RCU Tasks Trace checking for userspace execution
Date:   Mon, 18 Jul 2022 08:16:10 +0800
Message-Id: <20220718001610.263700-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For RCU tasks trace, the userspace execution is also a valid quiescent
state, if the task is in userspace, the ->trc_reader_nesting should be
zero and if the ->trc_reader_special.b.need_qs is not set, set the
tasks ->trc_reader_special.b.need_qs is TRC_NEED_QS_CHECKED, this cause
grace-period kthread remove it from holdout list if it remains here.

This commit add rcu_tasks_trace_qs() to rcu_flavor_sched_clock_irq()
when the kernel built with no PREEMPT_RCU.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 v1->v2:
 Fix build error due to undeclared rcu_tasks_trace_qs(), note in no-PREEMPT_RCU
 kernel, the RCU Tasks is replaced by RCU, so rcu_note_voluntary_context_switch()
 only include rcu_tasks_trace_qs().

 kernel/rcu/tree_plugin.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 4152816dd29f..5fb0b2dd24fd 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -976,7 +976,7 @@ static void rcu_flavor_sched_clock_irq(int user)
 		 * neither access nor modify, at least not while the
 		 * corresponding CPU is online.
 		 */
-
+		rcu_note_voluntary_context_switch(current);
 		rcu_qs();
 	}
 }
-- 
2.25.1

