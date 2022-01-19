Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7FE493287
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 02:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350794AbiASBvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 20:51:01 -0500
Received: from mail-vi1eur05on2062.outbound.protection.outlook.com ([40.107.21.62]:51809
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350720AbiASBur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 20:50:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F2BD4KG0qht/wE6cL7w9twndszIiz9OdRueaaLCmhL3sMVFTOegCvon+xPJ0uu7RRjPPFKMJR7+HBECHsTDP3OzlWiCRIv4wTWf3jQkzrbz1s7zrYTeJyaoQqOCwCzyIEHD+knnP0VjNdoU5HFGKTrCNaHM+zoBGKRNCdq/l64sc2kGzEbxi58GD/DrvsYvOazsjn9M6xTpeo/DEP7HpcPF4GgV1kd0M52Y6nM64/8IwIKx2Vinqp18v3PiODYaL/8X57VHDdCtG126bXE9yNZlfQHjVDqeWUiwalMnY1AeiK4gRDH1yaekWig7aJKdER1Edl5oBiQmEe0od9JQQQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/wAEKitPvMB3QSNvHzCGLRrnh8GIhdDQ3ehe/LSK3I=;
 b=F/YemPZuWNie5oRJcvDrgfiSTA0bH6FadxgOSoJugIsE+h+LPMITutLYa8ZGOnpPfPmsMotJ8gr6C8JVG5RkPK/KsskVma/tPOkYxheKkXC1AllH4UFk/bhn0hLz8VS3iduurRc4s1YCWjd52mJlB3ZVW51PvmXtk7ZjsLl8nRXvgYK/uHpzT3TnMBCBdkcnhIK26Sv7ACwE3JuVZxuF8jeaeWotnI/jtIOm5aCwKOeO6PgkKbbBzwRXfv3kOZNdGcKSWERHYUxltOGG4q/cYBzcozHD/ixLsuHhFR2KeK6nn9EBmR0UjY7EFaQYp/iYDUfT8tNNq1m/Y/1PF+bFcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/wAEKitPvMB3QSNvHzCGLRrnh8GIhdDQ3ehe/LSK3I=;
 b=KBREXkp4wLJKHyInVdkB6nL51NIhuPBW9WRO6ODYoM8ZlGV5A9jY/V1d372ztC6aCppmbPOiV6QqaiHcw2oU9wtHlMpYaDNo+jAywB+LfubGeB0YsWzcb3YXU19idgz5qG+rsK7c6T5R5VlS0a/mwVoCzH9VxdY9Zud6iuRYyGo=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB6907.eurprd04.prod.outlook.com (2603:10a6:10:119::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Wed, 19 Jan
 2022 01:50:45 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%4]) with mapi id 15.20.4888.013; Wed, 19 Jan 2022
 01:50:44 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>
CC:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/2] dt-bindings: serial: fsl-lpuart: Drop i.MX8QXP
 backwards compatibility
Thread-Topic: [PATCH 1/2] dt-bindings: serial: fsl-lpuart: Drop i.MX8QXP
 backwards compatibility
