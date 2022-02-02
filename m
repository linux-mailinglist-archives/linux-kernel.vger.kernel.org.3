Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5004A6C16
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 08:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiBBHI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 02:08:29 -0500
Received: from mail-bmxind01olkn2087.outbound.protection.outlook.com ([40.92.103.87]:17574
        "EHLO IND01-BMX-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229462AbiBBHI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 02:08:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TjJQHtk/ExTU7n7HtXlAVbk93Y/b8WCPj126BPn2CkAOqrGxGipbrZIK8NyNIMHFo+o8tJ6hmWVfYp/Usygl7Wfnk1rRIedXC5NrKxvnJ4WROhyfO5E/r1F0TUCIXEMo0Np3ImscuCPtFDxuKoqXifhb1Ln8RDLX3Mt5OgRMaN3erIgOIuEcyVK0YZOPmhLXtB9aXVzOVpU1JmDmdB1unVaaRsyl8QNFAq31G+yg7d6YRNh7mEQQJtd0x+QQ7HR0drnNPOfA/e0Y3MxUIRkklJnDBo0rB1kCvHiuh6TCCjI/i9jWOe7TA2odB9yfhWNml6T3E5k1V7mGHX2LlCBdBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIV9ax1TDVo7LWawhjtJ4prLDmVk9D9F5rS00qmDKkw=;
 b=ZT2D2jZV8CnU6pf4K19waRVvW5M243owWDhHa493TF2BbjmUXcxxHUrh8REnYnSmR3Y2ehz/eY4NxTs7wT2Ca9Tv17m2IRbfMbNRdnZWkgcZPCsy0/F8PEUF9dWU729hxCOfcLOxlo71eIWsXqaTCJm0yWIM4EnmxLkFSyUp2hrvrMMyOF5KSw1HXCQvg+fwfa2iU9agN9uAJNRqh1t8ol/TnvwNThSiYcg7BDanpontqvgQyQjbE6Vp62yr/3uvTRvA2lL1TsU+Pi192i6JHm7OvaPwrVxYzaPPINGfODQQjpdvSpq/UmfyOYwVJorcz/NgUv9pmuUR0eBMxOOqUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIV9ax1TDVo7LWawhjtJ4prLDmVk9D9F5rS00qmDKkw=;
 b=uAu506BAtxTMHHorSl2xT7VZdSkqR2pnJZQxTSMndv4TA6/Y6MS0dFnKAyzYcAJBY51DNTNHXiLuIf4p+RB6WfFnsqCSPC1yi5ijHP2P6ZnGxD6ljZmJGS5CtnrCVStHmUIiNsqan1GynTS7yWn1WwC64FgxZt1xHT8Y7/k3bWx8vlzqmO5VivsOYzu3Ekq/QAQz6NhRFrVqtSdQQ4thY6B+OBoyg2yBD47KlGYJj+EVlKRmZ842hf7xFRAOCKqtwyU5I3h123KUu5+PFrFZgyQ3SsvUFDjpDdp6XJYekbLPwlbeb/ifsEKmZvQb2aYbuBBqdfrqw3j+SEI+ynD2jg==
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13)
 by BM1PR01MB4930.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b01:9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 2 Feb
 2022 07:08:21 +0000
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d19b:7cd1:3760:b055]) by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d19b:7cd1:3760:b055%9]) with mapi id 15.20.4951.012; Wed, 2 Feb 2022
 07:08:21 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     "mchehab@kernel.org" <mchehab@kernel.org>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "hverkuil@xs4all.nl" <hverkuil@xs4all.nl>,
        "sergey.senozhatsky@gmail.com" <sergey.senozhatsky@gmail.com>,
        "ribalda@chromium.org" <ribalda@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        Orlando Chamberlain <redecorating@protonmail.com>,
        "paul@mrarm.io" <paul@mrarm.io>, Aun-Ali Zaidi <admin@kodeit.net>
Subject: Re: [PATCH RESEND] media: uvcvideo: Add support for Apple T2-attached
 FaceTime HD Camera
Thread-Topic: [PATCH RESEND] media: uvcvideo: Add support for Apple
 T2-attached FaceTime HD Camera
