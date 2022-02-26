Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2319D4C5620
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 14:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbiBZNbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 08:31:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbiBZNbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 08:31:35 -0500
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181744D634;
        Sat, 26 Feb 2022 05:30:59 -0800 (PST)
Received: from hatter.bewilderbeest.net (174-21-187-98.tukw.qwest.net [174.21.187.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 5FCF265A;
        Sat, 26 Feb 2022 05:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1645882259;
        bh=tRdON2JMEu6p1PaqCs46C7UgeqnqwrwysosqhUASnuI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HbJvkbRrIeFV0L6raX0HOnLsOUpLHmSNjviIEyGH1ey4NbfabpzWNAzdaXjfjEmHA
         x9cUWdujxyeV5T/0pTQIp75GYmwEr1jk8P/VJVF9RjLBnlo1PGATljcId+2s8c7mq8
         DwO1D+DkPQo2XA+kLTqDejlHPoilRSVHSGFpFHO8=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     linux-hwmon@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     Zev Weiss <zev@bewilderbeest.net>, Renze Nicolai <renze@rnplus.nl>,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] hwmon: (nct6775) Rearrange attr-group initialization
Date:   Sat, 26 Feb 2022 05:30:43 -0800
Message-Id: <20220226133047.6226-2-zev@bewilderbeest.net>
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

We now track the number of attribute groups in nct6775_data, as a
measure to simplify handling differences in the set of enabled
attribute groups between nct6775 drivers (platform & i2c).  As a side
effect, we also reduce the amount of IS_ERR()/PTR_ERR() boilerplate a
bit.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 drivers/hwmon/nct6775.c | 84 ++++++++++++++++++++---------------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 2b91f7e05126..139b2fe5ca4d 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -1198,6 +1198,7 @@ struct nct6775_data {
 	const char *name;
 
 	const struct attribute_group *groups[7];
+	u8 num_groups;
 
 	u16 reg_temp[5][NUM_TEMP]; /* 0=temp, 1=temp_over, 2=temp_hyst,
 				    * 3=temp_crit, 4=temp_lcrit
@@ -1405,10 +1406,18 @@ struct sensor_template_group {
 	int base;
 };
 
-static struct attribute_group *
-nct6775_create_attr_group(struct device *dev,
-			  const struct sensor_template_group *tg,
-			  int repeat)
+static int nct6775_add_attr_group(struct nct6775_data *data, const struct attribute_group *group)
+{
+	/* Need to leave a NULL terminator at the end of data->groups */
+	if (WARN_ON(data->num_groups == ARRAY_SIZE(data->groups) - 1))
+		return -ENOSPC;
+
+	data->groups[data->num_groups++] = group;
+	return 0;
+}
+
+static int nct6775_add_template_attr_group(struct device *dev, struct nct6775_data *data,
+					   const struct sensor_template_group *tg, int repeat)
 {
 	struct attribute_group *group;
 	struct sensor_device_attr_u *su;
@@ -1419,28 +1428,28 @@ nct6775_create_attr_group(struct device *dev,
 	int i, count;
 
 	if (repeat <= 0)
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 
 	t = tg->templates;
 	for (count = 0; *t; t++, count++)
 		;
 
 	if (count == 0)
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 
 	group = devm_kzalloc(dev, sizeof(*group), GFP_KERNEL);
 	if (group == NULL)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 
 	attrs = devm_kcalloc(dev, repeat * count + 1, sizeof(*attrs),
 			     GFP_KERNEL);
 	if (attrs == NULL)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 
 	su = devm_kzalloc(dev, array3_size(repeat, count, sizeof(*su)),
 			       GFP_KERNEL);
 	if (su == NULL)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 
 	group->attrs = attrs;
 	group->is_visible = tg->is_visible;
@@ -1478,7 +1487,7 @@ nct6775_create_attr_group(struct device *dev,
 		}
 	}
 
-	return group;
+	return nct6775_add_attr_group(data, group);
 }
 
 static bool is_word_sized(struct nct6775_data *data, u16 reg)
@@ -4020,10 +4029,8 @@ static int nct6775_probe(struct platform_device *pdev)
 	const u16 *reg_temp_crit_l = NULL, *reg_temp_crit_h = NULL;
 	int num_reg_temp, num_reg_temp_mon, num_reg_tsi_temp;
 	u8 cr2a;
-	struct attribute_group *group;
 	struct device *hwmon_dev;
 	struct sensor_template_group tsi_temp_tg;
-	int num_attr_groups = 0;
 
 	if (sio_data->access == access_direct) {
 		res = platform_get_resource(pdev, IORESOURCE_IO, 0);
@@ -4844,46 +4851,39 @@ static int nct6775_probe(struct platform_device *pdev)
 	nct6775_init_fan_common(dev, data);
 
 	/* Register sysfs hooks */
-	group = nct6775_create_attr_group(dev, &nct6775_pwm_template_group,
-					  data->pwm_num);
-	if (IS_ERR(group))
-		return PTR_ERR(group);
-
-	data->groups[num_attr_groups++] = group;
-
-	group = nct6775_create_attr_group(dev, &nct6775_in_template_group,
-					  fls(data->have_in));
-	if (IS_ERR(group))
-		return PTR_ERR(group);
-
-	data->groups[num_attr_groups++] = group;
-
-	group = nct6775_create_attr_group(dev, &nct6775_fan_template_group,
-					  fls(data->has_fan));
-	if (IS_ERR(group))
-		return PTR_ERR(group);
+	err = nct6775_add_template_attr_group(dev, data, &nct6775_pwm_template_group,
+					      data->pwm_num);
+	if (err)
+		return err;
 
-	data->groups[num_attr_groups++] = group;
+	err = nct6775_add_template_attr_group(dev, data, &nct6775_in_template_group,
+					      fls(data->have_in));
+	if (err)
+		return err;
 
-	group = nct6775_create_attr_group(dev, &nct6775_temp_template_group,
-					  fls(data->have_temp));
-	if (IS_ERR(group))
-		return PTR_ERR(group);
+	err = nct6775_add_template_attr_group(dev, data, &nct6775_fan_template_group,
+					      fls(data->has_fan));
+	if (err)
+		return err;
 
-	data->groups[num_attr_groups++] = group;
+	err = nct6775_add_template_attr_group(dev, data, &nct6775_temp_template_group,
+					      fls(data->have_temp));
+	if (err)
+		return err;
 
 	if (data->have_tsi_temp) {
 		tsi_temp_tg.templates = nct6775_tsi_temp_template;
 		tsi_temp_tg.is_visible = nct6775_tsi_temp_is_visible;
 		tsi_temp_tg.base = fls(data->have_temp) + 1;
-		group = nct6775_create_attr_group(dev, &tsi_temp_tg, fls(data->have_tsi_temp));
-		if (IS_ERR(group))
-			return PTR_ERR(group);
-
-		data->groups[num_attr_groups++] = group;
+		err = nct6775_add_template_attr_group(dev, data, &tsi_temp_tg,
+						      fls(data->have_tsi_temp));
+		if (err)
+			return err;
 	}
 
-	data->groups[num_attr_groups++] = &nct6775_group_other;
+	err = nct6775_add_attr_group(data, &nct6775_group_other);
+	if (err)
+		return err;
 
 	hwmon_dev = devm_hwmon_device_register_with_groups(dev, data->name,
 							   data, data->groups);
-- 
2.35.1

