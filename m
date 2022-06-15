Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26DA54C050
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 05:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242357AbiFODvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 23:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbiFODvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 23:51:48 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2053.outbound.protection.outlook.com [40.107.21.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF2F5002E;
        Tue, 14 Jun 2022 20:51:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=js7sflj6R2fEeS8fNt20o7k2pHVA6x1LfvWNem5yNPciykRvP7xIBjS6JXhqJ6cIRx3j+MFamlt7gBAEyxoE0W1I/zFJSupWG6TqoJJr8vyBA/cPENF2Pav8oD3Kys7RXnJDq0FdHBpNQVVJL6W9zpz6xf4iq99is6xSBCfir6yrCTDWYiaSnZfvPb0hVRvQ229NbmmI1JqSujhTpZP5E1EmIOpvoQ4zWHXHgFxyqzAKvcSknOjluYS7yaD21IlNyLB1PH27SNfHH7H5eTSWiZb9Mwy4tpRr1Y58pnt1kbzN/CenfpONNaKMXGVLS7bqnccYVAPOddl80jZvqwyKNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZ7oW9IXkS99SKPSUwFyJ5pmEIjf28RXcQY49nNS2E0=;
 b=FrucKORLWi9tB7fLS5FUU7ubztYLBYFbP4JIi3xjZc+XbYjYL8n24C7oAVjhBLOWM6/8SfDFpfBae1T4FL/fcyI9MdyJ800Ytg3iaDFhOYCVj0vrkIrSECwQjpk+6XOHbkPl/8RLAVMfqqG/yVGrVYKtQVyYGpQv4MGlGUbX5nnv/tzEVtmhgZO7k+LXZDmcUvRMvlg6eoJkRvbcAS3QJgf8YspN42VrLltNOXPbDE8/9mpsyIHCvjqHe9UU8TEi9LWOxztXnVlYml1vcQ3wknhpRiT7y2+15kAXnegO/iOwoiANICtdqUHatdpfPAJT3VZidg1MRoRQJGFyquFGuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZ7oW9IXkS99SKPSUwFyJ5pmEIjf28RXcQY49nNS2E0=;
 b=Ntdven51stSGvj0/3pIV1wHwRnmibqBZ9poMlwr+SM3i50fElyz88im2Gncapvd7YwVobd597xOCGYTwsoEQcn1s3PIAHBn1a5jBUfkVEV0YNiU3X4vMGV1/n5cVnIY5zfEHCHEyIZ5TV9uC53F0EKrhvKgWkwBvWcc501JDoyk=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7867.eurprd04.prod.outlook.com (2603:10a6:10:1e5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Wed, 15 Jun
 2022 03:51:43 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%8]) with mapi id 15.20.5332.015; Wed, 15 Jun 2022
 03:51:43 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
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
Thread-Index: AQHYe/9WcK1FHwn3oEC6Wgr9BHrI561PdpGAgAAafPCAACfUgIAAI5Cg
Date:   Wed, 15 Jun 2022 03:51:43 +0000
Message-ID: <DU0PR04MB94175C104984F0232B62CB9C88AD9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220609125100.3496633-1-peng.fan@oss.nxp.com>
 <20220609125100.3496633-2-peng.fan@oss.nxp.com>
 <20220614213953.GA2693578-robh@kernel.org>
 <DU0PR04MB94178655FA1B5FCF96BC5DCF88AA9@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20220615013713.GA3408671-robh@kernel.org>
