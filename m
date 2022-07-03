Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342FB56464B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 11:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbiGCJN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 05:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbiGCJNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 05:13:20 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80071.outbound.protection.outlook.com [40.107.8.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFE1D48;
        Sun,  3 Jul 2022 02:13:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bww6PzqRqDFmKGSzSiV7r9EGRbZe1Ru0Wb8z7V57u3YpZZjyHBt2LFc0Q/ff97rAByt4VZQ7pJCD1/Hh+jN3YP24r9g00tCt+gOEi2FfwoGoqni+VpgXqmHH5oC1pj8zOzKSo7cE5U3yXYdIcayzLg0APRW7S45eKSApFVlbVvrMWjXi8GnJh2D58p6aHxHyOWkBkXwsic0kR3fCO3ZB4vpAalxd4FnhMbkgfbGSWOmRyis3w8r8zKz/cZlvsYV2TSZlJCZfNLLxiCzbyPKuWNaWmVaWI6tSkOdnvWZcAHm9QYJtT1ZAGtXqswGhqxLzHjEx6uiSYD0x0jjzzD0h8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YiA+8OnmQ7YBctwKVNxjpamwVG7ltfYqmjcEzCuMMxA=;
 b=H5HMdJ1CFGXOSKxONMGV7VgP+InLKYRqcI3lbYL7x4kzNXigLzgqXrt49D/I+ybOkJDl1upkc7iIRwovONzKRj0M+LFChLXs/K4NMWEspUGkNGYRA30B310Ovxg/pH49e2iiPzSHc+t80Cf6sKSH/A+Wm2aEDZ/Bg/tVC1lLwfG1o/gubcqZQ/z9vShu1DVvRcv55wTroY2Liz4O38mUiV75Doj/8KyJ7i4iJM8ZZ+dP4p/1tQlVMRRRCi9p7KFvAoOYIfAs9dXpaB5U3R+X0+DLskwtgYTGRbupzxUq8FpyKLLUmehnGgQ7Mg0q/MeUFP1fi1HvRxJK8hbFyHG3LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YiA+8OnmQ7YBctwKVNxjpamwVG7ltfYqmjcEzCuMMxA=;
 b=XY3pI5t9aAhgxSRid9GzPaVfxJGB1WzcC8WjjnPg2pf54zipCGY88oJXDyvmQqUIhJcqWfBkCEpPIznbeSGV+iiv6v34MGpMz0MCNEGuA6H/pqZiiV/QqMn+5tAIQVfxCDUxxwq40qoRhbv3A0YXd6D2UIsGmj4Y7t6OiwKGDGM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7768.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.19; Sun, 3 Jul
 2022 09:13:15 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%5]) with mapi id 15.20.5395.018; Sun, 3 Jul 2022
 09:13:15 +0000
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
Subject: [PATCH V3 1/7] dt-bindings: soc: imx: add interconnect property for i.MX8MP media blk ctrl
Date:   Sun,  3 Jul 2022 17:14:45 +0800
Message-Id: <20220703091451.1416264-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220703091451.1416264-1-peng.fan@oss.nxp.com>
References: <20220703091451.1416264-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:194::6) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f05e16a-4947-4959-ccf8-08da5cd442f2
X-MS-TrafficTypeDiagnostic: AS8PR04MB7768:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Y1CCw6X3as9QUs8rRg+bpQF114a5SsoYwIqztNwQLpo/lDKRgxDzOF3wBJsDosHqrF9myEYu3jNGaRLZ/IDdDq7ILX3N9p15565FWB+iI5NqRz8qT0E0StooOYH8pRRvhg8L2inog0vcbXu2v/YT/TElcQ99bqHl4Ykwm6GML1NgAg3lSgqUPU0zF6q+hw7SxL1iV2+OR8H/M3sfYaii8n4IgTWb3ElNYYRcLiGTXs03QqXqUkN3VBnjpGP4mXV2sAfKdEnlPLlUeTkdstn7tzBBiRWHoa/Lb9aV6T0N1UgNkN3o7xx2qKMXXCf/sOIEtHzkdRR4mzddgEzQdve71l6VHD7xUXvC9h09I2L8RwcLhYClybkF7KLtrJCeELMDVYFREJcGwVKNVn1ds6gyPGrjoPMHia6fEMSSN62BlOP8AAPQk4Wn6/BfsmTsB3LVkfraLOedu1Fh8j6eoezE11vivqvBhkEWj15AGacIBmmjWGFL7evHEz9ZSxbsjZ1Uo3N7nwGjMRnBtjYOLaF3YaJHyDbldqa+F/775+BnueW6IaisEp2TyhB+jpVtBVgkHN4r4db14QIlxAceh6hobP4BpHowt5Xqt0Bqc3ld+ualpXOo1Ka5nIqtI8Y/5QfD55ZIAY6UTH97yQamjEvdizoxIilGcyb/5T/K4maxcll8AP+OaJEkFq9Qhy+ay6IVI52sX3TbgOXNXonxTJ2wCsgjwIPtzx++cOKKOIXBbgaVHYtfq1It4xgxCRhr7zdkTqBIzFSbTSBuxvzp6HFfyzfJyRB5K1q1d77IUP+/MXe0xK8VoKzkE/uxI1NpAmv2+B33Tho1uVhkBLyjoYuNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(478600001)(4744005)(5660300002)(8936002)(7416002)(921005)(54906003)(316002)(86362001)(6486002)(4326008)(8676002)(66476007)(66556008)(66946007)(2616005)(1076003)(186003)(6512007)(26005)(52116002)(2906002)(41300700001)(38100700002)(38350700002)(6506007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b+JLIckqS4JsTFMVhSwyd7RamNLHldg0Fnilq7+J7ggdheYHHxP6CyUPW3b3?=
 =?us-ascii?Q?DkRqKwrrlgvoZiLEqEpuXZpi58hVdHNDuliEEr9Oi5zeznv0GCSN+AAEFrad?=
 =?us-ascii?Q?ukmDhZAAgqro7G1AN/bjDaM2LYAXpPJwvuGWCBSSNztjBMbG800797bZIk+W?=
 =?us-ascii?Q?eyz0PlU3NdzwGcHasV6PPKMeQ2MpsyZuXXrGux6EBFSrUSXKu5ajJCMxtcTD?=
 =?us-ascii?Q?d/JeZTtqrpSsA5XDnhktWzgHl9tTa/Iu2tMIpVXYDItm0pj2GLwWYJtVisgq?=
 =?us-ascii?Q?0JKDpvtfJ0FNqKZvrq7tX9tLWxCMOAe4d2naCMTTHJWvwAOA3MLdq60oq5Ht?=
 =?us-ascii?Q?0lAM7Y6+dBiaxGT8JtQk/kGxb0CUWWnwqxrAcWYi6O4z7cbUJsOpA+7e6GMg?=
 =?us-ascii?Q?Jt04+LkpDJFMFyGnOv3y7uJr9YMRf7Kj30Ezzg68dZHXPoMOMg5LIryeCuE5?=
 =?us-ascii?Q?0xsMZ2hwTeOc1AzJyOfdD/bR2S1C7DUerqL3/OzJ1kjc7R6cMhqr5AfIawfV?=
 =?us-ascii?Q?xLuNV32TxEdgdmjILbJeDY7SPkqaJEEepUIJ+DvLn+NJy7d78rlHUpIC7yEw?=
 =?us-ascii?Q?nnhu4/MlmFBS/o1N6n1q0XIcWyp+3HpFKm0geVP4MGv6IpYVyplcHuBRT/Qw?=
 =?us-ascii?Q?hytHS2YQF1OVeMJNF0I1fjc4NJSTFI08rW2/mgMxlJEUaWgEoOA/NSz8DgzX?=
 =?us-ascii?Q?BottkfmyBVOLQ90tqwQ+s5mdGmlj+kFLmas2PfaBdelh2Gbg1uA/BDfdjDzn?=
 =?us-ascii?Q?pngYeBYEUTqDIMJAPqj5SUnmseUHv0HXI/8q/MyUznNBKJ+bYF1Elilna9ou?=
 =?us-ascii?Q?+m0eWa8lOfntFMDM2Y+NXjCoG/KCVAN/W2B1z8/F/EInIXtVzZqvBb5aJKTM?=
 =?us-ascii?Q?8Cq2pWD20jyqsNrcjlI09CYbq4M1/8HL+ORMxgmt2xpzjJ86ouPZoRfkDtT0?=
 =?us-ascii?Q?2vCyr1pEeN6Ip6JsJ7KpQF+bRxKivKktZYiK7wCzNVyiuhhJYhA/pMh5Ll8m?=
 =?us-ascii?Q?KOOcQOlv2OzAB0Poc5iVLFpRddIOhIUuvIbVRm4AhSC/khFoqCYnGBFbtuLf?=
 =?us-ascii?Q?F/fcX6pRgAeYbZFIA0+oMa/GvfxGb9IjD1yBGDpQZUsaTa799en2EpDCyx9s?=
 =?us-ascii?Q?NB0Yxo7/MsfvcXqfwyvYQ/zPYo2Zhh+UhkBAUkHjRc5DWNhsvHkdGfmGlAoc?=
 =?us-ascii?Q?lZZMbIogZbrujco8N0lTLR5X2DInlFiexWVwi99Y3EEZyZ6ttf/+wCoGTzqJ?=
 =?us-ascii?Q?4sVwJARIbY6hjuo7hedcRqIL18emofIptPJ48bwBqr6QHXpx3FReoAVScwS1?=
 =?us-ascii?Q?l/HvQu8JEN7E0jofTtYX3woFhwXWAgYs3m6j579PVxsWqPso7isUG+dZhIcU?=
 =?us-ascii?Q?dZISeWm06Z3ONtvRgtjMQaBphx6TCOp4u2fs+4wAWQpuNlpnjUuvI4S56zC9?=
 =?us-ascii?Q?SnF/u0ka4YM9pX6znoxCXtu+ZxFksRak//1MPEbfBEQiOwaSpIgKsWpRS2ec?=
 =?us-ascii?Q?TQdosaPrf/LLA32d4yGRTepVTafx3LBTQsUeoejtvn114lhYnbGFTNRRY86B?=
 =?us-ascii?Q?e+C9Xzgknjh48bF1atIJY61QfwJ3o3nuVdfNekHh?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f05e16a-4947-4959-ccf8-08da5cd442f2
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2022 09:13:15.5344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4B7MV6O9H8BRAZy2H4JLsFvfeivz/IxpMARjdUbFc+9/pf1UfYrwvaQXujP/DuzkGKBEWUC+Dqph1S+ApPsZ7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7768
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add interconnect property for i.MX8MP mediamix blk ctrl

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../soc/imx/fsl,imx8mp-media-blk-ctrl.yaml         | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-media-blk-ctrl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-media-blk-ctrl.yaml
index b246d8386ba4..dadb6108e321 100644
--- a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-media-blk-ctrl.yaml
+++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-media-blk-ctrl.yaml
@@ -64,6 +64,20 @@ properties:
       - const: isp
       - const: phy
 
+  interconnects:
+    maxItems: 8
+
+  interconnect-names:
+    items:
+      - const: lcdif-rd
+      - const: lcdif-wr
+      - const: isi0
+      - const: isi1
+      - const: isi2
+      - const: isp0
+      - const: isp1
+      - const: dwe
+
 required:
   - compatible
   - reg
-- 
2.25.1

