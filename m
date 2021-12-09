Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA2C746E7BC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 12:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236949AbhLILo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 06:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236841AbhLILos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 06:44:48 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D23CC0617A2;
        Thu,  9 Dec 2021 03:41:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2550BCE25B0;
        Thu,  9 Dec 2021 11:41:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 223BCC341C6;
        Thu,  9 Dec 2021 11:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639050070;
        bh=OCqDBrBAHUAnB8eSFPZckm6joiYRs8SoKnRRNlEb96g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lUsKqnH1rYk3w/x4mdxRoMhaAVbTJaFXMsyYYqqNqT3N7cxmjGz9NfX6HH9onh0BG
         mXK6rI74TxXxKFIMNPaHDPoi9d5f2V6By5LCux8if3U3Az2n7TSvowz+ZMoeT8fMqe
         iSxGlnwW4173P8b3FFQUjlvkHyTm6Y4WN8YswX2VR15axsKQzDWZUeva/jrevmiC3Z
         jlm2GMY7OW1CDnAWlvvVhNxxxWX99UBjmS4tCFkzSUo48yg5XkPKWLwHfTjeybukE7
         4dQU8m74No9Wdy8pLAblnHAvbqMZhigCLlxVz+Y4ebYhQgO+5oh0fUILDiV4tPKBg5
         kg3LCPyVBSltw==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mvHnQ-00BuPI-0m; Thu, 09 Dec 2021 12:41:08 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH v2 4/4] media: si2157: use a different namespace for firmware
Date:   Thu,  9 Dec 2021 12:41:07 +0100
Message-Id: <c06c7806247557daffa999d15cf090437d346747.1639049865.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1639049865.git.mchehab+huawei@kernel.org>
References: <cover.1639049865.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each chip at the si21xx TER family seems to have a different firmware,
with seems to actually be a patch against the ROM code.

Rework the code in orde to use different firmware files depending
at the chip ID and rom ID.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH v2 0/4] at: https://lore.kernel.org/all/cover.1639049865.git.mchehab+huawei@kernel.org/

 drivers/media/tuners/si2157.c      | 172 ++++++++++++++++-------------
 drivers/media/tuners/si2157_priv.h |  14 +++
 2 files changed, 110 insertions(+), 76 deletions(-)

diff --git a/drivers/media/tuners/si2157.c b/drivers/media/tuners/si2157.c
index 5f4ae8593864..f28eab17e82f 100644
--- a/drivers/media/tuners/si2157.c
+++ b/drivers/media/tuners/si2157.c
@@ -76,6 +76,36 @@ static int si2157_cmd_execute(struct i2c_client *client, struct si2157_cmd *cmd)
 	return ret;
 }
 
