Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1CD59B9BA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 08:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbiHVGoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 02:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbiHVGoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 02:44:17 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130048.outbound.protection.outlook.com [40.107.13.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C5726AED;
        Sun, 21 Aug 2022 23:44:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mYCOuy+O5M9LX8OuvPwSz00QbFiL32+RhscgE4RkC8k75FGGN5alORZ4VOsdobe8qqNToJ/ehM5r7ajlBWIPIX4TsJylR5gSApPP7eLNBvAG3UEoLU/hZaB6d9G4VcAoNd1wQpHKHtwwf4/LzharUnH0shjWV++9naZHL72Cbs96NGo31kgJPfyHNUcKfjN80m4aNbUXqkLALzW23QlpA63WNO1V0Pww0+5bdlFJMBdrJilNHc8hOFpKyZIRlobfL3rAJ8NKN0S7FsR/Mle/aCkbEluHFcFtvKTCLoX3iLGObE/+XLVMKBzDnCGT3LxWrI+9fZddHwC3+Quj+VDY1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UYSmPdW32X+r+EBp9qaAQpzeMIyoesTUXBQ9OMwitu4=;
 b=I5J0c2eNrF3kQYhRRP3I/Tr6nCq3lZyI/FEKD3rP9f3d1VdkaoY0emaG5XjheInbONCLevkCgTJ3Li0h9IkddI+l/i4yrdwMGne4hYv0IzeNJQXXlCv4c6FPllqAlP9u1LfiJ0LDhM9RrUYmyX+uuI3EZ3uX4bU1EIXVuPtW3x7gchwOODmW+GcAZw9uxel2EZYWkQbRJaAbCOWbCYu6n4XCbFuo/Cq1lQqrK116P1VkZ5AeuYE2AdvmntoAHsqtBBxc3Zya9qLDKKUGxvRuICASQcVyRkAMy7UmxbEV3rfaGQ4JWDxxdprPptUL635NL395NQuebm4GqmULc1g0QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYSmPdW32X+r+EBp9qaAQpzeMIyoesTUXBQ9OMwitu4=;
 b=OBSVtmHDNnQfbn9lt4MJP16Ir0HJiSnDkGS5LkPhTkPNUhs4xmozlDQwUIAMga2ouRMpym1+06Tu1HW/Bmjb2HYvKKsGDiQZbp1ijC6kk14Hztoxj803lzJ8eNiKL44EvP465rAoJRfjekXzBvznhGlGm9WXTMMbVdYCWZUewMk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8476.eurprd04.prod.outlook.com (2603:10a6:102:1df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Mon, 22 Aug
 2022 06:44:13 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%6]) with mapi id 15.20.5546.021; Mon, 22 Aug 2022
 06:44:13 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        l.stach@pengutronix.de, laurent.pinchart@ideasonboard.com,
        marex@denx.de, m.felsch@pengutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V5 2/8] dt-bindings: soc: imx: drop minItems for i.MX8MM vpu blk ctrl
