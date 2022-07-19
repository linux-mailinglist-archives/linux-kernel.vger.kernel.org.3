Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A48B57A219
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239816AbiGSOpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240051AbiGSOo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:44:29 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE99B20;
        Tue, 19 Jul 2022 07:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658241806; x=1689777806;
  h=from:to:cc:subject:date:message-id;
  bh=s/vt8de6ZqMbsy1G9Q4hDjZjo+KRTtwTS4CtWJfFUz0=;
  b=lYZ0i1SsW/fVf5+bNYl7TWrnGY4kHpa6gMUvAI3mPRrSpfcdTZ/TUb57
   B6ZArmqw7cmnkIhtOMEX2n0QSJgF73zAVoXd2B7hvZKcc8FY3qTOdf8jT
   ewzFta3EWYQe++XaiXVuGv3jSDr0hF/DVD7QNHE5I8QDGGFMDQ4PwWUar
   NpmP0TgfWCuI+aS1VrytJv8WAMWnDZEvoMangBJ7TC2G6Ea3sCcas6Wwe
   tk+taQLPYzBZoC/EAAAyzwPNdxvoFEau7HzOXlVYuvgnPTl87hso7vW9S
   LHU20MT9ARffmFOkVNqzrkM0OR2r+ILuy2Q4gb6PWS88vCz790G9orHyL
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="348200775"
X-IronPort-AV: E=Sophos;i="5.92,284,1650956400"; 
   d="scan'208";a="348200775"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 07:43:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,284,1650956400"; 
   d="scan'208";a="572873053"
Received: from srpawnik.iind.intel.com ([10.99.123.68])
  by orsmga006.jf.intel.com with ESMTP; 19 Jul 2022 07:43:23 -0700
From:   Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
To:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com,
        andriy.shevchenko@linux.intel.com, linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, sumeet.r.pawnikar@intel.com
Subject: [PATCH] powercap: RAPL: Add Power Limit4 support for Alder Lake-N and Raptor Lake-P
Date:   Tue, 19 Jul 2022 20:09:00 +0530
Message-Id: <20220719143900.6024-1-sumeet.r.pawnikar@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

