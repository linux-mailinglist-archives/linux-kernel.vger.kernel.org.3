Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23AE4EDB1C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 16:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237233AbiCaOF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 10:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237185AbiCaOFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 10:05:54 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22185A165;
        Thu, 31 Mar 2022 07:04:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DiO5As/dTrT4bji0UF/pHjUCanBu/nEIv86pHetxg5CwG4bkrTBSPtOjhXHWqKdGkwP4TE9igacDc59cOxW2FPEU0LYF9e5y398eUM5QaNBuGhztGOt4OuqnBYvIuElXc3k32C3AF35mQNagYmM8jvLlkmym/U4r1h6M8DsLnUloqiSqW/eT4p9riG8wPCTU7k+glzG5giY59J9AaNYVQ+8xOtqmaltWRrIGa073L3oJFrqdjdd1WwnBHxVbrX0+nNh6akeS0xrTDGW4thdqH9u3DwtZq6ErWACyhyFkmWTUlM9dOr7zYzueCVXOe1xVuxA5NovG0Dn4RRohYKepUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJd88mxQOrNTUrmgCCLfUV+rP+BZp4hs900KT8rMUBI=;
 b=fUN4/txt4b/KYZyIF5pPQRFFldbWUHXY1KGI12RErMKDDZoafRZ8IE9AI3bnOu2cey+2WrnuhorPwWkGP7T0bFPGqpmkR7K9lbmPl7jkn6cObENVK3tm7+vArBKuKDYL/ABe9Wn/CfPQ9gUa9T3rcmSRjeIhua8vha0ldSrePkfuCl/5uFQGTVsmaAjo/DnwW8zdx1i1BXW7UugV3mBFyfZ8UViyDLJJLUAC5AtS6RFkQLtBQjOwLYF5wRpYKLztABWfvfzX74HL9vzuiNkIwyZxstvbzUM2W9iZSSn7DeK8YBAe7Izcfs2fyKtRn/EAiPzImFiyHJIzDeY1pmHdDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=alsa-project.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJd88mxQOrNTUrmgCCLfUV+rP+BZp4hs900KT8rMUBI=;
 b=gSGqOWgC25RatMqaSLBLFTt63pjxkCa9JOMOXYSybTipR8oJzWo0vy9U92/LnYivJ7K+E/E9LLsWE3Jmnw+GqQ6czY9VD8REvI0cH3oMWOR7OPk/27CxZO9JliFrOlk8dziv9yR6umYz3X8H3yjaD0sj/EgZ1pPo7ZkBxK8swuXTUt3lnpxMVWT9g7q7fFR9pt1ZdZM57C2UTFrEdQv6MYnIKDKVrot/ZXQp1S3usWwZK6f2wYfczNftWting2hAFnLZ44KBl4P16pz26h7I9ikKbN4s4WAEPBfy4NsaXUzQwuyTnYpwB/B9NpYwY1RQ6zwMM2Vo1EW5sjttvzHmhA==