Date:   Mon, 22 Aug 2022 14:45:30 +0800
Message-Id: <20220822064536.3947512-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220822064536.3947512-1-peng.fan@oss.nxp.com>
References: <20220822064536.3947512-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:196::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 985426f5-f581-4aef-f1d4-08da8409b991
X-MS-TrafficTypeDiagnostic: PAXPR04MB8476:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NGwvFEIucHNl0XNH0ZPERxoFLutuz450aOXRDT4yN6oySkuECW3GvVD+aRU1sCS6Jo2dWQPVW5BRtV5mIFGWPbnBVv60HBbEbhuy/9YawwGq0UA2aOuOAZpfuV+BOZfG5RkFxcCRIk6+xPtdjrdu7Okfu8JRmEBdnDsVCZDeGDlyS8vkcg4JiaSGWTSC2oqcGVded2jmi4jwmQZqjwMXzmpcZwfCmCTWdI9o+JMwnpm1kxppTBLUvQNYSQ1DPsQsq1tAnPZoUuKyqNhgrzsw3UPDipMOqjpJDzYy0G3+CiiPIKFiJ4Ym/G+s0qZ7BIM3rYVlBIpZXRHwc05MbF0y5JzllZsmhNIRcqbSMhorAToaq1pP7RklooFvaX7ZQMMYtdvADzTGppCTq4pRkDYhU8HMecCG5J2e2Ieae2CuAhhgl56gufF3lxwqlM9FUKFIUypqXjDnxRZMwBCSHKyQ7YCwo3blQwXFbM3xIIBEwjU0+Wu1WefmF5BuRKiI7dmU3NKZ+hYuisxE3gXd1MviFJzGVk7zeMzSpYeuWU1Cw6vrmc8OcGEQQdlcP2SoW7DL3hbQUzjs99WrqfMLkscSZAnPPIVbW8TNmw08IK0B64ehsxSey2tF8yObT0QYulXdRkDg+HVcHCPm6aXMZSjo9UmpXIr+m2lVGG73EcR4DWHD0az9Ee3hGuyfc0B2aXeR7JcmBLrw2fnHZkF9Q4ydgfwTDuCNNfMbc70ff13vxBs1d6LZzDsBw9P/2C0x75PCMkNXNJD1m62HDZWjSxqfHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(66946007)(66556008)(66476007)(8676002)(4326008)(86362001)(54906003)(38350700002)(38100700002)(8936002)(186003)(1076003)(6512007)(26005)(52116002)(6666004)(41300700001)(6506007)(6486002)(478600001)(7416002)(316002)(2906002)(83380400001)(2616005)(4744005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?22NtbyV/EiGGs2dgl0RUl93FA+l8UPg2FqCEKghK/agCxhF24nsroCZV5Qyz?=
 =?us-ascii?Q?9zlKlIDdTMAF2gZSEPmkVXSaeiUt7I34r9gClpbm34vATRv7etL6IIBkJaWK?=
 =?us-ascii?Q?tkor9b00ey/UH8Sp8za5uVNWDf29KUd53YrUc8zO9B1uZxGX8QvSjgfq+7P+?=
 =?us-ascii?Q?En/J9GngGeVN6DunF5EymgLJ4Qp8kZGAVNxkhOrAavdutzLgM4+MEeIOv6+C?=
 =?us-ascii?Q?fxx/sFn6UOMVlyFwdSk/C+nprmShCgPyWVjWu42SNWG69/8kdl5xX7H5qlqi?=
 =?us-ascii?Q?eIVLtEoVRsTTI06wxxaaOsF0Y3zbuhC5SGRq3sS2LSQXQeMobtpUpkBLtzDS?=
 =?us-ascii?Q?DwtQpkcmerhL8th98PBWBxd3PF5cL8tLqANxp6fl+hNFy6vI/IP0cC46aVic?=
 =?us-ascii?Q?0G+ZX+iuKkVZrOKSroQKlg0jQjfXOcllt3QMwax6wWnGyqVIYfujQhqFWR/p?=
 =?us-ascii?Q?uDG/MVZpWqoUSqnIWkCkOhSqY75Kz5fwX+R7XgDLc9FeZ5RJtldNGt+m915M?=
 =?us-ascii?Q?z+ZU1tb3t9yY09/a3MqpcENsKjoLy2RJtjWcdiQQ6bql8RYR8zWMrqpX9vLf?=
 =?us-ascii?Q?5XrHJi1zWiXSEMbRq+tpUjibTtWxoqCr58OBrIXl3FfucRsdJI/EsFu/Uwh7?=
 =?us-ascii?Q?axoA8itqdliKcBFcl1HGpco/uR3t0A7bS1kLxD1oW0BL6irg6w6L5A+IzNTK?=
 =?us-ascii?Q?JMky/cJPVviWu2OWN8wh+qh4/HNdeCKBNzjzXRmpqqvs1dBDGwCakHoZwwtH?=
 =?us-ascii?Q?NAa04If2UaFjdmnQT1qT6Vq+M1/LJkpqc6xGjT5gAIkjLcVw/Zh4U6e2useY?=
 =?us-ascii?Q?0FpIxFBOSS27W4cRcCifUtqyvMco7tzrBVjPST5O5EOfmppsqWJFHjGqZGhr?=
 =?us-ascii?Q?HgkIApre4QTQ8N84hlCHWQPpFtxswVyRI7rdERntwdCHlEqbUMfPvT1aT3gi?=
 =?us-ascii?Q?/UnNUMcm/Z5ppIyTh6n5pDUKjaumFmQa1Hm17El0aDhV3ZIww1kyzDMW00iD?=
 =?us-ascii?Q?LfSO3j1eEv2pHGbcKbaUJNgXW/Usa9lU5soSB97QGhLYTOn4+IZEGDAP2gs3?=
 =?us-ascii?Q?3z9MR5XcqUwJ7LutUOEBQEkbU6UpU1qb3vBneU1glcrnUoOyWqbjkyKVcmaR?=
 =?us-ascii?Q?fy7I19rq6K4AUUmZG27PCpRcU36Jr1EJtRUfw5jw0MkSb28FlvFOGMq0i+w3?=
 =?us-ascii?Q?eRGtQeoLpmV4XkGhQxz6H1TwRYlnVZmBweqQ/BFOJrfy9XEIbo2+Qajj025K?=
 =?us-ascii?Q?ckLE1JEtcOnAwR935vhLtvbjrs0Zst1Oa3XmHlBaPgu0AAPcsbiF3/BVZPR6?=
 =?us-ascii?Q?ZQPhwnhQYmzYEMTzyodFeeaskFn3Ch0n/9W0g7izvYfRsB5ETn9VKjiFc1Uw?=
 =?us-ascii?Q?E7n6lGBxtX6oXN8sDNcwO5KY5Gceul30ujQ6GhsKubTcUCMiaR0aYW2/BPNw?=
 =?us-ascii?Q?YEPcz/X23P1VkdoG1DLu9RlNyJFGm9qOvE7QzA3i43SBdUZosHaOd3p6tukD?=
 =?us-ascii?Q?FES4QBCw9sqQobGjYinSIpIuAppp4LooJQrBybAFgH90lgU1gx7oTWG9aerJ?=
 =?us-ascii?Q?nyAQgmy+jrhFcdFRQTlAn9iuZdLZp2t5YWME0tz4?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 985426f5-f581-4aef-f1d4-08da8409b991
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 06:44:13.2236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KUfohjli9gL25KxW/AZHkGGIishmol3jUxJreYPnGx9VQncOkeq6iXE7RbCBZTmyyM3KszTI5lrO4U+mx1PebA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8476
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

minItems and maxItems are set as the same value. In such case minItems is
not necessary. So drop it.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml    | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml
index 26487daa64d9..b3fb529b399c 100644
--- a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml
+++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml
@@ -27,7 +27,6 @@ properties:
     const: 1
 
   power-domains:
-    minItems: 4
     maxItems: 4
 
   power-domain-names:
@@ -38,7 +37,6 @@ properties:
       - const: h1
 
   clocks:
-    minItems: 3
     maxItems: 3
 
   clock-names:
-- 
2.37.1

