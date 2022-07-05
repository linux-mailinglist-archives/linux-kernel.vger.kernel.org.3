Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FAB566A0E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 13:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiGELn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 07:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbiGELnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 07:43:18 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D9B1705D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 04:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657021397; x=1688557397;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u/kMUnMXwniEBClFqHb0MZ8oS0jnT97cxzgVVR3bZoU=;
  b=mk7W/U1FeoyiATpyXCtJrvVjdRQPxyvg04ZCN0FTSdcHBmOkL3fFpi3p
   7EbFvy4lvLf2MudBSRIyx4qEP9xDF04ejYmlGk/IW7yLU0WiTM4efnUtl
   HgiTdmcl1Xgl+oLqn32xRQwKjRdIjLOUPkV9HewW6ruYcWf762RxqqUG2
   PFTCmAHm3l2MuCayxASLhbD3FaJNjNS2/9GWARyu/T3B64fC54azvQiph
   0Q9PkwTpI5o+O5KIBzFcddz4u5PmeZI1YOtCdoyi+dcRVjK+T1/5Qi85H
   5Fq3xCd2/oPArCgiWG+1cKc7WbMA9y/UUn+UvGaszH5cKII9dDI9QYW7+
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="263753735"
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="263753735"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 04:43:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="769627322"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 05 Jul 2022 04:43:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 964CFCE; Tue,  5 Jul 2022 14:43:22 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     john.garry@huawei.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/4] bus: hisi_lpc: Use devm_platform_ioremap_resource
Date:   Tue,  5 Jul 2022 14:43:10 +0300
Message-Id: <20220705114312.86164-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220705114312.86164-1-andriy.shevchenko@linux.intel.com>
References: <20220705114312.86164-1-andriy.shevchenko@linux.intel.com>
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
---
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