Received: from BN9PR03CA0241.namprd03.prod.outlook.com (2603:10b6:408:ff::6)
 by MW5PR12MB5621.namprd12.prod.outlook.com (2603:10b6:303:193::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Thu, 31 Mar
 2022 14:03:58 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::2b) by BN9PR03CA0241.outlook.office365.com
 (2603:10b6:408:ff::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.13 via Frontend
 Transport; Thu, 31 Mar 2022 14:03:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5123.19 via Frontend Transport; Thu, 31 Mar 2022 14:03:55 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 31 Mar
 2022 14:03:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 31 Mar
 2022 07:03:53 -0700
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Thu, 31 Mar
 2022 07:03:49 -0700
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
Subject: [PATCH v2 2/6] ASoC: tegra: Add Tegra186 based ASRC driver
Date:   Thu, 31 Mar 2022 19:33:28 +0530
Message-ID: <1648735412-32220-3-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1648735412-32220-1-git-send-email-spujar@nvidia.com>
References: <1648735412-32220-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39b82fef-8f60-4035-d1f3-08da131f4bbb
X-MS-TrafficTypeDiagnostic: MW5PR12MB5621:EE_
X-Microsoft-Antispam-PRVS: <MW5PR12MB5621F78E7E8BAA63DE5AEDE3A7E19@MW5PR12MB5621.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QCdcMB9QuIs0LgyBGJcvi0IXLAOQaCUTlTSEU6gOUqepRIcTH90RLfgZB0NycovlWoRtVOjE2UqieBtPO8PksQZGI8zfOPcx5utNyBbcku84JLynnmqBMr2Ae3kMDk9MjXq1DXYgYfr6FawsXGzomolmTcpHPf8N6iRvO6RfDQdSuxG/VNag60LHpjTKPtBO8TDr5qTb8NzgWCYXZmPOkhD8BwvGVFBqh0Ttr0ZhABtcmBznq3OF+oP0jWrqRcX/FLjgcRFKgY5BkAYGW1Y968SSK/rMO2kcyyAnCAFnNVinpLVUaXpAnEq1rcG2ELdmt9dQ+oxDeHbpxOq3Coru/M0L+vt/DdS8FRuQel4bWmfiKmwPadcpqIAhPY9VrnnxIF2foxGqEIFDJU0i6X5yemPx27ux0AdTutJYOXtcYaXCAvksBY1zqN3C5GyJNVsfVhpuIlbic+otspyH9aUOK7aepsmbkMRYnseAyHgmDrmDQJB5HobOAxsiefzg0fUM0p7pB9OtJqg0m8p07UtnxgUeLaSDNM6Xxu1S/YCorj8IpVeMlnIRfw67Ifb7cyg2xX+1Fb0N8RpWTi8wxU0VHeOa9Y5R1zEOLz5zSXieWuw6YEhLBrHci4vxwg3MEM7lRL3qhtGyB3v0chV2Xi9NShI1U9X7ebevD5T3d6HDqf4LUCo8Tvdz6YCzgjulGrMEJO2Nks4uq0kcjIetuGlAtg==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(7696005)(70586007)(2616005)(47076005)(86362001)(8676002)(36756003)(4326008)(54906003)(8936002)(316002)(2906002)(70206006)(6666004)(508600001)(110136005)(107886003)(426003)(40460700003)(82310400004)(36860700001)(186003)(5660300002)(336012)(30864003)(26005)(81166007)(83380400001)(7416002)(356005)(36900700001)(579004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 14:03:55.9360
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b82fef-8f60-4035-d1f3-08da131f4bbb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5621
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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
 sound/soc/tegra/tegra186_asrc.c | 1046 +++++++++++++++++++++++++++++++++++++++
 sound/soc/tegra/tegra186_asrc.h |  112 +++++
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
index 0000000..3c1e20cb
--- /dev/null
+++ b/sound/soc/tegra/tegra186_asrc.c
@@ -0,0 +1,1046 @@
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
+	  0x7500 }
+
+static const struct reg_default tegra186_asrc_reg_defaults[] = {
+	ASRC_STREAM_REG_DEFAULTS(0),
+	ASRC_STREAM_REG_DEFAULTS(1),
+	ASRC_STREAM_REG_DEFAULTS(2),
+	ASRC_STREAM_REG_DEFAULTS(3),
+	ASRC_STREAM_REG_DEFAULTS(4),
+	ASRC_STREAM_REG_DEFAULTS(5),
+
+	{ TEGRA186_ASRC_GLOBAL_ENB, 0},
+	{ TEGRA186_ASRC_GLOBAL_SOFT_RESET, 0},
+	{ TEGRA186_ASRC_GLOBAL_CG, 0x1 },
+	{ TEGRA186_ASRC_GLOBAL_CFG, 0x0 },
+	{ TEGRA186_ASRC_GLOBAL_SCRATCH_ADDR, 0},
+	{ TEGRA186_ASRC_GLOBAL_SCRATCH_CFG, 0x0c207980 },
+	{ TEGRA186_ASRC_RATIO_UPD_RX_CIF_CTRL, 0x00115500 },
+	{ TEGRA186_ASRC_GLOBAL_INT_MASK, 0x0},
+	{ TEGRA186_ASRC_GLOBAL_INT_SET, 0x0},
+	{ TEGRA186_ASRC_GLOBAL_INT_CLEAR, 0x0},
+	{ TEGRA186_ASRC_GLOBAL_APR_CTRL, 0x0},
+	{ TEGRA186_ASRC_GLOBAL_APR_CTRL_ACCESS_CTRL, 0x0},
+	{ TEGRA186_ASRC_GLOBAL_DISARM_APR, 0x0},
+	{ TEGRA186_ASRC_GLOBAL_DISARM_APR_ACCESS_CTRL, 0x0},
+	{ TEGRA186_ASRC_GLOBAL_RATIO_WR_ACCESS, 0x0},
+	{ TEGRA186_ASRC_GLOBAL_RATIO_WR_ACCESS_CTRL, 0x0},
+	{ TEGRA186_ASRC_CYA, 0x0},
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
+
+	/*
+	 * Below sequence is recommended after a runtime PM cycle.
+	 * This otherwise leads to transfer failures. The cache
+	 * sync is done after this to restore other settings.
+	 */
+	regmap_write(asrc->regmap, TEGRA186_ASRC_GLOBAL_SCRATCH_ADDR,
+		     TEGRA186_ASRC_ARAM_START_ADDR);
+	regmap_write(asrc->regmap, TEGRA186_ASRC_GLOBAL_ENB,
+		     TEGRA186_ASRC_GLOBAL_EN);
+
+	regcache_sync(asrc->regmap);
+
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
+	bool change = false;
+
+	asrc->lane[id].ratio_source = ucontrol->value.enumerated.item[0];
+
+	regmap_update_bits_check(asrc->regmap, asrc_private->reg,
+				 TEGRA186_ASRC_STREAM_RATIO_TYPE_MASK,
+				 asrc->lane[id].ratio_source,
+				 &change);
+
+	return change ? 1 : 0;
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
+	bool change = false;
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
+	regmap_update_bits_check(asrc->regmap,
+				 ASRC_STREAM_REG(TEGRA186_ASRC_RATIO_INT_PART,
+						 id),
+				 TEGRA186_ASRC_STREAM_RATIO_INT_PART_MASK,
+				 asrc->lane[id].int_part, &change);
+
+	tegra186_asrc_lock_stream(asrc, id);
+
+	return change ? 1 : 0;
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
+	bool change = false;
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
+	regmap_update_bits_check(asrc->regmap,
+				 ASRC_STREAM_REG(TEGRA186_ASRC_RATIO_FRAC_PART,
+						 id),
+				 TEGRA186_ASRC_STREAM_RATIO_FRAC_PART_MASK,
+				 asrc->lane[id].frac_part, &change);
+
+	tegra186_asrc_lock_stream(asrc, id);
+
+	return change ? 1 : 0;
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
+	int value = ucontrol->value.integer.value[0];
+
+	if (value == asrc->lane[id].hwcomp_disable)
+		return 0;
+
+	asrc->lane[id].hwcomp_disable = value;
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
+	int value = (asrc->lane[id].input_thresh & ~(0x3)) |
+		    ucontrol->value.integer.value[0];
+
+	if (value == asrc->lane[id].input_thresh)
+		return 0;
+
+	asrc->lane[id].input_thresh = value;
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
+	int value = (asrc->lane[id].output_thresh & ~(0x3)) |
+		    ucontrol->value.integer.value[0];
+
+	if (value == asrc->lane[id].output_thresh)
+		return 0;
+
+	asrc->lane[id].output_thresh = value;
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
+	/* Initialize default output srate */
+	for (i = 0; i < TEGRA186_ASRC_STREAM_MAX; i++) {
+		asrc->lane[i].ratio_source = TEGRA186_ASRC_RATIO_SOURCE_SW;
+		asrc->lane[i].int_part = 1;
+		asrc->lane[i].frac_part = 0;
+		asrc->lane[i].hwcomp_disable = 0;
+		asrc->lane[i].input_thresh =
+			TEGRA186_ASRC_STREAM_DEFAULT_INPUT_HW_COMP_THRESH_CFG;
+		asrc->lane[i].output_thresh =
+			TEGRA186_ASRC_STREAM_DEFAULT_OUTPUT_HW_COMP_THRESH_CFG;
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
index 0000000..094fcc7
--- /dev/null
+++ b/sound/soc/tegra/tegra186_asrc.h
@@ -0,0 +1,112 @@
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
+/* ASRC Global registers offset */
+#define TEGRA186_ASRC_GLOBAL_ENB			0x2f4
+#define TEGRA186_ASRC_GLOBAL_SOFT_RESET			0x2f8
+#define TEGRA186_ASRC_GLOBAL_CG				0x2fc
+#define TEGRA186_ASRC_GLOBAL_CFG			0x300
+#define TEGRA186_ASRC_GLOBAL_SCRATCH_ADDR		0x304
+#define TEGRA186_ASRC_GLOBAL_SCRATCH_CFG		0x308
+#define TEGRA186_ASRC_RATIO_UPD_RX_CIF_CTRL		0x30c
+#define TEGRA186_ASRC_RATIO_UPD_RX_STATUS		0x310
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
+#define TEGRA186_ASRC_GLOBAL_CFG_FRAC_28BIT_PRECISION		0
+#define TEGRA186_ASRC_GLOBAL_CFG_FRAC_32BIT_PRECISION		1
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

