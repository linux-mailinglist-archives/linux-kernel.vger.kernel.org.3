Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F633591094
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 14:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238533AbiHLMMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 08:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238512AbiHLML2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 08:11:28 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F0528E21
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 05:11:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFcWGJRGkrkwwLl9sFoZ/i4dZx0UzwfiPWYJJyRrF9pL+sTJX5Pi5tk88WUZxQcHMIRxFjPHpVnhFig9Ir8JmgBtxkq+EYDqbaADWNsPXm5BrottPsG74HEn/hyBonh2pzBmhjx2EEFk7dIFuIMqo2ywyeIKeQjX6A8ymm/ENjrx5T/DDKY5TtMB1FqVvaevEgoNgIlM5p7hXmeUpTwRMkIddeTBVW+xxmijhRGrbpNrMaFVnBFP7+15MUrrGaY+rR3NoY6f/gsCkTfb8Uq2ppcIS9YVlR6MGPhhcs7494juOXMr/HbOf9OutfOf/lZ1RKHSdc2TgeEB8yD7eMVScA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/qvHoA1DGo0Ik5alvcHg3T3expaXE+lSPAGZgi46sfs=;
 b=ddMlGZWRQQsRqTyAhHu13u6ldHYw93/eD36Ts2si01K1kTeMaDmgonB7kcqCe97KYaNYC3lgRG956Y4O79hLPa5EnsQYYHIO83PsK84Ab+uRCthA7oxD3DjtXAou5KnXDWwq2tfYWOwEptEgZaghBrMVKytwzYPLA3I3lXwSJA0NDUKigueKZI/zVtj4HC7X2uarOE42rFM+aGjNiDXtK+fxR6wCTTzJjIThresEGAzmB5Cn7bjv1tJH6lFRAlbT0eJ/jPCQi9B1DouJD/Ox7qRlvLz46M5hPn0yFqD8YtXpgcm7Z54v9Qo3037B3vOGUSfAfCQxdWuIrQiL+/ni8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qvHoA1DGo0Ik5alvcHg3T3expaXE+lSPAGZgi46sfs=;
 b=v7IB7TnhBpcq6AvRwDg1P24MlxzWyFDa635Tq9VWpz1uGHlSqt5r6I4ooV5E7m+gPTnnpdg7hXTV/x3zJuv7ZBdeViacwOr+41n1pR4wP14NxDshw4A18NpbxZwwmNKRisdJLUjDgic7ZQdTYNwOkFBdFuIX2lOSgzoI2lcrJfs=
