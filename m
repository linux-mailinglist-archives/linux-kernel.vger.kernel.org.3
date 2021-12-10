Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C72C46FC2B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 08:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237914AbhLJIAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 03:00:50 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:54464 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235979AbhLJIAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 03:00:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 46332CE2A2E;
        Fri, 10 Dec 2021 07:57:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A8FFC341D4;
        Fri, 10 Dec 2021 07:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639123023;
        bh=fTUqs9sW1baOd3VK3risCkuIxXJtvrC2VcBYmUXelLs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WBc8L7rwCRanpdSgLhjLbKauyQkrx+y+KfDa3MpzLYU+xjAH5+BLQAxlxZO0H+Emy
         eGaeCJQpwrbr4WMQcGpUM5yDtUnM+650nty8wpes5uo4FYKV7btfCCywF/LRbGLldI
         WFM1I3hWltU0pVf3wecfeA5jKZaUdNee4Trwe9oh3CqyEzwiUCIzDhsf6hu1OdhiBD
         HUJMqBVsG+q1SZlFUAB2TlqVwbe7UfeT3Jh4sx22oG3BEUm3UaIrNsW2/7jq9hBg79
         wyGhTMRhKfKDyqG9e0OLowX8WU0Pt52HLBur3MeuuuwXo9Gh6AU1q+Rb9fhuwNiZDl
         zDcvDhJogya0g==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mvam4-000BVi-UU; Fri, 10 Dec 2021 08:57:00 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Robert Schlabbach" <robert_s@gmx.net>,
        Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH v3 4/4] media: si2157: use a different namespace for firmware
Date:   Fri, 10 Dec 2021 08:56:59 +0100
Message-Id: <74ddde559ddca726aea10bc8c2e9f730d5421502.1639120421.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1639120421.git.mchehab+huawei@kernel.org>
References: <cover.1639120421.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each chip at the si21xx TER family seems to have a different firmware,
with seems to actually be a patch against the ROM code.

Rework the code in order to use different firmware files depending
on the chip ID and rom ID.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH v3 0/4] at: https://lore.kernel.org/all/cover.1639120421.git.mchehab+huawei@kernel.org/

 drivers/media/tuners/si2157.c      | 180 ++++++++++++++++-------------
 drivers/media/tuners/si2157_priv.h |  31 +++++
 2 files changed, 132 insertions(+), 79 deletions(-)

diff --git a/drivers/media/tuners/si2157.c b/drivers/media/tuners/si2157.c
index 5f4ae8593864..bb590395e81a 100644
--- a/drivers/media/tuners/si2157.c
+++ b/drivers/media/tuners/si2157.c
@@ -76,6 +76,19 @@ static int si2157_cmd_execute(struct i2c_client *client, struct si2157_cmd *cmd)
 	return ret;
 }
 
