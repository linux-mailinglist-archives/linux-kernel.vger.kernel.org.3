Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC1656C309
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240445AbiGHVJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 17:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240430AbiGHVJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 17:09:01 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF3F17049
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 14:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657314541; x=1688850541;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SetEOGhaWLyaztNH5ao+P5ewqYeiLxGVWkqNFRtt51A=;
  b=K+BQO7WtN4LcGSJAtPD2BBc1X6IlCWpoEXuN1iOcX1kUz2wO1aynW8IW
   YIo1wAgO3ClDE6WYePRAvVZk/wenCRns/+dF0exEnFkQAz8vVUAKtzzFW
   ZpXV1cfrvnBnxOP9hTOBw44lAiIV3Luhij4f/etr8sS8Oqol2NIcRrRaK
   /bOf1WG14s9XWnOdDDE2l8ZPC+c1J0R2WDx/fXmpXXjU5LSZ3YLX7aSSA
   wjIu8TjpTpBzypMg0+tlNhaHLDeWl0mrsop2Y5b1fV2mgAm/w4Wchxj8G
   S3E307ylUK2OxiFOUmH4V+9yZ4LaJGnLnyoyn2woN/wxD2qmiueNSlAxH
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="283120427"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="283120427"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 14:08:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="544339268"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 08 Jul 2022 14:08:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 97277AD; Sat,  9 Jul 2022 00:09:00 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     john.garry@huawei.com
Subject: [PATCH v2 2/4] bus: hisi_lpc: Use devm_platform_ioremap_resource
Date:   Sat,  9 Jul 2022 00:08:57 +0300
Message-Id: <20220708210859.6774-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220708210859.6774-1-andriy.shevchenko@linux.intel.com>
References: <20220708210859.6774-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct resource is not used for anything else, so we can simplify
the code a bit by using the helper function.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: John Garry <john.garry@huawei.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
v2: added tags
 drivers/bus/hisi_lpc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
index 6d432a07cbba..03d4d96ff794 100644
--- a/drivers/bus/hisi_lpc.c
+++ b/drivers/bus/hisi_lpc.c
@@ -618,7 +618,6 @@ static int hisi_lpc_probe(struct platform_device *pdev)
 	struct logic_pio_hwaddr *range;
 	struct hisi_lpc_dev *lpcdev;
 	resource_size_t io_end;
-	struct resource *res;
 	int ret;
 
 	lpcdev = devm_kzalloc(dev, sizeof(*lpcdev), GFP_KERNEL);
@@ -627,8 +626,7 @@ static int hisi_lpc_probe(struct platform_device *pdev)
 
 	spin_lock_init(&lpcdev->cycle_lock);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	lpcdev->membase = devm_ioremap_resource(dev, res);
+	lpcdev->membase = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(lpcdev->membase))
 		return PTR_ERR(lpcdev->membase);
 
-- 
2.35.1

