Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64AE59BBA5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 10:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbiHVIbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 04:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234067AbiHVIaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 04:30:07 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70042.outbound.protection.outlook.com [40.107.7.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9D5140E2;
        Mon, 22 Aug 2022 01:29:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a6SXMzZGwvnZcByDg7A4Xpz2BQx8ZsPu6Hy44ULZe/7C8ISWc2Jy5SkhrFOqjX3F823+TgTCkEDbic/bs4HHaatRT3/dDfNBIanDldUsYKnU/aunJCDRzWEXrhsXyiaO/ilDPiAAvbH8stVWiji4ip4vmz2ymoIgWvdA7+6j85oRO3scQICKxs/sWYcNIrRVSq4E/u4KzktSdlcIG1DxGHfOyULSOPtYZ5mtW0fDc5niEk54R3FCsB99a2E3jBhyH5oNPG0tKGoRLU5mgvmDsDjiZdqWzbx1zyNvWPGOmWd7tHX37TX/DaU7cPIO0TkfKMx1Kc+uPUHmTV33ParKSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWOpr5UGSlGjP/pOzDat3oTNcGbm6xg8m4AIGGc6u7g=;
 b=iFix/G3s6GYi/g9edJD+XrZ6EfiL6GaiKccRrwauz3T7qsol5jr4hE6t8dzmd8SvN/eMJSyBIQPBJ/4bK9R+GpK4TwWFJpRZZ5yZSIk5R8T4w2MCMnpNZLA8WSmsAMdTyT0if/qTyC7JRMW2XAgvT6lwMGBf9CL6k9OA81oQ9yduocoR2/WgEgTNjBjhmkemg7JF7gWiTgwonj+v5+GgqcQlJm2FUK1y1HmRqkL91mqc75vMXKmOFgqJGDgDY9w1wgHAwdNA00eezIHEcDX676723X0ChESaLhFwn/FCr3w5a2g9A7MdLjbUPr8M/8aou/hIwILbdnK0hxRpuvX3Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWOpr5UGSlGjP/pOzDat3oTNcGbm6xg8m4AIGGc6u7g=;
 b=MrMP7XmhrQLeLv2nilH9q3l/+34crduk0En1UOq9R81j27A06LT/sBl9QPTtySIwQ5vo14XBk7hryyeN3Cqlip4iWfIasAKChpfXcR6Kn6S0QMZwbmVPsQCNGkmdIfJ4/6MuOtE2XRH1ocbQVKv/Oaa1AaxNUcIEKY+SslEPDcU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB6128.eurprd04.prod.outlook.com (2603:10a6:803:ff::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Mon, 22 Aug
 2022 08:29:53 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%6]) with mapi id 15.20.5546.021; Mon, 22 Aug 2022
 08:29:53 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V7 6/6] arm64: dts: imx93: add mediamix blk ctrl node
