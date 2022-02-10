Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4E94B08B3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 09:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237835AbiBJIoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 03:44:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237832AbiBJIoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 03:44:12 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80044.outbound.protection.outlook.com [40.107.8.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240DD10FF;
        Thu, 10 Feb 2022 00:44:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VjBJadU8vxDvRZvQj3S7Id43MLxxuP7+bBlLrw+0vdlcP2SmNtkInsCem2RGb+ezqUHlgKmLTyeqexbAlO1oAGOIfgB5mvCVhvzZsjJ6p8Kbk4B0y6+gCJTNc3FBFEUspgZyZ/E7CnUmNC7Amthq301QN9cELbFYtY0W7A88ARniYGqhvRS6OMoOhlQpdJM3xqa2vSdPEvthSqmrOV15bUNfv/YniSpcxJNFvil9PC3/auCS4p2pPp6R/QUyVeCcY+g6zLwIVR/tLJMhCnmUCyGHik5oMVNrNYY6U89f3FmoyrCLH607y+RKqfXfT81zfhwKuvrPlYzMV8dTn4/Gag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oTG7JQbmXi2XxCjghorcTTexJ/5wtcKV5q/u1IgE7n8=;
 b=gzwUtAUbT2kyGymbHrYhV7jQS1urcR13ffhjsgphod3XCo9NGRh90YSpJIn9sz0XrMZitmuxWMqALiwaU/DDJCgBno+xfiFJ5EL/3tONNhSwQHElmbT2omiE1/jR/U+WY7sqIb/rl+jz9TT6qw3CP2nGSqZJnxiD+TZX2/IXutRNxBio+oR1+q5o72FWa7rmVsURGRn2/06LwZRdkIi3dDW0/SPwbZL7I2IzFyKkzJPw9SNQ6/aaoXdz0Kmo5zWifIchl1tAkp5wpKCll0506uRkffan27PVZpePbLpSCBCFxGpunAH4QbvFMg0DDP7AxFj0tVMO83hk83Dt0p1FHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTG7JQbmXi2XxCjghorcTTexJ/5wtcKV5q/u1IgE7n8=;
 b=AgWSV0Vjf4e0GK6VOYcWrxi63IJUZ21e17GxJpLEnIlNG6HTY4djYKcUFpHRXcYigEK0t/2vWXAi7vBHGshIn5d7CWiecfGPPusraU+BC6XnKK7VRnNlkeXBRWmSKdCf4jgTlpoVGq001Z9+HOJ7BIvP/D2rbSgEbSECpBFwUdo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB5771.eurprd04.prod.outlook.com (2603:10a6:10:af::27)
 by AM0PR04MB6211.eurprd04.prod.outlook.com (2603:10a6:208:141::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Thu, 10 Feb
 2022 08:44:09 +0000
Received: from DB8PR04MB5771.eurprd04.prod.outlook.com
 ([fe80::1cb4:559d:eae5:f409]) by DB8PR04MB5771.eurprd04.prod.outlook.com
 ([fe80::1cb4:559d:eae5:f409%3]) with mapi id 15.20.4951.018; Thu, 10 Feb 2022
 08:44:09 +0000
From:   Kane Jiang <jian.jiang@nxp.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Kane Jiang <jian.jiang@nxp.com>
Subject: [PATCH 3/3] Add i.MX8MM GPT input capture example.
Date:   Thu, 10 Feb 2022 16:43:35 +0800
Message-Id: <20220210084335.1979778-4-jian.jiang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220210084335.1979778-1-jian.jiang@nxp.com>
References: <20220210084335.1979778-1-jian.jiang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:4:197::15) To DB8PR04MB5771.eurprd04.prod.outlook.com
 (2603:10a6:10:af::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37a6b797-3a00-481c-7747-08d9ec718161
X-MS-TrafficTypeDiagnostic: AM0PR04MB6211:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB6211E3989B17C8D3ABF28C149A2F9@AM0PR04MB6211.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:311;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cGFYFJxqftI7nFsj3fZ7EQefqNG2zh34iy0hKxLXAOqHmMkXalkPJsJyUZqEwVVSe2FySgeMfZG/33gOo8pSyIvIuxSto9FVo+Nr3VWOLP4f154ZCxT9qT3kIEOZJZhLsUdgA/201BQEyVPN8kPUf35Wj1bf0U5CAzYNbtEv+k2EUneQQYqZ7ID/y1u62DgvliM3Fyr3D/GBf6D5nhJwi0mFD1UfKjede/DkZivwXZwfcvYMfkHNu+jtWaEdq5Dd1LSerZG3itLJ0ReMvdIve9FiCMxeEAh0Waz24w8JN0YZ0oi6KXTg1+8SWBh5/0jUMbRMM/lX21+MMM+xvyyv1+14FUPql7wl/7dhggXtxAZkSSiYdFaKXu2Q5lolezDWsEhhi2bzBUMR6ooSVbPIlhTW03VfKSPHbQ8nauiodEuSzevn4YZ0IonGT5TtgG4DA+FF9jQIQdJcG6BEBDrlVGzQyDd0oYM9yTsfqJ8tVhJ+Dx4m7dVzf1RMA7BbPYEROsO4CnyHB7xbqzDWQb471lKWYXEbqeSOcWiCwdNJKXySPea6W1S5tfxSGrRTyzqf+/X/X17pGTTvHrl0JUT18Jl/E5AQhaUBiDXe7XIb4o7A4RDCsILvLKY2YEL2Z6TlvM/6FVNJeJcWX5oj9c030axHkxq8EvbX4mDdgPBBwig0W7qPkBhBKVygVoeG4iCD8bNW1CHF+NlarEuS8fuM8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB5771.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(38350700002)(6512007)(8676002)(110136005)(6506007)(316002)(86362001)(6666004)(508600001)(66476007)(66946007)(4326008)(66556008)(6486002)(52116002)(36756003)(8936002)(5660300002)(7416002)(83380400001)(2616005)(1076003)(2906002)(26005)(186003)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SBrqZ3yATTxoN4G9tNO++dKDPJyjvUfJ3hh/oW9D+tWSwbcruvgeoyX8QG+2?=
 =?us-ascii?Q?JrVchnurKns5kanw1YDoSkBvXh5fUdT++M9ysNrdOyhcljbkv2FwL8gt6nYb?=
 =?us-ascii?Q?omkHIJ52GQoyIxcnrBP/2yQzCpb/u9oOaZtrAEilNkd/nBQGLjXEpoePiwpj?=
 =?us-ascii?Q?o3rq92ZIGWRJSaaTIgzbvGLxPov8XZovS1wgj21j4xkdkTZLkBEpL2ddvHx8?=
 =?us-ascii?Q?XEWU36Vbr2IsaGzmU9tEehAO7zKpVmf0TQ5igDAy/tFnVj3Rro0xBQlJ48gV?=
 =?us-ascii?Q?d8jWHaYFKydnknzXd4XiTIvWKmN6EPmE4RQMOjD8NF7GkMEFPCiWbjLo0zqB?=
 =?us-ascii?Q?m5WWLwtFBeHSn8e8asxZDNUcYOaa0fPPrdOvE3qKAkq5j/ZrxhTyJHl/1I4H?=
 =?us-ascii?Q?mJiCYGqdYdbSXTpHdw+WWWmJDthMrTi8C2yKSAWzSt8vvgLr2g5e+qaI3vvx?=
 =?us-ascii?Q?7PaFx6oNXR/0m9g5WDBL4AbkvJBDj6IHeAYILG7rusdGKAbOLqyvWaTbKp8s?=
 =?us-ascii?Q?TCtPmRu2AaJ6g/HkNxwucVYrIKTDCufZ/K739zhyEHFatM4D6hE41PHh1zEm?=
 =?us-ascii?Q?h7pPJCoO5W+8jbHm/r2oiM44QRXghFs6oyMOhGBIYL+Gdf0VrE/d/htUdlAK?=
 =?us-ascii?Q?1+exeU9zbuinrM6roXSkVS5VFM73KtBWVGWvt/XckoddSV74c4lFyRwmB2EJ?=
 =?us-ascii?Q?E56PNnaU0kTSGsib638NoxhpAdQ5QraC+Vwu9Vbl1o6CsMBzaQwmcMDExRxa?=
 =?us-ascii?Q?BoPQIQ6cV6+v/QWMT/iqW94OscsRbbQItU1wTUNAAvRxnssJufsTkScJgfZm?=
 =?us-ascii?Q?KNv9GMx+yWir0D50k5HJCBbMrO2EsJvg7QEsqhNxjSGdT5iP2bsiw9HjpXpc?=
 =?us-ascii?Q?lGgeBcwP6txC+YhXX/kTwQed99BVJYUyj2S0en7HmxWIHR0V4g9owkIBH5Yg?=
 =?us-ascii?Q?ejY0OP8LN0e6splaxI7avOAw+PASa4zZmlAd8yGmgIaZxmN1d08/x9xFFWH6?=
 =?us-ascii?Q?UuSorLx/i0sh3lKzPipYKv3TGCMToxaFsQjM/K+YgRBzXqUaK8Yvxdx4ktzW?=
 =?us-ascii?Q?kFoDcr3lgjErDkix+Uddeh2opNGfn1FbZD/urbYod93ykZxZU3K5zTuEkqAw?=
 =?us-ascii?Q?oar1/dcyEHSd+aOFhqzbdxBOtT/Zbi5qDbpUboNNSCESvxhs6VgevTW7ZC5x?=
 =?us-ascii?Q?PEIJIX1GfZe6bdqu+dw9OfSmAkmq8KsUes+LGT9l1shF4+08lfBV8p60rklz?=
 =?us-ascii?Q?nQVBE5cufFos34Z0mr2xWcSalCj4Y074S2bACPrmQ4kJZg3IBa2yXpvFNk74?=
 =?us-ascii?Q?AzNIfMzWtbJaVXB/eozDWdzYK4oemYEI7jv+2hVw/e3UIjrBeP+G7AaHl0En?=
 =?us-ascii?Q?KtWgh0WBHG4QUkA30Gfn8sr5+sRyosoWhVmFOamU0vDlrBkVChEvwh28Xivu?=
 =?us-ascii?Q?MCUvexZGY2NTgKZjkleibHYZEOqclveHN42QWW2DMw9F53A+FkXuqrDrAL83?=
 =?us-ascii?Q?JeHhPitEDjchu+JXIix98JmPGjO38fSgKfobT9Uofiwt32MZxVX69mgssbGS?=
 =?us-ascii?Q?FCvNCePwkY9aVEMtyzANIZowHrJN0m1aBX33TckzACELhvFfOxjGTnyvIYLr?=
 =?us-ascii?Q?0zkowrhPUGiXwa4btYvnLs8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37a6b797-3a00-481c-7747-08d9ec718161
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB5771.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 08:44:09.7931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vJ4XzguX2MnroRNp1ymq1dIGYUu7ZpCjMMUeZXJSxS1Z7nSAgbdPv8D0xx+1eljp8Vh/u0bK/cTI8snps5CqZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6211
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cause i.MX GPT dts example cannot match i.MX8 chip series.
So add NXP i.MX8MM chip GPT input capture function example
to yaml file.

Signed-off-by: Kane Jiang <jian.jiang@nxp.com>
---
 .../devicetree/bindings/timer/fsl,imxgpt.yaml | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml b/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
index a4f51f46b7a1..917c1d9516cc 100644
--- a/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
+++ b/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
@@ -58,6 +58,29 @@ required:
 
 additionalProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,imx8mm-gpt
+    then:
+      properties:
+        reg:
+          maxItems: 2
+        interrupts:
+          maxItems: 2
+        clocks:
+          items:
+            - description: SoC GPT ipg clock
+            - description: SoC GPT per clock
+            - description: SoC GPT osc per clock
+        clock-names:
+          items:
+            - const: ipg
+            - const: per
+            - const: osc_per
+
 examples:
   - |
     #include <dt-bindings/clock/imx27-clock.h>
@@ -70,3 +93,28 @@ examples:
                  <&clks IMX27_CLK_PER1_GATE>;
         clock-names = "ipg", "per";
     };
+
+  - |
+    #include <dt-bindings/clock/imx8mm-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      pinctrl_gpt_input_capture0: gptinputcapture0grp {
+        fsl,pins = <0x1CC 0x434 0x000 0x1 0x0		0xd6>;
+      };
+
+      gpt1: gpt@302d0000 {
+        compatible = "fsl,imx8mm-gpt";
+        reg = <0x0 0x302d0000 0x0 0x10000>;
+        interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clk IMX8MM_CLK_GPT1_ROOT>,
+                 <&clk IMX8MM_CLK_GPT1_ROOT>,
+                 <&clk IMX8MM_CLK_GPT_3M>;
+        clock-names = "ipg", "per", "osc_per";
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_gpt_input_capture0>;
+      };
+    };
-- 
2.25.1

