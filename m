Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5714958B7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 04:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbiAUD6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 22:58:10 -0500
Received: from mail-dm6nam12on2129.outbound.protection.outlook.com ([40.107.243.129]:44737
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233731AbiAUD6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 22:58:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3l/cKehQ9ybF8bToLgGQNEhaeViqd0hyEmMs1ii1yup0pzeFVpyv3Pl+8w89llq2hKliCQpqsmjVQqcMl65ZN92mFCQfy7oOed+cRkexAkxLo8tTHckARmCA04Uil/AsFehmxnVULoAxE2uIpcp8/IkXJsm96nR3pRAE7zFhk9USWqNMUW+ucaYqvDc4wlTF9ybdksJ+TlEZSBs+7PFwFChh1uDfmDDr+QUml7wNEN1Y1pkVfTce3/teKEAwz/rikW3Nlh895wpjUiAHnUUeg0XSvsFc23Dl1FeTR3/5XW8HcaOhalqssbggflQ1vQ+4ThchNa+l0YHT+jg+2ifqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2BlyZ3sjh/VIH/O0b3FwkoibEK+bSExPAw4+q/38q0=;
 b=hWWAwq6ivQ2MDBdaA2i0ciPbEFQC+awPbXKopkI0qkzEe/Aht/tTmBwxv7qio8dlYt0AUkH8+m5zqim/Ia6UhTM96ATteB6rzO+NLsziVv0jIgandb7cvkM0TTPtwmCD0cCBKRNhn5Kw3vsAMlX2SMHgUBUjf95SdUqVNqzLBdRA9uNwL33nV7Lfzv7tpoe58dq1WX8WedGvYK6eHDPjdM1FAPuKBwwdAonMgf4oMGM954JlHwuk96F125mBLJqKPZ3tetFq7ISzI+xjOw2nvXWnfSx/gbI2x8Hl94f6Nc4pIZHgOgsoqbfIat96Qu2aYILBZOb+L42rnLkqqts7NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com;
 s=selector2-towerbridgetechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2BlyZ3sjh/VIH/O0b3FwkoibEK+bSExPAw4+q/38q0=;
 b=Qoc7SAYdyYRrsBDjue6uAoQFv/izAMxwsd3ROXGdk0Hak9IPvMYSBq+RecJNPfN+NRqBdvEbsov4/ApBevFgDQl3CqeFQqA4vv9r7b0s/OLacHrfzafXSzpkycLu2WiRNvtNcBK9fxo12cxQ6b7x+DQRnabtgIMoPV4sWmSfH0w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bayhubtech.com;
Received: from PH0PR16MB4248.namprd16.prod.outlook.com (2603:10b6:510:4c::16)
 by BY5PR16MB3442.namprd16.prod.outlook.com (2603:10b6:a03:1ab::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Fri, 21 Jan
 2022 03:58:01 +0000
Received: from PH0PR16MB4248.namprd16.prod.outlook.com
 ([fe80::e88f:f199:eed:4645]) by PH0PR16MB4248.namprd16.prod.outlook.com
 ([fe80::e88f:f199:eed:4645%7]) with mapi id 15.20.4909.010; Fri, 21 Jan 2022
 03:58:00 +0000
From:   Chevron Li <chevron.li@bayhubtech.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shirley.her@bayhubtech.com, fred.ai@bayhubtech.com,
        xiaoguang.yu@bayhubtech.com, shaper.liu@bayhubtech.com,
        bruce.yang@bayhubtech.com
Subject: [PATCH 1/2] mmc:sdhci-msm:fix Qualcomm sd host 7180 SD card compatibility issue
Date:   Thu, 20 Jan 2022 19:57:46 -0800
Message-Id: <20220121035747.400-1-chevron.li@bayhubtech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0171.apcprd02.prod.outlook.com
 (2603:1096:201:1f::31) To PH0PR16MB4248.namprd16.prod.outlook.com
 (2603:10b6:510:4c::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20eb195c-f9dc-476e-22b1-08d9dc92375e
X-MS-TrafficTypeDiagnostic: BY5PR16MB3442:EE_
X-Microsoft-Antispam-PRVS: <BY5PR16MB34423528F44F9EB8A6F59926EA5B9@BY5PR16MB3442.namprd16.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Y2daamet4T1TRQ4XB92h4ARYa3+w0Ld3VDZ2Ru/gzEjHIFDNFq/ie78qT0tBMTUVrKU4J73YEDRHugu9cjnH3J71IKmDQqq6HuzfLNUjo+p4afflHnf49p3wm6mt/FwGPsFVZV4GDEKGwTz+pBDr1kNtWex3hkx3l5yZg+Kudcvq7dxdVWCYUH/Jy/7AA5zWXhp/OuLBahim7+Wvtr3L4dTolDqSAYeCbVZNll7WNSwrCF0rCBgELRgMiFTWnCEUEYcrCq5CRsG/vqKNdhxk8ccHXWJdFe+GU1k+d1/JJ4IzAn6gAA3pyy11PEpIZWxZ378wOz9a+GeNnQPLMLC1RoOTYY/hgWJNN7KDCOswPoYqvD3NnvyeOke/oZ+aBYM1/NXec1TyJRg/mPRmIlxCnvP47O40WO2KQyadJ33r7tV3/vftGzSrtS8WWkzRVBIecJy0gJZ32658rPntyzTkCuztjN7upYqqyh/ysjbCQi9ZhoLwlwrZcXus1eUoOOtDhiRjUuYkcRdcD228Juq7Twj2fo2zl49ryqmov+wCiyUoRL0fonO+FmPTUnrlyHquYSzFCoc8OXYu7Ws0z6isR3+9Sp3mviiu2zMW8CVrf3Shc/AvNKIlrw1u1bG//1kuYUhDd4vEyt3rTKUrT/eJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR16MB4248.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(366004)(396003)(39830400003)(376002)(66476007)(66556008)(36756003)(38100700002)(86362001)(6506007)(66946007)(316002)(83380400001)(508600001)(8936002)(2616005)(52116002)(6486002)(1076003)(6512007)(6666004)(4326008)(8676002)(5660300002)(107886003)(2906002)(186003)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DtcemZwSFTf+X1nxxn3xLoinPabEi6KYnenJNblTZNJOBZoqoJ9kogW8FCNu?=
 =?us-ascii?Q?ENgMvX1uixumtdUNp2Mayy/XUFv6iKSczPFK4/SLTyBDO/0/TS4rk21R2nxf?=
 =?us-ascii?Q?pvIBYQK2KudrTO0eP+I2m18Pj31ypw5YmJgANNiqzdFN9BG/2XfVT5PS2xjp?=
 =?us-ascii?Q?cnZnGtWT7gxsXON3Yip7O74rqZcSnH+WUcvwWmShPTaEfLoVShPnF9RxVVRl?=
 =?us-ascii?Q?rqBWMQdP3JfGuxwfsXWIbEJMuC77lnwNJxaoCL6Yw7KarQ8ARV+AoLtaLUgw?=
 =?us-ascii?Q?LvZXXPdvokFKjOpu1oIaBV+iKW/xSCJDaadMe9lJzaIOnmIJGoyE3o0h6ixX?=
 =?us-ascii?Q?U6OowPwHj0W5nn60C+ah3/dzDR6kQN/wEpcGIDee79S7XqDO/lZkRhzLxL+b?=
 =?us-ascii?Q?h6ywx97D0Iesu3eSs5mf4KbpLykw0mJT9HPSMf2iLJRbptYHbInQ1SbDdOxr?=
 =?us-ascii?Q?FPfmi0J8m0nAzuimISO1p2AmbPXaJQWrVS8ACsNiRlVdR5Ko4rk+btHU4rH4?=
 =?us-ascii?Q?wyd1Pwm4JiHXPR+qzL4qN2C6vUUjyDDvz759tvFyLN37tEAYZ3tYoqaxr+fn?=
 =?us-ascii?Q?bS/407MuC2UA11Ny3Z7LXdXXfbLMesGmvQUdz151XMt1mflhyaI942CkwyEA?=
 =?us-ascii?Q?qj0T2CLVtgpwlZeIEl3FtdQBjLj6IH1L4FVSOlMWSK1PH/yptoIkoWaGyC1/?=
 =?us-ascii?Q?skAdTeqwSIduS6FynNwIXLD1odIl+jtUsA+HcrGzT7EYjCjgO0wHCq9u9drb?=
 =?us-ascii?Q?P58YDy/VnM7cS3H38L1LySxmYt0x1rvmjtyAuOh9BVYsfTjFMj9F11VJRtB9?=
 =?us-ascii?Q?E3aM9ke3U6T+nqGt+iD7YlwPSc6ViLfzPP3WYS7eLNNJDw7WMdRrU1RAKdd8?=
 =?us-ascii?Q?xqteqSnqLxZSDNVMmmq6vH3VR2S7KipjnUMOtV3VQLwEWxd2aGbQxD/yKYZp?=
 =?us-ascii?Q?z8mryYfsi4B/VE+HYprokJ214acZy5BHDIu7jCwNriq5XKK/8U6GyET3a3Mu?=
 =?us-ascii?Q?ZW1WaEvPVp5WaGs/vOONWEU6OZR7+dPSyz1hQ8kGL9j+Zt6h0qaKksVNA7/R?=
 =?us-ascii?Q?SuC2kwlAii/jfhTszgBUOks8MBe/k0kQwIJ6nXA2657tEFybwS0S0Hbyc+Nn?=
 =?us-ascii?Q?/J5+tleRKmI8RcktsrUqi6SHUBDytKIQXTigGlwnHSl/ibYzbkqe3Y4wluVe?=
 =?us-ascii?Q?emAOtt6cdvCCrg0Al1fZb/zFQTlkRFOGNPXhAZifWsF2jiI25dmHp6r4s0uV?=
 =?us-ascii?Q?3+GVbK1AvE0ALMZFq1jFNXNNcKOzx5RXp7oIcS2ohbMka1cp8XVtm4UTFd/V?=
 =?us-ascii?Q?Ev77yYz+lO1aVyNsFRapxK+a/iw490JZVvaByOuuOAxspKcTTGg0M57muWrF?=
 =?us-ascii?Q?2Ua86w/Bcl0Uu2P1V/gUWdkzk88kc/Nol3VN9Ao6wokSfJIn+zVtIwfH4eta?=
 =?us-ascii?Q?DAWpIISj5u4OiP8Alsrn1B/2ALixt11m7UL9j6rq6RhyR0NLmT0F1H+u24FE?=
 =?us-ascii?Q?15KhBhu+vDu+Fff6pRAnnQsWTQggWm/96MCrSMe3cGBUFug8R3iAGEO5sJcI?=
 =?us-ascii?Q?Prm4yBD1er2uNEWdbzVTBG2iNAmynZYIuUaIC3YIUMu7xlPlGYBg5xmMZcr7?=
 =?us-ascii?Q?RGW6Yeg6nccmxU8Ff6yMceYBatOjPGPlK6Xp1bW8E4OqpYhZK8hLsRgox3FA?=
 =?us-ascii?Q?M3GHPe0VMlmGFJF7g0xY5O+MXDPhWYq2dueRvBWPeBg6CpGxfSbYEfhILHA8?=
 =?us-ascii?Q?bx1Q+o7B6zqxQbtxsSuPy39GKygvKJY=3D?=
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20eb195c-f9dc-476e-22b1-08d9dc92375e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR16MB4248.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 03:58:00.5637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KvDtEKyknEXLfSM/7K4bVuE/yNBewFWZO9o/0HpjCVBsDqZqjxnIrUzvXkobl4isdYhxonSqvtDfJkMZnLC94uKcVX3xltPiNiajUY7nLOo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR16MB3442
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve the signal integrity for long SD bus trace by using SC7180+GGC SD host redriver chip
1.GGC is a SD bus signal re-timing IC that has been paired with the SC7180 sometimes.
2.The key points are initialized GGC chip during SD initialization and use GGC special tuning flow to re-timing SD bus signal.
3.GGC resource is initialized for GGC chip during Qualcomm host probe:
 3.1 GGC structure initialization
 3.2 GGC GPIO resource assignment
 3.3 Reload host->mmc->detect with GGC chip special initiation flow.
 3.4 Reload the host->mmc_host_ops.execute_tuning with GGC chip special tuning flow.
4.The function of the patch is already verified on Chrome OS, and Google request us to submit the patch to Linux for them future use.
5.GGC can work with any other standard SDHCI controller to improve SD signal SI and Timing.
6.GGC has cooperated with Intel/Qualcomm/MTK/SPRD sd host already and work well.

Signed-off-by: Chevron Li <chevron.li@bayhubtech.com>
---
Changes:
1.add a data member in sdhci_msm_host structure for extension
2.add an API to get the extension address from sdhci_msm_host structure
3.add an independent branch for GGC chip support according to the configure of DTSI
---
 drivers/mmc/host/sdhci-bayhub.c | 34 ++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-msm.c    | 39 ++++++++++++++++++++++++++++++++-
 2 files changed, 72 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mmc/host/sdhci-bayhub.c

diff --git a/drivers/mmc/host/sdhci-bayhub.c b/drivers/mmc/host/sdhci-bayhub.c
new file mode 100644
index 000000000000..867d465ce848
--- /dev/null
+++ b/drivers/mmc/host/sdhci-bayhub.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Bayhub Technologies, Inc. BH201 SDHCI bridge IC for
+ * VENDOR SDHCI platform driver source file
+ *
+ * Copyright (c) 2012-2018, The Linux Foundation. All rights reserved.
+ */
+
+struct sdhci_bht_host {
+};
+
+static void bht_signal_voltage_on_off(struct sdhci_host *host, u32 on_off)
+{
+}
+
+static void sdhci_bht_parse(struct mmc_host *mmc_host)
+{
+}
+
+static void sdhci_bht_resource_free(struct sdhci_msm_host *vendor_host)
+{
+}
+
+static void mmc_rescan_bht(struct work_struct *work)
+{
+}
+
+static int sdhci_bht_execute_tuning(struct mmc_host *mmc, u32 opcode)
+{
+	int ret = 0;
+
+	return ret;
+}
+
diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 50c71e0ba5e4..5e19d34ef25c 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -285,8 +285,14 @@ struct sdhci_msm_host {
 	u32 dll_config;
 	u32 ddr_config;
 	bool vqmmc_enabled;
+	unsigned long	private[] ____cacheline_aligned;
 };
 
+static inline void *sdhci_msm_priv(struct sdhci_msm_host *msm_host)
+{
+	return (void *)msm_host->private;
+}
+
 static const struct sdhci_msm_offset *sdhci_priv_msm_offset(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -1585,6 +1591,8 @@ static void sdhci_msm_dump_pwr_ctrl_regs(struct sdhci_host *host)
 		msm_host_readl(msm_host, host, msm_offset->core_pwrctl_mask),
 		msm_host_readl(msm_host, host, msm_offset->core_pwrctl_ctl));
 }
+/* include bayhub patch for GGC chip support */
+#include "sdhci-bayhub.c"
 
 static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
 {
@@ -1628,10 +1636,16 @@ static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
 
 	/* Handle BUS ON/OFF*/
 	if (irq_status & CORE_PWRCTL_BUS_ON) {
+		/* Bayhub patch: GGC chip power on patch */
+		if (of_find_property(msm_host->pdev->dev.of_node, "use-bayhub-bh201", NULL))
+			bht_signal_voltage_on_off(host, 1);
 		pwr_state = REQ_BUS_ON;
 		io_level = REQ_IO_HIGH;
 	}
 	if (irq_status & CORE_PWRCTL_BUS_OFF) {
+		/* Bayhub patch: GGC chip power off patch */
+		if (of_find_property(msm_host->pdev->dev.of_node, "use-bayhub-bh201", NULL))
+			bht_signal_voltage_on_off(host, 0);
 		pwr_state = REQ_BUS_OFF;
 		io_level = REQ_IO_LOW;
 	}
@@ -2497,7 +2511,12 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	const struct sdhci_msm_variant_info *var_info;
 	struct device_node *node = pdev->dev.of_node;
 
-	host = sdhci_pltfm_init(pdev, &sdhci_msm_pdata, sizeof(*msm_host));
+	/* Bayhub patch: memory allocate for sdhci_bht_host structure */
+	if (of_find_property(node, "use-bayhub-bh201", NULL))
+		host = sdhci_pltfm_init(pdev, &sdhci_msm_pdata,
+			sizeof(*msm_host) + sizeof(struct sdhci_bht_host));
+	else
+		host = sdhci_pltfm_init(pdev, &sdhci_msm_pdata, sizeof(*msm_host));
 	if (IS_ERR(host))
 		return PTR_ERR(host);
 
@@ -2511,6 +2530,15 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	if (ret)
 		goto pltfm_free;
 
+	/* Bayhub patch: resource assign and mmc_rescan routine overload */
+	if (of_find_property(node, "use-bayhub-bh201", NULL)) {
+		struct sdhci_bht_host *bht_host;
+
+		bht_host = sdhci_msm_priv(msm_host);
+		sdhci_bht_parse(msm_host->mmc);
+		INIT_DELAYED_WORK(&host->mmc->detect, mmc_rescan_bht);
+	}
+
 	/*
 	 * Based on the compatible string, load the required msm host info from
 	 * the data associated with the version info.
@@ -2727,6 +2755,9 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	host->mmc_host_ops.start_signal_voltage_switch =
 		sdhci_msm_start_signal_voltage_switch;
 	host->mmc_host_ops.execute_tuning = sdhci_msm_execute_tuning;
+	/* Bayhub patch: overload the mmc_host_ops.execute_tuning routine */
+	if (of_find_property(node, "use-bayhub-bh201", NULL))
+		host->mmc_host_ops.execute_tuning = sdhci_bht_execute_tuning;
 	if (of_property_read_bool(node, "supports-cqe"))
 		ret = sdhci_msm_cqe_add_host(host, pdev);
 	else
@@ -2750,6 +2781,9 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	if (!IS_ERR(msm_host->bus_clk))
 		clk_disable_unprepare(msm_host->bus_clk);
 pltfm_free:
+	/* Bayhub patch: release assigned resource */
+	if (of_find_property(node, "use-bayhub-bh201", NULL))
+		sdhci_bht_resource_free(msm_host);
 	sdhci_pltfm_free(pdev);
 	return ret;
 }
@@ -2763,6 +2797,9 @@ static int sdhci_msm_remove(struct platform_device *pdev)
 		    0xffffffff);
 
 	sdhci_remove_host(host, dead);
+	/* Bayhub patch: release assigned resource */
+	if (of_find_property(msm_host->pdev->dev.of_node, "use-bayhub-bh201", NULL))
+		sdhci_bht_resource_free(msm_host);
 
 	pm_runtime_get_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);

base-commit: c9e6606c7fe92b50a02ce51dda82586ebdf99b48
-- 
2.32.0

