Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C5749C7AA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 11:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240069AbiAZKhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 05:37:21 -0500
Received: from mail-bmxind01olkn2040.outbound.protection.outlook.com ([40.92.103.40]:63299
        "EHLO IND01-BMX-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232441AbiAZKhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:37:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fpBdKL6dAwi4Vq6TlaHmYMrgG5hsY+GppU+VXubt3xbib0Gj2XdOKqJfXgqi7vEbw1ZGFNB2DGKesUFhSzzn9Lw4z4J7Dnil6Q0hR60dAUB489ftTrJwLMC/HNggSOhlghkWeSTj+4YznMoLHMPx7sMF17BxHdJoEkqKJ8uNlnD8gu/gS09r9QOdD6TURQgPg1zFU7/4Z6Hle2VfbZmr6skmRpva6cGGs2Lis8Uwd++pYbf7e1vw14RChhZULWhRfYDYDu/b451I5qSdhz4dZvgRF5ylPYwNdOy9YDJymNy2Soz3gyWbOk9Uyf3VlmnQHr5L/IvhT6FHSIFfOdSG4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/kMTFG8OMmTFpRBz5T9Ud641V/Oq/od8Ewz9EOvGic=;
 b=EK3Fs7zq5DZ3BdZNQXL+/44uNafVQ9rtL60bmyUUeMR0BDxU4rk7hpKzNRj3SoWa/v/nbuP9IFMDhygFNaYz3UbJrAg7cyG27F4wheolbTWl7xrmSvc8itMOX2s3mP/UnvCGtSGxzLm/nxoSwkPUCDcprP5yaq3x/wPvaOpuOG1ek+Ik4W8ShbRFQXSR2Oka0u1rwbHI4FJ2KIP58wkdLVPPrryJ7Jg2ExrtqWnUpVVWHYQS1Ae+TwOPE0jDLD+rYU1dkoBl3wHvBqcUc/fpyBVLEWaxE9j63e+qym8s4Yj4tF73L3cPQ9BvuvhPu0OP9z4gmE7olhnarNOFLyHq/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/kMTFG8OMmTFpRBz5T9Ud641V/Oq/od8Ewz9EOvGic=;
 b=V7GTsBKD8TPXEEmKpOlMcqnaGjlyJ7ipDVIfQ8eeSOa7wH2fMPAYMsCYJoY28JKjiyLU6e9jaCfCn1DeqwY1VNIRj+K+x3gWY1W+9s8vyFp6RmNW+lLrHIRHR/cu4LeGGvu/8oX7nT9hjT1f2+3/WCpiMOTU/VTNHTIL8ji3PP6m8C1qGmau5Sls2xPmRQArLOZ0NwPTLfSyYkY5fflRljPb/DUJL10HxvFXeObBnAJQmA/YCx7WEMkhsEwoLPWe5YSHphKTThw5wT2EZuG5ohac+6/WqVB68W8XDAgre1zEMhxh9lASiUaYalvb+edzI/OdVgxurDJYJedMR3qIRA==
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13)
 by PN3PR01MB7190.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Wed, 26 Jan
 2022 10:37:13 +0000
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d19b:7cd1:3760:b055]) by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d19b:7cd1:3760:b055%9]) with mapi id 15.20.4930.015; Wed, 26 Jan 2022
 10:37:13 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        "laurent.pinchart+renesas@ideasonboard.com" 
        <laurent.pinchart+renesas@ideasonboard.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "hverkuil@xs4all.nl" <hverkuil@xs4all.nl>,
        "sergey.senozhatsky@gmail.com" <sergey.senozhatsky@gmail.com>,
        "ribalda@chromium.org" <ribalda@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
CC:     Orlando Chamberlain <redecorating@protonmail.com>,
        "paul@mrarm.io" <paul@mrarm.io>, Aun-Ali Zaidi <admin@kodeit.net>
Subject: [PATCH RESEND] media: uvcvideo: Add support for Apple T2-attached
 FaceTime HD Camera
Thread-Topic: [PATCH RESEND] media: uvcvideo: Add support for Apple
 T2-attached FaceTime HD Camera
