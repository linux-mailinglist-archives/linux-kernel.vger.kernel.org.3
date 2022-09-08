Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2A65B1FCB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbiIHN5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbiIHN4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:56:51 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C6CFBF33;
        Thu,  8 Sep 2022 06:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662645410; x=1694181410;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=utCileiSE7bLSjAcc6EdD2itncoMCWpsLzAPOz2wAMA=;
  b=F864B3Lf3v0X1Krfg8UTVLklMQnwJeArpRlz/70V7+ndmDipSRuGQmaz
   jN0ntKti3jOy4R+6BdpRLkBsgQWswPdkouYNS3ePUcXLMZJlr1l5fw7ie
   DBhbeM/M9uOIApjoEJw8jN6fElui4xH9S6EAy6ViUXj0G+m9nfri7o10b
   n6+kemTGnlUJLbLxhmf/btsZ2287SacGjPE74BXnfLcQKkufVS70Lied5
   yWZmz7SdG/mISn29544N5Kwk6y9X662xBs6K/WL1UA/8wQB4QxfcwQ1Ic
   yUvQZw2lcK+dh308O4UqMya6vkA7ZIytbWA8CCjr//opZ3b/Q6jWKrWq0
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="276908274"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="276908274"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 06:56:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="740678860"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 08 Sep 2022 06:56:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 58BC0F7; Thu,  8 Sep 2022 16:57:02 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v2 1/9] pwm: lpss: Deduplicate board info data structures
Date:   Thu,  8 Sep 2022 16:56:50 +0300
Message-Id: <20220908135658.64463-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220908135658.64463-1-andriy.shevchenko@linux.intel.com>
References: <20220908135658.64463-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Move the board info structures from the glue drivers to the
common library and hence deduplicate configuration data.

For the Intel Braswell case the ACPI version should be used.
Because switch to ACPI/PCI is done in BIOS while quite likely
the rest of AML code is the same, meaning similar issue might
be observed. There is no bug report due to no PCI enabled device
in the wild, Andy thinks, and only reference boards can be tested,
so nobody really cares about Intel Braswell PCI case.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pwm/pwm-lpss-pci.c      | 29 ----------------------------
 drivers/pwm/pwm-lpss-platform.c | 22 ---------------------
 drivers/pwm/pwm-lpss.c          | 34 +++++++++++++++++++++++++++++++++
 drivers/pwm/pwm-lpss.h          |  5 +++++
 4 files changed, 39 insertions(+), 51 deletions(-)

diff --git a/drivers/pwm/pwm-lpss-pci.c b/drivers/pwm/pwm-lpss-pci.c
index c893ec3d2fb4..75b778e839b3 100644
--- a/drivers/pwm/pwm-lpss-pci.c
+++ b/drivers/pwm/pwm-lpss-pci.c
@@ -14,35 +14,6 @@
 
 #include "pwm-lpss.h"
 
-/* BayTrail */
-static const struct pwm_lpss_boardinfo pwm_lpss_byt_info = {
-	.clk_rate = 25000000,
-	.npwm = 1,
-	.base_unit_bits = 16,
-};
-
-/* Braswell */
-static const struct pwm_lpss_boardinfo pwm_lpss_bsw_info = {
-	.clk_rate = 19200000,
-	.npwm = 1,
-	.base_unit_bits = 16,
-};
-
-/* Broxton */
-static const struct pwm_lpss_boardinfo pwm_lpss_bxt_info = {
-	.clk_rate = 19200000,
-	.npwm = 4,
-	.base_unit_bits = 22,
-	.bypass = true,
-};
-
-/* Tangier */
-static const struct pwm_lpss_boardinfo pwm_lpss_tng_info = {
-	.clk_rate = 19200000,
-	.npwm = 4,
-	.base_unit_bits = 22,
-};
-
 static int pwm_lpss_probe_pci(struct pci_dev *pdev,
 			      const struct pci_device_id *id)
 {
diff --git a/drivers/pwm/pwm-lpss-platform.c b/drivers/pwm/pwm-lpss-platform.c
index 928570430cef..834423c34f48 100644
--- a/drivers/pwm/pwm-lpss-platform.c
+++ b/drivers/pwm/pwm-lpss-platform.c
@@ -15,28 +15,6 @@
 
 #include "pwm-lpss.h"
 
-/* BayTrail */
-static const struct pwm_lpss_boardinfo pwm_lpss_byt_info = {
-	.clk_rate = 25000000,
-	.npwm = 1,
-	.base_unit_bits = 16,
-};
-
-/* Braswell */
-static const struct pwm_lpss_boardinfo pwm_lpss_bsw_info = {
-	.clk_rate = 19200000,
-	.npwm = 1,
-	.base_unit_bits = 16,
-	.other_devices_aml_touches_pwm_regs = true,
-};
-
-/* Broxton */
-static const struct pwm_lpss_boardinfo pwm_lpss_bxt_info = {
-	.clk_rate = 19200000,
-	.npwm = 4,
-	.base_unit_bits = 22,
-	.bypass = true,
-};
 
 static int pwm_lpss_probe_platform(struct platform_device *pdev)
 {
diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index 36d4e83e6b79..9537aefd254a 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -29,6 +29,40 @@
 /* Size of each PWM register space if multiple */
 #define PWM_SIZE			0x400
 
+/* BayTrail */
+const struct pwm_lpss_boardinfo pwm_lpss_byt_info = {
+	.clk_rate = 25000000,
+	.npwm = 1,
+	.base_unit_bits = 16,
+};
+EXPORT_SYMBOL_GPL(pwm_lpss_byt_info);
+
+/* Braswell */
+const struct pwm_lpss_boardinfo pwm_lpss_bsw_info = {
+	.clk_rate = 19200000,
+	.npwm = 1,
+	.base_unit_bits = 16,
+	.other_devices_aml_touches_pwm_regs = true,
+};
+EXPORT_SYMBOL_GPL(pwm_lpss_bsw_info);
+
+/* Broxton */
+const struct pwm_lpss_boardinfo pwm_lpss_bxt_info = {
+	.clk_rate = 19200000,
+	.npwm = 4,
+	.base_unit_bits = 22,
+	.bypass = true,
+};
+EXPORT_SYMBOL_GPL(pwm_lpss_bxt_info);
+
+/* Tangier */
+const struct pwm_lpss_boardinfo pwm_lpss_tng_info = {
+	.clk_rate = 19200000,
+	.npwm = 4,
+	.base_unit_bits = 22,
+};
+EXPORT_SYMBOL_GPL(pwm_lpss_tng_info);
+
 static inline struct pwm_lpss_chip *to_lpwm(struct pwm_chip *chip)
 {
 	return container_of(chip, struct pwm_lpss_chip, chip);
diff --git a/drivers/pwm/pwm-lpss.h b/drivers/pwm/pwm-lpss.h
index 8b3476f25e06..9ea5b145a353 100644
--- a/drivers/pwm/pwm-lpss.h
+++ b/drivers/pwm/pwm-lpss.h
@@ -33,6 +33,11 @@ struct pwm_lpss_boardinfo {
 	bool other_devices_aml_touches_pwm_regs;
 };
 
+extern const struct pwm_lpss_boardinfo pwm_lpss_byt_info;
+extern const struct pwm_lpss_boardinfo pwm_lpss_bsw_info;
+extern const struct pwm_lpss_boardinfo pwm_lpss_bxt_info;
+extern const struct pwm_lpss_boardinfo pwm_lpss_tng_info;
+
 struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, struct resource *r,
 				     const struct pwm_lpss_boardinfo *info);
 
-- 
2.35.1

