Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8487B5335DE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 05:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243163AbiEYDeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 23:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242067AbiEYDef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 23:34:35 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A1F7893F;
        Tue, 24 May 2022 20:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653449673; x=1684985673;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KdtnY983uARnCJjXy5Kw61Z7shQrGiGIoJu3KXw7P98=;
  b=T+KoRKHF7lO9uRrdHk4YeF7+aA56rtnkL7csqlG1hCf1ekVuZMYDUjVd
   1XViD1pm9g9xr5FP6Yu00JQTH1NKaQsWM1sWy2j9gO1oPLbRirwYRc60X
   GOJToSVptFTz7LHc4zYz/n916pcLvMwKorG9VEy4Kxx+kkgXqjKKwfBub
   Os5RkGwqFM24ldMnA7TJwlWmq13jx46FMmNMWQdAVpwGCqtTUIsaIXaPm
   TSLsrkZgJG+CWlPiNuW3R8AxcbM0rffUfdeWG2MtS9Aro4KvVVwVEPUVt
   VmC7iGuyr999fbfDBoxsQzxva4Zogr+6mM3ATQyYbQ/e5dkohcsXAcQ9m
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="261316106"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="261316106"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 20:34:33 -0700
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="548798018"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 20:34:32 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcu: Fix incorrect judgment condition in show_rcu_nocb_state()
Date:   Wed, 25 May 2022 11:34:30 +0800
Message-Id: <20220525033430.1953349-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When check the 'rdp->nocb_cb_kthread' tasks exists, if is true, however
the output is the cpu where 'rdp->nocb_gp_kthread' is located. this
ensure that the tasks in the judgment condition and the tasks of the
cpu where the output tasks are located are the same tasks.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tree_nocb.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index fa8e4f82e60c..f4ee81d119c8 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1438,8 +1438,8 @@ static void show_rcu_nocb_gp_state(struct rcu_data *rdp)
 		(long)rdp->nocb_gp_seq,
 		rnp->grplo, rnp->grphi, READ_ONCE(rdp->nocb_gp_loops),
 		rdp->nocb_gp_kthread ? task_state_to_char(rdp->nocb_gp_kthread) : '.',
-		rdp->nocb_cb_kthread ? (int)task_cpu(rdp->nocb_gp_kthread) : -1,
-		show_rcu_should_be_on_cpu(rdp->nocb_cb_kthread));
+		rdp->nocb_gp_kthread ? (int)task_cpu(rdp->nocb_gp_kthread) : -1,
+		show_rcu_should_be_on_cpu(rdp->nocb_gp_kthread));
 }
 
 /* Dump out nocb kthread state for the specified rcu_data structure. */
@@ -1483,7 +1483,7 @@ static void show_rcu_nocb_state(struct rcu_data *rdp)
 		".B"[!!rcu_cblist_n_cbs(&rdp->nocb_bypass)],
 		rcu_segcblist_n_cbs(&rdp->cblist),
 		rdp->nocb_cb_kthread ? task_state_to_char(rdp->nocb_cb_kthread) : '.',
-		rdp->nocb_cb_kthread ? (int)task_cpu(rdp->nocb_gp_kthread) : -1,
+		rdp->nocb_cb_kthread ? (int)task_cpu(rdp->nocb_cb_kthread) : -1,
 		show_rcu_should_be_on_cpu(rdp->nocb_cb_kthread));
 
 	/* It is OK for GP kthreads to have GP state. */
-- 
2.25.1

