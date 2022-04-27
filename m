Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46405510DB1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 03:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356589AbiD0BFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 21:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350422AbiD0BFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 21:05:49 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F4A46B0E;
        Tue, 26 Apr 2022 18:02:39 -0700 (PDT)
Received: from hatter.bewilderbeest.net (174-21-163-222.tukw.qwest.net [174.21.163.222])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id EA3FEB9A;
        Tue, 26 Apr 2022 18:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1651021359;
        bh=kzG6XQw/bGkihFfgyxsKNBvleQ5Q+i6m4vlDfKsNkgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q6t8BSkXmmELMw7iPE9RiZGzZPjFAiQ1QJ2tWe0jOUeHg28kKpsJacFionIRVeRyn
         cyFNzp9IHV5KUwfF8N82q6OUcofVpuPBvFKlpbKslROlRORQaptWTdO/Int/P4bOeT
         dbKP4sOXPRQcaoeQ3C2CTS3/K1rUapY56hXfunEA=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Cc:     Zev Weiss <zev@bewilderbeest.net>, Renze Nicolai <renze@rnplus.nl>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Joel Stanley <joel@jms.id.au>
Subject: [PATCH v4 4/7] hwmon: (nct6775) Add read-only mode
Date:   Tue, 26 Apr 2022 18:01:51 -0700
Message-Id: <20220427010154.29749-5-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220427010154.29749-1-zev@bewilderbeest.net>
References: <20220427010154.29749-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Joel Stanley <joel@jms.id.au>
---
 drivers/hwmon/nct6775.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 36bdbb176601..99b4e308a053 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -1348,6 +1348,7 @@ struct nct6775_data {
 	u8 sio_reg_enable;
 
 	struct regmap *regmap;
+	bool read_only;
 };
 
 struct sensor_device_template {
@@ -1405,6 +1406,11 @@ struct sensor_template_group {
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
@@ -2371,7 +2377,7 @@ static umode_t nct6775_in_is_visible(struct kobject *kobj,
 	if (!(data->have_in & BIT(in)))
 		return 0;
 
-	return attr->mode;
+	return nct6775_attr_mode(data, attr);
 }
 
 SENSOR_TEMPLATE_2(in_input, "in%d_input", S_IRUGO, show_in_reg, NULL, 0, 0);
@@ -2607,7 +2613,7 @@ static umode_t nct6775_fan_is_visible(struct kobject *kobj,
 	if (nr == 5 && data->kind != nct6775)
 		return 0;
 
-	return attr->mode;
+	return nct6775_attr_mode(data, attr);
 }
 
 SENSOR_TEMPLATE(fan_input, "fan%d_input", S_IRUGO, show_fan, NULL, 0);
@@ -2834,7 +2840,7 @@ static umode_t nct6775_temp_is_visible(struct kobject *kobj,
 	if (nr > 7 && !(data->have_temp_fixed & BIT(temp)))
 		return 0;
 
-	return attr->mode;
+	return nct6775_attr_mode(data, attr);
 }
 
 SENSOR_TEMPLATE_2(temp_input, "temp%d_input", S_IRUGO, show_temp, NULL, 0, 0);
@@ -2908,7 +2914,7 @@ static umode_t nct6775_tsi_temp_is_visible(struct kobject *kobj, struct attribut
 	struct nct6775_data *data = dev_get_drvdata(dev);
 	int temp = index / 2;
 
-	return (data->have_tsi_temp & BIT(temp)) ? attr->mode : 0;
+	return (data->have_tsi_temp & BIT(temp)) ? nct6775_attr_mode(data, attr) : 0;
 }
 
 /*
@@ -3766,7 +3772,7 @@ static umode_t nct6775_pwm_is_visible(struct kobject *kobj,
 		if (api > data->auto_pwm_num)
 			return 0;
 	}
-	return attr->mode;
+	return nct6775_attr_mode(data, attr);
 }
 
 SENSOR_TEMPLATE_2(pwm_stop_time, "pwm%d_stop_time", S_IWUSR | S_IRUGO,
@@ -3961,7 +3967,7 @@ static umode_t nct6775_other_is_visible(struct kobject *kobj,
 			return 0;
 	}
 
-	return attr->mode;
+	return nct6775_attr_mode(data, attr);
 }
 
 /*
-- 
2.36.0

