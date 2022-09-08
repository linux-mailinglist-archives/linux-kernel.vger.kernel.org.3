Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278D25B1FD9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbiIHN5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbiIHN5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:57:01 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69666F8242;
        Thu,  8 Sep 2022 06:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662645419; x=1694181419;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uBscJFQbw18Si2rbAy+SrsNOerjt4LJIPX+P611o7xg=;
  b=jhzUtDKD0CiiOaqI5BTuQVaY/jVq4sROeEzGyQuMEoULBtqc8s2a7KCQ
   UT70E/08ewC4X6oS4Y1CipaUcLutUmLkEoOjXfr98SzPcUVBBRYrbanHu
   3Tk3zn4XKAhEIvvklHJo7FI9VNphx9vFxFuux0IT4L7P+7//C0vskZtCF
   9AVl6+Aj0/pjos77nghNDz7WBeTvR1CYjSR41KulM2lBMOH2e4RJomnMY
   8SLno6MH6acZI4p4EP6goEJZ/gK52f4z5J87M0/MH873LOsRyqULdpcFG
   gr8XDl6E4vXxIQhTzORfwNLu3rnuUSAsI21KbtojLZ91LYA8WvbnAQAIT
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="297174067"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="297174067"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 06:56:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="704012689"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Sep 2022 06:56:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 90AE350D; Thu,  8 Sep 2022 16:57:02 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v2 5/9] pwm: lpss: Use device_get_match_data to get device data
Date:   Thu,  8 Sep 2022 16:56:54 +0300
Message-Id: <20220908135658.64463-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220908135658.64463-1-andriy.shevchenko@linux.intel.com>
References: <20220908135658.64463-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

device_get_match_data() in ACPI case calls similar to the
acpi_match_device(). We may simplify the code and make it
generic by replacing the latter with the former.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pwm/pwm-lpss-platform.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-lpss-platform.c b/drivers/pwm/pwm-lpss-platform.c
index 7bbbb7a9b578..c48c6f2b2cd8 100644
--- a/drivers/pwm/pwm-lpss-platform.c
+++ b/drivers/pwm/pwm-lpss-platform.c
@@ -7,11 +7,12 @@
  * Derived from the original pwm-lpss.c
  */
 
-#include <linux/acpi.h>
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/property.h>
 
 #include "pwm-lpss.h"
 
@@ -19,16 +20,13 @@
 static int pwm_lpss_probe_platform(struct platform_device *pdev)
 {
 	const struct pwm_lpss_boardinfo *info;
-	const struct acpi_device_id *id;
 	struct pwm_lpss_chip *lpwm;
 	void __iomem *base;
 
-	id = acpi_match_device(pdev->dev.driver->acpi_match_table, &pdev->dev);
-	if (!id)
+	info = device_get_match_data(&pdev->dev);
+	if (!info)
 		return -ENODEV;
 
-	info = (const struct pwm_lpss_boardinfo *)id->driver_data;
-
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
-- 
2.35.1

