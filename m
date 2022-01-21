Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8C3495BDD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 09:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379564AbiAUIZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 03:25:47 -0500
Received: from mail-bo1ind01olkn0147.outbound.protection.outlook.com ([104.47.101.147]:59648
        "EHLO IND01-BO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231208AbiAUIZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 03:25:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ScIMvu2YVeiGKuB1n7LzL8OPAF/xb41xZZC3qVGtsLWF8flQ+1lbmDVfiPvrtaAOEFdX0tEDxdEQ0RFeAQZUNRiQo4UqhN7LppNtRihyTakCY6d1sLAFBGC+3CSjq4XuF9zmcNaBoRgL/r4W1j8vBMPdV6c05DLbysc1cIu+IRvjnXwbgx56umCx+/FPK7cA/IIhQDBwhwOULm+6cB8fyKBwCovAZcNik0DZ9iiy5/0/I4qQv2EslNbvZ4Veaty+Rqh0cHbRlK/qj2BIBAV5Ng/qHkbdYSZ4QyqbAFKMk2gmuD581hBTiIkcacAK92Bxi5+OBmFpdB003TEh12axBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krma4VHb9sJrmprJ5mShOQ73B5oR6gD1pgrE1j02stg=;
 b=VW96kkoxUJcf39UfpaMJoEJtnzveWyFNBBQKPG1tkHZn9SfDwS8Q4VFEIETw+adHdriKqBtWfz0C3H+VvbK00mBbMhbtrcnaVjnMzDjtRUekQc/dgH+s1BthnxD0n9pAqDhljiPt3O9yKLuVq9FFmJTCdvq6I84VplOBlPJTLbtiySWtbpjIBabF4GvF/XFXY92lKzMF+4P6JIYtR9e8NvtPgK3WqGl1eYL3imXT2qdsiqayZf40A5M/Zv//DqTskgtgYNaz7sOBQMp491rALQNW2FljGqhDMglc/xCsAksuDjzdowbxA3m/72KKUqG3d+ggLGXzHCKvd6J4IwrDGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krma4VHb9sJrmprJ5mShOQ73B5oR6gD1pgrE1j02stg=;
 b=dTjB2wA6gBVHnVwK4+YAimElCXmvXbRfpHGaDbPYnTlrs7yM9sHqdSCJ/tOahkKxfBII/LXbdGPNdR4JZvWyMK8sOjR2Kc7NnEXpOlV5uuyWN9tdUBZyIhdkqm2QcwXD+wts4Cbqeekli5fdZaKeBVQjTXvnW3bB63adi+kKDh7CT2h33tCk7J9eDyNW9UIHsBWd4WHXrZFgYd4PioYJjtjzd9lv4fvUGYLSXGYM4bBnLmj9m8HxYRlcqRdIAqbrceRdTsnUHuXwzxWFbebikTHEqpmBHdP77YUU+ois4zfzj51+bvPDdur5YlJnZHqwqAArZrI7KrVZeqgpnY9WNA==
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13)
 by MA1PR0101MB1862.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:27::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Fri, 21 Jan
 2022 08:25:41 +0000
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d19b:7cd1:3760:b055]) by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d19b:7cd1:3760:b055%6]) with mapi id 15.20.4909.010; Fri, 21 Jan 2022
 08:25:41 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     "jikos@kernel.org" <jikos@kernel.org>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC:     "paul@mrarm.io" <paul@mrarm.io>, Aun-Ali Zaidi <admin@kodeit.net>,
        Orlando Chamberlain <redecorating@protonmail.com>
Subject: [PATCH 2/3] HID: apple: Add necessary IDs and configuration for T2
 Macs.
Thread-Topic: [PATCH 2/3] HID: apple: Add necessary IDs and configuration for
 T2 Macs.
