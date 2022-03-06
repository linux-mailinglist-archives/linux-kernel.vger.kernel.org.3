Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B862D4CE8A5
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 05:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbiCFECD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 23:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiCFECB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 23:02:01 -0500
Received: from IND01-MA1-obe.outbound.protection.outlook.com (mail-ma1ind01olkn0173.outbound.protection.outlook.com [104.47.100.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD72022B18;
        Sat,  5 Mar 2022 20:01:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HgxiaWCG+I4aZnAtPPfPU475zHpV6t9yZ0RTNQlcx9R6LisNXNPzAxDjGi+rCHk71HZu0Nz1vq1SfHRypjBaLq37NtZC4Orrgt+1IZvFbpt2paIz3KQ7w92dvGF/CX5QeZPocJRSjLEiFIfdI6nsBRI1WVI0m8ICA6MB5E9NdFPQ0Bv5Fq6B93Em+2wh5WiFVwQw5livaFnXrIDWHLXR1TaFJWjK0hjd4o9xyQgPRrqe3WsUZhMiRbdfF2LnrAJjYPukqvWyA3f8db2a/qjmmjtkuDuupIEdofheOPRX9Jz5lbKbsPdJ5/u4YMvNAyuIww0xp9/nxGyPOCV20UyjgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xG+TyjcKH0Px6rCxR7Pw6EqVh3SV5WA+74Grk/KAYt8=;
 b=IrpeIlBI8743SEFeuAbFlv28dHXfj7NI2cgMO0LhraqVb1N9ot1VIOWHesB+UfrIDgQNW54Cmy0JfGMhb134bwO/KKPjaZ5wd7lyTKoYTvabVhYqlAM3DIAqcIPTT5v+ksjBS4EC6ohZCQqKnyHB8d0eC/sgqDZmNi32x/Ts+y0mcwr2LB6qdh1f1lSK9N3f8THvmTytZ+verXGTgSUCAjd6DDQVM1WQE9vZfhMIH+sorg7klN0rrBcmAN5WVDRzalg5T9NjPx/V4szenWhGIrs8z4fIVYVVHu3ZAWxhFTE99QSI7pOh0y3+EqQvLzutpumepFHAWpSwZS1gvJ896w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xG+TyjcKH0Px6rCxR7Pw6EqVh3SV5WA+74Grk/KAYt8=;
 b=NnXR6znRY4QtqNWas6awm+PNjUO5mshfCQs475e+Jl1fKYFzrdAJWUsO0/MrWKhT0mYcWVdZ8ZyzS9fsunESlYC1i5kcSSyuUHitRZdGCaTnRMQiT80ghHAWkfzs95km0gCg3aaUs5JJDTc117y/Waz1l3hwvqDCQI053eBdGkB5mZuFfHlGeduuB/M311MrTmIU97WgOn2rnZlxLYZS1pDhz6okNvWu+cL+UBQHwB0vDbe5wy6DrEqeB5yViWgBVCgGmIft2JXJe7LgKN0++HTvjmBehsFqQ8sJC+kMxmXCmkOvQeZZL6Zg+fWg8yuqou5wvHCmgQQboq3t0J5zBA==
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13)
 by PN0PR01MB5969.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:65::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Sun, 6 Mar
 2022 04:01:04 +0000
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::3465:cd70:421e:78fc]) by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::3465:cd70:421e:78fc%6]) with mapi id 15.20.5038.026; Sun, 6 Mar 2022
 04:01:04 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     "jkosina@suse.cz" <jkosina@suse.cz>,
        Jiri Kosina <jikos@kernel.org>,
        "alexhenrie24@gmail.com" <alexhenrie24@gmail.com>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>
CC:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "paul@mrarm.io" <paul@mrarm.io>,
        "admin@kodeit.net" <admin@kodeit.net>,
        Orlando Chamberlain <redecorating@protonmail.com>
Subject: [PATCH] HID: apple: Bring apple_key_translation structures together.
Thread-Topic: [PATCH] HID: apple: Bring apple_key_translation structures
 together.