+static const struct si2157_tuner_info si2157_tuners[] = {
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
@@ -85,7 +98,7 @@ static int si2157_load_firmware(struct dvb_frontend *fe,
 	struct si2157_cmd cmd;
 
 	/* request the firmware, this will block and timeout */
-	ret = request_firmware(&fw, fw_name, &client->dev);
+	ret = firmware_request_nowarn(&fw, fw_name, &client->dev);
 	if (ret)
 		return ret;
 
@@ -124,16 +137,86 @@ static int si2157_load_firmware(struct dvb_frontend *fe,
 	return ret;
 }
 
+static int si2157_find_and_load_firmware(struct dvb_frontend *fe)
+{
+	struct i2c_client *client = fe->tuner_priv;
+	struct si2157_dev *dev = i2c_get_clientdata(client);
+	const char *fw_alt_name = NULL;
+	unsigned char part_id, rom_id;
+	const char *fw_name = NULL;
+	struct si2157_cmd cmd;
+	bool required = true;
+	int ret, i;
+
+	if (dev->dont_load_firmware) {
+		dev_info(&client->dev,
+			 "device is buggy, skipping firmware download\n");
+		return 0;
+	}
+
+	/* query chip revision */
+	memcpy(cmd.args, "\x02", 1);
+	cmd.wlen = 1;
+	cmd.rlen = 13;
+	ret = si2157_cmd_execute(client, &cmd);
+	if (ret)
+		return ret;
+
+	part_id = cmd.args[2];
+	rom_id = cmd.args[12];
+
+	for (i = 0; i < ARRAY_SIZE(si2157_tuners); i++) {
+		if (si2157_tuners[i].part_id != part_id)
+			continue;
+		required = si2157_tuners[i].required;
+		fw_alt_name = si2157_tuners[i].fw_alt_name;
+
+		/* Both part and rom ID match */
+		if (si2157_tuners[i].rom_id == rom_id) {
+			fw_name = si2157_tuners[i].fw_name;
+			break;
+		}
+	}
+
+	if (!fw_name && !fw_alt_name) {
+		dev_err(&client->dev,
+			"unknown chip version Si21%d-%c%c%c ROM 0x%02x\n",
+			part_id, cmd.args[1], cmd.args[3], cmd.args[4], rom_id);
+		return -EINVAL;
+	}
+
+	dev_info(&client->dev,
+		 "found a 'Silicon Labs Si21%d-%c%c%c ROM 0x%02x'\n",
+		 part_id, cmd.args[1], cmd.args[3], cmd.args[4], rom_id);
+
+	if (fw_name)
+		ret = si2157_load_firmware(fe, fw_name);
+	else
+		ret = -ENOENT;
+
+	/* Try alternate name, if any */
+	if (ret == -ENOENT && fw_alt_name)
+		ret = si2157_load_firmware(fe, fw_alt_name);
+
+	if (ret == -ENOENT) {
+		if (!required) {
+			dev_info(&client->dev, "Using ROM firmware.\n");
+			return 0;
+		}
+		dev_err(&client->dev, "Can't continue without a firmware.\n");
+	} else if (ret < 0) {
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
@@ -176,72 +259,11 @@ static int si2157_init(struct dvb_frontend *fe)
 			goto err;
 	}
 
-	if (dev->dont_load_firmware) {
-		dev_info(&client->dev, "device is buggy, skipping firmware download\n");
-		goto skip_fw_download;
-	}
-
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
+	/* Try to load the firmware */
+	ret = si2157_find_and_load_firmware(fe);
+	if (ret < 0)
 		goto err;
-	}
 
-skip_fw_download:
 	/* reboot the tuner with new firmware? */
 	memcpy(cmd.args, "\x01\x01", 2);
 	cmd.wlen = 2;
@@ -258,11 +280,6 @@ static int si2157_init(struct dvb_frontend *fe)
 	if (ret)
 		goto err;
 
-	if (warn_firmware_not_loaded) {
-		dev_warn(&client->dev, "firmware file '%s' not found. Using firmware from eeprom.\n",
-			 fw_name);
-		warn_firmware_not_loaded = false;
-	}
 	dev_info(&client->dev, "firmware version: %c.%c.%d\n",
 			cmd.args[6], cmd.args[7], cmd.args[8]);
 
@@ -298,11 +315,6 @@ static int si2157_init(struct dvb_frontend *fe)
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
@@ -968,3 +980,13 @@ MODULE_LICENSE("GPL");
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
index ef4796098931..0db21b082ba9 100644
--- a/drivers/media/tuners/si2157_priv.h
+++ b/drivers/media/tuners/si2157_priv.h
@@ -41,6 +41,23 @@ struct si2157_dev {
 
 };
 
+enum si2157_part_id {
+	SI2141 = 41,
+	SI2146 = 46,
+	SI2147 = 47,
+	SI2148 = 48,
+	SI2157 = 57,
+	SI2158 = 58,
+	SI2177 = 77,
+};
+
+struct si2157_tuner_info {
+	enum si2157_part_id	part_id;
+	unsigned char		rom_id;
+	bool			required;
+	const char		*fw_name, *fw_alt_name;
+};
+
 #define SI2157_CHIPTYPE_SI2157 0
 #define SI2157_CHIPTYPE_SI2146 1
 #define SI2157_CHIPTYPE_SI2141 2
@@ -54,7 +71,21 @@ struct si2157_cmd {
 	unsigned rlen;
 };
 
+/* Old firmware namespace */
 #define SI2158_A20_FIRMWARE "dvb-tuner-si2158-a20-01.fw"
 #define SI2141_A10_FIRMWARE "dvb-tuner-si2141-a10-01.fw"
 #define SI2157_A30_FIRMWARE "dvb-tuner-si2157-a30-01.fw"
+
+/* New firmware namespace */
+#define SI2141_60_FIRMWARE "dvb_driver_si2141_rom60.fw"
+#define SI2141_61_FIRMWARE "dvb_driver_si2141_rom61.fw"
+#define SI2146_11_FIRMWARE "dvb_driver_si2146_rom11.fw"
+#define SI2147_50_FIRMWARE "dvb_driver_si2147_rom50.fw"
+#define SI2148_32_FIRMWARE "dvb_driver_si2148_rom32.fw"
+#define SI2148_33_FIRMWARE "dvb_driver_si2148_rom33.fw"
+#define SI2157_50_FIRMWARE "dvb_driver_si2157_rom50.fw"
+#define SI2158_50_FIRMWARE "dvb_driver_si2178_rom50.fw"
+#define SI2158_51_FIRMWARE "dvb_driver_si2158_rom51.fw"
+#define SI2177_50_FIRMWARE "dvb_driver_si2177_rom50.fw"
+
 #endif
-- 
2.33.1

