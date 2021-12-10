Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43BAE46FC37
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 09:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237978AbhLJIDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 03:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbhLJIDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 03:03:33 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBDFC061746;
        Thu,  9 Dec 2021 23:59:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8F6F5CE2A2C;
        Fri, 10 Dec 2021 07:59:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B87D0C341C8;
        Fri, 10 Dec 2021 07:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639123194;
        bh=Nf+Wcdf04qf2Nlhbx2KQt1pzdfSFDlEh5q45kHafA08=;
        h=From:To:Cc:Subject:Date:From;
        b=YXGJe3h1nzK/olC++6chtobUC26on3d+t3ZQl75gynrPzIaEAsq2c5SOj5EmSa1Hb
         j/GV7k1VRfHuH+B1lgYOdLvTMRk14wWJT4MWSXe1l9POArcggrBaFo0FkRS6U0Aop7
         uZda8DWIdzzNFfu97JR5+ZltHzD2PC6UjLfLlMxQEiq+cdLiJLZBZfvCWCAVSqLSKQ
         wHL3JN9M15CYfnxWb17c/QIe0f/e8n5b9GfrAw6sutiTsj2RONNJCBYF21bWiIvNcI
         vGJs9TWRFi47CYEeQNHL1w45OZTmBDKraSs9ZfeIM+o2dbhdb2aipRk4Q9M18Ruz5S
         VI+kFctIQPr4w==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mvaoq-000BYg-MA; Fri, 10 Dec 2021 08:59:52 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH RFC] media: si2157: get rid of chiptype data
Date:   Fri, 10 Dec 2021 08:59:50 +0100
Message-Id: <7dfc5692c89a4017591f475341f7178e473f7bb1.1639123045.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver should be capable of autodetecting its type, so no
need to pass it via device driver's data.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

This is RFC, as this patch could potentially cause regressions, if some of the
data there would actually be quirks needed by some specific devices. 

 drivers/media/tuners/si2157.c      | 40 +++++++++++++++++-------------
 drivers/media/tuners/si2157_priv.h |  7 +-----
 2 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/drivers/media/tuners/si2157.c b/drivers/media/tuners/si2157.c
index bb590395e81a..8c33c412a203 100644
--- a/drivers/media/tuners/si2157.c
+++ b/drivers/media/tuners/si2157.c
@@ -185,6 +185,9 @@ static int si2157_find_and_load_firmware(struct dvb_frontend *fe)
 		return -EINVAL;
 	}
 
+	/* Update the part id based on device's report */
+	dev->part_id = part_id;
+
 	dev_info(&client->dev,
 		 "found a 'Silicon Labs Si21%d-%c%c%c ROM 0x%02x'\n",
 		 part_id, cmd.args[1], cmd.args[3], cmd.args[4], rom_id);
@@ -235,10 +238,10 @@ static int si2157_init(struct dvb_frontend *fe)
 	dev->if_frequency = 0; /* we no longer know current tuner state */
 
 	/* power up */
