Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 408E0492037
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 08:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244726AbiARH0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 02:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234037AbiARH0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 02:26:33 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C7AC061574;
        Mon, 17 Jan 2022 23:26:33 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id i8so13121937pgt.13;
        Mon, 17 Jan 2022 23:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V0/xeb/ltQYaEaF113sypfFpexckyEO/l19a8/MnbB0=;
        b=NfgJNWaqhS8piWDRfV9g5I3M7ApDQ2XvtoYhCRfaS+d7AR50shzyQIotLT3zdSHNBx
         N3Jbj6DtwpFLebXYIYvMY29+BSnqzAv5K1WFkYS8AE/J5Z4zkDCkwRVEaWTFZ4nnPW9Y
         Yt3t3Az3RIYB2MPvXE99lJwJ0dCIYNsUca3h5Eb+bRD+W+2AxRvYUySYSUBhR/R3PpDr
         dvMJ89SLo9zZxh6DU8NUyQ35MbgPBXVtIe16M+5r5YXcIjzMfMElKYRU+W3Ba0QRvBpD
         NschROAPDFsqWZ4tqGtiBsbFMwHoaQOq5rmookkp14cT2eb153N9M+TpBmFincp1zW47
         LbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V0/xeb/ltQYaEaF113sypfFpexckyEO/l19a8/MnbB0=;
        b=68q8T2DsWXGtAwZE7rayT+kwPd8SLwY3vrWtJPsTbUObpS5AhtAcZUR07WA9KW39iC
         YrsEdttOAVuKyjPiPtKr7blET7xnN/gN+DoZLqNIeS+dZvJxYgRZr/DHBykV8fehgiDr
         T4220SHi915Fu94AjkxHJzNIKTeSmT+MQ/mg3eBHbzlPdJ0fsIMGkE7fDPHPaOBh/n3E
         Pxu8h72H67YnJ1xnZCNaKQA4Eox4Kqk6jJfnD9a8kstela0DdF27c2yhOyNWOUWhY4qc
         Pbhi5kLG+5e6WW6iKOxdzJWK/yuzANo+YJ+IBjsejI7TcLsd3lX+tmFEoPpDT+WeUUst
         8goQ==
X-Gm-Message-State: AOAM5313bh1omYdn4s2PsUEuNIIaoJmSsh0wT6GgAiO5xBoFlUI+4NQ4
        gB3QGJYR9R4ARP13k/hqW+M=
X-Google-Smtp-Source: ABdhPJySuGgE/LOdJB7H2LXfyH0/wfP+Sp291d9HnX7lvDs2GqjEHCGkHHY0/IEj6qHnoGyEjXe4UQ==
X-Received: by 2002:a63:6c03:: with SMTP id h3mr21624014pgc.604.1642490793264;
        Mon, 17 Jan 2022 23:26:33 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:bf2e:59:5029:f4c5])
        by smtp.gmail.com with ESMTPSA id y18sm11079816pfl.156.2022.01.17.23.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 23:26:32 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Angela Czubak <acz@semihalf.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/12] HID: i2c-hid: fix handling numbered reports with IDs of 15 and above
Date:   Mon, 17 Jan 2022 23:26:17 -0800
Message-Id: <20220118072628.1617172-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
In-Reply-To: <20220118072628.1617172-1-dmitry.torokhov@gmail.com>
References: <20220118072628.1617172-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Angela Czubak <acz@semihalf.com>

Special handling of numbered reports with IDs of 15 and above is only
needed when executing what HID-I2C spec is calling "Class Specific
Requests", and not when simply sending output reports.

Additionally, our mangling of report ID in i2c_hid_set_or_send_report()
resulted in incorrect report ID being written into SET_REPORT command
payload.

To solve it let's move all the report ID manipulation into
__i2c_hid_command() where we form the command data structure.

Signed-off-by: Angela Czubak <acz@semihalf.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/i2c-hid/i2c-hid-core.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 517141138b00..bd7b0eeca3ea 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -97,6 +97,7 @@ union command {
 		__le16 reg;
 		__u8 reportTypeID;
 		__u8 opcode;
+		__u8 reportID;
 	} __packed c;
 };
 
@@ -232,7 +233,13 @@ static int __i2c_hid_command(struct i2c_client *client,
 
 	if (length > 2) {
 		cmd->c.opcode = command->opcode;
-		cmd->c.reportTypeID = reportID | reportType << 4;
+		if (reportID < 0x0F) {
+			cmd->c.reportTypeID = reportType << 4 | reportID;
+		} else {
+			cmd->c.reportTypeID = reportType << 4 | 0x0F;
+			cmd->c.reportID = reportID;
+			length++;
+		}
 	}
 
 	memcpy(cmd->data + length, args, args_len);
@@ -293,18 +300,13 @@ static int i2c_hid_get_report(struct i2c_client *client, u8 reportType,
 		u8 reportID, unsigned char *buf_recv, int data_len)
 {
 	struct i2c_hid *ihid = i2c_get_clientdata(client);
-	u8 args[3];
+	u8 args[2];
 	int ret;
 	int args_len = 0;
 	u16 readRegister = le16_to_cpu(ihid->hdesc.wDataRegister);
 
 	i2c_hid_dbg(ihid, "%s\n", __func__);
 
-	if (reportID >= 0x0F) {
-		args[args_len++] = reportID;
-		reportID = 0x0F;
-	}
-
 	args[args_len++] = readRegister & 0xFF;
 	args[args_len++] = readRegister >> 8;
 
@@ -350,18 +352,12 @@ static int i2c_hid_set_or_send_report(struct i2c_client *client, u8 reportType,
 	size =		2			/* size */ +
 			(reportID ? 1 : 0)	/* reportID */ +
 			data_len		/* buf */;
-	args_len =	(reportID >= 0x0F ? 1 : 0) /* optional third byte */ +
-			2			/* dataRegister */ +
+	args_len =	2			/* dataRegister */ +
 			size			/* args */;
 
 	if (!use_data && maxOutputLength == 0)
 		return -ENOSYS;
 
-	if (reportID >= 0x0F) {
-		args[index++] = reportID;
-		reportID = 0x0F;
-	}
-
 	/*
 	 * use the data register for feature reports or if the device does not
 	 * support the output register
-- 
2.34.1.703.g22d0c6ccf7-goog