+enum si2157_chip_type {
+	SI2141 = 41,
+	SI2146 = 46,
+	SI2147 = 47,
+	SI2148 = 48,
+	SI2157 = 57,
+	SI2158 = 58,
+	SI2177 = 77,
+};
+
+struct si2157_firmware {
+	enum si2157_chip_type chip_id;
+	unsigned char rom_id;
+	bool required;
+	const char *fw_name, *fw_alt_name;
+};
+
+static const struct si2157_firmware si2157_fw[] = {
+	{ SI2141, false, 0x60, SI2141_60_FIRMWARE, SI2141_A10_FIRMWARE },
+	{ SI2141, false, 0x61, SI2141_61_FIRMWARE, SI2141_A10_FIRMWARE },
+	{ SI2146, false, 0x11, SI2146_11_FIRMWARE, NULL },
+	{ SI2147, false, 0x50, SI2147_50_FIRMWARE, NULL },
+	{ SI2148, true,  0x32, SI2148_32_FIRMWARE, SI2158_A20_FIRMWARE },
+	{ SI2148, true,  0x33, SI2148_33_FIRMWARE, SI2158_A20_FIRMWARE },
+	{ SI2157, false, 0x50, SI2157_50_FIRMWARE, SI2157_A30_FIRMWARE },
+	{ SI2158, false, 0x50, SI2158_50_FIRMWARE, SI2158_A20_FIRMWARE },
+	{ SI2158, false, 0x51, SI2158_51_FIRMWARE, SI2158_A20_FIRMWARE },
+	{ SI2177, false, 0x50, SI2177_50_FIRMWARE, SI2157_A30_FIRMWARE },
+};
+
 static int si2157_load_firmware(struct dvb_frontend *fe,
 				const char *fw_name)
 {
@@ -124,16 +154,63 @@ static int si2157_load_firmware(struct dvb_frontend *fe,
 	return ret;
 }
 
+static int si2157_find_and_load_firmware(struct dvb_frontend *fe)
+{
+	struct i2c_client *client = fe->tuner_priv;
+	unsigned char chip_id, rom_id;
+	struct si2157_cmd cmd;
+	int ret, i;
+
+	/* query chip revision */
+	memcpy(cmd.args, "\x02", 1);
+	cmd.wlen = 1;
+	cmd.rlen = 13;
+	ret = si2157_cmd_execute(client, &cmd);
+	if (ret)
+		return ret;
+
+	chip_id = cmd.args[2];
+	rom_id = cmd.args[12];
+
+	for (i = 0; i < ARRAY_SIZE(si2157_fw); i++) {
+		if (si2157_fw[i].chip_id != chip_id)
+			continue;
+		if (si2157_fw[i].rom_id == rom_id)
+			break;
+	}
+
+	if (i >= ARRAY_SIZE(si2157_fw)) {
+		dev_err(&client->dev,
+			"unknown chip version Si21%d-%c%c%c ROM 0x%02x\n",
+			chip_id, cmd.args[1], cmd.args[3], cmd.args[4], rom_id);
+		return -EINVAL;
+	}
+
+	dev_info(&client->dev,
+		 "found a 'Silicon Labs Si21%d-%c%c%c ROM 0x%02x'\n",
+		 chip_id, cmd.args[1], cmd.args[3], cmd.args[4], rom_id);
+
+	ret = si2157_load_firmware(fe, si2157_fw[i].fw_name);
+
+	/* Try alternate name, if any */
+	if (ret == -ENOENT && si2157_fw[i].fw_alt_name)
+		ret = si2157_load_firmware(fe, si2157_fw[i].fw_alt_name);
+
+	if (ret == -ENOENT && si2157_fw[i].required)
+	    dev_err(&client->dev, "Can't continue without a firmware.\n");
+	else if (ret < 0) {
+		dev_err(&client->dev, "error %d when loading firmware\n", ret);
+	}
+	return ret;
+}
+
 static int si2157_init(struct dvb_frontend *fe)
 {
 	struct dtv_frontend_properties *c = &fe->dtv_property_cache;
 	struct i2c_client *client = fe->tuner_priv;
 	struct si2157_dev *dev = i2c_get_clientdata(client);
-	bool warn_firmware_not_loaded = false;
-	unsigned int chip_id, xtal_trim;
-	bool fw_required = true;
+	unsigned int xtal_trim;
 	struct si2157_cmd cmd;
-	const char *fw_name;
 	int ret;
 
 	dev_dbg(&client->dev, "\n");
@@ -176,72 +253,15 @@ static int si2157_init(struct dvb_frontend *fe)
 			goto err;
 	}
 
+	/* Try to load the firmware */
 	if (dev->dont_load_firmware) {
 		dev_info(&client->dev, "device is buggy, skipping firmware download\n");
-		goto skip_fw_download;
+	} else {
+		ret = si2157_find_and_load_firmware(fe);
+		if (ret < 0)
+			goto err;
 	}
 
-	/* query chip revision */
-	memcpy(cmd.args, "\x02", 1);
-	cmd.wlen = 1;
-	cmd.rlen = 13;
-	ret = si2157_cmd_execute(client, &cmd);
-	if (ret)
-		goto err;
-
-	chip_id = cmd.args[1] << 24 | cmd.args[2] << 16 | cmd.args[3] << 8 |
-			cmd.args[4] << 0;
-
-	#define SI2177_A30 ('A' << 24 | 77 << 16 | '3' << 8 | '0' << 0)
-	#define SI2158_A20 ('A' << 24 | 58 << 16 | '2' << 8 | '0' << 0)
-	#define SI2148_A20 ('A' << 24 | 48 << 16 | '2' << 8 | '0' << 0)
-	#define SI2157_A30 ('A' << 24 | 57 << 16 | '3' << 8 | '0' << 0)
-	#define SI2147_A30 ('A' << 24 | 47 << 16 | '3' << 8 | '0' << 0)
-	#define SI2146_A10 ('A' << 24 | 46 << 16 | '1' << 8 | '0' << 0)
-	#define SI2141_A10 ('A' << 24 | 41 << 16 | '1' << 8 | '0' << 0)
-
-	switch (chip_id) {
-	case SI2158_A20:
-	case SI2148_A20:
-		fw_name = SI2158_A20_FIRMWARE;
-		break;
-	case SI2141_A10:
-		fw_name = SI2141_A10_FIRMWARE;
-		break;
-	case SI2157_A30:
-		fw_required = false;
-		fallthrough;
-	case SI2177_A30:
-		fw_name = SI2157_A30_FIRMWARE;
-		break;
-	case SI2147_A30:
-	case SI2146_A10:
-		fw_name = NULL;
-		break;
-	default:
-		dev_err(&client->dev, "unknown chip version Si21%d-%c%c%c\n",
-				cmd.args[2], cmd.args[1],
-				cmd.args[3], cmd.args[4]);
-		ret = -EINVAL;
-		goto err;
-	}
-
-	dev_info(&client->dev, "found a 'Silicon Labs Si21%d-%c%c%c'\n",
-			cmd.args[2], cmd.args[1], cmd.args[3], cmd.args[4]);
-
-	if (fw_name == NULL)
-		goto skip_fw_download;
-
-	ret = si2157_load_firmware(fe, fw_name);
-	if (fw_required && ret == -ENOENT)
-		warn_firmware_not_loaded = true;
-	else if (ret < 0) {
-		dev_err(&client->dev, "error %d when loading firmware file '%s'\n",
-			ret, fw_name);
-		goto err;
-	}
-
-skip_fw_download:
 	/* reboot the tuner with new firmware? */
 	memcpy(cmd.args, "\x01\x01", 2);
 	cmd.wlen = 2;
@@ -258,11 +278,6 @@ static int si2157_init(struct dvb_frontend *fe)
 	if (ret)
 		goto err;
 
-	if (warn_firmware_not_loaded) {
-		dev_warn(&client->dev, "firmware file '%s' not found. Using firmware from eeprom.\n",
-			 fw_name);
-		warn_firmware_not_loaded = false;
-	}
 	dev_info(&client->dev, "firmware version: %c.%c.%d\n",
 			cmd.args[6], cmd.args[7], cmd.args[8]);
 
@@ -298,11 +313,6 @@ static int si2157_init(struct dvb_frontend *fe)
 	return 0;
 
 err:
-	if (warn_firmware_not_loaded)
-		dev_err(&client->dev,
-			"firmware file '%s' not found. Can't continue without a firmware.\n",
-			fw_name);
-
 	dev_dbg(&client->dev, "failed=%d\n", ret);
 	return ret;
 }
