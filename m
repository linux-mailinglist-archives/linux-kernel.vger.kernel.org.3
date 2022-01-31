Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 638294A3F13
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 10:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236544AbiAaJM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 04:12:28 -0500
Received: from mail-ma1ind01olkn0166.outbound.protection.outlook.com ([104.47.100.166]:24096
        "EHLO IND01-MA1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234358AbiAaJM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 04:12:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CE+8GdQDF7Kg22UklnWIS61fL8M31NShhiFt6HogqLyaeD0fjF16TMCGFrGvEIu9zwD4hSKfWwuyUj3mOYQRjj6+4lwWJf4aZPzZ6nrWtbOqgFNRwDaUT3x/4M4l9+iaTEHrjwtT/vEjd7g2gfSowZ2+4Vl7ZKBMBGt9HM5qdamG1C7fvj6dZs/OfOu5WZMVuQthaKtMjsg1ycGgGu0vOcrz/T98koQJ5NVuen/0InhgVWgKjX6O4U9UNTymYXyOxrE/buyWwoATq8RpfXs8oPrto0IV+eAqEBbH3wluA7JEizMQxchA+5Tv8p7ZYaKeI2NJPSAOBG2C1NZv4Ku43Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ut/jOtQM5LCb8mFPta98FQAA/quSe1o5jhYRMGHmOkQ=;
 b=Dz1v+MM3FjBj7G4iQLz6kNJviMuxqP2F/RPwS9LCZc/XH2sHQdnhUMBW58Yq5mJfq1ntg+VDOuES5mCP8dEqkhQ2j478aD/Ra2QFBwPcvXufJOY+2jQxPrswj+V24d2/jYYjrs3WQVrcjWk8yxD3HVQWgvA8xndy9FoNLuoNS/ijBWG9+KFbJjW8EnqSyELH4sKgPZU9Z668u8zrkpG/imKZBauxjhvuQEWrJrQZei29CB3CgD3Y3rVIOA4/lNYsx6t3V20/GyHc3wALPJWqbutlS/TDunoXAFMNwpWNCUrV24syHbFxiM+RFSdLR+VCUrhk079ghR9WylY9UhUx6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ut/jOtQM5LCb8mFPta98FQAA/quSe1o5jhYRMGHmOkQ=;
 b=gXXBC8u+DV3JR/ipV7e1fJVlSh6pDhP90bABspiPhAD7jZ9DfJJjIundoHtH2EwnV4RBjkf6/q5xAnQpf+4p+87F8znirM/ygEhv1GRbEVa2XznXelLAXEnKEFS2FapkM+FWM+2Ht7Nt09S7uNFoQbGLnZCGWz15xphLtApM65B73SgmB78T0dbMs1ojRdjbnbaNr2AwkbwpF+RCpzDEiHW0xm7dXByJXxxdi1MCWYq9aGVcJa5C81znHdQkrpOgouxzE1j8G4XXpRfoNpEjmsnln0bLaUgDv6mLVLjXjS0DNTkn1Pm4YgkGsPA7uwM09U3OZRIA1fqJuR6BJw8rlw==
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13)
 by PN0PR01MB7800.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:b0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Mon, 31 Jan
 2022 09:12:20 +0000
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d19b:7cd1:3760:b055]) by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d19b:7cd1:3760:b055%9]) with mapi id 15.20.4930.021; Mon, 31 Jan 2022
 09:12:20 +0000
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
        "paul@mrarm.io" <paul@mrarm.io>, Aun-Ali Zaidi <admin@kodeit.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH RESEND] media: uvcvideo: Add support for Apple T2-attached
 FaceTime HD Camera
Thread-Topic: [PATCH RESEND] media: uvcvideo: Add support for Apple
 T2-attached FaceTime HD Camera
