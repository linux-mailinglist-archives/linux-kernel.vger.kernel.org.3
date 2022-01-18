Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8A249203C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 08:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245338AbiARH06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 02:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244677AbiARH0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 02:26:37 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C66C061574;
        Mon, 17 Jan 2022 23:26:36 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id x83so13127365pgx.4;
        Mon, 17 Jan 2022 23:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ES83obJErk0lZ4kelhdPyHXgtGt2UP7T+Eb9i5keaTM=;
        b=Dof1I0AksaKXl49yzZAExVWINZ4MxevKOcEeLwdD2dE/gECkf8YV+E24U/LyroD5kK
         pXwQz+F2yWZITKUZn0xafEOhs0MbvYnLQKOQ0XbmqyL3q9Kcvkwi63Ni1uzC0EXlEFnL
         qv8YECHIcW5R4rwZUV6qqsN07vvrEJUMcqzCINd+6i42zrh7Rqirr+1i3z1nOqZZ9QaW
         myNRdfGwzSLk/bRsYXouXgNZkxdSltiRdhpHBvCo6PgeV/WvGre8PYHy+eI2qDwSE0ao
         RSh24CPa3wPnsuEETTCnqBrXdcRXcAbyFx1s/ZHoVCAzOGX7dUpc99dVdl3ZfDlaJ93v
         fV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ES83obJErk0lZ4kelhdPyHXgtGt2UP7T+Eb9i5keaTM=;
        b=0lmI4SwNpBWQBmGMyQwi2IT2HP/bj0aSYfiGZms2ePxms6Ehc4e/OjuR24DCXgDhYr
         Jd6Xgn4mnMzscGzixcLVxQaE22ffp8Yr9GIyGFdIGTrWqvfPQk7dhLbNqEpUG9WEWYvv
         +49YgLiaAfqIHinADaWJSctey48lPMlO8f7xztsf6j5OGqWlDhGWY2JIk7w83V2UKD2C
         ZOxumTTTra22NT50vzjtGhAZhmss2OiKyeUdf5m25KyVgM/nzdMiFg+5AVSEQFe6s8d7
         WKtniT6kRs/MBIdPb7TaSb3uXW+85U1pwrRg0dTjR4scgMZTSIn+PpB6GXR6xhq6CbCD
         QfwQ==
X-Gm-Message-State: AOAM533E16Ppf9nJIpniwHJljJZ5kd5cglg5YZmpouajCF26i5wTDkdb
        YiW+sSMF6DEU16dfc+y3GwU=
X-Google-Smtp-Source: ABdhPJymuOUypPqjMMF/NOLafAl1UOlyqABEc3f57QAFEh5XJVlNnxaTYWSoD+d3uKT51lpzk2IzLw==
X-Received: by 2002:a65:6859:: with SMTP id q25mr18771789pgt.452.1642490796350;
        Mon, 17 Jan 2022 23:26:36 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:bf2e:59:5029:f4c5])
        by smtp.gmail.com with ESMTPSA id y18sm11079816pfl.156.2022.01.17.23.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 23:26:35 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Angela Czubak <acz@semihalf.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/12] HID: i2c-hid: use "struct i2c_hid" as argument in most calls
Date:   Mon, 17 Jan 2022 23:26:19 -0800
Message-Id: <20220118072628.1617172-4-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
In-Reply-To: <20220118072628.1617172-1-dmitry.torokhov@gmail.com>
References: <20220118072628.1617172-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main object in the driver is struct i2c_hid so it makes more sense
to pass it around instead of passing i2c_client and then fetching
i2c_hid associated with it.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/i2c-hid/i2c-hid-core.c | 75 ++++++++++++++----------------
 1 file changed, 36 insertions(+), 39 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index b383003ff676..bae3e7a9b2e4 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -208,12 +208,12 @@ static u32 i2c_hid_lookup_quirk(const u16 idVendor, const u16 idProduct)
 	return quirks;
 }
 
