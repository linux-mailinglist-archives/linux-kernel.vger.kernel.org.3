Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA48749204F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 08:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245003AbiARH1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 02:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245414AbiARH1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 02:27:05 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833B8C061755;
        Mon, 17 Jan 2022 23:26:46 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id i17so12301368pfk.11;
        Mon, 17 Jan 2022 23:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NshJlE4fbQHE7g31yBf1Bf/x2G6pGiGg+SM9MONafno=;
        b=DoeAfJgfEOOlwisvdc5WFl1pMOl9L2Wpvx+nmurtEu0Bn0RxUk7KHaYPn8HONZV2/w
         BfseDLL3gVFVgiKcd2h/tvGEHyM+u0bzEGFEx7WAzRbxE88Bl55ytRXQqO4biSb+dc3z
         nup2PTCU7GQ5kyo0UbQ4IStnAy5D5n8XsT7XsOg+SSg0KSCrshXIrBlaK/r6jS3TEqP/
         oYgGAZKowVX3Rjy4wa8vkG3StjTlBFJNiwIMRVEm0c74wne0LL9nB/nIbyUOu7joQw+X
         q6XWNJq08dycDw7I/MvtyshxWTAq47uEVawHyyHOl8wJx9MMuI/EGIlY9yyzzg8hKyfU
         EmQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NshJlE4fbQHE7g31yBf1Bf/x2G6pGiGg+SM9MONafno=;
        b=hLyJGV5BV7v91hTBK2niCM/wxKoQI+Zk9SH9U0bwcBtzNp/zhbVXuflJRwC5PXmD5O
         Aq0nGMVvNC4tUGkMC/ZsenRA9NtrE89aS9UkuX8Cj9ryi+PPAHhSWVvTRHCZh0MwdA2u
         oBGYfhJZ4akSbg2JsR+oSUkJEIxuIDhznsF2rdLXxXksFXHYG7pHCxc10iFgDrRQ3wNX
         wjHMpAF1P6BeWXmpZ5wAFhZlt7pZUS7AdHo4gj5X2KVnDb3K4LQ/KIPv8n3QXpbqDxjc
         It8gSytq0FHZbYgzemlQqLEvkL9nP+wc29UuxIoWnB69/uf7p2D6x/oXM9Fe6S8xxhhJ
         Fdnw==
X-Gm-Message-State: AOAM533JmT1VWJOKfBCzjyedqA40Sdj/lu3AMSEPTiFLbOu7amZSK5zP
        ArweT0aJhdPK5rpT7g3DW3E=
X-Google-Smtp-Source: ABdhPJyRY0j3v5h0gMb2ouP6F3Fqv+k/gqBodjtKLEk5TvrXajU1Vg9I6BQxypgv3Lhb10aG7J8BDw==
X-Received: by 2002:a63:be0a:: with SMTP id l10mr22316301pgf.542.1642490805914;
        Mon, 17 Jan 2022 23:26:45 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:bf2e:59:5029:f4c5])
        by smtp.gmail.com with ESMTPSA id y18sm11079816pfl.156.2022.01.17.23.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 23:26:44 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Angela Czubak <acz@semihalf.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/12] HID: i2c-hid: rework i2c_hid_get_report() to use i2c_hid_xfer()
Date:   Mon, 17 Jan 2022 23:26:25 -0800
Message-Id: <20220118072628.1617172-10-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
In-Reply-To: <20220118072628.1617172-1-dmitry.torokhov@gmail.com>
References: <20220118072628.1617172-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explicitly prepare command for i2c_hid_get_report() which makes the logic
clearer and allows us to get rid of __i2c_hid_command() and related command
definitions.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/i2c-hid/i2c-hid-core.c | 150 ++++++++++++-----------------
 1 file changed, 59 insertions(+), 91 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 1515fc892e61..433b6692f277 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -94,29 +94,6 @@ struct i2c_hid_desc {
 	__le32 reserved;
 } __packed;
 
