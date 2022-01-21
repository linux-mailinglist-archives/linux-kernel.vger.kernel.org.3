Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3AF1495BCC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 09:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345918AbiAUIV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 03:21:29 -0500
Received: from mail-ma1ind01olkn0161.outbound.protection.outlook.com ([104.47.100.161]:8352
        "EHLO IND01-MA1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233264AbiAUIV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 03:21:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=foiIR3e7jIkuAblmNIjdgedrhnBLdBzASJTm86TWe8lDLWwGW8XJDtQ1nrXEev5CXV+HYKu8IzNlOKmfNpM0HcTao9F5dCWOE8wLkKz8QKEL9TJNY4LD8lotLIqWyddxCNHvIVtObrnvv1/xpc6WKR+BWOib7GNQ3hQ2BYUrc05N9bU5JQd6FqkPP1eyLoGf3Kr/hS/CiHPRY4q+wiF3znguBrToVgqWGEOVoVoGz/3gX123iv8osah7qw7kgCoDMgLYoOZhXgmkqZhbLtKPYxg19S8xWRqbnh2FUaUYG5pP/2JGxihlKM/cfjBXRscsIyS9vuPE88GOBKV8z/QZYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2xEJg5lAvRAf9MnaHNNG/43w0bTMk7LDhCTq6RGs0M=;
 b=lfhteAfmRNLtjrkLfGgWFiBIeDEyT5wH9NifH9WkS8h3L9YZQ1k+WwdJB5BHpU3L0Q931nKCrLYLRlmj1Cqshkxft8u5UxmipNbkgVXTjhQFpMEi4WEYiOq1PVJ7AR7lYeos7GKdwLCYpPyBu0t9vAbWecPGzl1HnGPHmu+K6nWFyQOvuObSoXlJeafz8VLdiriyX0gOHaDWHf9A1cylBDf1SubKn7VEzMqI9Uk6Yu+2SjXEA9/lrMZXjR8OW0e66pZH4819x8dinhZwBmstdtfOmr5jvACJBClTfU4oTsCuS2DI2ZQ1I/GDdAQWvvYM5mZPAkAc89qN6e5RqmVxLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2xEJg5lAvRAf9MnaHNNG/43w0bTMk7LDhCTq6RGs0M=;
 b=r4egJFFho7mkftoV33YacqgtxWT9wiSEc7N/epYVlT2VaCh/P9AzgBN7pvEIB9W40dk0THcb/1TVj0c9QKGv7KihOIEFqzNr3KuubI5ZpqBaKQeBHOSiwEW1YdGFmTQUwPWh2BvRF5sgN431TJSCVdp/gV6xbmFPYGi/EKzz5dJy0LmZ3kcjDw/lKi3BaE93f6gxuk3y25JdQjhjc6ty+ahGFTm46oT8W3EVCQ7yYT5+sTzQwpvhcAMfjEqn5R1gh2kzVwfxG8gAc51IZ4FqK5icMfGJEWRtn0nHHwyWPLAucF4gi4a/g9f75kU2zOQmZ3ClLQC7Fm6NfBRksHzhZQ==
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13)
 by BM1PR01MB2610.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:49::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Fri, 21 Jan
 2022 08:21:23 +0000
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d19b:7cd1:3760:b055]) by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d19b:7cd1:3760:b055%6]) with mapi id 15.20.4909.010; Fri, 21 Jan 2022
 08:21:22 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     "jikos@kernel.org" <jikos@kernel.org>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC:     "paul@mrarm.io" <paul@mrarm.io>, Aun-Ali Zaidi <admin@kodeit.net>,
        Orlando Chamberlain <redecorating@protonmail.com>
Subject: [PATCH 1/3] Add support for keyboard backlight on certain T2 Macs.
Thread-Topic: [PATCH 1/3] Add support for keyboard backlight on certain T2
 Macs.
