Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2364644D1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 03:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241292AbhLACUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 21:20:34 -0500
Received: from mail-sgaapc01on2115.outbound.protection.outlook.com ([40.107.215.115]:13825
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229538AbhLACUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 21:20:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5VzScsFFLfAot5zs5c5hkYEJKQa8b6k4gJ0xzHo9V1oIfpPaG5Wq5fQbxWJfRZ+PLEVYES7Q55u5Q0B31dvrLx40zO85bqUyr5iReXpGNbUqIJ5LuGhgX+GiFOtITMaBA2BHKROb+GcQ8yH8TjobiyZRYjqCku9QTvg0O2u5slb2XT9rOGZQRM674N0wJlaOft5IDHw7PZPBq5BX7jKgMVxa7JvMkDPj38mOJc/XBqJ7ILT99i6LOrnEQC5QQnRTLUXTzUBHWvUoKYXEWfWCM4NCsTzz8TPUwFJL+Qx27kG2jo7mWIps2PTkTNiuevBD5+ucAy1BYsxzAHYiBkcjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zyG3o5/6EbxTxGW2bEwPmGb+KN50klqwxaYhZRGB0RE=;
 b=TbbyK+e+m5VTo19eB8T8A/LvikrDPNoAsbCu/Gw0eVZR6JHeAb8jr7csnB0RMEnInsyNo30H/NqYIhn7OG1unH/YiGOQrGzeWC+qULMRKV7PXWzGQ8o/pAsD4TNTa8gB0M+yFFEYavfwhQ53oND0kMp6XB4F1FZnWfgutbF03yqwiU1pWfulv6okzg/OPab1br2gtnVXXUHgnBkK5WrIie0UfrgTDYfrk3fjKvQcfuC9j2uxu2xEIhOeRPAwOYQ6EIgI1XssP919gJk5RnLs22iXExEk6gONUud3/wx+85TPB9pwg2yds6RqsNiHX4EUnJ/NEBYuAimHfq/d3rSAPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zyG3o5/6EbxTxGW2bEwPmGb+KN50klqwxaYhZRGB0RE=;
 b=mLx04n/rSker8aafnIRs84b8BDt2xyYUhzBBlndCiLpnmnsfDEHJFHckXUCWkr6Fpnz1CUUG7UPEmKxBTT7vooSzHxitkWI32G7Lqm4vZrwXv7WHrXxFoQn5asvhU49oWBvmK+/5rcbzKTT+x2x+G2onPZ+Csd6P+XOYBlYu+q8mEkq8MkLxDpjiXNFg3ebGRoffOB8wTI76gtMu27lu1AW3EZXU0/mztOyFEfUVQutZsse2xzE2W5JPKqhh3MW1NQ9CYarw1ausmrPezhRy8Aat4HnA1RtCZYmVY9p04QnPjHiV/SBIvu1ss6T0kQPqoMxX93U/xMUh5eikJOk4Tg==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by HK2PR0601MB1922.apcprd06.prod.outlook.com (2603:1096:202:b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 02:17:01 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::70c4:b471:2d05:1209]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::70c4:b471:2d05:1209%6]) with mapi id 15.20.4734.024; Wed, 1 Dec 2021
 02:17:01 +0000
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
        BMC-SW <BMC-SW@aspeedtech.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: RE: [PATCH v2 3/4] usb: aspeed-vhub: fix ep0 OUT ack received wrong
 length issue
Thread-Topic: [PATCH v2 3/4] usb: aspeed-vhub: fix ep0 OUT ack received wrong
 length issue
Thread-Index: AQHX5dcQPlR7FKZMjEu7RLEtATtxIKwb9GyAgADy05A=
Date:   Wed, 1 Dec 2021 02:17:01 +0000
Message-ID: <HK0PR06MB32023684D218259A6236C78C80689@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20211130104256.3106797-1-neal_liu@aspeedtech.com>
 <20211130104256.3106797-4-neal_liu@aspeedtech.com>
 <YaYPUfFTNkh+zpqz@kroah.com>
