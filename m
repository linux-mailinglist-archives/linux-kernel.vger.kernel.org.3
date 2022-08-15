Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6216592AA3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 10:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbiHOH7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 03:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiHOH7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 03:59:10 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70073.outbound.protection.outlook.com [40.107.7.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D441DA73;
        Mon, 15 Aug 2022 00:59:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1zUdrrKFaSIN3JZk2lNrZCpA06CCz8F8vqQwY03iz1XT177ZiPqVtr3ioBX5RQ/cc7RYKPI1dR0TuhfRzclpQ3jMUcwAozIMqX2bOrK81G8t2CPkJcICsqp9r0IDgSNpgghD/u9Mq4T9IIkiMRkxQqzm1zAC69hbUw+0V1avJnEwM31ZGE7joBFFsMMxMGbmPO6VjzMI/woerA/7S9l/bFtcVnagh3XEQ4/3EyfQITcTv5n9FdtE4bbhhiL84VMHuidL7+J3gxP9PptF22JhXutRnT9LHbCvwmJFkJfvbgrPPoQ2Q+Ik19YVuYGVXnLzQlkRALtN9Krctw23xbJ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Inn4xH9c8tBjTTgWBs+mvCzdb/LzliO2RaL54StVzfs=;
 b=dBtWUqNh3u2pjRMTpM4yUBxzSskLrI6TE/4ImXS08Kwol721P3gBuYiU0CIDIYeL5VEhwc5tj/sLnzhfmNKAd3n1qMY0pUN23ycZd47b3AowoG4m6/2pEKpjdI5lZeV9q1adUOr0XbDO+jMJIbPHPp8naoRt2XNEa/D6PGA9xIv6HARCYKRARXeTBaCOcLD2srJUoAEtK1lBYOaSbib11xdhav5wKQ7TtFe5bvYhrISHlRhsT8JB+7nojV3ldoSnsmgrgB/zYUPylP9o1k8opxaIT/e7XPPUbthXDhkdMc/n7/pQxUiF6IWHvfLJRfQJ+ayPOoKmVATVglLObMeNJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Inn4xH9c8tBjTTgWBs+mvCzdb/LzliO2RaL54StVzfs=;
 b=mE2DWy4hcHtzCgVPIZHd88kQxckklbavq9DqNiQlSTrwZ/gVNRNXFZRWTd2VzAg4D4xK/SceHG8FsMchL6+QqmMnVTRq6O3NeMSEkgjXmFfUD8oijt/jjFUOs2/TLICeS0IyDMzpgj4d6L0GvJx93gcAzZ4Ws3f5NRJ0g+jQ+z8=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM5PR04MB3059.eurprd04.prod.outlook.com (2603:10a6:206:b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.27; Mon, 15 Aug
 2022 07:59:06 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5525.011; Mon, 15 Aug 2022
 07:59:06 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Abel Vesa <abel.vesa@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "abelvesa@kernel.org" <abelvesa@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ye Li <ye.li@nxp.com>
Subject: RE: [PATCH V2] clk: imx8mp: tune the order of enet_qos_root_clk
Thread-Topic: [PATCH V2] clk: imx8mp: tune the order of enet_qos_root_clk
Thread-Index: AQHYsEbvQWxYY3ZlFUCiyhkgScPOJ62vmPmAgAAAI3A=
Date:   Mon, 15 Aug 2022 07:59:06 +0000
Message-ID: <DU0PR04MB9417BD20354981A3B690D02B88689@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220815013428.476015-1-peng.fan@oss.nxp.com>
 <Yvn8k0INnkF40Oky@linaro.org>
In-Reply-To: <Yvn8k0INnkF40Oky@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23e133f0-d07d-49ff-7ed2-08da7e9406f8
x-ms-traffictypediagnostic: AM5PR04MB3059:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 71T2v/40kCA6oECTb2DpGd0lAqWSnCANI751yuKym/aHVW+v38sxN2bq93VQgR/IeQkTjbxOIwtVWwr3AhImhI3AcTrhCIOxEgp7psV4/hRv18MuPPg0fVWBQoeddIkngNkJ/5UNsDoSjhE8s9EA/vuDfziLqg5nntp/2mtRLCYD2lM6hytDBJaJOnFffNWqjDLxhQpzXQ+TvkkgWCbxM4Ef5ZJLqmrr/2t6jqKYvxQRPRZ5KkHfLjaO8Qle+82aaMLkW7BF/GUt8X9XCqFrz7URhPdwk9IMr5R8qEil/y33PRLmalXzS9cPHejPPBc3HmWRT3tS8QHIXyJud3Mc19SDxpadhB55tS3ykA82HIH/LDq/V9o++aqllgp4DVJ8Dou8p2MUwmpEbtXzoh5e8Zwa4dHdzrCXnZqYlsBHIacR6rdY9/+Wv9uKGm9GdhYcF+dNx9mSjZDXDipzdS0si3OzsQ2rB/2NTg93jzVAgUWmKYfmyMmDzN0ZejQ29qnS1nGVdydtgXY7SlvUFchT0enb3cB6UStqD1APf5FSa44CnHEIDvYziLbyUrN0IIOvADcNYlGz+XsOb0aYi8CvyKi6Fzt6IduKjtyECRfc9UgWiFoT9gdLP9AUifUezuoLLzzgCY/2DxG2qMYTia0CLv+KfxGH4amrVvYKZlA/q17pk2d2sWeL6LMir11TjAt3HkwPnyOsm84e84EJwJG/5hLISfH+P0f6ez8u31hwt83NkNLlAReVrj8mFr6RInKvt2pEUMO7pDYe6k3SdH5+5y4s//zsKe0Jq/T3d7chhAJyQLHuUEgE7V1P6+Oj8C/lpVg1ps30JQWGNdzwmpRE5A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(33656002)(83380400001)(8676002)(9686003)(26005)(71200400001)(186003)(478600001)(8936002)(54906003)(4326008)(66556008)(76116006)(64756008)(66476007)(66946007)(316002)(66446008)(110136005)(44832011)(55016003)(5660300002)(52536014)(2906002)(7416002)(41300700001)(7696005)(38070700005)(53546011)(6506007)(86362001)(122000001)(38100700002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vxgB1vov/nXM9lTlDgd/i02n3kFZ31CdVDUQeJ630Vco7tvyJLz/z5VdLcwq?=
 =?us-ascii?Q?9S62q+qhgO3RRqov8UKVT/Qmj1y9RXns5mgisMDnb+v29c5bSUDheMrws4P6?=
 =?us-ascii?Q?fpSlr3RntCCn91Mdzlil6IWYOHvWf4RlOBB/Sl0I6vbKqrVOxJmN6LtkbM9P?=
 =?us-ascii?Q?xE4eThMrMOyK5vFsyPpfdlczfhuWLNcvObj0a8vbZoUby1XEt73MAwhAdVjp?=
 =?us-ascii?Q?RgOTykPs3oAtxIYIqif8rZVBsnl6+k0ASEmKs5okd51HVfdFa7D89C9ufS/q?=
 =?us-ascii?Q?4D6zAkwDm4NpGDNnPnGkLJ/5se+Q+KIQ2vtV6irIBrJE436OeGwoEp3dKuFD?=
 =?us-ascii?Q?fYS8aR7y95XjU36n2brmyZyAWYfOCQjo36ZlRcNv46n2PfcBqZiItfcVkZIB?=
 =?us-ascii?Q?obKprqX2W+mhbk+WGogB8VqVQRbuKra7JOfbwsI7b7gzScVj0Rn3a3aPkmUt?=
 =?us-ascii?Q?yuDN49L5i80tSeDnaD/n9jV1VOO4MGzudb+Zdgvf3ZGmvDtbL71G1hs3DFfl?=
 =?us-ascii?Q?Gnhqs2SWJSRqF3o0g3FedNNBKzzuBx+CeukEsaHsg7ivB8hPgCVr8TqL6ycx?=
 =?us-ascii?Q?XN8SBc0fyzOA7KYKaHSJr6HMcZz6ckOl0FMJGGlVBNLDvo81UgaeSmfdVU4T?=
 =?us-ascii?Q?+zY/wn0FFqsOmyYPh7x/gzEos6i0+wVVwfeGBdNDIx5CyU2O+0w8HpUSXtZY?=
 =?us-ascii?Q?ZcZ0280i5bthfivBVgn5z1L0Ubecp6SM6yzoapgxWuRRJ9fDeUBYbLIQLe4w?=
 =?us-ascii?Q?WtORcrdITjHXKy/7eqiCzuy4Ju6mutivMN4EWG9GTjumxlBFAbEc52rKkgM6?=
 =?us-ascii?Q?LCa4hK4He3NLXI7/YVIFd0s1j48qJLcR+JKfKNj6N3tALaU+7uvI1kbZzuJd?=
 =?us-ascii?Q?5In838y1jxFrHLQGAB/kidi728CRlZ6hwKk4MHLX7u6By2ifBIYImI9QlHHB?=
 =?us-ascii?Q?rwCqT7fi4jrFk8cB9e44kYuDva0gdNt13lvtmvkZEwubvsQM5etzbonGWhtI?=
 =?us-ascii?Q?E0RFTmIODyz+9gF9KcIwofDBS48DyYeIMgj6N7kRp4Wc3OkTXnzD9R0SNmAt?=
 =?us-ascii?Q?GXJvFEHpT5w3uHdZGiKM+AfsB7dLh9HeLe7uz1HTzErVgLjgN4rIG/JM7Zlu?=
 =?us-ascii?Q?8NY7zlL3D2rA3cJ/y4S2rLfhfG1eR7OWfGU4a/ChfTmQZU50BFrU4KiObEIa?=
 =?us-ascii?Q?NRUv+mDQ7TlHAMeY/sNKRTgYzmHl5i0fOyuOeN82CVzNLUKy/sSIHJSxKcc+?=
 =?us-ascii?Q?7+3iBBm+91r8CRj028A+DaGYVaZG0bUpng0R4cekD8d1O4Ya8XHM699Iigd6?=
 =?us-ascii?Q?yj8fkdcRaMe0p+IQgg+MhuUA3FzqNb9i9LiKyxuXJHGa600UrR5KTe8kDLr7?=
 =?us-ascii?Q?qZYN8wFphOZdAnU6QYYRBbejltrh9hLftePz2qVRKk5khyPHjhK0TeREgbLZ?=
 =?us-ascii?Q?XNxQEbl8d+p09k6mJLYiAQkHGxayvc2ao4AqMXwSXq3+SB4BG/j4inG1ngMX?=
 =?us-ascii?Q?zgA96kdGgmjWZDRI7Zu222evVfSAKEsuXrlgguvksbqym2MQfySztNzeHMoF?=
 =?us-ascii?Q?J3HVzKo3szsyLEEHfLY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e133f0-d07d-49ff-7ed2-08da7e9406f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2022 07:59:06.3086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sj7vRHzSpGRihQU/iVmr+hFeBU3rIl7803RrV8G7iH9apYzK0sMnn31XYKk2ingIX6p50itkh9CBZ1VrpZGlOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3059
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Abel,

> Subject: Re: [PATCH V2] clk: imx8mp: tune the order of enet_qos_root_clk
>=20
> On 22-08-15 09:34:28, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > The enet_qos_root_clk takes sim_enet_root_clk as parent. When
> > registering enet_qos_root_clk, it will be put into clk orphan list,
> > because sim_enet_root_clk is not ready.
> >
> > When sim_enet_root_clk is ready, clk_core_reparent_orphans_nolock will
> > set enet_qos_root_clk parent to sim_enet_root_clk.
> >
> > Because CLK_OPS_PARENT_ENABLE is set, sim_enet_root_clk will be
> > enabled and disabled during the enet_qos_root_clk reparent phase.
> >
> > All the above are correct. But with M7 booted early and using enet, M7
> > enet feature will be broken, because clk driver probe phase disable
> > the needed clks, in case M7 firmware not configure sim_enet_root_clk.
> >
> > And tune the order would also save cpu cycles.
> >
> > Reviewed-by: Ye Li <ye.li@nxp.com>
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
>=20
> Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
Wrong address?

Thanks,
Peng.
>=20
> > ---
> >
> > V2:
> >  Use Abel's new address
> >
> > V1:
> >  Patch got reviewed in NXP internal.
> >
> >  drivers/clk/imx/clk-imx8mp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/clk/imx/clk-imx8mp.c
> > b/drivers/clk/imx/clk-imx8mp.c index e89db568f5a8..652ae58c2735
> 100644
> > --- a/drivers/clk/imx/clk-imx8mp.c
> > +++ b/drivers/clk/imx/clk-imx8mp.c
> > @@ -665,8 +665,8 @@ static int imx8mp_clocks_probe(struct
> platform_device *pdev)
> >  	hws[IMX8MP_CLK_CAN1_ROOT] =3D
> imx_clk_hw_gate2("can1_root_clk", "can1", ccm_base + 0x4350, 0);
> >  	hws[IMX8MP_CLK_CAN2_ROOT] =3D
> imx_clk_hw_gate2("can2_root_clk", "can2", ccm_base + 0x4360, 0);
> >  	hws[IMX8MP_CLK_SDMA1_ROOT] =3D
> imx_clk_hw_gate4("sdma1_root_clk", "ipg_root", ccm_base + 0x43a0, 0);
> > -	hws[IMX8MP_CLK_ENET_QOS_ROOT] =3D
> imx_clk_hw_gate4("enet_qos_root_clk", "sim_enet_root_clk", ccm_base +
> 0x43b0, 0);
> >  	hws[IMX8MP_CLK_SIM_ENET_ROOT] =3D
> > imx_clk_hw_gate4("sim_enet_root_clk", "enet_axi", ccm_base + 0x4400,
> > 0);
> > +	hws[IMX8MP_CLK_ENET_QOS_ROOT] =3D
> > +imx_clk_hw_gate4("enet_qos_root_clk", "sim_enet_root_clk", ccm_base
> +
> > +0x43b0, 0);
> >  	hws[IMX8MP_CLK_GPU2D_ROOT] =3D
> imx_clk_hw_gate4("gpu2d_root_clk", "gpu2d_core", ccm_base + 0x4450, 0);
> >  	hws[IMX8MP_CLK_GPU3D_ROOT] =3D
> imx_clk_hw_gate4("gpu3d_root_clk", "gpu3d_core", ccm_base + 0x4460, 0);
> >  	hws[IMX8MP_CLK_UART1_ROOT] =3D
> imx_clk_hw_gate4("uart1_root_clk",
> > "uart1", ccm_base + 0x4490, 0);
> > --
> > 2.37.1
> >
