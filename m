Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9DD4E219E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 08:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239080AbiCUH42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 03:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345060AbiCUH4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 03:56:19 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130040.outbound.protection.outlook.com [40.107.13.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70342167DD;
        Mon, 21 Mar 2022 00:54:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7oKutP4tw0W91+0leEV5xMhlO2le9uhvn95GO6ugK1K7DK3+LFy3j3z0onSpIGRcXDj67hiolw2M11sPNhZH9RIa56jyqvx2epHEUtc99/+wPnvC4MyQWNuPd/hhh4DlktijDN7XwMXTNw8+5phD2KQYBDyngBhtqzmLifMHjBhKLzghoJ9J1bBri8pIZPMZYYkNie+7CXaA5RB0gdw33Wibmrh4XkZiMQiBQHfJnFNJPuojornvMrkUZjyzv7Nity5WB4n47N47g9S3VJcfQ4HXEbWYwKFdVxyLG9znsfDYDnPkb4YabSG9LDj7Ino6qFhyKOXiGlqq4/Gkt5rLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+SDGOfgnfjMyO9l7GDGlKbOerEEDkiHgyuDEeZXUJ0=;
 b=R8LwPt9LjYlokiwgVH7OB200AsHkBnSd0+n9KJPAofFoRarF8JebJhqyC64r95q7ZnUX3wxdWgP98Q5DsfEEo9sP9cJffsEkH/k0WrebzYWOZUV0Lc8O9MRh0tYBha1PnTwESmKRH/4QJ7wwAnH5YFip/LqOltEpwlyQf+2b73oLiu7BgC+H8SOXINEIj9GyEn9Yusk3S0yz5sbfljK8LSx50TyS4L4cARDS0JJYFNjJzRZHr4yTQa1P1qv9+Ar/CCRTzQtnY0zEFu8/aZI4iXpzzbca5V4nHEzKyCVdkPNkE3gynMvBKSlWAuLt739+SA7uDhp0ns19IU65m2NFlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+SDGOfgnfjMyO9l7GDGlKbOerEEDkiHgyuDEeZXUJ0=;
 b=YMr9ktIro2XI/ignGazxEHeDps/BwXDgrLJ46VBKPEdWC2xQD6vw3ha93q+pNLjiXzAg3VJnAjxQG7JxKpr3bBne+MMqljf5eZg0cFqg/OZfAEFjbeDyMYN/DWYBh6XY9Jr211DhlGItdP0eSP9uadeKEJDrMh0wMRANuQzo2jE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by DB7PR04MB4204.eurprd04.prod.outlook.com (2603:10a6:5:22::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.22; Mon, 21 Mar
 2022 07:54:52 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::6972:1f59:5d1c:e557]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::6972:1f59:5d1c:e557%5]) with mapi id 15.20.5081.022; Mon, 21 Mar 2022
 07:54:51 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     robh+dt@kernel.org, krzk+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, manish.narani@xilinx.com,
        michal.simek@xilinx.com, dinguyen@kernel.org, bp@suse.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH V2 2/2] arm64: dts: imx8mp: add ddr controller node to support EDAC on imx8mp
Date:   Mon, 21 Mar 2022 15:51:31 +0800
Message-Id: <20220321075131.17811-3-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220321075131.17811-1-sherry.sun@nxp.com>
References: <20220321075131.17811-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0104.apcprd02.prod.outlook.com
 (2603:1096:4:92::20) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 883bba6b-90fb-4b36-1218-08da0b101461
