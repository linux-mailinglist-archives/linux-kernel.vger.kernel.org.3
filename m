Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E65586138
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 22:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238280AbiGaUNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 16:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238044AbiGaUNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 16:13:00 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E720EE07
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 13:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659298380; x=1690834380;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YH1woyFQ2Vb65JPOBA29W1A9OjpciCvJkegmreEUmow=;
  b=TN/E2y9S3EGmBN3x5B0h5y9dzhxC+JndQ70DLJZB5JDqdbpEy9QFHuw3
   7wW6qkTZtnIQpWHO3sgi/BoLrmwPftkrBbHcaPppJoM+GvOOwuLfVeNQu
   G6GqtoeZd13QzA9eglgMjgl64c5lOvas6mPAAKwHlY5wWjvlybXo2kkJf
   G81rlZu2b+wBwDa70Qp6zk+/W0sRuev+KIb//mP9fkbJjSi+65COjCRCb
   hu0V6KN7iNJIMeMgIs051WINrb4u4NroDkNhf7wV7CAp/5fGAMBodvuqW
   Lq0oWwscKokw7kfXHk6BVfnFNcDau+kC2Dk6Q+fFi8n8zuKHuzNrKizi9
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10425"; a="350729833"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="350729833"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 13:12:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="660895722"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 31 Jul 2022 13:12:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 63C7011C; Sun, 31 Jul 2022 23:13:08 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee@kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v2 05/10] mfd: intel_soc_pmic_crc: Convert to use i2c_get/set_clientdata()
Date:   Sun, 31 Jul 2022 23:12:53 +0300
Message-Id: <20220731201258.11262-5-andriy.shevchenko@linux.intel.com>
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

We have the specific helpers for I2C device to set and get its driver data.
Convert driver to use them instead of open coded variants.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Hans de Goede <hdegoede@redhat.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
v2: added tags and rebased on top of new patch 1

 drivers/mfd/intel_soc_pmic_crc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/intel_soc_pmic_crc.c b/drivers/mfd/intel_soc_pmic_crc.c
index 64cdd435f8c5..082007485cda 100644
--- a/drivers/mfd/intel_soc_pmic_crc.c
+++ b/drivers/mfd/intel_soc_pmic_crc.c
@@ -181,7 +181,7 @@ static int intel_soc_pmic_i2c_probe(struct i2c_client *i2c,
 	if (!pmic)
 		return -ENOMEM;
 
-	dev_set_drvdata(dev, pmic);
+	i2c_set_clientdata(i2c, pmic);
 
 	pmic->regmap = devm_regmap_init_i2c(i2c, config->regmap_config);
 	if (IS_ERR(pmic->regmap))
@@ -227,7 +227,7 @@ static int intel_soc_pmic_i2c_remove(struct i2c_client *i2c)
 
 static void intel_soc_pmic_shutdown(struct i2c_client *i2c)
 {
-	struct intel_soc_pmic *pmic = dev_get_drvdata(&i2c->dev);
+	struct intel_soc_pmic *pmic = i2c_get_clientdata(i2c);
 
 	disable_irq(pmic->irq);
 
-- 
2.35.1

