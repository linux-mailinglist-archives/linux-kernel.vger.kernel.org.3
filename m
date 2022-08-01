Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40C6586851
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 13:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbiHALmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 07:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbiHALmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 07:42:11 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4106733419
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 04:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659354130; x=1690890130;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eLE5JXpyuqjBs0RA8OwFmBNSvArt/ZwPHwg7TY/2cPw=;
  b=AbHu0x2KZ8oWjlGFSwBkgvm3oD8XiSMBh1y+x/24MONIoEwqq2uIIJCY
   uKSjmb6ZgDX42x2VYlx+LxW3cwJdtMGNEVAw+YiuQw4vWVuYDf/O0cNdA
   9J8UUCvsdkXSC06Aovu4XtMYTV0rH5ylmNJ4IjW/N4KaKev4I/N2AO2bg
   ib5Sg4EfNFiFQl1J7xMVQv2EtxCTZ3hlAwBRPj21J7rVw9Qid3Q6lJdgm
   JbIl/Z+NjQzs8wyBfZhbaJbAMKiJF3u8FWwNV1d5exuubRsxwNsQxAcGF
   9tTFTI+sJUZHdmhZPKQ0XhrJJBno/S+fgyzy8lgFO+fvyBhvhOWUJc/8t
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10425"; a="314949663"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="314949663"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 04:42:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="691434126"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Aug 2022 04:42:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1843A1DF; Mon,  1 Aug 2022 14:42:14 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee@kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v3 05/10] mfd: intel_soc_pmic_crc: Convert to use i2c_get/set_clientdata()
Date:   Mon,  1 Aug 2022 14:42:06 +0300
Message-Id: <20220801114211.36267-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220801114211.36267-1-andriy.shevchenko@linux.intel.com>
References: <20220801114211.36267-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

v3: no changes
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

