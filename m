Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2819B57FCDF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 12:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbiGYKEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 06:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234323AbiGYKE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 06:04:29 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2040.outbound.protection.outlook.com [40.107.20.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DBE17598
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 03:04:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRGM1lUMf5itmBdzGs/NpLxH8XVm0XuTFR7oFVYUgSC8gfsqcGhks8iEj2CkuAs2hDA1iy68yH2InbPFHXSztxR988PYCmbTwQ4K5hzZzLGFuLikCKdTxad8Pr5kt/B/V0vl0Z2ES40yItwCJHfK5oSUA+6OCmQMFqsym44Hyqk17tahKu6bteVwQvrWLoHGRwTCNH9OFtydruak3MwyqNX0g44W7dRo8UX+LwnwJ0avKzCVnxWeQdl5ARU2YbYmWrMT6TNPHg+wG1SKXbhJdt7LcKA8z6Q/KgbxcuXJ7W4Mda7Edp97BtZM3ZXTjFItGJBnJXcaE74Uki/0Mj9Y7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tEnbRpQQLMPNNUl8X/79Gfd7W3fLrdfdqxWxjpWrlIw=;
 b=lNmPSiX1V7x8t/aSe3rmiTpv35oTNzn0UpnlSWPQO5gwkksyOO+ADjpAMUvMlEPhWNSlN5EzosTCZVPLgu7MONr+M/Lr/9oVHJQFStPNSRWB55op/dATP0t2W+89sEYJF2WoQM1Vooc4xZvYKLF5VpQR/NjrVYNx0VMM4jgw/bxWmOiZyxZgpldZab+udUPkzbvOQf0WxDDlWhIJ+w6v8+FkX5plRQLxXKQsBVwGpMCfsx9HRgxPg58k2wDkxN/eqC1CKT6/wMO9xI5M2hMMl9O2MXS2STF0D6BhqOacBUw1v0rRfe6YNpuEFcJUrvmGfPRbezcg3BrS1JwxvI4AKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEnbRpQQLMPNNUl8X/79Gfd7W3fLrdfdqxWxjpWrlIw=;
 b=o2pT5GqH1NKc1fTn8XN7VX1Q16etA1epUBbRc/ChOsGANhR5MQc51lUNgrS/x2un5kEpTIiCw9NNDNeRbElf4BSsYTFA+qy0BZWNPUuu0F2p/GMkSrp50bttM71jauYA9Y6Jcwdm1yHhgrJnXQnpcL2ZE7SSvlyPsq7paMNOH+0=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB7118.eurprd04.prod.outlook.com (2603:10a6:800:127::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Mon, 25 Jul
 2022 10:04:25 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597%3]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 10:04:25 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
CC:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] soc: imx: imx93-blk-ctrl: set priority level
Thread-Topic: [PATCH] soc: imx: imx93-blk-ctrl: set priority level
Thread-Index: AQHYn9q2XCdDIKjK3k6IbfZ3hVw/662Ox5IAgAAB5WCAAAlPAIAAB53Q
Date:   Mon, 25 Jul 2022 10:04:25 +0000
Message-ID: <DU0PR04MB9417E452C99EA1C4662A06DA88959@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220725035931.3988435-1-peng.fan@oss.nxp.com>
 <20220725085050.izj7kmgeuxxug6rh@pengutronix.de>
 <DU0PR04MB9417BBDAE35E932F7601F94788959@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20220725093056.ywr7zo37e4rbrvei@pengutronix.de>
