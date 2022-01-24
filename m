Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B70B498326
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 16:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240472AbiAXPKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 10:10:25 -0500
Received: from mail-ma1ind01olkn0161.outbound.protection.outlook.com ([104.47.100.161]:25364
        "EHLO IND01-MA1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240344AbiAXPKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 10:10:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQz1oa7Fblji3i6n61NcfwmoDWQiPl+veVe6W8M4PsdPSdKsEXNxqDkaEN2+vO3P2q31EkBxfbKAI5KB+/JHhd5fLxKSBTokQoTEIDwnRl0Qw6WcswjXJlSdBG5QiN/a32+3c+1HiUdUpfUNmAihKikdhX3jNv5nD/eC4dMiNW4Gsf5bxdBDqKFtIGkCoKYIAYXkjX8JfmlcH2ZtoASEM9tBbVrWrGy9p9YuCEKdPFm6aobF5I/DlId08z4jaEXQyhRcUxrR/8fCM1NoXQCPVV4oHMENaAa7xRKdGO4129RvKP+wNvo7TtK2nwFz9nE1BGkNsIIhcBwEfjdAwGrjhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AopwVpOAznea4ixmV0qPlPP9esdg0CgE22pnNtuGawQ=;
 b=VSncOgvst7cJa/Oh6Vj2O7EROiITPh3KKLv+CbHQkhd/Q2jwAGlPS9c5pco1GgzDP44Uc3dI8NpSGeEZ4M6G8gHCMTq2oISZBxdPneNPJOhQBoFpmcs6QzpCtoXODULATuhMeQA54GDXyazwlFGQblDBpk79V6nu2SZISquYrNIjc8hQ3kn8ZuhRvV0gDDeXnF+c6D4NfMwHv86DEhdjtJk14VS4Q9OqNYP9hR29edXZhgTK72/tCO7bE18z0ky5NRmjiJ0L1N3R2z1RIEsow3/BWPjadgnYGc+ZphZQmLG6KgqfQmUvGbQJG3U9KXySQ8sJcrnyZZ5PxFROdp4SiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AopwVpOAznea4ixmV0qPlPP9esdg0CgE22pnNtuGawQ=;
 b=SWnWPeCQpLhyoiFfa3Tq8KUl9QshBJF06YUuV2NUTcczK7jDtdCkTUFFb0+2ZyJsxVqoizMBlBtqWY66ZRBQTG0TIRnfXZD7gsIISEGjsUFDVo2Tz22vGlCNAVtcnqpAqtTeqEeXtEmGMjt1cXvgYRoyYAkLdLar3ZUZ6VAilvrkZdrx4V4RauAwdpVQZOfuOx6DLBv7oPmHki1LBe5YE/1xjcV/ED14UdjzILxMAkCgTIJXbJTPjfhDtqQ3aeOT8LPAsKYxOLi3lxpB7pKC4rkcMwUUtlnRTf9hCXBGxPaXPFNKfIHL3xC32cYrUUo2kGC2+rlZ+4FbaMwV/aZCJA==
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13)
 by PN3PR01MB5602.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:79::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.11; Mon, 24 Jan
 2022 15:10:15 +0000
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d19b:7cd1:3760:b055]) by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d19b:7cd1:3760:b055%6]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 15:10:15 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     "jkosina@suse.cz" <jkosina@suse.cz>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "alexhenrie24@gmail.com" <alexhenrie24@gmail.com>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC:     "paul@mrarm.io" <paul@mrarm.io>, Aun-Ali Zaidi <admin@kodeit.net>,
        Orlando Chamberlain <redecorating@protonmail.com>
Subject: [PATCH v2 3/3] HID: apple: Add fn mapping for MacBook Pros with Touch
 Bar
Thread-Topic: [PATCH v2 3/3] HID: apple: Add fn mapping for MacBook Pros with
 Touch Bar
Thread-Index: AQHYETR9gng9woz2EE6lNBNyOEXQBw==
Date:   Mon, 24 Jan 2022 15:10:15 +0000
Message-ID: <9287244B-120D-49BD-B213-40651246FF6A@live.com>
References: <67E7EA8B-CF21-4794-B7B4-96873EE70EF6@live.com>
 <4016C218-BF0B-484E-BDFD-A88FB7510E3E@live.com>
