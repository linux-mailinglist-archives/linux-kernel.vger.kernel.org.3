Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1D5554647
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354781AbiFVKgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 06:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346319AbiFVKgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 06:36:13 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A1B3B571;
        Wed, 22 Jun 2022 03:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655894172; x=1687430172;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ab1KhP6RlfLDUpqQx5KxRjWRdxnAQ1ojvkbHJLNruCA=;
  b=GcM9hHVzjAthPztuxRujmN3z1Eqp2ZNzz2qZeUy3QsharapGACJV9cQT
   KgHs0F2EuW4JvIhDxmDod9WhWiH+AQ5KJRYS9J2ZHAEDgDCBrzdXGCrCu
   98iEYj9gwqCh5xfeiloak5UaIqcvBiDFJi7cUJVKyAZLM9LwE3WeTLNVA
   LSJWSdXlYQrUw0lwwIZKa6Kb63AcVaSCpfVql0bz3hxCVF21/TCRgpMfk
   yZZ/I1xvh6N2zMDZGFsA5o7gWEpZ5/n82UqlMJceMVB9wryD1WdS4pJdT
   hgxMpkAe4AjCHklUWH5uk1V786ebMmTEpuLNwuYnJVtnlgORboK0H1/wW
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="281456222"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="281456222"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 03:36:12 -0700
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="644131142"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 03:36:10 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcu: Add exp QS check in rcu_exp_handler() for no-preemptible expedited RCU
Date:   Wed, 22 Jun 2022 18:35:49 +0800
Message-Id: <20220622103549.2840087-1-qiang1.zhang@intel.com>
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

In CONFIG_PREEMPT=n and CONFIG_PREEMPT_COUNT=y kernel, after a exp
grace period begins, if detected current CPU enters idle in
rcu_exp_handler() IPI handler, will immediately report the exp QS of the
current cpu, at this time, maybe not being in an RCU read-side critical
section, but need wait until rcu-softirq or sched-clock irq or sched-switch
occurs on current CPU to check and report exp QS.

This commit add a exp QS check in rcu_exp_handler(), when not being
in an RCU read-side critical section, report exp QS earlier.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tree_exp.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index be667583a554..34f08267410f 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -828,11 +828,14 @@ static void rcu_exp_handler(void *unused)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 	struct rcu_node *rnp = rdp->mynode;
+	bool preempt_bh_disabled =
+				!!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK));
 
 	if (!(READ_ONCE(rnp->expmask) & rdp->grpmask) ||
 	    __this_cpu_read(rcu_data.cpu_no_qs.b.exp))
 		return;
-	if (rcu_is_cpu_rrupt_from_idle()) {
+	if (rcu_is_cpu_rrupt_from_idle() ||
+			(IS_ENABLED(CONFIG_PREEMPT_COUNT) && !preempt_bh_disabled)) {
 		rcu_report_exp_rdp(this_cpu_ptr(&rcu_data));
 		return;
 	}
-- 
2.25.1

