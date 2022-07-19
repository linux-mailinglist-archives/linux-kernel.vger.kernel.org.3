Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD4D5791FE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 06:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236401AbiGSEeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 00:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234905AbiGSEeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 00:34:11 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58F5DFE3;
        Mon, 18 Jul 2022 21:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658205250; x=1689741250;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Oo5mFvEdxcmvFkZNTfVI0PHChwTIjii9rMQrX+JWyx4=;
  b=aGhQs1Q+4LJnezZhVG9gtXebjgZ2Hd96UBWu5VIyTQihu71K0yoGLEgv
   WA433JCMOVcsl3yYGjWH7+8X/H7PQ+C/MUF1gcZR6hEkx7iRFf7SPluFz
   iHJEXVzZcgEGAhz5Umy9SAlMgs6YEBRXh7NKzaVfxIPj6hoRzVtyHLSD6
   a1+OL9/Q+RBgZZHpS7YYS1+q1l52hHb/tOYA8EyX2ZEPZjyHCaxyyMIvq
   Uu2JOkJY/Rv/gLnIrIBPfrIzmlZJhSOKcs6O/RUy1ApdDV/sal98cspae
   xRFg+iJyG05Ny8i/nkQ0u6gefcJAnjQ6iqHE/CG0xhE+kBJbuT04MdMC4
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="312073438"
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="312073438"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 21:34:10 -0700
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="625010656"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 21:34:08 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] rcu-tasks: Make RCU Tasks Trace checking for userspace execution
Date:   Tue, 19 Jul 2022 12:39:00 +0800
Message-Id: <20220719043900.437443-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For RCU tasks trace, the userspace execution is also a valid quiescent.
when the scheduling clock interrupt handler interrupts current task and
check current tasks running in userspace, then invoke rcu_tasks_trace_qs()
to check quiescent state, usually, the current tasks ->trc_reader_nesting
should be zero, if the current tasks ->trc_reader_special.b.need_qs is not
set, set TRC_NEED_QS_CHECKED to ->trc_reader_special.b.need_qs. this cause
grace period kthread remove task from holdout list if current tasks is in
holdout list.

But sometimes, although the scheduling clock interrupt handler check
current tasks running in userspace, but the current tasks
->trc_reader_nesting maybe not zero (if one of the functions in the
scheduling-clock interrupt handler were traced/instrumented), and then
invoke rcu_tasks_trace_qs(), if the current tasks ->trc_reader_nesting
is still not zero, the current tasks will be insert local CPU blocked list.
if starts a new RCU tasks trace grace period and the grace period kthread
scan running tasks on each CPU, find that current tasks is running, will
also insert it to hold out list.

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

