Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA203590CC5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 09:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237576AbiHLHot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 03:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237504AbiHLHok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 03:44:40 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70073.outbound.protection.outlook.com [40.107.7.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472A5A61F6;
        Fri, 12 Aug 2022 00:44:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ixhlzb1o5MulTBXVygT1YbG5RrOcn0kBzgNDbhilgKLgNI9b/l0cUroUaWRB/9jSb3OVt58Rzq0Bcd3UpI4ujo1y2Dm+64bkSybTdlDx6VIgHsm1Ul1CHoKL1tg4BudFmwiN42NwwqLHso+8Fkgv8uYv6JxOZbwoTRsM+dSonwl7LF3R8A04iX3wo7BtUGEs0n6Q8Ie3OiJgZA35jhJlVPJgoyVRc+LdyOKBWgcdXVfi0YurPy8beYidi8a44pGZu5zhHHPrkEAYuf3FsHVY0x7bA6Up7Y7E9lLrx5K4Uf/D+urGhaZ2VZMgj/lZNqonZML69QmiDig0IT+8W4qMKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qedGAawE+bjuLdJAEnylYy5nrgKN0Dzq0qCkr6S76w=;
 b=TFA3Rv/pro7aWPRJb9zZt8AfiEQ+or4rdFKfphERbXKCTT9SYDzvd8BVbX/ay0QCgmj48/4LVN4GbgEL0A37y4JW3/zl08Q1noyjFoZU2sPk4MMZgSxP+kztCyoQUQaFFtkG0Bz4OQ8ITrBY/qGkTnyjX+DULOvbUN5sRrfvF6e1vDfOYr69dZAieigupLkbiVu9qpVlP26xjKTMX7f9KDgSVGxh6p0IB6fnVwyFco5iqO0rGYoWw37DS3IHQluq28zxGpz/Gxxq1ViLqs0oShz0SN+KxL1qETF/jdbMFbqaC7d3bQxSGEp8CMbdq/yysWN3GgzI3lRfLJ9Ak8L15Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qedGAawE+bjuLdJAEnylYy5nrgKN0Dzq0qCkr6S76w=;
 b=dtEEuMLrgZJJ4ZxXXSa5OJAxG6vgVgIJDJyqea7ecAjWTWpnqfXJa/zDgkYAAIgGPcogzHc6sFY+3MGQZH/Ltf5NRVVpkAaOPecT5syHMwS3q/WOiEtotogK08kwEKDdUxLIXohwwHsXAU8SG3zEMrQLP5xzx2hmL95Be1BFAhA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by HE1PR0402MB2922.eurprd04.prod.outlook.com (2603:10a6:3:d6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.24; Fri, 12 Aug
 2022 07:44:35 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5525.011; Fri, 12 Aug 2022
 07:44:34 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH 1/7] arm64: dts: imx93: correct SDHC clk entry
Date:   Fri, 12 Aug 2022 15:46:03 +0800
Message-Id: <20220812074609.53131-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220812074609.53131-1-peng.fan@oss.nxp.com>
References: <20220812074609.53131-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0032.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::23) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7560fc0-928f-40e9-c84a-08da7c368013
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2922:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S3k6rHNbYzYNDHDflOrRfcfNcjey6+pJoExncG1SHfFQ3CtAK0IgZu0NdZcxHt5i8FwbOzaBt/2Jib1RAg0k6jTM0/ZaNVly7v1suWVcHJcwXXu1oSs5+hKZALdL0rR5Udnm6WjSFhZZL73C519tB9FzRk37UK8WLEthz9d0Tnaavuw2oNNLAg8ZchcA4WjhY5OnkjBuVF8Mvk9LafH2r07eUKttiZ9XGEqferkiXmMLB/XoOoHuH8uCg4deiHRgQLe5JVQ5JALCzlECN/2elAf+hdqJDxV6UEoKHH4N0Y3aiHDbwWFOTuq3k3jtMtYPTBP+VQyJn6lTlebhakGRU/nuqptRQWDwuyofU3F5bJue52dOTra41lmQvq99PPEiIY15qBEMcDPul8EMVYIfKZYOPC4dHyKeErQrV7NbPvPC11rUrCShuv+tEeGfR32j/ZunDfYzcOHnR6HTDKNxVorZu5Yh3VCRyaQnsYaXTNb4IPP7QHL/hyC4t/i0NKCxhpC3MXstGN8+pv9FkBmrk6RC2PaBiRla218iy7KaE8d7cStVm6aUrH/UspnhmoPNMgcMKsNhHSlNY09vENAgiZCXL7dMWytOkt0XE4e29Nt1wTISGFsJNZ4cZ1Ts6+YGSmGMMjusSUT2Mmw3pgSVg+yeQhV+PCdnALyVAWgGDxLtX9R9qXU6zJP53AEYJ+7/6mwxEonh4RRIanZJGIzoqxQLvT41schylG6tSbNlIWXhlAClEDo4gB7z5FY+TorakapuINWn35Jl51EUSCXFxckkYCQQEcl5X0B/l32UPw/U0zjXwFQfZqHpm/O1NsTd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(86362001)(66556008)(8676002)(4326008)(66946007)(2906002)(66476007)(38350700002)(38100700002)(8936002)(316002)(52116002)(54906003)(1076003)(41300700001)(186003)(83380400001)(6506007)(2616005)(478600001)(6666004)(5660300002)(6486002)(6512007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wpn+t8XT3Hkqlnmv6jy7Q9KhZ1VEPw5N8O85PYnee8g3yetN2MXgomaKLxNM?=
 =?us-ascii?Q?ySYyxmwMjz2HnkC+VCq9WMoKAHmQmkNOdBNMK7kxnwDyouf5f8rCr6r4Q15U?=
 =?us-ascii?Q?sp9K1wVD+WwaFfM7C4N0KD/4981QoBspvuuTs2zSpiAsuZVrh5vpIOY85vbn?=
 =?us-ascii?Q?3dY8eKGuBuinC8QugRvrwcmCjYYXeaghpz56JXvwWEIMLrjsDl9VHrwAK2Ew?=
 =?us-ascii?Q?j3hQzfpkd7RKDGkAeNtrOjzUxx8vwTPPwHjzjmbDTbYfryQfNrXw2ksYxY9I?=
 =?us-ascii?Q?80ESJ2GqdvRLczLTJUK1eig13xbgMBFWvfGGWFm0cdUH3GYb8HWl4vv6n1fy?=
 =?us-ascii?Q?wQvQtE1m8TZNyU+76s/d0kZry7oz4X5fITQOIVRvEdB+kD+TDGDjV5EVvnc2?=
 =?us-ascii?Q?GOrodStlrj9ZafQc7i3GWaVYxbryCXNQT10jI/ttLIsUMbwdrWf9+nIGDREG?=
 =?us-ascii?Q?xA0mdoMrosxoSpceHw1k+Mf2XF+XCCMqLqRZx7o/VTXJIGCozwfrlcVcclN9?=
 =?us-ascii?Q?XXB5lLVlOJGpPhwXWMzTyI0rbwu1DWXn+NB7kru+vIFuR2dgUwoBKdf/Ufym?=
 =?us-ascii?Q?bHrhVqKoBU9RjKkbNLtyYwLNv+h3qAwJhxKF5QF2YNHMpGm1xJc8f45deBtn?=
 =?us-ascii?Q?xr3YxAoZOUvcUi0jUfBzknQ4I4yUaAGwTcvMKvegi0kaHOJeVbGTeSF6JIux?=
 =?us-ascii?Q?RkWLTYMG9UZwcNfsrCrzK1xsDVV+S7AOed/Ul778awPD5XYndOGsOThBR+GK?=
 =?us-ascii?Q?/p/Ptq3MzewvYe9cWNHwFPF5NEWTi3RRsomZ9mEqMx7u94S9UeuFnCnhWT+W?=
 =?us-ascii?Q?QTeWBlgpHxiFeQ1JFvtsVbRnrKOBJHYHOaxW4bgV67oM9TlMwj+C6KkOe+aT?=
 =?us-ascii?Q?GY8lpMGdsW+mX2DeVFj2waUtDB2J3wcXsqW/dL5TBrozO06LGgRHgGiS3LbD?=
 =?us-ascii?Q?54hhtm16UCXyiH+w0MLMFpKBwyEp10xqqRkug23TPUybJw4cMT5BlZs50+ai?=
 =?us-ascii?Q?Dm0FcmNIlUsShAmj0Rra6VS5YkVPGwQ8VyL9YbMMG8UAlZRUqxRvsyYkDJBa?=
 =?us-ascii?Q?o6JOJGnXFt9l1tJpXl8zNU/ErELaEH1r3wC3cDLb+qLwBxlYugQQzi8ibXaE?=
 =?us-ascii?Q?fABGw/g+iZBXz92fMEGm243q0IzIJV5y92ZqR2AvgWmVBUiEre1q1e4Swo+X?=
 =?us-ascii?Q?9JoTdCQ3F4Ea3bAczDrsjPS6PJfs2LbNoc4f+DNWihQPcUBCV2RvUbr9+A2x?=
 =?us-ascii?Q?vkAC7SGLLHA8ZVtg49AVySBjWf2EFndnjlNjdOu52ByYjIAuDX4c3MOopf3K?=
 =?us-ascii?Q?Tl105yNv9nQ8N29zb1JM4CjUWEL62LudoQw2CmT87xCh/3I6pznUjCv6/JDX?=
 =?us-ascii?Q?rH9UPjHJhhj4GMF3z3zta3/2596Ehm/2g3VR6KbBuOswFieRfYPcHnZXQF76?=
 =?us-ascii?Q?1laUM/OwK1C1GwdXJ7uskCYmjRzYLQEBcFnRrWn2b5Wszg3LT9AUudpdFpjw?=
 =?us-ascii?Q?mcXfoBLa7BYqcSYlDoSGqr+W1aT8wUBobWCgxyGRFot5d5ABgQeKgwoZHMZ/?=
 =?us-ascii?Q?G/uutsNvme8gOUakxVvtHQMtbr6smB3Utz2n0Us6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7560fc0-928f-40e9-c84a-08da7c368013
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 07:44:34.7704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SNZhU4m5NHeNRRfTLaHPdO3LcQIfsm/Ur1jPUNfbbaiqVsXTSoe2DfUETaeGafQhw68wNcEkt075Q90iqZfvvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2922
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

DUMMY clk only works with clk_ignore_unused and bootloader enables those
clks that required for SDHC work properly.

Correct SDHC clk entry with real clk.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index f83a07c7c9b1..431dc239631d 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -248,8 +248,8 @@ usdhc1: mmc@42850000 {
 				compatible = "fsl,imx93-usdhc", "fsl,imx8mm-usdhc";
 				reg = <0x42850000 0x10000>;
 				interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_DUMMY>,
-					 <&clk IMX93_CLK_DUMMY>,
+				clocks = <&clk IMX93_CLK_BUS_WAKEUP>,
+					 <&clk IMX93_CLK_WAKEUP_AXI>,
 					 <&clk IMX93_CLK_USDHC1_GATE>;
 				clock-names = "ipg", "ahb", "per";
 				bus-width = <8>;
@@ -262,8 +262,8 @@ usdhc2: mmc@42860000 {
 				compatible = "fsl,imx93-usdhc", "fsl,imx8mm-usdhc";
 				reg = <0x42860000 0x10000>;
 				interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_DUMMY>,
-					 <&clk IMX93_CLK_DUMMY>,
+				clocks = <&clk IMX93_CLK_BUS_WAKEUP>,
+					 <&clk IMX93_CLK_WAKEUP_AXI>,
 					 <&clk IMX93_CLK_USDHC2_GATE>;
 				clock-names = "ipg", "ahb", "per";
 				bus-width = <4>;
@@ -276,8 +276,8 @@ usdhc3: mmc@428b0000 {
 				compatible = "fsl,imx93-usdhc", "fsl,imx8mm-usdhc";
 				reg = <0x428b0000 0x10000>;
 				interrupts = <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_DUMMY>,
-					 <&clk IMX93_CLK_DUMMY>,
+				clocks = <&clk IMX93_CLK_BUS_WAKEUP>,
+					 <&clk IMX93_CLK_WAKEUP_AXI>,
 					 <&clk IMX93_CLK_USDHC3_GATE>;
 				clock-names = "ipg", "ahb", "per";
 				bus-width = <4>;
-- 
2.37.1

