Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1C957E1B8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 14:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbiGVM40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 08:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235193AbiGVM4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 08:56:13 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2044.outbound.protection.outlook.com [40.107.20.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5798CEA7;
        Fri, 22 Jul 2022 05:56:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ks8KRFHp4b6LsK7QG7fxDrDF8vwXFFR8Nyior/qc3tPPeTMb+fJ3HKIZfXdXKNEdcX+UNQ5r294IkWCUywOzBLWfbIzwP5EC7OEY0SyFJG+TdJqKhaP9noGB1/nx2jSQwBdaDCE2a7FMdlRhVZnaCkQZz2WY/Cs1HxnSxG0q/OzWwV5XM9LZkpwFipjWm1RRuscpdV++hhL0IPp7FbAAVmIHzr5RZ3X6gwUzIsb7/Z3vnXOSl07wOkKsO+/tBTyp/9P4TLMeQdePk7VAt5O827shZNV/Q/aYZojY4Acu5Efgw15tjaM748Lh/VCnGWewVsYusaSCsgQEchvTnIIa9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mKsrAdly00Em38kdhPjSLRn68fLyjlyY1v8ENm1fQ5w=;
 b=bjGVidAsS5qsgQ4+yxvu7idg5E/bqGyzhl7hGXDi/1a6+WXKQUmOdgoCaU5TpPFfHNuiY85im8Qc69eayqNj9DDPo9179IW6lOOTglPFrHPBIbmdZ+fB/bqVJkQFaz1AGaGIjDriLdUBgQ/4TJ9TqqUY4NsdDuKQ0IxWsdBenCaWxf0Drb0sqgVR/oVbqsPaqg+mM6Ph+7aQYqRpjFZCOs55HfzVEDmYj6QsAiC7QocgL/5iGj6ljU0pqoMColBLMM50vENs+kfEsSiDsh3qWwpNxQCRYl6PeXPQDUy1vV2bKhbpfKzAvoxJ7/gchgxw9UZRuIsFvO9hdlkYp1kF+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKsrAdly00Em38kdhPjSLRn68fLyjlyY1v8ENm1fQ5w=;
 b=Ztzyye1P7zl2kPee0j4114fK/cpTGwhYl6ypoZ1bZ7jiQZspUiU5/r3I64oiLrxQpk9uBTgEY9bXwKMrrTz+8lV1ED3ZhiH3weXvn4ym90H+d0M47rw3FjO/lT6Kgm9rFwOqGPGHxvVF0R2m7+ntVTq+YvK88PUcgxuEpCYlPXg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB7633.eurprd04.prod.outlook.com (2603:10a6:20b:2d9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 12:56:07 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597%3]) with mapi id 15.20.5458.019; Fri, 22 Jul 2022
 12:56:07 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, l.stach@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, aford173@gmail.com,
        Markus.Niebel@ew.tq-group.com, alexander.stein@ew.tq-group.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        Peng Fan <peng.fan@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V4 2/8] dt-bindings: soc: imx: drop minItems for i.MX8MM vpu blk ctrl
