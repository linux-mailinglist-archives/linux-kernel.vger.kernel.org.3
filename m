Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546225A0208
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 21:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239495AbiHXTWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 15:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238932AbiHXTWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 15:22:11 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9666C741
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 12:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661368930; x=1692904930;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=vvIFYPS4jNvbYVxVC+0i4epasyNJreygrRXEzBULvno=;
  b=ftJ17Qp19v/J0S/4p+wixuLXVS3aToZmX14TcbozBmn3mGFI6ayMnfhi
   1b/3OIr6xheQN7ZkUk1w1JOmkkagyehQe8TTQDuMR+iN3qJbq84syb6HC
   4ONMe4ZzshjTWnPmcFY21xDozdgadajHmxRuz+0HjLXB9unrysif2Escu
   KqXXzlz77qWvGIIfSowNLyYPw+opwKHn3o4ao6O0qbah+BW3eZumC93/i
   FvkJRS5UlNvpypvjy9UxlYsI/Dw0jEf2Kq19tDcPC0bRKSoob9BVJidct
   O+AkXN5ivLhUVign+/qTXRv4ldSs+ghpUhFQuWz20FoxWON/Y0EH6N8w1
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="292801038"
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="292801038"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 12:22:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="606140559"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga007.jf.intel.com with ESMTP; 24 Aug 2022 12:22:07 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, chang.seok.bae@intel.com
Subject: [PATCH 2/3] x86/fpu: Fix the init_fpstate size check with the actual size
Date:   Wed, 24 Aug 2022 12:12:22 -0700
Message-Id: <20220824191223.1248-3-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220824191223.1248-1-chang.seok.bae@intel.com>
References: <20220824191223.1248-1-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The init_fpstate buffer is statically allocated. Thus, the sanity test was
established to check whether the pre-allocated buffer is enough for the
calculated size or not.

The currently measured size is not strictly relevant. Fix to validate the
calculated init_fpstate size with the pre-allocated area.

Also, replace the sanity check function with open code for clarity. The
abstraction itself and the function naming do not tend to represent simply
what it does.

Fixes: 2ae996e0c1a3 ("x86/fpu: Calculate the default sizes independently")
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/kernel/fpu/xstate.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index f0ce10620ab0..f5ef78633b4c 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -678,20 +678,6 @@ static unsigned int __init get_xsave_size_user(void)
 	return ebx;
 }
 
-/*
- * Will the runtime-enumerated 'xstate_size' fit in the init
- * task's statically-allocated buffer?
- */
-static bool __init is_supported_xstate_size(unsigned int test_xstate_size)
-{
-	if (test_xstate_size <= sizeof(init_fpstate.regs))
-		return true;
-
-	pr_warn("x86/fpu: xstate buffer too small (%zu < %d), disabling xsave\n",
-			sizeof(init_fpstate.regs), test_xstate_size);
-	return false;
-}
-
 static int __init init_xstate_size(void)
 {
 	/* Recompute the context size for enabled features: */
@@ -717,10 +703,6 @@ static int __init init_xstate_size(void)
 	kernel_default_size =
 		xstate_calculate_size(fpu_kernel_cfg.default_features, compacted);
 
-	/* Ensure we have the space to store all default enabled features. */
-	if (!is_supported_xstate_size(kernel_default_size))
-		return -EINVAL;
-
 	if (!paranoid_xstate_size_valid(kernel_size))
 		return -EINVAL;
 
@@ -879,6 +861,12 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 	init_fpstate.size		= fpu_kernel_cfg.max_size;
 	init_fpstate.xfeatures		= fpu_kernel_cfg.max_features;
 
+	if (init_fpstate.size > sizeof(init_fpstate.regs)) {
+		pr_warn("x86/fpu: init_fpstate buffer too small (%zu < %d), disabling XSAVE\n",
+			sizeof(init_fpstate.regs), init_fpstate.size);
+		goto out_disable;
+	}
+
 	setup_init_fpu_buf();
 
 	/*
-- 
2.17.1

