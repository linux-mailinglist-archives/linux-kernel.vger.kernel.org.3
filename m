Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 025D249DB7C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 08:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237299AbiA0H15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 02:27:57 -0500
Received: from mail-mw2nam12on2085.outbound.protection.outlook.com ([40.107.244.85]:47937
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237284AbiA0H14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 02:27:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sshyuq1t+43UypDKWWDDJQ728q0Sw5m6/Ctqb5N7IiDCyKhCYGR20p+nsCu16z9rO3l/yRT5OzDD1e8vpy1bp2J7QOcUb1XoSRQKdBfFdGp66LhL1PI9n+TogjM96fgWb3RrL2GMAfSgDo6VJzRIcL0G8dqm+tqtRNSdvra2RtXRyMZgy3lPIbYSZlpDKFqDIljFvKN8BB4Glg74NZcZwKyPnMEAIumxFix3M+Mxj4lohY0kZjaAtq4y3d8COB9N8pSKL1i+n/I2kpeSp+8XA4xwXFKt7QcPq9WzO9PyXaE8sUT61CXS//f8sx5JAwOaePP7tnMReSPEcH56hZtPKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8o+dhjWFmScul3Jn90p/8qCG9iVtDvbXwjdnn4Dd7Y=;
 b=AQx3i4XWl7Gy8gCE5SQXTdup9LC5iSF3pcdTW1Y6+Uz6Dv5BmT+3/MV8Gpo1IP4LrgBvqH9hhZgwImi0eEKDsoklCRkCRaUEZM8rfElMKGtEBFDgEn/JoxXjEnZ0nUi843S//ylL+4uHCni8pvd7K8QBCiW7JbaBdanEIy2DI5b9Q9rT6+4JctrfA+g9j+UQQx7cj6SY47PGtTZ7FlYFb2kiPdD7YfCm4/AfYRjvqLdotxM8MdKGK6rxnqxQbw5cIpl9v6bFqxbDwqSzio+PMKYdwdlqlLBJ4o8R9JbS9v0yhGNsI8Z0u3F3SoZlhLCmB95XVJiBKdB7k5KDfTY4NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8o+dhjWFmScul3Jn90p/8qCG9iVtDvbXwjdnn4Dd7Y=;
 b=L2r9ZKCP9clEDIqRXnkkzcFvPTHCsnqNnKfYcizu8qC6VXumchox3MMF8ObX1X66g72QN9iobgLmFJo0jw/IkbCdHPqHhWWw4CTJ1w3HYGmmiLuW9KeluphAJ70h1oUjMnj7MthHzgXB1aF8J1dJofYOYOmiNgm/Jsjvumy3mCW14KcZPCqnmGSSAwowmSPiHmaKf34/KBIZ4P9aPjEYuTPHy2I/LajVmR2cpDxTaW0qRnPKePMMIdJOi7pJN/5G9U9yqzGmaHa1uC5vwp+UBFCeSN23owBNL3YQzfsXxsHVQtD4nyFCjw5XZ1Wfjsq6ErA53qZ7b7DE0nTccnkjTg==
Received: from MWHPR14CA0011.namprd14.prod.outlook.com (2603:10b6:300:ae::21)
 by CH0PR12MB5250.namprd12.prod.outlook.com (2603:10b6:610:d1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Thu, 27 Jan
 2022 07:27:54 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ae:cafe::1b) by MWHPR14CA0011.outlook.office365.com
 (2603:10b6:300:ae::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Thu, 27 Jan 2022 07:27:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 07:27:53 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL109.nvidia.com (10.27.9.19) with Microsoft SMTP Server (TLS) id
 15.0.1497.18; Thu, 27 Jan 2022 07:27:53 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9;
 Wed, 26 Jan 2022 23:27:52 -0800
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Wed, 26 Jan 2022 23:27:49 -0800
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <perex@perex.cz>, <robh+dt@kernel.org>, <thierry.reding@gmail.com>
CC:     <jonathanh@nvidia.com>, <mkumard@nvidia.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v2 2/5] dt-bindings: Add Tegra234 APE support
Date:   Thu, 27 Jan 2022 12:57:32 +0530
Message-ID: <1643268455-15567-3-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643268455-15567-1-git-send-email-spujar@nvidia.com>
References: <1643268455-15567-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88061fd1-79da-41e3-a2a8-08d9e166885d
X-MS-TrafficTypeDiagnostic: CH0PR12MB5250:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB525042B8855A2DECA5F29717A7219@CH0PR12MB5250.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B1Ulitj3AELCw9/xKds5DDlDAIwDS9pkBg7QK+ziESfQ9VPnRqo149daGFft8XOuZVhW6hnHAg2wtxu+0TL3vC1TrgBivpYHxBKFKNLAkGDu5r58mDiO7MZ6FWfDiQY7NX4kxJ2cTMosOmFOmg+RIbN4LL7bFZ9Dmlv/i7glTLkfUUQgaEKNVYbdQIiLbhRXUoKl51IH0kEnGpT5wN9/z9n90bLGasWvc6ht+po+F2dVheWrMnojglUwQKU3rrmc8UWITAkA48ZHX9mcze46GJsw2pkqlOUdTc+xAZyFVYS1fHBjPv1xB316Nv1j7QfQigXF7fB4q8eMgDQNQEFpCaLtP2LuKUAXFW8UcQ4fMo44yJ/GifB5fNUx2Wj1wBAyEKuUGi7ovOxqmw68PEHyLSGgNexjCNStr27F57P7QZn9pIKF+1S1Wzy6IdVm+q205bdiKjwC+MKw1OvfhQq8q0e4HoM0evgsokEXhobhOpGCDvWTSZN71k1ikyX8SSLhGg+BgzGyIQc7m5Xj3U/UDl9Vp9ltn5INWHQN83q8ULmS42fm2PDs3A3IncKGMrZCyHFwYNsy0w6NJBm55yFQQvO3DzuG7eWpctVW+B55PQuCzrM8E3APtZWhD1IlFCnMqLYsQl/vZZOlWnfbR5lR4QEOysJfNEVpXu33Mj4B2oia4DTTbWLvcvMzwjaDyZYQ5cqUL5eOmVLrrF+9ZGf9nQ==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(508600001)(54906003)(40460700003)(6666004)(110136005)(7696005)(82310400004)(86362001)(47076005)(36860700001)(83380400001)(2616005)(356005)(316002)(426003)(336012)(2906002)(26005)(186003)(107886003)(5660300002)(36756003)(7416002)(4326008)(70586007)(81166007)(8936002)(70206006)(8676002)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 07:27:53.9293
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88061fd1-79da-41e3-a2a8-08d9e166885d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5250
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clocks, power-domain and memory bindings to support APE subsystem
on Tegra234.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 include/dt-bindings/clock/tegra234-clock.h     | 74 +++++++++++++++++++++++++-
 include/dt-bindings/memory/tegra234-mc.h       |  7 +++
 include/dt-bindings/power/tegra234-powergate.h |  9 ++++
 3 files changed, 89 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/power/tegra234-powergate.h

diff --git a/include/dt-bindings/clock/tegra234-clock.h b/include/dt-bindings/clock/tegra234-clock.h
index 8d7e66e..635b5fb 100644
--- a/include/dt-bindings/clock/tegra234-clock.h
+++ b/include/dt-bindings/clock/tegra234-clock.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (c) 2018-2019, NVIDIA CORPORATION. All rights reserved. */
+/* Copyright (c) 2018-2022, NVIDIA CORPORATION. All rights reserved. */
 
 #ifndef DT_BINDINGS_CLOCK_TEGRA234_CLOCK_H
 #define DT_BINDINGS_CLOCK_TEGRA234_CLOCK_H
@@ -9,6 +9,26 @@
  * @defgroup bpmp_clock_ids Clock ID's
  * @{
  */
+/** output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_AHUB */
+#define TEGRA234_CLK_AHUB                       4U
+/** @brief output of gate CLK_ENB_APB2APE */
+#define TEGRA234_CLK_APB2APE                    5U
+/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_APE */
+#define TEGRA234_CLK_APE                        6U
+/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_AUD_MCLK */
+#define TEGRA234_CLK_AUD_MCLK                   7U
+/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_DMIC1 */
+#define TEGRA234_CLK_DMIC1                      15U
+/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_DMIC2 */
+#define TEGRA234_CLK_DMIC2                      16U
+/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_DMIC3 */
+#define TEGRA234_CLK_DMIC3                      17U
+/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_DMIC4 */
+#define TEGRA234_CLK_DMIC4                      18U
+/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_DSPK1 */
+#define TEGRA234_CLK_DSPK1                      29U
+/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_DSPK2 */
+#define TEGRA234_CLK_DSPK2                      30U
 /**
  * @brief controls the EMC clock frequency.
  * @details Doing a clk_set_rate on this clock will select the
@@ -20,8 +40,60 @@
 #define TEGRA234_CLK_EMC			31U
 /** @brief output of gate CLK_ENB_FUSE */
 #define TEGRA234_CLK_FUSE			40U
+/** output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_I2S1 */
+#define TEGRA234_CLK_I2S1                       56U
+/** @brief clock recovered from I2S1 input */
+#define TEGRA234_CLK_I2S1_SYNC_INPUT            57U
+/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_I2S2 */
+#define TEGRA234_CLK_I2S2                       58U
+/** @brief clock recovered from I2S2 input */
+#define TEGRA234_CLK_I2S2_SYNC_INPUT            59U
+/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_I2S3 */
+#define TEGRA234_CLK_I2S3                       60U
+/** @brief clock recovered from I2S3 input */
+#define TEGRA234_CLK_I2S3_SYNC_INPUT            61U
+/** output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_I2S4 */
+#define TEGRA234_CLK_I2S4                       62U
+/** @brief clock recovered from I2S4 input */
+#define TEGRA234_CLK_I2S4_SYNC_INPUT            63U
+/** output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_I2S5 */
+#define TEGRA234_CLK_I2S5                       64U
+/** @brief clock recovered from I2S5 input */
+#define TEGRA234_CLK_I2S5_SYNC_INPUT            65U
+/** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_I2S6 */
+#define TEGRA234_CLK_I2S6                       66U
+/** @brief clock recovered from I2S6 input */
+#define TEGRA234_CLK_I2S6_SYNC_INPUT            67U
+/** PLL controlled by CLK_RST_CONTROLLER_PLLA_BASE for use by audio clocks */
+#define TEGRA234_CLK_PLLA                       93U
+/** @brief output of the divider CLK_RST_CONTROLLER_PLLA_OUT */
+#define TEGRA234_CLK_PLLA_OUT0                  104U
 /** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_SDMMC4 */
 #define TEGRA234_CLK_SDMMC4			123U
+/** @brief output of mux controlled by CLK_RST_CONTROLLER_AUDIO_SYNC_CLK_DMIC1 */
+#define TEGRA234_CLK_SYNC_DMIC1                 139U
+/** @brief output of mux controlled by CLK_RST_CONTROLLER_AUDIO_SYNC_CLK_DMIC2 */
+#define TEGRA234_CLK_SYNC_DMIC2                 140U
+/** @brief output of mux controlled by CLK_RST_CONTROLLER_AUDIO_SYNC_CLK_DMIC3 */
+#define TEGRA234_CLK_SYNC_DMIC3                 141U
+/** @brief output of mux controlled by CLK_RST_CONTROLLER_AUDIO_SYNC_CLK_DMIC4 */
+#define TEGRA234_CLK_SYNC_DMIC4                 142U
+/** @brief output of mux controlled by CLK_RST_CONTROLLER_AUDIO_SYNC_CLK_DSPK1 */
+#define TEGRA234_CLK_SYNC_DSPK1                 143U
+/** @brief output of mux controlled by CLK_RST_CONTROLLER_AUDIO_SYNC_CLK_DSPK2 */
+#define TEGRA234_CLK_SYNC_DSPK2                 144U
+/** @brief output of mux controlled by CLK_RST_CONTROLLER_AUDIO_SYNC_CLK_I2S1 */
+#define TEGRA234_CLK_SYNC_I2S1                  145U
+/** @brief output of mux controlled by CLK_RST_CONTROLLER_AUDIO_SYNC_CLK_I2S2 */
+#define TEGRA234_CLK_SYNC_I2S2                  146U
+/** @brief output of mux controlled by CLK_RST_CONTROLLER_AUDIO_SYNC_CLK_I2S3 */
+#define TEGRA234_CLK_SYNC_I2S3                  147U
+/** @brief output of mux controlled by CLK_RST_CONTROLLER_AUDIO_SYNC_CLK_I2S4 */
+#define TEGRA234_CLK_SYNC_I2S4                  148U
+/** @brief output of mux controlled by CLK_RST_CONTROLLER_AUDIO_SYNC_CLK_I2S5 */
+#define TEGRA234_CLK_SYNC_I2S5                  149U
+/** @brief output of mux controlled by CLK_RST_CONTROLLER_AUDIO_SYNC_CLK_I2S6 */
+#define TEGRA234_CLK_SYNC_I2S6                  150U
 /** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_UARTA */
 #define TEGRA234_CLK_UARTA			155U
 /** @brief CLK_RST_CONTROLLER_CLK_SOURCE_SDMMC_LEGACY_TM switch divider output */
diff --git a/include/dt-bindings/memory/tegra234-mc.h b/include/dt-bindings/memory/tegra234-mc.h
index 2662f70..444e62d 100644
--- a/include/dt-bindings/memory/tegra234-mc.h
+++ b/include/dt-bindings/memory/tegra234-mc.h
@@ -1,4 +1,5 @@
 /* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/* Copyright (c) 2018-2022, NVIDIA CORPORATION. All rights reserved. */
 
 #ifndef DT_BINDINGS_MEMORY_TEGRA234_MC_H
 #define DT_BINDINGS_MEMORY_TEGRA234_MC_H
@@ -7,6 +8,8 @@
 #define TEGRA234_SID_INVALID		0x00
 #define TEGRA234_SID_PASSTHROUGH	0x7f
 
+/* NISO0 stream IDs */
+#define TEGRA234_SID_APE	0x02
 
 /* NISO1 stream IDs */
 #define TEGRA234_SID_SDMMC4	0x02
@@ -20,6 +23,10 @@
 #define TEGRA234_MEMORY_CLIENT_SDMMCRAB 0x63
 /* sdmmcd memory write client */
 #define TEGRA234_MEMORY_CLIENT_SDMMCWAB 0x67
+/* Audio Processing (APE) engine read clients */
+#define TEGRA234_MEMORY_CLIENT_APER 0x7a
+/* Audio Processing (APE) engine write clients */
+#define TEGRA234_MEMORY_CLIENT_APEW 0x7b
 /* BPMP read client */
 #define TEGRA234_MEMORY_CLIENT_BPMPR 0x93
 /* BPMP write client */
diff --git a/include/dt-bindings/power/tegra234-powergate.h b/include/dt-bindings/power/tegra234-powergate.h
new file mode 100644
index 00000000..8e28fcb
--- /dev/null
+++ b/include/dt-bindings/power/tegra234-powergate.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2018-2022, NVIDIA CORPORATION.  All rights reserved. */
+
+#ifndef __ABI_MACH_T234_POWERGATE_T234_H_
+#define __ABI_MACH_T234_POWERGATE_T234_H_
+
+#define TEGRA234_POWER_DOMAIN_AUD	2U
+
+#endif
-- 
2.7.4

