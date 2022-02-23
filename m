Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684F94C2050
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 00:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245114AbiBWX4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 18:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245097AbiBWX4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 18:56:46 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049405E746;
        Wed, 23 Feb 2022 15:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645660578; x=1677196578;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FJCs9Jv1mjb1vjFstuh0NUAf3NVCWQZ6Hb8AlB7++jA=;
  b=KwAzHsWDGBol5cHo5ouxJ105uKe2xrPNCLn2SqdBZNtVZaPOSNzT3rUV
   yPtooSeaa7e5z7I1zcmcx0HNicGKH3g+kppvrL7pBNZ2IOHUj8UOPGNV5
   t3AGadCImZKwr04aHJ94aq0pOwmFL6wo1hEW7bshjTh7K7eGRXM/dYzMa
   ppud4+uv3MFAm3c7K4Avmpy/s7C51nYBFoQmTWydJKI7QOk8s/LRQDPcT
   j4SfkMjFBw/z/U1PduCvEHaSVqa8bfSmmMmVAY5hekOKfkKAb2h6riGMS
   +klP+hORB78G/s1ECn+i0+BVIvATX3WG4vSFeCS6In8QFRZ/zS+OdQL95
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="232084070"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="232084070"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 15:56:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="506114602"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 23 Feb 2022 15:56:09 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DF51873; Thu, 24 Feb 2022 01:56:25 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v1 2/3] ACPI: lpss: Constify properties member in struct lpss_device_desc
Date:   Thu, 24 Feb 2022 01:56:21 +0200
Message-Id: <20220223235622.19555-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220223235622.19555-1-andriy.shevchenko@linux.intel.com>
References: <20220223235622.19555-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The properties are static and not supposed to be modified, constify them.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/acpi_lpss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index bcae0f03572b..c28954411af9 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -82,7 +82,7 @@ struct lpss_device_desc {
 	const char *clk_con_id;
 	unsigned int prv_offset;
 	size_t prv_size_override;
-	struct property_entry *properties;
+	const struct property_entry *properties;
 	void (*setup)(struct lpss_private_data *pdata);
 	bool resume_from_noirq;
 };
-- 
2.34.1

