Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB3649F993
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 13:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348563AbiA1MiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 07:38:22 -0500
Received: from mail-bn1nam07on2041.outbound.protection.outlook.com ([40.107.212.41]:21316
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348556AbiA1MiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 07:38:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggJFmxPornPiaoaShJTdRTNMMOUbRckWWMlxmgXjWDMyLpZgPZJw2+6FdnXZogLMTuX/CxjwIanqefI715RWmMO9Kqt1+a/QJsnCynwLmK0tIKv3zqZFcTfOInkvCJ6EtC13zZPfGWk1zAhrIUChqHGuDxwvFzuYpWcTYpldXxbLARuD0AjeR5gjObPoVkHSE1RIEC2Plna9L58vaIj0V4U2EZE4oEeJmUvECqT9CcujKZ7aY5X9Qrfyi86M25XOusiVMWuWoFzmoYVsrQuK56kBl9nZKEIFQMYZkxxysP45NIU+eBulr9OquDRRS5StKM4aYy8hqpxzab6nq7hRGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8o+dhjWFmScul3Jn90p/8qCG9iVtDvbXwjdnn4Dd7Y=;
 b=PndJfDooy3yDzP5zOiRiqInPceB+V+QG2OGOKSBpblH6r9iJ2u52HE3GbX2T27sEmiosGEHWoJXNtM6D7BPziZjNMlaUjP3ETssLzJdTm916PE8O7afKSePjFQ3VkiQKxynVVHaRAifaC+u349VpEBmacKER0yEIMkcnRGAIFBRA0pQX/fXyjV1DQYSQfYNE/bHRshXfN58D8w4oHpO2sXRUT9n05xaDl0HGfAWxyiUcvguVBoYkHkY+g5eZK36oS2tpJQwBdNSt9qmyLZ+tlA4qA7lf2D7zIYio8ZJ3HNpCi/9RYSz6qDC5P9+Xs4vPS292W9PGsfMTgvMI1x00Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8o+dhjWFmScul3Jn90p/8qCG9iVtDvbXwjdnn4Dd7Y=;
 b=J8DV+Q3ef/jBKj8hVoWELebzL955749WlTW/w6Ivi53tAXNxVPK4lRVB4zOu82hJRxkeGkGru35pwH6OuRDngLdaA1qpgPItAsp4/JQ7yI11626L7+0utVwSM2BuR7CHt5BWSlXfIGwAeCXCZqQICVm0NoBQp1MDe5EUbX7CnEJNsfx5nEwatKF/Cm5I8a2a+orgHc4U2xnROxMHKV5T9b15K2j9gk2SY1YvpmSEGyWYHn1B4WbURNy7XQ3J3qccghc2ia4o6IyvRrTFUDtVvkP+ZJH1Lmlw4KDBtce/7qpmqr5WrLMNFsSPujqu2JOc2i6dUaycPpvvSsWm9yqk4Q==
Received: from BN9PR03CA0870.namprd03.prod.outlook.com (2603:10b6:408:13d::35)
 by DM6PR12MB5566.namprd12.prod.outlook.com (2603:10b6:5:20d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Fri, 28 Jan
 2022 12:38:15 +0000
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::87) by BN9PR03CA0870.outlook.office365.com
 (2603:10b6:408:13d::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Fri, 28 Jan 2022 12:38:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT010.mail.protection.outlook.com (10.13.177.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 12:38:14 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL101.nvidia.com (10.27.9.10) with Microsoft SMTP Server (TLS) id
 15.0.1497.18; Fri, 28 Jan 2022 12:38:13 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9;
 Fri, 28 Jan 2022 04:38:13 -0800
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Fri, 28 Jan 2022 04:38:10 -0800
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <perex@perex.cz>, <robh+dt@kernel.org>, <thierry.reding@gmail.com>
CC:     <jonathanh@nvidia.com>, <mkumard@nvidia.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v3 2/5] dt-bindings: Add Tegra234 APE support
Date:   Fri, 28 Jan 2022 18:07:53 +0530
Message-ID: <1643373476-8538-3-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643373476-8538-1-git-send-email-spujar@nvidia.com>
References: <1643373476-8538-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40b36af6-57cb-461c-fc95-08d9e25b0d8e
X-MS-TrafficTypeDiagnostic: DM6PR12MB5566:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB55661DF0C131C58C247A133AA7229@DM6PR12MB5566.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9YEcJwIepGOZ0KIJHVyRgVcu2yhGXNqqbyvDPhAvxXxNl75PQI9PFAaHihonm5C9eipfF4hbWgAC9HrE5V64fnPw9ogDbzOz3PApsYzm7eeG6VF5GlGskksgjjl3fSw4Vc0AVPjusJ6tYd7aqyZRUaWXXBRLVqoSP6SFOaGyk2jF+H2Nh+PiqVqBBJ5YtDje3ZREVDlcxcAhyDZ77q28zBob/scxK4PaZaEUE7eBnA+KjJGsTQ4cRwZqB5tbCPyoOpqwkb5z9DIvzGQkwB25qGQ/lLxzvYQOcnryTIydGvbto9eqZ6y6NiCjNVZLIADzKuxIJ8AR4kl9pe1lfJjUZbxmwYgeGtj/PMhArL0tVE+qbhtUrbmx5IqalxKGwvhAi8IDvR59m60ZoDcSIZkQNmmedIzqyoQoaVWiCEhCDp74LvC0tNqAWmxPYTx/GjkDzN2dd0DSvjLGzIl9WyjqzciHfB0DU7bxtMlh3++506kA76K/Rt1PcQxoxjy941YhgrMRCkhbQHXwvw8G/u8/I5KYJPzU4m/oAV6r6Fgvzq8HV2+zVcrIT+oPsgw7yzN7zG9AUtcNfPgMv8WTaztKK+Dqj203/I0aH0cZRXRolPXIk3b4Uw4oITqkfi1iUIvaPiVCsoaIaBUFi793veBJtzCTgRuoQatrI7+etKVT39V50li7uSKARreZzpvTn+qF88h0m6SFBqyJ9yQVlyYu4A==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(26005)(81166007)(426003)(356005)(336012)(82310400004)(107886003)(186003)(508600001)(6666004)(83380400001)(36860700001)(7416002)(2906002)(47076005)(2616005)(5660300002)(7696005)(70206006)(70586007)(86362001)(40460700003)(110136005)(54906003)(8936002)(4326008)(8676002)(36756003)(316002)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 12:38:14.5293
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b36af6-57cb-461c-fc95-08d9e25b0d8e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5566
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

