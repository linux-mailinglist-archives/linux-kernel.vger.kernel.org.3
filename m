Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52066544207
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 05:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234608AbiFIDij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 23:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbiFIDig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 23:38:36 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80059.outbound.protection.outlook.com [40.107.8.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D8D7C161;
        Wed,  8 Jun 2022 20:38:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0cOiQoBFuuchRc2c6wkDMkFrPnOrSHuAh1ywSTlvrwWBwABLvvJ+Lq/sTbjZvhyzDpUh5PYiI2HM3IodGEfA9Spz2lYh9eiH73pGnrpqFSXlepjlcgm2Su5swUdGqtuQ4eruT5cjpSK/iSFO3fCtoHnQGs+62qQV0hzIXh6er5JQ/BH0wsk/r8twx6rqDgMpjDmjqKRz4kmC1/d9k0Kgjqkptv9choWSPYxjeo5JZzs+e/mcZ86rwq+uPaJgwxWoJq24ygOe33Dvv3K4widfHOh0nGf2TvlkWQ8cJI3G1i6ZiFoF6j92OLFDW5sbvMrD0BVEOX1H9GHn6vAJ9bBIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHRlJSOoBo9BL4J4EKrEI60JrEXUkpcd+AJnkjwyaXs=;
 b=N3vPpbWgWI0fUWOYNeoCILJFQgnnBA2++BQwvV13OELQbgpEdj/9Hc+ZeCDQc6N6AUnhTAaCDO/asXDbMeRA8/eGcE3euz2vvOAbLC8vDTueoP0yQ7WhmEu3bJdyXsvu3iN4StljnXMhmUh4wgF+RkfUTxlKwPsr9/ryq1FiN51+tqxIBOXlHXdsp5FEmziI6BH4LJGIJEi6GzPCwqXufWyHgHI8mUWQXUDdHTQmsuIPuz1OFS0+LPc27EMwSio937RMcf/TeXmfIzcXsRnMWoGawIVaftcPgxPFexMBSBLNQV6dd9N4z9TVB+QQLMK0dFasngY5qoTv5+nBBflreA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHRlJSOoBo9BL4J4EKrEI60JrEXUkpcd+AJnkjwyaXs=;
 b=iugUzm97QaUCOzzHGh0p4nwfOwnWoFkzIT5E0FiXmYtjuOPVI2claxU7hJiPLQdTYvao2VouBk2yoAx4oiL/JuK8570/PQdH/5OvmOLxyZ/46er2WMS5lDMMbS78GUdj4e/O0qJcprzkb41h5eeJU339eyk16wmkFVCcoIzLWt0=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS4PR04MB9505.eurprd04.prod.outlook.com (2603:10a6:20b:4e4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Thu, 9 Jun
 2022 03:38:32 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%8]) with mapi id 15.20.5332.012; Thu, 9 Jun 2022
 03:38:32 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH V6 0/4] arm64: add i.MX93 support
