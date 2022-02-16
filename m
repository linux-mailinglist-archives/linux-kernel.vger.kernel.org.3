Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9CD4B82D2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 09:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiBPITs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 03:19:48 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiBPITq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 03:19:46 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138F82701AD;
        Wed, 16 Feb 2022 00:19:34 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id hw13so2771626ejc.9;
        Wed, 16 Feb 2022 00:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MOCLKH0tLyLf/g2Of1HbBCGxzF/AcevMxYdNg5s8qfI=;
        b=PVhAGsp/nsGsciyj2Bx+3BctQOUtxJ/qbFlYRj7iBg6X/ZmDRVU/+0Z7uQKU8lOMZK
         NINkfKrw6bN4Fqu5+XlthtdXlGUlxsXJOFLEzHSw3iWXA27ODl6+0jDcjrmHYUAUb+YJ
         R+eU9Ca2JTS9UZhQaGGPQUS8fPTNxI8BrS+B3IpfiDLigr/Ib+I6h5r5z662CjupoBGP
         +LwBXIBOKvyWov3n2cSsMFGpAyvOWE6qHRuX/ArqObLUcodNGvTRrEWFmBQzImTe6TcF
         fsJEeMxm5Jo6Et9+5OY795vmlCnfpRPsF1Px7YG1V3ekqbp2uU6wLwhdqd3BJxHEJm2A
         DpEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MOCLKH0tLyLf/g2Of1HbBCGxzF/AcevMxYdNg5s8qfI=;
        b=nS84kEQ/IHv0Kq5tr6leaKcJYSmjnySSx3YMZI9MAy91Sq3RgRqqHtlRxV7VpBKOFb
         yMdwIALOw5Qw8dE+Y6N+iFGmKS85DRhdPLSsOe2JWNfYBg38c6Q0LhisNsV8BsCn6vfC
         jjAPP13qAfhtXf9zhqyHK/cC5gDsXBFRSXFNMFdxrIzvLsX3nVfd/0T7aK/avgbBwRia
         lOcwiC31Att1r3eVVGl1gEPUN4Cv7EbWJPJlpO/FNUI7q7muJ9Z1LOMxDWQfuqxvJupF
         +CcfRmqbPj3TP6RFwVFHPOWM+FqODSLHywFCFfvcvMbx/LuLpcsglEBG/NwAlr0tfFnO
         kSuQ==
X-Gm-Message-State: AOAM530jgzFFy25V9TV/pmp5qVrEhjIVxc4lTz7U8svKh5FGPDOwv3Cy
        U9Dsb21rMKHAA8191J+Y0Vs=
X-Google-Smtp-Source: ABdhPJwB+bL8BkzbKvMj4xc/P6Hoc/CcYTWThHUVGi0TmTBtgTTxgneZDMj2QpS8wbXXtwUfJbNnmA==
X-Received: by 2002:a17:906:da1b:b0:6b8:7826:3fa0 with SMTP id fi27-20020a170906da1b00b006b878263fa0mr1348055ejb.516.1644999572516;
        Wed, 16 Feb 2022 00:19:32 -0800 (PST)
Received: from tiger.museclub.art (p200300cf9f235800e668694710673d4b.dip0.t-ipconnect.de. [2003:cf:9f23:5800:e668:6947:1067:3d4b])
        by smtp.googlemail.com with ESMTPSA id e27sm4470048ejm.18.2022.02.16.00.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 00:19:32 -0800 (PST)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Eugene Shalygin <eugene.shalygin@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (asus-ec-sensors) merge setup functions
Date:   Wed, 16 Feb 2022 09:19:20 +0100
Message-Id: <20220216081920.2334468-1-eugene.shalygin@gmail.com>
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

Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 drivers/hwmon/asus-ec-sensors.c | 55 ++++++++++++++-------------------
 1 file changed, 24 insertions(+), 31 deletions(-)

diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index bfac08a5dc57..45de8d34a588 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -589,31 +589,40 @@ get_board_sensors(const struct device *dev)
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
 	const struct ec_sensor_info *si;
