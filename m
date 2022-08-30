Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4568B5A65BD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 15:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiH3N41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 09:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbiH3Nzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 09:55:36 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD83A82D2A;
        Tue, 30 Aug 2022 06:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661867732; x=1693403732;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ST8BWIGNQi7JwPA+iqczOtk6uPlOmHH+w14IA95KirY=;
  b=ZULwpNtYWEhNQ/9C45p8rMfAMgh/X5sywUgerfG51vtizv/rYnDaB1hV
   1yLHzK5KyHzFtvdbzXvPEtyDMt8N484U+DTUKjyl0mZmriNCbbEyC4nxS
   GwlvCwpun+1ozxl3Xx+/cPFIOlTT4ApOxetoy0H9QOsCLy3wIgf0Hozs9
   XJ819HP5dWw/ZWyDnmkzqcP5TN1J2CXFpxwoWlsVBoHslAejD2NunpvXR
   AndB5/rXXnvX9U1A71+kpasOxpS+ToYru8Ahhz6bL0vo9FSMiUlw3Q9Hq
   hOzLcBLDGCRYdKu/0z0+u+9AIrHOWq3ebapxyqsf8J5W6kGjLIYLo1pqk
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="296455638"
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="296455638"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 06:55:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="857108291"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 30 Aug 2022 06:55:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4283AAD; Tue, 30 Aug 2022 16:55:35 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v1 2/2] ACPI: PMIC: Replace open coded be16_to_cpu()
Date:   Tue, 30 Aug 2022 16:55:32 +0300
Message-Id: <20220830135532.28992-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220830135532.28992-1-andriy.shevchenko@linux.intel.com>
References: <20220830135532.28992-1-andriy.shevchenko@linux.intel.com>
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

It's easier to understand the nature of a data type when
it's written explicitly. With that, replace open coded
endianess conversion.

As a side effect it fixes the returned value of
intel_crc_pmic_update_aux() since ACPI PMIC core code
expects negative or zero and never uses positive one.

While at it, use macros from bits.h to reduce a room for mistake.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/pmic/intel_pmic_bytcrc.c   | 24 ++++++++++++++++++------
 drivers/acpi/pmic/intel_pmic_chtdc_ti.c | 13 +++++++++----
 2 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/pmic/intel_pmic_bytcrc.c b/drivers/acpi/pmic/intel_pmic_bytcrc.c
index 9ea79f210965..af385cec69f1 100644
--- a/drivers/acpi/pmic/intel_pmic_bytcrc.c
+++ b/drivers/acpi/pmic/intel_pmic_bytcrc.c
@@ -6,14 +6,20 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/bits.h>
 #include <linux/init.h>
 #include <linux/mfd/intel_soc_pmic.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+
+#include <asm/byteorder.h>
+
 #include "intel_pmic.h"
 
 #define PWR_SOURCE_SELECT	BIT(1)
 
+#define PMIC_REG_MASK		GENMASK(9. 0)
+
 #define PMIC_A0LOCK_REG		0xc5
 
 static struct pmic_table power_table[] = {
@@ -219,23 +225,29 @@ static int intel_crc_pmic_update_power(struct regmap *regmap, int reg,
 
 static int intel_crc_pmic_get_raw_temp(struct regmap *regmap, int reg)
 {
-	int temp_l, temp_h;
+	__be16 buf;
 
 	/*
 	 * Raw temperature value is 10bits: 8bits in reg
 	 * and 2bits in reg-1: bit0,1
 	 */
-	if (regmap_read(regmap, reg, &temp_l) ||
-	    regmap_read(regmap, reg - 1, &temp_h))
+	if (regmap_bulk_read(regmap, reg - 1, buf, sizeof(buf)))
 		return -EIO;
 
-	return temp_l | (temp_h & 0x3) << 8;
+	return be16_to_cpu(buf) & PMIC_REG_MASK;
 }
 
 static int intel_crc_pmic_update_aux(struct regmap *regmap, int reg, int raw)
 {
-	return regmap_write(regmap, reg, raw) ||
-		regmap_update_bits(regmap, reg - 1, 0x3, raw >> 8) ? -EIO : 0;
+	u16 mask = PMIC_REG_MASK;
+	__be16 buf;
+
+	if (regmap_bulk_read(regmap, reg - 1, buf, sizeof(buf)))
+		return -EIO;
+	buf = cpu_to_be16((be16_to_cpu(buf) & ~mask) | (raw & mask));
+	if (regmap_bulk_write(regmap, reg - 1, buf, sizeof(buf)))
+		return -EIO;
+	return 0;
 }
 
 static int intel_crc_pmic_get_policy(struct regmap *regmap,
diff --git a/drivers/acpi/pmic/intel_pmic_chtdc_ti.c b/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
index 6c2a6da430ed..376bc80eb50a 100644
--- a/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
+++ b/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
@@ -8,12 +8,18 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/bits.h>
 #include <linux/init.h>
 #include <linux/mfd/intel_soc_pmic.h>
 #include <linux/platform_device.h>
+
+#include <asm/byteorder.h>
+
 #include "intel_pmic.h"
 
 /* registers stored in 16bit BE (high:low, total 10bit) */
+#define PMIC_REG_MASK		GENMASK(9. 0)
+
 #define CHTDC_TI_VBAT		0x54
 #define CHTDC_TI_DIETEMP	0x56
 #define CHTDC_TI_BPTHERM	0x58
@@ -73,7 +79,7 @@ static int chtdc_ti_pmic_get_power(struct regmap *regmap, int reg, int bit,
 	if (regmap_read(regmap, reg, &data))
 		return -EIO;
 
-	*value = data & 1;
+	*value = data & BIT(0);
 	return 0;
 }
 
@@ -85,13 +91,12 @@ static int chtdc_ti_pmic_update_power(struct regmap *regmap, int reg, int bit,
 
 static int chtdc_ti_pmic_get_raw_temp(struct regmap *regmap, int reg)
 {
-	u8 buf[2];
+	__be16 buf;
 
 	if (regmap_bulk_read(regmap, reg, buf, sizeof(buf)))
 		return -EIO;
 
-	/* stored in big-endian */
-	return ((buf[0] & 0x03) << 8) | buf[1];
+	return be16_to_cpu(buf) & PMIC_REG_MASK;
 }
 
 static const struct intel_pmic_opregion_data chtdc_ti_pmic_opregion_data = {
-- 
2.35.1

