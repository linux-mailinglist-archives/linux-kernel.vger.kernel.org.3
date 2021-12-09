Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8148346E7B5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 12:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236873AbhLILou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 06:44:50 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:49126 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235410AbhLILoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 06:44:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E835DCE25AC;
        Thu,  9 Dec 2021 11:41:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071D9C341C8;
        Thu,  9 Dec 2021 11:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639050070;
        bh=nS4NbdcZZQknQAUdObfE4yZuAA5dQDGhf8ckIq7I0Ss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XAKXSYLxhwoWO/fNsExAt8oZam96PmPwEFIz6NJ7ugaeVscXyWFouLIC6HlOZhhYt
         eo8NBzDq+ozprFlE2snZeSukD1UWRTAaT21U02e6DwKbvkrvakg9tTlvsmTstwTTJr
         QSQX+Ge7H10baRvE0+GbjlA3//5sneCz1ZUxyHhwGO+9fApANbfF6inlVIjiCUj81p
         cKq7cd3JZ91KKo+ON5V4gbbyTheklMxISwlZR410KTc4NpV4o430qZOPjsoK+SxCk2
         qVMFKTI5pIe9EazMPKAHN76nXI7f+kNT/xKi6nIfEHE8vLpaKj/JrnBg07DzUt04KX
         x45I/5zZ43+GA==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mvHnP-00BuPE-Vn; Thu, 09 Dec 2021 12:41:07 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH v2 3/4] media: si2157: rework the firmware load logic
Date:   Thu,  9 Dec 2021 12:41:06 +0100
Message-Id: <4b3956d77835c22e2c2c342f6e30a408c956f558.1639049865.git.mchehab+huawei@kernel.org>
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

Loading a firmware file should not be mandatory, as devices
could work with an eeprom firmware, if available.

Yet, using the eeprom firmware could lead into unpredictable
results, so the best is to warn about that.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH v2 0/4] at: https://lore.kernel.org/all/cover.1639049865.git.mchehab+huawei@kernel.org/

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