Thread-Index: AQHYEqCuFa0IUQWRI0uS4fqZrMlb86x/2XiAgAAImYA=
Date:   Wed, 2 Feb 2022 07:08:21 +0000
Message-ID: <951C1FB9-9709-4CB3-8DD7-703900FE56FD@live.com>
References: <527C2E71-12E2-45D1-9B50-5A413B6920A1@live.com>
 <Yfomr83ol/1iGRSv@pendragon.ideasonboard.com>
In-Reply-To: <Yfomr83ol/1iGRSv@pendragon.ideasonboard.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [Bf6bj0dXtjju2tegpFmO8XX8AGLgdNFDlXVNYWnKMYYDy+gojh2zigLCsq4Kg7fe]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 63d921da-168a-4e21-9cc1-08d9e61acc1b
x-ms-traffictypediagnostic: BM1PR01MB4930:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sZaceBkVBjbdug41+t0EIHMPrIZN/fM5YQBkylvUz1fjsRpj4njm6KbfUj2jSGypuUQyzmEE7AAdW98lxvbMLk0M/i3hFhr3QV+b5b5G/aD9jcbYSnBQRgDz6PLuDTMKfHBIcoghUdGOYVcJ9zmeBag4URC7UP7fg/s1cM5nw0hQDiTYkPWaCMIkz7xVxCoEVlC48jYja7MUZ6tCAt0F5nP4HAinWjKbhX9KXwaHsxr8zRFWpJ1SpLpGiE7e83SEAMugMb6Z7BjG8+5Q9ZCKaJ8vPz6uvlshyHenQqs7AyoGHLOOanJtBkeY0CK029DEotad29Dino7nUfOwDcgYui7t5zKE30Z3UcbcRW2EH8qyPGzzFagiM9Lqb2kFU3auK5wTuiFM3NfI9tqLTxrytjnocBdHY29i+wXFAtRrRBXz2M5HL3WeNysqPaAs4WLqvx4HX5Oi3XT2uHUmSq3L1J/VX40Grzhfa/kP8a058dE7eoc+zDb2cBoZKNm8qUseuYYnmKsDPt7nDXjK0s7syhN7utBkBCbL/v8T/GqEpDekxbg+ZIzQSP7Tjq2GjZ5sOiXrAarQeFt4e6GMFWWNQg==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Pmqu9D8mBqov/7oF84k0R3V3iIwtxt/bMV6F9kYXZ69rf7iBDtBNzLBEANf0?=
 =?us-ascii?Q?ipeJ2JBr/mH9OOfTPski3u/GEk4LGADbUVB9AaYD+DUuBG109S1VUwF3roiC?=
 =?us-ascii?Q?yGvRFgNNDvet3LiBBJl88ALxePm1xKGNkLFvMJegphdD1yLTV9db1GDYEnoA?=
 =?us-ascii?Q?r1puLRcpY47bwdg4b6qmC555igJsjXqKGQ6eSc8XMFZbnB8TtWcldzzd4YXB?=
 =?us-ascii?Q?R8/beH46icCgjdWq+lWfbpP7FC56AoHWDfcdJxyO6S75It+xPl4ycFQdweEZ?=
 =?us-ascii?Q?ED17k1nlHkPSgaQOqxaiGbSq1LUr9FFGDAhPcv7jw/4T6xSfD5c8+6rCg0gI?=
 =?us-ascii?Q?31UATeySRC8zCj8HicWGrVhJ7I+swX629POfEWo5IsU8uNYAEI1VNqkTwX1R?=
 =?us-ascii?Q?M0yEUN6doQ4mNM7tDDr3o0MGD0Yj8MXOoCITEnRjNl35QJeSshf+hdIeBJQY?=
 =?us-ascii?Q?j6Nz36/1qQgZeTEf68h0w0o9zqHIJasc/trsvARBomFcPaTqSPSw2iZBUQDI?=
 =?us-ascii?Q?lzqvu3lF07IP7rLTwMX1OVTstwXht8zDPygwTMTuXeoTeW6SAUaDpzxUT65s?=
 =?us-ascii?Q?aBIJlfZuGxSvjza41dykhMmSWx4ATsk5R2SpjxCJY9biTaEeiAkdOtS7nxNC?=
 =?us-ascii?Q?8EUoGVgRKEek59Cpn4bcJLr+uBa/oRLLKYdiPKBVyB2X6U8cR3HhNNqGUD+q?=
 =?us-ascii?Q?hyxhirS8q68+3zC4UR/uhltFd1GxbMHJ7GnONbBsLn53TRJ0OEUuI+nhJe3o?=
 =?us-ascii?Q?bypITRUW1WdDk6VhuHVZV++QMWFWUdwvArWwqEYjBW97W8qCPtOx4uU//b1D?=
 =?us-ascii?Q?ghpzWjhut0fdqKgunWKUhGwEcP1Zo+LQJqHUd+5Z5/a/dV6z3qcXOXTQTDwc?=
 =?us-ascii?Q?PgXtUtCJxG6p39w4byYaguFDBGDJ50WvpVL974gNOgQOdIY6P7ezGwImOZ7j?=
 =?us-ascii?Q?/tFX9pk+N7DdbgmAZ/qms8qTBUlcjZETl5iJxtMrtIHiRnrDVpAkSADfGwmB?=
 =?us-ascii?Q?HhF+98MrmKj+ZTq4kJqoYp5XzA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2959B2FAD2E9FB4A9AA0A3B226F46F4A@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 63d921da-168a-4e21-9cc1-08d9e61acc1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 07:08:21.6909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BM1PR01MB4930
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent

