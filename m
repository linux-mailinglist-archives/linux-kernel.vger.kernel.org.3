Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5679C54E86A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 19:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377424AbiFPRKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 13:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377598AbiFPRKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 13:10:15 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E845193D7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 10:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655399414; x=1686935414;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e7I9E3hjZZBGHdKkvpKGbfezI2QMhQaaFRyQmclEOsU=;
  b=aRYKtNok9jU4caLGrVxAd7xEDhONCcgkO/SSzy1VCJXqMWhHKZ18WgVV
   HvgaPqkzI9fR63IiGeoS6K52Q6av4TojOLXQ5DPPme7UKs61HJO+Fy13r
   yVhkeSHzDrG8hFUiJFUc8KpL6iNJ4LnrE+xIrWLk/hJXV/MnXBsWixsve
   U6DK4yuRhexYJAoKRHCbt9H2FFB3ulM/jlDphqPu+UZGEasxGLWLtq7cR
   PPdq0ZYGAFQ8r1aGPq2mcYO66/8FZr9xgbfsxi8Ov2RxUP8wIZ7r3mKLF
   wgeBtDP+9pyS9mQC2dodzkbH4+fbeE3+yWLPzDsf9Yy7xDK48UPZiVGmI
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="343258568"
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="343258568"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 10:10:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="653244582"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 16 Jun 2022 10:10:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 190D067; Thu, 16 Jun 2022 20:10:14 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v1 2/2] mfd: intel_soc_pmic_chtwc: Switch from __maybe_unused to pm_sleep_ptr() etc
Date:   Thu, 16 Jun 2022 20:10:09 +0300
Message-Id: <20220616171009.43524-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220616171009.43524-1-andriy.shevchenko@linux.intel.com>
References: <20220616171009.43524-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Letting the compiler remove these functions when the kernel is built
without CONFIG_PM_SLEEP support is simpler and less heavier for builds
than the use of __maybe_unused attributes.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel_soc_pmic_chtwc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/intel_soc_pmic_chtwc.c b/drivers/mfd/intel_soc_pmic_chtwc.c
index 1cbe2bcce530..9216f0d34206 100644
--- a/drivers/mfd/intel_soc_pmic_chtwc.c
+++ b/drivers/mfd/intel_soc_pmic_chtwc.c
@@ -222,7 +222,7 @@ static void cht_wc_shutdown(struct i2c_client *client)
 	disable_irq(pmic->irq);
 }
 
-static int __maybe_unused cht_wc_suspend(struct device *dev)
+static int cht_wc_suspend(struct device *dev)
 {
 	struct intel_soc_pmic *pmic = dev_get_drvdata(dev);
 
@@ -231,7 +231,7 @@ static int __maybe_unused cht_wc_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused cht_wc_resume(struct device *dev)
+static int cht_wc_resume(struct device *dev)
 {
 	struct intel_soc_pmic *pmic = dev_get_drvdata(dev);
 
@@ -239,7 +239,7 @@ static int __maybe_unused cht_wc_resume(struct device *dev)
 
 	return 0;
 }
-static SIMPLE_DEV_PM_OPS(cht_wc_pm_ops, cht_wc_suspend, cht_wc_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(cht_wc_pm_ops, cht_wc_suspend, cht_wc_resume);
 
 static const struct i2c_device_id cht_wc_i2c_id[] = {
 	{ }
@@ -253,7 +253,7 @@ static const struct acpi_device_id cht_wc_acpi_ids[] = {
 static struct i2c_driver cht_wc_driver = {
 	.driver	= {
 		.name	= "CHT Whiskey Cove PMIC",
-		.pm     = &cht_wc_pm_ops,
+		.pm     = pm_sleep_ptr(&cht_wc_pm_ops),
 		.acpi_match_table = cht_wc_acpi_ids,
 	},
 	.probe_new = cht_wc_probe,
-- 
2.35.1

