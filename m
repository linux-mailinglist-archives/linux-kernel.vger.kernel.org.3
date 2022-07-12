Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE599571454
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbiGLIUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbiGLIUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:20:24 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20087.outbound.protection.outlook.com [40.107.2.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0420A23A6;
        Tue, 12 Jul 2022 01:20:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a40RK2K52FFA1pnnL0f9iquNOFfncIx6Ax4aMSpzLsUXZfmd1NXJObnyettBrHzCQ3WkxnflOe28A1Dg7wwDMxmVYLCrN0956byoz/AxqCq+liBkRBNq1LVIR3EWvGE7Ur+MkFwq24lz5AsXlL7HPeRvVZYPfQKywAFuf8/ywdhvY+Fr6olEYpDM0UkAibYjaYipGvdVDCcvyA0oJCTjU+NmOQfwpYhaO/b/L/2NiKNx1LxF6CYxGHPxjQFoOioqi8nXB6e2HLxew1810RkJDiKiQI+7CUMTubnSuCpekmjna7ey1A7EACSVURHaB4SQVk6C4eweR/HGGQX7M/9sfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lyLmTAF5G4bYguZJVEUJ5e2wqVfwcYwfM3vZVIJu/6w=;
 b=RIBalii7mQNVKsI2aR5UZpq/2DOwI1XfjCQHlJ2/15RSkA4GmrV8jURjE/CsxAwsk1h0vklm0SWHiLrEocEK/zLsSUhVITf/c4f0H+1kzr2M4OMq6L5svfuyvKYZNR6qJNGWtjqntuMg6DeAEujftXARPpEJ1nGgg7RVH0qK8na5YgCmyFz8bjkfHvKVOgsKnSCYEbDNiama5YG4d/eGlndAax0674AljByMu1rD0sgWFqZ0UuEyLZwpe1KfBoKT6o+ShDE972JEqYHzjvPmipFFFFb62tpd1XuZqeuZCaHy4+qYVsvamshqEWPnHDtS2m21Z0NNQbqJ2qAMBUdS1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyLmTAF5G4bYguZJVEUJ5e2wqVfwcYwfM3vZVIJu/6w=;
 b=JiwKT8vvcqsuoqZwI8oCS0fgOFzEZ2VxmNFMkzpEZ/pvLCnvTaSrLKZGzGDAbY1+i/5ImR2XXOcTlJm8D3gCi70M3KTxPM1ffYeMtiPRVahSmAFefUCq84BXmmWAnrv+KrYHryamHt6yMXtpfsh21zlWVqierQFoqMUaIM89gyA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB6890.eurprd04.prod.outlook.com (2603:10a6:10:117::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Tue, 12 Jul
 2022 08:20:19 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%7]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 08:20:19 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, l.stach@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, aford173@gmail.com,
        Markus.Niebel@ew.tq-group.com, alexander.stein@ew.tq-group.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/6] dt-bindings: soc: imx: add i.MX8MP vpu blk ctrl
Date:   Tue, 12 Jul 2022 16:21:42 +0800
Message-Id: <20220712082146.1192215-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220712082146.1192215-1-peng.fan@oss.nxp.com>
References: <20220712082146.1192215-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0217.apcprd06.prod.outlook.com
 (2603:1096:4:68::25) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9de3ac79-68c6-46dd-79ea-08da63df5bc7
