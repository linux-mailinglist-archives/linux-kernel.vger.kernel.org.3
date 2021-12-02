Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCF44662AD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 12:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346505AbhLBLuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 06:50:20 -0500
Received: from mail-mw2nam12on2073.outbound.protection.outlook.com ([40.107.244.73]:43584
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346508AbhLBLuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 06:50:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1nx6aO+Oh3FXH2vDM18EZtpmBq7es+fWiQYn6sj9/KOYRlihIynkWxaIqDwE55LB6JjUDXRwYub99ZCf++XIjEEDTgcDQqlAQa4LKz5x89nZ2QyZYM54jfIQwTqSWzrKRYu8/a8PBXb6Z7q9YQRaN1e4g/1Lp4x0oNfHyyGFeWKMj8g3ZXkqXLrZ2oSIdpRGaO/RIrmdvStJyd8ol42XnnqZr42TeiXZ5aCT9aaB+xgZ/l19czqPuFJ7s7WkDoxBsPQmVKDDsmzdj65zL9TRt+BmE81f7JQbGiQiIREWUThCO12eWiGQTzylvJHvb80LXWac09hQu3KkNrNjysxFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ed1tRlVYQb9EEcPTdOOj4Dsl+ZMIJDvs6vu2RI7QQzY=;
 b=i5AHszXy7gKdnbi3FtiBaoXUl55Y+liLyLb+ysT4oY0MouSzxguX1uDfxJ5KQbV6LwJL/FVxr9VbnbL8uP6xAgYsMNwso4Xdf6VfSQDRo+csqlUFuOvWnP4VZqEQ8mXv26efBHE1hrTIevCcP4QPjLniaDOoNKbcJ9EyrVqajJNNJ07+QY+5cigzZAjSupof1IMcf4oIWcwqxJqihcesCRGc0+ZEBV1xhWx/ftEgr7a3BPgBh6mEzRdaFy6gvNx1dG7sORL1nrQJgXAJ1UFB5JKji4UdsxKhaMrOXe/IbCY73I5zT9FM5g9UfikplxxuqsRPpquoIOoaSPLC/0T5sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ed1tRlVYQb9EEcPTdOOj4Dsl+ZMIJDvs6vu2RI7QQzY=;
 b=KKaGVk4QYzLFnWu7EMkuCJyGplaq6cHJcoHgY2MoMTUHLZAiMdTHaq1jCKCcXOxhTEjH2AVK3rNHKks0Z7C/263QFe9w3Y+b8rywQzswW8j03xzI7bNAabNBNScU+VLBoeq+Xpqy9bz0CDaiVXsvldrANaAYEbBxI6+YWsHm9Ks=
Received: from BY5PR02MB6916.namprd02.prod.outlook.com (2603:10b6:a03:234::18)
 by SJ0PR02MB7664.namprd02.prod.outlook.com (2603:10b6:a03:323::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Thu, 2 Dec
 2021 11:46:41 +0000
Received: from BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::8151:8728:8d6b:c3dc]) by BY5PR02MB6916.namprd02.prod.outlook.com
 ([fe80::8151:8728:8d6b:c3dc%5]) with mapi id 15.20.4755.016; Thu, 2 Dec 2021
 11:46:41 +0000
From:   Anand Ashok Dumbre <ANANDASH@xilinx.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        git <git@xilinx.com>, Michal Simek <michals@xilinx.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>
Subject: RE: [PATCH v11 1/5] device property: Add fwnode_iomap()
Thread-Topic: [PATCH v11 1/5] device property: Add fwnode_iomap()
Thread-Index: AQHX4YZBUvFrfnFzmkK2bRDvVWcrV6wUH/KAgAgekICAArbIYIAACAGAgAAjQwA=
Date:   Thu, 2 Dec 2021 11:46:41 +0000
Message-ID: <BY5PR02MB6916174E242165D305192F2FA9699@BY5PR02MB6916.namprd02.prod.outlook.com>
References: <20211124225407.17793-1-anand.ashok.dumbre@xilinx.com>
 <20211124225407.17793-2-anand.ashok.dumbre@xilinx.com>
 <YZ92mTURrFWZPUXp@smile.fi.intel.com>
 <DM6PR02MB69236DAEBED675DB929BB8ACA9679@DM6PR02MB6923.namprd02.prod.outlook.com>
 <BY5PR02MB6916F7BC6ACE5326DB92DB2BA9699@BY5PR02MB6916.namprd02.prod.outlook.com>
 <YaiTw1RVgxkOvFj8@smile.fi.intel.com>
