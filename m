Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83D85AF53C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 22:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbiIFUC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 16:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbiIFUCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 16:02:06 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30112BA176;
        Tue,  6 Sep 2022 12:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662494258; x=1694030258;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U3KLmkQYC25dsT/dzKWxv9yfMWhzJxNZMsvxnNcpr0s=;
  b=dPklQ31WIbMBqIyyJ8YhCZoEgTfL1L7VOHUz9jw4uvVrj746QdZq0VZG
   tCiUzaj1em6NcbJyJe4r1+8sMvZScL6oevCsmIeMEPMPI6S/cuRKV7e+Z
   yqY7Os6xTSrzw11iMAuupcJ0m/w0x7pkYnobuy90K7LQv8rSEjpGd0l1R
   OtcqBEsfr77xCdc5HPdKzE01Uy9Mfmpw/JTjVAXwCVEcXh2KLh+nJrUBt
   o6tl4Sb8dMgTBsC8skt5LxAP7QVv73ZBk+qMXid097vCmGqNpVWj0IINL
   IXQfC6LxAF0QwR0pFQkf/Bx7uVMJKFNQ5um0Ge0A7aYsBd/BEtUXFjqzj
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="277085500"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="277085500"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 12:57:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="789796848"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 06 Sep 2022 12:57:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EF94A7C; Tue,  6 Sep 2022 22:57:45 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v1 2/9] pwm: lpss: Move exported symbols to PWM_LPSS namespace
Date:   Tue,  6 Sep 2022 22:57:28 +0300
Message-Id: <20220906195735.87361-2-andriy.shevchenko@linux.intel.com>
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

Avoid unnecessary pollution of the global symbol namespace by
moving library functions in to a specific namespace and import
that into the drivers that make use of the functions.

For more info: https://lwn.net/Articles/760045/

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pwm/pwm-lpss-pci.c      | 1 +
 drivers/pwm/pwm-lpss-platform.c | 1 +
 drivers/pwm/pwm-lpss.c          | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-lpss-pci.c b/drivers/pwm/pwm-lpss-pci.c
index 75b778e839b3..9f2c666b95ec 100644
--- a/drivers/pwm/pwm-lpss-pci.c
+++ b/drivers/pwm/pwm-lpss-pci.c
@@ -92,3 +92,4 @@ module_pci_driver(pwm_lpss_driver_pci);
 
 MODULE_DESCRIPTION("PWM PCI driver for Intel LPSS");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(PWM_LPSS);
diff --git a/drivers/pwm/pwm-lpss-platform.c b/drivers/pwm/pwm-lpss-platform.c
index fcd80cca2f6d..96fde1b2b967 100644
--- a/drivers/pwm/pwm-lpss-platform.c
+++ b/drivers/pwm/pwm-lpss-platform.c
@@ -87,4 +87,5 @@ module_platform_driver(pwm_lpss_driver_platform);
 
 MODULE_DESCRIPTION("PWM platform driver for Intel LPSS");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(PWM_LPSS);
 MODULE_ALIAS("platform:pwm-lpss");
diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index 36d4e83e6b79..a82a57eb2482 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -250,7 +250,7 @@ struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, struct resource *r,
 
 	return lpwm;
 }
-EXPORT_SYMBOL_GPL(pwm_lpss_probe);
+EXPORT_SYMBOL_NS_GPL(pwm_lpss_probe, PWM_LPSS);
 
 MODULE_DESCRIPTION("PWM driver for Intel LPSS");
 MODULE_AUTHOR("Mika Westerberg <mika.westerberg@linux.intel.com>");
-- 
2.35.1

