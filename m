Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C09492044
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 08:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245591AbiARH10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 02:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234427AbiARH0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 02:26:41 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0803C061401;
        Mon, 17 Jan 2022 23:26:41 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id h23so13142515pgk.11;
        Mon, 17 Jan 2022 23:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xK1aCyNEs72Nz6kllo8Nxz5IKBPWt0j4OPgxiYbFIoY=;
        b=BTKCQBne31e6RluyS/R2Sx6f76juUN1wI5IsdkjgC4xwnA/O8BHAilL+eLCi+iBA9z
         qdgd259NjDQXF14RIZDnbV+73ytj6bAGLFRMUziXUJb+5kXW5s/nIX3nsl5inatSV4Mc
         GZF64tpcAEPo9DkWJK7x4FZjzeLKDkOoMtZUUhQ4DQ2nAk/u80Uk1LceBFaTjKT9oiTe
         rxMTX1YgFvQoNuden1ewRcfPVHjmO7WdguMlypPX28UDyyzancnCDsqOfj/DkQKyfEEr
         5zEOZBJASBW9N9rUqfXEmWC41qZVmF4HXIrHbMCuTSbXnWnYmTUZF9I9NLQ80Y2t4Ceu
         2EgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xK1aCyNEs72Nz6kllo8Nxz5IKBPWt0j4OPgxiYbFIoY=;
        b=fBBiyMO9oZ3WJA7Y/UvaJV9T7ISegjspCS8N+RYRkwgdpU1MyZa6S6ZKhW8DIE3hu9
         17cUz1A/cJt3Ft+gq/rbnWUB+t/VSNm/jR4Kscbq2afKf0/oOz9zLu2b9GWlIcsLwlZt
         +HtHU4bpsO/TUadP2L1sR9yQJ0jeS4kXKpdPNZG/VB5tfoY01sVh0qyurMP7uYdAiV7c
         X0E1XF8r8SW2y+jRk0cc4XKjuExyQB2mW/PqaNYQ1GDzByDEzLI04zmR8VCSaYCFXTQm
         +3w5pGFZtPnv6FI2/3xqirNZ4eghd1X5r+k8oeJBEf2CxoQmuKmsTY3ujriw3jwZmOKU
         fplg==
X-Gm-Message-State: AOAM5326DYrYhVgwy9ythrBiILiD32n8mkIfKVExxDENPWAarZRrofMC
        JlBu2yJE0mtjLBsIf3OHUy0=
X-Google-Smtp-Source: ABdhPJzzPLF6lfzlxQRptNhBBnQCaa5RDkKbvUWy4FX/KXDeGi/pOW3eInFMte354z638l7vRzbRnA==
X-Received: by 2002:a63:720c:: with SMTP id n12mr22481147pgc.1.1642490801186;
        Mon, 17 Jan 2022 23:26:41 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:bf2e:59:5029:f4c5])
        by smtp.gmail.com with ESMTPSA id y18sm11079816pfl.156.2022.01.17.23.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 23:26:39 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Angela Czubak <acz@semihalf.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/12] HID: i2c-hid: define i2c_hid_read_register() and use it
