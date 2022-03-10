Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB024D52E5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 21:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244735AbiCJUKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 15:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242884AbiCJUK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 15:10:26 -0500
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00046.outbound.protection.outlook.com [40.107.0.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E0713C3BB;
        Thu, 10 Mar 2022 12:09:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2itb8HUUCCb26vYjoL6YAeG26L/9hYrZN4o67fVuSN8djpawXBE0tIYebOlELhhROtzngQ4D7H5r0jCq3wZbLevR0RprKf4zwTeC+FCxazKs3fRdShHfoMK+7GwRkk93Hxu/QheCeBT/NqU8wQpbUkly9LYb8XWC6BT7FSrtZcN2FrFA4jRYOdlY93MhSl+zWLrEtk+z8m4v55bs7rBlXML9N5X8Vbh0yqmWTUIcyXzbo69Wij1Fy0pPmnVlXmnuWZas/dT2034lsjzLvCRIbPNKyfdNdyV0JoWUleJMDN0dJnmDCF4TbSRKqOUzYdnUWrpxc+UssHTpfxo8vznfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4v5fMYxsUqOZGdCdc+NCxSUOPRLXQ5mRLjxGyepyaHg=;
 b=cae7Ap+1nf77EfL40MthwNGsVJrpXPokOxAgMM4Yvjp3EwVVrcoCy0mJN7QDVa/pTFoyY5sEOpp3aAh7YU8vS+tnvvCp8jqu2hNuEvhPu5czOz1HwyJfYjcbk6cAk3HvuENaKFDpdoPs7POEx2iguhYlM8Q7bUFnEqJMVluyDyz3KeaTEPb5zdtWNlMgHrZJC/fl0+1JrPX9czF6UjnL8oioVRvYHWgoQ68vzUaBR/VIvqWH1CCmJ6iDO+umWS6wpLQBlNKpcoIxUgNpCx83tJuvHLTQ7hFX/taX5sPjJ/OvXuCVdEEVglYiPFPA/EAKTRGDM64PV4WNFByihsMcKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4v5fMYxsUqOZGdCdc+NCxSUOPRLXQ5mRLjxGyepyaHg=;
 b=ma1pPLIZjz119GMvJAchtZyVDj5uKVGxzEbfSnjD3yjZ7xYdNwHFuVs7acvRIQm6PQXg8z75kk/CDiOyPkM8pwaqT6u0iUEgOhftc2nGvhY1RLcRwniP3KMDLgpyP98cNVS5hoDkYqfh5f0wBYmb/snzPp9AIr5VXFYCtksz6Y0=
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by AM5PR04MB3233.eurprd04.prod.outlook.com (2603:10a6:206:11::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Thu, 10 Mar
 2022 20:09:20 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::ac0c:d5d:aaa9:36]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::ac0c:d5d:aaa9:36%5]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 20:09:20 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Ioana Ciornei <ioana.ciornei@nxp.com>,
        Marc Zyngier <maz@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Leo Li <leoyang.li@nxp.com>, Biwen Li <biwen.li@nxp.com>,
        "Z.Q. Hou" <zhiqiang.hou@nxp.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 devicetree] Revert "arm64: dts: freescale: Fix
 'interrupt-map' parent address cells"
Thread-Topic: [PATCH v2 devicetree] Revert "arm64: dts: freescale: Fix
 'interrupt-map' parent address cells"
Thread-Index: AQHX8PLFuZGYqGm80USNgHy7kOyTS6xNAmwAgALPWACAAXcHAIA6LOyAgC4d1wA=
Date:   Thu, 10 Mar 2022 20:09:20 +0000
Message-ID: <20220310200920.qtsw6c277yxvdinb@skbuf>
References: <20211214135852.2934670-1-vladimir.oltean@nxp.com>
 <20211231181350.qwfnrwvdfnfssdjt@skbuf>
 <c5b9cec617100b891b7fceaee8655ba8@kernel.org> <20220103113043.GA14690@dragon>
 <20220209115434.7ej5btlnbe5wbyz2@skbuf>
