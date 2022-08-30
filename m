Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61EEE5A694C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 19:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiH3RLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 13:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiH3RLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 13:11:45 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13326B942D;
        Tue, 30 Aug 2022 10:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661879505; x=1693415505;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TsbH8WfVIPK7o9v1IjER2iQuy7ebiON15BiW0wAGgc0=;
  b=LwlC0c0kzRovhdU7CgL7rRkdvI8RhhD/6Ig8h+Z5BOwjpoE+iMa9n6NE
   0u3kuZdxPISeruq1e46fbjbGwUJsn7fFbpvbdiS76ByRQ6mf8D3bCw1sI
   mawJuL4gbyxlaleqakfaxA9DE4zRGQxIchqUS+154rnjSoaCbFr2bqtA8
   z6dfJJ3kHrrZE/c/GK7uG4RMSMPo7XlzGkNUTqdbJvPZX4wo9bzbvr/Ab
   L/kYX5/+JhpnPgZWBgaq//9wi2OcFATTARfx/TXJeJGS5w7NLIn267/88
   9TOIykWOXm4eayMkqxcNzGWVYBn89SkdqtewesQL/y/I+EIQcu7UhUpqv
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="296031024"
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="296031024"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 10:11:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="562734132"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 30 Aug 2022 10:11:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8338AAD; Tue, 30 Aug 2022 20:11:56 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v2 1/3] ACPI: PMIC: Use sizeof() instead of hard coded value
Date:   Tue, 30 Aug 2022 20:11:53 +0300
Message-Id: <20220830171155.42962-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's better to use sizeof() of a given buffer than spreading
a hard coded value.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: updated another driver as well (due to this no tag added)
 drivers/acpi/pmic/intel_pmic_chtdc_ti.c | 2 +-
 drivers/acpi/pmic/intel_pmic_xpower.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/pmic/intel_pmic_chtdc_ti.c b/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
index 418eec523025..6c2a6da430ed 100644
--- a/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
+++ b/drivers/acpi/pmic/intel_pmic_chtdc_ti.c
@@ -87,7 +87,7 @@ static int chtdc_ti_pmic_get_raw_temp(struct regmap *regmap, int reg)
 {
 	u8 buf[2];
 
-	if (regmap_bulk_read(regmap, reg, buf, 2))
+	if (regmap_bulk_read(regmap, reg, buf, sizeof(buf)))
 		return -EIO;
 
 	/* stored in big-endian */
diff --git a/drivers/acpi/pmic/intel_pmic_xpower.c b/drivers/acpi/pmic/intel_pmic_xpower.c
index 61bbe4c24d87..33c5e85294cd 100644
--- a/drivers/acpi/pmic/intel_pmic_xpower.c
+++ b/drivers/acpi/pmic/intel_pmic_xpower.c
@@ -255,7 +255,7 @@ static int intel_xpower_pmic_get_raw_temp(struct regmap *regmap, int reg)
 	if (ret)
 		return ret;
 
-	ret = regmap_bulk_read(regmap, AXP288_GP_ADC_H, buf, 2);
+	ret = regmap_bulk_read(regmap, AXP288_GP_ADC_H, buf, sizeof(buf));
 	if (ret == 0)
 		ret = (buf[0] << 4) + ((buf[1] >> 4) & 0x0f);
 
-- 
2.35.1