Thread-Index: AQHYDHO+plZ9y2qou06EQse/dVwmjqxplO8w
Date:   Wed, 19 Jan 2022 01:50:44 +0000
Message-ID: <DU0PR04MB9417F3799FB34E7838E9741688599@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220118135918.2126010-1-abel.vesa@nxp.com>
In-Reply-To: <20220118135918.2126010-1-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73a7ef08-4b0f-4695-473b-08d9daee1b9f
x-ms-traffictypediagnostic: DB8PR04MB6907:EE_
x-microsoft-antispam-prvs: <DB8PR04MB6907F6A1281FF57C622FFFA088599@DB8PR04MB6907.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:632;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ID/P6IGWYU0XiBZAcAOBfK8YLh3EaH4ur3xZ5RGyYvQxMtj3WqguoXp6Wcyw9JDbUHoZN8if8ZdDi9EiQq842LbTvh90bFeozdb8UAVTNFpJ0b1RrndEpzYocTXRI8wAOxIMw7La85iR5QweEjVdzvfvoE7SqmLe0/PWKcIgytnEPj1CYh/h9dDZ0NlQrnCICZviGCXVNks+w3S6vte6dc9EsVP8Y3N5DOujR6XkCgT/myG1drDnzJMIZPL7csk2zxvBrWaxQDOC5KwIDFxraWuADTgEDmfQ4JAFgTga2jx2QHowrn3fy/DKPFofzC/TScOprtiYc/gFJ+4Pr+aSbdpXw42Kr6UkOphDHMdWtuszasdLSMP/77jLWWB4+9Z3wuVdkV/U8iP+wyeTyZCHR1oXm9K8ZHlhPE3PC2lVB9NMCRlc+GcY2URm7Pv3sWx3O3DBtdQ4tRGhsXJfO3kN83QsTYQfzL3DNiDyoXc4vqUSQFFBD/BJsIQljhY3hAaH2lQrgAOz6nky9p0+tcdW1FX9G6EoIg+GcKhbCxqBsRW8UHCxTq587g6/nOfLIyJMP9nKscjSA4Yh3OkyqiVgF9FT1HskQVeZM0Wl+pjruaixYOh5oa2srdaltINjs+L5Vdv9VI6OMcLSnRbU/92FC4JsIFW6ewQ4Y/rq7vJqFkyOrn6VwYbBgGHF9Lf3uo70ocyQjFjAfE9XOIzknFv0Mw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(55016003)(508600001)(83380400001)(44832011)(38070700005)(86362001)(8936002)(71200400001)(52536014)(122000001)(5660300002)(38100700002)(7416002)(54906003)(316002)(9686003)(4326008)(76116006)(2906002)(6636002)(66556008)(66476007)(66946007)(64756008)(66446008)(7696005)(186003)(8676002)(33656002)(26005)(6506007)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GDn1TRxQRmCnGuEMGsDko4vqWwRYesJQCSY295G4iOIoQ9lbS4m+E0AMot4i?=
 =?us-ascii?Q?PN9ybFBgaNX6WZkGTYYcd9eiaf7qRoxZvoqHcEO9jz/QX1RVPgOWMWx+uIvc?=
 =?us-ascii?Q?00bmXj7q4AGgQ+CtIxPpQBINxP082TYE5iq7o6PuKZT2xxr9zxmZoJ6e5qQV?=
 =?us-ascii?Q?2NPw41ldJNVxV2t1zBTLeXxKaNq2ITccyaHVPrODtCOESRLz9askQ+9L99tq?=
 =?us-ascii?Q?dPno0a9RbUUCzaCmPd89pG1C4IKcpguc/ei9B/oDpORypyTFKXKHySZbZzaa?=
 =?us-ascii?Q?ZPoKLzD90rnaolLl66OOVzDxtXkc/CJdOWVWHMtmRbhAdoGMzhlAjKX0vsAi?=
 =?us-ascii?Q?FCsxyyFrKz4rj7M5np+GolUIzALjbDd83HmaLogHkp9mAAWKPc7IdOznFJlS?=
 =?us-ascii?Q?7i8x1rLcPZdh+9/Nha0ajWugbmQcOqFwuPMdLMFjrtS2I73ZspVsuf/Kfy+t?=
 =?us-ascii?Q?4wxNAY/bmNL9CQNIhP8qmarb98xzb9H3+UT4F7xu1T70d9I4SZjiXEOQXKke?=
 =?us-ascii?Q?dYF1Yz8VSBoslVYtxgeLCcDJhf9MrBwqatsy3AN9iDyT6kH54lZApA69bhTw?=
 =?us-ascii?Q?JcQOt3FGgsKwF7hZ9/FxstwgtQaQzeg1UYfC3rdcFD2PwfiSA8PxqkF40LXG?=
 =?us-ascii?Q?mmFki9NV5bicDes21JaCJpubocet647QQZexuG9l7hAJaJz6cJjMIpXQ8Yh6?=
 =?us-ascii?Q?XN11u7Yyf9yW+wqdEYFq8EiB/YaEkGznpsqPseol8eTjXfbQ5twHc1OPDzlL?=
 =?us-ascii?Q?/779XcWmA6cE/In6hwqBnQnjuur3rZeDhGdyZ0TjmVgACJORomxkQiFFNIXN?=
 =?us-ascii?Q?0arAQU5qdQc4xXIrqpmfoTofwXYSaSm5dBl4OGEUicvc2HhZACn0sOomigW3?=
 =?us-ascii?Q?rzaMVY3dM8Ch3FWtF01bN9mttxxKXQfotZtmj8OaXKpuLc6WfQ4OS0oEEWfh?=
 =?us-ascii?Q?DDlaxJzRB8+BWqZcMi1/h8Bf2d4waTIvJB6xXEHRjTp4VT0RGl34ecdMzt40?=
 =?us-ascii?Q?H0zWjZ0OP4ruPMWvHHOrmoc0OCfBSeRg6sf+4G6OBwrdAXyRlD4zLFttWy/2?=
 =?us-ascii?Q?+gOyD+Fo3NqEnRHX9hUgue0Osf40EgCjLUW+ObYbQBK0IWXxyPshkGoKSLlJ?=
 =?us-ascii?Q?GwFmjyucggB0fiEJFR/us0kcvEnsih5uFrUu/x7e+RaaCW5JeqkAvIQoSkr2?=
 =?us-ascii?Q?32Wbf9PJ3/h2S5/Oyeixn2E4DdovpQ/CxxMueTJQasH1haLpakcJwQ7W8Qmt?=
 =?us-ascii?Q?DtmSaILUNrNLvfN423SE+aUf4fAkj7m4beiHYuMid2xRPlQH9PdIPxvmN641?=
 =?us-ascii?Q?hN7MbbSw/PwHN4Z8V1fKIHBitA0CGn3UUV77nUjx8Ajd3cVPSbhloQTHwbxf?=
 =?us-ascii?Q?CVt2cz3JeKevNcRSvbh7D44Hri8VCF9IhQgwE3Nr6EDuFCk0U90KuASxvxu8?=
 =?us-ascii?Q?a7cCWDoIcAkxImYQoMWt07IdB05NSPaHLCLxjPYfLPaIzf9yhVJoeazYXmyS?=
 =?us-ascii?Q?oHXKhPf2r3bfSAOokBQLhLFV7hfyZKoz6BuMkUDq+r6A9arWLR39bcV1a1US?=
 =?us-ascii?Q?i/982oOqD7NcFI8N9TZ8LZPbmObdEZsoI1ySLeOqjsDsJMx9HMKx78uXsWLN?=
 =?us-ascii?Q?9Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a7ef08-4b0f-4695-473b-08d9daee1b9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 01:50:44.9036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OgV5D9B4uMOlr7chKAZrGOOQ4EAPosZUGwwvwugs0Z6l+px2D04DJWxiun3aq1QnAopsEuFIOzr5RM8jljZn1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6907
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH 1/2] dt-bindings: serial: fsl-lpuart: Drop i.MX8QXP backw=
ards
> compatibility
>=20
> Drop the i.MX8QXP backwards compatibility with i.MX7ULP since they differ
> from clocks handling point of view.
>=20
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

> ---
>  Documentation/devicetree/bindings/serial/fsl-lpuart.yaml | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
> b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
> index aa83cbf56d59..ff364bd0fbac 100644
> --- a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
> +++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
> @@ -20,11 +20,10 @@ properties:
>            - fsl,ls1021a-lpuart
>            - fsl,ls1028a-lpuart
>            - fsl,imx7ulp-lpuart
> +          - fsl,imx8qxp-lpuart
>            - fsl,imxrt1050-lpuart
>        - items:
> -          - enum:
> -              - fsl,imx8qxp-lpuart
> -              - fsl,imx8ulp-lpuart
> +          - const: fsl,imx8ulp-lpuart
>            - const: fsl,imx7ulp-lpuart
>        - items:
>            - enum:
> --
> 2.31.1

