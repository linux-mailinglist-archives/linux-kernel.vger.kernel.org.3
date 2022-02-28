Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570EE4C65C4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 10:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbiB1Jga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 04:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbiB1Jg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 04:36:28 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316C85BD31
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 01:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646040949; x=1677576949;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NweViYYo1lLcSvZJPVLclYJYDxYs37WMqWxfMCuRKMw=;
  b=oB7lmLwFsuBwpNyG0sLn/dZdfVoROTDSedeAW+QSXDV0cExWbZogwnEP
   ikbwnD4TlzEd1j/bqvxr5Jq+UiHutlJGyWd7/cbQxJ6EBWp87Pt2LC/fd
   n5IAkYHheN7jzlPKoPhTyWAIWBF/hG/5n2Gs8LF6RtrYZarJvS82LlU9c
   lSqIYJlLFwQ+yCgn1xzWz4n7n0WXJmaJcovMdPiDInaB+naY+1bDxY+2u
   g+Zr+XivmdeuUqbphNdvwCgBbxomJgVw8Kk8bYr2OpqL1wPGx5+68Cfpq
   M6lcV3yxpDE+YVowNbF/BbPW1XjKWFDj5U30riSNR3xo2Hty+Ehn9xJ3+
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10271"; a="252573377"
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="252573377"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 01:35:40 -0800
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="550167403"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 01:35:39 -0800
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] rcu/nocb: Clear rdp offloaded flags when rcuop/rcuog kthreads spawn failed
Date:   Mon, 28 Feb 2022 17:36:29 +0800
Message-Id: <20220228093629.3746473-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_RCU_NOCB_CPU is enabled and 'rcu_nocbs' is set, the rcuop
and rcuog kthreads is created. however the rcuop or rcuog kthreads
creation may fail, if failed, clear rdp offloaded flags.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tree_nocb.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 46694e13398a..94b279147954 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1246,7 +1246,7 @@ static void rcu_spawn_cpu_nocb_kthread(int cpu)
 				"rcuog/%d", rdp_gp->cpu);
 		if (WARN_ONCE(IS_ERR(t), "%s: Could not start rcuo GP kthread, OOM is now expected behavior\n", __func__)) {
 			mutex_unlock(&rdp_gp->nocb_gp_kthread_mutex);
-			return;
+			goto end;
 		}
 		WRITE_ONCE(rdp_gp->nocb_gp_kthread, t);
 		if (kthread_prio)
@@ -1258,12 +1258,22 @@ static void rcu_spawn_cpu_nocb_kthread(int cpu)
 	t = kthread_run(rcu_nocb_cb_kthread, rdp,
 			"rcuo%c/%d", rcu_state.abbr, cpu);
 	if (WARN_ONCE(IS_ERR(t), "%s: Could not start rcuo CB kthread, OOM is now expected behavior\n", __func__))
-		return;
+		goto end;
 
 	if (kthread_prio)
 		sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
 	WRITE_ONCE(rdp->nocb_cb_kthread, t);
 	WRITE_ONCE(rdp->nocb_gp_kthread, rdp_gp->nocb_gp_kthread);
+	return;
+end:
+	if (cpumask_test_cpu(cpu, rcu_nocb_mask)) {
+		rcu_segcblist_offload(&rdp->cblist, false);
+		rcu_segcblist_clear_flags(&rdp->cblist,
+				SEGCBLIST_KTHREAD_CB | SEGCBLIST_KTHREAD_GP);
+		rcu_segcblist_clear_flags(&rdp->cblist, SEGCBLIST_LOCKING);
+		rcu_segcblist_set_flags(&rdp->cblist, SEGCBLIST_RCU_CORE);
+	}
+	return;
 }
 
 /* How many CB CPU IDs per GP kthread?  Default of -1 for sqrt(nr_cpu_ids). */
-- 
2.25.1