> On 02-Feb-2022, at 12:07 PM, Laurent Pinchart <laurent.pinchart@ideasonbo=
ard.com> wrote:
>=20
> Hi Aditya,
>=20
> Thank you for the patch, and sorry for the late reply.
>=20
> On Wed, Jan 26, 2022 at 10:37:13AM +0000, Aditya Garg wrote:
>> From: Paul Pawlowski <paul@mrarm.io>
>>=20
>> Adds the requisite device id to support detection of the Apple FaceTime
>> HD webcam exposed over the T2 BCE VHCI interface.
>>=20
>> Tested-by: Aun-Ali Zaidi <admin@kodeit.net>
>> Signed-off-by: Paul Pawlowski <paul@mrarm.io>
>> Signed-off-by: Aun-Ali Zaidi <admin@kodeit.net>
>> Signed-off-by: Aditya Garg <gargaditya08@live.com>
>> ---
>> drivers/media/usb/uvc/uvc_driver.c | 9 +++++++++
>> 1 file changed, 9 insertions(+)
>>=20
>> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/=
uvc_driver.c
>> index 7c007426e..88dc9e7aa 100644
>> --- a/drivers/media/usb/uvc/uvc_driver.c
>> +++ b/drivers/media/usb/uvc/uvc_driver.c
>> @@ -2848,6 +2848,15 @@ static const struct usb_device_id uvc_ids[] =3D {
>> 	  .bInterfaceProtocol	=3D 0,
>> 	  .driver_info		=3D UVC_INFO_QUIRK(UVC_QUIRK_PROBE_MINMAX
>> 					| UVC_QUIRK_BUILTIN_ISIGHT) },
>> +	/* Apple FaceTime HD Camera (Built-In) */
>> +	{ .match_flags		=3D USB_DEVICE_ID_MATCH_DEVICE
>> +				| USB_DEVICE_ID_MATCH_INT_INFO,
>> +	  .idVendor		=3D 0x05ac,
>> +	  .idProduct		=3D 0x8514,
>> +	  .bInterfaceClass	=3D USB_CLASS_VIDEO,
>> +	  .bInterfaceSubClass	=3D 1,
>> +	  .bInterfaceProtocol	=3D 0,
>> +	  .driver_info		=3D (kernel_ulong_t)&uvc_quirk_probe_def },
>=20
> Have you tested that the device doesn't work without this quirk ?
uvcvideo 1-2:1.1: Failed to query (129) UVC probe control : -110 (exp. 48).
uvcvideo 1-2:1.1: Failed to initialize the device (-5).

These errors are encountered without this patch
>=20
>> 	/* Apple Built-In iSight via iBridge */
>> 	{ .match_flags		=3D USB_DEVICE_ID_MATCH_DEVICE
>> 				| USB_DEVICE_ID_MATCH_INT_INFO,
>=20
> --=20
> Regards,
>=20
> Laurent Pinchart