Date:   Fri, 22 Jul 2022 20:57:24 +0800
Message-Id: <20220722125730.3428017-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220722125730.3428017-1-peng.fan@oss.nxp.com>
References: <20220722125730.3428017-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::31)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d73162a-5738-4ba5-0f9d-08da6be18ae6
X-MS-TrafficTypeDiagnostic: AM9PR04MB7633:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vDDjhZV2BjC27xt2RtfDHnlpI7g+H6VvwWHRwDD+TLwL0VRPkfVfcWhPi5YZur+Yp5DqwmD/agrg/7h2tt0krwTjl2eOPToXEFgyNbBywbpNLZ2GD1j1Xr73A7tOExCxUPmfyccGF6IfscHvGiC2qEXWZ9Qm6PY39Vdp8uKt8yKpHwbZ7ld3Z524uHpYvzXmTDQ9c3khz/ZI91QH88pKS4zLYWTxqb+Ued43UrORdysLEd2dtsH/i+tRlppahfqJi4jhF1JjxzIk+ew9oslDaZzA1RGfOWPyHSRL8rmP8BfJqrfR9iPcX6IteG+ygmPwoyJbAEA76pkPYfGu1/XI6DwH+5NB7GDFnkB3GAZjQMb98UbLsM1ISmFUeN2fxnpP9z0Ljq+W0o2iquiTTLM1r+AVSthKw87GvrjTd76r/6Iap5lcUQesh7DGpg2fAtjILfvEcGtix3YKIm4Xog3buClEg4uoBw4XVvWRHjIpAisiH/UM1mWcwPPA4/3v7+uj9gyFKx0zVgsh3l6Jx8Apiy+LnEmZ1o65qQxGPQvt6hdew3jHWcIYTh4GyAVWwWMtptqShNvB4NWKEuhVknp5wG/6MAdiGx46X61EI9YSc9duMwUbKFpNbJMC192VxhBkI5OhtMP2sB9KjgF5TKfH+im28jzeVojKqu78FueVQO8MnAt2jnsWlVuSmS+4q/v/FFvOgdLV84EOsqQpPc7AS3JX9ext9hw/i/+zodS6DEnHkag91b66h7hCriG1fAVXM9baYxHS+n/VM+Y4ELulWUcfqyAB1SNKfh4zNPzT0lWzwy8n7TT2bWqAc61hV67IUJcYwNlzSNXaPeaS482FuUnLTJUud5HMdvc99WIjWhc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(66556008)(5660300002)(8676002)(66946007)(66476007)(6506007)(26005)(4326008)(8936002)(52116002)(186003)(83380400001)(7416002)(41300700001)(86362001)(6666004)(4744005)(2906002)(54906003)(6512007)(38350700002)(6486002)(38100700002)(478600001)(316002)(2616005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?idL+Qd1+UUmE0tbgmOj98TH9+0h+d0KPXejbgN5dPJyjDVhSOMv+7Qxeimrp?=
 =?us-ascii?Q?/F2A7Z+KRKIeaMeeKaHDcntdmizMTt9PBozymjQZzKRSdEMVQ105qarZVInP?=
 =?us-ascii?Q?8s0en+mS1KzK/YBVSJ9sgkdN5M3sgDT2lJyJGXyDIRBls/pvz7ynY3qcXolf?=
 =?us-ascii?Q?Lcu5myVMjmbZwV9UAu8s07QKzvTSPI0mD3LK+7YfbJR1ep32Vsh9dh2eL1Al?=
 =?us-ascii?Q?C2J+0QfPqUFze9Q2j9X5GR9jOhuF2lSbosX0y+CpIEFg8wftG32etEimHqvz?=
 =?us-ascii?Q?fkDPEJ/PjP2oQdpCahJG1lyH+9lBgqX0GRAR7BvP+1Dy5NfjWLHhQKVR0nh8?=
 =?us-ascii?Q?waagXS69ZaOLIfEDDtzQAkI+2KWWoVftCEm2MhfpHTxhXW4tTZosfqCO0OI7?=
 =?us-ascii?Q?8p/NU7ZticGvnpJyuzAM3Sw+VPZfzc6IdA68imWXQXcgSwewMbAl/FBpNdjk?=
 =?us-ascii?Q?6e33fmhQVal+o/CHpBLvGDlb4vW0c23Q4zUm9c/J/NV61vg2/qVMJOntWbDf?=
 =?us-ascii?Q?eAZBqTS1/Hs9xW6WRp8UYJc+YAvUQG+p4MLO47ZgJfQfr4xl8HSjuE3K1uqz?=
 =?us-ascii?Q?y3+RGffTzeiGq3c9p2U4CjZVvHl2eG4lyg/IVKdgiBTcfZmWVXPSNNQpjwvl?=
 =?us-ascii?Q?bz7t7ucjdi7IIqFZpFKUOp72JmTDpDSbNZCKMZYffTm0dFLK661r5kD77Z+s?=
 =?us-ascii?Q?GMOnX9xMhGcm0lLUOLsXU/VAFZqT5LxIQFjGi9JrLOqmIUVqAGBxwsQ69LKt?=
 =?us-ascii?Q?ulsCeM/oiWj6JIXLekqbiQ8a/up5M4lpmCVW2+PbnAhnsmFae2zPEYlHjotA?=
 =?us-ascii?Q?zGjJ9EvMIg9bNjacqc19Ocgr3hDisKR2jiLeTMCSAlI5B8VYIKUs/751oxiC?=
 =?us-ascii?Q?ucNHDiHk1FZ6SJbj8Nqp7KhzrzDTmgO2gktuQ+ipbbKmV/oIX011oPMSLbbV?=
 =?us-ascii?Q?pcCg+Tx7UEu9htpdJKRTmMhwbUOfEVw4uvSOl2oeU3W0zIVLS+2KUmwtduJw?=
 =?us-ascii?Q?vKS54U9H0ymoaNDdWa8IE0N7cnrZ1kuu+lS6+/9NCqSbQo5grReKNaV574BJ?=
 =?us-ascii?Q?3TdBVVU0nHtRBn2tzGVQim3LyhnnC6p4eErRwLO8oleML/99BChVf7S+OCpX?=
 =?us-ascii?Q?XIW72t3S9UrdcFbMgJOvXOEmRLHjzigmX/neCI5aCNFT+3fu/d3YalGmHE+8?=
 =?us-ascii?Q?ovvnXPQmq4WDwv3EcfGUcH8yA0ikw/RXwA5OGDiig4fisOSi9fby1N3Kh8hE?=
 =?us-ascii?Q?NcoMCNXXuypkCXQULDbBWf+jKzc0LCs+PmjedPnESTfANbTvqQjizZBh+i0v?=
 =?us-ascii?Q?eZNxJ7DoY1HE8Bw6+smkiOEvv/TwYpV1wxEcZ4OxQbIBZLojwwh0qWfPIqzv?=
 =?us-ascii?Q?/nGLP6qwV2Dcg1neu46hKrKmxDL0WKqqPKcE429IkborhGF+vikw0+OncBe9?=
 =?us-ascii?Q?nPoT3zZP/hYhGDAM09RSCXy/HP85iEb6I/5kWuGeatw3TVudUNyDDliwTIy1?=
 =?us-ascii?Q?1uUg5M5R/ZRNCFMWms6PDzPRQK1DW4eQYpMaDYXMt/SG2FDeVTsH4Tg3YI5A?=
 =?us-ascii?Q?U0rF64JcBqYveVQ6QP3SAtsIYf9cA7aIsk5rw/OQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d73162a-5738-4ba5-0f9d-08da6be18ae6
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 12:56:07.2711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y3HorSCMQFRTq1rSriMIblocXB6cbnmBoyOznHt+jIEFLjwnrsZoG7s2NPTkdioy23lU3E9YiVJB/DxRbJwKjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7633
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
2.25.1

