Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B905ADDFA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 05:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbiIFD1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 23:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbiIFD0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 23:26:55 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80072.outbound.protection.outlook.com [40.107.8.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147D05C9EA;
        Mon,  5 Sep 2022 20:26:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+kNXgFg5/kMfBFkdyvdxpqTzQjAG/qKpUJhaHaLel22C6KYFShDqz5wDg9Gq5pcFW7PCRAbmavGD9H22ls1nPwHak57rTnC2qhB6NRfBtZc/r6SgDoDpJnM47i9CI/3Jwx6L1DSGJrLobuLi2mEYqaWbo6lbAIZ44uKyFEmQoAzk91Ce7azoP6NF0AhAR+RHz2deFY5o9WkrZera1lUs+WhvLYcqzVjrvolE7k5+MWBRSJRUXO+6dBKs8bjHgZxz1ZyHomoiLF9E/ydhW0K8COnTEjxilm0MzGlpVl0gHoPncXEsTaSIP6P5TSyzk0gSSyyqsl2ztsco+EUfrfbTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0XgVov/aAL+68kSo7lADupymmzviYiPYf5BGaMcsJok=;
 b=MjrANgmIrOQhv8fIpEW46j4TU7rtgrMcf8gLjuSRQwqxqu/BVsPaIbqcBKYF5PLIEvzHie75DbQ/rDdVpL29pQCJGaKQ9eNl1t5ZWjOc5BIqXGiQ41YAcovIJwTsP8tofLXaZL1UFIBwX2fUgT+F/X8bREGsmWTPvUy+ieQ/iyqrRxwggysa4rn9eF0Kjryp1dwBCUM8SLeaDQ4Pp5TnC2TdwHqBQ7vfFkvPc0X/l9ET3N/Wov+vjcwVsZoA19qUrp5NYVSHjNGXFcKqVtekqbX6ooxeoK6g24PfHpsYLOSEQcRopWXNw3INYlhi40rdu7nA3tN4HOSd3gMVNrj9Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XgVov/aAL+68kSo7lADupymmzviYiPYf5BGaMcsJok=;
 b=Q14WgnHiDR6nc8GlbhLKDZB1AjUqBP1JV5k9P7nn2P3ZDNksn/w6gf63XQjrx2xCli+xTDy0GENtVSmTwvRKVLDywzeIjAvLDAVzu0PZVd8egEMVcZpN+GwtuUQznFOPt1yaeyoa6Xb4TNreyGN7lzTAXxcN27AS+90lUg1crtY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR0402MB3714.eurprd04.prod.outlook.com (2603:10a6:208:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Tue, 6 Sep
 2022 03:26:51 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.017; Tue, 6 Sep 2022
 03:26:51 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V9 2/6] dt-bindings: soc: add i.MX93 mediamix blk ctrl
Date:   Tue,  6 Sep 2022 11:28:13 +0800
Message-Id: <20220906032817.2090160-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220906032817.2090160-1-peng.fan@oss.nxp.com>
References: <20220906032817.2090160-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0115.apcprd02.prod.outlook.com
 (2603:1096:4:92::31) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65889d77-2131-4b07-09a6-08da8fb7a347
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3714:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jDpoAuE0aBSI3QAKhkMKyhdKE2UKmq57xEVMRK+9jiYw90E8noJsnmL5YMlmfh8+wTWqOQwfgQp32bjg3QA9TXjR8ZGfAL71X/eJ5bn9sstg7kXNzR0Khu8TnbsvTwhGmj+UeOk2vxgeAdlixv9lp0GyaLawfC64q27F+Y6TaA1hkPUWm7+ur9u04BYmQLfFP2MRC+sLJ6Iw5Sxd1UHb5KGdksBbZdb3nsMIYbi6FWrrVRzMP1vZORrfqhFTdMOHuc7HbzFk40BWnH1kQaPsyTa41L88oZ5VJDr+6MdQq6pwqTgqjvfDTtlW900AQHnfZn/kg+Y3NEQNb28rRiaMi1hQvjrbpZoQ9qGhHI0AbLYM7m/i2zgqlV+c3kWc8DvoHEZScOaqGABFF0NNsu7SuhzDL70glg03mhBmBnxIacr8LRb+TEAymrfINS7MRz9iK9ZXywumdmkIjngmIef31rokjTQ3L+egMCezk4pomUfvVC9tD8Cm2aW0Ez65RnaQ5K5FD11Oyv79JrAFuslznArfnOtdarVK0RMuW9Hp4S10w67LjO3nsXmUISnZlZnWTxd5u/zo+005BQoPeRwxzmlhLD8txNYvmwO1T3ca2TYFzOqB5++MnKOZtKHop/QDyz3xgn/BctV/rZ8vvguQOWdqRhZIBNnVZPVkKXCfnfd+7JJ1r6zP/jIyksN9khTJhER9Gx5r/kTZidERXYhA9Tu3AA73kcLpgxAwF1lIp+JB8118532OxL6WV2B1eJS11zG9/enTFwaSBr76d+Mg00+OVd9uUBNkmAjyXBpD5otSsut/RBdjmEuXdjyAa8kW982LW03D/q7IbFUWEX0+Yg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(8676002)(4326008)(66476007)(66946007)(66556008)(2616005)(1076003)(38350700002)(38100700002)(6486002)(186003)(41300700001)(966005)(6512007)(6506007)(6666004)(52116002)(54906003)(316002)(83380400001)(26005)(86362001)(8936002)(478600001)(5660300002)(2906002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GiQ186JsejEIT5GzJem8jC6TwNuOPW4kNsV4RzkXLJWeRYtAdXMvel9rsGjP?=
 =?us-ascii?Q?NZ1jj3gssxje1sUWDaM5/j+YJWtmB3jlyAE7kSZaOKUJShXWf6N5njieaXui?=
 =?us-ascii?Q?XkB3IXi+TO3d02hhkVgDL/XJjszgHv2dGxexjuRbuHoqFeA7Dm7LdrZS9G3r?=
 =?us-ascii?Q?DxcAAUoQYc6chfY6eLkwHcGAP+KGjfBykBz+ZIxN3atVzs6zvreOHss/4rjP?=
 =?us-ascii?Q?cbC+thXkJeWGwqlY6j+/hcA/o2zA+hLv0kbDAPDzy+9NYC64tpXkJ5v5CorF?=
 =?us-ascii?Q?BaCYIfKPNRvFV2KAQ5LehtHC6bQ4cqB8+YYueEuRc07EGq/UtY5W+bmwTN4U?=
 =?us-ascii?Q?Q4KKLNdFEpwPwrYOKk89lB8hU9qMUmXM30vvluIJn7gcGeTXSlDdVpuNvMGc?=
 =?us-ascii?Q?b7W3doiNBxXoRSEx3YD9I0vOPr6KhKbDh8tVsEwFb8OHWg4jiOBHwWVoNrfP?=
 =?us-ascii?Q?+8DkTfpVDVgCGlI/Cawfg9aIfS7DXEPm9SEBsrQPEZrdXteLATj3AFVWf3+8?=
 =?us-ascii?Q?u9wj8tnTC1jnQJBEaA8uNzAd4sqEBorw6jmE+w0qGzsqjDwRXngTeSmWff1K?=
 =?us-ascii?Q?27n3Hc8XmgegBdLwXHSdDGd6rHHDgmoJwtoCN/JdbT6zLEyY1kHgNUwtlXkp?=
 =?us-ascii?Q?67/SkYGFRDng3vEmhYOeZ9Aco3bNOYJE32Gn1mBmP0wEcZqCkI4EZGjzDC+n?=
 =?us-ascii?Q?znnUUo4YenoySL2A7/KKq6vU0gnfR63WPgDLfhfkn/f4rGDjbGfzc+14LXYT?=
 =?us-ascii?Q?HFjsyiJXP892xcXbpp9y/dtptvJBV0GAzd5JSywQu0t+cfqWNQ5QxJh6TR0i?=
 =?us-ascii?Q?FnKplLgbd5RsCoLckE0kIGNFttOTWRGe3eXKOhGHax0tMjY/w3Z+tFD6jcvH?=
 =?us-ascii?Q?zhhYROtnezjY43nqIotDezng3hw0YBw21i3tyeZtM2nvRmpi1WEQMRRS1c3g?=
 =?us-ascii?Q?z3JI+AVUamAOjEqkdshyz80SG5NKkVmNyiVv8FFS3j1gJOlNPhIoghhuOm2z?=
 =?us-ascii?Q?+QlF94ppd2GaVOKfNiIXM/LrLY1jRh254dwEDDprpDL3vemzp9N6xCXyOq4j?=
 =?us-ascii?Q?8ryincnMz87dMFbnwslTZP6808lRA5sSzq21UgRHamLr9dX7Z3g8SwWPAvHw?=
 =?us-ascii?Q?6iKpPkbeWvH1efXB9vc0flgE0AIUe+yGe89OKrGXLvMA7aGcawGFq7bP6yNe?=
 =?us-ascii?Q?F9zt0G5wnIClRPyzxf1qDu0jX9kgsc238vdF98sYqOZW1P6YNluGYyTvfvIs?=
 =?us-ascii?Q?fGPXbtirFkTGaPpIiROPoDuhesfGUeO8IU9IbjK8V3wtPK2GYbURuOYr/RXW?=
 =?us-ascii?Q?YIvjWyMDtk7Lj24ghxFdMztxowmKM+WDLJCOrV5+qmj0SeOpK208IQZQEfjA?=
 =?us-ascii?Q?c/tt6AmLkberp1iiZKhAMIpWvZ35PH/9PqNX1+xxuFC+InDmu6f3uaGqjSsj?=
 =?us-ascii?Q?IX65iBBkZg1RZt/5YW896MD9gue1bapfFESoLgt1lOcBUdKbt3waSnY4zR0M?=
 =?us-ascii?Q?m2dQgKFWP1TLAqDCfMsrN+CRzxxrc5oOrdKe4j2CmcoT81MHm5vtfpCq4i+X?=
 =?us-ascii?Q?ORsXL58f3tlN8EhC6xg+YPnsymd4jQEBrVdIV/xi?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65889d77-2131-4b07-09a6-08da8fb7a347
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 03:26:50.9193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aQ66gRxETXqGU3ymiaxFl7/MWeLaVZRYNP007h5wDQJH6ZVH6D2SasYiMDzQ+4xv6KFjl3ji+LtcPmRtInJgdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3714
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add DT bindings for i.MX93 MEDIAMIX BLK CTRL.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../soc/imx/fsl,imx93-media-blk-ctrl.yaml     | 80 +++++++++++++++++++
 include/dt-bindings/power/fsl,imx93-power.h   | 15 ++++
 2 files changed, 95 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml
 create mode 100644 include/dt-bindings/power/fsl,imx93-power.h

diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml
new file mode 100644
index 000000000000..792ebecec22d
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/imx/fsl,imx93-media-blk-ctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX93 Media blk-ctrl
+
+maintainers:
+  - Peng Fan <peng.fan@nxp.com>
+
+description:
+  The i.MX93 MEDIAMIX domain contains control and status registers known
+  as MEDIAMIX Block Control (MEDIAMIX BLK_CTRL). These registers include
+  clocking, reset, and miscellaneous top-level controls for peripherals
+  within the MEDIAMIX domain
+
+properties:
+  compatible:
+    items:
+      - const: fsl,imx93-media-blk-ctrl
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  '#power-domain-cells':
+    const: 1
+
+  power-domains:
+    maxItems: 1
+
+  clocks:
+    maxItems: 10
+
+  clock-names:
+    items:
+      - const: apb
+      - const: axi
+      - const: nic
+      - const: disp
+      - const: cam
+      - const: pxp
+      - const: lcdif
+      - const: isi
+      - const: csi
+      - const: dsi
+
+required:
+  - compatible
+  - reg
+  - power-domains
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx93-clock.h>
+    #include <dt-bindings/power/fsl,imx93-power.h>
+
+    media_blk_ctrl: system-controller@4ac10000 {
+      compatible = "fsl,imx93-media-blk-ctrl", "syscon";
+      reg = <0x4ac10000 0x10000>;
+      power-domains = <&mediamix>;
+      clocks = <&clk IMX93_CLK_MEDIA_APB>,
+               <&clk IMX93_CLK_MEDIA_AXI>,
+               <&clk IMX93_CLK_NIC_MEDIA_GATE>,
+               <&clk IMX93_CLK_MEDIA_DISP_PIX>,
+               <&clk IMX93_CLK_CAM_PIX>,
+               <&clk IMX93_CLK_PXP_GATE>,
+               <&clk IMX93_CLK_LCDIF_GATE>,
+               <&clk IMX93_CLK_ISI_GATE>,
+               <&clk IMX93_CLK_MIPI_CSI_GATE>,
+               <&clk IMX93_CLK_MIPI_DSI_GATE>;
+               clock-names = "apb", "axi", "nic", "disp", "cam",
+                             "pxp", "lcdif", "isi", "csi", "dsi";
+      #power-domain-cells = <1>;
+    };
diff --git a/include/dt-bindings/power/fsl,imx93-power.h b/include/dt-bindings/power/fsl,imx93-power.h
new file mode 100644
index 000000000000..17f9f015bf7d
--- /dev/null
+++ b/include/dt-bindings/power/fsl,imx93-power.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/*
+ *  Copyright 2022 NXP
+ */
+
+#ifndef __DT_BINDINGS_IMX93_POWER_H__
+#define __DT_BINDINGS_IMX93_POWER_H__
+
+#define IMX93_MEDIABLK_PD_MIPI_DSI		0
+#define IMX93_MEDIABLK_PD_MIPI_CSI		1
+#define IMX93_MEDIABLK_PD_PXP			2
+#define IMX93_MEDIABLK_PD_LCDIF			3
+#define IMX93_MEDIABLK_PD_ISI			4
+
+#endif
-- 
2.37.1