@@ -968,3 +978,13 @@ MODULE_LICENSE("GPL");
 MODULE_FIRMWARE(SI2158_A20_FIRMWARE);
 MODULE_FIRMWARE(SI2141_A10_FIRMWARE);
 MODULE_FIRMWARE(SI2157_A30_FIRMWARE);
+MODULE_FIRMWARE(SI2141_60_FIRMWARE);
+MODULE_FIRMWARE(SI2141_61_FIRMWARE);
+MODULE_FIRMWARE(SI2146_11_FIRMWARE);
+MODULE_FIRMWARE(SI2147_50_FIRMWARE);
+MODULE_FIRMWARE(SI2148_32_FIRMWARE);
+MODULE_FIRMWARE(SI2148_33_FIRMWARE);
+MODULE_FIRMWARE(SI2157_50_FIRMWARE);
+MODULE_FIRMWARE(SI2158_50_FIRMWARE);
+MODULE_FIRMWARE(SI2158_51_FIRMWARE);
+MODULE_FIRMWARE(SI2177_50_FIRMWARE);
diff --git a/drivers/media/tuners/si2157_priv.h b/drivers/media/tuners/si2157_priv.h
index ef4796098931..a99e04589b6a 100644
--- a/drivers/media/tuners/si2157_priv.h
+++ b/drivers/media/tuners/si2157_priv.h
@@ -54,7 +54,21 @@ struct si2157_cmd {
 	unsigned rlen;
 };
 
+/* Old firmware namespace */
 #define SI2158_A20_FIRMWARE "dvb-tuner-si2158-a20-01.fw"
 #define SI2141_A10_FIRMWARE "dvb-tuner-si2141-a10-01.fw"
 #define SI2157_A30_FIRMWARE "dvb-tuner-si2157-a30-01.fw"
+
+/* New firmware namespace */
+#define SI2141_60_FIRMWARE "dvb_driver_si2141_0_ab23.fw"
+#define SI2141_61_FIRMWARE "dvb_driver_si2141_1_1b12.fw"
+#define SI2146_11_FIRMWARE "dvb_driver_si2146_1_1b3.fw"
+#define SI2147_50_FIRMWARE "dvb_driver_si2147_3_1b3.fw"
+#define SI2148_32_FIRMWARE "dvb_driver_si2148_0_eb15.fw"
+#define SI2148_33_FIRMWARE "dvb_driver_si2148_2_1b11.fw"
+#define SI2157_50_FIRMWARE "dvb_driver_si2157_3_1b3.fw"
+#define SI2158_50_FIRMWARE "dvb_driver_si2178b_0_ab15.fw"
+#define SI2158_51_FIRMWARE "dvb_driver_si2158b_4_1b3.fw"
+#define SI2177_50_FIRMWARE "dvb_driver_si2177_3_1b3.fw"
+
 #endif
-- 
2.33.1

