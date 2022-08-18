Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8A5597B10
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 03:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242609AbiHRB3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 21:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239267AbiHRB3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 21:29:24 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2053.outbound.protection.outlook.com [40.107.20.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BF3A0611;
        Wed, 17 Aug 2022 18:29:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=POpXXoWFn14FITdNittdIowbr6V9y8EOHLZAn4ZS1dguBgZ0RNoFQ4wSa0Lyc6udNzTUwyBAMkjg2mNvnG3oU4Nqhe+2vjkREmlJ+uvToeVxYZrq+37oHZRbwDN16Fpw9FrC1Bq8tLGm+a3X8sVqt/oEhBw/8AYUpeo4AshQOXrVHK3Jveoo7wuKZeh9oJeGrABU/V0l7jNe8t6oxZ6IrkYd8bMM7Mc/794Wmyr6KH3kiTjzyzYDmjqmuaB7xvTCku3TefxwMymGcfGsBRJE3noD0mozReJsbP+mVMS/xZKKRfl/AzTWbP9Q5DJRTmvi0cOUUz8Kw6XkORzUcB5uFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CApb9cDM8wo2XqtDM9EzI+PA/B/ptsoR4Ql+e1nIr/k=;
 b=IOAZrlW52wLI0GvG/tgRegDYMES6ymipei128L7fkmzMAHm1WbxFH88zPebtB8VPQnUh5O2qnQOXlqyy605Fi9wmoS0bxvyi49k7Tx5ko+wpQqyUdPJYUuWVJpLxBBSk8G9zTCatFWhldtkhOtH5JXp9fwtmlrFAA/IkCbFidk0uQ6bhFz3ZcBfOvryiub8iBJG58TqGUgEzgnIt1UEo28muZE7Uex7dL4CZl075pCoZ3JwHDke/J98X1bJJfg031nQwYRyUCGTGvzlsnbyhnouKl3APEVVvJvSdIVjoXzs9HN4AcGM6ygiryEJTYzMtLo7M1hGnwGHIiOJBt86CUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CApb9cDM8wo2XqtDM9EzI+PA/B/ptsoR4Ql+e1nIr/k=;
 b=JkfEGHY2WRorShkVQXKD1dubqpvQBuYxhcr/DxeBxrC8k9xqv5HhcV4ertNB/KkozGx4PR/s6Y3Veq9jxG6RnGU/6DLNe7gPjiz1najeDhFQlLPXXiZUK/7+/MrpJzPracjbOxpOKGL72V4JcNTJUaAfjS91f5B3cr02eO9dskE=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM5PR04MB3219.eurprd04.prod.outlook.com (2603:10a6:206:7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Thu, 18 Aug
 2022 01:29:21 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5525.011; Thu, 18 Aug 2022
 01:29:21 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2] dt-bindings: memory-controllers: fsl,imx8m-ddrc:
 restrict opp-table to objects
Thread-Topic: [PATCH v2] dt-bindings: memory-controllers: fsl,imx8m-ddrc:
 restrict opp-table to objects
Thread-Index: AQHYsgh/yfH+qTchP0CqSsUtIgHbWK2z3oHg
Date:   Thu, 18 Aug 2022 01:29:20 +0000
Message-ID: <DU0PR04MB941717FFA704B46F4346B417886D9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220817071050.26149-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220817071050.26149-1-krzysztof.kozlowski@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3262f94f-c33e-43b5-1b30-08da80b9137a
x-ms-traffictypediagnostic: AM5PR04MB3219:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 48z27IPM5dzlhlWkUjM8ZBBDPisyiUg932geNX8AScQJKhv53SOaQXYUy2LYwi3zG5DCld/5JUUO+ERkJW3wibnkNjodijmCxLko/4awmJm/rH/9mfA5kqQbFJBAWRFfQusg8Lh00ouxqmf079OTRDeuyiTehffNrd74TvBXEPgM2b3Zz7fcr6xD5+L4ZZu3nHEZRbhgQtWmN0i3WeJW0A9bs8CKUIUCiva0tq/GBG/7tLpxNq8XuByoykWyJbHELjF5uexOm4NOS2z24rWfN1Io3AVASXnxNi8cBv0BHhGLeftQ2fTyM7W8O/7nBWb9crnuWI8/M1qmBIU+bFxDrsk7IuX/F4dP4whGFMeGIpK52cKMC0i3u1wXO0IZt/ExiGS0BijbJ5f3iebTq18TBVnyA6CIp33UEedWbm0X5M/fT4o5k5xCn5U8T/4xWQ0+T8rjJptVlTIjGSUlG1AeWdlYN7atsM0tC+IzFXYcxPRq+R+YYlOtpRWfJNTvTFky3IWVWmIKyEocjVty25nPZQ/xpyRD1Ei0rxqGK7Lz6Vr8QpkQgzD81DSTUN3bwbdWAhklmpBDgmmsJLgapQukZrqCDrz3/r6FT1CmOkuU+NDQxcJLWYywOCASrAN5UCHJZ/3uohzdBtHpC76ZafI4PdvjTgiNTBvUu4qMISgLmDtPF7unTH8gk2fx/VOUJhrfeM06Xd/yV+E9hcEX2HqJyyCI78P9Ggj08VtWW6EeNgWQmZnuyOMzLcFUalqRk23Yp1eXvR4aR6QvLp0OCTvjE1DSclw5cs8acqZNz+EfNPA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(921005)(316002)(122000001)(38100700002)(38070700005)(71200400001)(55016003)(66556008)(76116006)(64756008)(66946007)(66476007)(66446008)(8676002)(2906002)(186003)(26005)(44832011)(33656002)(9686003)(7696005)(6506007)(83380400001)(41300700001)(86362001)(478600001)(110136005)(8936002)(5660300002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YTdUG6jckEvZfFHCzb6QzrNCmeUdWZLg+7sp2Af/M/UEwXBflMdnVovy/DzI?=
 =?us-ascii?Q?UMzcXOEsowfBY5rbPrWdLUUSXvGzN8N/AYlRugCYREbNqZld9D7+gnUlMjHX?=
 =?us-ascii?Q?RYLrqIYOXmEs9DHrnRkMSBD3qzfIurs4GjSZ6jlFWtTT7jjpWVXmzzwgjW0M?=
 =?us-ascii?Q?D2mezPtjobQHZfsQ0t55q6Cus2MnksmtH0oWD9bSRkNgjh6MPXUpCLdSo12X?=
 =?us-ascii?Q?SuCXz3LLvGuIRzd1ddB0d/B2lNvUJclHJgXfnL7Z8Y7cR0OyfS0whBoAWkU6?=
 =?us-ascii?Q?ZiBzSpI5n1R1Z+/RFdpBd6qpPvMdmjV1LjvJrkXPlP9hLbsY2QiTIChbmMq1?=
 =?us-ascii?Q?rw+gTLl/mkMordismC3o1prGANsjHjMIwAYqYbnlmVockvA5Ermk5/m2REHi?=
 =?us-ascii?Q?XGBKnbuubxsdh6WuRxsngNQbgg42ErNuPFw3D7e3guzaFKDDm6hYqNbHOIsQ?=
 =?us-ascii?Q?Uqv0wl4BquXCgl+Pu8Ydj+2q46GzE8HJEpljxd9ny5HjXW4FeDQhHHVUW2FT?=
 =?us-ascii?Q?w3kECgMLfqojx9WyuIoiyLPB09vXYpv1TQbY531edA+o9b2QSk2T3W/theIw?=
 =?us-ascii?Q?gNrTAYWq/GVdTp7VQuG9Itmvd41sCJ1wIOfrTRfImN+R0D6kluaEdFbEdyaQ?=
 =?us-ascii?Q?oeOgGvcyBmO7C/LbWB9khie5mbXIHyNGTLmn1ZL+gttugetzCeQBtpLDpSj4?=
 =?us-ascii?Q?f9ZaL9MnXwWTIGGUoSDP5nPyhtfmBHmWy1i3Bl1H7fb09axUqJL+ayA98GCD?=
 =?us-ascii?Q?EHQod6azSkrUgh1ADgc+GBPvMG8ngakNxXtBj7LT0w0KahoQNtys6Neb9DOV?=
 =?us-ascii?Q?feNsqHv1UdINALecwqSIEco0Shk8+cagdNVfdAjEmtfS56XyHRkTm6QaZ9WR?=
 =?us-ascii?Q?K/SsBE9EYo3WdbbbA4D/OzAmiBJLxIS0+UMTflPCeKcoCGz4Yh/aVAgfzVca?=
 =?us-ascii?Q?YpE6htH11e6YAWfEJ3tXoJbHdTRuvR5IUWTBGMfoHBHzGXOaio4KhEP2BEP/?=
 =?us-ascii?Q?jgcASq5YS/DVXL3ciq/cCaZHO6Sz6bhibfGmdevehmMYbWyzM/ah5UXCdyb/?=
 =?us-ascii?Q?MLj30DmmPFspWpRG3qIqxiUR3afiTiuYnishqlI4VTVcpVs9b2QOc5Q7zo3C?=
 =?us-ascii?Q?ZmDFSVnAGLEgurVgohmUe7/eIyEl7aP0fsjYH2kjF7MbAnDM+5FghWVMgeBU?=
 =?us-ascii?Q?rQqf2cF4fjxQhcDHBQ0g4Q3pf4sV5e57kysF3ok1HUlxaPCFzPcuNCX4FGZ6?=
 =?us-ascii?Q?b9cPK70mz0H5BQG8IrIxPl6f4XtEBiHSoggMqq9jSYtlJVfOYzMz34bCiDsU?=
 =?us-ascii?Q?O+KRL6ygVMdi/yVn0wGwr2/SYyIvBSvGSOsEFhGtCKnuEm0fLiN7Tij1DWDG?=
 =?us-ascii?Q?K56a94HH6VHkPNEn8YOV0WL03F2GNLCn9lvrwxD0zj64KHGYINVLZI+WiGLe?=
 =?us-ascii?Q?WRQlMC6AKsE+6N/Io4Sux/06ESPc/dp/bs67JwFpnEhEygA5GVed9CcyPraZ?=
 =?us-ascii?Q?FfFGX7opulbgmlSPR9CQha2DX2XEvDqQecoWKqbXklIuNfFiita7mrVXuuPB?=
 =?us-ascii?Q?GHHu/PS+pZr4Rxep1T4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3262f94f-c33e-43b5-1b30-08da80b9137a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2022 01:29:20.9952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ul14VkVyriZYK904QLh0+Me1laQMrWX1xFIsK4e0fCBVPrkIiTxGZLl0NousjVVfSeLI5ZuuJpj0+g0vCpl4dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3219
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH v2] dt-bindings: memory-controllers: fsl,imx8m-ddrc:
> restrict opp-table to objects
>=20
> Simple 'opp-table:true' accepts a boolean property as opp-table, so restr=
ict
> it to object to properly enfoerce real OPP table nodes.

enfoerce->enforce?


>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Peng Fan <peng.fan@nxp.com>
>=20
> ---
>=20
> Changes since v1:
> 1. Correct typo in subject.
> ---
>  .../devicetree/bindings/memory-controllers/fsl/imx8m-ddrc.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/memory-
> controllers/fsl/imx8m-ddrc.yaml
> b/Documentation/devicetree/bindings/memory-controllers/fsl/imx8m-
> ddrc.yaml
> index 445e46feda69..fc2e7de10331 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/fsl/imx8m-
> ddrc.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/fsl/imx8m-
> ddr
> +++ c.yaml
> @@ -47,7 +47,8 @@ properties:
>        - const: apb
>=20
>    operating-points-v2: true
> -  opp-table: true
> +  opp-table:
> +    type: object
>=20
>  required:
>    - reg
> --
> 2.34.1

