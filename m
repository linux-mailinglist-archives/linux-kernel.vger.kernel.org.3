Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536264EA703
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 07:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbiC2FS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 01:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbiC2FS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 01:18:26 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC59B181B0A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 22:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648531003; x=1680067003;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QeNE9/gtPkar92U7I/guWUxoEyBuRFRr0c1TASY7eBg=;
  b=Oirsx8j1JtjCOtvGiEmvF1Mw0O5Z0hxNx8PxhhkFgAQcSvUEuSa3nLPY
   JBaAKuk9UFkJtlyimaRSgim1XF+JWdolXeNhZrqDQQelpkhMo1+HKSU8V
   5S+EFLxhtPxTI5NuHhVtOpRcec/lboL4JS19nonU2vmDpQspG9GOmLF4q
   6h3+7YZdseB0W4pNC9+2B4YxFETFMoYW51mpCgtDERLTHzMZ+wY1iLs4f
   xez+KaghlAhEGnDb9zMsjU/4qyQEdOn+qEgISqnR+l5qWqzSBVZgYOjx+
   1U4CtkxbIerhELrwsoDjBmgcAZnhrdPKHgXHKNLoneeKssCnACpKj2ZrN
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="319863447"
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="319863447"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 22:16:43 -0700
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="564313639"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 22:16:41 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     tj@kernel.org, jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] workqueue: Restrict kworker in the offline CPU pool running on housekeeping CPUs
Date:   Tue, 29 Mar 2022 13:17:14 +0800
Message-Id: <20220329051714.2184811-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CPU going offline, all workers in this CPU pool will lose
affinity to this CPU, and may run to isolated CPU. like kworker
in unbound pool, set CPU affinity of these kworker is housekeeping
cpumask.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/workqueue.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index abcc9a2ac319..c509ce73a783 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5023,7 +5023,8 @@ static void unbind_workers(int cpu)
 
 		for_each_pool_worker(worker, pool) {
 			kthread_set_per_cpu(worker->task, -1);
-			WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);
+			WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task,
+						housekeeping_cpumask(HK_TYPE_WQ)) < 0);
 		}
 
 		mutex_unlock(&wq_pool_attach_mutex);
-- 
2.25.1

