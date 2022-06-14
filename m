Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B31954BE64
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 01:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239090AbiFNXih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 19:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiFNXif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 19:38:35 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2044.outbound.protection.outlook.com [40.107.104.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31B24EA3D;
        Tue, 14 Jun 2022 16:38:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lc1+17icXeu9PvBbVctk1fJ239ZjWzhZS9fEbQipx3PchBH4YLxkmuBjeUlHsMtSI8xpHAoXWAWaD2tAKCw/oTuB2DpJnn+N49+7gcQA3EFGmyxHtxF9hra4otw+nn+4Id5+pbHyMeCpKswOz9rgv0SxmA2H2gQ1LWKO+KGNpVkUadsa13NU47gV9M+YLEw8/aSBB6FrBW8ceHDns9NBLRiXrOd9SYcVIZmhberG+bezckWXrwjMv+Mh73Wvf7F0aXZMLSo67hwVZdiW90KV7NfbdHfE8JfS3mjLvtDIenWiUs90MoHcNNyAFDpM2X38dTvz5RAX1ACuQauW6qpj8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LT7ZCs4lty3g1APhKY5WthGuGcsgWBXWkdQLnvZ8gag=;
 b=OSnsIhtaq8bDaDBXU9R0sxeajrufVRqfmgiRhYUUq1Ae57uU2nGU29MnU1Xqtq6ZsyiUxatj2QalsQIR4kUQGDodVitndGIgkl3K8CYR2krdI8QO5hRQZbqWGC2ajh8A9+uEihL5r02h+XDftT6bpxZ8GQrpN3PqmjNGfCv5fB1WklWrvsN3yoi5j4Fsnm2ubyC2nwf8YxpKiaorTaOfE4g03jrUFNXKWxh3KIRXn1mVg0k85ORUNXm3/hi4dv/UD9JDtmT/aNJU2/+GbjUvQ/haJUEAclT0BKae1xf5LfAekDr3UiL/LgAaF9m2cZQtcpo3UHAJzFV6kkXpzclY1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LT7ZCs4lty3g1APhKY5WthGuGcsgWBXWkdQLnvZ8gag=;
 b=RPdJRMhboYZprZXwbaXdGKUn11hfWUxadWe8WddM1TIjBhgG8qDp/xqp7BlyFI8mI7PFu/X0OIaQkJmuvUyvS5lgrAnvFkzXUfDLyGcwreCD6pyKtKScWZZJq5YFpHQqn7GYpQYh7MOyZLWOBN8a2qZA7hDJdyo+0p4j9bIocss=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU0PR04MB9420.eurprd04.prod.outlook.com (2603:10a6:10:35b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.19; Tue, 14 Jun
 2022 23:38:32 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%8]) with mapi id 15.20.5332.015; Tue, 14 Jun 2022
 23:38:32 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "djakov@kernel.org" <djakov@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>, Abel Vesa <abel.vesa@nxp.com>,
        "abailon@baylibre.com" <abailon@baylibre.com>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        "marex@denx.de" <marex@denx.de>,
        "paul.elder@ideasonboard.com" <paul.elder@ideasonboard.com>,
        "Markus.Niebel@ew.tq-group.com" <Markus.Niebel@ew.tq-group.com>,
        "aford173@gmail.com" <aford173@gmail.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 0/8] interconnect: support i.MX8MP
Thread-Topic: [PATCH 0/8] interconnect: support i.MX8MP
Thread-Index: AQHYdZuXp1k0Y8bakU2NzRLysk7WMq1Mm6BQgAKkk4CAAGCvgA==
Date:   Tue, 14 Jun 2022 23:38:32 +0000
Message-ID: <DU0PR04MB94173B94950965B7DB3BA4CB88AA9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220601094156.3388454-1-peng.fan@oss.nxp.com>
         <DU0PR04MB941799547BD863444C6F268D88AB9@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <c2034c030333f89e0ac7d86c906dd222cc151d52.camel@pengutronix.de>