In-Reply-To: <4016C218-BF0B-484E-BDFD-A88FB7510E3E@live.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [edbFmOejZcH9DItN6LD1DuXrJsXJYntjQZcWzpATP3YUahVQsoYy+BIC2MLOYWn3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9b94716-1125-40b0-f580-08d9df4ba05d
x-ms-traffictypediagnostic: PN3PR01MB5602:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N21xCnjbwyU/f3IrfXMgH0mK/6h2FFS751qFIRCYWaxO+tbwJPsJOYAFwLkwmPUygmHrI4J6f72nHtOmX/o1KuTvUa0tR4UWl5Pr3j1TzqDYT2k9gB/M69oDNUOlL3Wvzh/F+HThnAWXH4z75l4/J4dy6HZN3+ATAcWyIrPVB1hT/grPYh1fezgaTRC7O3GeaHxGpTyUQVHTdAJsCR3nEVi8EByjPe/uvVKgFwfKl7rHvLbF1CyD6t2Ud5qBKKw03GVPmW9NZUt/GbXOaNSXW7g7IR7ARLTDvLy0JZ0vCmYZ8uh6etQ3H2NsOYPWUoOfxptn2naHQw9bZRTVxBnbQif2NxfbhLatonf1bx2f+XU2UzWbaJ4lB9qNx+UE/G0wFOUWNcRnxmGuv5ohl/yu2ckZFzbTYab0/9H/+bT4UVQA+XGY2VQL2QYVpkGT7kVFggGUM8uGX6W/d7BnQauFvSXdh48BnAuJHVvRSvOSyZAUzt21h3iQ/1tLBBqN01XMWp7wfvBwHETaJf6brre7oc0Ip40y3K0hjpmW+hVL5gjQ0fhgd5oap9gHUTDFY5Kc0Krvt1SoOssG5vhWfY4kKg==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Owo+uhUZsMggwLZohCKuGTA76eRrZNn53qrzkEyVaeT1sgANU/WMqrDU8E5R?=
 =?us-ascii?Q?QYb+PBqVa9nmsbW2c+AywYSlZ/Q7gpFNQbsRXYvdHcXKhSa+bJUNOABLjNSy?=
 =?us-ascii?Q?lK2r0RN75HcwYkFM1qfjqEUSVq9xeYcxtyyMkUnqmx3+9ERETSQxLYdrsMTr?=
 =?us-ascii?Q?5jHQaCuqqrErrtHcvPl/BXVbAkkL9plKK68ICbO7m8hbuM8sIyQ40JyK26v3?=
 =?us-ascii?Q?fVF076mqtRoQwS/E850XWp9w3Ag2fTt+CYxksuUvsRY5wpV6IQ/peqtUSaBG?=
 =?us-ascii?Q?O0xBw9jGL1v0IbAGe74RBW8QKdpKCwIfpnNNUF/V6vgg3NNZ/AyX/JIP/zTH?=
 =?us-ascii?Q?CLAnhc5W6sKQiSwUXtD+hysJYx2hU+HlyliMELQvzEQ2DNcjZLqHcNwt3+1R?=
 =?us-ascii?Q?MlEkPf5fddQygFDxJL4ayd55LDFF0IIethu8KCigxjNCfqVN0mqvfx3laMZV?=
 =?us-ascii?Q?pui4w2lmbmUmyMjSVSI0sKjr1ZN9jc55RzKNvpyInp4q7KSiJraUwUZMxo96?=
 =?us-ascii?Q?bGdDcq5SwMvBtPtQymdVsjgPKr46nhFNayhwFGHG5bq7VKSpt/Rn7ihP0hwn?=
 =?us-ascii?Q?F5RnOsl8mhqwbWHnpgWxiR0E0OlNStbjjTW7UoMoY5TznL8daDzlWXodTRoe?=
 =?us-ascii?Q?qdvxXM0Js11FqSHKhN2BZAkdGIwjdvF9XSvX2p92ruRdC8kzaHailnRSL+88?=
 =?us-ascii?Q?zsPPi8Rpuyyhz8TSwtYzzEPdSFTPYx9Us+D86y65vJ4Ua0lN8pnd6ngVkFL8?=
 =?us-ascii?Q?TCV7N4D2YImfHsgs6Sjq2OCbuX4Ah1oU5fD/oJEbaMF9Yubf6aZjraH5K41y?=
 =?us-ascii?Q?2F46L1mA10lhojOwb3qkiAzhfcaMlkw7BSQH6+U5JkyP5qYkjxaexrlPt28Q?=
 =?us-ascii?Q?Yq2WKh5VunU/MH+78sk729dUWb4RyyuosT2r+j1lG1I/cAIm0QS4s7TGBFhJ?=
 =?us-ascii?Q?0UFFf4LS+U1G9CBB6OGpAwtRwckHjbhQDz7qiahTQ9ZetbBJwO7bffwf9mp4?=
 =?us-ascii?Q?xWzJ93iDhiQ33zs6OfpsDgxTFQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4488A5207DB70942B5C9E0981371DC09@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b94716-1125-40b0-f580-08d9df4ba05d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2022 15:10:15.4908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB5602
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aditya Garg <gargaditya08@live.com>

This patch adds the Fn mapping for keyboards on certain T2 Macs.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 drivers/hid/hid-apple.c | 62 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 658d79375..5448e5a66 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -142,6 +142,51 @@ static const struct apple_key_translation macbookair_f=
n_keys[] =3D {
 	{ }
 };
=20
+static const struct apple_key_translation macbookpro_no_esc_fn_keys[] =3D =
{
+	{ KEY_BACKSPACE, KEY_DELETE },
+	{ KEY_ENTER,	KEY_INSERT },
+	{ KEY_GRAVE,	KEY_ESC },
+	{ KEY_1,	KEY_F1 },
+	{ KEY_2,	KEY_F2 },
+	{ KEY_3,	KEY_F3 },
+	{ KEY_4,	KEY_F4 },
+	{ KEY_5,	KEY_F5 },
+	{ KEY_6,	KEY_F6 },
+	{ KEY_7,	KEY_F7 },
+	{ KEY_8,	KEY_F8 },
+	{ KEY_9,	KEY_F9 },
+	{ KEY_0,	KEY_F10 },
+	{ KEY_MINUS,	KEY_F11 },
+	{ KEY_EQUAL,	KEY_F12 },
+	{ KEY_UP,	KEY_PAGEUP },
+	{ KEY_DOWN,	KEY_PAGEDOWN },
+	{ KEY_LEFT,	KEY_HOME },
+	{ KEY_RIGHT,	KEY_END },
+	{ }
+};
+
+static const struct apple_key_translation macbookpro_dedicated_esc_fn_keys=
[] =3D {
+	{ KEY_BACKSPACE, KEY_DELETE },
+	{ KEY_ENTER,	KEY_INSERT },
+	{ KEY_1,	KEY_F1 },
+	{ KEY_2,	KEY_F2 },
+	{ KEY_3,	KEY_F3 },
+	{ KEY_4,	KEY_F4 },
+	{ KEY_5,	KEY_F5 },
+	{ KEY_6,	KEY_F6 },
+	{ KEY_7,	KEY_F7 },
+	{ KEY_8,	KEY_F8 },
+	{ KEY_9,	KEY_F9 },
+	{ KEY_0,	KEY_F10 },
+	{ KEY_MINUS,	KEY_F11 },
+	{ KEY_EQUAL,	KEY_F12 },
+	{ KEY_UP,	KEY_PAGEUP },
+	{ KEY_DOWN,	KEY_PAGEDOWN },
+	{ KEY_LEFT,	KEY_HOME },
+	{ KEY_RIGHT,	KEY_END },
+	{ }
+};
+
 static const struct apple_key_translation apple_fn_keys[] =3D {
 	{ KEY_BACKSPACE, KEY_DELETE },
 	{ KEY_ENTER,	KEY_INSERT },
@@ -269,6 +314,17 @@ static int hidinput_apple_event(struct hid_device *hid=
, struct input_dev *input,
 		    hid->product =3D=3D USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_FINGERPRINT_2=
021 ||
 		    hid->product =3D=3D USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_2021)
 			table =3D apple2021_fn_keys;
+		else if (hid->product =3D=3D USB_DEVICE_ID_APPLE_WELLSPRINGT2_J132 ||
+			 hid->product =3D=3D USB_DEVICE_ID_APPLE_WELLSPRINGT2_J680 ||
+			 hid->product =3D=3D USB_DEVICE_ID_APPLE_WELLSPRINGT2_J213)
+				table =3D macbookpro_no_esc_fn_keys;
+		else if (hid->product =3D=3D USB_DEVICE_ID_APPLE_WELLSPRINGT2_J214K ||
+			 hid->product =3D=3D USB_DEVICE_ID_APPLE_WELLSPRINGT2_J223 ||
+			 hid->product =3D=3D USB_DEVICE_ID_APPLE_WELLSPRINGT2_J152F)
+				table =3D macbookpro_dedicated_esc_fn_keys;
+		else if (hid->product =3D=3D USB_DEVICE_ID_APPLE_WELLSPRINGT2_J140K ||
+			 hid->product =3D=3D USB_DEVICE_ID_APPLE_WELLSPRINGT2_J230K)
+				table =3D apple_fn_keys;
 		else if (hid->product >=3D USB_DEVICE_ID_APPLE_WELLSPRING4_ANSI &&
 				hid->product <=3D USB_DEVICE_ID_APPLE_WELLSPRING4A_JIS)
 			table =3D macbookair_fn_keys;
@@ -480,6 +536,12 @@ static void apple_setup_input(struct input_dev *input)
 	set_bit(KEY_NUMLOCK, input->keybit);
=20
 	/* Enable all needed keys */
+	for (trans =3D macbookpro_no_esc_fn_keys; trans->from; trans++)
+		set_bit(trans->to, input->keybit);
+
+	for (trans =3D macbookpro_dedicated_esc_fn_keys; trans->from; trans++)
+		set_bit(trans->to, input->keybit);
+
 	for (trans =3D apple_fn_keys; trans->from; trans++)
 		set_bit(trans->to, input->keybit);
=20
--=20
2.25.1


