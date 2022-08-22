Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D8659B9BC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 08:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbiHVGpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 02:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbiHVGos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 02:44:48 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140089.outbound.protection.outlook.com [40.107.14.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AE928713;
        Sun, 21 Aug 2022 23:44:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MnAa34q+P2ty3Uy8o6oxKMPjAlzVRoClJXMgBc7g9dzkGDrrGlNkvan+ZUNsxNWXjjQx/qWg2yQb9NpWs00MAjxqhYNUUJyc23X5xdKyLS4t/T7LMha5xusx21uftMqPded4eGSdc4LvZsR6Shpz3IX53UJpW1qlLyjFSPdkqTe0Z2sXhfX/a0raMDCnmQlAE6WByui3rcSkL0PFpR4uL58/VbJcCqyRuC6tFdGBXJOtCtSUQ9k32MsZT9xeHwuuY/W1YesvGqifxhvV9F1xJyHej5N6V9beQjhL8XPot9iB4GRY6KhuRlI48emagwJWi++v+VuHvDBpUbYuQ5qV5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dma8cIJQc5ubQopFUhi6dflKF9/BvxB8VpjaXn131eM=;
 b=QZfqgFfilQjbqbAMgJ1p1hpnqRI3vAvzeVE4ImPCgnlOQXUDyPzjWvUCFdIs4TDaA/6p8Ij0BjypIH15gd57+xhBJyTzRz5+1oW3RmmOdelQeKuhnbGoXASi2nXWMu6WlYiLcXmJYuaGF0WUlRHhnxF8Ism4TTpNnPGZJF+7gn2vny2eqBHlq8lvLz5H4TBY/9iBxFhUkeUCLiShzeHubMSi3fqg/CZtjyUBiq/+JhldKQKGfW6NqF+FIFY28drBo2R/DTlGbeyXWWMTVBBNVMOCwI2BZfn9fGSdt7T65ltW1e23NAa3f9vrtLHOuz632pSf00d0SE2MJ7BdK1jjhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dma8cIJQc5ubQopFUhi6dflKF9/BvxB8VpjaXn131eM=;
 b=Lors4rQ2zG65TaLQ6Lu+YbmftyCAsWbjF1uEG7i1KiNY/0VDtchNAWtbUPLqwhT8BXfpRg6byFIxEJyKdmO7N/TIjx/iIJmYUYF9UdX2eke1GXcJcHeh+u8Me0mzMBKdYL/dFy11JIIWwud50CxV3FBb7O0lg7eWwaJiAYtxzag=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8752.eurprd04.prod.outlook.com (2603:10a6:102:20e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Mon, 22 Aug
 2022 06:44:41 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%6]) with mapi id 15.20.5546.021; Mon, 22 Aug 2022
 06:44:41 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        l.stach@pengutronix.de, laurent.pinchart@ideasonboard.com,
        marex@denx.de, m.felsch@pengutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 8/8] arm64: dts: imx8mp: add VPU blk ctrl node
