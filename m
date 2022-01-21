Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35F91495BE5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 09:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379580AbiAUI1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 03:27:21 -0500
Received: from mail-ma1ind01olkn0143.outbound.protection.outlook.com ([104.47.100.143]:59954
        "EHLO IND01-MA1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1379573AbiAUI1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 03:27:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XmRwhMTaEAk8zsX0J3z8a5t7oZaOPuQ44M+VwbE7JWl5/zlAKnrbGWn0DHOQQpum8VKTkjf2QRRX1EXB4j4IrvnULNuafcACUYnV9/h9DriABAQTfr0iZmQTowfKbMRbC8t8Qcp0SNCoh0HT8zhlnWrst7wspak7UOvJpLCyfuBjUkMWqc6zfdIO9y5lkSiWGwTwjFktPcqItTp4fojc2W+khsYQX3km4aaKu2Ak0+2WvprC0z1nndMnFtFdgcqKPzaRWlWJZXY+kJcE9whswpKqUGxgzGfxi31mQHhh5/gFMp3M6X0M1ksqQKeeQYPEu1HbmRXa3a4N6Mbm9TuK5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4f42ynkZbwP5ZUApWLBQZYEGltlRoeTZrg9e2f+bVwU=;
 b=ne2AHurCPzobPYLEB0izGwpb0wM8Kp4IEQHS2YkGOsItp5BaT9TEsZq7sDYn4sonhCi+yvOc23iIiXrYJ0EeC6KW1PEiF84IywnQXDYFc7dTz2EGWykIuS9sAMOfSl3bUw3ARi+100dKtSvTLQqiCokSAgYIwjrlXm3YIh1i2g2rGflsV1PDLgWnrL+QAb++93Y9tfYDaWUtflfm9gOWKeTAHVfz7tgCuBa1TAtXh880RtkQYkvzLexjhYjk/ylRhc625w5IwZeQtXqSBLdVlWMqKTSB81hngJgaTIqYVsnkaGrj8q4LaDiZB2lzTqOQPx7PEGzgMdI01CuUCDtT6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4f42ynkZbwP5ZUApWLBQZYEGltlRoeTZrg9e2f+bVwU=;
 b=Kjb2fUVDtbgh2qhZVto54Zt42eXeb7aWhX2s2tS1wRhhi1FXbyV2FYjexU0GMbfTl+7XEHTIni8V0LFaI1yWI9ZBKSV54JDowRg9xJFOrJcQF/BHoucyYHlLswfEF9gXJCDVt+pE3+YzTFa4+EZb3G6vfbJVUKp2LTtwd5ZOiLGlClnrCB1sbC61I4Itln992PON6BjNH4DSgplKfVU/IxtEauoxwm/DHPbgLm/0b/hLdq1LNaW5Q1VVpsndJXZdxl0XbkvOci/RAR93BnbDDv2vRcpN1g7Bi7TyT/L2vV/TE6N94ujvqhRS+PgcHmNOhVWWlp9TOb/Bot5EOrwzNQ==
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13)
 by PNZPR01MB4912.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:2d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Fri, 21 Jan
 2022 08:27:08 +0000
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d19b:7cd1:3760:b055]) by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d19b:7cd1:3760:b055%6]) with mapi id 15.20.4909.010; Fri, 21 Jan 2022
 08:27:08 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     "jikos@kernel.org" <jikos@kernel.org>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC:     "paul@mrarm.io" <paul@mrarm.io>, Aun-Ali Zaidi <admin@kodeit.net>,
        Orlando Chamberlain <redecorating@protonmail.com>
Subject: [PATCH 3/3] HID: apple: Add fn mapping for MacBook Pros with Touch
 Bar
Thread-Topic: [PATCH 3/3] HID: apple: Add fn mapping for MacBook Pros with
 Touch Bar
Thread-Index: AQHYDqCtf+L8VNoQhkWQ1a/1M58sqw==
Date:   Fri, 21 Jan 2022 08:27:08 +0000
Message-ID: <658FB7A9-FFE1-43B3-8826-F06F4933DE76@live.com>
References: <CA294A24-E279-47FE-A5E3-E47F1A2619B5@live.com>
 <C6DEF799-EEC2-42FC-84C1-CA942A614864@live.com>
