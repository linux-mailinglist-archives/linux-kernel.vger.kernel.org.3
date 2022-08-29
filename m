Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01E45A4271
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 07:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiH2Fl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 01:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiH2FlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 01:41:23 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2051.outbound.protection.outlook.com [40.107.21.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C803225589;
        Sun, 28 Aug 2022 22:41:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4v6YIocwBog3TfbHtyh/EFvbwRKgRKPKFqrTGS3gvEkrrbmQsHQ+1z1CwDepxEyKWKmbgUc1PeD8LA8lpl4V3mzofLm0LBGtyts3+OxzgUnFXY1iM4EOzB/lNfqqYQaep8apsWOCAJamdxYJ1TIcUFk/ZbUR1nZlYj0M7Srljabp/MmdZ71GYrOk/1N5FAzKCU912oP0O/341PO+0W7po92CXQi/3l92hVOoghsy5T0rBo1g+ifmaKhClQ6qUSW66SUaNuC6JqSqUtc5xMbBwEqkiPfBc6JmG9ftAzCA2T/d4I1LNMB7BlCovE+35akFBdQHDzMiW6DXMoA9MseQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IfSbwQrIO9R21GSt/b+himE5Q+JeEAk+XFfTJfxiJJM=;
 b=QXCfQJL5fbCKsFDx5OrLlsTP4jG4zLTbXgd1wYNNT/jZTz3CiQ9ZEYok++CfsRN1A9ShXW+aBvK6OHFYar9tVKY8TxMMWIqHE+C5PTBC6Dmv1vBeffOlqzh+vzmKYqqln49YcuIQtMKLMFexJBwErNzBDc3r8uJ7bgSIFu+B8UccUt776SMPBw/7okYNkvobU9z8hPDfnElTNeLJHXS0yf6YHCYAoz+SdmQTacKf3Y9BJMUrcZqKvZcYNIWcR88ow3OYQeUaNCzGWC/BpVivFlTeXx1g0F1GbarbqkGgvvhZ9nHFuHN79dPUdwVR19X86bhfmzhDoQXCXpK69WfT8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IfSbwQrIO9R21GSt/b+himE5Q+JeEAk+XFfTJfxiJJM=;
 b=fFxE41Deuq5qMBlSUUa4Mc6UhklBRBGUpPtV6oyaJS3yN6r/4Q+dNO2/jlgi6ViyhyNYKjGW433h8KRLjARvHbI3ME5UUO+VuktYevfNDFiEyffNTZxxMl5ClftVSyWfozv8vfSqVHkH1lX8J3is9tvb8aGJqRhrmHykWOewRFg=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB6PR0402MB2886.eurprd04.prod.outlook.com (2603:10a6:4:97::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Mon, 29 Aug
 2022 05:41:18 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%6]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 05:41:18 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Marcel Ziswiler <marcel@ziswiler.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 3/5] arm64: dts: imx8ulp: no executable source file
 permission
Thread-Topic: [PATCH v1 3/5] arm64: dts: imx8ulp: no executable source file
 permission
Thread-Index: AQHYuYFHALjJdq4o7EqA39cHolr15a3FYMhA
Date:   Mon, 29 Aug 2022 05:41:18 +0000
Message-ID: <DU0PR04MB9417C07E03D931C982B1645888769@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220826192252.794651-1-marcel@ziswiler.com>
 <20220826192252.794651-4-marcel@ziswiler.com>
