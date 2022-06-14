Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5A854BE44
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 01:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242564AbiFNXWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 19:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiFNXWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 19:22:47 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2078.outbound.protection.outlook.com [40.107.21.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E732655D;
        Tue, 14 Jun 2022 16:22:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7fLuRSOucz7cihcuH8+pVX7tvuqq75hAyT4h49FYaxGGP/hZWeaS5wMnQu9/GhQ1Em3wg1qdzZbPUmxGvO3jphYQJJCybB50Iu1XO4yEjRcjbpQ7GHd2TRHBvFykiM4apATZ4d7BZJvCPCwHuI3bIZjeMqz7GR5lzpjRhwybBn5QvljD+QEYVHEbX08OAYb0aplf2vlAd0/T6HnW/lvDqSNymhQwUm3La/hTQPuO2Fj4/VPB9IYzvMTF7fzP9xQvYTvR6Z2YRdsBYS8F72Bc7QORtGlltUtSWAn4tW37L+Pdn1AtVtFPl8db47irBYMmOjm8il9xFVWdAc89SNssw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tf4dLODPZScqmjTnNy4z3vkPyuI8nU5RjsT1Be35BIM=;
 b=FDD3vOKJA2q0pqCvTOE3OzGG4lCZRYQY/SEzAM2sz/zYS70N5DKiztvTNcxZojAQ4fjAJO/jY0EGPoSW8e5JLMmRvE36bbj/wCJ6p2VxORg25isNumEhRJuSzJabi0SpcUyeRbSPGsT80yt7G5LmnDahFWD02UySPn7HHTJOZAmFDLhKPlu+FXF+wRqSYqvLvwX0U8CCGyGL3mT/WRxhgoOQQ8NKtUFVZ/g2UWOLAaX4CO+PUq+6A1/V7jp9qLFsyIbemZPi3XZ2BO9ia0sAzfhPHMcs/JZL1yKM8p2yzLAWNxK/LmN1Agjb+8V9OstiXO+/bEhrFN4gEjxtyvowYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tf4dLODPZScqmjTnNy4z3vkPyuI8nU5RjsT1Be35BIM=;
 b=KCqHFS5vqFuftQyWFOdJ6QXBGqw8WNGDFj+hZqHEvxMfxMSGMkQ4JGKEOWwx+waW7rdDtwMoR8/69zlHteNE7uF9b/A3Y6AjZqTqIljNDB4ImVUHmeGUyPMu6uqr6vXNqh0GGZ52Aa4tJorBALvkVUGO3H69wK+//a2CuGUWBH4=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8735.eurprd04.prod.outlook.com (2603:10a6:102:21f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.22; Tue, 14 Jun
 2022 23:22:43 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%8]) with mapi id 15.20.5332.015; Tue, 14 Jun 2022
 23:22:43 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH V4 1/7] dt-bindings: soc: add i.MX93 SRC
Thread-Topic: [PATCH V4 1/7] dt-bindings: soc: add i.MX93 SRC
Thread-Index: AQHYe/9WcK1FHwn3oEC6Wgr9BHrI561PdpGAgAAafPA=
Date:   Tue, 14 Jun 2022 23:22:43 +0000
Message-ID: <DU0PR04MB94178655FA1B5FCF96BC5DCF88AA9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220609125100.3496633-1-peng.fan@oss.nxp.com>
 <20220609125100.3496633-2-peng.fan@oss.nxp.com>
 <20220614213953.GA2693578-robh@kernel.org>
