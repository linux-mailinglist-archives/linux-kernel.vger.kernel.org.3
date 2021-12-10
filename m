Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C1946FC28
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 08:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237729AbhLJIAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 03:00:44 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:54460 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235454AbhLJIAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 03:00:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F3E31CE2A2C;
        Fri, 10 Dec 2021 07:57:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9760C341CA;
        Fri, 10 Dec 2021 07:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639123023;
        bh=iyhRVtN2E2di8t+lsSwTTzfRVzT0KnrO8XlPwFB3E1Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SJ/KnWfBPUdL+B0wxYewhlCdFzsksomo43bQhen87oAm9AEyy7rcX7q74qEvZ1rZ4
         zP67URv0q1NDKrx2SXlxGxmz2iTusm88tPIzLhDB2VUDKBRvTyrINGQ3xHqNILuZn0
         8Bd73uwPpLuRB/R7sXLOUa6gPXUkGjNGs4VPVgxiJiW9bMG0Ul852QoMLiC4K0GDBE
         KaGLtjXwNrtljDHMrREt16vkQ2dBgekRUNmjAzhbyFbg0PPmS5+SDCiQfAolS5KmUD
         /CGd6iKmAr0pfPV0y6yNz6f+038ltbIzjpWQZJWz+6FRkzOpQCs/jDT8smTUG9185z
         UAx467cc8aknQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mvam4-000BVe-T4; Fri, 10 Dec 2021 08:57:00 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Robert Schlabbach" <robert_s@gmx.net>,
        Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH v3 3/4] media: si2157: rework the firmware load logic
Date:   Fri, 10 Dec 2021 08:56:58 +0100
Message-Id: <4b3956d77835c22e2c2c342f6e30a408c956f558.1639120421.git.mchehab+huawei@kernel.org>
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

Loading a firmware file should not be mandatory, as devices
could work with an eeprom firmware, if available.

Yet, using the eeprom firmware could lead into unpredictable
results, so the best is to warn about that.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH v3 0/4] at: https://lore.kernel.org/all/cover.1639120421.git.mchehab+huawei@kernel.org/

 drivers/media/tuners/si2157.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/media/tuners/si2157.c b/drivers/media/tuners/si2157.c
index ed28672c060d..5f4ae8593864 100644
--- a/drivers/media/tuners/si2157.c
+++ b/drivers/media/tuners/si2157.c
@@ -129,8 +129,9 @@ static int si2157_init(struct dvb_frontend *fe)
 	struct dtv_frontend_properties *c = &fe->dtv_property_cache;
 	struct i2c_client *client = fe->tuner_priv;
 	struct si2157_dev *dev = i2c_get_clientdata(client);
+	bool warn_firmware_not_loaded = false;
 	unsigned int chip_id, xtal_trim;
-	unsigned int fw_required;
+	bool fw_required = true;
 	struct si2157_cmd cmd;
 	const char *fw_name;
 	int ret;
@@ -199,10 +200,6 @@ static int si2157_init(struct dvb_frontend *fe)
 	#define SI2146_A10 ('A' << 24 | 46 << 16 | '1' << 8 | '0' << 0)
 	#define SI2141_A10 ('A' << 24 | 41 << 16 | '1' << 8 | '0' << 0)
 
-	/* assume firmware is required, unless verified not to be */
-	/* only the SI2157_A30 has been verified not to yet */
-	fw_required = true;
-
 	switch (chip_id) {
 	case SI2158_A20:
 	case SI2148_A20:
@@ -212,9 +209,8 @@ static int si2157_init(struct dvb_frontend *fe)
 		fw_name = SI2141_A10_FIRMWARE;
 		break;
 	case SI2157_A30:
-		fw_name = SI2157_A30_FIRMWARE;
 		fw_required = false;
-		break;
+		fallthrough;
 	case SI2177_A30:
 		fw_name = SI2157_A30_FIRMWARE;
 		break;
@@ -237,12 +233,11 @@ static int si2157_init(struct dvb_frontend *fe)
 		goto skip_fw_download;
 
 	ret = si2157_load_firmware(fe, fw_name);
-	if (ret) {
-		if (!fw_required)
-			goto skip_fw_download;
-
-		dev_err(&client->dev, "firmware file '%s' not found\n",
-			fw_name);
+	if (fw_required && ret == -ENOENT)
+		warn_firmware_not_loaded = true;
+	else if (ret < 0) {
+		dev_err(&client->dev, "error %d when loading firmware file '%s'\n",
+			ret, fw_name);
 		goto err;
 	}
 
@@ -263,6 +258,11 @@ static int si2157_init(struct dvb_frontend *fe)
 	if (ret)
 		goto err;
 
+	if (warn_firmware_not_loaded) {
+		dev_warn(&client->dev, "firmware file '%s' not found. Using firmware from eeprom.\n",
+			 fw_name);
+		warn_firmware_not_loaded = false;
+	}
 	dev_info(&client->dev, "firmware version: %c.%c.%d\n",
 			cmd.args[6], cmd.args[7], cmd.args[8]);
 
@@ -298,6 +298,11 @@ static int si2157_init(struct dvb_frontend *fe)
 	return 0;
 
 err:
+	if (warn_firmware_not_loaded)
+		dev_err(&client->dev,
+			"firmware file '%s' not found. Can't continue without a firmware.\n",
+			fw_name);
+
 	dev_dbg(&client->dev, "failed=%d\n", ret);
 	return ret;
 }
-- 
2.33.1