Thread-Index: AQHYEqCu2WK4czRdOkWdIOo6RfyQ3g==
Date:   Wed, 26 Jan 2022 10:37:13 +0000
Message-ID: <527C2E71-12E2-45D1-9B50-5A413B6920A1@live.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [i8j6DwbTZhYkJ+m9MaQRIoUWll/KIucxzuuqEom2+lp2GkMdiC7u8yH4NXC2+nzZ]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4fdf6894-e121-4f63-c829-08d9e0b7d08c
x-ms-traffictypediagnostic: PN3PR01MB7190:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NchfHwMStjH/BJuygeLLr/4l+CuIJgRxr4CEPtMd6UVJ3t02Ac0GGCswWFBJ9uT4oVA9cpqoERsuUk7teb77BYhCoVaxr6qHhQkbymoQeqSunGCpzodtZrDfeLahTKQQw3PxwUIPSvtLZZRY6ozj4MrI5g/aoO0xnCxtYxJO4xDnIVfStTHjbOrJyP3AzwMm3QBQTrr1ds+Zy6PNVLKvgTQbUs9H6YDXZRlmfGyWqbqAMIQHa17mSBwuRSNj4QK0J6YoA41Kmur+rl6vRUfNOF5mw3i65IVP0nH9dZNQMkomVioKFtWKmwYP9hsAlTR/xHva04JI21igHdSBHhYTaqfafNH7DyAn0L74dTVDyEfILaTq/Y/ga9q3rKQDWy86gUNYNEfXY+MOgsK13AYjOUD5TqlU8ZBF49CSQpuH0iz6GXQ5jeN1EjSxzBRnPDPEz5ibIqvjQVvvZwaEzckyVdIRVpa4LOId4Ckp5S5cevGsZU/r/zgfOb5kwP1ma0FpxMEUQjRfvaMG0duCtE89tNZFetEAKx9tAnBg9t8hfQsynLq8ZBlzHWo2iFv1n7/6nYAJnpcLBdkGBbUfwU/ORw==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uEJQCvfUUiuf+XzIZ/FuyZBPso5Oe0UkdIzxzd5WhEQ6Gj6oDfnL8rrCwBrL?=
 =?us-ascii?Q?/oQpFvHz622ktsfMCxdwKePRmjZBEjUEv4vwB3wzb9LfTN5XhWNETT4XFymZ?=
 =?us-ascii?Q?AB17w9/We0D+R/1mcxMr/aoA56Hiz5TR34rUBlxAVJQkzpT9mBhHt4fF8gNU?=
 =?us-ascii?Q?BoK8WjEmMCChAHkuv6FQyeYvhbAbloNn2oey/ukfrOmQP52/Y5ShwoFo74md?=
 =?us-ascii?Q?O2XTZpvrwnj7ir1QkOgoX8bo3ndPVGr6sED6hACRjNFDYcMJnam10jgRqWUr?=
 =?us-ascii?Q?2j0SwM0Tk5VAUU27GHiDdN++9PNpf8G+SU8izQSz7RDYWVoEeugt30lw5EsV?=
 =?us-ascii?Q?CFkfJzaMK/hE4cEHI+c9N9Z0l05yiipL2Kocb8tmVFC3CjjVXHRkHIsWbErp?=
 =?us-ascii?Q?gZEMqlAqkbpBlEFFbx/y6IMlOmwlZWDhP37PsxtTVD0bQzStfKzVK3RKBKoR?=
 =?us-ascii?Q?tZphCkeaaCq695O2hotAVN6x2NRMa+zFqne9GgyR+ZvM8jG+drts3+CJ4y+R?=
 =?us-ascii?Q?633a/3skhRTfow8lPVh2Igl8kZSV6IWcKEVRDIngXmJ3xXQBkYerm8owuRuX?=
 =?us-ascii?Q?7snj9GMy50pwMU95f/UoXIPCwc1j+iT50Q03FlXI+HGGYl59DLLCIVWV5HIU?=
 =?us-ascii?Q?0ReQm/MxjpQfym9OfqReEToeM44lbGYYlDRFnFbt4BAPqLMR10PZLVLPaKAJ?=
 =?us-ascii?Q?rMPv47MiRy/FRVZAKAR0/2cdnhiRvkIvuHn4Y9sxmbsO5UNMTC0DhnK+mK4l?=
 =?us-ascii?Q?0M+uMRg+80UjcoVThY6Brzg6cE6tA7m7WgrEgIgSJaZWdL8qXD6FNUu7bflD?=
 =?us-ascii?Q?jA4DcPYVQHU1aYnaalBW+gUc9k1GAaTqPI1x4SjWCpQHFVjPXudRZn6PMzC8?=
 =?us-ascii?Q?IJNIAV4dzRek7/0gGmgtwjpV4sZrezZNLb9szOWtoaqiMIRhQF017qsd7eo0?=
 =?us-ascii?Q?dfZhnPrJ6jY9Wmm7vKukMGL18P8EJiRaLeS+B5yM0top1CzKZPphC/NgfdGM?=
 =?us-ascii?Q?+iF0O6pMDGdfHPf+Ljoabr0BnQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7DE2D59C604185469F68BE6EE2523BEC@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fdf6894-e121-4f63-c829-08d9e0b7d08c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2022 10:37:13.1535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB7190
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


