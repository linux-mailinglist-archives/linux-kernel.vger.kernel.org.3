Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358275B1FCC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 15:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbiIHN5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbiIHN4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:56:51 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C844FCA07;
        Thu,  8 Sep 2022 06:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662645410; x=1694181410;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jDxTwbb4QkYB4ydKPfaT1i2EoPig8GG6D0laswJmke0=;
  b=gVQLx4bi9rQH8su6Dotbuxsk/jtbTNmPMHhg6VxUjJIHojpgwg5ZMT6e
   iAzTBnLBTVEfh2KrLgH76RBZe/0nI1aEgeMarF/06HFTunBbOB+dVOMy6
   mKyFDEHXeHsc5nxnVVwEX/OWXgXjfpfHn3rl7X53B9/17xG7G0T2AB1xE
   69b4mTDUKZSTMYe2nBVWBkSOnON5iOX9hHUvRp1RbPAuTdVaoP0L7R5qQ
   BW62sGSCNKqYZT8QlRslxXgd+31bEUNYBAJkuDYFqnY8taR03jwdnwA2P
   yzac7jMDLSDQK82cauwizqAXe00f25w8ZB0MfTbQ7lJy5qiXlr60fjqQw
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="277560799"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="277560799"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 06:56:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="592173752"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 08 Sep 2022 06:56:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 65C69238; Thu,  8 Sep 2022 16:57:02 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v2 2/9] pwm: lpss: Move exported symbols to PWM_LPSS namespace
Date:   Thu,  8 Sep 2022 16:56:51 +0300
Message-Id: <20220908135658.64463-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220908135658.64463-1-andriy.shevchenko@linux.intel.com>
References: <20220908135658.64463-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Avoid unnecessary pollution of the global symbol namespace by
moving library functions in to a specific namespace and import
that into the drivers that make use of the functions.

For more info: https://lwn.net/Articles/760045/

Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pwm/pwm-lpss-pci.c      | 1 +
 drivers/pwm/pwm-lpss-platform.c | 1 +
 drivers/pwm/pwm-lpss.c          | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/drivers/pwm/pwm-lpss-pci.c b/drivers/pwm/pwm-lpss-pci.c
index 75b778e839b3..9f2c666b95ec 100644
--- a/drivers/pwm/pwm-lpss-pci.c
+++ b/drivers/pwm/pwm-lpss-pci.c
@@ -92,3 +92,4 @@ module_pci_driver(pwm_lpss_driver_pci);
 
 MODULE_DESCRIPTION("PWM PCI driver for Intel LPSS");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(PWM_LPSS);
diff --git a/drivers/pwm/pwm-lpss-platform.c b/drivers/pwm/pwm-lpss-platform.c
index 834423c34f48..65154c0abab1 100644
--- a/drivers/pwm/pwm-lpss-platform.c
+++ b/drivers/pwm/pwm-lpss-platform.c
@@ -88,4 +88,5 @@ module_platform_driver(pwm_lpss_driver_platform);
 
 MODULE_DESCRIPTION("PWM platform driver for Intel LPSS");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(PWM_LPSS);
 MODULE_ALIAS("platform:pwm-lpss");
diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index 9537aefd254a..74a296cb1af0 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -18,6 +18,8 @@
 #include <linux/pm_runtime.h>
 #include <linux/time.h>
 
+#define DEFAULT_SYMBOL_NAMESPACE PWM_LPSS
+
 #include "pwm-lpss.h"
 
 #define PWM				0x00000000
-- 
2.35.1