-struct i2c_hid_cmd {
-	unsigned int registerIndex;
-	__u8 opcode;
-	unsigned int length;
-};
-
-#define I2C_HID_CMD(opcode_) \
-	.opcode = opcode_, .length = 4, \
-	.registerIndex = offsetof(struct i2c_hid_desc, wCommandRegister)
-
-/* commands */
-static const struct i2c_hid_cmd hid_get_report_cmd =	{ I2C_HID_CMD(0x02) };
-
-/*
- * These definitions are not used here, but are defined by the spec.
- * Keeping them here for documentation purposes.
- *
- * static const struct i2c_hid_cmd hid_get_idle_cmd = { I2C_HID_CMD(0x04) };
- * static const struct i2c_hid_cmd hid_set_idle_cmd = { I2C_HID_CMD(0x05) };
- * static const struct i2c_hid_cmd hid_get_protocol_cmd = { I2C_HID_CMD(0x06) };
- * static const struct i2c_hid_cmd hid_set_protocol_cmd = { I2C_HID_CMD(0x07) };
- */
-
 /* The main device structure */
 struct i2c_hid {
 	struct i2c_client	*client;	/* i2c client */
@@ -258,52 +235,62 @@ static size_t i2c_hid_encode_command(u8 *buf, u8 opcode,
 	return length;
 }
 
-static int __i2c_hid_command(struct i2c_hid *ihid,
-		const struct i2c_hid_cmd *command, u8 reportID,
-		u8 reportType, u8 *args, int args_len,
-		unsigned char *buf_recv, int data_len)
+static int i2c_hid_get_report(struct i2c_hid *ihid,
+			      u8 report_type, u8 report_id,
+			      u8 *recv_buf, size_t recv_len)
 {
-	int length = command->length;
-	unsigned int registerIndex = command->registerIndex;
-
-	ihid->cmdbuf[0] = ihid->hdesc_buffer[registerIndex];
-	ihid->cmdbuf[1] = ihid->hdesc_buffer[registerIndex + 1];
+	size_t length = 0;
+	size_t ret_count;
+	int error;
 
-	if (length > 2) {
-		length = sizeof(__le16) + /* register */
-			 i2c_hid_encode_command(ihid->cmdbuf + sizeof(__le16),
-						command->opcode,
-						reportType, reportID);
-	}
+	i2c_hid_dbg(ihid, "%s\n", __func__);
 
-	memcpy(ihid->cmdbuf + length, args, args_len);
-	length += args_len;
+	/* Command register goes first */
+	*(__le16 *)ihid->cmdbuf = ihid->hdesc.wCommandRegister;
+	length += sizeof(__le16);
+	/* Next is GET_REPORT command */
+	length += i2c_hid_encode_command(ihid->cmdbuf + length,
+					 I2C_HID_OPCODE_GET_REPORT,
+					 report_type, report_id);
+	/*
+	 * Device will send report data through data register. Because
+	 * command can be either 2 or 3 bytes destination for the data
+	 * register may be not aligned.
+	 */
+	put_unaligned_le16(le16_to_cpu(ihid->hdesc.wDataRegister),
+			   ihid->cmdbuf + length);
+	length += sizeof(__le16);
 
-	return i2c_hid_xfer(ihid, ihid->cmdbuf, length, buf_recv, data_len);
-}
+	/*
+	 * In addition to report data device will supply data length
+	 * in the first 2 bytes of the response, so adjust .
+	 */
+	error = i2c_hid_xfer(ihid, ihid->cmdbuf, length,
+			     ihid->rawbuf, recv_len + sizeof(__le16));
+	if (error) {
+		dev_err(&ihid->client->dev,
+			"failed to set a report to device: %d\n", error);
+		return error;
+	}
 
-static int i2c_hid_get_report(struct i2c_hid *ihid, u8 reportType,
-		u8 reportID, unsigned char *buf_recv, int data_len)
-{
-	u8 args[2];
-	int ret;
-	int args_len = 0;
-	u16 readRegister = le16_to_cpu(ihid->hdesc.wDataRegister);
+	/* The buffer is sufficiently aligned */
+	ret_count = le16_to_cpup((__le16 *)ihid->rawbuf);
 
-	i2c_hid_dbg(ihid, "%s\n", __func__);
+	/* Check for empty report response */
+	if (ret_count <= sizeof(__le16))
+		return 0;
 
-	args[args_len++] = readRegister & 0xFF;
-	args[args_len++] = readRegister >> 8;
+	recv_len = min(recv_len, ret_count - sizeof(__le16));
+	memcpy(recv_buf, ihid->rawbuf + sizeof(__le16), recv_len);
 
-	ret = __i2c_hid_command(ihid, &hid_get_report_cmd, reportID,
-		reportType, args, args_len, buf_recv, data_len);
-	if (ret) {
+	if (report_id && recv_len != 0 && recv_buf[0] != report_id) {
 		dev_err(&ihid->client->dev,
-			"failed to retrieve report from device.\n");
-		return ret;
+			"device returned incorrect report (%d vs %d expected)\n",
+			recv_buf[0], report_id);
+		return -EINVAL;
 	}
 
-	return 0;
+	return recv_len;
 }
 
 static size_t i2c_hid_format_report(u8 *buf, int report_id,
@@ -651,13 +638,12 @@ static int i2c_hid_alloc_buffers(struct i2c_hid *ihid, size_t report_size)
 }
 
 static int i2c_hid_get_raw_report(struct hid_device *hid,
-		unsigned char report_number, __u8 *buf, size_t count,
-		unsigned char report_type)
+				  u8 report_type, u8 report_id,
+				  u8 *buf, size_t count)
 {
 	struct i2c_client *client = hid->driver_data;
 	struct i2c_hid *ihid = i2c_get_clientdata(client);
-	size_t ret_count, ask_count;
-	int ret;
+	int ret_count;
 
 	if (report_type == HID_OUTPUT_REPORT)
 		return -EINVAL;
@@ -667,42 +653,24 @@ static int i2c_hid_get_raw_report(struct hid_device *hid,
 	 * not have the report ID that the upper layers expect, so we need
 	 * to stash it the buffer ourselves and adjust the data size.
 	 */
-	if (!report_number) {
+	if (!report_id) {
 		buf[0] = 0;
 		buf++;
 		count--;
 	}
 
-	/* +2 bytes to include the size of the reply in the query buffer */
-	ask_count = min(count + 2, (size_t)ihid->bufsize);
-
-	ret = i2c_hid_get_report(ihid,
+	ret_count = i2c_hid_get_report(ihid,
 			report_type == HID_FEATURE_REPORT ? 0x03 : 0x01,
-			report_number, ihid->rawbuf, ask_count);
-
-	if (ret < 0)
-		return ret;
-
-	ret_count = ihid->rawbuf[0] | (ihid->rawbuf[1] << 8);
-
-	if (ret_count <= 2)
-		return 0;
-
-	ret_count = min(ret_count, ask_count);
-
-	/* The query buffer contains the size, dropping it in the reply */
-	count = min(count, ret_count - 2);
-	memcpy(buf, ihid->rawbuf + 2, count);
+			report_id, buf, count);
 
-	if (!report_number)
-		count++;
+	if (ret_count > 0 && !report_id)
+		ret_count++;
 
-	return count;
+	return ret_count;
 }
 
-static int i2c_hid_output_raw_report(struct hid_device *hid,
-				     const u8 *buf, size_t count,
-				     u8 report_type, bool do_set)
+static int i2c_hid_output_raw_report(struct hid_device *hid, u8 report_type,
+				     const u8 *buf, size_t count, bool do_set)
 {
 	struct i2c_client *client = hid->driver_data;
 	struct i2c_hid *ihid = i2c_get_clientdata(client);
@@ -735,7 +703,7 @@ static int i2c_hid_output_raw_report(struct hid_device *hid,
 
 static int i2c_hid_output_report(struct hid_device *hid, u8 *buf, size_t count)
 {
-	return i2c_hid_output_raw_report(hid, buf, count, HID_OUTPUT_REPORT,
+	return i2c_hid_output_raw_report(hid, HID_OUTPUT_REPORT, buf, count,
 					 false);
 }
 
@@ -745,11 +713,11 @@ static int i2c_hid_raw_request(struct hid_device *hid, unsigned char reportnum,
 {
 	switch (reqtype) {
 	case HID_REQ_GET_REPORT:
-		return i2c_hid_get_raw_report(hid, reportnum, buf, len, rtype);
+		return i2c_hid_get_raw_report(hid, rtype, reportnum, buf, len);
 	case HID_REQ_SET_REPORT:
 		if (buf[0] != reportnum)
 			return -EINVAL;
-		return i2c_hid_output_raw_report(hid, buf, len, rtype, true);
+		return i2c_hid_output_raw_report(hid, rtype, buf, len, true);
 	default:
 		return -EIO;
 	}
-- 
2.34.1.703.g22d0c6ccf7-goog

