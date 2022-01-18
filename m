Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF59D492043
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 08:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245529AbiARH1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 02:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245003AbiARH0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 02:26:40 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E026C06161C;
        Mon, 17 Jan 2022 23:26:40 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id 128so12314415pfe.12;
        Mon, 17 Jan 2022 23:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k+ph1/QN1j4IUgMje1r3voGZ5lWOAeDuTQ2adMCwVo4=;
        b=d9IrUOz1Qx2Ta+vK+JxM+FjX3giOOtnWxsZxAith22VZ9u1OzLfLGPxgRV2P7c8qbF
         Wd81PF21eA/yYvDsAOl2iUwJ8PaQIN4cJKIyXM8wjVg8sxUspJVV14GmtJrNQdNHe6by
         TdbZA+VGr5nGfylMiBRQE3oyHiVlRmR/pQdiiOC9feZTMj2Q9heU5WKuK2xeHOXl1yzN
         P98J7bN1b+KZHx+j4ldEXi+SDB1LjdAtlyRfnfLksJcZ/MIzksv+dT4fdfIWyVU9Trq0
         e5wApwwDvL8CRL82d/icWLkp1qlOc8M2Pyyis+7O8T+3gAfKFhtQTv4lN9SDO0tLetUk
         Mp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k+ph1/QN1j4IUgMje1r3voGZ5lWOAeDuTQ2adMCwVo4=;
        b=GgE3WkadAYKySQg+8wyUfuvo6nq1dOa5f5mShUBDecHy9Vvyd/hT/Q7UsivEoIUXwH
         c+Jk+fSQ+s09zjxKfR6kXHFGf8RquMzuxp43ohb0NvZKXyOYq6zhEgc+ocJ1OUXMRQ1Y
         V1xc4NvYQ71t/IugYpg6ClSwf0ukFyF9eapbeuYInaPFqUorwinQ50h23qQJbjbmaI0i
         RTUIyMflTWv+6ezvhfywfA6JjrctRUnWDZ+Z0xUWJq4yFindfD1JOK4uaXIEjgAdPROm
         VHueUn7qGhgKTi/5ufs8ggG86Z+iD86h2vShxWAp49r3E7njReli7KMWafelCQGNqmAL
         p3Aw==
X-Gm-Message-State: AOAM533yZYOYQovGJmdiMLSrUvPj0AyKGjFla33v5t8VDShgvLZbDHST
        OFiS3KlRoDwvOuMi3XKArso=
X-Google-Smtp-Source: ABdhPJwoFtTgwbO/ax9ClEazGtTyGQl8RDqbAevp+ac5daYdSvOADsp/NAzsJJMADXFwHGh2ciaEDA==
X-Received: by 2002:a63:3e0e:: with SMTP id l14mr21803126pga.223.1642490799442;
        Mon, 17 Jan 2022 23:26:39 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:bf2e:59:5029:f4c5])
        by smtp.gmail.com with ESMTPSA id y18sm11079816pfl.156.2022.01.17.23.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 23:26:38 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Angela Czubak <acz@semihalf.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/12] HID: i2c-hid: explicitly code setting and sending reports
Date:   Mon, 17 Jan 2022 23:26:21 -0800
Message-Id: <20220118072628.1617172-6-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
In-Reply-To: <20220118072628.1617172-1-dmitry.torokhov@gmail.com>
References: <20220118072628.1617172-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of relying on __i2c_hid_command() that tries to handle all
commands and because of that is very complicated, let's define a
new dumb helper i2c_hid_xfer() that actually transfers (write and
read) data, and use it when sending and setting reports. By doing
that we can save on number of copy operations we have to execute,
and make logic of sending reports much clearer.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/i2c-hid/i2c-hid-core.c | 269 ++++++++++++++++-------------
 1 file changed, 151 insertions(+), 118 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 6c1741d9211d..c48b75bd81e0 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -35,6 +35,7 @@
 #include <linux/kernel.h>
 #include <linux/hid.h>
 #include <linux/mutex.h>
+#include <asm/unaligned.h>
 
 #include "../hid-ids.h"
 #include "i2c-hid.h"
