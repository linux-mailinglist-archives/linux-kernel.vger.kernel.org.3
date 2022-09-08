Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56EBD5B1FD7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbiIHN51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbiIHN4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:56:54 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83E7B6D14;
        Thu,  8 Sep 2022 06:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662645410; x=1694181410;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ClRv4YDuC6sHMGg76v4yV0u46OLwed7onWZxOHGjYlw=;
  b=hAYdbV1kCjaKXzNcOCx5Ed4565b3J0300//eYlKC6k97iL/oF29LPlE7
   QvZtRBtHKYB3MN3tRQl8wfGL18OczHLaCwLP8niImVK2MoWRmZwOAW7GY
   3Zy9QjuOyXUB57nKtTIo2umTRMyCDZ50cEOkXb68PZRIjpk+rXOUwq2y6
   qoYxBaIapcJeavfDcnvW103JEOBwi5/zvXIXL8MdWOtrPapDJBD7qvpsk
   FDGDzjBg4xvF8p0Dm3t/MfbIQPnDZ55WQwYMy4IMgUwjLnfjUQlfCccu4
   8GJ4PdfFgYJ6cyxf1PBq+ZzrFOoNOtREiImPaVLTz1dCE08n0Pd4dEDEN
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="358906744"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="358906744"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 06:56:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="943352130"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 08 Sep 2022 06:56:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B8D8B6CD; Thu,  8 Sep 2022 16:57:02 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v2 9/9] pwm: lpss: Allow other drivers to enable PWM LPSS
Date:   Thu,  8 Sep 2022 16:56:58 +0300
Message-Id: <20220908135658.64463-10-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220908135658.64463-1-andriy.shevchenko@linux.intel.com>
References: <20220908135658.64463-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PWM LPSS device can be embedded in another device.
In order to enable it, allow that drivers to probe
a corresponding device.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pwm/pwm-lpss.h                        | 26 ++--------------
 .../linux/platform_data/x86}/pwm-lpss.h       | 30 ++++---------------
 2 files changed, 7 insertions(+), 49 deletions(-)
 copy {drivers/pwm => include/linux/platform_data/x86}/pwm-lpss.h (52%)

diff --git a/drivers/pwm/pwm-lpss.h b/drivers/pwm/pwm-lpss.h
index 0249c01befd5..fe32e336db8e 100644
--- a/drivers/pwm/pwm-lpss.h
+++ b/drivers/pwm/pwm-lpss.h
@@ -13,11 +13,9 @@
 #include <linux/pwm.h>
 #include <linux/types.h>
 
-#define MAX_PWMS			4
-
-struct device;
+#include <linux/platform_data/x86/pwm-lpss.h>
 
-struct pwm_lpss_boardinfo;
+#define MAX_PWMS			4
 
 struct pwm_lpss_chip {
 	struct pwm_chip chip;
@@ -25,29 +23,9 @@ struct pwm_lpss_chip {
 	const struct pwm_lpss_boardinfo *info;
 };
 
-struct pwm_lpss_boardinfo {
-	unsigned long clk_rate;
-	unsigned int npwm;
-	unsigned long base_unit_bits;
-	/*
-	 * Some versions of the IP may stuck in the state machine if enable
-	 * bit is not set, and hence update bit will show busy status till
-	 * the reset. For the rest it may be otherwise.
-	 */
-	bool bypass;
-	/*
-	 * On some devices the _PS0/_PS3 AML code of the GPU (GFX0) device
-	 * messes with the PWM0 controllers state,
-	 */
-	bool other_devices_aml_touches_pwm_regs;
-};
-
 extern const struct pwm_lpss_boardinfo pwm_lpss_byt_info;
 extern const struct pwm_lpss_boardinfo pwm_lpss_bsw_info;
 extern const struct pwm_lpss_boardinfo pwm_lpss_bxt_info;
 extern const struct pwm_lpss_boardinfo pwm_lpss_tng_info;
 
-struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, void __iomem *base,
-				     const struct pwm_lpss_boardinfo *info);
-
 #endif	/* __PWM_LPSS_H */
diff --git a/drivers/pwm/pwm-lpss.h b/include/linux/platform_data/x86/pwm-lpss.h
similarity index 52%
copy from drivers/pwm/pwm-lpss.h
copy to include/linux/platform_data/x86/pwm-lpss.h
index 0249c01befd5..296bd837ddbb 100644
--- a/drivers/pwm/pwm-lpss.h
+++ b/include/linux/platform_data/x86/pwm-lpss.h
@@ -1,29 +1,14 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Intel Low Power Subsystem PWM controller driver
- *
- * Copyright (C) 2014, Intel Corporation
- *
- * Derived from the original pwm-lpss.c
- */
+/* Intel Low Power Subsystem PWM controller driver */
 
-#ifndef __PWM_LPSS_H
-#define __PWM_LPSS_H
+#ifndef __PLATFORM_DATA_X86_PWM_LPSS_H
+#define __PLATFORM_DATA_X86_PWM_LPSS_H
 
-#include <linux/pwm.h>
 #include <linux/types.h>
 
-#define MAX_PWMS			4
-
 struct device;
 
-struct pwm_lpss_boardinfo;
-
-struct pwm_lpss_chip {
-	struct pwm_chip chip;
-	void __iomem *regs;
-	const struct pwm_lpss_boardinfo *info;
-};
+struct pwm_lpss_chip;
 
 struct pwm_lpss_boardinfo {
 	unsigned long clk_rate;
@@ -42,12 +27,7 @@ struct pwm_lpss_boardinfo {
 	bool other_devices_aml_touches_pwm_regs;
 };
 
-extern const struct pwm_lpss_boardinfo pwm_lpss_byt_info;
-extern const struct pwm_lpss_boardinfo pwm_lpss_bsw_info;
-extern const struct pwm_lpss_boardinfo pwm_lpss_bxt_info;
-extern const struct pwm_lpss_boardinfo pwm_lpss_tng_info;
-
 struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, void __iomem *base,
 				     const struct pwm_lpss_boardinfo *info);
 
-#endif	/* __PWM_LPSS_H */
+#endif	/* __PLATFORM_DATA_X86_PWM_LPSS_H */
-- 
2.35.1

