Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373384F6072
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbiDFNqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233615AbiDFNpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:45:51 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2080.outbound.protection.outlook.com [40.107.20.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F282F3D3C;
        Wed,  6 Apr 2022 03:55:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=boZyi5Ss1K4Tr0zuTpRxZJZ6INu7iIvRTGJv+w1iRZ61iUDAdBhDIvvFjNXAXXeFWemYY/qXMaXF/6dCVCWeMRI32s75fVFPJ1BB+ahIekwGWupfB/JScjARSciQBf3NwVRUgiL+cPzuxoj78UTdrK799Cve3wIHgceBo098Bhc2bWh68xtASPhaOpFXKtYZpJkqcc9Xrsb+qFkuGdeSz7rN3voV4KEoqUyZ1EGjducvHVOaAkBT5As9ruz65FaA16K72JebNIEiVGLefbQy5cYkb2FdeNTU+NzkG2nyOgX5+/m/SN60GwNfr1QRpVyhX3gf4sOiTwpmbFRkN4Yyxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+gmWceB4/H0vmOLSkqbSUE0TBVkUunV3D46wDK8Q58=;
 b=WNTuvmnSQp5UIPoDqVNMvhO+s580Q4fJ8dqeU9/ti1gX3muUW6ysvVhxCARKvvDT99BnftVCgqJo4b08nus1V1XsB9m8VJskJM4xclkYGtAfmbZ7SwGhLyO0EgY8lex34h8Mky4JGhbN7LkNEfLwlWoGDYfAUySylL5jeZ2o/C6E4MkGiSFHYZV5f4uPrx4dL21AB0bUOZOVhVV2vGKpGj+vdSHIQfBQeoUbsDZefye7Pifzn+P7VaWRokZ2x/WWIRuVnAOpUckmlHnXfRLOzywkySmLyg9CT4yZwRKC+hn2DK/nQOCo8btywVanS2e80od4i/2Tk8nR90t0NVzBuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+gmWceB4/H0vmOLSkqbSUE0TBVkUunV3D46wDK8Q58=;
 b=V19ddBEhLnt5Fia1uLBTOBpYoStCEOarNynbwwA9R/tMZnysWPvBSjnsGCHDafOFGgMTTHNStEgu/StldUXl0PiPG/VLcTofIAXidjdMRqZQvXkEulOz1UdyPs2WlgRSWSxBDx6LOb5HaRfi/LPPWBQMRqqWnWMamtpy8GWbR9o=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB7PR04MB4922.eurprd04.prod.outlook.com (2603:10a6:10:18::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 10:55:36 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::389f:e6eb:a7a2:61b6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::389f:e6eb:a7a2:61b6%7]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 10:55:36 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "djakov@kernel.org" <djakov@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
CC:     "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/5] imx: support noc settings with power domain
Thread-Topic: [PATCH 0/5] imx: support noc settings with power domain
Thread-Index: AQHYSY9XqgeQwXhCJU6yFFfpAw5XMqzio6cAgAAQnRA=
Date:   Wed, 6 Apr 2022 10:55:36 +0000
Message-ID: <DU0PR04MB9417E35732AD4B823726D84D88E79@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220406082330.2681591-1-peng.fan@oss.nxp.com>
 <6a77a71069d771d408f716d05cafc6b3a1e13cda.camel@pengutronix.de>
In-Reply-To: <6a77a71069d771d408f716d05cafc6b3a1e13cda.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e4a1bb88-bb9a-486b-df02-08da17bbfb39
x-ms-traffictypediagnostic: DB7PR04MB4922:EE_
x-microsoft-antispam-prvs: <DB7PR04MB49227C718C02AF28C8BA4AFC88E79@DB7PR04MB4922.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /gTU1ku/9/vnitiR/htk1MLCj3QkiSME54qWh7cHFueRYqYbtAN6hRW2wHuDtCAC2/SRQgUbCs4Xn0p5IszT5h/z2pj+teGg2NbgmX2CkcI1zHbBTq1a8/2Mqn/iAN1S0Qn2mYF/nhYMDnb9IDNssm/VdeWq2vlHe903iWDDqvepEmGNbDZoBbncbPbwBf8d+FcVdSX1AEq7QJp3oaUMhuWYmbCQbQ3KhNzGyQhrmhwjlf4wf8MXhJcBKCmA2lxsrp5OttoQDrd8LT9zg2q2Ox1/810DKUDTk6gsp5MBOJv/RASffrXTfPEttTAuU8vLswwYYOgYLTC7+AJJT9VBKLjJ75kAdIuciFdnKqWt2wJGFBi11l1MaAjBBuwwbwcF+GDeFY9zVnYEkwJC4RCEYOIs4anaZFSucNlLW3CUpvMZBCrbl5gU49BDZv3qlpYYeg1ZeJVG7QyapzoR4fkVPNQoIye22VbON6PPODndbdqK9ynaGepxxooRwYX4abYltHur0FdcXzsXyh24R7YanLT69zdKhJ3xWjlaK18ErrT57Ye6IJGh3kl2EcihXIVUpibBEtZog0BB96MvEsTOvMilCLgjEDdnLRx3rJZ3lHmfDqyBpfwSmyeh8bySbdFhJVWKDODnTaxTlrP6LNWs+yODJoo0u4rh4ifRJDxI9IAYF2h8LszLOLYYbOo0QMTCj4U7/oCNxREf9TM+BZ6rzw8Ba9wJCesOas8yUnlCYxImp9xBSnn23RB63SSsi+OZL+8vc4+n4SNrSNo1F205GvExPawQewUjq4cXphtvO5ngNPSiuUX7rsb0FwHNfn35
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(76116006)(66946007)(54906003)(966005)(33656002)(66556008)(4326008)(316002)(86362001)(186003)(26005)(9686003)(2906002)(5660300002)(8676002)(66446008)(83380400001)(71200400001)(508600001)(110136005)(66476007)(64756008)(6506007)(38070700005)(55016003)(122000001)(8936002)(44832011)(38100700002)(7696005)(45080400002)(52536014)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mhoN9e2VYGdS2fdORtX+bJswYxYmn+3hQt0p58Ubzi8s0QXWGmkmDnC/53if?=
 =?us-ascii?Q?+K+oHUjmbzeZ4pOg3YkyiIgSLMqKt/Mkfa9tf/OlsXDipwFeyu3vShCD+un2?=
 =?us-ascii?Q?cUyZs33zANtTCyEK2fIfVRxkZ1AAd3YftCfjvG4KC2mCKOkKqICDWoUl4XWi?=
 =?us-ascii?Q?+OLmEhzXJcgksAkevf73NaBS9BI4aXNGcIMaKmonEipJ/9nF8P5JV7WZaXsB?=
 =?us-ascii?Q?1O9LigSif3YPGiaARpPaVK+2Smt6KVXXJFUrxgft5aQBtEH1htEZsHYz2dfy?=
 =?us-ascii?Q?x1LozdMH+MF2fLEDGuNqcm/8e114qyt3R3BTsf1V/nNWC+PoLU+FMMh2wVa/?=
 =?us-ascii?Q?kuLgmqPbLqCRqoVZQV6Izf/v4kIls5kgPidpBHXq8KUarP35DFoa5zJXOE2u?=
 =?us-ascii?Q?UwI032QJ5NnUKe/t1d5DEjaJYP/Jv57gD4OVo2Dq4pNeIvOpUEVX3F2FnQ87?=
 =?us-ascii?Q?OnDObKGF5dyKoJu+iDljoJ0p07KojXYmw7yR467QuV3b8v0eKHDF2o7UyzmT?=
 =?us-ascii?Q?HDeF7HTLaXKjIk4zA9cem5h5b2c90R4g8rjmt43dMRplt0JX3gDA3FMPPbeA?=
 =?us-ascii?Q?YS4YBjkJ5jCEy18gSavlCWYfWtygRF5korFMIJ4OoB27KTOyYH35+P3c+s6/?=
 =?us-ascii?Q?39C6ZbDqv1X44Zntq2pivs2Ya9ZHWGxvEZr44knqjnKlF1nJb53kdjd/UMef?=
 =?us-ascii?Q?xH0N8XKZ81DUtF/AxrgLADNvA7uql9LIIwqYg1h7dVWzguq1b7NG/uT4+yf/?=
 =?us-ascii?Q?NUUzcmNVVTLfhpXLDwYRiSIsszpyVCVM7NhBmWmDoxOkzy/JvNE6IbZavFsf?=
 =?us-ascii?Q?sDEBc7lIB3Nneys0nWRiPTvOoM1kzubiBvLSe0V1rqOiBKBAmNtz7dnCQnwM?=
 =?us-ascii?Q?ajT8Yoi1kOePtWLlXYCL93v47B+QvhyzkIm2mDPqON1GkWnEH5Idd5jkJXri?=
 =?us-ascii?Q?77mpHJfOcbwBrYGPG1VDrZPV75akoidk5nMDCDyWxtK52nwXMhh8KDA3S2pn?=
 =?us-ascii?Q?AMo9tjnNU0D0rkaJSMVcCAAE50jHjFekWKZRsMT34qEaIhBy0HXJ/TRmg3PA?=
 =?us-ascii?Q?pb+KKct14LbQBs2dnlt9hw/oG5pwbFcdOTIvY5eBGKhiYmo0jKJxQ7DT3HxF?=
 =?us-ascii?Q?+8G4ZThSjnB07oM+n53eHW1UcAk8k5JhVHzChtEAxRLlONI2HGdiaMtQZQpF?=
 =?us-ascii?Q?kjCpkxMJ5suNikL9rVKid378xjoBAUChEtGz5QwwFSf4Gfo6v4Stsy0i7fD1?=
 =?us-ascii?Q?TjPugZ9vydzzmVbkljk51VOwvOX1F6258r5wFL+dgUZk7Ljojimu30MYdHGH?=
 =?us-ascii?Q?umCmL7rc9RWD7Xsd+lEjbyPXbPnnJYf7HpkODaPaHwoYcuM1+3Ug5Wtdzdwz?=
 =?us-ascii?Q?uVxqulGPFYLRM8089MXAO8w4K6zDoXGLU6ajFrNFAHqkXSHVKcKndXeLsDk/?=
 =?us-ascii?Q?vbT1xuTrMy1+bLO0av0pFdaBvQM0/X67xzyshkf+6+z4C5v+ZfKvCw/9gEuG?=
 =?us-ascii?Q?sz/mbB+kIU6V1YBm1HMZbF7ceGmdsCgD0nhQhDNCCYE8DzoKZhSoGO6ORLVK?=
 =?us-ascii?Q?9phT0b8TXVc2IK6kyBVYmIdHTFKXeUOqvXR4zT7+HjwWfAt/CMpUmKNzb9tH?=
 =?us-ascii?Q?yMZA2BWBswLJHoGGmqj0YrBbvk1/Kscc2vJw8indZLvYybHQ0/QLuD4LOpym?=
 =?us-ascii?Q?TXrzxkjM0FERhCdtFKZ2QbEz90x9irLrfylaS0X/wE+sZjBonnbWyGCnCc2g?=
 =?us-ascii?Q?lIBNHXHUKQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a1bb88-bb9a-486b-df02-08da17bbfb39
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2022 10:55:36.6606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4k9+jpRj8mOyQC661BSQCurO1MqcFNxP7kIozEraYW4AXzTZ/2i1ru+RcI0nuYsq9sH1OL2wM6sfwcTCVyNe3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4922
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_BL_SPAMCOP_NET,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH 0/5] imx: support noc settings with power domain
>=20
> Hi Peng,
>=20
> Am Mittwoch, dem 06.04.2022 um 16:23 +0800 schrieb Peng Fan (OSS):
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > i.MX8MP has a design that NoC(Not main NoC) is distributed in multiple
> > blocks, such as vpumix, hsiomix and etc. The access to NoC requires
> > power domain on and blk ctrl settings configured.
> >
> > So the design here is for mixes that not have blk-ctrl, configure the
> > NoC in gpcv2 driver, for mixes that have blk-ctrl, configure the NoC
> > in blk-ctrl drivers.
> >
> > This v1 patchset not apply on Shawn's tree, I picked up Lucas's HSIO
> > and Laurent's mediablk patches, then worked out this patchset:
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
h
> >
> ub.com%2FMrVan%2Flinux%2Ftree%2Fnoc-imx8mp&amp;data=3D04%7C01%7
> Cpeng.fan
> > %40nxp.com%7C3bd1d020ad8f4a68efc808da17b28ac8%7C686ea1d3bc2b
> 4c6fa92cd9
> >
> 9c5c301635%7C0%7C0%7C637848352908363591%7CUnknown%7CTWFpbG
> Zsb3d8eyJWIj
> >
> oiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3
> 000&am
> >
> p;sdata=3DZVeHFy%2FEaWPhAj%2BURGIDXoWYdX5eeQoEIeZYZoxPPNo%3D&a
> mp;reserve
> > d=3D0
> >
> > Note: This interconnect related functions not added. This patchset is
> > only to replace the function did in NXP downstream:
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fsou=
r
> >
> ce.codeaurora.org%2Fexternal%2Fimx%2Fimx-atf%2Ftree%2Fplat%2Fimx%2
> Fimx
> >
> 8m%2Fimx8mp%2Fgpc.c%3Fh%3Dlf_v2.4%23n157&amp;data=3D04%7C01%7C
> peng.fan%4
> >
> 0nxp.com%7C3bd1d020ad8f4a68efc808da17b28ac8%7C686ea1d3bc2b4c6fa
> 92cd99c
> >
> 5c301635%7C0%7C0%7C637848352908363591%7CUnknown%7CTWFpbGZs
> b3d8eyJWIjoi
> >
> MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C30
> 00&amp;
> >
> sdata=3DeLawc3SJQBRmVwcOA2%2B6u6d2ZaYxqcO4Gm%2FqEJpqxFE%3D&a
> mp;reserved=3D
> > 0
>=20
> As a general comment I think this is implemented the wrong way around.
>=20
> Neither GPC, nor the blk-ctrl should poke into the NoC registers directly=
. The
> NoC driver should attach itself to the power domain via a notifier (same =
as
> the blk-ctrl does with the GPC domains) and should do the necessary NoC
> configuration when the power domain is powered up.

If separate NoC in a standalone driver, NoC may be configured not as early =
as
power domain up. Saying lcdif is running, NoC driver probe starts w/o defer
probe.

Thanks,
Peng.


>=20
> Regards,
> Lucas
> >
> > Peng Fan (5):
> >   dt-bindings: interconnect: imx8m: Add bindings for imx8mp noc
> >   arm64: dts: imx8mp: add noc node
> >   soc: imx: gpcv2: support i.MX8MP NoC settings
> >   soc: imx: imx8m-blk-ctrl: support i.MX8MP media blk ctrl noc settings
> >   soc: imx: imx8mp-blk-ctrl: introduce HSIO blk ctrl noc settings
> >
> >  .../bindings/interconnect/fsl,imx8m-noc.yaml  |   6 +
> >  arch/arm64/boot/dts/freescale/imx8mp.dtsi     |   7 ++
> >  drivers/soc/imx/gpcv2.c                       |  56 ++++++++-
> >  drivers/soc/imx/imx8m-blk-ctrl.c              | 109
> ++++++++++++++++++
> >  drivers/soc/imx/imx8mp-blk-ctrl.c             |  74 ++++++++++++
> >  5 files changed, 251 insertions(+), 1 deletion(-)
> >
>=20

