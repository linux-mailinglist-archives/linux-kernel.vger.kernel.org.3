Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9337959B9BF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 08:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbiHVGog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 02:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbiHVGo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 02:44:27 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2079.outbound.protection.outlook.com [40.107.105.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C943827FC0;
        Sun, 21 Aug 2022 23:44:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ndOR7AXMoUGDBTdtqe6YnLdHniIZnMJ5UOjv0eikoklq5xf3UXZkWCnQlSoX7zUu4A7LWWP7g8pS2BTfQfnimdwqeg6zrCv8vumVeKQOFZSijLy/BX21SPY32RllXjqte1Uh4kMrzr7uXWecZo9oNZhMUTyqjjDe/j5DM44tjkSsleFT2RTUm3AjP6mRL1K+CvcQzLWSNkfbcrahWsPiXI+7WXidyEZ8T9WeJjUmos61F7INCNyYxkA9mMejti6jifPE2/CsoDFGaURAWClTYS+jrIkke3k7semAmyUV15d4fUaKUc11kzBgEvIekdcPuAE68rP6je23yEWdVH2Bfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=co20H49QQixNME/Y5zlKshQN3aGAMndeRy81d5+jlrE=;
 b=j+8Kpiep9+M/VLIf4cEs5zQE2awL8OXpCjtHzQT1EcgVMAPCcn2w02z4Z40j+NffHGMJFH4DoQDhaxph9Mh49FOa5V8qrq7UinzUCFW31bWxAOsm+aOnTAV4kGjidesGmYgPmFbQP8hOnuCxAy1+YUP6CYAb42X3uPY5pOfUYyAg7NKx3H/U/mbR3GwB4MUqav34svh/CTm1HahUkRXuD/HR2gFKbVybsQba1S4Tnm0v14jc16bxgrf/ah3VYTYJT/mGmoCz2ts1Uq2oA583eppMsHfZ77i2QnjL3m4UJJ370JnjkN57xjDO2AanUjxk93rcHzYaZb/E0fppvHVP8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=co20H49QQixNME/Y5zlKshQN3aGAMndeRy81d5+jlrE=;
 b=R/wR+4frHhHUOEF4bOjEDFX+qgXnzMO/oZKCssEOm6iwQpO3LQKAs6YUyKVuFo2X6ez8nFp5w2i4jF3P+31pdkBtGcE3pr2yprfaF86Uh/VHvzsFWAblpYbDSCeqvrYcOp8WhulHRFf6N888Bg+iQIjiPV6rdoFFNjswp1qV59s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8476.eurprd04.prod.outlook.com (2603:10a6:102:1df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Mon, 22 Aug
 2022 06:44:22 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%6]) with mapi id 15.20.5546.021; Mon, 22 Aug 2022
 06:44:22 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        l.stach@pengutronix.de, laurent.pinchart@ideasonboard.com,
        marex@denx.de, m.felsch@pengutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V5 4/8] dt-bindings: soc: imx: add i.MX8MP vpu blk ctrl