In-Reply-To: <20220826192252.794651-4-marcel@ziswiler.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5dba9d6-8fa2-4666-39b3-08da898118dc
x-ms-traffictypediagnostic: DB6PR0402MB2886:EE_
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jz8LbICQC/3ltyalSyBnxCOtemeA5KX7lfx37gJ+JoqKEauCbvd72qodn+KFCbO05g5Ugdh//5E+ZRewL7WVSwWvBgnT2RnZAlSLqerM3G0nUNBlzqOwHCtaGbRNJzmtPNqRdKh/MXL5NW7Jtv1XgczJHH1cgcwZoZcFaVPTK/Hk7qwl7uZ0ygWRNIQgwDYCDvgLvJKNLz5mHQG5lv6y75F0zmp37WljBxM49D47UIqIl3emHar9KMMKP09rZhfwfBeFjapYDU/ICTNseIsXX6Mf2FkzxbWH/nGk1hkkH6NlOPsn9AzyuTm0KDnU841EWdOsWN2i1tcYzXAnxzZuCOgq8Ki8blf5YZGQnG+rwWOvzjdpoKcIJUqmNSv/DgU/UPTijYy5OPILB0XLiliGlwTrSEsv1naWRZ8F0ErrNm5zj/SU+5Ggli4d6Va6r/cxm1GhXBE+77QoXMsZWyrq0xAYWicpKTN2N9ilVQYsp2XhlmaFrqAmSKjmEkFuOjx8GElwGsswM9JLmNfbPYPAEwVbk0j/QP4nvlbnlahdwWUdEq+lT5bEK73u1NFxOj9KoyUHh2mFkC+v04WEud9pIAjw8kF3z8AOrTu5bCYk0U2j9yFkgC23HT+DQAFEVSpmzn0qo4ta/4RbyLlJIcjlZo1kigNjNyVZvitZGJmhYf+9NhbacwXUZRvoHFfzF0uiAqmChqlByQCvsJvbwMCTOV6vHoeWPDh9j4sKoxY3M7pJewLTaDqtU7crZft3B6lezOxt4VlkRG2PY4z2TjQ/4UlJ9d/C61PpQIFslfZxsP8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(39860400002)(376002)(346002)(366004)(64756008)(38070700005)(478600001)(71200400001)(55016003)(7416002)(4326008)(8676002)(66946007)(66476007)(33656002)(76116006)(83380400001)(54906003)(41300700001)(110136005)(5660300002)(4744005)(26005)(86362001)(38100700002)(6506007)(66446008)(7696005)(66556008)(186003)(8936002)(2906002)(9686003)(52536014)(316002)(44832011)(122000001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9fsboFD/0Cd/vaXanKJ6vs9srrutH4G2boS3NhuFnhqCCunNZ3GBsQzxl1lA?=
 =?us-ascii?Q?mdRff0Sply1bg+1RTA8dVKLnOj29oxEZp7hqBa0mFfE5I2MNAMz+iAsoZJUf?=
 =?us-ascii?Q?nQ15gKQRIYWeium5fF7vaGqUG5sQE/fiNkATAhAGo2ihsGeEZsdHMLf0YrwS?=
 =?us-ascii?Q?A4VtDJHvCutCQLwtvXfk5li/eHgM96oWK5b+kmbBZIZw80Am3kXrGoXx1FS/?=
 =?us-ascii?Q?L4V53xM+gzNHCkqMCGQbNEBLGEXEXe8TTG+rK0pu6QCK6By4lgg1JaEx2W6+?=
 =?us-ascii?Q?s+hIv4nNsJK+rpE7++YXup8x9PrVmgv/aZ/9rO8vnLvOvXKhLJgplyq3Pwoy?=
 =?us-ascii?Q?mNwbl6BrABD1gXE2QgIZnYgw/6KQGQvVNBOuhfZuf316uCVXTjPBw6pE+eFw?=
 =?us-ascii?Q?iBGPQH7JcyBpkVouauWYXrvmEwQwIUW672kr8zjRObjdnmOVWxfuPvPJQZDm?=
 =?us-ascii?Q?4Irq+SUfqVHrC9NG0FQZIpqGglGzxKbrLMt0j2qxCsOJLYGM0gbtBffiB96g?=
 =?us-ascii?Q?0zkY8Vck9pfoGzODKtQMOGG8Zc4ud6qL18mkms/TpsfTuaCpv7ostuQ5z1sg?=
 =?us-ascii?Q?dzlcUm4QQftIuWTk8Gbg62kPvHPLAsbCnkuLuandA/kCUJnTJUlQ/GFDNFjs?=
 =?us-ascii?Q?gVZtV34RQ9ORqA6bvxeNtC8XyZgl3ZYqIXGLfzEuZEFe9J65N2Gmt/eJxzin?=
 =?us-ascii?Q?U6yIdKCWaPBEJ687pihbis4kdlemfQ51rKX1hZ4tP+WFh2WyxiK+n7owKz91?=
 =?us-ascii?Q?SypscX0+Y4iNcARa8oRlgeY2d8OMv7WEPUwQAilcDH8lsZK/WNJaknS0atb2?=
 =?us-ascii?Q?1LLmpWr+y9BhZbxmrSDmFXHmZJLlt4nlp5iHZR3RA6cXKTvDBeot3/dq3kXR?=
 =?us-ascii?Q?WHeXW8nWcaGM6gORCYRCX4XwS6q57CM/ALQgdxKZfpK/lEYRQ0PQtwDd3WST?=
 =?us-ascii?Q?wlDK2AnwqEpLNEbvCj3sOwwZjCcqbgz9vYfPseAs6/5ttpixmewVs4nkFQV3?=
 =?us-ascii?Q?6xtZF1o8koG5bFDAuknfbp4PwLUt24J2GtSzOzEdZJNkbr1ybg6doYvdWctZ?=
 =?us-ascii?Q?z5iCxriBF60GJbStR4nUJukh1n3SVLDM82dpNnQc/SXI+zRRRUQ+guQC/n03?=
 =?us-ascii?Q?lwRqhheolSSDiegWyTHoSTUzA/wQgpf5dTIgXiYY0FxnHvH/60IkuunjZkUX?=
 =?us-ascii?Q?mcblfKurn4bjyaB6ibh5C1vJ7OkUnZhhNtpHBOrozI420ow/JwNZIFY5BbpT?=
 =?us-ascii?Q?Fh2Jci3n5rDsyS+5sk0jDwjlHFTmCmMTsZzWlcnwoHs4yTqeYNVZ2deU1hca?=
 =?us-ascii?Q?tzqpc7GsdTZURDaTGLT8ITLDmwrgYXitVSe+2NjPjh6UgxFWYDDw2g++DSRi?=
 =?us-ascii?Q?WEDCDL8U2sSQAx7ziQaVYljxN3p3mg8PemSN13q6F/FjppS7yhFRPut9UtO7?=
 =?us-ascii?Q?Z9+loc6xWfIsm8GkC9h6zqMjsC7i4ShyTUA9PKjYmradN6KxXHqEyKWTV5Wb?=
 =?us-ascii?Q?wN/rFOSrXYTy//iSGv3dY3x27aBnGrD6dwN5vTX/5pyrUNo1Hl+x+Ziv8s20?=
 =?us-ascii?Q?y0udlglUpXVOxQwKsOg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5dba9d6-8fa2-4666-39b3-08da898118dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2022 05:41:18.6750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MLQ4k6W1Ank3Ijs6p46CbAcBI/FyFfxIn1hORNqxhxMx7fZfLawh/+USWHQXJoMIdTP6774vAvk7zruvwxEu6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2886
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH v1 3/5] arm64: dts: imx8ulp: no executable source file
> permission
>=20
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>=20
> This fixes the following error:
>=20
> arch/arm64/boot/dts/freescale/imx8ulp-pinfunc.h: error: do not set
> execute permissions for source files
>=20
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Acked-by: Peng Fan <peng.fan@nxp.com>
> ---
>=20
>  arch/arm64/boot/dts/freescale/imx8ulp-pinfunc.h | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)  mode change 100755 =3D>
> 100644 arch/arm64/boot/dts/freescale/imx8ulp-pinfunc.h
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8ulp-pinfunc.h
> b/arch/arm64/boot/dts/freescale/imx8ulp-pinfunc.h
> old mode 100755
> new mode 100644
> --
> 2.36.1

