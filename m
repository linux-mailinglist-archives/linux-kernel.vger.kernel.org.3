Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658794B8D27
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 17:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235881AbiBPQBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 11:01:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235880AbiBPQBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 11:01:49 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFF510A5;
        Wed, 16 Feb 2022 08:01:34 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id m17so4620290edc.13;
        Wed, 16 Feb 2022 08:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=14dfXqiviWvFWbZ7hDtjVX4wUngEitaG2TtCJwozqVc=;
        b=dselpBPU48A4OFRui0ktf19YXTMhvx5YTY/Sphlb4uE7oejsdyX2QrP1tkrDf0myU8
         g/TtfZZedPY1m3fOkweMbFluVWMxiScKUTZ1VrKbX1hM/c/8VushT97r40yTJSEYNOgn
         f8JB/qJUBW/5rRU84RXoPKXClBpYN8ZLPszRbHwB2q0KZ8ATNWUJxVJQXRiL7tIW6SUY
         wFL3+hgT1Bwb3QjpPUz12ArZE10R5woiiBAxkfHasJtgKuNWisFFGmvFOCdTK1VczkOm
         w+aNao4junf5kFQdEkV3rlzgQviXUgGG8wgxvihNuFNijQE3xehsiPkvXJZ5hLi+GAK/
         p3qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=14dfXqiviWvFWbZ7hDtjVX4wUngEitaG2TtCJwozqVc=;
        b=h30vGOU1rzUAUpbUGtI8Ysul1Sh+YK2GJtp2Za40MRF/w/1B9nDItZQl1mLjKu4HFl
         S4g98toLJk0b/J9lGCblGJI4EUmALSf2eZvmNIsRSE+2SBzGwmeO8AKhXvsW5Y3xEr/G
         4c2HsVnetWSS/RU+gAiwuWwWNxGBcQXdD93k0lmhPXxVAct+J+UzshMtFNHgkEDH6KZU
         Fe2ByxrdqfRFRrz2gHw4fC8Zi00BaR5vru/lj63B28PyboF+FqMVjBPfEvOh99SPgTiG
         2+DaWDdDnTwh1FncTqElf4dPU3MTPmcZFRmK+1Fbw+dhE2DZvw+0Us+7vKeS3Xl9Ikpk
         BUtw==
X-Gm-Message-State: AOAM530pV1rc5i9/GmNajtHOE2KZrNZQY8gN0liON0G3oeBblUc/bw3L
        B7p99Cezr/Be+24nBErGA2s=
X-Google-Smtp-Source: ABdhPJyR3n8irQCaf3MTjG/4tZjtU4Bti1nk83yB2dgpJyzuxrad4tKW2yRTDjG6HE8iRWszQKkTvw==
X-Received: by 2002:a05:6402:5214:b0:412:996:9ffb with SMTP id s20-20020a056402521400b0041209969ffbmr3312338edd.238.1645027293296;
        Wed, 16 Feb 2022 08:01:33 -0800 (PST)
Received: from tiger.museclub.art (p200300cf9f235800e668694710673d4b.dip0.t-ipconnect.de. [2003:cf:9f23:5800:e668:6947:1067:3d4b])
        by smtp.googlemail.com with ESMTPSA id m4sm59108ejl.45.2022.02.16.08.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 08:01:32 -0800 (PST)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Eugene Shalygin <eugene.shalygin@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] hwmon: (asus-ec-sensors) merge setup functions
Date:   Wed, 16 Feb 2022 17:01:28 +0100
Message-Id: <20220216160128.2418025-1-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220216153407.2412409-1-eugene.shalygin@gmail.com>
References: <20220216153407.2412409-1-eugene.shalygin@gmail.com>
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

Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 drivers/hwmon/asus-ec-sensors.c | 38 ++++++++++++++-------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index bfac08a5dc57..b9eb9126e433 100644
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
 	const struct ec_sensor_info *si;
+	struct ec_sensors_data *ec_data;
 	enum hwmon_sensor_types type;
+	unsigned long board_sensors;
+	struct device *hwdev;
 	unsigned int i;
 
-	ec_data->board_sensors = get_board_sensors(dev);
-	if (!ec_data->board_sensors) {
+	struct device *dev = &pdev->dev;
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

