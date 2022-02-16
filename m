Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92C14B8C85
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 16:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbiBPPed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 10:34:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235357AbiBPPec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 10:34:32 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B987D267241;
        Wed, 16 Feb 2022 07:34:17 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id x5so4510658edd.11;
        Wed, 16 Feb 2022 07:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F/pXocPlPW+FFunz/4FMFMPXTdLFh4fHOr4OnvdvivY=;
        b=oParpqTNSlFICkmQ0iqmliF9rhpfMnS6GO4B4rBlYMXgq29oKvAfRA0we1EepFr8Ql
         6qpMDGZLp2AxPErewlrGcV0dCFUiM7L7sxazVAPtMQLlpEMH3UIV6HCEKE5rNr/huAep
         a5sdp+eHATv6HFMyFQMvffq49MxjbkdB9p1BzWmE5rGUWuJvU0oSYdsjCh5LSfxptDjb
         TpPsBETB/nDKDUsQId43N2HqiCn2hyn2hhNj1oVlbyFlHbba5VnFp2zhtNJk2DPuF/u8
         WcRC7BWr1/20m72mpGuzgBlpBVFGrdnbd5eY84WyCjF+LpukKS2G0HIOHVQzUJLvGCGb
         lXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F/pXocPlPW+FFunz/4FMFMPXTdLFh4fHOr4OnvdvivY=;
        b=iwXuZRIWsGubZbV3MUgw1cj0lguVfHDD5wqlp8nGrAOBFMYBFHbJWN1tIF1mHOwAcr
         dOeu3eKIwhVXKWKNXPjaKKT2nNOhDM4FxPj3eIOWHjq2Briomih7Ev1k9/8G3iEG2YAE
         w2zOLic2Gn2Ollhgg1LynARqFAknqqJrcTF9tmHWoTGd/k35v04ri/jaVKRVL16Jt0ZD
         wgDVba2R8MLOUZR06YHrVdzXb2BbSDyaAbctm+gX7odvveBPnIXpG+cSuxYoGgcaZJdG
         2/6a3BgpQ/9jE4D+8pmKrcSK1zKnU9C6vGHFBdGSfzdlY1ILZoq2NJItOVWLIvbAH79O
         u+Ew==
X-Gm-Message-State: AOAM532/pupo2sOBW8Gp7JHZ6Xb0wd0nqikdi3f6jdui1W8BvG2sCFLL
        ckK1SLVpsXxld9jYGf+UFYU=
X-Google-Smtp-Source: ABdhPJyI9L2ZEvl5Uj8rZ3RMzGr/8WnQcW8tusGLLRei4CyopyqbmcUZobhj8GukEDktjVV6Ru5r3w==
X-Received: by 2002:a05:6402:349:b0:410:a0bd:35ad with SMTP id r9-20020a056402034900b00410a0bd35admr3546737edw.12.1645025656186;
        Wed, 16 Feb 2022 07:34:16 -0800 (PST)
Received: from tiger.museclub.art (p200300cf9f235800e668694710673d4b.dip0.t-ipconnect.de. [2003:cf:9f23:5800:e668:6947:1067:3d4b])
        by smtp.googlemail.com with ESMTPSA id f3sm356717edy.72.2022.02.16.07.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 07:34:15 -0800 (PST)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Eugene Shalygin <eugene.shalygin@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] hwmon: (asus-ec-sensors) merge setup functions
Date:   Wed, 16 Feb 2022 16:34:07 +0100
Message-Id: <20220216153407.2412409-1-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <d720b4a6-e318-8738-d9f4-5017acd558e6@roeck-us.net>
References: <d720b4a6-e318-8738-d9f4-5017acd558e6@roeck-us.net>
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

Change in v2: add local struct device *dev = &pdev->dev;

Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 drivers/hwmon/asus-ec-sensors.c | 39 ++++++++++++++-------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index bfac08a5dc57..300328d97a0c 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -589,23 +589,34 @@ get_board_sensors(const struct device *dev)
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
+	struct device *dev;
 	unsigned int i;
 
-	ec_data->board_sensors = get_board_sensors(dev);
-	if (!ec_data->board_sensors) {
+	dev = &pdev->dev;
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
@@ -666,22 +677,6 @@ static int __init configure_sensor_setup(struct device *dev)
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

