Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3130D55F117
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 00:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbiF1WV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 18:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbiF1WVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 18:21:11 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10843E5DF
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 15:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656454674; x=1687990674;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YjBpaXBaUXk9Z9Z8lqLGCYIp/OKdpCpiNa2H/SoGnO4=;
  b=THF9zGzdZaCUOwUfCUZpJlPGZb8PsXRFaSOWhMtNyaQ0S0wemNfTSXob
   juHt3++9msPvBiu95ROV/FySxujC493fCiZvRzaPwndpXkWxo+BTjLWuk
   AOAfQGI1QV9o/db0gsGxA4z+F9lX3wp6dJ0D1OomOX0PEsVbOlYfzhugf
   zqytDkbIj+7KAH7p5ZiRxiKBVJi7h3wjXQvFE9KXrwUvgZF+nWiQMCIG4
   y+Y8+yiHSlfPNEVqIzs7/bMfuVDibuxFWzSfMfRynzPhisF+wLtdToMOy
   XC19WcyGSQ7Djd/9Rk7DmhVAXu+vSpCEXJ6U7sHGr9dEbzHrBhPj8E5EV
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="307348943"
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="307348943"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 15:17:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="658300938"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 28 Jun 2022 15:17:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D9F51CE; Wed, 29 Jun 2022 01:17:48 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 01/11] mfd: intel_soc_pmic_bxtwc: Don't shadow error codes in show()/store()
Date:   Wed, 29 Jun 2022 01:17:37 +0300
Message-Id: <20220628221747.33956-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kstrtox() along with regmap API can return different error codes based on
circumstances.

Don't shadow them when returning to the caller.

While at it, remove rather confusing message from addr_store().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: dropped a confusing message as well (Lee)
 drivers/mfd/intel_soc_pmic_bxtwc.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
index bc069c4daa60..bdc3153ee890 100644
--- a/drivers/mfd/intel_soc_pmic_bxtwc.c
+++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
@@ -339,10 +339,12 @@ static ssize_t addr_show(struct device *dev,
 static ssize_t addr_store(struct device *dev,
 			  struct device_attribute *attr, const char *buf, size_t count)
 {
-	if (kstrtoul(buf, 0, &bxtwc_reg_addr)) {
-		dev_err(dev, "Invalid register address\n");
-		return -EINVAL;
-	}
+	int ret;
+
+	ret = kstrtoul(buf, 0, &bxtwc_reg_addr);
+	if (ret)
+		return ret;
+
 	return (ssize_t)count;
 }
 
@@ -354,9 +356,9 @@ static ssize_t val_show(struct device *dev,
 	struct intel_soc_pmic *pmic = dev_get_drvdata(dev);
 
 	ret = regmap_read(pmic->regmap, bxtwc_reg_addr, &val);
-	if (ret < 0) {
+	if (ret) {
 		dev_err(dev, "Failed to read 0x%lx\n", bxtwc_reg_addr);
-		return -EIO;
+		return ret;
 	}
 
 	return sprintf(buf, "0x%02x\n", val);
@@ -377,7 +379,7 @@ static ssize_t val_store(struct device *dev,
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