In-Reply-To: <20220614213953.GA2693578-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c6e62de-3d01-4100-942c-08da4e5cc88a
x-ms-traffictypediagnostic: PAXPR04MB8735:EE_
x-microsoft-antispam-prvs: <PAXPR04MB8735EDED5C199EE04EEAC6BB88AA9@PAXPR04MB8735.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U5xBGZAR7OKwwEEcVGEULXNU9jyu9vGGsqDE1/AWYbpDwm7uaJJh4T0juOG04sF6CzyUa5oTwU/fwIU89sMui7MOQSOdUQiY8LinA5ULLaoyjA27W0f+KxfdWZwKCZRI3jPP33o/VnwYUTRl+S7B+z4Lt8fv8Eg0qLYrsY9Kacg+CgHwmH5drvCQd02bwkCEo9mBKp9BPz+e5jfA0E7lL2U6ITiW/i/E7nHpNBtTWOkJYQQRU5/taShC4cu+GDPU15zdTSpFNQjiUc/HmNPml2n2FHRs9Uv4/+nS78c1LfMHWX+i5CT2JYI3jdXF8H6ol2HliVHmxfwD9IgEAir6M2XqbmnFtPHkjeStRoV2azFIjt2JqyIpKsl5NkMNZGluFQIxWULJylJTEbGrlvBAR+ffjXwiBFCeGrX3efv9HX5otqZhM3wUC33uvvnucjViuqU6scRboNZArWf9Wp3trz/MPeYsP0QMupHQcTAwgsBMVN5aQDQPIwRkZqFzPOoMOTV4b5k9WYYcEWme1IK48gd8OhIwnTxaeieqNdnYHDumoxwHajstTY55pEVHqnwbQhNAZfQsMCKGsoapei6GMDgX1SzQ5SpT3au8CA/DqlbXsnj18/KYoL1RfSq+XST/UuVChqkGvbd6WITVXHFoq5OUoi5K3yEA1tzARjsrvwaVXPatvRrKXgLc52vV8JSid9EOq3jG5mG6xpwqeqUcOZQe3QeagqqhPDYEyDdfCg9fPX6GXLW7gQkIXHRbrmDc/HhjIYbQJO2alRzRj+WY31u8GwudtLxGHjkUi45SBmo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(2906002)(66446008)(66556008)(38070700005)(122000001)(508600001)(8936002)(66476007)(55016003)(71200400001)(52536014)(4326008)(66946007)(76116006)(8676002)(86362001)(64756008)(45080400002)(44832011)(7416002)(33656002)(186003)(83380400001)(316002)(110136005)(9686003)(7696005)(54906003)(6506007)(5660300002)(26005)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3hkTNxDq1h+dB7Pg1o/n9DsenZ8931R7x7MAizd9NCYxFi+LD1em/YnIuua4?=
 =?us-ascii?Q?bF+e3lOTzdIvQeKKW/Cjl1PMl9SvUcFqreP0HdL6mArMumI9sWRI1XLyL1of?=
 =?us-ascii?Q?Mu9GBhlYFu8KIjPLFhiR+Zq3CzD9Lw5d/l8cdqcbRNCRT98iqJytoX7yTYcw?=
 =?us-ascii?Q?TbV8XuwB3IJjd9KMvUwJ2qMR+OecyjMzUI+Tz4XWRIA7rvIq0ikHnU4ZPSiN?=
 =?us-ascii?Q?erB+q6BK2jNMiJcxrDV1Mi95j+DWFk0HB/S7IphxcyEAg46U9kLHW9eWZs84?=
 =?us-ascii?Q?omkqhaX3hPj7FYSUyGTD2m0ppXXqzlsfkV+vXxShbnyiecsDz3vQNzJP4WXO?=
 =?us-ascii?Q?euFmGl3OFEGfg4RP+f4aePMljGjyXzXmessk4Yyf2A8aFYUhxXVXgkNBCWKd?=
 =?us-ascii?Q?GQNV7CJTrSdhxyf5a/+2XCrGToDQuER6J92cR0D3Ypu/bNrugHUPeM8KH5Ws?=
 =?us-ascii?Q?eEkmkFD9iA8qW5bzzpZ7MGUKdEXr38aBtaWQ9kixCbqkJRX5eBBVDQXTHxgz?=
 =?us-ascii?Q?AA5ZQhHxBGCTn9X+w22b2sepWlluCQwge2ZLdVU5Q5ZyCsHRDnR823YahD2t?=
 =?us-ascii?Q?/xQvxTVKfd7esB6F2V/zCUf92vT7T9Ktqk9ykEltZFRmfd0Q5np/3kqc2CXk?=
 =?us-ascii?Q?vAGtMGlR8dt+GdNWEYAe8DcHMAjMBF48dbCJiE30gFvwXfUDYvxz9ItXdL1r?=
 =?us-ascii?Q?ve/IStvTbK5tiFWpsvbzHxl4nLe1NKjFDAgnK7/SYAYhdq7Ujvhs6nsk26/I?=
 =?us-ascii?Q?8BHV3oylFcCDRiajRgrwt7QoPJOwAGlpCDziqOrQfSbFZzOwKZowUnzll0ss?=
 =?us-ascii?Q?d5aZD5iREoy3E3o4QKCkPpN1M2jEt46AdXhAuI/eEFy7pKkRCnNdlxi53Zyx?=
 =?us-ascii?Q?BRfo+MDiI7XYYCvBkOuhOS4cPLnARIwo3cpVS84qmHC6ENzqxIIksKj8KsHO?=
 =?us-ascii?Q?8xartDY6aY7xHjM6DrGwPY9M6v4aYguhsXS7amb17Jn1AMfIUKaOKlPj+3EV?=
 =?us-ascii?Q?1kxmDRkje3ZBLXDsnKOmpPn2cVQ41xbCGWl65F/p+S4IXl5tNuxQ0TO/L4Xg?=
 =?us-ascii?Q?m17vGExgNjnN9251VgYhZFvtrkQGqqxWIyEtZhOKUhPgpGQbPi7Hvzqz0JEx?=
 =?us-ascii?Q?AWwCtDNBuegfdAI3JpON3UuwOWIi1zV5NLlBv+vqKqjiffTiWIlkbdESKmCZ?=
 =?us-ascii?Q?3qcMQthwv8p0bDLaaB7XAHMS4qV5SmaV9lkW3RcJcPDBR0vkZn6C5XlvBomP?=
 =?us-ascii?Q?T6uH4tZKVWht3rUFI20V5aVFA/FAwVdF0MhfU+86XvxwW5CBK3/hAShkzcl6?=
 =?us-ascii?Q?Ux3Y0Cyp7uc6wwS2/EBwUvFt/lpYjJvTGlYFjsgidDTBKZDzOV/MHyJO+SPg?=
 =?us-ascii?Q?XuHD2xaYG4XiIGYAB6I0KaBo+a0D5ofmEJWFlywZfcRC2F5nJuzk72A8GHn0?=
 =?us-ascii?Q?BcQKPxnx7oFSFWpXtPfckYpYu0R0mzIUyahrmFq+QJhVd1ZsPAWsVk7dSFxk?=
 =?us-ascii?Q?vSXvS1C+bD2CBm2nLIvimkGLi0mVnB08LaUomvFDgQnzluJ7+OwWQe4eJeLH?=
 =?us-ascii?Q?fSA7iRVr9RrDilKpTkmLXa9vcpt6Bl+GvpCiJPmPj0L6EDT3ONGp29UPfUfq?=
 =?us-ascii?Q?cZAh+iA7Y2bJ/kMe8BSLdyu66tUV6+Sm5rBS/qO/r9O27jmVO7tP/kHvuDIQ?=
 =?us-ascii?Q?yhEQpzP0vQigVQ9/WVfHFYtzausWQQ1dpDVkkZAhizbEU/r3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c6e62de-3d01-4100-942c-08da4e5cc88a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 23:22:43.4360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tzmhn5mzu2EjYMYk2yrUGmOZVSkVwLVL7uszhdvv/lM+NZWM38Zw8OzYyW9+O/X2gPiJqmLh4+Q/mslYaDGmbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8735
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V4 1/7] dt-bindings: soc: add i.MX93 SRC
>=20
> On Thu, Jun 09, 2022 at 08:50:54PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Add bindings for i.MX93 System Reset Controller(SRC). SRC supports
> > resets and power gating for mixes.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  .../bindings/power/fsl,imx93-src.yaml         | 96
> +++++++++++++++++++
> >  include/dt-bindings/power/fsl,imx93-power.h   | 11 +++
> >  2 files changed, 107 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/power/fsl,imx93-src.yaml
> >  create mode 100644 include/dt-bindings/power/fsl,imx93-power.h
> >
> > diff --git
> > a/Documentation/devicetree/bindings/power/fsl,imx93-src.yaml
> > b/Documentation/devicetree/bindings/power/fsl,imx93-src.yaml
> > new file mode 100644
> > index 000000000000..880500a841f7
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/fsl,imx93-src.yaml
> > @@ -0,0 +1,96 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> > +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdev=
i
> >
> +cetree.org%2Fschemas%2Fpower%2Ffsl%2Cimx93-src.yaml%23&amp;data=3D0
> 5%7C
> >
> +01%7Cpeng.fan%40nxp.com%7Cbce11534c1f9456c1a4108da4e4e6d4d%7C6
> 86ea1d3
> >
> +bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637908395997226535%7CUnkn
> own%7CTWF
> >
> +pbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVC
> I6
> >
> +Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DsTDHZ9BVww%2FFe2pwS%2Fjoz
> HPwWRmkU1hi
> > +966eGXzjFSk%3D&amp;reserved=3D0
> > +$schema:
> > +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdev=
i
> >
> +cetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=3D05%7C01%7Cpeng
> .fan%
> >
> +40nxp.com%7Cbce11534c1f9456c1a4108da4e4e6d4d%7C686ea1d3bc2b4c6
> fa92cd9
> >
> +9c5c301635%7C0%7C0%7C637908395997226535%7CUnknown%7CTWFpbG
> Zsb3d8eyJWI
> >
> +joiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3
> 000%
> >
> +7C%7C%7C&amp;sdata=3DxAU2zmsZDWOtCndpmKvMScG1XqjytSUnXLvzxR40p
> HY%3D&amp
> > +;reserved=3D0
> > +
> > +title: NXP i.MX93 System Reset Controller
> > +
> > +maintainers:
> > +  - Peng Fan <peng.fan@nxp.com>
> > +
> > +description: |
> > +  The System Reset Controller (SRC) is responsible for the generation
> > +of
> > +  all the system reset signals and boot argument latching.
> > +
> > +  Its main functions are as follows,
> > +  - Deals with all global system reset sources from other modules,
> > +    and generates global system reset.
> > +  - Responsible for power gating of MIXs (Slices) and their memory
> > +    low power control.
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: fsl,imx93-src
> > +      - const: syscon
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  slices:
>=20
> power-controller
>=20
> But if there aren't any other child nodes for the SRC, then why do you ne=
ed this
> level at all? If there are others, then your binding is incomplete.

