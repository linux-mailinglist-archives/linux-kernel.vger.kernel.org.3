Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793B55ADE01
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 05:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238206AbiIFD1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 23:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237510AbiIFD1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 23:27:07 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80055.outbound.protection.outlook.com [40.107.8.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B11563F0F;
        Mon,  5 Sep 2022 20:27:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dWruqTV9YsAtBBlUIzJbBDKhSs5MvxQgY07ktygLgONrI8dBcogOqz2faHdP7ZFekUwSH4LbXAnOIT7ZnmvresjUI3o7HkRVaR9PKx5jCiVUF1uuqYLDNBqef8mWMOiPTARpMTD92xKbkS+3m8yqMfIp/WSEAD7qTPPArUKA8tGah5CsST6ThRk4hbtaVe35XY41hpJxmL2ngAR0WCW+sAD+9fIUmkcgen3669t2citD10Z1E1eoDRde4pp5SNUeJesUArqlk/lvbSLlRwD8PNpkv5reJ9qw9026CVSadlFphrlW92BjTyZXDa/lM9HoaSPDbrbgltUxEGskinei9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iINQD28DzOkRmE/tAFH5kLwvRi/YffQp0vo5JEZarNM=;
 b=V8yY33LcHT7FZdEvafx5+wQNw0eOqhWf4rT5usJhzw/I2cHrZAjuuKSKHU3Nb2bqHeohZEOxWtOIo+2crRkzMqYz7KgFpdwHvJy9TQ/ybAKuBgEf5V4SYFshpRGQ0nfcwHGyUMpnY6drTr/eO1dAidAD01NJ+jty8zjRN1kzZbYj3Zxq7MQxj0r82qkQEXiDPW/2XcaGcuAt1BfQtJ405znEoD2ixD12GcQmTB6X+8n9FEtyTU3uCo7iv1SPq6z8R0tJvrPUQNehi9wJBUnEMDC10C0jaZprDHtJF3+VYLQtOkjySImgjrh6M1pwtaaPcbKFCmMRjoIxzieR1oBgCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iINQD28DzOkRmE/tAFH5kLwvRi/YffQp0vo5JEZarNM=;
 b=NLkyt34x9+ikwOVoSBCSbpp5Qg67dtwdQ5UVk1CZg4izRukLxDQyM1rUPydsfE0NJNcGRCvr3V1PwImFWXU91C5N5Mr4HO+MXTm2APt+PxwK03nMof2ztFOI8EiY7GRiVQbYdN+5FO9xrMu5sco9K1IH03dkkeLhf7+FsxcBtfU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR0402MB3714.eurprd04.prod.outlook.com (2603:10a6:208:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Tue, 6 Sep
 2022 03:27:02 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.017; Tue, 6 Sep 2022
 03:27:02 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V9 5/6] arm64: dts: imx93: add src node
Date:   Tue,  6 Sep 2022 11:28:16 +0800
Message-Id: <20220906032817.2090160-6-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 787bef09-aa08-4d3a-f620-08da8fb7aa16
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3714:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6r0e0+24UKeZdyHBaZb6M2slpKz937U/gf9JsHpHXq5sv5UQ+otSCA0jMYI4s5ml9PRZuel/V74EQCN1N/EQnJNuOr+0+YFw28tdt6MDGOiLFZTZnPRP/tbkK33Hdo+ooP5DK+KZL0paVXYwICFMK3NFXO3WU3loCOK0wtMPwdnzDsJDwTDeyuE5YUDLQWoN9vc5nQzL9jzE9lt+uhmT1SjgWvieOV3S2mi7VsdoULw72EiBKt6G4knuxbPsfSWR7KeEZmftlLZSMtkYN93uWCEklNlxF9TMzaVhMKCtfpvPZ01tjlz6AzVcFr1ocjZgktWxtUV2rbofLPc4PD1gwFByymkcn0iHwotomyvIGs0oYB4CukmblZmB+KvZGO7gg/uqO+CYwaWH7JxLk56JuqIhVFBGsysYnbXMSxXPtWUXWckd3vCN8r8PC18OUmxSBg8+aCXDeEcZ8OnikOIDCdwiTLeGCiisIoxqvSVrNjXFLafmoUzk+HumAnTOHtZgh7kIhhI5bYPMeSzy7zNNSs8lzoDuEn1BLWSwQtutlen/A5JRxWrAiy4Gj9G4tIGMuCEoU3drtQ9FmG/xyPqxXmHfDMFTmz5OStmqEGnS0JFaYQLWRmV7eO9jIXQ5kFLgGICqHM3Tr839T7oxvuNoOuyBlV20rAGAYZkTcu70tNKUJ2wmnobrmr6GkbVCvAXcs0mIHJE333a5tU8CEb7kUehUMUoDTgtyRwApN24BGDmg7FsWgzIT2JEncWYwcFdCIuzD+kVBpoxiyIK6G4LyDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(8676002)(4326008)(66476007)(66946007)(66556008)(2616005)(1076003)(38350700002)(38100700002)(6486002)(186003)(41300700001)(6512007)(6506007)(6666004)(52116002)(316002)(83380400001)(26005)(86362001)(8936002)(478600001)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B8L90ENcWtF4QyVOkevCGRlNuvJm4O8BIO1OdUhuwcMH5qqqUGqNSFkbOzMk?=
 =?us-ascii?Q?iiv8L+fMbsS1SPwkYFeHeisHKfttIZI/sHYY5FW6EKfWaPB6NnMfXXWTGG4p?=
 =?us-ascii?Q?UUldelO+d3KyGq5tWQZYXm/+heU1rEfS70gaRnZK3Jw+wfJqlHSVTOXPgH9y?=
 =?us-ascii?Q?zuOdUBUAZT3jUGe1dse28LliEdskaRvAzCducY6NGC286eArj1jHa7LWw0at?=
 =?us-ascii?Q?hIAV6X+Ep49ZXwuYHebniimBlltAfCNn1IAl0U17grjSRPnDyl5Bl4x2Hl04?=
 =?us-ascii?Q?8Cj6yjPzqVT2W6Om0GevvVZ0rIaLU0iKtXH+sMTGt9uWf+sH4s77mUo8VnpA?=
 =?us-ascii?Q?nbAfS90IQ7+WVoo2fBPVRS7Nr7GcIMCpYRjceLZyQgAlQ5u8ShdLZQYxZsGr?=
 =?us-ascii?Q?ZXXR6w/H0s6EIwWzNE84uxWful6DPo3r2e/rLxk2cm4sdPnYlGAVZGsy0kj+?=
 =?us-ascii?Q?knYL6nHvNNIKYp+WhvElk6gIoQXkkOXknUdHlEONA9ZiSBMwPTzQwRVtMkwf?=
 =?us-ascii?Q?a2QuXDZSp39L6HfmwvFqp7Pyaq6nQNCPuzqwWB8FL2L34VzrWjx/8LW3XSqx?=
 =?us-ascii?Q?INS8EkW9ZRRm6E7d+Q5eyQJoGBQA0VeOtdbhk4fdqhOgzbsB0qxILwP/TXpH?=
 =?us-ascii?Q?s+wL/rU6LFJ9ra/5mvvTqLgjgLUwXoFRdmvdgEbNPxMbBdNMV9zzJFKqR+Lr?=
 =?us-ascii?Q?BeGmzR7gNV0KEKpxX0DgsEBT118aai3qbn4cgkfRhDHoEhDjo9hsYC7s5Z8F?=
 =?us-ascii?Q?nu+vual+xrpqGDErJdvla2ycEni5S1LUuXktC2AlsWO4qJjGRm73Cj+Otjur?=
 =?us-ascii?Q?JLzY+7f+9viE2LOVNIYwhF6sTSGXT49aOw0SNo0qYJHxxLWS2P14JYLsEvbD?=
 =?us-ascii?Q?9D7Onuy/coG/A596zStbrZDEJfduWxalKZZbb9tQrT6xRI/CEyFWXG0mC+fN?=
 =?us-ascii?Q?7+kKL+TupmL0AIZMdFz6Vfb32Tzdn4L+4dms+/fX3xhUJa5OAIYl0f8k4ZVN?=
 =?us-ascii?Q?3IgSaH7Ia08cmW9t0sRi2cy868/hKVJ37fHH1AeUUAtGhgA3OblYi8mTGlGR?=
 =?us-ascii?Q?YDW3wIgpUu4HWb82L81lvJqO8yim0o0U6huvFhsCp/1CW3TIridDMXnVZ/UU?=
 =?us-ascii?Q?SaOjd254UrW9vpTeXf+hWrMmfNMFYtIUzXo0sHwoZ6YOyFy2joSwEbty75Ik?=
 =?us-ascii?Q?OhJmLJxtEUG5kr8f6efYWWvi/R4QLWi36Yld4JRGbDO3+kjIniBc2XkEivwi?=
 =?us-ascii?Q?Pdrx2BSov+w6o9L+0XRrAkJm1ugHJvemmL55tp+lM/VEg8gSMgGJsIa0t9re?=
 =?us-ascii?Q?b3BsosMqOydmjPLKX+srmSAGYHBb8oQ+VkB19xALk8TyOZTPs0S+cLabmDoU?=
 =?us-ascii?Q?6hzx9Ciph9KwPV2znFhqFajAFs1a4v2BZMG8grL6BHtl1XPys0TvfqdsuzGp?=
 =?us-ascii?Q?NXww300H70u3doVCeP32vGPB7pVGSMqdNtMgFFZGvB6oIFdtu2SFI6J6Pkqi?=
 =?us-ascii?Q?FCLhWB0DgtMHf7e/Uc028VrkdNC+X+QR+x5rTKeJBtF/naxnI2qoRNHSX6Y4?=
 =?us-ascii?Q?GfMLKTWvyqbc0snU+e5xxORsGviqntrtizU5roja?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 787bef09-aa08-4d3a-f620-08da8fb7aa16
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 03:27:02.3639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /INbqK2lpGtGBKZfsRPfzO8ulegDFQjMNiHZ6sjW4DZ5i+7c4TYD7A62KoIXqrn4mmCnU7ju3fuWQIds7sn+/g==
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

