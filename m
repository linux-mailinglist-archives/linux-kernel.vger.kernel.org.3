Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127C259108A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 14:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238438AbiHLMK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 08:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237026AbiHLMKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 08:10:48 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2065.outbound.protection.outlook.com [40.107.101.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C4015A2B
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 05:10:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZoG11EYhlHv08ujq51qG43Wo3MpNZs8pBJuj2opvLufIIy0/EzNWhi06w8kzIqdGkS7jDdwpp9Ucq9KxDWXPn4akOI/8Wzgb0DiD8BRBhWiFZGoTzSxgiI4y2Qow8jKYO8Gpxv61E23+jQ81hc4w1s8Jrde0jDZJW7Maz4l0Q39kQthOPq1kqplzdD9AQvRVNoihIUBpXU6sZEtEn/nt9Z65Z9VrxU6OhwYMV332wUFe+SN4jmlF+wZfDhhS7GFGCVQuChAK7hKoUJF9T8G7UcjmB2PAo3v1P144aJaT2bDqaFZjU0WUDZ3WObxlRgoa8jC6V3XqQxfd38iTa+8qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VbCKi3GglQJAJd2XTXoHLZHgpJ+9x68hNT1rRxm2ack=;
 b=Poivt4fvbL10hVPtrOj3TH8lRT6KwEbKngjaptI7HUiu6wCB6VG1CKZxYQS3kSJmPUezuwBzQR9aw9fFgu8o8Itr8gkNSeHS45t/2L1cbH/bnfs0/azn/hnLP2EecZwOZNWNDAWrh2F09THzwFlS1k7lhD44XnsB3OFzGggJ49C27TgSUMZ0GzZwuoeH4sNcxNQVJTGtFXr1zvpjMXjSphG++tdg1TLzduz4T65IEN6xMb6O8EdEeSEeUvZcp1bv4r5X6J2z3adAuWpvQ5arYq3NGQ0S2ZvItayI3lgA3treufexJRON77+dLfNN2VcnWZBRyxNGNYvFNxNtIX/ocw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbCKi3GglQJAJd2XTXoHLZHgpJ+9x68hNT1rRxm2ack=;
 b=eA56KwdNYVJ6RjDFioPgDbViQpiaJxwQpPckWd9+32c2pAILaLQyf1ABtnT19bjgh+duEDmxt6qNGpqtFWEu2H14UBloCtkzykexUou3Mek4KdEJEPBn0gj8iRa8/GXwA3d0MfQKQ4hcFlBg/npKb4asHoee2BbtDKdhtYDJ3A8=
Received: from DS7PR05CA0092.namprd05.prod.outlook.com (2603:10b6:8:56::10) by
 DM5PR1201MB0060.namprd12.prod.outlook.com (2603:10b6:4:51::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.15; Fri, 12 Aug 2022 12:10:42 +0000
Received: from DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::31) by DS7PR05CA0092.outlook.office365.com
 (2603:10b6:8:56::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.8 via Frontend
 Transport; Fri, 12 Aug 2022 12:10:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT039.mail.protection.outlook.com (10.13.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Fri, 12 Aug 2022 12:10:42 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 12 Aug
 2022 07:10:09 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 12 Aug
 2022 05:09:56 -0700
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 12 Aug 2022 07:09:52 -0500
From:   Syed Saba kareem <Syed.SabaKareem@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <mario.limonciello@amd.com>,
        Syed Saba kareem <Syed.SabaKareem@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 05/13] ASoC: amd: add acp6.2 pdm platform driver
Date:   Fri, 12 Aug 2022 17:37:23 +0530
Message-ID: <20220812120731.788052-6-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812120731.788052-1-Syed.SabaKareem@amd.com>
References: <20220812120731.788052-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6db49eb-3f12-4ebd-dd63-08da7c5badef
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0060:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BttHAK0faGhTHPlLECq0J2OOHZxy++pxtxcSKxFm5I/czQhn6Sw2dxt3xZccLpmQiZNVoiF/aLS+Fntdp+8JLtjHOFnbR/9MkVxkrM8fOEs1YPE3e6gvF/MhZIixSe6G/BnRpD7cSlvjiu8kvG5ptuosk2hU2eKuzwLS9fSdZopLPET0DKmVk38syj49yfTPPg9m+RtQbsbDHK0VM+DklDzD65htVinGdvyFSdl16NftzKQkBa0kUj20ONQd89EqyLDa8WcLIcUPrHw8pc+VuqTEkapewZRWQURgnUlR9W8EOSrxAdCxWA13U25Sa8/tXmZbaKu97AFpZ0Rj+qCFpln8hQ6loX+053V0nzGphEgSxufv/ZqtXlNaYKkdUc2xkOyt+0XFcxK34jj2Qn2KPkkd9X91rrY2weFhtwN2o+NU/0TIsQUKZlsB2caEuAMsZYa0/o42idkkj1tk4KNGzTrpguIZ/Ghsiye4EqvwfZL/JcqwG/55GTz1q9Og1N5M1d6kdCQI/BJr3ZS0uxK+n2zaDsL+WMv99sVfTCL+F4Ca+ra2cxb80nZMAssJ1LXmxgZyNp8lWMAaIHE0IYwTnK58PXYoWK94wtUPd+mGlQQR3Kx9hhRoYPksv6DzIQaLVuo5frCd8LSG+BsOTzv07W0tmqlldDGT8icolx8VsedGqc256QTfNR26UN4GkE3Tw9AIKiLBOokxuWWUJ+yln6PJZVFKcgBjVBL3GOrH/WPaZBA17PXo3ivQWtdyQVSJ2DA45n+KkIpfog1vhR7sECXn8roeukPxiRV4Vq7/hFDLLjiLpMSLk1tre/ISMI+AcKD3GIC35W0qUTtuo5S0yw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(396003)(346002)(376002)(46966006)(40470700004)(36840700001)(82740400003)(4326008)(70586007)(70206006)(8676002)(8936002)(478600001)(5660300002)(356005)(81166007)(316002)(2616005)(54906003)(110136005)(336012)(186003)(36860700001)(1076003)(47076005)(40460700003)(6666004)(426003)(41300700001)(7696005)(26005)(40480700001)(36756003)(86362001)(82310400005)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 12:10:42.7299
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6db49eb-3f12-4ebd-dd63-08da7c5badef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0060
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PDM platform driver binds to the platform device created by
ACP6.2 PCI device. PDM driver registers ALSA DMA and CPU DAI
components with ASoC framework.

Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
---
 sound/soc/amd/ps/acp62.h      |  5 +++
 sound/soc/amd/ps/ps-pdm-dma.c | 82 +++++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+)
 create mode 100644 sound/soc/amd/ps/ps-pdm-dma.c

diff --git a/sound/soc/amd/ps/acp62.h b/sound/soc/amd/ps/acp62.h
index ab56e1f8c31b..7636bfeb8a8a 100644
--- a/sound/soc/amd/ps/acp62.h
+++ b/sound/soc/amd/ps/acp62.h
@@ -45,6 +45,11 @@ enum acp_config {
 	ACP_CONFIG_15,
 };
 
+struct pdm_dev_data {
+	void __iomem *acp62_base;
+	struct snd_pcm_substream *capture_stream;
+};
+
 static inline u32 acp62_readl(void __iomem *base_addr)
 {
 	return readl(base_addr - ACP62_PHY_BASE_ADDRESS);
diff --git a/sound/soc/amd/ps/ps-pdm-dma.c b/sound/soc/amd/ps/ps-pdm-dma.c
new file mode 100644
index 000000000000..bca2ac3e81f5
--- /dev/null
+++ b/sound/soc/amd/ps/ps-pdm-dma.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * AMD ALSA SoC Pink Sardine PDM Driver
+ *
+ * Copyright 2022 Advanced Micro Devices, Inc.
+ */
+
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dai.h>
+
+#include "acp62.h"
+
+#define DRV_NAME "acp_ps_pdm_dma"
+
+static struct snd_soc_dai_driver acp62_pdm_dai_driver = {
+	.name = "acp_ps_pdm_dma.0",
+	.capture = {
+		.rates = SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S32_LE,
+		.channels_min = 2,
+		.channels_max = 2,
+		.rate_min = 48000,
+		.rate_max = 48000,
+	},
+};
+
+static const struct snd_soc_component_driver acp62_pdm_component = {
+	.name		= DRV_NAME,
+};
+
+static int acp62_pdm_audio_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct pdm_dev_data *adata;
+	int status;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "IORESOURCE_MEM FAILED\n");
+		return -ENODEV;
+	}
+
+	adata = devm_kzalloc(&pdev->dev, sizeof(*adata), GFP_KERNEL);
+	if (!adata)
+		return -ENOMEM;
+
+	adata->acp62_base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
+	if (!adata->acp62_base)
+		return -ENOMEM;
+
+	adata->capture_stream = NULL;
+
+	dev_set_drvdata(&pdev->dev, adata);
+	status = devm_snd_soc_register_component(&pdev->dev,
+						 &acp62_pdm_component,
+						 &acp62_pdm_dai_driver, 1);
+	if (status) {
+		dev_err(&pdev->dev, "Fail to register acp pdm dai\n");
+
+		return -ENODEV;
+	}
+	return 0;
+}
+
+static struct platform_driver acp62_pdm_dma_driver = {
+	.probe = acp62_pdm_audio_probe,
+	.driver = {
+		.name = "acp_ps_pdm_dma",
+	},
+};
+
+module_platform_driver(acp62_pdm_dma_driver);
+
+MODULE_AUTHOR("Syed.SabaKareem@amd.com");
+MODULE_DESCRIPTION("AMD PHEONIX PDM Driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.25.1

