Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04944A83B9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 13:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350511AbiBCMVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 07:21:20 -0500
Received: from mail-bmxind01olkn2060.outbound.protection.outlook.com ([40.92.103.60]:56032
        "EHLO IND01-BMX-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229379AbiBCMVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 07:21:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DtnwqqrpkxWmgCSRYAgNa3uGHkQQcW8LRLN4KFvFpMzrS1P7WZ9335eEEQMtU+jERkWGXf/iKZGizNs/9/jgpxXx+8YS8G3PvIE6uu1wpbHAwBmyHNz8I4RVs6jJeVMT9fPosCoQYNYzmEaHtGb/P8TtWmOlBk4uuH1uGpM+BmvOCRy6VNLWHpl4hY3BSEEgWa3VLJ4rUeIdBz4BCtGvne2LI4+eik4/UtC46MqAhl4knJcY8r4eHTZea1QFma15hBsiAtDyeN6bz5Tq4mCu8aFGV0PUhSSjs3UX4kYnXR4ft8L0EX2/vyDE8RVLfcIhMw0hZLbyJNUvgPJP95QzAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7is92ihNGd6dPnvuiggr8at82p5e/oKjnfVvb6maXk=;
 b=bLC1PHpNo4zSF9zr4SfLtA/5zbtnhg7+3E9oQ+xvSYOD3r7s+rN62dA3DLGfO8im+2cqCwYgG8UwAeGf7REA94I+6skyQPNwxI7cbqpnu69ocyfWOepUHVBMqHC7a4SMBNfZ4tSOKn8odETMWqcILC5cUEzWidXJWa9sLbLjNE2QCwEoOzWKA3RUkO8BtihxkgfDofqFtNEMD36Z5+8DwP+eTHnTzjTe88AWv3uj4Ttg//cYGzX5qmF/bd/nM7mYLxDgRXapWnHCezWOAY7AR27j0dSMK8nzAmr2L1ldEpXZEQ7djD/hVfUqXA7xkV09ja14hSLKlgTojds2tdCTsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7is92ihNGd6dPnvuiggr8at82p5e/oKjnfVvb6maXk=;
 b=MaBFQccwXhQ2vaW7Yu1gGEWBfKJbHSpgXxma17y3zDU+G8yl2sJgUboHfhIO8aiS7Y5aO4+xxP61X0W6mBMDRIEFdO4FrV5vV6jFUcqkHOc+7LGoprK61KE/bpkGT0UCc/949B7di+pGEhmxgxs15ahQVigLVOG7H+Ctu1B1MpDlN66OSws5gBgDErReKZZNXLpL0ngI//pFVgu4G+K0edEqJSqXx7daL5q8tJvjp71houxCnUu6oNlDjrs4MWlzRN7tbemKPy9zXZ0LGgBOEsfoGBwoLCIYVeIJ+QB3sblEDVRGNBc4SF4CLLt8+n/UjyMoLjaCN3sEnnmv/r+m1w==
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13)
 by MAXPR01MB2320.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:59::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Thu, 3 Feb
 2022 12:21:13 +0000
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d19b:7cd1:3760:b055]) by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d19b:7cd1:3760:b055%9]) with mapi id 15.20.4951.012; Thu, 3 Feb 2022
 12:21:13 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     "jkosina@suse.cz" <jkosina@suse.cz>,
        Jiri Kosina <jikos@kernel.org>,
        "alexhenrie24@gmail.com" <alexhenrie24@gmail.com>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC:     "paul@mrarm.io" <paul@mrarm.io>, Aun-Ali Zaidi <admin@kodeit.net>,
        Orlando Chamberlain <redecorating@protonmail.com>
Subject: [PATCH v3 1/3] HID: apple: Add support for keyboard backlight on
 certain T2 Macs.
Thread-Topic: [PATCH v3 1/3] HID: apple: Add support for keyboard backlight on
 certain T2 Macs.
Thread-Index: AQHYGPiIph7UJPakWU+x6MdA3b9YOw==
Date:   Thu, 3 Feb 2022 12:21:13 +0000
Message-ID: <D0C26284-966C-4581-BE37-78A6B0B367BB@live.com>
References: <67E7EA8B-CF21-4794-B7B4-96873EE70EF6@live.com>
 <1088ECFE-B356-4731-AC8A-09A4421DD7D1@live.com>