-	if (dev->chiptype == SI2157_CHIPTYPE_SI2146) {
+	if (dev->part_id == SI2146) {
 		memcpy(cmd.args, "\xc0\x05\x01\x00\x00\x0b\x00\x00\x01", 9);
 		cmd.wlen = 9;
-	} else if (dev->chiptype == SI2157_CHIPTYPE_SI2141) {
+	} else if (dev->part_id == SI2141) {
 		memcpy(cmd.args, "\xc0\x00\x0d\x0e\x00\x01\x01\x01\x01\x03", 10);
 		cmd.wlen = 10;
 	} else {
@@ -247,11 +250,11 @@ static int si2157_init(struct dvb_frontend *fe)
 	}
 	cmd.rlen = 1;
 	ret = si2157_cmd_execute(client, &cmd);
-	if (ret && (dev->chiptype != SI2157_CHIPTYPE_SI2141 || ret != -EAGAIN))
+	if (ret && (dev->part_id != SI2141 || ret != -EAGAIN))
 		goto err;
 
 	/* Si2141 needs a second command before it answers the revision query */
-	if (dev->chiptype == SI2157_CHIPTYPE_SI2141) {
+	if (dev->part_id == SI2141) {
 		memcpy(cmd.args, "\xc0\x08\x01\x02\x00\x00\x01", 7);
 		cmd.wlen = 7;
 		ret = si2157_cmd_execute(client, &cmd);
@@ -493,7 +496,7 @@ static int si2157_set_params(struct dvb_frontend *fe)
 	if (ret)
 		goto err;
 
-	if (dev->chiptype == SI2157_CHIPTYPE_SI2146)
+	if (dev->part_id == SI2146)
 		memcpy(cmd.args, "\x14\x00\x02\x07\x00\x01", 6);
 	else
 		memcpy(cmd.args, "\x14\x00\x02\x07\x00\x00", 6);
@@ -560,9 +563,9 @@ static int si2157_set_analog_params(struct dvb_frontend *fe,
 	u8 color = 0;    /* 0=NTSC/PAL, 0x10=SECAM */
 	u8 invert_analog = 1; /* analog tuner spectrum; 0=normal, 1=inverted */
 
-	if (dev->chiptype != SI2157_CHIPTYPE_SI2157) {
-		dev_info(&client->dev, "Analog tuning not supported for chiptype=%u\n",
-			 dev->chiptype);
+	if (dev->part_id != SI2157) {
+		dev_info(&client->dev, "Analog tuning not supported on Si21%d\n",
+			 dev->part_id);
 		ret = -EINVAL;
 		goto err;
 	}
@@ -874,7 +877,7 @@ static int si2157_probe(struct i2c_client *client,
 	dev->inversion = cfg->inversion;
 	dev->dont_load_firmware = cfg->dont_load_firmware;
 	dev->if_port = cfg->if_port;
-	dev->chiptype = (u8)id->driver_data;
+	dev->part_id = (u8)id->driver_data;
 	dev->if_frequency = 5000000; /* default value of property 0x0706 */
 	mutex_init(&dev->i2c_mutex);
 	INIT_DELAYED_WORK(&dev->stat_work, si2157_stat_work);
@@ -917,10 +920,8 @@ static int si2157_probe(struct i2c_client *client,
 	}
 #endif
 
-	dev_info(&client->dev, "Silicon Labs %s successfully attached\n",
-			dev->chiptype == SI2157_CHIPTYPE_SI2141 ?  "Si2141" :
-			dev->chiptype == SI2157_CHIPTYPE_SI2146 ?
-			"Si2146" : "Si2147/2148/2157/2158");
+	dev_info(&client->dev, "Silicon Labs Si21%d successfully attached\n",
+		 dev->part_id);
 
 	return 0;
 
@@ -953,11 +954,16 @@ static int si2157_remove(struct i2c_client *client)
 	return 0;
 }
 
+/*
+ * The part_id used here will only be used on buggy devices that don't
+ * accept firmware uploads. Non-buggy devices should just use "si2157" for
+ * all SiLabs TER tuners, as the driver should auto-detect it.
+ */
 static const struct i2c_device_id si2157_id_table[] = {
-	{"si2157", SI2157_CHIPTYPE_SI2157},
-	{"si2146", SI2157_CHIPTYPE_SI2146},
-	{"si2141", SI2157_CHIPTYPE_SI2141},
-	{"si2177", SI2157_CHIPTYPE_SI2177},
+	{"si2157", SI2157},
+	{"si2146", SI2146},
+	{"si2141", SI2141},
+	{"si2177", SI2177},
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, si2157_id_table);
diff --git a/drivers/media/tuners/si2157_priv.h b/drivers/media/tuners/si2157_priv.h
index 0db21b082ba9..df17a5f03561 100644
--- a/drivers/media/tuners/si2157_priv.h
+++ b/drivers/media/tuners/si2157_priv.h
@@ -26,7 +26,7 @@ struct si2157_dev {
 	unsigned int active:1;
 	unsigned int inversion:1;
 	unsigned int dont_load_firmware:1;
-	u8 chiptype;
+	u8 part_id;
 	u8 if_port;
 	u32 if_frequency;
 	u32 bandwidth;
@@ -58,11 +58,6 @@ struct si2157_tuner_info {
 	const char		*fw_name, *fw_alt_name;
 };
 
-#define SI2157_CHIPTYPE_SI2157 0
-#define SI2157_CHIPTYPE_SI2146 1
-#define SI2157_CHIPTYPE_SI2141 2
-#define SI2157_CHIPTYPE_SI2177 3
-
 /* firmware command struct */
 #define SI2157_ARGLEN      30
 struct si2157_cmd {
-- 
2.33.1


