Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CB04B9111
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 20:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238064AbiBPTUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 14:20:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbiBPTUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 14:20:15 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12D5295FEF;
        Wed, 16 Feb 2022 11:20:02 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a23so1540203eju.3;
        Wed, 16 Feb 2022 11:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/wG8x2k3KCilCpxGiW0pcspXFO5UaNsljjYfO2abQfc=;
        b=SOLAojGh3v44wgqjBf/tkVxf+peGfsjJB6jDI3NShV8zaLn6CdUeWh8R1vc+RpohjZ
         GCSacDgWfEfKNvraby/J7gidQm1EX3NAvZ+a1NlAkiw8MbW94If0MkMpha27szGq2yCI
         i59oTv1jbosQYZE1V4ZqMUfBVHugZyccaeCxqztae8FldQKx2/pipLM0MjhKInKbW1AO
         YxqKCa4fERVp2iabhTyzthc19lyTgt/6vD0JHSjRg9L0KJ+xGecQHPNr+ATAi/HVygYz
         dFliTXSDkCSVaXA9IpIdSXAZXJn580dk3qZ1gpFVuruQ4Jj4L/8gUF148hg5iww/s0yv
         zb2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/wG8x2k3KCilCpxGiW0pcspXFO5UaNsljjYfO2abQfc=;
        b=B1PTWenb73s8EY331dY7U/cl1lHk+xKP1jg7Qvr0PMDFBNPDlFsDJ6c06dyRbnXlQR
         PrdATM08KU70A2yZejxRdr+G1I6Uu8GTQvGbBlM1LjjmrDAE9e6ojvEqOTP5MutVr+fA
         7MY+2HQTEg/FAcEU4sVZ+xnkUb+EZ+FVJV2QgOJ0Ig/SSNNNgAyPacY5JI0NXc0AfsoZ
         J1TjyDXF8dYhaiH1ND08O9P8Aikf4HmIw4/GTCTy35u22HpEVzq8IdBW3lD7YXa1CJwX
         TIn7CkU9gAJJ5fawep3HcTzIylDylvRNaXf29AK5FBLLJjB91guSBCstcWEYK/ssxKqT
         pA5g==
X-Gm-Message-State: AOAM5318TeD2UsWlOIuD3fKOt7PTmo9OnehcX8wYEjhM8AC1P+D2H8UL
        z8qcUlfkL7F2mA3tFlMf5cOP9hIdoE+MFg==
X-Google-Smtp-Source: ABdhPJyen+HuOcqT7mG5V92fT14wHkyUe8pfVrUjfQUO2nMQMXaxC8RG49GAB2LgSYHCgvm8o8mGlw==
X-Received: by 2002:a17:906:2dd6:b0:6ce:1052:d10b with SMTP id h22-20020a1709062dd600b006ce1052d10bmr3575202eji.118.1645039201127;
        Wed, 16 Feb 2022 11:20:01 -0800 (PST)
Received: from tiger.museclub.art (p200300cf9f235800e668694710673d4b.dip0.t-ipconnect.de. [2003:cf:9f23:5800:e668:6947:1067:3d4b])
        by smtp.googlemail.com with ESMTPSA id fx4sm231816ejb.221.2022.02.16.11.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 11:20:00 -0800 (PST)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Eugene Shalygin <eugene.shalygin@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6] hwmon: (asus-ec-sensors) merge setup functions
Date:   Wed, 16 Feb 2022 20:19:58 +0100
Message-Id: <20220216191958.2442843-1-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merge configure_sensor_setup() into probe().

Changes:
 - v2: add local struct device *dev = &pdev->dev;
 - v3: initialize dev at declaration
 - v4: fix checkpatch warning
 - v5: fix formatting
 - v6: code style fixes
Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 drivers/hwmon/asus-ec-sensors.c | 41 +++++++++++++--------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index bfac08a5dc57..0eeaa1bcc0f9 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -589,23 +589,31 @@ get_board_sensors(const struct device *dev)
 	return (unsigned long)dmi_entry->driver_data;
 }
 
-static int __init configure_sensor_setup(struct device *dev)
+static int __init asus_ec_probe(struct platform_device *pdev)
 {
-	struct ec_sensors_data *ec_data = dev_get_drvdata(dev);
+	const struct hwmon_channel_info **ptr_asus_ec_ci;
 	int nr_count[hwmon_max] = { 0 }, nr_types = 0;
-	struct device *hwdev;
 	struct hwmon_channel_info *asus_ec_hwmon_chan;
-	const struct hwmon_channel_info **ptr_asus_ec_ci;
 	const struct hwmon_chip_info *chip_info;
+	struct device *dev = &pdev->dev;
+	struct ec_sensors_data *ec_data;
 	const struct ec_sensor_info *si;
 	enum hwmon_sensor_types type;
+	unsigned long board_sensors;
+	struct device *hwdev;
 	unsigned int i;
 
-	ec_data->board_sensors = get_board_sensors(dev);
-	if (!ec_data->board_sensors) {
+	board_sensors = get_board_sensors(dev);
+	if (!board_sensors)
 		return -ENODEV;
-	}
 
+	ec_data = devm_kzalloc(dev, sizeof(struct ec_sensors_data),
+			       GFP_KERNEL);
+	if (!ec_data)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, ec_data);
+	ec_data->board_sensors = board_sensors;
 	ec_data->nr_sensors = board_sensors_count(ec_data->board_sensors);
 	ec_data->sensors = devm_kcalloc(dev, ec_data->nr_sensors,
 					sizeof(struct ec_sensor), GFP_KERNEL);
@@ -616,9 +624,8 @@ static int __init configure_sensor_setup(struct device *dev)
 	ec_data->read_buffer = devm_kcalloc(dev, ec_data->nr_registers,
 					    sizeof(u8), GFP_KERNEL);
 
-	if (!ec_data->registers || !ec_data->read_buffer) {
+	if (!ec_data->registers || !ec_data->read_buffer)
 		return -ENOMEM;
-	}
 
 	fill_ec_registers(ec_data);
 
@@ -666,22 +673,6 @@ static int __init configure_sensor_setup(struct device *dev)
 	return PTR_ERR_OR_ZERO(hwdev);
 }
 
-static int __init asus_ec_probe(struct platform_device *pdev)
-{
-	struct ec_sensors_data *state;
-	int status = 0;
-
-	state = devm_kzalloc(&pdev->dev, sizeof(struct ec_sensors_data),
-			     GFP_KERNEL);
-
-	if (!state) {
-		return -ENOMEM;
-	}
-
-	dev_set_drvdata(&pdev->dev, state);
-	status = configure_sensor_setup(&pdev->dev);
-	return status;
-}
 
 static const struct acpi_device_id acpi_ec_ids[] = {
 	/* Embedded Controller Device */
-- 
2.35.1

