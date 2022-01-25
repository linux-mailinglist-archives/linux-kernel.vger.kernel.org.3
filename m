Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC3949AC19
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 06:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240887AbiAYF5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 00:57:49 -0500
Received: from mail-dm6nam10on2045.outbound.protection.outlook.com ([40.107.93.45]:53575
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240524AbiAYFz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 00:55:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9EoQPvIXb/IirFpKiboM/RmEI1goOujCIjayaEVOMtHQgF39xDbt8F77Zm39Ka35W7NY2X1c+JtEDBFUyp4FX8aPJkf7e4Kd709g7ZWQUNq3hz89OHoEtms5MOwu+35UmatTBcRDGkIGghoCeG/q27MHqVsYgFMReioFkVgLJIoxuK4tMZsQX2JsLilgXNVYD9MQMJ1Rq0R4hxYbz8N1p/AWat3wFToi+zOCITR2s16p0GogQ8Nhqm6J2SeUrAnSVQZQFhu/dje4rVXL1/kbUqUDQzK72+2UA9+QClCeiPioyj3AOV0LOgpX5mUv/bh8PxAO6gveuE2u+SUH0SsLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8t442sqYo7CNkPqZbrYZm67XBdg8RSTrFfdLvq/6y0s=;
 b=ggKFoX0NNHYg+oAAA4HgYu24rchcW8KwoB6lJm+ychqg024qBTzG/ycde3nvQgM8Zw/BZ+S2+qclfqDZay25J0eBTd02xOKtIeHTzWWRAksSsqh4BCRNJN5VNEK5e1Zszj7vUpw0mTkhdyKB190oOUtu9safl0bAIlgY6Xxr3Wl5p2PEgDzych5WMXyBZA5v3cd5Sx0fA7/8zUyNaTPYkb68+9x7RQ041u/5Z5N12McCG5Sp9a2spYBsQsMs+f0srczR9eMZDajQdOZ1SOIoDYY0xpk2xSdY3GGgd0PxSSBVOfH43I4TCA1Em4kaq/cN//wzlqnQ+nh0BDUqpG4Q+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=baidu.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8t442sqYo7CNkPqZbrYZm67XBdg8RSTrFfdLvq/6y0s=;
 b=gg9OA8WE551Ojsu3TO7gWl+aYgM1ljpdABdOba3Bv2AMb+/KKv2h7rodwDnwHXjGbM2Dr2QwVmrYbL/CC7W8F3OwPHmujQN3/2e1MkXem09AJ7KSRsQDH1nNIbbbHN4emLkZn6j4h8rwoTZ/UQp35Jr7yRjVNnR9lU6uLJO/3WqhSTHDCCGWnXrc9KaJuSZg0WIcldnYLztlqdKzGAUCeMzY/Tsv3i3tdilvQS9mjvwvNMyCZ5UswA/jCxOdYvIDUmS4aaQQAc1cjmjAFdB1sFcGAoAszRhYDSy0KDJrVcSnBgXi2V3qcdS3/+E2ai/XD1hdemT/QNX8Pq3txOEpAQ==
Received: from DM6PR07CA0131.namprd07.prod.outlook.com (2603:10b6:5:330::19)
 by DM6PR12MB5005.namprd12.prod.outlook.com (2603:10b6:5:1be::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Tue, 25 Jan
 2022 05:55:26 +0000
Received: from DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::af) by DM6PR07CA0131.outlook.office365.com
 (2603:10b6:5:330::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7 via Frontend
 Transport; Tue, 25 Jan 2022 05:55:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT040.mail.protection.outlook.com (10.13.173.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4909.7 via Frontend Transport; Tue, 25 Jan 2022 05:55:24 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.18; Tue, 25 Jan 2022 05:55:24 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9;
 Mon, 24 Jan 2022 21:55:23 -0800
Received: from kkartik-desktop.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Mon, 24 Jan 2022 21:55:20 -0800
From:   Kartik <kkartik@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <digetx@gmail.com>, <ulf.hansson@linaro.org>,
        <christophe.jaillet@wanadoo.fr>, <kkartik@nvidia.com>,
        <andriy.shevchenko@linux.intel.com>, <jckuo@nvidia.com>,
        <caihuoqing@baidu.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] soc/tegra: pmc: Add Tegra234 wake events
Date:   Tue, 25 Jan 2022 11:27:42 +0530
Message-ID: <1643090262-26127-1-git-send-email-kkartik@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49815307-ccbd-488a-5124-08d9dfc747c1
X-MS-TrafficTypeDiagnostic: DM6PR12MB5005:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB5005C7CB8605E9CC348D4155CD5F9@DM6PR12MB5005.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ij6hSFNNIW5/rH3o1OJuQV5Hy7x+zIDBRwyJhEeCWTKVgBgH3lJbNDVSDS7lZ03eLALw3tbw2LrVd/lTGeGdY4b/DidjHes/LyZfzxNZZrzy7l69RX+6WNYkBNnEjUBNuldTguvwMzOpimtTGDm8RPefe39lTWmCfYGPT1H8QUlCHOXkKDLg7WGyVeNWztNkM02eVNa52hEAYlY/cl0BoNoCeydVY1jmM9Bgd5cDw8eVI6Q9KbeEWaIFh54NLzclcZ1dr6KmwRWltUzuXESmPXTO1+h3GdRfZjS4sXcbiz1KPDXqV/tIWjfFt7L5vZbpHS49nEH1r1aKXd9ONha/5idBPY9wXyh6Z0sAA25dm0qrSU8WrDPS8JDpdjZZDjjmtBxI3QpDiMeJtAxrME1X9LWk69QrqKdPcdmdpgo0Yz3618pcHYSefsopaDQxFz7yoe4TaGE0h6KhzLhjqW6i7D8o+QJvz/fA6FrI7xotbNYckXpXwhDyp56taMByTWQcHeJ1koHpoquGl/nrSZjFzyR0+WSBVUFc2qjBGrbObSBScvldLsqHtQiWjbrhZoXJpLy2rz4uupVPIVlcEmA76DU/n5rf5zmUd9TaF4T/oQKPrjSqb2oc4gDvzV0miSpwwQwm2ZKXA2DYoeO+h8+nYBbrZOqDtwp9QomU+TjSjeyKiO7hAXZ3Vqt4rJeSokFAnmhmWFHxU1NIgykN/0t9yyY1ojgkVhu9UNmCc8Xlj5CyY/m2RS+kBGMhgMtv96+FekgGDhVXoy5wVbq8+bdbmAzZTSap82Bqct5NP70a8CLA1Ho+2RK93hU5s8WgdKKR
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(46966006)(40470700004)(36840700001)(36860700001)(426003)(110136005)(82310400004)(36756003)(81166007)(2906002)(921005)(336012)(508600001)(70586007)(47076005)(2616005)(186003)(8676002)(70206006)(6666004)(356005)(8936002)(86362001)(7696005)(83380400001)(316002)(5660300002)(40460700003)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 05:55:24.3723
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49815307-ccbd-488a-5124-08d9dfc747c1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5005
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kartik <kkartik@nvidia.com>

Enable the Tegra RTC alarm and power key wake-ups for Tegra234

Signed-off-by: kartik <kkartik@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 5aceacb..0edb7f8 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -3,7 +3,7 @@
  * drivers/soc/tegra/pmc.c
  *
  * Copyright (c) 2010 Google, Inc
- * Copyright (c) 2018-2020, NVIDIA CORPORATION. All rights reserved.
+ * Copyright (c) 2018-2022, NVIDIA CORPORATION. All rights reserved.
  *
  * Author:
  *	Colin Cross <ccross@google.com>
@@ -54,6 +54,7 @@
 #include <dt-bindings/pinctrl/pinctrl-tegra-io-pad.h>
 #include <dt-bindings/gpio/tegra186-gpio.h>
 #include <dt-bindings/gpio/tegra194-gpio.h>
+#include <dt-bindings/gpio/tegra234-gpio.h>
 #include <dt-bindings/soc/tegra-pmc.h>
 
 #define PMC_CNTRL			0x0
@@ -3788,6 +3789,11 @@ static const char * const tegra234_reset_sources[] = {
 	"FUSECRC",
 };
 
+static const struct tegra_wake_event tegra234_wake_events[] = {
+	TEGRA_WAKE_GPIO("power", 29, 1, TEGRA234_AON_GPIO(EE, 4)),
+	TEGRA_WAKE_IRQ("rtc", 73, 10),
+};
+
 static const struct tegra_pmc_soc tegra234_pmc_soc = {
 	.supports_core_domain = false,
 	.num_powergates = 0,
@@ -3812,8 +3818,8 @@ static const struct tegra_pmc_soc tegra234_pmc_soc = {
 	.num_reset_sources = ARRAY_SIZE(tegra234_reset_sources),
 	.reset_levels = tegra186_reset_levels,
 	.num_reset_levels = ARRAY_SIZE(tegra186_reset_levels),
-	.num_wake_events = 0,
-	.wake_events = NULL,
+	.num_wake_events = ARRAY_SIZE(tegra234_wake_events),
+	.wake_events = tegra234_wake_events,
 	.pmc_clks_data = NULL,
 	.num_pmc_clks = 0,
 	.has_blink_output = false,
-- 
2.7.4

