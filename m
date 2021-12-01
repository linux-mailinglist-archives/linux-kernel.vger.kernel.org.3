Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB0F24646CB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 06:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346797AbhLAFqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 00:46:52 -0500
Received: from mail-psaapc01on2101.outbound.protection.outlook.com ([40.107.255.101]:32780
        "EHLO APC01-PSA-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346789AbhLAFqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 00:46:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBVIyOomhneBkcpEKv1wPXC8A5c6AewE3oorr9DBgW5dCxku6QnBgTuhlDLoSDbgURZOBnqCwYx56mcNBMSOrgJRBEVeEuEXjE/k6/9lcybRRVGj2z9ffbZlPz2hM4dy5aH/f5xM1VTA03YK3kkVJ5RVDR6skmlOq8451v5q86LPskgd7FiJW40pnYq5HDuUGJeBieVDgLVonS2s0ApxhhwpxCzrwrrifz6GyozaMSA2bilXcWBqQhQylF/sh3J3LwB1LVIqm21BdQtn6ZVJRHNtf3LhSj1NV7v4Zpo3vs6YYKliziIKKtCEHmyaTmMaBvekJbjfeVlerc7ElUfs3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lzh0MbsURqzy+K6nxZHrUAzXE8yYoezoVd/SBy4XSuk=;
 b=PWpStbC7lytXErYRkUaU8Ek45Hgf4wjyUtR0ALp3vskXDnGN8NQH2wZICK+M4RB9ycNj2Y37Er2spqa1yAEtzbG9ZngnIkET3yFBLNaj6YxDBC4z56EqS5hQeQAcI/FLUt0lKW3Y3b6QpeJ6xjoejkzMgq5BW7Fgzt09QU49tu/AIp/CZfIdJS8ZRRvl/aQDQqSQeUKBSUGEu1tnM3ENbLUJFiMs4RdXaMVJwZ+oYw+d5NzksI8NvDlOcmaAFTZaIJcQVXlEwiNk3Rh4s1coyMRtfW2dZ46J9hC+dVoM3aP3M1LFydA62n/PycyHr2cBSwr7EcYU8V0aUPBVrIvwlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzh0MbsURqzy+K6nxZHrUAzXE8yYoezoVd/SBy4XSuk=;
 b=N++mnA/K0rGcU8yZCE/K2gY2mlZ9vnjnyOgBbmJw4I3KD1xz3D3A85x4eCaM7Ao6pVebNVVZLugAvdBzQ7kwN/H27AlhACY7JS7IcEbhypcxBLF6h814hFrzqrVOjOzz8yOYbaEaT4a9y8YwOVzwszxgNX59RxCIrAl8AHekmLAJ6qoMQH6SQQWrl9Qb0upBUp0oRYSY5fvLSozWzRcb8jIl5SGXlkIVTb8wuEbPxaCXcAL7E7XIQ4B1vpFAvxCtKF99jtQ70vRROXHm1p3KviVGHH7Q2wt9C5MUyMyE4u0EikmTlx6OJ+T6cWjCWPey4LLdosEUxbfIXx496pRKXg==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by HK0PR06MB3377.apcprd06.prod.outlook.com (2603:1096:203:8b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 05:43:16 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::70c4:b471:2d05:1209]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::70c4:b471:2d05:1209%6]) with mapi id 15.20.4734.024; Wed, 1 Dec 2021
 05:43:16 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <balbi@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Tao Ren <rentao.bupt@gmail.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        kernel test robot <lkp@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Subject: RE: [PATCH v2 1/4] usb: aspeed-vhub: add qualifier descriptor
Thread-Topic: [PATCH v2 1/4] usb: aspeed-vhub: add qualifier descriptor
Thread-Index: AQHX5dcPGG2zpqcQlU+Dys+5o778UKwb870AgAEqPKA=
Date:   Wed, 1 Dec 2021 05:43:16 +0000
Message-ID: <HK0PR06MB3202436CA49363FD3F60212380689@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20211130104256.3106797-1-neal_liu@aspeedtech.com>
 <20211130104256.3106797-2-neal_liu@aspeedtech.com>
 <YaYOvgCaO4FJ8r+z@kroah.com>
