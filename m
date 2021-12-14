Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68864740DE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 11:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbhLNKxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 05:53:20 -0500
Received: from mail-eopbgr10043.outbound.protection.outlook.com ([40.107.1.43]:64137
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231486AbhLNKxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 05:53:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUJE/UButfUnwLnb8WlavEKpTAELw6BlMGi6YObalwhUKFWjNFWA6h6r415Z94Ncs4Elg9C/i35+DUMVvF29bjr1qSKPGzq6Fsq6cOP+0HiWNCKe6ahSEB31cuelcpinP9G0LgfLUQNSvKwmkD8wRZmjq1rnOxHKgXc2sVpFmRAY4T3TY509e0HfllANP1zGhRRYStjCGL9M4eNtiGorhhl4mAUtdhPyaWpr+xgHkcZBa8bfMPVW/9xDpSPYkwf+ikXitiNNgsgNv7m96pjKV3ru5bUEbL21no054uI49n7Z6MdJ+SxYrLOeXXICRVSwmIet0rGHw6E0jUqyFrGPgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CeASEeJAAQwoC0ZZDFKbyXCOdxyGJY8fHkAz3LRcHs=;
 b=cd1pQbJ0byMAst3FkDI3IpXaylQ5cFxkRjtWwMdcuinVZOp0AjNBjwIJjfsYYidOJU923CISVZvj0b22iDjFyIDLqq0MNf9yhYCmI9NFvEn2AkJZ1hCULMQXcsVC9r7nfAL17HgNZFema7iy0Yo9gJfVER13JQ2f2iibLJTNPJg/MmouYaB9R67/pJx8Lg+svYveZQVryQT0CXEYywpkKS8R0VB7VcyXZKOVAXdAaOvM4NqJdRyZNBolpACRvYjaxzvKyJollmFvT1ypo0qmZ+/2b5vSM2TQMhYrmVahgQC+XOH2KKNl4miy8416iVkk71fs+6wBcGXLFUeSH5/W5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CeASEeJAAQwoC0ZZDFKbyXCOdxyGJY8fHkAz3LRcHs=;
 b=DywzlLRqSpmj0tn/yNEF7pRDp3sIscPkX96NBwCGezDJLrOq124YyD2is5w4eeEV8+gDQexnas5gktWLn5Puy16XzF1bjpLosPDaEZEQlMKWy6ey+mQN835z5ZxB5JbPo6HXih8zuh9l6Eb4Dp9Oi3F4L4eDMSneDnQW52r0f8s=
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by VI1PR0402MB3838.eurprd04.prod.outlook.com (2603:10a6:803:20::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 14 Dec
 2021 10:53:16 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::c84:1f0b:cc79:9226]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::c84:1f0b:cc79:9226%3]) with mapi id 15.20.4755.028; Tue, 14 Dec 2021
 10:53:16 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        Biwen Li <biwen.li@nxp.com>, "Z.Q. Hou" <zhiqiang.hou@nxp.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [RFC PATCH devicetree 00/10] Do something about ls-extirq
 interrupt-map breakage
Thread-Topic: [RFC PATCH devicetree 00/10] Do something about ls-extirq
 interrupt-map breakage
Thread-Index: AQHX8ItO3xtQxxPJV0yONti9mp5846wxrpCAgAASv4CAAAYSAIAAAr6AgAACkICAAAPSAA==
Date:   Tue, 14 Dec 2021 10:53:16 +0000
Message-ID: <20211214105316.aibjmwdhg7a5wwlj@skbuf>
References: <20211214013800.2703568-1-vladimir.oltean@nxp.com>
 <87ilvrk1r0.wl-maz@kernel.org> <20211214095853.4emzycaxkuqr4tun@skbuf>
 <87czlzjxmz.wl-maz@kernel.org> <20211214103025.wnzkfxr5xxeuhpln@skbuf>
 <87a6h3jwrc.wl-maz@kernel.org>
