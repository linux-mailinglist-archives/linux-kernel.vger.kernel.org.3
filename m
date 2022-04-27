Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4258D512769
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 01:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbiD0XOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 19:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiD0XOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 19:14:23 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C9332988
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 16:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651101070; x=1682637070;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PEHCXjXuGeH255YPGNEQTyRSOPX9oekMUvTMM96x13g=;
  b=h2QJ9/07szldp5aAcN0W28mToTUFfcQcDg/dDD5WkDfaxKs5S8x643Rk
   YFu0Wd/dV0LiNF/HTUh/a2mncZRHRn/fbuJZukerZ/nl5Eepr8mcgpi2P
   XIrZHD9xNbcP745pFXq1soNxKjqT9N3ZArTiHFn0u5ilEk/oXzCvCl6Ms
   vVszERxP2/okC2BYKYNWVKYE2XxVcAXu9bkGue8ZRRnoiwRc+ZKiBW0Aa
   DKqAo8NZSzxI1Jyas962RhO9OD4XzRT5x+BYpf9FFUUK3+oYG86oeeRid
   6qfs7ycdtF1W59IWZtLkWtymrkPVgmxek51rCC7PdBh4UB5xmQ1vYA7pR
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="253481033"
X-IronPort-AV: E=Sophos;i="5.90,294,1643702400"; 
   d="scan'208";a="253481033"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 16:11:09 -0700
X-IronPort-AV: E=Sophos;i="5.90,294,1643702400"; 
   d="scan'208";a="559263685"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 16:11:09 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH] x86/split_lock: Enable the split lock feature on Raptor Lake
Date:   Wed, 27 Apr 2022 16:10:59 -0700
Message-Id: <20220427231059.293086-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Raptor Lake supports the split lock detection feature. Add it to
the split_lock_cpu_ids[] array.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/intel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index f7a5370a9b3b..24b473895635 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1230,6 +1230,7 @@ static const struct x86_cpu_id split_lock_cpu_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	1),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		1),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		1),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		1),
 	{}
 };
 
-- 
2.35.1