@@ -47,6 +48,15 @@
 #define I2C_HID_QUIRK_BAD_INPUT_SIZE		BIT(6)
 #define I2C_HID_QUIRK_NO_WAKEUP_AFTER_RESET	BIT(7)
 
+/* Command opcodes */
+#define I2C_HID_OPCODE_RESET			0x01
+#define I2C_HID_OPCODE_GET_REPORT		0x02
+#define I2C_HID_OPCODE_SET_REPORT		0x03
+#define I2C_HID_OPCODE_GET_IDLE			0x04
+#define I2C_HID_OPCODE_SET_IDLE			0x05
+#define I2C_HID_OPCODE_GET_PROTOCOL		0x06
+#define I2C_HID_OPCODE_SET_PROTOCOL		0x07
+#define I2C_HID_OPCODE_SET_POWER		0x08
 
 /* flags */
 #define I2C_HID_STARTED		0
@@ -90,16 +100,6 @@ struct i2c_hid_cmd {
 	unsigned int length;
 };
 
-union command {
-	u8 data[0];
-	struct cmd {
-		__le16 reg;
-		__u8 reportTypeID;
-		__u8 opcode;
-		__u8 reportID;
-	} __packed c;
-};
-
 #define I2C_HID_CMD(opcode_) \
 	.opcode = opcode_, .length = 4, \
 	.registerIndex = offsetof(struct i2c_hid_desc, wCommandRegister)
@@ -115,9 +115,7 @@ static const struct i2c_hid_cmd hid_report_descr_cmd = {
 /* commands */
 static const struct i2c_hid_cmd hid_reset_cmd =		{ I2C_HID_CMD(0x01) };
 static const struct i2c_hid_cmd hid_get_report_cmd =	{ I2C_HID_CMD(0x02) };
-static const struct i2c_hid_cmd hid_set_report_cmd =	{ I2C_HID_CMD(0x03) };
 static const struct i2c_hid_cmd hid_set_power_cmd =	{ I2C_HID_CMD(0x08) };
-static const struct i2c_hid_cmd hid_no_cmd =		{ .length = 0 };
 
 /*
  * These definitions are not used here, but are defined by the spec.
@@ -144,7 +142,6 @@ struct i2c_hid {
 	u8			*inbuf;		/* Input buffer */
 	u8			*rawbuf;	/* Raw Input buffer */
 	u8			*cmdbuf;	/* Command buffer */
-	u8			*argsbuf;	/* Command arguments buffer */
 
 	unsigned long		flags;		/* device flags */
 	unsigned long		quirks;		/* Various quirks */
@@ -206,67 +203,90 @@ static u32 i2c_hid_lookup_quirk(const u16 idVendor, const u16 idProduct)
 	return quirks;
 }
 
