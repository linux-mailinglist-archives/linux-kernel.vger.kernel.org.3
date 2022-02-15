Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11AC4B65E7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 09:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235396AbiBOIUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 03:20:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235376AbiBOIUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 03:20:02 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70044.outbound.protection.outlook.com [40.107.7.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EA79BBB0;
        Tue, 15 Feb 2022 00:19:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+S7VRXAwa6sKwKbXXgutRLsm1pKdlgCwqtBBx250jRc81D15VcYzHw6cJ0YrrR+elBJlsODbyzXiQ1wq4wDdYmdjspkQ4oUFdDqZk7fNUA5TJQsLzRuC4QXwxOg1eaV8lkSIsb18q2c3c8bmmtEB1ZelgY6TIOvCiyxa7KI4CPne7eu796ZO53KoX+sLqfFTwDPmhF0GIPi5qUUe4quAfoTQD/GpO4GATgX239Z4Q9rpae1O5xwINRK+Ka3AsV0vUlnsKnmrss9yscCxexG4wNU9+zrE8XdLh07EXpwHjrvg1l1V7OlnoNslcvB9OLRhfZ9Dud9DdsiMO7Ss0npOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXItFWMuMrVqTwjazPRaPuFLO5XG8JYnc41M8qHOPqk=;
 b=bkP+KI5P5ExQbMJm+jtV1sqVOoXBP6zKNdiAK5jRAxrl5rRuHI0/H8oAnf0A0jFNSa7iJ9BB/UFtFwk6WFmZiWnzM8F3yWVkFtWVyI4MoNcLaWAfbOtHUsvZ2kKMIK8VZzE7fp//0CC0p9PETuLLg2RLWPsRtJ2KpwcYuA9JytMyBzHsXDycIfwjpdnofFp0fcI09/lz43XIuwuEj/S/+DFyF45vugcdukrEEXvDoJewT2g6qbM6nmtSXhwYhCK0NlFvzCV3Y1cnO+UF6HO6yKhDGvBYKw/3hM63BlP1MpSEF6EdGeuq3BD6D5Wda+Hi1/zgb/K8U1AdbRO1y86RRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXItFWMuMrVqTwjazPRaPuFLO5XG8JYnc41M8qHOPqk=;
 b=BgxSc06P1JVqMk6HMokxU0wHxx9LeF8WWC7C8bn+7ixdsRmrctvCufxEBY/OXNI2xkTEgALHhlEbyIK4azkAY4nDyEO4xSfzFCJoA61n7r9HC+mW5OR48DeQXTPE9ZekK8CN8eHUF1S0UdXiLbbr5jX/qAXxHE308mPH7d8+MU0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB5940.eurprd04.prod.outlook.com (2603:10a6:208:117::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Tue, 15 Feb
 2022 08:19:47 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::448c:19d:ca9a:123e]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::448c:19d:ca9a:123e%7]) with mapi id 15.20.4975.018; Tue, 15 Feb 2022
 08:19:47 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 4/4] clk: imx: add i.MX93 clk
