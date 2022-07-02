Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B3D563EBE
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 08:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbiGBGGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 02:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbiGBGGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 02:06:00 -0400
Received: from smtp.smtpout.orange.fr (smtp06.smtpout.orange.fr [80.12.242.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7291929E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 23:05:58 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id 7WGRoyJevP8Ap7WGRoBEgh; Sat, 02 Jul 2022 08:05:56 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 02 Jul 2022 08:05:56 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Ed Brindley <kernel@maidavale.org>,
        Denis Pauk <pauk.denis@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-hwmon@vger.kernel.org
Subject: [PATCH v2] hwmon: (asus_wmi_sensors) Save a few bytes of memory
Date:   Sat,  2 Jul 2022 08:05:54 +0200
Message-Id: <e23cea6c489fabb109a61e8a33d146a6b74c0529.1656741926.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first 'for' loop of asus_wmi_configure_sensor_setup() only computes
the number and type of sensors that exist in the system.

Here, the 'temp_sensor' structure is only used to store the data collected
by asus_wmi_sensor_info(). There is no point in using a devm_ variant for
this allocation. This wastes some memory for no good reason.

Use the stack instead.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
v1 -> v2: Use the stack instead of kmalloc/kfree to simplify even more the
          code (Guenter Roeck)
---
 drivers/hwmon/asus_wmi_sensors.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/asus_wmi_sensors.c b/drivers/hwmon/asus_wmi_sensors.c
index 9e935e34c998..6e8a908171f0 100644
--- a/drivers/hwmon/asus_wmi_sensors.c
+++ b/drivers/hwmon/asus_wmi_sensors.c
@@ -514,22 +514,20 @@ static int asus_wmi_configure_sensor_setup(struct device *dev,
 	int i, idx;
 	int err;
 
-	temp_sensor = devm_kcalloc(dev, 1, sizeof(*temp_sensor), GFP_KERNEL);
-	if (!temp_sensor)
-		return -ENOMEM;
-
 	for (i = 0; i < sensor_data->wmi.sensor_count; i++) {
-		err = asus_wmi_sensor_info(i, temp_sensor);
+		struct asus_wmi_sensor_info sensor;
+
+		err = asus_wmi_sensor_info(i, &sensor);
 		if (err)
 			return err;
 
-		switch (temp_sensor->data_type) {
+		switch (sensor.data_type) {
 		case TEMPERATURE_C:
 		case VOLTAGE:
 		case CURRENT:
 		case FAN_RPM:
 		case WATER_FLOW:
-			type = asus_data_types[temp_sensor->data_type];
+			type = asus_data_types[sensor.data_type];
 			if (!nr_count[type])
 				nr_types++;
 			nr_count[type]++;
-- 
2.34.1

