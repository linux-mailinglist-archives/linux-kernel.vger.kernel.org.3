Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA65A571479
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbiGLI0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbiGLI0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:26:47 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2710D9FE32;
        Tue, 12 Jul 2022 01:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657614407; x=1689150407;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hEG3bam6mQkAnbScvVr12FW+q7oVU3bFp38DqJk5n6Q=;
  b=UO1+z+obfPnMN8rIHa1N3Q07iDWyoMB+2VbhLrjBeinRo491Q53Jd9sN
   kBAD5NPtMNls1F0mEIk35VCQ1bQ1x6cDMMZAfHS89ilNyWHaQIEh93ACk
   kxkItz4DpB5uShX2sJRm8JNncjWpLEFLLmSyeJkneXfT1xpOxHPyiTqdC
   hwgtUIK1/NxLfMgG41v1wRHg1QscDrzWsbPmFtdVibudVpyjasA9yxivk
   Prt9TAETTbNEy3mUyzeDKWoBrn/qNgz+uwO4+2w1pIm81kyAayS94kjjw
   sHAUiSniEU+RWw5AWt5FedsGpLcdBxH2XgPzmsJY0h7EzPD16tqi+jIZr
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="346556759"
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="346556759"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 01:26:46 -0700
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="622418031"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 01:26:43 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] rcu-tasks: Convert RCU_LOCKDEP_WARN() to WARN_ONCE()
Date:   Tue, 12 Jul 2022 16:26:05 +0800
Message-Id: <20220712082606.3662616-2-qiang1.zhang@intel.com>
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

For kernel build with CONFIG_PROVE_RCU=y and CONFIG_DEBUG_LOCK_ALLOC=y,
when the synchronize_rcu_tasks_generic() called occurs during the
rcu_scheduler_active variable is RCU_SCHEDULER_INACTIVE, the warnings
will be trigger, however the warnings is not actually triggered because
the debug_lockdep_rcu_enabled() return false(the rcu_scheduler_active !=
RCU_SCHEDULER_INACTIVE condition is false).

This commit replace RCU_LOCKDEP_WARN() with WARN_ONCE() to trigger
warnings.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tasks.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 83c7e6620d40..469bf2a3b505 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -560,7 +560,7 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 static void synchronize_rcu_tasks_generic(struct rcu_tasks *rtp)
 {
 	/* Complain if the scheduler has not started.  */
-	RCU_LOCKDEP_WARN(rcu_scheduler_active == RCU_SCHEDULER_INACTIVE,
+	WARN_ONCE(rcu_scheduler_active == RCU_SCHEDULER_INACTIVE,
 			 "synchronize_rcu_tasks called too soon");
 
 	// If the grace-period kthread is running, use it.
-- 
2.25.1