Date:   Mon, 22 Aug 2022 16:31:06 +0800
Message-Id: <20220822083106.156914-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220822083106.156914-1-peng.fan@oss.nxp.com>
References: <20220822083106.156914-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0041.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::15) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7f6a9c8-0a97-4a09-b8be-08da84187c87
X-MS-TrafficTypeDiagnostic: VI1PR04MB6128:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IornQLrTT2F16yjtigIUZ8prQbD1eEAXvocmvEEnsNWnVU4BLjdErCMfI5uNUaj5auCDhCRthm+ianOLZgB3RpdnskacTJphqBZjTqlqE7ajKBQ72MbDegEOCY1VX4/W+c5fgz2hgiWQE8zX822GTWkCrZTPfVX1ZkDJz9iY4U1MKsSfJb+Frvzp5jHkfWc1hhBqbt930WbxV2qsSqRtEg4SR0DNSR9ZNBvOYRX0waB6AJYAiaADSw+cGRMsCA3YlgBeF4C+UG4rOtwyNHk22ekiCBoS0AXwcJ6WJy7mLzKmc0j6sPZJwOBx2cP+Q3sZVBSD7knsGE6Shn+EwqYlB2KQjxGYTW1gmWy4TXquNWDpgYd05coYNw0IpytArBDzyP/0ZXz1m7R8vhJ/9dz/CWGHyCtnHwyJmmIfvtJJ+hZpqp6b5uJIWAa3ULNOFIPvZZPBZCD7gpk44tUDgeaxxfCkwUKR14yp26q5cgfu20XNSGJRQGLaXRKOFGCb3q9y6WT/qMtsJqg+kk8ymrAN+1anKPAdUjIn6J7snXJ8GY4TAVL84skfjjmijx/h9QCrEkSutbLEtQHSVg6uWbZ3qafbhCDKVLGm1xfxM2XRukfFD5BYubJf3OyhcQN0c1ORBnc3eTJwsdSOwOqwXR7Gu/nNOskm3usszdhFS7/ULx/suw7Gm9x2jwEWx97ctfroIe/le14ks290t68cxGGJGuNCZ/aQWi11sNN0Tim4gprNw/bem1jSGoAMbatXIe2fY5bbS+07e6jCOP//i4RaDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(1076003)(186003)(83380400001)(316002)(2616005)(26005)(86362001)(52116002)(6506007)(41300700001)(6512007)(5660300002)(6666004)(38100700002)(38350700002)(6486002)(478600001)(66476007)(66946007)(4326008)(8676002)(66556008)(2906002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i6t5irlKdVPaUHXdhP5orlIWsC4pvqjm9C/xE+QxQxXsqY6qjLc5Daew49Vm?=
 =?us-ascii?Q?1hxWJTqx27IGAbRf7iCd0bE3mtpb4aLKS//vS2Bbz7s85uyHNXJs8bi6capP?=
 =?us-ascii?Q?YL4e448U0bUhW+HEA44PGnlV5VIDRHpIvWzEe0ie0I6MqMUYIpVDdKm1TMf9?=
 =?us-ascii?Q?+xpEnqeKUjsMVSL78pZ1pe91I95NqMv2g/EWOWD4BJr2yZaT/w1YH7BmBCrc?=
 =?us-ascii?Q?TyZk90q4RasUGkA5s2T9Hi5oSHt1l7qXbFWrWr7pnRO2joSu2VgcK8z4MV9X?=
 =?us-ascii?Q?21r9mUgrPpr8ZXKBeDMgKCd3VL0GRxG4iDeIhDbrXPDhPY6iU0GVp1wbGpgC?=
 =?us-ascii?Q?mQtdrQ+7YE6JZREgSnf1I/eaRV68vKSN28rlCJpX3Y7GW9ssB0jAlQhfN9CR?=
 =?us-ascii?Q?nuMaDTPijvO7JoztJmdWbF5MrKkY0hHwXynBXrC4NNyFmgOVANfVlLvUDiJB?=
 =?us-ascii?Q?92gndsbfXxNsZ8AgnDkgcZEoK9xDr3WsR42TLmszA1R/1HtO6p64d+mL/lcs?=
 =?us-ascii?Q?tdc2OrCRVi1ULBErkGii2vCXq6oO/AMZFcloHfgDqx8NANjeHWYhceWxR+v8?=
 =?us-ascii?Q?6ODKtrXev8+qK7GpWp+poKXBwkVIWXYYJz7apnXRnwk1E9tvkS7PJyzBw1R3?=
 =?us-ascii?Q?if/Ouv4kXQ44MQzEzSeW1Z8olLxVj9ECmjJJE3iDBzxSFlK8DzvPU/cbVfLo?=
 =?us-ascii?Q?gA/O8RGFJp9hGqnLhUltYqJgPPOdV6WR6TG/H633fwPfHUplm83n8bio9M5b?=
 =?us-ascii?Q?YO0/kvtaT1vbcW866+Ew3uqgXbk9Vl0em73M9zHdfwqdT2FThO8mGz8SjCVJ?=
 =?us-ascii?Q?euE3+vmxjo4liZX2t8WZwJbvXhw6qDa1HJuMEsVTyfVTV29W04OsjJtzcwbo?=
 =?us-ascii?Q?uVby98njLOz1Irf6Gdg2NnVuWnLW2R+BR2ZJVV5lOoNTGKaf2zO8FQutHGhN?=
 =?us-ascii?Q?l1tjT9oB9al5ky9x3GWaoOaU3IZp6uQQj6vpAaraKbhEPVs+Ao2L9RfY9hmC?=
 =?us-ascii?Q?be1P0PmOiQ2stDxpomuC9Urh53KhwVNZMJABp/P6TGdaj55gbp4gsuKvzhVJ?=
 =?us-ascii?Q?Cx/0Uev5JWphkjrRHCl9dLjdZ84hxC/SHy2PU9rPg4C3fIqkF3gQ4Ts7WELr?=
 =?us-ascii?Q?R/xS8D3R8rRzltQSUDnBW8MiSicnDwnxa21uq2mmu9z5Mbpvn9Mfu0xlLBAc?=
 =?us-ascii?Q?/J9IMo+jKbejT3MmahoU1fuAivC+ph4QraNnwxvVLNbp/jLzMuvQI2CBBgOu?=
 =?us-ascii?Q?EESXSmiONB16ppo4vp7wfFJHXm+fjfbosn+1MhqYhg1KUx/BTSqdxW3U9EiR?=
 =?us-ascii?Q?ACmk9AO8sn/XvAPH333rjkXgrW5sEBaeFFogjgC72yZzGsFchXuD4yLHNeGO?=
 =?us-ascii?Q?eVsauqmBVnjPPCO7nQmq+ppPufvWsv6FMDPgxfSTFjebmMA9JzqYsKk70HbP?=
 =?us-ascii?Q?sQBQHR4sDFKRq4k0/mHl73kGA6xrX3f+5E9kbA42PQt/QvdgLIT9PoZAPi0E?=
 =?us-ascii?Q?4uTwQxSwgs7CsWp4yha9R1y+fq1rrMjceh9Dqh1hUrreYOuRYqc2zfqPplpk?=
 =?us-ascii?Q?bMmj8KUN4J6GOhDa1nmtqIp6PmdzUv8fxQQnCdBJ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f6a9c8-0a97-4a09-b8be-08da84187c87
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 08:29:53.2522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nJ5M92ACyM6u6TOoa0HzK5/So0En7S2gnwlyep+sfa0fEYpT73DfBvzVXZExsvQNe2o6XpJFHcB44a9ujXV7FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6128
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX93 mediamix blk ctrl node

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 3281b554ed92..0a29b33be515 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/power/fsl,imx93-power.h>
 
 #include "imx93-pinfunc.h"
 