In-Reply-To: <YaYOvgCaO4FJ8r+z@kroah.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d61017c3-31c6-477a-7754-08d9b48d792e
x-ms-traffictypediagnostic: HK0PR06MB3377:
x-microsoft-antispam-prvs: <HK0PR06MB337769900EB6505FCAE9E99580689@HK0PR06MB3377.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /As1dgMC2MCj0Ma2pWLnYNPYWLCdcOiutY14aMpvwO03wlRjiCqzFeaQ7+QLQRzVY/KEXGz8wNzwa76MI6Mbh4/jFLGqFTzzws8hUsK69HPNdyHV7i+FriNTMlwAKdFgp+K0LDyASlLXLGMuNsadilV4qzOcxXWs+okkT/vX/lEOZNulDCukraOQ2Ft9g2LhBEemYqluB4yfvkCeV4iZH6RY/39KhOhZxOLKrDbYxO+UiVkhWLVmV2I+nJ7c/736wZonmsR8AOBmqLPBVOFHoubuV6P5NljrVhLoDslLzulOCqtU4e7jaeTKcX5V6nHmdtiK6x73wzUCOltnpokgW6kk2b/jKGE7T3Nif129He/G/sIJ9/w7qZIg0//n/7Q6YgHjG3SHD2rtC0K51whu6HTEwaUne6IgyK+idTZGqKa9tbM3fSmUdR+Z51ZSMgLUWCm3kqqkTDlF+4mSZ9B8ytMtg4A6m64H5K7743ti84a9ExlbBXiIfbnE1GLKXWZ5PdQT5Jtgfw6Bzyp+WhugOgFygmPxgBDWRHJszQkrlOfFLn4g3hvgWB69K36DfeHwKQVd2X7inpkc24ov8Wy4XlVgFcU/Muy18k+M+6+nqpV75FQRVuBlYS3XTJMEN7zvIO9KdRUg7FliANkWoMdDMIB9LZzXY3gn316YDafTQ6iV6u4bCTXGVLXRGnc2A5d94WwwI8GPKEgA2idHT0ijuw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(346002)(136003)(39840400004)(396003)(508600001)(8936002)(54906003)(64756008)(6916009)(316002)(71200400001)(122000001)(76116006)(38100700002)(53546011)(186003)(38070700005)(86362001)(52536014)(2906002)(26005)(5660300002)(83380400001)(66556008)(66946007)(66476007)(55016003)(6506007)(66446008)(33656002)(4326008)(7416002)(8676002)(7696005)(9686003)(107886003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?I87LySCuvXwFkQhREjwsNxoVKvVIkGxqMKZfbi5VtNbONzhhoiY5DcV/wjSL?=
 =?us-ascii?Q?nWV9BTWyhUFJVAlzU5Xjl2cM3UZ24qw7RKQt5qr0TePcEuC4dtRLVM5YI/WX?=
 =?us-ascii?Q?lCezVXTve6Pj+BQV9vW7rLAXqjGgv0VtoUQLtJWe0/uFmIxwaGXTOANWBXbk?=
 =?us-ascii?Q?Zc3eWMe6IhEGgSitt/iTe3P01GLW8NJefQIvGgZ32dTjtphAuPNF0p3Goez/?=
 =?us-ascii?Q?SgIxXgjWwSXf73Ic/X/mAc1Rpt6w62wVow+bi20pveXdr2tB3Tp858RFhijv?=
 =?us-ascii?Q?rykE7qIuj/lfGa/y5UZhQtDoagrW+C1Y6I3F90Z5sbgtePgWPb4chs4t7n3N?=
 =?us-ascii?Q?0pPravMScCjPz+npnKJW4ZdTZsCQR6q0umJ63s/uoqYHsfvW6aYVs+dznS2n?=
 =?us-ascii?Q?Mi88kS8ktQNV8hgsHFbORXbPRsAc1ozWdBi7Yge0nJBbQBPYoYV52pC+tSuJ?=
 =?us-ascii?Q?9pNSiLJbR5bLH/zsxmsXrvfJt3Kz1SK6+EsIgQwZ2q2m3c3GpzMRkuAvtEWJ?=
 =?us-ascii?Q?wzp0A46E0hj8jL4tRyXkiH9dWt4DSbjKOWgr6AiyDoDv5RORem4oGTW4T56Y?=
 =?us-ascii?Q?alZxYO3eR9DIm6Hwk9h1UiO9uEn34uQWPQmtQRZP1FKSCsA9uOiUprkKhKTb?=
 =?us-ascii?Q?AKzc/kQgC16QRDYqLojTl2tZft9ASNjYc3zBOyz879x7Dkr+UPh/srKtBkDD?=
 =?us-ascii?Q?T0bIQxCECjV3+ATOsl0c7ySumvMQ0aEiakM0GDXUiAWLVK7NWfTGBO9vGtRc?=
 =?us-ascii?Q?s+zRarqtuBMqedbLGDarfkgjXDFC/QrvaOP/BEb1on+ozejguYERmtBOPYJQ?=
 =?us-ascii?Q?zyVcS5jxqjZjTUJjowL74wzWCq2krf9KgF20DIVXuGHhzJzDD4fNxYerVMiH?=
 =?us-ascii?Q?6tVnq+1f728xrCuYyVzbhNjqdv8C+EkVWbyMjwwoHThP+8hVaCAOVayd2b3v?=
 =?us-ascii?Q?huIKsdaNi9EiElnkRYcTYPovG6sBdV7sKIbeQh57FxS0KnQyVDQgBGi2tv1B?=
 =?us-ascii?Q?0kby3rdtpnQ/r3pgmABhytEvoumToKyPJ+doxZNyHldB/42FHkwCUTn4yxoL?=
 =?us-ascii?Q?rL7bcmv8v/nt4292YwO9jNRNFipByjkQs/moVLPSkJbd3MD+QrVajj07Xedy?=
 =?us-ascii?Q?fb0nHrASlg5tRNDJGR8/dZz+NY+w++Tuq31GBnSxRMgcs7Wupn5s3xQvh5fV?=
 =?us-ascii?Q?dnXkq8ZH68tnFN6WLwdJkMtYAuk4tY8VL6GWDA595j3oTMCuWhYWZ6swt72E?=
 =?us-ascii?Q?zVjqeuw4gu4gFDRRK6RO3ICY8PFdoaUVUVCPFnhkkuhMCPrUqFnQEtLE0eQZ?=
 =?us-ascii?Q?UUMC9QUzNZ1jK6t39pyMw08B429wAVpxCcpSYKc5YYOuLcRnsOg6b3opU2fw?=
 =?us-ascii?Q?hkdF0urtZG6YojJNZzqdIF7P5/ERER8Sc/JPDD8wVo2QtUQL7N/btaFLBYbr?=
 =?us-ascii?Q?QeGL3DZtKD65RQ0sEHhpG7YHaP8Sbh4pPvqQFBZVoi55wbRw9wL+HYN2dK6L?=
 =?us-ascii?Q?P30Y0S33wfzcgqjMfugsoYkIxYDBdvBKXMVpq+GAE3AxlRzaF5SqycfD4V5V?=
 =?us-ascii?Q?VmC/xEkycEF2takDiC2o5aPFbnOVsqcx/gpX+jttzKNQKFRDE3GbfNHvStnW?=
 =?us-ascii?Q?5FPKG5W4f0j3OW4OCF5eJxs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d61017c3-31c6-477a-7754-08d9b48d792e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 05:43:16.4983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KRK6AaQXNdiO1D4YgDN8oi53p9vYZKQgzMcm8Js4AookgRLgPK6oK3W6fvum5POLf5lOLhPHunsKs1fTnkMbrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB3377
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Tuesday, November 30, 2021 7:45 PM
> To: Neal Liu <neal_liu@aspeedtech.com>
> Cc: Felipe Balbi <balbi@kernel.org>; Joel Stanley <joel@jms.id.au>; Andre=
w
> Jeffery <andrew@aj.id.au>; Cai Huoqing <caihuoqing@baidu.com>; Tao Ren
> <rentao.bupt@gmail.com>; Julia Lawall <julia.lawall@inria.fr>; kernel tes=
t
> robot <lkp@intel.com>; Sasha Levin <sashal@kernel.org>;
> linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-aspeed@lists.ozlabs.org; BMC-=
SW
> <BMC-SW@aspeedtech.com>
> Subject: Re: [PATCH v2 1/4] usb: aspeed-vhub: add qualifier descriptor
>=20
> On Tue, Nov 30, 2021 at 06:42:53PM +0800, Neal Liu wrote:
> > Support qualifier descriptor to pass USB30CV compliance test.
>=20
> Please provide more information here in this description.  This does not
> explain what is happening here very well.
>=20
> Also, what is "USB30CV"?
>=20

