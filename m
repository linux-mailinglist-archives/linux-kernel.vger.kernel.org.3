Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00305AF54B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 22:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiIFUEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 16:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiIFUEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 16:04:02 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2211409B;
        Tue,  6 Sep 2022 12:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662494382; x=1694030382;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1GmuwRmBcP+qpqm868ZlLiTER6yT1AblOqnH4Dlpe/4=;
  b=WUlupqneHjKsRzvVz5N7pYtc/7DBPiirwHapJDv4QeFXpVRxepSnlse3
   aFFUPEpdIzMt+UiIVhEWDVfQZu0HZZ5CBdiGcW2/N5UAiupHxDpRjg2EX
   EZZgA48SD+FpN2HUlA7eT4YyzOinivUqwNwrSiUX8D2zDSdhDJpPbtO4j
   Hn2gt2n8WOTV9w5/AR8QG8NenET3Z/xzZAo5utD4uMn329mZ/0iQJuVYQ
   ef4yJZQefP3YQJ/03Yz7aphJEBh+c/idTrJOQxExkTVIWjblteWJnioA3
   obkP6IicAugRq2McUcevoIDKGcGrv1CkE1005rtaLuG+jLe1PlTsZkrYT
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="358407370"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="358407370"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 12:57:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="647351096"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 06 Sep 2022 12:57:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4D24657F; Tue,  6 Sep 2022 22:57:46 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v1 9/9] pwm: lpss: Allow other drivers to enable PWM LPSS
Date:   Tue,  6 Sep 2022 22:57:35 +0300
Message-Id: <20220906195735.87361-9-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220906195735.87361-1-andriy.shevchenko@linux.intel.com>
References: <20220906195735.87361-1-andriy.shevchenko@linux.intel.com>
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
 drivers/pwm/pwm-lpss.h                     | 26 ++---------------
 include/linux/platform_data/x86/pwm-lpss.h | 33 ++++++++++++++++++++++
 2 files changed, 35 insertions(+), 24 deletions(-)
 create mode 100644 include/linux/platform_data/x86/pwm-lpss.h

diff --git a/drivers/pwm/pwm-lpss.h b/drivers/pwm/pwm-lpss.h
index 35e570067fc6..41cb4b6246bb 100644
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
@@ -25,23 +23,6 @@ struct pwm_lpss_chip {
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
 /* BayTrail */
 static __maybe_unused const struct pwm_lpss_boardinfo pwm_lpss_byt_info = {
 	.clk_rate = 25000000,
@@ -72,7 +53,4 @@ static __maybe_unused const struct pwm_lpss_boardinfo pwm_lpss_tng_info = {
 	.base_unit_bits = 22,
 };
 
-struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, void __iomem *base,
-				     const struct pwm_lpss_boardinfo *info);
-
 #endif	/* __PWM_LPSS_H */
diff --git a/include/linux/platform_data/x86/pwm-lpss.h b/include/linux/platform_data/x86/pwm-lpss.h
new file mode 100644
index 000000000000..296bd837ddbb
--- /dev/null
+++ b/include/linux/platform_data/x86/pwm-lpss.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Intel Low Power Subsystem PWM controller driver */
+
+#ifndef __PLATFORM_DATA_X86_PWM_LPSS_H
+#define __PLATFORM_DATA_X86_PWM_LPSS_H
+
+#include <linux/types.h>
+
+struct device;
+
+struct pwm_lpss_chip;
+
+struct pwm_lpss_boardinfo {
+	unsigned long clk_rate;
+	unsigned int npwm;
+	unsigned long base_unit_bits;
+	/*
+	 * Some versions of the IP may stuck in the state machine if enable
+	 * bit is not set, and hence update bit will show busy status till
+	 * the reset. For the rest it may be otherwise.
+	 */
+	bool bypass;
+	/*
+	 * On some devices the _PS0/_PS3 AML code of the GPU (GFX0) device
+	 * messes with the PWM0 controllers state,
+	 */
+	bool other_devices_aml_touches_pwm_regs;
+};
+
+struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, void __iomem *base,
+				     const struct pwm_lpss_boardinfo *info);
+
+#endif	/* __PLATFORM_DATA_X86_PWM_LPSS_H */
-- 
2.35.1

