Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4754451E4EB
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 08:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445836AbiEGG4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 02:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445819AbiEGG4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 02:56:16 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2087.outbound.protection.outlook.com [40.107.21.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199145DBE3;
        Fri,  6 May 2022 23:52:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bk2P5RL4rTnfTs16BOWUd+q6t0WbKxC9QalX3/bg3Le20h4XVIWM2zO/mAGz5zgXWmPAdEIV2/723fBsPxqHQ8JwEUAodRXjIDcRyAXZlPzRfCUdfW1pNVDRhGMCkMu8NgoVV+XHyAmK+RhG466kpB9Azk+ex4vax1jODdSS74JIIf6Iu3mWQTGce4jsfUIOiQ8uvqHPnEK6a1+Ii8jc6md2MiaK8U+iV8L9PpcGuyR0mpRBc52HVbiJwdsF2aE6FD9DUthQk5TmVvpC+cKYsFpbmI526eT0H5g5C/OXsFxh8r+CgpMdDyUNcbUjiMI24jyImvSY5diGgziC0wsKeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtduIOQq/3VBVAmz+pBP51dDTXARSUjayH25KcAhmcc=;
 b=hlarEm9ph/jax1ahtRYbXesWxXABoT9AxeAkyXJl1xXg8Bn1ZB08yT65XnizAu8CqsNjebZsEmEH5t+D7lOx/mWTqj4dFRAp4WxpAMlunQumZhbIx+/YPNe3PYdGJnTdQG6hWt53QDyeetMYs9Zmp1qgrJ56kxzT8Zeyanl0H+2mEQNnbwOkMe97+LcpTaVTMO1zdXtvzUfh1wDdtroy7prO5IVUYVIwEBoAB055cyZwjPJxTSwuMuw9JSNF9A0VBDHZrDHfQiu1Jp5HE9rrcdHhhIq7WJnYIKlrhjv+YZozv9IRZnO36P7cEPuJT3Y+HVM4Fcj/QoaZfZYNrpgKlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtduIOQq/3VBVAmz+pBP51dDTXARSUjayH25KcAhmcc=;
 b=VBwvw0YwFbTh+6Lao7Zb05CaLPlPdCaFg/IiFzIKxzrDTj8o2fpiI/iCHC1WRaeNHXTTI1HnIL17PZGOvhsVgfl77CbIx0hMQ3E3I1j1XJ/XguSGHNRJURj8Mpa0bynXoT46PKGj5JxhrHz1Z1vCQc1d9BD1cuGUsItGtGDn/NU=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR0401MB2527.eurprd04.prod.outlook.com (2603:10a6:800:5c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Sat, 7 May
 2022 06:52:28 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fc66:662f:2a82:1420]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fc66:662f:2a82:1420%6]) with mapi id 15.20.5227.018; Sat, 7 May 2022
 06:52:28 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Tushar Khandelwal <Tushar.Khandelwal@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
Subject: RE: [PATCH 2/2] mailbox: imx: fix duplicated initializer
Thread-Topic: [PATCH 2/2] mailbox: imx: fix duplicated initializer
Thread-Index: AQHYXUcNKvNmyGN4x02HfeYaq+0C5q0TA2Tw
Date:   Sat, 7 May 2022 06:52:28 +0000
Message-ID: <DU0PR04MB9417AFDAFE3F06B3F9274E1888C49@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220501103428.111286-1-krzysztof.kozlowski@linaro.org>
 <20220501103428.111286-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220501103428.111286-2-krzysztof.kozlowski@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e267577-9ceb-47ad-3825-08da2ff626ce
