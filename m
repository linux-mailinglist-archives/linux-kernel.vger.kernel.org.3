Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F7D4C5622
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 14:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbiBZNbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 08:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbiBZNbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 08:31:34 -0500
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227AE4D9FF;
        Sat, 26 Feb 2022 05:30:59 -0800 (PST)
Received: from hatter.bewilderbeest.net (174-21-187-98.tukw.qwest.net [174.21.187.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 9FB1866F;
        Sat, 26 Feb 2022 05:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1645882259;
        bh=dvWhM0j4c/M5NbkEfml3xflGbASqE3fz2afcQu4V7N0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iuoEBbxSYoEGXbejWzvCvAMBKnATSd7HftDVykqi9FkOgsVY0hMdqw2GlMre+YR/I
         8Pm1bhURCHr6HLmQ22a/utuV/vGiXAWpoZh+OVg4m18q3kj64u0aQY5ivwO4Mby5fR
         mjcd2QdTbEUw/AI2J4CAgvUgwncmPNduvljrB2UE=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     linux-hwmon@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     Zev Weiss <zev@bewilderbeest.net>, Renze Nicolai <renze@rnplus.nl>,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] hwmon: (nct6775) Add read-only mode
Date:   Sat, 26 Feb 2022 05:30:44 -0800
Message-Id: <20220226133047.6226-3-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220226133047.6226-1-zev@bewilderbeest.net>
References: <20220226133047.6226-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When enabled, all write bits are removed from the modes of all sysfs
attribute files.  This provides a bit of infrastructure for the
upcoming i2c version of this driver, which should generally avoid
writes to device registers so as not to interfere with simultaneous
use of the device via the LPC interface.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 drivers/hwmon/nct6775.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 139b2fe5ca4d..c5b28a693461 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -1349,6 +1349,8 @@ struct nct6775_data {
 	/* nct6775_*() callbacks  */
 	u16 (*read_value)(struct nct6775_data *data, u16 reg);
 	int (*write_value)(struct nct6775_data *data, u16 reg, u16 value);
+
+	bool read_only;
 };
 
 struct sensor_device_template {
@@ -1406,6 +1408,11 @@ struct sensor_template_group {
 	int base;
 };
 
+static inline umode_t nct6775_attr_mode(struct nct6775_data *data, struct attribute *attr)
+{
+	return data->read_only ? (attr->mode & ~0222) : attr->mode;
+}
+
 static int nct6775_add_attr_group(struct nct6775_data *data, const struct attribute_group *group)
 {
 	/* Need to leave a NULL terminator at the end of data->groups */
@@ -2246,7 +2253,7 @@ static umode_t nct6775_in_is_visible(struct kobject *kobj,
 	if (!(data->have_in & BIT(in)))
 		return 0;
 
-	return attr->mode;
+	return nct6775_attr_mode(data, attr);
 }
 
 SENSOR_TEMPLATE_2(in_input, "in%d_input", S_IRUGO, show_in_reg, NULL, 0, 0);
@@ -2464,7 +2471,7 @@ static umode_t nct6775_fan_is_visible(struct kobject *kobj,
 	if (nr == 5 && data->kind != nct6775)
 		return 0;
 
-	return attr->mode;
+	return nct6775_attr_mode(data, attr);
 }
 
 SENSOR_TEMPLATE(fan_input, "fan%d_input", S_IRUGO, show_fan, NULL, 0);
@@ -2665,7 +2672,7 @@ static umode_t nct6775_temp_is_visible(struct kobject *kobj,
 	if (nr > 7 && !(data->have_temp_fixed & BIT(temp)))
 		return 0;
 
-	return attr->mode;
+	return nct6775_attr_mode(data, attr);
 }
 
 SENSOR_TEMPLATE_2(temp_input, "temp%d_input", S_IRUGO, show_temp, NULL, 0, 0);
@@ -2736,7 +2743,7 @@ static umode_t nct6775_tsi_temp_is_visible(struct kobject *kobj, struct attribut
 	struct nct6775_data *data = dev_get_drvdata(dev);
 	int temp = index / 2;
 
-	return (data->have_tsi_temp & BIT(temp)) ? attr->mode : 0;
+	return (data->have_tsi_temp & BIT(temp)) ? nct6775_attr_mode(data, attr) : 0;
 }
 
 /*
@@ -3509,7 +3516,7 @@ static umode_t nct6775_pwm_is_visible(struct kobject *kobj,
 		if (api > data->auto_pwm_num)
 			return 0;
 	}
-	return attr->mode;
+	return nct6775_attr_mode(data, attr);
 }
 
 SENSOR_TEMPLATE_2(pwm_stop_time, "pwm%d_stop_time", S_IWUSR | S_IRUGO,
@@ -3704,7 +3711,7 @@ static umode_t nct6775_other_is_visible(struct kobject *kobj,
 			return 0;
 	}
 
-	return attr->mode;
+	return nct6775_attr_mode(data, attr);
 }
 
 /*
-- 
2.35.1