In-Reply-To: <20220615013713.GA3408671-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23773e2c-53e2-4dbc-bdee-08da4e825c9b
x-ms-traffictypediagnostic: DBBPR04MB7867:EE_
x-microsoft-antispam-prvs: <DBBPR04MB7867D4BC9729DDB857AE281388AD9@DBBPR04MB7867.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FdoTfxQLozgJzPTjvkXiDvs4huTTxNxBotr6bnnaFPSN8wBObJ9t1LDp1eOo18Zpgldmoh3vXmMx1glw1kZxwOHUH0K6kBgosasqmq7BorOTvu58Ec2RiK54lz37XKM6KvRAx3iqNGRmi5uvnEcZ51O9i/mK1QswldQ2quJj5PdSOWLBDqH8HkzoCzZkg5+CjOIwDA8KA5zlitsJIQNPDp1iIETpy0ji5sHCsj+Lzb3EqD4qSNBwVQ310JILVkZ/SrJmoOaBtE5imI4yMm/A3vfrfAyzwRUXbSNw+FSzSCQw/1l+36kagd0G68s/3JOOUGpMFi2+RqdRWo+y54ROf8MgS9dvCMBlu0CmJliHYjyJmPhWXh9zieWwQ5uWjCFMD4jdHrfatD5Z0afpufVlqA5wzr0qfBqLaDC7LbF9jYt7AGMMptUk6i9jCiStNkjejK6ZtHNYXwQZlOC1/aNRFYqhGie9nwaR0gsdFYeIawRxZnpIltwwC32QFof5GZOl35JhunYtJmNoWp2YxUWJgARsu69m24L4kyb49QFjGPz4yFQEwCO5tNoCSQ5+yRNHktGr56C4L+iBdK3u3wGWeEyybWleqwGdxSCfzoIfH8uKunDOx7CMAEFiPvIrQuwbzt6XLS63RSR4KQTOBCW/sMc9qIU+aA/IufJHvoG/6zA0gxXEDRM1MxEitIMRpaC11yGQCHiLeYE6tVkyc+fc+PV8LcnLwpPxTraKdQiwOH/bc4eGJhEUCG7qbnttETakDcNdkj7xRo1Y8gWlX6ylOzycZVXT3+VSdVv+aisYSbs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(186003)(122000001)(83380400001)(45080400002)(71200400001)(7416002)(9686003)(26005)(44832011)(5660300002)(86362001)(52536014)(8936002)(38070700005)(508600001)(6506007)(7696005)(54906003)(8676002)(76116006)(33656002)(66946007)(66556008)(66446008)(66476007)(64756008)(4326008)(2906002)(55016003)(6916009)(38100700002)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0MNXFRUsuXB6neyqXbZcDhgbdLM6Y25t/XEqJu45YZhlniAFSQIo0W22DnK4?=
 =?us-ascii?Q?GiaqFjXUyZ8h2TItxuuL0tgbL/ebe2G42lQGcy4YkX6dQDacXef46NscnHUC?=
 =?us-ascii?Q?xfYZBWrzzOJjizrwPZFiVyL3C6VwDVdI+qY4OwXbu2XVDhzQfIVxwTvqIIaE?=
 =?us-ascii?Q?E2J9YTdo3+a4j9LfSL2easPlCP8FHBESJdZxYJnZLEgqMqg/yOFeHCx9TNm0?=
 =?us-ascii?Q?ekiPGcGQslzE02JAxuPHBZPxSph767HmMfJaH4KZkWTHaYwzeXBIm/Evmm1q?=
 =?us-ascii?Q?33+9a9zoKz1I08aVbe+TNg+LMPNG2/9lhzfL7k0Bq/tlRhrzYVfBio15l3UC?=
 =?us-ascii?Q?dFZq9x35HXRvjt9PDJvyMhEAXdf5LsxYHRM/u4UgITIq1/YQEGc7E2NNXUGg?=
 =?us-ascii?Q?7Kee0OwxqLl4g79r5A8nN8lPnJrzxtkPM044zRwQX+ivrkBk3ZrjuP8IjPxn?=
 =?us-ascii?Q?zrlaaBtaZEzSH4LQ7tyT5pLnz8KUN7qHnu9dIgxlw9lWtQkA6y0T3nXg4UCf?=
 =?us-ascii?Q?UGZH0Kjz2oT19ZBjXZ0blMwoXSXaWgFw4ogmf7AGmdB/jamPsvQ0yDdFGIO+?=
 =?us-ascii?Q?dLCbiUmVu2AfqqYAUJAoN1iPJ5G94bTwYkwFOXMJuPhWBIlHjMXnS3AvjaZ0?=
 =?us-ascii?Q?7wuBpushJ9A+r6L1PC+BCs/5PN1Ey33Chgds+Bq2obE3GqS4BU1dGeE1JU7c?=
 =?us-ascii?Q?A2rIj4/AmkBYnyLuJmulgSgEQC+krwc0kHVW/14N7cXr1SQXQ84doYM8rN8r?=
 =?us-ascii?Q?LflgDq+HFXTb9fR+QXYFpqGB88A0wubTjc1f7L932VyYVAbxdMpdcPfoEjfu?=
 =?us-ascii?Q?Y5R6UDvVULTvwwuPJYSqLH925r3TW/owkafn9OppxqvQLHI2FLfSKoBlzlDL?=
 =?us-ascii?Q?8Bs/6rakswOoEPOn/sQx8EfWw+TqH5xPlf57Pvu+S/Y8JBnJzqImiNY80hGp?=
 =?us-ascii?Q?CvBF8XH4LmYb2ulQQ/8LwUEI1RYwOkawEVz0sUOK2C8nl/1s+z4YJElDzPvi?=
 =?us-ascii?Q?4B4yVM0T+kZPdwO8SiCZodgP8NuGBdJjzz8JqlvXwWb5gBKRA0dQOsUKPHLN?=
 =?us-ascii?Q?uXzD7F3SnJtz0+idbKc0FJmmKdt/mtJ2az+6DlHU0mZ6Wv6LFb3x/D7mDNjC?=
 =?us-ascii?Q?HcldSE+CKDwGHNzoZK39Vn7SYeRfIYQ7E9ZAACO004+8Y63DdPEpGgP15tZ1?=
 =?us-ascii?Q?Bpe6qRMTMhypdLWCY/y0cqaO3SY/VP2DUCyV6aWahJxoiulWxUKKkf700WFO?=
 =?us-ascii?Q?FpawpN2LLmkqsNiORvPGdVnUbxNjsSyJ/806Qzzvely2uYaM41A9xHKv78KR?=
 =?us-ascii?Q?o3gvCvNXooENEGgxwVvqhmplSgefGguBs1O9KFS/o61lwow4VeT3wvIYkhQX?=
 =?us-ascii?Q?mvHgi+ia36ZARHR9lf8JZ+cjIMZ0qIcsKGMOSr1HBD2CxzzppB8RxwDWyDPp?=
 =?us-ascii?Q?BLalmhtkvPqUHpzyrkqcBjQq7/TmeQwLogzaA8gTP7xFpnLK126ykdnML0Ni?=
 =?us-ascii?Q?O11AdCoB1qLq9mtskKhb5K45O4gpA378+uOp4GVP6//PqbbWSX7yIKfmHlyK?=
 =?us-ascii?Q?/tWL0En0/Xdh7453LCQ5n1tPcD3zQSbXGsxp/RXY0xsb2M+LlMYsjv8V0Ntl?=
 =?us-ascii?Q?RO1r77yRF6IYiqdQ1pwIY+0QyJD30+OOBtuAdgq3L9MG6Ybfciv9sg0yLKCm?=
 =?us-ascii?Q?wrUfJ+XiNQRSTrq+jqxlUokRWeZ3l4YcwI2z3BurBaOi2/TYoVIJEUoTr8TY?=
 =?us-ascii?Q?lSZZqZTgOw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23773e2c-53e2-4dbc-bdee-08da4e825c9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2022 03:51:43.2616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uLdbyiKqiETcGCBq5vU5xP9id1UIVSmFKfvvbcA6CbrjpcPTB9EKjKXK1LLo78o8LpXBIFjVwpIgnSTjyxsX6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7867
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
> On Tue, Jun 14, 2022 at 11:22:43PM +0000, Peng Fan wrote:
> > > Subject: Re: [PATCH V4 1/7] dt-bindings: soc: add i.MX93 SRC
> > >
> > > On Thu, Jun 09, 2022 at 08:50:54PM +0800, Peng Fan (OSS) wrote:
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > >
> > > > Add bindings for i.MX93 System Reset Controller(SRC). SRC supports
> > > > resets and power gating for mixes.
> > > >
> > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > ---
> > > >  .../bindings/power/fsl,imx93-src.yaml         | 96
> > > +++++++++++++++++++
> > > >  include/dt-bindings/power/fsl,imx93-power.h   | 11 +++
> > > >  2 files changed, 107 insertions(+)  create mode 100644
> > > > Documentation/devicetree/bindings/power/fsl,imx93-src.yaml
> > > >  create mode 100644 include/dt-bindings/power/fsl,imx93-power.h
> > > >
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/power/fsl,imx93-src.yaml
> > > > b/Documentation/devicetree/bindings/power/fsl,imx93-src.yaml
> > > > new file mode 100644
> > > > index 000000000000..880500a841f7
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/power/fsl,imx93-src.yaml
> > > > @@ -0,0 +1,96 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML
> > > > +1.2
> > > > +---
> > > > +$id:
> > > > +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2=
F
> > > > +devi
> > > >
> > >
> +cetree.org%2Fschemas%2Fpower%2Ffsl%2Cimx93-src.yaml%23&amp;data=3D0
> > > 5%7C
> > > >
> > >
> +01%7Cpeng.fan%40nxp.com%7Cbce11534c1f9456c1a4108da4e4e6d4d%7C6
> > > 86ea1d3
> > > >
> > >
> +bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637908395997226535%7CUnkn
> > > own%7CTWF
> > > >
> > >
> +pbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVC
> > > I6
> > > >
> > >
> +Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DsTDHZ9BVww%2FFe2pwS%2Fjoz
> > > HPwWRmkU1hi
> > > > +966eGXzjFSk%3D&amp;reserved=3D0
> > > > +$schema:
> > > > +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2=
F
> > > > +devi
> > > >
> > >
> +cetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=3D05%7C01%7Cpeng
> > > .fan%
> > > >
> > >
> +40nxp.com%7Cbce11534c1f9456c1a4108da4e4e6d4d%7C686ea1d3bc2b4c6
> > > fa92cd9
> > > >
> > >
> +9c5c301635%7C0%7C0%7C637908395997226535%7CUnknown%7CTWFpbG
> > > Zsb3d8eyJWI
> > > >
> > >
> +joiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3
> > > 000%
> > > >
> > >
> +7C%7C%7C&amp;sdata=3DxAU2zmsZDWOtCndpmKvMScG1XqjytSUnXLvzxR40p
> > > HY%3D&amp
> > > > +;reserved=3D0
> > > > +
> > > > +title: NXP i.MX93 System Reset Controller
> > > > +
> > > > +maintainers:
> > > > +  - Peng Fan <peng.fan@nxp.com>
> > > > +
> > > > +description: |
> > > > +  The System Reset Controller (SRC) is responsible for the
> > > > +generation of
> > > > +  all the system reset signals and boot argument latching.
> > > > +
> > > > +  Its main functions are as follows,
> > > > +  - Deals with all global system reset sources from other modules,
> > > > +    and generates global system reset.
> > > > +  - Responsible for power gating of MIXs (Slices) and their memory
> > > > +    low power control.
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    items:
> > > > +      - const: fsl,imx93-src
> > > > +      - const: syscon
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  slices:
> > >
> > > power-controller
> > >
> > > But if there aren't any other child nodes for the SRC, then why do
> > > you need this level at all? If there are others, then your binding is
> incomplete.
> >
> > Currently we not need other parts from driver, so I not add them. I
> > just add mix slices with name "slices". For U-Boot, we are not using
> > DTB for mem slices, so I not add mem slices.
> >
> > It has following mix slices.
>=20
> What's a mix slice?

