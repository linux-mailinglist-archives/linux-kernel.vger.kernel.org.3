Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0017449203E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 08:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245455AbiARH1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 02:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244864AbiARH0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 02:26:38 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5F0C061574;
        Mon, 17 Jan 2022 23:26:38 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id f8so13143142pgf.8;
        Mon, 17 Jan 2022 23:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vzFET2Y0lUKHdKshKTuEKMzUv5HlVgdjcJJcn/1bC04=;
        b=OeUpP4CeWl9U9kbR4FZp+tPxMAY4ogckXiNydU1cYbMrSgCLiq/+z/jOUBMhn+lUSK
         1ZJ1iMrCPKWNoBhnkMiPPeHlJeccEImCDrH8khiMKpLtEbJvtG19GbDAhTIGGmg92UJu
         ojh4fbvwpW/jBB29TP0kGxZ3nN4diSXwXmBRaJbGBy2M/D/UKTsKCIo3Ne0Z6PnINOQR
         Iq2NnA9Xnog6qbbuUHGVRNd8SinNGsL4smvLc7CHRFfoJMiFkW5qPHqmlo7hKtMsiWNV
         cHrJex3++s25wVSoosilGLIfCjg+Q0nV9cGNwBPe8VLZNkXr0+42wCeiNAyF0mh892j7
         BwIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vzFET2Y0lUKHdKshKTuEKMzUv5HlVgdjcJJcn/1bC04=;
        b=q+1/U+4ofdpZ+1r1Xt9k90k2Hc9cs6F5x85k/AHgh//L1hiKBdEO2wM8q5FauO1V1W
         MELs5BPibkTYJEifrMOQRFe9dIsmxjuJWTlgEoMBZf4Q2JLXl+3xEt6hxxtAnHX7cQ8o
         a55E+VMeQNKc7qLREuii10NZ5HJY5ulo0VetdtMrv+nMAOpquQ5cW6NzSArCIOfVO0r1
         Rst5SrwUP64kiSuA2vKwLgXF/gyzFrbC8ErF5h9TI+gjyeIvARiopUZC1MIgUxNLoJEj
         3iEmkouleBPwIvuW/RfNYbP1LJzutRo3y6yAqEd2e9mw1ccWfuFBKmQqKdy68weqp8FP
         +MsQ==
X-Gm-Message-State: AOAM533jr82iebQqN0XGCDu+phxxL7aOx/qXAOM412t0meHISctMQsDm
        WM5Q9OlwlHuABF5CAwbLMZZMFH8g8Rk=
X-Google-Smtp-Source: ABdhPJzdt1aGugShvdV7GUkM2IIA6QRZ+IY+3HnmK7atesh8lmRnG/6Bl6nWh51f5XGbNqL/W8MzYA==
X-Received: by 2002:a63:864a:: with SMTP id x71mr8332724pgd.618.1642490797916;
        Mon, 17 Jan 2022 23:26:37 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:bf2e:59:5029:f4c5])
        by smtp.gmail.com with ESMTPSA id y18sm11079816pfl.156.2022.01.17.23.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 23:26:36 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Angela Czubak <acz@semihalf.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/12] HID: i2c-hid: refactor reset command