USB 3 Command Verifier (USB3CV) is the official tool for USB 3 Hub and Devi=
ce Framework testing.
The USB3CV tool includes the xHCI Compliance Drivers for use with the USB3C=
V.

We would like to pass USB3CV - Chapter 9 Test [USB 2 devices] - Device Qual=
ifier Tests.
A high-speed capable device that has different device information for full-=
speed and high-speed
must have a Device Qualifier Descriptor.
This patch is to support device qualifier, and the host will retrieve it th=
rough Get Descriptor request.

> >
> > Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> > ---
> >  drivers/usb/gadget/udc/aspeed-vhub/hub.c  | 24
> > +++++++++++++++++++++++  drivers/usb/gadget/udc/aspeed-vhub/vhub.h |
> > 1 +
> >  2 files changed, 25 insertions(+)
> >
> > diff --git a/drivers/usb/gadget/udc/aspeed-vhub/hub.c
> > b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
> > index b9960fdd8a51..93f27a745760 100644
> > --- a/drivers/usb/gadget/udc/aspeed-vhub/hub.c
> > +++ b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
> > @@ -68,6 +68,18 @@ static const struct usb_device_descriptor
> ast_vhub_dev_desc =3D {
> >  	.bNumConfigurations	=3D 1,
> >  };
> >
> > +static const struct usb_qualifier_descriptor ast_vhub_qual_desc =3D {
> > +	.bLength =3D 0xA,
> > +	.bDescriptorType =3D USB_DT_DEVICE_QUALIFIER,
> > +	.bcdUSB =3D cpu_to_le16(0x0200),
> > +	.bDeviceClass =3D USB_CLASS_HUB,
> > +	.bDeviceSubClass =3D 0,
> > +	.bDeviceProtocol =3D 0,
> > +	.bMaxPacketSize0 =3D 64,
> > +	.bNumConfigurations =3D 1,
> > +	.bRESERVED =3D 0,
>=20
> Fields that are to be set to zero do not need to be set here, the compile=
r does it
> for you.
>=20
> thanks,
>=20
> greg k-h

This is more clear that we specify each member's value.
Thanks

-Neal
