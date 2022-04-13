Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA224FF92D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 16:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236214AbiDMOo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 10:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236211AbiDMOoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 10:44:11 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926DD50448;
        Wed, 13 Apr 2022 07:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649860910; x=1681396910;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sFYf0sR2D6x6PkN6iFJFvdQCnCDMjDUCNFCP0vNEokQ=;
  b=V29MBnsXXTW2696E/v20xyED3N4eTtgZ2t3M7mGf2N7PdBoLyZcKQFLi
   EvQ3P0RdxZh/r1JTixFjVXW/DnEypBeKBKMo0txuDgDA66LrI6rnSU4Is
   YEPWvdx5WsvdMxtiLwrnyK4FNggOxaEPqZ2SpSeW5DH3fMbCePInwirdz
   dst9hULHAl0CWQgZN/sVinmk10KO7+Wbu8R1XIoVDqBus5qPhZla1IkZL
   xpI2KjEdGxl4vhl0y2+2IHTT7uHKC4DbRdiqKIMq1m6u5osK97SSsqlTQ
   CE+FPbmo9Mrr1Y773lglFk35Lv3TSGllvZSZLmqIOiNYNZQ8C1uYTDP0W
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="325590559"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="325590559"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 07:41:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="623708423"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 13 Apr 2022 07:41:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E5568236; Wed, 13 Apr 2022 17:41:43 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v1 3/3] iio: imu: adis16480: Fix getting the optional clocks
Date:   Wed, 13 Apr 2022 17:41:24 +0300
Message-Id: <20220413144124.72537-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220413144124.72537-1-andriy.shevchenko@linux.intel.com>
References: <20220413144124.72537-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The extended clocks are optional and may not be present for some SoCs
supported by this driver. Nevertheless, in case the clock is provided
but some error happens during its getting, that error should be handled
properly. Use devm_clk_get_optional() API for that. Also report possible
errors using dev_err_probe() to handle properly -EPROBE_DEFER error.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/imu/adis16480.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index 287914016f28..fe520194a837 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -1362,31 +1362,25 @@ static int adis16480_get_ext_clocks(struct adis16480 *st)
 {
 	struct device *dev = &st->adis.spi->dev;
 
-	st->clk_mode = ADIS16480_CLK_INT;
-	st->ext_clk = devm_clk_get(dev, "sync");
-	if (!IS_ERR_OR_NULL(st->ext_clk)) {
+	st->ext_clk = devm_clk_get_optional(dev, "sync");
+	if (IS_ERR(st->ext_clk))
+		return dev_err_probe(dev, PTR_ERR(st->ext_clk), "failed to get ext clk\n");
+	if (st->ext_clk) {
 		st->clk_mode = ADIS16480_CLK_SYNC;
 		return 0;
 	}
 
-	if (PTR_ERR(st->ext_clk) != -ENOENT) {
-		dev_err(dev, "failed to get ext clk\n");
-		return PTR_ERR(st->ext_clk);
-	}
-
 	if (st->chip_info->has_pps_clk_mode) {
-		st->ext_clk = devm_clk_get(dev, "pps");
-		if (!IS_ERR_OR_NULL(st->ext_clk)) {
+		st->ext_clk = devm_clk_get_optional(dev, "pps");
+		if (IS_ERR(st->ext_clk))
+			return dev_err_probe(dev, PTR_ERR(st->ext_clk), "failed to get ext clk\n");
+		if (st->ext_clk) {
 			st->clk_mode = ADIS16480_CLK_PPS;
 			return 0;
 		}
-
-		if (PTR_ERR(st->ext_clk) != -ENOENT) {
-			dev_err(dev, "failed to get ext clk\n");
-			return PTR_ERR(st->ext_clk);
-		}
 	}
 
+	st->clk_mode = ADIS16480_CLK_INT;
 	return 0;
 }
 
@@ -1447,7 +1441,7 @@ static int adis16480_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	if (!IS_ERR_OR_NULL(st->ext_clk)) {
+	if (st->ext_clk) {
 		ret = adis16480_ext_clk_config(st, true);
 		if (ret)
 			return ret;
-- 
2.35.1

