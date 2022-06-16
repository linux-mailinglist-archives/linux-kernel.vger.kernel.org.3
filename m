Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6834B54E839
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 19:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242174AbiFPQ7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 12:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238328AbiFPQ63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 12:58:29 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1D53E5FF
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 09:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655398708; x=1686934708;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5zZKY4Kr7GFCaPKpY3mPabUiDHy4UJVkaehHFaxVe9A=;
  b=mE6WX5YktSa3ROjWZv1+Sgk/KGI2Ziec2pG40ModZ78ME2x88vXDeOrX
   5D91/1pTrYK7MZed7jDkbG5ZgqjK95xjAD/4yOQ2qwPxb+/zv0nILQpV9
   f7pTXbWYvQ2WWxEjxxNv/MBQm4Zjv7yYkfg1zqC8NRveCm49gWhSyuwp5
   GwVdMjdrAwZqQpgQkBxJbN+7Og0gXfdmfB11UZga/DFFl+zXkG9i4dgi+
   sdkh8EUGynXXhT0mzj2jM+YT2Th0umzqIJ9625m+Jvym3M1JJwgzlNqcD
   fivOQ6KNMJCB+SoeJHjDshFbCcYd8YHqdMo4Brn0YKgu/rmzNrkGi80bc
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="280327612"
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="280327612"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 09:58:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="536514724"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 16 Jun 2022 09:58:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3F181109; Thu, 16 Jun 2022 19:58:30 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v1 01/11] mfd: intel_soc_pmic_bxtwc: Don't shadow error codes in show()/store()
Date:   Thu, 16 Jun 2022 19:58:13 +0300
Message-Id: <20220616165823.4919-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kstrtox() along with regmap API can return different error codes based on
circumstances.

Don't shadow them when returning to the caller.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel_soc_pmic_bxtwc.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
index bc069c4daa60..3148a319d467 100644
--- a/drivers/mfd/intel_soc_pmic_bxtwc.c
+++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
@@ -339,10 +339,14 @@ static ssize_t addr_show(struct device *dev,
 static ssize_t addr_store(struct device *dev,
 			  struct device_attribute *attr, const char *buf, size_t count)
 {
-	if (kstrtoul(buf, 0, &bxtwc_reg_addr)) {
+	int ret;
+
+	ret = kstrtoul(buf, 0, &bxtwc_reg_addr);
+	if (ret) {
 		dev_err(dev, "Invalid register address\n");
-		return -EINVAL;
+		return ret;
 	}
+
 	return (ssize_t)count;
 }
 
@@ -354,9 +358,9 @@ static ssize_t val_show(struct device *dev,
 	struct intel_soc_pmic *pmic = dev_get_drvdata(dev);
 
 	ret = regmap_read(pmic->regmap, bxtwc_reg_addr, &val);
-	if (ret < 0) {
+	if (ret) {
 		dev_err(dev, "Failed to read 0x%lx\n", bxtwc_reg_addr);
-		return -EIO;
+		return ret;
 	}
 
 	return sprintf(buf, "0x%02x\n", val);
@@ -377,7 +381,7 @@ static ssize_t val_store(struct device *dev,
 	if (ret) {
 		dev_err(dev, "Failed to write value 0x%02x to address 0x%lx",
 			val, bxtwc_reg_addr);
-		return -EIO;
+		return ret;
 	}
 	return count;
 }
-- 
2.35.1

