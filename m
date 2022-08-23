Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA6E59D0C5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 07:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240210AbiHWFvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 01:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240289AbiHWFvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 01:51:00 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2064.outbound.protection.outlook.com [40.107.104.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990D35EDD8;
        Mon, 22 Aug 2022 22:50:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXy/Dg+Clun+fs3f2JDgxDSakvFITNfALPgBurLara15ZV5ADSgV+cJy1e2p45osDoIeGPqRMmnImIcyiIHQ67CIgShVWGIHXhKEHHINJx4c/JTeRNjeVUKboqUGF/n4gJOFFt2v7vJ0PpSzWuAhO2S9fjMNXYHeQhatH63gK/eEd+pDAHla3UFKy2qj7FPqUcxm/ctstPQtkfCrfDBIgu+f6ykK++seVFtbaf8l5SzAQ+n7eorLD1TF2iPVIYevLSgk5unNZFdIvTvktDNQ/4dbraL45SWd6ezM1QBmtLORSRcmXxNnCGnLuUEgys6KoRt1r+Q+Bqx4lHunzWDGzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iINQD28DzOkRmE/tAFH5kLwvRi/YffQp0vo5JEZarNM=;
 b=hqIOXo7jiWe7OakLYn97qjujFX9urewrd0tL2OZI75RCzbXDZ1BQ0FeYlzADE86+gJ9CynCn3DQB1OOVkRWKc9Qw965Jiz9xYDBvsQseZObgOie5ISLy7gKr0h9EUI6BbybE5n/CYcdhZ9yjN35RvulJrmULHUsL03pbawjtpuD5r89Roo3Iz6LiBL8vBsYKZbg2RyaLDvL2lim32PKMHv3cXD5H5zvN/JX21MxU7yEnUJlhRuGGQYsuU6fVAZ3q96wjC7vhOsRtXAhOUyA44VFzqeRAlVHRH9kguCHvaXDVygnSWTeD8I08CG6DLy5iPaPXIMW5hlRjLVcpAzVCFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iINQD28DzOkRmE/tAFH5kLwvRi/YffQp0vo5JEZarNM=;
 b=EmQYsFRQ9oZPx15LF9SrloUi3Vz8ggLFP6dOTk9pfgSWSWNqP4WSTHD6BZa8cxJ6lgy+MA9FuJQWczslQvSm5vj+gzCevcmUNXEIGDS0NguH/wf9m+Y7nk4JrahiVLyK3ssNl53xtE0CgHpds1dSjtawdNqzHrYfQ+IzaWqcouU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB7165.eurprd04.prod.outlook.com (2603:10a6:800:125::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Tue, 23 Aug
 2022 05:50:57 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5546.023; Tue, 23 Aug 2022
 05:50:57 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V8 5/6] arm64: dts: imx93: add src node
Date:   Tue, 23 Aug 2022 13:52:14 +0800
Message-Id: <20220823055215.1139197-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220823055215.1139197-1-peng.fan@oss.nxp.com>
References: <20220823055215.1139197-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::16)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65c1d91e-f3a1-403f-975c-08da84cb72fe
X-MS-TrafficTypeDiagnostic: VI1PR04MB7165:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7KspiGDFvsLP/tqmRmPgYeoQ+0ibpeZZdkeasu5QBcCgZANu88HTVqjidzEmaYD2sx3j/GceQc/x9kw4Lz+yPeiYftDCrMzZQBD6/lL0JTfLhOnksUdPxAeXbgYonWz93OYzzFDzAUaXmsj5rku2XRMyr66E8rYd4PIPiHSXwngXNF2hNYhUHTIlxp5DcO+i0lJRdBv5Y+o6g8I6seKUc2bhzBA70ZalOfZFtl09Rcd5Mnzy88DBa6xhjr30PIF4fyKuUT1ovkO0n0fn316gfHxjITTpVAnIUq3am2tE3TR9iLccJPVOOnKmJ/jqMXbuxvPdIy5vH5Nuwf9hJH2ZoKrhroo5fsdZCs99G9igC2XB/scrrIQKED6ZExpL5MMLQj7qDSfEmzHh5KyAj/0dG8/G6FnLLELjMORxMpVdAV4GL/ZSVKg+H3QX3TCZYMcbUtJ9KEFURpjIifZ8HeceUP8Urng73qPFvuMK75Zgj2/8sKWmSbhhZqcvG9tI0pFII6rcUSimgGKggNjqOOGf9clSOWzoMXRLAmmBQTY4iJlryoGiXCWpn+cAu3XEUuyTxuWY5XA7bNQZ/2Vf9Ku+hZ//YSNvsH22LGbTxJXml+KmBPa/u1aOVSQKhwr1UJfnyaXugpAjk6Vt5iniFKPJlN+wCOvmEpRRwWS/kaQ3uPgbOJ+lhcdCJJIOFQiHynBPiS65Cb/OCaT/iEaooey4tvea50AU1t48vonCcHW8NL+QySNv0UATys+nVjRRZHf/A+QUhI7vNEs3HPhsCu5tnw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(376002)(39860400002)(396003)(136003)(2616005)(83380400001)(38100700002)(38350700002)(316002)(8676002)(4326008)(66946007)(66476007)(66556008)(26005)(6512007)(6486002)(6666004)(86362001)(52116002)(6506007)(5660300002)(2906002)(186003)(41300700001)(1076003)(478600001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V5fGcsTHez6reE1FepHnAf1OnuFVrU0tkajkW1pHCCZdJpQYc50m4tvZ3N6d?=
 =?us-ascii?Q?b2OfyrmUbiWHnWw73x5+w8lzftKyr3PzOv3bLxVNZrhghAdTIHY0MiZAavT3?=
 =?us-ascii?Q?9IAFrLOacvt9CJKcJnKQIfvwRtxrzl3mCSJgaEW57InTrt/Gtjf8P1y8QqK6?=
 =?us-ascii?Q?E5YoYPoUXDXCS5xQRMbEfqFzPJ9aZNByqqlKyZhZDM+JinYO7eYv8lZxajAi?=
 =?us-ascii?Q?bZI+Gu7MbGoTaeNUekDquIo4MO6/SSiKbcVveMvTuFbRVb7C2N0hIssil20k?=
 =?us-ascii?Q?ixrnV2pDmrWsY9x0yv8Vx8+UjaDrSvu+t1MYHVD7fxewMb2XWUOxnlKanhNj?=
 =?us-ascii?Q?HGkjLPyhApxrnoOh2G74GHYzm/8JW1fk9MC71VJLzdLgANCy++A1WSSRUh4k?=
 =?us-ascii?Q?v4oMdy6YEHGCQTPFhG5bellTnWyCFAPCH9FLD4AUPkmmkKGiSLpsDh3oBCJs?=
 =?us-ascii?Q?eXHVVO8maUy2J+fFKS6gykBJOANhfSpDVmkRXtWxXv2X4SsCH+WhZJhlOJMC?=
 =?us-ascii?Q?rRoO8lPGudt19yOUoPlsX9GXG0naQBgsOpC4JtWiod1K7Dyb0xSumpXYfTDW?=
 =?us-ascii?Q?uzo9XWcs2ZBcM72H4/bkkjBZ5+e22HJKO03cNtTqinVnjdZCL/FNPUg3XcdA?=
 =?us-ascii?Q?JE8z23rLgju13b1yIEUXFtc1tQUzXm0gGvF9Bfuhp687/IK2afEuBgrOmS1p?=
 =?us-ascii?Q?WEq/c24475WK+wso9vrV58/HthFtr7x1VLeSTjAU8Kg7VwS9vECm3zL+5Y9O?=
 =?us-ascii?Q?qMr5qxfyn+RtJAf/eIJ0Fr1bKX8TGeRETKmGaksu7rFxz7rYmc3FrWtQcuUR?=
 =?us-ascii?Q?7hARs5htxBkOzEQhTpAUIzWldPLEXRe8y0r8/i9KPfkE//pm+cKTQz4ZhDH9?=
 =?us-ascii?Q?T8nIA3M/HX663iEDuYEpllME2f85QJhGuOivyDLqZJg9wV5M6k+9SjSktL9+?=
 =?us-ascii?Q?5hVc6yarQUcUchpO6VnqSNuZWDKyzLq5YP1j/3gBdhKoWPmtRakVB4fZzeR6?=
 =?us-ascii?Q?yIwziehIGQ/7xPJUXdc/xYUvBUURvjng6f6wL4lv0z/LjCm0+tXI609YaoO6?=
 =?us-ascii?Q?ypbmyhRXFOV8NqBljJge7QnOHdK2LffzFctpjzMt5YKkC4lowCTU9XvE0gSu?=
 =?us-ascii?Q?DAjzTl0VXxEWECFQsWj48j7WHqTAWsjdzv7GiK19Mvsxn35HB5dFL7zF6Amx?=
 =?us-ascii?Q?cwScmqfoaVvjAFoJlz6QLojmjdGwVa63HdrDKHUaHf4FsSUy8mGsOeTZPB/O?=
 =?us-ascii?Q?KpdeNIs+uoq1fuHJqUkAhp+r2+JlzRreGPYCxHuc/SrCjIqfs0KOk/h9qCTX?=
 =?us-ascii?Q?yyNKHQwJdLAMn0rT+bArem48SlOoSX8f19B292i15M0siuBiaHf0otHjP0jf?=
 =?us-ascii?Q?sxyhjkenudaeXi1mbDqwPoIgIo6GCCHutbWlCe1P61oIUMokAKgOuWzqcZrS?=
 =?us-ascii?Q?eXSIV1eqZLsjSC4E3yWAW2QoIRA2PqvzYBNvE9voqXtEQPdxMHVwlkO6nmD3?=
 =?us-ascii?Q?A/y3BdTPspsNpRMSPWSydZMb82RmVbi1YXF0/rSJFsJmcQYcIzf8uNZVU+/q?=
 =?us-ascii?Q?iB4nIuWLCYzFDFL6FeDF5cMcT3ZL0p/hG1k1Gg55?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c1d91e-f3a1-403f-975c-08da84cb72fe
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 05:50:57.0423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: waQufPDzctbiuuZQuN5v/3RlPkMCYMdt7rrRF53IySyYImmdDbGn8wXKOzBIRJMtB1q2yMBJPx5ugui1CmSvIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7165
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX93 SRC node

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index f83a07c7c9b1..3281b554ed92 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -161,6 +161,30 @@ clk: clock-controller@44450000 {
 				status = "okay";
 			};
 
+			src: system-controller@44460000 {
+				compatible = "fsl,imx93-src", "syscon";
+				reg = <0x44460000 0x10000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges;
+
+				mediamix: power-domain@44462400 {
+					compatible = "fsl,imx93-src-slice";
+					reg = <0x44462400 0x400>, <0x44465800 0x400>;
+					#power-domain-cells = <0>;
+					clocks = <&clk IMX93_CLK_MEDIA_AXI>,
+						 <&clk IMX93_CLK_MEDIA_APB>;
+				};
+
+				mlmix: power-domain@44461800 {
+					compatible = "fsl,imx93-src-slice";
+					reg = <0x44461800 0x400>, <0x44464800 0x400>;
+					#power-domain-cells = <0>;
+					clocks = <&clk IMX93_CLK_ML_APB>,
+						 <&clk IMX93_CLK_ML>;
+				};
+			};
+
 			anatop: anatop@44480000 {
 				compatible = "fsl,imx93-anatop", "syscon";
 				reg = <0x44480000 0x10000>;
-- 
2.37.1

