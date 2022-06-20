Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5334B551632
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 12:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240670AbiFTKpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 06:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240795AbiFTKnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 06:43:20 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843EC140C7;
        Mon, 20 Jun 2022 03:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655721799; x=1687257799;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=M3bqDonEX7K4lrycc+KmJwuLlRjfv8zoVcZKA2ZbWo0=;
  b=TCICPZC1pGKCCxxMdOmp+IogJZT2+ZAerxfgMrj5+wlPd2SzCpxNjsrd
   nRirdqB05PKHiaoY3nCWbL/btQRzWI8bq4pS2d6hA3zXN5iUYxo9gL+O+
   C2wxzTlE0IX7ij6svk0MrVAbW2ITyiEEJKj/c5xwJXQ7Tu/jaCuGX8RY4
   jMhfXCacll38vFc+LgVHYScLWiLCwmU99mCJyeapCdU6QMmoGqfnKdsof
   suGtQVAPDLrd+yer/RC4lnKSnWn1kn0fY6UkVnsm113TUQiSNxBfhBBO0
   sSCIKGdJS+7gnefPdF9v+y2MZSSPCLxp/9bk1eApuwQ+x8u/YAG7GSgwc
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="366187189"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="366187189"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 03:43:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="729321649"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 20 Jun 2022 03:43:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4E90314F; Mon, 20 Jun 2022 13:43:19 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v1 1/1] usb: typec: wcove: Drop wrong dependency to INTEL_SOC_PMIC
Date:   Mon, 20 Jun 2022 13:43:16 +0300
Message-Id: <20220620104316.57592-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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

Intel SoC PMIC is a generic name for all PMICs that are used
on Intel platforms. In particular, INTEL_SOC_PMIC kernel configuration
option refers to Crystal Cove PMIC, which has never been a part
of any Intel Broxton hardware. Drop wrong dependency from Kconfig.

Note, the correct dependency is satisfied via ACPI PMIC OpRegion driver,
which the Type-C depends on.

Fixes: d2061f9cc32d ("usb: typec: add driver for Intel Whiskey Cove PMIC USB Type-C PHY")
Reported-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/typec/tcpm/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/Kconfig b/drivers/usb/typec/tcpm/Kconfig
index 557f392fe24d..073fd2ea5e0b 100644
--- a/drivers/usb/typec/tcpm/Kconfig
+++ b/drivers/usb/typec/tcpm/Kconfig
@@ -56,7 +56,6 @@ config TYPEC_WCOVE
 	tristate "Intel WhiskeyCove PMIC USB Type-C PHY driver"
 	depends on ACPI
 	depends on MFD_INTEL_PMC_BXT
-	depends on INTEL_SOC_PMIC
 	depends on BXT_WC_PMIC_OPREGION
 	help
 	  This driver adds support for USB Type-C on Intel Broxton platforms
-- 
2.35.1

