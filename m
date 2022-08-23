Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0DA59EDE3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 23:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbiHWVB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 17:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiHWVBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 17:01:51 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FD07EFE8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 14:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661288511; x=1692824511;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1CmFjVU7Lfw7w8LNEJx3ofOpNT1iSuGMTLn/ARKsFBg=;
  b=LDu/L3NiJjGlEBcjCtyMMdjIcFeAVgjdleGopPqmGBpdH0OFEtXng7kB
   /lYFqzvO6OFxL4VaiejVZBtTQ2MMO09QDY9HZQEFiTQQMcD8SccZjwTbs
   uJ0kVBKIoaGDE8W7XsRZUQXINQe7mdW1GGVRgI9f2U0r7FU1FKmmdNrkD
   RNNpxTSE+lWgktyxcgnXAYI/+GfbuhNRZ0qgo3Vg87qK2rOCfhOOuIL3Y
   wDPKqmWUHDa7JrC0NJcxNmexv/E/0n8bk/8R5kCHJf/0RT0oIodEw8lcw
   d3hS13Roi0uZu2fp+mEaQkdiXYijlKFo47cmv7JWJYdqdDeVcaZd6EsoH
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="357769299"
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="357769299"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 14:01:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="698812589"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Aug 2022 14:01:48 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 2/4] perf/x86/msr: Add new Raptor Lake S support
Date:   Tue, 23 Aug 2022 14:01:27 -0700
Message-Id: <20220823210129.979394-2-kan.liang@linux.intel.com>
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

The same as the other {ALDER,RAPTOP}LAKE, the new Raptor Lake S also
supports the PPERF and SMI_COUNT MSRs.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/msr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index ac542f98c070..ecced3a52668 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -106,6 +106,7 @@ static bool test_intel(int idx, void *data)
 	case INTEL_FAM6_ALDERLAKE_N:
 	case INTEL_FAM6_RAPTORLAKE:
 	case INTEL_FAM6_RAPTORLAKE_P:
+	case INTEL_FAM6_RAPTORLAKE_S:
 		if (idx == PERF_MSR_SMI || idx == PERF_MSR_PPERF)
 			return true;
 		break;
-- 
2.35.1

