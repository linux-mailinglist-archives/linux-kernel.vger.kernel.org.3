Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA1C4A83BD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 13:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240423AbiBCMXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 07:23:08 -0500
Received: from mail-bmxind01olkn2074.outbound.protection.outlook.com ([40.92.103.74]:3758
        "EHLO IND01-BMX-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231842AbiBCMXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 07:23:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WnSnL6JHc6DiAI5E7XUQDz0fsi8pdhrdXXyBYoYcUY/gsPXV/yXOzBPyqYYMq0voJyhoxaNYG//9cmg82b7U5YuZYPV9ZVP/POP9LjCly9ibJmsVaGIaTE42evpKb+JipBuIgOA2OAU9l9g5lCnXdgr/LrdbFt+v3JJQ4DaZzHTAUJbkSdtoBVDBnNAphnVKf/lvfJxMW0OE6mjb3kvbhUig1i2LNcayvk5fP6NP8XKCQFiizXteRk5O9pKMSIczzElpKTVn0BIjlfmEYEfigBsNE9tYFlNmvGV1PTX5G7M1hAjqLFdXIaQ32vcy2HJwSN6cwQuF5zwbxVz/HnRAmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31G4u6wEIIkwYzOfWErw6RaNsoVqvqzkGZmfnLC8M+Y=;
 b=kmtv0R/YAdjy8m6FfE5zJl5p+pGunrcAEEvdpc4Bd4zlDyySdFTmW9P7D6pOjsTiVBSZ82LXCxXltuHRYye2femg4/zsg/7AR7g78uEA4lwUcBWoJ72mDfxzbDgv5Vm71hxyv0SD6h3OmL6v6WozKl+3FsV+16ZUpsnqqPi53e6orZrKXedTZaw6r7fSIdqDgYN7+wYZ3c9LZ3sJvz/MaoeE1rW6YuMXUpDfqqGbVoCXSyK3nZLo+pq6JrlZLn1cfxFawezBT50mr6Wf4R5YugUq/ng0//GUcbOPcsRC9reTNbrZYdwI7XJehnBpKS9P7ZyJL1FdswWoclIQWvb36Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31G4u6wEIIkwYzOfWErw6RaNsoVqvqzkGZmfnLC8M+Y=;
 b=XhdIt85AOVY7Lg8OcBZ8gwWvSLaWlNY43XJaMu3E8s3GZ2bx4hJdLBWPRPjghiiTx0Zfot5xu5ml1y117oQPut82r6dazKZmmPC4nGajfA524AresKuvbwhPQCpzOuMOq0CdLPKJCTVN64s3NmEPc/D50k9m26EJOvr1O77yY0GyDvLhYTLa3TRD2YjxdCE3l2ytnYwqHwhP3VLMeqw3Dc+qr0YxL32mk8Didpw8SlU8EnteJqh9yYnV6+l/qDXlO0O+Z9v4MLYjeRA3wjr4O6jo8Hzea8fpsbT52afjSKUjVCt8ypxNJf10JIfxL2XzDKn9ga5dTj5pKrdGk6mQbQ==
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13)
 by PN3PR01MB6934.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:a9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Thu, 3 Feb
 2022 12:23:02 +0000
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d19b:7cd1:3760:b055]) by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d19b:7cd1:3760:b055%9]) with mapi id 15.20.4951.012; Thu, 3 Feb 2022
 12:23:02 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     "jkosina@suse.cz" <jkosina@suse.cz>,
        Jiri Kosina <jikos@kernel.org>,
        "alexhenrie24@gmail.com" <alexhenrie24@gmail.com>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC:     "paul@mrarm.io" <paul@mrarm.io>, Aun-Ali Zaidi <admin@kodeit.net>,
        Orlando Chamberlain <redecorating@protonmail.com>
Subject: [PATCH v3 3/3] HID: apple: Add fn mapping for MacBook Pros with Touch
 Bar
Thread-Topic: [PATCH v3 3/3] HID: apple: Add fn mapping for MacBook Pros with
 Touch Bar
Thread-Index: AQHYGPjJEELh7X6UMkCMSdLNxORFRg==
Date:   Thu, 3 Feb 2022 12:23:02 +0000
Message-ID: <B17D84D1-F91C-4CF0-A931-C19D0278E329@live.com>
References: <67E7EA8B-CF21-4794-B7B4-96873EE70EF6@live.com>
 <1088ECFE-B356-4731-AC8A-09A4421DD7D1@live.com>
 <D0C26284-966C-4581-BE37-78A6B0B367BB@live.com>
 <9981348D-0D48-4613-A46E-03E9A1897E59@live.com>
