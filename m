Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D53051F97C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 12:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbiEIKR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 06:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbiEIKRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 06:17:48 -0400
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D292415C7
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 03:13:47 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id bq30so22912501lfb.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 03:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ip-fi.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SHCsC1uDLakwJtX7YsLeyfBSvYkKba8AoDt84Vx3l6w=;
        b=eImb/xFHwcJD0dVU2MKXjffJmbqfXGzoSz26SAoyTMwxwud310YnP1ykPV927FTlbl
         WeUDXTATM27OxAz74yYx021yoPt1G8n+O7ajy1ue2HUcGAu7y539OJ3Ek6VVSoNXzpOD
         z4GzsLnzG/lAJIJoh/LilUyKaitKrbSkHHDnlGgF/LYtaqC6gPHl/XvHBdUpw0dXVMGV
         8EVu7+fy3S85P79BEknTOiskgO05F77xssC7rGkII8U2wPwwOm2XexhCxx0TGVTwj3O7
         WcIrpdLuXybFkYvB1vPfUOQATdh12z8Sa9vF6odlBAVbhLqUwMdI1gXs/wJ2HcmtDwHs
         zK2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SHCsC1uDLakwJtX7YsLeyfBSvYkKba8AoDt84Vx3l6w=;
        b=3cFiglT7Nzl3gJXIN5mkx/cnrPqSirXbf5XyK1jauEikDOCTGEUO5td0QL9B5CNOa8
         NhxlGvt9YrzVG2m1mbd5EmXa6sPUwk23+Yp+Q46OsBX98iHjHFQhha2cxJmhDcoK2drr
         j9XS82W2HRAeHM49il8qxKlWT2P1j+QzTxYso/kociiufx3ASwgvaa+/kWCgieP2QuYn
         67TBrPec5C67GO56ZfJ+Um1MivN0Nwu85nMgiB0I9pWGK/so6QxDc8F1zOqJhmESxHTS
         NWCI6FD3DuCm/f8k0URYinxMq37jLCp3C3/ODX+sbiwtJXVYx/dg8rZ/bdpK/wmsJayn
         OgjQ==
X-Gm-Message-State: AOAM531SeRDgANw3Jj8opIwdjccZyJ9D4aKG+VgsNSZuz/EVdSIw3bhr
        mQi+pRUMv1YI/TPPI+Axc4TJuLO62NxkcF6+qFo=
X-Google-Smtp-Source: ABdhPJyekIVKSk0V6Fd2WaWbbA6eYP1X/7K/nNdayL4DYwvGAoBqXBD9M+MfPDvU/KgQu2Y47a4p6g==
X-Received: by 2002:a5d:640f:0:b0:20c:9be6:30c1 with SMTP id z15-20020a5d640f000000b0020c9be630c1mr12838289wru.273.1652090583920;
        Mon, 09 May 2022 03:03:03 -0700 (PDT)
Received: from localhost.localdomain ([45.152.183.54])
        by smtp.gmail.com with ESMTPSA id 67-20020a1c1946000000b003942a244f2csm19203107wmz.5.2022.05.09.03.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 03:03:03 -0700 (PDT)
From:   Johan Boger <jb@ip.fi>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, joe@perches.com,
        Johan Boger <jb@ip.fi>
Subject: [PATCH] staging: drivers: hid: hid-asus.c: Optimized input logic for keys
Date:   Mon,  9 May 2022 12:02:58 +0200
Message-Id: <20220509100258.24764-1-jb@ip.fi>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of calling asus_map_key_clear() function in each case,
we now set a temporary value and clear it after default.
Patch was checked by checkpatch and adjusted accordingly.

