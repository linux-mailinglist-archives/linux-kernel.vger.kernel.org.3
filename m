Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254A25528F5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 03:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242634AbiFUBYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 21:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240589AbiFUBYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 21:24:34 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE0818393;
        Mon, 20 Jun 2022 18:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655774674; x=1687310674;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=P1rVaIhS5r5JKXcqA4qDq5VHV9+1YzZmetl5LjjbGvk=;
  b=fetST3UJnTH8ePIrxc1bdi49jvP1zt68/xPc97r78r5ZCnUEttgKYRst
   EheJOpNLLQIydQWwkMjQk3wIu4enhDPHdswz2CztZbRNpySO1W5uC2meZ
   o6r8AsgF/kdrqrFQL1rbcOK2CO78mEKRE3I02nnjtGv3Lm5As2F0Tq7T2
   jIVNCq32C7HJd1glbaigo1wLdjBkbeoxIuK9RM5XqPY8fZZzCKEvp3h0c
   U50K7obj1Kch8etS0eCN7PR5MWc7YAa3XOGdquU87HOhs8hBTUK+s8oj2
   buse6pxVKLP5ll+0NXNIyznLwSn2Ngp16T+/NRt6LIRoohmxYwnXl9U8e
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="278771181"
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="278771181"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 18:24:33 -0700
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="643366799"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 18:24:32 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcu: Add a warnings in sync_sched_exp_online_cleanup()
Date:   Tue, 21 Jun 2022 09:24:12 +0800
Message-Id: <20220621012412.2724457-1-qiang1.zhang@intel.com>
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

Currently, the sync_sched_exp_online_cleanup() is invoked in
cpuhp per-cpu kthreads when CPU is going online, so the CPU id
obtained by get_cpu() should always be equal to the CPU id of
the passed parameter, that is to say, the smp_call_function_single()
never be invoked, if be invoked, there may be problem with cpu-hotplug,
this commit add WARN_ON_ONCE() to remind everyone.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tree_exp.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index be667583a554..ae8dcfd4486c 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -865,6 +865,8 @@ static void sync_sched_exp_online_cleanup(int cpu)
 		put_cpu();
 		return;
 	}
+
+	WARN_ON_ONCE(my_cpu != cpu);
 	/* Quiescent state needed on some other CPU, send IPI. */
 	ret = smp_call_function_single(cpu, rcu_exp_handler, NULL, 0);
 	put_cpu();
-- 
2.25.1

