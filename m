Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6654747E196
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 11:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347771AbhLWKiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 05:38:13 -0500
Received: from mga05.intel.com ([192.55.52.43]:47340 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243241AbhLWKiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 05:38:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640255888; x=1671791888;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yNV1tmH/oemQmmbyzBcEAOihPyJKp+tc9v1PnJomzdQ=;
  b=LGchwvbXHUQOo2KlaVD3NgIiSTGjKxdcFTKWyXgTL1CBbo0jJ/hF+6Ui
   oZSkvR6LSlmeRocW1vWVX4rpUFfhx5t/umw9wFFBxPpNIieEIFHQ65xO4
   ZbSWYnYaZAsy3H+2bd4hEZ39xFOeVFBkS+YYSk9+GjgK2GNR13AyPQnJH
   zLiEkGXFMkKNxngMWZviG8pCP7Uq3xJ76TqbHjqX4kbcFwVfGNz/w1AIm
   Laz9Xh2HBaz8h3ymgCd2I1muTD171/4XoJGfZeT835o6twv+fXeiqHE8F
   Me9NS3LK7G4Vsz6esCPy+FoPhOiNnLlcQlm5MImm2CZ+LKLLw2W7iW6Xp
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="327110934"
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="327110934"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 02:38:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="617451821"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 23 Dec 2021 02:38:05 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A5E44120; Thu, 23 Dec 2021 12:38:13 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Hoan Tran <hoan@os.amperecomputing.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v1 1/2] gpiolib: acpi: make fwnode take precedence in struct gpio_chip
Date:   Thu, 23 Dec 2021 12:38:08 +0200
Message-Id: <20211223103809.12343-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the driver sets the fwnode in struct gpio_chip, let it take
precedence over the parent's fwnode.

This is a follow up to the commit 9126a738edc1 ("gpiolib: of: make
fwnode take precedence in struct gpio_chip").

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index c7a0e56593e7..c0f6a25c3279 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -1339,6 +1339,9 @@ void acpi_gpio_dev_init(struct gpio_chip *gc, struct gpio_device *gdev)
 	/* Set default fwnode to parent's one if present */
 	if (gc->parent)
 		ACPI_COMPANION_SET(&gdev->dev, ACPI_COMPANION(gc->parent));
+
+	if (gc->fwnode)
+		device_set_node(&gdev->dev, gc->fwnode);
 }
 
 static int acpi_gpio_package_count(const union acpi_object *obj)
-- 
2.34.1

