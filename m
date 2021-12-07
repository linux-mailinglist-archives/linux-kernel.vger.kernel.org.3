Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A43BF46B0B4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 03:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244195AbhLGCiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 21:38:11 -0500
Received: from mail-eopbgr80042.outbound.protection.outlook.com ([40.107.8.42]:50671
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236369AbhLGCiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 21:38:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=amAZGrlR/xkuWdWivpL+vR7D02VmTuFDKUvBeYPlq5ijUfSlkRTMg59K+uCmb25QdofkOjdE4EQ0gWGWM0h2SgvpoOfBLmSQQ64i+Vk2aQtwwr9fXbBDMXV8qhMN08aQK1a1FVTdQsfa7dL4LXPZWRXyhAMBKXF/ZcQqk1nq45ZVYKRdGWhCimPPG1iBl2wOEwwZ7qbBwvR87YmrRVDlYT3mAMVpAoK6y5ZV2jH1ySwxzqZVhuxfcIevsM6bOA/zkXrrnq+EPvmVefu7yBjGHNlaUk5d0nc+N74TLIt28mNA2lE8YbodRfNx4cdaeagudCszSMG3aLNcvlOy7hb3NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ahv/JT501zUTkjnk2dgE8TVCfhpiQC9MfZXJCrlKxhY=;
 b=SBBxZJjS/oolpLnIEDjDus+5pYxWv1sv2/6ImoIYcgN3dFhSugR8NBzp0Mewmagcc970i1mzNhXJh16pdTDsiT4L4xqBA/CyoCJ7qrZWe1V8Jd1PX7y1Hu1treom44Eppw+GoMTxPjYiBocZp65H8lgFQIrz/QVeAzyA6Y4Biy4UYwXi1mT+1QFw+AMjkZ4ChwPVuzXDGmoaIxVPDWzUWwfNTjooqYaexLEmvKYd7EgWwCiqLvA0Y82jl5WOXb2w12AjFICpgbcY0cScXeTtw5RcQiJBXjNp9eZhwrT7sLtlpmnBfXgNuVyISVdCbh62abBK2RGtmxpLmDkhqM3QKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahv/JT501zUTkjnk2dgE8TVCfhpiQC9MfZXJCrlKxhY=;
 b=ksZguTle/kpqoXyVxUcxuZ8OCtHlK/zq9Jl/7HDzZRwf+81nXoWPDI3xndqFFRlkht5JZO5lLXrzmAA/ORpaZpSz3kbYVaqoIG+X67BhD+EQXwn49tDsvE//lG17egbQgvyFlFmjPj/G/+7oH/f1xYzdt3VS6kniOaxJ7nayc1c=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8551.eurprd04.prod.outlook.com (2603:10a6:10:2d6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Tue, 7 Dec
 2021 02:34:38 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43%9]) with mapi id 15.20.4755.021; Tue, 7 Dec 2021
 02:34:37 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/3] add i.MX8ULP scmi power domain
Thread-Topic: [PATCH 0/3] add i.MX8ULP scmi power domain
Thread-Index: AQHX22MxQv+CnsINSU+DFjWqBcyxvqwHE8wQgB9bHDA=
Date:   Tue, 7 Dec 2021 02:34:37 +0000
Message-ID: <DU0PR04MB94175C662990FC2587996CE4886E9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20211117032740.2518926-1-peng.fan@oss.nxp.com>
 <DU0PR04MB94179C596E6144B928D17D1D889A9@DU0PR04MB9417.eurprd04.prod.outlook.com>
