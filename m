Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB0D48257E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 19:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhLaSNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 13:13:55 -0500
Received: from mail-am6eur05on2083.outbound.protection.outlook.com ([40.107.22.83]:20732
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229583AbhLaSNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 13:13:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=giDAgVFKISs32w7dD1wP947dsBsBjkTljdfRf+BKucip5Kv36s4EmLb05DGaUHPIvjLELWI/kfJkgWbT28vz7avoCxKBbUH5iYSX4ozZTA7x6Y8Lp0tcuaLAempamtfaSgxIpa/973KXkFlUN7A7/TL+Nftk1JFfVUyxur1U+tvySnOb6qxn+SqKnmlFR9DdZQQ1nIvtZrSNxs2qUOxq2EPPHA9UzaBWLYD9l/Hiy3WjABwP2fJhESKuUDi8Xx/hJP1Cl2YmFr2fPB4VoOoG6Gz97Fz+/5xvCqJi32YcoQlREDN9MJE+uFNdjYXURi73PXvzF2ePpZ+b7A5PvAcm5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kc7z7kmJ3msMuJ42mvPrGf+vXOyJEgDnNnzod+/lVWc=;
 b=C7eCuyQjNbcahnyISKt207UMuon72Hd1PePh5tN1KqpWhsufnrh1xzjIU+xW845YDLYv5481zmMaNxqKVm1SVDbustjrVk8QDH8I2XMJKouFQ8+5Qoe8J2u7PVrxY6g9tq0PmoZWrsuk29AZ3cECh05WTGXimVKAYhCMUGF1TaXPwD+dZq47eYSm9jloh4Ts4bnNcpYscbDgh5KX2Nc24Qr4Z3xqmm3bfHLYWeFNWAPROSlJ6tpzvEtR3wavQ+BVTq7LvQydCQo1FUCRv0PcT2mFY7VI5z8eR7vBzX6Zt9aaih+KdxP/AtPTvHoLmU4G4iiPIfzWe1RAEOVLLBi4Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kc7z7kmJ3msMuJ42mvPrGf+vXOyJEgDnNnzod+/lVWc=;
 b=Q0M67c8elKy9MQTCtypmCOtBwghV3qK1lF7+EvvuaQqReYCo75q9f/eIhlmSq2Pg+myGhFF8xkLUZ/w/5bYOzu05vhXkBKYmFnAMZsihHRK5jo9XLYiOeUbRNoNJCQqBW3WS9ZDYzcqV0T1K91GLpP6BtClJWpE1vd9QK9vf0/k=
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by VI1PR0402MB2862.eurprd04.prod.outlook.com (2603:10a6:800:b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Fri, 31 Dec
 2021 18:13:51 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::c84:1f0b:cc79:9226]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::c84:1f0b:cc79:9226%3]) with mapi id 15.20.4823.023; Fri, 31 Dec 2021
 18:13:51 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        Biwen Li <biwen.li@nxp.com>, "Z.Q. Hou" <zhiqiang.hou@nxp.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 devicetree] Revert "arm64: dts: freescale: Fix
 'interrupt-map' parent address cells"
Thread-Topic: [PATCH v2 devicetree] Revert "arm64: dts: freescale: Fix
 'interrupt-map' parent address cells"
