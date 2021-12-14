Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFE30473FFF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 10:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbhLNJ66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 04:58:58 -0500
Received: from mail-eopbgr60079.outbound.protection.outlook.com ([40.107.6.79]:28226
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229550AbhLNJ64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 04:58:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lx/LwqqWeqPYatWJEnhCwTQL51IoRbLc4xHnQF56C6Kw/MIwPk7VvYGEDS1DTq1pH1iXGmnjQIAavwfTAokiLdr2+qmrrV+YnK2HCp+3dATpmhVEQOes7hbCVZBxgb7rZ4jmnSM9U+eDuzHanZJmVukZ/1f4ueEfpXnGJ0/b5voxFerjFxu1s9PIFaGN35dC97DevrkRc+m2daWRKXhfCQsupEvSyvU99tjYHWXSOpFY/sUCMabCNzKxwe2HvrLxAmP0L+SHybnymFaxTjGCd6owKwOUO/VrwZzolrJoGC371dbT6ln8x14vf150h/3cKHrJDWCkCXOt4IhpY6lBuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUVyYLZNVeiwtAEGqHpehcWYj+WVGb7a14gf1lBcwo8=;
 b=fTUyToMNB+3KEBc6l10lhUatre37MzTzU9qVtK8D/j1j1p5zOBWl+Ym2mRhA6AyQ7EOwwlyO4bVNJjU7mAW3o+sjPgZzrUVtpVBZDVxA/A5sy/OZ/90v1hVhMr8rfdZcGfMOCkFZPvZYpiIib8FjgWUJzALwAJLXMtNBc4XRA7xGV+iHQEKLfTTfFQEZTstlN3162OtYvbljFdA1XjoQ/xygKBxNk4cGZBUUWZ5YS7n3+aiLQpzQXXpa7zTcB5ysRyyci8wbj1i0lep17v18P5L+KR90YwnRorWcR65ZRpdl0Utt7rBX5FhA74CKqwNFvs/UEXllCmZ2N8ucNLN8hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUVyYLZNVeiwtAEGqHpehcWYj+WVGb7a14gf1lBcwo8=;
 b=Ziga/V+J7zUBtkllj9uutD/kLDN6jmRYR6BcI0oMAy1V6CexfnTWTgddK3HjPA+N/Pn3AYzrAxK8V3kpW/HDokIlez4+1pDzK9+oVixzFiW3CIsL63ND4Y3dMHlMOVIUj6MzfohkdRmYuF5Lqug3qGe2VKcAL6K5F0Iqq1MEFxU=
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by VE1PR04MB7341.eurprd04.prod.outlook.com (2603:10a6:800:1a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 14 Dec
 2021 09:58:54 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::c84:1f0b:cc79:9226]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::c84:1f0b:cc79:9226%3]) with mapi id 15.20.4755.028; Tue, 14 Dec 2021
 09:58:54 +0000
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
Thread-Index: AQHX8ItO3xtQxxPJV0yONti9mp5846wxrpCAgAASv4A=
Date:   Tue, 14 Dec 2021 09:58:54 +0000
Message-ID: <20211214095853.4emzycaxkuqr4tun@skbuf>
References: <20211214013800.2703568-1-vladimir.oltean@nxp.com>
 <87ilvrk1r0.wl-maz@kernel.org>