Date:   Mon, 17 Jan 2022 23:26:22 -0800
Message-Id: <20220118072628.1617172-7-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
In-Reply-To: <20220118072628.1617172-1-dmitry.torokhov@gmail.com>
References: <20220118072628.1617172-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handling simple read of device registers in __i2c_hid_command() makes it
too complicated and the need of special handling for the HID descriptor
register adds even more complexity. Instead, let's create simple
i2c_hid_read_register() helper on base of i2c_hid_xfer() and use it.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/i2c-hid/i2c-hid-core.c | 45 +++++++++++++++---------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index c48b75bd81e0..b1a2c6ad374d 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -104,14 +104,6 @@ struct i2c_hid_cmd {
 	.opcode = opcode_, .length = 4, \
 	.registerIndex = offsetof(struct i2c_hid_desc, wCommandRegister)
 
-/* fetch HID descriptor */
-static const struct i2c_hid_cmd hid_descr_cmd = { .length = 2 };
-/* fetch report descriptors */
-static const struct i2c_hid_cmd hid_report_descr_cmd = {
-		.registerIndex = offsetof(struct i2c_hid_desc,
-			wReportDescRegister),
-		.opcode = 0x00,
-		.length = 2 };
 /* commands */
 static const struct i2c_hid_cmd hid_reset_cmd =		{ I2C_HID_CMD(0x01) };
 static const struct i2c_hid_cmd hid_get_report_cmd =	{ I2C_HID_CMD(0x02) };
@@ -243,6 +235,14 @@ static int i2c_hid_xfer(struct i2c_hid *ihid,
 	return 0;
 }
 
+static int i2c_hid_read_register(struct i2c_hid *ihid, __le16 reg,
+				 void *buf, size_t len)
+{
+	*(__le16 *)ihid->cmdbuf = reg;
+
+	return i2c_hid_xfer(ihid, ihid->cmdbuf, sizeof(__le16), buf, len);
+}
+
 static size_t i2c_hid_encode_command(u8 *buf, u8 opcode,
 				     int report_type, int report_id)
 {
@@ -268,13 +268,8 @@ static int __i2c_hid_command(struct i2c_hid *ihid,
 	int length = command->length;
 	unsigned int registerIndex = command->registerIndex;
 
-	/* special case for hid_descr_cmd */
-	if (command == &hid_descr_cmd) {
-		*(__le16 *)ihid->cmdbuf = ihid->wHIDDescRegister;
-	} else {
-		ihid->cmdbuf[0] = ihid->hdesc_buffer[registerIndex];
-		ihid->cmdbuf[1] = ihid->hdesc_buffer[registerIndex + 1];
-	}
+	ihid->cmdbuf[0] = ihid->hdesc_buffer[registerIndex];
+	ihid->cmdbuf[1] = ihid->hdesc_buffer[registerIndex + 1];
 
 	if (length > 2) {
 		length = sizeof(__le16) + /* register */
@@ -791,8 +786,9 @@ static int i2c_hid_parse(struct hid_device *hid)
 
 		i2c_hid_dbg(ihid, "asking HID report descriptor\n");
 
-		ret = i2c_hid_command(ihid, &hid_report_descr_cmd,
-				      rdesc, rsize);
+		ret = i2c_hid_read_register(ihid,
+					    ihid->hdesc.wReportDescRegister,
+					    rdesc, rsize);
 		if (ret) {
 			hid_err(hid, "reading report descriptor failed\n");
 			kfree(rdesc);
@@ -902,7 +898,7 @@ static int i2c_hid_fetch_hid_descriptor(struct i2c_hid *ihid)
 	struct i2c_client *client = ihid->client;
 	struct i2c_hid_desc *hdesc = &ihid->hdesc;
 	unsigned int dsize;
-	int ret;
+	int error;
 
 	/* i2c hid fetch using a fixed descriptor size (30 bytes) */
 	if (i2c_hid_get_dmi_i2c_hid_desc_override(client->name)) {
@@ -911,11 +907,14 @@ static int i2c_hid_fetch_hid_descriptor(struct i2c_hid *ihid)
 			*i2c_hid_get_dmi_i2c_hid_desc_override(client->name);
 	} else {
 		i2c_hid_dbg(ihid, "Fetching the HID descriptor\n");
-		ret = i2c_hid_command(ihid, &hid_descr_cmd,
-				      ihid->hdesc_buffer,
-				      sizeof(struct i2c_hid_desc));
-		if (ret) {
-			dev_err(&ihid->client->dev, "hid_descr_cmd failed\n");
+		error = i2c_hid_read_register(ihid,
+					      ihid->wHIDDescRegister,
+					      &ihid->hdesc,
+					      sizeof(ihid->hdesc));
+		if (error) {
+			dev_err(&ihid->client->dev,
+				"failed to fetch HID descriptor: %d\n",
+				error);
 			return -ENODEV;
 		}
 	}
-- 
2.34.1.703.g22d0c6ccf7-goog