x-ms-traffictypediagnostic: VI1PR0401MB2527:EE_
x-microsoft-antispam-prvs: <VI1PR0401MB252758E84F146A7E51AC217788C49@VI1PR0401MB2527.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PVuPPuAx8FnTzE5vR0GjPlQnVbXycUNFv1vdBWdfpZl99RDcWWNz43I8RzCVEaEarP9BemOa2wlSACHEZAzc/chhoY41Q+8k8S/RVt0tPJ+677cvyobNzf4YLStlJrEN7kPgtuAxe+CKoRK3iwdff/mVvHhn4zR41SxHvx8s3QPpBNw7rDlzX5hvNCN2TnkklZmyCTGoLjC9hvD7yxL7Dzo4RKZhKtP/LxdgTeW/aPjd8PJ2FjxGQ7ZmpIOSoLFKFcIIDbzzZVZBKCJ1UnszoIgY5dHdeFaOLn38Bq4payplDCBiEQ12mCqqljqjor/IEpR+AhII/Rkq+h3vAJQe8S2AHGRlZ792vomzBCcpi8HyepWdq9rg3wz57r6/ikhk3jDvu3yzHICYIf9bF5ORPduGhyGEXiS/vBXRw+ShIEQXyoK4ehkONZTjOJG8oncRO38tb8QIypqY6/N7BNtqf6IqdLVcrWHikMZeJsU0VuySzvRo2j5uTtzKoC24GX9lJoWTFaxcpWzEromyBFuGKfFBl1WMgPeV8vQuZXw5KYmD7HsdV2Srd+gRmH5v9vwRM9UjAx75D2PfXi3ji9gRJEOVNJyTKAF1O/WN65gBeEgn5IobU7La6wksZsCdH8URXYeCD5iyQAPv2RvkF66L8FbCI1pozhWCaeXSRQk3pLShUfrNN9oFlWMcGeeOjk13wSqNRYmGh0B3UAfjVNULv47MC2EP+TgOpN2tOic6xKc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(76116006)(186003)(9686003)(38100700002)(66556008)(66946007)(66476007)(66446008)(64756008)(8676002)(71200400001)(6506007)(26005)(7696005)(2906002)(55016003)(921005)(33656002)(122000001)(15650500001)(44832011)(508600001)(83380400001)(5660300002)(8936002)(316002)(38070700005)(7416002)(52536014)(110136005)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nITyYdx13Gy1c2wsKOwVpfifqa0p8WYQGd+wWX4dNp62wqXxm9n38ZPndFRh?=
 =?us-ascii?Q?0+Ro2PSGg6cOSr0lsANk4eqY8gTdpuXUsZliQJeybCxUXU7nQ/THENCveDS8?=
 =?us-ascii?Q?+ZvEcxeBfq+DRTk07R7V0zrB7qwr0BjR27w3pEJd1nDwl+R3n5svbEcsbaYV?=
 =?us-ascii?Q?WA2rynHTIO8QWOVUfURZYJ/azHKayY3gByvUP8AfbtUf6yWCfLDYqvyjdXbI?=
 =?us-ascii?Q?TiBQ3vxaCVmnoBHXUZlCovqJ8gPyJKDDzNZ6MD0HJSZrjkRlb/m7ac8MmrS+?=
 =?us-ascii?Q?W0XT6svgY6znGh4QGXLDSPY2okJ/hprDcwnMI05uwuvxlUHHnsxS2JDAXKUV?=
 =?us-ascii?Q?BqcjVrcPQL8bVDvkurPugbGOilPex75nwDFAXvY3bYRgno3JWO1MR/2kMf7y?=
 =?us-ascii?Q?KJTMyOl6oRLlYrARTieUSdpLAHDliZskmOvWUAwisMTvxF36xxlMbI946gIV?=
 =?us-ascii?Q?K9wLHXAOP2/rfhniqRFSD8tahLNp8nqIikwnK4nWWaRtOBkT7D8cYlYYj20Z?=
 =?us-ascii?Q?VI2WYqKf7XOOMxmBlMVsAX6cvIOwR9AiaCf+oJB+vU9Js1JRQ+YsmAzI0xL7?=
 =?us-ascii?Q?WfypAb4V6k9maYC4G1vMFJVyzjFirWnXiI/SNNl5IiE76TTVHHtAuHMfEcI+?=
 =?us-ascii?Q?ySjjPU059jDOiU8vYWAJPPcMSDYKm2htL88+LV0vcx6UN3Xha60O8udg3Z+a?=
 =?us-ascii?Q?g3exam0RLlh87GC6nqkplGvNE7HQ6q6SJwMnza/XC4Apct2nYu9yLy8pewZz?=
 =?us-ascii?Q?CtWpKEf0r+s/vJ68zkam0XPsMOcI+Fw3UZbtKfuSxP5PVUBD4c9hlPkNnUb1?=
 =?us-ascii?Q?NkJgHBPrTZxEKSMcpIeHueXgs0MSyAEIrjRHJpgcc9XcDX6liIC1dMds9sIZ?=
 =?us-ascii?Q?AfEHAMznno9f8SybVTQYhqTaocinnrBCGOStwjxJcCqk/IPA8JnV5fuR+AI2?=
 =?us-ascii?Q?mytjxRNkNDOblBVXo342UatAncGrhTZffuUFDf9js/oeGyWD9c6HIfYn7byf?=
 =?us-ascii?Q?8JvmtmFYzeG29rol1iyOAtyZVNLrDvBANHVqg5KvGmdoTLGwzjLNaaMYrm06?=
 =?us-ascii?Q?rP+acXgFQbAbO/8xP7sAHoOEJW9HpSjaMUkfmzDDnpCMnb8bkLSsTayDFUin?=
 =?us-ascii?Q?vSvrMYGZXqpbL7pzU8YxjvT4icCzWh3Dt3cv/g8UL094GYJhLa/E9gLNmQ/o?=
 =?us-ascii?Q?uJTQnx1c3oq7P/YUo5TjBRkSp7a1eyvnvVQ7rnjZY8INf5KTbWGwEHA4sKLH?=
 =?us-ascii?Q?n6jnD6sY6uRAkyrtY2gMchUFOuZoSjRG6B5l27DPoLdbrKDg7vfOtfRqoS2k?=
 =?us-ascii?Q?eUr9nvfXmcxXPHUiUHkVHo7G1bH5LSgiJfOmWn4GT5vf3uv+eRr/bRrhqXHt?=
 =?us-ascii?Q?zfPaZoAw0yeTYVxYoXIl7F2rygqajsrYwoZ204y9OsYKoZQQcipXa1V4IRvQ?=
 =?us-ascii?Q?W4st2d1Y+VvYixVfi44jGXImTRMQD6/azyjEuiiB6TA99brkvb+UsTPz+Ngn?=
 =?us-ascii?Q?1QzIXt9/uu4oIo9SRYRUVo5yRXtVxFHiZEgcd7QYATbZ2qFsLXCoKZquEsN7?=
 =?us-ascii?Q?C2hhwaxvnbA8fivVPSFnwTUc2iqfK7nrOM63Ua5li9btpnch5l27Hm2/RMgG?=
 =?us-ascii?Q?j2MN/u0Lh3JMxA7IZ5L8yKJKym+lb8YUT4wZhlug3uJMfZX6E/8jo6L5084R?=
 =?us-ascii?Q?RO9CwJPAWzjwHQKQPr2rRcst+8+RFCwDvx5XwDWB2XFNCKrHXM7mOVKotUsX?=
 =?us-ascii?Q?t/1I9jLaOA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e267577-9ceb-47ad-3825-08da2ff626ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2022 06:52:28.5230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +8+SuBvN/y+ttGHeH+p6ZFcs+zSwq4e8ttWKmoVrlOwYnY7+1ZfCPCN6WRg5oX9w9kin73S+7wGVIcoYtFYM8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2527
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH 2/2] mailbox: imx: fix duplicated initializer
>=20
> rxdb field is being initialized twice:
>=20
>   drivers/mailbox/imx-mailbox.c:889:19: error: initialized field overwrit=
ten [-
> Werror=3Doverride-init]
>     889 |         .rxdb   =3D imx_mu_generic_rxdb,
>=20
> Fixes: 315d2e562418 ("mailbox: imx: introduce rxdb callback")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

> ---
>  drivers/mailbox/imx-mailbox.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.=
c
> index e88f544a1548..df8a785be324 100644
> --- a/drivers/mailbox/imx-mailbox.c
> +++ b/drivers/mailbox/imx-mailbox.c
> @@ -886,7 +886,6 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx8ulp =
=3D
> {
>  	.rx	=3D imx_mu_generic_rx,
>  	.rxdb	=3D imx_mu_generic_rxdb,
>  	.init	=3D imx_mu_init_generic,
> -	.rxdb	=3D imx_mu_generic_rxdb,
>  	.type	=3D IMX_MU_V2,
>  	.xTR	=3D 0x200,
>  	.xRR	=3D 0x280,
> --
> 2.32.0

