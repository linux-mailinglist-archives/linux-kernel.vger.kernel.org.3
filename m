Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C2E5A603B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiH3KFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiH3KEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:04:15 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDD2E9935
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:02:10 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id z6so14784734lfu.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=XTo3q+mYdw/9PjZFiZ4r8XFtLJMcNPoTEDIQJX2GN1A=;
        b=PMtleank1JlxTB9xtAYWSLgzJx5+N0S3rWQGvBrc4xHau8uCKKBNcWiA+YGgNIwucg
         kFZfewjJDI7yS5rnFe+t3TeYIhNsg6LOgI7Q5IhxYkqNdmEdQ6XBX7LtgSNmNtUUCrSy
         ZAqxYx/T+io8wNiFniaem6BXmx90apn8Fczns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=XTo3q+mYdw/9PjZFiZ4r8XFtLJMcNPoTEDIQJX2GN1A=;
        b=yVQh0Na6z0RWBeKQOrCGHcLE8uGvNL3O+4LY2ZRMc7toWxGEe/j/+G6HY+ZwHhI9xc
         cJIlIVkspc4nHwCQcOaITqEG9b4Dq08rC3qBsFtPV/+OaKhYwGxfweoSMSPK9v+pVn/Z
         MsL79G2E8alyFn0SHftNBhhDhF/io9+v5hbkvfzw78JJ/pAkVFLEZTtPM0swLEKep9z3
         Yn1L9GVy+sVYND/EAh0mStjtv/DXSC3h/RKXR1izM9nIGSUavxURxAN1n35EX/8XGJsT
         +ZCxw6PfPlwcXl78YGWDTVQdGe3NwhbMKWbj3jciCnoKVHCnPIr8IUNU/38/6JHXpxtX
         /aEQ==
X-Gm-Message-State: ACgBeo3hPyBdnx/e1yizQG2XS1tgEVUZdca7eDKB44FYWmaBnSGaZUSJ
        pnHQa5OiMRB9I6tfB+m533qGTw==
X-Google-Smtp-Source: AA6agR7OkZ+mkz0MOg8POSt7JBF/h6f019AHL8Fu93/UAdUMpZ4aQjBCUvnFmcihuv0hxXKUkzv5kg==
X-Received: by 2002:ac2:4c55:0:b0:492:d91d:363f with SMTP id o21-20020ac24c55000000b00492d91d363fmr8463727lfk.116.1661853729576;
        Tue, 30 Aug 2022 03:02:09 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id m6-20020a056512114600b0048af6242892sm1573435lfg.14.2022.08.30.03.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 03:02:08 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: [PATCH 6/6] rtc: isl12022: add support for temperature sensor
Date:   Tue, 30 Aug 2022 12:01:52 +0200
Message-Id: <20220830100152.698506-7-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220830100152.698506-1-linux@rasmusvillemoes.dk>
References: <20220830100152.698506-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/rtc/rtc-isl12022.c | 81 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/rtc/rtc-isl12022.c b/drivers/rtc/rtc-isl12022.c
index b295ec92ee17..1bd72f436318 100644
--- a/drivers/rtc/rtc-isl12022.c
+++ b/drivers/rtc/rtc-isl12022.c
@@ -17,6 +17,8 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/regmap.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
 
 /* ISL register offsets */
 #define ISL12022_REG_SC		0x00
@@ -30,6 +32,9 @@
 #define ISL12022_REG_SR		0x07
 #define ISL12022_REG_INT	0x08
 
+#define ISL12022_REG_BETA	0x0d
+#define ISL12022_REG_TEMP_L	0x28
+
 /* ISL register bits */
 #define ISL12022_HR_MIL		(1 << 7)	/* military or 24 hour time */
 
@@ -38,6 +43,7 @@
 
 #define ISL12022_INT_WRTC	(1 << 6)
 
+#define ISL12022_BETA_TSE	(1 << 7)
 
 static struct i2c_driver isl12022_driver;
 
@@ -48,6 +54,79 @@ struct isl12022 {
 	bool write_enabled;	/* true if write enable is set */
 };
 
+/*
+ * A user-initiated temperature conversion is not started by this function,
+ * so the temperature is updated once every ~60 seconds.
+ */
+static int isl12022_hwmon_read_temp(struct device *dev, s32 *mC)
+{
+	struct isl12022 *isl12022 = dev_get_drvdata(dev);
+	struct regmap *regmap = isl12022->regmap;
+	u8 temp_buf[2];
+	s32 temp;
+	int ret;
+
+	ret = regmap_bulk_read(regmap, ISL12022_REG_TEMP_L,
+			       temp_buf, sizeof(temp_buf));
+	if (ret)
+		return ret;
+	/*
+	 * Temperature is represented as a 10-bit number, unit half-Kelvins.
+	 */
+	temp = (temp_buf[1] << 8) | temp_buf[0];
+	temp *= 500;
+	temp -= 273000;
+
+	*mC = temp;
+
+	return 0;
+}
+
+static ssize_t
+isl12022_hwmon_show_temp(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	int ret;
+	s32 temp;
+
+	ret = isl12022_hwmon_read_temp(dev, &temp);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%d\n", temp);
+}
+static SENSOR_DEVICE_ATTR(temp1_input, 0444, isl12022_hwmon_show_temp,
+			  NULL, 0);
+
+static struct attribute *isl12022_hwmon_attrs[] = {
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(isl12022_hwmon);
+
+static void isl12022_hwmon_register(struct device *dev)
+{
+	struct isl12022 *isl12022;
+	struct device *hwmon;
+	int ret;
+
+	if (!IS_REACHABLE(CONFIG_HWMON))
+		return;
+
+	isl12022 = dev_get_drvdata(dev);
+
+	ret = regmap_update_bits(isl12022->regmap, ISL12022_REG_BETA,
+				 ISL12022_BETA_TSE, ISL12022_BETA_TSE);
+	if (ret) {
+		dev_warn(dev, "unable to enable temperature sensor\n");
+		return;
+	}
+
+	hwmon = devm_hwmon_device_register_with_groups(dev, "isl12022", isl12022,
+						       isl12022_hwmon_groups);
+	if (IS_ERR(hwmon))
+		dev_warn(dev, "unable to register hwmon device: %pe\n", hwmon);
+}
+
 /*
  * In the routines that deal directly with the isl12022 hardware, we use
  * rtc_time -- month 0-11, hour 0-23, yr = calendar year-epoch.
@@ -179,6 +258,8 @@ static int isl12022_probe(struct i2c_client *client)
 		return PTR_ERR(isl12022->regmap);
 	}
 
+	isl12022_hwmon_register(&client->dev);
+
 	isl12022->rtc = devm_rtc_allocate_device(&client->dev);
 	if (IS_ERR(isl12022->rtc))
 		return PTR_ERR(isl12022->rtc);
-- 
2.37.2

