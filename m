Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25114E6781
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 18:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352134AbiCXRMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 13:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236380AbiCXRMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 13:12:17 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50058.outbound.protection.outlook.com [40.107.5.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27439B0D3F;
        Thu, 24 Mar 2022 10:10:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=knzpXPBDQfM+TsdyHrOyOtAMYzIptM+GYLRgiXTDQHnbdwlSevU6Ol09K1DeWqHCMC2Arfsx5CsiT+8HHa1qDPc4eZQyj0sFqiZc632TBm+dF9TbHQc5IybYccpATUACHRcc1tI4FDS1fUU5MXZRJEe4Mzjy1R3540xdrQ1u1BRV7xPozpDIV/GFm7sM+jPShYEmYPQGZjD+rnFUOVgR1xXfxy4JEN3vQgwyXkQ21KP8OnGzQ4nBRv26m8m1LdCofs8dsEvRQBo9WGG5lpXmlLQu0u+/NYqZAxXeF5qrt1gQVJJFJuVOj4kYhrH+ZgjEl2pLVHf2cPdUpGCUdh66pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WsoT3HSJPoRsVwC1bBp1HaTco/IZrUMAp8z/OQYoq6E=;
 b=JmFE4fTAE2JJVtPLubt3Gx37z3+oHeP20xAEvIVmrxcOKlbvsZbhWMi1vdEJ0yu9qmC4w5CXoOXg4Vjlb0TYUwOJ41P15qn2Akdpg6PJAeYs71+zRkpmWok/qHYEHyPpoB7i5qLo4AAONUDDNMPuBlJ5E6cHptrJEhZKD15nGSNfq7wSICPG0Z0HoHIH1G6g7ODch6senfVg/dCOejDps2XyiY+mlDrVYBIQQ25euYXz2OhKcrDv6QpS8HOQAZH3CXtbwf8PIKDw/Mi5V8D+d6+CCN0UKJjhtFWMkbdi3rrYh6dFUGv/eGY/MEA3Z62cCaRMMSfTRx1UQEQz7RE7jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WsoT3HSJPoRsVwC1bBp1HaTco/IZrUMAp8z/OQYoq6E=;
 b=m1dV58i5uOw8IM9dmPfd4CRY7iPN0/dnWEqhxfUiaBQOiWR6UGiAa6Ti9/gIQWMjX6KPMH8HcQicRRe1pKOit4PsmFo/B+VJaqYZeDv3b4Erp7fjNrJ67J9y8d2TdZrMiK3CyOjGhXOo30Ddm0PlRv3irCGm3uKKK5goyUe/Qhk=
Received: from AM0PR04MB5121.eurprd04.prod.outlook.com (2603:10a6:208:c1::16)
 by PAXPR04MB8943.eurprd04.prod.outlook.com (2603:10a6:102:20e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Thu, 24 Mar
 2022 17:10:42 +0000
Received: from AM0PR04MB5121.eurprd04.prod.outlook.com
 ([fe80::4502:5fbf:8bf2:b7bd]) by AM0PR04MB5121.eurprd04.prod.outlook.com
 ([fe80::4502:5fbf:8bf2:b7bd%7]) with mapi id 15.20.5102.018; Thu, 24 Mar 2022
 17:10:42 +0000
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
Thread-Index: AQHX8ItO3xtQxxPJV0yONti9mp5846wxrpCAgAASv4CAAAYSAICdm7aA
Date:   Thu, 24 Mar 2022 17:10:42 +0000
Message-ID: <20220324171041.t5yoocinj6gizcc7@skbuf>
References: <20211214013800.2703568-1-vladimir.oltean@nxp.com>
 <87ilvrk1r0.wl-maz@kernel.org> <20211214095853.4emzycaxkuqr4tun@skbuf>
 <87czlzjxmz.wl-maz@kernel.org>
In-Reply-To: <87czlzjxmz.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 70e93d56-a54c-4be9-5847-08da0db93a5c
x-ms-traffictypediagnostic: PAXPR04MB8943:EE_
x-microsoft-antispam-prvs: <PAXPR04MB894331948C92449B6A1AAC97E0199@PAXPR04MB8943.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TiWUBkxrujNdf8QJkA2WTRgT7YuefEOQYV9LuzWZHBbC1XErfoktNFhPvAXXpdjFZbYvxD3Ma7bvKd7RjfFdksaiAnIziK/DRjw9OKKcoMd4PfpRGXg9rPFuMnkzrMoetjGm1UaF6K6tW/HwDBmu78E7ZZNIemtcMXP5OY28PDEf0i/uXgSZUsyd26rsmQNOy5UMwcXBJQc4afECTHmil6djRLQ8uJoQquQbWi0CQBpSSuJsl4iGPJJWNf6kSzQUC5S+hZzgLScftQqQQAHpYx7me4pQfp1Kkq8y4Jm+etSBb4bQRbza9ApW2Iz9mC9xljR1Hnn080FmEWTl2Yxz6j/9OBBFVM8CERywX3/+kYda8AIcZTyiSoeA10gIxSDnM9Y6KZv+cZWT+qrjOE+Re+RzDOfJlIRyeEztx3hj9n99UZt9YzglHj5F3kbTOiNJbXCNc4wsR/495XLQm11XLvL/fTt8aIru8slWYgazr9HaSa70YC/+ZoxRGCOfb03vhtsA/mbSBOq4dB9vhYfbTesiNXsvJcfElMw/VMXyPHGUplo2Ym+B1MHAa9n217iBXqZzVcdEQmmi4hdCYNWWLtgdeAufxAAQIm/eyDRMKYYDXAjEvntf9jjCVshLxHpmf1g5+jr+gMUem71RBEU+jWDHxqrYKZZGLIzwxsXtgTSwLEsJeg3xi+4hiZDhPpcoRZY4LMdFFmHLOHFUYQ1jAz/Zjzgn39XRZnVBmKrG14SP8rFUUFfeW95vS8QnBpN8GT+vZaGHFC5W9iz3h5LgR3yWOoe66tuF3v3PvnQzZyQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5121.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(54906003)(83380400001)(71200400001)(38100700002)(6916009)(122000001)(33716001)(6506007)(8936002)(91956017)(4326008)(1076003)(76116006)(44832011)(9686003)(6512007)(8676002)(66556008)(64756008)(66446008)(66946007)(66476007)(86362001)(2906002)(5660300002)(38070700005)(508600001)(186003)(26005)(316002)(966005)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m2ENI57NJVNnVxGVY72BqCITUSc+uzZ73PF2DVKGVu+1vq61uvBG9uZ+Y32b?=
 =?us-ascii?Q?T0NZM1kM/LucsRu1QvA5INu/BOkYV/jw4HmdfGPsClOBgzxeDmG1hTSLCGJH?=
 =?us-ascii?Q?IisDDq5bAunOqOBMsqbQnHdzHx2yv1s5tNRCaW/Y4fnVryQ0dCtESQ/LtXrn?=
 =?us-ascii?Q?I+UPDoeW8AnbM7GRNaQ0d1zhqeLQ+lxJ8xtPg/pgVm61LloAi6fu0ZkoG0pj?=
 =?us-ascii?Q?8HKSa879TXGxB12dROj3Iwv0qSEp+yxVleWax3rNlWuaCi5Ojp3cHPGhwLsX?=
 =?us-ascii?Q?UE/GEf94I5HXJsBbArNxvEMHnnevpKi0dC+AQlUn53yNwlY/CUBPx1EG/rcC?=
 =?us-ascii?Q?G0BTQDJ0qqglAVNCBorMwOiz+Manf7LJicwsUOIXp8UcF7ZfG01KAhFePNdX?=
 =?us-ascii?Q?Zi+92lKkHaEkMo21Fr2PkKPTHDV1RAYZF6I+9KfwvmExj/2g78oIibZ5wlzq?=
 =?us-ascii?Q?zWaMptLEAlMVxtM/qGiO+ptynmzWTUM97mnjp4R9m/ZdgbnkH550gnNxbeHk?=
 =?us-ascii?Q?PrbVaH099rwxJi/GP9bO3xijpnKN0yWXJJOK7KikBeQ0a39gJD5P8YsmHXLp?=
 =?us-ascii?Q?Vkn04y5H76NA7NFZCxMdeQhI5XNofqOEvGOCaxZr4ZbL7YGblLJe/al593yF?=
 =?us-ascii?Q?yro3otc/ZTnOO1hwz4943wV3vaUAX/JFExvg00rJ0UKtgLgyHb0oRgyylNNH?=
 =?us-ascii?Q?DmtES9/JcI8osdp9LxVqZx9PUw3RKxkzIRPdYreO6Dsh8hq3shK7CKWQ4v3f?=
 =?us-ascii?Q?gcyKBhKpity2xM+sfNb7Fu9kQyp2sHIZZMN0NFTWR23xDayE0z9C5AFuk1r1?=
 =?us-ascii?Q?gdIE4oqNn4WiGVnH+rAmEs6slvCNe4RygPShh3SdQoh7ZKzjTXF1fjWb/UYb?=
 =?us-ascii?Q?lfQtCGs4DKbBMznoBoA1qvu2ZmZLSAcS+NaamiLTm/TVuDJC0IFjNsN1O8+C?=
 =?us-ascii?Q?Jgo+CQmWH7FxD6An7mjXhZhGFPgw4ls9cYWy/UuAHoTl2x3RB7A6OCVK13Lq?=
 =?us-ascii?Q?rmZuiZfbv1KLlnFaDdpLbPj5gk6HhqdCyjwNkEGymuiRNsL7x02yGlyCOsE9?=
 =?us-ascii?Q?y+bWhvx0d+PeWBQVtkKddxREdWSHDlNuIBo5DTaMR9SgiJTHHA8Ion3ZKjhL?=
 =?us-ascii?Q?PrRzTWXnl8ejGv5w5/LPLSft25vLgqv+bl+FnI+1/BbKVCMiP2tBHp2cCfzt?=
 =?us-ascii?Q?qvKO0sR7vV9+8JYLZltL2QPdlnPr4pjNxcdr3Jc4XkW9QSxGuYoIue7xTXPK?=
 =?us-ascii?Q?BpjYhMDa8ulupKjiEuisy39b++r8B8C/CET7Q7o8kDjm/qzrSTLGHWqAHD9x?=
 =?us-ascii?Q?IFK73WUS/AOXkWJYWjvACtUuFCFok/pCfsXNixIyfjmST7v8nikG84TQ8S70?=
 =?us-ascii?Q?QT4d1medeo6pLqDOvNKsV+JN5Cml2AvygjRib2yQv20rjhlR6f79TatOzPfB?=
 =?us-ascii?Q?6OQWD+uk6dBfK4GTG8X/aGW/WGGqIkWDxETlQ3zDHpBRgX6pZ7IAbS1ZBfg6?=
 =?us-ascii?Q?kQPUV4ZsOsr2KC1hz79WFGtnm6KhdXCtX/Dgp8osnT4q5jIQG56e2qwTXef6?=
 =?us-ascii?Q?Ost90ZTCEJQyJmy87p7S6BEF/JyoToAs+QQRs0VJrVh5k600cdkJrZxECWle?=
 =?us-ascii?Q?iBGJ8W7uuMrfeNiT7Ud9xkL6s5YVJE7CoGUlQOeDLkma80Ny4OmjRHVfTDwk?=
 =?us-ascii?Q?MmMvJLdA5qRB0TL8KqoFSs4OV7OgCvvxNVacFIIdkB/JM1UphOk94T0P15dX?=
 =?us-ascii?Q?5H31KCDtCP1VAGxWFUjUB3wwsOOnh58=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6DBB7331E2362343BAA66A3CE2CCC873@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5121.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e93d56-a54c-4be9-5847-08da0db93a5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2022 17:10:42.4806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M6Lcui9FPuRH2KCENrejI/RdKp3lfY6FFaA5/R2/lwPSbPa94LbcZ0nvrEBwftM5X9l7NoGHm0w+ua4zplOWBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8943
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marc,

On Tue, Dec 14, 2021 at 10:20:36AM +0000, Marc Zyngier wrote:
> On Tue, 14 Dec 2021 09:58:54 +0000,
> Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> >=20
> > Hi Marc (with a c),
> >=20
> > I wish the firmware for these SoCs was smart enough to be compatible
> > with the bindings that are in the kernel and provide a blob that the
> > kernel could actually use. Some work has been started there and this is
> > work in progress. True, I don't know what other OF-based firmware some
> > other customers may use, but I trust it isn't a lot more advanced than
> > what U-Boot currently has :)
> >=20
> > Also, the machines may have been in the wild for years, but the
> > ls-extirq driver was added in November 2019. So not with the
> > introduction of the SoC device trees themselves. That isn't so long ago=
.
> >=20
> > As for compatibility between old kernel and new DT: I guess you'll hear
> > various opinions on this one.
> > https://www.spinics.net/lists/linux-mips/msg07778.html
> >=20
> > | > Are we okay with the new device tree blobs breaking the old kernel?
> > |
> > | From my point of view, newer device trees are not required to work on
> > | older kernel, this would impose an unreasonable limitation and the us=
e
> > | case is very limited.
>=20
> My views are on the opposite side. DT is an ABI, full stop. If you
> change something, you *must* guarantee forward *and* backward
> compatibility. That's because:
>=20
> - you don't control how updatable the firmware is
>=20
> - people may need to revert to other versions of the kernel because
>   the new one is broken
>=20
> - there are plenty of DT users beyond Linux, and we are not creating
>   bindings for Linux only.
>=20
> You may disagree with this, but for the subsystems I maintain, this is
> the rule I intent to stick to.
>=20
> 	M.
>=20
> --=20
> Without deviation from the norm, progress is not possible.

I was just debugging an interesting issue with an old kernel not working
with a new DT blob, and after figuring out what the problem was (is),
I remembered this message and I'm curious what you have to say about it.

I have this DT layout:

	ethernet-phy@1 {
		reg =3D <0x1>;
		interrupts-extended =3D <&extirq 2 IRQ_TYPE_LEVEL_LOW>;
	};

	extirq: interrupt-controller@1ac {
		compatible =3D "fsl,ls1021a-extirq";
		<bla bla>
	};

I booted the new DT blob (which has "interrupts-extended") on a kernel
where the ls-extirq driver did not exist. This had the result of
of_mdiobus_phy_device_register() -> of_irq_get() returning -EPROBE_DEFER
forever and ever. So the PHY driver in turn never probed, and Ethernet
was broken. So I had to delete the interrupts OF property to let the PHY
at least work in poll mode.

What went wrong here in your opinion?=
