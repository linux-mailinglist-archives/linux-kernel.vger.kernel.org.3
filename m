Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0626749AE92
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 09:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1453096AbiAYIwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 03:52:13 -0500
Received: from mail-bn8nam11on2061.outbound.protection.outlook.com ([40.107.236.61]:19457
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1452453AbiAYIs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 03:48:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PkdBMRiZMvLBe/mOFQZCDSTM4HrJFrlCSwsLiOt93mq+FwYJIlSW/OSY2h54/XHjtrZIkAZKBYZCi4sfeiSqL8ujgWLJ3NadohYO70WKJz4Ww4ukEu51PqC52lfXEIRlgfvzIDt8RE/y3Fp57BkAYvm0VUzKQdRLMCU0z407e5sZNzFE/fzhgQwfjS0zmK5nXv+BrKzauJuinxvB91Zc+BQQLT9Wa0lugxMNOTWkphXAn2632vk96rKksiSTuLu/KEwgCw0vSgB/nzbu4hStVLX8xyH9PQRTqx0B8oImGSsyt8M1Hx3gIs4FYJMjqsEy26HeQNL8CzdUJ05+nSF7Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtQ4RqxHB8FkwUvd78mkf2dv+4Lop7bbo7tBBMqpIBw=;
 b=Eug9NOnyH7HLZRnWsoLYFNGORust7Q54s9lhghPGmSEGLU9Zayv92afYhenlPxfrGRmV37MiMNoVzkjYjIdh0dYBslFbrooIkoCYosiu84G+9JInTgW/xiv9G6+JUXhoUvHDVHHyITAyt9TjdPH0eMAFfQke46zm54VJQn6ZSX/3Zn51UcGqHCepPGSIkEceNAIxOjmh/KD6nRwMI6I+ztA0xP8HOZotTpXbeCDNxhFRTY3RjiyIw6P/wXORIfyRL3TMq4L+dyYv/zrgPCePUpv/EUrzUD/KwWlqEs5ZMTCR9nbLys9s52XxCaviElSDoEnrvWSkytRQK8aBs9WM5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtQ4RqxHB8FkwUvd78mkf2dv+4Lop7bbo7tBBMqpIBw=;
 b=i/D1WpGTZtOOJqRp7Mq37bwMv2XXPQOBr+XLU7WQJ94mlSAfzZAjYdQq+z4OMKIGe6X9GdP/9CH8yVsgHVHp9HEeiCgISncO63jao4AFp1aygH/VhUtC3gBiwPJoMgn47JXgrk0kvrQH6O3Ap/Owq4HIpx4DOctYdfAxJMHyUJFVaaEfOtu+JgWpB8FLlS8RSDXxmE8znQIV1lKo7SL0DSuKiUgu8qAvjioCajGkPpOpXV29UuAQ3lZfYMvKWUYzWLhLF13493O639QpkeI6/rshgZP4n6JAo2KeihIP8stkjBm8fM0il4b9mnLuWxLiivpA5Q7A4z/3DOiPKOxbVQ==
Received: from DM6PR07CA0111.namprd07.prod.outlook.com (2603:10b6:5:330::12)
 by CO6PR12MB5458.namprd12.prod.outlook.com (2603:10b6:5:35b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Tue, 25 Jan
 2022 08:48:55 +0000
Received: from DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::25) by DM6PR07CA0111.outlook.office365.com
 (2603:10b6:5:330::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Tue, 25 Jan 2022 08:48:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT026.mail.protection.outlook.com (10.13.172.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4909.7 via Frontend Transport; Tue, 25 Jan 2022 08:48:55 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL105.nvidia.com (10.27.9.14) with Microsoft SMTP Server (TLS) id
 15.0.1497.18; Tue, 25 Jan 2022 08:48:54 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9;
 Tue, 25 Jan 2022 00:48:54 -0800
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Tue, 25 Jan 2022 00:48:51 -0800
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <perex@perex.cz>, <robh+dt@kernel.org>, <thierry.reding@gmail.com>
CC:     <jonathanh@nvidia.com>, <mkumard@nvidia.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 2/5] dt-bindings: Add Tegra234 APE support
Date:   Tue, 25 Jan 2022 14:18:08 +0530
Message-ID: <1643100491-5398-3-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643100491-5398-1-git-send-email-spujar@nvidia.com>
References: <1643100491-5398-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ddfa392-1275-423c-bd3b-08d9dfdf8517
X-MS-TrafficTypeDiagnostic: CO6PR12MB5458:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB5458559E843DAE217B234067A75F9@CO6PR12MB5458.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aL3eQEUJg1u3PQN7kLZ6r13tw4AWwINlZYnYFgu5fwJ4qVtINa8pz0RPFkr/x7SGX9GMDzoVvxq1CGtFz4B2ATOl13SPp2wU1vdw6OAxomtlThpzlzsBi9Yc1eYNpU0qhQ1em6ireHDST+eCc5x8TkK38Vm2VZ67GrA/YqoUqP32c0E4njFvXlhNyUm4gFF+ntaHEYR4l04ftlf79m7hTXW605lPcsHzT4wK4uLqsq4CAYtCnPJnJFIvimORP6tLGzdPLdh9hyoM2WDbXqcz1Ji3c3DoD4mX4pJNxdhULSLwWI2qjWKa7rLBorUfJ7p5nmA0gbW0GBjfys3iy4sc3xvyObU3lzZmIi9IOHeaKbfgOCHbBC2God1QKQBv8FEmULGlNavpvYm1vkJNJ/kkwRSY6Urr2z1T2lYcE8G1ijR3oQkYNQKaJSSpnBkUBPvgwp67RU+3Vs3y97M41Cy6uhlodlJS8Ut+Ar8KIjbXQZBV2XxQ8BQNo7Fi6FJLbzsc7X28inCQhlqA3jnPG3vUPnrduJgY4EfHTBYrAq78E/l2A4hSI4EeAyna6BEYXCqumXEtt/XZXSQ25H7gPs2NhwnFwZFW+26uDfXVs5lomcDNP8Mv9KBOExFPZneXiLmXOqHSs0AHPpnXRpRPs2YpGpktApVG+IJ7hLauHoqJoCA7biYjuJYiAPXtg13CgggozmuZCLaS7shHBThu9WUt0et1IwL27pmd/7FSRZA70gaYNaMdkQ2e5GVWIxNg9POT9Y0tk2aaWakaYkNPGYE0ehygPqEVMSstepxJxf4ks4E=
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(36840700001)(40470700004)(46966006)(82310400004)(336012)(26005)(4326008)(36756003)(7696005)(86362001)(508600001)(47076005)(70206006)(70586007)(7416002)(2906002)(36860700001)(8936002)(8676002)(2616005)(356005)(54906003)(81166007)(426003)(5660300002)(40460700003)(107886003)(186003)(6666004)(110136005)(316002)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 08:48:55.1700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ddfa392-1275-423c-bd3b-08d9dfdf8517
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5458
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clocks, power-domain and memory bindings to support APE subsystem
on Tegra234.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 include/dt-bindings/clock/tegra234-clock.h     | 72 ++++++++++++++++++++++++++
 include/dt-bindings/memory/tegra234-mc.h       |  5 ++
 include/dt-bindings/power/tegra234-powergate.h |  1 +
 3 files changed, 78 insertions(+)

diff --git a/include/dt-bindings/clock/tegra234-clock.h b/include/dt-bindings/clock/tegra234-clock.h
index 7207d25..18c5fe5 100644
--- a/include/dt-bindings/clock/tegra234-clock.h
+++ b/include/dt-bindings/clock/tegra234-clock.h
@@ -9,8 +9,28 @@
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
 /** @brief output of mux controlled by CLK_RST_CONTROLLER_CLK_SOURCE_AXI_CBB */
 #define TEGRA234_CLK_AXI_CBB			8U
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
@@ -30,8 +50,60 @@
 #define TEGRA234_CLK_EQOS_TX			35U
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
index 8a39c56..dcb73602 100644
--- a/include/dt-bindings/memory/tegra234-mc.h
+++ b/include/dt-bindings/memory/tegra234-mc.h
@@ -8,6 +8,7 @@
 #define TEGRA234_SID_PASSTHROUGH	0x7f
 
 /* NISO0 stream IDs */
+#define TEGRA234_SID_APE	0x02
 #define TEGRA234_SID_MGBE	0x06
 #define TEGRA234_SID_MGBE_VF1	0x49
 #define TEGRA234_SID_MGBE_VF2	0x4a
@@ -42,6 +43,10 @@
 #define TEGRA234_MEMORY_CLIENT_MGBEDWR 0x65
 /* sdmmcd memory write client */
 #define TEGRA234_MEMORY_CLIENT_SDMMCWAB 0x67
+/* Audio Processing (APE) engine read clients */
+#define TEGRA234_MEMORY_CLIENT_APER 0x7a
+/* Audio Processing (APE) engine write clients */
+#define TEGRA234_MEMORY_CLIENT_APEW 0x7b
 /* EQOS read client */
 #define TEGRA234_MEMORY_CLIENT_EQOSR 0x8e
 /* EQOS write client */
diff --git a/include/dt-bindings/power/tegra234-powergate.h b/include/dt-bindings/power/tegra234-powergate.h
index 6b79386..b0c71a2 100644
--- a/include/dt-bindings/power/tegra234-powergate.h
+++ b/include/dt-bindings/power/tegra234-powergate.h
@@ -4,6 +4,7 @@
 #ifndef __ABI_MACH_T234_POWERGATE_T234_H_
 #define __ABI_MACH_T234_POWERGATE_T234_H_
 
+#define TEGRA234_POWER_DOMAIN_AUD	2U
 #define TEGRA234_POWER_DOMAIN_MGBEA	17U
 #define TEGRA234_POWER_DOMAIN_MGBEB	18U
 #define TEGRA234_POWER_DOMAIN_MGBEC	19U
-- 
2.7.4