Date:   Mon, 22 Aug 2022 14:45:32 +0800
Message-Id: <20220822064536.3947512-5-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 55eb12cd-89fd-4dc1-1d82-08da8409bf56
X-MS-TrafficTypeDiagnostic: PAXPR04MB8476:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tRvKrD0r0JMcuWnx6Tbio9IdX7kgOwrfW4jdrQmS7452ahD3C9CgSRU4KtokWDW+IQTJgQwcOXB8FqkS01dxZIBrm29MwH1voeakUj0lSRGL0wo5gpdG1YV8dZZ6qAyiF9CNTfVusTE35jSfthhzAB+bvxif6yA9PsmWT0esLnAC6JP2E3egPhYmSzsmHNxO7opfXCoxSKC9nGzq3LK++8UuJkkG372x13fBryotHtKWWfBQ2CpDxtS/oIoaIx4ooYt92TQ7ViUmNStxKT/Hikzrq1K7L3JgOF1XtBbkG1ylgt82Tcq0R+1jpZAFSMaLB3jMnPRziocL2DAmujdDpw1RzAuuePXB1XKQKEEFUeyTBqqG9uyCAVS69HiGMRexs/sDtYns7pzvdB+uWzMyDO2/8OO9snKUWQ6ap8LPnmsSNfw8GFGsnK2jam4X9deRPZljxW14znKLSJTsJR2UWc6ULx6hj54r8g6uKiSapfTdNhGZ4dMH6RI3zbYZbwVuOjWnrlXBazPqlIQe59bjXnP8bZZlLCOecpVZUnveIoAKAUzhRZsVjh0+QpIbwjdeIY3Zx/UEA5QJFOYpcsK68K0NqRQccMl1r/+15+9P9YUotpjAiwiP4I9XnQ/ubwZnsxGsdyiDrzsF3EOvbgHK5bup7ksfE524o/WJr/S8AL73hJL1aCe5TBks/5v9bL81FxB3B57kvo69Asezt2gV2S8prqoFRfFoNaLT+SVrkWwWT34WuZyzE9mp0N+5cejAds8MrhzP+EC69FIZwefSEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(66946007)(66556008)(66476007)(8676002)(4326008)(86362001)(54906003)(38350700002)(38100700002)(8936002)(186003)(1076003)(6512007)(26005)(52116002)(6666004)(41300700001)(6506007)(6486002)(478600001)(7416002)(316002)(2906002)(83380400001)(2616005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OtUZ9MOJouGF6nWjGpmABK5qCOEWltPswqjnW+Hun6Z5A4ylMsJ344CBa7j9?=
 =?us-ascii?Q?9RrYFmFpwCSBY2qSURYVTMoaHT4XvN02gE7QXOsVY0xOYJQ4jVXP0M8mOLTH?=
 =?us-ascii?Q?VJ0h2fk5m9YYOTdM0+LzGsWYvTh/hlvDKvYkguD0ptB8c6x20HBw7fqiXEip?=
 =?us-ascii?Q?hvYoyVnsaIdLhBJLfoCgyZzmNGpS1NbJyDZzc29iZsf8Q3cs3flfGQOIrU1F?=
 =?us-ascii?Q?E5PMU+gofvfD0mHywZb7NXuW1h7wCYHnsMVFn/fPzjhs2+hjYIltyNkwed/E?=
 =?us-ascii?Q?oh/rbeH9CyUsGHWrlhSId8JOEQcDwKbgQz2WTZ+TtHV2DSK/SOyGFbLjNa+D?=
 =?us-ascii?Q?ccejYMrIVBtquKv7sXHbEaVNn4NtcI4HIAv30wrXLBTYEBPKZZWmgXIZWZDh?=
 =?us-ascii?Q?5plqy0xGk2+0gEqwYuzaXvW4FQTu8ZMNCOIDLHzKj6QTbWyPoq9cQeApXnOT?=
 =?us-ascii?Q?6lLV4pwZhkU0jueRXaIoiBQnTCVhvDSHG02M94ELRMUnWH/j/S+gI0PqRVuS?=
 =?us-ascii?Q?3JomhToZHy83RhINXEao206XXSw7Hw1R9AXbIR/5g1CbhL6xiIByd3pK514T?=
 =?us-ascii?Q?530DKi7uP1T9VblAcRk3r1moI2542v4todRXPk/DdWWj1CORMMW22yRPj2NV?=
 =?us-ascii?Q?JS0/G//mGNEhXd/L/BjkTF6U+YRRnepXgmOLhQ1kHT11wDwOhQV6kXtRobw0?=
 =?us-ascii?Q?wS/QiM4h+LwsQmj/DZfEG1BTEieKSfv15ePaKBQu9gCuS9KBJIbFTPGZD3p1?=
 =?us-ascii?Q?rKgy08VJQnwqRNN1vcJqnNCqbVtXZ7q4US6OoB6Nxi3sXd0GXfFCvGXrSnsk?=
 =?us-ascii?Q?rIqEcff2M9XVE8i5p/1LmzDNH/tJ38gCU8EfWuILbvwcE30q4OdMPt+EIKJ0?=
 =?us-ascii?Q?IDv9keyPqlsm9JGUfMXQV/FeGYHr1V8XTUMhtp8xjY9FczsrABRmj4pk/I66?=
 =?us-ascii?Q?+IYtDU85xM0yOmdwQjz7qRcEEHFmtrkeuifyXvVZaRGGBY2HP83xZN/N+afn?=
 =?us-ascii?Q?B8MGpbC6yTXBKrn0xo4O/1jRBk/RqHCTxbd+0UV5qb4oeLcjSADa66ok2/fj?=
 =?us-ascii?Q?csyNdXcKhH0Qm3mcqQCXvz07gj4zXgmEw29OebPhMIdGhS0PRh8HLv5rsCLZ?=
 =?us-ascii?Q?u9T4XOWD0dM8NtDvLZrjACQn+4ay7Kd8aHSRyu825i4mFbJ2tcMndVp46z6Y?=
 =?us-ascii?Q?vH0aMTSXZT0EXUjkKCIdEBDPBWmb05PeQtFdd6fKqDbqlscpUVlIyoYoDT2m?=
 =?us-ascii?Q?/Vukp4KvX3kEgVnPa5OIxASRHlJr4icPOyggz9o2p7b/NQ7MfE7gXAUXUSFi?=
 =?us-ascii?Q?8fiCPD8BgSqgtMqpLs27FGRc8uMwWkF5cZkngTRZ4Ana546sweMrk7i5BG/D?=
 =?us-ascii?Q?Nufy/833cObmsAnJA+neACRGPlcJTuMklqcJlYuSvt2v2rktPv9rthFgrH6j?=
 =?us-ascii?Q?wnWDEOBqqfWaEn16O2+vNaHFBZ3TzOrORiXFavpmIqx4meN/9a+JIMYkrKh1?=
 =?us-ascii?Q?IofYw6jYwf9dfd4QFDFVng779YNU7OpKLmI8mVrVsvYeDfHSCrLHePK5entx?=
 =?us-ascii?Q?M3WNuUZ/GVx4aseayRFSi1MBofo3/bvm4JOI1ODd?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55eb12cd-89fd-4dc1-1d82-08da8409bf56
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 06:44:22.8522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wo9RonZYXnP6q0vVKiRStVG4Z75TouplRtmOXvRVe1yRIK2tCV0k9D6jhnnjfGyhPOCM2p40T3CGkHj+mucDlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8476
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8MP VPU blk ctrl module has similar design as i.MX8MM, so reuse
the i.MX8MM VPU blk ctrl yaml file. And add description for the items.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml      | 112 +++++++++++++++---
 include/dt-bindings/power/imx8mp-power.h      |   4 +
 2 files changed, 99 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml
index d79e5d2634d6..d71bb20d4907 100644
--- a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml
+++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml
@@ -30,32 +30,19 @@ properties:
     maxItems: 4
 
   power-domain-names:
-    items:
-      - const: bus
-      - const: g1
-      - const: g2
-      - const: h1
+    maxItems: 4
 
   clocks:
     maxItems: 3
 
   clock-names:
-    items:
-      - const: g1
-      - const: g2
-      - const: h1
+    maxItems: 3
 
   interconnects:
-    items:
-      - description: G1 decoder interconnect
-      - description: G2 decoder interconnect
-      - description: H1 encoder power domain
+    maxItems: 3
 
   interconnect-names:
-    items:
-      - const: g1
-      - const: g2
-      - const: h1
+    maxItems: 3
 
 required:
   - compatible
@@ -65,6 +52,97 @@ required:
   - clocks
   - clock-names
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,imx8mm-vpu-blk-ctrl
+    then:
+      properties:
+        power-domains:
+          items:
+            - description: bus power domain
+            - description: G1 decoder power domain
+            - description: G2 decoder power domain
+            - description: H1 encoder power domain
+
+        power-domain-names:
+          items:
+            - const: bus
+            - const: g1
+            - const: g2
+            - const: h1
+
+        clocks:
+          items:
+            - description: G1 decoder clk
+            - description: G2 decoder clk
+            - description: H1 encoder clk
+
+        clock-names:
+          items:
+            - const: g1
+            - const: g2
+            - const: h1
+
+        interconnects:
+          items:
+            - description: G1 decoder interconnect
+            - description: G2 decoder interconnect
+            - description: H1 encoder power domain
+
+        interconnect-names:
+          items:
+            - const: g1
+            - const: g2
+            - const: h1
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,imx8mp-vpu-blk-ctrl
+    then:
+      properties:
+        power-domains:
+          items:
+            - description: bus power domain
+            - description: G1 decoder power domain
+            - description: G2 decoder power domain
+            - description: VC8000E encoder power domain
+
+        power-domain-names:
+          items:
+            - const: bus
+            - const: g1
+            - const: g2
+            - const: vc8000e
+
+        clocks:
+          items:
+            - description: G1 decoder clk
+            - description: G2 decoder clk
+            - description: VC8000E encoder clk
+
+        clock-names:
+          items:
+            - const: g1
+            - const: g2
+            - const: vc8000e
+
+        interconnects:
+          items:
+            - description: G1 decoder interconnect
+            - description: G2 decoder interconnect
+            - description: VC8000E encoder interconnect
+
+        interconnect-names:
+          items:
+            - const: g1
+            - const: g2
+            - const: vc8000e
+
 additionalProperties: false
 
 examples:
diff --git a/include/dt-bindings/power/imx8mp-power.h b/include/dt-bindings/power/imx8mp-power.h
index 14b9c5ac9c82..2fe3c2abad13 100644
--- a/include/dt-bindings/power/imx8mp-power.h
+++ b/include/dt-bindings/power/imx8mp-power.h
@@ -52,4 +52,8 @@
 #define IMX8MP_HDMIBLK_PD_HDCP				7
 #define IMX8MP_HDMIBLK_PD_HRV				8
 
+#define IMX8MP_VPUBLK_PD_G1				0
+#define IMX8MP_VPUBLK_PD_G2				1
+#define IMX8MP_VPUBLK_PD_VC8000E			2
+
 #endif
-- 
2.37.1