In-Reply-To: <YaYPUfFTNkh+zpqz@kroah.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 689677c4-1182-49d5-897b-08d9b470a931
x-ms-traffictypediagnostic: HK2PR0601MB1922:
x-microsoft-antispam-prvs: <HK2PR0601MB19221F4895938D4C59076A9080689@HK2PR0601MB1922.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JyHX0MfAck4EbK5mZ6MAO+kQud/rxXb68TH6pePuenHGYXonPg38OkLLZb9/fPTUDd86P6xOtdsnbsTRHjfk+BtgThuQj0xiAHPFA82+NRAtV+MQV9T/7QCyF9AM4dG/2ZcEDkdYNLwm09Zfj4avC5MykcNHKMlwdy4zMTE0aASFn9kC0jFJMIUTqbjAQfjQDb0IAEwweSUIUjopNrjsnAgk8C7t+GAiEY0KJ8lkzWS+nXNvDa5riozjumKjjqw98wOOuJhzhY94sTYM/y9xSbs5FElTcRYrn5v/dkX8wAln0g3BFKSYBbMmFU6Nv8PljdeTezBYKktOmUd3fdobQvqy/wU8HELK2YNTQZ5KcI7gNwPvOLZv+DpbvZT9AY1qqEJAwkcDpEdd4zy8Q3uWPQ9xXr/+YEJypDkMBRkNcmXzPWrnTsM3j830iEqomJ0a3m2lXSmfVi6XllUwnlFX3jS2ehYrP3Nei0ChgiNrhDOu2XIjMPl+qbj95rcyLF83r+JW93k++QtpifVz8wLMBD1ZLGG0JIE92lUiEUTzyJT3tate+m2kL7SHfwqSZniLOooxBLJnIv+r6P4/2kdEMYs7JRIwOcFAGhsKmeRKLx9lVHPlMbNhgYhUHUHhs/DGW6SKbxFomC3HW7SBi9J9diKzAW2Rf8VztDMmtVU/wh3ZFZxJ0AEZOhoUgQHPrnEcreKaMTCz2KIEU97ujHaCzw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39850400004)(366004)(136003)(346002)(376002)(38070700005)(6506007)(9686003)(6916009)(86362001)(55016003)(4326008)(186003)(8936002)(8676002)(5660300002)(53546011)(2906002)(7416002)(7696005)(83380400001)(71200400001)(26005)(33656002)(508600001)(54906003)(122000001)(64756008)(66556008)(66476007)(52536014)(66946007)(66446008)(76116006)(316002)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mlJN9IMKSTE/kDmzoKDJ+v7e7ZUqlopU2GnlbWA5wLAtlkkkKimR3PddIrT5?=
 =?us-ascii?Q?dbqWKDcR7xC57Hf1/cAdsS62As5VO5G2JWtZrVeD42gAKrdY/AdpqkEYfwZa?=
 =?us-ascii?Q?Uk5hkKYc3msAuChQE/UPwVTxGieEqST3CiV2uU13q70nfRDVWBdRVpWvMad6?=
 =?us-ascii?Q?JwGaJvvXXcx2KlVhrYEFqDQB73VHv1LQJPVFmm0x8tU2q7hXlNE9VJhs5bRQ?=
 =?us-ascii?Q?f9MOpJwGELvC4KfJvN+Hawm4ticqWx8Sef4JK6rEaSXmJKc9baqB0KVopz4s?=
 =?us-ascii?Q?3BYRXtUHudMEhGyquHZcVOSug2clINWtbpsZfmyUYtuDlj9Frro5P1rbTgFd?=
 =?us-ascii?Q?EL2XoJPjF1e4yAKQpY2rUeSwTFIQx4GS+W7wqBaGcRvVeE1Ixt2Uj9o4ynwQ?=
 =?us-ascii?Q?HiCVC04tPt4E7Cy2AwxujL3uLPX4NptjZMNuiA/6iHqya7aBbTzJEF8Uyt8E?=
 =?us-ascii?Q?0jPRR6Jo69fRnsxdbAmUI4iotoKBoOtAIuYGoD1VLggW0GQahxNspnm9fJ8r?=
 =?us-ascii?Q?w4wWV3kLhkE0Xiy7u6gHf+2FYQmi4EFvzBJk73svX2GROCNzKhAX3TGWLqKR?=
 =?us-ascii?Q?IQQfUuqI/cLjTVJYZqGzXdElujINYN2rAOT2cnv/XZnAAZtQOtRGnl5pHgIV?=
 =?us-ascii?Q?9vYDNThcgFugb6PgRW0TVAEzsX4VBcPu3rcSievHWQ6GmC5hmvjJrYWL5D4u?=
 =?us-ascii?Q?L+PO95Yde0aCwyvDOG31eHBx4ZmYb+bHm2NHKQ3KHSUuRWZBwcbG4CLg3XA5?=
 =?us-ascii?Q?GoeNGOcDtW6y4VBYBco4TrY3IW3ZkAeAsq0gNGEBL2ViNgjVF9I4XVtVz9vN?=
 =?us-ascii?Q?ZFfUfnPNqK5b98K3D3b0lg5/BecvCDr9ZmJLZpBMPth1f6zennY40xozdr0b?=
 =?us-ascii?Q?4uQHFWixF7fqCntyYzG0qU61CfQP3RDEgS+/RsnbYk4IQ76FkoAc4z8L2OS2?=
 =?us-ascii?Q?4bKZOoiEalB3C2ts8MOJ1r95I3bbxNe3ogRWBK7jQxoFgPn7PJerKBPEZb3K?=
 =?us-ascii?Q?ivI9Eg2yhV19XyKGq30jv1gP53Z/92cORmN4W/J2OZCalG3BWpYw5mfF+nFB?=
 =?us-ascii?Q?fgoP/6OprLKC3yGyhs8pyWJA2aPBHxldKJ7eeHaSZHiZlzbf2We838fk9x3X?=
 =?us-ascii?Q?Mb+XS7zIA7+bdVSI+k072AbqRKyFZP0vHQaCTJbWpJYkOd0wxSulrqcMU3uM?=
 =?us-ascii?Q?7rVv7OgDrBks1M2fEKsv+iebGSeDYCy1YGS5ie8vGbFy0wSDj/F1cjsUpzfX?=
 =?us-ascii?Q?WcTNl0eK4O3Q8iTWZu6wzKAERC73R94ho+GaQjPd6RfCRExXLntq4bUbohor?=
 =?us-ascii?Q?rXImB+qaWqnpdLLS0bHw5TR8EJ4wB96U1josfKmuzbqScF9/JxeNX8hN2PSe?=
 =?us-ascii?Q?DXCwXnV6PLFEWYk4+cG6fzG9xaDn6yMiT+pUgIh+fiuooFMG7ZMgOeHRvewz?=
 =?us-ascii?Q?AAUOHjZHCpH9u8wttr0j2ZoSZcxn6Rfg2z3E2E5t4oFSUYMQqI4l9b9UdnKi?=
 =?us-ascii?Q?Kbg5Pjg/pBbipBpSyseloBxaZ4QYGsmTkhvjnW7FHKXhqT58DtzZi140tvTT?=
 =?us-ascii?Q?s2oliwh+cX9QZ8jaWqo/yBAOetuDdrDusvmrgMffdteFy0GUuPZnmc07oOLy?=
 =?us-ascii?Q?ze0QHw1Zq3dTabmmul9rBN4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 689677c4-1182-49d5-897b-08d9b470a931
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 02:17:01.5989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y43AW5Im5EvobxcqA9t3aeZpf/YMB9SRczhx2OayilSiTgceKoXPH/heQ7ubzV5HkVB6l+MJCSywLKdwFRJZIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR0601MB1922
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Tuesday, November 30, 2021 7:47 PM
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
> <BMC-SW@aspeedtech.com>; Benjamin Herrenschmidt
> <benh@kernel.crashing.org>
> Subject: Re: [PATCH v2 3/4] usb: aspeed-vhub: fix ep0 OUT ack received wr=
ong
> length issue
>=20
> On Tue, Nov 30, 2021 at 06:42:55PM +0800, Neal Liu wrote:
> > If multiple devices in vhub are enumerated simultaneously, ep0 OUT ack
> > might received wrong data length. Using expected data length instead.
> >
> > Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> > ---
> >  drivers/usb/gadget/udc/aspeed-vhub/ep0.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/usb/gadget/udc/aspeed-vhub/ep0.c
> > b/drivers/usb/gadget/udc/aspeed-vhub/ep0.c
> > index 74ea36c19b1e..bea9cbb191a2 100644
> > --- a/drivers/usb/gadget/udc/aspeed-vhub/ep0.c
> > +++ b/drivers/usb/gadget/udc/aspeed-vhub/ep0.c
> > @@ -251,6 +251,13 @@ static void ast_vhub_ep0_do_receive(struct
> ast_vhub_ep *ep, struct ast_vhub_req
> >  		len =3D remain;
> >  		rc =3D -EOVERFLOW;
> >  	}
> > +
> > +	/* HW return wrong data len */
>=20
> Please spell out "Hardware"?
>=20
> thanks,
>=20
> greg k-h

Sure, I'll fix it in next patch.
Thanks

Best Regards,
-Neal