Date:   Tue, 15 Feb 2022 16:18:35 +0800
Message-Id: <20220215081835.790311-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220215081835.790311-1-peng.fan@oss.nxp.com>
References: <20220215081835.790311-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0026.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 011f10be-f3ac-471a-8c07-08d9f05bedd7
X-MS-TrafficTypeDiagnostic: AM0PR04MB5940:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB59409CE4D3A50D7BDF7A4F60C9349@AM0PR04MB5940.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wJ2ZtOTJkfFHgmi/tgZ5d9pQkvaVAWUSsMo5/tnsQxkBj8HNP+zosxZ7pqEWIBnR0swLUUUa1wAy6DwdPSxcXH8n2oMVWzdlwVbviVw2iLcMhtnu1iIU8V1gJHZJb0fONU13qpoKJq+k9eEj/RfaxfsNccil1ix3gLXjyvAM22NxxQew7AfluOAJ1tmXqmk/bGezy1jZ79B7vCafjQJx0abLbk+6D6EL8etZmkyy7EiCpWwgy7Jx6ay+dP6kfQzNtqH1LwL6OjNvK+YJTvSU3tHoDvI8pYLS75CXUyw/AtxH0m2r+x+yfNIOstub2XRfYOH0Ow2Fd7reInqORyCa8Mp5AAp0OzdJ6mchFo1YJHLnW0rU6mdp/ht1FxqmUX+j+uz8o48sLDuHSizBLI+kkOw0Jss4dBwfSn4FL1DUGw8xqpGSxaO5EFSxdPysRvArld7KK9A62sTmRAH22aMDkU2ty7Iw9gqZTOqeg+t7d5fSkeaproNuxzZOgMoaTDWdJC1Ge9pp/Y48vwUIxIl86VcBE1T0RfK9MkteDOYxAnhqSyb4zVp37qgw+L/DeMWacowQd8ngfkSU+xeKa9bYEXhYsex4t12hT8Litilk3VvjHaVDrhlgAByjnbu6L6jh6jTOlsNAoRL/MyHXij8fSCxlC+V34VqW36rMz9J/mjAuzYf+OHHFdes3XRGqdRPjy3tUO8unkByCoaZiHxj6IA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(186003)(6486002)(26005)(83380400001)(5660300002)(1076003)(508600001)(86362001)(30864003)(2616005)(6666004)(2906002)(38100700002)(66946007)(66556008)(8936002)(66476007)(4326008)(7416002)(6512007)(52116002)(8676002)(6506007)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hgwRisT/c6xSCfQjX1od3tjySkorXcA3EAWZvVF75IweLaV6i3U9+Wj1fE6A?=
 =?us-ascii?Q?79LKiYkBQPrcUAFfsTfk/z8I63nt+zQo/W1pRW8BuQSqQsPAcuPD+x34BbVM?=
 =?us-ascii?Q?RaCY2tCMQGt7sdYA1tWNDxFtjX0EfEIARVv6i571M8fNbw6BetYOumioCrGR?=
 =?us-ascii?Q?/RQaelrj+fsAyo3D19Q22jHh0TduTVnvI6wjbvi30niBowzAgq4GiDwm/7z8?=
 =?us-ascii?Q?7nrEKdD9ffF1VJ7jT4+TR8X72GSKTbLGDWMEApm3lBlnDobyHiooWcw8KkhT?=
 =?us-ascii?Q?/liVQRh4Q8OxQEd9jcsffkdxmjHgtJjcouRo5CpIvdY2YzVakdEGwjiyD1Tl?=
 =?us-ascii?Q?2xh4+s6IEod7jDsEY+bY6XDEiY9Wlhu5rhUuhPmG0qKO4/odM35YznYn0u6B?=
 =?us-ascii?Q?lUiJ9EYSXUpI6oC+UX5GVLNQKFf2mlVI7CeRER6AJgHmzuLBCQWcGNzBj7Ay?=
 =?us-ascii?Q?Ko5E5HHzZIrT6V4/q9oH/XEYWnRTkupUUtCNYfxDDTO6LLd1fPq76Bwr+CPW?=
 =?us-ascii?Q?YLkcNnj8vzY6csrwhtgJ4bOoACfrV8B0MIsdwX7gmYzHuGk1gU8TqGPG/pPy?=
 =?us-ascii?Q?5I2RZsCImBjfm0bptLbP+Qddf1o0yvfRVEDHD2hbGqMaB6o4O/JT96N1i5Gz?=
 =?us-ascii?Q?CaYm8VAocQWHhLDU2HcuAiUPuhrfkpEHYVg8J2t6MHWvE0k8tci7PmmULWPK?=
 =?us-ascii?Q?I61WR7gRI8HSQs32GqVLFC2uur5QH3ajdaYko8jm0Ae9qfwAhoyzjf2iv9sM?=
 =?us-ascii?Q?DLZLQJ4cUe2afbuzgshMMK5B8iM1tabMq/yHP5xQSLXS+B4/9AOSGE97ibQB?=
 =?us-ascii?Q?gIQJfqbQXG7espuQ6svSLeBvjt0CuTMo2L8hOfqAzHxncG9H/U3zMf1GtV6r?=
 =?us-ascii?Q?LffNmtfqN2PKWl3whNFiyIxC1HCp/Rkl3H2KKpUsfK6whZ3tx+sJWsNndmY2?=
 =?us-ascii?Q?ZDZ9WVZlnWawu2oitHdHYXxkVy2w3M/oGa4XY5l4QUu2iGp76108+1nKEmql?=
 =?us-ascii?Q?jdomZYIuLRcmq03tBK95Nesyzx1LSSUFy/Y9jC+/IsmLrHsS/6vReX1rULqd?=
 =?us-ascii?Q?IpID8f59tc758zFYtn4pnBNVPGRZr4VLRnIuWnzVJMCWlJV8URAc169iSrZ9?=
 =?us-ascii?Q?kJEPa5+4Ol5ZJb+6eJT2SBz88ko5eT5EsC7taE/gIOTXfhmn64kwPLTEJ1p4?=
 =?us-ascii?Q?7kzvgcWU3RIyb4+Iolx0HvffOvwDYuigblVqMfIb4XwTRU0RviFq0gobbCEO?=
 =?us-ascii?Q?l2qljV3lY2U7iY2xiGVpb9rebZonHsuJS0DUFxylPNtIVMfecVxZ58l+oOGQ?=
 =?us-ascii?Q?tt1nAUffWspECOt8tfTQS8gjYNbmU/aVLRUzE4tXbq2jKkbuUoT2iveKV7n2?=
 =?us-ascii?Q?Yh7b+DnHbC8Ke4NZEDNT25IJzvDDQ969Ov/iitcAjVrwKTUoPFkVBB0Qolod?=
 =?us-ascii?Q?ef4QbTvVPm/hQJcEmQ8L152tUGDRw2F+b/iItXK84uO9oQqXTQMIVudJwh4h?=
 =?us-ascii?Q?01p12FDjfg1aZd5MRVme3abejG3WPId/3VdImrgAoAsiqAyecHFqvAIzfJPv?=
 =?us-ascii?Q?gbXIjZic71xQTFQCSGiYVV7sK0ukjGk33IxwgQ3oAC7BPjNPeMkZG+o+cDRw?=
 =?us-ascii?Q?UNC/StxrxaIy9BESI+/yDxI=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 011f10be-f3ac-471a-8c07-08d9f05bedd7
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 08:19:47.5620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oq1Kss1W59hlHDD0LumSAly+tI26YUgQ8Ofb8GjriV/oHyB5rQZhywXtoMqxD/UFsnnkVmFqpNqrz3ceUyPqWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5940
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Note: This is based on uncompleted information including the composite
clk. Just build pass, not verified.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/Kconfig     |   6 +
 drivers/clk/imx/Makefile    |   2 +
 drivers/clk/imx/clk-imx93.c | 338 ++++++++++++++++++++++++++++++++++++
 3 files changed, 346 insertions(+)
 create mode 100644 drivers/clk/imx/clk-imx93.c

diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
index c08edbd04d22..80a16c60b68f 100644
--- a/drivers/clk/imx/Kconfig
+++ b/drivers/clk/imx/Kconfig
@@ -105,3 +105,9 @@ config CLK_IMX8ULP
 	select MXC_CLK
 	help
 	    Build the driver for i.MX8ULP CCM Clock Driver
+
+config CLK_IMX93
+	tristate "IMX93 CCM Clock Driver"
+	depends on ARCH_MXC || COMPILE_TEST
+	help
+	    Build the driver for i.MX93 CCM Clock Driver
diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 717a33c7ed50..66914437813e 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -28,6 +28,8 @@ obj-$(CONFIG_CLK_IMX8MN) += clk-imx8mn.o
 obj-$(CONFIG_CLK_IMX8MP) += clk-imx8mp.o
 obj-$(CONFIG_CLK_IMX8MQ) += clk-imx8mq.o
 
+obj-$(CONFIG_CLK_IMX93) += clk-imx93.o
+
 obj-$(CONFIG_MXC_CLK_SCU) += clk-imx-scu.o clk-imx-lpcg-scu.o
 clk-imx-scu-$(CONFIG_CLK_IMX8QXP) += clk-scu.o clk-imx8qxp.o \
 				     clk-imx8qxp-rsrc.o clk-imx8qm-rsrc.o
diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
new file mode 100644
index 000000000000..7cd5e7fb0c8b
--- /dev/null
+++ b/drivers/clk/imx/clk-imx93.c
@@ -0,0 +1,338 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2021 NXP.
+ */
+
+#include <dt-bindings/clock/imx93-clock.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/debugfs.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+#include "clk.h"
+
+enum clk_sel {
+	LOW_SPEED_IO_SEL,
+	NON_IO_SEL,
+	FAST_SEL,
+	AUDIO_SEL,
+	VIDEO_SEL,
+	TPM_SEL,
+	CKO1_SEL,
+	CKO2_SEL,
+	MISC_SEL,
+	MAX_SEL
+};
+
+static const char *parent_names[MAX_SEL][4] = {
+	{"osc_24m", "sys_pll_pfd0_div2", "sys_pll_pfd1_div2", "video_pll"},
+	{"osc_24m", "sys_pll_pfd0_div2", "sys_pll_pfd1_div2", "sys_pll_pfd2_div2"},
+	{"osc_24m", "sys_pll_pfd0", "sys_pll_pfd1", "sys_pll_pfd2"},
+	{"osc_24m", "audio_pll", "video_pll", "clk_ext1"},
+	{"osc_24m", "audio_pll", "video_pll", "sys_pll_pfd0"},
+	{"osc_24m", "sys_pll_pfd0", "audio_pll", "clk_ext1"},
+	{"osc_24m", "sys_pll_pfd0", "sys_pll_pfd1", "audio_pll"},
+	{"osc_24m", "sys_pll_pfd0", "sys_pll_pfd1", "video_pll"},
+	{"osc_24m", "audio_pll", "video_pll", "sys_pll_pfd2"},
+};
+
+struct imx93_clk_root {
+	u32 clk;
+	char *name;
+	u32 off;
+	enum clk_sel sel;
+	unsigned long flags;
+} root_array[] = {
+	{ IMX93_CLK_A55_PERIPH,		"a55_periph_root",	0x0000,	FAST_SEL, CLK_IS_CRITICAL },
+	{ IMX93_CLK_A55_MTR_BUS,	"a55_mtr_bus_root",	0x0080,	LOW_SPEED_IO_SEL, CLK_IS_CRITICAL },
+	{ IMX93_CLK_A55,		"a55_root",		0x0100,	FAST_SEL, CLK_IS_CRITICAL },
+	{ IMX93_CLK_M33,		"m33_root",		0x0180,	LOW_SPEED_IO_SEL, CLK_IS_CRITICAL },
+	{ IMX93_CLK_BUS_WAKEUP,		"bus_wakeup_root",	0x0280,	LOW_SPEED_IO_SEL, CLK_IS_CRITICAL },
+	{ IMX93_CLK_BUS_AON,		"bus_aon_root",		0x0300,	LOW_SPEED_IO_SEL, CLK_IS_CRITICAL },
+	{ IMX93_CLK_WAKEUP_AXI,		"wakeup_axi_root",	0x0380,	FAST_SEL, CLK_IS_CRITICAL },
+	{ IMX93_CLK_SWO_TRACE,		"swo_trace_root",	0x0400,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_M33_SYSTICK,	"m33_systick_root",	0x0480,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_FLEXIO1,		"flexio1_root",		0x0500,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_FLEXIO2,		"flexio2_root",		0x0580,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_LPIT1,		"lpit1_root",		0x0600,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_LPIT2,		"lpit2_root",		0x0680,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_LPTMR1,		"lptmr1_root",		0x0700,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_LPTMR2,		"lptmr2_root",		0x0780,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_TPM1,		"tpm1_root",		0x0800,	TPM_SEL, },
+	{ IMX93_CLK_TPM2,		"tpm2_root",		0x0880,	TPM_SEL, },
+	{ IMX93_CLK_TPM3,		"tpm3_root",		0x0900,	TPM_SEL, },
+	{ IMX93_CLK_TPM4,		"tpm4_root",		0x0980,	TPM_SEL, },
+	{ IMX93_CLK_TPM5,		"tpm5_root",		0x0a00,	TPM_SEL, },
+	{ IMX93_CLK_TPM6,		"tpm6_root",		0x0a80,	TPM_SEL, },
+	{ IMX93_CLK_FLEXSPI1,		"flexspi1_root",	0x0b00,	FAST_SEL, },
+	{ IMX93_CLK_CAN1,		"can1_root",		0x0b80,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_CAN2,		"can2_root",		0x0c00,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_LPUART1,		"lpuart1_root",		0x0c80,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_LPUART2,		"lpuart2_root",		0x0d00,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_LPUART3,		"lpuart3_root",		0x0d80,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_LPUART4,		"lpuart4_root",		0x0e00,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_LPUART5,		"lpuart5_root",		0x0e80,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_LPUART6,		"lpuart6_root",		0x0f00,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_LPUART7,		"lpuart7_root",		0x0f80,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_LPUART8,		"lpuart8_root",		0x1000,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_LPI2C1,		"lpi2c1_root",		0x1080,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_LPI2C2,		"lpi2c2_root",		0x1100,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_LPI2C3,		"lpi2c3_root",		0x1180,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_LPI2C4,		"lpi2c4_root",		0x1200,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_LPI2C5,		"lpi2c5_root",		0x1280,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_LPI2C6,		"lpi2c6_root",		0x1300,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_LPI2C7,		"lpi2c7_root",		0x1380,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_LPI2C8,		"lpi2c8_root",		0x1400,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_LPSPI1,		"lpspi1_root",		0x1480,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_LPSPI2,		"lpspi2_root",		0x1500,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_LPSPI3,		"lpspi3_root",		0x1580,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_LPSPI4,		"lpspi4_root",		0x1600,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_LPSPI5,		"lpspi5_root",		0x1680,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_LPSPI6,		"lpspi6_root",		0x1700,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_LPSPI7,		"lpspi7_root",		0x1780,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_LPSPI8,		"lpspi8_root",		0x1800,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_I3C1,		"i3c1_root",		0x1880,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_I3C2,		"i3c2_root",		0x1900,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_USDHC1,		"usdhc1_root",		0x1980,	FAST_SEL, },
+	{ IMX93_CLK_USDHC2,		"usdhc2_root",		0x1a00,	FAST_SEL, },
+	{ IMX93_CLK_USDHC3,		"usdhc3_root",		0x1a80,	FAST_SEL, },
+	{ IMX93_CLK_SAI1,		"sai1_root",		0x1b00,	AUDIO_SEL, },
+	{ IMX93_CLK_SAI2,		"sai2_root",		0x1b80,	AUDIO_SEL, },
+	{ IMX93_CLK_SAI3,		"sai3_root",		0x1c00,	AUDIO_SEL, },
+	{ IMX93_CLK_CCM_CKO1,		"ccm_cko1_root",	0x1c80,	CKO1_SEL, },
+	{ IMX93_CLK_CCM_CKO2,		"ccm_cko2_root",	0x1d00,	CKO2_SEL, },
+	{ IMX93_CLK_CCM_CKO3,		"ccm_cko3_root",	0x1d80,	CKO1_SEL, },
+	{ IMX93_CLK_CCM_CKO4,		"ccm_cko4_root",	0x1e00,	CKO2_SEL, },
+	{ IMX93_CLK_HSIO,		"hsio_root",		0x1e80,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_HSIO_USB_TEST_60M,	"hsio_usb_test_60m_root", 0x1f00, LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_HSIO_ACSCAN_80M,	"hsio_acscan_80m_root",	0x1f80,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_HSIO_ACSCAN_480M,	"hsio_acscan_480m_root", 0x2000, MISC_SEL, },
+	{ IMX93_CLK_ML_APB,		"ml_apb_root",		0x2180,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_ML,			"ml_root",		0x2200,	FAST_SEL, },
+	{ IMX93_CLK_MEDIA_AXI,		"media_axi_root",	0x2280,	FAST_SEL, },
+	{ IMX93_CLK_MEDIA_APB,		"media_apb_root",	0x2300,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_MEDIA_LDB,		"media_ldb_root",	0x2380,	VIDEO_SEL, },
+	{ IMX93_CLK_MEDIA_DISP_PIX,	"media_disp_pix_root",	0x2400,	VIDEO_SEL, },
+	{ IMX93_CLK_CAM_PIX,		"cam_pix_root",		0x2480,	VIDEO_SEL, },
+	{ IMX93_CLK_MIPI_TEST_BYTE,	"mipi_test_byte_root",	0x2500,	VIDEO_SEL, },
+	{ IMX93_CLK_MIPI_PHY_CFG,	"mipi_phy_cfg_root",	0x2580,	VIDEO_SEL, },
+	{ IMX93_CLK_ADC,		"adc_root",		0x2700,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_PDM,		"pdm_root",		0x2780,	AUDIO_SEL, },
+	{ IMX93_CLK_TSTMR1,		"tstmr1_root",		0x2800,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_TSTMR2,		"tstmr2_root",		0x2880,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_MQS1,		"mqs1_root",		0x2900,	AUDIO_SEL, },
+	{ IMX93_CLK_MQS2,		"mqs2_root",		0x2980,	AUDIO_SEL, },
+	{ IMX93_CLK_AUDIO_XCVR,		"audio_xcvr_root",	0x2a00,	NON_IO_SEL, },
+	{ IMX93_CLK_SPDIF,		"spdif_root",		0x2a80,	AUDIO_SEL, },
+	{ IMX93_CLK_ENET,		"enet_root",		0x2b00,	NON_IO_SEL, },
+	{ IMX93_CLK_ENET_TIMER1,	"enet_timer1_root",	0x2b80,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_ENET_TIMER2,	"enet_timer2_root",	0x2c00,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_ENET_REF,		"enet_ref_root",	0x2c80,	NON_IO_SEL, },
+	{ IMX93_CLK_ENET_REF_PHY,	"enet_ref_phy_root",	0x2d00,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_I3C1_SLOW,		"i3c1_slow_root",	0x2d80,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_I3C2_SLOW,		"i3c2_slow_root",	0x2e00,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_USB_PHY_BURUNIN,	"usb_phy_root",		0x2e80,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_PAL_CAME_SCAN,	"pal_came_scan_root",	0x2f00,	MISC_SEL, }
+};
+
+struct imx93_clk_ccgr {
+	u32 clk;
+	char *name;
+	char *parent_name;
+	u32 off;
+	unsigned long flags;
+} ccgr_array[] = {
+	{ IMX93_CLK_A55_GATE,		"a55",		"a55_root",		0x8000, CLK_IS_CRITICAL },
+	{ IMX93_CLK_CM33_GATE,		"cm33",		"m33_root",		0x8040, CLK_IS_CRITICAL },
+	{ IMX93_CLK_ADC1_GATE,		"adc1",		"osc_24m",		0x82c0, },
+	{ IMX93_CLK_WDOG1_GATE,		"wdog1",	"osc_24m",		0x8300, },
+	{ IMX93_CLK_WDOG2_GATE,		"wdog2",	"osc_24m",		0x8340, },
+	{ IMX93_CLK_WDOG3_GATE,		"wdog3",	"osc_24m",		0x8380, },
+	{ IMX93_CLK_WDOG4_GATE,		"wdog4",	"osc_24m",		0x83c0, },
+	{ IMX93_CLK_WDOG5_GATE,		"wdog5",	"osc_24m",		0x8400, },
+	{ IMX93_CLK_SEMA1_GATE,		"sema1",	"bus_aon_root",		0x8440, },
+	{ IMX93_CLK_SEMA2_GATE,		"sema2",	"bus_wakeup_root",	0x8480, },
+	{ IMX93_CLK_MU_A_GATE,		"mu_a",		"bus_aon_root",		0x84c0, },
+	{ IMX93_CLK_MU_B_GATE,		"mu_b",		"bus_aon_root",		0x8500, },
+	{ IMX93_CLK_EDMA1_GATE,		"edma1",	"wakeup_axi_root",	0x8540, },
+	{ IMX93_CLK_EDMA2_GATE,		"edma2",	"wakeup_axi_root",	0x8580, },
+	{ IMX93_CLK_FLEXSPI1_GATE,	"flexspi",	"flexspi_root",		0x8640, },
+	{ IMX93_CLK_GPIO1_GATE,		"gpio1",	"m33_root",		0x8880, },
+	{ IMX93_CLK_GPIO2_GATE,		"gpio2",	"bus_wakeup_root",	0x88c0, },
+	{ IMX93_CLK_GPIO3_GATE,		"gpio3",	"bus_wakeup_root",	0x8900, },
+	{ IMX93_CLK_GPIO4_GATE,		"gpio4",	"bus_wakeup_root",	0x8940, },
+	{ IMX93_CLK_FLEXIO1_GATE,	"flexio1",	"flexio1_root",		0x8980, },
+	{ IMX93_CLK_FLEXIO2_GATE,	"flexio2",	"flexio2_root",		0x89c0, },
+	{ IMX93_CLK_LPIT1_GATE,		"lpit1",	"lpit1_root",		0x8a00, },
+	{ IMX93_CLK_LPIT2_GATE,		"lpit2",	"lpit2_root",		0x8a40, },
+	{ IMX93_CLK_LPTMR1_GATE,	"lptmr1",	"lptmr1_root",		0x8a80, },
+	{ IMX93_CLK_LPTMR2_GATE,	"lptmr2",	"lptmr2_root",		0x8ac0, },
+	{ IMX93_CLK_TPM1_GATE,		"tpm1",		"tpm1_root",		0x8b00, },
+	{ IMX93_CLK_TPM2_GATE,		"tpm2",		"tpm2_root",		0x8b40, },
+	{ IMX93_CLK_TPM3_GATE,		"tpm3",		"tpm3_root",		0x8b80, },
+	{ IMX93_CLK_TPM4_GATE,		"tpm4",		"tpm4_root",		0x8bc0, },
+	{ IMX93_CLK_TPM5_GATE,		"tpm5",		"tpm5_root",		0x8c00, },
+	{ IMX93_CLK_TPM6_GATE,		"tpm6",		"tpm6_root",		0x8c40, },
+	{ IMX93_CLK_CAN1_GATE,		"can1",		"can1_root",		0x8c80, },
+	{ IMX93_CLK_CAN2_GATE,		"can2",		"can2_root",		0x8cc0, },
+	{ IMX93_CLK_LPUART1_GATE,	"lpuart1",	"lpuart1_root",		0x8d00, },
+	{ IMX93_CLK_LPUART2_GATE,	"lpuart2",	"lpuart2_root",		0x8d40, },
+	{ IMX93_CLK_LPUART3_GATE,	"lpuart3",	"lpuart3_root",		0x8d80, },
+	{ IMX93_CLK_LPUART4_GATE,	"lpuart4",	"lpuart4_root",		0x8dc0, },
+	{ IMX93_CLK_LPUART5_GATE,	"lpuart5",	"lpuart5_root",		0x8e00, },
+	{ IMX93_CLK_LPUART6_GATE,	"lpuart6",	"lpuart6_root",		0x8e40, },
+	{ IMX93_CLK_LPUART7_GATE,	"lpuart7",	"lpuart7_root",		0x8e80, },
+	{ IMX93_CLK_LPUART8_GATE,	"lpuart8",	"lpuart8_root",		0x8ec0, },
+	{ IMX93_CLK_LPI2C1_GATE,	"lpi2c1",	"lpi2c1_root",		0x8f00, },
+	{ IMX93_CLK_LPI2C2_GATE,	"lpi2c2",	"lpi2c2_root",		0x8f40, },
+	{ IMX93_CLK_LPI2C3_GATE,	"lpi2c3",	"lpi2c3_root",		0x8f80, },
+	{ IMX93_CLK_LPI2C4_GATE,	"lpi2c4",	"lpi2c4_root",		0x8fc0, },
+	{ IMX93_CLK_LPI2C5_GATE,	"lpi2c5",	"lpi2c5_root",		0x9000, },
+	{ IMX93_CLK_LPI2C6_GATE,	"lpi2c6",	"lpi2c6_root",		0x9040, },
+	{ IMX93_CLK_LPI2C7_GATE,	"lpi2c7",	"lpi2c7_root",		0x9080, },
+	{ IMX93_CLK_LPI2C8_GATE,	"lpi2c8",	"lpi2c8_root",		0x90c0, },
+	{ IMX93_CLK_LPSPI1_GATE,	"lpspi1",	"lpspi1_root",		0x9100, },
+	{ IMX93_CLK_LPSPI2_GATE,	"lpspi2",	"lpspi2_root",		0x9140, },
+	{ IMX93_CLK_LPSPI3_GATE,	"lpspi3",	"lpspi3_root",		0x9180, },
+	{ IMX93_CLK_LPSPI4_GATE,	"lpspi4",	"lpspi4_root",		0x91c0, },
+	{ IMX93_CLK_LPSPI5_GATE,	"lpspi5",	"lpspi5_root",		0x9200, },
+	{ IMX93_CLK_LPSPI6_GATE,	"lpspi6",	"lpspi6_root",		0x9240, },
+	{ IMX93_CLK_LPSPI7_GATE,	"lpspi7",	"lpspi7_root",		0x9280, },
+	{ IMX93_CLK_LPSPI8_GATE,	"lpspi8",	"lpspi8_root",		0x92c0, },
+	{ IMX93_CLK_I3C1_GATE,		"i3c1",		"i3c1_root",		0x9300, },
+	{ IMX93_CLK_I3C2_GATE,		"i3c2",		"i3c2_root",		0x9340, },
+	{ IMX93_CLK_USDHC1_GATE,	"usdhc1",	"usdhc1_root",		0x9380, },
+	{ IMX93_CLK_USDHC2_GATE,	"usdhc2",	"usdhc2_root",		0x93c0, },
+	{ IMX93_CLK_USDHC3_GATE,	"usdhc3",	"usdhc3_root",		0x9400, },
+	{ IMX93_CLK_SAI1_GATE,		"sai1",		"sai1_root",		0x9440, },
+	{ IMX93_CLK_SAI2_GATE,		"sai2",		"sai2_root",		0x9480, },
+	{ IMX93_CLK_SAI3_GATE,		"sai3",		"sai3_root",		0x94c0, },
+	{ IMX93_CLK_MIPI_CSI_GATE,	"mipi_csi",	"media_apb_root",	0x9580, },
+	{ IMX93_CLK_MIPI_DSI_GATE,	"mipi_dsi",	"media_apb_root",	0x95c0, },
+	{ IMX93_CLK_LVDS_GATE,		"lvds",		"media_ldb_root",	0x9600, },
+	{ IMX93_CLK_LCDIF_GATE,		"lcdif",	"media_apb_root",	0x9640, },
+	{ IMX93_CLK_PXP_GATE,		"pxp",		"media_apb_root",	0x9680, },
+	{ IMX93_CLK_ISI_GATE,		"isi",		"media_apb_root",	0x96c0, },
+	{ IMX93_CLK_NIC_MEDIA_GATE,	"nic_media",	"media_apb_root",	0x9700, },
+	{ IMX93_CLK_USB_CONTROLLER_GATE, "usb_controller", "hsio_root",		0x9a00, },
+	{ IMX93_CLK_USB_TEST_60M_GATE,	"usb_test_60m",	"hsio_usb_test_60m_root", 0x9a40, },
+	{ IMX93_CLK_HSIO_TROUT_24M_GATE, "hsio_trout_24m", "osc_24m",		0x9a80, },
+	{ IMX93_CLK_PDM_GATE,		"pdm",		"pdm_root",		0x9ac0, },
+	{ IMX93_CLK_MQS1_GATE,		"mqs1",		"sai1_root",		0x9b00, },
+	{ IMX93_CLK_MQS2_GATE,		"mqs2",		"sai3_root",		0x9b40, },
+	{ IMX93_CLK_AUD_XCVR_GATE,	"aud_xcvr",	"audio_xcvr_root",	0x9b80, },
+	{ IMX93_CLK_SPDIF_GATE,		"spdif",	"spdif_root",		0x9c00, },
+	{ IMX93_CLK_HSIO_32K_GATE,	"hsio_32k",	"osc_32k",		0x9dc0, },
+	{ IMX93_CLK_ENET1_GATE,		"enet1",	"enet_root",		0x9e00, },
+	{ IMX93_CLK_ENET_QOS_GATE,	"enet_qos",	"wakeup_axi_root",	0x9e40, },
+	{ IMX93_CLK_SYS_CNT_GATE,	"sys_cnt",	"osc_24m",		0x9e80, },
+	{ IMX93_CLK_TSTMR1_GATE,	"tstmr1",	"bus_aon_root",		0x9ec0, },
+	{ IMX93_CLK_TSTMR2_GATE,	"tstmr2",	"bus_wakeup_root",	0x9f00, },
+	{ IMX93_CLK_TMC_GATE,		"tmc",		"osc_24m",		0x9f40, },
+	{ IMX93_CLK_PMRO_GATE,		"pmro",		"osc_24m",		0x9f80, }
+};
+
+static struct clk_hw_onecell_data *clk_hw_data;
+static struct clk_hw **clks;
+
+static int imx93_clocks_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct imx93_clk_root *root;
+	struct imx93_clk_ccgr *ccgr;
+	void __iomem *base = NULL;
+	int i, ret;
+
+	clk_hw_data = kzalloc(struct_size(clk_hw_data, hws,
+					  IMX93_CLK_END), GFP_KERNEL);
+	if (WARN_ON(!clk_hw_data))
+		return -ENOMEM;
+
+	clk_hw_data->num = IMX93_CLK_END;
+	clks = clk_hw_data->hws;
+
+	clks[IMX93_CLK_DUMMY] = imx_clk_hw_fixed("dummy", 0);
+	clks[IMX93_CLK_24M] = imx_obtain_fixed_clk_hw(np, "osc_24m");
+	clks[IMX93_CLK_32K] = imx_obtain_fixed_clk_hw(np, "osc_32k");
+	clks[IMX93_CLK_EXT1] = imx_obtain_fixed_clk_hw(np, "clk_ext1");
+
+	clks[IMX93_CLK_SYS_PLL_PFD0] = imx_clk_hw_fixed("sys_pll_pfd0", 1000000000);
+	clks[IMX93_CLK_SYS_PLL_PFD0_DIV2] = imx_clk_hw_fixed_factor("sys_pll_pfd0_div2",
+								    "sys_pll_pfd0", 1, 2);
+	clks[IMX93_CLK_SYS_PLL_PFD1] = imx_clk_hw_fixed("sys_pll_pfd1", 800000000);
+	clks[IMX93_CLK_SYS_PLL_PFD1_DIV2] = imx_clk_hw_fixed_factor("sys_pll_pfd1_div2",
+								    "sys_pll_pfd1", 1, 2);
+	clks[IMX93_CLK_SYS_PLL_PFD2] = imx_clk_hw_fixed("sys_pll_pfd2", 625000000);
+	clks[IMX93_CLK_SYS_PLL_PFD2_DIV2] = imx_clk_hw_fixed_factor("sys_pll_pfd2_div2",
+								    "sys_pll_pfd2", 1, 2);
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx93-anatop");
+	base = of_iomap(np, 0);
+	of_node_put(np);
+	if (WARN_ON(!base))
+		return -ENOMEM;
+
+	clks[IMX93_CLK_AUDIO_PLL] = imx_clk_fracn_gppll("audio_pll", "osc_24m", base + 0x1200,
+							&imx_fracn_gppll);
+	clks[IMX93_CLK_VIDEO_PLL] = imx_clk_fracn_gppll("video_pll", "osc_24m", base + 0x1400,
+							&imx_fracn_gppll);
+
+	np = dev->of_node;
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (WARN_ON(IS_ERR(base)))
+		return PTR_ERR(base);
+
+	for (i = 0; i < ARRAY_SIZE(root_array); i++) {
+		root = &root_array[i];
+		clks[root->clk] = imx93_clk_composite_flags(root->name,
+							    parent_names[root->sel],
+							    4, base + root->off,
+							    root->flags);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(ccgr_array); i++) {
+		ccgr = &ccgr_array[i];
+		clks[ccgr->clk] = imx_clk_hw_gate4_flags(ccgr->name,
+							 ccgr->parent_name,
+							 base + ccgr->off, 0,
+							 ccgr->flags);
+	}
+
+	imx_check_clk_hws(clks, IMX93_CLK_END);
+
+	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
+	if (ret < 0) {
+		dev_err(dev, "failed to register clks for i.MX93\n");
+		goto unregister_hws;
+	}
+
+	return 0;
+
+unregister_hws:
+	imx_unregister_hw_clocks(clks, IMX93_CLK_END);
+
+	return ret;
+}
+
+static const struct of_device_id imx93_clk_of_match[] = {
+	{ .compatible = "fsl,imx93-ccm" },
+	{ /* Sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, imx93_clk_of_match);
+
+static struct platform_driver imx93_clk_driver = {
+	.probe = imx93_clocks_probe,
+	.driver = {
+		.name = "imx93-ccm",
+		.suppress_bind_attrs = true,
+		.of_match_table = of_match_ptr(imx93_clk_of_match),
+	},
+};
+module_platform_driver(imx93_clk_driver);
-- 
2.25.1

