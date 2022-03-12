Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4354D719D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 00:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbiCLXzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 18:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbiCLXz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 18:55:29 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDA84BFCB;
        Sat, 12 Mar 2022 15:54:23 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id n11so4783813qtk.4;
        Sat, 12 Mar 2022 15:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6reENKjLxzVDDzWxixRXSsX85fERB7cMHTFnI3v6Gw0=;
        b=gjtPC0ZMnIJEpnRYZJg3NOu3Id9FNM24ALMjIg8tUHcqeeIaRU7aYzQc2t8MqK1F5f
         fKWTW/BCXEmdH9sAAxHH0GmWyvd2/uxeKR8JPRAuiHuV3SHm8F2riqB/kNe1xZee7hw4
         CMEwlRoInImtTckeLiw9miybgNUFvvw/4BDtnEpULITdKQ+9rmE6BgEy8strkOPBmRPk
         zjicm/4ZmKZ9F5QtipS7rMX+eTsD++jROdlAlrRsVl8MEinOlON/5cuiMz0/jz38fp1o
         pT5zwzosAXjIsogDEfjiW/3YTP0NzXvlZDk2cIF35LxTJ/vzD3P58Xc5Sl8SC35OReUe
         MrbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6reENKjLxzVDDzWxixRXSsX85fERB7cMHTFnI3v6Gw0=;
        b=FW2xDWZ8diz6vcIOZO4M7a/WSR5zbCUTn3Q9MDwaoRn2APMOjq3czjtYoz9Ab4FLaH
         NhA1lkagGi8ASHdCNX9KgYTu+hZHhO+Z2w07sBpfkXCEYZS1TUFSG3I2PQW/oXRlbDSm
         VrMhmudsI2eJOJEFgJDWoYasGzm50Orz6eBrdGybCf4Dta2GYSoZVPBsNJpb8/ZYyIif
         xz7dsqESucWVfWTpEWm6oxVV8YPIsZ/H9O7zgkWyothEcu9XQdKhHDUPujE2SUw0ZkhO
         12Ll+mhOiS4tts324m0NfxNVi+fRMbYZOGNu9uXD8NoWPcBdMyQKuvDs1WhSJv18tpl5
         0dww==
X-Gm-Message-State: AOAM531f1pJGq43srLpcHoLaX/0qbqN73JdtC1GTDKvpIbodAKD/AqH+
        DLXN4rUOe2YO/lpH3O6utw==
X-Google-Smtp-Source: ABdhPJy8V1NMTjaQSgICIZ7UShH/xICewg2gzvsdlr69/kgsxNoG7tBpMn6aCLWALZm+nKfiq/hJGQ==
X-Received: by 2002:a05:622a:191:b0:2e1:a2c8:b295 with SMTP id s17-20020a05622a019100b002e1a2c8b295mr13732010qtw.652.1647129262758;
        Sat, 12 Mar 2022 15:54:22 -0800 (PST)
Received: from arch.. ([2607:fb90:975:db95:8e89:a5ff:fe6f:56d3])
        by smtp.gmail.com with ESMTPSA id e18-20020a05620a12d200b0066393782c89sm6373071qkl.64.2022.03.12.15.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Mar 2022 15:54:22 -0800 (PST)
From:   Daniel Bomar <dbdaniel42@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Bomar <dbdaniel42@gmail.com>
Subject: [PATCH] HID: microsoft: Report Xbox Guide and Back buttons on Xbox One S controller
Date:   Sat, 12 Mar 2022 17:52:30 -0600
Message-Id: <20220312235230.7498-1-dbdaniel42@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Daniel Bomar <dbdaniel42@gmail.com>
---
 drivers/hid/hid-microsoft.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
index 071fd093a5f4..19dc0a4eb38a 100644
--- a/drivers/hid/hid-microsoft.c
+++ b/drivers/hid/hid-microsoft.c
@@ -27,6 +27,7 @@
 #define MS_DUPLICATE_USAGES	BIT(5)
 #define MS_SURFACE_DIAL		BIT(6)
 #define MS_QUIRK_FF		BIT(7)
+#define MS_XBOX			BIT(8)
 
 struct ms_data {
 	unsigned long quirks;
@@ -275,6 +276,16 @@ static int ms_event(struct hid_device *hdev, struct hid_field *field,
 		return 1;
 	}
 
+	if (quirks & MS_XBOX) {
+		if (usage->hid == 0xc0223) {
+			input_report_key(input, BTN_MODE, value);
+			return 1;
+		} else if (usage->hid == 0xc0224) {
+			input_report_key(input, BTN_SELECT, value);
+			return 1;
+		}
+	}
+
 	return 0;
 }
 
@@ -447,7 +458,7 @@ static const struct hid_device_id ms_devices[] = {
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, 0x091B),
 		.driver_data = MS_SURFACE_DIAL },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_XBOX_ONE_S_CONTROLLER),
-		.driver_data = MS_QUIRK_FF },
+		.driver_data = MS_QUIRK_FF | MS_XBOX },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_8BITDO_SN30_PRO_PLUS),
 		.driver_data = MS_QUIRK_FF },
 	{ }
-- 
2.35.1