-static int __i2c_hid_command(struct i2c_client *client,
+static int __i2c_hid_command(struct i2c_hid *ihid,
 		const struct i2c_hid_cmd *command, u8 reportID,
 		u8 reportType, u8 *args, int args_len,
 		unsigned char *buf_recv, int data_len)
 {
-	struct i2c_hid *ihid = i2c_get_clientdata(client);
+	struct i2c_client *client = ihid->client;
 	union command *cmd = (union command *)ihid->cmdbuf;
 	int ret;
 	struct i2c_msg msg[2];
@@ -288,18 +288,17 @@ static int __i2c_hid_command(struct i2c_client *client,
 	return ret;
 }
 
-static int i2c_hid_command(struct i2c_client *client,
+static int i2c_hid_command(struct i2c_hid *ihid,
 		const struct i2c_hid_cmd *command,
 		unsigned char *buf_recv, int data_len)
 {
-	return __i2c_hid_command(client, command, 0, 0, NULL, 0,
+	return __i2c_hid_command(ihid, command, 0, 0, NULL, 0,
 				buf_recv, data_len);
 }
 
-static int i2c_hid_get_report(struct i2c_client *client, u8 reportType,
+static int i2c_hid_get_report(struct i2c_hid *ihid, u8 reportType,
 		u8 reportID, unsigned char *buf_recv, int data_len)
 {
-	struct i2c_hid *ihid = i2c_get_clientdata(client);
 	u8 args[2];
 	int ret;
 	int args_len = 0;
@@ -310,10 +309,10 @@ static int i2c_hid_get_report(struct i2c_client *client, u8 reportType,
 	args[args_len++] = readRegister & 0xFF;
 	args[args_len++] = readRegister >> 8;
 
-	ret = __i2c_hid_command(client, &hid_get_report_cmd, reportID,
+	ret = __i2c_hid_command(ihid, &hid_get_report_cmd, reportID,
 		reportType, args, args_len, buf_recv, data_len);
 	if (ret) {
-		dev_err(&client->dev,
+		dev_err(&ihid->client->dev,
 			"failed to retrieve report from device.\n");
 		return ret;
 	}
@@ -323,17 +322,16 @@ static int i2c_hid_get_report(struct i2c_client *client, u8 reportType,
 
 /**
  * i2c_hid_set_or_send_report: forward an incoming report to the device
- * @client: the i2c_client of the device
+ * @ihid: the i2c hid device
  * @reportType: 0x03 for HID_FEATURE_REPORT ; 0x02 for HID_OUTPUT_REPORT
  * @reportID: the report ID
  * @buf: the actual data to transfer, without the report ID
  * @data_len: size of buf
  * @use_data: true: use SET_REPORT HID command, false: send plain OUTPUT report
  */
-static int i2c_hid_set_or_send_report(struct i2c_client *client, u8 reportType,
+static int i2c_hid_set_or_send_report(struct i2c_hid *ihid, u8 reportType,
 		u8 reportID, unsigned char *buf, size_t data_len, bool use_data)
 {
-	struct i2c_hid *ihid = i2c_get_clientdata(client);
 	u8 *args = ihid->argsbuf;
 	const struct i2c_hid_cmd *hidcmd;
 	int ret;
@@ -380,19 +378,19 @@ static int i2c_hid_set_or_send_report(struct i2c_client *client, u8 reportType,
 
 	memcpy(&args[index], buf, data_len);
 
-	ret = __i2c_hid_command(client, hidcmd, reportID,
+	ret = __i2c_hid_command(ihid, hidcmd, reportID,
 		reportType, args, args_len, NULL, 0);
 	if (ret) {
-		dev_err(&client->dev, "failed to set a report to device.\n");
+		dev_err(&ihid->client->dev,
+			"failed to set a report to device.\n");
 		return ret;
 	}
 
 	return data_len;
 }
 
-static int i2c_hid_set_power(struct i2c_client *client, int power_state)
+static int i2c_hid_set_power(struct i2c_hid *ihid, int power_state)
 {
-	struct i2c_hid *ihid = i2c_get_clientdata(client);
 	int ret;
 
 	i2c_hid_dbg(ihid, "%s\n", __func__);
@@ -404,18 +402,18 @@ static int i2c_hid_set_power(struct i2c_client *client, int power_state)
 	 */
 	if (power_state == I2C_HID_PWR_ON &&
 	    ihid->quirks & I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV) {
-		ret = i2c_hid_command(client, &hid_set_power_cmd, NULL, 0);
+		ret = i2c_hid_command(ihid, &hid_set_power_cmd, NULL, 0);
 
 		/* Device was already activated */
 		if (!ret)
 			goto set_pwr_exit;
 	}
 
-	ret = __i2c_hid_command(client, &hid_set_power_cmd, power_state,
+	ret = __i2c_hid_command(ihid, &hid_set_power_cmd, power_state,
 		0, NULL, 0, NULL, 0);
-
 	if (ret)
-		dev_err(&client->dev, "failed to change power setting.\n");
+		dev_err(&ihid->client->dev,
+			"failed to change power setting.\n");
 
 set_pwr_exit:
 
@@ -434,9 +432,8 @@ static int i2c_hid_set_power(struct i2c_client *client, int power_state)
 	return ret;
 }
 
-static int i2c_hid_hwreset(struct i2c_client *client)
+static int i2c_hid_hwreset(struct i2c_hid *ihid)
 {
-	struct i2c_hid *ihid = i2c_get_clientdata(client);
 	int ret;
 
 	i2c_hid_dbg(ihid, "%s\n", __func__);
@@ -448,22 +445,22 @@ static int i2c_hid_hwreset(struct i2c_client *client)
 	 */
 	mutex_lock(&ihid->reset_lock);
 
-	ret = i2c_hid_set_power(client, I2C_HID_PWR_ON);
+	ret = i2c_hid_set_power(ihid, I2C_HID_PWR_ON);
 	if (ret)
 		goto out_unlock;
 
 	i2c_hid_dbg(ihid, "resetting...\n");
 
-	ret = i2c_hid_command(client, &hid_reset_cmd, NULL, 0);
+	ret = i2c_hid_command(ihid, &hid_reset_cmd, NULL, 0);
 	if (ret) {
-		dev_err(&client->dev, "failed to reset device.\n");
-		i2c_hid_set_power(client, I2C_HID_PWR_SLEEP);
+		dev_err(&ihid->client->dev, "failed to reset device.\n");
+		i2c_hid_set_power(ihid, I2C_HID_PWR_SLEEP);
 		goto out_unlock;
 	}
 
 	/* At least some SIS devices need this after reset */
 	if (!(ihid->quirks & I2C_HID_QUIRK_NO_WAKEUP_AFTER_RESET))
-		ret = i2c_hid_set_power(client, I2C_HID_PWR_ON);
+		ret = i2c_hid_set_power(ihid, I2C_HID_PWR_ON);
 
 out_unlock:
 	mutex_unlock(&ihid->reset_lock);
@@ -625,7 +622,7 @@ static int i2c_hid_get_raw_report(struct hid_device *hid,
 	/* +2 bytes to include the size of the reply in the query buffer */
 	ask_count = min(count + 2, (size_t)ihid->bufsize);
 
-	ret = i2c_hid_get_report(client,
+	ret = i2c_hid_get_report(ihid,
 			report_type == HID_FEATURE_REPORT ? 0x03 : 0x01,
 			report_number, ihid->rawbuf, ask_count);
 
@@ -669,7 +666,7 @@ static int i2c_hid_output_raw_report(struct hid_device *hid, __u8 *buf,
 	 * to i2c_hid_set_or_send_report which takes care of encoding
 	 * everything properly.
 	 */
-	ret = i2c_hid_set_or_send_report(client,
+	ret = i2c_hid_set_or_send_report(ihid,
 				report_type == HID_FEATURE_REPORT ? 0x03 : 0x02,
 				report_id, buf + 1, count - 1, use_data);
 
@@ -724,7 +721,7 @@ static int i2c_hid_parse(struct hid_device *hid)
 	}
 
 	do {
-		ret = i2c_hid_hwreset(client);
+		ret = i2c_hid_hwreset(ihid);
 		if (ret)
 			msleep(1000);
 	} while (tries-- > 0 && ret);
@@ -748,7 +745,7 @@ static int i2c_hid_parse(struct hid_device *hid)
 
 		i2c_hid_dbg(ihid, "asking HID report descriptor\n");
 
-		ret = i2c_hid_command(client, &hid_report_descr_cmd,
+		ret = i2c_hid_command(ihid, &hid_report_descr_cmd,
 				      rdesc, rsize);
 		if (ret) {
 			hid_err(hid, "reading report descriptor failed\n");
@@ -868,11 +865,11 @@ static int i2c_hid_fetch_hid_descriptor(struct i2c_hid *ihid)
 			*i2c_hid_get_dmi_i2c_hid_desc_override(client->name);
 	} else {
 		i2c_hid_dbg(ihid, "Fetching the HID descriptor\n");
-		ret = i2c_hid_command(client, &hid_descr_cmd,
+		ret = i2c_hid_command(ihid, &hid_descr_cmd,
 				      ihid->hdesc_buffer,
 				      sizeof(struct i2c_hid_desc));
 		if (ret) {
-			dev_err(&client->dev, "hid_descr_cmd failed\n");
+			dev_err(&ihid->client->dev, "hid_descr_cmd failed\n");
 			return -ENODEV;
 		}
 	}
@@ -882,7 +879,7 @@ static int i2c_hid_fetch_hid_descriptor(struct i2c_hid *ihid)
 	 * bytes 2-3 -> bcdVersion (has to be 1.00) */
 	/* check bcdVersion == 1.0 */
 	if (le16_to_cpu(hdesc->bcdVersion) != 0x0100) {
-		dev_err(&client->dev,
+		dev_err(&ihid->client->dev,
 			"unexpected HID descriptor bcdVersion (0x%04hx)\n",
 			le16_to_cpu(hdesc->bcdVersion));
 		return -ENODEV;
@@ -891,8 +888,8 @@ static int i2c_hid_fetch_hid_descriptor(struct i2c_hid *ihid)
 	/* Descriptor length should be 30 bytes as per the specification */
 	dsize = le16_to_cpu(hdesc->wHIDDescLength);
 	if (dsize != sizeof(struct i2c_hid_desc)) {
-		dev_err(&client->dev, "weird size of HID descriptor (%u)\n",
-			dsize);
+		dev_err(&ihid->client->dev,
+			"weird size of HID descriptor (%u)\n", dsize);
 		return -ENODEV;
 	}
 	i2c_hid_dbg(ihid, "HID Descriptor: %*ph\n", dsize, ihid->hdesc_buffer);
@@ -1059,7 +1056,7 @@ void i2c_hid_core_shutdown(struct i2c_client *client)
 {
 	struct i2c_hid *ihid = i2c_get_clientdata(client);
 
-	i2c_hid_set_power(client, I2C_HID_PWR_SLEEP);
+	i2c_hid_set_power(ihid, I2C_HID_PWR_SLEEP);
 	free_irq(client->irq, ihid);
 
 	i2c_hid_core_shutdown_tail(ihid);
@@ -1082,7 +1079,7 @@ static int i2c_hid_core_suspend(struct device *dev)
 	}
 
 	/* Save some power */
-	i2c_hid_set_power(client, I2C_HID_PWR_SLEEP);
+	i2c_hid_set_power(ihid, I2C_HID_PWR_SLEEP);
 
 	disable_irq(client->irq);
 
@@ -1130,9 +1127,9 @@ static int i2c_hid_core_resume(struct device *dev)
 	 * let's still reset them here.
 	 */
 	if (ihid->quirks & I2C_HID_QUIRK_RESET_ON_RESUME)
-		ret = i2c_hid_hwreset(client);
+		ret = i2c_hid_hwreset(ihid);
 	else
-		ret = i2c_hid_set_power(client, I2C_HID_PWR_ON);
+		ret = i2c_hid_set_power(ihid, I2C_HID_PWR_ON);
 
 	if (ret)
 		return ret;
-- 
2.34.1.703.g22d0c6ccf7-goog

