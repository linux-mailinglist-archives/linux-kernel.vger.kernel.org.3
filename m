Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE194AF0BC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbiBIMFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbiBIMDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:03:32 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA41DF28AC5;
        Wed,  9 Feb 2022 03:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644406268; x=1675942268;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=82b6mZczpOv37z3IPpKD3cDsYnQm6SpSpft+H4QvXoo=;
  b=BCR9P2Koz+9xoJqOmDOvhCtvwEv+HgOXqxH8bCTIMTr/rVmrmeVv7c2V
   IVNvD6tYF7nw5Y//asQU9+NeS0MtOFivaMD+otCArajMDlRnI2K6zS3Xl
   dBQzMsnWcUef23tL/tHGvQ4qsMtsxl3pJefdSEmyOljHL6cmmtbmbnnUo
   CcPSaiE1oVUCOXGcJzCs7WpsInn3y2W1/28dyr7Mxq0RkIx/HO/bE16Ja
   ERSyoO0nr4spQo41l4OvjirM2OL5ot4tA9/IQh+aoaL7tPJJ2rY7PKDAX
   bqQxsRWsq7CmxRAggQpohkwz76pXEjOvNW7Bjecce40kT+H/Ddse00I2f
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="309928313"
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="309928313"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 03:31:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="536902450"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 09 Feb 2022 03:31:06 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 374413ED; Wed,  9 Feb 2022 13:31:21 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 2/3] gpiolib: sysfs: Move kstrtox() calls outside of the mutex lock
Date:   Wed,  9 Feb 2022 13:31:16 +0200
Message-Id: <20220209113117.25760-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220209113117.25760-1-andriy.shevchenko@linux.intel.com>
References: <20220209113117.25760-1-andriy.shevchenko@linux.intel.com>
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

In a few places we perform kstrtox() operations under mutex that
do not require any locking. Move them outside of the mutex locks.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-sysfs.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index 57d8ecab53b7..e7828d4dc7a8 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -121,24 +121,18 @@ static ssize_t value_store(struct device *dev,
 {
 	struct gpiod_data *data = dev_get_drvdata(dev);
 	struct gpio_desc *desc = data->desc;
-	ssize_t status = 0;
+	ssize_t status;
+	long value;
+
+	status = kstrtol(buf, 0, &value);
 
 	mutex_lock(&data->mutex);
 
 	if (!test_bit(FLAG_IS_OUT, &desc->flags)) {
 		status = -EPERM;
-	} else {
-		long		value;
-
-		if (size <= 2 && isdigit(buf[0]) &&
-		    (size == 1 || buf[1] == '\n'))
-			value = buf[0] - '0';
-		else
-			status = kstrtol(buf, 0, &value);
-		if (status == 0) {
-			gpiod_set_value_cansleep(desc, value);
-			status = size;
-		}
+	} else if (status == 0) {
+		gpiod_set_value_cansleep(desc, value);
+		status = size;
 	}
 
 	mutex_unlock(&data->mutex);
@@ -342,11 +336,13 @@ static ssize_t active_low_store(struct device *dev,
 	ssize_t			status;
 	long			value;
 
+	status = kstrtol(buf, 0, &value);
+	if (status)
+		return status;
+
 	mutex_lock(&data->mutex);
 
-	status = kstrtol(buf, 0, &value);
-	if (status == 0)
-		status = gpio_sysfs_set_active_low(dev, value);
+	status = gpio_sysfs_set_active_low(dev, value);
 
 	mutex_unlock(&data->mutex);
 
-- 
2.34.1

