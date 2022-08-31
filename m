Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB815A7F65
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 15:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbiHaN5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 09:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiHaN5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 09:57:40 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB90D5EAD;
        Wed, 31 Aug 2022 06:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661954259; x=1693490259;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dtL+8Cys9Oexa2+abpB8VdNGZHy6gFiiShpIowTcEGw=;
  b=V0V0LK8SS/I5/3znce7CCRCSZKnVpae2CWsNsoUOlpA1sRaXNY8FMwwf
   SCey28JGP+b6kq7YfIRAfnBgwHDDLoaFZMWb+gDUfiHo2R6XaM2zXbQKv
   +RnsA2cH4G7X9ifNLAzUqjbZBgBQ+qzp5zjBFhLTAjk8VTsZVUQ2y9oMp
   6BV8PAVtRQMRBEWDsUtuL3u/+zzSYjTVSyo5w6CnBBe+OxXEHKMjqB5cK
   H1TDzt092ay+PiM0VbWil0hgdSrxOU2+XIzFvHROfP9slxF4Okj/QjQ7q
   G+DMalPG4HN3/FnquOqvslW1GC3s+1hfBQ2VgepyBjtXamqGRshA9MxSL
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="381748176"
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="381748176"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 06:57:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="940441946"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 31 Aug 2022 06:57:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DEFB1174; Wed, 31 Aug 2022 16:57:50 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Andy Shevchenko <andy@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 1/3] ACPI: PMIC: Use sizeof() instead of hard coded value
Date:   Wed, 31 Aug 2022 16:57:47 +0300
Message-Id: <20220831135749.78743-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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

It's better to use sizeof() of a given buffer than spreading
a hard coded value.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
v3: added tag (Mika)
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