+static int i2c_hid_xfer(struct i2c_hid *ihid,
+			u8 *send_buf, int send_len, u8 *recv_buf, int recv_len)
+{
+	struct i2c_client *client = ihid->client;
+	struct i2c_msg msgs[2] = { 0 };
+	int n = 0;
+	int ret;
+
+	if (send_len) {
+		i2c_hid_dbg(ihid, "%s: cmd=%*ph\n",
+			    __func__, send_len, send_buf);
+
+		msgs[n].addr = client->addr;
+		msgs[n].flags = client->flags & I2C_M_TEN;
+		msgs[n].len = send_len;
+		msgs[n].buf = send_buf;
+		n++;
+	}
+
+	if (recv_len) {
+		msgs[n].addr = client->addr;
+		msgs[n].flags = (client->flags & I2C_M_TEN) | I2C_M_RD;
+		msgs[n].len = recv_len;
+		msgs[n].buf = recv_buf;
+		n++;
+
+		set_bit(I2C_HID_READ_PENDING, &ihid->flags);
+	}
+
+	ret = i2c_transfer(client->adapter, msgs, n);
+
+	if (recv_len)
+		clear_bit(I2C_HID_READ_PENDING, &ihid->flags);
+
+	if (ret != n)
+		return ret < 0 ? ret : -EIO;
+
+	return 0;
+}
+
+static size_t i2c_hid_encode_command(u8 *buf, u8 opcode,
+				     int report_type, int report_id)
+{
+	size_t length = 0;
+
+	if (report_id < 0x0F) {
+		buf[length++] = report_type << 4 | report_id;
+		buf[length++] = opcode;
+	} else {
+		buf[length++] = report_type << 4 | 0x0F;
+		buf[length++] = opcode;
+		buf[length++] = report_id;
+	}
+
+	return length;
+}
+
 static int __i2c_hid_command(struct i2c_hid *ihid,
 		const struct i2c_hid_cmd *command, u8 reportID,
 		u8 reportType, u8 *args, int args_len,
 		unsigned char *buf_recv, int data_len)
 {
-	struct i2c_client *client = ihid->client;
-	union command *cmd = (union command *)ihid->cmdbuf;
-	int ret;
-	struct i2c_msg msg[2];
-	int msg_num = 1;
-
 	int length = command->length;
 	unsigned int registerIndex = command->registerIndex;
 
 	/* special case for hid_descr_cmd */
 	if (command == &hid_descr_cmd) {
-		cmd->c.reg = ihid->wHIDDescRegister;
+		*(__le16 *)ihid->cmdbuf = ihid->wHIDDescRegister;
 	} else {
-		cmd->data[0] = ihid->hdesc_buffer[registerIndex];
-		cmd->data[1] = ihid->hdesc_buffer[registerIndex + 1];
+		ihid->cmdbuf[0] = ihid->hdesc_buffer[registerIndex];
+		ihid->cmdbuf[1] = ihid->hdesc_buffer[registerIndex + 1];
 	}
 
 	if (length > 2) {
-		cmd->c.opcode = command->opcode;
-		if (reportID < 0x0F) {
-			cmd->c.reportTypeID = reportType << 4 | reportID;
-		} else {
-			cmd->c.reportTypeID = reportType << 4 | 0x0F;
-			cmd->c.reportID = reportID;
-			length++;
-		}
+		length = sizeof(__le16) + /* register */
+			 i2c_hid_encode_command(ihid->cmdbuf + sizeof(__le16),
+						command->opcode,
+						reportType, reportID);
 	}
 
-	memcpy(cmd->data + length, args, args_len);
+	memcpy(ihid->cmdbuf + length, args, args_len);
 	length += args_len;
 
-	i2c_hid_dbg(ihid, "%s: cmd=%*ph\n", __func__, length, cmd->data);
-
-	msg[0].addr = client->addr;
-	msg[0].flags = client->flags & I2C_M_TEN;
-	msg[0].len = length;
-	msg[0].buf = cmd->data;
-	if (data_len > 0) {
-		msg[1].addr = client->addr;
-		msg[1].flags = client->flags & I2C_M_TEN;
-		msg[1].flags |= I2C_M_RD;
-		msg[1].len = data_len;
-		msg[1].buf = buf_recv;
-		msg_num = 2;
-		set_bit(I2C_HID_READ_PENDING, &ihid->flags);
-	}
-
-	ret = i2c_transfer(client->adapter, msg, msg_num);
-
-	if (data_len > 0)
-		clear_bit(I2C_HID_READ_PENDING, &ihid->flags);
-
-	if (ret != msg_num)
-		return ret < 0 ? ret : -EIO;
-
-	return 0;
+	return i2c_hid_xfer(ihid, ihid->cmdbuf, length, buf_recv, data_len);
 }
 
 static int i2c_hid_command(struct i2c_hid *ihid,
@@ -301,70 +321,81 @@ static int i2c_hid_get_report(struct i2c_hid *ihid, u8 reportType,
 	return 0;
 }
 
+static size_t i2c_hid_format_report(u8 *buf, int report_id,
+				    const u8 *data, size_t size)
+{
+	size_t length = sizeof(__le16); /* reserve space to store size */
+
+	if (report_id)
+		buf[length++] = report_id;
+
+	memcpy(buf + length, data, size);
+	length += size;
+
+	/* Store overall size in the beginning of the buffer */
+	put_unaligned_le16(length, buf);
+
+	return length;
+}
+
 /**
  * i2c_hid_set_or_send_report: forward an incoming report to the device
  * @ihid: the i2c hid device
- * @reportType: 0x03 for HID_FEATURE_REPORT ; 0x02 for HID_OUTPUT_REPORT
- * @reportID: the report ID
+ * @report_type: 0x03 for HID_FEATURE_REPORT ; 0x02 for HID_OUTPUT_REPORT
+ * @report_id: the report ID
  * @buf: the actual data to transfer, without the report ID
  * @data_len: size of buf
- * @use_data: true: use SET_REPORT HID command, false: send plain OUTPUT report
+ * @do_set: true: use SET_REPORT HID command, false: send plain OUTPUT report
  */
-static int i2c_hid_set_or_send_report(struct i2c_hid *ihid, u8 reportType,
-		u8 reportID, unsigned char *buf, size_t data_len, bool use_data)
+static int i2c_hid_set_or_send_report(struct i2c_hid *ihid,
+				      u8 report_type, u8 report_id,
+				      const u8 *buf, size_t data_len,
+				      bool do_set)
 {
-	u8 *args = ihid->argsbuf;
-	const struct i2c_hid_cmd *hidcmd;
-	int ret;
-	u16 dataRegister = le16_to_cpu(ihid->hdesc.wDataRegister);
-	u16 outputRegister = le16_to_cpu(ihid->hdesc.wOutputRegister);
-	u16 maxOutputLength = le16_to_cpu(ihid->hdesc.wMaxOutputLength);
-	u16 size;
-	int args_len;
-	int index = 0;
+	size_t length = 0;
+	int error;
 
 	i2c_hid_dbg(ihid, "%s\n", __func__);
 
 	if (data_len > ihid->bufsize)
 		return -EINVAL;
 
-	size =		2			/* size */ +
-			(reportID ? 1 : 0)	/* reportID */ +
-			data_len		/* buf */;
-	args_len =	2			/* dataRegister */ +
-			size			/* args */;
-
-	if (!use_data && maxOutputLength == 0)
+	if (!do_set && le16_to_cpu(ihid->hdesc.wMaxOutputLength) == 0)
 		return -ENOSYS;
 
-	/*
-	 * use the data register for feature reports or if the device does not
-	 * support the output register
-	 */
-	if (use_data) {
-		args[index++] = dataRegister & 0xFF;
-		args[index++] = dataRegister >> 8;
-		hidcmd = &hid_set_report_cmd;
+	if (do_set) {
+		/* Command register goes first */
+		*(__le16 *)ihid->cmdbuf = ihid->hdesc.wCommandRegister;
+		length += sizeof(__le16);
+		/* Next is SET_REPORT command */
+		length += i2c_hid_encode_command(ihid->cmdbuf + length,
+						 I2C_HID_OPCODE_SET_REPORT,
+						 report_type, report_id);
+		/*
+		 * Report data will go into the data register. Because
+		 * command can be either 2 or 3 bytes destination for
+		 * the data register may be not aligned.
+		*/
+		put_unaligned_le16(le16_to_cpu(ihid->hdesc.wDataRegister),
+				   ihid->cmdbuf + length);
+		length += sizeof(__le16);
 	} else {
-		args[index++] = outputRegister & 0xFF;
-		args[index++] = outputRegister >> 8;
-		hidcmd = &hid_no_cmd;
+		/*
+		 * With simple "send report" all data goes into the output
+		 * register.
+		 */
+		*(__le16 *)ihid->cmdbuf = ihid->hdesc.wCommandRegister;
+		length += sizeof(__le16);
 	}
 
-	args[index++] = size & 0xFF;
-	args[index++] = size >> 8;
-
-	if (reportID)
-		args[index++] = reportID;
+	length += i2c_hid_format_report(ihid->cmdbuf + length,
+					report_id, buf, data_len);
 
-	memcpy(&args[index], buf, data_len);
-
-	ret = __i2c_hid_command(ihid, hidcmd, reportID,
-		reportType, args, args_len, NULL, 0);
-	if (ret) {
+	error = i2c_hid_xfer(ihid, ihid->cmdbuf, length, NULL, 0);
+	if (error) {
 		dev_err(&ihid->client->dev,
-			"failed to set a report to device.\n");
-		return ret;
+			"failed to set a report to device: %d\n", error);
+		return error;
 	}
 
 	return data_len;
@@ -575,31 +606,33 @@ static void i2c_hid_free_buffers(struct i2c_hid *ihid)
 {
 	kfree(ihid->inbuf);
 	kfree(ihid->rawbuf);
-	kfree(ihid->argsbuf);
 	kfree(ihid->cmdbuf);
 	ihid->inbuf = NULL;
 	ihid->rawbuf = NULL;
 	ihid->cmdbuf = NULL;
-	ihid->argsbuf = NULL;
 	ihid->bufsize = 0;
 }
 
 static int i2c_hid_alloc_buffers(struct i2c_hid *ihid, size_t report_size)
 {
-	/* the worst case is computed from the set_report command with a
-	 * reportID > 15 and the maximum report length */
-	int args_len = sizeof(__u8) + /* ReportID */
-		       sizeof(__u8) + /* optional ReportID byte */
-		       sizeof(__u16) + /* data register */
-		       sizeof(__u16) + /* size of the report */
-		       report_size; /* report */
+	/*
+	 * The worst case is computed from the set_report command with a
+	 * reportID > 15 and the maximum report length.
+	 */
+	int cmd_len = sizeof(__le16) +	/* command register */
+		      sizeof(u8) +	/* encoded report type/ID */
+		      sizeof(u8) +	/* opcode */
+		      sizeof(u8) +	/* optional 3rd byte report ID */
+		      sizeof(__le16) +	/* data register */
+		      sizeof(__le16) +	/* report data size */
+		      sizeof(u8) +	/* report ID if numbered report */
+		      report_size;
 
 	ihid->inbuf = kzalloc(report_size, GFP_KERNEL);
 	ihid->rawbuf = kzalloc(report_size, GFP_KERNEL);
-	ihid->argsbuf = kzalloc(args_len, GFP_KERNEL);
-	ihid->cmdbuf = kzalloc(sizeof(union command) + args_len, GFP_KERNEL);
+	ihid->cmdbuf = kzalloc(cmd_len, GFP_KERNEL);
 
-	if (!ihid->inbuf || !ihid->rawbuf || !ihid->argsbuf || !ihid->cmdbuf) {
+	if (!ihid->inbuf || !ihid->rawbuf || !ihid->cmdbuf) {
 		i2c_hid_free_buffers(ihid);
 		return -ENOMEM;
 	}
@@ -659,8 +692,9 @@ static int i2c_hid_get_raw_report(struct hid_device *hid,
 	return count;
 }
 
-static int i2c_hid_output_raw_report(struct hid_device *hid, __u8 *buf,
-		size_t count, unsigned char report_type, bool use_data)
+static int i2c_hid_output_raw_report(struct hid_device *hid,
+				     const u8 *buf, size_t count,
+				     u8 report_type, bool do_set)
 {
 	struct i2c_client *client = hid->driver_data;
 	struct i2c_hid *ihid = i2c_get_clientdata(client);
@@ -681,7 +715,7 @@ static int i2c_hid_output_raw_report(struct hid_device *hid, __u8 *buf,
 	 */
 	ret = i2c_hid_set_or_send_report(ihid,
 				report_type == HID_FEATURE_REPORT ? 0x03 : 0x02,
-				report_id, buf + 1, count - 1, use_data);
+				report_id, buf + 1, count - 1, do_set);
 
 	if (ret >= 0)
 		ret++; /* add report_id to the number of transferred bytes */
@@ -691,11 +725,10 @@ static int i2c_hid_output_raw_report(struct hid_device *hid, __u8 *buf,
 	return ret;
 }
 
-static int i2c_hid_output_report(struct hid_device *hid, __u8 *buf,
-		size_t count)
+static int i2c_hid_output_report(struct hid_device *hid, u8 *buf, size_t count)
 {
 	return i2c_hid_output_raw_report(hid, buf, count, HID_OUTPUT_REPORT,
-			false);
+					 false);
 }
 
 static int i2c_hid_raw_request(struct hid_device *hid, unsigned char reportnum,
-- 
2.34.1.703.g22d0c6ccf7-goog

