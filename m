Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840A4580FA5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 11:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbiGZJOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 05:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiGZJOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 05:14:45 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FBA2AC64;
        Tue, 26 Jul 2022 02:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658826885; x=1690362885;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xo3CxoOmbyKB7y0WNfc6A5+sScixZQkydSNNvq47huM=;
  b=QQ0GI3ecxvWO2uSDPYQ/pJwU/q6IGiiDIjuJWQGbEegAzBAnBV0hLHgt
   laAlBokAXw76W7OpA7Sd4nuqrVuUwWEit6yAWdh1SQ6t39ZBE42DnDxrV
   sqg8PbqZUVqqokDkbWndnoWR86b+G9mQ2Gj3ntveLlDe9BYnM1sB2WHSz
   j+e94qxm9UETJYzMQJ104NIZ9kksds0jMutzlr9b4oGJjXnTZsW+5aEJn
   rk5q1Q98ZxQrRP4p8kHbnnsj9VuQO6Zh6tleuZTPM1HwUjVWFrAzhqYp5
   8gB1NZkgLd1GfNXLnkMvnw3RsVfb+LX544gYyprfi9ePO2uVQ2k0IEd7i
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="351897656"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="351897656"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 02:14:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="689372517"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Jul 2022 02:14:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9535B3ED; Tue, 26 Jul 2022 12:14:52 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v1 1/1] gpio: 74xx-mmio: Use bits instead of plain numbers for flags
Date:   Tue, 26 Jul 2022 12:14:48 +0300
Message-Id: <20220726091448.81746-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The initial code was misleading to use bitwise AND against plain number,
and the commit d3054ba1db62 ("gpio: 74xx-mmio: Check MMIO_74XX_DIR_IN flag
in mmio_74xx_dir_in()") missed that. Switch definitions to be defined bits
for the correct comparison.

Fixes: d3054ba1db62 ("gpio: 74xx-mmio: Check MMIO_74XX_DIR_IN flag in mmio_74xx_dir_in()")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-74xx-mmio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-74xx-mmio.c b/drivers/gpio/gpio-74xx-mmio.c
index cd399898ed12..0464f1ecd20d 100644
--- a/drivers/gpio/gpio-74xx-mmio.c
+++ b/drivers/gpio/gpio-74xx-mmio.c
@@ -13,8 +13,8 @@
 #include <linux/platform_device.h>
 #include <linux/property.h>
 
-#define MMIO_74XX_DIR_IN	(0 << 8)
-#define MMIO_74XX_DIR_OUT	(1 << 8)
+#define MMIO_74XX_DIR_IN	BIT(8)
+#define MMIO_74XX_DIR_OUT	BIT(9)
 #define MMIO_74XX_BIT_CNT(x)	((x) & GENMASK(7, 0))
 
 struct mmio_74xx_gpio_priv {
-- 
2.35.1