Thread-Index: AQHYMQ7NtWWr6sDn30KTrEKF2M4JdQ==
Date:   Sun, 6 Mar 2022 04:01:04 +0000
Message-ID: <4111ACD7-5928-4D6B-9C0F-897BA057A891@live.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [eTrh+xa3ZKfSaNyUQk7fxpbboWEJXv0o]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86aac38f-0e69-47a8-10b5-08d9ff25ef86
x-ms-traffictypediagnostic: PN0PR01MB5969:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5RzIsz7mOSmtYt7xqFQD0CVCICbHepUlAC8WGHSSsFTDYj+Ew2qHQFanw06OAmWa9KU72qpK0fotFoLIp5qtLYjoIp+pyL1ml44Sw+S9hTUKYBncUu0dy40DUOWVG3RrGoLTDuQcBBsfp/uL4mOlisk5vYfenFiK+N1bmhEox8QSiaUn6FJ57SJjH21S+xnOzJ7vkWDIknGC7zgNu/aygrwaO8EDumJgHxWwIz+1O8RkR5541aPf7KZQNC8ZNHTex3M+jpGiO2ibQ7WxBDxndSBYGI3oKDLUj7cu/8BuVP9sdnnbLs86XG34pKrEU5XdBZ5FmnQs3f9lJxfs6uk+dxcVf4ulfKAFVutoVSU2w5kaNwngQJIl6MlbmfAMUQGsBmOEADz+jfl0k249k0VBfFJQj/VVYJXpyFxgaazibESC0X7Xb/ttcvz+7jdFJc79nwc4HXY7ccF0CTCbFYsfs3L5RQBzO7lyv0cAX+IczPFwgJp3XDTAZOgbarv7kqIEBU8xS/+7qZdG0EpAnQ8cBfducKjP4tO3mkA54hEHXU/BH+h0VovDhIEOPoShcNPwVD/qAQj8xDSMd4H6F7lz1A==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7eL7tfm7c/OKAVBXKIlhtv2756GE3c9ErPhS0kmfFSyk/l0PJtv2OvXkGPjk?=
 =?us-ascii?Q?dSLiY3jCOSCP6vy/1SmqFK51yr9/7aU6zgMt0WRVYZR5kR8z2r3MeOvZ2Yy3?=
 =?us-ascii?Q?+cTKd3cES73vJx1nN9kp4rMxlMO6WFSm3Mvp7KOUcNEcEtunhiSSZuswOFjn?=
 =?us-ascii?Q?OlMeLa6nEVCW6DRBAnoF6AsXEBDhXRqJSCNqa1boaZx7rIG/1hMmebki6ogD?=
 =?us-ascii?Q?tGXyf3nBb9mV0A6wYzFrOQT9e4RFejJNy+eR6/WVPzreEtRT2Na2aZ78qAsd?=
 =?us-ascii?Q?z7VZ1dkxxiCxDctEciPSRt7v1oOOkK3dHv3YZwtJ+GpMcXYEXJG+afPck7ks?=
 =?us-ascii?Q?XH8rzz6yoovnPXyQ80A+4rudqhqtBYy1OYQg2BotvHIfHKCZXhcO3c2IZ5RM?=
 =?us-ascii?Q?Sy+XPJwcrRNQIJvakIfJo8bEHcabU+i+vbP3TdAuAH48k6oky57ew0CojrWI?=
 =?us-ascii?Q?sU6fFF1F5/h68yj0e+e2im6nIVkesD8Kf6xY2wsxuzSPLsIWdFrZ69zOuzw2?=
 =?us-ascii?Q?TAeLaMdTu+Z3YxHkbukxvPJU8Gyub5wdtNb3T+5TqneNFcy6F5W2ci5o/2Sb?=
 =?us-ascii?Q?nwtw5IveLLLRyNH5YrmqOGM2zIeV/w6bsmc9p8Sjs2DFoJIoLqQEe3L0C45c?=
 =?us-ascii?Q?BdTm3MZrtZd1C5Ij8OHrmZvGMjYRfRArkLuafnuE5lrZN0hJEt5FGMvzS2vK?=
 =?us-ascii?Q?dZWta36iYFlEyaudHifmSnQWdeyGYT5SOxlHr1YLOE84OCE2WvzVMhsw3FP/?=
 =?us-ascii?Q?xYi96788C9sF6bUDZgS4i03mpBrOLNWUoSJfQ36Jkqqd3NDi2hfdYQ4sJ+W8?=
 =?us-ascii?Q?vs5bFYIEOXiBwQASbk0QNXZmfGcqFmkvfMPhcuslcNJvuDCDgbOZgpTUgeMt?=
 =?us-ascii?Q?x/Qn+0SHM95Ao/LFvsTZrq8KwobtDr9CbIcAoyCDjpLw9zrSNB/zTdxybZFG?=
 =?us-ascii?Q?mK255QJOs744PqRKesZ2bw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2C0A04701BA5C04C82646AE2B4C16C9B@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 86aac38f-0e69-47a8-10b5-08d9ff25ef86
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2022 04:01:04.6268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB5969
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aditya Garg <gargaditya08@live.com>

This patch relocates the backlight structures so that key translation
structures come together. There is no functional change in this patch.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 drivers/hid/hid-apple.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 0cf35caee..a2769c842 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -85,6 +85,19 @@ struct apple_key_translation {
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
 static const struct apple_key_translation magic_keyboard_alu_fn_keys[] =3D=
 {
 	{ KEY_BACKSPACE, KEY_DELETE },
 	{ KEY_ENTER,	KEY_INSERT },
@@ -126,20 +139,6 @@ static const struct apple_key_translation magic_keyboa=
rd_2015_fn_keys[] =3D {
 	{ }
 };
=20
-struct apple_backlight_config_report {
-	u8 report_id;
-	u8 version;
-	u16 backlight_off, backlight_on_min, backlight_on_max;
-};
-
-struct apple_backlight_set_report {
-	u8 report_id;
-	u8 version;
-	u16 backlight;
-	u16 rate;
-};
-
-
 static const struct apple_key_translation apple2021_fn_keys[] =3D {
 	{ KEY_BACKSPACE, KEY_DELETE },
 	{ KEY_ENTER,	KEY_INSERT },
--=20
2.25.1


