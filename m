Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E6B4A8415
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 13:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350628AbiBCMvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 07:51:43 -0500
Received: from mail-bmxind01olkn2079.outbound.protection.outlook.com ([40.92.103.79]:21991
        "EHLO IND01-BMX-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236476AbiBCMvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 07:51:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vry+epXwNNoo2Wj2IgAEFvfV4y4x5uFwXFZV6HlD1ZHLQkHfcJworPW/q+LkyAaiCoRLdEF9ZGCqZOZkiV+f2Wd3D9DkBCUQ+JMVtQV9kp5NEF6J0gf2bSXVE6au/WbNXl3+HEPzyhErzG7q2eCzyPnC/8vFTd/qHgNEh77q1oyv53YkwspIhKXzQ08D55mM2IfddKlk87mvQ5o0Yy56AMG1u3ZyD3ul2a22gWzOoIk4OJEG1/gcwUbJQx3NV7dhTUD9Io50Z5MgNEBxsdiYMSjZlq2GlQ55yoyXjbhKwwZqr6JjGbEWBy7AibxXcNCp08ZkYenFoThFxqM6i6W96w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2dDJY1lWb+HEpYx2uCJQBMLczC82KiSsXWV81lWEQo=;
 b=AgdoIwLrguiZqQSXdBNVkNTmi82/tW1qufAl82MdvygmLTWqq1mOJrKS14JawOvkqqFk96WuPC3wUzNLaxEcPSQETU35hMCiVbhsRTWfST2E2qYiIU2frwVfHHGMuyH+3eYS3u+Cc22WsZZLy411PFZf/XOxMBdTtLauRWvWLgcXAdfL9awp48c4JX2T2RJynkSIoboOToWXgbazr8GhwKZsDiXUHmp/jLnQtaSb0X/YpELtS7VGCQC8Y3ahli9tEcR2b83+6GhmoSm5fyjueeS0QSbb1G4AwNZ0Q/jGm1lWSkivrPr5JQOBZgwXvfrA0WemTcxuC1hcsOEpG+1QWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2dDJY1lWb+HEpYx2uCJQBMLczC82KiSsXWV81lWEQo=;
 b=D8MXrGPSv4JNR6LzSM+khqevmSUCaCRaT1NoU2mNB13BWUyc8u8oy1+m9F+1zlimSgQ69mfMG/6x2OCtz1O6nH+MVb2Xkvj6iyFNxS4TCGkuFn9s0yJt/a/DL7X8+KNHlBpfGWXZp4Vgp/qgitV2y18gHDQRtiYXfs5jHIrF1tNeTdU8x0osVN9rZhQTzO9bK0oR0B/Vunydw97clDkog8g4him2siSkhNpWFEu/5uaYZonqtdNtc9s7lWWMXhFJCR/BrxCt3p9Xts+ABuvXJfgEQKaurEefXD6kU3Qt1iF395mza8QB/LZb+lZNJLf5kNsBi82fjSkd1InQGnTpeQ==
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13)
 by MAZPR01MB7588.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:3f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 12:51:36 +0000
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d19b:7cd1:3760:b055]) by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d19b:7cd1:3760:b055%9]) with mapi id 15.20.4951.012; Thu, 3 Feb 2022
 12:51:36 +0000
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
Thread-Index: AQHYEqCuFa0IUQWRI0uS4fqZrMlb86x/2XiAgAAImYCAARp3AIAA18IA
Date:   Thu, 3 Feb 2022 12:51:36 +0000
Message-ID: <7A80783B-E8EE-4CEF-A09C-AE71C3072A7C@live.com>
References: <527C2E71-12E2-45D1-9B50-5A413B6920A1@live.com>
 <Yfomr83ol/1iGRSv@pendragon.ideasonboard.com>
 <951C1FB9-9709-4CB3-8DD7-703900FE56FD@live.com>
 <Yfsa2JUiEf74gBbQ@pendragon.ideasonboard.com>