Thread-Index: AQHYDqB6SoUV0oSPqkm4D6M98i+8cg==
Date:   Fri, 21 Jan 2022 08:25:41 +0000
Message-ID: <C6DEF799-EEC2-42FC-84C1-CA942A614864@live.com>
References: <CA294A24-E279-47FE-A5E3-E47F1A2619B5@live.com>
In-Reply-To: <CA294A24-E279-47FE-A5E3-E47F1A2619B5@live.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [MwWeujta4/e27wQmuOCKa9WKv/zWTQGacM49PqUB0mGexq+vxhI0ItF1M89y0EBM]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29e43cde-5feb-4716-c137-08d9dcb79c92
x-ms-traffictypediagnostic: MA1PR0101MB1862:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wJRXh1qryOzPtPyRIVshdo0M5yo0fqU/OdyHvf8kJyGBoAzEvtwXW1+dARzjHMrZxo8cQINUhJxtE3ozEGNWne+NRysJYhYcHezsXNtoKY6/sURwmFealHOz51XS8liI0whJs2BavPVr7j2WnU1pFhZyHogo6w4d6FjdAW4rk3JHsm6iJkePA/oJiFdOd6ZObIJZ/0QmpVwPjZcuW21sW74SMq95nSpEnZdYNJiG+/ViHEAt5OxUq6esPBwUii32WdLF/ytQdjEAOKZNprEBSeA1xg3C3W6qHrDMbBSnEZML/dIRZ4KN6YXobaBXl0oTYjAN5DyQTBr8ONl+VMQLkYwE5JVMYbvnRN0fHrO6aLn8dXIMuAd2X+C8GF9nejYYldy/5xizhH0yMnayOSwPAn+iawKoO3a8C+jCeXzhsri463f8fXZKGWEnaHnyfkdSrVAQHMYw4qzEZURcN5CB2HusIB/eOlR+WB0nnydQEVR57zYFWUAqPG8AyCK+58/exzzjfi/w44ZLO1RjqRJn+LfjneIaiAHvYvfVZlHwhLox07TAW9AINOnZQP3T4u9ePUNVSNT31VxFWS1EnTRaOQ==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zjEeYCZjCPwiSyJJGmJkMvlLwSMtzw03ATHaM6hqTiaQYL4uqUn5Gcq7F4Te?=
 =?us-ascii?Q?MyMPNEpFkuNg+snUB+Jk0bSX2dPXGf6mmpdHqzYFkYq/sH2o55EkqRy/28fg?=
 =?us-ascii?Q?7H8ZludaX13OZdLj2JvckUzWrS/MK8dqccriVJBSw0vNokSQbXFKxzy+TY23?=
 =?us-ascii?Q?6o2ufKnqlofCA6P+7kiJLC2Os675p8WrkMBKI+d6OQ8DUx+/OsjsnogW7S9x?=
 =?us-ascii?Q?6z71Fe6YGdai+0s+gIsJA08MQlSUeXkf1y2Pi/bbk4R3Mvm0oc0w50RRI7ha?=
 =?us-ascii?Q?dq1exphtAqSyq6fMkUHLN0x4yFV6yUkjM/QCM5Iy5VfJNVLq9y3957Y/b8DF?=
 =?us-ascii?Q?Orj3J93Cek1VQ505XudWASKRMfy3U9HcXW/OSbWCLLTaUwpAb62B4dItF4gE?=
 =?us-ascii?Q?FJs17V9/aFN3ViG7eRtzVFHvkOfwKSED20stqOVKwOOJNxNDJ6KpT1MgQKW4?=
 =?us-ascii?Q?4x9hk6IyJbFNn9E9w8jNB1BgEGF1U5R+ZEuKTVAiuAglqsjWxQi4dgaKczPl?=
 =?us-ascii?Q?QGeX0uMdWojy8kbe13j3tVUMR7ufDiypPRWFc+QEVbUNlC8WPWIGxGhQzA+X?=
 =?us-ascii?Q?4UoFYtAFy3V5FcMpY17jPF+ADqVMngvA9kK3xcn0zTnftWmRfJimFcZ7Ax6Q?=
 =?us-ascii?Q?DCL3pPQQ7pGsZtvyg2K9HfGHMAX3zJM4PnvUkZrs3J4G4lM/5FNhqlRqN0q7?=
 =?us-ascii?Q?RRxhdrn4ym67zTXn+/wyCBtvppvwV4zv2aL7XbJGOEZrl2aiIwd99ADu0mcP?=
 =?us-ascii?Q?GTW48NDx8Ac/qELcB/JajDarDTKEeTmyfNkKJOCxjowq9/t1vWzvr9RrX1/Q?=
 =?us-ascii?Q?NY1S7Fi4j3TP3tocgMOOIf3/MyIi2Dw+xV2fyfu962sEQ/ejq5F3GEFyfl69?=
 =?us-ascii?Q?aNjbO692D6PEZEQULsBe2eWuFdxMbVr0Y2JEfkJmh8c6/NCf4hLwW/v1Y4B6?=
 =?us-ascii?Q?WFzu5qL7UR4lE2wZuezSSSObAb1T15qGnHMFURbqHbTyF2vqpYTwu+IOv3v9?=
 =?us-ascii?Q?+OUhd54djMByXIm7zNv9Vc8aXQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7EE5585BCD26D94F819B92124ECBE31F@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e43cde-5feb-4716-c137-08d9dcb79c92
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2022 08:25:41.2843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA1PR0101MB1862
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aun-Ali Zaidi <admin@kodeit.net>