In-Reply-To: <C6DEF799-EEC2-42FC-84C1-CA942A614864@live.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [/sfbNiChjDc2wttft6A+hb4rDXgLEYU8vp2wI2w5gE2M05vnQxEseJtUZAEFBNxk]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8fb7b702-2c52-4ed5-7b27-08d9dcb7d055
x-ms-traffictypediagnostic: PNZPR01MB4912:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aUsA/mb/90JpmGXyyCdXOl+lNXhBJooQIfZwK7RZ9FiIbiH2KhMlY4yJbC6YLDHa7BeQB1CQTbgS6pd2WKjhSVXXbyIREmSTqkHBGOBSg6njWorD6Y3d3aYZdEWelNJwZWMQVv8DjxCBtrgb87R1pWxjMrrGaGz7QgpUZ+uZMYOGy36A7kf9UP56QStTvvnPb8FkyHwd6U4XslWeNrm3QdTXHrKFeuDEVC4uSK0TFIAVaTpwlajJg6DDkS3mS54Cx2iC1DbkvQiFueqETf9JHK5cOyb50BUF5tjt9/g9+pjUXQSL1mheHoNDJXLNaTr/Z6aMz75qPqFxsOIBMKoSN0P8UCPXv2ZfRXFo6tbogd/ynqf4aohWGDL/a3GlcdekUQ02giLrnpZcF3vgEKbUHQaFeAyiDkSNFSECnq+Rzo7vzuoagGdXpeOjv7c/SJjb9bFdxQtwM7ZZrfiHIZFnhXhNBIeLKUKXdBa6icM0K0bP/fCsYxr7daPOROgjkTq59OxmHzWwXvSKvX+Y9tjcQ7YWottnnX6Q3HkAbvaoO8BLUo/ohlwCSPyVHxCJnZlyDpSYrz6SxSt/VfH7Hp8oaw==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CNP7ayXmtbQubBdoQbiOnk6R4LHc6Py7SRTv9jqlEEpBeks50ECIxnxSamuV?=
 =?us-ascii?Q?GhvBleRSzvI1B+BaiwMgR+IhU+xlvER0f0OxEHJShGIJ/E2vNDDv9P35B0rS?=
 =?us-ascii?Q?FcBUu9nKnwWwJSfBDpHX7XOMgXqycL/e4sLbY5boYCWXkN/XkwPJ1X9hAvor?=
 =?us-ascii?Q?dUP0m+3sNLCnBSzlOYqLkPh3lKmRcJdQaiurNqyQUZBSusBMJZ+Ur+js4cd+?=
 =?us-ascii?Q?6rtRsGdH1U/GgNJWxgQbzu5BT+r0OB5tTrxKI9eHnHNo9r4aXbqR2u5SBWqQ?=
 =?us-ascii?Q?TMqH44GXJcC2f7Td3fDl111bOtlSgD+qlaneFAMAvVPWyf+/oK5nRgbJhIw4?=
 =?us-ascii?Q?vweA7g4qjzQ4ADTLMpm3URHwYyjp9bZeaZtN+yJU3xuCMAh/vb3d//V7GUCa?=
 =?us-ascii?Q?hzOaA02ooxKQkMpY1yqWaH5Rke3FmHwxM87F8JrzpgjCPwZ1C/9IARBrqL+i?=
 =?us-ascii?Q?5qGC3okaR8h8cuvKy1ZE004CxzxvgCOsJuypq/QPwLr1T0jssjtwRyFSubTU?=
 =?us-ascii?Q?p6oH0fSSoga7kkw/igpDpPJ5Oxer6u5Y1XP1htNtVP4qgdOf9VofwtPyjWkE?=
 =?us-ascii?Q?thnXANMz2Z6zrMUw5kPRCe5M9P89AX0gmTAcZJnGI6/VqVNxKLZmgMRgDlib?=
 =?us-ascii?Q?xNrjBVbeoZmwW25+pYLrNDSoOBDMgg3wsCwTS212XW1KV16WI3SZ3dGh4RZw?=
 =?us-ascii?Q?flaJiFizatk1HO2PTTPylj52o3LblL1Fw+5prDcE2OJYAMbxZ1VHCDgoU2+x?=
 =?us-ascii?Q?JGP4xbhWQHEi+Tvp1p8gDhbzOAotPHiP0/2zDsoO6KQMZWyyduxNlm5fxvHa?=
 =?us-ascii?Q?f/tDzbWHU+gWf+dIY6e+QWxSKU2NyUtunsMdhNzTooHu4u3dDobaMF0U7nZQ?=
 =?us-ascii?Q?j3m8ZBd55S7/vNNhRmkJoUhj9Ley6I9DFL0Z6Gi4hsvsXOuP7WnLZpLMjz1H?=
 =?us-ascii?Q?WgJp6tP7kaOPoCKmpZZPF2gL8J3MHwA8vntR+jspahKtgkVBtyvOuN9XnqX/?=
 =?us-ascii?Q?DQRZvoq4vH+pbex4mJmpZHYH7A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0BEC3BFC18F6C049A97C07550AE38246@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb7b702-2c52-4ed5-7b27-08d9dcb7d055
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2022 08:27:08.1400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNZPR01MB4912
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aditya Garg <gargaditya08@live.com>

This patch adds the Fn mapping for keyboards on certain T2 Macs.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 drivers/hid/hid-apple.c | 70 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 823021c24..c4d21c617 100644
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
@@ -272,6 +317,25 @@ static int hidinput_apple_event(struct hid_device *hid=
, struct input_dev *input,
 		else if (hid->product >=3D USB_DEVICE_ID_APPLE_WELLSPRING4_ANSI &&
 				hid->product <=3D USB_DEVICE_ID_APPLE_WELLSPRING4A_JIS)
 			table =3D macbookair_fn_keys;
+		else if (hid->product >=3D USB_DEVICE_ID_APPLE_WELLSPRINGT2_J140K &&
+				hid->product <=3D USB_DEVICE_ID_APPLE_WELLSPRINGT2_J152F) {
+				switch (hid->product) {
+				/* MacBook Pros with esc on the touchbar */
+				case USB_DEVICE_ID_APPLE_WELLSPRINGT2_J132:
+				case USB_DEVICE_ID_APPLE_WELLSPRINGT2_J680:
+				case USB_DEVICE_ID_APPLE_WELLSPRINGT2_J213:
+					table =3D macbookpro_no_esc_fn_keys;
+					break;
+				/* MacBook Pros with a dedicated esc key */
+				case USB_DEVICE_ID_APPLE_WELLSPRINGT2_J214K:
+				case USB_DEVICE_ID_APPLE_WELLSPRINGT2_J223:
+				case USB_DEVICE_ID_APPLE_WELLSPRINGT2_J152F:
+					table =3D macbookpro_dedicated_esc_fn_keys;
+					break;
+				default:
+					table =3D apple_fn_keys;
+				}
+			}
 		else if (hid->product < 0x21d || hid->product >=3D 0x300)
 			table =3D powerbook_fn_keys;
 		else
@@ -480,6 +544,12 @@ static void apple_setup_input(struct input_dev *input)
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