In-Reply-To: <87ilvrk1r0.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 81f4399c-a4fd-432b-db92-08d9bee85695
x-ms-traffictypediagnostic: VE1PR04MB7341:EE_
x-microsoft-antispam-prvs: <VE1PR04MB73415B90CDCB8936E0F6AD81E0759@VE1PR04MB7341.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:923;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NJ8M4FZ3xH5jtjQmCnT/cZeOL3HrbGsyNMIjSvu656PbLn89wvclEnFdq6IVVJtlyYURTeM8KLRszBDxTP4isfWCP9yZOgFL4GxR74HbSBUCUmI1y+U8CG+D3GQzh2IRM5ggEoPQwJURJndUj9cCYy7A3Ga5eLVjr3GoJOpAORw9Jk0V+CE/IA9xbWXX0NTwOw6b0f33jNX6+ZIk3YNB31+5NPelNm8SBT9soqj4iwP2NVzuzOU+ZpDC4m4IZ0xrlwNZhrhhVIq4YrMLXQ2SuX8DYRQGNk5ZIUB7V2qRgrxmVtTl4ubWfXkDnIvVGSK1I+icgQz/yx7QjxLd8+tCck/BDjZ+u9tbMlpfS4I2EPB27/HdlCeRqSH9aylfhfninvxje3l7XxJM/XpeX2BtZXoztS+Z+HXKmdNMFAUx1jJVZ5vA6Y/+16KIOA1emK/5JL20ao852nbfs3RsQFQO+JhIk+/wlRLUq+xssTcvyUoBNN2pE/8bDvrVZvW6NYELhLUMg2Lz8ciYIz0lvnfIaEMRmIs/cZGD2R4OYJk7xmmSj6SJLQwTKI/vcNW5s0TxsmOHEc/aOQHPgVhI3ZkOTac+U3/Cz5GBjFYWtSUANVfqpWANBMdAD5RYZWssJOozSAweE3UW+eNpoU5OsAAmFnzL2E49TiMEo4txx+bx3PqT53naiwHlRTNSad8tK8oqvmpJe7oyU5aJ1JwE3ttphK2KZZcSAbNci9Sn3zwDNSRbMDDGE7mSh6vn5IXuQ7UJm6XdESVX7sSzERTKaqE8t0vGoLHRgIVTiQfptnFvvFY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(316002)(83380400001)(6506007)(8936002)(71200400001)(8676002)(186003)(38100700002)(54906003)(6486002)(6512007)(26005)(38070700005)(91956017)(122000001)(2906002)(66476007)(44832011)(66556008)(66446008)(66946007)(5660300002)(508600001)(9686003)(33716001)(4326008)(966005)(76116006)(6916009)(86362001)(1076003)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3hMrxHlxuBrGzQPo/XEgs/KAjENq7IpcpnC+77eIp9UZc5hZNJ5ETLfIPBvk?=
 =?us-ascii?Q?KkCbic+0bM3htkh4F8mSKoH3MxysYPmAK5vDhsbZglCdUYu5RQEpYVNs7VLk?=
 =?us-ascii?Q?WP7i32tJiR0kNpjFf4SfK9leXAO/c8teLUgZjMm8i7kMWrU3lL1rWm2TA6ov?=
 =?us-ascii?Q?euWF2KRfueqNXaxR0xawzuJLC76bTa2t2AcRyI/PwQx5TMFaZZmTUimuJXX5?=
 =?us-ascii?Q?BgxZNfucxwayK++ga20D9KK8i7i2RsdXHMpmVRa3CoO1Puv9fiw19UeMEQYk?=
 =?us-ascii?Q?uQpw93w4XxQz0wj+DnxygOPeaJlfRIbrZUfiPunLOd8BZvIx9BLVKOk6ukn8?=
 =?us-ascii?Q?LTeztEXIvp0vumKglPWVveVRhTz2WTkxnWxsh6DX3HupQmADg/dfAfGOLGx9?=
 =?us-ascii?Q?TD3aaf1ff2xJFBcqNO/DuzhQcvg2RzrJPalYFnHMRy6pQG+b5/2841zkGqlE?=
 =?us-ascii?Q?zi2ugschPCnD7W7WXh4KsExZDzDG8EZWklJXPLf6xzJgWBUxXbcU3MxjU4Xy?=
 =?us-ascii?Q?DOMFj1eFgW44UWSJbWWbrwRzKjHRW1zPq0fqw5wyMpf1TxdbxvvfPQjA3da9?=
 =?us-ascii?Q?hHhrAoNO3ch5CO4T5fkfAsajH8pRKjV3hGn8drN9i8T2bYXfyK+KYyX307Uw?=
 =?us-ascii?Q?WwgAfeblyMa4m/09mI9KCtWFsQ57iH76D81wGfrl2HycTuJsHPUR1jRMuQt5?=
 =?us-ascii?Q?NX4cySfICmiK3U5GB8sIREIr2zT/eCrmkytc4HmLt2rRhC5BwX0b2u7nQ2Ig?=
 =?us-ascii?Q?2YrxQkgKlrmturno1lIMi1Ya50OJM8PO+ICzubGeKF2g6Q8f7GAj5E9rdfS2?=
 =?us-ascii?Q?K5Ey5a/RkILscF5pe5nUMWAZvr39kGIweANTSWHaTJBUU2x5BceJR/QM3vgY?=
 =?us-ascii?Q?mNmizOIWnp0Ricr2Fl1pgi8Tt/GI2D1SE5xNgnmQ26KC7sMeHT36otH3FF8L?=
 =?us-ascii?Q?clbSTX+6Qg12fU1SImfj33/us9T310N8N9gbDPR2f4c+SQaJtnev3sPxPRwN?=
 =?us-ascii?Q?h8jxj2N5jlo7KoBFOFoWUMQtWh8DaLWHIXcNxhF8w8eO48ln9gZv8p6E+/bo?=
 =?us-ascii?Q?RS2dEu67K0vJiCH+LIJJ7VrUOq3Lh7o/JtG/sA1/ODWMzEZaYty1XWCHUuUu?=
 =?us-ascii?Q?bSg3gr9y/k9zeU8fyE/04ugVMI69Ik4zw55oeSX33N2YUDbSsrnHGyG25ilp?=
 =?us-ascii?Q?N78K/yA1I1xzfZYlOgiUsk2zJ0pgGNmNe6RRbCB0pfSFWg1pAnc7bj3Kjrud?=
 =?us-ascii?Q?XRLaeih3O3eoxg8TyZDPtRbmh/Zseeca/JuEhQCCvvzot4UiFa8CvLtnpdSa?=
 =?us-ascii?Q?C/kL4eWj3xTVrZNnswLrl12SqorDQ+cnHRCBixlxhVl2cT9cVkm6qLyE1V3p?=
 =?us-ascii?Q?Wu46AClxmNGb3o3IShEu4tpaqa0MNx3xWDjLT6Rwb0slhXXhaT0aJ8UAz4ZX?=
 =?us-ascii?Q?3NUsX4KLrsz/siThgRvggz6BDpcAKw0h7hts32a4Rfl+zRdZiHKqqqpjyePt?=
 =?us-ascii?Q?iMFUJpuRaLCosPb7UwJkeS0HTlTGPR9/Lplfj/zYNORkt7W1Ajdbz41APXUd?=
 =?us-ascii?Q?cmgCrIG22gMHdOOrf5QATs08WXFJvRK6Otw39TkzCQzH6tNXgxpv7jFNb19w?=
 =?us-ascii?Q?LELPl6gsE4UePLv1mezd3TM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1366F924C44B884B843849D86D5677DF@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f4399c-a4fd-432b-db92-08d9bee85695
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 09:58:54.3050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U97S1/gIcQvSJJ1hITm30Qw4C1bTvA081J2MR35+720zlJORFWf8uw9ZZ7HH3YXSEBZYuhMsco1J2bcJk+Ml8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7341
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc (with a c),

