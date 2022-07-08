Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CA656B4E4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 10:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237618AbiGHIzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 04:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237791AbiGHIzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 04:55:16 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10069.outbound.protection.outlook.com [40.107.1.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3438471BED;
        Fri,  8 Jul 2022 01:55:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbuLcTsX+h8yjKcIwwpuop3nhT2cT5xwauSMnQ5sSGyKRUwuqFotLjtMCeGny6+2TQq3Mg6M5VmwJd7vbeUd0OKC20Vr1O8Qcr727ddZkP/f9UmY0h7eoNQpgLYewae2TFPCcZu/ikLywx1LbzhS9eZVNwjZmytY0vP9JzO/9iKMIo/kV2XGU17c9MjXAeN2PxjH0yigKcCpkcEuBwB92GtOfBq0dE4zbtDZGByZfo8n/GmB4AfE24Z8LTpVPSZWGjgKSbdZCQKGvP1ACduZ8PPUwrqbf0xXhZ1RREMMBiGJwApqqF0PybJjUZWwMWJmX5cjxltDar4iIwr03hGx7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=33o/Y/ohCYZp4xzeDP1SPYbZC/8TudY+xtcUlfmjVhA=;
 b=ecB0+pIPR3mIP2DplXYmPpXT3ZUx8p7+ei5qXhcDWfcg/0aZhuFc+rHvM/ho6+qG6/SoML1OU9BucLBokTAdO/LU4fIwmR3eCm9AjS78fhGTfQ4BpRPbh+aR8ObjeVNG8S8Kqt7ZZW7TZVOooJ5NECHoT1GF8FCsHKPaL5H+FKfwrjPMjZxdmmkSsONpQK5bA49PQ5B1djqpj94x9mOXBIW4NiPJYfOLMszFJnazNuZsozfnGIB8WFviWJynzYgObzk7yYSC70aufW+waTsS1paYb0izHxaNQXnnwVHUHfgCi8iTD43gOUcIs8spErIJn8JG0S4sNTGMP34c9e2sFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33o/Y/ohCYZp4xzeDP1SPYbZC/8TudY+xtcUlfmjVhA=;
 b=NXaubZnSYeUyzBQyU0QYcuXC6lSjcgDf7VUqf2yLVPV/yhpEVixIyElAsGks43kMdpyZsByiVbwr4IFnKNgOU2brbS6d94VReM98JrPSTaPieVtR/QyCEcXJy+LCJ2LAm5R9GH1GHsDyr3W5NzeYlQqtTUfn/ndtaSCFCy0N+n4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB6503.eurprd04.prod.outlook.com (2603:10a6:20b:ff::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.19; Fri, 8 Jul
 2022 08:55:12 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%6]) with mapi id 15.20.5417.016; Fri, 8 Jul 2022
 08:55:12 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     djakov@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, abelvesa@kernel.org,
        abailon@baylibre.com, l.stach@pengutronix.de,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, Markus.Niebel@ew.tq-group.com,
        aford173@gmail.com
