Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBA054E94B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 20:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377716AbiFPSZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 14:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236005AbiFPSZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 14:25:34 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2756350B14
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 11:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655403934; x=1686939934;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sF79Qt828qMrKLiz8Nxfo108qZt8bdqIRJBaL0fX77g=;
  b=PcVLxhNDZgcqQsrpSn3PfDnRINyaSeQdKOhmH4pVwflPgda9jrJKgf6x
   fHSnKpHcbC2CzMRiJm/nqLmsCkZ5Jk5CV8KOw8WjVXtM0+ZpS1evolx7x
   6Mu8fWvR/okV7mZG35YazHMcInQopOHndtFwa3S2LzKb563gZn4C+hMID
   t34yl7r+U7njRi7bTpZj/G7QIf8X+rNuof1hOXRLvqCRog8Oixk7cbVh2
   9kcPnwHrWH02MXUW+7MV+sfjgHazzsMBbd6yxguRZ5OwAuYVkOfYTeRYe
   MYAFZ8sTAn5q5i9UEpYeqzUKNS08vB/iMRAoqHtJ3OkYvB4GTBoDmESWg
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="262340666"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="262340666"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 11:25:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="762957514"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 16 Jun 2022 11:25:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A927F4BA; Thu, 16 Jun 2022 21:25:34 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 7/9] mfd: intel_soc_pmic_crc: Convert driver to use ->probe_new()
Date:   Thu, 16 Jun 2022 21:25:22 +0300
Message-Id: <20220616182524.7956-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220616182524.7956-1-andriy.shevchenko@linux.intel.com>
References: <20220616182524.7956-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the ->probe_new() callback.

The driver does not use const struct i2c_device_id * argument,
so convert it to utilise the simplified I²C driver registration.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel_soc_pmic_crc.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/intel_soc_pmic_crc.c b/drivers/mfd/intel_soc_pmic_crc.c
index f1e5fdd846b3..edadc07d473e 100644
--- a/drivers/mfd/intel_soc_pmic_crc.c
+++ b/drivers/mfd/intel_soc_pmic_crc.c
@@ -164,8 +164,7 @@ static const struct intel_soc_pmic_config intel_soc_pmic_config_cht_crc = {
 	.irq_chip = &crystal_cove_irq_chip,
 };
 
-static int intel_soc_pmic_i2c_probe(struct i2c_client *i2c,
-				    const struct i2c_device_id *i2c_id)
+static int intel_soc_pmic_i2c_probe(struct i2c_client *i2c)
 {
 	const struct intel_soc_pmic_config *config;
 	struct device *dev = &i2c->dev;
@@ -249,11 +248,6 @@ static int intel_soc_pmic_resume(struct device *dev)
 
 static DEFINE_SIMPLE_DEV_PM_OPS(crystal_cove_pm_ops, intel_soc_pmic_suspend, intel_soc_pmic_resume);
 
-static const struct i2c_device_id intel_soc_pmic_i2c_id[] = {
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, intel_soc_pmic_i2c_id);
-
 static const struct acpi_device_id intel_soc_pmic_acpi_match[] = {
 	{ "INT33FD" },
 	{ },
@@ -266,9 +260,8 @@ static struct i2c_driver intel_soc_pmic_i2c_driver = {
 		.pm = pm_sleep_ptr(&crystal_cove_pm_ops),
 		.acpi_match_table = intel_soc_pmic_acpi_match,
 	},
-	.probe = intel_soc_pmic_i2c_probe,
+	.probe_new = intel_soc_pmic_i2c_probe,
 	.remove = intel_soc_pmic_i2c_remove,
-	.id_table = intel_soc_pmic_i2c_id,
 	.shutdown = intel_soc_pmic_shutdown,
 };
 
-- 
2.35.1

