Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9256C57EEE0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 12:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235538AbiGWKs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 06:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbiGWKsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 06:48:55 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80051.outbound.protection.outlook.com [40.107.8.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCCE13E0C;
        Sat, 23 Jul 2022 03:48:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cfG8MC9LxO4DiCKIYjlGne3FLRNmV0gKb0g2zKvd6qN2nz1dIvLScq1dXO9xxJKAlyLMc5Az/vdWsa4qvFAxskoBLMXbQKDaVgz9RpLjZXKkst1l5G9XcaP22yBau0wOsL69BbId7cMz46CqTczt3DTiH1FyMFSkaMJ7yirloGvRYPuJryvDN/HwMnSUl206/WWJojM3VihRUywm/utGKd3kuspW9JvAUedMmh2CaLBIaNoUIhE5cFA+QhkyDQrO8iF8pkNsmevXyqxzWQI/V3QLIHezzWA265yTFNp6aYjASw8hEJntu6n6mYCo0Uv8HqQcFDDwCO5jlXRPswyzzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ibd4i820qxOgB0fNOiwI+CbZGgGoHFg+890daPK2ilE=;
 b=j0qpNdBh5HVCuIv7ThqEJlMk2nHTTP7VAows9VrcCrZpz0UggI2juee2TuUJrqPNSeZ/GT6istkablEbaT+MZvyDNGlAQop+b7n2MSSyPZ0VVzyoGB5txycK3jmN5boWUixAWUsKh1zjX9jCMWORjFSnIQM/MwZlVGZryVesuPlzRNQoNSWJjklqkzUgfT5Pne9gwZY/g/rP3QvK8JUheITBACk78KzITFg6uxswXQiq8UJSSC+caITlZ9dbPdBTqQVyQgUSVTtHRCuGZWgk2fHfdRRp50L0Sz7/unm9/XIsQ3hd4oQ6U7tmk1Z15DYtg7DfU4Qtbu7ljbvc3tNjqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ibd4i820qxOgB0fNOiwI+CbZGgGoHFg+890daPK2ilE=;
 b=bWXqLdSQMNi2XDP2TZ18g/JLwakOPK9Y7Rx5ygdRG+8g7i3133nD1YP/YZgK0mMjRGhb9QBSgbL26P72Eo+LXBZZACZL9eGy6oW65rRvVyJ1zGIXC8YDSZW3+7IZ7lkUS3eSK5yPlrYBeVW7HdXiDX4zVjYsaRVAqBKuQuwFnc8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR0402MB3709.eurprd04.prod.outlook.com (2603:10a6:803:1e::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Sat, 23 Jul
 2022 10:48:49 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597%3]) with mapi id 15.20.5458.019; Sat, 23 Jul 2022
 10:48:49 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, tharvey@gateworks.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] arm64: dts: imx8mp-venice-gw74xx: fix sai2 pin settings
