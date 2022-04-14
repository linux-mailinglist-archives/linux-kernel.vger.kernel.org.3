Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C221C500ED3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 15:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbiDNNVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 09:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243934AbiDNNTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:19:18 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820D392D31;
        Thu, 14 Apr 2022 06:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649942193; x=1681478193;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xX/cmUcjGxXpG7rPxofxKQoxBKiUs0vSg8GaifSgBio=;
  b=RZQv5rD+7g1Xz9CvUJO8Z5mBan8rtjPnYbjVgYKhFcGx3zcXRtqKytyt
   zIP998aMPY7UJT93i17klniMYr+BMMLB85KFk0sIkBSo9eIa2EEXtXjsP
   3CAS95ZqMgp2ykpqtez2g1+T4Wc9Ih5up98nV/snCJnzkigzkwqdi4zzF
   JaUX+zrWwQcZQOENz7Ry5sH8SC4Q0lu6hbHtfzziiTzNwVTSrMzClaqX6
   1gvRs8xuruK3n8NeS5NEjjo2eCieNMqvLZvFilXx16TsNRjzx5ooSCqQ1
   0ktw5PQnA5QnTUKOyottbmFk2iPVnxs4+ygJKsTB0fKikTSrPJscpCI2r
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="242859747"
X-IronPort-AV: E=Sophos;i="5.90,259,1643702400"; 
   d="scan'208";a="242859747"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 06:16:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,259,1643702400"; 
   d="scan'208";a="591187970"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 14 Apr 2022 06:16:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 750AD2AE; Thu, 14 Apr 2022 16:16:01 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH v2 3/3] iio: imu: adis16480: Improve getting the optional clocks
Date:   Thu, 14 Apr 2022 16:15:59 +0300
Message-Id: <20220414131559.24694-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414131559.24694-1-andriy.shevchenko@linux.intel.com>
References: <20220414131559.24694-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The extended clocks are optional and may not be present for some
configurations supported by this driver. Nevertheless, in case
the clock is provided but some error happens during its getting,
that error handling should be done properly.

Use devm_clk_get_optional() API and report possible errors using
dev_err_probe() to handle properly -EPROBE_DEFER error.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
---
v2: added tag (Nuno), massaged commit message (Nuno)
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

