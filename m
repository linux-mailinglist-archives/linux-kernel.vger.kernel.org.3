Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1B05AEBA7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 16:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbiIFOKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 10:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240704AbiIFOIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 10:08:02 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2061e.outbound.protection.outlook.com [IPv6:2a01:111:f400:7ea9::61e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AD27F0BD;
        Tue,  6 Sep 2022 06:45:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3sfmjCeS85tAjGH+VpK35kPIV/jyZ2pdTgte0k1irYIDrA6iajc8dDfwFfYnv29kAd8AjRccTqkZtGxdmbcqmE1hYmGoocHFBaEoTA/MCVh80KBm2vk/NbV5IOkcorOZXkqtcsagi0fTXPLMKFoM2lVHin+rkVh3lo01R+G1YtBYzjdcW6FVWU2s6hwbvlKhztBjtpfBkWtxPIU1wONwQ0EQETuM0RP9KnsahmavgJOXUkAI2m+c02dFeprxjcmuuUb0rKvylhggsIKpWgoyT8xQAv5rmt7ajWQ1JR4IziAqXr5++Q8de/Vqrsnx3b3K0FePiyxaFOzOgGxRKlx5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xe/gHVRsS9jO7JHeFe+NOiajmXlhQPe5dKmDOoT7qlU=;
 b=VKqy/n8fFNYgfw2zM+qMk5uRh9YaST/gY4K3BC145S/t0//sTRvBW34MZBLWGy6651Isj3Maxf6WetO/HRlvhpF1KI5F9RIRE/Lm49eo3OdvJl/fo6mVNpmK51/xUnheGXgFa+qAVffpwKzcu5rmzvlk4L6zFzAYfSBONv79BpSWnpdZcZ+1/wgxk6Fm3KdiwMxczP+fK9+SxL1UrGY3Awner7VxniEYfbJ129MmUVWtmebUVIf/ysB0Y2dYQoGI5HUsHhhKAGUlCB9sB5FXxy/wGI6oZMHGZUAsqR9WRyt4e3aiY0YoF9tdgm5vZAb7X187kkPNbkIjt7affaX3nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=linux.dev smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xe/gHVRsS9jO7JHeFe+NOiajmXlhQPe5dKmDOoT7qlU=;
 b=T/9xrGEXP1ndTLXBDm446Iz4hDpgXKGYy/I7ghXRUGIvn+GEcJ/YwXlFhfXiXGSNrurbGaeGLITzfsvm2dhyqYddxfYeWm1jLAW6lcxnYEc93Iuv/S1RC3fuNH1TG3SqLD0fXU9PcI9duTikvfggeeDAhHvDH6RGPr9u3GS1k59Hq98uXvYmwWBAAb1Yos55dCBFzbVUJBEFfLn7/VPcNVXRmmHlJnh6YmThq3yv2r+U4ftLOP/G2S417zOgmr2h9H46AZETrxdtQ8pU+u6p933D5v6r3ZZaFyyf8OfVbb5PahUaTW0ywzYuXv+nal6J0whEckkYZmxhuKlGBUyKUQ==
Received: from DM6PR10CA0013.namprd10.prod.outlook.com (2603:10b6:5:60::26) by
 PH7PR12MB7209.namprd12.prod.outlook.com (2603:10b6:510:204::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 13:44:29 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::fa) by DM6PR10CA0013.outlook.office365.com
 (2603:10b6:5:60::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Tue, 6 Sep 2022 13:44:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5588.10 via Frontend Transport; Tue, 6 Sep 2022 13:44:28 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Tue, 6 Sep
 2022 13:44:28 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 6 Sep 2022
 06:44:27 -0700
Received: from build-petlozup-20220627T000321362.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.986.29 via
 Frontend Transport; Tue, 6 Sep 2022 06:44:27 -0700
From:   Petlozu Pravareshwar <petlozup@nvidia.com>
To:     <jonathanh@nvidia.com>, <thierry.reding@gmail.com>,
        <p.zabel@pengutronix.de>, <dmitry.osipenko@collabora.com>,
        <ulf.hansson@linaro.org>, <kkartik@nvidia.com>,
        <cai.huoqing@linux.dev>, <spatra@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <petlozup@nvidia.com>, Stefan Kristiansson <stefank@nvidia.com>
Subject: [PATCH] soc/tegra: pmc: Fix dual edge triggered wakes
Date:   Tue, 6 Sep 2022 13:44:17 +0000
Message-ID: <20220906134417.341407-1-petlozup@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc7d6c1d-4536-40f7-74c2-08da900debb5
X-MS-TrafficTypeDiagnostic: PH7PR12MB7209:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U5yDTMKBNihqs6WCy9aalCw1DoE49oSpC/6e10q0Ju5WUQe5b8I5Xig/m/bbAqLi5zWuAsjBYIaoss/0HT+5DhDLxlRhDfwc5A+EOQLcmzAiHawiiobTVPhGdg40djIXdwjMUXZyTPyaTH2sDzoKoxy5YkcbiaEkT+cwafFWz2muQy1fE/F0CL94xn9bqDDixKNaVQqcP38ENWSnw2HkUbzeP4QXNdemRjNNcOs+rNjbz+EKa/GwqFBYQjFhIRVc45MqSvpleDtCrytKeDbgX9vCpE+MCL20uEHeQTB7Ijp/06cfUuic8KkkDne6I6hR1Q3P87WzdGYA1R0P9EqxgXrnaK23P15Eab368ZIYpuqc8NhUjOmnglUiqqkbOWvx2qyAdBTB9oOQQkeU8/EgpQ/yu1GUSKM9GcFZGnlvxTxVyebydH3KCDEigfPG8gK+FVUWDK2ULcuGKNg4CrAVM5Py+ldIYeS6MF62fuofjwd1wJkQ+4EmaIEKbnt+Wqx8kqOT6KF+8ob288J4drtQrgsUWI307v6URho/ScAC9kU8Ozxg12xU+KobA7CisgnRY/2SmD1R2dnwHeed3Ul9nHpy2g4if+2FO665Yvi3lfWbS7eDT7cGg16f7iBDBmZRMeUrqneHxJ8TfEmA11C+g0h32dOuNY6ydQgO23Z04N8xRfr6kMAas/h7PGworbIDwj+a8mj72b677NxVkuynjPxjyqBZlWAg0rGs94dps/mdPj+dMKJeYU24TE8h5Hb5/hbWuQwJD+em3768l7h5l4/O9Rb4+P1XdkTMaOcHGqoSxxCUWhO/9dQaTOgvlwUL
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(136003)(376002)(39860400002)(36840700001)(46966006)(40470700004)(356005)(2906002)(4326008)(6666004)(70206006)(40480700001)(70586007)(8676002)(82310400005)(7696005)(26005)(316002)(41300700001)(107886003)(478600001)(110136005)(54906003)(82740400003)(336012)(2616005)(1076003)(83380400001)(47076005)(86362001)(426003)(186003)(921005)(5660300002)(81166007)(36860700001)(36756003)(40460700003)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 13:44:28.8608
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc7d6c1d-4536-40f7-74c2-08da900debb5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7209
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a wake event is defined to be triggered on both positive
and negative edge of the input wake signal, it is crucial to
know the current state of the signal when going into suspend.
The intended way to obtain the current state of the wake
signals is to read the WAKE_AOWAKE_SW_STATUS register,
which should contains the raw state of the wake signals.

However, this register is edge triggered, an edge will not
be generated for signals that are already asserted prior to
the assertion of WAKE_LATCH_SW.

To workaround this, change the polarity of the wake level
from '0' to '1' while latching the signals, as this will
generate an edge for signals that are set to '1'.

Signed-off-by: Stefan Kristiansson <stefank@nvidia.com>
Signed-off-by: Petlozu Pravareshwar <petlozup@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 141 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 136 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 495d16a4732c..6a86961477e8 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -182,6 +182,9 @@
 #define WAKE_AOWAKE_TIER0_ROUTING(x) (0x4b4 + ((x) << 2))
 #define WAKE_AOWAKE_TIER1_ROUTING(x) (0x4c0 + ((x) << 2))
 #define WAKE_AOWAKE_TIER2_ROUTING(x) (0x4cc + ((x) << 2))
+#define WAKE_AOWAKE_SW_STATUS_W_0	0x49c
+#define WAKE_AOWAKE_SW_STATUS(x)	(0x4a0 + ((x) << 2))
+#define WAKE_LATCH_SW			0x498
 
 #define WAKE_AOWAKE_CTRL 0x4f4
 #define  WAKE_AOWAKE_CTRL_INTR_POLARITY BIT(0)
@@ -191,6 +194,12 @@
 #define  TEGRA_SMC_PMC_READ	0xaa
 #define  TEGRA_SMC_PMC_WRITE	0xbb
 
+#define WAKE_NR_EVENTS		96
+#define WAKE_NR_VECTORS		(WAKE_NR_EVENTS / 32)
+
+DECLARE_BITMAP(wake_level_map, WAKE_NR_EVENTS);
+DECLARE_BITMAP(wake_dual_edge_map, WAKE_NR_EVENTS);
+
 struct pmc_clk {
 	struct clk_hw	hw;
 	unsigned long	offs;
@@ -2469,29 +2478,37 @@ static int tegra186_pmc_irq_set_type(struct irq_data *data, unsigned int type)
 {
 	struct tegra_pmc *pmc = irq_data_get_irq_chip_data(data);
 	u32 value;
+	unsigned long wake_id;
 
-	value = readl(pmc->wake + WAKE_AOWAKE_CNTRL(data->hwirq));
+	wake_id = data->hwirq;
+	value = readl(pmc->wake + WAKE_AOWAKE_CNTRL(wake_id));
 
 	switch (type) {
 	case IRQ_TYPE_EDGE_RISING:
 	case IRQ_TYPE_LEVEL_HIGH:
 		value |= WAKE_AOWAKE_CNTRL_LEVEL;
+		set_bit(wake_id, wake_level_map);
+		clear_bit(wake_id, wake_dual_edge_map);
 		break;
 
 	case IRQ_TYPE_EDGE_FALLING:
 	case IRQ_TYPE_LEVEL_LOW:
 		value &= ~WAKE_AOWAKE_CNTRL_LEVEL;
+		clear_bit(wake_id, wake_level_map);
+		clear_bit(wake_id, wake_dual_edge_map);
 		break;
 
 	case IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING:
 		value ^= WAKE_AOWAKE_CNTRL_LEVEL;
+		clear_bit(wake_id, wake_level_map);
+		set_bit(wake_id, wake_dual_edge_map);
 		break;
 
 	default:
 		return -EINVAL;
 	}
 
-	writel(value, pmc->wake + WAKE_AOWAKE_CNTRL(data->hwirq));
+	writel(value, pmc->wake + WAKE_AOWAKE_CNTRL(wake_id));
 
 	return 0;
 }
@@ -3074,28 +3091,142 @@ static int tegra_pmc_probe(struct platform_device *pdev)
 	return err;
 }
 
-#if defined(CONFIG_PM_SLEEP) && defined(CONFIG_ARM)
+#ifdef CONFIG_PM_SLEEP
+#ifdef CONFIG_ARM64
+/*
+ * Ensures that sufficient time is passed for a register write to
+ * serialize into the 32KHz domain.
+ */
+static void wke_32kwritel(u32 val, u32 reg)
+{
+	writel(val, pmc->wake + reg);
+	udelay(130);
+}
+
+static void wke_write_wake_level(int wake, int level)
+{
+	u32 val;
+	u32 reg = WAKE_AOWAKE_CNTRL(wake);
+
+	val = readl(pmc->wake + reg);
+	if (level)
+		val |= WAKE_AOWAKE_CNTRL_LEVEL;
+	else
+		val &= ~WAKE_AOWAKE_CNTRL_LEVEL;
+	writel(val, pmc->wake + reg);
+}
+
+static void wke_write_wake_levels(unsigned long *lvl)
+{
+	int i;
+
+	for (i = 0; i < WAKE_NR_EVENTS; i++)
+		wke_write_wake_level(i, test_bit(i, lvl));
+}
+
+static void wke_clear_sw_wake_status(void)
+{
+	wke_32kwritel(1, WAKE_AOWAKE_SW_STATUS_W_0);
+}
+
+static void wke_read_sw_wake_status(unsigned long *status_map)
+{
+	u32 status[WAKE_NR_VECTORS];
+	int i;
+
+	for (i = 0; i < WAKE_NR_EVENTS; i++)
+		wke_write_wake_level(i, 0);
+
+	wke_clear_sw_wake_status();
+
+	wke_32kwritel(1, WAKE_LATCH_SW);
+
+	/*
+	 * WAKE_AOWAKE_SW_STATUS is edge triggered, so in order to
+	 * obtain the current status of the input wake signals, change
+	 * the polarity of the wake level from 0->1 while latching to force
+	 * a positive edge if the sampled signal is '1'.
+	 */
+	for (i = 0; i < WAKE_NR_EVENTS; i++)
+		wke_write_wake_level(i, 1);
+
+	/*
+	 * Wait for the update to be synced into the 32kHz domain,
+	 * and let enough time lapse, so that the wake signals have time to
+	 * be sampled.
+	 */
+	udelay(300);
+
+	wke_32kwritel(0, WAKE_LATCH_SW);
+
+	for (i = 0; i < WAKE_NR_VECTORS; i++)
+		status[i] = readl(pmc->wake + WAKE_AOWAKE_SW_STATUS(i));
+
+	bitmap_from_arr32(status_map, status, WAKE_NR_EVENTS);
+}
+
+static void wke_clear_wake_status(void)
+{
+	u32 status;
+	int i, wake;
+	unsigned long ulong_status;
+
+	for (i = 0; i < WAKE_NR_VECTORS; i++) {
+		status = readl(pmc->wake + WAKE_AOWAKE_STATUS_R(i));
+		status = status & readl(pmc->wake +
+				WAKE_AOWAKE_TIER2_ROUTING(i));
+		ulong_status = (unsigned long)status;
+		for_each_set_bit(wake, &ulong_status, 32)
+			wke_32kwritel(0x1,
+				WAKE_AOWAKE_STATUS_W((i * 32) + wake));
+	}
+}
+#endif /* CONFIG_ARM64 */
+
 static int tegra_pmc_suspend(struct device *dev)
 {
+#ifdef CONFIG_ARM
 	struct tegra_pmc *pmc = dev_get_drvdata(dev);
 
 	tegra_pmc_writel(pmc, virt_to_phys(tegra_resume), PMC_SCRATCH41);
+#else /* CONFIG_ARM64 */
+	DECLARE_BITMAP(status, WAKE_NR_EVENTS);
+	DECLARE_BITMAP(lvl, WAKE_NR_EVENTS);
+	DECLARE_BITMAP(wake_level, WAKE_NR_EVENTS);
+	int i;
+
+	wke_read_sw_wake_status(status);
+
+	/* flip the wakeup trigger for dual-edge triggered pads
+	 * which are currently asserting as wakeups
+	 */
+	for (i = 0; i < BITS_TO_LONGS(WAKE_NR_EVENTS); i++) {
+		lvl[i] = ~status[i] & wake_dual_edge_map[i];
+		wake_level[i] = lvl[i] | wake_level_map[i];
+	}
+
+	/* Clear PMC Wake Status registers while going to suspend */
+	wke_clear_wake_status();
 
+	wke_write_wake_levels(wake_level);
+#endif
 	return 0;
 }
 
 static int tegra_pmc_resume(struct device *dev)
 {
+#ifdef CONFIG_ARM
 	struct tegra_pmc *pmc = dev_get_drvdata(dev);
 
 	tegra_pmc_writel(pmc, 0x0, PMC_SCRATCH41);
+#endif
 
 	return 0;
 }
 
 static SIMPLE_DEV_PM_OPS(tegra_pmc_pm_ops, tegra_pmc_suspend, tegra_pmc_resume);
 
-#endif
+#endif /*CONFIG_PM_SLEEP */
 
 static const char * const tegra20_powergates[] = {
 	[TEGRA_POWERGATE_CPU] = "cpu",
@@ -4069,7 +4200,7 @@ static struct platform_driver tegra_pmc_driver = {
 		.name = "tegra-pmc",
 		.suppress_bind_attrs = true,
 		.of_match_table = tegra_pmc_match,
-#if defined(CONFIG_PM_SLEEP) && defined(CONFIG_ARM)
+#if defined(CONFIG_PM_SLEEP)
 		.pm = &tegra_pmc_pm_ops,
 #endif
 		.sync_state = tegra_pmc_sync_state,
-- 
2.17.1

