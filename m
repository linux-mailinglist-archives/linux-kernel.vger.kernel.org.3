Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42DD548C485
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 14:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353459AbiALNNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 08:13:40 -0500
Received: from mail-ma1ind01olkn0147.outbound.protection.outlook.com ([104.47.100.147]:19106
        "EHLO IND01-MA1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1353504AbiALNNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 08:13:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NpRGnzq1vRkjFRPbmnAj5h5QakxOYMGVc75OSssnkZMBK3fXvL9MhlPEtJMD/hRRuVIGKi1iknHN0QXScWN+pjgdyDcyp2Q+XKhW8RzT/GTCZdMsmarYERSD1rvEukXMH4ds4sJmDkbC/sObWqbIk96FJnEks8I86ICb8jRqiVwcs8iNumVWRWEOinSpRFUkMcxDDhJUEw8z+oqUg8GBDS40zaIcwJ1xMawYAOQufHRcUykYi7VeqK5yFx3ARh1O73uLjHZUH9fFUwrS0fKv+SLa8VRbK5E+vuSllDtHACMkUZJZF5cBcILRzUvZE/puNBXEmopkbslp6SYWhw4wHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/kMTFG8OMmTFpRBz5T9Ud641V/Oq/od8Ewz9EOvGic=;
 b=NORvbuBa8xKNy0RX9oGhWF/C60xnnEHs66Q4kllWkI/txR7Rh3yESVOhnrc1w24M2NHkrL+PrxPWPZaLtD7sWdmlz6URJ07S/ZEqx9cTcs3kC47bOJJC1ACa1YtwgJwmGUYipmGYDqaonSirZiuqbEuVpXzULxKd/dbOUfX6/o92qRtoBYD6sPfIiURLLxPFU0ygGPbLXsF0zonaLRaMVm2Ut0/geV8ymudeqJ+LU7ptp8uwcqj7/M0/v2aZIzGhqHN46UBvN4pgLiXWYNv1vrtSfuAFnz7XLeT5nQU95B2BSM6Ewg975p1fspjgRmHqZJQPO+ATXWgB5g6sF0RCwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/kMTFG8OMmTFpRBz5T9Ud641V/Oq/od8Ewz9EOvGic=;
 b=fkvEQ02QIKcGd5czTtufPdMfN4PEBnDTGPj2TBYiJTV84VDGaiNMyxwOjxVknsr9S6O9S6moOieF8J2iDqX/fRHhm0Y+iyOXQlzcYAqP16XwCAYJmWEmz/5yxQCME/1fetQ+71B6v1lE/90nWTR08Djg3LgGRVN1Ypng/KrOhe5zFIBWorfPYDTNWIQzbV/vxeFkEUxMDqDiHYPHqXIc28z/qiZevnqduSv4NayXbS2j+T1IZsj/I4NiQsYD44n9hDGA7oMz9Gd8he2t/sY9Up268KUbXpRdzg7aeJ/h2ufZf9Vdd/8FtCwXH96K4YedQlGMhgfw5DdulntDFjQbsQ==
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13)
 by PNXPR01MB7201.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Wed, 12 Jan
 2022 13:13:01 +0000
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::7ca6:9165:19ec:4cd7]) by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::7ca6:9165:19ec:4cd7%8]) with mapi id 15.20.4867.012; Wed, 12 Jan 2022
 13:13:01 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>
CC:     "linux-uvc-devel@lists.sourceforge.net" 
        <linux-uvc-devel@lists.sourceforge.net>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "paul@mrarm.io" <paul@mrarm.io>,
        Orlando Chamberlain <redecorating@protonmail.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] media: uvcvideo: Add support for Apple T2-attached FaceTime
 HD Camera
Thread-Topic: [PATCH] media: uvcvideo: Add support for Apple T2-attached
 FaceTime HD Camera
