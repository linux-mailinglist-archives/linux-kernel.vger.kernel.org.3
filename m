Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372BE4D9628
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345897AbiCOI2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345878AbiCOI17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:27:59 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00056.outbound.protection.outlook.com [40.107.0.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506073981F;
        Tue, 15 Mar 2022 01:26:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oRMPzjgBSufYr3CIyqqmvTpOV1Z/W9kwAPCrF+tIRD38V7+fpE/f961KdNvjEcBLRwODhsD8aCuurFYRu03GW3vi+8sKxIiRqqHZr6PybxKA6Oqq2GqY6XO5+tGzt81TiWCVfWcBBN7nbggLLgl+aDRtlQPugMMgqjYDDRf5FgUw2DRil7Y+gSVulRVFNBfJmbD/55NEKh/JrIq8gM2GECbZY74C+xXQDKTZXKOVCBam7k+SLOyA8JlSb1CtjbJmXOxIpMmbdhpkEQ9RTnOSc+fjNKiVoDXckCCBlmUU8Qp6Opjt1eiOiTy3d4xPhbiXEv182fe/jfnXqNSIsKBEgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VYHkpDpjLp1Uk+qaqbDDTcJkS0u6zneC43dypOzScCc=;
 b=exWN9D1wtJwZaD4RHejnR255ctWwDZq30zJxvjEHcqZ9PyUxBehOj/NdUglmgHHTzJjOIHd4ObDxjcRMx+skNUHsQM7IFP/ElADch9x6f3wzowlATjSsvrQptKuLJXCsZJ6MlyLVVPsfuKONmCU3e/JcchT5QolGHk5kvMZHwDv7qGRbZJZ1k0vadSiE1yjUsAGj7EcyiD+uSV88wUbQt1Dwa6iPzm2j1NklnWQHV321/CEH25UBMtf4ne0X0l2FLd6jWmskGemvspVMj+Ha4GtRjLWx8dZDuB4uFaW7EKAnI1/8zdR709P2+Lb9zBVfXN23kn3AoQcSfhcpY22lsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYHkpDpjLp1Uk+qaqbDDTcJkS0u6zneC43dypOzScCc=;
 b=TkOOAHuY3cgoZjdmfOZt1aYS7W1BwirPONCnN5G+e108FA6lPNz1izTA1px1SdOeEuLnCof03lz/MJ2d1dxYFcJDDSqL0MqI+YPPhfrXM/l1W8Cz2EViJpYb1RoMiLm/Tlx5WYDjo7sIhlGIKzuP553RMifrrACRP7SQ5PepQQI=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by HE1PR0402MB2921.eurprd04.prod.outlook.com (2603:10a6:3:d5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.28; Tue, 15 Mar
 2022 08:26:43 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7%6]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 08:26:43 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: RE: [PATCH] clk: imx: Select MXC_CLK for i.MX93 clock driver
Thread-Topic: [PATCH] clk: imx: Select MXC_CLK for i.MX93 clock driver
Thread-Index: AQHYOEY1Pi9g1puP8E+W1GR7t9RdXKzAHCCA
Date:   Tue, 15 Mar 2022 08:26:43 +0000
Message-ID: <DU0PR04MB94178847ACC8BC6E5D1ADBDF88109@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220315082446.3120850-1-abel.vesa@nxp.com>
In-Reply-To: <20220315082446.3120850-1-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 755aaaa1-537b-4d11-bc74-08da065d8997
x-ms-traffictypediagnostic: HE1PR0402MB2921:EE_
x-microsoft-antispam-prvs: <HE1PR0402MB2921A765398F0581C11203A188109@HE1PR0402MB2921.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W3n9hL1McU2Vfxnp7+zrij9ZRkn93F5OsAjdJ85tfj4PdiO+oNG4IQIO8HrWHsTFmTF2Z9g6Fd7irY6tkTeLq53NCSlKkE6VNXmjwCcxBuNpTDMG3iqSl9WnohrZEkDi5NfQQdaE1wN/m7sI7QAaEZfFFmPOQmd7pmhnJocRZRomldGVBPp4/BmsEZnuULCwteRDHZUHNxS6v42tggHt5GPxziYPBM4FcFlyO/wQxsdgirJQlLzVUPUkaMLauZTT9wmIT1j5lASYoeQs3tOo83f3FFRAK/uLyVA8pXuflBDk5E8loNnkNspec4CN64zOXoT20BWjY3WC63c5GhCYvlSdfKfccESmXbOQ4ZNQ+dWkt2enpBXjgyZSXxV7o7y6H4e9zUw3oEtypCE9x0UW2psvBQUMXub3xAx5eYtAavy6oxUMulE1QyKN9+/dIpjo7hEJI2lqagOW17/hln8XaMEQQIUutPD9ZIOhKFA8Yo/4jPLzSult+Yt1xAxY1cwazkTLn8wg/aHYDSHC8476TGrB7/b/r/7EtPpuE9YPQS5sbfNf1g2WDKWqceMyYadzcWUg1L7fiMVeuA+RsPCAC0HdRzKU4WrBb5hxeMit3SHod9CurzUG6/EMK3ETgGqS1NQ5sjbxauV5cbV60p0vGmetWlKk4+HJkCPNuxt3/kX7h4Ky3VJtJc1B/5+y3gl229zM3AxZvZ/smYYEbQV2LQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(122000001)(38100700002)(83380400001)(86362001)(76116006)(66946007)(66556008)(66446008)(71200400001)(55016003)(64756008)(4326008)(66476007)(38070700005)(316002)(110136005)(54906003)(186003)(7696005)(6506007)(26005)(8936002)(52536014)(508600001)(44832011)(33656002)(9686003)(5660300002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NSYhqI2AMXcLv2xFqP+enW3n6M4Ot9ijgvQ4PmP/tcDfJ4yyt25YXVoq9vv6?=
 =?us-ascii?Q?axPVu2gnw07WwxVZBkGh/CUqjQYPxwitf+t9KOcjrORtXA5H6jSOIzDtaf63?=
 =?us-ascii?Q?fSKkVfd9v+qHaMUtsfmi3t01yOyAFtatjxF0hQzCENHPPPpYWsb5SiYt5w0k?=
 =?us-ascii?Q?bRl3UbgRMxEKirt56XXV4E9ELtQnEV0g+uRdbtrigJM5wqb5Vi//9UVvKGTB?=
 =?us-ascii?Q?20X/eQaRjkijbGcDOK9lG3cHtaeJrreH5pXsG/K9Wgi5y6vK+VTYZzlLhPgi?=
 =?us-ascii?Q?o+OeXNNxNfEXG0ExixMvYVbRUeaJdqLgJDAKpli8q2lJ5lOSXOMcR5NmTGod?=
 =?us-ascii?Q?UUtExDj+VaNfSF7mevGb7aFnnxesM/Ux2SYid5CpDQpLCXpZQF32dNfz3CeN?=
 =?us-ascii?Q?0h8U8OVTe1YeoinSvtmI2p6ZvbfrJ+1BErBUUPy47MjxhBVDlYQCQc+pTgoP?=
 =?us-ascii?Q?6+mrvpBQUuuWDmG5nm7P8u+XvHbp8OkmjY/e/bixki3Ec+wmiwWk5DrNoy9B?=
 =?us-ascii?Q?tTU30csqYXrPx0ymBr87VV2DROB5j97QPLr1AuIs7blwcOdOClYEBAb8Tm3J?=
 =?us-ascii?Q?N3ta8os+7CraF4PJ6yF6Y6gPYtKVcFVK4QaJrv17e54pHjkqlZ9/VeSAHlxI?=
 =?us-ascii?Q?974crw4BBadjHOmrgViXL8WePJjIVxD+5KroMdZE092/GMZZ54nREqdyLmQf?=
 =?us-ascii?Q?E1P+GdB3nqlz4UHpUL2oxcDihNGZlXWfef0XS79pIPE2//qok/P1jHd8UagX?=
 =?us-ascii?Q?i+h83eo5cG3d3fyjduhZfIX+erGc8LqIzRWDxwr2p+GlkLPP532o/5kw/Elg?=
 =?us-ascii?Q?GDnMU8vF0g/jlc0qu0zIAjb3+NN0iXmShJPQ9NjSkASZnb+z0vNXOJnnX1C0?=
 =?us-ascii?Q?6QCO1Z3yxbxUQSM2Fn0voMr+k4D/JR46i/fhx7K5zGOYn21FwNSRL7FIepEi?=
 =?us-ascii?Q?KHfxspm2p2dr6K1vnNP/17VBPD+GeNpLJoLIs/oj8O6EQ9rT52Sn9XWwFCdX?=
 =?us-ascii?Q?zkqpqeTCY58k2KEEC9BbN6lE4t9z3gmq1oZsd3uWPr78Un3w55CO1eV+uJgq?=
 =?us-ascii?Q?oVeJDClAprTbzF4UeBcynEdTqNCGNJcom7Lq3ma62ITDOuDW68vMmFKHnyPZ?=
 =?us-ascii?Q?3OhIRjSBwyuX8CkoVT/TDjChg+arw26Plx0AWkxE5mNyInO4ulRMjaF4Ci8L?=
 =?us-ascii?Q?smMTNji2W2nNbcVI71wf2pBWaqlucoGCRyo+8B0y/8TL4DgtsVhVVXenDKra?=
 =?us-ascii?Q?dXMJf8lXf2yRESTmBum4j9jVYjxfMaoYh6itwM06dxg0JdjSehX+k8g7n2Zy?=
 =?us-ascii?Q?mlWeknFz2d8Nk/tQmgNtOv1j7vM0cubbafNyc9lWf3PdyB+A/Tz19a/kq9Bg?=
 =?us-ascii?Q?ruVDryrlG5yfAqif6PMQ1MjlC5ahwE9UZFFWzkwCXZVbki8NAo4CyFBRjDJ1?=
 =?us-ascii?Q?vkjTa/Z6/Sg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 755aaaa1-537b-4d11-bc74-08da065d8997
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 08:26:43.5713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /J9mZquO6Pj5XY5vQzC5XqDfRHAmjwdSBUOCs+h08j0q8WkvFOduoeYWM+FhNv1STewbjteMmwiknmipXoo26Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2921
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH] clk: imx: Select MXC_CLK for i.MX93 clock driver
>=20
> Most of the i.MX clock generic API is built by selecting MXC_CLK.
> Without it, the i.MX93 clock driver will fail to build:
>=20
> aarch64-linux-gnu-ld: drivers/clk/imx/clk-imx93.o:
> in function `imx93_clocks_probe': clk-imx93.c:(.text+0xa8):
> undefined reference to `imx_obtain_fixed_clk_hw'
>=20
> So fix this by selecting MXC_CLK for the CLK_IMX93.
>=20
> Fixes: 24defbe194b6 ("clk: imx: add i.MX93 clk")
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Reported-by: kernel test robot <lkp@intel.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

> ---
>  drivers/clk/imx/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig index
> cc464a42d646..25785ec9c276 100644
> --- a/drivers/clk/imx/Kconfig
> +++ b/drivers/clk/imx/Kconfig
> @@ -109,6 +109,7 @@ config CLK_IMX8ULP
>  config CLK_IMX93
>  	tristate "IMX93 CCM Clock Driver"
>  	depends on ARCH_MXC || COMPILE_TEST
> +	select MXC_CLK
>  	help
>  	    Build the driver for i.MX93 CCM Clock Driver
>=20
> --
> 2.34.1

