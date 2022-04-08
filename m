Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32784F97B2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 16:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236714AbiDHOLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 10:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232875AbiDHOLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 10:11:36 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B884330B96D;
        Fri,  8 Apr 2022 07:09:32 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id o15so10694871qtv.8;
        Fri, 08 Apr 2022 07:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4TNi/yaqFQE6T+l9n5l5tGxRgXhjywuUJADf5dPUVmA=;
        b=caS4zbIr1sgZEa+jj88EO96nUbZ42WUbjDVNUTYdItlrbJfnl3mhl2acuW5CFx0YQN
         YFjhRM7y9Sx3K7u9+sovWBxzcPvf/ERmxqd3/onBu8jehvNHSlZL6pLlO6DfWs5iZ8rr
         6Tjfy/h48PNwguNYEyv1E2Y8VwMHIM55cUivcLRWxQNXDaaFOAv3jbQJ3t/Clrx0udzV
         KqT1m0ygYzsVI7N+M0dTi8UMYpx0+rshvD1zR/aAG2f4xjRDSUPS+JFJhrE/8BAiARGT
         20mXyQNLpo4ELBFj8bT41TC6G90FcJqt55yK1heGyAoNY5K4VLJmW7PhcJTGGdWVB77g
         PdEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4TNi/yaqFQE6T+l9n5l5tGxRgXhjywuUJADf5dPUVmA=;
        b=GaayfsGdCZdr6Hg8LxPUiI1vSdOxHUxCb+amqxpu93JhXA40Iz/Ec1Jg0XBlCYMFqQ
         YNdqm+cYeKyWsOzqmtMGTEF1c1eB8pBnB1NBFsRb8RPXQvLrL/qJICGimQqeVXEWSHGJ
         bCLNk6NZff5BpagFsHxIPCftR4bMYlSHoOlJNXrX5bqTkDDItgQoX+zg1h42uEY1bAJc
         8xnTdmR3sBmWcGxiVaqtLHwsu3RlWIiOciwRDPEdDrYoJZlzswaSWjpJPm0oRgIS1TZ4
         Tr30nWpvxpU88pfB8Vx+Cbr63bPf/86rD8PByuJqDSGP/L+fDohQ/+KdrTok90VnQ5FY
         4Uqg==
X-Gm-Message-State: AOAM530WsMFpCofMNLioDdEszepqRizuOHBvjMgUfTMCeaVLJAvV7q7H
        OKruE/W+AcuiA3AEj1kEmhWNJ4hDzsM6
X-Google-Smtp-Source: ABdhPJxK4h9DfpyeCgGMnHuVkat9kpG7atAGqVV+gcddA6jpxnLrymZr7loATIuJ//dzG+kTRt8CKA==
X-Received: by 2002:ac8:454f:0:b0:2eb:d22b:934b with SMTP id z15-20020ac8454f000000b002ebd22b934bmr6430578qtn.269.1649426971750;
        Fri, 08 Apr 2022 07:09:31 -0700 (PDT)
Received: from arch.. ([2607:fb90:96c:82d2:8e89:a5ff:fe6f:56d3])
        by smtp.gmail.com with ESMTPSA id o13-20020ac87c4d000000b002e1e732dea5sm18474280qtv.70.2022.04.08.07.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 07:09:31 -0700 (PDT)
From:   Daniel Bomar <dbdaniel42@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Bomar <dbdaniel42@gmail.com>
Subject: [PATCH] HID: microsoft: Fix button/axis mapping for Xbox One S Controller
Date:   Fri,  8 Apr 2022 09:09:02 -0500
Message-Id: <20220408140902.15966-1-dbdaniel42@gmail.com>
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

Remaps several buttons and axes to match how these are mapped in the
xpad driver (same controller over USB).

This is also how they are documented to be mapped in
Documentation/input/gamepad.rst
---
 drivers/hid/hid-microsoft.c | 73 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 72 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
index 071fd093a5f4..903e09a3d898 100644
--- a/drivers/hid/hid-microsoft.c
+++ b/drivers/hid/hid-microsoft.c
@@ -27,6 +27,7 @@
 #define MS_DUPLICATE_USAGES	BIT(5)
 #define MS_SURFACE_DIAL		BIT(6)
 #define MS_QUIRK_FF		BIT(7)
+#define MS_XBOX			BIT(8)
 
 struct ms_data {
 	unsigned long quirks;
@@ -179,6 +180,70 @@ static int ms_surface_dial_quirk(struct hid_input *hi, struct hid_field *field,
 	return 0;
 }
 
+#define ms_map_abs_clear(c)	hid_map_usage_clear(hi, usage, bit, max, \
+					EV_ABS, (c))
+/*
+ * Remap buttons and axes on Xbox controllers over bluetooth so they match
+ * with the xpad driver (USB interface) and with mapping specified in
+ * Documentation/input/gamepad.rst
+*/
+static int ms_xbox_quirk(struct hid_input *hi, struct hid_usage *usage,
+		unsigned long **bit, int *max)
+{
+	int code;
+	switch (usage->hid & HID_USAGE_PAGE) {
+		/*
+		 * Remap "Xbox" and Select buttons from consumer page to gamepad buttons.
+		 * This allows these buttons to show up on the /dev/input/js* interface.
+		*/
+		case HID_UP_CONSUMER:
+			switch (usage->hid & HID_USAGE) {
+				case 0x223:
+					ms_map_key_clear(BTN_MODE);
+					return 1;
+				case 0x224:
+					ms_map_key_clear(BTN_SELECT);
+					return 1;
+			}
+			break;
+		/* These buttons do not physically exist on the controller. Ignore them. */
+		case HID_UP_BUTTON:
+			code = ((usage->hid - 1) & HID_USAGE) + BTN_GAMEPAD;
+			switch (code) {
+				case BTN_C:
+				case BTN_Z:
+				case BTN_TL2:
+				case BTN_TR2:
+					return -1;
+			}
+			break;
+		/* Remap right joystick to RX/RY */
+		case HID_UP_GENDESK:
+			switch (usage->hid) {
+				case HID_GD_Z:
+					ms_map_abs_clear(ABS_RX);
+					return 1;
+				case HID_GD_RZ:
+					ms_map_abs_clear(ABS_RY);
+					return 1;
+			}
+			break;
+		/* Remap left and right triggers from "gas" and "break" to RZ/Z */
+		case HID_UP_SIMULATION:
+			switch (usage->hid & HID_USAGE) {
+				case 0xc4:
+					ms_map_abs_clear(ABS_RZ);
+					return 1;
+				case 0xc5:
+					ms_map_abs_clear(ABS_Z);
+					return 1;
+			}
+			break;
+	}
+
+	return 0;
+}
+
 static int ms_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		struct hid_field *field, struct hid_usage *usage,
 		unsigned long **bit, int *max)
@@ -203,6 +268,12 @@ static int ms_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 			return ret;
 	}
 
+	if (quirks & MS_XBOX) {
+		int ret = ms_xbox_quirk(hi, usage, bit, max);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -447,7 +518,7 @@ static const struct hid_device_id ms_devices[] = {
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

