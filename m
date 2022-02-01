Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 234664A6012
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 16:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240364AbiBAP2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 10:28:15 -0500
Received: from mga11.intel.com ([192.55.52.93]:50145 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240298AbiBAP2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 10:28:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643729287; x=1675265287;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vYx2GsZqSFMCQkCK0aXM5A2exFEh+Udse3hEMOmlWNA=;
  b=VU3y+Zw0mpqXRbWStXjlUy5ZoTUINlOhyjPWss+ncFUsbg7uR+r7gyrw
   fRaQhQ82q6LDboOVbXMmMt4Hyt0xUE7c5C8M+AvU5q2GM9Sce0LEP86r6
   4UC7WHfGndsXX2juCd4UJU4jjLOVjBlSyM5P8nPCMHmuwVvBmzKi4L+m3
   nT4D+NEuoLBaGDwBpqWzOH5jmL1dqhOrxAb1C07FLKHaS1n/AoO3+txW9
   sJwhhOpyoy6u+Qx1pHwAsPg7oEhFZPGGdliGTib8YaiBk92wJ2zqOMF+d
   M1kYvZYeBX3kPA7Ih08RwVlo4CT8Pg3bonYF089OW7CemkLKQSFJ/OGZ3
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="245307490"
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="245307490"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 07:28:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="497378279"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 01 Feb 2022 07:28:03 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id F0EA741C; Tue,  1 Feb 2022 17:28:17 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v3 4/4] gpiolib: Simplify error path in gpiod_get_index() when requesting GPIO
Date:   Tue,  1 Feb 2022 17:27:58 +0200
Message-Id: <20220201152758.40391-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220201152758.40391-1-andriy.shevchenko@linux.intel.com>
References: <20220201152758.40391-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify error path in the gpiod_get_index() when requesting a GPIO line by:
 - checking for error condition first
 - dropping redundant 'else'

As a result, decrease the indentation level for better readability.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index daedf8207173..b4d8bf3a1121 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3933,20 +3933,19 @@ struct gpio_desc *__must_check gpiod_get_index(struct device *dev,
 	 */
 	ret = gpiod_request(desc, con_id ?: devname);
 	if (ret) {
-		if (ret == -EBUSY && flags & GPIOD_FLAGS_BIT_NONEXCLUSIVE) {
-			/*
-			 * This happens when there are several consumers for
-			 * the same GPIO line: we just return here without
-			 * further initialization. It is a bit of a hack.
-			 * This is necessary to support fixed regulators.
-			 *
-			 * FIXME: Make this more sane and safe.
-			 */
-			dev_info(dev, "nonexclusive access to GPIO for %s\n", con_id ?: devname);
-			return desc;
-		} else {
+		if (!(ret == -EBUSY && flags & GPIOD_FLAGS_BIT_NONEXCLUSIVE))
 			return ERR_PTR(ret);
-		}
+
+		/*
+		 * This happens when there are several consumers for
+		 * the same GPIO line: we just return here without
+		 * further initialization. It is a bit of a hack.
+		 * This is necessary to support fixed regulators.
+		 *
+		 * FIXME: Make this more sane and safe.
+		 */
+		dev_info(dev, "nonexclusive access to GPIO for %s\n", con_id ?: devname);
+		return desc;
 	}
 
 	ret = gpiod_configure_flags(desc, con_id, lookupflags, flags);
-- 
2.34.1