In-Reply-To: <1088ECFE-B356-4731-AC8A-09A4421DD7D1@live.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [eeUxHezq7LijH3/azKQIrHRgjvQ4BZPrxouD7lvj9xgn2k28AS1Tq1tjNOkkibvG]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fdd86464-bb04-4490-2aee-08d9e70fab4f
x-ms-traffictypediagnostic: MAXPR01MB2320:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GpMzPP32Ti3tTCsLQU6MLRC0ihxEQJGh3J0AT+ElCHoWKKuhD2g9vf4DKlerz6ykVEzoyMx6DdLzsKx8SdicRsqH0rwsuv+oUuUwTKpk+fdHzDPbNPxifvHArf6zIm8uROKkpEq5M7oOcthVD4A4dpDZTaKUsJlu557LRCHQC0g/2lQ2KskRc8EAglgpQvSzLc5HJXQ+gjfhcku4X20P3f0p39ulfBJF/0GDe4RpZY2WNtuF5gRJibQhbNZHxc9oLytPe+WYPOh4gkuE6u1y83gYnpltcYOAqWwEQFm8uSgpqdNvP2XLwGidxNDxWr21cX1uYYmivcBucKtE8NrReW/ba3NDpAODx5jzsZUAfhvSDHzOYtpIKS8v+XQ2Ur6GYSHMEFZGJ+c0HZ9KcyYuM4/TpWtiU7NBnQY6KMDaf/zHFGtuYobwM3hCIPU7c+DJs5tUHeR7F78MpCGYNJKaEzT2IVJoM+Q3drzBh83XPCjNgdI2mpNCjo0JdZYS0V79zndynzv4kk0YeF2eDM+fr78y37BFezdOECYWubBBDgNubfbMH2hL00R7WpMkQYpag3GFHbWiXbFUAzQjxGfpng==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qYX3W4q3uX6QD8c5tbECTcw7T9M+zkMKImvvJSIfK3O2hWWvCjIpMzaHHBce?=
 =?us-ascii?Q?wktyo7di5jkIUODjQc3hR7B0SompqsOKZ1DQqQf4gpwSmw/Jrt5j1KvAqs3G?=
 =?us-ascii?Q?MGrZViBzjHnRzhITaBygpTTSp1R8Qizj8tCoJ025AdGxkQblon+zAI5wrdP2?=
 =?us-ascii?Q?Jf+GaQZwMs3S6vsMmeGF7DZA2f40PvgXBCv+1X0kXyJhAcwGMKwJzOtHvcIF?=
 =?us-ascii?Q?yDYG5LCFRcLz2YlOYRQzDLZ2kqWxb6RcmlgpBKFLCh0ScnQUJvUysJLkDe78?=
 =?us-ascii?Q?KQX6toVWt6gpl0r+6R7EzGb9qeDl7Sy7zvHLobTAjvjMqgDUtWYK2pZZX2S5?=
 =?us-ascii?Q?g7dHqlbflN/S9m1BtGUG7ik+QM7+0SJDnOIO5MKJ9I3MkAFgvCNKMoXcR0/K?=
 =?us-ascii?Q?xr03xxoe8RA/YB0pqoov9IHAuQHqU8Rizbrrv+p6oqh0Efx7JrkN659uTUqq?=
 =?us-ascii?Q?1froZ60vjD4lliXGu+PFtgIsiGSwQyEKp8I+FeyjndukgyeJ13Awdm9sb67H?=
 =?us-ascii?Q?I+N+ENsBbH3bR/o4WWVNhmpk6T/wA7FliI6GNTL9lNnVs6HCHseYgVTTys0R?=
 =?us-ascii?Q?qc0+fguMNHryUs9YR3P6bVpb5Xdmr/DDrVUeK61sCxtcnBeGJuHcQOXPkIte?=
 =?us-ascii?Q?KetSkwgmoeCCoJMsZ0e6Vb2w+Rvi2hXnZTUKnIK2nmuOL2iJQGnwHBTs7A7u?=
 =?us-ascii?Q?JuXJZvwyhCTw5UtIJDrJHkDqt5+eKXz0z/a3ZSJr+fAr0rfe5NaCWgwUaJg7?=
 =?us-ascii?Q?z/HxEe5tNKHAP1MMtlLqPf6FXCRlbYeXiz2B+rqU29NGf2mYUFnUEik2eZrA?=
 =?us-ascii?Q?My1N9ipAbp0/Vv9XJn3bEQuoKtmzqOWIRIG6AgU1Hm1cVQrp7jtWuJbDsXKj?=
 =?us-ascii?Q?UONQoRbKF2eneaVdQX80frFXshtRqh11jsKC1R0KilUoK8yyahAdQmYh+I85?=
 =?us-ascii?Q?WXldI0nj2kUQ9p3rKGkGmggei16PWKJlWVWcyUDHy34WKbfKRDebCjmKTQY2?=
 =?us-ascii?Q?cN6Rs6qxbt5srcCbAJKC5zXYOw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F4626D114DCA7249AEBC2ECBE58E0282@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: fdd86464-bb04-4490-2aee-08d9e70fab4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2022 12:21:13.3472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAXPR01MB2320
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
v2 :- Use better approach to map fn keys
v3 :- Use BIT(10) for APPLE_BACKLIGHT_CTL since 0x0200 (BIT (9)) has been u=
sed.
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
+#define APPLE_BACKLIGHT_CTL	BIT(10)
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


