Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB7A57822D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbiGRMXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbiGRMXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:23:33 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5220624F20
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658147012; x=1689683012;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l+msobxS9p5Huw/9u/bccwG0q8VfI/K+EFXqCeMYcS8=;
  b=NHA+zpNKwSl5RN6kj5fUSETmjaNu/29c50LxUHm5hO+A548SVYWv65nt
   iXln/kBcZjdBKqISL1BhtEYlB4sa2hGLj673XnayeIBnp1Ah2G8TyTDTY
   zLdBfbKt7qyCRUotJ3iRBjPixr96iz0Q1fLWUUnxM2JtEx9iSraQ2im5Y
   acaND2sc0do4/xlsOQzaItXRRG1rpVPsBZC58ujtvSl1Bd9E/VkqSflgC
   Nm8h2jk26dhC8K5pSYYakCtLNrXrkUNErts1av62Wa12qvqH5vrUZD2oa
   zmczQcMulDIBUTB8z8WgF0bgoXy6iLaSO2Cj21LXfXvoeGt8mJWRw2ase
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="266611161"
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="266611161"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 05:23:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="700013651"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 18 Jul 2022 05:23:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 67BF63E3; Mon, 18 Jul 2022 15:23:39 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [RESEND][PATCH v1 5/9] mfd: intel_soc_pmic_crc: Convert driver to use ->probe_new()
Date:   Mon, 18 Jul 2022 15:23:24 +0300
Message-Id: <20220718122328.8287-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220718122328.8287-1-andriy.shevchenko@linux.intel.com>
References: <20220718122328.8287-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the ->probe_new() callback.

The driver does not use const struct i2c_device_id * argument,
so convert it to utilise the simplified I²C driver registration.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Hans de Goede <hdegoede@redhat.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
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