In-Reply-To: <c2034c030333f89e0ac7d86c906dd222cc151d52.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5cb4b773-e4c0-4f59-6e50-08da4e5efe17
x-ms-traffictypediagnostic: DU0PR04MB9420:EE_
x-microsoft-antispam-prvs: <DU0PR04MB9420DD1914E26161BE9457E988AA9@DU0PR04MB9420.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T7uovAlTlC+vY1IkqUij8njDVD90BnoBpIdmc3jZvV3ApBHrDEiNwHPbMuSEwHKTLpx84HxjdlpUO1R7tvz1DaDl1Ge2CbxFRHRjP/xx9dE7bIJa67cPgnyCbhmA/fH6DlQWd55+B/9zjeEFf4y9817b5EgfCCbsGU99sKkXMmotYc0Ktdn6IoE3CeM+OLv+AsYCeqTQNQ5nm1LPjd+rx703zVOXCsUYafALh6B4xyDc+r3jFAdjvkWZIvJ17SaZus1DQHEhuqRIfw3x5PyoO529ErifcCjfOdq8muEHtwE3w1OE8h8cr4tYvvboo5Ys6oj0NbbQqMLvpANLo1cnT1DBcWVqkWAIWSoDuMpjNeI7HIkxptaRVnrVpRJLM2OCZ64JVQsqEEQyNBtfd0enkKbRC1s24B+z2v+7HjVJpQqAwjJmwwD8TrE3czhyJ5Y3LkK8InpCUt00uTGJqUVueIX83K9dLshQMYW27tKThaq+iJOMUv7FAIB25dXD1rius7TLPPhj+YOjIqojbqt7o79bsHXQ95xX4TQTW1r5GD2IDWk8f1d1Wi1w637N6h9oOFomlE4ZGnLVG9F79ot35W9pP9fGvqbx/rsG8J+2oeJtUD8VGXVCjvovdUyeBSCHjnULpRTVqBl7P3Exw0y9qaV+I7TtYKF+Iq6ri59mh8T2Mks4iM5Vn6Yov7/tFAYHICjMe/TsfMJmu89bY7DOJeL49e7NL/DJghv8jtft9PBg29YEvlr9CnzD0twg2/WNHpNQRPLUhmA4fmXp1bqNpe398ytWEhaAsN1ZSyB1HVpetVE+QddbO9sEwMtYEm7d1a2rZZ4s08Ufd/v/TGl6lF+pFD8jDpK6za2jg750Ig0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(186003)(52536014)(5660300002)(38070700005)(4326008)(7416002)(316002)(66556008)(83380400001)(86362001)(64756008)(122000001)(55016003)(8676002)(921005)(66446008)(66476007)(508600001)(71200400001)(54906003)(6506007)(8936002)(66946007)(33656002)(7696005)(45080400002)(76116006)(44832011)(966005)(2906002)(38100700002)(110136005)(26005)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R18hJj0+Qh2uKSLeIaK8A5WsrvoecdiXiGPrO9SRkKugLFhgQOiOUxo1MbVP?=
 =?us-ascii?Q?pK3M3x768LaZtlYi/30FcjGOV79ZK3O9lr9YQm5879EO3HUKLVt3nkLmwz/y?=
 =?us-ascii?Q?UhZIyrLPCImb+Jjd0oweG/ey+c3VQppdcOTnB+UKJUTdehZ9zHomCBkFf7K+?=
 =?us-ascii?Q?Z4PJ7owUZ279//N8XbsdPUkMlDLfzfq0aKE9WfX7jznjk2XekY64jaT96Bvs?=
 =?us-ascii?Q?VWRQ/7uvtMXetqBvLSJWPw5yWNdYEhBbHBaWTbF6UY2jls3m9LE+7pmZv4so?=
 =?us-ascii?Q?6ujYIg4heRdne+6n94wODUeBEkgXF3OvYNFUAPmV5veasKy01WtUMHNAKmSp?=
 =?us-ascii?Q?MF1ymjIrksrXYJuGiu8nRlibTZwA4UH8d83AY2VLCWg7C1NkVmjfbjqp1xkJ?=
 =?us-ascii?Q?2N/JPCE4/EnB6n0hmA/jaMcrNA65K+PAtgmo7Y0EqQX5Cv+PQvSqc9FNvYz8?=
 =?us-ascii?Q?yfcJ5859tv8OLHCrKaBAqVEc7PYL2EzsFLAWenuLyghNB034rAiTRcietUUk?=
 =?us-ascii?Q?qCPjLXC55iUc1vVVRtJVZjH7BGS1qsYX9oveCfYhE1TpE7SW9pxPoDNHupZ/?=
 =?us-ascii?Q?nQLN7GVAUT8hB7KWfdDQQlU6GeohfHNDVc1ZhQ8jpli6a3BxmRJBPvPZDV/w?=
 =?us-ascii?Q?Lbf+cHqUXAWiJFiDrLcBYlaiv14YI7TgpZ27Uf/Tc/QRuRx0+E2Ja8dpZoWF?=
 =?us-ascii?Q?f3BmpxZboPCfllaFewqu0TyYYC9cwhr5vyFP1KuA74V0+G+7/U83gPbXS3UH?=
 =?us-ascii?Q?8yohHVQZAhiVPXeZ0ee1uBXmlu3qKGY6o8IaKVfAtzfj55HjXE3NbkGL4DXL?=
 =?us-ascii?Q?PbDmm/0tSwCVNOBNHrOkxRWoyhfxd9O/YGb/JIbQmj5lP5Q2SYp7VblROqSj?=
 =?us-ascii?Q?zbsoZq5zpwIAwOIti/EABya6iD71o0sKBTY8XRhlk0oC0wBSslR60BkEGfwU?=
 =?us-ascii?Q?c5i2QBVsFu+WU1mLGr0DhhoDUKVQYh7UeyITv8MMcCO9ZXpBCitp1R4qwMvU?=
 =?us-ascii?Q?02lDuyEN0AzWS+Wymrt0LjT3oVSHtxrlrDg/mi+01NJw7qXBa8eR1TgVojaL?=
 =?us-ascii?Q?dHWMUW0DvzvM4O1QspKjc/AbB5yL1F4ASJfkQzSTq8cTtJ/STAWFDs2rpsWa?=
 =?us-ascii?Q?RE6jJPln9ijSFNrz6W6kBlnrXFhxUuZy7cSNyjgMQCxaI7EZPcTn1AgThTez?=
 =?us-ascii?Q?eFOdNLjZnQZTrOxbTt5ISwoRSNLdShKIjs3WUUSnRP+lhadzm9K7R4mFlA63?=
 =?us-ascii?Q?SE/K8N94VJ82vptjXSe4nsqr48StfC88JFPKnSgxh3bjF/IZFCdQhFXlnPRR?=
 =?us-ascii?Q?eodUtzfhRHo4rXg1PWv6mGVqWo5kdBmnuSgEKI3VkKzY6CaZvUCHkJCkwcy/?=
 =?us-ascii?Q?0VdN8M0e8yIzDbin/AMwxoO7e1RMs3u+CWQ/IIQH/dLlNGBsAbKoMtYz8jRV?=
 =?us-ascii?Q?u6gVmAG0AZDJdGbgfb4E0Zij8SIfb9HZuc+JLkMTc82pLsrX2jbhKEffuUTL?=
 =?us-ascii?Q?fnpi4Q/8y4TvHusfgD9Zz4/TjtZxXCTbndiYf6T175/Ve/da3Oy6CWDGEos7?=
 =?us-ascii?Q?2A2bGpv36z8kZgiLL5SBLOmpB5ghVj3r7efMjG2kTQrTSptnKIYlcBDvpPQ0?=
 =?us-ascii?Q?N9HWBZ6NEtCdxJ6IEJl0EFneuT6XWA6Quq8ntL0zxTYhfnzvOjD6PpB7KpBE?=
 =?us-ascii?Q?3J8jmnkSosInZ+Khr7HgYtKly1DXGiefJxFJnoT1Ij6Al2n2DzLGBvKh46BZ?=
 =?us-ascii?Q?NQt7JTByow=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb4b773-e4c0-4f59-6e50-08da4e5efe17
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 23:38:32.2875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IVAt5fOKwvRrejTqzBrqPN4jlnf9wePb8odPurqjXIPgcFu2fsgFM/HzeccoL1uiHd1dNsGH/tiUhdgO7zplZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9420
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lucas,

