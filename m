Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597ED57147A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbiGLI0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbiGLI0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:26:49 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E4B79EC3;
        Tue, 12 Jul 2022 01:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657614409; x=1689150409;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=raPMXH9QSNw3E3vaUMbJH7s6s1TJ9z6kiv/MTcKgZRE=;
  b=ikgYxNTXueBadD8ofvd2ILIodkKgCBqpDZbojYYb/ifz97oN66rg+GaK
   q2fGKDAUvb6klrcWQGfmYiFFgoaliN27bQJXYmGKDtZp52rLILI3H3RNt
   DfPdyD0MxhBO5IOibHzof1V//kVGplLWFqKq8TF88ZwafEsCKiBj9Q9TC
   CCJ29VIZIIm4fBwhZxuskX9foWf4A6MTQLSze0+9TuKwIzjfWefAh8lH1
   p2QJp1AwrSfwe2Dj0MXQB5a8QRfVLdcY2o7sLZmK5xCn8dVQFR5S8xlFd
   oGrvIBX0KNnj/pPY/W3fE/AHEdp9PbVTmdSO6sn4dGRwiZio2aMjz4laf
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="346556766"
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="346556766"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 01:26:48 -0700
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="622418047"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 01:26:45 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] rcu-tasks: Make synchronize_rcu_tasks_generic() no-ops on early booting
Date:   Tue, 12 Jul 2022 16:26:06 +0800
Message-Id: <20220712082606.3662616-3-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220712082606.3662616-1-qiang1.zhang@intel.com>
References: <20220712082606.3662616-1-qiang1.zhang@intel.com>
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

When the rcu_scheduler_active variable is RCU_SCHEDULER_INACTIVE and not
yet converted to RCU_SCHEDULER_INIT, there is only idle task, any legal
call synchronize_rcu_tasks_generic() is a quiescent state. this commit
make synchronize_rcu_tasks_generic() no-ops when the rcu_scheduler_active
variable is RCU_SCHEDULER_INACTIVE.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tasks.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 469bf2a3b505..0237e765c28e 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -560,8 +560,9 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 static void synchronize_rcu_tasks_generic(struct rcu_tasks *rtp)
 {
 	/* Complain if the scheduler has not started.  */
-	WARN_ONCE(rcu_scheduler_active == RCU_SCHEDULER_INACTIVE,
-			 "synchronize_rcu_tasks called too soon");
+	if (WARN_ONCE(rcu_scheduler_active == RCU_SCHEDULER_INACTIVE,
+			 "synchronize_rcu_tasks called too soon"))
+		return;
 
 	// If the grace-period kthread is running, use it.
 	if (READ_ONCE(rtp->kthread_ptr)) {
-- 
2.25.1

