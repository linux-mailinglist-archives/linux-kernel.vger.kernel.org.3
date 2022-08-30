Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA475A6C4D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 20:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbiH3Sdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 14:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbiH3Sd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 14:33:28 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551E66D573
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 11:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661884407; x=1693420407;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=h1BxaOOoiltf/jjn9jarqjcp6JmDX52ctebixNc5/GI=;
  b=Oj3CL7G3G/R0bTlc1w/nMPv0yl+BgLs0nePICwXH7xscldtm1B5lA/6+
   D/HK+uIBcHYm5PNGTY8VulNQSaHb9IHhJ5k3WwxMVXupZlRfzZi+8Ksf3
   gznOu4UY8VF24qd7oMWFbsOQd2jycWBhCnjkDcbqcGHH+k6DYNjZqfVPS
   cwpK0e9Vg5Xv/y6ZeoNnuUAzvl/DA0aBw0Mr4R9AkeEsDfGCykOxtd3pv
   +eTHqbPBFz6cfMjM63loo0ph8bNsygdLV+T9lizFWs+ZkUuvAGpF4dEPP
   G3evko17V5dIvM0UzG5I2YnwLyLRC6Z32whU4ewdq+7qXDNIkdYqkdtBV
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="296054838"
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="296054838"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 11:33:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="754149113"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 30 Aug 2022 11:33:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 31461AD; Tue, 30 Aug 2022 21:33:39 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] mtd: rawnand: Replace of_gpio_named_count() by gpiod_count()
Date:   Tue, 30 Aug 2022 21:33:36 +0300
Message-Id: <20220830183336.49966-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a preparation to unexport of_gpio_named_count(), convert the
driver to use gpiod_count() instead.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mtd/nand/raw/nand_base.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 6b67b7dfe7ce..2200276c7f25 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -5331,11 +5331,10 @@ static int of_get_nand_secure_regions(struct nand_chip *chip)
 int rawnand_dt_parse_gpio_cs(struct device *dev, struct gpio_desc ***cs_array,
 			     unsigned int *ncs_array)
 {
-	struct device_node *np = dev->of_node;
 	struct gpio_desc **descs;
 	int ndescs, i;
 
-	ndescs = of_gpio_named_count(np, "cs-gpios");
+	ndescs = gpiod_count(dev, "cs");
 	if (ndescs < 0) {
 		dev_dbg(dev, "No valid cs-gpios property\n");
 		return 0;
-- 
2.35.1