Currently we not need other parts from driver, so I not add them. I just ad=
d mix
slices with name "slices". For U-Boot, we are not using DTB for mem slices,
so I not add mem slices.

It has following mix slices.
0 EdgeLock Enclave
1 AONMIX
2 WAKEUPMIX
3 DDRMIX
4 DDRPHY
5 MLMIX
6 NICMIX
7 HSIOMIX
8 MEDIAMIX
9 CM33MIX
10 CA55 core 0
11 CA55 core 1
12 CA55 cluster

It has following mem slices:
0 AONMIX memory
1 WAKEUPMIX memory
2 DDRMIX memory
3 DDRPHY memory
4 MLMIX memory
5 NICMIX memory
6 OCRAM
7 HSIOMIX memory
8 MEDIA memory
9 CA55 core 0 memory
10 CA55 core 1 memory
11 CA55 cluster memory
12 L3 cache

It has some general purpose functions that could
be covered by SRC node itself.

Thanks,
Peng.

>=20
> > +    type: object
> > +    description: list of power domains provided by this controller.
> > +
> > +    properties:
> > +      '#address-cells':
> > +        const: 1
> > +
> > +      '#size-cells':
> > +        const: 0
> > +
> > +    patternProperties:
> > +      "power-domain@[0-9]$":
> > +        $ref: /schemas/power/power-domain.yaml#
> > +
> > +        type: object
> > +        properties:
> > +          '#power-domain-cells':
> > +            const: 0
> > +
> > +          reg:
> > +            description: |
> > +              Power domain index. Valid values are defined in
> > +              include/dt-bindings/power/imx93-power.h for fsl,imx93-sr=
c
> > +            maxItems: 1
> > +
> > +          clocks:
> > +            description: |
> > +              A number of phandles to clocks that need to be enabled
> > +              during domain power-up sequencing to ensure reset
> > +              propagation into devices located inside this power domai=
n.
> > +            minItems: 1
> > +            maxItems: 5
> > +
> > +        required:
> > +          - '#power-domain-cells'
> > +          - reg
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - slices
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/imx93-clock.h>
> > +    #include <dt-bindings/power/fsl,imx93-power.h>
> > +
> > +    system-controller@44460000 {
> > +        compatible =3D "fsl,imx93-src", "syscon";
> > +        reg =3D <0x44460000 0x10000>;
> > +
> > +        slices {
> > +                #address-cells =3D <1>;
> > +                #size-cells =3D <0>;
> > +
> > +                mediamix: power-domain@0 {
> > +                        reg =3D <IMX93_POWER_DOMAIN_MEDIAMIX>;
> > +                        #power-domain-cells =3D <0>;
> > +                        clocks =3D <&clk IMX93_CLK_MEDIA_AXI>,
> > +                                 <&clk IMX93_CLK_MEDIA_APB>;
> > +                };
> > +        };
> > +    };
> > diff --git a/include/dt-bindings/power/fsl,imx93-power.h
> > b/include/dt-bindings/power/fsl,imx93-power.h
> > new file mode 100644
> > index 000000000000..27fb7df80f93
> > --- /dev/null
> > +++ b/include/dt-bindings/power/fsl,imx93-power.h
> > @@ -0,0 +1,11 @@
> > +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> > +/*
> > + *  Copyright 2022 NXP
> > + */
> > +
> > +#ifndef __DT_BINDINGS_IMX93_POWER_H__ #define
> > +__DT_BINDINGS_IMX93_POWER_H__
> > +
> > +#define IMX93_POWER_DOMAIN_MEDIAMIX		0
> > +
> > +#endif
> > --
> > 2.25.1
> >
> >
