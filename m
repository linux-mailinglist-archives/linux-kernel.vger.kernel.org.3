Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7915AF544
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 22:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbiIFUEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 16:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiIFUDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 16:03:31 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86887357F9;
        Tue,  6 Sep 2022 12:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662494340; x=1694030340;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DLAYl/tomufvU0qedUSOwgtL2ARaViWqYo/L/dYYvM4=;
  b=FVcIFZvQ2kKKzPHHFr+PF/BmFz0NnQ+cCKdTOnd/prwrPm6y3oRp3bqX
   oSdlFxAiQCoxQonPsz3mXBDXzjjQ8hf0fwQlxnId3IkUGrM3R4IBXGHKR
   Y+Ei8QFKr7OCkaILsiZdbsBoiv6sJaJikwDm80st1OO/OwwNgDTIr657S
   r/HBr0OjfY2c4JwxK8rmjWEhF6Yz/60kHHXAiBWewef5keqNTqabjkN9u
   Yx/dEgqtul6NI+/fsSBon8ZJJ/vDHWYV+1v2cpDbHq9pIx1KnAAHn2/jY
   NUuMlUMSDeXexEnKQRZGXNyldvibjhQsNzSVLfBDA0VXB6HZxkLVcBX0m
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="279705025"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="279705025"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 12:57:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="610070470"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 06 Sep 2022 12:57:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E167A86; Tue,  6 Sep 2022 22:57:45 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v1 1/9] pwm: lpss: Deduplicate board info data structures
Date:   Tue,  6 Sep 2022 22:57:27 +0300
Message-Id: <20220906195735.87361-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With help of __maybe_unused, that allows to avoid compilation warnings,
move the board info structures from the C files to the common header
and hence deduplicate configuration data.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pwm/pwm-lpss-pci.c      | 29 -----------------------------
 drivers/pwm/pwm-lpss-platform.c | 23 -----------------------
 drivers/pwm/pwm-lpss.h          | 30 ++++++++++++++++++++++++++++++
 3 files changed, 30 insertions(+), 52 deletions(-)

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
index 928570430cef..fcd80cca2f6d 100644
--- a/drivers/pwm/pwm-lpss-platform.c
+++ b/drivers/pwm/pwm-lpss-platform.c
@@ -15,29 +15,6 @@
 
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
-
 static int pwm_lpss_probe_platform(struct platform_device *pdev)
 {
 	const struct pwm_lpss_boardinfo *info;
diff --git a/drivers/pwm/pwm-lpss.h b/drivers/pwm/pwm-lpss.h
index 8b3476f25e06..3864f32c2487 100644
--- a/drivers/pwm/pwm-lpss.h
+++ b/drivers/pwm/pwm-lpss.h
@@ -33,6 +33,36 @@ struct pwm_lpss_boardinfo {
 	bool other_devices_aml_touches_pwm_regs;
 };
 
+/* BayTrail */
+static __maybe_unused const struct pwm_lpss_boardinfo pwm_lpss_byt_info = {
+	.clk_rate = 25000000,
+	.npwm = 1,
+	.base_unit_bits = 16,
+};
+
+/* Braswell */
+static __maybe_unused const struct pwm_lpss_boardinfo pwm_lpss_bsw_info = {
+	.clk_rate = 19200000,
+	.npwm = 1,
+	.base_unit_bits = 16,
+	.other_devices_aml_touches_pwm_regs = true,
+};
+
+/* Broxton */
+static __maybe_unused const struct pwm_lpss_boardinfo pwm_lpss_bxt_info = {
+	.clk_rate = 19200000,
+	.npwm = 4,
+	.base_unit_bits = 22,
+	.bypass = true,
+};
+
+/* Tangier */
+static __maybe_unused const struct pwm_lpss_boardinfo pwm_lpss_tng_info = {
+	.clk_rate = 19200000,
+	.npwm = 4,
+	.base_unit_bits = 22,
+};
+
 struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, struct resource *r,
 				     const struct pwm_lpss_boardinfo *info);
 
-- 
2.35.1

