Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36BEF464580
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 04:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346468AbhLADkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 22:40:25 -0500
Received: from mail-sgaapc01on2114.outbound.protection.outlook.com ([40.107.215.114]:45505
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233370AbhLADkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 22:40:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kNSte6NqoajXhaNw5kQgXcxNfg8eZjjX7JT+ISl1dCySMhwl1eqiHjQ2RNPkk7iUMs+MTyjotcmYSennKh/gHCOdIVu/NZDt6p1uEK5Q2/4U2gsPnW8vbcomLLwuiufWzP9vIhCM69j9XE5bNtN4vYreadRYTc0WIx/rbjQ7tDeGZFhyhmLawqpaNwsaI48FSAUcHWIPSqeOzMxAKLcZsIb6kyTARbaBadG6jQvh9+UIxd0Afh+4CJf/4Ps0eeXG7wAmriAPUBKh7OmHxN9FLXSPySWMZvNCdaXUutfYyA9Xys2uTjk4XNyYCts4OG/EqqywPCfhKmjwJ4wG/uThRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Np5uG3zpqJGku1nFMKUUlFyd/o2EsDIjHK4smnzI968=;
 b=O1Q/ILvqmpacHQ022aCamLp7vmU3WWm1Qd5I4akpOiYkgQ+V5OOr7i/09MK2pbbTNO0xI+BLUndzr7NTUCPkyYouG6jMEJiku6gFbgvq+IBONDcwyTv/3ErLYeW6nu1HACXzb/1F6FGGIMQ5nmVX3TKPGS4zellGegwptyzHrwCmnGH1IFK0PMC1TyQ4YO31AV4xG1nDx0jegSScAgKTaCFpk66Xx7nr78fG6UZRL2nocG7VVR8nsXmF5uRnb30z+F0VaJU3nnMo7KsJRoys5eVkH5kRC4LRVg3IdcxzJwLI69jG/K89FOuvpXWXd7WdjgbRi47o/0ZCaHBDmi0hWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Np5uG3zpqJGku1nFMKUUlFyd/o2EsDIjHK4smnzI968=;
 b=cIwvX3tWLctqIJCgKjVNuFSz82TtrvlfqdGy9gM7iG0mygWxb7ofooapPqe5fchdmq3EHLYsZ1vxflVTz/LYuFkxmDkaQMsnLEv4DXpmUobT1by1rPPKx9APmjeY2VRWLr2d1ZhPF+FKUIlv0z+QJ5M8hqxz6XhEASW+5+VuxCxmtfPzVsWX3xdp+pN273A+ZoH0+mQOWmqK2IV9gAoBZaE70bvlRQwh9Jps+Fi2aGkrcjX5TTBETWRqLbYGR/JLUDEy7Hfbc7UpKrhnHQY/iGUlTzr/q4U/dwaQA2BiSBwZQACOPbMNEDb3eNzIJYiyzn0nUO6NG4JiCwKvFbMOyg==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by HK0PR06MB3651.apcprd06.prod.outlook.com (2603:1096:203:b5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Wed, 1 Dec
 2021 03:36:59 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::70c4:b471:2d05:1209]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::70c4:b471:2d05:1209%6]) with mapi id 15.20.4734.024; Wed, 1 Dec 2021
 03:36:59 +0000
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
Subject: RE: [PATCH v2 4/4] usb: aspeed-vhub: support test mode feature
Thread-Topic: [PATCH v2 4/4] usb: aspeed-vhub: support test mode feature
Thread-Index: AQHX5dcRQVG/ybLU/0ajWaHwY+/uR6wb9E4AgAEJVjA=
Date:   Wed, 1 Dec 2021 03:36:58 +0000
Message-ID: <HK0PR06MB3202B6ED02866DFDC2037B6280689@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20211130104256.3106797-1-neal_liu@aspeedtech.com>
 <20211130104256.3106797-5-neal_liu@aspeedtech.com>
 <YaYPOAB3Anfhh5AA@kroah.com>
