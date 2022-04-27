Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C83511238
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358683AbiD0HSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242672AbiD0HSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:18:18 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834B5140D4;
        Wed, 27 Apr 2022 00:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651043707; x=1682579707;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fXJkbxDf0qd9gW+A5tjOWCA9l6X90L85cXDE1FuuhiU=;
  b=gjAaRAarpDtX5g4WR3l822MezjoClULZb4FAhfqYXJCGxiOHcXh5T6fQ
   SYXgCt3lbgbVPJm+BfHDQ/rF3qZxMpeom1pACpx1cp6uEiuWBCO7KRdzT
   mR0JQIdiwlE+oV9YwRsxIRXCybZGWaF+9HoKaY2tfYH2xdepoWvEbDBdd
   001RczP97SRiIr1JeVC+P4z7fX5qBXbcAbUs41d7PEI4M4+4/8+luawFN
   hMBCycXPSJq9K35UjLP+2ZI/c8TCery+ZARftFnW/Aax58XVRu6RifDPO
   s0jl3h3vteKVIcmYOpRCy4YjFIj3RX2kwBbxkg4NJeivyGDE2wFtOr1LW
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="328786668"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="328786668"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 00:15:07 -0700
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="580431679"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 00:15:05 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcutorture: Fix kmemleak in rcu_test_debug_objects()
Date:   Wed, 27 Apr 2022 15:15:20 +0800
Message-Id: <20220427071520.2239030-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kmemleak kthread scan to the following:

unreferenced object 0xffff95d941135b50 (size 16):
  comm "swapper/0", pid 1, jiffies 4294667610 (age 1367.451s)
  hex dump (first 16 bytes):
    f0 c6 c2 bd d9 95 ff ff 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000bc81d9b1>] kmem_cache_alloc_trace+0x2f6/0x500
    [<00000000d28be229>] rcu_torture_init+0x1235/0x1354
    [<0000000032c3acd9>] do_one_initcall+0x51/0x210
    [<000000003c117727>] kernel_init_freeable+0x205/0x259
    [<000000003961f965>] kernel_init+0x1a/0x120
    [<000000001998f890>] ret_from_fork+0x22/0x30

the rhp object is not released after use, so call kfree() to
release it.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/rcutorture.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 0885a66f9d76..f3f9f97c3c1f 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -3183,6 +3183,7 @@ static void rcu_test_debug_objects(void)
 	pr_alert("%s: WARN: Duplicate call_rcu() test complete.\n", KBUILD_MODNAME);
 	destroy_rcu_head_on_stack(&rh1);
 	destroy_rcu_head_on_stack(&rh2);
+	kfree(rhp);
 #else /* #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD */
 	pr_alert("%s: !CONFIG_DEBUG_OBJECTS_RCU_HEAD, not testing duplicate call_rcu()\n", KBUILD_MODNAME);
 #endif /* #else #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD */
-- 
2.25.1

