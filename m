Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A204DA197
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 18:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350756AbiCORwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 13:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350728AbiCORwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 13:52:38 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C626251301
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 10:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647366685; x=1678902685;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=TIHdA+AKHcJYGnhjeoFev4M5zL94iMlaKtK+VcDIR+A=;
  b=jxmzdy/l72LSt2jWWyEm+BiGJVpsFRR3e2t83LUO0XZcoCVsJaCQsXOy
   0FQIIgiFXPkgaMH4r6Okdn5s9RzFuqGKoxuha0sMvNdbJZwKJzuLgXIsH
   Bch+03vBjfy9y7VpMDRQkNnyCv2Ws/R6MMNu+9BBUu9kptbCemPWNcZv2
   05tMrV5T0WMYG4KsjHYecwo4F6OGkSmh028OdHd8/pfF3WY/NNS2yxGRy
   wzlRcrgbvzgYVCrBOoFdpi5TTw2JL/VdsRNWXwA4+IVfc45r5RnIb5ah8
   PRvumjPoincXLkaFIiMDwUObbDDG4iz4gs0E1f/anTgcUeEhsZ/nDSfmQ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="317106860"
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="317106860"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 10:46:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="613358396"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by fmsmga004.fm.intel.com with ESMTP; 15 Mar 2022 10:46:37 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 3/4] perf/x86/msr: Add Raptor Lake CPU support
Date:   Tue, 15 Mar 2022 10:45:59 -0700
Message-Id: <1647366360-82824-3-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1647366360-82824-1-git-send-email-kan.liang@linux.intel.com>
References: <1647366360-82824-1-git-send-email-kan.liang@linux.intel.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Raptor Lake is Intel's successor to Alder lake. PPERF and SMI_COUNT MSRs
are also supported.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

No changes since V1

 arch/x86/events/msr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index 96c775a..6d759f8 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -103,6 +103,7 @@ static bool test_intel(int idx, void *data)
 	case INTEL_FAM6_ROCKETLAKE:
 	case INTEL_FAM6_ALDERLAKE:
 	case INTEL_FAM6_ALDERLAKE_L:
+	case INTEL_FAM6_RAPTORLAKE:
 		if (idx == PERF_MSR_SMI || idx == PERF_MSR_PPERF)
 			return true;
 		break;
-- 
2.7.4

