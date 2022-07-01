Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035C1563999
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 21:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiGATM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 15:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiGATM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 15:12:58 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191383C716
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 12:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656702778; x=1688238778;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7Ji9e0hAxIJNMDuh9KYE+lqOyY+7TlQzjmXgYGpP8ic=;
  b=B/v4A8o1Nq4uHWX/CwpEYPpszms6RkYDUKN/vAQ3HPQU6gsn4bnMCfNU
   /xBHXsGXvl/GW+uButkwndsq4JvWfhRzhDBjKV8Uq7gP5ugof/0ebQ2bB
   BkaL5xhIM/DuZc9aB6fxOI5maENSHq1W54Ca3qSJvEglPlUlAIRbV+UHG
   2OahCQooE/7aRdbAjW6qcDWUHVto2rCsEyeAXPit3mAr7Se7yMYVYPB4k
   N3q2y2XlxeVJMEbCY9NqIt2W4Nt7Pg9CgjRNqlzdZDGEXrlwDihRA79rI
   dmgELMl/MaDj04yXRTBFHKlFHwIRVTfYYnXwdOOYDeCfpLrwuPlmLYasu
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10395"; a="271497870"
X-IronPort-AV: E=Sophos;i="5.92,238,1650956400"; 
   d="scan'208";a="271497870"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 12:12:44 -0700
X-IronPort-AV: E=Sophos;i="5.92,238,1650956400"; 
   d="scan'208";a="596366381"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 12:12:44 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     yazen.ghannam@amd.com
Cc:     tony.luck@intel.com, bp@alien8.de, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, x86@kernel.org
Subject: [PATCH] RAS/CEC: Reduce offline page threshold for Intel systems
Date:   Fri,  1 Jul 2022 12:12:39 -0700
Message-Id: <20220701191239.619940-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <a871b8bd35604921b842dcd65aed0f6c@intel.com>
References: <a871b8bd35604921b842dcd65aed0f6c@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A large scale study of memory errors on Intel systems in data centers
showed that aggressively taking pages with corrected errors offline is
the best strategy of using corrected errors as a predictor of future
uncorrected errors.

It is unknown whether this would help other vendors. There are some
indicators that it would not.

Set the threshold to "2" on Intel systems.

Do-not-apply-without-agreement-from-AMD
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/ras/cec.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index 42f2fc0bc8a9..b1fc193b2036 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -556,6 +556,14 @@ static int __init cec_init(void)
 	if (ce_arr.disabled)
 		return -ENODEV;
 
+	/*
+	 * Intel systems may avoid uncorreectable errors
+	 * if pages with corrected errors are aggresively
+	 * taken offline.
+	 */
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
+		action_threshold = 2;
+
 	ce_arr.array = (void *)get_zeroed_page(GFP_KERNEL);
 	if (!ce_arr.array) {
 		pr_err("Error allocating CE array page!\n");
-- 
2.35.3

