Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEAEC4834FC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 17:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234765AbiACQlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 11:41:50 -0500
Received: from mout-y-111.mailbox.org ([91.198.250.236]:47506 "EHLO
        mout-y-111.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbiACQll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 11:41:41 -0500
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:105:465:1:4:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4JSLv634ZYzQk9k;
        Mon,  3 Jan 2022 17:34:58 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1641227698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jGg109/SdVHAGsrAmpzH9OY+vbgtukVPEWTK0WDru0U=;
        b=X6Nlz27buP8i9o6PFocqdelqz2TasN39CkF4YEJ5nHXhcMEAlX3NdXwLEvONKHzxtw27fl
        s5XPTjN9zxuHvrXljbt7ZswAKXM2TB4F2g3r+MHlaWNRH08dvkyohDpCDOhCg9CfK06ET1
        5foM6SomWd/Ps8TM7YcTSSfP+6LFOLbtxFKywiI4jPEGtq7PRWlx7tTgrtELJVJuEDsd+g
        XzBW1HgcJIh0pkwn32iM3YJpWIYq/N3wB/ODZCpqts1iF6/6LD8bFgouEqtolqp4G30hfN
        lZo5fqHLTCTtfjfjJyHYH9TLheEoB8R2SIxZq8MxCv3YzLalwjBO1py9+wHeLw==
From:   Marcello Sylvester Bauer <sylv@sylv.io>
To:     linux-hwmon@vger.kernel.org
Cc:     Marcello Sylvester Bauer <sylv@sylv.io>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/4] hwmon: (max6639) Add devicetree support
Date:   Mon,  3 Jan 2022 17:33:49 +0100
Message-Id: <18f099abda66841042d71739c6ffd41c84434106.1641224715.git.sylv@sylv.io>
In-Reply-To: <cover.1641224715.git.sylv@sylv.io>
References: <cover.1641224715.git.sylv@sylv.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the driver to work with device tree support.

Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
---
 drivers/hwmon/max6639.c | 47 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
index d733c35b5bcf..f84ee4a05f80 100644
--- a/drivers/hwmon/max6639.c
+++ b/drivers/hwmon/max6639.c
@@ -412,6 +412,38 @@ static int rpm_range_to_reg(int range)
 	return 1; /* default: 4000 RPM */
 }
 
+static struct max6639_platform_data *get_pdata_from_dt_node(struct device *dev)
+{
+	struct max6639_platform_data *pdata;
+	u32 pol, ppr, rpm;
+	int ret;
+
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return ERR_PTR(-ENOMEM);
+
+	pdata->pwm_polarity = true;
+	ret = of_property_read_u32(dev->of_node, "polarity", &pol);
+	if (!ret && !pol)
+		pdata->pwm_polarity = false;
+
+	ret = of_property_read_u32(dev->of_node, "pulses-per-revolution", &ppr);
+	if (ret < 0)
+		dev_warn(dev, "No pulses-per-revolution property\n");
+	else
+		pdata->ppr = ppr;
+
+	ret = of_property_read_u32(dev->of_node, "rpm-range", &rpm);
+	if (ret < 0) {
+		dev_warn(dev, "no rpm-range property\n");
+		pdata->rpm_range = 4000;
+	} else {
+		pdata->rpm_range = rpm;
+	}
+
+	return pdata;
+}
+
 static int max6639_init_client(struct i2c_client *client,
 			       struct max6639_data *data)
 {
@@ -421,6 +453,12 @@ static int max6639_init_client(struct i2c_client *client,
 	int rpm_range = 1; /* default: 4000 RPM */
 	int err;
 
+	if (!max6639_info && client->dev.of_node) {
+		max6639_info = get_pdata_from_dt_node(&client->dev);
+		if (IS_ERR(max6639_info))
+			return PTR_ERR(max6639_info);
+	}
+
 	/* Reset chip to default values, see below for GCONFIG setup */
 	err = i2c_smbus_write_byte_data(client, MAX6639_REG_GCONFIG,
 				  MAX6639_GCONFIG_POR);
@@ -631,6 +669,14 @@ static const struct i2c_device_id max6639_id[] = {
 
 MODULE_DEVICE_TABLE(i2c, max6639_id);
 
+#ifdef CONFIG_OF
+static const struct of_device_id maxim_of_platform_match[] = {
+	{.compatible = "maxim,max6639"},
+	{},
+};
+MODULE_DEVICE_TABLE(of, maxim_of_platform_match);
+#endif
+
 static SIMPLE_DEV_PM_OPS(max6639_pm_ops, max6639_suspend, max6639_resume);
 
 static struct i2c_driver max6639_driver = {
@@ -638,6 +684,7 @@ static struct i2c_driver max6639_driver = {
 	.driver = {
 		   .name = "max6639",
 		   .pm = &max6639_pm_ops,
+		   .of_match_table = of_match_ptr(maxim_of_platform_match),
 		   },
 	.probe_new = max6639_probe,
 	.id_table = max6639_id,
-- 
2.33.1

