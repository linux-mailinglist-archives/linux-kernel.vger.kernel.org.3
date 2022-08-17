Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB35596A03
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 09:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbiHQHCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 03:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiHQHCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 03:02:00 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0277548D;
        Wed, 17 Aug 2022 00:01:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HHUtsNREPsS64XNgZcu+0fFnh/PxiYv8VqZuWjrYMUZoMUpt4CxV7P+BZb7w/Bvl7ad9Kgl609sfGfrg4+870Thh50//sUAu9VrTvoDBu/sB0J/Ab/HFdsjjpuSs0FQ+TLoDhmHuPHqeoDzZLA7+uNm6JW9gbJBF+qM52WvW944DD1/J/0S2VIr/QhZfegxmaVdSetkyBu7fCagHKmj7Z+2olC+ZUPYfEYxvMZm8ZrtiMiWZvVGZtHmsm78BpVUqebwaooaG1aglGVL70HOZRveDVdBRdtFsXl2cibg6MmrMyEl/8nCKfG8AX6rwyoz6QIh5hD5BF1LkNMwqZP94yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/u3CXFHL7imdmcvFKNLqTrOUFKtn1CnRLVbqV9bBwo=;
 b=F75pMH1j17f4XkLVAsdtT6p8/xaVserveWx0UBqFTodD9Bja4zinopRBu4dEZW3Bi1DDitYmY/oxFUi8mvfyxTDcxduWtwGIyxtKlLyTwwmcLKcZmhnMkaLv1ucmgWdz12F4WiNghDecVpnljQsZV0QnGXJBsKhJ5lMTsKV3V13gGD7LnzyVaC3I9ytERjjAu+sAEelGzWAvrxJs/iAdNWYetdSl8C3VceBO7TZgc5i5irD0djFHQnL/1BFNztq0eRCl5Vtwp8gqKnfrcsWdooVHrzYsTrVS9sDmnxmgjVN6skEXZ0KyHb9pVBnhFyNqi+3GOsEOsUbUz7FuDY4c4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/u3CXFHL7imdmcvFKNLqTrOUFKtn1CnRLVbqV9bBwo=;
 b=OYckSNMpPFzIZqDoIx+YuGScX8S7NWok0+Hh++ix+DHtXgJPxHa4Oc9c3JuBlic2jthbuq0IjpTjSgMN6VM2Y/MkgkuE045lVK5q2nEJl2D/+rNi+QnbBUYrEjz8Zuq+U9Ou6aqocwIpN0L3YcL58zJjB2yotOHTlQYIPA0Uwy0=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB4839.eurprd04.prod.outlook.com (2603:10a6:20b:10::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Wed, 17 Aug
 2022 07:01:56 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5525.011; Wed, 17 Aug 2022
 07:01:56 +0000
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
Subject: RE: [PATCH 1/2] dt-bindings: interconnect: fsl,imx8m-noc: drop
 Leonard Crestez
Thread-Topic: [PATCH 1/2] dt-bindings: interconnect: fsl,imx8m-noc: drop
 Leonard Crestez
Thread-Index: AQHYsgbz7atbLAFhFUGtao4Oxb84CK2yqiig
Date:   Wed, 17 Aug 2022 07:01:56 +0000
Message-ID: <DU0PR04MB9417FC8A9879D5A5A388ADA2886A9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220817065946.24303-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220817065946.24303-1-krzysztof.kozlowski@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73a480f2-e4ea-45b0-8f10-08da801e5f40
x-ms-traffictypediagnostic: AM6PR04MB4839:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EOQJFceZA5mWXwCwGo2MirAqOfTRlMHXhTr8yH1uE4Wy4G1AWspbD6O5xbToBVqlCfROVuYz5a81c8ESlCq9x2fczy1DJQwfXNqyz2jNcK36Slm/QStFId5bCYfxQi1S/nU9POTl6LAZTmLAJBdP0tww83R3erEb1kGN47dLeLUhgBpWNU3jKALXdz5XPABat4trntV49uh2vz6nKGTpDmoZY8ni/o/EjTdI1jje3F3VNI6WbhLOCtmoLvn7ezbzMGCp3v0O/Icpzi2YQsy4PUlyqpfeAOLPa2uLEet+L+L4zHe/lyvpofMuL1WGz8cM7O0jDcN7ZP6iECM2/TSK/Dvp/jC6Z5psl9iVgOg0ZF6i+v6c/9QAiMSEMwUKgo1wWrRWYgyxj3q3hlmThf3idEdvWdhHuYhR0RB5F2R1yWvH+LuYDQueBeuxuXSGK+dQgfh1kCZp3yCNP6d3gJPkrYz2ZqpG0vszZBEi63pxomkrTuT9IG67+eprI7TPOFiSfj3VTBLiiMKnA5JKTtZpgu+osmBHjHaKbUxg7UgD6caQ9beqgTPFv1B/HYUyWjky0Fgx/9VWWxaRHbfm0lepvQsPHv4X6smoNuF4x1Z5BRbfpk4rTcNRTZD1C5nzFVduND8vqXNJISsY+8qJoikTdNWIQBm/4IXvkD7PQrICkbzxAXtdMKTZTxeK7nyQ6blJ+pANZiS7wbkl2i4iQcnDi0ce99qCXp8/0XgxkOy0CR+dNBs6JazQ8n6tNHG1ScRuXp8/Zrdx0sI6zh+OW3kXYsSnn0Dykc4PasLY8Uz44uuw5lPaZk1ugLe7ioX1/oMDUPF220xHDtkb7v5HSNbozTKK9Pn+zyBRukxRBvPBi3k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(26005)(122000001)(71200400001)(316002)(38070700005)(41300700001)(7416002)(921005)(33656002)(44832011)(66446008)(2906002)(66476007)(9686003)(66946007)(7696005)(76116006)(8676002)(38100700002)(66556008)(186003)(5660300002)(64756008)(478600001)(966005)(83380400001)(8936002)(45080400002)(110136005)(86362001)(52536014)(6506007)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bSBGS8iq629HTXc5v6XfBemC78oIRiy33VBRKC0NcHyWtvGSqmvreIlM7hGr?=
 =?us-ascii?Q?AzIyN/5Fs9DtX0viH+uXhAlRbOVANlkJJkQTfIQwmixzrXij6NfMGwOfG0Gx?=
 =?us-ascii?Q?H8tGKfv7tp8wmyKUtWi7c46RJsvQfzZYtyDn6sxtAzLY7Me+egroDS7PS9kt?=
 =?us-ascii?Q?bZ7iT3y4vzKN4sfGlml705841K8t2bBsvsOidulXlRq9boxOJG1re/xYDIcV?=
 =?us-ascii?Q?12WHTY8AkhC3GfO5hrowS2bcKFdG+Qh7Y5+Oy3DOdK4Ujx7HaKJGf5oZeWR8?=
 =?us-ascii?Q?O94XSSfzILCqXm9JNd5ilVQ+UdbyxqjKWsl7LnsdSDqj+zfuZzIWfKRhYtH4?=
 =?us-ascii?Q?EcIy4sCs5cR7P3bj9cHCevFKxIiwfMeHSJVrNbVYvPHU/xX3v5o82ga38WCm?=
 =?us-ascii?Q?9on7KTaumY1reh3lTL91QFsyiN9e94qR5Sogf1eR41YrQSczzJlr0/3ITFAa?=
 =?us-ascii?Q?i5TpEaDrEgsyKY74CQlxbXvShj7mpIskzScovUtzHozCYmSyv9ltVCi1U27l?=
 =?us-ascii?Q?4IxbnhQU6fOMhmlxq7DXb+dVOIYOstkMbHOQCi44uZGTN7/pUkcHXppyYmxf?=
 =?us-ascii?Q?I/eepg+ELIbhGfIfLX057Yno8QiEfq5TKJ/6jLnkqI6s6bXbYKfqs1a/30NB?=
 =?us-ascii?Q?UIWb5E+uLD6jYgzf8LGf7O0heFJWGzYK5E7ntDur0ejog7+dYNHlPWh712c2?=
 =?us-ascii?Q?kXnMoHocMDKBNLZeFDEz5Rl3V9nuE8T7MIMBJoM+vR1cu4Z6T7o225lZlM1a?=
 =?us-ascii?Q?+Vn0G21id9+W7MBgB69j7bXNKBBnK/ZuO+miNg3z35NrurYpXzJBdOvMZpj4?=
 =?us-ascii?Q?hMylUHW3hJmTGifMuj8Q500qqJNeMGPV35Pcj2377lhP1e4i8COp9n6+9qVa?=
 =?us-ascii?Q?8ffX5HBic+bmLaCVCbOS/eQeVNRkm78dBlj/iUUC1lW7uC1MtNJcnBA8bt/t?=
 =?us-ascii?Q?cE4boHjoI7FtGSOTdXvp2+zsWXYZqNDXKKIBonSlMBFU369ABWo6Voy/a1pw?=
 =?us-ascii?Q?as5kQb1oeazwEfq4wndAd9HuOdh5Jat1YOCg5Yb+0AfrLF+oEM+v6ZV3G/5s?=
 =?us-ascii?Q?gQM3NxoOwJ36Mj5LxK2eV+0rMqOGqEHZnTBFJbDOFz0r8INfne8cPKEifj7x?=
 =?us-ascii?Q?WJcYlHhZCPH/PdDsHty4zRWiCs4coLAVq36j8m6BeN/cWgFsZ6B4p+9qzvYy?=
 =?us-ascii?Q?oRGMc9Gefg8+TPDRy86oVvS0eFAIDnXOOZRXhL/UdqCA7x1WhGIrpZw3ML3k?=
 =?us-ascii?Q?qL7xp7hfOU+qA4v5CivPic6A0l16SRxDRMwa01AXBHcWIw0bN5pykXOuDZ60?=
 =?us-ascii?Q?75CT2u6I8nEnFk7mtyLYNhAdY6zSXou1tT6exVLAOSPEC4FYEtfass2N3VaW?=
 =?us-ascii?Q?VMOIjm3NWjmF+xZmBUT9X9bj5A5jO2MqW3uQrjiUJ8AhVilcyXZfEMnqC4MR?=
 =?us-ascii?Q?hsoaqq1ytblq1AViP+nCGIHqm3fe0EBS/RH5V98MLWYnEWtbFz5THVqhq1L1?=
 =?us-ascii?Q?oMLlRJyc+nXCUV0kdWR4eX6qcdgLEVN0qFY8mSAz98m+lkDAeu9DQOwyGsgP?=
 =?us-ascii?Q?EfXBW+j5LUIdDz3Vj5ULkX86sOKw8r93i7UTa2o4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a480f2-e4ea-45b0-8f10-08da801e5f40
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2022 07:01:56.1162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 348ftFpJc11mHGn0zPqkez5xtuD2nDu8GNGMKqwieR66LqlXJ1xJ+xUh7YBnBmeRUic32xz9x1jAJzbG57FjAw==
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

> Subject: [PATCH 1/2] dt-bindings: interconnect: fsl,imx8m-noc: drop
> Leonard Crestez
>=20
> Emails to Leonard Crestez bounce ("550 5.4.1 Recipient address rejected:
> Access denied:), so change maintainer to Peng Fan from NXP.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20

Thanks. Acked-by: Peng Fan <peng.fan@nxp.com>

Thanks,
Peng.
> ---
>=20
> Peng, please ack it if you agree.
> ---
>  .../devicetree/bindings/interconnect/fsl,imx8m-noc.yaml         | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/interconnect/fsl,imx8m-
> noc.yaml b/Documentation/devicetree/bindings/interconnect/fsl,imx8m-
> noc.yaml
> index 7d8d0896e979..f7a5e31c506e 100644
> --- a/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/fsl,imx8m-
> noc.yaml
> @@ -7,7 +7,7 @@ $schema:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevice
> tree.org%2Fmeta-
> schemas%2Fcore.yaml%23&amp;data=3D05%7C01%7Cpeng.fan%40nxp.com%
> 7C5dd9d91ca3754840402f08da801e149f%7C686ea1d3bc2b4c6fa92cd99c5c3
> 01635%7C0%7C0%7C637963163932351723%7CUnknown%7CTWFpbGZsb3d
> 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%
> 3D%7C3000%7C%7C%7C&amp;sdata=3DyeDnKhOwb40KnNYnK1FTmkklp9EjYS
> m4JCiEC9%2FVWVw%3D&amp;reserved=3D0
>  title: Generic i.MX bus frequency device
>=20
>  maintainers:
> -  - Leonard Crestez <leonard.crestez@nxp.com>
> +  - Peng Fan <peng.fan@nxp.com>
>=20
>  description: |
>    The i.MX SoC family has multiple buses for which clock frequency (and
> --
> 2.34.1