Thread-Index: AQHYB7YgubwvQq98m02ITNscTMkEuA==
Date:   Wed, 12 Jan 2022 13:13:01 +0000
Message-ID: <F8030678-1AA2-4601-A1F0-CA8618CFD969@live.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [BliPOO75yCj/a6OWulJbc3FbLTV43x5zuxSYclQ/4iFmFNqsv3Y5Vp9egd1Q4JPh]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb21d0a3-ecf7-4297-0a71-08d9d5cd42ba
x-ms-traffictypediagnostic: PNXPR01MB7201:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TJpbId1Mgzq4WxkZrLVw2qkgfqMo+Cg+gl0zzq3gQc4MKWYgkVD9MA2Wdsf2g/0xrWULjq1JeyR1tYumWgr4a8busPT9akp5buuNRBqwJWFXtSzGkO8MMTcjI40oHoABOobcCFINq2l9d366f+u2yz8NjSpNwRfRCUdLnGD2R4mlVraQVYjBmJFgiW0MV+EnJWchWHyXJu4DRytTUIPlUFj1a3B8ogXVhlZ32GjaNZoLuZLwrjlph9DHwPVq4291ivQez4Mk9rvTZbTHGzSaK/nsf5po0QyNDMaxWq18vJJ7kENe7mYMb/ZJ8OvU018IgH1KW0n+HcrJYrd8aKhOxtfc7e+z02GBhpSYsotuZ3Wafk+6yg3FoQ03K3aT+3V8/RODROtiClQv0Ym3qiV3vPCDrdqSVHNdmQ0KxlW/4eQjPv19JAAVPJ+EkVbTPAjSAVZ9y1YcPouCaYca8jIUvzgj71pH1GYrEsx0/zLoSZT8Pyf0mmtPHr8mDESo53SaH+sH4vIokOGvkjZ7Up8QNbrr+itzkLEQRAo91o6/8UKjehzP84HDXlXGwGq2HT4Ckso8K9IovNHYAQB7vEVWHg==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N0DhxizGenG+rp6+wM7kGTiHNxMpduYLXSZL4GPQnoDqQbg/gLk+5cuX8gwk?=
 =?us-ascii?Q?MzP31BH0j8JtmpI7LN7dy7qU3cG/QxlAnbuJ9lwKkMNNnq0olgGkUOrTtQou?=
 =?us-ascii?Q?8XEYeKwKq/pcda8rCDALc9Hsekfkz0nKtqGnZzQ+ZFK/2OV3wG+ut/CCMTr8?=
 =?us-ascii?Q?Vr5xZ4KDI0E1kPXOw4s8eNLht8+PR1waw2rpTgvfzED5cJdV+sLK1cOtT07S?=
 =?us-ascii?Q?kvjWffMFOZdbC/hfvZK9o0pXzBPHP3BlIiRZX7blMmE+2xxQjkq45R6SnFTs?=
 =?us-ascii?Q?xUR29B+4F/La57zcuHv3FsiXNwUljUW/Ig5+i23hohCfkysauVow+XKjCOWV?=
 =?us-ascii?Q?AhNfBMUOitcDWmznV8WtdkeU7sneNSzxD0jgqAudtKRICqvRq//X1GZW6rCs?=
 =?us-ascii?Q?SO8ON+pOJHE2YO3HlD/F8HITLEkxHrRmaYCLp2O3bvr4Kw3SWWJ4uGoq6QNh?=
 =?us-ascii?Q?Hf/gT+x1Un4skDRKN/8fnOIDj6pQEGSoz2dshOHmsnZJCWUM6BlKFghjYd0L?=
 =?us-ascii?Q?LCtpXp4KLuCaRsRGlT7vhmO/nlOWZBDZ4TEY4BLDnWX5g5nlqy2KX2hDycZs?=
 =?us-ascii?Q?ENOM7KCfOwLTNQpTqnNAoczGbk9/6px2EF1clkZCy/FQuUxSNWgX9RrZ5Cor?=
 =?us-ascii?Q?hLFq3PZHYAhQw07+o1TwGbM8Bn2BJgMV6STiQZwwVnaU/053o+20IkmDGrjZ?=
 =?us-ascii?Q?8blXvP4uwS6CyWGZpCr8pxeORJBuXfc9q3uJfQo2xb2HaGl/10IwRNECHbJt?=
 =?us-ascii?Q?/xYZlJ5n5qO7AfKv7dNYkD8OI5mrfy1U4xA8iVS/L4tU9Sw82B17xXL38816?=
 =?us-ascii?Q?nU80tUg+79HrKX9xmFa7U6GHeQmiao88+68zeKYlSbpT0bVDSTSuyW4Ulopt?=
 =?us-ascii?Q?7+YiRmRcrw9VbnprbjVyhdxeXWTHvnowS4MTBM80D1GaYFbnYLDp0PsGkRLw?=
 =?us-ascii?Q?C81qkDbsta8Jot5UzshO1OjLX4InBsbEknwtfKvQTO91LEnag3vgBE55zQhk?=
 =?us-ascii?Q?EFNDR9PNMwa35SWl+F3K7abBKg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E0923E64D64D254598A7724A67846A75@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: bb21d0a3-ecf7-4297-0a71-08d9d5cd42ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2022 13:13:01.3509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNXPR01MB7201
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Pawlowski <paul@mrarm.io>

Adds the requisite device id to support detection of the Apple FaceTime
HD webcam exposed over the T2 BCE VHCI interface.

Tested-by: Aun-Ali Zaidi <admin@kodeit.net>
Signed-off-by: Paul Pawlowski <paul@mrarm.io>
Signed-off-by: Aun-Ali Zaidi <admin@kodeit.net>
Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 drivers/media/usb/uvc/uvc_driver.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc=
_driver.c
index 7c007426e..88dc9e7aa 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2848,6 +2848,15 @@ static const struct usb_device_id uvc_ids[] =3D {
 	  .bInterfaceProtocol	=3D 0,
 	  .driver_info		=3D UVC_INFO_QUIRK(UVC_QUIRK_PROBE_MINMAX
 					| UVC_QUIRK_BUILTIN_ISIGHT) },
+	/* Apple FaceTime HD Camera (Built-In) */
+	{ .match_flags		=3D USB_DEVICE_ID_MATCH_DEVICE
+				| USB_DEVICE_ID_MATCH_INT_INFO,
+	  .idVendor		=3D 0x05ac,
+	  .idProduct		=3D 0x8514,
+	  .bInterfaceClass	=3D USB_CLASS_VIDEO,
+	  .bInterfaceSubClass	=3D 1,
+	  .bInterfaceProtocol	=3D 0,
+	  .driver_info		=3D (kernel_ulong_t)&uvc_quirk_probe_def },
 	/* Apple Built-In iSight via iBridge */
 	{ .match_flags		=3D USB_DEVICE_ID_MATCH_DEVICE
 				| USB_DEVICE_ID_MATCH_INT_INFO,
--=20
2.25.1


