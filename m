Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAAB154C4A7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 11:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345545AbiFOJ2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 05:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345502AbiFOJ2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 05:28:08 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80083.outbound.protection.outlook.com [40.107.8.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FD517A9E;
        Wed, 15 Jun 2022 02:28:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7h7n85WIkbDXi4WkM3p9UkQORua957Urp5Wbx3B9pOnzIfZit9c1sujmzo1OxW7snvvOs4VzB7r4EiMErXv+xoIbtG9T+TddbgiQi+R/OocHJ27igFwa1burTm1huD3cA5YYXCgFn847js2WpHnzYIOk7mtWwPrLoB3T0TVupUmZbjap3Scm9xClT2YXc1YwtezU6fr+AmFFTNaqz7q5Q9g0UOhIBwrx8eXMO+xsA/ZQQUFYccS0j9Uc08lrOeMilfEEg6WbSv4BhaIbj9pzzZ9rx3VQaA54Wie9DTA0gXRmGEgwuBCvGM5YI75kdFrnK7983t2iobqMOm2mQ7qWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YsDmUe3gD+OCP2bFdpS8pnmvcME9RhPf0yUYE84sVgg=;
 b=BSuIAUFHQWECXw7RTDg06KaL5nH/58ttBCMiC/TI/CYdX/8/sZPUsEbWWkuQlSfak+CCJG8eAYk44H8DgX0Ht2LI7wehigYPROfRrh8TU3lpq4H3/qhk95OivIHEh5XXK5DA6O6GpPED8UDMFu1b6U2flxxgG9V33gJswTpU++CJpa7Uun/bVxSoU12yGuFci5ofS3dWj3lEXaDaP21CsAjs6NcAX8sv5iJMyzH0r/KEfM7Eu2kEDOos0QRSuv/eX/yZQnJ3GsrYtu9u0MiM0YH/qzs7YEaJR4xS5LMXoq5FKMP6Z7++Vo3/3VhqqRTzKL11+/Gm9S0VTEeOM2V0tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsDmUe3gD+OCP2bFdpS8pnmvcME9RhPf0yUYE84sVgg=;
 b=bWBQza0lcSp3pg0oucu3hZBvBXEmapgBDMlj5tzlrOtjTim8GghXa2WgvrLCXy21jta0cYemCPfx9GrltrMHNAHRickF26HfkeE29q4C8QNSTDfzA0Ggj+QuP4PFuEBLRWPRidjQBTdDRZjc+T0Oc48FPOAuOGJcpqtNvzgUj+M=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB6PR0402MB2886.eurprd04.prod.outlook.com (2603:10a6:4:97::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Wed, 15 Jun
 2022 09:28:00 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5353.014; Wed, 15 Jun 2022
 09:28:00 +0000
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
Thread-Index: AQHYdZuXp1k0Y8bakU2NzRLysk7WMq1Mm6BQgAKkk4CAAGCvgIAAokWAgAABFjA=
Date:   Wed, 15 Jun 2022 09:28:00 +0000
Message-ID: <DU0PR04MB94172B0EE6455C43B4B0364088AD9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220601094156.3388454-1-peng.fan@oss.nxp.com>
         <DU0PR04MB941799547BD863444C6F268D88AB9@DU0PR04MB9417.eurprd04.prod.outlook.com>
         <c2034c030333f89e0ac7d86c906dd222cc151d52.camel@pengutronix.de>
         <DU0PR04MB94173B94950965B7DB3BA4CB88AA9@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <9cc8d2d2ca9ff2ee71d976b2b0210ce144298c46.camel@pengutronix.de>
In-Reply-To: <9cc8d2d2ca9ff2ee71d976b2b0210ce144298c46.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: df4377b7-a698-4099-557a-08da4eb15728
x-ms-traffictypediagnostic: DB6PR0402MB2886:EE_
x-microsoft-antispam-prvs: <DB6PR0402MB28866E5681F2DE79B95F11E188AD9@DB6PR0402MB2886.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xjdtOTj7swqtSuYzbyZ8H5jxnIS0TF/wwwW0eaphr0ZGKR7hIpH1W9PHkPd4UC3Kv1ZJYQQzuxdJyTpCQAH6pynfccYRUxGjvyvKVD0OKyXn4L5hcVIErpSQErGOkoQus2SVjDra6tt7TIhI1IqbTG3CiMY96/J3smevet3bbp1WfHXMnvkXZ76gZaeYA2M/U+sNQK+JhrJNMGiuqap2hCf8SEsATKisaWWkTJAgjgcDe0NGW+UUKlBLUKTJXxJaPvILJ7sB6S//4WIVv2PxTKjAJvtK/uT1d+0Me9hH6EelRuY1fkPWbD2jyr8rjGF7cvWwABRS0Uz4bUot8Q78A1DuxV38+w23FjuLl9vUStRdBA85OG8g2RdJ/Zk710PjStFqVvhMY4drG4KIELszbqe2bNFhMmRxA8ynAyeQ8cEaL9dMgreDFQKfZuZwgzGYJmxrXvneW5+ti+hVvOFD/C/zkZvHWVLqh9lm3++DJ9dtkU8w8OkcJnEUmnMtMZe32UK7DifBPE9hjWhFn1OX8oFiZJDkOPfuULFZXLGkvzFT3oNzb8N2hFHrqzFWsuOs5k0pYkgDXFjnf1ywU7SKI5DO3eLQO7uPJW0LYTEwozusSttXE1tm6CqaZoJYF+CS0kFXYUwgQH9P8OS/ec8N4chi+xfcSFCrDPETCywhTBdBzrkic4QUajLYk0esg8hfj0EWX2AQEwVlbMFZSG7zblPRZ91i+KZKtOps5T7qJ5mudZx+bac38A2bQ9TuwpjgzLUds6gHKuW/RfCKHVTjcMtFKN8NHoz4eZ7BKBqhGvS+SaGbfJ+E2p0HXZ5wKFso
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(110136005)(38070700005)(122000001)(86362001)(316002)(5660300002)(38100700002)(54906003)(186003)(66476007)(26005)(921005)(9686003)(55016003)(66946007)(33656002)(83380400001)(8676002)(7696005)(76116006)(66446008)(64756008)(66556008)(52536014)(966005)(45080400002)(71200400001)(508600001)(7416002)(8936002)(6506007)(44832011)(2906002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hMKMCC+x/WC/z6I8017JdY6Ob1gneMFAiEgpN//XKtVX99vKUEeH18EZCKth?=
 =?us-ascii?Q?+15QaCamVW7yosvwA2laFVeu7LycSMIzf5pIJLI4kYgknzXstnYLT7OOc7xf?=
 =?us-ascii?Q?Nf6uQRSNWWyHK5W7oQR73foKQhiHfvOc/7W9gc0q6qReMFFzV1s8uJKzBStC?=
 =?us-ascii?Q?yCtAVQQK1Me1FZGcVTU96sgYQMsJpPda/rXbD1bLH6rnblR/bsqETNTQFog4?=
 =?us-ascii?Q?BlgsLP2o4HY/8fzjaq2PHvdHWbcpjfbbYF2diUt6XD06BDURgzhxhBY6wKoR?=
 =?us-ascii?Q?VSlp2x9Mp2JCGKWXMArFXMwtS5w6YmeAirB15e5pY6U6gkE/3TnUqYrgA2v9?=
 =?us-ascii?Q?vjQGRNsz/k1XaJxUglmWfugqIKMy9U8Q6QqcxQoCLCZM9uaiR68u5FZ1QFap?=
 =?us-ascii?Q?UK4JXmd1CggikpQNXZIPgEeW4YnnRzMbT2RyGAyyuNROjgGleCAJvBMYhmxU?=
 =?us-ascii?Q?zLatt8zusPpduAbIHc0YJCMlD9lkAXoph5YejTmr9ivQK8xndje9fzQ0SEXu?=
 =?us-ascii?Q?/VcWlKdmBfWqrFhNgVkapsMU7Teonf+P/L9lqeu4ykGBMcE50f3SnXN3Z1im?=
 =?us-ascii?Q?yuQCbIpfGInhY6esz1ejeNCH6EAYKhkk0Rn8ZEdKwZBKMCFHF2sTof3gNtC+?=
 =?us-ascii?Q?eqn6PdWwTh/5K90Ccrg/X2Abea8fNntk/6w5dr0wDlrBK0boAZ4toEJccw8B?=
 =?us-ascii?Q?KsZvW58CNTNfm3X0dLl28NIB7/FDhGEiSkNf1oE4YNtcrgOBLAT9agsER2xD?=
 =?us-ascii?Q?KRGhr7dmveHf8P2tdlUV2TJ11SUVknP9IAs7tgC7Iybm54tOaymx5vDweAUL?=
 =?us-ascii?Q?XV6u7BcYS39WY/3C/9fbk7stvaMECEekol3J81+dvXgXVHn56fh7b0JGUWcf?=
 =?us-ascii?Q?NYrO3A7mnNFlelojf6M7Tia8Dzlaw0+DT73uahD947z+65aGWArblIGhRZfj?=
 =?us-ascii?Q?eO7XJ7FMo/R9rhyqkRUa3CV72r97YPlDIItFy81xCL4nMMFaCG12joPMai5y?=
 =?us-ascii?Q?56R/wAAWpdNNGBr8ksCF6DykhFck6UJmWm6KlBon+Pg53UAjt0g4dKy0LmkX?=
 =?us-ascii?Q?tDzcN040gkjhxsaIqMR8vcckigRzsJBovCn6WV69KA0XUBUFR7FEg0i1UEqG?=
 =?us-ascii?Q?01R8ASUPrMi0DlpjJlYSbG8w4Ol1q8ok/cM35WZOBW7HW7KMZ51b+0H1I6ou?=
 =?us-ascii?Q?jF0pcKgfUHzLmZZG0tkqqfW/mcN47ed4bChqFYJXffgmrIIG/HNDwWA9xmox?=
 =?us-ascii?Q?q6rGkKB9jV+m98Xr/gkQW50bLHRZscmDU+g1U1X6Lcf+2t5+GxnZXAZwPIGZ?=
 =?us-ascii?Q?mW49BtN79tV1pSP5wPGxyEEKu+YCn9RP6rEzgdJUlKw1nQqFhOWrJrA7bsVs?=
 =?us-ascii?Q?tLjxADfg7wnmo8kbM8Z4KSLLz5MsW1z3PcJ7xjjKKZJrg9G2aecXSHupCTbd?=
 =?us-ascii?Q?8N7xXCDJiwnYhbhUSVs/x5pwnjkz1nSrZS11rHy0BFKiCFlYPuHV2DMytNG6?=
 =?us-ascii?Q?WVnpOlytzMa/ZRui3nM2wRUrXfpGh1zjWV+SpC8aaqNL54ybDgH/vzAuIt/8?=
 =?us-ascii?Q?7+bcCbNi0z+NmHnQj9lMpAdytGfeAdQxt8JQAeI4Y01oMCnqKAVPYjb4kICH?=
 =?us-ascii?Q?t/AvNTSe2efqnMcI17qp1SGCdVqxNTbktbz1f3xW4Km1lB4ncNZKheLmt3Ie?=
 =?us-ascii?Q?HjDZrVQAPBBMMCnjnNtvoxcJBSx+xvXKy11j9S0nqJjjvjRA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df4377b7-a698-4099-557a-08da4eb15728
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2022 09:28:00.4629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OcbFryb1KdTsFjEcvPAe+GaLLNy8eNUDVGgF6mLC+bCHUuDB4BKOcIiIPeeonuzA6Z2CpOdRBwdIR0AbvrsoIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2886
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
> Am Dienstag, dem 14.06.2022 um 23:38 +0000 schrieb Peng Fan:
> > Hi Lucas,
> >
> > > Subject: Re: [PATCH 0/8] interconnect: support i.MX8MP
> > >
> > > Hi Peng,
> > >
> > > Am Montag, dem 13.06.2022 um 01:23 +0000 schrieb Peng Fan:
> > > > All,
> > > >
> > > > > Subject: [PATCH 0/8] interconnect: support i.MX8MP
> > > >
> > > > I am going to send out V2 this week to address the comments until n=
ow.
> > > > But before that I would like to see if any one has any comments on
> > > > the design here.
> > > >
> > > > Georgi, do you have comments on Patch 2 " interconnect: add device
> > > > managed bulk API"
> > > >
> > > > Lucas, since you had comments when I first use syscon to configure
> > > > NoC, are you ok with the design to use interconnect in this patchse=
t?
> > > >
> > > I'm still not 100% convinced that the blk-ctrl is the right consumer
> > > for the interconnect, since it doesn't do any busmastering. However,
> > > the design looks much better than the syscon based one.
> > >
> > > I mostly worry about being able to extend this to do more than the
> > > current static configuration if/when NXP decides to release more
> > > information about the NoC configuration options or someone reverse
> engineers this part of the SoC.
> >
> > I have asked internally, NoC documentation for i.MX8M* is not allowed t=
o
> public.
> >
> Yea, sadly I've heard this many times from NXP.
>=20
> > I
> > > still hope that we could optimize NoC usage by setting real
> > > bandwidth and latency limits for the devices connected to the NoC.
> > > As the blk-ctrl doesn't have any clue about this right now, we can't
> > > really set any more specific requests than the current INT_MAX ones.
> >
> > Actually looking at ATF NoC settings, the values are suggested by
> > Design team, Design team give SW team such a group of value and not
> > suggest SW team to change it. And the value in ATF not touch bandwidth
> > registers, as you could see from the patchset, only mode,priority,ext_c=
ontrol
> are configured.
> >
> > Similar to qcom using static settings:
> > ./drivers/interconnect/qcom/qcm2290.c:668.
> > .qos.qos_mode =3D NOC_QOS_MODE_FIXED,
> >
> > I understand that people wanna tune the settings at runtime on demand.
> >
> Right. We had the same situation with QoS settings on the i.MX6, where
> Freescale/NXP claimed that the values from the design team are optimal an=
d
> should not be changed, but we actually had some cases where tuning those
> values to the specific use-case of a board was beneficial. With the i.MX6=
 we
> could do this on our own, as things were documented, at least partially.
>=20
> I don't request you or anyone from the NXP open source team to do somethi=
ng
> here, as I understand that the no documentation policy is an outside deci=
sion
> that you can not really change. I just want to make sure that if someone =
was to
> do something about this situation, we don't make that change harder than
> necessary by locking us into a DT binding and design that might be hard t=
o
> change later on.

Hope I could help on this if you have suggestion on technical direction wit=
hout
breaking NXP policy.

>=20
> > > I guess we could extend things in this way by making the blk-ctrl
> > > not only be a simple consumer of the interconnect, but aggregate
> > > requests from the devices in the blk-ctrl domain and forward them to =
the
> NOC provider, right?
> >
> > I am not sure. This patchset is actually only for init NoC settings
> > after power on, because the initial value is invalid.
> >
> > I could think how to resolve the INT_MAX settings in next version, For
> > your upper suggestion, could we start after this version approved for
> > land in tree?
> >
> I just want you to think about how we could extend the design laid down i=
n this
> patchset if/when the peripheral drivers are starting to request their act=
ual
> bandwidth usage. If the answer to this question is "we'll simply make the=
 blk-ctl
> part of the interconnect hierarchy and let it aggregate the bandwidth req=
uests
> and forward them to the NoC driver"
> then I'm fine with this patchset landing in upstream as-is. I'm just not =
sure if I'm
> overlooking something here which would prevent such an extension of the
> design, as I'm not a expert in the interconnect framework.

There is only priority level as I write in the driver, the priority level i=
s not suggested
to runtime change according to i.MX design team.
For media related settings, there is GPR hurry level settings which is writ=
ten
in RM and ATF code.

In normal case, if you really wanna change priority level, you could use
other value. I'll update driver to describe priority bit mask.
In some heavy load mode, you could pre-set a GPR hurry level value to boost
the transaction.

But since design team not suggest SW to runtime update the value, also no
idea to match priority level with SW bandwidth. from driver debug, what
I could improve is the describe the priority register, then people wanna
to change, could update it.

Is this ok?

Thanks,
Peng.

>=20
> Regards,
> Lucas
>=20
> >
> > Thanks,
> > Peng
> >
> >
> > >
> > > Regards,
> > > Lucas
> > >
> > > > Thanks,
> > > > Peng.
> > > >
> > > > >
> > > > > From: Peng Fan <peng.fan@nxp.com>
> > > > >
> > > > > This patchset is to support i.MX8MP NoC settings, i.MX8MP NoC
> > > > > initial value after power up is invalid, need set a valid value
> > > > > after related
> > > power domain up.
> > > > >
> > > > > This patchset also includes two patch[1,2] during my development
> > > > > to enable the ICC feature for i.MX8MP.
> > > > >
> > > > > I not include ddrc DVFS in this patchset, ths patchset is only
> > > > > to support NoC value mode/priority/ext_control being set to a
> > > > > valid value that suggested by i.MX Chip Design Team. The value
> > > > > is same as NXP downstream one inside Arm Trusted Firmware:
> > > > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F=
%
> > > > > 2Fso
> > > > >
> > >
> urce.codeaurora.org%2Fexternal%2Fimx%2Fimx-atf%2Ftree%2Fplat%2Fimx%2
> > > > >
> > >
> Fimx8m%2Fimx&amp;data=3D05%7C01%7Cpeng.fan%40nxp.com%7C6cfad0fcec
> > > 0d472
> > > > >
> > >
> 408a208da4e2cd96d%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7
> > > C63790
> > > > >
> > >
> 8251778425186%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJ
> > > QIjoiV2
> > > > >
> > >
> luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DU
> > > vIx%
> > > > >
> > >
> 2BAz9rx3Z8Oy7VSCRB90O8M5VICIUaUOiTmYw%2FeI%3D&amp;reserved=3D0
> > > > > 8mp/gpc.c?h=3Dlf_v2.4#n97
> > > > >
> > > > > A repo created here:
> > > > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F=
%
> > > > > 2Fgi
> > > > >
> > >
> thub.com%2FMrVan%2Flinux%2Ftree%2Fimx8mp-interconnect&amp;data=3D05
> > > %7C
> > > > >
> > >
> 01%7Cpeng.fan%40nxp.com%7C6cfad0fcec0d472408a208da4e2cd96d%7C68
> > > 6ea1d
> > > > >
> > >
> 3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637908251778425186%7CUnkn
> > > own%7CT
> > > > >
> > >
> WFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJX
> > > V
> > > > >
> > >
> CI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DW2iYPMJ6dn%2F4OTalTD2yqB
> > > Hx%2Bo3%
> > > > > 2BuBTuP%2BAe4bBz2Gc%3D&amp;reserved=3D0
> > > > >
> > > > > Peng Fan (8):
> > > > >   dt-bindings: interconnect: imx8m: Add bindings for imx8mp noc
> > > > >   interconnect: add device managed bulk API
> > > > >   interconnect: imx: fix max_node_id
> > > > >   interconnect: imx: set src node
> > > > >   interconnect: imx: introduce imx_icc_provider
> > > > >   interconnect: imx: set of_node for interconnect provider
> > > > >   interconnect: imx: configure NoC mode/prioriry/ext_control
> > > > >   interconnect: imx: Add platform driver for imx8mp
> > > > >
> > > > >  .../bindings/interconnect/fsl,imx8m-noc.yaml  |   6 +
> > > > >  drivers/interconnect/bulk.c                   |  34 +++
> > > > >  drivers/interconnect/imx/Kconfig              |   4 +
> > > > >  drivers/interconnect/imx/Makefile             |   2 +
> > > > >  drivers/interconnect/imx/imx.c                |  68 +++--
> > > > >  drivers/interconnect/imx/imx.h                |  25 +-
> > > > >  drivers/interconnect/imx/imx8mm.c             |   2 +-
> > > > >  drivers/interconnect/imx/imx8mn.c             |   2 +-
> > > > >  drivers/interconnect/imx/imx8mp.c             | 232
> > > > > ++++++++++++++++++
> > > > >  drivers/interconnect/imx/imx8mq.c             |   2 +-
> > > > >  include/dt-bindings/interconnect/fsl,imx8mp.h |  59 +++++
> > > > >  include/linux/interconnect.h                  |   6 +
> > > > >  12 files changed, 424 insertions(+), 18 deletions(-)  create
> > > > > mode
> > > > > 100644 drivers/interconnect/imx/imx8mp.c  create mode 100644
> > > > > include/dt-bindings/interconnect/fsl,imx8mp.h
> > > > >
> > > > > --
> > > > > 2.25.1
> > > >
> > >
> >
>=20

