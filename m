Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B435A694E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 19:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiH3RL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 13:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiH3RLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 13:11:45 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C91B6D70;
        Tue, 30 Aug 2022 10:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661879504; x=1693415504;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p1rw2lqi1y8+LrcoY7xgsSlWXDb8A7zXJQ7t10y/Dd0=;
  b=UUWbJWUtXdoM9cndyzJKwf9FxkSmyxmIehNBF/mrMxB17YJ7y+6ZMCR1
   363ZtQhMN0+FSe3i+hUhIg1mCc8P5G1lkRNC6KBJaSplR2S84ksZLQrbW
   3Qhi2DAnDF+BY2GEgrQdiwsdtIOGqq1WdpRM74SEmzLryyRO3XP+VYnRW
   EYomAPaRbk+P9F9p8B371M8cvk3ExiN14mcJ+tQ9I6Vky6fDoYsgw0i+K
   3ID4Ig4cy40i+ksDEv+sJVxYpKlMcnQWvI2eOjngDtAW2jKOaG/650rSZ
   aOjEAV0258H8BbuIlAkzoUwcsT2A30P9Ayf4aBkYDwDufCoTZ6z8YtuL7
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="293989285"
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="293989285"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 10:11:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="715389266"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 30 Aug 2022 10:11:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A01AF19D; Tue, 30 Aug 2022 20:11:56 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v2 3/3] ACPI: PMIC: Convert pr_*() to dev_*() printing macros
Date:   Tue, 30 Aug 2022 20:11:55 +0300
Message-Id: <20220830171155.42962-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220830171155.42962-1-andriy.shevchenko@linux.intel.com>
References: <20220830171155.42962-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we have a device pointer in the regmap, use it for
error messages.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: new patch
 drivers/acpi/pmic/intel_pmic_chtwc.c  | 5 +++--
 drivers/acpi/pmic/intel_pmic_xpower.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/pmic/intel_pmic_chtwc.c b/drivers/acpi/pmic/intel_pmic_chtwc.c
index f2c42f4c79ca..25aa3e33b09a 100644
--- a/drivers/acpi/pmic/intel_pmic_chtwc.c
+++ b/drivers/acpi/pmic/intel_pmic_chtwc.c
@@ -236,11 +236,12 @@ static int intel_cht_wc_exec_mipi_pmic_seq_element(struct regmap *regmap,
 						   u32 reg_address,
 						   u32 value, u32 mask)
 {
+	struct device *dev = regmap_get_device(regmap);
 	u32 address;
 
 	if (i2c_client_address > 0xff || reg_address > 0xff) {
-		pr_warn("%s warning addresses too big client 0x%x reg 0x%x\n",
-			__func__, i2c_client_address, reg_address);
+		dev_warn(dev, "warning addresses too big client 0x%x reg 0x%x\n",
+			 i2c_client_address, reg_address);
 		return -ERANGE;
 	}
 
diff --git a/drivers/acpi/pmic/intel_pmic_xpower.c b/drivers/acpi/pmic/intel_pmic_xpower.c
index 3c7380ec8203..a6dc8dd0d191 100644
--- a/drivers/acpi/pmic/intel_pmic_xpower.c
+++ b/drivers/acpi/pmic/intel_pmic_xpower.c
@@ -278,11 +278,12 @@ static int intel_xpower_exec_mipi_pmic_seq_element(struct regmap *regmap,
 						   u16 i2c_address, u32 reg_address,
 						   u32 value, u32 mask)
 {
+	struct device *dev = regmap_get_device(regmap);
 	int ret;
 
 	if (i2c_address != 0x34) {
-		pr_err("%s: Unexpected i2c-addr: 0x%02x (reg-addr 0x%x value 0x%x mask 0x%x)\n",
-		       __func__, i2c_address, reg_address, value, mask);
+		dev_err(dev, "Unexpected i2c-addr: 0x%02x (reg-addr 0x%x value 0x%x mask 0x%x)\n",
+			i2c_address, reg_address, value, mask);
 		return -ENXIO;
 	}
 
-- 
2.35.1