In-Reply-To: <YaiTw1RVgxkOvFj8@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ec54edd-b8dd-483d-f859-08d9b5896840
x-ms-traffictypediagnostic: SJ0PR02MB7664:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <SJ0PR02MB7664F2876F779E2D2AFC86F6A9699@SJ0PR02MB7664.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PSeTPbPcU6XfBt4il3LSJjylYmayvPPDHqfYsaVrP0cqPwZ7G4+j+hYRvM8aPhQL4bg207DTyxq0e4G3GiN6swks3eR5XoGZyeKsTqCrnJe5Z+r1iA14QX+xVAeKQ/+J7y0uCFgAQNm81H+5XkWTPhLY6i7DSebxtEG1XBqC/q8+vIYynNhOMYqJ6LmLNVjnMQp4F1V7XRwDqXvaV3lWgLFcgBV0dsm/OgiQkFxrRaStS/3AzrtnIRqKhjn7mVhPgFIxLakyDcB7HO1LjZl4Ko2n7EfIXthhsUtbIJXPfNGCLdSr+uqIo2CQuMGX+SDLkC2GLRy1nvw2jn/38AJRYXVRWZu2AKwgrasjEey7Yl/3JivgJiOpxsPiTFuxu+vEDZhvaspp9AQe9MKYqdlQpC3K8LdBO5ViTZycqhkAhcuygNf5WNXYlrOf/lbSMjMUK4c+4c9YFFlHYIrU5qPt69mZ0mEwDEE4UHap7eHkX18p/LZqcmZpQWUiz39z7mb9zMY87TDyPoGdgIi910lxs1++5KDu1c+udtOj8rPnA9CjHYrQtesOtSvev6EvOdKb8/4ss+BDvuZxzgLU4Zn0hSIbVF56Cbq4LEDgvUbeRjyjo9UIbGDPWES3J4zkGi3TVCr+phsGojqEoogBGAmuhWIqsT5u0M3jt+GiKotUnfkxfsRzjlO50/LkvFN94eC5fxVrj7AQ+aWM5ONy1LES5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6916.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(33656002)(7696005)(66476007)(6916009)(71200400001)(66556008)(26005)(5660300002)(7416002)(54906003)(66446008)(316002)(76116006)(8936002)(64756008)(66946007)(2906002)(9686003)(6506007)(508600001)(38070700005)(8676002)(122000001)(38100700002)(86362001)(186003)(4326008)(52536014)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?P325NLj9Vb9OKUy0NHxSDy/RBoxYvO7UdBKzruDMuiyVYmZ8d/QwjAVg2gGn?=
 =?us-ascii?Q?jlAPJ0UNPdZJQm4N23cuc1hSypwNNx0W5wRrQXT5tyXUxtQ8TSvTCnThdMKy?=
 =?us-ascii?Q?ul1P7enKtLRk25s6WllwyKHqTFXwR3a8IPJyJ0CNYW31u8Atv+H3y8cA4zHU?=
 =?us-ascii?Q?tO0u9N0SOe8UAfb8tZfAZ5kq16DZa1JEywuNQiK4GOGaxdht33TuvdrhREiD?=
 =?us-ascii?Q?z//YteS/ygXPCUOb30L7R5zcR9xZHngOenLNkT4x/AFoRRbO96DDrmsnEv+H?=
 =?us-ascii?Q?fRtcwzjdhU/ae/BbhC8U0qZdF6nPmafcUganeaeexEVmA6+02KNP6DPy+3ev?=
 =?us-ascii?Q?xD5j9xcw+8ZwBc73z5MpHsiHfHXJoa7vpS4jclKH0fY0f/31VuxVfHV5rqnR?=
 =?us-ascii?Q?3/10I3npLyJ/gBAMNoJekgIchwm8hCRHe4Obi0fVuzwjl9F1JFMCxhoHuqp9?=
 =?us-ascii?Q?SrLtz6Da3NdZeQNSCDdaWtTSa0PTLjwjH5RiuEguBgu++1/wxW1eDwR7yMln?=
 =?us-ascii?Q?u55jnttkQbkqUhTGlqfFVEkwW60g04uRItU6jC69cf3W1bvRWxuS/xlVHDLu?=
 =?us-ascii?Q?Q8sZ3c+qDDmTouqI8xAa46iZhpZIibXViiikofD/4KOD/LLkNy2rmQt6z6MR?=
 =?us-ascii?Q?p/AvtJw8OOGec+EDj5FfXwtXWodi96V/c0hJtIPzFZS03FrxDCMqaLyE7CFZ?=
 =?us-ascii?Q?4qR0eORtecdn7m9d3OTXeljenEOllQVwhCl4Xt03nCbNFjG1wqwNEP2eD92m?=
 =?us-ascii?Q?fjRrBdOVEhk3Pwa1d8kev/gn0Il5+y91AKSxrjl/CxGAgn5LQX9cfw5r9jhz?=
 =?us-ascii?Q?HG3cKBDSt6pQmWOcQRf9w1d5DRF38PvPKX7WYmVIpeDRjKE8aZUAha554Zq+?=
 =?us-ascii?Q?V3ZozuayGuGuxw5/V65Z1oRIuctDezjp8HZGRldcQmjLJPUNG5sJN9hMuhSP?=
 =?us-ascii?Q?nWszyjyVlUNlDKm7FlG+RPCw1fSazIlhlYs8N4dBWTXHWwzcjOjSYk+FoF56?=
 =?us-ascii?Q?a90dkKBccgzq5+JTOEJty1Yby6Z6AVy6KdsAaZdeVVsWSf0AvGwQAAEhjBrl?=
 =?us-ascii?Q?GoF5+d3c94G1fhwVk5/QtAjrULJiIJRfUtky5soWMOAQ37ClvfCqa7hcOuwv?=
 =?us-ascii?Q?TGNN1vfpyyvm82i0I432cgnyPK4I0r+0vB6QzMTdmdUB5htEM3MGI/dAMMgo?=
 =?us-ascii?Q?5NmQYCuzHLR38sZ3untHsKYvfPun5BTO9be17rThxaOBxuh/U3HfB2Kkei2F?=
 =?us-ascii?Q?vDaAR9NdEERLklFOHkHeCRLnSylKUfTeH71IwIamYd8yyOaFmH9Z2ehFpnyJ?=
 =?us-ascii?Q?y1EGwE90BG28jQTB+/gOPfb882mt+SXvUpCPJ6fTX/0xTzdEQlLHkHbjoI+3?=
 =?us-ascii?Q?tTamIhmXeSKeLToOlTNQlo38K/F1m3Ru87cpF+YQ/Zxdi276d50d+45a78sB?=
 =?us-ascii?Q?w8WprSmBTNuxhmOR9u4XPvuvyscR/G9U+rOXKsj/BH9vURKgkX2AM0VvZ6TS?=
 =?us-ascii?Q?bDUB/p44NC26lPhi026E2URF/+WikGkwtLuaq+mW83tpI35O8tSAOmMvy/2S?=
 =?us-ascii?Q?8XrpzMnmFYIsJl9ATAERK3Ndv2LGbYBeiJnbLpfI8CEl0sZ6ShkWr/t6kggL?=
 =?us-ascii?Q?XA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6916.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ec54edd-b8dd-483d-f859-08d9b5896840
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2021 11:46:41.2465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oZvW8HVST1Ojzn3maCbsDjhHujHTn3ym+DIiupd20tYSuWP7gd0xGnajobgRxyGKS6/QAnNqqRLXr4TcazoF7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7664
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> ...
>=20
> > > > > +void __iomem *fwnode_iomap(struct fwnode_handle *fwnode, int
> > > > index) {
> > > >
> > > > > +	if (is_of_node(fwnode))
> > > > > +		return of_iomap(to_of_node(fwnode), index);
> > > >
> > > > It seems this part should be wrapped in some ifdeffery according
> > > > to kbuild bot report.
> > >
> > > I see that of_iomap is wrapped in #ifdef I will fix that and send a n=
ew
> patch.
> >
> > I am unable to reproduce the conditions for the error shown by the kern=
el
> bot.
> > Not sure if I am doing something wrong. Any help/suggestion would be
> appreciated to fix this issue.
>=20
> Kbuild bot gives you a config file and command line with which it tried t=
o
> build. It's quite rare that it gives you false positives (and here it's n=
ot the
> case, because you need to have ifdeffery like other APIs in this category
> have).
>=20

The problem is at the config file itself. I am unable to point to compiler =
correctly while running,
make ARCH=3Ds390 test_defconfig
s390-linux-gcc: unknown compiler
scripts/Kconfig.include:44: Sorry, this compiler is not supported.
scripts/kconfig/Makefile:94: recipe for target 'test_defconfig' failed
make[1]: *** [test_defconfig] Error 1
Makefile:619: recipe for target 'test_defconfig' failed
make: *** [test_defconfig] Error 2

I have added the compiler binaries to the patch and set CROSS_COMPILE=3Ds39=
0-linux-

> > > > > +	return NULL;
> > > > > +}
>=20
>=20
> --
> With Best Regards,
> Andy Shevchenko
> =09

Thanks,
Anand

