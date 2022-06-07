Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2975423F2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383090AbiFHAys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 20:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389901AbiFGWyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 18:54:04 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075B52EA412;
        Tue,  7 Jun 2022 12:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654631379; x=1686167379;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=U7jCZ/xTLZ6IZ4AqpjCoJuga0NHMpqo/MjLVXSIcWIc=;
  b=QjvW2RV5juTFUm3GrMoq8VHOxdFf5JdzIYPu+vaNgH4XpoF/e/GioC0W
   DzQsPN/bbKESsZRF1sJmnt0/PDOJwgNIIzh421c38qecPNitp9z3LmCLw
   /vQeI0QiRirJa99BgiJQbcgGpDgeL07tx4cwKOMMPpoog9KNpjwUoeo0n
   yTkwCfQPrWttazC9TNuHjBBuA9UL2bBW33ulgLXp3R4bjoANFckeDXWfa
   T2GCD3CFgOE2oUGyaJ02yeodZETkV2oxtJEUcx6wn+ZrwEijq+1bLKHxH
   szxq6z7hdV/ftwAsU3RAp5zP314CgUtcZnJ3DGopr0hYzXfcyz8j4vz56
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="265343600"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="265343600"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 12:06:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="584342057"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 07 Jun 2022 12:05:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BD49E109; Tue,  7 Jun 2022 22:06:02 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] spi: Replace match_true() by device_match_any()
Date:   Tue,  7 Jun 2022 22:06:01 +0300
Message-Id: <20220607190601.47363-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have already a helper to match any device, use it and drop match_true().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index ea09d1b42bf6..24440cd4aa5e 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2613,11 +2613,6 @@ int spi_slave_abort(struct spi_device *spi)
 }
 EXPORT_SYMBOL_GPL(spi_slave_abort);
 
-static int match_true(struct device *dev, void *data)
-{
-	return 1;
-}
-
 static ssize_t slave_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
@@ -2625,7 +2620,7 @@ static ssize_t slave_show(struct device *dev, struct device_attribute *attr,
 						   dev);
 	struct device *child;
 
-	child = device_find_child(&ctlr->dev, NULL, match_true);
+	child = device_find_child(&ctlr->dev, NULL, device_match_any);
 	return sprintf(buf, "%s\n",
 		       child ? to_spi_device(child)->modalias : NULL);
 }
@@ -2644,7 +2639,7 @@ static ssize_t slave_store(struct device *dev, struct device_attribute *attr,
 	if (rc != 1 || !name[0])
 		return -EINVAL;
 
-	child = device_find_child(&ctlr->dev, NULL, match_true);
+	child = device_find_child(&ctlr->dev, NULL, device_match_any);
 	if (child) {
 		/* Remove registered slave */
 		device_unregister(child);
-- 
2.35.1

