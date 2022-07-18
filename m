Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94D857822E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbiGRMXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbiGRMXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:23:33 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547F5252B5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658147012; x=1689683012;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tu5LmTNUiV8XlJ9H6mRPQmc+5x+pCXgr6bjCySCdlf8=;
  b=dZBuimeWdDzqHzUXAqHMzpe/xNFKej3Vt7h1UQs/9e+7B6bkoFjnc2w1
   hobpkHJhLcxxVsG+MIx5rkNbzi6nSb3A6FFy+WoMRjazkVvAEDN42Mo64
   k51zv7KxeXnTHdFQuZCf95MCVRatMO/oXTxzZvd9BCQYadoPRCtPgpfsp
   PUZKJOwA0duXvpJKp0M91m0afCeMXz5SyLBBDJdJeKerG+9fqdWft+/yl
   NsAqrcSPLJWsApQkGIMBUDX/MEAS4VevAAyzZxws12c0e5912eFVh3Gi7
   nTkil1txExuXrxPTnyy9dX+elL7Y153NI9DuzdjiOPNrBFZvLip/5V8yR
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="283772482"
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="283772482"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 05:23:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="739447120"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 18 Jul 2022 05:23:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4828EF1; Mon, 18 Jul 2022 15:23:39 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [RESEND][PATCH v1 2/9] mfd: intel_soc_pmic_crc: Convert to use i2c_get/set_clientdata()
Date:   Mon, 18 Jul 2022 15:23:21 +0300
Message-Id: <20220718122328.8287-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220718122328.8287-1-andriy.shevchenko@linux.intel.com>
References: <20220718122328.8287-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have the specific helpers for I2C device to set and get its driver data.
Convert driver to use them instead of open coded variants.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Hans de Goede <hdegoede@redhat.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/intel_soc_pmic_crc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/intel_soc_pmic_crc.c b/drivers/mfd/intel_soc_pmic_crc.c
index 187a4ede1148..165f686132f6 100644
--- a/drivers/mfd/intel_soc_pmic_crc.c
+++ b/drivers/mfd/intel_soc_pmic_crc.c
@@ -181,7 +181,7 @@ static int intel_soc_pmic_i2c_probe(struct i2c_client *i2c,
 	if (!pmic)
 		return -ENOMEM;
 
-	dev_set_drvdata(dev, pmic);
+	i2c_set_clientdata(i2c, pmic);
 
 	pmic->regmap = devm_regmap_init_i2c(i2c, config->regmap_config);
 	if (IS_ERR(pmic->regmap))
@@ -222,7 +222,7 @@ static int intel_soc_pmic_i2c_remove(struct i2c_client *i2c)
 
 static void intel_soc_pmic_shutdown(struct i2c_client *i2c)
 {
-	struct intel_soc_pmic *pmic = dev_get_drvdata(&i2c->dev);
+	struct intel_soc_pmic *pmic = i2c_get_clientdata(i2c);
 
 	disable_irq(pmic->irq);
 
-- 
2.35.1