@@ -354,5 +355,25 @@ gpio1: gpio@47400080 {
 			#interrupt-cells = <2>;
 			gpio-ranges = <&iomuxc 0 0 32>;
 		};
+
+		media_blk_ctrl: system-controller@4ac10000 {
+			compatible = "fsl,imx93-media-blk-ctrl", "syscon";
+			reg = <0x4ac10000 0x10000>;
+			power-domains = <&mediamix>;
+			clocks = <&clk IMX93_CLK_MEDIA_APB>,
+				 <&clk IMX93_CLK_MEDIA_AXI>,
+				 <&clk IMX93_CLK_NIC_MEDIA_GATE>,
+				 <&clk IMX93_CLK_MEDIA_DISP_PIX>,
+				 <&clk IMX93_CLK_CAM_PIX>,
+				 <&clk IMX93_CLK_PXP_GATE>,
+				 <&clk IMX93_CLK_LCDIF_GATE>,
+				 <&clk IMX93_CLK_ISI_GATE>,
+				 <&clk IMX93_CLK_MIPI_CSI_GATE>,
+				 <&clk IMX93_CLK_MIPI_DSI_GATE>;
+			clock-names = "apb", "axi", "nic", "disp", "cam",
+				      "pxp", "lcdif", "isi", "csi", "dsi";
+			#power-domain-cells = <1>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.37.1

