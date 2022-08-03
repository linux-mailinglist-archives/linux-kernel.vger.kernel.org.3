Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FFB5889D7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 11:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237853AbiHCJwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 05:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237790AbiHCJve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 05:51:34 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80040.outbound.protection.outlook.com [40.107.8.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F16A6397;
        Wed,  3 Aug 2022 02:50:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=czw/ieDxzu9O8dDFPulxNv9rKj60Nl6ev6qU1sUOMtDOchxQRX6i7g2bf6tbSKcu/1LtvxjZCLfM+FlSwR8MH5Y2B8y4BGNldC0d7d7EKwfUijTKUvpEVgeppAkSs7Q6Qyr1h+JN7qnkaKuBZGbbdQ5BUkRlOtg650YxFFjqBZ9kh30Hl8KcKXsygkAHYLjfQlmJin5/o/bYMyY8x7qvbnblib0n7F7IR61L1WpCzszcI2OxKgzQLxe9T9vlhTcV/be9DJQiD04uiR88lE28sNQTJWAFpRplgmaJWThut50bkd//NgQnt+jVVlEAV1G6POFIyXYlpneSHsSbwHaivA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GdCEjXJzbr6KlpiEWE23XLGxsBo3HWEe7PEZwuHaKPo=;
 b=Tl2bu1VkxQfadKuLhbgKynomIxqUpEwdTbQRaMlWZpc1Ar61JKJfaafaMgQmqGSqO65Nn5zOFMDc/2LyQaEhHmXmQQ6F1qbzr+ImMHVzVR5CSfLWjcLTr1wSz/b0OuoPK6ClFuSe/X2Ts37MK9ZG+MP5AkdU90DWiIc68Z/w8PschHtcPVd0wmtHvzPSr+7N6pS8szUqwac45hy8eKrIytnSjGMXcISAIW7k+WqPwiu54I6WrNQmt3qQsd1gwI2cEYJxskuHSgwueKXRVwWkon+2B596kAxy/uk664xAcblKch+9H5Qru/UKmNpNEticN2MnKdt9jip/OwweV7+NcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GdCEjXJzbr6KlpiEWE23XLGxsBo3HWEe7PEZwuHaKPo=;
 b=Lig1tp9PU/gzK7ovTrgxBMy47HNBG7lADI8gFDRYeFHwJYebVKcaDHp1wzLm5ew/qEyYvoFKx2F5tph4uhhSX6mar/k0b3cBzQeSSfUzUXTThlUvdl7LPISpSlpLCwFua47YuZRC0jj556oHzLdfycE7TcULTigFz3yBpRHw9dQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by HE1PR0402MB2891.eurprd04.prod.outlook.com (2603:10a6:3:df::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Wed, 3 Aug
 2022 09:49:48 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5504.014; Wed, 3 Aug 2022
 09:49:48 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>
Subject: [PATCH 2/2] arm64: dts: imx93: add gpio clk
Date:   Wed,  3 Aug 2022 17:51:03 +0800
Message-Id: <20220803095103.3883035-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220803095103.3883035-1-peng.fan@oss.nxp.com>
References: <20220803095103.3883035-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::33)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f232f00c-f79f-44a0-6976-08da75358102
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2891:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: evUfunk6lZ0FLB8MWukimlp4iuRK3RJwM5nGi4BlaKZc0NbQ9cj/g0x/2N95eonVuT/i8nNdWqGSltUXLC6RewdqvnD+hA70h1pQlNb+7n4H7PLCs0MRz0qp4sJy7VBjlQ1iDIj8UFgXefn3yRljrOl42vdTP9uCKs4h5oTsajjF42BFY32uvN5tH5BRkXXu0osRri+TC5CVcBkdSAjUOIKeqjVaU0vA/P+7LlBbF+2kkjSc2hRBCmImzSYJcJUmqtEsPb1dOohudqrYd84eOYvc671tWVNnqebAOlOhQhwk3lY6lg200+29PEzUwvDNOyse4T2oH2MaikBaUOdqHld+nXHlE4pTwc3mYg9qtMKCz37QX9zZj2RQ+o1G72wSWDmf8dc7bonbDnBapflZLCVkE31thBkX2CHseATsCucTZNaMJAhu4psz9hRaLNo2f5aQaddfDILhmatx/qavcfWTTVzQ8MlDmv1DK1oBK9Y9B3RHq4cB3ThoXZGUaWRg415HxP+ktboIGnGoK0fyASU5f77btyEgCId8RZDoD68aAgrzQ+naLbO8r9LaNhbUlv4dkCOLOdMz1Kyv5Mtk1ptM9HlNCsnG/nurrM2kK85dBwtU1FOCq+XGiKjW+7tgEa4VzB+ukkBZimXhsA5WUYl9DTVrpn7OeRaK2OD0JcZWcoT16XQKCbxXMeGUL2T95xs0LuMqI+nA590S1LKnguknCfe8v3SYzMDOZb7LurC46bKYQ7O5N7wQ6uHYyKjIKaGxe6QgLxpmKIOo9LrpdbkJOZRIrx5SwOMX8WUfsUylho6xcYS8IeFIHuHqvvzS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(39860400002)(366004)(376002)(136003)(6486002)(5660300002)(478600001)(4326008)(2906002)(66556008)(66476007)(66946007)(8676002)(38100700002)(8936002)(38350700002)(52116002)(86362001)(1076003)(2616005)(186003)(41300700001)(6666004)(6512007)(6506007)(26005)(54906003)(83380400001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?40KhhuWdmOfIrDWY1DcpkgBY4mlwObM6Hu/qJbW7iSLifmDNKFceYDYEbVVC?=
 =?us-ascii?Q?ShfO3ZmznzZPSRVJYlFkI1zq2q2gTozTedFhj7vwGozwqKCJSflMctrd3UwH?=
 =?us-ascii?Q?+rkuSBm94b7Ch6ZUuJfvL0RN6k5LU7XHqv4VPaszfbfoqXxbP7cm02ygMCa0?=
 =?us-ascii?Q?5OJpBw6QsliIW5A/UQ//q+/PLwcZJUQt4/58oTnS6r2BIIL34rnZW0gwCJSg?=
 =?us-ascii?Q?CBeMnK7Mz0DQH22wiANIYC6phayk1OZpzB/XWDIhlqla9Yy/XYpV7cGUbC18?=
 =?us-ascii?Q?+9GpShqc2KG/G32ju6/JvwtN2PGFQ5grXHSY+GSMEKIY/ukA3UilGXgaLRIl?=
 =?us-ascii?Q?YsNMC8Kp3RylSbtrT0etfqbxcti5t7E8iXtnOe8ZrBPFqRnr7rl9C+s+4Lau?=
 =?us-ascii?Q?zQqcthHeBf8rDg3z9MkpR8LBnCedlPw/uTp9Eof3wQ3wPM6j+EHXbaud7IvX?=
 =?us-ascii?Q?7Kk0v0R8kgw1QCh9h2TN67zei7wtZKE/cR61vsNLQKaNY/Y5g3koXqTM2NJ7?=
 =?us-ascii?Q?rAR/zlznchXC6OwW0pxO/KlDxyFoB4XrocQHDJTMj/5fa3LweRJphihMkvzu?=
 =?us-ascii?Q?PfaoB0ekMkfHD3WCYxjju5To5GtmikZRJfQpBP7Ild4i6z6hasjdchl378fR?=
 =?us-ascii?Q?FApp8y2ZykTiuCYhdm16hqwEoJRCfivVLWfjWXGg0gvZvKgxCKmhDjaUgy8p?=
 =?us-ascii?Q?U/QaOUsPG6JE/BGgi7M7XnGEH2pEArhQchlm8Hon0HAfy3LAEOpLMAH1hDk9?=
 =?us-ascii?Q?4Tkw6L/12MkhMNjV7pSpmNcN/vmo/72lumK1DJ+X2FNUALuW48kMFXcbAfqT?=
 =?us-ascii?Q?nNQdRHqzkpE6/nMTMA0FOJhMb8ozyW655BWnCiyqraoS82LyHgmTQyBJj1fw?=
 =?us-ascii?Q?qeYHzHiObf7AfiMDQiTKj3Jr5FPkHTs/vb29qXKEC1e42axhszX91cOFCuVA?=
 =?us-ascii?Q?6J52cVbxTECnjCLYtk6o3NXb3cvBP5nv7grCGB58bOFh5bLK53tu7jzDLKkf?=
 =?us-ascii?Q?c/6hEPyI1yF83MQ3LudCYZJ3ACE+qZeFLd6LsXYBrsudMWW3/FS0H4eBGIHc?=
 =?us-ascii?Q?+8gDmSNlL6srk+vAut8x9lDDa/U9P84rYSP7p4zbYLmCB6xcpxWtdClchlCt?=
 =?us-ascii?Q?sN5tgyvQR+ZPS5p5AYd7BQFr4xgi1vhY1Jt3SkzZPKV6frg8vN3YHTxAIxHT?=
 =?us-ascii?Q?irSOCGZPK/HKScXftFeBT8V63IvouYOaV0nd6kBObii/wfvp/+0Kt0B5dTGh?=
 =?us-ascii?Q?ktfeJdataHe6xVYDUuVIOuYwBZ+Xck85YdILM9QQrv+e4OktdlwL0R78kfd7?=
 =?us-ascii?Q?SEEjwuKRWQ3Xos/P9GjCMOXmL64i+YWi+d6HFfX4FWEAbvtPokeNtIL2Imcp?=
 =?us-ascii?Q?7d9SQZFYICtz1fhcxTy8F7N6XwZ/W66TjKV7eNrwGFf6WVI792JaahoQpo6D?=
 =?us-ascii?Q?V1DTvaSox+CliJVWxtqcvKjTpTYxBLUQfbbYEF9819hpc8lJ7vw5wKXkG9yS?=
 =?us-ascii?Q?IC400FZf6KNUMl9Xp4keOCzfSIv1zR2ccZCg0w+rwKA2kIt72R5aDfRCA7mp?=
 =?us-ascii?Q?vl8pU4QyvMnPlEeDCyo7AT9fQKz1f2pAr0vsKgIM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f232f00c-f79f-44a0-6976-08da75358102
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 09:49:48.6825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 89ZZCYXynP6+HnYb2c2nn3JByL/Gp1Sj2jerLu9b6MX6892AGg4xkFLqOc3QNA1SZTaLpkr6fuUPFQOZrZJc4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2891
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add the GPIO clk, otherwise GPIO may not work if clk driver disable the
GPIO clk during kernel boot.

Fixes: ec8b5b5058ea ("arm64: dts: freescale: Add i.MX93 dtsi support")
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 7d812897aa38..37996a82bfe7 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -298,6 +298,9 @@ gpio2: gpio@43810080 {
 			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			clocks = <&clk IMX93_CLK_GPIO2_GATE>,
+				 <&clk IMX93_CLK_GPIO2_GATE>;
+			clock-names = "gpio", "port";
 			gpio-ranges = <&iomuxc 0 32 32>;
 		};
 
@@ -309,6 +312,9 @@ gpio3: gpio@43820080 {
 			interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			clocks = <&clk IMX93_CLK_GPIO3_GATE>,
+				 <&clk IMX93_CLK_GPIO3_GATE>;
+			clock-names = "gpio", "port";
 			gpio-ranges = <&iomuxc 0 64 32>;
 		};
 
@@ -320,6 +326,9 @@ gpio4: gpio@43830080 {
 			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			clocks = <&clk IMX93_CLK_GPIO4_GATE>,
+				 <&clk IMX93_CLK_GPIO4_GATE>;
+			clock-names = "gpio", "port";
 			gpio-ranges = <&iomuxc 0 96 32>;
 		};
 
@@ -331,6 +340,9 @@ gpio1: gpio@47400080 {
 			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			clocks = <&clk IMX93_CLK_GPIO1_GATE>,
+				 <&clk IMX93_CLK_GPIO1_GATE>;
+			clock-names = "gpio", "port";
 			gpio-ranges = <&iomuxc 0 0 32>;
 		};
 	};
-- 
2.25.1

