Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED3F579098
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 04:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236770AbiGSCKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 22:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236622AbiGSCKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 22:10:23 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3CF2A97F;
        Mon, 18 Jul 2022 19:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658196622; x=1689732622;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HuWT1Qbmsp6FL1I6szP12YNCNY1tyhftj3GbBMYoxiE=;
  b=Lm/wMDLEXuYrBVUYPNIcTpk0SxRKKzKCOSTEJpnLhRctHlyd+n8/dzyI
   D4cNH0XM6aiQ6cyoKGApqoRXHu5Pffqlhw71MjwABs9BIjf8dmCFRH9uO
   0J5zY6zf5RGIxD5L713tDqLo4oCtPJ322+PlPNQFYFibxF54Mb6OS6fMW
   QEjplEfwFu2iv/8Ii5MN95e+v2TeKzF08g1nNaiS3EEzuGbpmVZmKKkj3
   qTZNVudKpljaNADXcqwIPBiNZp1OyAnLKAPOgKwSGNdA7bqLYvc2kiGT5
   0dDQpZ+Bw0N7QNEET36lJ2Tk9Kza0sC1uiDHMDZt8jXd68/Ublls6J0FD
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="266143902"
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="266143902"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 19:10:22 -0700
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="655536034"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 19:10:20 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] rcu-tasks: Make RCU Tasks Trace checking for userspace execution
Date:   Tue, 19 Jul 2022 10:15:13 +0800
Message-Id: <20220719021513.432306-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For RCU tasks trace, the userspace execution is also a valid quiescent
state, when scheduling-clock interrupt handler interrupts the task is
in userspace. 

if the ->trc_reader_nesting is zero, and the ->trc_reader_special.b.need_qs
is not set, set the tasks ->trc_reader_special.b.need_qs is
TRC_NEED_QS_CHECKED, this cause grace-period kthread remove it from holdout
list if it remains here.

If the ->trc_reader_nesting is not zero(if one of the functions in the
scheduling-clock interrupt handler were traced/instrumented), and starts a
new RCU tasks trace grace period, when grace period kthread scan running
tasks on each CPU, this running uasks will be inserted into hold list.

This commit add rcu_tasks_trace_qs() to rcu_flavor_sched_clock_irq()
when the kernel built with no PREEMPT_RCU.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 v1->v2:
 Fix build error due to undeclared rcu_tasks_trace_qs(), note in no-PREEMPT_RCU
 kernel, the RCU Tasks is replaced by RCU, so rcu_note_voluntary_context_switch()
 only include rcu_tasks_trace_qs().
 
 v2->v3:
 Modify commit information.

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