In-Reply-To: <DU0PR04MB94179C596E6144B928D17D1D889A9@DU0PR04MB9417.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82d7ee6e-2ceb-4522-cc53-08d9b92a1d30
x-ms-traffictypediagnostic: DU2PR04MB8551:EE_
x-microsoft-antispam-prvs: <DU2PR04MB8551A7C9715700B07C605DD8886E9@DU2PR04MB8551.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9jV460NskDzA7dA5KjoLIhKM3lqMsZUoupDdZaWnt+Zf1yckIgB7eygCFdyvoZqv1mwpRrMYXAfCDS2BZqNE7UCsBF2ekDJ6Bh5xUOgjG1lFt6qAE21gaTkoLtzWozgrVW+opy4UxEwDR3uuw80ichXbcOpMQYAVqotoSXIZtb6kBDtO9J45L0HmCqiIMArgL0LB4Zf+XWuHLMdvugJ+1tnz2ImmwrgpuKC93A6o9u4sr7g9NnuHqu6nghpUFhWONLN+eCoq8X8J2ki3KiF+sgcGQ+OwNrsVv0FA+tSE0TR8NHfY8tgtqIFYcnqL9YFYE7ahSWLtfBXF8GUxphmxNGJRDC1D6NKsYQddJJzcTx4Czx69TKCOEoXH5sPEQiSmuowXJ2UHSprj+Lpm/qsuGlo9GooZgeVSc5iYyo5R0h/it4UTuvfyzAlhQWXYczL3pJStwQcxwYTJtqNt7bJKbdR2Y8w91q/GHUfye0Jd3uYW9OPV6cUhxrh0lzY7zdUulN34YQDoSf34n42QeYPVPpizV/5yCCnj/HM86w204Oe1GRtipV0mH1G2P67MOxeL+VaMJIws2vixnCm52LdVYGzOTUYS94qJ95hHB6DXcY5gFho5Gw6J8GRaP0Hxf194c4s8H7cn8FHYP9RPnrdjl2ZewoGG0asu9brkJDaTDrt1YoRgByIQkfiIv+XxVs6k45LdfbAqE1yYlspLp+LD+P0ymsSxtDkhsRVc21ICdHBYK5BBiYWTd/zwBXe5cP+OvPOoNnCo3O7kufD1jLtR5n2Cl+ws8XhELG2ghJZif30=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(110136005)(33656002)(44832011)(8936002)(38070700005)(122000001)(76116006)(71200400001)(316002)(66556008)(64756008)(66946007)(6506007)(66446008)(8676002)(86362001)(7696005)(186003)(54906003)(66476007)(26005)(9686003)(52536014)(4744005)(5660300002)(2906002)(4326008)(55016003)(38100700002)(508600001)(966005)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3ZgQUltvxbm9/uq7eQKSkUflH4ZY/v2aEr7SbFAAt9KUx+Gz9H6IKsXNy5Qs?=
 =?us-ascii?Q?QUxfRVME0TDICBa2I8A3jUxy0UHITDZ/NFa+wzMhwGQeAMrVWuijz/eYDE16?=
 =?us-ascii?Q?iaY/PWeVw3pKih/tylGmlOMEVKyNA11/p9h7PZKQPaRPeMkf490GgPa0IJ+W?=
 =?us-ascii?Q?PkVkrQ8KWoyQNYHTeWdLT12Zv30U42mnK6uuJH2CrABW5VLOPkOrt/X3xhk4?=
 =?us-ascii?Q?HU0Kh/+2Q09LughPv78Ib7x2bjqWIFNU6gB3zM2YDJhyHZqmptIcztemjCfi?=
 =?us-ascii?Q?9WDoEPDykojl3KrTqWHpI0OLJkZHdb6xVgKd2FYhwmwlvSUOuQ3ZM+xxNlRN?=
 =?us-ascii?Q?ejWoJc31UNaK3ceYSLyHcARNPjncMUJWw8GeEAyCXcee/LiGmBAxkz/1+DAv?=
 =?us-ascii?Q?GDQ/XflbUc58vGfDj7f8bpS1ZO8PS1twgcy4+LGgItdb6Nzf3l2FEiUE6d3+?=
 =?us-ascii?Q?HqijD6llG3H0vETZP9kJzbdWGxuVmBw5m/guQ9PubX8uoIq2i5x2Rckr+Irg?=
 =?us-ascii?Q?UjO8nqRWDm65NsZ3J+xFk2Dj62Jwt5sMzuJy5vq1NZU6zNNXi6eDb8LG6NL8?=
 =?us-ascii?Q?nA6f08pvKdIqlSQLzCuLCFbBjfRVrBCbcCeF4ud/GPT+1YvwfgXmyq2pwuwx?=
 =?us-ascii?Q?OjSoCnHOCu0T98EdWvLTvCGYUf8knt524P2hJG+9E3yayl7Eqcjb8NDCEFED?=
 =?us-ascii?Q?vnM8mWLGAzPIgrKzMJbLRvrMAgpaWzTu9XUqBvj2gUNHvpGw7lVdJT6JnfoG?=
 =?us-ascii?Q?2/YgQlqgn45r8aYx8NU0lqoRU+O2hRdai6aJAy1r+h1ZMriQyIR5StED3/Hi?=
 =?us-ascii?Q?Odqn2N7WWLPlTzljQTTW+5HGPG5KX6R4T+FSjubiKJGHrV9JZDm1M6IyirNQ?=
 =?us-ascii?Q?cL2o6+60fde7PuiO9/U6Z8/FqlQC/1rnUzAaQUInwQL+ZrobdoK1M3r+tYXE?=
 =?us-ascii?Q?VUAGsWHGrL77Hr5m/Km/mVu01OVvYjOQU5HyJKOvJDqTEL6vj7r4EPdgXOi1?=
 =?us-ascii?Q?tPGUWymOJ7ttlSuDcNNCYvcjYr5oloVoJdEA6Hw8+QkySZKeqhyY4Jt1x4Fl?=
 =?us-ascii?Q?q8VLR9rkp7+QjGjd7G6xMbld2O0mj6XaDYWrd/eihf91jEVxpYwQMh/Tyi5Q?=
 =?us-ascii?Q?qZEu2y5bKtMYghj1Yb/Z5YWiBG4AdxRrWjLokD+VDb97qD55UO/Mo8TVeU+5?=
 =?us-ascii?Q?Y8tIKh2jMio2ofsJAGARZSBqoiQzHS/usmL9xsNWFRbwxoBoQ3rTq7quTXO4?=
 =?us-ascii?Q?Bw04tZnhs/p7AEncVDH2oHfOam+KZBOHprOegu5D3gJP1tm6pbzjvAZf7woI?=
 =?us-ascii?Q?Or5dMLefMn3p9UicAxBQ7NffD/vTCKU28nN5mTxrpCww5sZIZ++ccHhlPIFH?=
 =?us-ascii?Q?qtbz+7ObmUdFKGIIR1qS8ZnxZyh5uctRisHMNWCFlsZSTFZy763FPh0FNbuG?=
 =?us-ascii?Q?2RKsyy3IgEHW4ftjoePEeBk3XQ8++oXtEqbaB3uhenVjjWbAl+D+Jmai18Tk?=
 =?us-ascii?Q?vOr0mO+auTI0Gd3lQeYjEAG2lccWsIqy+XgiF0l5T4D940eXL5x/Rdt1YnAK?=
 =?us-ascii?Q?4TzzhnBbQP19bOPd3lgD9YzpAIp6O22gRjAqQpf/8CjNzvd9PzKafWrQpo8O?=
 =?us-ascii?Q?jnqh5jNuOQGDIYzDWLl45bE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82d7ee6e-2ceb-4522-cc53-08d9b92a1d30
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2021 02:34:37.8779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +iurBgTCqqdNQ8cG0L3ZpSL/gRnJIrxHrIaVpOMQXQyTA4+Wyo37ZUpRCTDAcyp6eFnC5zX8PW7rD6vrbaCx7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8551
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

> Subject: RE: [PATCH 0/3] add i.MX8ULP scmi power domain
>=20
> > Subject: [PATCH 0/3] add i.MX8ULP scmi power domain
>=20
> Forget to mention, this patchset based on:
> https://lkml.org/lkml/2021/11/12/74

Since the i.MX8ULP dtsi landed in your tree now, do you have
time to give a look for this patchset?

Thanks,
Peng.

>=20
> Thanks,
> Peng.
>=20
> >
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > This patchset is to add device tree support for i.MX8ULP SCMI
> > firmware, and enable it for USDHC node
> >
> > Peng Fan (3):
> >   dt-bindings: power: imx8ulp: add power domain header file
> >   arm64: dts: imx8ulp: add scmi firmware node
> >   arm64: dts: imx8ulp: add power domain entry for usdhc
> >
> >  arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 38
> > ++++++++++++++++++++++  include/dt-bindings/power/imx8ulp-power.h
> > | 26 +++++++++++++++
> >  2 files changed, 64 insertions(+)
> >  create mode 100644 include/dt-bindings/power/imx8ulp-power.h
> >
> > --
> > 2.25.1

