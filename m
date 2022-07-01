Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDC15638B5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 19:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbiGARrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 13:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiGARrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 13:47:09 -0400
Received: from smtp.smtpout.orange.fr (smtp04.smtpout.orange.fr [80.12.242.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680E536B74
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 10:47:07 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id 7KjPoZtgDQKua7KjPo0b6V; Fri, 01 Jul 2022 19:47:05 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Fri, 01 Jul 2022 19:47:05 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Ed Brindley <kernel@maidavale.org>,
        Denis Pauk <pauk.denis@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-hwmon@vger.kernel.org
Subject: [PATCH] hwmon: (asus_wmi_sensors) Save a few bytes of memory
Date:   Fri,  1 Jul 2022 19:47:02 +0200
Message-Id: <3a494f7049f4f9a169477d872bab0c8a7c7ec48c.1656697596.git.christophe.jaillet@wanadoo.fr>
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
this first allocation and it can be freed just after this initial loop.

So use kzalloc()/kfree() to save a few bytes of memory that would be kept
allocated for no good reason otherwise.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/hwmon/asus_wmi_sensors.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/asus_wmi_sensors.c b/drivers/hwmon/asus_wmi_sensors.c
index 9e935e34c998..4873edad4996 100644
--- a/drivers/hwmon/asus_wmi_sensors.c
+++ b/drivers/hwmon/asus_wmi_sensors.c
@@ -514,14 +514,16 @@ static int asus_wmi_configure_sensor_setup(struct device *dev,
 	int i, idx;
 	int err;
 
-	temp_sensor = devm_kcalloc(dev, 1, sizeof(*temp_sensor), GFP_KERNEL);
+	temp_sensor = kzalloc(sizeof(*temp_sensor), GFP_KERNEL);
 	if (!temp_sensor)
 		return -ENOMEM;
 
 	for (i = 0; i < sensor_data->wmi.sensor_count; i++) {
 		err = asus_wmi_sensor_info(i, temp_sensor);
-		if (err)
+		if (err) {
+			kfree(temp_sensor);
 			return err;
+		}
 
 		switch (temp_sensor->data_type) {
 		case TEMPERATURE_C:
@@ -536,6 +538,7 @@ static int asus_wmi_configure_sensor_setup(struct device *dev,
 			break;
 		}
 	}
+	kfree(temp_sensor);
 
 	if (nr_count[hwmon_temp])
 		nr_count[hwmon_chip]++, nr_types++;
-- 
2.34.1