i.MX9 has many logic block named [x]mix, such as wakeupmix,
mediamix. One mix slice is for one mix block logic.

>=20
> > 0 EdgeLock Enclave
> > 1 AONMIX
> > 2 WAKEUPMIX
> > 3 DDRMIX
> > 4 DDRPHY
> > 5 MLMIX
> > 6 NICMIX
> > 7 HSIOMIX
> > 8 MEDIAMIX
> > 9 CM33MIX
> > 10 CA55 core 0
> > 11 CA55 core 1
> > 12 CA55 cluster
> >
> > It has following mem slices:
>=20
> What's a mem slice?

From HW perspective, registers are actually memory.
So saying mem slice is for memory related stuff for
a mix.

>=20
> > 0 AONMIX memory
> > 1 WAKEUPMIX memory
> > 2 DDRMIX memory
> > 3 DDRPHY memory
> > 4 MLMIX memory
> > 5 NICMIX memory
> > 6 OCRAM
> > 7 HSIOMIX memory
> > 8 MEDIA memory
> > 9 CA55 core 0 memory
> > 10 CA55 core 1 memory
> > 11 CA55 cluster memory
> > 12 L3 cache
> >
> > It has some general purpose functions that could be covered by SRC
> > node itself.
>=20
> Please make bindings as complete as possible, not what some u-boot or lin=
ux
> currently uses or not.

