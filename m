Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1565463F3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 12:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344288AbiFJKhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 06:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348034AbiFJKgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 06:36:25 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B8749F19;
        Fri, 10 Jun 2022 03:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654857206; x=1686393206;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GPbto6kWLD4KwhM5VBSRgAyWo2PjSu6DlokZQj9/3i4=;
  b=m54mMxqC87gYi6IGgLS6bY8FwWE1HJOqkbvg6e7Y/+LXleQT5M/fmqDR
   eoNtoXi1rXYq4EWTbkhEAQMDF963kVHpmBCkIDBhNWxNDF4XyBI5xTpBn
   CGVRlophvuyLw9ejpxZKt/lyZ8AchCIWtjaqFocFqtrHRN/QlZuW3iZKF
   ANK4I0uha1JA1+ke3dUMLfQGnTg56naa2FTmqawppXfMq1cB9X2rwmD0r
   X1vV0znJcAtWEn5A4I8BYaieJUo/XADaVvKrr7MzmIoemgWBXydjxz+HN
   B/JaLquye2UYO+Gk0ahFiJQMwDNahTskADPAnI6bGrTsT5/2WJR+AqxIa
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="339342507"
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="339342507"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 03:33:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="710884395"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 10 Jun 2022 03:33:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0DAC0F8; Fri, 10 Jun 2022 13:33:25 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Zev Weiss <zev@bewilderbeest.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Subject: [PATCH v1 1/1] hwmon: (nct6775) Drop duplicate NULL check in ->init() and ->exit()
Date:   Fri, 10 Jun 2022 13:33:24 +0300
Message-Id: <20220610103324.87483-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since platform_device_unregister() is NULL-aware, we don't need to duplicate
this check. Remove it and fold the rest of the code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hwmon/nct6775-platform.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/nct6775-platform.c b/drivers/hwmon/nct6775-platform.c
index 6d46c9401898..3a48627419ba 100644
--- a/drivers/hwmon/nct6775-platform.c
+++ b/drivers/hwmon/nct6775-platform.c
@@ -1200,10 +1200,8 @@ static int __init sensors_nct6775_platform_init(void)
 exit_device_put:
 	platform_device_put(pdev[i]);
 exit_device_unregister:
-	while (--i >= 0) {
-		if (pdev[i])
-			platform_device_unregister(pdev[i]);
-	}
+	while (i--)
+		platform_device_unregister(pdev[i]);
 exit_unregister:
 	platform_driver_unregister(&nct6775_driver);
 	return err;
@@ -1213,10 +1211,8 @@ static void __exit sensors_nct6775_platform_exit(void)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(pdev); i++) {
-		if (pdev[i])
-			platform_device_unregister(pdev[i]);
-	}
+	for (i = 0; i < ARRAY_SIZE(pdev); i++)
+		platform_device_unregister(pdev[i]);
 	platform_driver_unregister(&nct6775_driver);
 }
 
-- 
2.35.1