Thread-Index: AQHX8PLFuZGYqGm80USNgHy7kOyTS6xNAmwA
Date:   Fri, 31 Dec 2021 18:13:51 +0000
Message-ID: <20211231181350.qwfnrwvdfnfssdjt@skbuf>
References: <20211214135852.2934670-1-vladimir.oltean@nxp.com>
In-Reply-To: <20211214135852.2934670-1-vladimir.oltean@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23becfe3-8245-4e5b-9452-08d9cc894c7e
x-ms-traffictypediagnostic: VI1PR0402MB2862:EE_
x-microsoft-antispam-prvs: <VI1PR0402MB2862B8AC2070E0BAB83969E5E0469@VI1PR0402MB2862.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yo4acR3zxaQjTt6Nb4VrzcFh9SVtOxLFgKdkc3LZ8X1Q/1yZ6GF6ecQDdWP0QgG9zK2HxHAyxegMyNjOQh0SEj4J5SbgGtZ5cNEMfcI6Gm8fQYxgHtdXQR6vo/Tw/xv2bFY7soGbRzdCj94oaPcac1YQDB83GXuEOgCLM/aY57dJK5EJYhT33zQyPOBM5R8YxoUOycL7j9mqtsqcHkDrL+ZA3XTaHOno5pQb5nB4m6ww++NVMJzqR+P36i5pnu9nxQ+o0+jkgXRfPMeuFm7sAXB522F4BPTyzpVCe9BfmpzekEXD+sz83QBr2bFVMqIYDLOBckBnQq0Q9/NyzxiKTCdpbjCGHKN0O5BRhnzdf7JaZzm2fSnXwrwcgTi4IIsBYigQso0OIN3lJUVHfGgCDTd1Jj36vDzsIgzNP9DCDzPxR85fuyufgbnSQjvMFezD4TyJJ10EIJwGeFX8mZhnJDPXoQoVX2ik0JBI6R2KVwkM1nq8e40F2Xp/PsxmfXPDpP9BXoaAKCsSYc4/f5We+UnDpqd08ZSPsb87nkRCgqSU9j+ejRUeUUxePYs0FC/3IxooJ7P0bmyUreSTx/bu4UZ17PaO+PggwcifZpHbO0idNGrCkl0qYSXSdR3A8Efr3b0uBQqLxVC7+pCnGy/QsThpUb2OnmcpBWQnngOUmX1/TbzriBvlVW+0OwoYTVyjg9T2O7qeyzetA6eb/puNGK5gkJdjkfoV2ycnq1tfAgDSvhF5O/hZoB0q3Me0AspqpPIhh0/kPxGkOUSB13lTOfybLynDOZYCWZII4DCnWkUbB0f8XJTdk8NrBTJXC8fR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(122000001)(26005)(5660300002)(8676002)(38100700002)(66476007)(44832011)(64756008)(6506007)(6486002)(3716004)(54906003)(33716001)(66556008)(83380400001)(66946007)(91956017)(110136005)(316002)(66446008)(4326008)(1076003)(38070700005)(2906002)(9686003)(966005)(76116006)(508600001)(8936002)(71200400001)(6512007)(86362001)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FXGCIMrY0pGyzP9H5czrT5Yn7wDTGBnmq9CIYmeZnRoTkspkbQWI1IfphgFB?=
 =?us-ascii?Q?EEUOZYteHt5KFdjuLwnt1k/asA/lnGd89UOjsoxVfcUlRftQFtP+ok1kq4XI?=
 =?us-ascii?Q?MbAR6ubUfCecmoiVZI7+wUh08GHB3EpGWKmro7vD8AwtxRhV74P/hIrfsPqu?=
 =?us-ascii?Q?2AcvbWW1JsRH8op4QllJreXH2cQDQRP0HXdC38aLgXUi82NWIrnoKQa1kcPf?=
 =?us-ascii?Q?hPw+ghORiQmhUwk/ULeYwz1qZp/qaCjtgU7QR0UBQZ/xhqGE1y6rcoz2VB3b?=
 =?us-ascii?Q?Jkv6Gh7CtkqB/SBHUIuIuSAg4s0Guh1qbkN38CYgp9izvkQZghfPF0qpdnM7?=
 =?us-ascii?Q?/MuH8ESw17y8znJxXiSx33yV57sSQ0+ojfnIqYSChHP3X9XBVdPsVTrbeiai?=
 =?us-ascii?Q?+lg99/OCD0EFIRRRptLRbcrSdpTLr++3ixnZtgm3rVZn7YkSwy+LHPE9D/3A?=
 =?us-ascii?Q?+98Xj8OUbdKxThxVlxqw8ylLqJL3wq73qy3S14sFSbgKSMtPryuyXc8veiUM?=
 =?us-ascii?Q?CpzsHOGb0AKBUNUHUt92+3ynEID5ntwnWnP8lm6jl+eUQDy+8e9pSn3Mw6E4?=
 =?us-ascii?Q?o8gmf3Fe3l2QgDrd2b7jwgoN25plUei+7ayR+X1cmWmgBunaY8TKoCLfVces?=
 =?us-ascii?Q?UlyqbezMsmvhFAOA9N3Evfjm3kkmc9n3ZJ2zgMkJ+rnGMECl3Y3YmgNBGdfp?=
 =?us-ascii?Q?BgoIKetR2Jtj1rLtfpaXQ4ONL4C09Zf2JqIjmg53k3r1FE4o/d388IzysbCE?=
 =?us-ascii?Q?Czs9/UvZt88NOs4mYzktAg/Aj3dZ693rM2vp44/OvLl/IQrqKOGpKIDV8Sxw?=
 =?us-ascii?Q?Byg5jMGMdGQAvskiXhQG45iclIomrLo+XevL3LGt79gQTVmu1llJutwc9+SV?=
 =?us-ascii?Q?K+rBX8myE54EvDP24RElncTxyj31yGIndo/SqUgQdoqt0U2Aa0pFQVGM6sjO?=
 =?us-ascii?Q?HNY7H0YGlC3sVyBXvVXyufMEFRc9DyyaRpwC1NpQCoU2ynRtjePFtR6uqSPl?=
 =?us-ascii?Q?PEXg5qWB38ymycB3st9WkT/lgA7Bzul44RoUpE0RmgHNHMD8SzXgYOTxfAwo?=
 =?us-ascii?Q?kjplELAFBKl7YXR8f5NViaGQZYf3Mi4Pgfg06FQfG1hCliyw0Gn6x1akgaOO?=
 =?us-ascii?Q?ud4/7NzCAm9QTnPKdkskTJtSBQNFB30o+9r7J0d9jFYOqPoOsl3arlBEF+HT?=
 =?us-ascii?Q?mDT/lkumcmKIpikZqDx3Gd1W+wIDKCiLS5+iJPlqqYW2gOqJojMSEJ3zjLFa?=
 =?us-ascii?Q?9LToBWmI7zZZvIsO/wAGixjogdtXKWVFWCWDeUuklO7XL4OuybjupJZvwvX3?=
 =?us-ascii?Q?VAEJ8dkWurPv997a+vWyyfzRKVU1PAbrjcfDh6IK+tyy/Zc7MOfkwTDAIZri?=
 =?us-ascii?Q?P1FWuUHbRcvWhKAV5xMvHX/rxWom/9Uj/9qhESch1I9KDYe4z4AybWX6lc0k?=
 =?us-ascii?Q?UnSJxko3lEPtNdFqJAQkwtzItAooY5UhzZ07s9gC3gDUeN58sSL5AUtoIf0c?=
 =?us-ascii?Q?IN0pBw26AT1rV0bhluFt9a1S29MbwCCqUCO/CpbSEVmhovEb7SB7juAetDSW?=
 =?us-ascii?Q?0pWvrRhNR5j9/yBkST30YACsnYBTn707IAaXeCRA5XcHuDv62cgO/z2Pr1Vh?=
 =?us-ascii?Q?M+7IeCntS8gqcVpl3SL4AK0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7BF76291621DAC40B6164099865EA96B@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23becfe3-8245-4e5b-9452-08d9cc894c7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Dec 2021 18:13:51.4179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hzKCjzIb/ozM8lln6Jy9qabkiNquG4CVsu1TEJRcWBxn+Kq5ue0pLcCZ4CdqZaEZ+EPwh1JCRsGeAw/ckkqbgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2862
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Dec 14, 2021 at 03:58:52PM +0200, Vladimir Oltean wrote:
> This reverts commit 869f0ec048dc8fd88c0b2003373bd985795179fb. That
> updated the expected device tree binding format for the ls-extirq
> driver, without also updating the parsing code (ls_extirq_parse_map)
> to the new format.
>=20
> The context is that the ls-extirq driver uses the standard
> "interrupt-map" OF property in a non-standard way, as suggested by
> Rob Herring during review:
> https://lore.kernel.org/lkml/20190927161118.GA19333@bogus/
>=20
> This has turned out to be problematic, as Marc Zyngier discovered
> through commit 041284181226 ("of/irq: Allow matching of an interrupt-map
> local to an interrupt controller"), later fixed through commit
> de4adddcbcc2 ("of/irq: Add a quirk for controllers with their own
> definition of interrupt-map"). Marc's position, expressed on multiple
> opportunities, is that:
>=20
> (a) [ making private use of the reserved "interrupt-map" name in a
>     driver ] "is wrong, by the very letter of what an interrupt-map
>     means. If the interrupt map points to an interrupt controller,
>     that's the target for the interrupt."
> https://lore.kernel.org/lkml/87k0g8jlmg.wl-maz@kernel.org/
>=20
> (b) [ updating the driver's bindings to accept a non-reserved name for
>     this property, as an alternative, is ] "is totally pointless. These
>     machines have been in the wild for years, and existing DTs will be
>     there *forever*."
> https://lore.kernel.org/lkml/87ilvrk1r0.wl-maz@kernel.org/
>=20
> Considering the above, the Linux kernel has quirks in place to deal with
> the ls-extirq's non-standard use of the "interrupt-map". These quirks
> may be needed in other operating systems that consume this device tree,
> yet this is seen as the only viable solution.
>=20
> Therefore, the premise of the patch being reverted here is invalid.
> It doesn't matter whether the driver, in its non-standard use of the
> property, complies to the standard format or not, since this property
> isn't expected to be used for interrupt translation by the core.
>=20
> This change restores LS1088A, LS2088A/LS2085A and LX2160A to their
> previous bindings, which allows these systems to continue to use
> external interrupt lines with the correct polarity.
>=20
> Fixes: 869f0ec048dc ("arm64: dts: freescale: Fix 'interrupt-map' parent a=
ddress cells")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> v1->v2: remove the other 9 patches that rename "interrupt-map" to
>         "fsl,extirq-map", at Marc's suggestion.

Could this patch be considered for merging in v5.16? The problem is
going to be quite a bit more severe and tricky to fix otherwise. Thanks.=
