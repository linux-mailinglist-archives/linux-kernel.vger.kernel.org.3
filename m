Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E593B4B8EEC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 18:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236950AbiBPRPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 12:15:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236940AbiBPRPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 12:15:48 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AE52A5980;
        Wed, 16 Feb 2022 09:15:36 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a23so820202eju.3;
        Wed, 16 Feb 2022 09:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=laqsIuZH7hU8mtZ60aUAJG9zfQnHthRY1o0zcbYGLEo=;
        b=AeTb7tXNRZP88egqfYyprAtnp+DLvDDB/9gysSWFRxHOZ4AO/EFMveZzPmuqtQCbOJ
         DTclMbe68TdoVkyGoeuHfSupOJc6O+cOjpVR+/E+pEAvUdMRmScc+BNViWhY1gbt+ycn
         ZtMz48veMaiNpWfquhNzESocCIb7dEcAIM7cze0Tbbav7klMMQtZdDYA8hgdtBwDQIBl
         yao75cjQEL2IMX0NOEsfuE2/6DwcBnE8L26mRDFVNMqHSsVgFJq8/Gn+Axuxte+Ahoz/
         re0H85VwbQ9uN19R1nJvbRakp0+4Zpb4htNV2MTMiM8JkzBJ5Mativ1mX0tl6QTGxwU3
         4ECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=laqsIuZH7hU8mtZ60aUAJG9zfQnHthRY1o0zcbYGLEo=;
        b=PqmoKBBWozT1SJOBAsmaszHNVFFGWOchlcvydx5tRvXu7oljzPywsbOEiGucPQc4n0
         gDFIK4isei1wY65QWz/c2Ta/cmwjr6I2evY9mkCUYRmeD0xqwQDm5ZOf3ApBdT/xW/5j
         /0LITevHBl5HQJT0qu/XVnMHC7KA1MPMJYJorMb6hRkE2uADha/LYHQd3zSfY6+waLQQ
         a2o9QtiH4pBOKiC8ie0137hOGA6wLSGgXb8cXMA8ddv3GzrtfA+4QTZtXRZ8Y0WMloFi
         sQMSjlW8HnTGmhZ3+9F+RKo4G5QfFfDJH8bfwiaLsFu4BKsaLhh5TmM5wZ5I85cMvgMC
         2NNw==
X-Gm-Message-State: AOAM5320zDcSF8zRhDGNDI/bK4Oal0TRSIM5ePbXoLGF4YM6ulbus0RP
        eUE3LiuKghHncOM/+ly9gMg=
X-Google-Smtp-Source: ABdhPJw78OXrVLxLCmzJqfw7LR7htLRf5FVzE5rsIb2Nd2qc8uOu3ol4Ob39FtlM2aO2mCsL3BUabg==
X-Received: by 2002:a17:906:6a04:b0:6cf:db6:bda6 with SMTP id qw4-20020a1709066a0400b006cf0db6bda6mr3172116ejc.738.1645031734763;
        Wed, 16 Feb 2022 09:15:34 -0800 (PST)
Received: from tiger.museclub.art (p200300cf9f235800e668694710673d4b.dip0.t-ipconnect.de. [2003:cf:9f23:5800:e668:6947:1067:3d4b])
        by smtp.googlemail.com with ESMTPSA id m7sm138580ejq.10.2022.02.16.09.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 09:15:34 -0800 (PST)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Eugene Shalygin <eugene.shalygin@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] hwmon: (asus-ec-sensors) merge setup functions
Date:   Wed, 16 Feb 2022 18:15:32 +0100
Message-Id: <20220216171532.2430409-1-eugene.shalygin@gmail.com>
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
Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 drivers/hwmon/asus-ec-sensors.c | 38 ++++++++++++++-------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index bfac08a5dc57..ef887168df20 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -589,23 +589,33 @@ get_board_sensors(const struct device *dev)
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
+	if (!board_sensors) {
 		return -ENODEV;
 	}
 
+	ec_data = devm_kzalloc(dev, sizeof(struct ec_sensors_data),
+			     GFP_KERNEL);
+	if (!ec_data) {
+		return -ENOMEM;
+	}
+
+	dev_set_drvdata(dev, ec_data);
+	ec_data->board_sensors = board_sensors;
 	ec_data->nr_sensors = board_sensors_count(ec_data->board_sensors);
 	ec_data->sensors = devm_kcalloc(dev, ec_data->nr_sensors,
 					sizeof(struct ec_sensor), GFP_KERNEL);
@@ -666,22 +676,6 @@ static int __init configure_sensor_setup(struct device *dev)
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