Cc:     kernel@pengutronix.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        Peng Fan <peng.fan@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V4 3/7] dt-bindings: soc: imx: add interconnect property for i.MX8MP hsio blk ctrl
Date:   Fri,  8 Jul 2022 16:56:28 +0800
Message-Id: <20220708085632.1918323-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220708085632.1918323-1-peng.fan@oss.nxp.com>
References: <20220708085632.1918323-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::14)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7fc4687-025c-48c8-df20-08da60bf9144
X-MS-TrafficTypeDiagnostic: AM6PR04MB6503:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: voGE4whkEAUGwui/9L679dCYGcT99qHitc6LX8vUROSrzvajUwWQnbv3yfJ1BZhb5WmOvBDIO6BLlJjHjarKzXj7yhQZxjDaVhCn/ptnbDBlAKrf1d0O7sPq4PF/y/hvn81N89g+n3E0AqPPuzpZd6mmzYEj6wVC4hHmeOqvCxkJu/CZDRp0ymqhWW3FS6XqFU5G+i1KtFwQlPy82zX2KlVv7P0BkKJGBLsdIJXl5HVYse58focdebLKJuDZ1yOfteLuBw74vFpBA6AahHFPXP8LJbHsmsVnQ87K2RflwOT/hIV4bppOgIcSSF3AtSapDnNZPJfYDaIr3T4NJ7PBQMwFZWdpSJ2KjceCLdKXmcVpbh+lMs3yRGbjrOC/KOP2hwWsgKI8LVyAWzexqqfuL1v5Uru5acq4/H3TtacLls8iOABgnQGpEmCT5O/MTcbV/FdFDCFKvqqjC5DEu3NASAr7qr0xvtCIZd8IO0exkROk44EBHQps0+6A2vw4C2BYP9GvflIciRHXBBhAUR1jJtJGVBc8aJqwdXvbXPcEAOgCQngBD9UerEbDlyis11YBSJ81+u2Ex4mfDcEkOeAjlert2hcVEoZi76C//SAGLMTIcdP2fPUcUgTJJEIr8EL5ByZUoahj0eQ6ovKnHDbk+FMLT2MYSOWgkbKn1Ztdv2ibaoUXAuWfFDLIWfaeWD72PL1a3JxOrkl8qjMubR+yNVzwpB8sXvL0hDsKjYkPy6Sx1VIhoR9xjK/hiwZ9/Wuwp8ryNljQQmH9oMQgLsuY2ttiAFW7vWCAg3aBxyn+5SKeVRps5Fc33NET2Y3sVtkLTQZPLY5VbEcVTJbsLxL+Ug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(66556008)(66476007)(186003)(66946007)(2616005)(8936002)(1076003)(7416002)(4326008)(8676002)(5660300002)(54906003)(6512007)(52116002)(4744005)(478600001)(2906002)(38350700002)(38100700002)(6506007)(26005)(6666004)(41300700001)(921005)(6486002)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aU5H/FjNQ0JtFnlO/XSvKpj9pOK0mCSdnUW2N1Vz3xXdAhcu9cxoycR6Sce+?=
 =?us-ascii?Q?P5suNnXUY5IEXTbWMWoFct77lr4N1SUw+D6dPV9zIkpv3LtXl8NunoZ/SFYI?=
 =?us-ascii?Q?rT10Ur3wFRKYeEwr1ycqEaH1eaiRv6s0F1lWR86cPIiYBCFTcsAfUPVoHAtA?=
 =?us-ascii?Q?rFrVs+AktRGkn1lbXVpserZAbHLOydgkgNGLd/7jk4IfasCM14v5QiHyF1Ig?=
 =?us-ascii?Q?Y4bgArlp6eKb2xPxcKSRRDcOT5sc9DmQVmw/D2RZQKrgGZyrAMnsfyVhh4RV?=
 =?us-ascii?Q?/VDdwiIRvpsG29Mm7w15LHzfquDUU/nYJhtfahAZyzFhUin2kR5bnNOQ2Ibx?=
 =?us-ascii?Q?x3DuuitqMrPQtGzVFouFi+rqYA3SkrQRCxiT3puXzgZqkPatXpve7hVlMWmS?=
 =?us-ascii?Q?ptJ3TKys+pFbN2937bxouhevS+IA7ZmzPjg/L0rbHGv1f9gr3dYqAW6ZwCUO?=
 =?us-ascii?Q?sEaQX+k6FRUUJT8g5ljMZfMlVDg/VHprHT3w/PDfouOnJsdila5LBLmS+/lx?=
 =?us-ascii?Q?yXrtbWomwSnhVqBLQtSJzlBRk01uAXUM8x/aZX2ElYgKODAaW++xD4wbhcmy?=
 =?us-ascii?Q?XW9NLwu59Vtgn6tCrXSfiXoOvPChlruokdCq36KtKXVUDlb86xKhRcPO5caZ?=
 =?us-ascii?Q?t4rv32yruWuY6/kKBl05hvgKicw+PGcaXE1s3RL/yOdr1zNNVL3uymp3ADS3?=
 =?us-ascii?Q?9NzE+RrYp7aoKcjJjKiMc4FD2BT3G1MrAp69FVah5ce8kmp6dpM6Lx47oQ3x?=
 =?us-ascii?Q?kxVE+xxjfQ6RCFp0kXVnHBuMoC4zHhDzbwXOSqGnwqX80dBjzVGwY3Jdis6s?=
 =?us-ascii?Q?mtCfZvmMo05X44fNstyNcjRBHmi/I5mtL0irWhHuzA93IufSiH9yCxPXn2Nz?=
 =?us-ascii?Q?S5XwA5KOLvWGqY8CCRKGTaMvjp1AwwU3hZVDIFAKNtGqizbvkDZyW510jVmn?=
 =?us-ascii?Q?vcEuL01fR08JjwvApLxhwp56q/rQvrX5EJPBJyKUv+v4cJJb0At6t82j5qJL?=
 =?us-ascii?Q?PgndwGZEcNTX4Jm9yXO/ZCYrxJ41asEFl5mDwnO+FQJ9DhAzNwEuh/ORlkZ+?=
 =?us-ascii?Q?SkWgXAYlGe4wfZfN1sZ7VGMoM5rFjpksbS4vdoZz/IZcqoWfx8XEVGY3h1n7?=
 =?us-ascii?Q?L8f+VfKxV9pIaIIIm0xwdc/U1hvKT/bD5/KmqcG2NWF/20qcOJe9kxCrpe2K?=
 =?us-ascii?Q?jLpIia1QcaAxqn+tP0e3ekTROO/1f5L0W1iXNyg5gE1sd6ZnmVa65jXCtleC?=
 =?us-ascii?Q?X8MeqrWACkc0M+DO6wvwmHuTDfIGGDj65Ep0/B99WwV0aj4/DFCi1UbenABh?=
 =?us-ascii?Q?rhsHkKBrYmrQt/V0nvWkaOUOUkWAMmyv86c0fy3Wbnh1hadVSBBRhJoWBksp?=
 =?us-ascii?Q?pLndUNnaMFaZfEgg/Vn0z07/lASzSrCIISkk8I+vG328LcwPqXxWaCjo4iFK?=
 =?us-ascii?Q?UwkQi5MjnV6YyRa8Sd2A2Mq/RPPSiA9OBD4vouac090IUtImOoZA6SnpNsk+?=
 =?us-ascii?Q?rv6JfIbGCUjJXMZ5WG4lRrDbENhvun4LnnmOwT3zISccP63vBLD1ksbdaee6?=
 =?us-ascii?Q?VTZmQIXA+rVxsAlEV3ng1Fk5/KL3YlD54Hm8t06F?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7fc4687-025c-48c8-df20-08da60bf9144
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 08:55:12.1700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 524rcvy2Iox8KtuldxUUGNS9wV/RS03+bhyK0Uz2QKAYWzIfON1WkQNAcdSv8JVkDhQZItV6iN53FziC1S+jUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6503
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add interconnect property for i.MX8MP hsio blk ctrl

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/soc/imx/fsl,imx8mp-hsio-blk-ctrl.yaml     | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-hsio-blk-ctrl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-hsio-blk-ctrl.yaml
index c1e29d94f40e..c29181a9745b 100644
--- a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-hsio-blk-ctrl.yaml
+++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-hsio-blk-ctrl.yaml
@@ -48,6 +48,16 @@ properties:
       - const: usb
       - const: pcie
 
+  interconnects:
+    maxItems: 4
+
+  interconnect-names:
+    items:
+      - const: noc-pcie
+      - const: usb1
+      - const: usb2
+      - const: pcie
+
 required:
   - compatible
   - reg
-- 
2.25.1

