Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1798B4A83BE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 13:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbiBCMWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 07:22:21 -0500
Received: from mail-bmxind01olkn2020.outbound.protection.outlook.com ([40.92.103.20]:36098
        "EHLO IND01-BMX-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238772AbiBCMWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 07:22:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c777byYqlohGQCCY9D2bkZPUshNZaWbnRjC8G16gXo8DWXfyQe5eSKijGhp0h2lnNsdHmqrmgIt9HBGZAJtitWXTYj/egCC+21mpR+dCLLkA1jGCqTHyRkCkB3lk0AH/NYsKNL4Kwbkb5VDYdrhUtiVwPE+MaJdmEzugSXwoMvf6bLMbLWXZOYaTF3eDHcyN+jD9om7pihg7aeAsyvHpZVX8IzSpmKoWn/Vi1vw6+MUjRq03Edac/0SU2y7c+ouq7tLihJL9qCYrICTVAblKRES0sYpL/22QMNKM0jZGRDLCTDPcL8GQZ2iB5BLAvlWE4P9KjUjcCNEZXttdEyjROQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ynjlUzo6Cjav7qfolIYsnNjiLNNvNMTJYB0yphqWXk=;
 b=ch+a8pQ0FMuLwyAWv19msoWgCWuncgn//BUJQjIaNDddrz7+Ip/tnM7up0OJL9TbBYn6+/8txqF5mDY9+p05+QZeF8FG0TZ42CY9LbB9CnrMpA8EiTmzTKqBYO/Ibb0au2aDcGEjfUbvh7Q1RrY+DDKZM9errGCi+LiXAeD0GLTHsV1s6QlJ5rq5Fm9CocGib1FMSUsMWAVrZIWV9drmEUT70+tjH2AqIE11m78XNE0WLJ7jGjzBlnBFPmhpVrPuXaoe7cIdEQNDNE56nwrB2d7Egr9seYNfblbMFsCShGGoGFM2lm4wrwgutTh7+A819Xmj+wH6z34yG7OiWZFGOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ynjlUzo6Cjav7qfolIYsnNjiLNNvNMTJYB0yphqWXk=;
 b=WqVJl7Ods14oq9Hq8HtJF349nCI18HJbaxD3KMu7//rpZfCnMsjJhSn8e3XDwx+vxUikTRXXkjum73CH5WiBGcX36jHEhzFp54pUz2bUm2aExsc8aiBkaB31KI8oTmBmi8/aUNF+bd2AcbglOSm/1c711Zm6oOStfol+OHBqHk/lYml35hfm+i3sqCoG0QiiZVHXXAeNy3NqSzbFB7QsG3pRSgp8ddtR2tCI9OAS+FXRohhsCq7WLCvwmf8S9w3LvXRnoS6l+awaGuT7AQIp9Ued+j26nEl/SVE5gXFXlvsORrwlhoBfqpCPH6sThsxx3wbkkrEKJC0lxvvUAL1wRw==
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13)
 by PN3PR01MB6934.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:a9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Thu, 3 Feb
 2022 12:22:09 +0000
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d19b:7cd1:3760:b055]) by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d19b:7cd1:3760:b055%9]) with mapi id 15.20.4951.012; Thu, 3 Feb 2022
 12:22:09 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     "jkosina@suse.cz" <jkosina@suse.cz>,
        Jiri Kosina <jikos@kernel.org>,
        "alexhenrie24@gmail.com" <alexhenrie24@gmail.com>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC:     "paul@mrarm.io" <paul@mrarm.io>, Aun-Ali Zaidi <admin@kodeit.net>,
        Orlando Chamberlain <redecorating@protonmail.com>
Subject: [PATCH v3 2/3] HID: apple: Add necessary IDs and configuration for T2
 Macs.
Thread-Topic: [PATCH v3 2/3] HID: apple: Add necessary IDs and configuration
 for T2 Macs.
Thread-Index: AQHYGPiqg2IJkgvOJ0+WrzX+lSIq1Q==
Date:   Thu, 3 Feb 2022 12:22:09 +0000
Message-ID: <9981348D-0D48-4613-A46E-03E9A1897E59@live.com>
References: <67E7EA8B-CF21-4794-B7B4-96873EE70EF6@live.com>
 <1088ECFE-B356-4731-AC8A-09A4421DD7D1@live.com>
 <D0C26284-966C-4581-BE37-78A6B0B367BB@live.com>
