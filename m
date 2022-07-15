Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85EAF576589
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 19:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234780AbiGOQ4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 12:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234399AbiGOQ4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 12:56:53 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4A779EF7;
        Fri, 15 Jul 2022 09:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657904212; x=1689440212;
  h=from:to:cc:subject:date:message-id;
  bh=s/vt8de6ZqMbsy1G9Q4hDjZjo+KRTtwTS4CtWJfFUz0=;
  b=JmOnPMt2ia8iL6x+DjCcjsZhvJU5MVLf0WzbV/v48KM6ru8vqsRrXeAs
   ewvBZcdzzm1cxoCzeqFyGX3C1KzXSeTg7oxqJv1pURpI9xgGFb9Hhi2Sn
   wWA97S7Yo42kOnqAgQHKCv8nq0bwB5rGe5JB3JlkuC4rL9faFyp037f2a
   ULcJaeZnyRBElNJdkkRWBiOfqvpIu4t8BiFr3GbhGHEcUhyrpq71hTF7i
   0+waGaOvzvTKvF64aqtQ4sjBBCvMIsKNjmFS4lgGdwZ8uEWPEyA/2oM2T
   ntHa/Pug4K/pScOhZ4UEQdA1M69vk/K9pygVTSuM/sJ7scERiCXxJnCLo
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="286979391"
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="286979391"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 09:56:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="593794543"
Received: from srpawnik.iind.intel.com ([10.99.123.68])
  by orsmga007.jf.intel.com with ESMTP; 15 Jul 2022 09:56:44 -0700
From:   Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
To:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com,
        andriy.shevchenko@linux.intel.com, linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, sumeet.r.pawnikar@intel.com
Subject: [PATCH v2] powercap: RAPL: Add Power Limit4 support for Alder Lake-N and Raptor Lake-P
Date:   Fri, 15 Jul 2022 22:22:28 +0530
Message-Id: <20220715165228.28044-1-sumeet.r.pawnikar@intel.com>
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

