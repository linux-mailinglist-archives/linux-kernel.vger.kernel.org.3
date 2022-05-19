Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFD852CC4D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 08:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbiESG7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 02:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbiESG6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 02:58:44 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2123.outbound.protection.outlook.com [40.107.114.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6475B8BCC;
        Wed, 18 May 2022 23:58:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HmU5ZE8VUfXWjIqaewYXIXC1eRqj5I/5E+97FpQv/Ds5ZUtAucAp/YDaZHCDyfsZ9p/N8L89wNByFXtB0MrfDMuiPyPb2bCSQQqzRQxXx2VolmqyjgsgSc2WQZdn+RUnVhBcy8tTRUv3mbPgxX4j0L7roBJYCGKQHgEc+t6A0Udrm6bdd+eBd3iOktEmNnG68newfq1oRzMnm1ouwL36Mr5apXuFc36Wz+bS8RnirqhGMmr/EQDyfFt0Jagl3cTpptHYnlR8gZOOSgYliKLfuzPG2njcFxpDk9QhHJmolQBXUJLP5Eb77Fj9uLUnKh4n+NclhNgJ5orQCY0/IVYD4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=35qBviN/A9LSTfYXjyHbo8pCa8AwwcHI9tMtKGvrbW4=;
 b=UI082d4UY/gQjudUfCmrFSNHunydvE1fSxtOPEDDoAdeIhE6/KcWOi/S/glQYMJjRt8uwiUxUggMP8KZFRJ3rCw+oO2LN8KMBKmA8ugQCnhkvxBxBZfy4pOTBIVw24NxZsz7Jb1tL5egUgkqFbXdkzKxrqVixTea7pMwfbI60TwsjIdu7WzVTIiANk4DvbUiP/aqubEtzGLfheVJoBXSn0dHTWHtRUSuIH/390jdBOJ5kDtEaiJuOZhR7uU08I6bZleNxDLazki3tolRZFWkgU+3JmzqgOON0//7dX+CuL3T5mz3YmyH2LCAASEFhBq77csPkRepQAE17F4nGDsMCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35qBviN/A9LSTfYXjyHbo8pCa8AwwcHI9tMtKGvrbW4=;
 b=l+ZLMSZN9ZuuTCWZbqcfY8INCXXfZ63X73ovS3iP5VgKVSWObATUhUqJaYQDGyjf8JTOSuAUCwZ2jDM0UdDe3iXFM1Y/lS3kuAWrk6z5jPQ/aKAVNIJ2RYSIb/JqtzsjR3BJMSZN5IVE85KHMl0jzHyfOVbHlQmat9JcRe4581I=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB10165.jpnprd01.prod.outlook.com (2603:1096:400:1ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Thu, 19 May
 2022 06:58:40 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57%9]) with mapi id 15.20.5273.014; Thu, 19 May 2022
 06:58:40 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Marc Zyngier <maz@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>
Subject: RE: [PATCH v4 0/7] Renesas RZ/G2L IRQC support
Thread-Topic: [PATCH v4 0/7] Renesas RZ/G2L IRQC support
Thread-Index: AQHYau2pqpd+8UxUcE6/qYBApCzwD60lIWYAgAB0hQCAAC6qgA==
Date:   Thu, 19 May 2022 06:58:40 +0000
Message-ID: <OS0PR01MB5922A0C8F58C5A4221A57F1F86D09@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220518192924.20948-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAHp75VeyU4Ox76wz9VfT8qEKHsE1eAo2iw27Lro1tmjJB0npMg@mail.gmail.com>
 <CA+V-a8tp0T=ojr3hB-QacOvV5sCZ29YXspPzKSSpGHUA8_1XDA@mail.gmail.com>
