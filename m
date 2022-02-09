Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412644AF0BB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbiBIMFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbiBIMDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:03:32 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C99BE016CFF;
        Wed,  9 Feb 2022 03:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644406268; x=1675942268;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FXWN8R871gmjrjKcr6dQfeEJg1wb6st6UlaER4Vzc84=;
  b=Z9o/ZXkjGTeLwHb+TAVeHtW8FO5YSRV0S0Fhr2gTmLf+vonW2eMhnxld
   g/z8SdA8Ff35DH0K2FX+DAJ8nSt00e97oaC5ZVW+KPdvK082N4xvsz1kP
   xEZiN11fefpFRVmcdLK4DwpiAMl8HbBebwIi8IIQDGJVaGFWZ+FyvSk6T
   /eW1B+fkvnd6ijgC4hibYz56r63ItQua9vGYTUOa9MFvfzKeDNbbiD983
   3pbT+mJaYPZcKodA1c6aYtCxvJVOX3Fto7Q10TGEWX8hGPdUJ7BITOTX5
   6y4rRqVLXjWfz87tSf9Pjai99qOl9LGYyF7NRVFSnw9zT4Fc9zWsqhxIB
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="273719026"
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="273719026"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 03:31:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="499939389"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 09 Feb 2022 03:31:06 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 226BC509; Wed,  9 Feb 2022 13:31:21 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 1/3] gpiolib: sysfs: Move sysfs_emit() calls outside of the mutex lock
Date:   Wed,  9 Feb 2022 13:31:15 +0200
Message-Id: <20220209113117.25760-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a few places we perform sysfs_emit() operations under mutex that
do not require any locking. Move them outside of the mutex locks.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-sysfs.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index 78ca7dee8b64..57d8ecab53b7 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -61,17 +61,16 @@ static ssize_t direction_show(struct device *dev,
 {
 	struct gpiod_data *data = dev_get_drvdata(dev);
 	struct gpio_desc *desc = data->desc;
-	ssize_t			status;
+	int value;
 
 	mutex_lock(&data->mutex);
 
 	gpiod_get_direction(desc);
-	status = sysfs_emit(buf, "%s\n",
-			    test_bit(FLAG_IS_OUT, &desc->flags) ? "out" : "in");
+	value = !!test_bit(FLAG_IS_OUT, &desc->flags);
 
 	mutex_unlock(&data->mutex);
 
-	return status;
+	return sysfs_emit(buf, "%s\n", value ? "out" : "in");
 }
 
 static ssize_t direction_store(struct device *dev,
@@ -108,12 +107,13 @@ static ssize_t value_show(struct device *dev,
 	mutex_lock(&data->mutex);
 
 	status = gpiod_get_value_cansleep(desc);
-	if (status >= 0)
-		status = sysfs_emit(buf, "%zd\n", status);
 
 	mutex_unlock(&data->mutex);
 
-	return status;
+	if (status < 0)
+		return status;
+
+	return sysfs_emit(buf, "%zd\n", status);
 }
 
 static ssize_t value_store(struct device *dev,
@@ -238,7 +238,6 @@ static ssize_t edge_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct gpiod_data *data = dev_get_drvdata(dev);
-	ssize_t	status = 0;
 	int i;
 
 	mutex_lock(&data->mutex);
@@ -247,12 +246,13 @@ static ssize_t edge_show(struct device *dev,
 		if (data->irq_flags == trigger_types[i].flags)
 			break;
 	}
-	if (i < ARRAY_SIZE(trigger_types))
-		status = sysfs_emit(buf, "%s\n", trigger_types[i].name);
 
 	mutex_unlock(&data->mutex);
 
-	return status;
+	if (i >= ARRAY_SIZE(trigger_types))
+		return 0;
+
+	return sysfs_emit(buf, "%s\n", trigger_types[i].name);
 }
 
 static ssize_t edge_store(struct device *dev,
@@ -324,16 +324,15 @@ static ssize_t active_low_show(struct device *dev,
 {
 	struct gpiod_data *data = dev_get_drvdata(dev);
 	struct gpio_desc *desc = data->desc;
-	ssize_t			status;
+	int value;
 
 	mutex_lock(&data->mutex);
 
-	status = sysfs_emit(buf, "%d\n",
-			    !!test_bit(FLAG_ACTIVE_LOW, &desc->flags));
+	value = !!test_bit(FLAG_ACTIVE_LOW, &desc->flags);
 
 	mutex_unlock(&data->mutex);
 
-	return status;
+	return sysfs_emit(buf, "%d\n", value);
 }
 
 static ssize_t active_low_store(struct device *dev,
-- 
2.34.1

