Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A125658684E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 13:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbiHALmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 07:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbiHALmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 07:42:09 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A178F33374
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 04:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659354128; x=1690890128;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=knGH38HWqYg1IYzJYNTLhKW9vKaYJK9SynnRiSWenHs=;
  b=gGRrNgTVa/tkKCGi8MNZ4H20Z7tgo2ZGmRF8aShyDa6Ny2MCcHWPwJQp
   dnBhmc2UlktxJzdMK+JwjNF5dK9UpvFk5gpEGeeV0kdNFg0KOM44upFrq
   WbpKxy5nAWRij26shwZRSflMOwC64FE9uFEgqsbhhbGD4u5LjMmcrCP6G
   oEhg7w+FaV9pXlwsQ0+zWpsxsutauOLr4YE5Mm6ScEnC4V33VJAo7PfN6
   LgAv1aZQ/NUp8IFBBhRHqXqine7MHd/hN6rZgtlbOtlZQb/Fz3Ar1usCc
   4QnDiEER5rMHlaKtzpngEea8OqyMs/Z5os3DRYY1328mjmv24le3n1ZjC
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10425"; a="268890679"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="268890679"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 04:42:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="552485949"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 01 Aug 2022 04:42:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 35E79417; Mon,  1 Aug 2022 14:42:14 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee@kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v3 08/10] mfd: intel_soc_pmic_crc: Convert driver to use ->probe_new()
Date:   Mon,  1 Aug 2022 14:42:09 +0300
Message-Id: <20220801114211.36267-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220801114211.36267-1-andriy.shevchenko@linux.intel.com>
References: <20220801114211.36267-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
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

v3: no changes
v2: added tags and rebased on top of new patch 1

 drivers/mfd/intel_soc_pmic_crc.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/intel_soc_pmic_crc.c b/drivers/mfd/intel_soc_pmic_crc.c
index 17fcb10930f6..d4780390fbea 100644
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
@@ -254,11 +253,6 @@ static int intel_soc_pmic_resume(struct device *dev)
 
 static DEFINE_SIMPLE_DEV_PM_OPS(crystal_cove_pm_ops, intel_soc_pmic_suspend, intel_soc_pmic_resume);
 
-static const struct i2c_device_id intel_soc_pmic_i2c_id[] = {
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, intel_soc_pmic_i2c_id);
-
 static const struct acpi_device_id intel_soc_pmic_acpi_match[] = {
 	{ "INT33FD" },
 	{ },
@@ -271,9 +265,8 @@ static struct i2c_driver intel_soc_pmic_i2c_driver = {
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