Thread-Topic: [PATCH V6 0/4] arm64: add i.MX93 support
Thread-Index: AQHYZGrx0QGyTCC3dk6f5zBfU9jVS61Gm+rA
Date:   Thu, 9 Jun 2022 03:38:32 +0000
Message-ID: <DU0PR04MB941798E82A756FC1FD16E78F88A79@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220510124050.398891-1-peng.fan@oss.nxp.com>
In-Reply-To: <20220510124050.398891-1-peng.fan@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 625d1967-04c0-488f-49df-08da49c986c6
x-ms-traffictypediagnostic: AS4PR04MB9505:EE_
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-microsoft-antispam-prvs: <AS4PR04MB9505523A2F788B4B6A643699C9A79@AS4PR04MB9505.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ECvIgI8pMxQADnNXb62mYlPzJwIRch6itEYJqBJ9lMOSiiLIvc5cqxU/vlbSqT3gehvClm4RJrL/mRN2suVLuZNwaRCD6bL1xJ6Xv1SQOul6w7oo9FsgtFxIfMMoV3Uu7KIQGVK/otUn/eyrml9v1rU8DwkgGJG+5yqloV79LufhVQPUmHKkmEzR6iYM4jzyh+IHiZaN6L36r63mDGX2fAXpjYeAMCzidgZXH2Bcey8LDIqlGGULO7TzECkaHU3O6beaBKQ0Lf5Au+N/Qe7tjOfuk27oXfFCbRO9LfsgZyUNYnMrOKB1I0qT3q0iSCUZzg4X6KHNjIYQ/W00RUCS27IbTkctGMnMh5sAupN4b+Nmrfl9ba15UDDE1vpB58cj1dVhtZ/20bj0dNAOTcPfXQsQPMUw13vo/KCw8WfsqRd9Uag9JpyHcMRadAVKbHT8Jb5KKhyl9LGY9uCvwXk/lq5kn4C3DmY9jgWPrzwHSEr/ZqeUfhNuBq+VpRYUdkk82ZyW0mODFNU1UxgcgCh/aGMKeNzFLwvPfEgTVoXN0wz8QdhVdwMXl3ITaLyxgnILSFGhUtXsAt2wTk8bJ4X8nhPEeWvj4lrVQc3zG975MiR1xMoQaVnz3dUWI9S0wwpIe29k/vImP+vErmYovK8YOgiJy3Ib2cC1M2ko/W8pocb9OY6/5OnJmMqgKpjQiI86X2KNDKaG47Wx1E4MLQ9EnQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(54906003)(33656002)(9686003)(38100700002)(4326008)(76116006)(8676002)(5660300002)(66446008)(66556008)(64756008)(66946007)(66476007)(7696005)(122000001)(6506007)(26005)(110136005)(8936002)(316002)(186003)(38070700005)(83380400001)(71200400001)(508600001)(55016003)(2906002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XrQYS9HIfCVHddwPNCkOiRnU+YuQZmcr9Altk9Ff93u2/X41pDY3cWMUFS8z?=
 =?us-ascii?Q?KEMF09S8BKTABLw5U4uYJDB4wz64kxXnEWWUc0wZOgU7uXFr5zh7PjskJYDU?=
 =?us-ascii?Q?sQj7jZ79Kf/gZFtua5F8eJF4tdXmmV2MmiU6ExhiH6YjDA0N6jLt9Jowt4W4?=
 =?us-ascii?Q?yZeTszzqYHKZ7nI+mbPtaKbjXt0W5gNO9KGwGtxEKI6Gb/SYWwPuVCUhXrfp?=
 =?us-ascii?Q?73+AeTmsmBuL7xP57N2y9U7spi1dbq+UYfX+jB8SLJ1L7J2ZyaYt5zBtGh+5?=
 =?us-ascii?Q?0H7+pXtPbbuXFmnw7gKbI0IdEZcEGU6HpnvInO/fmU8HVpNhmR5YaTQLTcSG?=
 =?us-ascii?Q?x8TLEFjjG4lhL+XwwFrQquco/DhkbtRedtb+Ogf9dcl5e6PepvXCsli2/Q3q?=
 =?us-ascii?Q?fwouW31vwYRyMxiMBqSe941vZ3IFq32NhQYfPHg4s6GQKDrX6q6SaEDqO8tJ?=
 =?us-ascii?Q?D3PpUbjjB4c0SXwXXsyPqr8b5E1Zw4uqnws+gqODOC726iguc99dCjjh4bCM?=
 =?us-ascii?Q?X28KGz4548zPLyNp+MDlnKYm4WUcHbGabHCeEsof4joOPWwRzeJcn+/bcEJW?=
 =?us-ascii?Q?5M+6cd/hszcAQ7QD3YmQ8FTE1zO8K2zSpc+tfrxHcQfXft50M3A8+W4yR/zn?=
 =?us-ascii?Q?OxtQBPTU6bTlkcmwia5J02QqfYKB2K4H9/2jqlL9Um/ka3Pf8NJMLYxO5Bjq?=
 =?us-ascii?Q?rSskiiuL0rHUAmP3p1uBfUuTTGOCEIMlCgJ4ea7ypoNnMWHvW/hcPZsLy85p?=
 =?us-ascii?Q?Xqgb5B99s50czCcwx1p9P+zjGl15W5KT5Uj9zJVJTgVaKcojBKE/kSiIoH1F?=
 =?us-ascii?Q?v4BhFwi/i7pHSL0jfFfxBRypB8Hxlt5lFuCLvdgbDgaCuyhBcDLDTNAdT6Ok?=
 =?us-ascii?Q?9MUqL1Tnql10ERnxORfrZpqJrWRjKobFBd1SXgJ1Y9MyMsh3e/VfZkxsehk4?=
 =?us-ascii?Q?ws8J6IpzcnSuIl9gQ/pWLq74iSaGsXZcNE8tfTpr0gZnUKgX5KPtuWAfnfyx?=
 =?us-ascii?Q?PXdxBsia2DTH3Rk6OhIqx3DSPul894MVun+xN5dkKXknTAfQ5hdHmLNHP5eL?=
 =?us-ascii?Q?GccwPQEiVHeak5FuGxjnrUrXK6SjPv83y9JqfCSWWG3quo7wsacXbb80vnzd?=
 =?us-ascii?Q?pUHVhzH4mMrkfujXe6vR29DCpqj+DCB/41MAvLxh8rCqr473UxqhjfhhDDiR?=
 =?us-ascii?Q?1qrVXDX7ussh0BQNSVh51ZASHm/cdNB2TiqMNMkzgx1r9JcwQmygRWjRCk6n?=
 =?us-ascii?Q?WPSfvRE5i4ZofiEQ5mxdMuQfxxzGtnUpzZqxCLzmqd4em4c/7U5wOiSPTF8k?=
 =?us-ascii?Q?t1nPCNdMq6ldNBEw0tdZkMy4dN1XQy+hLI07u4xhK8+RJDsqTi6G8o5MRpiO?=
 =?us-ascii?Q?HUrLaIw1h3F+wRMLlGe2F7CQjnxdwiNENgK0r5zY0rttqWOmgXSK5NctaEPA?=
 =?us-ascii?Q?eE8L3yCJkDX2HyzcfqHLInJccjVLrR5eWyfI1jkU9WwMrh0aySDGaG6i/7EX?=
 =?us-ascii?Q?Q+oYo7kXfoxgpUjwxk5lJ2uKM70djoZky2p3oAZEctdDi9DsI85gGJ7o+IDv?=
 =?us-ascii?Q?Jh1rQG8D/CCNZXUIbaU16hPYyUswNuyKOQX4xorh7KNFm86gWW4vvtSgFoSR?=
 =?us-ascii?Q?K4Y4WLrQDV8keG4rd8CdcJsddNSE+kNiY/aqDGpv4xUMPWazcSY2BwHXeh50?=
 =?us-ascii?Q?WBHdZHX4mpb+FS2+br1D7u7gTWAcXn6oTMsfYYQVdfmwE7eonBd9UgzhRQfS?=
 =?us-ascii?Q?8f3iXNOY2g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 625d1967-04c0-488f-49df-08da49c986c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2022 03:38:32.4585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4TwBVfC9ctoycvq/yred4ZEm0I0OSdnogAKKBhwSePa2/QYZ5XemS09r88+LsM/UcfLm10IMM0TofwtTOaUkfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9505
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

> Subject: [PATCH V6 0/4] arm64: add i.MX93 support

Is there a chance to get this patchset into your tree?

Thanks,
Peng.
>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Sorry for sending several versions in short time, just wanna to catch 5.1=
9
>=20
> V6:
>  Per Fabio's comments, drop unused uart2/uart5 pinmux
>=20
> V5:
>  Add R-b from Aisheng
>  drop iomuxc status from board dts
>=20
> V4:
>  Add A-b
>  In patch 1 to move imx93 behind imx8ulp  Drop a whitespace in patch 2
>=20
> V3:
>  Add a new patch patch 1 for board binding doc  Add A-b from Rob  Fix dtb
> warnings.
>=20
> V2:
>  Update License
>=20
> Add i.MX93 dtsi and 11x11 evk board support
>=20
> The required bindings and drivers has already been in tree.
> There arem checkpatch error for the pin header files as other i.MX pin pi=
n
> header files.
>=20
>=20
> Peng Fan (4):
>   dt-bindings: arm: fsl: add imx93 11x11 evk board
>   arm64: dts: freescale: Add i.MX93 dtsi support
>   arm64: dts: freescale: add i.MX93 11x11 EVK basic support
>   arm64: defconfig: enable i.MX93 clk & pinctrl
>=20
>  .../devicetree/bindings/arm/fsl.yaml          |   6 +
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  .../boot/dts/freescale/imx93-11x11-evk.dts    | 114 ++++
>  arch/arm64/boot/dts/freescale/imx93-pinfunc.h | 623
> ++++++++++++++++++
>  arch/arm64/boot/dts/freescale/imx93.dtsi      | 334 ++++++++++
>  arch/arm64/configs/defconfig                  |   2 +
>  6 files changed, 1080 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
>  create mode 100755 arch/arm64/boot/dts/freescale/imx93-pinfunc.h
>  create mode 100644 arch/arm64/boot/dts/freescale/imx93.dtsi
>=20
> --
> 2.25.1