X-MS-TrafficTypeDiagnostic: DB8PR04MB6890:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F45xKekDogKdaYGzx3sbgROgi7HiWDt4HuY9rCSFhMFQrD7oez8OuWVto5ZwSkfZvdDIdcBFqwHRIz18PE+AojeqMug2GVqBvMzp+amP8nnfqn1jlzrUc+SpkshC4aarSlaAZGI0JuhojdFf8Sn8nV2W86NkiccWdyMYV6Tx9HAZkV1c+szPYdIAhql5Chr0+seIzQYjVVTg9rqkr6BGIalPBEwf2jcfoVYEZmqY1HuzHY3JtUV/Z0W3+YDOYwr/IZhd8J8EmJ45TYr59lAaG4FOvtMX84vnfjsrYxxMwheDk+F4Vf8Egym889PI/0Y19oKFlTJSFx4HEo2FYJYC3SH9ToST+pcGjdNqk0cdjBFZvcaxs1oVh34fMsnYnhhOygll2cIIKervk4U6ElJ+QGhvvtJY2zJRKOdSZ8ZM8mu446QctYyWeEGMvXq1ZdU4bSJmXLmzhCBkSJFd3yWwalFluecXFcZLhlzr2klHXiZii0rRxJMroWpwqtjvEMp62Jqehs8HVRJf40nwhC9yppvnySwAjT9/n9HhlWcPDtGveWOUrSpg4/KLDuaIyeyqC33Idc+emdgLzCCc2blIcaK54dYG9zxHTz6uve2RCa+Q695lCo1BzVbQZK1gzEuVMnQ12jiowpe9/8OpMTjkWQ+ICGkCnvxOx/xq2+G/emzQsKLV6PUwJGR4kE74GEGdA/EcGa7fN/D6mbYXOy2KWmRvswfGvtKqrtDbiSNpPfMMjSgO8SaYRjD8/x2AtyreQUJKP+WpIxkqFHRxS7Il4c7R9U3IUtXwPhf8Fk9nbq7QxpQu/2mSHTtMLrrZOIlR3ZfNGeJ6DxBZfwtxpAAi3V08lqJRGP6BxwnsNuz7U85E1etNFOdnfFbZQNyQzDRC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(83380400001)(186003)(1076003)(2616005)(2906002)(38100700002)(38350700002)(7416002)(4326008)(66556008)(316002)(66946007)(6512007)(86362001)(5660300002)(26005)(6506007)(966005)(6486002)(478600001)(66476007)(8936002)(6666004)(8676002)(41300700001)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QPODeccagW3eZ/XveBibcVnC8JEfj4slhxxGA8kRNcOmjjkmaOsihKuZWv4m?=
 =?us-ascii?Q?0UsZY9KX9IZl1DGevuqlepZgb8zUXKZBwyun+mXohPIDc1usIjIFE84AthcQ?=
 =?us-ascii?Q?9A/23Xs0Vk0MtBr7njMiuhTUdF6UYrdJyRAyVW+h1obPexpoH+Wiy8iCQilj?=
 =?us-ascii?Q?HOrFwWkII1uu4ylQpIJ+0pCUHrvlGD1FOd94Hb6zThkoYYhBQwZ0AEn+/K8h?=
 =?us-ascii?Q?ZiyaLqhrkM0dquDQTgYUzd/9JLD7GEEVe+LkJku40EGLa1Agl8NTfCK4Z5oN?=
 =?us-ascii?Q?yEQwxH2TZdRKU6wOfniFFr5t+TmKexJaBtUuAAz4JRtA5yAnj51zPFYt8rDO?=
 =?us-ascii?Q?u0JE14/xvuY7hf6j+sGWVwCEkQNdQVLjQjkEMv1TF4cvOxfpi5UXbp/51UVD?=
 =?us-ascii?Q?sgkCAXsSonhZH6vHtM9kmqUQA9Zahil4AmH+KsWBjLIC7KWmRKqdL8tkQrvE?=
 =?us-ascii?Q?k5MRxGx6/8TYQOideZkT1lLazU4pGlT+yqCAM2BmTda7uu8xk8XHZ5pfyReM?=
 =?us-ascii?Q?LdQPop1VyJAp7V6TYvuZWXgVoUiAiQnL6dl8SVRMCoIOqwhx+UZZ3zkk2yBZ?=
 =?us-ascii?Q?qOxO41E0MRd2d9rJZG4VgTC4hyuQXaFvIe7639qln7E5fbBlja+3McIs+Nkz?=
 =?us-ascii?Q?gI9ZCBcieMKsY+sKpu42TqAgtBN9UVXVD6HI5vNLnfywR5vW9pVUXLkbYl5G?=
 =?us-ascii?Q?oDnx5p9QRDTRAQD8IBTJPfIOwdD27O1mpXRz4IfRxfM/Thvy9fM5QPo0/uvE?=
 =?us-ascii?Q?trQgApERQji29vHg3XBuoMIL2GDd4rPhQ6V/1xwqGqGQH+6w9poR8yiPqVcz?=
 =?us-ascii?Q?DHpoUn29bNx9U9cNpBRLNwKGRsinYESSGGJ1lFXQ4QsAL8H9uXomTL+CaQxs?=
 =?us-ascii?Q?JYeDR50SSr07Qn2joZXmqI7V8INx8A4WtG0r3lNRo7SRMCvcAPHQaeiEZ9lo?=
 =?us-ascii?Q?bVeJcsy5znE7t1PJBpG0VVZ56FfrGGJbI6mLSOTiaf1276h24inUYXTOdxNR?=
 =?us-ascii?Q?XCybwCRTI1gUsb4rosrx0zCXiTInxI3mG2lAgmWB7ZgWZ0kcWVT2a0ekffBD?=
 =?us-ascii?Q?o4qJlPFe3qwl9SJakleP3FHFRTEK8R+sAYI/W9odCl92mau+uApxtPnbSPWV?=
 =?us-ascii?Q?+c7zpKrMIt+PKril/eCbZ+0suOKLJ+/1xFLPOs0l5df12ZJQygaV0ZbD/wsH?=
 =?us-ascii?Q?D/MlmRkj8FedHtDrBdBfwuu2SVCaGbXg5B6npzmDPL9iajTBx/P4XxrIp5Fd?=
 =?us-ascii?Q?McuWykjOzahEmQV9ILnRN/nReT+esEjMggn2RAXxfcdOqKp0XODWhNzn29Wq?=
 =?us-ascii?Q?tCgxE8Bjc5ZQ7fq/MBrCzke7SiBoe7LNZGTYdbn+6mpSBIlwqP+H2y/dBQhF?=
 =?us-ascii?Q?WTS8gbiST8Rf6l8l7vVzHqyHDZ4rXC+gxFPUi69ms4/dSvWki5GaLciJuHqr?=
 =?us-ascii?Q?ICeGzW76xLhGlLL0mKdb+nseDclEd+NPdEGFP9xM8G8n5KpYbmsWT8GGVF8b?=
 =?us-ascii?Q?GsxAwRCmwiHHk8epLvk4CAfxeAhtBp/j5Ix6TDzM/591sjjqsWNtP9V73mJ5?=
 =?us-ascii?Q?XuK+VLkaf39EWt6ngKkRUYV4tfxAhpe6v8yloZX4?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9de3ac79-68c6-46dd-79ea-08da63df5bc7
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 08:20:19.6565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fUXMz1GrejT77plfuh2oxjST8/GPDeupjys/xYomqu+G3zjav2dvXpCdQvi1m0adJodYFZrKTefBbrjjNI2ANg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6890
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8MP VPU blk ctrl module has similar design as i.MX8MM, so reuse
the i.MX8MM VPU blk ctrl yaml file.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml        | 17 ++++++++++++++---
 include/dt-bindings/power/imx8mp-power.h        |  4 ++++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml
index 26487daa64d9..edbd267cdd67 100644
--- a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml
+++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml
@@ -4,20 +4,22 @@
 $id: http://devicetree.org/schemas/soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: NXP i.MX8MM VPU blk-ctrl
+title: NXP i.MX8MM/P VPU blk-ctrl
 
 maintainers:
   - Lucas Stach <l.stach@pengutronix.de>
 
 description:
-  The i.MX8MM VPU blk-ctrl is a top-level peripheral providing access to
+  The i.MX8MM/P VPU blk-ctrl is a top-level peripheral providing access to
   the NoC and ensuring proper power sequencing of the VPU peripherals
   located in the VPU domain of the SoC.
 
 properties:
   compatible:
     items:
-      - const: fsl,imx8mm-vpu-blk-ctrl
+      - enum:
+          - fsl,imx8mm-vpu-blk-ctrl
+          - fsl,imx8mp-vpu-blk-ctrl
       - const: syscon
 
   reg:
@@ -47,6 +49,15 @@ properties:
       - const: g2
       - const: h1
 
+  interconnects:
+    maxItems: 3
+
+  interconnect-names:
+    items:
+      - const: g1
+      - const: g2
+      - const: h1
+
 required:
   - compatible
   - reg
diff --git a/include/dt-bindings/power/imx8mp-power.h b/include/dt-bindings/power/imx8mp-power.h
index 14b9c5ac9c82..11d43fc7a18e 100644
--- a/include/dt-bindings/power/imx8mp-power.h
+++ b/include/dt-bindings/power/imx8mp-power.h
@@ -52,4 +52,8 @@
 #define IMX8MP_HDMIBLK_PD_HDCP				7
 #define IMX8MP_HDMIBLK_PD_HRV				8
 
+#define IMX8MP_VPUBLK_PD_G1				0
+#define IMX8MP_VPUBLK_PD_G2				1
+#define IMX8MP_VPUBLK_PD_H1				2
+
 #endif
-- 
2.25.1

