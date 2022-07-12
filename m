Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CA6571A8A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 14:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbiGLMxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 08:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbiGLMxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 08:53:38 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20042.outbound.protection.outlook.com [40.107.2.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C236559B;
        Tue, 12 Jul 2022 05:53:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HCczbhfgdRCQKtSg3/PIy+/i/4K4LI8Pv81YQWd0bRwz+f3OgqQWjq0oLGtnZALnjEBfNRelHAqE3mxUgLkegTHybslV97huVMsvmeF4Jrswn+YM+bLf9WC49ZJ0figByEl8DDoeRbXpv7hOed6mIMxwK7CZUx7po00mb3SAobgCYORMG0yL+rNxcVJDB24giyhxySOntVVkGxe/EKJSoeBEYjSbULEt2DxRVVxSxIG4fLImqngbnZgIapR8gAZveL7iNBT6M19ukovk7pvtFLM3cX04NmSshws3G+KoZBWVkNTRPC5KPAZcgemjaU5BIDjildrc+C4g14PRwOOC+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gHwoE9VPZ0YGhbDwTWEUxG7cg2ed2DM3ws7+AxuEw8g=;
 b=kCF5VilInFn9LJa2ehLbXSNMGc4He7MxkAjMUnjC6BCoGLoGbFbl5coOSd3mWz2fX5TDr2gPJyx+Bk62L9+Hg6Gnas5Pa5h847STTSYM0bLJ7vkDd3/n7+Ppgd2hYIwPzC6xREBBJbqs1PozKSqQX/q1M4N3l/L7GtJXtj3n+i3mdtAzVMQ/MaM/JBkJ9I0yBDsbpYJLA5K7c6YEaqjbDLdX03Z8uVbOQK1DbQ6Zu5a3f5SmMdznUocxdPXZjoCUmWQ8X+w57yONgbgAbT0YdydL5vMzSyFI0sS7pgEi8CI79puIr3BJ2BKHBl0yOnQwMXhLkh0nP9+LU+73rEbSQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHwoE9VPZ0YGhbDwTWEUxG7cg2ed2DM3ws7+AxuEw8g=;
 b=Uy6/A/nsag3FIiyiu76cRUqWOb5WcZRYFcQ99fYv1M3tqUFNyND4mF4ffUa1Z6JyqcFZgp8FI+qTpLGQ7up91/DnMw2E3SL6O9axefx8/LZr5xX/Z3gd6cr+HIxjuo77xGMR9WGEbI3ISBbVdMUb0ZXwKaJ+TKcvlU1oai0dQ68=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB7PR04MB4106.eurprd04.prod.outlook.com (2603:10a6:5:19::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Tue, 12 Jul
 2022 12:53:32 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%7]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 12:53:32 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Adam Ford <aford173@gmail.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marek Vasut <marex@denx.de>,
        "paul.elder@ideasonboard.com" <paul.elder@ideasonboard.com>,
        "Markus.Niebel@ew.tq-group.com" <Markus.Niebel@ew.tq-group.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>
Subject: RE: [PATCH 2/6] dt-bindings: soc: imx: add i.MX8MP vpu blk ctrl
Thread-Topic: [PATCH 2/6] dt-bindings: soc: imx: add i.MX8MP vpu blk ctrl
Thread-Index: AQHYlcg5I5ncUTWt0EmNtwD2G/d8v616pYIAgAALWYA=
Date:   Tue, 12 Jul 2022 12:53:32 +0000
Message-ID: <DU0PR04MB94175613D62A3F626CC0A47088869@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220712082146.1192215-1-peng.fan@oss.nxp.com>
 <20220712082146.1192215-3-peng.fan@oss.nxp.com>
 <CAHCN7xLhSKQa3-ueiOz4ptg7Sp1vF3rmN5JRzqA+euVKYbZoOQ@mail.gmail.com>
In-Reply-To: <CAHCN7xLhSKQa3-ueiOz4ptg7Sp1vF3rmN5JRzqA+euVKYbZoOQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 533c8fab-cea4-4d19-14d3-08da640586cf
x-ms-traffictypediagnostic: DB7PR04MB4106:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XajTuz/CRhGI/8gEL+WcP8C9pdonKSNpaWEOrUnOT5PVzcQ6qbn7OHz6La+NjUCUWlgDfT7IE6A9Kuiqy1uDNwbct9BQn2yR94xhpDOLzBd0zncVBASmwqAVPT0egaSD9453g1gJypObiWQIOYP8tYyfOjkv9glMLZwj8yELfLXUgNyKRiUXN0Mz7C7dqjK2fYUkGUlYdX2+gSdZaApPReVani4O9/N9rYrAHApUqdNK+NRh7rSXAcVmlnU4JaVBugW1W+4KmvnLFJhZ059oR2RfpHLFTnR/ugzMXKp9Gbmgysv4cj3Cf5VJTZ5ZWntg9a7FrUg4ku4e0bbmii8z7lQyQ5r5Z821rPDtJ54CxbLzDInVNMHqe0RArIgsIn3b1uRq+CmDgq+HAqw/fVPnFli6MU/IMNxWjnh3DFGnhOsaZsYHU4ajNMDbAJN5IYVzczQP588yHaRrx2UMten3wI8JoTy7Jt+/aYJVs4cO1auvPVeH4vMtoob6tTUnTERGlUj7OP2n0CrqM3DdCnC5Q5Ben6WbsxA9yQZykAzM4rzNC9GcI/RdLmjlUoh5XIBZW/TsWGuSzK7Soeh244ehUbAelzbmnZ06lsysAEmLWWlEjYnWQy0kmhPNDUA0d2WeEQeZfJKcoagII5mLe4IFR69yPor9PIZ9KEu5tkM7m2RT7b7IS2qUUb6fSR9h4tp9b7xOuAuR3oGAsDniZAFWX2hPUrqxYvP+9A+t8256TOOk5kvhLyMYd1lJ/ljxQYtCvUseDDXXCg9MZLxhvUrgbHI7uLPZsr9m4YwPlrOiCr4cpj1OpXSlsNYPYyo42Qi09uZwegVp7URYV3FQ7X4tekbqF94uJyCSaGbgBk1aNI8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(64756008)(8676002)(966005)(66556008)(316002)(4326008)(66446008)(66476007)(66946007)(38070700005)(44832011)(45080400002)(54906003)(5660300002)(122000001)(71200400001)(76116006)(52536014)(110136005)(7416002)(478600001)(86362001)(2906002)(41300700001)(38100700002)(8936002)(6506007)(7696005)(26005)(83380400001)(55016003)(9686003)(53546011)(33656002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2wdK43ThCzG827mWtDK1EljhSUF90Bi1iXcuXGxEQa1zPdMSD2HZ/moRsVJ7?=
 =?us-ascii?Q?Ap2nMSOW1cuZ0E35mgewk1dEA4IX/yyhAtVbqxYGkmyhgtabuKgUVqXN9tB3?=
 =?us-ascii?Q?oQ1nwQ6SeDTUjYaL6DrJLHl/S6jRnrfC1gs747LMyirKNpDRoL0tQnW8zDBd?=
 =?us-ascii?Q?KxFvqVslArhfjGFEp4X5KyJq49sowAahncVAUw8iokWw9aYmpGRiC/H9pgVa?=
 =?us-ascii?Q?TSQDCDplX8OLEJmPmDOBLSJzGTk+fhEi14u90XjvLVDTMiAKKzGTa1w4wATl?=
 =?us-ascii?Q?YfrEB5pKc3S3aAzlVhZ7WOt/qNMpUPGC6C0F58i0qf0E9y+fo4dNn1sODpKo?=
 =?us-ascii?Q?LpxeDqolMpNCAA9FyncTz6QOPIaPjg6uOSH9SMblJxASeVCMZnU53WZpFCei?=
 =?us-ascii?Q?Q7uHe3LP9664xh6AX/PrFolvfMGWrZqBLQJoBa7PziJC6a8r6vZ4AMiTRZUW?=
 =?us-ascii?Q?Qm3eAwwlYfaQej4L9KEmBg+MP8D8zojGHbVS8qP4etVKccXX88iiZnk+p9kL?=
 =?us-ascii?Q?X5zImidYWvgS0yAKta0xJdeFV11DuAe5CMt42S4yJw5HCHbtmCLdl1b1Ivdq?=
 =?us-ascii?Q?BKr1A7E0luJFMc8vkQSosxVQvZqRJSFqoJLqfKFqheft07iobiWi04zXS6rz?=
 =?us-ascii?Q?rzzOKyZO9f+yvMkl+qnfXWVmnFrZvK4KhwkR0LjABXxIl7UX7RhrgE5FKjoB?=
 =?us-ascii?Q?bP9OtxlCQwXJAmSssU/08gLQd4p5LrZdXTcmjTmGVJGyJncVbbO8/fENnFzf?=
 =?us-ascii?Q?SD9cu2u6r86RJjAHKLYgKL0RPNGuyZ4vVG4KLJ68hmWOZUhfJPXZ4y4h0HkN?=
 =?us-ascii?Q?umzSOAk43/QfYBAb8brxvfk0Ic0x1XhLIxgNySODV+UrqldwNMGJEIdtnNqk?=
 =?us-ascii?Q?YOJDNnpfTGWlOC8iueJ3aznenH/vyold3fun1y0Drun1szCzuLO/cw7YPFDQ?=
 =?us-ascii?Q?+/9Uwc/SP0IBnJzH/CjaEXXu74LwHSv40cFd0oPB3UU9A/hyI0o455uyyHeh?=
 =?us-ascii?Q?hkbxdivKbAAenfbx3xtcaUFakqdn4mLVNderIH6AJZvSExIIn6+JyEhPONqc?=
 =?us-ascii?Q?HkvBAcQiRUuM8wY9kTVPKm3TcdIbuAvT+ApFNnQHdx9EPIE1WM+3JimOYI1T?=
 =?us-ascii?Q?2hO28DJWwLlyDjtld7LH/8y5rApCVrMZV7+LoRKsrsu0b0/Ws14/bq+CRCpg?=
 =?us-ascii?Q?L3jukhPIq/iuE4fYhhUH1y6n7Cr/KvaCjc6NNPkgMx7n9t3eKls57JvCAz4I?=
 =?us-ascii?Q?7Bpq7ym6a+TWdXi+8EspI1OkHn3yVZe7U8I2liNYvL8JBZWav9UKg2YT1j3/?=
 =?us-ascii?Q?ADFvCPHp9GvQLAgu3dv+wPRpMEiwhALe1Z1kl6QLLktV5NjaRGMJYrwQ3GkK?=
 =?us-ascii?Q?1Y8IQSENosvnqETDf8FhrfWM0/pc/kbAT/Jcif4bYkzk+O5KOLN73Zzp8DCR?=
 =?us-ascii?Q?ziHGLYG1umlN5ijQRKOqPPxDwEl5A8boxMDA1AiNzC/+ADQXTxAbaxlFhq2j?=
 =?us-ascii?Q?IMkOHTrYlo31Nnq3BupS+F5SP7OJkg235/gWtpK5RYzduDvxQQHjbc+zapdX?=
 =?us-ascii?Q?LKO0jhEAMJ/mlN+T8g0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 533c8fab-cea4-4d19-14d3-08da640586cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 12:53:32.5366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S+OJAxpJ+GzsZk8dsEEjDCU3TuM8WGM7hYZ2T0GZM/PJio9SvI4PZthDd4v5XJO5CzU12Imd2ipCAoTGC/0Eeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4106
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH 2/6] dt-bindings: soc: imx: add i.MX8MP vpu blk ctrl
>=20
> On Tue, Jul 12, 2022 at 3:20 AM Peng Fan (OSS) <peng.fan@oss.nxp.com>
> wrote:
> >
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > i.MX8MP VPU blk ctrl module has similar design as i.MX8MM, so reuse
> > the i.MX8MM VPU blk ctrl yaml file.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  .../soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml        | 17 ++++++++++++++---
> >  include/dt-bindings/power/imx8mp-power.h        |  4 ++++
> >  2 files changed, 18 insertions(+), 3 deletions(-)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-
> ctrl.ya
> > ml
> > b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-
> ctrl.ya
> > ml index 26487daa64d9..edbd267cdd67 100644
> > ---
> > a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-
> ctrl.ya
> > ml
> > +++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-
> ctr
> > +++ l.yaml
> > @@ -4,20 +4,22 @@
> >  $id:
> >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevic
> > etree.org%2Fschemas%2Fsoc%2Fimx%2Ffsl%2Cimx8mm-vpu-blk-
> ctrl.yaml%23&am
> >
> p;data=3D05%7C01%7Cpeng.fan%40nxp.com%7Cc99b7cd9f40b4e5ecf8a08da6
> 3ffb350
> > %7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63793224713390
> 0894%7CUnk
> >
> nown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6I
> k1haWw
> >
> iLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DuiVz0so%2BdmCPhOu
> I3Lf1cJBfs0
> > kmBYa5J4Ak8uWxk%2Fk%3D&amp;reserved=3D0
> >  $schema:
> >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevic
> > etree.org%2Fmeta-
> schemas%2Fcore.yaml%23&amp;data=3D05%7C01%7Cpeng.fan%40
> >
> nxp.com%7Cc99b7cd9f40b4e5ecf8a08da63ffb350%7C686ea1d3bc2b4c6fa92
> cd99c5
> >
> c301635%7C0%7C0%7C637932247133900894%7CUnknown%7CTWFpbGZsb
> 3d8eyJWIjoiM
> >
> C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000
> %7C%7C
> > %7C&amp;sdata=3D4y71i22hEKKd8D16qHOMsK%2F%2FDfsV1IL17iioMm9lw
> %2Fk%3D&amp
> > ;reserved=3D0
> >
> > -title: NXP i.MX8MM VPU blk-ctrl
> > +title: NXP i.MX8MM/P VPU blk-ctrl
> >
> >  maintainers:
> >    - Lucas Stach <l.stach@pengutronix.de>
> >
> >  description:
> > -  The i.MX8MM VPU blk-ctrl is a top-level peripheral providing access
> > to
> > +  The i.MX8MM/P VPU blk-ctrl is a top-level peripheral providing
> > + access to
> >    the NoC and ensuring proper power sequencing of the VPU peripherals
> >    located in the VPU domain of the SoC.
> >
> >  properties:
> >    compatible:
> >      items:
> > -      - const: fsl,imx8mm-vpu-blk-ctrl
> > +      - enum:
> > +          - fsl,imx8mm-vpu-blk-ctrl
> > +          - fsl,imx8mp-vpu-blk-ctrl
> >        - const: syscon
> >
> >    reg:
> > @@ -47,6 +49,15 @@ properties:
> >        - const: g2
> >        - const: h1
> >
> > +  interconnects:
> > +    maxItems: 3
> > +
> > +  interconnect-names:
> > +    items:
> > +      - const: g1
> > +      - const: g2
> > +      - const: h1
> > +
> >  required:
> >    - compatible
> >    - reg
> > diff --git a/include/dt-bindings/power/imx8mp-power.h
> > b/include/dt-bindings/power/imx8mp-power.h
> > index 14b9c5ac9c82..11d43fc7a18e 100644
> > --- a/include/dt-bindings/power/imx8mp-power.h
> > +++ b/include/dt-bindings/power/imx8mp-power.h
> > @@ -52,4 +52,8 @@
> >  #define IMX8MP_HDMIBLK_PD_HDCP                         7
> >  #define IMX8MP_HDMIBLK_PD_HRV                          8
> >
> > +#define IMX8MP_VPUBLK_PD_G1                            0
> > +#define IMX8MP_VPUBLK_PD_G2                            1
> > +#define IMX8MP_VPUBLK_PD_H1                            2
>=20
> Is H1 even correct for 8MP? The TRM calls the encoder a VC800E.  Since th=
e
> Encoder on the 8MM is a Hantro H1, this might add confusion if people sta=
rt
> thinking they are the same.

VC8000E should be used, I'll update.

Thanks,
Peng.

> > +
> >  #endif
> > --
> > 2.25.1
> >
