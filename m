Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEC2564645
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 11:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbiGCJNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 05:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbiGCJNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 05:13:34 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2055.outbound.protection.outlook.com [40.107.22.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D021118;
        Sun,  3 Jul 2022 02:13:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sc5H+QDRNPiaUg5fxEOkzX2WMZJHqLiG0tS2+r1PdV3kQeQVhOtg3LC3w8pe2pYO5Us/HszM1KeqdBwBaZoyNY6Mp9fZc3d6wDlOFpCp5V6zGqQlTbN/HvfiT8CTS+duL/x7LWtNX5GwPOH0kSQsGa/jBvUcP6e/ZckFG58QDI5kLRU1JcMF3nFsjBM+Cs/HvEEq1WCmzG/HMFGFlO4EECGVRt4FqDE70wkxLwFcHFGWofna3TMJgMTMZtTvJyQVGXUmpRJLlqdyRzMk1Da5tZrbnwbLr0dRid/yfFTGJmN6D5y5ncSG1eqIwiv1W41ez+Hw0Pd/hxO5Z6KyMDZ+gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qLhlNisqvlpwQtd5Dm08Rk/xcIL5USTSTUhDsl8b+U0=;
 b=ebRlRD1I1U5DUXocBP5867a9D6Uc+41L86y1f43gmENBj+xcojYaTGMO8mVPorcHHsq3eJ5m/BttQxx/E6E1bsVp6xgk/tTJCEhAEZI+Oe7zfJq44jIVzZ/ZMeQGsoF9J6calwbFDIxeEqEqybwnq5fUT/zanN4kPzPujXmJdWPUGjnfqFmGySv9URtKmeixxEhzx5yqznZLOxos6Mt4uAGS/+4s2pkFcNNRYuxXZ2/1aSzPy6+OQkO012qwP2PraKDDVYRPN7NePfxlsyOvzJmbQH09v/z/+iIj1qlf1Ttrw/cvlnmHES22hPHIpMW6KfTrG3K3oAa4xTiFHFUvNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLhlNisqvlpwQtd5Dm08Rk/xcIL5USTSTUhDsl8b+U0=;
 b=kQJ3YLQeM3JlDJI+vHvrIIkL4CCr6YdvWtRKy21MllpJBsfW5fkxoYUVU5p0Q7mYnaJLl3Y+xIUcig8Ou1Y81ypfSzZA/f5TTxF5UIpNw+wJFZiYt3TShYw2t44NWTWqNIvWIguduMIaxXrqZjMnc4IyEl3MdrxHDmDMVgL0g4A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7768.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.19; Sun, 3 Jul
 2022 09:13:21 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%5]) with mapi id 15.20.5395.018; Sun, 3 Jul 2022
 09:13:21 +0000
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
Subject: [PATCH V3 2/7] dt-bindings: soc: imx: add interconnect property for i.MX8MP hdmi blk ctrl
Date:   Sun,  3 Jul 2022 17:14:46 +0800
Message-Id: <20220703091451.1416264-3-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 87315697-6079-4dda-f057-08da5cd44698
X-MS-TrafficTypeDiagnostic: AS8PR04MB7768:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7JY5VT/A30UH3A0ilrgKSb4zTv+sAAbwRPcxQwcf51CSVCVR3gwehwFXHYaPL2du4RrYhEMLDJS9636w9Ao+4Gx/ksnUleNN4GRpwzoNyXJN/1B6HS+U3VzG9xcvamNIAlU1BNM7UN2DaD2kYYV+A/kRit5KLcXgrSzLaJyOTrOtsbIn4M89wcegNoiglCgHHkgX8359OZV4kDzW3DdqvqVBvDW2cIKKs83fvDpHzLk0SNI1k1KmMzA5G/JiLakt/QC6jbOqzsgnLeuAOfew/dCaG3TIoGa73IZeEKPC/LNckoqprU4DjuLx/pix1Heju6mpUTylA4ifvnfV7sIbbdoPEvBWdTiy1zq1/+lpJ+AfrxIoPWiPRUnhW7yaMfkFQS1yQ+gAiZ3bZGDfYAUI+xI1WBFnmQ+y/WP0XBzO/Bjri2HA7QWi8VFDM31lK7mFEIk/SMJogdquikcM6x1Cb3QoJ2J/LQQEE/iBiTaTfiOZ2PdBFogkoMc2Vc3sxoM1CY4edhgVuWewUgWpfWsa+v7fKKNkjwyr/76XxRhLRWR+RFigjqjhZdGae/sKSUBwB80i3E+4piPOrJx/3Tww0jmnPo+GHnHNEQVOz3PdoQoAa7NDQcq/+Oz668Atl2LEfxEu2EneVNQ7GLiqirNyhz74Gr1HLXNAMzFeWHrnFeTlLmF6ljm9oTEaTJvGLoo2d1VUqRshdNcp6m4KXrSVtCOuLbFkaGCqcgKNWSff2MczKMw2+FhEQIjC3CRO4L0rTTMQqfvbkil+rQrwWmGuzwrvAepMEce0l6bpS7U0GS1/+KvkVu7Ckn1DilFykUM/RT8Qr4iJq73hadjmj6p79g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(478600001)(4744005)(5660300002)(8936002)(7416002)(921005)(54906003)(316002)(86362001)(6486002)(4326008)(8676002)(66476007)(66556008)(66946007)(2616005)(1076003)(186003)(6512007)(26005)(52116002)(2906002)(41300700001)(38100700002)(38350700002)(6506007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9eHdd8ZyHFemXBxjQmFmpEPllGQreAmdfAuu949F883QUE9J/NWsHhU3lhbB?=
 =?us-ascii?Q?V0t9wemZAdww+5rU80ICTq0tLUl16fMGy+26Uf8odnQwdS8t/wVrRoMETzhm?=
 =?us-ascii?Q?6wvcxFw812hApLj1TU42wuQXYqkr4T1OjrXLU33GTNYy2gRjgJ7StOSsO1O8?=
 =?us-ascii?Q?5Qy2J+x9w4ebYgWn5PGbqdM84h08kbYHJFXGcsvu6z/VpiYobegjhsrGrDhC?=
 =?us-ascii?Q?da/cALgGCLgFWGKUDK8Bx2qweNMkjITETGvzZjpcllFock2Ru7uShHuHsaMb?=
 =?us-ascii?Q?pWINEKlM3heuRAaKyW1lJB579wlLW/c3qR1fOryn3HOcegBkTZnJ9PM/TdGX?=
 =?us-ascii?Q?v6Lc5G3SpsxqDNMps7PPFD+6IAiPblejswe5gLL9bgzQlNYuZvghUJWq7Dzo?=
 =?us-ascii?Q?y5Dep9PIXzY3Str7OVlJ416ICeN0iCCcSmFkdwhVnLCYIx8Y6gQmG1v/dvfe?=
 =?us-ascii?Q?wVoP4V7ZGLCAml4fK0TuPtSS9cLW3dMGg/r5pKT3fP9UhmULhWWLhAo7lgBe?=
 =?us-ascii?Q?J+e0eGYVBzWPJFKVcaz+JfWt1RaYxS5/4fbjWsRaGjpxj2sxJ2r23HZRMVt5?=
 =?us-ascii?Q?ktKoJcEWjBIpOEHFMdZwWZyJSD+AqrM6UWIegPjC0oIeu+9oB4ycQhuhkzkA?=
 =?us-ascii?Q?TCBf73hJCh7FjokZLKAU8xjt/IEJGEYW/v+i343iF5kahpN2DdBCaZah789n?=
 =?us-ascii?Q?Uni1KoHydy0yp8ro5t9sqOvdntrOPPIN7ujLCU749wrccx/pDsza6KVRn63v?=
 =?us-ascii?Q?tsXAiWCNBK2coF3SgGZ9pKFZK0I5LevWqK1uCdV0tXyVO/QuncXwblLTwUFv?=
 =?us-ascii?Q?gM3ZLIy9ho1EvGSU6YDZ4CY1Lyu5oyyt2wA32x4YleVjIWJ2PJB0ItIbyaDb?=
 =?us-ascii?Q?xJwxe+T1dL+TVFRb7aUE7aSG0J0fc086oK8AJUZNnFta4nw5ExXMnweLqmRu?=
 =?us-ascii?Q?9DyoQa5IirFpaVffz8Xx1CU7DuDrzbWpR+FpBTvASKgbLXZTKa5s9wtQCxAp?=
 =?us-ascii?Q?7mfFIGHitZYW86/vC//af6ubNRdArN5MSLKm3ZrQw4M7H5wEDJU7V5/ze7fn?=
 =?us-ascii?Q?eJSSqdUZhXdDXZqAyAH2XCd117hOs6nB5CfCBZlDZi/cJHaYJ9J/7+WAZMiQ?=
 =?us-ascii?Q?KHpuJ8StK9eYzLCYVld2mzV8lwCZJsDFyjzIj2jw+nEZv/QZ4X6WCR2RSDVz?=
 =?us-ascii?Q?hcMhZc3S60CFmnHyXJk44bRTp3WI34BwBNiAyJMScCn/qhAmmrNbyRKKrCy5?=
 =?us-ascii?Q?tPqKIq6jmXBKVwZB7u4JTOBl3jcme6ZD6DZt1aaVgSX+prHhqG1SRpRUC2Ee?=
 =?us-ascii?Q?CRGnjjwAsC4nFgLLPp+gVJ715BpcnV8U8idXxdhpurBhp9I2WdjrT2UHuvyr?=
 =?us-ascii?Q?F9SkFIbFhwjzHMUV3l9MAAtAp0HePNwXkF2GTxIlQh90b7GX3uZllk/Q7u0n?=
 =?us-ascii?Q?qGj3lLeH+wxz1Z2xdLrfzsq3sZT1kKaabGpgv75jBs/1E9A1l6CFIw/iaJSH?=
 =?us-ascii?Q?YWvfVToXmNHaeCSGPX8ORg5EMZRAbh8ukW3M3022TBsVWH7pKFlFAXtmByJ5?=
 =?us-ascii?Q?El+IYQDKtIJck9EE/L+Jbx4hB6YLwgQ72pnyqeYc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87315697-6079-4dda-f057-08da5cd44698
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2022 09:13:21.6877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p3dtHOggUzMgIQPM8Djz+18sahLtJrWwAdQeYVxeFOoe9JHgwFeI0jncc48ezvJ/VsZ008cW6CvdIrpsHv9wYg==
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

Add interconnect property for i.MX8MP hdmi blk ctrl

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/soc/imx/fsl,imx8mp-hdmi-blk-ctrl.yaml       | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-hdmi-blk-ctrl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-hdmi-blk-ctrl.yaml
index 563e1d0e327f..1be4ce2a45e8 100644
--- a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-hdmi-blk-ctrl.yaml
+++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mp-hdmi-blk-ctrl.yaml
@@ -52,6 +52,15 @@ properties:
       - const: ref_266m
       - const: ref_24m
 
+  interconnects:
+    maxItems: 3
+
+  interconnect-names:
+    items:
+      - const: hrv
+      - const: lcdif-hdmi
+      - const: hdcp
+
 required:
   - compatible
   - reg
-- 
2.25.1

