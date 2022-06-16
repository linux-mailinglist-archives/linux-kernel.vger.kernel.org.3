Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE6254E869
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 19:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377608AbiFPRKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 13:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377424AbiFPRKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 13:10:13 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325172DA84
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 10:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655399412; x=1686935412;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=32HxJOvFe5LZApNUOvk3//aeHqxqF88d7eIx8ooqBDg=;
  b=Z+KeqIbj4s23zuowuaCcBnbaoDbGdPeeqIwRcHV7XFl3ZjgYm4mI9Ttk
   M6wIEuCuk23Svg2XmTbjKHmxXMmGbzoxuz325IArguOy3cwCjLml4IvIr
   KB6oaH3uZcwZa3w4VUgYkA8xAIGLJA5+m+u6hNpxsoUaWmwjTpeilrWkm
   OQoTdN5LNvV9VrMBEH+RZL+5sdfW7LNW5Jq/BjKFirNVplE+3SvCC4NDn
   utPVpv4vO6jTMGpOkrIIcURbFRsjTWZNzsIJNByK0UXIIuIN+j9LIxOvn
   sBuuEqDWs7ydKcYlnNLDITGTFXI0gzj1xwAJoCX29j/rJemxuxdFKM7IC
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="259760129"
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="259760129"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 10:10:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="583710378"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 16 Jun 2022 10:10:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 09EF3109; Thu, 16 Jun 2022 20:10:13 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v1 1/2] mfd: intel_soc_pmic_chtwc: Use dev_err_probe()
Date:   Thu, 16 Jun 2022 20:10:08 +0300
Message-Id: <20220616171009.43524-1-andriy.shevchenko@linux.intel.com>
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

Simplify the mux error path a bit by using dev_err_probe().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel_soc_pmic_chtwc.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/mfd/intel_soc_pmic_chtwc.c b/drivers/mfd/intel_soc_pmic_chtwc.c
index 4eab191e053a..1cbe2bcce530 100644
--- a/drivers/mfd/intel_soc_pmic_chtwc.c
+++ b/drivers/mfd/intel_soc_pmic_chtwc.c
@@ -179,18 +179,13 @@ static int cht_wc_probe(struct i2c_client *client)
 	int ret;
 
 	status = acpi_evaluate_integer(ACPI_HANDLE(dev), "_HRV", NULL, &hrv);
-	if (ACPI_FAILURE(status)) {
-		dev_err(dev, "Failed to get PMIC hardware revision\n");
-		return -ENODEV;
-	}
-	if (hrv != CHT_WC_HRV) {
-		dev_err(dev, "Invalid PMIC hardware revision: %llu\n", hrv);
-		return -ENODEV;
-	}
-	if (client->irq < 0) {
-		dev_err(dev, "Invalid IRQ\n");
-		return -EINVAL;
-	}
+	if (ACPI_FAILURE(status))
+		return dev_err_probe(dev, -ENODEV, "Failed to get PMIC hardware revision\n");
+	if (hrv != CHT_WC_HRV)
+		return dev_err_probe(dev, -ENODEV, "Invalid PMIC hardware revision: %llu\n", hrv);
+
+	if (client->irq < 0)
+		return dev_err_probe(dev, -EINVAL, "Invalid IRQ\n");
 
 	pmic = devm_kzalloc(dev, sizeof(*pmic), GFP_KERNEL);
 	if (!pmic)
-- 
2.35.1

