Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 806DC49F1B2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 04:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345635AbiA1DNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 22:13:32 -0500
Received: from mga17.intel.com ([192.55.52.151]:39938 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242230AbiA1DN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 22:13:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643339609; x=1674875609;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/LmCgpYiJBrJsf8AATV8fsiaEKrBmaCM1obCwdAjp24=;
  b=ecZKNutFLqH5p/zslw1Qndt2PDsBFFB6fIBpvTSE5s+oFk0fb5M8+EZJ
   X7EItUo+JTDD8N/6Q5ytRhz9GSHk9/ik7KLISoaUEATcEKdbRmSJl+nDd
   S1Dt8Xh/WQDjtVOEdUCyJFGmEjHdcJRhb3/M4sDqR3J3qhhabV0uJHy99
   x/N0R6F2fApHOuUgTxYt7pe55aL4I2nfNpJpGPV075UB12NFEDz68xYZX
   4tTjviLvWumHRtH8wHLZ1kY+/gvaGIPOKbWZVOXcs/HJLwg6rWdFdM421
   fLCk+iXknJgnLQiAEOiXJEIb56rbYxlXT3SyVyKjpusFtGA8AGzPtMjwu
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="227702447"
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="227702447"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 19:13:29 -0800
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="535960378"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 19:13:27 -0800
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org
Cc:     linux-kernel@vger.kernel.org, qiang1.zhang@intel.com
Subject: [PATCH] rcu: When rcuog kthreads is in polling mode, wakeup waitqueue is not requried
Date:   Fri, 28 Jan 2022 11:13:46 +0800
Message-Id: <20220128031346.157961-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When grace period cleanup, the rcuog kthreads that waiting in sq
waitqueue will be awakened, however if the 'rcu_nocb_poll' is set,
the sq waitqueue always empty, so if 'rcu_nocb_poll' is set, return
directly.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tree_nocb.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 636d0546a4e9..9e106c590e56 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -201,6 +201,8 @@ static void rcu_lockdep_assert_cblist_protected(struct rcu_data *rdp)
  */
 static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq)
 {
+	if (rcu_nocb_poll)
+		return;
 	swake_up_all(sq);
 }
 
-- 
2.25.1

