Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3FA4C6027
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 01:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbiB1Ak3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 19:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiB1Ak1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 19:40:27 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80078.outbound.protection.outlook.com [40.107.8.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCBC41994;
        Sun, 27 Feb 2022 16:39:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M59Sv+GNz7/TWLx2Aw91p3/y9gcguYlp9T0CrZyrSbqLr7C4WR2G/1asjVH71GgL6tnNR+Y5h3TaGRnXvdyB1K/Gk5pV7sEdgJKXIsD1gJrvAbWHZgvYgFizVmGLKqszjB5uSU7OoRAOdyWWMTcgAhPcszWdoeZKgTDadiI+XrrxrZdhOJGOlySNHgrrUV+TV4GWZcROsxNnLMvU9GXSDN8Mo1BiDG03aOxOMpCrRkICHjPgo/NGHvJT9pU1v1sNT4ERbPIFch6wOvKX4dbDOq7GAvUOpBh1lOBNyKb86Qx5PX3oB6mBHDXWg+1APm5QdJ8cdR7J0v7eWA8kyR2fSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XtHGyxuoJ3bZwBfJNXEZXsFVfA8xL7j6EinM79hhU3o=;
 b=ighcCA5rFHzfvF4blIRM75GKmjrHTuJTBhGaunZEAuy4kevF1gwt4uCDZJ7SBT8lIn8ZicU1Eo7IqTFPLzJTqapm4o5jd8FHa8ob8w7eOpN5TTSqPW39Lva6utLsMbPT++th6V3XAI9Q+kW6Wy2b2jnxS1XLJGhn8tCb7XGZEZzvLPHcCAyPIs6CUo2BJu2zn4KdDA57jov8vy/9xQlTDaFCL+emrJTjQFqWWscceSHe9aLMjtBIoR8LOiEgGOw6LiABtF3yzbjjUmKmFBeN3AhulxECFTi0soeFxPU4KZF93KYa77SevssuOWDq3/vf6SGH7Fc9uMcE+yRwEvDqOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XtHGyxuoJ3bZwBfJNXEZXsFVfA8xL7j6EinM79hhU3o=;
 b=G1LX7sp67hLGeoj1yO215ZlPzXAmfewPpKZP/QNIoS80ucrcBoRvVJAL2bSI6toEdiFzEOPQUB9kHaJTkIyOhYJhtLWUI4EGd9GgcB+ZCw1Xg0YpDPHD+orSKRizl7qfep/+jwpQHoIOch1SF9oS7QlaDjJvZZJIE2cR3ZqTOVs=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB4815.eurprd04.prod.outlook.com (2603:10a6:803:5d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Mon, 28 Feb
 2022 00:39:45 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Mon, 28 Feb 2022
 00:39:45 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/3] clk: imx8mp: remove SYS PLL 1/2 clock gates
Thread-Topic: [PATCH 3/3] clk: imx8mp: remove SYS PLL 1/2 clock gates
Thread-Index: AQHYKh/pjVRxh52TuUCry9PuZTCQ2qykVYuAgAPL2kA=
Date:   Mon, 28 Feb 2022 00:39:45 +0000
Message-ID: <DU0PR04MB9417D1BF8C068E5636C60F9E88019@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220225081733.2294166-1-peng.fan@oss.nxp.com>
 <20220225081733.2294166-4-peng.fan@oss.nxp.com> <YhjpIbIVf7DQh/Ja@abelvesa>
In-Reply-To: <YhjpIbIVf7DQh/Ja@abelvesa>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07d462d8-5b51-4450-d986-08d9fa52d15b
x-ms-traffictypediagnostic: VI1PR04MB4815:EE_
x-microsoft-antispam-prvs: <VI1PR04MB4815E18A58E3EB992A67DCA588019@VI1PR04MB4815.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0Y0NnW2cmzZ377idCPxVA2JJCkXM2N7v0pTeFRoCBU3Wb8cYX6MhSaRosBe8L+T4PgAb9lqi//1SMpmNdKgcoqHs1ZTP9+/PVePUnxHTgRQgq8UEtLCrxSGw3ISUDsVtSOmaA93S9Ij4XTfrkLFzSRZUiNkXST3IQMRlqIws1Z2tHC4X/KXs5tnDUPqqETiXhUsiwURMrn0UY2ycqcvbflEUCXbx5TAv6S3F43XDGf/buJq4C0F50wkk2rlNICYhWIQdUQB/a2ND6iXdsD9WQZSIf3/CrMzRD7S6HIgQc69T8eow/VzjQCvEDxMsBcfR8lLgYwRRPeAzk30pW69dPJsJ64k7NcoGRsV/s4+ev8HsrFPJTHdHYLJ1bTANc6+KqQ8/35C9IqRUASLg//r/PbZGTZDeUFgrSGjE5KnQeatfEGNOP8BFQt6unOkfYW62qC5FirA5Q0kDNEqiPkpaJCf4SyvFzMo+iP+AJjAEOSyfptbabbuAT2AWWRGESnp+LOFyJa131INMogzYofP/Ltke8RZ4+feIdpodRjFMc58PBQwf9zJMypnUFB5x1LWK0b0WwCN23M8S8R1SO++Dt6OS2tq3hQwfBZQMLwTXmf2N23ix47b9+4sz+mtu8ddXYzG3tPbldRn+Lz5em0QY0BJMVQDj2QMHCY2hIZpHihC5haLmq7Kry7jF6Hlhg1itZJeLLGaHuilNBvb/uwUfzv3waJ1aN2p3yFLPenkXFjM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(83380400001)(33656002)(38070700005)(122000001)(2906002)(6506007)(7696005)(9686003)(54906003)(110136005)(86362001)(508600001)(316002)(55016003)(76116006)(26005)(71200400001)(66946007)(7416002)(53546011)(66556008)(8936002)(66476007)(66446008)(64756008)(52536014)(8676002)(4326008)(44832011)(186003)(38100700002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rxaO/yonOZLFR2FJcW0XpdDaAQLH4zfO1E2ZQG1pSYkGeGvyE38ZPEE/4MtW?=
 =?us-ascii?Q?hAo2U9O0EfIQyYXkhqfmNA2H7u5OE3bgRwZxIh5BCsI/0JjTYI7vkMt+KtZE?=
 =?us-ascii?Q?SGTMtMxBT01KR5VLq15TIo2BpKmbhwwBsgnrKdrPFy4cWWu9AXhY3qAxO47E?=
 =?us-ascii?Q?jgnaDyfAcamMWF8BfXYV5DDm/VR1L68WbVhXmkSoYARCdlVyRI3meCdiZOP4?=
 =?us-ascii?Q?r05zS/gVwFNGRhydV87o9pPLqwfF0npN3O5leU6u6SwrhgCxDeea1PQnoAK9?=
 =?us-ascii?Q?KVMadiHwcI/03X0ecYQA4r5uqrUaDJx6ce1h+Qmf1xEv9pqDNmTr9Ap9Aj+Z?=
 =?us-ascii?Q?grOjUEaMaXrafLb1hsRyU8fb2crcVNoUHqGN4GLJjzoNgOkTUvDiJHw2Tn/h?=
 =?us-ascii?Q?wSjuqI2LEMo3WJnxdvBj1nnBQtL6RbyIO6qoNES8/mVajooFtQBDY5Dmq8ZZ?=
 =?us-ascii?Q?6zpt3cNpuV+0wU6OETWZgJ43NUox9VlA6QzGw7RulN+59ApCD0GpabSJzfr5?=
 =?us-ascii?Q?jZqsKUhJXoOjP+FZUCBIjCDZ0oAkMzk0zkWVsm/lAzf4o+KfcLTv2TJN7vuK?=
 =?us-ascii?Q?/7XcxECZFOzqlri82ju1qG7ecyzTEQIICCGNd3TIMYbPUz0LAcRJThzwz9xw?=
 =?us-ascii?Q?NLOv6LgVasIeS0bnFGGhsHde7hPaIlB0fiLpqImLCuBks/Tz+VryzaIeLMlH?=
 =?us-ascii?Q?sSHn2Brxg0hJ5Gf4C2P5TyiUW6brHtZY0a3vEWs9LNSRsAcn8igCf1yYCmrh?=
 =?us-ascii?Q?pq3vzTZ4ZIMRjPqABZ0q7bHuWpv2H10liQNlPHYWikkg4NBVhhO9gYeEp+UD?=
 =?us-ascii?Q?tkyFkUCES2gx6obbRn/0DYMjnawB5STGcFrUHhq1zLSSa45QOx8BuPNCS88N?=
 =?us-ascii?Q?AdQ68wO6H3V2m+YZMdJjW0PPAXix5uqNR+Mgv1eYBCZul5Eo12Qu63F07jVK?=
 =?us-ascii?Q?osLH0ZuBu8OHte2+jK42BFp/XL2OrAfVbO80DPWNRxSU+q2EpWr5lb/J40v6?=
 =?us-ascii?Q?WFe9w8zvXRQtcEbcJEM5yICqY1D3aKMJ2ROQ5MOg7oMePGfgUf73lhvMvW/i?=
 =?us-ascii?Q?7/72kuPQDiK01v1JyyuQy4BIi2XziZUPIHgkd33JCmqU42UPF81MQOwHAOIS?=
 =?us-ascii?Q?vR0P5UrGzL4RPaNJpwg0UEtZcGteuyuS6bz6mMQq1tKdCLgvrlsLAWOec1Wx?=
 =?us-ascii?Q?I9XWV8bN7eKTK4YHudWk4iOS1uPV7asbGI/tKxdzLflPV4BKTwVaYnycK7wK?=
 =?us-ascii?Q?PLlcpRNcrEhbKSE8tOhWdqB+dM/yEmHfScZZp9d4wBaqBUjD1aPTbg7c0BN4?=
 =?us-ascii?Q?xJW8hv8STv4Cs1uHAf0yI50u7ECMyVUd8EuuKNqimDSNVtVn+uRNu+UdZKuY?=
 =?us-ascii?Q?wgkpBMEjeqC/4BHmE4ZMtEY8FBQfafTSPyWknDKHR2BLNkMqVxABIkMjWVEi?=
 =?us-ascii?Q?J+2t9Qd6MUM4Xf5dj7Xj1HpaJ894rbk1nbSQWGLLk0AFZ/ft2Y5g0Q0RhHva?=
 =?us-ascii?Q?9haX3Y/Tv0h55chSgJfdR+vor3nkKovYWXyQl+J+5OndeBPIJKNkCqJXKh7B?=
 =?us-ascii?Q?GIg1/0CHZuI0rZN5SQ6ZbWUnCk64O2FOGHHkOg4B1M7X0sX02d4ISqY7o1Ue?=
 =?us-ascii?Q?MQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07d462d8-5b51-4450-d986-08d9fa52d15b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2022 00:39:45.5262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JdDKQvgmwObnKSz1MnvfSWIXYbwya6/otjOX84hh9VPP7qHkIKTs5vKGUxxElvKGaeJlbbYM5QGVRH5U5ppCfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4815
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abel,

> Subject: Re: [PATCH 3/3] clk: imx8mp: remove SYS PLL 1/2 clock gates
>=20
> On 22-02-25 16:17:33, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Remove the PLL 1/2 gates as it make AMP clock management harder
> > without obvious benifit.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/clk/imx/clk-imx8mp.c | 48
> > ++++++++++++------------------------
> >  1 file changed, 16 insertions(+), 32 deletions(-)
> >
> > diff --git a/drivers/clk/imx/clk-imx8mp.c
> > b/drivers/clk/imx/clk-imx8mp.c index f23b92906d3b..18f5b7c3ca9d
> 100644
> > --- a/drivers/clk/imx/clk-imx8mp.c
> > +++ b/drivers/clk/imx/clk-imx8mp.c
> > @@ -480,44 +480,28 @@ static int imx8mp_clocks_probe(struct
> platform_device *pdev)
> >  	hws[IMX8MP_ARM_PLL_OUT] =3D imx_clk_hw_gate("arm_pll_out",
> "arm_pll_bypass", anatop_base + 0x84, 11);
> >  	hws[IMX8MP_SYS_PLL3_OUT] =3D imx_clk_hw_gate("sys_pll3_out",
> > "sys_pll3_bypass", anatop_base + 0x114, 11);
> >
> > -	hws[IMX8MP_SYS_PLL1_40M_CG] =3D
> imx_clk_hw_gate("sys_pll1_40m_cg", "sys_pll1_bypass", anatop_base + 0x94,
> 27);
>=20
> Hmm, isn't there a chance that u-boot might gate these? Then, in kernel y=
ou
> won't have a way to ungate them, leaving the consumers hanging.

Both NXP and Upstream U-Boot not touch these bits. With the CG managed
by Linux, it is hard to support AMP. This is same to Lucas's patch to
clk-imx8mq.c to drop the gate.

The other method to support AMP well, is to add the CGs clk in device tree =
node
for Mcore. But we still need a method to support M core booted in U-Boot, a=
nd
linux may gate off the clock.

Thanks,
Peng.

>=20
> > -	hws[IMX8MP_SYS_PLL1_80M_CG] =3D
> imx_clk_hw_gate("sys_pll1_80m_cg", "sys_pll1_bypass", anatop_base + 0x94,
> 25);
> > -	hws[IMX8MP_SYS_PLL1_100M_CG] =3D
> imx_clk_hw_gate("sys_pll1_100m_cg", "sys_pll1_bypass", anatop_base +
> 0x94, 23);
> > -	hws[IMX8MP_SYS_PLL1_133M_CG] =3D
> imx_clk_hw_gate("sys_pll1_133m_cg", "sys_pll1_bypass", anatop_base +
> 0x94, 21);
> > -	hws[IMX8MP_SYS_PLL1_160M_CG] =3D
> imx_clk_hw_gate("sys_pll1_160m_cg", "sys_pll1_bypass", anatop_base +
> 0x94, 19);
> > -	hws[IMX8MP_SYS_PLL1_200M_CG] =3D
> imx_clk_hw_gate("sys_pll1_200m_cg", "sys_pll1_bypass", anatop_base +
> 0x94, 17);
> > -	hws[IMX8MP_SYS_PLL1_266M_CG] =3D
> imx_clk_hw_gate("sys_pll1_266m_cg", "sys_pll1_bypass", anatop_base +
> 0x94, 15);
> > -	hws[IMX8MP_SYS_PLL1_400M_CG] =3D
> imx_clk_hw_gate("sys_pll1_400m_cg", "sys_pll1_bypass", anatop_base +
> 0x94, 13);
> >  	hws[IMX8MP_SYS_PLL1_OUT] =3D imx_clk_hw_gate("sys_pll1_out",
> > "sys_pll1_bypass", anatop_base + 0x94, 11);
> >
> > -	hws[IMX8MP_SYS_PLL1_40M] =3D
> imx_clk_hw_fixed_factor("sys_pll1_40m", "sys_pll1_40m_cg", 1, 20);
> > -	hws[IMX8MP_SYS_PLL1_80M] =3D
> imx_clk_hw_fixed_factor("sys_pll1_80m", "sys_pll1_80m_cg", 1, 10);
> > -	hws[IMX8MP_SYS_PLL1_100M] =3D
> imx_clk_hw_fixed_factor("sys_pll1_100m", "sys_pll1_100m_cg", 1, 8);
> > -	hws[IMX8MP_SYS_PLL1_133M] =3D
> imx_clk_hw_fixed_factor("sys_pll1_133m", "sys_pll1_133m_cg", 1, 6);
> > -	hws[IMX8MP_SYS_PLL1_160M] =3D
> imx_clk_hw_fixed_factor("sys_pll1_160m", "sys_pll1_160m_cg", 1, 5);
> > -	hws[IMX8MP_SYS_PLL1_200M] =3D
> imx_clk_hw_fixed_factor("sys_pll1_200m", "sys_pll1_200m_cg", 1, 4);
> > -	hws[IMX8MP_SYS_PLL1_266M] =3D
> imx_clk_hw_fixed_factor("sys_pll1_266m", "sys_pll1_266m_cg", 1, 3);
> > -	hws[IMX8MP_SYS_PLL1_400M] =3D
> imx_clk_hw_fixed_factor("sys_pll1_400m", "sys_pll1_400m_cg", 1, 2);
> > +	hws[IMX8MP_SYS_PLL1_40M] =3D
> imx_clk_hw_fixed_factor("sys_pll1_40m", "sys_pll1_out", 1, 20);
> > +	hws[IMX8MP_SYS_PLL1_80M] =3D
> imx_clk_hw_fixed_factor("sys_pll1_80m", "sys_pll1_out", 1, 10);
> > +	hws[IMX8MP_SYS_PLL1_100M] =3D
> imx_clk_hw_fixed_factor("sys_pll1_100m", "sys_pll1_out", 1, 8);
> > +	hws[IMX8MP_SYS_PLL1_133M] =3D
> imx_clk_hw_fixed_factor("sys_pll1_133m", "sys_pll1_out", 1, 6);
> > +	hws[IMX8MP_SYS_PLL1_160M] =3D
> imx_clk_hw_fixed_factor("sys_pll1_160m", "sys_pll1_out", 1, 5);
> > +	hws[IMX8MP_SYS_PLL1_200M] =3D
> imx_clk_hw_fixed_factor("sys_pll1_200m", "sys_pll1_out", 1, 4);
> > +	hws[IMX8MP_SYS_PLL1_266M] =3D
> imx_clk_hw_fixed_factor("sys_pll1_266m", "sys_pll1_out", 1, 3);
> > +	hws[IMX8MP_SYS_PLL1_400M] =3D
> imx_clk_hw_fixed_factor("sys_pll1_400m",
> > +"sys_pll1_out", 1, 2);
> >  	hws[IMX8MP_SYS_PLL1_800M] =3D
> imx_clk_hw_fixed_factor("sys_pll1_800m",
> > "sys_pll1_out", 1, 1);
> >
> > -	hws[IMX8MP_SYS_PLL2_50M_CG] =3D
> imx_clk_hw_gate("sys_pll2_50m_cg", "sys_pll2_bypass", anatop_base +
> 0x104, 27);
> > -	hws[IMX8MP_SYS_PLL2_100M_CG] =3D
> imx_clk_hw_gate("sys_pll2_100m_cg", "sys_pll2_bypass", anatop_base +
> 0x104, 25);
> > -	hws[IMX8MP_SYS_PLL2_125M_CG] =3D
> imx_clk_hw_gate("sys_pll2_125m_cg", "sys_pll2_bypass", anatop_base +
> 0x104, 23);
> > -	hws[IMX8MP_SYS_PLL2_166M_CG] =3D
> imx_clk_hw_gate("sys_pll2_166m_cg", "sys_pll2_bypass", anatop_base +
> 0x104, 21);
> > -	hws[IMX8MP_SYS_PLL2_200M_CG] =3D
> imx_clk_hw_gate("sys_pll2_200m_cg", "sys_pll2_bypass", anatop_base +
> 0x104, 19);
> > -	hws[IMX8MP_SYS_PLL2_250M_CG] =3D
> imx_clk_hw_gate("sys_pll2_250m_cg", "sys_pll2_bypass", anatop_base +
> 0x104, 17);
> > -	hws[IMX8MP_SYS_PLL2_333M_CG] =3D
> imx_clk_hw_gate("sys_pll2_333m_cg", "sys_pll2_bypass", anatop_base +
> 0x104, 15);
> > -	hws[IMX8MP_SYS_PLL2_500M_CG] =3D
> imx_clk_hw_gate("sys_pll2_500m_cg", "sys_pll2_bypass", anatop_base +
> 0x104, 13);
> >  	hws[IMX8MP_SYS_PLL2_OUT] =3D imx_clk_hw_gate("sys_pll2_out",
> > "sys_pll2_bypass", anatop_base + 0x104, 11);
> >
> > -	hws[IMX8MP_SYS_PLL2_50M] =3D
> imx_clk_hw_fixed_factor("sys_pll2_50m", "sys_pll2_50m_cg", 1, 20);
> > -	hws[IMX8MP_SYS_PLL2_100M] =3D
> imx_clk_hw_fixed_factor("sys_pll2_100m", "sys_pll2_100m_cg", 1, 10);
> > -	hws[IMX8MP_SYS_PLL2_125M] =3D
> imx_clk_hw_fixed_factor("sys_pll2_125m", "sys_pll2_125m_cg", 1, 8);
> > -	hws[IMX8MP_SYS_PLL2_166M] =3D
> imx_clk_hw_fixed_factor("sys_pll2_166m", "sys_pll2_166m_cg", 1, 6);
> > -	hws[IMX8MP_SYS_PLL2_200M] =3D
> imx_clk_hw_fixed_factor("sys_pll2_200m", "sys_pll2_200m_cg", 1, 5);
> > -	hws[IMX8MP_SYS_PLL2_250M] =3D
> imx_clk_hw_fixed_factor("sys_pll2_250m", "sys_pll2_250m_cg", 1, 4);
> > -	hws[IMX8MP_SYS_PLL2_333M] =3D
> imx_clk_hw_fixed_factor("sys_pll2_333m", "sys_pll2_333m_cg", 1, 3);
> > -	hws[IMX8MP_SYS_PLL2_500M] =3D
> imx_clk_hw_fixed_factor("sys_pll2_500m", "sys_pll2_500m_cg", 1, 2);
> > +	hws[IMX8MP_SYS_PLL2_50M] =3D
> imx_clk_hw_fixed_factor("sys_pll2_50m", "sys_pll2_out", 1, 20);
> > +	hws[IMX8MP_SYS_PLL2_100M] =3D
> imx_clk_hw_fixed_factor("sys_pll2_100m", "sys_pll2_out", 1, 10);
> > +	hws[IMX8MP_SYS_PLL2_125M] =3D
> imx_clk_hw_fixed_factor("sys_pll2_125m", "sys_pll2_out", 1, 8);
> > +	hws[IMX8MP_SYS_PLL2_166M] =3D
> imx_clk_hw_fixed_factor("sys_pll2_166m", "sys_pll2_out", 1, 6);
> > +	hws[IMX8MP_SYS_PLL2_200M] =3D
> imx_clk_hw_fixed_factor("sys_pll2_200m", "sys_pll2_out", 1, 5);
> > +	hws[IMX8MP_SYS_PLL2_250M] =3D
> imx_clk_hw_fixed_factor("sys_pll2_250m", "sys_pll2_out", 1, 4);
> > +	hws[IMX8MP_SYS_PLL2_333M] =3D
> imx_clk_hw_fixed_factor("sys_pll2_333m", "sys_pll2_out", 1, 3);
> > +	hws[IMX8MP_SYS_PLL2_500M] =3D
> imx_clk_hw_fixed_factor("sys_pll2_500m",
> > +"sys_pll2_out", 1, 2);
> >  	hws[IMX8MP_SYS_PLL2_1000M] =3D
> > imx_clk_hw_fixed_factor("sys_pll2_1000m", "sys_pll2_out", 1, 1);
> >
> >  	hws[IMX8MP_CLK_A53_DIV] =3D
> imx8m_clk_hw_composite_core("arm_a53_div",
> > imx8mp_a53_sels, ccm_base + 0x8000);
> > --
> > 2.25.1
> >
