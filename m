Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE086596A04
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 09:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiHQHCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 03:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238639AbiHQHCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 03:02:32 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150048.outbound.protection.outlook.com [40.107.15.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158AA79606;
        Wed, 17 Aug 2022 00:02:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=guPWU0aN+oekTuJD6CLpbR0drlZJshxYyHP/yaCJN2Zb1Fl3vLVCNiAZ7erMVwI4mZv3PTys7Jqoli3G5n/8vTIGyvNM0u2bBRV9ToIl4Xm54m38KuveysAL1cWIzgq0cwXW9VG7Cd3fcs0qtDXTnuYl8lg5jDMz+gjBFKi4UIgfpUkdAww7wi8Ryiluj9x3uyJZbeZxEpzxjbbs+alxFbEFEBmhvPXUZae/n1jgt4gGhaRB40LboV3jfzkz3ZuFmF2IpfaMDHFi+tQX+kxsPcUfBgYRKFTRLZuKx3BqM7iF+P/fm9B6iVLjZS+Dy/tEHNG8vqiGF7DZrevqAhRhbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w46TRHu2lu9y6i/ubx2OUN0oaddbEmKKRbaUwjROBbQ=;
 b=aylX6Z/4NQVmDR8r1QGKLs27A2patXXvdqvrvNmY4NOG8jRfIzudgRTk1pQpFRYSdWHgK2WcjydVluL/GfbFqOwU0jnj3pJAPZkgeXDHNXGeMUY8/u/BgtxEcqa5cTKZjUkzcvvhHUoItdSeVAKta0gd971Io3kiwxw/+qGwpyz6LxBg+V3n0CcxqYIzGoxTEdjVqm9ZdqHv2PVg2hotZ9bb3FvL/y5XOILGYj5jwXHMRc/epdWOmzcTyfmF5c1tsID0IubmOjgmf6WRdEQYLziMq2SYHX7ISNitdBGXs68JSEuzT88BoCl1P+5mvVSPJMg53QArfFX8dyEVmWJUtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w46TRHu2lu9y6i/ubx2OUN0oaddbEmKKRbaUwjROBbQ=;
 b=c27oeputOs2pFafv/jJJh+jTJHMDQ5kD8t2RGVB7XZwnAcvkisxSiBExGJIwXzk36bsGVxJeqJauIAV3GOYIGO5FT2mEp1juO7tiGeKET37hmUekTwell+bOtbQr0g+zlvo4O9g9YXwmvUIsnnSluEYT5InbeyniJEk6uxpAd/w=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB4839.eurprd04.prod.outlook.com (2603:10a6:20b:10::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Wed, 17 Aug
 2022 07:02:29 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5525.011; Wed, 17 Aug 2022
 07:02:29 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] dt-bindings: memory-controllers: fsl,imx8m-ddrc: drop
 Leonard Crestez
Thread-Topic: [PATCH 2/2] dt-bindings: memory-controllers: fsl,imx8m-ddrc:
 drop Leonard Crestez
Thread-Index: AQHYsgb1sHZEtPDgZ0mK0q/DY4A6L62yqnHw
Date:   Wed, 17 Aug 2022 07:02:28 +0000
Message-ID: <DU0PR04MB9417C2A5495EC2E009A1B3ED886A9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220817065946.24303-1-krzysztof.kozlowski@linaro.org>
 <20220817065946.24303-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220817065946.24303-2-krzysztof.kozlowski@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 00ca187f-9f0f-4b16-3cf8-08da801e72d9
x-ms-traffictypediagnostic: AM6PR04MB4839:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wyvMD1B5v2rTXdhcRgnZim7Wp9ZlibutCNtlXbpjChJ7dzof70UT2Wc2IYVJl1WKIW4hzJUd1OZzF+SxMXsT5bmh4hhlLooyZnVbI4RQ2il5M9/be9W5DyXa7RPEdCzaeIcx4dEzzPmMxhC34Kx93AFqXdESckp+N3zWRd09jtJNBmZIb+rjDayRHnweZ6YPEnFTCKOmwZA+Zn5UWO4x7QnLnVIyXxHPkyVUFcrYNP39opIPKM2Q/ZXLZwxIFpWiY+uIuBpAecNzMcpQyhC3J9oFQRxAWNIK0t20YPCaFx+4iDwu8rE5w7bKmU/o8HEyYmatZOwIJ055CYD2HgpZ21pnbOMSsqXiq54l0fG1vWQAiaX8h2jEdoFO1SELIS8L+oDLO2HfDeprRohmy9tBSir3zQEyAyyu09wZJ95VYVahzhRN7pGjtgbJ0VLgemO9r8kZ0kupQ/wnIus86LFQwcHRQ4ibtZ9/d04o9OWstd19KKA2RF3w4tWBLyW12nt2frizVa8n6Wq4r+wUTKNRwti25bWlNp3sZJ4gtX7FSfHWbKSw9MSGPODj5MHK6rBXC9pZyUE19x0WFlyj43rzxTg1Q0PahFjxhTAjD5xI4D8TfTI5E1JkPG8+He8E8yUnvq9Rruh2bqoxJdN/iTin/V2kmyOQv3NrDtwS/l/rPPlWzf5oVRIIVcMvxVmZxDj0tW5i1M9xL2Wkz7jtzE3FPNDT8GrDyczaA/am/nqmwTvVSMTnutW1V1cO6QG5Iygx6NiDqN3SLFJt3wUR68OmbN2zuqz/nVBhhSh+zuW+wVZA1Hae2e1CvYiMQNtjaJwQvqMFR205tWmu9doIFUxWcFXTPyWMawVo2zQ/GxcUBC8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(26005)(122000001)(71200400001)(316002)(38070700005)(41300700001)(7416002)(921005)(33656002)(44832011)(66446008)(2906002)(66476007)(9686003)(66946007)(7696005)(76116006)(8676002)(38100700002)(66556008)(186003)(5660300002)(64756008)(478600001)(966005)(83380400001)(8936002)(45080400002)(110136005)(86362001)(52536014)(6506007)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sr+h3a6v4BGxQQhopXzoxqD9DuQkjVO2VvGwvAmkvfCMKO2lTAVX3ky4CvMB?=
 =?us-ascii?Q?L2ieZQKj24cwsd3ZODNG5zmcCfQrarT0z1E8rw2KsyC59ERMOaGlsdMeuwCC?=
 =?us-ascii?Q?WVHJwLBuWDGh3209tf3pGbbHwpd5kRYtMfmUCek5XlzfklVSFdJu/Pv+a48s?=
 =?us-ascii?Q?YSH2xVUHqKPRmWcHpSuZZ8SuUa0kN7z/AyFFRw/hjmdWCkHhMSNoL+mPgbAf?=
 =?us-ascii?Q?KmZXdKPynJ2HiMOLwdQRnpykvdZz1j/qx2gGSu1+BJe9vZBntq+BTwQeh+6F?=
 =?us-ascii?Q?Bq85vgHPskKZeJlfMtAET0lXv6BXyIK7pA+PxIQaE0NY8byIVNCCphLIFkVW?=
 =?us-ascii?Q?DMv2fXt76d57Z8k9oLK8la4j5PiA5cDa+krhejHy8XW4Cu4LP4dH5syQQU3L?=
 =?us-ascii?Q?zbeoaE2yD+Mb8kFYqFsoybC/ZTwCJY96a6zH4OtuundmYOizuEVxXvcFkmQz?=
 =?us-ascii?Q?eyGZojcs2WtYZ+FILE/PoEYyVxpeUfgFOfwy8z1XuBjz3ViFpLB0jNeICkuZ?=
 =?us-ascii?Q?PNM1ARM/INZmqXijBjXy2Vz7gg/l7VpblGPKay9Y5ZArh8vwi2HQIAlplhWL?=
 =?us-ascii?Q?TJP3B3RwaH2CdkgipS1ocptS6Y4+qBMSauCs678Iy4e0yVxJzpZyUm45zKVc?=
 =?us-ascii?Q?nXEtkHho1eQtizU95dGrs9GW++8N2RZWFvRk0vE0R1K/hyyqZ6BWiTK/rmWC?=
 =?us-ascii?Q?fZffuTLZpPh0loZ4BH/FH8+jrCYed+LuVI+ViB2rN8s9gT+CNkMVQ9b6uk7J?=
 =?us-ascii?Q?llufu3hanTTmlhK6+wqBU4bC23dvqU/zp3KSy2wWXy7hZFb8d/bxkQxa+uwy?=
 =?us-ascii?Q?f+IQod7TKKFfganEAZ8othdrByOT/JUpaxmRX9/9QL/4p1No9jQWYabjOmnW?=
 =?us-ascii?Q?nD7MsY81U/uIjGveDqz6VHl1fgShHXgH7wUw9acylCWvcly32QVKkFv80FVb?=
 =?us-ascii?Q?yIl+96sqZxkGOhPYZ1ErBLEMSLqjuxU8iPPk85i+mq4CIL9gvOo6NZNavXey?=
 =?us-ascii?Q?NE1Er2FUFKx4VB1GlhRv2Z1oV6Rn1Bxl33dUDMThfxiMLg2EdB8MVmBYNZZD?=
 =?us-ascii?Q?j5rFZK108nAWZ7ceSzA1OnJ2t5fcnF6iGhF4WaSJoeg2p8zpFaPb5NxhNT1k?=
 =?us-ascii?Q?xUAMdJzYNcB1X3Q58OQYdHYy+8/FvcEMdq0D0qUj6biM5D2wg3b6mBVeDYDd?=
 =?us-ascii?Q?2rXyvObrMcscqZDdYCFUcloj9vUTFh00xunP2SesGDgv5O4oEenluAgT8bPv?=
 =?us-ascii?Q?/QulwlDiV6PIXX0Qj9UnREZReGEbns68sTSYATMc8umQapB/mwg8rFPV9wSI?=
 =?us-ascii?Q?/Z5nN44nTZWlPoFv7uR/FwzbMeNbjZ6ccjCtZ8HcrbPp7nStyWbqu+P8ETQz?=
 =?us-ascii?Q?p3yYkQ8w0AKhjlXyfhKhkkyirFMh/AX0vhaGWf/VxZ/KIxV9TLn1EgqC3v5K?=
 =?us-ascii?Q?JRhmxw21WaaxOsDfnO8xkk1Hm0yf7n8e/oSNqNRK5NY0ragXXLPD4ZLS+6H0?=
 =?us-ascii?Q?8hbSx8JeHCFXstZBVCDRiS0jLEW3TDbQyq5gGGBDoaPIB7yoLsuze6t+lzTm?=
 =?us-ascii?Q?xzK6PER0U66ImgMjpZduBQIyakFzDYN4nxlwf+MS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00ca187f-9f0f-4b16-3cf8-08da801e72d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2022 07:02:28.9935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vEOAJZe8YtxVVUvgaUtWhzcRBfWl1XQEuS9ldCrdU9A7WZvav++Hqc3itVdKMeA5PTHnKoukT3ktY6ZRWutp1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4839
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH 2/2] dt-bindings: memory-controllers: fsl,imx8m-ddrc: dro=
p
> Leonard Crestez
>=20
> Emails to Leonard Crestez bounce ("550 5.4.1 Recipient address rejected:
> Access denied:), so change maintainer to Peng Fan from NXP.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks. Acked-by: Peng Fan <peng.fan@nxp.com>

