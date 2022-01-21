Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63169495BDA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 09:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379557AbiAUIYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 03:24:52 -0500
Received: from mail-ma1ind01olkn0160.outbound.protection.outlook.com ([104.47.100.160]:6123
        "EHLO IND01-MA1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231208AbiAUIYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 03:24:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jxcvu2kiCP7r2N9qeMma4BVIDakzDY05pP4FiYZOkvx24+rh8neTPohpY7864GfjY8pw/KgQnxeTtJZ4nu1Al6PEQlJ3+JT66idbRRekJBoWSAOQnAEnqT0mKyRiYbD+ijngrBYBPzicKID9KA1yLewdF7bqLBkZRC7iNKCqtQmSsssADbBf49SmHcFcsUZO2m9zMyYiyzMIYXbGi05Pt2pRczwNs/URzNvdOhM5eBh4X/Y8N7Z48diIaYUg0h7rjO2f4K+8n+0Z/cHV8KisGgb4IO2n2/rGo7hl7hW9UcDaZrf1v3miduJl6t+C1Iz4j6p0CIJz63kuTGiQBZ3fjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2xEJg5lAvRAf9MnaHNNG/43w0bTMk7LDhCTq6RGs0M=;
 b=gmZQISuP4M2fXUhEAp1ENTNJ2UCMj26IQySGaaqEg6LYJ1nh2yfnyYmA2lMiLSATzo0EKAM32cnyRb9n7z92Nod2sAogGrLMMS5Xg2GJpC4ChYSBdgYnqUXst6cPAJa63NANwOGDrsjP3+ioHitRKxXMmmEKlm+sMnOoPVadi96PbwvIJTtX/FiBhRYuf6+J+B3+x9fgXZHffbEwndneY5oJb6zIYvw0/kLcn2q9GcqOzhs9PSWr8SU8BA+Fn24eSgDEUoN73GZl9JROkKJpVtpv/oUJFHy3LdZckYPJag7zV4mcV5OVdedvUazPxRo3wyFiSbNCDHlKTiyBjkptSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2xEJg5lAvRAf9MnaHNNG/43w0bTMk7LDhCTq6RGs0M=;
 b=V2HLAU/ILBU/K0T2agx2RrPOGrt/5WPrF7+7eswyS50nCb1iFKX0uWerCPY1FfJFlu6I1KhFqgGc8hrSgYayC/dsRUySUNU5ogIRVcngXbcYiwfGdjjlJ/SFWi5dNTtuSn7rqj2ho0leTsjEVkhKCDzgKYNtUQ/PzwDKiwXuWf385um/hQo1A7+6aOF8R35SgAxlB2ZPwG+NcejzIsWxtu7BwtAoLnY8oit141L0hGeRVaTwxErJuZpJ1bSE2uqzMuGqwcOI3tQa8fWtXzFw9BTxXuLN3sdCLTf5Hb9UFWVoo+z2DLmGMMUPXWWZ2YHRt/kS9vc8or0A1b2bkl818Q==
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13)
 by MA0PR01MB6985.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:1d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Fri, 21 Jan
 2022 08:24:47 +0000
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d19b:7cd1:3760:b055]) by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d19b:7cd1:3760:b055%6]) with mapi id 15.20.4909.010; Fri, 21 Jan 2022
 08:24:47 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     "jikos@kernel.org" <jikos@kernel.org>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC:     "paul@mrarm.io" <paul@mrarm.io>, Aun-Ali Zaidi <admin@kodeit.net>,
        Orlando Chamberlain <redecorating@protonmail.com>
Subject: [PATCH 1/3] HID: apple: Add support for keyboard backlight on certain
 T2 Macs.
Thread-Topic: [PATCH 1/3] HID: apple: Add support for keyboard backlight on
 certain T2 Macs.