Date:   Mon, 22 Aug 2022 14:45:36 +0800
Message-Id: <20220822064536.3947512-9-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 030dc54f-5767-476c-6d6b-08da8409ca59
X-MS-TrafficTypeDiagnostic: PAXPR04MB8752:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M6AIdnouuoSPduDr1aLsM0SVEc4vO94kdCOQPUnIDHIlK7vOr+0S3tJV8/HnLQNINW1qDNTsRo8X1nLXCkcSVeKFh+kybod8GBli+oeQRUChaLohaBKOtPzdii+0ujgxXPVYPa4NCQKF5vy/fOi4ZZbf64r4i0+i3nfUQuefN5+Bb7bR0zt+p+02VOnaIJjBtzknsv/QhYQCZXrwjKCaCVYcQUhwYVOTQtIM9S+CwLkIzX2MkQa6W7kOxhSMz/4XsEFF3MEftgf/Z61FH9pnX7vvnH63fG+Mc9uqi88x8V2MldslzynN8Rv7WHO15CCn+0S5BNxWtCzhutt4yElDPIoGz9fdt4uE35EEOtuPcF3YitQ9/LQxiFrBsRpuYqMnrg8uTAnwzYFyvU25Am0N8dOpTiyuIX3SZ6/fwZ3v/F7+07n7GYw/M3LNLG7jTYhpdXzc2Evt+n4EI2B8fK6SBOmiGbHSmPbOkteNkGvTngvvoW2zYEW19iY7+ZfaH/zzZgbnH2Xg68mg9eOmH3enY89v0vH5Ihm7P7jD2vd/kOvmJrLSX9jUrq/LI3IexbpQH7FY5qz0tXcI3mAvLIFx1XkKcWQAdtaJOLOZc++DzaVln+70Bc36RGSpaXvJNHyZYxgJYLtWh8LyTQCZgAaAbJjHlvvZSh7MPTKZ3P6E3EFoY/vTx8R7Qnh5eSeCUctd9z9T22iVxwU8kJLL05QeTYldceJgdOk9LJKs3HdFZxycYXmZV3GFAVvaJ1K+V6NGkKEwB/bkqfG3uoMHLujWpoSV0oPerIfNHivw/fQwsDQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(396003)(346002)(136003)(39860400002)(83380400001)(86362001)(38100700002)(38350700002)(316002)(478600001)(6512007)(66476007)(6486002)(4326008)(8676002)(66946007)(26005)(2906002)(7416002)(52116002)(186003)(1076003)(6506007)(2616005)(6666004)(5660300002)(41300700001)(66556008)(8936002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?47DNF30tVVDaaw5tHhE1teC6JtZCzsbqfMQwTI85ePZCO/dslxXWA7YiWHsI?=
 =?us-ascii?Q?neZ96q9n7Bli8rqXCveYZ7eTJuxpO7Q7mhocsLEjZBQJu98ip6wBLUN08QNI?=
 =?us-ascii?Q?KuxRSDZvnfCLY7KKjElpD5uVVAVrjTkU3OM6bzhVT0VX7SQIIVlY46loTW+w?=
 =?us-ascii?Q?06xXKUxgDJv0LNPD3+0oSN8S9yn56lqGtehgoFzkAYtCxXXEHV01k9S2ZNy9?=
 =?us-ascii?Q?woTjBLR4qBfPMEEQgbTvNgtcLVRLE5lE7Ssm5NywGdbuhRCbYBQ2xAj4zK1W?=
 =?us-ascii?Q?bDyTiM72o0ig3zBp2i1cqN33u4gQm6ZAZt5nvDk/VICsqW4PRaC3XHrfv++W?=
 =?us-ascii?Q?DaaClsTVJv10G6JX7fpmicLsSi21fkT8SLlpGXEGIv+Af26sVGg43RlzWK0I?=
 =?us-ascii?Q?KEvUoQr2eToLIWFHfdbUG2dphfpiVI0/LoxViqtVDPFxQDWaOJWtUoJpHbSv?=
 =?us-ascii?Q?Usv0a6FsYoAmQfYOhr2ZU9ao3HmqbncDWIrtkIAQ8VY5lfRE0XCaIwlNhD7Y?=
 =?us-ascii?Q?zJjvPtzigiUtN/6tVIGsOAtc5YvYm/LJYoUwiB7CiXdbiwJ99UFuodmeOLmC?=
 =?us-ascii?Q?JwhBg2Q1wHiTS4ceKlpZjlasKUJk4m40jV8G4+vHMlRKQ1QTh0zdfbRzG1ip?=
 =?us-ascii?Q?mYpsgLReaUfJCs3CRDdr84tseRh5xf8lpOWKjvj8jYOSWlK7y0mtrG+IlhDT?=
 =?us-ascii?Q?Eu/0pTGaFDdfgK9BCEy/I8iz14/TXOozGr+puzelDQY2NH/EatxiaUPFfBO7?=
 =?us-ascii?Q?Ju+aw8qGcRJYxtZyMwCRbIB4LRZKixs8lnSEd56RXK0WK2B37zXM2qzEClX0?=
 =?us-ascii?Q?3RrUZU1OQel8yi4eyMnlbao+9k6gjRfnEoslig7j6U3VVmRqbZoYXayPBn8A?=
 =?us-ascii?Q?E+7+dzIPzs0ANzsPH53g1F2JEiHuw75OXCRBv2IZDTVMHmvXLjdbMMGJGJdC?=
 =?us-ascii?Q?AESILTs7cyczsvJgldwgnjHJ+EovrCdCmjk47U7WlAt6QUWkDlUbwHq443ox?=
 =?us-ascii?Q?iALP/S9Xft64plrEH3FlJ+d6tU5r5H2OZtmwVxpvn/OauXa12RC2mFCuPyO0?=
 =?us-ascii?Q?F8Lp7fWCwjV6w1qvlXJHdIr90TGwxik4OnFHHDN7Mff07ZoKjasXiBxBw/7T?=
 =?us-ascii?Q?O6VhiQREMM0xaWPkdI1JMVbp+O61qMUgVdqaxpTzQ2Rk78EvOmZrG+g0JCuo?=
 =?us-ascii?Q?Cy1StPtwmPJuOCjLtdFj9/OblhXBPEZEOD/fPzzJ0cgcHSYcd3ZbiYLV3h6y?=
 =?us-ascii?Q?TUCb2DMN0S0rHCTcpkMe4g/JroTKRHO/ngpmQN4um/gi13HNqBu3UcUeLyMR?=
 =?us-ascii?Q?VyLJB/EPXnLI0+bNnFHbFvqgc0j6SOjOK/0VHwwVQEmUK0MZMKtWjK2xQulu?=
 =?us-ascii?Q?zKViMBHGDG9yHxqI4ZuIiL8uAaLz8MKBINEu70ERglWaWTjAkA2jVjQEi6pM?=
 =?us-ascii?Q?OMivL2C/MqqvWpm8De9VvFbX19c7Ny0QZZMhVMiApQgMxbFVwAhq+mdAWIPb?=
 =?us-ascii?Q?715qJtdZ9wtk4hhfpfw/5qaWR+QhU5kn8BOvUxVi6CXnuJ2PoH1b80J1t6Yp?=
 =?us-ascii?Q?1jSMsN4zebMKaL/QxehK/rBWNVuRKK5lniIS47cD?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 030dc54f-5767-476c-6d6b-08da8409ca59
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 06:44:41.2496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SaXiD7jvf+CyHy3sFNj6ohjvuP7PbywePfEjzSNesKpxhRc+J6O3/r3B4+EX5X9OmPOhpiMse3GoLf9U0hMEQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8752
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX8MP VPU blk ctrl node

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 34af983b0210..a153bdc7a01e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1175,6 +1175,23 @@ gpu2d: gpu@38008000 {
 			power-domains = <&pgc_gpu2d>;
 		};
 
+		vpumix_blk_ctrl: blk-ctrl@38330000 {
+			compatible = "fsl,imx8mp-vpu-blk-ctrl", "syscon";
+			reg = <0x38330000 0x100>;
+			#power-domain-cells = <1>;
+			power-domains = <&pgc_vpumix>, <&pgc_vpu_g1>,
+					<&pgc_vpu_g2>, <&pgc_vpu_vc8000e>;
+			power-domain-names = "bus", "g1", "g2", "vc8000e";
+			clocks = <&clk IMX8MP_CLK_VPU_G1_ROOT>,
+				 <&clk IMX8MP_CLK_VPU_G2_ROOT>,
+				 <&clk IMX8MP_CLK_VPU_VC8KE_ROOT>;
+			clock-names = "g1", "g2", "vc8000e";
+			interconnects = <&noc IMX8MP_ICM_VPU_G1 &noc IMX8MP_ICN_VIDEO>,
+					<&noc IMX8MP_ICM_VPU_G2 &noc IMX8MP_ICN_VIDEO>,
+					<&noc IMX8MP_ICM_VPU_H1 &noc IMX8MP_ICN_VIDEO>;
+			interconnect-names = "g1", "g2", "vc8000e";
+		};
+
 		gic: interrupt-controller@38800000 {
 			compatible = "arm,gic-v3";
 			reg = <0x38800000 0x10000>,
-- 
2.37.1

