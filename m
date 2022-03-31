Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5D14ED3A5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 07:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbiCaF6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 01:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiCaF6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 01:58:34 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EA41AA056
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 22:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648706207; x=1680242207;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FZyFixHTyqkYhNWGDpwi2BoO+1lQkoTiQ3VMdhC0QAg=;
  b=B7JkgfW4BpIzNcT2BJj36fgvUWVdn1UwlCnuvPih+u81PAKFC1hrfnCA
   r9yiWsT2qsdxagPDqjuObI4qu7Oxtnej889WqHkD0zXROyb770L20B4UA
   9OYwQKBr5kU2ZeGsi6dGR3ZE41948f/lS478MRr1MSxgcNc40ARgogiG2
   BwFNY1A7t7H+Wyi+WcMQ9U/h75KuEBvGIcC0En4f/tMqGq5ZN1XmAd4mJ
   WoQN3XjbpdqVn5EQSiHBaMAECFtb65sBHLA0PfEliHLBuDMe5BEXJJ1d7
   D+78ExmgH0D6iErHk7CyKJ3Ch15/ob+k7OpaP1bhZDWfHic853sTLtGpI
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="257307543"
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="257307543"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 22:56:47 -0700
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="522196740"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 22:56:45 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     jiangshanlai@gmail.com, tj@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] workqueue: Restrict kworker in the offline CPU pool running on housekeeping CPUs
Date:   Thu, 31 Mar 2022 13:57:17 +0800
Message-Id: <20220331055717.2659428-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CPU going offline, all workers in this CPU pool will lose
affinity to this CPU, and may run to isolated CPU. like kworker
in unbound pool, set CPU affinity of these kworker is
wq_unbound_cpumask.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 v1->v2:
 Replace housekeeping_cpumask(HK_TYPE_WQ) with wq_unbound_cpumask.

 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index abcc9a2ac319..b447012df177 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5023,7 +5023,7 @@ static void unbind_workers(int cpu)
 
 		for_each_pool_worker(worker, pool) {
 			kthread_set_per_cpu(worker->task, -1);
-			WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);
+			WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, wq_unbound_cpumask) < 0);
 		}
 
 		mutex_unlock(&wq_pool_attach_mutex);
-- 
2.25.1

