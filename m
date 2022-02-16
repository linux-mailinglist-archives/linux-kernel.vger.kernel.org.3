Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1631E4B8753
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 13:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbiBPMGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 07:06:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232995AbiBPMGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 07:06:15 -0500
Received: from smtp.outgoing.loopia.se (smtp.outgoing.loopia.se [93.188.3.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9412944E3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 04:06:02 -0800 (PST)
Received: from s807.loopia.se (localhost [127.0.0.1])
        by s807.loopia.se (Postfix) with ESMTP id 169042F189C0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 12:56:03 +0100 (CET)
Received: from s934.loopia.se (unknown [172.22.191.6])
        by s807.loopia.se (Postfix) with ESMTP id 060453087ECF;
        Wed, 16 Feb 2022 12:56:03 +0100 (CET)
Received: from s472.loopia.se (unknown [172.22.191.6])
        by s934.loopia.se (Postfix) with ESMTP id 019F07E96F0;
        Wed, 16 Feb 2022 12:56:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at amavis.loopia.se
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
Received: from s645.loopia.se ([172.22.191.6])
        by s472.loopia.se (s472.loopia.se [172.22.190.12]) (amavisd-new, port 10024)
        with LMTP id r4UxUMHdHAdu; Wed, 16 Feb 2022 12:56:02 +0100 (CET)
X-Loopia-Auth: user
X-Loopia-User: carl@hgsystem.se
X-Loopia-Originating-IP: 94.234.42.160
Received: from localhost.localdomain (unknown [94.234.42.160])
        (Authenticated sender: carl@hgsystem.se)
        by s645.loopia.se (Postfix) with ESMTPSA id B8C481576393;
        Wed, 16 Feb 2022 12:56:01 +0100 (CET)
From:   Erik Rosen <erik.rosen@metormote.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chu Lin <linchuyuan@google.com>,
        Jason Ling <jasonling@google.com>
Cc:     Erik Rosen <erik.rosen@metormote.com>
Subject: [PATCH 1/1] hwmon: (pmbus) Try to match MFR_MODEL to pmbus device id
Date:   Wed, 16 Feb 2022 12:55:37 +0100
Message-Id: <20220216115537.44205-2-erik.rosen@metormote.com>
X-Mailer: git-send-email 2.11.0 (Apple Git-81)
In-Reply-To: <20220216115537.44205-1-erik.rosen@metormote.com>
References: <20220216115537.44205-1-erik.rosen@metormote.com>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new device id to  read the MFR_MODEL command
to try and match the model name to the device id name and
predefine the functions supported by this specific converter.
In this way one can avoid the auto-detection process
altogether for the problematic models.
If there is no match, the driver reverts to auto-detection.

Signed-off-by: Erik Rosen <erik.rosen@metormote.com>
---
 drivers/hwmon/pmbus/pmbus.c | 57 +++++++++++++++++++++++++++++++------
 1 file changed, 49 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus.c b/drivers/hwmon/pmbus/pmbus.c
index d0d386990af5..278b2a927ce0 100644
--- a/drivers/hwmon/pmbus/pmbus.c
+++ b/drivers/hwmon/pmbus/pmbus.c
@@ -18,9 +18,11 @@
 struct pmbus_device_info {
 	int pages;
 	u32 flags;
+	u32 func[PMBUS_PAGES];
 };
 
 static const struct i2c_device_id pmbus_id[];
+static const struct pmbus_device_info pmbus_info_zero;
 
 /*
  * Find sensor groups and status registers on each page.
@@ -156,13 +158,18 @@ static int pmbus_identify(struct i2c_client *client,
 	}
 
 	/* Try to find sensor groups  */
-	pmbus_find_sensor_groups(client, info);
+	if (info->func[0] == 0)
+		pmbus_find_sensor_groups(client, info);
+
 abort:
 	return ret;
 }
 
 static int pmbus_probe(struct i2c_client *client)
 {
+	int ret, i;
+	u8 mfr_model[I2C_SMBUS_BLOCK_MAX + 1];
+	const struct i2c_device_id *device_id = NULL;
 	struct pmbus_driver_info *info;
 	struct pmbus_platform_data *pdata = NULL;
 	struct device *dev = &client->dev;
@@ -173,6 +180,30 @@ static int pmbus_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	device_info = (struct pmbus_device_info *)i2c_match_id(pmbus_id, client)->driver_data;
+	if (!device_info) {
+		if (!i2c_check_functionality(client->adapter,
+					     I2C_FUNC_SMBUS_BLOCK_DATA))
+			return -ENODEV;
+
+		ret = i2c_smbus_read_block_data(client, PMBUS_MFR_MODEL, mfr_model);
+		if (ret < 0)
+			return ret;
+
+		for (device_id = pmbus_id; device_id->name[0]; device_id++) {
+			if (device_id->driver_data &&
+			    !strncasecmp(device_id->name, mfr_model, strlen(device_id->name)))
+				break;
+		}
+
+		if (device_id->name[0])
+			device_info = (struct pmbus_device_info *)device_id->driver_data;
+		else
+			device_info = (struct pmbus_device_info *)&pmbus_info_zero;
+
+		dev_info(dev, "Use pmbus device id: %s\n",
+			 device_id->name[0] ? device_id->name : "pmbus");
+	}
+
 	if (device_info->flags) {
 		pdata = devm_kzalloc(dev, sizeof(struct pmbus_platform_data),
 				     GFP_KERNEL);
@@ -183,6 +214,8 @@ static int pmbus_probe(struct i2c_client *client)
 	}
 
 	info->pages = device_info->pages;
+	for (i = 0; i < info->pages; i++)
+		info->func[i] = device_info->func[i];
 	info->identify = pmbus_identify;
 	dev->platform_data = pdata;
 
@@ -204,9 +237,16 @@ static const struct pmbus_device_info pmbus_info_one_skip = {
 	.flags = PMBUS_SKIP_STATUS_CHECK
 };
 
-static const struct pmbus_device_info pmbus_info_one_status = {
+static const struct pmbus_device_info pmbus_info_bmr458 = {
 	.pages = 1,
-	.flags = PMBUS_READ_STATUS_AFTER_FAILED_CHECK
+	.flags = PMBUS_READ_STATUS_AFTER_FAILED_CHECK,
+	.func = {
+			PMBUS_HAVE_VIN | PMBUS_HAVE_STATUS_INPUT
+		      | PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
+		      | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT
+		      | PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2
+		      | PMBUS_HAVE_STATUS_TEMP
+		}
 };
 
 /*
@@ -214,15 +254,15 @@ static const struct pmbus_device_info pmbus_info_one_status = {
  */
 static const struct i2c_device_id pmbus_id[] = {
 	{"adp4000", (kernel_ulong_t)&pmbus_info_one},
-	{"bmr310", (kernel_ulong_t)&pmbus_info_one_status},
+	{"bmr310", (kernel_ulong_t)&pmbus_info_bmr458},
 	{"bmr453", (kernel_ulong_t)&pmbus_info_one},
 	{"bmr454", (kernel_ulong_t)&pmbus_info_one},
 	{"bmr456", (kernel_ulong_t)&pmbus_info_one},
 	{"bmr457", (kernel_ulong_t)&pmbus_info_one},
-	{"bmr458", (kernel_ulong_t)&pmbus_info_one_status},
-	{"bmr480", (kernel_ulong_t)&pmbus_info_one_status},
-	{"bmr490", (kernel_ulong_t)&pmbus_info_one_status},
-	{"bmr491", (kernel_ulong_t)&pmbus_info_one_status},
+	{"bmr458", (kernel_ulong_t)&pmbus_info_bmr458},
+	{"bmr480", (kernel_ulong_t)&pmbus_info_bmr458},
+	{"bmr490", (kernel_ulong_t)&pmbus_info_bmr458},
+	{"bmr491", (kernel_ulong_t)&pmbus_info_bmr458},
 	{"bmr492", (kernel_ulong_t)&pmbus_info_one},
 	{"dps460", (kernel_ulong_t)&pmbus_info_one_skip},
 	{"dps650ab", (kernel_ulong_t)&pmbus_info_one_skip},
@@ -235,6 +275,7 @@ static const struct i2c_device_id pmbus_id[] = {
 	{"pdt006", (kernel_ulong_t)&pmbus_info_one},
 	{"pdt012", (kernel_ulong_t)&pmbus_info_one},
 	{"pmbus", (kernel_ulong_t)&pmbus_info_zero},
+	{"pmbus_match_model", (kernel_ulong_t)0},
 	{"sgd009", (kernel_ulong_t)&pmbus_info_one_skip},
 	{"tps40400", (kernel_ulong_t)&pmbus_info_one},
 	{"tps544b20", (kernel_ulong_t)&pmbus_info_one},
-- 
2.20.1

