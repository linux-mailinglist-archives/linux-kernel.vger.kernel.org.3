Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127C0560C23
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 00:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiF2WNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 18:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiF2WNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 18:13:15 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E1917596;
        Wed, 29 Jun 2022 15:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656540794; x=1688076794;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=14mMpm5JYU/oBxBuvhMONX4zD6TFyEpEz0kKpej+uHk=;
  b=BJCLgQByb2cZ+Y/N54mHW1WXM0lUa7IoYS5JXi2QP7A7QIzIWnPSQHvD
   Z4xgpap01jvkJdpiyy5LRzociHOVnR4Ba30fqXmBMhd8C7X4NNlJyhpRA
   0hjAr0lwY2/GMfgzAqti5qsILXFc/YF5P3lNVgPpX5yG6SAqxNvIpRLZM
   D5mmzSi6Zo3L0UQsmiR/q21kWkrsbT9u/HTo0xDami5Z+B2pWwOjFKpGj
   BgMTQX04v1ltEJQXg1zj6zfe1lWf3flj7ZTEBym/kQrwU1H45/ss2paYN
   VwO41k2JxOO31zsUtoS4BzyoXEXfO2A7B9fkM51+AzNLaZk6NbV2nX9SS
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="279720018"
X-IronPort-AV: E=Sophos;i="5.92,232,1650956400"; 
   d="scan'208";a="279720018"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 15:13:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,232,1650956400"; 
   d="scan'208";a="733357311"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 29 Jun 2022 15:13:13 -0700
Received: from MeteorLakePO1.jf.intel.com (MeteorLakePO1.jf.intel.com [10.234.180.58])
        by linux.intel.com (Postfix) with ESMTP id 94195580B55;
        Wed, 29 Jun 2022 15:13:13 -0700 (PDT)
From:   Gayatri Kammela <gayatri.kammela@linux.intel.com>
To:     hdegoede@redhat.com
Cc:     markgross@kernel.org, david.e.box@linux.intel.com,
        srinivas.pandruvada@intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gayatri Kammela <gayatri.kammela@linux.intel.com>
Subject: [PATCH v1 3/4] platform/x86/intel/pmt: telemetry: Fix fixed region handling
Date:   Wed, 29 Jun 2022 15:13:33 -0700
Message-Id: <20220629221334.434307-4-gayatri.kammela@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220629221334.434307-1-gayatri.kammela@linux.intel.com>
References: <20220629221334.434307-1-gayatri.kammela@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "David E. Box" <david.e.box@linux.intel.com>

Use the telem_type and the fixed block guid to determine if an entry is a
fixed region. For certain platforms we don't support this.

Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@linux.intel.com>
---
 drivers/platform/x86/intel/pmt/telemetry.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/intel/pmt/telemetry.c b/drivers/platform/x86/intel/pmt/telemetry.c
index f73ecfd4a309..5e4009c05ecf 100644
--- a/drivers/platform/x86/intel/pmt/telemetry.c
+++ b/drivers/platform/x86/intel/pmt/telemetry.c
@@ -23,12 +23,19 @@
 #define TELEM_GUID_OFFSET	0x4
 #define TELEM_BASE_OFFSET	0x8
 #define TELEM_ACCESS(v)		((v) & GENMASK(3, 0))
+#define TELEM_TYPE(v)		(((v) & GENMASK(7, 4)) >> 4)
 /* size is in bytes */
 #define TELEM_SIZE(v)		(((v) & GENMASK(27, 12)) >> 10)
 
 /* Used by client hardware to identify a fixed telemetry entry*/
 #define TELEM_CLIENT_FIXED_BLOCK_GUID	0x10000000
 
+enum telem_type {
+	TELEM_TYPE_PUNIT = 0,
+	TELEM_TYPE_CRASHLOG,
+	TELEM_TYPE_PUNIT_FIXED,
+};
+
 struct pmt_telem_priv {
 	int				num_entries;
 	struct intel_pmt_entry		entry[];
@@ -39,10 +46,15 @@ static bool pmt_telem_region_overlaps(struct intel_pmt_entry *entry,
 {
 	u32 guid = readl(entry->disc_table + TELEM_GUID_OFFSET);
 
-	if (guid != TELEM_CLIENT_FIXED_BLOCK_GUID)
-		return false;
+	if (intel_pmt_is_early_client_hw(dev)) {
+		u32 type = TELEM_TYPE(readl(entry->disc_table));
+
+		if ((type == TELEM_TYPE_PUNIT_FIXED) ||
+		    (guid == TELEM_CLIENT_FIXED_BLOCK_GUID))
+			return true;
+	}
 
-	return intel_pmt_is_early_client_hw(dev);
+	return false;
 }
 
 static int pmt_telem_header_decode(struct intel_pmt_entry *entry,
-- 
2.32.0