Thread-Index: AQHYDqBZjIWX3vgB/0uO5aaDcJHAaA==
Date:   Fri, 21 Jan 2022 08:24:47 +0000
Message-ID: <CA294A24-E279-47FE-A5E3-E47F1A2619B5@live.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [73oCnercoKD7mauPP+W/315O1W55sKwCtPG3mS4oXt9wgYUNYBMVUXYyzSgCmJWd]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a282ce57-3df7-4226-baf5-08d9dcb77c5b
x-ms-traffictypediagnostic: MA0PR01MB6985:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MnnWvYTpujrPN+MMXLo2P9Mm4/6bZCNVL2ZQZ88FCUH19h7H1qdX18EoQKpSNbcsQs/RCxQBZO+hTp5ze4/0P+cCivmNXmUJcUnNfYa+p/Q5bHHu8YEJktHgalkgwBmuVxqjlfhbCQYvFAFCkbCKdoHd+T9D2LE8GYHdAjVNBbQF80bnkRNCKw496kng/uq9fFC7IoouulgIZ9eELZ7Zo5qXl/rYFtDLP6CHhE88rdBhEX7xRFjdycV/ayPqaAXJ8I83Ef+kve5+OhMfe9Etqukw32Pzz4sOtkwTsRCFYDWJKjJldjbGrx6+q1aawh4JeAxtQVDVxfpFoH9iqppCzUXfqjYx8S+o4L0VTAtVEcP6tliUd8f20iQ5NCAU8/S5btS44Z1VQRxC5d+raiS3QyeRrir/7ebeVlcnoLBuSWpT5pwuz2AdAKRRa6NSo3L6mKmya+ClJ42OqlWappk8HTHILJpxf/G+lAWFgBe0H4osGoCdaQgzIbVgA2m/0hh48uhJ/6MAPhAWlCdlN+EKr/qc2Mt9Si+jL586E3ttry6wNWyr9dNPtKGlOA79704p7oT03I/D/F8sjyCoHug7Dw==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?l6C53xGxCyVlt9EFrMW+WDtaFP7tWqGrLa28ZUDA1/aKZ/oLeDsaxnmZeyR6?=
 =?us-ascii?Q?3Y3YSV2Ba+yn7Jn6UexF/M39cK7J2SKAaOgYJ7wXPQTm3fCskyyDqg9XQ/xB?=
 =?us-ascii?Q?AF8vkC3l1sq0SoWG/i56MzgMcishvjZMCuuijDVCOhJYo6I6O47MF7++TOkl?=
 =?us-ascii?Q?H6lSsCX3JLD00zvlyjotU/RJjjzwcCBA5PxqGljmPKq6p1U+VwKLSCV7mWiZ?=
 =?us-ascii?Q?7XwT+t8+tkNB4tWTHWyZbcXwa8dQ/eZqcPzITc8XcNan0Tf0r7L6wWEAH/dB?=
 =?us-ascii?Q?CZL8pdGZW8gPrF7qaPE+jO/oqPmiVo4zsNxbLcA1rUk+t3pbwnZEpYiQfymh?=
 =?us-ascii?Q?zH2i4SSt3ujhikqQzuB0zlRzfZO0pd9sVchMxVN4Xn8IqcxwAXh82r/gohv/?=
 =?us-ascii?Q?EOCYRKUemgSkgunSk1Ji1VPtY9S2lDguYvF2GYMeU8/r1eTqSt9krb8L2jIy?=
 =?us-ascii?Q?f/7yCATGTo/JnTP1IZzyMoByRRBVFfFzoUeYBwUSWdkpo4xvMhHMNrvJDlwU?=
 =?us-ascii?Q?CSLKO29WIc0ieIbit3QPqbmdomN7TeI67HCbU6VIvRwvHSTyPGEcL1QM4xZw?=
 =?us-ascii?Q?nm+AIIZFpSAWhwkGC+zj9FSsahaSDFhtVXOvJp+gfM2+eGBjjdx1n7GEvaIa?=
 =?us-ascii?Q?WlRz6bDhFxlOkFm6QRmrkBQnQuUCy6Cvl7PMVDn24nO0Q2aGqH7lPM8a95K6?=
 =?us-ascii?Q?r06lrX7gFPt72ELIMybF/XsJS8a0Fe0Wd7OauTBllg2tF0MIPn9oPGdkRzOb?=
 =?us-ascii?Q?7GLSalwGT3pQ3iNgz91KyH7UwaRUX34wdF4CEs1czaAbOwPSI1wVVqtHWvaa?=
 =?us-ascii?Q?Xtd0ab7YM6xQbK75XIlMWwA2iHkS3BJ5IeTaT1fMNXZWj0KZ/d5ED+BLq+2n?=
 =?us-ascii?Q?BLfRSQupi2XmzFOVNUyQ0JAalkrXdkhG+OImm9W7/0T0uzrkNsiBTLZGylHP?=
 =?us-ascii?Q?7Pa4TK9lNii/6yuadkNhpf57v67hxL7rZl7aGPac26vWWQkchSPy7N9VJxpI?=
 =?us-ascii?Q?J6MCI+qb7RVQU7Gorq4WJdTJLw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <44E5997F2033034E8255724357672870@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: a282ce57-3df7-4226-baf5-08d9dcb77c5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2022 08:24:47.2522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB6985
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


