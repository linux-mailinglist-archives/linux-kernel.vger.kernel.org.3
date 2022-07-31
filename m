Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B269058613A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 22:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238177AbiGaUNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 16:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237957AbiGaUNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 16:13:00 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3167BE0F8
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 13:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659298380; x=1690834380;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x0G/UicCyUUaNKhyjypbh9HPhPXzexP3V4lPe1524XA=;
  b=K+ps9Rj4R7yg/PVq7m6ZKmQ11R47mqzj0NmGlil/bzaCc/TNMK02ji7L
   VwhBoTlLx7yfr1mST618Bn65wcyU/0tjo0bePY+GiKR1lzObSh6+x3l6A
   GCtqkWY8EvjzXR3Urc+0jOES+NWQiMj4zh2+FS4GKwOtnAqgzP9e3J6hm
   yjpPibrD2TmJt/6biySxcrVaZTV4HJ9ArUfg8F6a9q82+6pd4P4e9+lJe
   Vp+6KdNZgV5VwqckpOoty0cZ4azvX7WA4jKIc7efvUFBFPLYPxTzkjmzh
   z2euEi8ha+AMJeLY148iZ4IYSMJ808HZm59Q660MUy7OpNZuh10tMR5gW
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10425"; a="375326704"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="375326704"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 13:12:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="669829855"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 31 Jul 2022 13:12:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5E84B1D0; Sun, 31 Jul 2022 23:13:08 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee@kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v2 04/10] mfd: intel_soc_pmic_crc: Use devm_regmap_add_irq_chip()
Date:   Sun, 31 Jul 2022 23:12:52 +0300
Message-Id: <20220731201258.11262-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220731201258.11262-1-andriy.shevchenko@linux.intel.com>
References: <20220731201258.11262-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_regmap_add_irq_chip() to simplify the code.

While at it, replace -1 magic parameter by PLATFORM_DEVID_NONE when
calling mfd_add_devices().

Note, the mfd_add_devices() left in non-devm variant here due to
potentially increased churn while wrapping pwm_remove_table().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Hans de Goede <hdegoede@redhat.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
v2: added tags and rebased on top of new patch 1

 drivers/mfd/intel_soc_pmic_crc.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/mfd/intel_soc_pmic_crc.c b/drivers/mfd/intel_soc_pmic_crc.c
index c4e6456976f5..64cdd435f8c5 100644
--- a/drivers/mfd/intel_soc_pmic_crc.c
+++ b/drivers/mfd/intel_soc_pmic_crc.c
@@ -189,10 +189,9 @@ static int intel_soc_pmic_i2c_probe(struct i2c_client *i2c,
 
 	pmic->irq = i2c->irq;
 
-	ret = regmap_add_irq_chip(pmic->regmap, pmic->irq,
-				  config->irq_flags | IRQF_ONESHOT,
-				  0, config->irq_chip,
-				  &pmic->irq_chip_data);
+	ret = devm_regmap_add_irq_chip(dev, pmic->regmap, pmic->irq,
+				       config->irq_flags | IRQF_ONESHOT,
+				       0, config->irq_chip, &pmic->irq_chip_data);
 	if (ret)
 		return ret;
 
@@ -207,26 +206,17 @@ static int intel_soc_pmic_i2c_probe(struct i2c_client *i2c,
 	irq_domain_update_bus_token(regmap_irq_get_domain(pmic->irq_chip_data),
 				    DOMAIN_BUS_NEXUS);
 
-	ret = mfd_add_devices(dev, -1, config->cell_dev,
+	ret = mfd_add_devices(dev, PLATFORM_DEVID_NONE, config->cell_dev,
 			      config->n_cell_devs, NULL, 0,
 			      regmap_irq_get_domain(pmic->irq_chip_data));
 	if (ret)
-		goto err_del_irq_chip;
+		pwm_remove_table(crc_pwm_lookup, ARRAY_SIZE(crc_pwm_lookup));
 
-	return 0;
-
-err_del_irq_chip:
-	pwm_remove_table(crc_pwm_lookup, ARRAY_SIZE(crc_pwm_lookup));
-	regmap_del_irq_chip(pmic->irq, pmic->irq_chip_data);
 	return ret;
 }
 
 static int intel_soc_pmic_i2c_remove(struct i2c_client *i2c)
 {
-	struct intel_soc_pmic *pmic = dev_get_drvdata(&i2c->dev);
-
-	regmap_del_irq_chip(pmic->irq, pmic->irq_chip_data);
-
 	/* remove crc-pwm lookup table */
 	pwm_remove_table(crc_pwm_lookup, ARRAY_SIZE(crc_pwm_lookup));
 
-- 
2.35.1