Date:   Mon, 17 Jan 2022 23:26:20 -0800
Message-Id: <20220118072628.1617172-5-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
In-Reply-To: <20220118072628.1617172-1-dmitry.torokhov@gmail.com>
References: <20220118072628.1617172-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Reset" is the only command that needs to wait for interrupt from
the device before continuing, so let's factor our waiting logic from
__i2c_hid_command() to make it simpler.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/i2c-hid/i2c-hid-core.c | 63 ++++++++++++++++++------------
 1 file changed, 38 insertions(+), 25 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index bae3e7a9b2e4..6c1741d9211d 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -88,7 +88,6 @@ struct i2c_hid_cmd {
 	unsigned int registerIndex;
 	__u8 opcode;
 	unsigned int length;
-	bool wait;
 };
 
 union command {
@@ -114,8 +113,7 @@ static const struct i2c_hid_cmd hid_report_descr_cmd = {
 		.opcode = 0x00,
 		.length = 2 };
 /* commands */
-static const struct i2c_hid_cmd hid_reset_cmd =		{ I2C_HID_CMD(0x01),
-							  .wait = true };
+static const struct i2c_hid_cmd hid_reset_cmd =		{ I2C_HID_CMD(0x01) };
 static const struct i2c_hid_cmd hid_get_report_cmd =	{ I2C_HID_CMD(0x02) };
 static const struct i2c_hid_cmd hid_set_report_cmd =	{ I2C_HID_CMD(0x03) };
 static const struct i2c_hid_cmd hid_set_power_cmd =	{ I2C_HID_CMD(0x08) };
@@ -220,7 +218,6 @@ static int __i2c_hid_command(struct i2c_hid *ihid,
 	int msg_num = 1;
 
 	int length = command->length;
-	bool wait = command->wait;
 	unsigned int registerIndex = command->registerIndex;
 
 	/* special case for hid_descr_cmd */
@@ -261,9 +258,6 @@ static int __i2c_hid_command(struct i2c_hid *ihid,
 		set_bit(I2C_HID_READ_PENDING, &ihid->flags);
 	}
 
-	if (wait)
-		set_bit(I2C_HID_RESET_PENDING, &ihid->flags);
-
 	ret = i2c_transfer(client->adapter, msg, msg_num);
 
 	if (data_len > 0)
@@ -272,20 +266,7 @@ static int __i2c_hid_command(struct i2c_hid *ihid,
 	if (ret != msg_num)
 		return ret < 0 ? ret : -EIO;
 
-	ret = 0;
-
-	if (wait && (ihid->quirks & I2C_HID_QUIRK_NO_IRQ_AFTER_RESET)) {
-		msleep(100);
-	} else if (wait) {
-		i2c_hid_dbg(ihid, "%s: waiting...\n", __func__);
-		if (!wait_event_timeout(ihid->wait,
-				!test_bit(I2C_HID_RESET_PENDING, &ihid->flags),
-				msecs_to_jiffies(5000)))
-			ret = -ENODATA;
-		i2c_hid_dbg(ihid, "%s: finished.\n", __func__);
-	}
-
-	return ret;
+	return 0;
 }
 
 static int i2c_hid_command(struct i2c_hid *ihid,
@@ -432,6 +413,39 @@ static int i2c_hid_set_power(struct i2c_hid *ihid, int power_state)
 	return ret;
 }
 
+static int i2c_hid_execute_reset(struct i2c_hid *ihid)
+{
+	int ret;
+
+	i2c_hid_dbg(ihid, "resetting...\n");
+
+	set_bit(I2C_HID_RESET_PENDING, &ihid->flags);
+
+	ret = i2c_hid_command(ihid, &hid_reset_cmd, NULL, 0);
+	if (ret) {
+		dev_err(&ihid->client->dev, "failed to reset device.\n");
+		goto out;
+	}
+
+	if (ihid->quirks & I2C_HID_QUIRK_NO_IRQ_AFTER_RESET) {
+		msleep(100);
+		goto out;
+	}
+
+	i2c_hid_dbg(ihid, "%s: waiting...\n", __func__);
+	if (!wait_event_timeout(ihid->wait,
+				!test_bit(I2C_HID_RESET_PENDING, &ihid->flags),
+				msecs_to_jiffies(5000))) {
+		ret = -ENODATA;
+		goto out;
+	}
+	i2c_hid_dbg(ihid, "%s: finished.\n", __func__);
+
+out:
+	clear_bit(I2C_HID_RESET_PENDING, &ihid->flags);
+	return ret;
+}
+
 static int i2c_hid_hwreset(struct i2c_hid *ihid)
 {
 	int ret;
@@ -449,11 +463,10 @@ static int i2c_hid_hwreset(struct i2c_hid *ihid)
 	if (ret)
 		goto out_unlock;
 
-	i2c_hid_dbg(ihid, "resetting...\n");
-
-	ret = i2c_hid_command(ihid, &hid_reset_cmd, NULL, 0);
+	ret = i2c_hid_execute_reset(ihid);
 	if (ret) {
-		dev_err(&ihid->client->dev, "failed to reset device.\n");
+		dev_err(&ihid->client->dev,
+			"failed to reset device: %d\n", ret);
 		i2c_hid_set_power(ihid, I2C_HID_PWR_SLEEP);
 		goto out_unlock;
 	}
-- 
2.34.1.703.g22d0c6ccf7-goog