> Subject: Re: [PATCH 0/8] interconnect: support i.MX8MP
>=20
> Hi Peng,
>=20
> Am Montag, dem 13.06.2022 um 01:23 +0000 schrieb Peng Fan:
> > All,
> >
> > > Subject: [PATCH 0/8] interconnect: support i.MX8MP
> >
> > I am going to send out V2 this week to address the comments until now.
> > But before that I would like to see if any one has any comments on the
> > design here.
> >
> > Georgi, do you have comments on Patch 2 " interconnect: add device
> > managed bulk API"
> >
> > Lucas, since you had comments when I first use syscon to configure
> > NoC, are you ok with the design to use interconnect in this patchset?
> >
> I'm still not 100% convinced that the blk-ctrl is the right consumer for =
the
> interconnect, since it doesn't do any busmastering. However, the design l=
ooks
> much better than the syscon based one.
>=20
> I mostly worry about being able to extend this to do more than the curren=
t
> static configuration if/when NXP decides to release more information abou=
t the
> NoC configuration options or someone reverse engineers this part of the S=
oC.=20

I have asked internally, NoC documentation for i.MX8M* is not allowed to pu=
blic.

I
> still hope that we could optimize NoC usage by setting real bandwidth and
> latency limits for the devices connected to the NoC. As the blk-ctrl does=
n't have
> any clue about this right now, we can't really set any more specific requ=
ests
> than the current INT_MAX ones.

