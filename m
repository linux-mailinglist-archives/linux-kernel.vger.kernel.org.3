Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D77D5813D4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 15:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238663AbiGZNHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 09:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238614AbiGZNHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 09:07:09 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A648C22BD1;
        Tue, 26 Jul 2022 06:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658840826; x=1690376826;
  h=from:to:cc:subject:date:message-id;
  bh=DvIjwdkxO81XtbqcSYVXAUA20zcuNGehRiM//+Z9ywA=;
  b=hc3Tg36PD3gZZhj66hU5supTNpKYSrW7Aa7E+PJYw5qLpmv1UGYBmcVD
   QpOpu0fkU4+3Saeei6D43VCRq/6n0df2LE7+i4tGfCJAZfWXRqqR5O3Sk
   +Dr9ek2+hts91Qs2uYzNJfgdFbJuZR2ZYEGQZA7xkdkeYfjUAEenxufJz
   iBYl65Bpia3lsvKtwRCrHgKxxGCLIZtKMTf/02THVjiMOpEvUeB4XGiny
   BrI3LsfL1T3gmmCMiuqyBgBo86JhEFTNGT3eAFefeWlRTZdo1Nzrjiw7a
   D/tPaHs8TG7yEFbxMV6TdAlewA37ZMB07rw/+l2mC0hOi1ClLc5R+n7y4
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="351941433"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="351941433"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 06:07:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="658676908"
Received: from srpawnik.iind.intel.com ([10.99.123.68])
  by fmsmga008.fm.intel.com with ESMTP; 26 Jul 2022 06:07:04 -0700
From:   Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
To:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com,
        andriy.shevchenko@linux.intel.com, linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, sumeet.r.pawnikar@intel.com
Subject: [PATCH v3] powercap: RAPL: Add Power Limit4 support for Alder Lake-N and Raptor Lake-P
Date:   Tue, 26 Jul 2022 18:32:29 +0530
Message-Id: <20220726130229.24634-1-sumeet.r.pawnikar@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Alder Lake-N and Raptor Lake-P to the list of processor models
for which Power Limit4 is supported by the Intel RAPL driver.

Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: Sent v2 without v1 i.e. first patch itself sent as v2 by mistake.
    There was no v1 sent for review.
v3: Added the backstory of previous versions. No functional changes.
---
 drivers/powercap/intel_rapl_msr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index 9d23984d8931..bc6adda58883 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -140,7 +140,9 @@ static const struct x86_cpu_id pl4_support_ids[] = {
 	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_TIGERLAKE_L, X86_FEATURE_ANY },
 	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ALDERLAKE, X86_FEATURE_ANY },
 	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ALDERLAKE_L, X86_FEATURE_ANY },
+	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ALDERLAKE_N, X86_FEATURE_ANY },
 	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_RAPTORLAKE, X86_FEATURE_ANY },
+	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_RAPTORLAKE_P, X86_FEATURE_ANY },
 	{}
 };
 
-- 
2.17.1