+	struct ec_sensors_data *ec_data;
 	enum hwmon_sensor_types type;
+	unsigned long board_sensors;
+	struct device *hwdev;
 	unsigned int i;
 
-	ec_data->board_sensors = get_board_sensors(dev);
-	if (!ec_data->board_sensors) {
+	board_sensors = get_board_sensors(&pdev->dev);
+	if (!board_sensors) {
 		return -ENODEV;
 	}
 
+	ec_data = devm_kzalloc(&pdev->dev, sizeof(struct ec_sensors_data),
+			     GFP_KERNEL);
+	if (!ec_data) {
+		return -ENOMEM;
+	}
+
+	dev_set_drvdata(&pdev->dev, ec_data);
+	ec_data->board_sensors = board_sensors;
 	ec_data->nr_sensors = board_sensors_count(ec_data->board_sensors);
-	ec_data->sensors = devm_kcalloc(dev, ec_data->nr_sensors,
+	ec_data->sensors = devm_kcalloc(&pdev->dev, ec_data->nr_sensors,
 					sizeof(struct ec_sensor), GFP_KERNEL);
 
 	setup_sensor_data(ec_data);
-	ec_data->registers = devm_kcalloc(dev, ec_data->nr_registers,
+	ec_data->registers = devm_kcalloc(&pdev->dev, ec_data->nr_registers,
 					  sizeof(u16), GFP_KERNEL);
-	ec_data->read_buffer = devm_kcalloc(dev, ec_data->nr_registers,
+	ec_data->read_buffer = devm_kcalloc(&pdev->dev, ec_data->nr_registers,
 					    sizeof(u8), GFP_KERNEL);
 
 	if (!ec_data->registers || !ec_data->read_buffer) {
@@ -622,7 +631,7 @@ static int __init configure_sensor_setup(struct device *dev)
 
 	fill_ec_registers(ec_data);
 
-	ec_data->aml_mutex = asus_hw_access_mutex(dev);
+	ec_data->aml_mutex = asus_hw_access_mutex(&pdev->dev);
 
 	for (i = 0; i < ec_data->nr_sensors; ++i) {
 		si = get_sensor_info(ec_data, i);
@@ -635,11 +644,11 @@ static int __init configure_sensor_setup(struct device *dev)
 		nr_count[hwmon_chip]++, nr_types++;
 
 	asus_ec_hwmon_chan = devm_kcalloc(
-		dev, nr_types, sizeof(*asus_ec_hwmon_chan), GFP_KERNEL);
+		&pdev->dev, nr_types, sizeof(*asus_ec_hwmon_chan), GFP_KERNEL);
 	if (!asus_ec_hwmon_chan)
 		return -ENOMEM;
 
-	ptr_asus_ec_ci = devm_kcalloc(dev, nr_types + 1,
+	ptr_asus_ec_ci = devm_kcalloc(&pdev->dev, nr_types + 1,
 				       sizeof(*ptr_asus_ec_ci), GFP_KERNEL);
 	if (!ptr_asus_ec_ci)
 		return -ENOMEM;
@@ -651,37 +660,21 @@ static int __init configure_sensor_setup(struct device *dev)
 		if (!nr_count[type])
 			continue;
 
-		asus_ec_hwmon_add_chan_info(asus_ec_hwmon_chan, dev,
+		asus_ec_hwmon_add_chan_info(asus_ec_hwmon_chan, &pdev->dev,
 					     nr_count[type], type,
 					     hwmon_attributes[type]);
 		*ptr_asus_ec_ci++ = asus_ec_hwmon_chan++;
 	}
 
-	dev_info(dev, "board has %d EC sensors that span %d registers",
+	dev_info(&pdev->dev, "board has %d EC sensors that span %d registers",
 		 ec_data->nr_sensors, ec_data->nr_registers);
 
-	hwdev = devm_hwmon_device_register_with_info(dev, "asusec",
+	hwdev = devm_hwmon_device_register_with_info(&pdev->dev, "asusec",
 						     ec_data, chip_info, NULL);
 
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