X-MS-TrafficTypeDiagnostic: DB7PR04MB4204:EE_
X-Microsoft-Antispam-PRVS: <DB7PR04MB4204C6D7347560548578DFAF92169@DB7PR04MB4204.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jm3K1PNSvn7oBmKE5rMMl3QvCw34hUm1HMkE+rorFJ+l3Z9iouairaMec1dIpLgbkjL4THShT9jk3vJIpRG5Ui6j/zgPLLOKyAqLQgg5/RCSD5xUOhinY4JwjbU/1x+fojI1ddwRd6hgKOYTlPpAMPAUzCgyv+GW2Dhks4co7N5a6vHVra1khWq5d3R3RwuNBMHqEaeP5ZeVNDgfIIC1oYMEe6ipcze7wymnxdwbOfIUDuEifjP0Fovv6i2jENnORObzuedlBFybmG8juL64d40IoF3xQy9I6GMs7kx7JhLAGymqWdyB5Lho1owyj4xQm0ghcbFa8P96ZUu3JASGs9FDKW9o+tOJlb4yKrqg24uD86bSA26pIRx26DlCE5JroYe0KD9r4DdryP8TS8U+iy8A3qMVxjef0OHJDsac+fJBmMOS6dXzTP64T3OokmlOWkaQleN4N0/Tq8V4WvgpOUREPkTahbjdlsl3XsleszoNmmgxAbDOSM18lBggcwqUHTqZIbH/SpWVZ1ln7Efb/dJitV4zlp7GB0IBROowilUy4CVMU5e1U0uFb6PKbS1DB+Rou5XojtiVidMVbimCjKxCEOKtju6ZIRmkUmdiU4U8X0cnZ/kf4kp/Vy50FW2L4TEP0RXdGPaiqc0frZFWvlxY4/I71wwHhgMx227YGZWgJ+j/6BKIJtzxvVJrNEt1GbdWTVaRzs/p1VTU8HqAhMSRjM3K+Rqsqwr/JlE4jxU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(186003)(8676002)(6486002)(2906002)(26005)(7416002)(4744005)(316002)(6666004)(44832011)(38100700002)(38350700002)(508600001)(4326008)(1076003)(86362001)(36756003)(5660300002)(66476007)(66556008)(66946007)(52116002)(2616005)(6512007)(6506007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M8gGpg2VUOgr66jJc2cF3OzHSO7g7GW+rfmA0vzUy4mM5P3KQNXg2MuMSWSI?=
 =?us-ascii?Q?zvQK6q9yEeMxx3SxuQwZ21qmjhIGW/E3rnoFXA0n6P/oAQkWfVK2Ij7PB75H?=
 =?us-ascii?Q?M+kvX7df3YI/dpij1/8UuSb8zbzglY1i1o2Nt9drULwIhctEE4L+uqnmRkK2?=
 =?us-ascii?Q?YsJ83JxzMidfHJjkfegpgcVcqTT1znghVk7ACNKqDmym2WM3RhZ8/7aA5nI8?=
 =?us-ascii?Q?Ic1z5RgismavHAkLkkMjGNdId3BV1o0E5adisCkxKDu1ogwyTlPLG4HNR4oL?=
 =?us-ascii?Q?Jr94Kyawq91aYY4s9CNC4ckPNmR2PqlQeYp8tA1l2jncVzlC7AoGHknHIy5c?=
 =?us-ascii?Q?0s0vo6k8DUqqvgSl9eLMtbG9RL73Qr+rcUCdnqyJ32QdeaYwypTE/knF6XOK?=
 =?us-ascii?Q?UqjOimKBhIjwWpnbafu96fNRZjf9vRJTXJcsmJgAAr3skV2PIcTDz7yWSdxq?=
 =?us-ascii?Q?xpyO86qo1A7wlHzjubrQHslP6WP5VHYEchfqX4Awf3VqDvz0IGqi3JN+2LXV?=
 =?us-ascii?Q?RTY9ts1Bo21Yw/hBrf6tbH1ucDnlmYdpIrfACm4KZ9Ki+1Ti1kitcNQW3G7e?=
 =?us-ascii?Q?r4dSQtZeP7ZgI1Qw8JxHFqSdLjGEMBs07uobWHDD6QsBWoKlIYQQNvFGoCBV?=
 =?us-ascii?Q?TJwhHsh6TsSxWVuYyXEefAqhD16sPA4H4xVoM6zu8XH5vSEVuRPY3ul9Rcge?=
 =?us-ascii?Q?QjodH/Sk7buhT3ZYumZt+dH5XNaUaNmCJrFDd+oKDHPqzcsemiLF/ky1g/XJ?=
 =?us-ascii?Q?o8qYiXSvhWg7LFuBPlQbsqbBg2dkjtt61e8Wm+zK6qZ+vFjzyuA+vc3dHh+b?=
 =?us-ascii?Q?jwS/hzk8VEGsLvUG21wasfhIFCBzHcvBygjDnJ8+Q123qa3PifzScxJZ/J/g?=
 =?us-ascii?Q?y8CdxIHsQ5N2VHNG8fgSgY2DBH2WpgC6dMWZUsdwaRA2x6480mewpUuvOd0o?=
 =?us-ascii?Q?6VtID5j1ISiQR148jrUwBgc7kGlgQin3BSVlW0kNe2tieEDDJ6odKcXf8p/v?=
 =?us-ascii?Q?3exR61TWZtWkpdf7Yo6mkyinP/bqGrguAuyFHRvd5aYXmZRcScIUe9JLdNsp?=
 =?us-ascii?Q?B6Sl+DZ1nilfqHmHgW0mSjiR9CgVZg5MWtcP2kzcP2e59opWgoIsCIcSI7Wg?=
 =?us-ascii?Q?AfGg4n0YHJc3LGtJZlC3PywrVvIVffPVG21OaDhMayiOun1ElxNwqHsOonZX?=
 =?us-ascii?Q?V5EhB4GIFfuQ9iALNuoVpaSMTnqivYkP9RbM8pItxQKyywVLnl7UOCYcFs8U?=
 =?us-ascii?Q?eszQDfSXbtd6qSjPGNh/jCHOYJaNg55rYT6Hf+dZ9U9x61eCF9KGFR5XTiWR?=
 =?us-ascii?Q?PPqNpTQkkVO1eySZYcOHXTXjby8WNRH7w+9RTs3tIvfCejP34kYHkXXKHf3g?=
 =?us-ascii?Q?Vj6evlXM6Xqjd+fRt36bATF85rxhqbqacS0IzCZU944NIgNDe4Mmd6dg99UB?=
 =?us-ascii?Q?9h8HDVWf49SqgMZJRmd2pSAUI4FvzhMq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 883bba6b-90fb-4b36-1218-08da0b101461
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 07:54:51.8915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +IL0dZdmK9JtzTDoFI7l3Q0QK6Yf2UybYPtiEd48Na+Y75pOAPHe9hDij4AeeuT7Ps8Q7Y16YS9zov1LyP7wEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4204
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX8MP use synopsys V3.70a ddr controller IP, so add edac support
for i.MX8MP based on "snps,ddrc-3.80a" synopsys edac driver.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 3f8703f3ba5b..f39da2b12ddc 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -902,6 +902,12 @@
 			interrupt-parent = <&gic>;
 		};
 
+		edacmc: memory-controller@3d400000 {
+			compatible = "snps,ddrc-3.80a";
+			reg = <0x3d400000 0x400000>;
+			interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		ddr-pmu@3d800000 {
 			compatible = "fsl,imx8mp-ddr-pmu", "fsl,imx8m-ddr-pmu";
 			reg = <0x3d800000 0x400000>;
-- 
2.17.1

