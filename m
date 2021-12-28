Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEAEE48073C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 09:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbhL1IFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 03:05:03 -0500
Received: from mga02.intel.com ([134.134.136.20]:21737 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230489AbhL1IFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 03:05:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640678701; x=1672214701;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VXX/GSUjwDrw6yMUS3z5rSKLlRpeGlqj+gglNGqtlnI=;
  b=QMMC7qqI0ZyjW+L36i4vj63y5OlqOL7V0vzmQWeok8OHdVf/P+T/MpXk
   GOkZk3tYkgs5SMBgsp69EwFvKqHlXsW/INXM3kRn/2JN37mUCr0JpxvtU
   DPoi88IlH2zNZSgb40h8hWP/LEGESaYrWczenYnLKW4jbYIGM7fMNQrCL
   gOxXGT0hhNiExlXDMnoFTFn3ZdkwWZSkt7Hs/kByuCZLeg34fbIy7yqT8
   vBCNg6PwpdbBN69JV5Vo964OqsGE4QmjPEGaIWS8uz0d4uT5d7xYIXMbF
   AruuIw8LunBn9F8FyAofGlLkIK0frPYPBAGPwcGnQkgRmPEPd7qmlpJ0R
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10210"; a="228634844"
X-IronPort-AV: E=Sophos;i="5.88,241,1635231600"; 
   d="scan'208";a="228634844"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2021 00:05:01 -0800
X-IronPort-AV: E=Sophos;i="5.88,241,1635231600"; 
   d="scan'208";a="686525921"
Received: from unknown (HELO zq-OptiPlex-7090.bj.intel.com) ([10.238.156.125])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2021 00:04:59 -0800
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org
Cc:     linux-kernel@vger.kernel.org, qiang1.zhang@intel.com
Subject: [PATCH] rcu: per-cpu rcuc kthread are created only when rcutree.use_softirq=0
Date:   Wed, 29 Dec 2021 00:05:10 +0800
Message-Id: <20211228160510.2893362-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In non-RT kernel, if the RCU_BOOST is enabled, the per-cpu rcuc
kthread will be created, however under the rcutree.use_softirq=1,
the RCU core processing only in softirq context, the rcuc kthread
doesn't do anything, so remove RCU_BOOST interference.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 9b58bae0527a..ed64b4fcb8a0 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2902,7 +2902,7 @@ static int __init rcu_spawn_core_kthreads(void)
 
 	for_each_possible_cpu(cpu)
 		per_cpu(rcu_data.rcu_cpu_has_work, cpu) = 0;
-	if (!IS_ENABLED(CONFIG_RCU_BOOST) && use_softirq)
+	if (use_softirq)
 		return 0;
 	WARN_ONCE(smpboot_register_percpu_thread(&rcu_cpu_thread_spec),
 		  "%s: Could not start rcuc kthread, OOM is now expected behavior\n", __func__);
-- 
2.25.1