In-Reply-To: <20220209115434.7ej5btlnbe5wbyz2@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17a8e62f-9fc8-4c4d-0abc-08da02d1dd1f
x-ms-traffictypediagnostic: AM5PR04MB3233:EE_
x-microsoft-antispam-prvs: <AM5PR04MB3233DE9EAF753F3614C5DDD3E00B9@AM5PR04MB3233.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NAIBIYy+P+Z2D8NNubT4T5LebYplYhzKAhPg8kS03Cc9UEftXteoBAz3iC+RfiaoO2Afhom2H4qq10mXSrL991O+GJuroO4ZcqVDIG2SlDucMMmnrMOcivnhTs+VNGOuKMAWHOHd6LoLuMuGw1fMUKz9nlclJqy6G2saiDRP5VMJTuU8VcLzeYw2SoiyaJLUUNySzmdky0AJ4cPNHvL/QwcHe1hgpoBZdWxqgAobuZdoMux8j7sQOPFClKdrZPMxGWeGptLkip/qx5E3QFV+ZM0a6HxSoaMWj4ekHua71k0rXd96wr1GxbxPobpgY643rDdDJovq401bUOtlrYTIr7bMfszMfDZwzvtja4tRhuPGTjvmSkgzDKDM52iyjjxviWu9Cv8Q/j8Juq/8wg39LplgF7ogjmTx8Vj03rpY7LerlUnv6g7Gfnh/OtfX8e3OjKGCOMA+Pw8UZ7cUUSluJujmaQ/LrdDxxRfXUkyBrBgkkjcDNl3KHX/L6PY3Ggz5Dnjw4F/Uc+3c0/xHXFHBz8skd4gMdFItDoOfEw6X5KEMHMdhpyyxbfIOrwBFPCsBJUoUBTq5Q7YelPmdKQQO2efoWHoJAMuB7kYJOYuZZafvL0h3FDhod+Zaw6gf2xK/QwrO0u0/BwnjJs7ssS22G5102LifbvQJyMnpu6t/P91GkTxNcJBij4ZHkGQQhnzoAfsaXNP/tIDhiYKNs+zn505N9eDugSn2CsYuUXZWnJp5aEz+9PKNY4msnFE/iKAfODDNHwwoypJ1/jpZgcZSVWZpUGog8vMZ0kmm+ix82WdDu/xRKC5wtFzqxu9S+x0TGbSg1FUlKb5uGpZl+7xo1A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(33716001)(83380400001)(1076003)(44832011)(6486002)(5660300002)(26005)(2906002)(186003)(38100700002)(54906003)(498600001)(122000001)(4326008)(8936002)(86362001)(71200400001)(4001150100001)(38070700005)(966005)(6506007)(66556008)(66476007)(66946007)(76116006)(9686003)(6512007)(53546011)(64756008)(66446008)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bbeHOK9KcdVnZVtlC8Y/v+v0dFOMxDY3JESg3RKPqyrdFLxdbo+vkLnFaxS6?=
 =?us-ascii?Q?N00W/rPaBgVBKRhI/YX+IrncBBbPUrqhl5rRfb10WJ4N1gy++8E8+Lvg2vxx?=
 =?us-ascii?Q?byQTj8GhfLoDSJ5+PHC48p0X5Y2c5DndhVTr/JcDCt4cmFVtbobeZ2smYnC6?=
 =?us-ascii?Q?ceqsyDpcjZhSJ2L+9WTKo7BqLWQCsfRTHqCPrj7CPTUDQiGV1jyFBNXfNuUd?=
 =?us-ascii?Q?nF+wCfUn/x4oD0xX3OnKLU3NoAYU+E+4oIEt7ziYvkyz58c7ZXZ0RffsMyDl?=
 =?us-ascii?Q?U/Ob4bkHFQHo2YUFfOoSQeJhXOcHIu8YbtpxrILTtcW69SSOXZddIM0uYlfx?=
 =?us-ascii?Q?n0MFJDU6GtR/LPCjaojEckF40hSf0Xxk1CWHp/dOld8V2ldxpJvztW6HUcZa?=
 =?us-ascii?Q?FoJXiRGLYHlTaad/RTp99S/m9Fj2N1M1gmwLvyeIboBqZb/wUs6Ggkp6V6XB?=
 =?us-ascii?Q?rxBMZ2V2KZQIRDJYtQ3giyLvGnkfQH+tfqWKJ6u2+4tZJoIP12JVOg8JX387?=
 =?us-ascii?Q?27Ci4KwyNsatxwR07BL68dAiGh/inH0zBIesDyZMdb76xkq2MyZZscUJiHDv?=
 =?us-ascii?Q?ha/kuc7Ka1c9VO1o0emY70PEJjdLYqan0E0yev+Y4K1pJlUMTNwPmaC0fzRq?=
 =?us-ascii?Q?8YZn/fDyD6G9YlBnTvu52CU3VeOgBVHZDFjqhcqASvD0JrGBEnjjEHjO/+pu?=
 =?us-ascii?Q?2eREzZaUm7lNLeYd1KjpXTwpxRk5q8SzZCDJJ3mVCOO5KIuW9fafOt5TG7ZK?=
 =?us-ascii?Q?yrXkbgF+/sSq/iEVbJ5PqwTra4J9RWGPKhZtOgR5zrUIOCZB0ogbYyxdhvHs?=
 =?us-ascii?Q?BFeQqPDqdVsXzwE/ztoHOEt+L8Q1XJjVC+OJCO67iinANMLitZ6dks1jJQ9J?=
 =?us-ascii?Q?ZLNH0ZNTw8tgPcm+p0Rs7tPoABuOqbsF/qF3YFJvh6gl6WVbOP6mXdStyQCR?=
 =?us-ascii?Q?cmvwTCYuLDMtBjUPkCW/ZDnEWlbVha3xdvhsbeUBIVUQhOkAJalycwDvqCLq?=
 =?us-ascii?Q?X41pLYsgjm55HVZAC/wRBxdUf5NtE6tg040JPH+FUjjAbQPaIOGjajdxVdNU?=
 =?us-ascii?Q?Ur2TN04o7pHVE+Uy4slu5B+1A1cUUl0bh1njhxPBwJPXx0wu7X6D1F9gkYhh?=
 =?us-ascii?Q?FgS/zBtM1FSI4e1jDdZLhHYHlUXWvpa0nwAyuJC8yC0JRnnZ0liUcVgZMEeT?=
 =?us-ascii?Q?Szzb33NB6et6ahn3eSPRrY+z47SBI1aunXJkYhYmTCkaSEk5R8lrcerzg4cQ?=
 =?us-ascii?Q?n19s63+f7HN05qnRXGBhK5Kt498UtH95pgWAszEA+ygB6oxnwtJFdMT9li2i?=
 =?us-ascii?Q?PZnbe9lY+gqh+ActGjRObfTHUz4ZIKHe3rSf6KIN7iQpCCF0+U40OZvLwFhH?=
 =?us-ascii?Q?90tZQYBUv5c9a6Ftgpn1sFomd4MtUjKzRedS0kj+GhKpQ2RuKORpkfI4t6u+?=
 =?us-ascii?Q?0zDKWuA1IOAIZPBzOita32pbA+LiMbiaIYmGaF5UkYrjN/ZSos9vYqfgOHTI?=
 =?us-ascii?Q?l2ilvFeYzMKnQn6/uKTYQCn2cA55MUPmhEH1zLlTYRmJTlTxi7dbs4RCIuQR?=
 =?us-ascii?Q?uNj93PNVgR4unxWtlKqayNVGGua4nzhBWoG89y1xCgy9O/gKxXCIg6xS4tan?=
 =?us-ascii?Q?bjjFKsckWD0Xnfvi5m6Ub0c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <05D6A30CDAB97C40A24E2C7692A5A093@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17a8e62f-9fc8-4c4d-0abc-08da02d1dd1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 20:09:20.6003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /aC6cbAvD1bHi+MbevhY86sDI30TS/gj4f4gxKIB0NZA3FDnfp1H9znShlmIApPmwBxROX2LAj2N9d7kpS7jeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3233
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,