In-Reply-To: <20220725093056.ywr7zo37e4rbrvei@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eec1304e-576b-446b-af61-08da6e250e0c
x-ms-traffictypediagnostic: VI1PR04MB7118:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WY2/Ar1UOZJkoEltf17fzeM53fbzHRT9RjmkvKRsrR4d2mPEPMHBxuJUIz7HQMJqbGOEJazpSuiLia6PAXkJ46d2wjn423rYzji8NE5tpuHztsCgVzaOj1rLpCXWLswhWvD//jKzvWTSamqzuPUmIQQ7BkszSLIjoQKHxjIQ+jYqELC+/G+wGPkwXCTPpNLZWy2Jle+8jzLLW/bl44HCKnhNgDNuYKsJWIp5Jlu180Zo3z7a8zQU09pfCRCRdxiEtCwagm+BNQARwi4+olNT2dL9lb+i1XRd/R+n5qA/cKcKt41nNv/Z/yIDd4j7znNhyLUqzGsyka8JoTgAdMofxr/4sHlYNVEhG3b5od5rrpHtLopMZTFUFCl7ID5Bk9v3cg7WKW3awPXpjFfox1AsNrz25+IgItWa5DymoAlaC70IBZwGu9hx/8HPOAAFIfUB5kdR2DB4hZbNMhDv/jYrQLYV1UzvsxVD+j6H3gfatJLZQAlU8Nk0vymdIE30UWXKboJulWdBrZZmFWVbimPpvOKH426Sdk9Mn9v1Wr9rLA8j+j9ZZhYvtcbnlssI7lBv+204/zeKxojAxtAqSwfCPIWTFDLxn8Stcx+6Ftdz/Mu5XWsIXFJeXkAf7F72HsxLH3FuRsTnYAiUP6YB+ToFQ9TXQpEMigRI20OCpK0XmaCbfffHUYtGnUlP70EBY9KHtW1mVD9DApjocSE6Hh0NBxm6NUCvKvARYFiRrUs1KLViqXfDchAQu5aGSCwRJfxapsuUNk03S9OoWUykaH1NhdhEfMdohEZRa5+lkeHN9X0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(396003)(366004)(136003)(376002)(38070700005)(6916009)(5660300002)(33656002)(316002)(54906003)(2906002)(122000001)(8936002)(7696005)(86362001)(26005)(76116006)(38100700002)(6506007)(9686003)(478600001)(186003)(83380400001)(66946007)(71200400001)(52536014)(66476007)(66556008)(66446008)(64756008)(8676002)(4326008)(55016003)(41300700001)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NQJvNdg+/uv6yfWhkMq9/gtXUOcsniqMPkmEnBZzp6qNqLEHzR7lKhByUTVj?=
 =?us-ascii?Q?BfdzikmuBFzhflLg7g2mLzLKhRwAUtxNBfiZDyc5CF38hf07Ilkn5vKt0urA?=
 =?us-ascii?Q?86VI3A/7o5XcYiKmxDA7KvmpmSYu0JUY9mDva2YyWC/tqcbS76ruFwwC31es?=
 =?us-ascii?Q?Dzstr5dr+Cnmw++9aiXGl9rMDPJPL33783nYn4D15WTddjUj8k74o6U+3nga?=
 =?us-ascii?Q?YaXFZ8ixQJ7hNgjosWuRQRmGLDDMSkDV3ToFAEeszo1q1sMq7V2fYuY83Shu?=
 =?us-ascii?Q?gjPddUCYPvLJqkk6XtvpDiPIU3sctZZAv3O8gVWLEt94KEQ8tPz36HeYxESV?=
 =?us-ascii?Q?eNimHIMHyMU+DvLUg11wwMISI9ZRbh07dp8qHIT+90Sh8PNChi9LXu2257JX?=
 =?us-ascii?Q?2DGnC12gp4+Y5qgYnZ8stigTK3nkvqAn6IKCcrN8B3+7oFfLV+DsiOyBcbrF?=
 =?us-ascii?Q?OaNEB0RJmdYyesXji/yNq73vnRRM35XJ9JBFBY1485iwBIpheRrMEU7VavEL?=
 =?us-ascii?Q?qYNnbY9gzafkubyQ1TVSwceUtY4nnhWguRDLOUJa2EN6wRF6OLaVp3b1irup?=
 =?us-ascii?Q?7+pq7ACoD67+OD3ANmCojghOIwUwtaQOwHS0mqELhX3ja+MMwhLnU9n6jb8G?=
 =?us-ascii?Q?FmdUjZOcLUpbNAMO3f9dYShrH2ltmQKOtkGYIm7PFRDW5B68wC69xHBKZe8K?=
 =?us-ascii?Q?LgBOPQMzWzah+pPbgtQZWyTDRet3SkkMaHExcFg8v4Y8OhmpaiyzIOESRavm?=
 =?us-ascii?Q?It5CfIhKX0OfLHJ0E18scaE7YFKjAL9sA8qxRTqJlKl/94DAC686l+7y0unz?=
 =?us-ascii?Q?PEE8Haa8zifBnb1hgPM41ocv9Toti0jbgbKLg+ZnLO1wegCfHdW1TmfWnTdT?=
 =?us-ascii?Q?K3PbrPId3InSxf/hkn1SABTV4pIwagHjnTU2uGI+mK6359nvBkaWoJTxan2G?=
 =?us-ascii?Q?DVjolJgT8NV3u1OxHAIWsnNshP5r+MBMOxJSnlKwNKcOi+4OK2LdeWmfUkRD?=
 =?us-ascii?Q?P7i0Co91T3A/DVsU8RoBQ86ZISypLX0Xk4Y6rh7Fl7evn0A438zN+RbffGNm?=
 =?us-ascii?Q?aiP34IxbX8XHwjmcimGMkQOj0oEnOLkDq9WTSjOhH8IhvDEr4i8X8n66GE9H?=
 =?us-ascii?Q?nWPEQf3biuYmlr1oJc6Zq8F6DBWtl535Ll7P6d52+0YtxdM40wtbJLtkpz7d?=
 =?us-ascii?Q?nqR5D9DQIOOjuYbvXZ0XnTAYRbz9ZHiGWuOLDsfHzM/Ack26mDrwyXdRJMeD?=
 =?us-ascii?Q?9AZX31rft/IIkOyoPH1DMdzyRqOjpkanTCBvLEm+hR2obnNhid6N7r3E8nXE?=
 =?us-ascii?Q?pHLcAnkvpwc/mY/zR8ZWbPSqkeaYQY3HwMX2Bi0FPzSCb1yMq7fNY77PxsbI?=
 =?us-ascii?Q?26pDNjXwGEdtwdMFi1aAvvtuETjg/39zwtIBB22LrXyuaiC0wPzCD6krgsH/?=
 =?us-ascii?Q?awsuP1TP3aBGJ1j3haX4oR/Iph1p6ln+GxQBHann1hgfFAl58cbOEqCneq1x?=
 =?us-ascii?Q?XhKTWJJrOwc50ZlcFnqabdPv0Ycbs1pqFxbPpO84uQBGSx2cSY2HkSUWH6w3?=
 =?us-ascii?Q?y0J5dtT2rumfd/0npCc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eec1304e-576b-446b-af61-08da6e250e0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2022 10:04:25.4279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4C4UeXAD2v4HJbF/d1imJc9RXo2s3Mmvv76G+wJJDY5K2ow9ukqOAQA/obnA0neLW7x87OMXijJ6N8hD/sa1Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7118
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH] soc: imx: imx93-blk-ctrl: set priority level
>=20
> On 22-07-25, Peng Fan wrote:
> > Hi Marco,
> >
> > > Subject: Re: [PATCH] soc: imx: imx93-blk-ctrl: set priority level
> > >
> > > Hi Peng,
> > >
> > > thanks for the patch.
> > >
> > > On 22-07-25, Peng Fan (OSS) wrote:
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > >
> > > > i.MX93 mediamix blk ctrl has registers to set QoS(priority) value.
> > > > It support default QoS value and cfg QoS value. Set an initial
> > > > value from i.MX design team. If LCDIF/ISI/PXP wanna a different
> > > > QoS value in future, they could use interconnect to request bandwid=
th.
> > >
> > > I need to ask here. Does the iMX93 use the same interconnect as the
> > > iMX8M* does?
> >
> > No. i.MX93 use different interconnect, it has different design, the
> > QoS priority register are distributed in blk ctrl.
>=20
> Did just the interface change e.g. how you configure the interconnect or =
is it
> a complete new interconnect?

It is different interconnect IP. The QoS(priority) register is not in a cen=
tral
place, they are spread in the mix blk ctrl register space, most blk ctrl
has QoS. By configure the register in BLK CTRL, the QoS value will flow
into the interconnect IP.

But compared with i.MX8M, it is simpler.

Regards,
Peng.

>=20
> > The reference manual would be public soon I think, then you could have
> > more information.
>=20
> Looking forward to it :)
>=20
> Regards,
>   Marco
