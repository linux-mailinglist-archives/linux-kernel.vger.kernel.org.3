Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3723492052
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 08:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245613AbiARH1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 02:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245410AbiARH1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 02:27:05 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160AEC061753;
        Mon, 17 Jan 2022 23:26:45 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id t32so13125619pgm.7;
        Mon, 17 Jan 2022 23:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C+G0JoqHk9MHyC89islo0SeNocmMaP3foPpVXqYBGEg=;
        b=RQ3cifQrU4BE4SCz9CJFD9YnebPR8r9bSam51P5U7Ex6EgaEWsV6J1KuB8rGvFGwiD
         xd8Qhyc0a7vUeJTc1xUX7fI9zG62DX4E1ZtAyD6JYvTiGk8Q0t8xvBl2q4zV1MBRPewv
         5blby41KXuVFpC9u8lxnxa0GzHqeLf6qjAwJI6/RH91d65bIGyDqbeSlnNRZRVan9qYR
         0SecNmy/nhJSRfsGnzFUjm9oBx2nKZl/QB14+nvH3igk0w2nhZGOkLebFO521wZdxgTl
         CZ9al1oVxaI3kcH50k+7RKIcBiXFFrsUoixlRG4/vgdDpRI1e2PqeWyKUSl6MxA8xkPN
         KuZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C+G0JoqHk9MHyC89islo0SeNocmMaP3foPpVXqYBGEg=;
        b=Cdrc5FO8rVd5iC0bY0BSw7S+sx0DEUkZYdUsjegjZujX6qUnTzwAw7oXztJfRvv/8Q
         bB/jf+MlK8CuMFHZ5aoJu7zlC7q5KfDVhoojN95w9m3Fnz7ynUvQ0Ue6kNkntU+DIRl7
         +XKLrsGTB6PmAw8DoGTm0CRxsUzsotslwZmpp4Ka/eBttV6m/fWKSXum3oRFowmLf5A2
         Fac613mzoDN6aLog9K4LDcKAmHggEFLbI71IdHkYgXHf9e8uPsEJeWNg8ZUasyzxC+UE
         7q8mPfOFROe9cWjDdMTWctav/ocZubfBvxVblQJw7c1IkdxjicS4Md6D1O4fUDSsMVJg
         yAIg==
X-Gm-Message-State: AOAM533OAOmqhxGPjhN8mNo2PH0Ufiljr9Fy8MSCtjZjFZD/K/Cupo+z
        T9WtBAbD7aQ0xRD/bU/J6dbn+yJrsAk=
X-Google-Smtp-Source: ABdhPJx6WF+fulXii6EXo6BdGddcJf2GslDii+H89qhlP4sEBDhyL8fhvirKm3h8MtrW79Hlo4tSGQ==
X-Received: by 2002:a05:6a00:1988:b0:4c3:b9cd:f09a with SMTP id d8-20020a056a00198800b004c3b9cdf09amr11725662pfl.2.1642490804460;
        Mon, 17 Jan 2022 23:26:44 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:bf2e:59:5029:f4c5])
        by smtp.gmail.com with ESMTPSA id y18sm11079816pfl.156.2022.01.17.23.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 23:26:43 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Angela Czubak <acz@semihalf.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/12] HID: i2c-hid: convert i2c_hid_execute_reset() to use i2c_hid_xfer()
Date:   Mon, 17 Jan 2022 23:26:24 -0800
Message-Id: <20220118072628.1617172-9-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
In-Reply-To: <20220118072628.1617172-1-dmitry.torokhov@gmail.com>
References: <20220118072628.1617172-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will allow us to drop i2c_hid_command() wrapper and get close
to removing __i2c_hid_command().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/i2c-hid/i2c-hid-core.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index da673e3f2910..1515fc892e61 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -105,7 +105,6 @@ struct i2c_hid_cmd {
 	.registerIndex = offsetof(struct i2c_hid_desc, wCommandRegister)
 
 /* commands */
-static const struct i2c_hid_cmd hid_reset_cmd =		{ I2C_HID_CMD(0x01) };
 static const struct i2c_hid_cmd hid_get_report_cmd =	{ I2C_HID_CMD(0x02) };
 
 /*
@@ -283,14 +282,6 @@ static int __i2c_hid_command(struct i2c_hid *ihid,
 	return i2c_hid_xfer(ihid, ihid->cmdbuf, length, buf_recv, data_len);
 }
 
-static int i2c_hid_command(struct i2c_hid *ihid,
-		const struct i2c_hid_cmd *command,
-		unsigned char *buf_recv, int data_len)
-{
-	return __i2c_hid_command(ihid, command, 0, 0, NULL, 0,
-				buf_recv, data_len);
-}
-
 static int i2c_hid_get_report(struct i2c_hid *ihid, u8 reportType,
 		u8 reportID, unsigned char *buf_recv, int data_len)
 {
@@ -455,13 +446,21 @@ static int i2c_hid_set_power(struct i2c_hid *ihid, int power_state)
 
 static int i2c_hid_execute_reset(struct i2c_hid *ihid)
 {
+	size_t length = 0;
 	int ret;
 
 	i2c_hid_dbg(ihid, "resetting...\n");
 
+	/* Prepare reset command. Command register goes first. */
+	*(__le16 *)ihid->cmdbuf = ihid->hdesc.wCommandRegister;
+	length += sizeof(__le16);
+	/* Next is RESET command itself */
+	length += i2c_hid_encode_command(ihid->cmdbuf + length,
+					 I2C_HID_OPCODE_RESET, 0, 0);
+
 	set_bit(I2C_HID_RESET_PENDING, &ihid->flags);
 
-	ret = i2c_hid_command(ihid, &hid_reset_cmd, NULL, 0);
+	ret = i2c_hid_xfer(ihid, ihid->cmdbuf, length, NULL, 0);
 	if (ret) {
 		dev_err(&ihid->client->dev, "failed to reset device.\n");
 		goto out;
-- 
2.34.1.703.g22d0c6ccf7-goog