This patch adds the necessary IDs and configuration for Macs with
the T2 Security chip.

Signed-off-by: Aun-Ali Zaidi <admin@kodeit.net>
Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 drivers/hid/hid-apple.c  | 16 ++++++++++++++++
 drivers/hid/hid-ids.h    |  8 ++++++++
 drivers/hid/hid-quirks.c | 16 ++++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index c22d445a9..823021c24 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -861,6 +861,22 @@ static const struct hid_device_id apple_devices[] =3D =
{
 		.driver_data =3D APPLE_HAS_FN },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING9_JIS=
),
 		.driver_data =3D APPLE_HAS_FN | APPLE_RDESC_JIS },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J1=
40K),
+		.driver_data =3D APPLE_HAS_FN | APPLE_BACKLIGHT_CTL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J1=
32),
+		.driver_data =3D APPLE_HAS_FN | APPLE_BACKLIGHT_CTL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J6=
80),
+		.driver_data =3D APPLE_HAS_FN | APPLE_BACKLIGHT_CTL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J2=
13),
+		.driver_data =3D APPLE_HAS_FN | APPLE_BACKLIGHT_CTL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J2=
14K),
+		.driver_data =3D APPLE_HAS_FN },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J2=
23),
+		.driver_data =3D APPLE_HAS_FN },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J2=
30K),
+		.driver_data =3D APPLE_HAS_FN },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J1=
52F),
+		.driver_data =3D APPLE_HAS_FN },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIREL=
ESS_2009_ANSI),
 		.driver_data =3D APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIREL=
ESS_2009_ISO),
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 26cee452e..8ad26c20f 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -167,6 +167,14 @@
 #define USB_DEVICE_ID_APPLE_WELLSPRING9_ANSI	0x0272
 #define USB_DEVICE_ID_APPLE_WELLSPRING9_ISO		0x0273
 #define USB_DEVICE_ID_APPLE_WELLSPRING9_JIS		0x0274
+#define USB_DEVICE_ID_APPLE_WELLSPRINGT2_J140K	0x027a
+#define USB_DEVICE_ID_APPLE_WELLSPRINGT2_J132	0x027b
+#define USB_DEVICE_ID_APPLE_WELLSPRINGT2_J680	0x027c
+#define USB_DEVICE_ID_APPLE_WELLSPRINGT2_J213	0x027d
+#define USB_DEVICE_ID_APPLE_WELLSPRINGT2_J214K	0x027e
+#define USB_DEVICE_ID_APPLE_WELLSPRINGT2_J223	0x027f
+#define USB_DEVICE_ID_APPLE_WELLSPRINGT2_J230K	0x0280
+#define USB_DEVICE_ID_APPLE_WELLSPRINGT2_J152F	0x0340
 #define USB_DEVICE_ID_APPLE_FOUNTAIN_TP_ONLY	0x030a
 #define USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY	0x030b
 #define USB_DEVICE_ID_APPLE_IRCONTROL	0x8240
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 9af1dc8ae..963cf2a2e 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -294,6 +294,14 @@ static const struct hid_device_id hid_have_special_dri=
ver[] =3D {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING9_ANS=
I) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING9_ISO=
) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING9_JIS=
) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J1=
40K) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J1=
32) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J6=
80) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J2=
13) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J2=
14K) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J2=
23) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J2=
30K) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J1=
52F) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIREL=
ESS_2009_ANSI) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIREL=
ESS_2009_ISO) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIREL=
ESS_2009_JIS) },
@@ -929,6 +937,14 @@ static const struct hid_device_id hid_mouse_ignore_lis=
t[] =3D {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING9_ANS=
I) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING9_ISO=
) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING9_JIS=
) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J1=
40K) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J1=
32) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J6=
80) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J2=
13) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J2=
14K) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J2=
23) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J2=
30K) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRINGT2_J1=
52F) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_TP_ONL=
Y) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY=
) },
 	{ }
--=20
2.25.1


