Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4295B578D3F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 00:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236432AbiGRWCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 18:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234877AbiGRWCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 18:02:49 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CAE30F41;
        Mon, 18 Jul 2022 15:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658181768; x=1689717768;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4f4sqt41mbrBJQ5YZ8lAHwW92PK8OUBMApM+zNy2HDY=;
  b=hM9Z/qy6RaT5oicalFdsPZGqVQhvImEtYBBFzdc8KyjoqQnU97+H9NPW
   aKEDHahNrNc4es5hylJQnt/YKFECmQjgkq9KO6O3bDEsJan/QHsU+yHPO
   W+NguDic4qsk3d8c4V80gXaJ9U85TpxlzZ42sIQYVOTEQHzP5Wsw1U2eQ
   xQjaG4G3VKw2QywvIrSi8INW9l2HvnyG+sBwUFrDs8ShNfovndZzK9Pgw
   u6bQQfmxTBE5KRUnObJihXaztia9GlixP02IUZiV1nrRX+1AFb9p85EMF
   wBIAEtzivdnTKC4OSKHDBniXWIHJ+Q6t/BqVwzaxwDhfpKLAenmQOu8Gu
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="273161745"
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="273161745"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 15:02:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="601361127"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 18 Jul 2022 15:02:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 28FC0195; Tue, 19 Jul 2022 01:02:55 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 3/3] gpio: 74xx-mmio: use bits.h macros for all masks
Date:   Tue, 19 Jul 2022 01:02:52 +0300
Message-Id: <20220718220252.16923-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220718220252.16923-1-andriy.shevchenko@linux.intel.com>
References: <20220718220252.16923-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the GENMASK() (far less error-prone, far more concise).

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-74xx-mmio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-74xx-mmio.c b/drivers/gpio/gpio-74xx-mmio.c
index b2cc8a55c257..cd399898ed12 100644
--- a/drivers/gpio/gpio-74xx-mmio.c
+++ b/drivers/gpio/gpio-74xx-mmio.c
@@ -5,6 +5,7 @@
  *  Copyright (C) 2014 Alexander Shiyan <shc_work@mail.ru>
  */
 
+#include <linux/bits.h>
 #include <linux/err.h>
 #include <linux/gpio/driver.h>
 #include <linux/mod_devicetable.h>
@@ -14,7 +15,7 @@
 
 #define MMIO_74XX_DIR_IN	(0 << 8)
 #define MMIO_74XX_DIR_OUT	(1 << 8)
-#define MMIO_74XX_BIT_CNT(x)	((x) & 0xff)
+#define MMIO_74XX_BIT_CNT(x)	((x) & GENMASK(7, 0))
 
 struct mmio_74xx_gpio_priv {
 	struct gpio_chip	gc;
-- 
2.35.1