ok, got it. Then do you think following is ok?

  mix-slices:
    type: object
    description: list of power domains provided by this controller.

    properties:
      '#address-cells':
        const: 1

      '#size-cells':
        const: 0

    patternProperties:
      "power-domain@[0-9]$":
        $ref: /schemas/power/power-domain.yaml#

        type: object
        properties:
          '#power-domain-cells':
            const: 0

          reg:
            description: |
              Power domain index. Valid values are defined in
              include/dt-bindings/power/imx93-power.h for fsl,imx93-src
            maxItems: 1

          clocks:
            description: |
              A number of phandles to clocks that need to be enabled
              during domain power-up sequencing to ensure reset
              propagation into devices located inside this power domain.
            minItems: 1
            maxItems: 5

        required:
          - '#power-domain-cells'
          - reg

  mem-slices:
    type: object
    description: list of power domains provided by this controller.

    properties:
      '#address-cells':
        const: 1

      '#size-cells':
        const: 0

    patternProperties:
      "power-domain@[0-9]$":
        $ref: /schemas/power/power-domain.yaml#

        type: object
        properties:
          '#power-domain-cells':
            const: 0

          reg:
            description: |
              Power domain index. Valid values are defined in
              include/dt-bindings/power/imx93-power.h for fsl,imx93-src
            maxItems: 1

          clocks:
            description: |
              A number of phandles to clocks that need to be enabled
              during domain power-up sequencing to ensure reset
              propagation into devices located inside this power domain.
            minItems: 1
            maxItems: 5

        required:
          - '#power-domain-cells'
          - reg

Thanks,
Peng.

>=20
> Rob