Signed-off-by: Johan Boger <jb@ip.fi>
---
 drivers/hid/hid-asus.c | 144 ++++++++++++++++++++++++++---------------
 1 file changed, 93 insertions(+), 51 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 08c9a9a60ae4..9c2080cd1de3 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -339,7 +339,7 @@ static int asus_raw_event(struct hid_device *hdev,
 		/*
 		 * Skip these report ID, the device emits a continuous stream associated
 		 * with the AURA mode it is in which looks like an 'echo'.
-		*/
+		 */
 		if (report->id == FEATURE_KBD_LED_REPORT_ID1 ||
 				report->id == FEATURE_KBD_LED_REPORT_ID2) {
 			return -1;
@@ -349,7 +349,7 @@ static int asus_raw_event(struct hid_device *hdev,
 			 * G14 and G15 send these codes on some keypresses with no
 			 * discernable reason for doing so. We'll filter them out to avoid
 			 * unmapped warning messages later.
-			*/
+			 */
 			if (data[1] == 0xea || data[1] == 0xec || data[1] == 0x02 ||
 					data[1] == 0x8a || data[1] == 0x9e) {
 				return -1;
@@ -359,10 +359,9 @@ static int asus_raw_event(struct hid_device *hdev,
 			/*
 			 * G713 and G733 send these codes on some keypresses, depending on
 			 * the key pressed it can trigger a shutdown event if not caught.
-			*/
-			if(data[0] == 0x02 && data[1] == 0x30) {
+			 */
+			if (data[0] == 0x02 && data[1] == 0x30)
 				return -1;
-			}
 		}
 
 	}
@@ -371,11 +370,10 @@ static int asus_raw_event(struct hid_device *hdev,
 		/*
 		 * CLAYMORE II keyboard sends this packet when it goes to sleep
 		 * this causes the whole system to go into suspend.
-		*/
+		 */
 
-		if(size == 2 && data[0] == 0x02 && data[1] == 0x00) {
+		if (size == 2 && data[0] == 0x02 && data[1] == 0x00)
 			return -1;
-		}
 	}
 
 	return 0;
@@ -393,7 +391,7 @@ static int asus_kbd_set_report(struct hid_device *hdev, u8 *buf, size_t buf_size
 	/*
 	 * The report ID should be set from the incoming buffer due to LED and key
 	 * interfaces having different pages
-	*/
+	 */
 	ret = hid_hw_raw_request(hdev, buf[0], dmabuf,
 				 buf_size, HID_FEATURE_REPORT,
 				 HID_REQ_SET_REPORT);
@@ -828,6 +826,7 @@ static int asus_input_mapping(struct hid_device *hdev,
 		int *max)
 {
 	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
+	int clear_key;
 
 	if (drvdata->quirks & QUIRK_SKIP_INPUT_MAPPING) {
 		/* Don't map anything from the HID report.
@@ -852,50 +851,73 @@ static int asus_input_mapping(struct hid_device *hdev,
 	/* ASUS-specific keyboard hotkeys and led backlight */
 	if ((usage->hid & HID_USAGE_PAGE) == HID_UP_ASUSVENDOR) {
 		switch (usage->hid & HID_USAGE) {
-		case 0x10: asus_map_key_clear(KEY_BRIGHTNESSDOWN);	break;
-		case 0x20: asus_map_key_clear(KEY_BRIGHTNESSUP);		break;
-		case 0x35: asus_map_key_clear(KEY_DISPLAY_OFF);		break;
-		case 0x6c: asus_map_key_clear(KEY_SLEEP);		break;
-		case 0x7c: asus_map_key_clear(KEY_MICMUTE);		break;
-		case 0x82: asus_map_key_clear(KEY_CAMERA);		break;
-		case 0x88: asus_map_key_clear(KEY_RFKILL);			break;
-		case 0xb5: asus_map_key_clear(KEY_CALC);			break;
-		case 0xc4: asus_map_key_clear(KEY_KBDILLUMUP);		break;
-		case 0xc5: asus_map_key_clear(KEY_KBDILLUMDOWN);		break;
+		case 0x10:
+			clear_key = KEY_BRIGHTNESSDOWN;		break;
+		case 0x20:
+			clear_key = KEY_BRIGHTNESSUP;		break;
+		case 0x35:
+			clear_key = KEY_DISPLAY_OFF;		break;
+		case 0x6c:
+			clear_key = KEY_SLEEP;			break;
+		case 0x7c:
+			clear_key = KEY_MICMUTE;		break;
+		case 0x82:
+			clear_key = KEY_CAMERA;			break;
+		case 0x88:
+			clear_key = KEY_RFKILL;			break;
+		case 0xb5:
+			clear_key = KEY_CALC;			break;
+		case 0xc4:
+			clear_key = KEY_KBDILLUMUP;		break;
+		case 0xc5:
+			clear_key = KEY_KBDILLUMDOWN;		break;
 
 		/* ASUS touchpad toggle */
-		case 0x6b: asus_map_key_clear(KEY_F21);			break;
+		case 0x6b:
+			clear_key = KEY_F21;		break;
 
 		/* ROG key */
-		case 0x38: asus_map_key_clear(KEY_PROG1);		break;
+		case 0x38:
+			clear_key = KEY_PROG1;		break;
 
 		/* Fn+C ASUS Splendid */
-		case 0xba: asus_map_key_clear(KEY_PROG2);		break;
+		case 0xba:
+			clear_key = KEY_PROG2;		break;
 
 		/* Fn+Space Power4Gear Hybrid */
-		case 0x5c: asus_map_key_clear(KEY_PROG3);		break;
+		case 0x5c:
+			clear_key = KEY_PROG3;		break;
 
 		/* Fn+F5 "fan" symbol on FX503VD */
-		case 0x99: asus_map_key_clear(KEY_PROG4);		break;
+		case 0x99:
+			clear_key = KEY_PROG4;		break;
 
 		/* Fn+F5 "fan" symbol on N-Key keyboard */
-		case 0xae: asus_map_key_clear(KEY_PROG4);		break;
+		case 0xae:
+			clear_key = KEY_PROG4;		break;
 
 		/* Fn+Ret "Calc" symbol on N-Key keyboard */
-		case 0x92: asus_map_key_clear(KEY_CALC);		break;
+		case 0x92:
+			clear_key = KEY_CALC;		break;
 
 		/* Fn+Left Aura mode previous on N-Key keyboard */
-		case 0xb2: asus_map_key_clear(KEY_PROG2);		break;
+		case 0xb2:
+			clear_key = KEY_PROG2;		break;
 
 		/* Fn+Right Aura mode next on N-Key keyboard */
-		case 0xb3: asus_map_key_clear(KEY_PROG3);		break;
+		case 0xb3:
+			clear_key = KEY_PROG3;		break;
 
 		default:
 			/* ASUS lazily declares 256 usages, ignore the rest,
-			 * as some make the keyboard appear as a pointer device. */
+			 * as some make the keyboard appear as a pointer device.
+			 */
 			return -1;
 		}
 
+		/* Clear temp key */
+		asus_map_key_clear(clear_key);
+
 		/*
 		 * Check and enable backlight only on devices with UsagePage ==
 		 * 0xff31 to avoid initializing the keyboard firmware multiple
@@ -907,31 +929,52 @@ static int asus_input_mapping(struct hid_device *hdev,
 
 		set_bit(EV_REP, hi->input->evbit);
 		return 1;
+
 	}
 
 	if ((usage->hid & HID_USAGE_PAGE) == HID_UP_MSVENDOR) {
 		switch (usage->hid & HID_USAGE) {
-		case 0xff01: asus_map_key_clear(BTN_1);	break;
-		case 0xff02: asus_map_key_clear(BTN_2);	break;
-		case 0xff03: asus_map_key_clear(BTN_3);	break;
-		case 0xff04: asus_map_key_clear(BTN_4);	break;
-		case 0xff05: asus_map_key_clear(BTN_5);	break;
-		case 0xff06: asus_map_key_clear(BTN_6);	break;
-		case 0xff07: asus_map_key_clear(BTN_7);	break;
-		case 0xff08: asus_map_key_clear(BTN_8);	break;
-		case 0xff09: asus_map_key_clear(BTN_9);	break;
-		case 0xff0a: asus_map_key_clear(BTN_A);	break;
-		case 0xff0b: asus_map_key_clear(BTN_B);	break;
-		case 0x00f1: asus_map_key_clear(KEY_WLAN);	break;
-		case 0x00f2: asus_map_key_clear(KEY_BRIGHTNESSDOWN);	break;
-		case 0x00f3: asus_map_key_clear(KEY_BRIGHTNESSUP);	break;
-		case 0x00f4: asus_map_key_clear(KEY_DISPLAY_OFF);	break;
-		case 0x00f7: asus_map_key_clear(KEY_CAMERA);	break;
-		case 0x00f8: asus_map_key_clear(KEY_PROG1);	break;
+		case 0xff01:
+			clear_key = BTN_1;		break;
+		case 0xff02:
+			clear_key = BTN_2;		break;
+		case 0xff03:
+			clear_key = BTN_3;		break;
+		case 0xff04:
+			clear_key = BTN_4;		break;
+		case 0xff05:
+			clear_key = BTN_5;		break;
+		case 0xff06:
+			clear_key = BTN_6;		break;
+		case 0xff07:
+			clear_key = BTN_7;		break;
+		case 0xff08:
+			clear_key = BTN_8;		break;
+		case 0xff09:
+			clear_key = BTN_9;		break;
+		case 0xff0a:
+			clear_key = BTN_A;		break;
+		case 0xff0b:
+			clear_key = BTN_B;		break;
+		case 0x00f1:
+			clear_key = KEY_WLAN;		break;
+		case 0x00f2:
+			clear_key = KEY_BRIGHTNESSDOWN;	break;
+		case 0x00f3:
+			clear_key = KEY_BRIGHTNESSUP;	break;
+		case 0x00f4:
+			clear_key = KEY_DISPLAY_OFF;	break;
+		case 0x00f7:
+			clear_key = KEY_CAMERA;		break;
+		case 0x00f8:
+			clear_key = KEY_PROG1;		break;
 		default:
 			return 0;
 		}
 
+		/* Clear temp key */
+		asus_map_key_clear(clear_key);
+
 		set_bit(EV_REP, hi->input->evbit);
 		return 1;
 	}
@@ -1100,11 +1143,10 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		goto err_stop_hw;
 	}
 
-	if (drvdata->tp) {
+	if (drvdata->tp)
 		drvdata->input->name = "Asus TouchPad";
-	} else {
+	else
 		drvdata->input->name = "Asus Keyboard";
-	}
 
 	if (drvdata->tp) {
 		ret = asus_start_multitouch(hdev);
@@ -1131,8 +1173,8 @@ static void asus_remove(struct hid_device *hdev)
 }
 
 static const __u8 asus_g752_fixed_rdesc[] = {
-        0x19, 0x00,			/*   Usage Minimum (0x00)       */
-        0x2A, 0xFF, 0x00,		/*   Usage Maximum (0xFF)       */
+	0x19, 0x00,			/*   Usage Minimum (0x00)       */
+	0x2A, 0xFF, 0x00,		/*   Usage Maximum (0xFF)       */
 };
 
 static __u8 *asus_report_fixup(struct hid_device *hdev, __u8 *rdesc,
-- 
2.30.2