In-Reply-To: <87a6h3jwrc.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34eacb92-0922-4092-c4cf-08d9beefef1a
x-ms-traffictypediagnostic: VI1PR0402MB3838:EE_
x-microsoft-antispam-prvs: <VI1PR0402MB38382B0AD300C4E2E0465BBCE0759@VI1PR0402MB3838.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MB20TUYEsEt7FxgIrqhHNXx7Y4dCTwrpDbLUAXuL7y4GLtKUSIu/whr7QFOcIdOVsooguksuU6BC1j2X863WO/TTOQQlSC75HhLWg3F+l0TWWeG2MzfVWJSq1RbqWJYzNK7GpG717v9u04z9zZMT2Kae2wStdvXt+/8OCH061weES4aItjWuBYla57GnYOQnmsMY+g5OJWtt8cYKW9TwOpZ5d4ngzTCx/zsE5H6BYKogBiNyHKiZ7YiZ3+r1O5ZXyjLCRqm5W+azTsZAa+yQiq4MzjcztztIIQ3NgVQzGCj8+NoFsfyu3AjOlooLim4p8bxO/YTqyCLwAVgVY85NXQ/mZpbuuOY7rXQ0+A//DDQB/5ERwUU3OccsCk/D6A6JzyYhBFmu8ofjK46qaOOREFdLgjrafU6CRU6CcMrA2Q2u6IvBOxH2taXsYDSMG8wOZoarbBQi1X7YVWIflkRj1ZOvXw8q4NBLHAf03rXdiFqM7csP3tEXczgytbWTZmmEaFTKo3A0cZRmcyYTLrdNtuba9FR8XeaxUmW6DD9GVHwOw323YIr5p/oa8zpFir48Vu4vjYjw7uOzYxNHKIXwrnXNlFaT6CT4edDLLQgs4H4YUXD1eMpq0AzdIK2jPLZSWvxzVFAbhC3xgeWnhTw257YDwE1NPBcoihITlKeR4eoBUhEMI3PO3ZRWj5OnQVvpfqg93QQpvtSRZmsvCePyJ2I/DAixFMdVWCdCyEDafgAf96eAqQ0FnaScScGgHF8kLlFR1FRut+I+rg+6Ai/5IaDvuYIl9u8br7iTCSQpk6A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(8936002)(6486002)(38100700002)(8676002)(86362001)(186003)(4326008)(966005)(26005)(1076003)(9686003)(2906002)(122000001)(71200400001)(66946007)(54906003)(316002)(6916009)(6512007)(44832011)(66446008)(508600001)(66476007)(91956017)(64756008)(6506007)(66556008)(76116006)(83380400001)(38070700005)(5660300002)(33716001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?57b3U+EkUGvhFdzLqg0vNkCRNGuk/Eja2hNRdahreqrZwdPye77aFUKZ6bRJ?=
 =?us-ascii?Q?lqP0q2m2+LR/NLB7hmJNd3orLDc4EkubrnZEsj/O3IdrLruOALBal6zfa58v?=
 =?us-ascii?Q?jCpv78DyDjt2alGNbQsSj1U1d8ccDvB+/2/PXwv1JqHt9k6+qxWCdadUvxSH?=
 =?us-ascii?Q?Ke8b/lVoOZ8Qrr/ULsln5AGI+al2qiruxifiwAnMTrc+6McwqWKtV2NIiyYF?=
 =?us-ascii?Q?8lPgMG6pg/1J2qW76i43fv6Z73lw9C4TN7l6k8JL9GjHZhlD3PGC2ZjhPVYU?=
 =?us-ascii?Q?Z3UAHl7w57dVbhbpWYkPggkxPc1ajPw1bDSiADl2BD5zu/qLu3b+dORf8x4Q?=
 =?us-ascii?Q?wOAfUfmchUHl/1MaDBPKHWcefbP5o4Ew7H3DE/kBE31ZDkXEO8Tc97KM3aQE?=
 =?us-ascii?Q?h/2Lbo8tI3uyu4ONGTaqWmm4ARiHGrfZEUVWJB24Bf8S6yO1NDLFhth9Xb7Z?=
 =?us-ascii?Q?HXLsfzGmWn0pipG/ETrJSYS6/fQr/G55oQGi0QyebOJIgcNdBH9YVuxfMVKv?=
 =?us-ascii?Q?DBpYvwriiBA+MI8XY+kMu/4AX4qteCwwRd+xwgLWhGfDnZ/sOl47+uNaoktD?=
 =?us-ascii?Q?/2e2dwSVD2hzgV33Oo45f6EMV5NchJonx7Q6Wyw4mQ6d0vLvNTkIQ9gXDIBL?=
 =?us-ascii?Q?/Sw+wcGMnhpoWbUrWTXhgyeYQ5TpXxwI/8p135+46sncaevTpOXP+sC8Mogm?=
 =?us-ascii?Q?DdhcRSe77oX6Vp2vLYqh8w5OVnYcUk4HgCpS1Wt08JEwwzMqdjbjS7muTsRy?=
 =?us-ascii?Q?Rt92/fJebMUlAV276ix78+0AAErDWCeyHZBAT+D0E4Sp9KNLq1su7DDFUaBO?=
 =?us-ascii?Q?Po+B9zDehn13M4Vk0R2NUr1ldS1vGQeZH/xtYa+6fVbL8KUgC7CfWGWMQT6M?=
 =?us-ascii?Q?ovecdxyYDXpOB6PKjy4ZceAVLddxMSA5Y4AC9gsVR2fmnUMDTPzo4v5bNACT?=
 =?us-ascii?Q?r+6vbMD5g76JtU5MTfD3I//N/eNtciSx7JHlfeVbfOoCV1lg4vX5W/HmCOWe?=
 =?us-ascii?Q?WKWLzBvn/pjHVL2AxD1Nob+IYjNdMexykWAkccMp4ovTLerfvuKEjuyk58zP?=
 =?us-ascii?Q?9RtVfKya98U+TzqCRGOglYuAic1gI7jEiKAsPNjhPJP6T43sqX1Eq0orZDYs?=
 =?us-ascii?Q?IVPjq4NRdBZHEQ2xc9U3d/7xk9XoatK5n669Pxg079W7FfYc0gCIL+eO3EbS?=
 =?us-ascii?Q?3/b2oBFqj3eQP0ipx8/gQItoC7wOoONgkbLz7Zi2scR+Ml4clHGTmQjWFFsn?=
 =?us-ascii?Q?z3aEbrdbu4SWnzD7KKCpJzFlMofi0jVVmt4p1m1Oc5dpgejYg1dJPH4ozfge?=
 =?us-ascii?Q?WLy2+gTtS54zpwA57sGLkqJiIrJzGIchp66Xj8Hr/7LorqFiLYDExpu4/rWI?=
 =?us-ascii?Q?EgvSK0wE9c1u3YtCw52CRVD2Lmp/A0W0cAi65MyaWRTqEWHPX7/UI5JloXrf?=
 =?us-ascii?Q?m1jkSDQ4ur4Y90D4jPAg958CLbl6oUHE1BgnjLLlmE2OFERH9aiYoi4AmiQ/?=
 =?us-ascii?Q?TyhZKaiH7lm2g79Z4eXlE807d4WQXTtG/Hh6ruMinNCiXtDAx1wAwRBTfNLy?=
 =?us-ascii?Q?u6Miq/HydU/bTKUt/skeVTlh1WUO9Tu95UhJAvIetcEKQZE+k+XHm+zY4Rdl?=
 =?us-ascii?Q?slwKLOuhkw/OE432K6YNQBs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EB715D3E58413B429F795A69D9069711@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34eacb92-0922-4092-c4cf-08d9beefef1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 10:53:16.6981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hdGsJldZ5JXsu6+8sX/GmlH7M9UAis+rOInyI3dJX7h39ZspAva8QTZRx3ShxaI22qgeadC2misNl+Zn+9ecjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3838
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 10:39:35AM +0000, Marc Zyngier wrote:
> On Tue, 14 Dec 2021 10:30:26 +0000,
> Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> >=20
> > On Tue, Dec 14, 2021 at 10:20:36AM +0000, Marc Zyngier wrote:
> > > On Tue, 14 Dec 2021 09:58:54 +0000,
> > > Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> > > >=20
> > > > Hi Marc (with a c),
> > > >=20
> > > > I wish the firmware for these SoCs was smart enough to be compatibl=
e
> > > > with the bindings that are in the kernel and provide a blob that th=
e
> > > > kernel could actually use. Some work has been started there and thi=
s is
> > > > work in progress. True, I don't know what other OF-based firmware s=
ome
> > > > other customers may use, but I trust it isn't a lot more advanced t=
han
> > > > what U-Boot currently has :)
> > > >=20
> > > > Also, the machines may have been in the wild for years, but the
> > > > ls-extirq driver was added in November 2019. So not with the
> > > > introduction of the SoC device trees themselves. That isn't so long=
 ago.