Date:   Sat, 23 Jul 2022 18:50:05 +0800
Message-Id: <20220723105005.3583860-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::18)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c119dcca-0ea1-48f3-e7d5-08da6c98ecb0
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3709:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L/eD5AWqTVeMbQYwugZX4A1wCXLk6KL1VoF9CE3W7cqwmGsIfGVt9A5dQURxk2rL1ZtgjsmAN9LPE65fOw4F4mADgpE/lePnII/8HcYBJd1kQIA+JdPeKdXMhUHwtZXhrm/V/5RBgRpcs9slL5xNMJEJttsuGosMZBZD0sgG1eUNiDnGhMfQWLTRjzVv8oiAziUnXhYWSyKW8wNkVG7LCjZxTv3xAfQuuAu/E19cimTT2mWtiZJQbYF/u8hnl8o5yMMzGZtaUhsQU85MR+ik8kNW0rFeljIxzy0sH36jn2qgsSER/VZY4gS8GTcnw5wdoGmsMJay39GBRBrgbJifhoX5oij26DtRwdr6eS1Tbd0SBKwAoF12ukFXlHM6sVW7B3Fqgn38I8xnliW/QBpwl5W/Fx7ZESWBDOPojHZB+KgRGB2lDMh7jHBsV6iHrobv3NJYjhgeVaD5x9wMI/pQD9Lqq4GLZ4RA+xc6UH/6IEAXvVh2GkMqB3rm3+nP3LGinghUyU9kOxShTEICH8DULRqL6pCL190H16b2XIaNdz45LLaICbMjHruy4tvGVe9BYPcyXyLMeTd49+tFG5xnAHY40gxknx+BQlJWTD3nGmtIQ5j3BASQgVtL74D/+xnk06y+d5OP17Tdye9mY144h3YCUr2k5xgxsV/b1I/9ViqTlpJgKSkrTG+kwdDW+qa4mdL06PEzFS0KZDJj7lIC4eSmOPb+gmJq443ViZlghY6oNW0warHvq75WjWe62gmH7p7duQIss20vtThHHjaGDytagK6fWs4b6QmaP9TDwsJeljdEIvE3ywWJWfGWWQNf4ZVWP0btkaZDpjSQO+gPsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(66556008)(8676002)(66946007)(4326008)(316002)(8936002)(478600001)(6486002)(2616005)(5660300002)(66476007)(186003)(38350700002)(7416002)(6512007)(6506007)(2906002)(1076003)(83380400001)(52116002)(86362001)(38100700002)(6666004)(26005)(41300700001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PKKvlojMjRU0R2mEf7LFzr+Foj74VHOupaEUF40m43rQCCMdcfNV5XispmCi?=
 =?us-ascii?Q?J1ByI15Qd8Km7LMPxZsqTZJzsdXt/pVhogM2JqwsFnU3//uW0xdfvre/pCwR?=
 =?us-ascii?Q?HNGm2eDflJujDOmW2S0a0C81PKYptGTZATBhrjKNpyYcdl14NdcBgKJTqwbX?=
 =?us-ascii?Q?+mkgrYk+rMsnCYoEJu+XHDc9yo0Seu0igDZ+mv3uD7739z/ocvznKeCYNPxu?=
 =?us-ascii?Q?qIIKpx7CFkdeBJ7qOOZxMImwj3oMcfo93nb+q03QgP7oVTSeA4RVhYUttie+?=
 =?us-ascii?Q?ogEt3PtQ8HQZe9ZT9RXaBrIFS4odaBbMoc/IvbLNpcAchYPZHG2uUFj0+a7k?=
 =?us-ascii?Q?LxOpx1og/asUzjFPFhDe22lmvocYlEXr90sxkVQqc6mMvicwNplixNA+R799?=
 =?us-ascii?Q?r0efJaNLT4eAJmSTf6cPssyLGKqLiE9i7cu31MXdzsJ6dq+SGnah0dJca/pV?=
 =?us-ascii?Q?0wKKqKafwRuEH+BW9upZ2LI0ApaW63LfgMOWvDby1G3LGGc7pSTn08Gazqig?=
 =?us-ascii?Q?wL2F2x1fYZEn4aeKD/z1d3a8UR2iYu/hBuInTZ4ZLzR+Jw9q2rrhGGMPcarG?=
 =?us-ascii?Q?F6Fin7Ibvm7c/pRp19n9I273g8LzbRkQyPhnQ2CqLmiPPz337rmP5VGFW1WI?=
 =?us-ascii?Q?4hhXUXVvueScQdjMKF5K86OSHQznlk8zfhK40D2vKf6RDPmfuO3zmBG5pR6X?=
 =?us-ascii?Q?M8YgJDKlL5xwRgSPvcfER/P0GA/QF24n7LsLlEvAN4WBgrLmTQZqfkWLpnDL?=
 =?us-ascii?Q?ZXQmlUPtMRrZT2I40h2UM4BWnhWnUBctd59xewzngjxAoEKCt2yPL84fxL5Q?=
 =?us-ascii?Q?8fFuunote3arVCKLuA+L2v3rcinlz+cuTK/areEh0IYjifQNJD8wXlXu5bou?=
 =?us-ascii?Q?kl6kZPvYa8Ittwfp+DnjYIlus+FjByfCo0cpVtBLqPZo+jHZvx81OSkzQCCo?=
 =?us-ascii?Q?H8UHibZ+zIzJAltkxwO5vn8y9YDHnJ5I6x7QCLW5tf4l25lfx3oWoakftpzW?=
 =?us-ascii?Q?4ItbtBPu3wB6QmuoWoKQ9aPgoKEVyOdtHUKSSsED9A1tNRCnpLKeULRl0LGU?=
 =?us-ascii?Q?RMThHSDKVyKgh3ripnxVjNNPJ5RP2Zk4amed1K5mF/TAp/jETpSNOMv2KDW1?=
 =?us-ascii?Q?tEUhjPfjJmJHRs3VPZQYzvme/oWb2UX9nTsFoaz+rjLnZuJa/T4gn5gEkNSk?=
 =?us-ascii?Q?r5iDo6gg+Y9J1LnOGnRLmp5x2immn8bwcIBdnxZtLF2xHilU6H6Gls6ytRLi?=
 =?us-ascii?Q?/1XODJFprMz/dKiXka8rSrm1mWecgvGZxnJIr6hELxJhR08xTErD3tee06ET?=
 =?us-ascii?Q?vo1iGiXruXA0uYQhy0KjD+jXj2dyJIZVFKb0FT9wj+4wrTFoYMMqbBgOwkQT?=
 =?us-ascii?Q?YuD+gPd0J2RDsF6TMQRhSU7QiQr3Ru9z6m4r+5WefeM17iUDFzSwBN+y06Xj?=
 =?us-ascii?Q?1Hy8hw65VdKlknbWQBUn59mAEs5kP63aSk3psfyDbs/WjrSKlI+i3G3WbiA9?=
 =?us-ascii?Q?6f2QtUoAtJsQO5LLwcQktcm5dosXI9fXwybh/5y16vKW8xPF4of237nR/dR/?=
 =?us-ascii?Q?A5yyWrzGdUz7EFEMErFXNYLqU7LBNCAxvfjJFF9U?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c119dcca-0ea1-48f3-e7d5-08da6c98ecb0
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2022 10:48:49.2399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t4Q87IlwDQOb+Vc4prEMjsURSeEH2lrXgakHWyU8vOXLgAu5RIQXJmck0BWSYAT3f9JBwob11mN9y54CoBRriQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3709
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The pad settings are missed, add them

Fixes: 7899eb6cb15d ("arm64: dts: imx: Add i.MX8M Plus Gateworks gw7400 dts support")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
index 521215520a0f..6630ec561dc2 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
@@ -770,10 +770,10 @@ MX8MP_IOMUXC_NAND_DATA03__GPIO3_IO09	0x110
 
 	pinctrl_sai2: sai2grp {
 		fsl,pins = <
-			MX8MP_IOMUXC_SAI2_TXFS__AUDIOMIX_SAI2_TX_SYNC
-			MX8MP_IOMUXC_SAI2_TXD0__AUDIOMIX_SAI2_TX_DATA00
-			MX8MP_IOMUXC_SAI2_TXC__AUDIOMIX_SAI2_TX_BCLK
-			MX8MP_IOMUXC_SAI2_MCLK__AUDIOMIX_SAI2_MCLK
+			MX8MP_IOMUXC_SAI2_TXFS__AUDIOMIX_SAI2_TX_SYNC	0xd6
+			MX8MP_IOMUXC_SAI2_TXD0__AUDIOMIX_SAI2_TX_DATA00	0xd6
+			MX8MP_IOMUXC_SAI2_TXC__AUDIOMIX_SAI2_TX_BCLK	0xd6
+			MX8MP_IOMUXC_SAI2_MCLK__AUDIOMIX_SAI2_MCLK	0xd6
 		>;
 	};
 
-- 
2.25.1

