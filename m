Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35F9E47005A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 12:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240815AbhLJLyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 06:54:51 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35862 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240459AbhLJLyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 06:54:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 274D3B827EC;
        Fri, 10 Dec 2021 11:51:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C22FEC00446;
        Fri, 10 Dec 2021 11:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639137073;
        bh=k6SoHWhosx0qzm2ZpWW1ByceeyzMtPO2w4609dbQnKU=;
        h=From:To:Cc:Subject:Date:From;
        b=BQvaSVhwExVghGCYl9TyVS/k2l4rDqcfVaZ5yXRPW8vhK61maQPPBNKe28Ugp3EyM
         5vtvKMIFmitqiiybgFUTW+13bQVAwBg5djldUlyD7i8YEUIWz23Xr7qY2JAj0iL/lO
         JxaEkH144KM497Mkb+aU9w1TPmrBycKv0jC7FLf4XTeEjFc64NpS/Fd1qSRIrloCr+
         R3aRQ620NJnUw7uJcYZdZGMd4RdhZSMK99/4Cl+6h2Bide8BnqMHehPyIN5yU8kAY0
         2RJXTHTsBwobXQTd+eUrYw03VLlptezMrab8FVjCwNuuLFqvdnCCRCeMWyPzrSjWzS
         wMeoEWypzkFoQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mveQh-000EFs-JX; Fri, 10 Dec 2021 12:51:11 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Robert Schlabbach <robert_s@gmx.net>
Subject: [PATCH v2] media: si2157: get rid of chiptype data
Date:   Fri, 10 Dec 2021 12:51:10 +0100
Message-Id: <08e7a803894687c7706dc974bffd7d8b0c9df53d.1639136930.git.mchehab+huawei@kernel.org>
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

While here, improve documentation of some of the part_id
specific code.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

v2:
   - Checked against the open-sourced manufacturer driver to see if the
     part_id-dependent parts make sense;
   - Added a couple of comments for some of those part_id-specific code

 drivers/media/tuners/si2157.c      | 44 ++++++++++++++++++------------
 drivers/media/tuners/si2157_priv.h |  7 +----
 2 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/drivers/media/tuners/si2157.c b/drivers/media/tuners/si2157.c
index bb590395e81a..a2f0dfd50e8d 100644
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
@@ -235,10 +238,12 @@ static int si2157_init(struct dvb_frontend *fe)
 	dev->if_frequency = 0; /* we no longer know current tuner state */
 
 	/* power up */
-	if (dev->chiptype == SI2157_CHIPTYPE_SI2146) {
+	if (dev->part_id == SI2146) {
+		/* clock_mode = XTAL, clock_freq = 24MHz */
 		memcpy(cmd.args, "\xc0\x05\x01\x00\x00\x0b\x00\x00\x01", 9);
 		cmd.wlen = 9;
-	} else if (dev->chiptype == SI2157_CHIPTYPE_SI2141) {
+	} else if (dev->part_id == SI2141) {
+		/* clock_mode: XTAL, xout enabled */
 		memcpy(cmd.args, "\xc0\x00\x0d\x0e\x00\x01\x01\x01\x01\x03", 10);
 		cmd.wlen = 10;
 	} else {
@@ -247,11 +252,11 @@ static int si2157_init(struct dvb_frontend *fe)
 	}
 	cmd.rlen = 1;
 	ret = si2157_cmd_execute(client, &cmd);
-	if (ret && (dev->chiptype != SI2157_CHIPTYPE_SI2141 || ret != -EAGAIN))
+	if (ret && (dev->part_id != SI2141 || ret != -EAGAIN))
 		goto err;
 
-	/* Si2141 needs a second command before it answers the revision query */
-	if (dev->chiptype == SI2157_CHIPTYPE_SI2141) {
+	/* Si2141 needs a wake up command */
+	if (dev->part_id == SI2141) {
 		memcpy(cmd.args, "\xc0\x08\x01\x02\x00\x00\x01", 7);
 		cmd.wlen = 7;
 		ret = si2157_cmd_execute(client, &cmd);
@@ -493,7 +498,7 @@ static int si2157_set_params(struct dvb_frontend *fe)
 	if (ret)
 		goto err;
 
-	if (dev->chiptype == SI2157_CHIPTYPE_SI2146)
+	if (dev->part_id == SI2146)
 		memcpy(cmd.args, "\x14\x00\x02\x07\x00\x01", 6);
 	else
 		memcpy(cmd.args, "\x14\x00\x02\x07\x00\x00", 6);
@@ -560,9 +565,9 @@ static int si2157_set_analog_params(struct dvb_frontend *fe,
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
@@ -874,7 +879,7 @@ static int si2157_probe(struct i2c_client *client,
 	dev->inversion = cfg->inversion;
 	dev->dont_load_firmware = cfg->dont_load_firmware;
 	dev->if_port = cfg->if_port;
-	dev->chiptype = (u8)id->driver_data;
+	dev->part_id = (u8)id->driver_data;
 	dev->if_frequency = 5000000; /* default value of property 0x0706 */
 	mutex_init(&dev->i2c_mutex);
 	INIT_DELAYED_WORK(&dev->stat_work, si2157_stat_work);
@@ -917,10 +922,8 @@ static int si2157_probe(struct i2c_client *client,
 	}
 #endif
 
-	dev_info(&client->dev, "Silicon Labs %s successfully attached\n",
-			dev->chiptype == SI2157_CHIPTYPE_SI2141 ?  "Si2141" :
-			dev->chiptype == SI2157_CHIPTYPE_SI2146 ?
-			"Si2146" : "Si2147/2148/2157/2158");
+	dev_info(&client->dev, "Silicon Labs Si21%d successfully attached\n",
+		 dev->part_id);
 
 	return 0;
 
@@ -953,11 +956,16 @@ static int si2157_remove(struct i2c_client *client)
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