> > > >=20
> > > > As for compatibility between old kernel and new DT: I guess you'll =
hear
> > > > various opinions on this one.
> > > > https://www.spinics.net/lists/linux-mips/msg07778.html
> > > >=20
> > > > | > Are we okay with the new device tree blobs breaking the old ker=
nel?
> > > > |
> > > > | From my point of view, newer device trees are not required to wor=
k on
> > > > | older kernel, this would impose an unreasonable limitation and th=
e use
> > > > | case is very limited.
> > >=20
> > > My views are on the opposite side. DT is an ABI, full stop. If you
> > > change something, you *must* guarantee forward *and* backward
> > > compatibility. That's because:
> > >=20
> > > - you don't control how updatable the firmware is
> > >=20
> > > - people may need to revert to other versions of the kernel because
> > >   the new one is broken
> > >=20
> > > - there are plenty of DT users beyond Linux, and we are not creating
> > >   bindings for Linux only.
> > >=20
> > > You may disagree with this, but for the subsystems I maintain, this i=
s
> > > the rule I intent to stick to.
> >=20
> > That's an honorable set of guiding principles, but how do you apply the=
m
> > here? Reverting Rob's change won't fix the past, and updating the code
> > to account for one format will break the other. As for trying one
> > format, and if there's an error try the other, there may be situations
> > in which you accept invalid input as valid.
>=20
> maz@hot-poop:~/arm-platforms$ git describe --contains 869f0ec048dc --matc=
h=3Dv\*
> v5.16-rc1~125^2~19^2~16
>=20
> This patch landed in -rc1, and isn't part of any release. Just revert
> it, and no damage is done.

The revert is one of the patches posted here. It will fix the problem
short-term but it may not be enough long-term. I think Rob is working on
some sort of validation for "interrupt-map" and this is how the apparently
non-conformant property was brought to his attention. It will trigger
validation warnings that I'm afraid will be tempting for many to "fix".
Thus the rest of the patches. Maybe it's just me, but between having to
play a whack-a-mole game and snapping compatibility of old kernels with
new DT blobs, I think more time is lost with the latter.=