In-Reply-To: <YaYPOAB3Anfhh5AA@kroah.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa33ac2e-faa6-4bfd-5c2b-08d9b47bd4a8
x-ms-traffictypediagnostic: HK0PR06MB3651:
x-microsoft-antispam-prvs: <HK0PR06MB3651108E73FA058DF23B2B8980689@HK0PR06MB3651.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:576;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ixoHSfpgI6jb3ksNHv2xXusVKBYuNRrmuossftj5xXjgbrXgj2KClYnX7fb6yCg1axis140UJoLycE7w6V3FYYbrGrlDzehU9ekAB4hCGWkc9/er4sd2u6TrrxllCEz+YYR8BytX/Y7e1wLoY+wxjfnZKUk4aRqcdyzlIXSlaj6X4qP+m+LSQrBYxQ8DdcFNP3+ZiIyaqngkifZOGT/41n/AeJIkxf9skF9u3CDTI3JtlNG1c7VvGSZzDyNUcOsF4VucIF10OQZdGowqfrAOsn1hMTRDe2Rn3RnHxX65NSnNZsmhsJfAWH4lzYO+aWUP07ZNsUhFGCUrFy4FvkCeZ7NpIhmRggT2rcxwVzoijSisnb8zvXb+nsfqLyf1uYGonKl/74xyk2Lff43upKhNMIzdtlMWY6EAMoNpa/PclHnhfBqBEvypsOePNiAOZKfpa/9ggKFNsHJkCEPEYINkEGUrwRUnr2J+uqrdO1ToN2WC0ObC4jtbayyfEMqYRK2WZUT8Qi77ePdXVPYIVaNqDvvhGnf6MNTQViusITLLQRc+2a3LYeSs9mb1VFPugQw2Um6lHMZgB2BmogGXk5lGXld/CwLV4GuE6qUNlB/yObIvNL+aW6mfkZeZdLFqjjSzIyqOve5gGPBxVU+LqC/4xQ9N+QeZH3oPGxOgXfAfXKWRFC6OpVufy+ViPGK4CuZnRVW5NBHv8cbhGpi/ZVfMhA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39850400004)(136003)(366004)(376002)(346002)(9686003)(76116006)(66946007)(54906003)(7416002)(71200400001)(2906002)(86362001)(6506007)(4326008)(38100700002)(53546011)(33656002)(83380400001)(186003)(508600001)(26005)(8676002)(38070700005)(52536014)(55016003)(316002)(66446008)(6916009)(8936002)(66476007)(64756008)(66556008)(122000001)(7696005)(5660300002)(107886003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?d/PoTZ22pqHpaHTKdnlVmS7WB/gFvpMak3p+3WDUeiFWPShZEyAPzamwZrxB?=
 =?us-ascii?Q?6PUpr+SdHCrX8QLsIG68roDGB33/7TBrzbJH8XhAUll1phy0JmbJ3zzS1XEO?=
 =?us-ascii?Q?wYOrobmfqnPz80jojUpsf9kEQFlzY3kLCSQCLlo29yMvbb9vfmQHPDUjJU0u?=
 =?us-ascii?Q?1sJIErvJBMOGvIjApn53ZxAnpuFojLCv/hZwZIAhS1qF9Hnogb14I3BF61BI?=
 =?us-ascii?Q?/OfB/eqURK0943KA5nvYq0cSbRjM9gocfQDyCwJcbAfElZKpzZhM+A6KUks+?=
 =?us-ascii?Q?aQnYTBnFEKvFNsFXrw5NQC/8VMtw33oXG3+Nb6kmE+X2ZIArHH+eS6SUaCDW?=
 =?us-ascii?Q?mFY7kpSnn/k78oc3aDvxHtFe/mBCNjvx2GHYeifLYtWcyrpy8QqZfPrM1nKc?=
 =?us-ascii?Q?8ZocaHAhpP9ZBw0/X3Tp55BzBleDwmw6r3DVmlZ5imM/YtOIQflWIJ+wSv3Q?=
 =?us-ascii?Q?OxWbJkNRTxx0TJiRnX2KgEEimppX1T+v9G3PfL2nYkZ4sW+DLqW4yVJgpjKp?=
 =?us-ascii?Q?P7ffHzy3+63pVfI5Lc/kcoz39RXIqssoini1HufQw5w8t3JcOaj7nj4Gt+ol?=
 =?us-ascii?Q?K9D8UG9TrQSc4FrzD88Mmd/WogAY9E9IvAjzkwY/CukhiP+juDrFKG/fiTWB?=
 =?us-ascii?Q?2HEdWWBKF0xZU821IfdqueZsvSsOkbRP70DC+wUTYtkJnQyNAQ3bpxFsCo5F?=
 =?us-ascii?Q?t9WcVPWc113MQNL9CDO68cq7jYoyGUQj2jYS6Tso6jhqbKj5422IkX3oIyFV?=
 =?us-ascii?Q?F+L4MBZxG1a05XLkNiyZvhyUp+uinhZMzd5lsTrz0FLdVcQ3gN4YLZqysMrG?=
 =?us-ascii?Q?vwqghu3xFXVL7y30tAj+bpnMlloFmUgUboq0gZkY8xcO8DqQZAsNKFTQCk8k?=
 =?us-ascii?Q?lBSI8KdCcXDvOEUHsJvgO8zJyCzqnUwdlveOLPodkqC2iGjlafM8gkIoc0YQ?=
 =?us-ascii?Q?DBWP/ms/dD45+S0Y4S70wx0VrP8tnn/h7srAN6r/pLll6H/vBXqw9Q6Ia3jj?=
 =?us-ascii?Q?s/b6YBlnovvoppVLpiz/YqJOQwjDrHJnzMZeYXKYebF4W2ntblhSJVgJgMlY?=
 =?us-ascii?Q?GvsljohJu2dZx+kW7XurzQG0gsMI6no9CwxS8dc4dT35TGMdrioFb8RjFWRp?=
 =?us-ascii?Q?XzAzpgi9/OFErCP9I0VioNmCM1lfiVB8S7sMRmgCu0MKAYXDaBxRq/z2iaDk?=
 =?us-ascii?Q?gG/dBfrPmpIOJQamczr4EyO8M9q5bSlsLwkaKxnAZ3YPp59EeXEA7Tiawd6Y?=
 =?us-ascii?Q?cQ7Rgah13twLP2iqG6T/t45S3G2WbcBXsABe0rKcuR+kCywL1B6llGDTFLeN?=
 =?us-ascii?Q?TOZ+XwNjRtwkrjYa1j1kWdsFB1iCsudX4TQzQz2mPlOtbIXsiF9m73agX6Fr?=
 =?us-ascii?Q?t4swZBODnzIf7eVX1ECHjL8lz/52fLQhiCAGX0b8INN2ltFvos00fTcdcIdd?=
 =?us-ascii?Q?FeODr5GHuK+tsk4JOTS8z3+vKZddaEsKaVab91x7QMI5TEULVQHP5j8PSCow?=
 =?us-ascii?Q?XzE5y2kVPrxR4pA1DsvBb+TDAyjc2Nsz9VmuWfpn5qtCbVe0nqGZ0OduF2Y0?=
 =?us-ascii?Q?AVOHxjUp6o+8nbgG/JMvNGx0Ev1FabDo5KZ5MYQI69gwcZSlo46K/0sW6QWk?=
 =?us-ascii?Q?ETzRZLoTxwLY5dk4Tz34Uxc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa33ac2e-faa6-4bfd-5c2b-08d9b47bd4a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 03:36:58.9687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /BHDQW32TvWpNo/4RUQP3Tdk0abrDRl6pRwmBmyiYpquXSRclyu/Vhb9mNgVTXH5K5yZy3K/5uVmr2ZDk3TeDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB3651
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
> <BMC-SW@aspeedtech.com>
> Subject: Re: [PATCH v2 4/4] usb: aspeed-vhub: support test mode feature
>=20
> On Tue, Nov 30, 2021 at 06:42:56PM +0800, Neal Liu wrote:
> > Support aspeed usb vhub set feature to test mode.
> >
> > Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> > ---
> >  drivers/usb/gadget/udc/aspeed-vhub/dev.c | 18 ++++++++++++++----
> > drivers/usb/gadget/udc/aspeed-vhub/hub.c | 22 ++++++++++++++++------
> >  2 files changed, 30 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/usb/gadget/udc/aspeed-vhub/dev.c
> > b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
> > index d918e8b2af3c..4462f4b73b04 100644
> > --- a/drivers/usb/gadget/udc/aspeed-vhub/dev.c
> > +++ b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
> > @@ -110,15 +110,25 @@ static int ast_vhub_dev_feature(struct
> ast_vhub_dev *d,
> >  				u16 wIndex, u16 wValue,
> >  				bool is_set)
> >  {
> > +	u32 val;
> > +
> >  	DDBG(d, "%s_FEATURE(dev val=3D%02x)\n",
> >  	     is_set ? "SET" : "CLEAR", wValue);
> >
> > -	if (wValue !=3D USB_DEVICE_REMOTE_WAKEUP)
> > -		return std_req_driver;
> > +	if (wValue =3D=3D USB_DEVICE_REMOTE_WAKEUP) {
> > +		d->wakeup_en =3D is_set;
> > +		return std_req_complete;
> >
> > -	d->wakeup_en =3D is_set;
> > +	} else if (wValue =3D=3D USB_DEVICE_TEST_MODE) {
>=20
> If you return, no need for an else statement, right?
>=20
>=20
> > +		val =3D readl(d->vhub->regs + AST_VHUB_CTRL);
> > +		val &=3D ~GENMASK(10, 8);
> > +		val |=3D VHUB_CTRL_SET_TEST_MODE((wIndex >> 8) & 0x7);
> > +		writel(val, d->vhub->regs + AST_VHUB_CTRL);
> >
> > -	return std_req_complete;
> > +		return std_req_complete;
> > +	}
> > +
> > +	return std_req_driver;
> >  }
> >
> >  static int ast_vhub_ep_feature(struct ast_vhub_dev *d, diff --git
> > a/drivers/usb/gadget/udc/aspeed-vhub/hub.c
> > b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
> > index 93f27a745760..e52805fbdebd 100644
> > --- a/drivers/usb/gadget/udc/aspeed-vhub/hub.c
> > +++ b/drivers/usb/gadget/udc/aspeed-vhub/hub.c
> > @@ -212,17 +212,27 @@ static int ast_vhub_hub_dev_feature(struct
> ast_vhub_ep *ep,
> >  				    u16 wIndex, u16 wValue,
> >  				    bool is_set)
> >  {
> > +	u32 val;
> > +
> >  	EPDBG(ep, "%s_FEATURE(dev val=3D%02x)\n",
> >  	      is_set ? "SET" : "CLEAR", wValue);
> >
> > -	if (wValue !=3D USB_DEVICE_REMOTE_WAKEUP)
> > -		return std_req_stall;
> > +	if (wValue =3D=3D USB_DEVICE_REMOTE_WAKEUP) {
> > +		ep->vhub->wakeup_en =3D is_set;
> > +		EPDBG(ep, "Hub remote wakeup %s\n",
> > +		      is_set ? "enabled" : "disabled");
> > +		return std_req_complete;
> >
> > -	ep->vhub->wakeup_en =3D is_set;
> > -	EPDBG(ep, "Hub remote wakeup %s\n",
> > -	      is_set ? "enabled" : "disabled");
> > +	} else if (wValue =3D=3D USB_DEVICE_TEST_MODE) {
>=20
> Same here, no need for else.
>=20
> thanks,
>=20
> greg k-h

Okay, I'll fix it in next patch. Thanks

-Neal
