Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2662F4CFD7D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 12:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbiCGL5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 06:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbiCGL5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 06:57:05 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F77B723DB;
        Mon,  7 Mar 2022 03:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646654171; x=1678190171;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pY74O68alyPR/DL0u5gLmeg1Gm3jSm4v6/u8mQneFzw=;
  b=hr7Ce6soaDhpcdDo+GCTPPdFcXSIg8pPJHDQrmHVP371Mj2bzxJ4inGt
   08z+3Ev5iaxpvOAO1SK+B9OWz+i6PkZ8HwEJ899K9sbt40YXPykk+16Oo
   TnJxd+6qP4C4zGa+iC4KuwgZMbMZCbCVijZ+aNhURqWSexryjeQ3FikDA
   O/M9TZjXBmvNuZkDItb0t2ASjMgQcy0x1/nDGskYVTFRRJFTrkETEnEuP
   fEMCKFHAjZgAqISsYqPgDB+9VFf1szqji49ius+QRMpfi9+2gWJa9AISR
   PpBXUwj7hBeFd4Sgwcpz/EOUlUljxQyXbAHA9T4zsHuIy4cwkXVhCQko3
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10278"; a="279075486"
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="279075486"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 03:56:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="537085980"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 07 Mar 2022 03:56:08 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C365410E; Mon,  7 Mar 2022 13:56:26 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v1 1/1] gpiolib: acpi: Convert ACPI value of debounce to microseconds
Date:   Mon,  7 Mar 2022 13:56:23 +0200
Message-Id: <20220307115623.37492-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It appears that GPIO ACPI library uses ACPI debounce values directly.
However, the GPIO library APIs expect the debounce timeout to be in
microseconds.

Convert ACPI value of debounce to microseconds.

While at it, document this detail where it is appropriate.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=215664
Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Fixes: 8dcb7a15a585 ("gpiolib: acpi: Take into account debounce settings")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c |  6 ++++--
 drivers/gpio/gpiolib.c      | 10 ++++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index c0f6a25c3279..a5495ad31c9c 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -307,7 +307,8 @@ static struct gpio_desc *acpi_request_own_gpiod(struct gpio_chip *chip,
 	if (IS_ERR(desc))
 		return desc;
 
-	ret = gpio_set_debounce_timeout(desc, agpio->debounce_timeout);
+	/* ACPI uses hundredths of milliseconds units */
+	ret = gpio_set_debounce_timeout(desc, agpio->debounce_timeout * 10);
 	if (ret)
 		dev_warn(chip->parent,
 			 "Failed to set debounce-timeout for pin 0x%04X, err %d\n",
@@ -1035,7 +1036,8 @@ int acpi_dev_gpio_irq_get_by(struct acpi_device *adev, const char *name, int ind
 			if (ret < 0)
 				return ret;
 
-			ret = gpio_set_debounce_timeout(desc, info.debounce);
+			/* ACPI uses hundredths of milliseconds units */
+			ret = gpio_set_debounce_timeout(desc, info.debounce * 10);
 			if (ret)
 				return ret;
 
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index f5e7443208d4..f956c533f218 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2223,6 +2223,16 @@ static int gpio_set_bias(struct gpio_desc *desc)
 	return gpio_set_config_with_argument_optional(desc, bias, arg);
 }
 
+/**
+ * gpio_set_debounce_timeout() - Set debounce timeout
+ * @desc:	GPIO descriptor to set the debounce timeout
+ * @debounce:	Debounce timeout in microseconds
+ *
+ * The function calls the certain GPIO driver to set debounce timeout
+ * in the hardware.
+ *
+ * Returns 0 on success, or negative error code otherwise.
+ */
 int gpio_set_debounce_timeout(struct gpio_desc *desc, unsigned int debounce)
 {
 	return gpio_set_config_with_argument_optional(desc,
-- 
2.34.1

