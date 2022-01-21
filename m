Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 087B4495E34
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 12:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380104AbiAULJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 06:09:56 -0500
Received: from mail-bn8nam11on2125.outbound.protection.outlook.com ([40.107.236.125]:24211
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1380096AbiAULJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 06:09:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hAQ/oX67scOJ1n092QXTqODnk2+HGumGOZgAe4Cgwq8PBDrJ29u8+5zsJVIlx9Qg36K2/wD0CRMCb5OW62tw3BZvYR+ZsVvofscU7Ac/nWj7qoQkANlkWdM0jKdxAPA9UOCcwMYTCm7uRbCJqzT1YcAPC/thz6wplPhp/6tRFk4BlyKDmT6u1vwOpxJvUzMJXifPWhRIBgVWIv0Vgs4qHAc18wrRtvpRdVTtYAmKRjJfNl6IXS/0mCw9Sg2tuhR3zSIahks0EZsjxmQ2KSf2ZHrgR6s/ILlcCTRu7UXVTa5Oj6Aoayhz4QOd/HANwYc44aqnBfmpyYdNXB2panZeZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2BlyZ3sjh/VIH/O0b3FwkoibEK+bSExPAw4+q/38q0=;
 b=YXdEcCMD6dafNeQpqrBfs/9MyYD3u7qaNP5vQxH1jGXKPkGkKT/AixX4ygg8WmtoFiaLHW9qFAm2FkHppijh6o1nRFqgdJ7DWSVtZN+90TtI3xhLW2bcog/JB43LCtS8E80thpyRQ+ZySngW/Gbx/Pyb2glYHmxrn+u2IUWAdfcv37M9IqA/BaL8WiJQtYlVD+ajCCskM6sH8CiXOe3X3FEA/Qh+9azzku/SIJwijGdLcCvAVqnSMFHEn4RPVcF/pWKHH0poDpCpL0jNcM4+Ry42k4SdNc1eBe0ZFnTGe1U7yIbasM2Lpr1fvnNXuQK2/BYSTyj9TFA0E0uqhtBW7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com;
 s=selector2-towerbridgetechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2BlyZ3sjh/VIH/O0b3FwkoibEK+bSExPAw4+q/38q0=;
 b=gEDhmdmbxnwM5EyeqQBqd0iWe6QWEsLjJRFZc5WGS1ucfc+LgBvw+VoJrulwGvSH82cd37fpKDRG8lBBCke5lHIb4pFeXW5NU6aaE28xUxxgxMY9siGl8trCrRYCmOi7PlnHw+cHnrI6SBEaYjWsLWdAdiuafrGU6LP7b9h3vws=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bayhubtech.com;
Received: from PH0PR16MB4248.namprd16.prod.outlook.com (2603:10b6:510:4c::16)
 by MWHPR16MB0014.namprd16.prod.outlook.com (2603:10b6:300:e7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Fri, 21 Jan
 2022 11:09:24 +0000
Received: from PH0PR16MB4248.namprd16.prod.outlook.com
 ([fe80::e88f:f199:eed:4645]) by PH0PR16MB4248.namprd16.prod.outlook.com
 ([fe80::e88f:f199:eed:4645%7]) with mapi id 15.20.4909.010; Fri, 21 Jan 2022
 11:09:24 +0000
From:   Chevron Li <chevron.li@bayhubtech.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shirley.her@bayhubtech.com, fred.ai@bayhubtech.com,
        xiaoguang.yu@bayhubtech.com, shaper.liu@bayhubtech.com,
        bruce.yang@bayhubtech.com
Subject: [PATCH 1/2] mmc:sdhci-msm:fix Qualcomm sd host 7180 SD card compatibility issue
Date:   Fri, 21 Jan 2022 03:09:08 -0800
Message-Id: <20220121110909.104-1-chevron.li@bayhubtech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0180.apcprd02.prod.outlook.com
 (2603:1096:201:21::16) To PH0PR16MB4248.namprd16.prod.outlook.com
 (2603:10b6:510:4c::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 268bbafb-69b2-4d04-c8eb-08d9dcce7b49
X-MS-TrafficTypeDiagnostic: MWHPR16MB0014:EE_
X-Microsoft-Antispam-PRVS: <MWHPR16MB001496714852B723C4936F41EA5B9@MWHPR16MB0014.namprd16.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BuRYvmZoLXCbTcOS9cNY9B6Ml7ZbeTaBBvIPFOIs+0RSAJXtF5m0zBkRpTJYc3AD4c8gUdVZP3MU0KzL7AQhTOGgKhiR29KYpDOX3Co6xr7Bp5yfow34S9xCPeIWq0ES/1Cd7lT9rl8JCypOrlfCZb4dDYTD8AB3OoDTffUOK6DUd6j+dHrQXYtUaXt3lP2/K2hUetyJL2VYufHtmTiCYCCiRct9jHjOpXTafjk+SVZl3T1RGs9JqMa4Btfjtl/GB+AhapzxgeL5sSXfLsuGi9I19RlZxLnsTgypZFPbc6soXWcaWgbnLa2hVWT4OzRvGDyeRJNb/g5dTNlbv6OUfFK8Uh+xPvn1FqRB9t/CMac3+rLyMPSGBw9yr+X70Sn3WXbER3JzMgccLDPuX9kzJIqSwWz7hi04JqtmLdGDnvsdbqLHGXBqfYSBjzuzrrgKA1GGL1Nc9h1l6ii/5Td2AIE1O/YeJVZmLQw+pWpsn/2udTkWbmWr0BOqYD9dyl9xti88CwY41e41dP1BXi6iV27zPQ17YkoJzYgnBF64C9ac3STxlQdyC84q1DR9U8/xbqBN1E1Q8OnPgWuYoh4xiQXRbabbUAeyo6JiAiIEdHQolcFjmOVlurCvE2WmHn/o++kllB3weIZfGJwcjhTCRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR16MB4248.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(39830400003)(366004)(136003)(4326008)(6486002)(86362001)(8936002)(1076003)(83380400001)(8676002)(6512007)(6666004)(316002)(5660300002)(107886003)(186003)(2616005)(66476007)(66556008)(66946007)(2906002)(508600001)(6506007)(44832011)(38100700002)(52116002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HVFnq5PvsTD+iaiAbScDy+auLXlCbcpH67J+hDLjpAsSHahHmzSNCLZRtarD?=
 =?us-ascii?Q?q4Tzeuf88KfBdjNrOm43E8LP4omXKi0DZYV/svgA15E0oBr1y1vmb+CpW5Vn?=
 =?us-ascii?Q?4YeG4SlikOAFiWsiXqNpZzSt9XSMKGHDIKgSFEJW3/n8EUXnciSnGRkEmvla?=
 =?us-ascii?Q?XhQSTdl5k/2TmMawOLkfQo0YKZAwMf2x3UFzfCorNPcMXY12bTLJ2eME4A7X?=
 =?us-ascii?Q?qasa1OZN1EluGf4dkIgR2oMVgeOLHSLcgTyAbIAZPZvFTanOELcnfN/62XBd?=
 =?us-ascii?Q?nDvIzLZ6cbjarHVE9nLjQW2+Lgdq+mcW/ghIjQJYdocDqcZLuMIHqf2mh8eq?=
 =?us-ascii?Q?aJBTWC088xZ1tyHy+ja6v0+HkXT0rmqbj0HxtK3nR0ftVXiSh065D5AH2Hn1?=
 =?us-ascii?Q?CjBz8uHj2xxMf9ZpC/i7VDRWD+4L3KiY9ahpiRJzcZhsdJA8GM7O/PRFlU1q?=
 =?us-ascii?Q?4BXPKwnOHHbIil055/pf0cd70sS5PyXDzPyxY63Zw+jKoDbP+6o79s/U5tUr?=
 =?us-ascii?Q?3QGgmbR6Up6hOF0e25jaj/U9vX0jYyl8pM0CK0bMJYzgJ/RzA9xAsMkWTOYP?=
 =?us-ascii?Q?2K6YAPdHSnScCk79TpCRB2qTtU8B0aWvn746yH5XWvEFqE47jIrWiuYSPlGG?=
 =?us-ascii?Q?7ApPrc1iAtKW5NhvDKoFaYMhP2v8fXRwg6gc1VLuYGPimJeQUSM+0exrMaDC?=
 =?us-ascii?Q?MPXcWbDuze4ZkWUXU/I644y+rpaLaSYgdnOeA9uIXrTPcxn67GnUocqdzP9t?=
 =?us-ascii?Q?jdi578br3K+8F+vVTnAODWD3gDGj24ABwAFStEFcdnLyPAGZSRnwiV104CEF?=
 =?us-ascii?Q?jsjd5oIdFBA6cOCvBe92QQ52x+gwO0FRg57RbpEKGYupjb8tJd6Cf+XaxvDQ?=
 =?us-ascii?Q?kTIZda31I+HDEVXiwAtkgn/dOV4SJ4jRjDuJ5d8g4xoxtp+i5ch/Izf88E8g?=
 =?us-ascii?Q?rBPEExG+Rp9MzCUWt7oadEWPoF5UT1KQCStzPfUzz0pPE6SjggR9vPrOyX0N?=
 =?us-ascii?Q?BdV13y54LTqnNblbegHulSz5u1u60zimCxVBqItXH/Qu3Z24sWGYguLCX6Wu?=
 =?us-ascii?Q?wIpzk3g8jBteXQJhKcelkkZR+N+g4WxgotKfDJ6t+yMIZ38cDkI0CGaIaOjA?=
 =?us-ascii?Q?rF2Tp3okgMH2chWLK9zDHzJ1V0M4xNdsLgqE/Kzfv6JLKfZjaMMVeL8+K3vg?=
 =?us-ascii?Q?MPtnRf5cgetyYe9pbpsrvazrXTQN+PJnxzHr7GGR386HicA/+cW3DwwGzDGw?=
 =?us-ascii?Q?wVjCpBkc2a2iPnW5rmGnvK5lDGdoPf44INzeQOmR+8oDFVkNxRboAgfqQOQo?=
 =?us-ascii?Q?Ia1ZbDPoRgDr68GuzsRAPyN5jF8SeFoSxTP/sdMTqZZHSITo3YXefLuhvFSR?=
 =?us-ascii?Q?AfNe3g3io4gW0PKR6XA+vUssPlm0M/9vbwDA/Ce+71WNcJg3WrRG8FMhM7iP?=
 =?us-ascii?Q?wMI9F9z2pyE36Wc0rb7RQyPOsKb8iGtSTggnq8S7P4owQhwvqVzfulaqIgTh?=
 =?us-ascii?Q?YB823gC+RtYXh7MKY43tLgW5MFbSfZE0bmab512CBw+6X1YyBJMGG4T0yyXB?=
 =?us-ascii?Q?Pt/SqMPxjPvvAP/mcSsZOSqTTNZqe/spJyQwRPcAy23oo5q+DyLA7wfqJ+95?=
 =?us-ascii?Q?MKfhzIxrVYnvSy4vyY5yl25ulQw0dVktZSCNgrCu3SZK9LlTlS++iRBgzwxa?=
 =?us-ascii?Q?h11bbu/Cfb7bM917r29Z/PdLL+tK4gsnoyQVEnLYMTCvxcwgrhcjfTtyfZmv?=
 =?us-ascii?Q?XfYVMp2lIymh+bOKe9xYnrObvWQxidY=3D?=
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 268bbafb-69b2-4d04-c8eb-08d9dcce7b49
X-MS-Exchange-CrossTenant-AuthSource: PH0PR16MB4248.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 11:09:24.2254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YFchzlaEFYssBaKIY27cwFkRDAyUrliyhQL4+7eoLwaJebTjnhGAsiZqx2oBU6dy+sm3yuqOuE9O5x4Nk03yRLNb8e2vqSlR9iDSx941NMs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR16MB0014
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

