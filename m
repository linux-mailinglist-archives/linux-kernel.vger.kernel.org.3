Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E87158613C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 22:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbiGaUN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 16:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238102AbiGaUNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 16:13:02 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27395E0F3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 13:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659298382; x=1690834382;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eaGYxfYFuFCvqgNvT9J44n+zfP1xenIG9ssD8KmUKwQ=;
  b=Bq6gndAEL+C7+X6Rxpw3Qj083XmmLg1vU15QzQkIuBn+o9v/BanguwdF
   r9bqcyvvQMUoP/yz+eThrTXjCD8XUNDYdVDb8p8g73H/NQ41ycky4PYVj
   tnWq494wOLz1OfwgDIawO+KERN/npnNN8WEG0JPnwnW/JskIjwwiFCxjs
   h7JTZENCpGrAjH8UBGxkhGG69pGoVjvoMRrRCDWa1Q98PoQW+dF0MzFYt
   yylPyLa2/FVSchkkTAU6BAVv+pdVAjNvTCVQJqr2qb4FVySBuvo+WCtKA
   lwA/OhBV4dvGV5xiPSfhAOo3M3xY4xizxfq/ZHweGz7trio8YJbhxxwbw
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10425"; a="287779682"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="287779682"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 13:13:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="929327773"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 31 Jul 2022 13:13:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8FF3A417; Sun, 31 Jul 2022 23:13:08 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee@kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v2 08/10] mfd: intel_soc_pmic_crc: Convert driver to use ->probe_new()
Date:   Sun, 31 Jul 2022 23:12:56 +0300
Message-Id: <20220731201258.11262-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220731201258.11262-1-andriy.shevchenko@linux.intel.com>
References: <20220731201258.11262-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

