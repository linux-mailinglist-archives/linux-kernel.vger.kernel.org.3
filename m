Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC9246D0B4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 11:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbhLHKRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 05:17:08 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:34622 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhLHKRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 05:17:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5F372CE2083;
        Wed,  8 Dec 2021 10:13:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A7A0C341C3;
        Wed,  8 Dec 2021 10:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638958410;
        bh=gVDD9vxvrZRD/msQTATqPEXonDeRcO8qqBMYYxq2Q3U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P7NOVIg1hcFQws1nX8o4BOipWNX4+Go+WC553zjJlylfIa5dFiVjztgCQjQ98vM+J
         o8nvn9R/SUOAN5tLyhWMtqg7Z7eNj++OqA1rmlMOR+xISGfZ8tw8cvMX/q9mQtWctJ
         ULw30LTBqqXoR79YWR8IFctz4qBRGygQjrCNnJ2Vvxe0/8vOl2NMYsZZV12RjkKV36
         M1S9GLIAji9quFcmgI7wwmjZKiwlr0kFCISGYHjfZ7Vbi5R7i/S1OblDCINj+Vo+bc
         zPJezMWj2MuvkotsOVV9Wivtk924U9EXGfuI0CHKyhWCPT4/LelJWRJZWfMX8SI1Cc
         ky448O9r5i+RQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mutx2-00BgVH-DI; Wed, 08 Dec 2021 11:13:28 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Robert Schlabbach" <robert_s@gmx.net>,
        Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 1/3] media: si2157: move firmware load to a separate function
Date:   Wed,  8 Dec 2021 11:13:24 +0100
Message-Id: <dc8d0be6a9756bf65371e2e1e0a8062df74f0e5f.1638958050.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1638958050.git.mchehab+huawei@kernel.org>
References: <cover.1638958050.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split the firmware load code from si2157_init, in order to
help to add further changes at the way firmware is handled on
this device.

No functional changes.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 0/3] at: https://lore.kernel.org/all/cover.1638958050.git.mchehab+huawei@kernel.org/

 drivers/media/tuners/si2157.c | 98 ++++++++++++++++++++---------------
 1 file changed, 56 insertions(+), 42 deletions(-)

diff --git a/drivers/media/tuners/si2157.c b/drivers/media/tuners/si2157.c
index 75ddf7ed1faf..481a5db7fb69 100644
--- a/drivers/media/tuners/si2157.c
+++ b/drivers/media/tuners/si2157.c
@@ -76,16 +76,63 @@ static int si2157_cmd_execute(struct i2c_client *client, struct si2157_cmd *cmd)
 	return ret;
 }
 
-static int si2157_init(struct dvb_frontend *fe)
+static int si2157_load_firmware(struct dvb_frontend *fe,
+				const char *fw_name)
 {
 	struct i2c_client *client = fe->tuner_priv;
-	struct si2157_dev *dev = i2c_get_clientdata(client);
-	struct dtv_frontend_properties *c = &fe->dtv_property_cache;
-	int ret, len, remaining;
-	struct si2157_cmd cmd;
 	const struct firmware *fw;
-	const char *fw_name;
+	int ret, len, remaining;
+	struct si2157_cmd cmd;
+
+	/* request the firmware, this will block and timeout */
+	ret = request_firmware(&fw, fw_name, &client->dev);
+	if (ret)
+		return ret;
+
+	/* firmware should be n chunks of 17 bytes */
+	if (fw->size % 17 != 0) {
+		dev_err(&client->dev, "firmware file '%s' is invalid\n",
+			fw_name);
+		ret = -EINVAL;
+		goto err_release_firmware;
+	}
+
+	dev_info(&client->dev, "downloading firmware from file '%s'\n",
+		 fw_name);
+
+	for (remaining = fw->size; remaining > 0; remaining -= 17) {
+		len = fw->data[fw->size - remaining];
+		if (len > SI2157_ARGLEN) {
+			dev_err(&client->dev, "Bad firmware length\n");
+			ret = -EINVAL;
+			goto err_release_firmware;
+		}
+		memcpy(cmd.args, &fw->data[(fw->size - remaining) + 1], len);
+		cmd.wlen = len;
+		cmd.rlen = 1;
+		ret = si2157_cmd_execute(client, &cmd);
+		if (ret) {
+			dev_err(&client->dev, "firmware download failed %d\n",
+					ret);
+			goto err_release_firmware;
+		}
+	}
+
+err_release_firmware:
+	release_firmware(fw);
+
+	return ret;
+}
+
+static int si2157_init(struct dvb_frontend *fe)
+{
+	struct dtv_frontend_properties *c = &fe->dtv_property_cache;
+	struct i2c_client *client = fe->tuner_priv;
+	struct si2157_dev *dev = i2c_get_clientdata(client);
 	unsigned int chip_id, xtal_trim;
+	struct si2157_cmd cmd;
+	const char *fw_name;
+	int ret;
 
 	dev_dbg(&client->dev, "\n");
 
@@ -181,45 +228,13 @@ static int si2157_init(struct dvb_frontend *fe)
 	if (fw_name == NULL)
 		goto skip_fw_download;
 
-	/* request the firmware, this will block and timeout */
-	ret = request_firmware(&fw, fw_name, &client->dev);
+	ret = si2157_load_firmware(fe, fw_name);
 	if (ret) {
 		dev_err(&client->dev, "firmware file '%s' not found\n",
-				fw_name);
-		goto err;
-	}
-
-	/* firmware should be n chunks of 17 bytes */
-	if (fw->size % 17 != 0) {
-		dev_err(&client->dev, "firmware file '%s' is invalid\n",
-				fw_name);
-		ret = -EINVAL;
-		goto err_release_firmware;
-	}
-
-	dev_info(&client->dev, "downloading firmware from file '%s'\n",
 			fw_name);
-
-	for (remaining = fw->size; remaining > 0; remaining -= 17) {
-		len = fw->data[fw->size - remaining];
-		if (len > SI2157_ARGLEN) {
-			dev_err(&client->dev, "Bad firmware length\n");
-			ret = -EINVAL;
-			goto err_release_firmware;
-		}
-		memcpy(cmd.args, &fw->data[(fw->size - remaining) + 1], len);
-		cmd.wlen = len;
-		cmd.rlen = 1;
-		ret = si2157_cmd_execute(client, &cmd);
-		if (ret) {
-			dev_err(&client->dev, "firmware download failed %d\n",
-					ret);
-			goto err_release_firmware;
-		}
+		goto err;
 	}
 
-	release_firmware(fw);
-
 skip_fw_download:
 	/* reboot the tuner with new firmware? */
 	memcpy(cmd.args, "\x01\x01", 2);
@@ -270,8 +285,7 @@ static int si2157_init(struct dvb_frontend *fe)
 
 	dev->active = true;
 	return 0;
-err_release_firmware:
-	release_firmware(fw);
+
 err:
 	dev_dbg(&client->dev, "failed=%d\n", ret);
 	return ret;
-- 
2.33.1