In-Reply-To: <CA+V-a8tp0T=ojr3hB-QacOvV5sCZ29YXspPzKSSpGHUA8_1XDA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf7c53f4-6305-472f-56ef-08da39650175
x-ms-traffictypediagnostic: TYCPR01MB10165:EE_
x-microsoft-antispam-prvs: <TYCPR01MB101657D9EDA957CC9120B4D1686D09@TYCPR01MB10165.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oe1ZW6yRibGp7MZ4UFYSf0G/VBfXqBdSY07OAlHyF1UaR/aCA2JLFxYlcru03hRu5xYWRQHNxGjMUr7h1yWFX5urAdithEkKpvvFu4h9fg6bEJk7AbeyyMjqbh+CHdeXXJkEOzg0dNHtgnlhfwRmUUVR7ksPPEtsIbKHVmjrT3/IYnN39iDCnfdDL2uvrRjyIWCcWrF/IAWgAIXAbuYlYwebUTrD3bxUMDRHot0F4mgmoOkUUQTrsI5GWQsHwcb7FaidlOQQ1YCXHF8Iqdu9umGwHECjkDCNtubW6QV5fDPUAUs1Pn4n1PxCmZRXr6vtWZRT8wEj8xOLmleei0AzNVv8yrgAAdUC414/v/aisXnDuiljCcErfDQBO9kHkM1rD1qmfpzKovieHGd+9akPW9REfJIhL1UU0HHhQ2sBHXnMMj41qdaJ0QxfkBMkF/0t5XWDpFh6b2tkJViqY+QwY8FisRqaOZ/72xICfn0f/SFufxGYGII1y3BpicHX6JzP1szbyRXoFX9dJWFUpzTuck9atzjwyNw/99wuLt9mojoiJiLXbtKPun3UzV825YGNETt4KASY0O3EeDWc2XTh9mGKvEHsPM24RKms9LL8TgeVzEWjyFP+7RxOZgJlAu36EabQtZN/hQXiGLkGIJTmi8HgGxT5whaPIb7SoWEHNjPVCFt1Z5yMpUAd8uahAeiTAv+wQLET50ZCUr/O3DNTvg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(186003)(86362001)(508600001)(53546011)(2906002)(7696005)(107886003)(71200400001)(55016003)(54906003)(110136005)(122000001)(26005)(66446008)(52536014)(33656002)(38100700002)(38070700005)(9686003)(8676002)(5660300002)(66946007)(76116006)(83380400001)(7416002)(4326008)(316002)(64756008)(8936002)(66476007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8KngAsRMdZK9ubagDa7l2vokTPXQMz5VkhaNv1tt5tpUyIPfmbrYMQuv4jxe?=
 =?us-ascii?Q?rxxJei+sVmrCz8aYr7XRw5oyhyyODGojJYtoxHygZV0LogYXIxXRM+88g6AR?=
 =?us-ascii?Q?thCrS043LukXrDBsgFf3s0ARI0lKZG8SSI+m6a2pJPb/cXhPyFP/RUzmUDX9?=
 =?us-ascii?Q?MvmXXT830iWTiv/udGoUGee1C+5pLGDlfHgsOj3J7WUzJDmq01isow07HK5N?=
 =?us-ascii?Q?k9hh8toohSAPIzSEELZLZmLHkA29GBVbWXPUEUjXdUMfmNPFpFm4R5GMaZGe?=
 =?us-ascii?Q?hysti0PoIJdafgvAlBqPyHzQUh9HNGujJc6XN/nAGzldOrod+YoOMs/5qMqj?=
 =?us-ascii?Q?JgqYoDCHVOepcq4JjQV1LHgXW8Ml0i+Nf3uhu1e1mMUB26OeePifV1OKemh+?=
 =?us-ascii?Q?8dLMKMHdPfhmIQNgn+HoBIoZR5aq4rclHwH4nNIQh+T2VaDucA8UFLT8S/AA?=
 =?us-ascii?Q?mF5e9LmNi535dmsx53dubmFjfacF3nlp5WnA6vhbt9hZIvRn98Rdqzut5hiK?=
 =?us-ascii?Q?/a2jjIfwnyaSf6uKvaoZH7ajUcf8xZM2Jq2oqZ+gw9zRXyu1CWp9rf1ruK0y?=
 =?us-ascii?Q?et+24lZ2EN465htHL5wxR3UybqBtQkpm8nMiOyhn6+OZTic/eb75dkrFZFyw?=
 =?us-ascii?Q?pf9x2edu2nQQOUP0o7ndd3XHz24V7kiZCFjsbW1Kyx9kM4dFk6e2iDj2lhW+?=
 =?us-ascii?Q?2VtjdnAorf4DXX3VGUNp2fCNRQvTWr5ZIQNW4i/F3PLYpjLBDsQalTNu4nFY?=
 =?us-ascii?Q?gOkSIEqJCtv6ZAflZYJh+PAdUB4GW/kT00ssVn/bWFazRXekK7cKgoUL8wAE?=
 =?us-ascii?Q?ETBkXw3fRHoDDBiEI29X+UTHR0RyM+I2p2BIqq3mmKoVExBMC1UBoProx6da?=
 =?us-ascii?Q?50GHvDM/ckxMlDqGv7h2TNcfZVmifpQej9pXIz+u5QhyDDAIOwyjLLo1Ul1u?=
 =?us-ascii?Q?mY/3/aIs/4ehzqpeSYg76Egg8anBdJaKVUwBDt+vQarJDgjfjvh6B3jT90y3?=
 =?us-ascii?Q?lsVXJCeUOdrkzYCyYC7xbfIw/kZ9LNnv4e1AZDYkRrfXrh53FQTf1AyAygt/?=
 =?us-ascii?Q?6alJWryNKcoOYJhcFNeCHvpe7DiVtnA+fez+730hzWNeEkKUnCFGADlFjEIA?=
 =?us-ascii?Q?5yF9YLQQiLOmQCTTS3eUbTd4b0fMDaLjfgvsiIrfaAJK7r2UJ3sw4OR3/Yee?=
 =?us-ascii?Q?rYvdLTUgcdCBUDiUjMK1hz00gyZswtbTIqiI9dBj29ACzoenStU4OnoUyn0R?=
 =?us-ascii?Q?ohKZq3YtC9tcUSV211+4CtULd5vjHxlF7KWYa3cgMQA7COYzrMae68oubT9x?=
 =?us-ascii?Q?1FBKsyWGfE+THiQ7DNgfIMrfq4o0uxGqfwOnuMh1caWYDb8OMGbrN5Wd42h3?=
 =?us-ascii?Q?KVVUYkjDCsZjVSb89u1GLrQcG/Qe8Ugd+wyzVpwKyabPlR4G3P3n85pJygpf?=
 =?us-ascii?Q?lp+t0t48jE9pbuU6JzUdiqUmxTWcBoT+k1dI7hhNUkf/+bl442M1VPVuP/zE?=
 =?us-ascii?Q?XqcrbXsNmJINjysMoHyPfY8eDQu6NdcMJfPkt+6OREmnvF3rVZ2ClhG/XrEJ?=
 =?us-ascii?Q?WN8VXCbsoTp/u5XvYjcKymb2QPxCWqHGHzRlvW1ZS1NfiOSlmIRk0Kuor/6i?=
 =?us-ascii?Q?epDbdwAYmbxDBDrDEMsGzmrHAT4m6vq7nLB3zifHKDHNM/ZFHkj04jDAwPeO?=
 =?us-ascii?Q?AzDZsSdM0h5zR4je0CRgYw1s4BdDZbDFDXT/LCgcTO30aHTN1612+1OH9Ku7?=
 =?us-ascii?Q?2pBfCv4ljuWmFrqr3Fa9mRx35IOyvzs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf7c53f4-6305-472f-56ef-08da39650175
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2022 06:58:40.4669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6PhZseYQ/8RLR0zzDxfY7/I0c6pfFPQO6s47V00FVqvcfdhepr5sa8HhkbaRJ+HJhcU0oY7ZC8y9R2bAwqnpt/uABgzAPM0m+lKlcFAmZMQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10165
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

> Subject: Re: [PATCH v4 0/7] Renesas RZ/G2L IRQC support
>=20
> On Wed, May 18, 2022 at 10:10 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Wed, May 18, 2022 at 9:29 PM Lad Prabhakar
> > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > >
> > > Hi All,
> > >
> > > The RZ/G2L Interrupt Controller is a front-end for the GIC found on
> > > Renesas RZ/G2L SoC's with below pins:
> > > - IRQ sense select for 8 external interrupts, mapped to 8 GIC SPI
> > >   interrupts
> > > - GPIO pins used as external interrupt input pins out of GPIOINT0-122=
 a
> > >   maximum of only 32 can be mapped to 32 GIC SPI interrupts,
> > > - NMI edge select.
> > >
> > >
> _____________
> > >                                                              |    GIC
> |
> > >                                                              |
> ________  |
> > >                                       ____________           | |
> | |
> > > NMI --------------------------------->|          |  SPI0-479 | | GIC-
> 600| |
> > >              _______                  |          |------------>|
> | |
> > >              |      |                 |          |  PPI16-31 | |
> | |
> > >              |      | IRQ0-IRQ7       |   IRQC   |------------>|
> | |
> > > P0_P48_4 --->| GPIO |---------------->|          |           |
> |________| |
> > >              |      |GPIOINT0-122     |          |           |
> |
> > >              |      |---------------->| TINT0-31 |           |
> |
> > >              |______|                 |__________|
> |____________|
> > >
> > > The proposed patches add hierarchical IRQ domain, one in IRQC driver
> > > and another in pinctrl driver. Upon interrupt requests map the
> > > interrupt to GIC. Out of GPIOINT0-122 only 32 can be mapped to GIC
> > > SPI, this mapping is handled by the pinctrl and IRQC driver.
> >
> > Where is the explanation on why valid_mask can't be used instead?
> >
> The .valid_mask option is one time setting=20

One question, if it is one time setting, Is it possible to use .valid mask =
to invalidate=20
invalid gpio lines?(ie, currently gpio range is 392, but there is only 123 =
GPIOs
present in the SoC, not sure this call back can be used to invalidate the n=
on-supported GPIOS??).

Cheers,
Biju



but what I need is something
> dynamic i.e. out of 392 GPIO pins any 32 can be used as an interrupt pin.
> Also with this patch we also save on memory here [0].
,
> > Andy Shevchenko
