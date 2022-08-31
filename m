Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542D25A7F66
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 15:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiHaN5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 09:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiHaN5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 09:57:40 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB57D5DEE;
        Wed, 31 Aug 2022 06:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661954259; x=1693490259;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bSCpQemP9GCiNd65ezhOmkR6CRf+YU/xosrXiMoIVAE=;
  b=SVmmqI4vl1xkvWWcbtbQqRVpnW6z5Xv4zV4pmHiN7bqbWq8u7CSyh69F
   hceHA/Mu1EkgDu5/FcToHtSJrx5F6hD4F8y1cUNA1qBdPwZOAUhfIYnmD
   D58QGbcvaLIJnI3HWFKkuBOYdceIJLUmWoRAalPYg7jjSCv7vS7e25bB+
   FunHUDgbRIta+RIEXQwrOgx9twBqBvgfrA1DjxSMXWwM2XV6VcUGwyFND
   CYlBagsQwDV2aIhry+6foT9BhMWoW0y8JBkl+k5z+p6RTPHLtnwPxJKlR
   5VWhz+0Tby6XpE+GNXiYF/Q3aNexEbSgSAu/4KJdd8j8TMYUKkCVlMyVr
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="275853486"
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="275853486"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 06:57:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="673361223"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 31 Aug 2022 06:57:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 006D919D; Wed, 31 Aug 2022 16:57:50 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 3/3] ACPI: PMIC: Convert pr_*() to dev_*() printing macros
Date:   Wed, 31 Aug 2022 16:57:49 +0300
Message-Id: <20220831135749.78743-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220831135749.78743-1-andriy.shevchenko@linux.intel.com>
References: <20220831135749.78743-1-andriy.shevchenko@linux.intel.com>
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
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
v3: added tag (Mika)
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

