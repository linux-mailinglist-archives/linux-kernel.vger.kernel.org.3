Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4182559EDE6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 23:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbiHWVCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 17:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiHWVBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 17:01:51 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A5D7EFEC
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 14:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661288511; x=1692824511;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mpZXC0V7DIVCyAFv2s+sWV5YZsx7b2wjDfmP26CTp8k=;
  b=iPH5fHErh9DNHYgyaWnc9LgDCpalYywELSaou2KjwwMcMkT7ZFFUGFJZ
   XFmKRy3zbhlujAWxKQoOubJGNL8PKjlFI3eIhTOuwETvd/FcpqG8+wDgW
   owIqCGq5dd9FLPjQgN/XtIDKx3a0qk3UTtGpgnW0CC0nZRS0c/gdFMCjs
   BHqBojG9LKJQXCP7K1rwiguTWB+1/U7bw735x3bcrnOAts8aQLXgayE1p
   qqWLdRqYTRpNnJU8gYKympbZDsssOc98CHz2ZPES+14wo6Z4/cAeQiKPU
   sbNZsobE+8pDqwkz92j3GPzKjbZFW2kmJ52cFkJM9/uuBo5hssMxz96Y5
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="357769300"
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="357769300"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 14:01:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="698812590"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Aug 2022 14:01:49 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 3/4] perf/x86/cstate: Add new Raptor Lake S support
Date:   Tue, 23 Aug 2022 14:01:28 -0700
Message-Id: <20220823210129.979394-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220823210129.979394-1-kan.liang@linux.intel.com>
References: <20220823210129.979394-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

From the perspective of Intel cstate residency counters, the new
Raptor Lake S is the same as the other {ALDER,RAPTOP}LAKE.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/cstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 8ec23f47fee9..a2834bc93149 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -685,6 +685,7 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,		&adl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		&adl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,	&adl_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	&adl_cstates),
 	{ },
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_cstates_match);
-- 
2.35.1