In-Reply-To: <9981348D-0D48-4613-A46E-03E9A1897E59@live.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [v8fSPPYqYFnVLCqIq7YI6GxCi/p4bvY2Z2Lbi1V86uaCoOfE6euGa2B9aCccVU+r]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c62a2cce-35d7-45e5-1d25-08d9e70fec6e
x-ms-traffictypediagnostic: PN3PR01MB6934:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XXQD3jKnoQgTbErPoBCYKew7C60DuJP8YbnpIf5A18qMHzGRzGLuoeFBBVFymo/JTSVoD17tlDPTAW1eVuI7Csy7TS9DbTvO17NrOiJb0bZ5HVqlp2nBgmXQQK2ftDshOOvdv1FZwiGz9IHLFHS+3Kec+85ePOK5pYnn7CVzT+jTWfS4RvGYwE8+aEQA5DJdUcZ5/WYgsNhsVsqhF76CbItPexnlAvlenHM7y6gaKLaEllV0jDSBuouxpCISEkpFviSsHqTl6c2TWPLgAy+gAUR43MppxzsUNf2FdcKClr0T52cYh02wasqupAubDCmhXTwg51Kf58mL4ApBSms2/QkrtHVH0LAGke2alPLlG2AvqhlcnGdzRrR6j0yHGvFjHq1hvav0p61dqDgcndZNMJopR7R1VeL7P3i+epTudGNVHRu40LGZFf07aP27l81Bzpsj9ZPcLIYBBIVJ+WWdWSnN5g+8Vwezy0unBqULtGixjyDDXnxrIy76rYgVReZpRhAttL1cyVoPECCfFtB58T8JGZFVKuRJJxm9tpwqiAv8dM849CgPckwQ7bL+rWRJ62R6mJQZQfe3jalrT9Qesg==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zXHt7zcLPsz8DdSZ96MaMT3uTMG5SrSyf07dks1bdPUEKSMS8o5b3dUSjQjo?=
 =?us-ascii?Q?U7UJT2/TFyA+TDHno+DbwTqQPKKtphbBxNimB9pLPj2CpUNCjtdUfKGFLPGU?=
 =?us-ascii?Q?SeWCMRd5L7hEOB9hz9RQDMkny4y5tjkc47YNFU/LkdB02JlrhXq3MFameUT7?=
 =?us-ascii?Q?Nq4u5m5Jc9Oir+fxPSa3JLHqP3TDmue2jOtPvo+HqkvTi05DGXcXmUlq/Do4?=
 =?us-ascii?Q?6G0EgDcCFxaZv7GCipRnUJJwS8AAYhuFq49a/3bZPN4U6DI1qivHTdUfRJ0b?=
 =?us-ascii?Q?ffKrrdKD3MsQ2eMZbx9S44zTmrvWuTBxkbrU3A1kZR8gZdnY/rhgRcgsqeB+?=
 =?us-ascii?Q?MohM553V3gYDUeR9zl+fjgJZWBxfpJV1/FiB+m5hKdFDyK2npaQnuWFKnMIw?=
 =?us-ascii?Q?KHbaWq0EehZRjH7qhyfVtaNl+d1OvvC8DbDlqWFbLrOBDyT7q3F9osqF5kz0?=
 =?us-ascii?Q?48g3YLB+ve/8APE+S7EpBoa1SSLZXypBR0xjdFWp95n5b3oD5v1D1pLw0s4s?=
 =?us-ascii?Q?c6p/H5I+0FsErD1B2aU7dRPsaiS3tF/ddHKkNGY2xAdKx48wFk77rmkTMTtk?=
 =?us-ascii?Q?OwMcXmBNFk8LZxAarTLFlAkjwALZoI7gTzOi2TP/jc4z3gU/ZL4vx0UFVqol?=
 =?us-ascii?Q?MDrluAj+e28BmEGLv4qRAWBVq0v+qU/Bbh1E/s94FX/6/4unM74KLl5JCmXo?=
 =?us-ascii?Q?Xej2EsI6yCKQjj21Ojvel9EgzQABTUUirWVbYubvzLsKIEvd3iqt1HiyxuXY?=
 =?us-ascii?Q?RJrxHMPM3IHLrJA/neZiUUk7HTU6Pf+v7KFiiKSUihMKWr3xww1RjbEV+g+M?=
 =?us-ascii?Q?45zjGSXE3nuX6zV5AiT/ZPRZskfL7I1Zbsg1ROu05vNamQ2SBSzQwxar7SJr?=
 =?us-ascii?Q?ZxJDVkn+d4jN/hu1jkCWtaXPlWO2tqOxwg4vUwyFvPL3pQnn2I5iTN2MvNZQ?=
 =?us-ascii?Q?dlI+R/LOQERXd0qy3MPTfO2SpE6/pC72WU/MUUYfT+t/kk1tCcf/8l30K3tc?=
 =?us-ascii?Q?g/1t0XwBnMyWHwHAroB3c1j/pw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4B76671B3AEB7E42AA39D2E1335B6AA6@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c62a2cce-35d7-45e5-1d25-08d9e70fec6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2022 12:23:02.6488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB6934
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aditya Garg <gargaditya08@live.com>

This patch adds the Fn mapping for keyboards on certain T2 Macs.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
v2 :- Use better approach to map fn keys
v3 :- Use BIT(10) for APPLE_BACKLIGHT_CTL since 0x0200 (BIT (9)) has been u=
sed.
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


