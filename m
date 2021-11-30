Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE9B8463C40
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244493AbhK3QxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 11:53:20 -0500
Received: from mga03.intel.com ([134.134.136.65]:52356 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244442AbhK3QxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:53:14 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="236200897"
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="236200897"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 08:49:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="540475719"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 30 Nov 2021 08:49:53 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 03118F4; Tue, 30 Nov 2021 18:49:57 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hoan Tran <hoan@os.amperecomputing.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 1/1] gpio: dwapb: clarify usage of the register file version
Date:   Tue, 30 Nov 2021 18:49:56 +0200
Message-Id: <20211130164956.37540-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First of all, it's obvious that different versions can't be provided
simultaneously. Hence, versions can't be bit masks.

Second, due to above we have to mask out the version field in the flags
and only that can be evaluated against the certain version.

Clarify all above by:
 - introducing GPIO_REG_OFFSET_V1 and GPIO_REG_OFFSET_MASK
 - replacing conditional to mask out bits and compare to a version

Luckily there is no functional change (at least intended), so no need
to backport this.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-dwapb.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
index f98fa33e1679..ec0767d7800d 100644
--- a/drivers/gpio/gpio-dwapb.c
+++ b/drivers/gpio/gpio-dwapb.c
@@ -53,7 +53,9 @@
 #define GPIO_SWPORT_DR_STRIDE	0x0c /* register stride 3*32 bits */
 #define GPIO_SWPORT_DDR_STRIDE	0x0c /* register stride 3*32 bits */
 
+#define GPIO_REG_OFFSET_V1	0
 #define GPIO_REG_OFFSET_V2	1
+#define GPIO_REG_OFFSET_MASK	BIT(0)
 
 #define GPIO_INTMASK_V2		0x44
 #define GPIO_INTTYPE_LEVEL_V2	0x34
@@ -141,7 +143,7 @@ static inline u32 gpio_reg_v2_convert(unsigned int offset)
 
 static inline u32 gpio_reg_convert(struct dwapb_gpio *gpio, unsigned int offset)
 {
-	if (gpio->flags & GPIO_REG_OFFSET_V2)
+	if ((gpio->flags & GPIO_REG_OFFSET_MASK) == GPIO_REG_OFFSET_V2)
 		return gpio_reg_v2_convert(offset);
 
 	return offset;
@@ -668,15 +670,15 @@ static int dwapb_get_clks(struct dwapb_gpio *gpio)
 }
 
 static const struct of_device_id dwapb_of_match[] = {
-	{ .compatible = "snps,dw-apb-gpio", .data = (void *)0},
+	{ .compatible = "snps,dw-apb-gpio", .data = (void *)GPIO_REG_OFFSET_V1},
 	{ .compatible = "apm,xgene-gpio-v2", .data = (void *)GPIO_REG_OFFSET_V2},
 	{ /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, dwapb_of_match);
 
 static const struct acpi_device_id dwapb_acpi_match[] = {
-	{"HISI0181", 0},
-	{"APMC0D07", 0},
+	{"HISI0181", GPIO_REG_OFFSET_V1},
+	{"APMC0D07", GPIO_REG_OFFSET_V1},
 	{"APMC0D81", GPIO_REG_OFFSET_V2},
 	{ }
 };
-- 
2.33.0