Actually looking at ATF NoC settings, the values are suggested by Design te=
am,
Design team give SW team such a group of value and not suggest SW team
to change it. And the value in ATF not touch bandwidth registers, as you
could see from the patchset, only mode,priority,ext_control are configured.

Similar to qcom using static settings:
./drivers/interconnect/qcom/qcm2290.c:668.
.qos.qos_mode =3D NOC_QOS_MODE_FIXED,

I understand that people wanna tune the settings at runtime on demand.

> I guess we could extend things in this way by making the blk-ctrl not onl=
y be a
> simple consumer of the interconnect, but aggregate requests from the devi=
ces
> in the blk-ctrl domain and forward them to the NOC provider, right?

I am not sure. This patchset is actually only for init NoC settings after
power on, because the initial value is invalid.

I could think how to resolve the INT_MAX settings in next version,
For your upper suggestion, could we start after this version approved for l=
and
in tree?


Thanks,
Peng


>=20
> Regards,
> Lucas
>=20
> > Thanks,
> > Peng.
> >
> > >
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > This patchset is to support i.MX8MP NoC settings, i.MX8MP NoC
> > > initial value after power up is invalid, need set a valid value after=
 related
> power domain up.
> > >
> > > This patchset also includes two patch[1,2] during my development to
> > > enable the ICC feature for i.MX8MP.
> > >
> > > I not include ddrc DVFS in this patchset, ths patchset is only to
> > > support NoC value mode/priority/ext_control being set to a valid
> > > value that suggested by i.MX Chip Design Team. The value is same as
> > > NXP downstream one inside Arm Trusted Firmware:
> > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fs=
o
> > >
> urce.codeaurora.org%2Fexternal%2Fimx%2Fimx-atf%2Ftree%2Fplat%2Fimx%2
> > >
> Fimx8m%2Fimx&amp;data=3D05%7C01%7Cpeng.fan%40nxp.com%7C6cfad0fcec
> 0d472
> > >
> 408a208da4e2cd96d%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7
> C63790
> > >
> 8251778425186%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJ
> QIjoiV2
> > >
> luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DU
> vIx%
> > >
> 2BAz9rx3Z8Oy7VSCRB90O8M5VICIUaUOiTmYw%2FeI%3D&amp;reserved=3D0
> > > 8mp/gpc.c?h=3Dlf_v2.4#n97
> > >
> > > A repo created here:
> > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fg=
i
> > >
> thub.com%2FMrVan%2Flinux%2Ftree%2Fimx8mp-interconnect&amp;data=3D05
> %7C
> > >
> 01%7Cpeng.fan%40nxp.com%7C6cfad0fcec0d472408a208da4e2cd96d%7C68
> 6ea1d
> > >
> 3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637908251778425186%7CUnkn
> own%7CT
> > >
> WFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJX
> V
> > >
> CI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DW2iYPMJ6dn%2F4OTalTD2yqB
> Hx%2Bo3%
> > > 2BuBTuP%2BAe4bBz2Gc%3D&amp;reserved=3D0
> > >
> > > Peng Fan (8):
> > >   dt-bindings: interconnect: imx8m: Add bindings for imx8mp noc
> > >   interconnect: add device managed bulk API
> > >   interconnect: imx: fix max_node_id
> > >   interconnect: imx: set src node
> > >   interconnect: imx: introduce imx_icc_provider
> > >   interconnect: imx: set of_node for interconnect provider
> > >   interconnect: imx: configure NoC mode/prioriry/ext_control
> > >   interconnect: imx: Add platform driver for imx8mp
> > >
> > >  .../bindings/interconnect/fsl,imx8m-noc.yaml  |   6 +
> > >  drivers/interconnect/bulk.c                   |  34 +++
> > >  drivers/interconnect/imx/Kconfig              |   4 +
> > >  drivers/interconnect/imx/Makefile             |   2 +
> > >  drivers/interconnect/imx/imx.c                |  68 +++--
> > >  drivers/interconnect/imx/imx.h                |  25 +-
> > >  drivers/interconnect/imx/imx8mm.c             |   2 +-
> > >  drivers/interconnect/imx/imx8mn.c             |   2 +-
> > >  drivers/interconnect/imx/imx8mp.c             | 232
> > > ++++++++++++++++++
> > >  drivers/interconnect/imx/imx8mq.c             |   2 +-
> > >  include/dt-bindings/interconnect/fsl,imx8mp.h |  59 +++++
> > >  include/linux/interconnect.h                  |   6 +
> > >  12 files changed, 424 insertions(+), 18 deletions(-)  create mode
> > > 100644 drivers/interconnect/imx/imx8mp.c  create mode 100644
> > > include/dt-bindings/interconnect/fsl,imx8mp.h
> > >
> > > --
> > > 2.25.1
> >
>=20

