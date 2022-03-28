Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31FE64E8DBA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 08:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238263AbiC1GIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 02:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238241AbiC1GIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 02:08:30 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2054.outbound.protection.outlook.com [40.107.96.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470F0515A2;
        Sun, 27 Mar 2022 23:06:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMN04MmDXjo8M7w269/619UekSZBUG8sO1imeHG/4qEl5S1gZPftYyjxioMswjVC2y4SV2TkFHX8bCf4v8+0NDG1F+5O4aTQQ86XT+WE2l+dlzObfojEDGpECVHu3IX5wBXHcnnw9qivCwOo3XWexkP/DcEkv8U0X7uYcQ88XdimhLXNYyFHAtJNyS5os1h3nW9wdsn5sm6bEasf/G3/pYOp/Z8vsPlyu9MTUHAwfDNiwW0Xn+z43ucYrtUAMzkJ9xgrhAzG/o7u/I8dvGu+0VnMrWlGOwzUYN88r9qzWSwJ4quKBYD+QDAblVSHUvDD7ORsBiJ4Hl0Zwj66v2z3GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UicQlR8i9PFQni692xQmrhvDarWnyCxZGqqR9CcDZMU=;
 b=H1P7nvXRpCow9d2wJy1DqdYqLci8mqFplSE8zUJKjXp7M3z522uwq5gDvBYshfz6sB69X/FcL2jVmBYzohEAc4Lt+Di3dtMwzNQuePAh9vWZ3KGQkKrv/t9Nip1V+JLzhe/Xj6VgrDGem26Z1+Z0TRE4sKi6qNZZh2xOo9Hrw3ZBoGjdSiZssbveYWGzmppySZl+WE6junfuQBffBbdq+cNJiGZuNZZlXuBaHBxszjuuaUCteLUGfcMkO0r6XQfX3wtDzqqrkxfTavu5I9C0eA8eM3p+D0TdcuA/PW/Jb7lZXMrkET3ox/lWWTQCGv71EO8aFqSz8yIWHiVJi+JDXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=alsa-project.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UicQlR8i9PFQni692xQmrhvDarWnyCxZGqqR9CcDZMU=;
 b=aTkeabS3s3WZ5/L9ANtp+T40e2xrQGgPlsnnQyxwK3pA4zMMq504Par7L1MUpI0FeiM4zIfolt1IrD9/xaG8TYPUUC/VRSwElLo+BvxkyLYT+gRj/gAhUerP3AX+GotjrebEqObHSFV+VOeHAa65symw6jeANipILSGZCJZG5zS+XtPmrw1AaU+N2qsKJtPlPzOLTOJUtvCToZSwks6CvH8euJfZl2Y6fa9KNFvwmO4vakmpLVUB9vZDWpWvnf7lwTL+ZXlxrG87esvzMxF71Q6M6WC5RVNTixtLye02H8XPwu5HQKmW3Kt6CoMaLMrMYpS7DyUNUh4wTMbL0g0t9Q==
Received: from MW4P221CA0026.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::31)
 by BN8PR12MB3090.namprd12.prod.outlook.com (2603:10b6:408:67::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Mon, 28 Mar
 2022 06:06:46 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b::4) by MW4P221CA0026.outlook.office365.com
 (2603:10b6:303:8b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16 via Frontend
 Transport; Mon, 28 Mar 2022 06:06:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5102.17 via Frontend Transport; Mon, 28 Mar 2022 06:06:43 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 28 Mar
 2022 06:06:42 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Sun, 27 Mar
 2022 23:06:41 -0700
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Sun, 27 Mar
 2022 23:06:37 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <thierry.reding@gmail.com>, <lgirdwood@gmail.com>,
        <perex@perex.cz>, <tiwai@suse.com>
CC:     <jonathanh@nvidia.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 2/6] ASoC: tegra: Add Tegra186 based ASRC driver
Date:   Mon, 28 Mar 2022 11:35:22 +0530
Message-ID: <1648447526-14523-3-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1648447526-14523-1-git-send-email-spujar@nvidia.com>
References: <1648447526-14523-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75614bf6-eec1-4e99-acb2-08da10812270
X-MS-TrafficTypeDiagnostic: BN8PR12MB3090:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3090C69A109B91005A20D613A71D9@BN8PR12MB3090.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y4pV44r1w/y5B+AwE50BU+qllsPx/pfMLCGVoeLWJ5Z8nSqVjl4qM0Qjbi/dJdO3Jz0pono8v8lSMwq50nVqJ9EPyPDraZsHftUr31X9FjK5sEdzOP3xWxcg9W01a0w22rBBdh9F71ThLHEaw3UrALmuMnQhaBkpsBNiN4pyvimbLGhY/HUeeYosheW9IJ+nv0j7+yItUZdFTisOfIgRK1RPSVRAYF4XE1Emu5w5LzsuTKFSvvcy0n9peNncibxWr3dBKrCZhl1nmUlrPbRHc9vpOlwe8iQkFkE/xvW/J/W0cAVA0lVoUxFVtakzT8Hlvmx8G43ArF6gqJmmJ9Gbejg4ADh+lmQeKbPheyy5xuKvKe/InrpGxwFUZDrKzayBpHYwqxCkSblG71YH4+Wz38tPmmgqxHxlalf+25cNqHYKX6fMbNO7DZQG3/QB4jWNFYyAma6LJ/XqYeOLjPip/0+q/ruzYIDZiu3AmLcWUraDaMXhbu7Z3CI64sYeVMYrW46cR4DqX+8MzvoSTU+SsA6byNzi87gWSKOckZNhNlGkSTGXCPeDXhreAlBrV44tbTybsuz1YJLtrOGMYN7N5cb42v0JMl/xlUl1ePdDgV9wDo8Awn8o5Lfpj7ZSAgzYri2GsBcRE8I3tfoxjTQn3O9ltu6EAZ8AXIsYnxKTMJZ71izODDuYS/fmwR0vv1FY6FfOFuy4C+g+61WsJOIjkQ==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(83380400001)(81166007)(356005)(30864003)(7416002)(47076005)(36860700001)(8676002)(4326008)(8936002)(40460700003)(36756003)(70586007)(6666004)(508600001)(7696005)(5660300002)(186003)(26005)(336012)(426003)(54906003)(107886003)(110136005)(70206006)(2906002)(2616005)(86362001)(316002)(82310400004)(36900700001)(579004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 06:06:43.9575
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75614bf6-eec1-4e99-acb2-08da10812270
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3090
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Asynchronous Sample Rate Converter (ASRC) converts the sampling frequency
of the input signal from one frequency to another. It can handle over a
wide range of sample rate ratios (freq_in/freq_out) from 1:24 to 24:1.

ASRC has two modes of operation. One where ratio can be programmed in SW
and the other where it gets the information from ratio estimator module.
The latter mode above can help address the cases where the sample rate is
not known at the stream set up time or is potentially time varying.
In addition, the ratio between input and output sample rate can be any
arbitrary number and the input and output clocks could be derived from
asynchronous clocks.

This patch registers ASRC driver with ASoC framework. The component driver
exposes DAPM widgets, routes and kcontrols for the device. The DAI driver
exposes ASRC interfaces, which can be used to connect different components
in the ASoC layer. Makefile and Kconfig support is added to allow build
the driver.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 sound/soc/tegra/Kconfig         |   12 +
 sound/soc/tegra/Makefile        |    2 +
 sound/soc/tegra/tegra186_asrc.c | 1045 +++++++++++++++++++++++++++++++++++++++
 sound/soc/tegra/tegra186_asrc.h |  113 +++++
 4 files changed, 1172 insertions(+)
 create mode 100644 sound/soc/tegra/tegra186_asrc.c
 create mode 100644 sound/soc/tegra/tegra186_asrc.h

diff --git a/sound/soc/tegra/Kconfig b/sound/soc/tegra/Kconfig
index cd45487..2482d98 100644
--- a/sound/soc/tegra/Kconfig
+++ b/sound/soc/tegra/Kconfig
@@ -85,6 +85,18 @@ config SND_SOC_TEGRA210_I2S
 	  compatible devices.
 	  Say Y or M if you want to add support for Tegra210 I2S module.
 
+config SND_SOC_TEGRA186_ASRC
+	tristate "Tegra186 ASRC module"
+	help
+	  Config to enable the Asynchronous Sample Rate Converter (ASRC),
+	  which converts the sampling frequency of the input signal from
+	  one frequency to another. It can handle over a wide range of
+	  sample rate ratios (freq_in/freq_out) from 1:24 to 24:1.
+	  ASRC has two modes of operation. One where ratio can be programmed
+	  in SW and the other where it gets information from ratio estimator
+	  module.
+	  Say Y or M if you want to add support for Tegra186 ASRC module.
+
 config SND_SOC_TEGRA186_DSPK
 	tristate "Tegra186 DSPK module"
 	help
diff --git a/sound/soc/tegra/Makefile b/sound/soc/tegra/Makefile
index f19d566..70a498d 100644
--- a/sound/soc/tegra/Makefile
+++ b/sound/soc/tegra/Makefile
@@ -11,6 +11,7 @@ snd-soc-tegra30-i2s-objs := tegra30_i2s.o
 snd-soc-tegra210-ahub-objs := tegra210_ahub.o
 snd-soc-tegra210-dmic-objs := tegra210_dmic.o
 snd-soc-tegra210-i2s-objs := tegra210_i2s.o
+snd-soc-tegra186-asrc-objs := tegra186_asrc.o
 snd-soc-tegra186-dspk-objs := tegra186_dspk.o
 snd-soc-tegra210-admaif-objs := tegra210_admaif.o
 snd-soc-tegra210-mvc-objs := tegra210_mvc.o
@@ -29,6 +30,7 @@ obj-$(CONFIG_SND_SOC_TEGRA30_I2S) += snd-soc-tegra30-i2s.o
 obj-$(CONFIG_SND_SOC_TEGRA210_DMIC) += snd-soc-tegra210-dmic.o
 obj-$(CONFIG_SND_SOC_TEGRA210_AHUB) += snd-soc-tegra210-ahub.o
 obj-$(CONFIG_SND_SOC_TEGRA210_I2S) += snd-soc-tegra210-i2s.o
+obj-$(CONFIG_SND_SOC_TEGRA186_ASRC) += snd-soc-tegra186-asrc.o
 obj-$(CONFIG_SND_SOC_TEGRA186_DSPK) += snd-soc-tegra186-dspk.o
 obj-$(CONFIG_SND_SOC_TEGRA210_ADMAIF) += snd-soc-tegra210-admaif.o
 obj-$(CONFIG_SND_SOC_TEGRA210_MVC) += snd-soc-tegra210-mvc.o
diff --git a/sound/soc/tegra/tegra186_asrc.c b/sound/soc/tegra/tegra186_asrc.c
new file mode 100644
index 0000000..44eedb0
--- /dev/null
+++ b/sound/soc/tegra/tegra186_asrc.c
@@ -0,0 +1,1045 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// tegra186_asrc.c - Tegra186 ASRC driver
+//
+// Copyright (c) 2022, NVIDIA CORPORATION. All rights reserved.
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+
+#include "tegra186_asrc.h"
+#include "tegra_cif.h"
+
+#define ASRC_STREAM_SOURCE_SELECT(id)					       \
+	(TEGRA186_ASRC_CFG + ((id) * TEGRA186_ASRC_STREAM_STRIDE))
+
+#define ASRC_STREAM_REG(reg, id) ((reg) + ((id) * TEGRA186_ASRC_STREAM_STRIDE))
+
+#define ASRC_STREAM_REG_DEFAULTS(id)					       \
+	{ ASRC_STREAM_REG(TEGRA186_ASRC_CFG, id),			       \
+	  (((id) + 1) << 4) },						       \
+	{ ASRC_STREAM_REG(TEGRA186_ASRC_RATIO_INT_PART, id),		       \
+	  0x1 },							       \
+	{ ASRC_STREAM_REG(TEGRA186_ASRC_RATIO_FRAC_PART, id),		       \
+	  0x0 },							       \
+	{ ASRC_STREAM_REG(TEGRA186_ASRC_MUTE_UNMUTE_DURATION, id),	       \
+	  0x400 },							       \
+	{ ASRC_STREAM_REG(TEGRA186_ASRC_RX_CIF_CTRL, id),		       \
+	  0x7500 },							       \
+	{ ASRC_STREAM_REG(TEGRA186_ASRC_TX_CIF_CTRL, id),		       \
+	  0x7500 },							       \
+	{ ASRC_STREAM_REG(TEGRA186_ASRC_ENABLE, id),			       \
+	  0x0 },							       \
+	{ ASRC_STREAM_REG(TEGRA186_ASRC_SOFT_RESET, id),		       \
+	  0x0 },							       \
+	{ ASRC_STREAM_REG(TEGRA186_ASRC_STATEBUF_ADDR, id),		       \
+	  0x0 },							       \
+	{ ASRC_STREAM_REG(TEGRA186_ASRC_STATEBUF_CFG, id),		       \
+	  0x445 },							       \
+	{ ASRC_STREAM_REG(TEGRA186_ASRC_INSAMPLEBUF_ADDR, id),		       \
+	  0x0 },							       \
+	{ ASRC_STREAM_REG(TEGRA186_ASRC_INSAMPLEBUF_CFG, id),		       \
+	  0x64 },							       \
+	{ ASRC_STREAM_REG(TEGRA186_ASRC_OUTSAMPLEBUF_ADDR, id),		       \
+	  0x4b0 },							       \
+	{ ASRC_STREAM_REG(TEGRA186_ASRC_OUTSAMPLEBUF_CFG, id),		       \
+	  0x64 }
+
+static const struct reg_default tegra186_asrc_reg_defaults[] = {
+	ASRC_STREAM_REG_DEFAULTS(0),
+	ASRC_STREAM_REG_DEFAULTS(1),
+	ASRC_STREAM_REG_DEFAULTS(2),
+	ASRC_STREAM_REG_DEFAULTS(3),
+	ASRC_STREAM_REG_DEFAULTS(4),
+	ASRC_STREAM_REG_DEFAULTS(5),
+
+	{ TEGRA186_ASRC_GLOBAL_ENB, 0x0 },
+	{ TEGRA186_ASRC_GLOBAL_SOFT_RESET, 0x0 },
+	{ TEGRA186_ASRC_GLOBAL_CG, 0x1 },
+	{ TEGRA186_ASRC_GLOBAL_SCRATCH_ADDR, 0x0 },
+	{ TEGRA186_ASRC_GLOBAL_SCRATCH_CFG, 0x0c207980 },
+	{ TEGRA186_ASRC_RATIO_UPD_RX_CIF_CTRL, 0x00115500 },
+	{ TEGRA186_ASRC_RATIO_UPD_RX_STATUS, 0x0 },
+	{ TEGRA186_ASRC_GLOBAL_STATUS, 0x0 },
+	{ TEGRA186_ASRC_GLOBAL_STREAM_ENABLE_STATUS, 0x0 },
+	{ TEGRA186_ASRC_GLOBAL_INT_MASK, 0x0 },
+	{ TEGRA186_ASRC_GLOBAL_INT_SET, 0x0 },
+	{ TEGRA186_ASRC_GLOBAL_INT_CLEAR, 0x0 },
+	{ TEGRA186_ASRC_GLOBAL_APR_CTRL, 0x0 },
+	{ TEGRA186_ASRC_GLOBAL_APR_CTRL_ACCESS_CTRL, 0x0 },
+	{ TEGRA186_ASRC_GLOBAL_DISARM_APR, 0x0 },
+	{ TEGRA186_ASRC_GLOBAL_DISARM_APR_ACCESS_CTRL, 0x0 },
+	{ TEGRA186_ASRC_GLOBAL_RATIO_WR_ACCESS, 0x0 },
+	{ TEGRA186_ASRC_GLOBAL_RATIO_WR_ACCESS_CTRL, 0x0 },
+	{ TEGRA186_ASRC_CYA, 0x0 },
+};
+
+static void tegra186_asrc_lock_stream(struct tegra186_asrc *asrc,
+				      unsigned int id)
+{
+	regmap_write(asrc->regmap,
+		     ASRC_STREAM_REG(TEGRA186_ASRC_RATIO_LOCK_STATUS,
+				     id),
+		     1);
+}
+
+static int tegra186_asrc_runtime_suspend(struct device *dev)
+{
+	struct tegra186_asrc *asrc = dev_get_drvdata(dev);
+
+	regcache_cache_only(asrc->regmap, true);
+	regcache_mark_dirty(asrc->regmap);
+
+	return 0;
+}
+
+static int tegra186_asrc_runtime_resume(struct device *dev)
+{
+	struct tegra186_asrc *asrc = dev_get_drvdata(dev);
+	int id;
+
+	regcache_cache_only(asrc->regmap, false);
+	regcache_sync(asrc->regmap);
+
+	/* Setup global registers */
+	regmap_write(asrc->regmap, TEGRA186_ASRC_GLOBAL_SOFT_RESET, 0x1);
+	regmap_write(asrc->regmap, TEGRA186_ASRC_GLOBAL_SCRATCH_ADDR,
+		     TEGRA186_ASRC_ARAM_START_ADDR);
+	regmap_write(asrc->regmap, TEGRA186_ASRC_GLOBAL_INT_MASK, 0x01);
+	regmap_write(asrc->regmap, TEGRA186_ASRC_GLOBAL_ENB,
+		     TEGRA186_ASRC_GLOBAL_EN);
+	regmap_write(asrc->regmap, TEGRA186_ASRC_GLOBAL_INT_CLEAR, 0x01);
+
+	/* Restore ratio information */
+	for (id = 0; id < TEGRA186_ASRC_STREAM_MAX; id++) {
+		if (asrc->lane[id].ratio_source !=
+		    TEGRA186_ASRC_RATIO_SOURCE_SW)
+			continue;
+
+		regmap_write(asrc->regmap,
+			ASRC_STREAM_REG(TEGRA186_ASRC_RATIO_INT_PART,
+					id),
+			asrc->lane[id].int_part);
+
+		regmap_write(asrc->regmap,
+			ASRC_STREAM_REG(TEGRA186_ASRC_RATIO_FRAC_PART,
+					id),
+			asrc->lane[id].frac_part);
+
+		tegra186_asrc_lock_stream(asrc, id);
+	}
+
+	return 0;
+}
+
+static int tegra186_asrc_set_audio_cif(struct tegra186_asrc *asrc,
+				       struct snd_pcm_hw_params *params,
+				       unsigned int reg)
+{
+	int channels, audio_bits;
+	struct tegra_cif_conf cif_conf;
+
+	memset(&cif_conf, 0, sizeof(struct tegra_cif_conf));
+
+	channels = params_channels(params);
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		audio_bits = TEGRA_ACIF_BITS_16;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+	case SNDRV_PCM_FORMAT_S32_LE:
+		audio_bits = TEGRA_ACIF_BITS_32;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	cif_conf.audio_ch = channels;
+	cif_conf.client_ch = channels;
+	cif_conf.audio_bits = audio_bits;
+	cif_conf.client_bits = TEGRA_ACIF_BITS_24;
+
+	tegra_set_cif(asrc->regmap, reg, &cif_conf);
+
+	return 0;
+}
+
+static int tegra186_asrc_in_hw_params(struct snd_pcm_substream *substream,
+				      struct snd_pcm_hw_params *params,
+				      struct snd_soc_dai *dai)
+{
+	struct device *dev = dai->dev;
+	struct tegra186_asrc *asrc = snd_soc_dai_get_drvdata(dai);
+	int ret, id = dai->id;
+
+	/* Set input threshold */
+	regmap_write(asrc->regmap,
+		     ASRC_STREAM_REG(TEGRA186_ASRC_RX_THRESHOLD, dai->id),
+		     asrc->lane[id].input_thresh);
+
+	ret = tegra186_asrc_set_audio_cif(asrc, params,
+		ASRC_STREAM_REG(TEGRA186_ASRC_RX_CIF_CTRL, dai->id));
+	if (ret) {
+		dev_err(dev, "Can't set ASRC RX%d CIF: %d\n", dai->id, ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+static int tegra186_asrc_out_hw_params(struct snd_pcm_substream *substream,
+				       struct snd_pcm_hw_params *params,
+				       struct snd_soc_dai *dai)
+{
+	struct device *dev = dai->dev;
+	struct tegra186_asrc *asrc = snd_soc_dai_get_drvdata(dai);
+	int ret, id = dai->id - 7;
+
+	 /* Set output threshold */
+	regmap_write(asrc->regmap,
+		     ASRC_STREAM_REG(TEGRA186_ASRC_TX_THRESHOLD, id),
+		     asrc->lane[id].output_thresh);
+
+	ret = tegra186_asrc_set_audio_cif(asrc, params,
+		ASRC_STREAM_REG(TEGRA186_ASRC_TX_CIF_CTRL, id));
+	if (ret) {
+		dev_err(dev, "Can't set ASRC TX%d CIF: %d\n", id, ret);
+		return ret;
+	}
+
+	/* Set ENABLE_HW_RATIO_COMP */
+	if (asrc->lane[id].hwcomp_disable) {
+		regmap_update_bits(asrc->regmap,
+			ASRC_STREAM_REG(TEGRA186_ASRC_CFG, id),
+			TEGRA186_ASRC_STREAM_ENABLE_HW_RATIO_COMP_MASK,
+			TEGRA186_ASRC_STREAM_ENABLE_HW_RATIO_COMP_DISABLE);
+	} else {
+		regmap_update_bits(asrc->regmap,
+			ASRC_STREAM_REG(TEGRA186_ASRC_CFG, id),
+			TEGRA186_ASRC_STREAM_ENABLE_HW_RATIO_COMP_MASK,
+			TEGRA186_ASRC_STREAM_ENABLE_HW_RATIO_COMP_ENABLE);
+
+		regmap_write(asrc->regmap,
+			ASRC_STREAM_REG(TEGRA186_ASRC_RATIO_COMP, id),
+			TEGRA186_ASRC_STREAM_DEFAULT_HW_COMP_BIAS_VALUE);
+	}
+
+	/* Set lock */
+	regmap_update_bits(asrc->regmap,
+			   ASRC_STREAM_REG(TEGRA186_ASRC_CFG, id),
+			   1, asrc->lane[id].ratio_source);
+
+	if (asrc->lane[id].ratio_source == TEGRA186_ASRC_RATIO_SOURCE_SW) {
+		regmap_write(asrc->regmap,
+			ASRC_STREAM_REG(TEGRA186_ASRC_RATIO_INT_PART, id),
+			asrc->lane[id].int_part);
+		regmap_write(asrc->regmap,
+			ASRC_STREAM_REG(TEGRA186_ASRC_RATIO_FRAC_PART, id),
+			asrc->lane[id].frac_part);
+		tegra186_asrc_lock_stream(asrc, id);
+	}
+
+	return ret;
+}
+
+static int tegra186_asrc_get_ratio_source(struct snd_kcontrol *kcontrol,
+					  struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_enum *asrc_private =
+		(struct soc_enum  *)kcontrol->private_value;
+	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
+	struct tegra186_asrc *asrc = snd_soc_component_get_drvdata(cmpnt);
+	unsigned int id = asrc_private->reg / TEGRA186_ASRC_STREAM_STRIDE;
+
+	ucontrol->value.enumerated.item[0] = asrc->lane[id].ratio_source;
+
+	return 0;
+}
+
+static int tegra186_asrc_put_ratio_source(struct snd_kcontrol *kcontrol,
+					  struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_enum *asrc_private =
+		(struct soc_enum  *)kcontrol->private_value;
+	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
+	struct tegra186_asrc *asrc = snd_soc_component_get_drvdata(cmpnt);
+	unsigned int id = asrc_private->reg / TEGRA186_ASRC_STREAM_STRIDE;
+
+	asrc->lane[id].ratio_source = ucontrol->value.enumerated.item[0];
+
+	regmap_update_bits(asrc->regmap, asrc_private->reg,
+			   TEGRA186_ASRC_STREAM_RATIO_TYPE_MASK,
+			   asrc->lane[id].ratio_source);
+
+	return 1;
+}
+
+static int tegra186_asrc_get_ratio_int(struct snd_kcontrol *kcontrol,
+				       struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_mixer_control *asrc_private =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
+	struct tegra186_asrc *asrc = snd_soc_component_get_drvdata(cmpnt);
+	unsigned int id = asrc_private->reg / TEGRA186_ASRC_STREAM_STRIDE;
+
+	regmap_read(asrc->regmap,
+		    ASRC_STREAM_REG(TEGRA186_ASRC_RATIO_INT_PART, id),
+		    &asrc->lane[id].int_part);
+
+	ucontrol->value.integer.value[0] = asrc->lane[id].int_part;
+
+	return 0;
+}
+
+static int tegra186_asrc_put_ratio_int(struct snd_kcontrol *kcontrol,
+				       struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_mixer_control *asrc_private =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
+	struct tegra186_asrc *asrc = snd_soc_component_get_drvdata(cmpnt);
+	unsigned int id = asrc_private->reg / TEGRA186_ASRC_STREAM_STRIDE;
+
+	if (asrc->lane[id].ratio_source == TEGRA186_ASRC_RATIO_SOURCE_ARAD) {
+		dev_err(cmpnt->dev,
+			"Lane %d ratio source is ARAD, invalid SW update\n",
+			id);
+		return -EINVAL;
+	}
+
+	asrc->lane[id].int_part = ucontrol->value.integer.value[0];
+
+	regmap_write(asrc->regmap,
+		     ASRC_STREAM_REG(TEGRA186_ASRC_RATIO_INT_PART, id),
+		     asrc->lane[id].int_part);
+
+	tegra186_asrc_lock_stream(asrc, id);
+
+	return 1;
+}
+
+static int tegra186_asrc_get_ratio_frac(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_mreg_control *asrc_private =
+		(struct soc_mreg_control *)kcontrol->private_value;
+	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
+	struct tegra186_asrc *asrc = snd_soc_component_get_drvdata(cmpnt);
+	unsigned int id = asrc_private->regbase / TEGRA186_ASRC_STREAM_STRIDE;
+
+	regmap_read(asrc->regmap,
+		    ASRC_STREAM_REG(TEGRA186_ASRC_RATIO_FRAC_PART, id),
+		    &asrc->lane[id].frac_part);
+
+	ucontrol->value.integer.value[0] = asrc->lane[id].frac_part;
+
+	return 0;
+}
+
+static int tegra186_asrc_put_ratio_frac(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_mreg_control *asrc_private =
+		(struct soc_mreg_control *)kcontrol->private_value;
+	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
+	struct tegra186_asrc *asrc = snd_soc_component_get_drvdata(cmpnt);
+	unsigned int id = asrc_private->regbase / TEGRA186_ASRC_STREAM_STRIDE;
+
+	if (asrc->lane[id].ratio_source == TEGRA186_ASRC_RATIO_SOURCE_ARAD) {
+		dev_err(cmpnt->dev,
+			"Lane %d ratio source is ARAD, invalid SW update\n",
+			id);
+		return -EINVAL;
+	}
+
+	asrc->lane[id].frac_part = ucontrol->value.integer.value[0];
+
+	regmap_write(asrc->regmap,
+		     ASRC_STREAM_REG(TEGRA186_ASRC_RATIO_FRAC_PART, id),
+		     asrc->lane[id].frac_part);
+
+	tegra186_asrc_lock_stream(asrc, id);
+
+	return 1;
+}
+
+static int tegra186_asrc_get_hwcomp_disable(struct snd_kcontrol *kcontrol,
+					    struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_mixer_control *asrc_private =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
+	struct tegra186_asrc *asrc = snd_soc_component_get_drvdata(cmpnt);
+	unsigned int id = asrc_private->reg / TEGRA186_ASRC_STREAM_STRIDE;
+
+	ucontrol->value.integer.value[0] = asrc->lane[id].hwcomp_disable;
+
+	return 0;
+}
+
+static int tegra186_asrc_put_hwcomp_disable(struct snd_kcontrol *kcontrol,
+					    struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_mixer_control *asrc_private =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
+	struct tegra186_asrc *asrc = snd_soc_component_get_drvdata(cmpnt);
+	unsigned int id = asrc_private->reg / TEGRA186_ASRC_STREAM_STRIDE;
+
+	asrc->lane[id].hwcomp_disable = ucontrol->value.integer.value[0];
+
+	return 1;
+}
+
+static int tegra186_asrc_get_input_threshold(struct snd_kcontrol *kcontrol,
+					     struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_mixer_control *asrc_private =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
+	struct tegra186_asrc *asrc = snd_soc_component_get_drvdata(cmpnt);
+	unsigned int id = asrc_private->reg / TEGRA186_ASRC_STREAM_STRIDE;
+
+	ucontrol->value.integer.value[0] = (asrc->lane[id].input_thresh & 0x3);
+
+	return 0;
+}
+
+static int tegra186_asrc_put_input_threshold(struct snd_kcontrol *kcontrol,
+					     struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_mixer_control *asrc_private =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
+	struct tegra186_asrc *asrc = snd_soc_component_get_drvdata(cmpnt);
+	unsigned int id = asrc_private->reg / TEGRA186_ASRC_STREAM_STRIDE;
+
+	asrc->lane[id].input_thresh = (asrc->lane[id].input_thresh & ~(0x3))
+				      | ucontrol->value.integer.value[0];
+
+	return 1;
+}
+
+static int tegra186_asrc_get_output_threshold(struct snd_kcontrol *kcontrol,
+					      struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_mixer_control *asrc_private =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
+	struct tegra186_asrc *asrc = snd_soc_component_get_drvdata(cmpnt);
+	unsigned int id = asrc_private->reg / TEGRA186_ASRC_STREAM_STRIDE;
+
+	ucontrol->value.integer.value[0] = (asrc->lane[id].output_thresh & 0x3);
+
+	return 0;
+}
+
+static int tegra186_asrc_put_output_threshold(struct snd_kcontrol *kcontrol,
+					      struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_mixer_control *asrc_private =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
+	struct tegra186_asrc *asrc = snd_soc_component_get_drvdata(cmpnt);
+	unsigned int id = asrc_private->reg / TEGRA186_ASRC_STREAM_STRIDE;
+
+	asrc->lane[id].output_thresh = (asrc->lane[id].output_thresh & ~(0x3))
+				       | ucontrol->value.integer.value[0];
+
+	return 1;
+}
+
+static int tegra186_asrc_widget_event(struct snd_soc_dapm_widget *w,
+					struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
+	struct tegra186_asrc *asrc = dev_get_drvdata(cmpnt->dev);
+	unsigned int id =
+		(w->reg - TEGRA186_ASRC_ENABLE) / TEGRA186_ASRC_STREAM_STRIDE;
+
+	regmap_write(asrc->regmap,
+		     ASRC_STREAM_REG(TEGRA186_ASRC_SOFT_RESET, id),
+		     0x1);
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops tegra186_asrc_in_dai_ops = {
+	.hw_params	= tegra186_asrc_in_hw_params,
+};
+
+static const struct snd_soc_dai_ops tegra186_asrc_out_dai_ops = {
+	.hw_params	= tegra186_asrc_out_hw_params,
+};
+
+#define IN_DAI(id)						\
+	{							\
+		.name = "ASRC-RX-CIF"#id,			\
+		.playback = {					\
+			.stream_name = "RX" #id "-CIF-Playback",\
+			.channels_min = 1,			\
+			.channels_max = 12,			\
+			.rates = SNDRV_PCM_RATE_8000_192000,	\
+			.formats = SNDRV_PCM_FMTBIT_S8 |	\
+				SNDRV_PCM_FMTBIT_S16_LE |	\
+				SNDRV_PCM_FMTBIT_S24_LE |	\
+				SNDRV_PCM_FMTBIT_S32_LE,	\
+		},						\
+		.capture = {					\
+			.stream_name = "RX" #id "-CIF-Capture", \
+			.channels_min = 1,			\
+			.channels_max = 12,			\
+			.rates = SNDRV_PCM_RATE_8000_192000,	\
+			.formats = SNDRV_PCM_FMTBIT_S8 |	\
+				SNDRV_PCM_FMTBIT_S16_LE |	\
+				SNDRV_PCM_FMTBIT_S24_LE |	\
+				SNDRV_PCM_FMTBIT_S32_LE,	\
+		},						\
+		.ops = &tegra186_asrc_in_dai_ops,		\
+	}
+
+#define OUT_DAI(id)						\
+	{							\
+		.name = "ASRC-TX-CIF"#id,			\
+		.playback = {					\
+			.stream_name = "TX" #id "-CIF-Playback",\
+			.channels_min = 1,			\
+			.channels_max = 12,			\
+			.rates = SNDRV_PCM_RATE_8000_192000,	\
+			.formats = SNDRV_PCM_FMTBIT_S8 |	\
+				SNDRV_PCM_FMTBIT_S16_LE |	\
+				SNDRV_PCM_FMTBIT_S24_LE |	\
+				SNDRV_PCM_FMTBIT_S32_LE,	\
+		},						\
+		.capture = {					\
+			.stream_name = "TX" #id "-CIF-Capture",	\
+			.channels_min = 1,			\
+			.channels_max = 12,			\
+			.rates = SNDRV_PCM_RATE_8000_192000,	\
+			.formats = SNDRV_PCM_FMTBIT_S8 |	\
+				SNDRV_PCM_FMTBIT_S16_LE |	\
+				SNDRV_PCM_FMTBIT_S24_LE |	\
+				SNDRV_PCM_FMTBIT_S32_LE,	\
+		},						\
+		.ops = &tegra186_asrc_out_dai_ops,		\
+	}
+
+static struct snd_soc_dai_driver tegra186_asrc_dais[] = {
+	/* ASRC Input */
+	IN_DAI(1),
+	IN_DAI(2),
+	IN_DAI(3),
+	IN_DAI(4),
+	IN_DAI(5),
+	IN_DAI(6),
+	IN_DAI(7),
+	/* ASRC Output */
+	OUT_DAI(1),
+	OUT_DAI(2),
+	OUT_DAI(3),
+	OUT_DAI(4),
+	OUT_DAI(5),
+	OUT_DAI(6),
+};
+
+static const struct snd_soc_dapm_widget tegra186_asrc_widgets[] = {
+	SND_SOC_DAPM_AIF_IN("RX1", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("RX2", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("RX3", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("RX4", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("RX5", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("RX6", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("RX7", NULL, 0, SND_SOC_NOPM, 0, 0),
+
+	SND_SOC_DAPM_AIF_OUT_E("TX1", NULL, 0,
+			       ASRC_STREAM_REG(TEGRA186_ASRC_ENABLE, 0),
+			       TEGRA186_ASRC_STREAM_EN_SHIFT, 0,
+			       tegra186_asrc_widget_event,
+			       SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_AIF_OUT_E("TX2", NULL, 0,
+			       ASRC_STREAM_REG(TEGRA186_ASRC_ENABLE, 1),
+			       TEGRA186_ASRC_STREAM_EN_SHIFT, 0,
+			       tegra186_asrc_widget_event,
+			       SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_AIF_OUT_E("TX3", NULL, 0,
+			       ASRC_STREAM_REG(TEGRA186_ASRC_ENABLE, 2),
+			       TEGRA186_ASRC_STREAM_EN_SHIFT, 0,
+			       tegra186_asrc_widget_event,
+			       SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_AIF_OUT_E("TX4", NULL, 0,
+			       ASRC_STREAM_REG(TEGRA186_ASRC_ENABLE, 3),
+			       TEGRA186_ASRC_STREAM_EN_SHIFT, 0,
+			       tegra186_asrc_widget_event,
+			       SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_AIF_OUT_E("TX5", NULL, 0,
+			       ASRC_STREAM_REG(TEGRA186_ASRC_ENABLE, 4),
+			       TEGRA186_ASRC_STREAM_EN_SHIFT, 0,
+			       tegra186_asrc_widget_event,
+			       SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_AIF_OUT_E("TX6", NULL, 0,
+			       ASRC_STREAM_REG(TEGRA186_ASRC_ENABLE, 5),
+			       TEGRA186_ASRC_STREAM_EN_SHIFT, 0,
+			       tegra186_asrc_widget_event,
+			       SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_SPK("Depacketizer", NULL),
+};
+
+#define ASRC_STREAM_ROUTE(id, sname)					   \
+	{ "RX" #id " XBAR-" sname,      NULL,   "RX" #id " XBAR-TX" },	   \
+	{ "RX" #id "-CIF-" sname,       NULL,   "RX" #id " XBAR-" sname }, \
+	{ "RX" #id,                     NULL,   "RX" #id "-CIF-" sname },  \
+	{ "TX" #id,			NULL,   "RX" #id },		   \
+	{ "TX" #id "-CIF-" sname,       NULL,   "TX" #id },		   \
+	{ "TX" #id " XBAR-" sname,      NULL,   "TX" #id "-CIF-" sname },  \
+	{ "TX" #id " XBAR-RX",          NULL,   "TX" #id " XBAR-" sname },
+
+#define ASRC_ROUTE(id)							   \
+	ASRC_STREAM_ROUTE(id, "Playback")				   \
+	ASRC_STREAM_ROUTE(id, "Capture")
+
+#define ASRC_RATIO_ROUTE(sname)						   \
+	{ "RX7 XBAR-" sname,		NULL,	"RX7 XBAR-TX" },	   \
+	{ "RX7-CIF-" sname,		NULL,	"RX7 XBAR-" sname },	   \
+	{ "RX7",			NULL,	"RX7-CIF-" sname },	   \
+	{ "Depacketizer",		NULL,	"RX7" },
+
+static const struct snd_soc_dapm_route tegra186_asrc_routes[] = {
+	ASRC_ROUTE(1)
+	ASRC_ROUTE(2)
+	ASRC_ROUTE(3)
+	ASRC_ROUTE(4)
+	ASRC_ROUTE(5)
+	ASRC_ROUTE(6)
+	ASRC_RATIO_ROUTE("Playback")
+	ASRC_RATIO_ROUTE("Capture")
+};
+
+static const char * const tegra186_asrc_ratio_source_text[] = {
+	"ARAD",
+	"SW",
+};
+
+#define ASRC_SOURCE_DECL(name, id)					\
+	static const struct soc_enum name =				\
+		SOC_ENUM_SINGLE(ASRC_STREAM_SOURCE_SELECT(id),		\
+				0, 2, tegra186_asrc_ratio_source_text)
+
+ASRC_SOURCE_DECL(src_select1, 0);
+ASRC_SOURCE_DECL(src_select2, 1);
+ASRC_SOURCE_DECL(src_select3, 2);
+ASRC_SOURCE_DECL(src_select4, 3);
+ASRC_SOURCE_DECL(src_select5, 4);
+ASRC_SOURCE_DECL(src_select6, 5);
+
+#define SOC_SINGLE_EXT_FRAC(xname, xregbase, xmax, xget, xput)		\
+{									\
+	.iface	= SNDRV_CTL_ELEM_IFACE_MIXER,				\
+	.name	= (xname),						\
+	.info	= snd_soc_info_xr_sx,					\
+	.get	= xget,							\
+	.put	= xput,							\
+									\
+	.private_value = (unsigned long)&(struct soc_mreg_control)	\
+	{								\
+		.regbase	= xregbase,				\
+		.regcount	= 1,					\
+		.nbits		= 32,					\
+		.invert		= 0,					\
+		.min		= 0,					\
+		.max		= xmax					\
+	}								\
+}
+
+static const struct snd_kcontrol_new tegra186_asrc_controls[] = {
+	/* Controls for integer part of ratio */
+	SOC_SINGLE_EXT("Ratio1 Integer Part",
+		       ASRC_STREAM_REG(TEGRA186_ASRC_RATIO_INT_PART, 0),
+		       0, TEGRA186_ASRC_STREAM_RATIO_INT_PART_MASK, 0,
+		       tegra186_asrc_get_ratio_int,
+		       tegra186_asrc_put_ratio_int),
+
+	SOC_SINGLE_EXT("Ratio2 Integer Part",
+		       ASRC_STREAM_REG(TEGRA186_ASRC_RATIO_INT_PART, 1),
+		       0, TEGRA186_ASRC_STREAM_RATIO_INT_PART_MASK, 0,
+		       tegra186_asrc_get_ratio_int,
+		       tegra186_asrc_put_ratio_int),
+
+	SOC_SINGLE_EXT("Ratio3 Integer Part",
+		       ASRC_STREAM_REG(TEGRA186_ASRC_RATIO_INT_PART, 2),
+		       0, TEGRA186_ASRC_STREAM_RATIO_INT_PART_MASK, 0,
+		       tegra186_asrc_get_ratio_int,
+		       tegra186_asrc_put_ratio_int),
+
+	SOC_SINGLE_EXT("Ratio4 Integer Part",
+		       ASRC_STREAM_REG(TEGRA186_ASRC_RATIO_INT_PART, 3),
+		       0, TEGRA186_ASRC_STREAM_RATIO_INT_PART_MASK, 0,
+		       tegra186_asrc_get_ratio_int,
+		       tegra186_asrc_put_ratio_int),
+
+	SOC_SINGLE_EXT("Ratio5 Integer Part",
+		       ASRC_STREAM_REG(TEGRA186_ASRC_RATIO_INT_PART, 4),
+		       0, TEGRA186_ASRC_STREAM_RATIO_INT_PART_MASK, 0,
+		       tegra186_asrc_get_ratio_int,
+		       tegra186_asrc_put_ratio_int),
+
+	SOC_SINGLE_EXT("Ratio6 Integer Part",
+		       ASRC_STREAM_REG(TEGRA186_ASRC_RATIO_INT_PART, 5),
+		       0, TEGRA186_ASRC_STREAM_RATIO_INT_PART_MASK, 0,
+		       tegra186_asrc_get_ratio_int,
+		       tegra186_asrc_put_ratio_int),
+
+	/* Controls for fractional part of ratio */
+	SOC_SINGLE_EXT_FRAC("Ratio1 Fractional Part",
+			    ASRC_STREAM_REG(TEGRA186_ASRC_RATIO_FRAC_PART, 0),
+			    TEGRA186_ASRC_STREAM_RATIO_FRAC_PART_MASK,
+			    tegra186_asrc_get_ratio_frac,
+			    tegra186_asrc_put_ratio_frac),
+
+	SOC_SINGLE_EXT_FRAC("Ratio2 Fractional Part",
+			    ASRC_STREAM_REG(TEGRA186_ASRC_RATIO_FRAC_PART, 1),
+			    TEGRA186_ASRC_STREAM_RATIO_FRAC_PART_MASK,
+			    tegra186_asrc_get_ratio_frac,
+			    tegra186_asrc_put_ratio_frac),
+
+	SOC_SINGLE_EXT_FRAC("Ratio3 Fractional Part",
+			    ASRC_STREAM_REG(TEGRA186_ASRC_RATIO_FRAC_PART, 2),
+			    TEGRA186_ASRC_STREAM_RATIO_FRAC_PART_MASK,
+			    tegra186_asrc_get_ratio_frac,
+			    tegra186_asrc_put_ratio_frac),
+
+	SOC_SINGLE_EXT_FRAC("Ratio4 Fractional Part",
+			    ASRC_STREAM_REG(TEGRA186_ASRC_RATIO_FRAC_PART, 3),
+			    TEGRA186_ASRC_STREAM_RATIO_FRAC_PART_MASK,
+			    tegra186_asrc_get_ratio_frac,
+			    tegra186_asrc_put_ratio_frac),
+
+	SOC_SINGLE_EXT_FRAC("Ratio5 Fractional Part",
+			    ASRC_STREAM_REG(TEGRA186_ASRC_RATIO_FRAC_PART, 4),
+			    TEGRA186_ASRC_STREAM_RATIO_FRAC_PART_MASK,
+			    tegra186_asrc_get_ratio_frac,
+			    tegra186_asrc_put_ratio_frac),
+
+	SOC_SINGLE_EXT_FRAC("Ratio6 Fractional Part",
+			    ASRC_STREAM_REG(TEGRA186_ASRC_RATIO_FRAC_PART, 5),
+			    TEGRA186_ASRC_STREAM_RATIO_FRAC_PART_MASK,
+			    tegra186_asrc_get_ratio_frac,
+			    tegra186_asrc_put_ratio_frac),
+
+	/* Source of ratio provider */
+	SOC_ENUM_EXT("Ratio1 Source", src_select1,
+		     tegra186_asrc_get_ratio_source,
+		     tegra186_asrc_put_ratio_source),
+
+	SOC_ENUM_EXT("Ratio2 Source", src_select2,
+		     tegra186_asrc_get_ratio_source,
+		     tegra186_asrc_put_ratio_source),
+
+	SOC_ENUM_EXT("Ratio3 Source", src_select3,
+		     tegra186_asrc_get_ratio_source,
+		     tegra186_asrc_put_ratio_source),
+
+	SOC_ENUM_EXT("Ratio4 Source", src_select4,
+		     tegra186_asrc_get_ratio_source,
+		     tegra186_asrc_put_ratio_source),
+
+	SOC_ENUM_EXT("Ratio5 Source", src_select5,
+		     tegra186_asrc_get_ratio_source,
+		     tegra186_asrc_put_ratio_source),
+
+	SOC_ENUM_EXT("Ratio6 Source", src_select6,
+		     tegra186_asrc_get_ratio_source,
+		     tegra186_asrc_put_ratio_source),
+
+	/* Disable HW managed overflow/underflow issue at input and output */
+	SOC_SINGLE_EXT("Stream1 HW Component Disable",
+		       ASRC_STREAM_REG(TEGRA186_ASRC_CFG, 0), 0, 1, 0,
+		       tegra186_asrc_get_hwcomp_disable,
+		       tegra186_asrc_put_hwcomp_disable),
+
+	SOC_SINGLE_EXT("Stream2 HW Component Disable",
+		       ASRC_STREAM_REG(TEGRA186_ASRC_CFG, 1), 0, 1, 0,
+		       tegra186_asrc_get_hwcomp_disable,
+		       tegra186_asrc_put_hwcomp_disable),
+
+	SOC_SINGLE_EXT("Stream3 HW Component Disable",
+		       ASRC_STREAM_REG(TEGRA186_ASRC_CFG, 2), 0, 1, 0,
+		       tegra186_asrc_get_hwcomp_disable,
+		       tegra186_asrc_put_hwcomp_disable),
+
+	SOC_SINGLE_EXT("Stream4 HW Component Disable",
+		       ASRC_STREAM_REG(TEGRA186_ASRC_CFG, 3), 0, 1, 0,
+		       tegra186_asrc_get_hwcomp_disable,
+		       tegra186_asrc_put_hwcomp_disable),
+
+	SOC_SINGLE_EXT("Stream5 HW Component Disable",
+		       ASRC_STREAM_REG(TEGRA186_ASRC_CFG, 4), 0, 1, 0,
+		       tegra186_asrc_get_hwcomp_disable,
+		       tegra186_asrc_put_hwcomp_disable),
+
+	SOC_SINGLE_EXT("Stream6 HW Component Disable",
+		       ASRC_STREAM_REG(TEGRA186_ASRC_CFG, 5), 0, 1, 0,
+		       tegra186_asrc_get_hwcomp_disable,
+		       tegra186_asrc_put_hwcomp_disable),
+
+	/* Input threshold for watermark fields */
+	SOC_SINGLE_EXT("Stream1 Input Threshold",
+		       ASRC_STREAM_REG(TEGRA186_ASRC_RX_THRESHOLD, 0), 0, 3, 0,
+		       tegra186_asrc_get_input_threshold,
+		       tegra186_asrc_put_input_threshold),
+
+	SOC_SINGLE_EXT("Stream2 Input Threshold",
+		       ASRC_STREAM_REG(TEGRA186_ASRC_RX_THRESHOLD, 1), 0, 3, 0,
+		       tegra186_asrc_get_input_threshold,
+		       tegra186_asrc_put_input_threshold),
+
+	SOC_SINGLE_EXT("Stream3 Input Threshold",
+		       ASRC_STREAM_REG(TEGRA186_ASRC_RX_THRESHOLD, 2), 0, 3, 0,
+		       tegra186_asrc_get_input_threshold,
+		       tegra186_asrc_put_input_threshold),
+
+	SOC_SINGLE_EXT("Stream4 Input Threshold",
+		       ASRC_STREAM_REG(TEGRA186_ASRC_RX_THRESHOLD, 3), 0, 3, 0,
+		       tegra186_asrc_get_input_threshold,
+		       tegra186_asrc_put_input_threshold),
+
+	SOC_SINGLE_EXT("Stream5 Input Threshold",
+		       ASRC_STREAM_REG(TEGRA186_ASRC_RX_THRESHOLD, 4), 0, 3, 0,
+		       tegra186_asrc_get_input_threshold,
+		       tegra186_asrc_put_input_threshold),
+
+	SOC_SINGLE_EXT("Stream6 Input Threshold",
+		       ASRC_STREAM_REG(TEGRA186_ASRC_RX_THRESHOLD, 4), 0, 3, 0,
+		       tegra186_asrc_get_input_threshold,
+		       tegra186_asrc_put_input_threshold),
+
+	/* Output threshold for watermark fields */
+	SOC_SINGLE_EXT("Stream1 Output Threshold",
+		       ASRC_STREAM_REG(TEGRA186_ASRC_TX_THRESHOLD, 0), 0, 3, 0,
+		       tegra186_asrc_get_output_threshold,
+		       tegra186_asrc_put_output_threshold),
+
+	SOC_SINGLE_EXT("Stream2 Output Threshold",
+		       ASRC_STREAM_REG(TEGRA186_ASRC_TX_THRESHOLD, 1), 0, 3, 0,
+		       tegra186_asrc_get_output_threshold,
+		       tegra186_asrc_put_output_threshold),
+
+	SOC_SINGLE_EXT("Stream3 Output Threshold",
+		       ASRC_STREAM_REG(TEGRA186_ASRC_TX_THRESHOLD, 2), 0, 3, 0,
+		       tegra186_asrc_get_output_threshold,
+		       tegra186_asrc_put_output_threshold),
+
+	SOC_SINGLE_EXT("Stream4 Output Threshold",
+		       ASRC_STREAM_REG(TEGRA186_ASRC_TX_THRESHOLD, 3), 0, 3, 0,
+		       tegra186_asrc_get_output_threshold,
+		       tegra186_asrc_put_output_threshold),
+
+	SOC_SINGLE_EXT("Stream5 Output Threshold",
+		       ASRC_STREAM_REG(TEGRA186_ASRC_TX_THRESHOLD, 4), 0, 3, 0,
+		       tegra186_asrc_get_output_threshold,
+		       tegra186_asrc_put_output_threshold),
+
+	SOC_SINGLE_EXT("Stream6 Output Threshold",
+		       ASRC_STREAM_REG(TEGRA186_ASRC_TX_THRESHOLD, 5), 0, 3, 0,
+		       tegra186_asrc_get_output_threshold,
+		       tegra186_asrc_put_output_threshold),
+};
+
+static const struct snd_soc_component_driver tegra186_asrc_cmpnt = {
+	.dapm_widgets		= tegra186_asrc_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(tegra186_asrc_widgets),
+	.dapm_routes		= tegra186_asrc_routes,
+	.num_dapm_routes	= ARRAY_SIZE(tegra186_asrc_routes),
+	.controls		= tegra186_asrc_controls,
+	.num_controls		= ARRAY_SIZE(tegra186_asrc_controls),
+};
+
+static bool tegra186_asrc_wr_reg(struct device *dev, unsigned int reg)
+{
+	if (reg < TEGRA186_ASRC_STREAM_LIMIT)
+		reg %= TEGRA186_ASRC_STREAM_STRIDE;
+
+	switch (reg) {
+	case TEGRA186_ASRC_CFG ... TEGRA186_ASRC_RATIO_COMP:
+	case TEGRA186_ASRC_RX_CIF_CTRL:
+	case TEGRA186_ASRC_TX_CIF_CTRL:
+	case TEGRA186_ASRC_ENABLE:
+	case TEGRA186_ASRC_SOFT_RESET:
+	case TEGRA186_ASRC_GLOBAL_ENB ... TEGRA186_ASRC_RATIO_UPD_RX_CIF_CTRL:
+	case TEGRA186_ASRC_GLOBAL_INT_MASK ... TEGRA186_ASRC_GLOBAL_INT_CLEAR:
+	case TEGRA186_ASRC_GLOBAL_APR_CTRL ... TEGRA186_ASRC_CYA:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool tegra186_asrc_rd_reg(struct device *dev, unsigned int reg)
+{
+	if (reg < TEGRA186_ASRC_STREAM_LIMIT)
+		reg %= TEGRA186_ASRC_STREAM_STRIDE;
+
+	if (tegra186_asrc_wr_reg(dev, reg))
+		return true;
+
+	switch (reg) {
+	case TEGRA186_ASRC_RX_STATUS:
+	case TEGRA186_ASRC_TX_STATUS:
+	case TEGRA186_ASRC_STATUS ... TEGRA186_ASRC_OUTSAMPLEBUF_CFG:
+	case TEGRA186_ASRC_RATIO_UPD_RX_STATUS:
+	case TEGRA186_ASRC_GLOBAL_STATUS ... TEGRA186_ASRC_GLOBAL_INT_STATUS:
+	case TEGRA186_ASRC_GLOBAL_TRANSFER_ERROR_LOG:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool tegra186_asrc_volatile_reg(struct device *dev, unsigned int reg)
+{
+	if (reg < TEGRA186_ASRC_STREAM_LIMIT)
+		reg %= TEGRA186_ASRC_STREAM_STRIDE;
+
+	switch (reg) {
+	case TEGRA186_ASRC_RX_STATUS:
+	case TEGRA186_ASRC_TX_STATUS:
+	case TEGRA186_ASRC_SOFT_RESET:
+	case TEGRA186_ASRC_RATIO_INT_PART:
+	case TEGRA186_ASRC_RATIO_FRAC_PART:
+	case TEGRA186_ASRC_STATUS:
+	case TEGRA186_ASRC_RATIO_LOCK_STATUS:
+	case TEGRA186_ASRC_RATIO_UPD_RX_STATUS:
+	case TEGRA186_ASRC_GLOBAL_SOFT_RESET:
+	case TEGRA186_ASRC_GLOBAL_STATUS:
+	case TEGRA186_ASRC_GLOBAL_STREAM_ENABLE_STATUS:
+	case TEGRA186_ASRC_GLOBAL_INT_STATUS:
+	case TEGRA186_ASRC_GLOBAL_TRANSFER_ERROR_LOG:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_config tegra186_asrc_regmap_config = {
+	.reg_bits		= 32,
+	.reg_stride		= 4,
+	.val_bits		= 32,
+	.max_register		= TEGRA186_ASRC_CYA,
+	.writeable_reg		= tegra186_asrc_wr_reg,
+	.readable_reg		= tegra186_asrc_rd_reg,
+	.volatile_reg		= tegra186_asrc_volatile_reg,
+	.reg_defaults		= tegra186_asrc_reg_defaults,
+	.num_reg_defaults	= ARRAY_SIZE(tegra186_asrc_reg_defaults),
+	.cache_type		= REGCACHE_FLAT,
+};
+
+static const struct of_device_id tegra186_asrc_of_match[] = {
+	{ .compatible = "nvidia,tegra186-asrc" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, tegra186_asrc_of_match);
+
+static int tegra186_asrc_platform_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct tegra186_asrc *asrc;
+	void __iomem *regs;
+	unsigned int i;
+	int err;
+
+	asrc = devm_kzalloc(dev, sizeof(*asrc), GFP_KERNEL);
+	if (!asrc)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, asrc);
+
+	regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
+
+	asrc->regmap = devm_regmap_init_mmio(dev, regs,
+					     &tegra186_asrc_regmap_config);
+	if (IS_ERR(asrc->regmap)) {
+		dev_err(dev, "regmap init failed\n");
+		return PTR_ERR(asrc->regmap);
+	}
+
+	regcache_cache_only(asrc->regmap, true);
+
+	regmap_write(asrc->regmap, TEGRA186_ASRC_GLOBAL_CFG,
+		     TEGRA186_ASRC_GLOBAL_CFG_FRAC_32BIT_PRECISION);
+
+	/* initialize default output srate */
+	for (i = 0; i < TEGRA186_ASRC_STREAM_MAX; i++) {
+		asrc->lane[i].ratio_source = TEGRA186_ASRC_RATIO_SOURCE_SW;
+		asrc->lane[i].int_part = 1;
+		asrc->lane[i].frac_part = 0;
+		asrc->lane[i].hwcomp_disable = 0;
+		asrc->lane[i].input_thresh =
+			TEGRA186_ASRC_STREAM_DEFAULT_INPUT_HW_COMP_THRESH_CFG;
+		asrc->lane[i].output_thresh =
+			TEGRA186_ASRC_STREAM_DEFAULT_OUTPUT_HW_COMP_THRESH_CFG;
+		regmap_update_bits(asrc->regmap,
+			ASRC_STREAM_REG(TEGRA186_ASRC_CFG, i), 1, 1);
+	}
+
+	err = devm_snd_soc_register_component(dev, &tegra186_asrc_cmpnt,
+					      tegra186_asrc_dais,
+					      ARRAY_SIZE(tegra186_asrc_dais));
+	if (err) {
+		dev_err(dev, "can't register ASRC component, err: %d\n", err);
+		return err;
+	}
+
+	pm_runtime_enable(dev);
+
+	return 0;
+}
+
+static int tegra186_asrc_platform_remove(struct platform_device *pdev)
+{
+	pm_runtime_disable(&pdev->dev);
+
+	return 0;
+}
+
+static const struct dev_pm_ops tegra186_asrc_pm_ops = {
+	SET_RUNTIME_PM_OPS(tegra186_asrc_runtime_suspend,
+			   tegra186_asrc_runtime_resume, NULL)
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				     pm_runtime_force_resume)
+};
+
+static struct platform_driver tegra186_asrc_driver = {
+	.driver = {
+		.name = "tegra186-asrc",
+		.of_match_table = tegra186_asrc_of_match,
+		.pm = &tegra186_asrc_pm_ops,
+	},
+	.probe = tegra186_asrc_platform_probe,
+	.remove = tegra186_asrc_platform_remove,
+};
+module_platform_driver(tegra186_asrc_driver)
+
+MODULE_AUTHOR("Junghyun Kim <juskim@nvidia.com>");
+MODULE_DESCRIPTION("Tegra186 ASRC ASoC driver");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/tegra/tegra186_asrc.h b/sound/soc/tegra/tegra186_asrc.h
new file mode 100644
index 0000000..7cf2a52
--- /dev/null
+++ b/sound/soc/tegra/tegra186_asrc.h
@@ -0,0 +1,113 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * tegra186_asrc.h - Definitions for Tegra186 ASRC driver
+ *
+ * Copyright (c) 2022, NVIDIA CORPORATION. All rights reserved.
+ *
+ */
+
+#ifndef __TEGRA186_ASRC_H__
+#define __TEGRA186_ASRC_H__
+
+/* ASRC stream related offset */
+#define TEGRA186_ASRC_CFG				0x0
+#define TEGRA186_ASRC_RATIO_INT_PART			0x4
+#define TEGRA186_ASRC_RATIO_FRAC_PART			0x8
+#define TEGRA186_ASRC_RATIO_LOCK_STATUS			0xc
+#define TEGRA186_ASRC_MUTE_UNMUTE_DURATION		0x10
+#define TEGRA186_ASRC_TX_THRESHOLD			0x14
+#define TEGRA186_ASRC_RX_THRESHOLD			0x18
+#define TEGRA186_ASRC_RATIO_COMP			0x1c
+#define TEGRA186_ASRC_RX_STATUS				0x20
+#define TEGRA186_ASRC_RX_CIF_CTRL			0x24
+#define TEGRA186_ASRC_TX_STATUS				0x2c
+#define TEGRA186_ASRC_TX_CIF_CTRL			0x30
+#define TEGRA186_ASRC_ENABLE				0x38
+#define TEGRA186_ASRC_SOFT_RESET			0x3c
+#define TEGRA186_ASRC_STATUS				0x4c
+#define TEGRA186_ASRC_STATEBUF_ADDR			0x5c
+#define TEGRA186_ASRC_STATEBUF_CFG			0x60
+#define TEGRA186_ASRC_INSAMPLEBUF_ADDR			0x64
+#define TEGRA186_ASRC_INSAMPLEBUF_CFG			0x68
+#define TEGRA186_ASRC_OUTSAMPLEBUF_ADDR			0x6c
+#define TEGRA186_ASRC_OUTSAMPLEBUF_CFG			0x70
+
+/* ASRC UPD related offset */
+#define TEGRA186_ASRC_RATIO_UPD_RX_CIF_CTRL		0x30c
+#define TEGRA186_ASRC_RATIO_UPD_RX_STATUS		0x310
+
+/* ASRC Global registers offset */
+#define TEGRA186_ASRC_GLOBAL_ENB			0x2f4
+#define TEGRA186_ASRC_GLOBAL_SOFT_RESET			0x2f8
+#define TEGRA186_ASRC_GLOBAL_CG				0x2fc
+#define TEGRA186_ASRC_GLOBAL_CFG			0x300
+#define TEGRA186_ASRC_GLOBAL_SCRATCH_ADDR		0x304
+#define TEGRA186_ASRC_GLOBAL_SCRATCH_CFG		0x308
+#define TEGRA186_ASRC_GLOBAL_STATUS			0x314
+#define TEGRA186_ASRC_GLOBAL_STREAM_ENABLE_STATUS	0x318
+#define TEGRA186_ASRC_GLOBAL_INT_STATUS			0x324
+#define TEGRA186_ASRC_GLOBAL_INT_MASK			0x328
+#define TEGRA186_ASRC_GLOBAL_INT_SET			0x32c
+#define TEGRA186_ASRC_GLOBAL_INT_CLEAR			0x330
+#define TEGRA186_ASRC_GLOBAL_TRANSFER_ERROR_LOG		0x334
+#define TEGRA186_ASRC_GLOBAL_APR_CTRL			0x1000
+#define TEGRA186_ASRC_GLOBAL_APR_CTRL_ACCESS_CTRL	0x1004
+#define TEGRA186_ASRC_GLOBAL_DISARM_APR			0x1008
+#define TEGRA186_ASRC_GLOBAL_DISARM_APR_ACCESS_CTRL	0x100c
+#define TEGRA186_ASRC_GLOBAL_RATIO_WR_ACCESS		0x1010
+#define TEGRA186_ASRC_GLOBAL_RATIO_WR_ACCESS_CTRL	0x1014
+#define TEGRA186_ASRC_CYA				0x1018
+
+#define TEGRA186_ASRC_STREAM_DEFAULT_HW_COMP_BIAS_VALUE		0xaaaa
+#define TEGRA186_ASRC_STREAM_DEFAULT_INPUT_HW_COMP_THRESH_CFG	0x00201002
+#define TEGRA186_ASRC_STREAM_DEFAULT_OUTPUT_HW_COMP_THRESH_CFG	0x00201002
+
+#define TEGRA186_ASRC_STREAM_ENABLE_HW_RATIO_COMP_SHIFT		31
+#define TEGRA186_ASRC_STREAM_ENABLE_HW_RATIO_COMP_MASK		(1 << TEGRA186_ASRC_STREAM_ENABLE_HW_RATIO_COMP_SHIFT)
+#define TEGRA186_ASRC_STREAM_ENABLE_HW_RATIO_COMP_ENABLE	(1 << TEGRA186_ASRC_STREAM_ENABLE_HW_RATIO_COMP_SHIFT)
+#define TEGRA186_ASRC_STREAM_ENABLE_HW_RATIO_COMP_DISABLE	(0 << TEGRA186_ASRC_STREAM_ENABLE_HW_RATIO_COMP_SHIFT)
+
+#define TEGRA186_ASRC_STREAM_RATIO_TYPE_SHIFT			0
+#define TEGRA186_ASRC_STREAM_RATIO_TYPE_MASK			(1 << TEGRA186_ASRC_STREAM_RATIO_TYPE_SHIFT)
+
+#define TEGRA186_ASRC_STREAM_EN_SHIFT				0
+#define TEGRA186_ASRC_STREAM_EN					(1 << TEGRA186_ASRC_STREAM_EN_SHIFT)
+#define TEGRA186_ASRC_GLOBAL_EN_SHIFT				0
+#define TEGRA186_ASRC_GLOBAL_EN					(1 << TEGRA186_ASRC_GLOBAL_EN_SHIFT)
+
+#define TEGRA186_ASRC_STREAM_STATEBUF_CFG_SIZE_SHIFT		0
+#define TEGRA186_ASRC_STREAM_STATEBUF_CFG_SIZE_MASK		(0xffff << TEGRA186_ASRC_STREAM_STATEBUF_CFG_SIZE_SHIFT)
+#define TEGRA186_ASRC_STREAM_INSAMPLEBUF_CFG_SIZE_SHIFT		0
+#define TEGRA186_ASRC_STREAM_INSAMPLEBUF_CFG_SIZE_MASK		(0xffff << TEGRA186_ASRC_STREAM_INSAMPLEBUF_CFG_SIZE_SHIFT)
+#define TEGRA186_ASRC_STREAM_OUTSAMPLEBUF_CFG_SIZE_SHIFT	0
+#define TEGRA186_ASRC_STREAM_OUTSAMPLEBUF_CFG_SIZE_MASK		(0xffff << TEGRA186_ASRC_STREAM_OUTSAMPLEBUF_CFG_SIZE_SHIFT)
+
+#define TEGRA186_ASRC_STREAM_RATIO_INT_PART_MASK		0x1f
+#define TEGRA186_ASRC_STREAM_RATIO_FRAC_PART_MASK		0xffffffff
+
+#define TEGRA186_ASRC_GLOBAL_CFG_FRAC_32BIT_PRECISION		0x1
+
+#define TEGRA186_ASRC_STREAM_STRIDE				0x80
+#define TEGRA186_ASRC_STREAM_MAX				0x6
+#define TEGRA186_ASRC_STREAM_LIMIT				0x2f0
+
+#define TEGRA186_ASRC_RATIO_SOURCE_ARAD				0x0
+#define TEGRA186_ASRC_RATIO_SOURCE_SW				0x1
+
+#define TEGRA186_ASRC_ARAM_START_ADDR				0x3f800000
+
+struct tegra186_asrc_lane {
+	unsigned int int_part;
+	unsigned int frac_part;
+	unsigned int ratio_source;
+	unsigned int hwcomp_disable;
+	unsigned int input_thresh;
+	unsigned int output_thresh;
+};
+
+struct tegra186_asrc {
+	struct tegra186_asrc_lane lane[TEGRA186_ASRC_STREAM_MAX];
+	struct regmap *regmap;
+};
+
+#endif
-- 
2.7.4