Thread-Index: AQHYEqCuFa0IUQWRI0uS4fqZrMlb86x84AqA
Date:   Mon, 31 Jan 2022 09:12:20 +0000
Message-ID: <9BD1D373-F588-44EE-AFC0-3D691B4134DA@live.com>
References: <527C2E71-12E2-45D1-9B50-5A413B6920A1@live.com>
In-Reply-To: <527C2E71-12E2-45D1-9B50-5A413B6920A1@live.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [LfaQ6fnhm/9MEVCpIA596LzhoRqO/QbO]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8893891f-548d-44a1-78a7-08d9e499c91d
x-ms-traffictypediagnostic: PN0PR01MB7800:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v2EXFYp/1f/wqo1IiqIx1Hf9a665j+Yk8o6zI3Os4jv1tqqiNJFkvuF5BYM80PxLzYnyqC6wUtOYOpNxIQ1ZttmOCbdDFXCWQjwy3Rob4ID4PbRN3xfVyDRqmJhg0KbjcR6SEqduSJnsr7k4QfUbz2Mh6FFUZkOiY4r3ALayeXmsoY1d6CGh4h4sVuvs2+v6wQgys420CjAeFst+9qJMb3qTprr9k9aDrGmGNJcUOG7wZdyBZ1Yw8cdKYQZgpb8K89KX41kzzIz2IqiFfKIrQIPHOQF8ysRxn/2jND43AbWRUYTD4+2ky7wuo05vP0eMqB3LrTcBr/n88ootkcB+Jtyb015cQqks0QRBVJIAQDZ8CHB0uo3jFoa9Ihxbzm5QZvr1d+dnNLFqjePxU4bNBtc4UQn1O7FvwSSUm7RH7Kii5CjPoMhiELJo8qOG4hFpJTpyeQjsBqmcoYuLobZs9UtCYh8RDURIeDg24wox0y/+J1eKTfY1EyRGhGwqIcdOnOZM5se+ZxqQe/sdlCcP6CnIzPhop8+psk48hwcGmRMvhaS58bSAv44emq30aW/HQ3r1oyyz9GkXGenSVb1+aw==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mizWvnyulvGqPH1o5LqRidsX7Y17ngWi5Q/rqZwcOfFyxN5tYGnHkMp+s5uR?=
 =?us-ascii?Q?G3YnN+V2hZBpMDO40qJ2mELzFV87ueMAbL6KE0+gV0xAPZRG+2je1JUmJ0mj?=
 =?us-ascii?Q?CTi5L0TNSW5kFDiCeiURjPaB+lsvQM3vYnFwQG5fNvNcw0qNnTFxdasC/Ddd?=
 =?us-ascii?Q?RCAmI15E9CZ1hkae8f2crJnPODieo9LXZuvZsXIzhg7RV89pjGyA/daYAwW8?=
 =?us-ascii?Q?BIJHtHbf9PPaxKLSPUpVlLyOEuJxVUj/s4SFFsj1ipgL/6jh6Ml1CBwy+YRK?=
 =?us-ascii?Q?QdZ+2eOAmSvEGdgl/vLM9NMYR4pSXbRUmJe+Pi7f54wtAqn8CpEnro/qkPkC?=
 =?us-ascii?Q?4tBfqVipkZFDWprURHzoIMnDQShjqLXhWUpn1vSsM5khdUNfTvQqieq0FOSD?=
 =?us-ascii?Q?g5OiCtz/+kehCmn1BE5MIXi2T53RUVWrZI345XMNduNBuCyyI3UpTD22eT+f?=
 =?us-ascii?Q?GZkrSWfgxAdX8OXvI6r0wOkD0YpK6jPSRwpZ+azawBpJ55R0wGKWeHjrjNUm?=
 =?us-ascii?Q?HRrKqbZBgWpCxOJDD+HZZWr4kPg/tnE72z/vJq7eLvAHzrTerFQU1tu3moxB?=
 =?us-ascii?Q?bmiqE49U4/5Gd5MbNb94WP/kbtbrjs8bVPX6TCpXHS69kpWbw+BAhTKmdoUa?=
 =?us-ascii?Q?GtB01kc1z40SY4i22JSazrJBmSsuk1W8KtPmrnXWv8O3bdM2wfz09WRywtUi?=
 =?us-ascii?Q?K2FsGou+/JAlChBU5FGwqFibyv5kqaDy1H7pmQboxaKdS5q39XikGj7Whs5t?=
 =?us-ascii?Q?ahQNVddYK6ueYTFeBk2HMdjX21akgHp73YxWUTzk1rBpKg8/Z54dXNNQ7JgH?=
 =?us-ascii?Q?/XVZ3kekx6T2p7A3zkN4EQkDTe8A1RdQ37fYuxsNfWvFO/xN850lKd0kZVox?=
 =?us-ascii?Q?CJmTzByBACtJqvgGyQbNEJTS5EVRCnASIwDDr13NQYlTV3ugspINXQXLQ7lX?=
 =?us-ascii?Q?UHDSSqrBzfhmIx6aGzKFPg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C8E79CAD9CAAA94C96A3D626DAD9BE18@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 8893891f-548d-44a1-78a7-08d9e499c91d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2022 09:12:20.1635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB7800
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maintainers

I sent this patch on 12.01.22 and then resent it on 26.01.22. I still haven=
't received a reply yet. Maybe I am not sending the mail to the correct mai=
ntainer? I request someone to reply cause no reply seems to create a confus=
ion.

Linus, I am sending this mail to you too, since you are the ultimate mainta=
iner.

Regards
Aditya
> On 26-Jan-2022, at 4:07 PM, Aditya Garg <gargaditya08@live.com> wrote:
>=20
> From: Paul Pawlowski <paul@mrarm.io>
>=20
> Adds the requisite device id to support detection of the Apple FaceTime
> HD webcam exposed over the T2 BCE VHCI interface.
>=20
> Tested-by: Aun-Ali Zaidi <admin@kodeit.net>
> Signed-off-by: Paul Pawlowski <paul@mrarm.io>
> Signed-off-by: Aun-Ali Zaidi <admin@kodeit.net>
> Signed-off-by: Aditya Garg <gargaditya08@live.com>
> ---
> drivers/media/usb/uvc/uvc_driver.c | 9 +++++++++
> 1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/u=
vc_driver.c
> index 7c007426e..88dc9e7aa 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -2848,6 +2848,15 @@ static const struct usb_device_id uvc_ids[] =3D {
> 	  .bInterfaceProtocol	=3D 0,
> 	  .driver_info		=3D UVC_INFO_QUIRK(UVC_QUIRK_PROBE_MINMAX
> 					| UVC_QUIRK_BUILTIN_ISIGHT) },
> +	/* Apple FaceTime HD Camera (Built-In) */
> +	{ .match_flags		=3D USB_DEVICE_ID_MATCH_DEVICE
> +				| USB_DEVICE_ID_MATCH_INT_INFO,
> +	  .idVendor		=3D 0x05ac,
> +	  .idProduct		=3D 0x8514,
> +	  .bInterfaceClass	=3D USB_CLASS_VIDEO,
> +	  .bInterfaceSubClass	=3D 1,
> +	  .bInterfaceProtocol	=3D 0,
> +	  .driver_info		=3D (kernel_ulong_t)&uvc_quirk_probe_def },
> 	/* Apple Built-In iSight via iBridge */
> 	{ .match_flags		=3D USB_DEVICE_ID_MATCH_DEVICE
> 				| USB_DEVICE_ID_MATCH_INT_INFO,
> --=20
> 2.25.1
>=20
>=20