Thanks,
Peng.=20

> ---
>  .../devicetree/bindings/memory-controllers/fsl/imx8m-ddrc.yaml  | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/memory-
> controllers/fsl/imx8m-ddrc.yaml
> b/Documentation/devicetree/bindings/memory-controllers/fsl/imx8m-
> ddrc.yaml
> index fc2e7de10331..519b123116dc 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/fsl/imx8m-
> ddrc.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/fsl/imx8m-
> ddrc.yaml
> @@ -7,7 +7,7 @@ $schema:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevice
> tree.org%2Fmeta-
> schemas%2Fcore.yaml%23&amp;data=3D05%7C01%7Cpeng.fan%40nxp.com%
> 7Cbc4ca1b3eb7f4ea37a6f08da801e15ac%7C686ea1d3bc2b4c6fa92cd99c5c3
> 01635%7C0%7C0%7C637963163958140691%7CUnknown%7CTWFpbGZsb3d
> 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%
> 3D%7C3000%7C%7C%7C&amp;sdata=3DaRsRxhGmrmdagEf8lKIZYpYMaW1E87
> 7GWn4j%2BW9e2Gw%3D&amp;reserved=3D0
>  title: i.MX8M DDR Controller
>=20
>  maintainers:
> -  - Leonard Crestez <leonard.crestez@nxp.com>
> +  - Peng Fan <peng.fan@nxp.com>
>=20
>  description:
>    The DDRC block is integrated in i.MX8M for interfacing with DDR based
> --
> 2.34.1