On Wed, Feb 09, 2022 at 11:54:35AM +0000, Ioana Ciornei wrote:
> On Mon, Jan 03, 2022 at 07:30:44PM +0800, Shawn Guo wrote:
> > On Sun, Jan 02, 2022 at 01:08:28PM +0000, Marc Zyngier wrote:
> > > On 2021-12-31 18:13, Vladimir Oltean wrote:
> > > > Hello,
> > > >=20
> > > > On Tue, Dec 14, 2021 at 03:58:52PM +0200, Vladimir Oltean wrote:
> > > > > This reverts commit 869f0ec048dc8fd88c0b2003373bd985795179fb. Tha=
t
> > > > > updated the expected device tree binding format for the ls-extirq
> > > > > driver, without also updating the parsing code (ls_extirq_parse_m=
ap)
> > > > > to the new format.
> > > > >=20
> > > > > The context is that the ls-extirq driver uses the standard
> > > > > "interrupt-map" OF property in a non-standard way, as suggested b=
y
> > > > > Rob Herring during review:
> > > > > https://lore.kernel.org/lkml/20190927161118.GA19333@bogus/
> > > > >=20
> > > > > This has turned out to be problematic, as Marc Zyngier discovered
> > > > > through commit 041284181226 ("of/irq: Allow matching of an
> > > > > interrupt-map
> > > > > local to an interrupt controller"), later fixed through commit
> > > > > de4adddcbcc2 ("of/irq: Add a quirk for controllers with their own
> > > > > definition of interrupt-map"). Marc's position, expressed on mult=
iple
> > > > > opportunities, is that:
> > > > >=20
> > > > > (a) [ making private use of the reserved "interrupt-map" name in =
a
> > > > >     driver ] "is wrong, by the very letter of what an interrupt-m=
ap
> > > > >     means. If the interrupt map points to an interrupt controller=
,
> > > > >     that's the target for the interrupt."
> > > > > https://lore.kernel.org/lkml/87k0g8jlmg.wl-maz@kernel.org/
> > > > >=20
> > > > > (b) [ updating the driver's bindings to accept a non-reserved nam=
e for
> > > > >     this property, as an alternative, is ] "is totally pointless.
> > > > > These
> > > > >     machines have been in the wild for years, and existing DTs wi=
ll be
> > > > >     there *forever*."
> > > > > https://lore.kernel.org/lkml/87ilvrk1r0.wl-maz@kernel.org/
> > > > >=20
> > > > > Considering the above, the Linux kernel has quirks in place to de=
al
> > > > > with
> > > > > the ls-extirq's non-standard use of the "interrupt-map". These qu=
irks
> > > > > may be needed in other operating systems that consume this device
> > > > > tree,
> > > > > yet this is seen as the only viable solution.
> > > > >=20
> > > > > Therefore, the premise of the patch being reverted here is invali=
d.
> > > > > It doesn't matter whether the driver, in its non-standard use of =
the
> > > > > property, complies to the standard format or not, since this prop=
erty
> > > > > isn't expected to be used for interrupt translation by the core.
> > > > >=20
> > > > > This change restores LS1088A, LS2088A/LS2085A and LX2160A to thei=
r
> > > > > previous bindings, which allows these systems to continue to use
> > > > > external interrupt lines with the correct polarity.
> > > > >=20
> > > > > Fixes: 869f0ec048dc ("arm64: dts: freescale: Fix 'interrupt-map'
> > > > > parent address cells")
> > > > > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> > > > > ---
> > > > > v1->v2: remove the other 9 patches that rename "interrupt-map" to
> > > > >         "fsl,extirq-map", at Marc's suggestion.
> > > >=20
> > > > Could this patch be considered for merging in v5.16? The problem is
> > > > going to be quite a bit more severe and tricky to fix otherwise. Th=
anks.
> > >=20
> > > FWIW:
> > >=20
> > > Acked-by: Marc Zyngier <maz@kernel.org>
> > >=20
> > > Rob, Shawn, can you please queue this as an urgent fix for 5.16?
> >=20
> > I would rather leave this to Rob, as I haven't heard anything from him
> > on this reverting (on his commit).
> >=20
>=20
> Could this patch be queued up as a fix for v5.16 and v5.17?
>=20
> Ioana

This is a reminder that interrupts through the fsl-extirq driver are
still broken. Not to mention that we aren't even in the same release
cycle as the patch that introduced the breakage anymore, so broken
device trees (or "syntactically correct", depending on how you wish to
see it) have already started circulating. Do you have a better
suggestion to fix this?=
