Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183CB5A3901
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 19:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbiH0RAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 13:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbiH0RAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 13:00:39 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9148C24BEE
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 10:00:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9jnk8RXadKmr759ZD2ILDJTx6Sd1xO+P7nff9KhXNhGKe3bE1vLTFUyvA7VnVPNEm0pk70Wq4zYZ4WRCZubQ8dtb1BtwRSBunr/EbZaveu48TdiImi1z3J3+OVdyHj7nFY7XbOZVSVIhjYdgVnuw9G3nUUGs0rMJ7jJVHOT6OYCvCxUjszJQkg2n4riF/ZVt1J0LejWESri1LLCtv991v0ZKax2Jsi5RNlNVEtJM9G4E45Jg/mJlBfmm4Bghr+znXfYPVuyEjJD9saMjnlqcFFtZb2sLYBwouPCnVZxI5CagYn+k2fBtaJU2xqbNfXSXObxe+kmRmTJbAyDG273NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PXGjTHeX6pb44lYunRSKdKZY77FFDMm2Tlgyls6mclI=;
 b=HDoWjpZc4eZgCyUkcNYe1ivq2z0TaDOTcfWH5py6LsEDjWB+nV1u71NwSVXw5itTLPwxAgoW9TRwCVxtracCrtvB5+5Y3YOqMX445qlJAS3cAee/zfbZjcNYFdA9pvkYahU7H4YKFExJf5IIKXza/4e36ClUfkuUdeUDqId5j2uu6qO8slDkDDsLSgLsdRRzbu83MGwcQMnM++GiLfeHkc+knBu6m0Z/QAUG186r45hEvbVmjWniIZ69XqP12IFaj2Kc8LUxPYG8VU5+sJHYWpj6KmFqYT31MZhBg7x+9cWcKuOIcJ/OqrmSt4QuNacrM+n7G4YsPs5SZF7j6K+LcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXGjTHeX6pb44lYunRSKdKZY77FFDMm2Tlgyls6mclI=;
 b=N4HYffOP1IRG7uTSVJWHXIv9pORtjV7TlJmQLfSSzHVU+1e2bX5OKAnNIhNT1lsnWkh2lhflHZFDegMF8mnMZodhuZa56wmT+wAjbooKCE0RmX3DjihB4llXQXNMFxT3E70Wn2riuwr3Py6U5o8BVhIFzAqRhOVvEqxcIJab5io=
Received: from DS7PR03CA0320.namprd03.prod.outlook.com (2603:10b6:8:2b::15) by
 CY8PR12MB7122.namprd12.prod.outlook.com (2603:10b6:930:61::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.18; Sat, 27 Aug 2022 17:00:29 +0000
Received: from DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::9e) by DS7PR03CA0320.outlook.office365.com
 (2603:10b6:8:2b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Sat, 27 Aug 2022 17:00:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT089.mail.protection.outlook.com (10.13.173.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Sat, 27 Aug 2022 17:00:28 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sat, 27 Aug
 2022 12:00:28 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sat, 27 Aug
 2022 10:00:28 -0700
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Sat, 27 Aug 2022 12:00:24 -0500
From:   Syed Saba Kareem <Syed.SabaKareem@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <mario.limonciello@amd.com>,
        <alexander.deucher@amd.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 09/13] ASoC: amd: add acp6.2 pdm driver pm ops
Date:   Sat, 27 Aug 2022 22:26:53 +0530
Message-ID: <20220827165657.2343818-10-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220827165657.2343818-1-Syed.SabaKareem@amd.com>
References: <20220827165657.2343818-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c1ea1e1-ba2a-46fa-21c1-08da884da51a
X-MS-TrafficTypeDiagnostic: CY8PR12MB7122:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: po7IXpSnkBbErRVEgMvy2Bf+nZb9Fzo0gkZaKf5yVstDnIK9FeW6gd5WuGUTQQ/ZlnlKTrdC8oKu/FSal+djBYJgqy7kt5Xhy/btIRdjpM8BHpxVQNpi/pS0zDX0l8CnOedJFS9874fY5KWxuDYiYAhSigkCzIle7PMgvX3/qkrSpaFMCPAUx+9YdIaHT0doJTzgltlGYAro8DZpsfK+Adx72jEOwfS2aPqq2L4W9h4RhlecDgLdehswgZgx7SvsR2atxSNokNrIysKpLTETY+Sua76yFJw/p9CpyvRTlA7HIgroi0tVcLBbscAVI8iHbu6quJMMjGsUSANtCQC8eM6k5n7qY3Fqcg5XPrOXUxHgyGODUxx5x70IWTDhzNVuz1vajVDrLJWHk5WTwpN5zbFzW/s9ybFX/m4FOGXQFNuBq8Bjp/pXu2KYqcudGdkqw+1/+e4K2Jd5aIqp8oF5Kb2mrWdWnxbNH+xAr23MDc4Tod66d89Q7HeGChpWjE8tbdWvQQAw8sJrCaUVRZpFNkKRMuY4ncJt28iPjZxhj/415KMYn7K7xMwoX9xMgVjddHZEtkkOJYmJzOh/Pyub0SFn2Sg7GNTmvalKf76pZEGkg5060luTzDIW+Mw5RjfaD1P4PsngmZ/RwSSZ6SsIYDl5c63rJ0gI5a2dv8+2OMsFr0x66lXOyhnc2uqrxxUwiaJX8mrTA6/Q+Wja+rP5/9gxQ4nHJozZvr+0o4IJnQEAJRpXeocFbUJNwk3TczYVq9PD2KbygcIovD4GXxdidQpNJjfYxniXEkszjwhVHcVdCe6fpVoix2TPVTlFzKvE
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(136003)(346002)(376002)(36840700001)(46966006)(40470700004)(2616005)(7696005)(6666004)(316002)(83380400001)(186003)(426003)(1076003)(26005)(336012)(47076005)(41300700001)(478600001)(5660300002)(40460700003)(82310400005)(8936002)(2906002)(40480700001)(70586007)(54906003)(110136005)(82740400003)(4326008)(8676002)(81166007)(356005)(86362001)(36756003)(36860700001)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 17:00:28.9065
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c1ea1e1-ba2a-46fa-21c1-08da884da51a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7122
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
Reviewed-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/ps/ps-pdm-dma.c | 57 +++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/sound/soc/amd/ps/ps-pdm-dma.c b/sound/soc/amd/ps/ps-pdm-dma.c
index f0ec1a4f3b9d..b207b726cd82 100644
--- a/sound/soc/amd/ps/ps-pdm-dma.c
+++ b/sound/soc/amd/ps/ps-pdm-dma.c
@@ -12,6 +12,7 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/soc-dai.h>
+#include <linux/pm_runtime.h>
 
 #include "acp62.h"
 
@@ -377,13 +378,69 @@ static int acp62_pdm_audio_probe(struct platform_device *pdev)
 
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