Received: from DM6PR10CA0014.namprd10.prod.outlook.com (2603:10b6:5:60::27) by
 CH2PR12MB3767.namprd12.prod.outlook.com (2603:10b6:610:26::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.17; Fri, 12 Aug 2022 12:11:17 +0000
Received: from DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::17) by DM6PR10CA0014.outlook.office365.com
 (2603:10b6:5:60::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.19 via Frontend
 Transport; Fri, 12 Aug 2022 12:11:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT039.mail.protection.outlook.com (10.13.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Fri, 12 Aug 2022 12:11:17 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 12 Aug
 2022 07:11:16 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 12 Aug
 2022 05:10:44 -0700
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 12 Aug 2022 07:10:41 -0500
From:   Syed Saba kareem <Syed.SabaKareem@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <mario.limonciello@amd.com>,
        Syed Saba kareem <Syed.SabaKareem@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 09/13] ASoC: amd: add acp6.2 pdm driver pm ops
Date:   Fri, 12 Aug 2022 17:37:27 +0530
Message-ID: <20220812120731.788052-10-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812120731.788052-1-Syed.SabaKareem@amd.com>
References: <20220812120731.788052-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c7b7caf-166b-499f-0451-08da7c5bc2b9
X-MS-TrafficTypeDiagnostic: CH2PR12MB3767:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wn51SiB6J7oy0eVqveox9tiNbhK0rwMwrM8jipbGSEw307JR0spkCi+uw5qNF4Pjb9CnfXXf7wvK1oCGxNf56fqYJwDf83mIONPXBa6DkG/0YjsaXMGlAFGwihz2jwJ1cG1UTMhSQXUmuQ4YySDtY6WemfZ4yGy9yX1Nji6511l3+rhHXu9zIMvkfqOdlggvJYP1EX1rr4i9vpF2mhz0XVO9hJ9RN+bYuQshiOw4mnfiW/bT4e124SNVxMwvPwiFc5kXN4B1tmZLhDnJiR3gRqfvIxu1JZSsvOvExkhq8udkqKqSonrMiEjxC0EwPWXyp4ETfbECvBgCukox71P1BERlowTR0HamkPDZouTLsJnJlXjS/cCQuy1kgl6K0SYkEOeNOHkba8CMOpeix9BhcVj4V/tj3vqXcEWStx1A1SXCgiKBJxES8/Zf9Ak1OJD8Q6hF8TiVrvpYbmL0wX2nh1Opt4RYfwXmGNNd+BKd9VNAfQcMw7Bxnh7p2hzA43HhnBlmvilmcbqhFWApJrjmCYP+6s62DGysEdPyHI8OwSdQv+0tm19mFHVCR0bwKwdA8JMi2ByNLmOftewWY02iRBguShYOWwhiOg2+4q0PQuVuZqvMcMCSb9A9vNFiinh33xFPM1TZ74LxHwBhXS6ATHzxvov/Wp6IDK7vI+j7CVLFoueFJ2bdXQtlfSeWkquwr/89zEAtx+PaAoSWY8ZprTyVla/QU9/ToNYrgjLCduh7Ug4LUTtsQ89UHYnR1ZkoANUZp9OVZ9iYzwTWz/8jgNFFtOtyr9EUeTBwHLC2D+F7XCgGxYcznDp0q5yFgFszdqKoOdMmYK79TWhgXe64jw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(39860400002)(396003)(346002)(46966006)(36840700001)(40470700004)(40460700003)(478600001)(26005)(41300700001)(6666004)(7696005)(4326008)(8676002)(5660300002)(70206006)(70586007)(316002)(54906003)(36756003)(86362001)(8936002)(2906002)(82740400003)(186003)(336012)(426003)(1076003)(2616005)(83380400001)(47076005)(110136005)(40480700001)(81166007)(356005)(82310400005)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 12:11:17.6026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7b7caf-166b-499f-0451-08da7c5bc2b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3767
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add acp6.2 pdm driver pm ops.

Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
---
 sound/soc/amd/ps/ps-pdm-dma.c | 57 +++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/sound/soc/amd/ps/ps-pdm-dma.c b/sound/soc/amd/ps/ps-pdm-dma.c
index a98a2015015d..7400fc7e1afd 100644
--- a/sound/soc/amd/ps/ps-pdm-dma.c
+++ b/sound/soc/amd/ps/ps-pdm-dma.c
@@ -12,6 +12,7 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/soc-dai.h>
+#include <linux/pm_runtime.h>
 
 #include "acp62.h"
 
@@ -374,13 +375,69 @@ static int acp62_pdm_audio_probe(struct platform_device *pdev)
 
 		return -ENODEV;
 	}
+	pm_runtime_set_autosuspend_delay(&pdev->dev, ACP_SUSPEND_DELAY_MS);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_allow(&pdev->dev);
 	return 0;
 }
 
+static int acp62_pdm_audio_remove(struct platform_device *pdev)
+{
+	pm_runtime_disable(&pdev->dev);
+	return 0;
+}
+
+static int __maybe_unused acp62_pdm_resume(struct device *dev)
+{
+	struct pdm_dev_data *adata;
+	struct snd_pcm_runtime *runtime;
+	struct pdm_stream_instance *rtd;
+	u32 period_bytes, buffer_len;
+
+	adata = dev_get_drvdata(dev);
+	if (adata->capture_stream && adata->capture_stream->runtime) {
+		runtime = adata->capture_stream->runtime;
+		rtd = runtime->private_data;
+		period_bytes = frames_to_bytes(runtime, runtime->period_size);
+		buffer_len = frames_to_bytes(runtime, runtime->buffer_size);
+		acp62_config_dma(rtd, SNDRV_PCM_STREAM_CAPTURE);
+		acp62_init_pdm_ring_buffer(PDM_MEM_WINDOW_START, buffer_len,
+					   period_bytes, adata->acp62_base);
+	}
+	acp62_enable_pdm_interrupts(adata->acp62_base);
+	return 0;
+}
+
+static int __maybe_unused acp62_pdm_suspend(struct device *dev)
+{
+	struct pdm_dev_data *adata;
+
+	adata = dev_get_drvdata(dev);
+	acp62_disable_pdm_interrupts(adata->acp62_base);
+	return 0;
+}
+
+static int __maybe_unused acp62_pdm_runtime_resume(struct device *dev)
+{
+	struct pdm_dev_data *adata;
+
+	adata = dev_get_drvdata(dev);
+	acp62_enable_pdm_interrupts(adata->acp62_base);
+	return 0;
+}
+
+static const struct dev_pm_ops acp62_pdm_pm_ops = {
+	SET_RUNTIME_PM_OPS(acp62_pdm_suspend, acp62_pdm_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(acp62_pdm_suspend, acp62_pdm_resume)
+};
+
 static struct platform_driver acp62_pdm_dma_driver = {
 	.probe = acp62_pdm_audio_probe,
+	.remove = acp62_pdm_audio_remove,
 	.driver = {
 		.name = "acp_ps_pdm_dma",
+		.pm = &acp62_pdm_pm_ops,
 	},
 };
 
-- 
2.25.1