In-Reply-To: <Yfsa2JUiEf74gBbQ@pendragon.ideasonboard.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [n2Gw1r8zHB8on1WaD7rKJxnVL9i5eWACTPfAiSqi8vYaPM3NSyv87EHI5MInBdF7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c20ca552-6b76-4128-1a3e-08d9e713e9df
x-ms-traffictypediagnostic: MAZPR01MB7588:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pU4JtwoVKIYtAy4GQWRmOKU3CtXXakdtY7fIDxQSpY7Soc5XblYuQLqvm+dVtGT5Txy11/2iTKQlhyYrJf5fUv+u/+yIXShK49j6vqg9Tdd94rcx3ZJ0H1FsPF9/J9vnYWtJHo+qywx+J/LuvGJ9bz5q1CGFHDN5/D9MDj46TDxGiQ9/KkMbxg7L1ieHjita6vXg+FQeTrrEGG/Su+qtG1YHixMVOn0rlOQd4O5Kws68AUtc5H2H4Kyha/P6ooHpnRAOPiFD/Pl/tLTXSa+kbO8dXceh58LmRKOUb3fniZOpHEYuj2czEHQLNZaXAhfs+rCanbNPZK2pOmYCANU7lkgzVsJI/fZm9CtWfGclL/uHJEUtYpePB6jxEirysxRlZFjKD9kNek4+VYHaU3pBg7XRANUmW1dtOJrjKoWxU/ao3IJsmh8+wRnGZzJlX4gFVt9DG4+VoFSIRyPC5o6Gzx0LOoY06HgVxGy1k/TDWOFtqsk8goYSnSjVVBaeOi0tAUkTIlJH+++1FnDcSykM+bbHwrk0GQXDlE8k3if2GcfvAsdf3hVCF0equPUWdDn2q1DHWf3sg26w7gjE+fiVoA==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?T32f9UY5X+wLGepncaf8PpHSVKPnZC5B1fyJrJz1xGUfjcd+3OjTY4SL+a81?=
 =?us-ascii?Q?HXLI1CPIDVg8yU6HahdSgB2GSDDADI2UVx3+xXSO9kmadlFztnDGYJdveaX3?=
 =?us-ascii?Q?zD0JruMF8xGoT3u6iVwzR+B8t9TP6M009BgF6IZkzptqPH9zUEKEz+uyY8A6?=
 =?us-ascii?Q?oCUTdNMb0E26oRBzM9Zfz2OBjp4sc2aSDm/wAim6CZtv8AvYYIDxqgG2KMNK?=
 =?us-ascii?Q?4UIpSUnXPVnzFizvEnGBVRKxYzbv+1/Bzef30Lx5uo84IDep2EsM7Vhdepjk?=
 =?us-ascii?Q?408cgdNZ021m3dESzdEgSau2k4odu96/y3CWua0JiWoroMoMdHx1nfSQkEij?=
 =?us-ascii?Q?qESy0nG2in1efWbntjcW62pMx+gtQmJF2BJT6roYFrfnrwocPrehc1KW+Ivx?=
 =?us-ascii?Q?yqjKL50q8Dd/P3MVWBBwrXsv7K9tdypEwcLNRBK+xcBO04bgpBRZDu5Me0yt?=
 =?us-ascii?Q?AI6bDoTwwiLoBYxKN/JtpHzZgH8N/UUlElwumThIgGGSazETxbGtxVG0NiuL?=
 =?us-ascii?Q?8Bev3Q44uaQb/UbBPIiOIf/No+B8OWL7L+EOkZ9UDgMPi1+4D1JM/lCFaYTI?=
 =?us-ascii?Q?/KVLGpyzlTeBetl370pzizBaBMVw/SdnfpTvhhf4VM2ftr6J9tPivBsw5Y5h?=
 =?us-ascii?Q?cMBDl5QvxeMtwmfJb2jybCnLd3FX1b2mhuXh99cEA17B/y4pdLf63Q/9VElY?=
 =?us-ascii?Q?sEmjXhDO/RZZnk5tZbnRJq13t2uiv+3exozWZ2wYyQpPFV5QtgnKZR59dHgN?=
 =?us-ascii?Q?Wc74bD/fPwAo46ypsqQD/Q1n9aVTMNCzg/xvN9qFi3UwkEA0Kxmj7AMIgWVS?=
 =?us-ascii?Q?eJoZVHOPjxPmHtuGp46tpdRAIUd0nXmXBGV+mFnKsRmYtMt+UMUHxuC42IX+?=
 =?us-ascii?Q?yYzfp2liWzpOJSg2HPhif/WdPd/0gaKcfI/XiP49ieUsdlhwqWKeWElSKytz?=
 =?us-ascii?Q?X6HqZJPqBzlnwipYFaXMCSpqIc13NuAUyXPlrIkGYa8bilWlffoDKX5kF9/s?=
 =?us-ascii?Q?XDvK55nY21XNITNGD2sZXErTuA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3562BDBD27BD324993598164F2988009@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c20ca552-6b76-4128-1a3e-08d9e713e9df
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2022 12:51:36.3118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB7588
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 03-Feb-2022, at 5:29 AM, Laurent Pinchart <laurent.pinchart@ideasonboa=
rd.com> wrote:
>=20
> Hi Aditya,
>=20
> On Wed, Feb 02, 2022 at 07:08:21AM +0000, Aditya Garg wrote:
>>> On 02-Feb-2022, at 12:07 PM, Laurent Pinchart wrote:
>>> On Wed, Jan 26, 2022 at 10:37:13AM +0000, Aditya Garg wrote:
>>>> From: Paul Pawlowski <paul@mrarm.io>
>>>>=20
>>>> Adds the requisite device id to support detection of the Apple FaceTim=
e
>>>> HD webcam exposed over the T2 BCE VHCI interface.
>>>>=20
>>>> Tested-by: Aun-Ali Zaidi <admin@kodeit.net>
>>>> Signed-off-by: Paul Pawlowski <paul@mrarm.io>
>>>> Signed-off-by: Aun-Ali Zaidi <admin@kodeit.net>
>>>> Signed-off-by: Aditya Garg <gargaditya08@live.com>
>>>> ---
>>>> drivers/media/usb/uvc/uvc_driver.c | 9 +++++++++
>>>> 1 file changed, 9 insertions(+)
>>>>=20
>>>> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uv=
c/uvc_driver.c
>>>> index 7c007426e..88dc9e7aa 100644
>>>> --- a/drivers/media/usb/uvc/uvc_driver.c
>>>> +++ b/drivers/media/usb/uvc/uvc_driver.c
>>>> @@ -2848,6 +2848,15 @@ static const struct usb_device_id uvc_ids[] =3D=
 {
>>>> 	  .bInterfaceProtocol	=3D 0,
>>>> 	  .driver_info		=3D UVC_INFO_QUIRK(UVC_QUIRK_PROBE_MINMAX
>>>> 					| UVC_QUIRK_BUILTIN_ISIGHT) },
>>>> +	/* Apple FaceTime HD Camera (Built-In) */
>>>> +	{ .match_flags		=3D USB_DEVICE_ID_MATCH_DEVICE
>>>> +				| USB_DEVICE_ID_MATCH_INT_INFO,
>>>> +	  .idVendor		=3D 0x05ac,
>>>> +	  .idProduct		=3D 0x8514,
>>>> +	  .bInterfaceClass	=3D USB_CLASS_VIDEO,
>>>> +	  .bInterfaceSubClass	=3D 1,
>>>> +	  .bInterfaceProtocol	=3D 0,
>>>> +	  .driver_info		=3D (kernel_ulong_t)&uvc_quirk_probe_def },
>>>=20
>>> Have you tested that the device doesn't work without this quirk ?
>>=20
>> uvcvideo 1-2:1.1: Failed to query (129) UVC probe control : -110 (exp. 4=
8).
>> uvcvideo 1-2:1.1: Failed to initialize the device (-5).
>>=20
>> These errors are encountered without this patch
>=20
> Thank you for the confirmation.
>=20
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>=20
> and applied to my tree.
Thanks !
>=20
>>>> 	/* Apple Built-In iSight via iBridge */
>>>> 	{ .match_flags		=3D USB_DEVICE_ID_MATCH_DEVICE
>>>> 				| USB_DEVICE_ID_MATCH_INT_INFO,
>=20
> --=20
> Regards,
>=20
> Laurent Pinchart

