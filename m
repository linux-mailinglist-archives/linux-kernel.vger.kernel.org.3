Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CCA5A020B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 21:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239215AbiHXTWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 15:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238576AbiHXTWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 15:22:10 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F946C744
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 12:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661368929; x=1692904929;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=bho/C6DX2b9DAeFXNTrqJlip/PRcn0dLalM6W++Y9TE=;
  b=XC7lrHKCwdi7G8eqIFli403JGAyqRrOr5A+5+ocbFctj5ZvNmGe8Jns6
   9l8usEoOlO7rZW58e/7liqpr06XA724y0W+fc6rAsz9VV+2ZgcToJg9Oi
   /mHsWvcJlsIG+OoF8PuKkcvtY9SWGo5wDDNAKm9ptMMDiOumMwUJ7OvuX
   hgHqq2ieiWPM8+3bCZMvD+zOTUIL339tsrWHekDP0bS+WM9TOea+9Vzcn
   c6Hchq9+PLs7bjPnRdeCFMnee6P3EMqcGvUzdy/akJCOPRHX4Dkl1xBmi
   1Ir+EoVUvGNNH6Sm1OPq5Ag4x+4DDhTya45qczJkKMaXqfKQfiCEn7whT
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="292801036"
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="292801036"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 12:22:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="606140555"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga007.jf.intel.com with ESMTP; 24 Aug 2022 12:22:07 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, chang.seok.bae@intel.com
Subject: [PATCH 1/3] x86/fpu: Configure init_fpstate attributes orderly
Date:   Wed, 24 Aug 2022 12:12:21 -0700
Message-Id: <20220824191223.1248-2-chang.seok.bae@intel.com>
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

The init_fpstate setup code is spread out and out of order. The init image
is recorded before its scoped features and the buffer size are determined.

Determine the scope of init_fpstate components and its size before
recording the init state. Also move the relevant code together.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/kernel/fpu/init.c   | 8 --------
 arch/x86/kernel/fpu/xstate.c | 6 +++++-
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 621f4b6cac4a..8946f89761cc 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -210,13 +210,6 @@ static void __init fpu__init_system_xstate_size_legacy(void)
 	fpstate_reset(&current->thread.fpu);
 }
 
-static void __init fpu__init_init_fpstate(void)
-{
-	/* Bring init_fpstate size and features up to date */
-	init_fpstate.size		= fpu_kernel_cfg.max_size;
-	init_fpstate.xfeatures		= fpu_kernel_cfg.max_features;
-}
-
 /*
  * Called on the boot CPU once per system bootup, to set up the initial
  * FPU state that is later cloned into all processes:
@@ -236,5 +229,4 @@ void __init fpu__init_system(struct cpuinfo_x86 *c)
 	fpu__init_system_xstate_size_legacy();
 	fpu__init_system_xstate(fpu_kernel_cfg.max_size);
 	fpu__init_task_struct_size();
-	fpu__init_init_fpstate();
 }
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index c8340156bfd2..f0ce10620ab0 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -360,7 +360,7 @@ static void __init setup_init_fpu_buf(void)
 
 	print_xstate_features();
 
-	xstate_init_xcomp_bv(&init_fpstate.regs.xsave, fpu_kernel_cfg.max_features);
+	xstate_init_xcomp_bv(&init_fpstate.regs.xsave, init_fpstate.xfeatures);
 
 	/*
 	 * Init all the features state with header.xfeatures being 0x0
@@ -875,6 +875,10 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 	update_regset_xstate_info(fpu_user_cfg.max_size,
 				  fpu_user_cfg.max_features);
 
+	/* Bring init_fpstate size and features up to date */
+	init_fpstate.size		= fpu_kernel_cfg.max_size;
+	init_fpstate.xfeatures		= fpu_kernel_cfg.max_features;
+
 	setup_init_fpu_buf();
 
 	/*
-- 
2.17.1