Thread-Index: AQHYDp/gEgs/X0xxKEGfanAHjm24DA==
Date:   Fri, 21 Jan 2022 08:21:22 +0000
Message-ID: <5144E65F-9CFB-464B-8895-43DC3831F253@live.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [eNbaXPOwTJhJ/Ltr2Vw5ysIoyh61ME6rMDN2Ri57x1NQA+2tw/G/ieSz6WCkIfl2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a0e9bf2-d95b-4af9-17a3-08d9dcb70290
x-ms-traffictypediagnostic: BM1PR01MB2610:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QvrMrEHyUpFneyJycgxh/te1PM0TihAks1MvBb4q3Hqina7ySwY4cmhy2CxaYdbOlo/sn3HqqL/fvGAWQ8OuWBr1swTa12oJwWGyRDBsEcLCUTQgYzdwNoGHl5SdxiccZJu3W7vv+wXIHCaOkv1pbpnhBQ0yXgptgPSkzsOfTUsqUbkpJiLZ5Viz9/+S81ZvRBhPioItbVmi/ojLXkxUXUjCSjNQC8tcMGRuFNVP4aQaLvnlD4QQcjgam9SBsIZ5Wx/7YElVcv1rNHP09DUSNV8AmJXhQYulwJaz7fdrDMUFqoYQ0/aCCxesd3Co/vwOL+s96LhFQMcYbIT3R0LTBz4BLVBwYTZtLTvaJeGEpRXv3UlFYvoM6/zBkO3KEIwKymqFkwoGflDuf9M4lTZAHZZqoWcDIo8/R4aKujUAY+43QzfDzmp+12+48/I2g6VdmPhDjyBKsyzTJuD1BAHeBTuphRgKp2b23UW6KbEOnPm060/y+0TRTWuL6oze2HwlAxB6/6XZYni3VNAN/oVIXR6V/0/cZ8DtbDDVLKjALTpavGiBfVIQSn66f/yTJB4ujxGmZQwlcFsokEl4NPHkmg==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xo8//27bNri1UGUcF/gCuXWRZIuOQi2Hldy8jRqqTAOXNPwO/31CDAhxSJeo?=
 =?us-ascii?Q?u07n68+UqanaEzzH34sTYv0EFA+qBiieA8rGSwwwkpo3t1pRVQfOzgAXN5wa?=
 =?us-ascii?Q?ku0MK6e8URwPTMhM3THvSjZU9ALZRbBFjFSx/npCszzG8RV4Aua4OYfvDUNa?=
 =?us-ascii?Q?hpzG8muVQMbd96zsGEvM43Om0CW6eGjoU/J3acDxO1iD9Pvoj07Y2IBWGEIo?=
 =?us-ascii?Q?KWfk5H181mh3xiSBMSmBMMqvjOTFBK1BF2z7Mpucg3+5xCPzmvoCOb+9++IJ?=
 =?us-ascii?Q?Zmwgxvc8J+3YyOLvcFC4aPNkjb31rHV6kbZ06drcxyyaf9OA5TzRO0PHy7I2?=
 =?us-ascii?Q?0qaHbMF1GOM9X8F50ImToWodi0QnTI5H812qLIRzBMkEYujz7PNji8DCsm0G?=
 =?us-ascii?Q?8LGb7L97KnnfkNCqpyFpiW0hoji2F0pjnuPq5RymT/cqf0KUmKJ6ObiO9TfI?=
 =?us-ascii?Q?NdL17O2qtkWprdqnh3TK65GNQN06ExwRwk2YzeTICRozfQwxZPIcItQpM86K?=
 =?us-ascii?Q?+JiRM4pRJABcKJGcVPGYud2lDoUBUf+3cv7p30qbMeZFzG9a0PGAW7Z1Yr3U?=
 =?us-ascii?Q?NxqXRcbsatkLlUOwVXl3/YTXpvRUW/+GwDgjRxWj/50ONmu5PEFg2B4Q5gpt?=
 =?us-ascii?Q?kZqqy1l+JdjmKhA3NXe9CU+ChXbd5034rRHOsvBALE0vWivpMj8NcPcDSXqP?=
 =?us-ascii?Q?soyqeyXxWSQEIcmI8ltP0S73PDKdTWBMSovOvbeYDe683zzGRG3bp56Kd8b0?=
 =?us-ascii?Q?KLJROk0YRjSuVOCsm8nIf7fDxOpfM1HniS/KgqTocH1jx92ctZ5od66KM8eQ?=
 =?us-ascii?Q?Sz+4yXtZB/sU2xz3y3CnVKMK3ECEfE0JYJ9Fnc/7IpKFA2d0JNJfmLa/prQz?=
 =?us-ascii?Q?gLJT8cw36m0LCr5hatClTK/Ng16rBizN/zn2DL12p3+nZlVgw6ntYnDxCC1+?=
 =?us-ascii?Q?0QAOoxWaE4O4hxyhDnbpwljEnTUwJifPAB/OSuDMhFpchjIhdK5EYo9K8u07?=
 =?us-ascii?Q?HymxxSYfjdagBI4n+LHRR65ASg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D2717EE247DD1947A1505CB39BD9B8A0@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a0e9bf2-d95b-4af9-17a3-08d9dcb70290
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2022 08:21:22.9290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BM1PR01MB2610
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Pawlowski <paul@mrarm.io>

This patch introduces the requisite plumbing for supporting keyboard
backlight on T2-attached, USB exposed models. The quirk mechanism was
used to reuse the existing hid-apple driver.

Signed-off-by: Paul Pawlowski <paul@mrarm.io>
Signed-off-by: Aun-Ali Zaidi <admin@kodeit.net>
Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 drivers/hid/hid-apple.c | 125 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 24802a4a6..c22d445a9 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -7,6 +7,7 @@
  *  Copyright (c) 2005 Michael Haboustak <mike-@cinci.rr.com> for Concept2=
, Inc
  *  Copyright (c) 2006-2007 Jiri Kosina
  *  Copyright (c) 2008 Jiri Slaby <jirislaby@gmail.com>
+ *  Copyright (c) 2019 Paul Pawlowski <paul@mrarm.io>
  */
=20
 /*
@@ -33,6 +34,7 @@
 /* BIT(7) reserved, was: APPLE_IGNORE_HIDINPUT */
 #define APPLE_NUMLOCK_EMULATION	BIT(8)
 #define APPLE_RDESC_BATTERY	BIT(9)
+#define APPLE_BACKLIGHT_CTL	0x0200
=20
 #define APPLE_FLAG_FKEY		0x01
=20
@@ -61,6 +63,12 @@ MODULE_PARM_DESC(swap_fn_leftctrl, "Swap the Fn and left=
 Control keys. "
 		"(For people who want to keep PC keyboard muscle memory. "
 		"[0] =3D as-is, Mac layout, 1 =3D swapped, PC layout)");
=20
+struct apple_sc_backlight {
+	struct led_classdev cdev;
+	struct hid_device *hdev;
+	unsigned short backlight_off, backlight_on_min, backlight_on_max;
+};
+
 struct apple_sc {
 	struct hid_device *hdev;
 	unsigned long quirks;
@@ -68,6 +76,7 @@ struct apple_sc {
 	unsigned int fn_found;
 	DECLARE_BITMAP(pressed_numlock, KEY_CNT);
 	struct timer_list battery_timer;
+	struct apple_sc_backlight *backlight;
 };
=20
 struct apple_key_translation {
@@ -76,6 +85,20 @@ struct apple_key_translation {
 	u8 flags;
 };
=20
+struct apple_backlight_config_report {
+	u8 report_id;
+	u8 version;
+	u16 backlight_off, backlight_on_min, backlight_on_max;
+};
+
+struct apple_backlight_set_report {
+	u8 report_id;
+	u8 version;
+	u16 backlight;
+	u16 rate;
+};
+
+
 static const struct apple_key_translation apple2021_fn_keys[] =3D {
 	{ KEY_BACKSPACE, KEY_DELETE },
 	{ KEY_ENTER,	KEY_INSERT },
@@ -530,6 +553,105 @@ static int apple_input_configured(struct hid_device *=
hdev,
 	return 0;
 }
=20
+static bool apple_backlight_check_support(struct hid_device *hdev)
+{
+	int i;
+	unsigned int hid;
+	struct hid_report *report;
+
+	list_for_each_entry(report, &hdev->report_enum[HID_INPUT_REPORT].report_l=
ist, list) {
+		for (i =3D 0; i < report->maxfield; i++) {
+			hid =3D report->field[i]->usage->hid;
+			if ((hid & HID_USAGE_PAGE) =3D=3D HID_UP_MSVENDOR && (hid & HID_USAGE) =
=3D=3D 0xf)
+				return true;
+		}
+	}
+
+	return false;
+}
+
+static int apple_backlight_set(struct hid_device *hdev, u16 value, u16 rat=
e)
+{
+	int ret =3D 0;
+	struct apple_backlight_set_report *rep;
+
+	rep =3D kmalloc(sizeof(*rep), GFP_KERNEL);
+	if (rep =3D=3D NULL)
+		return -ENOMEM;
+
+	rep->report_id =3D 0xB0;
+	rep->version =3D 1;
+	rep->backlight =3D value;
+	rep->rate =3D rate;
+
+	ret =3D hid_hw_raw_request(hdev, 0xB0u, (u8 *) rep, sizeof(*rep),
+				 HID_OUTPUT_REPORT, HID_REQ_SET_REPORT);
+
+	kfree(rep);
+	return ret;
+}
+
+static int apple_backlight_led_set(struct led_classdev *led_cdev,
+	enum led_brightness brightness)
+{
+	struct apple_sc_backlight *backlight =3D container_of(led_cdev,
+							    struct apple_sc_backlight, cdev);
+
+	return apple_backlight_set(backlight->hdev, brightness, 0);
+}
+
+static int apple_backlight_init(struct hid_device *hdev)
+{
+	int ret;
+	struct apple_sc *asc =3D hid_get_drvdata(hdev);
+	struct apple_backlight_config_report *rep;
+
+	if (!apple_backlight_check_support(hdev))
+		return -EINVAL;
+
+	rep =3D kmalloc(0x200, GFP_KERNEL);
+	if (rep =3D=3D NULL)
+		return -ENOMEM;
+
+	ret =3D hid_hw_raw_request(hdev, 0xBFu, (u8 *) rep, sizeof(*rep),
+				 HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
+	if (ret < 0) {
+		hid_err(hdev, "backlight request failed: %d\n", ret);
+		goto cleanup_and_exit;
+	}
+	if (ret < 8 || rep->version !=3D 1) {
+		hid_err(hdev, "backlight config struct: bad version %i\n", rep->version)=
;
+		ret =3D -EINVAL;
+		goto cleanup_and_exit;
+	}
+
+	hid_dbg(hdev, "backlight config: off=3D%u, on_min=3D%u, on_max=3D%u\n",
+		rep->backlight_off, rep->backlight_on_min, rep->backlight_on_max);
+
+	asc->backlight =3D devm_kzalloc(&hdev->dev, sizeof(*asc->backlight), GFP_=
KERNEL);
+	if (!asc->backlight) {
+		ret =3D -ENOMEM;
+		goto cleanup_and_exit;
+	}
+
+	asc->backlight->hdev =3D hdev;
+	asc->backlight->cdev.name =3D "apple::kbd_backlight";
+	asc->backlight->cdev.max_brightness =3D rep->backlight_on_max;
+	asc->backlight->cdev.brightness_set_blocking =3D apple_backlight_led_set;
+
+	ret =3D apple_backlight_set(hdev, 0, 0);
+	if (ret < 0) {
+		hid_err(hdev, "backlight set request failed: %d\n", ret);
+		goto cleanup_and_exit;
+	}
+
+	ret =3D devm_led_classdev_register(&hdev->dev, &asc->backlight->cdev);
+
+cleanup_and_exit:
+	kfree(rep);
+	return ret;
+}
+
 static int apple_probe(struct hid_device *hdev,
 		const struct hid_device_id *id)
 {
@@ -565,6 +687,9 @@ static int apple_probe(struct hid_device *hdev,
 		  jiffies + msecs_to_jiffies(APPLE_BATTERY_TIMEOUT_MS));
 	apple_fetch_battery(hdev);
=20
+	if (quirks & APPLE_BACKLIGHT_CTL)
+		apple_backlight_init(hdev);
+
 	return 0;
 }
=20
--=20
2.25.1


