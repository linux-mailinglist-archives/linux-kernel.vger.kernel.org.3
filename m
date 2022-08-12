Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C838590CCA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 09:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237516AbiHLHpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 03:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237566AbiHLHos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 03:44:48 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70051.outbound.protection.outlook.com [40.107.7.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A32EA6C1F;
        Fri, 12 Aug 2022 00:44:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WsvP8PzQb9sc0uht4KtaAwiqxl/wv0ALEnvuF8hx43SAVc566awbWBFEHo05H+0KH8F9TNhwAFSf40DHjALZ/iKyH0aEohuQk4+iAo5+CuBAG1iks0D1WFIv26Xb9jcRt3YeTYSGaPro39GTVS2az6Iou49KlxmuEt9xSczpEuQ+VCblTl/OptFM7Zwg4LjHV6/4yDEr34J6AitLWXU/d/jj9yP7c1xB3bnBNarj+EF8YF1Fj1t/KEeu0yJutE6HEzSB/FLyxTukkMhEtb7Xk8a2tY8Jzw5ImQTRl8Tn/mP4eKnNe6L/2A1/sAJq+5Oxd3MoWBJHLkeJFABNPnXKrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJgHxlx+oINKviLPDODGZJLIoFlVYSAARQA1N4UuQaw=;
 b=Z86TtLmTQgAX1hseVuibCI5XKTRxlOf1lrlBm/9sQYyZdUtWrVx8RhEf1JhCqqtAcMqI2xjGaiAGNH6wF40Yy5V1slcThgzdgM/4y8u2XZsie2MOulnBu1W42LEGvoUVqf5rkc/aB8ZKC10xm+zsxNPZX+GlpN3AOj6hOj80qgdrusJ5p5IilIoS3agaOKxwey5eDIWk/I1VwXUtFsLUgUqG0tKSqBVFVynGPVKaRyD6c0pisROF2Am7IJ47ktE7njkwjBR83srE491tNqzt2SHPrwpi2fFOFICdNMfErmbfdrj+GRjCdLP1PaehS19eruwiN4XmCxwbVss7vefxlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJgHxlx+oINKviLPDODGZJLIoFlVYSAARQA1N4UuQaw=;
 b=jIyFO1o630qSFfNthJLR5iwbEyt2FLUubJYStHoefFMnFj5GFBDCCc6hh4KfkRbqEhQkL9wYHdPf9OsITz5C/AdRh21qye6Te8zaSSLaSLTzcNkiCiCu9j5TleIne4oFBb5ZM7wCDb9rw8mQMC3wvXQlHgx9RalU9QNeNGEri4s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by HE1PR0402MB2922.eurprd04.prod.outlook.com (2603:10a6:3:d6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.24; Fri, 12 Aug
 2022 07:44:42 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5525.011; Fri, 12 Aug 2022
 07:44:42 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Ye Li <ye.li@nxp.com>, Jacky Bai <ping.bai@nxp.com>
Subject: [PATCH 3/7] arm64: dts: imx93: add s4 mu node
Date:   Fri, 12 Aug 2022 15:46:05 +0800
Message-Id: <20220812074609.53131-4-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: b7b32a2a-d34c-41af-aa01-08da7c3684bc
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2922:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0iA0LUPa99ed6Ngljhgdx7HZROqffbpdXrmaZptqETd9kE6DxZkvKHzd1N5w0eJYO1cM5SLGJouGHQvyC252/GtLa9URLYLfaMpjr6mrhqmbNM+6Sj7sJm8ywZrG6/GXKCbPpKLingVOF/3QzxygRMWwDAWrpw2tMNjl/F/hXNoMgFXFlcFpvdQRlMQqtdfhKDfa6kP1wS4RpWayEQT5a95IKbQwkE5LYYktuV5p6Kp8or10rgIE6EnspdrlfZteZVzm6ysMK52qtPIBcrfvi/DW5N6UbXYK0dhVP95r5oTRNaDSzFGLatpJL2zoPqRlcWBf9v9VfWYWXe5azSxI1zvau1vlVfDTrI510TMksci/FjCApSajNakyQq+yKdQETmRkymsMBRuIDjDcHBGGncIhCnmTCkJ2R5uHUYKXFZcQG+1DQ6G61MmjbhN1gG/yXCpXoK1vft+9/y0RXWKvcaNF0rprGW26jcWhEPbzhl+hSNhLd05quHfZ4YkhT7kejfQz3iiXPRXxvLk5VZ4OBAjNYWESftp/5Wd/BJHip1PXL6f9LFJ6YZ7DOo5Sju7MpOv6VOS3bd5dQCEvljaXu+ODwKA+YDwhmBwsahBqrtTZTDgbyLJWW0BbLWTF+8f/WJlPJDb1lN8h89lPqpNG3tzDXvIMAx/61O2qkBVERpXGR2V5DY/NwWy2eYz6MaQqrItvVWInIrppmnzvjR+2djpBjBi+gYDoVLTRj8q1f1cZuVaCijdoF5bX9wvImqt76acJhKN6J9BqDmxPH01S5M3jDPR3i69ud1U6qPDD6YuJYIGa85VOl395iEk6MbWB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(86362001)(4744005)(66556008)(8676002)(4326008)(66946007)(2906002)(66476007)(38350700002)(38100700002)(8936002)(316002)(52116002)(54906003)(1076003)(41300700001)(186003)(83380400001)(6506007)(2616005)(478600001)(6666004)(5660300002)(6486002)(6512007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2sa60/sln8LVqrL1ZzV0PCH8dUwn7hNJICLpv4qAdVCISkslwtL2f/k+Phet?=
 =?us-ascii?Q?X3Yenow0nLfi57q2yepJ6S46OyNY6FzTtRgLzeIbMiuwc8XeZ0z0zkJPbnhl?=
 =?us-ascii?Q?okIU1oe+TMDfJ8imJuNzOc760bY36UnCqN44g3PqRHNVshX5VzWwBPypQxDV?=
 =?us-ascii?Q?B2fTVAVBURaKY0aKDrLCZs0N7ay8nXLA2jpxPhDEq3ZmV4KvDp0o8rDZ+GFI?=
 =?us-ascii?Q?n1y/Gg8o/Ecps/9BDe5B0Bp0Iep9zjSYqOD0Uh5kWWkQwcIFT3jcwPDwr60w?=
 =?us-ascii?Q?yA9R3MZYfPzE83lQEpuogOVCC3WDl1Xa/o7d9poNsGd5Rc3F6lq+2o4pKwPB?=
 =?us-ascii?Q?4SkEUH3SbW2TnlMQreTwJHR5OsyIAhYNvHgS1IuA96edB7cTpVSmCQsk9uvx?=
 =?us-ascii?Q?Y1x+Rvr7A0QSR2whNnpyvDCdAriNOb/ILe9+xHfX5kCPzhhnQY4y8qRziXGQ?=
 =?us-ascii?Q?O4OqLUa/hb8eijXIsFtmQRDsHT9XQF3RjmdAEjB4Tvq2SG/XnBPMbDB+fQUh?=
 =?us-ascii?Q?alcjJmG6u+luBqiamqryLWjNiziYcJeQKhzuYqzRkjTVdgA6lABjsQgPORxX?=
 =?us-ascii?Q?sr6kfk4i4aAmK857klSg4lsf0j9GxTlx4uJx1IcG345mr/oPKeg8mGHBn19F?=
 =?us-ascii?Q?LJ67yrrF+RUNiJy7WUVP09++k9yytwu/LfYFCUamzb0+Rn9SoRTTFCTLjoMW?=
 =?us-ascii?Q?61LgpKDQZV3L0hjcJ+s8Aa9+Ess+2oYgY/c7kq64XYtDURqOF7aISDGdh6t+?=
 =?us-ascii?Q?ZOnlWQD1/0eKnaqUWmkykutC9OhmYrVcQqvpQfUdsmPqpZTi5ilnCWScZhQv?=
 =?us-ascii?Q?97YplWdXxw8Ej8WOy3ZcMSpL6L1SR1LSb8NUSZvPCTA6Mzwm3Ztr68+EPUKi?=
 =?us-ascii?Q?KDT/FLMOjEouFPNOXpB+T2nc1No+9NYWKxvyPVdsbL24MEN4CaPrh710GUf5?=
 =?us-ascii?Q?z8hM30ilaAhLou/FM69a0N22HIb40Auvhk8zus46A2L3bJ6iWQJA4WRvuyjH?=
 =?us-ascii?Q?0vjIpk9VbQ4fEKhoYF9T2iiNOUrpxE3fW4o+tMUp3B+hFD2JvmEMBWMJbTt7?=
 =?us-ascii?Q?7spooH8mF0HDwiB8nr2S6tB6Xc0vipqeEpX/7BwNi6Jeq7Lwgepx7hCVi+fp?=
 =?us-ascii?Q?B8DckKawU8K/rsStSY1ViuMMucJIV5D/7a+i3Q2ahIVbwR7PYHFSzFije+ev?=
 =?us-ascii?Q?5zO6tg2eGka84ex0qQAdw+ANSnO/yEAXeVdL3GbwveI8ip5Y3ojgxpqbVMi7?=
 =?us-ascii?Q?Rt38Z0J16N4EWuXabqb1Rxd8Xtpg8uU69jncowjspdrKKl45R7Pn0B3nq7DH?=
 =?us-ascii?Q?Jj+DegD6DXZK4ilcnWXSVWjwMTK/n6e/RPtkiDs4r1A+cQBwtvfOJ6uHF5Q+?=
 =?us-ascii?Q?9xMciLkCH7EbIBEM1VCsmk9BQkcp1/6P/TDCiaMuxyzvdYdRbts6fJ+WKq1p?=
 =?us-ascii?Q?pZvFijMdv5a5Y7d9a9gMRCkKET7HT1g6dUbppNnNnyvxAJozIQpUlHc4EVDa?=
 =?us-ascii?Q?Pe/z8Dtgf0NoNQxCnCD5DyhppVksFolXAYsty6ZKwxrxT2Iw7v2SHrzrdPON?=
 =?us-ascii?Q?BFDWOEzkev8k8Cf05JapPCyLPxhaj6Wu9/7JKzzP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b32a2a-d34c-41af-aa01-08da7c3684bc
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 07:44:42.6193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oXGq032gKPlJEsFHYspJ50M6oHYneuJKpruwYpX01qAk660jibdg4YKQeez2tY3aoOsY96c13H2OT4XNa7RxIg==
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

Add s4 mu node for sentinel communication

Reviewed-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 26d5ce4a5f2c..dd76472ced46 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -342,5 +342,15 @@ gpio1: gpio@47400080 {
 			clock-names = "gpio", "port";
 			gpio-ranges = <&iomuxc 0 0 32>;
 		};
+
+		s4muap: mailbox@47520000 {
+			compatible = "fsl,imx93-mu-s4";
+			reg = <0x47520000 0x10000>;
+			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "txirq", "rxirq";
+			#mbox-cells = <2>;
+			status = "okay";
+		};
 	};
 };
-- 
2.37.1