In-Reply-To: <D0C26284-966C-4581-BE37-78A6B0B367BB@live.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [lplVlAXoVd0ph1gcJqS8z7VrKMkfFF/H7qgHpw9DPtpRPINyB1qK9l5OVn53k46U]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 089af0f4-0157-42df-abf0-08d9e70fccf8
x-ms-traffictypediagnostic: PN3PR01MB6934:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2jcfK4A9aerpPldO9dwq+uJPJVVg8ZGyKM4hlW9vUniqhtEo2T3PU4q7tPugQAO2r1o83yvSyy5JweHfSwtyShHdzJFunRmihTYwJFiDbSTia14ztyfLLz2iF0JkcGM8vf8mrP/C3pddFAxVZijUobemMbrN9UQSTVtfsQ1RWbK5/3AaVR2GeH1NDHwqYlX9SeCRWvd7a5vnnwHRyv1dj4QFZwqqTiHUhspzOoPQpswQBDHy1aWcJkmyV6dOSlg3v9kM9i9r9AFwnOjAWqOygjMYRD1MCw+2r6Q0sysKiduSCTQSwJD7evN7uS4pKm4aweluyGhaquSqHQP2tRmGyJNx3RvEZEy2OQ+wf6jlB8U0P9ocyfNwWLfQOsiZXuPKVsg/+2oHsfUMGeuJpwDAcqBRMIAn7EKbtgsChzTm0cHQYR3zuCZAccR5f4uJT+pZByGM8q3a+2UNL3zxV8SDElsMaU7lhAP/wWirSU17AAC5jpdvlFh8ofd/5j/dOZ/QDR38RZ5NH3VWu8jFTjUAkd75lfLRROEtXuHeZ/gwP5nDrxRG3DR6WSaGql+zyScgNiVZNu46ehYDsS1XeFDNCQ==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8ExBi5FbXdsju5H12cktLBXEzlw2OxxQuvb37onW2MXUEhRRHxeG/XSUAiU0?=
 =?us-ascii?Q?s2+FDGkpIE1hQmn8oz/KZXi00TDSWxhvRFNs4Yo/vmAT+3EXRfhZLrEfmI5Z?=
 =?us-ascii?Q?H+ZLyhKRxr8JkQT0xicye+VyRdJv+jQ3I5iQWhWikjIjk+WFTut+KGb2l0gx?=
 =?us-ascii?Q?9c0mGkxOAzFHXmYVMm9JxZ7MzPpwyj95NC3VNFJr3G721Xx+UOdg+Mp49jII?=
 =?us-ascii?Q?pZyAetfzhG319/mCyKyGe/0amw+hXVFkwdbPrCI/tDhgIEaYsyvSilsC7X7I?=
 =?us-ascii?Q?STiB7I3SaWnrRWlZEACJPV4bbCidtah8P5p6xLKzkV96Ja5GVmLHvRN5VOoA?=
 =?us-ascii?Q?zSAa8dxXL7D4arvG65AlR77YCxTGvNrjPMtA+puX9X47wYdquFnbHxA3ProW?=
 =?us-ascii?Q?uO8LZr4x8U+ey8Nuf/uDSFs4JiGkHi6xnPFVJ1JbB9gxQz7c6g8mc2Xjd272?=
 =?us-ascii?Q?R6uA4Y5qftodjfkfuhD2EFZpjBmXUX7O+oI/b2IJcE6JISekCPrH5ryHMaEI?=
 =?us-ascii?Q?HBvUjBuJ8L9ZLKxENCMNsD0D3pbAuZVhvYtuf5q/0aP7c5/k86B2DfnSKVP0?=
 =?us-ascii?Q?U+1MFZj8P8EK1THLLNs0LyU0ZrRiNyCDSC67etlFS9IpiAYUoeSGb3cNu8kJ?=
 =?us-ascii?Q?nUi98iJyGZ2iNu4Nj5G4If4I5XxxdjXsK6hG8dsTBaOaM9BCmOg/UVWQlLAy?=
 =?us-ascii?Q?FnhwMdKoIWEaS79qj82gaZ65KRyR94RUT/z8GMRgQRQzOOi3pyq5BaMpDKtS?=
 =?us-ascii?Q?QqxWN9PITywY9bYMmoQ+gejoU/NxZrOQ/ZVje5ZWW6nHi2mRcRj5R23GK72U?=
 =?us-ascii?Q?BcTDibHzQK0NKNvcB/58mvDHM92lzKiDHPHnVyKXTyW3s5KQPvXIsjW5bBIa?=
 =?us-ascii?Q?A6hxlJ843f0JifM0CTK5iffYjy27xtjTuOVsBRzgj4JcxnLS5/xr01FpFQxV?=
 =?us-ascii?Q?qX77aoRWtZKA5nWgF7LOZhyQyc1VtPuUnySXJqKSKzawiVsem7UZKgLpmYzD?=
 =?us-ascii?Q?pyNyhed7srcvFOYw2T2qlqvYCQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E4C30B6AB0CC5744961EE385A18E1502@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 089af0f4-0157-42df-abf0-08d9e70fccf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2022 12:22:09.8541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB6934
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aun-Ali Zaidi <admin@kodeit.net>

This patch adds the necessary IDs and configuration for Macs with
the T2 Security chip.

Signed-off-by: Aun-Ali Zaidi <admin@kodeit.net>
Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
v2 :- Use better approach to map fn keys
v3 :- Use BIT(10) for APPLE_BACKLIGHT_CTL since 0x0200 (BIT (9)) has been u=
sed.
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