On Tue, Dec 14, 2021 at 08:51:47AM +0000, Marc Zyngier wrote:
> On Tue, 14 Dec 2021 01:37:50 +0000,
> Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> >=20
> > Currently the ls-extirq driver's use of the "interrupt-map" property is
> > double-broken:
> > - once by Rob Herring's commit 869f0ec048dc ("arm64: dts: freescale: Fi=
x
> >   'interrupt-map' parent address cells")
> > - twice by Marc Zyngier's commit 041284181226 ("of/irq: Allow matching
> >   of an interrupt-map local to an interrupt controller"), later revised=
,
> >   not very elegantly, through commit de4adddcbcc2 ("of/irq: Add a quirk
>=20
> Elegance is, I'm afraid to say, bloody overrated when dealing with
> this sort of crap.
>=20
>=20
> >   for controllers with their own definition of interrupt-map"). So this
> >   part works but we're on an offender list.
>=20
> Define 'part works'. Either it does, or it doesn't. There is no middle
> ground here.

"Part" is the subject, "works" is the predicate. It is a part of a
larger set of changes that now works after some breakage.

> >=20
> > Mark suggests that the problem may lie with the ls-extirq driver, and
> > its interpretation of the "interrupt-map" property, to be exact.
>=20
> s/Mark/Marc/, unless you are talking about someone else (who?).

Twas a typo, my hand must have slipped. This will not happen again.

> > This set of changes attempts to make the problem smaller by using a
> > vendor-specific name for the property, and reverts Rob's patch because
> > similarity with "interrupt-map" isn't actually a desirable feature afte=
r
> > all, it seems.
> >=20
> > Vladimir Oltean (10):
> >   irqchip/ls-extirq: rename "interrupt-map" OF property to
> >     "fsl,extirq-map"
> >   Revert "arm64: dts: freescale: Fix 'interrupt-map' parent address
> >     cells"
> >   dt-bindings: ls-extirq: replace "interrupt-map" documentation with
> >     "fsl,extirq-map"
> >   arm64: dts: ls1043a: rename the "interrupt-map" of the extirq node to
> >     "fsl,extirq-map"
> >   arm64: dts: ls1046a: rename the "interrupt-map" of the extirq node to
> >     "fsl,extirq-map"
> >   arm64: dts: ls1088a: rename the "interrupt-map" of the extirq node to
> >     "fsl,extirq-map"
> >   arm64: dts: ls208xa: rename the "interrupt-map" of the extirq node to
> >     "fsl,extirq-map"
> >   arm64: dts: lx2160a: rename the "interrupt-map" of the extirq node to
> >     "fsl,extirq-map"
> >   ARM: dts: ls1021a: rename the "interrupt-map" of the extirq node to
> >     "fsl,extirq-map"
> >   dt-bindings: ls-extirq: add a YAML schema for the validator
> >=20
> >  .../interrupt-controller/fsl,ls-extirq.txt    |  53 ---------
> >  .../interrupt-controller/fsl,ls-extirq.yaml   | 110 ++++++++++++++++++
> >  arch/arm/boot/dts/ls1021a.dtsi                |   3 +-
> >  .../arm64/boot/dts/freescale/fsl-ls1043a.dtsi |   3 +-
> >  .../arm64/boot/dts/freescale/fsl-ls1046a.dtsi |   3 +-
> >  .../arm64/boot/dts/freescale/fsl-ls1088a.dtsi |  27 +++--
> >  .../arm64/boot/dts/freescale/fsl-ls208xa.dtsi |  27 +++--
> >  .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi |  27 +++--
> >  drivers/irqchip/irq-ls-extirq.c               |  12 +-
> >  9 files changed, 161 insertions(+), 104 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/interrupt-control=
ler/fsl,ls-extirq.txt
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-control=
ler/fsl,ls-extirq.yaml
>=20
> This is totally pointless. These machines have been in the wild for
> years, and existing DTs will be there *forever*. The very notion of
> 'backporting' DT changes is totally ludicrous when it is some firmware
> (ATF, u-boot, or something else *that isn't under your control*) that
> provides the DT. It also breaks backward compatibility (old kernel
> with new DT), which is just as important. Why do you think I went the
> elegance-deprived route and added a quirk?

I wish the firmware for these SoCs was smart enough to be compatible
with the bindings that are in the kernel and provide a blob that the
kernel could actually use. Some work has been started there and this is
work in progress. True, I don't know what other OF-based firmware some
other customers may use, but I trust it isn't a lot more advanced than
what U-Boot currently has :)

Also, the machines may have been in the wild for years, but the
ls-extirq driver was added in November 2019. So not with the
introduction of the SoC device trees themselves. That isn't so long ago.

As for compatibility between old kernel and new DT: I guess you'll hear
various opinions on this one.
https://www.spinics.net/lists/linux-mips/msg07778.html

| > Are we okay with the new device tree blobs breaking the old kernel?
|
| From my point of view, newer device trees are not required to work on
| older kernel, this would impose an unreasonable limitation and the use
| case is very limited.

Sadly we're at a point where we cannot have software any longer that
works with all device trees in circulation, after Rob's change, because
the ls-extirq driver won't know what is the expected correct length of
an "interrupt-map"/"fsl,extirq-map"/whatever-you-want-to-call-it specifier.

And even with the revert, the argument you've brought to the table still
holds: any kernel running on a device tree with Rob's change will stay
broken no matter what we do. I'd like to take a more constructive
approach and see what we can do going forward (in the direction of the
arrow of time, in case that's not clear), at least.

> So no, I'm not taking the irqchip changes, as most of this churn
> serves no purpose. The revert of 869f0ec048dc is the only thing that
> makes some sense.

The devicetree changes were for Shawn to pick up anyway. But I posted
the entire series as RFC to gather comments. Other opinions still welcome.=
