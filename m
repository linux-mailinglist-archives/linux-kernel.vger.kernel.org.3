Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0BD54C0D2A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 08:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238617AbiBWHYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 02:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235001AbiBWHYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 02:24:06 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019A66C97C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 23:23:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byYcToTQkqYE2uvYxOScd0puLQZlLV9x9rkmFU5YgaMJi25/iVRlGOrFNCmBpNglo0XcJQ7PdTGO/IF8utnmqd9rOn768KzOtkIC1eHE/z6UhNUmc1UhMo/SBKWUs+jQeY/0AcOpEzsoWy9zwZUQjC0lr9ZSE5oeSsdOjlpJkwLW6V4mYXe09M0k89fkKHkuiiWAYLxhuqOnnotX2q+3OCmQdwxcbpG0Cs8MLJ3mcsbdAt2bCh3IOJO3nsbpumqnPQk0o0HbFtWvUgAMfjdLhlb8iLBGzxhMt5F5sbzXfuJuNkc3QZLtItL1Knx2tB/95Ory7g6uxbPegBD0JppStg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSLPIoyCoYNuCv031q6KvtizgGgQUbbVBnrTpN1trrA=;
 b=a/pyGLNScTMs1QTzIAbqZ2ZvBJzt54NYyrUaasplavgEkGLi6KwfEAdMsqrmSuBR5DeKZxoowaTm70rYu71n09b5Lvfk1FZ9Tx2HcnQJ9CmZbW0/8FPs+V0rVSRS30hV4PcWxL+7aa9K0WirK5RZ3/KUR0nxE5vvp18U9Aw7vB5KvcKLgmfu6OKkP2qknpMXo9kcnn1PNwHqgYNkfo2S/RrfUobbTYaTgVHqhHGjdIGAmC6hSSEanNQGfXxJVadvQGio+Z+qQD1V+HznV1o6FHLcyn2n+b5sHi0XzbT8tU7BbgMbYoO9MfuvakAZLtqkCgV8j30Q6g/6qPP6YVWh+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSLPIoyCoYNuCv031q6KvtizgGgQUbbVBnrTpN1trrA=;
 b=btVK9KS5D6EFc+sp0Ctw3i2cKNsOeNf0KzlWUfn55kyrrf5xNiNrXH5uWcX/QPWs6LYYNEDszhMDwqbJa9boY0MPMkClWC4/6iAr7Pv5+q2yxj+CS0jowkm3s61Ond/h2S/m61PqXNzMVqEN4gydLDDHjNJKIxkeFV5AMqcAoig=
Received: from BN9PR03CA0507.namprd03.prod.outlook.com (2603:10b6:408:130::32)
 by MW2PR12MB2348.namprd12.prod.outlook.com (2603:10b6:907:e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 23 Feb
 2022 07:23:35 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::c5) by BN9PR03CA0507.outlook.office365.com
 (2603:10b6:408:130::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Wed, 23 Feb 2022 07:23:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Wed, 23 Feb 2022 07:23:34 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 23 Feb
 2022 01:23:34 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 23 Feb
 2022 01:23:33 -0600
Received: from LinuxHost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Wed, 23 Feb 2022 01:23:30 -0600
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Alexander.Deucher@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <krisman@collabora.com>, <wtli@nuvoton.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/9] ASoC: amd: vg: fix for pm resume callback sequence
Date:   Wed, 23 Feb 2022 12:49:30 +0530
Message-ID: <20220223071959.13539-1-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97ec166d-e9fe-48df-65f6-08d9f69d66f3
X-MS-TrafficTypeDiagnostic: MW2PR12MB2348:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB23488A22BA653982DC15926F973C9@MW2PR12MB2348.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qjoTapz/IusMGuYJqufDOw4N2Dgzt91zvtht8NvvNo5waYxd4yxU0xR2wLXUYK6rdV8eq+6eE//dBQUzYcgcQAYdBBn3/L2vIMJcktToIj+vMn9X1YrjaN4mPuAvgP0o77eIedcGRaBEPCGJQFUJqShGhiQ/NeFkcwVJFqb3DWhDDOvAB84zSraNb2KTd63An8UYxqG74smggdbLmfJxKZx1Hy7edGdlouRCHUq+AzCIAOJG73H5dohPm3Ot+rJMnfLnm8cxCju6u1Pgx1jQHHL/hqj74cqOvxcd/tGcyiXfeXGoWEe+XyZsYHZ3fho5vljkG2xefqwp05PpKkQsP7QH79APGvnsFgGh8ucIi79RBaoedFD8IuAh+8bAJt2ckTIM7ImuqZWJlpy0aV+lhvkSD/51VxGdkQcOV8fldl3WySFcH0OqUw4qtjxm3wzRUz/2N0ZoYICIq+h50HK1CpLVWFvxww5ABGk2IEhuN+XZKMExqGjcBaTI+wNQjMgYYDfKHUJgJfvRPz8h+bFuBele4zq51sSibG7tqhPxCpLDFCHMrHvDgkaGCMz1yGAZBk+dxMXgmjxIsXAMglpSR6Sl4Mrj/8DiyUnRwK20mLwiyb+uBeJ8DMae87DQxyS+w3f6+6qIoNaNFEV6xkfjzDltJh9LEdqAC2gefblIwWaNTVunL74NJk/PguqbYFL6dGWDbDsQpmC0z0Oz7FCfWg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(8936002)(2616005)(336012)(7696005)(186003)(26005)(508600001)(356005)(86362001)(40460700003)(1076003)(70586007)(70206006)(4326008)(8676002)(81166007)(5660300002)(82310400004)(36860700001)(47076005)(54906003)(83380400001)(316002)(36756003)(110136005)(2906002)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 07:23:34.6536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97ec166d-e9fe-48df-65f6-08d9f69d66f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2348
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous condition is used to cross check only the active
stream status for I2S HS instance playback and capture use cases.

Modified logic to invoke sequence for two i2s controller instances.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/vangogh/acp5x-pcm-dma.c | 62 ++++++++++++++-------------
 1 file changed, 32 insertions(+), 30 deletions(-)

diff --git a/sound/soc/amd/vangogh/acp5x-pcm-dma.c b/sound/soc/amd/vangogh/acp5x-pcm-dma.c
index f10de38976cb..17853d8d56d3 100644
--- a/sound/soc/amd/vangogh/acp5x-pcm-dma.c
+++ b/sound/soc/amd/vangogh/acp5x-pcm-dma.c
@@ -426,6 +426,7 @@ static int acp5x_audio_remove(struct platform_device *pdev)
 static int __maybe_unused acp5x_pcm_resume(struct device *dev)
 {
 	struct i2s_dev_data *adata;
+	struct i2s_stream_instance *rtd;
 	u32 val, reg_val, frmt_val;
 
 	reg_val = 0;
@@ -433,44 +434,45 @@ static int __maybe_unused acp5x_pcm_resume(struct device *dev)
 	adata = dev_get_drvdata(dev);
 
 	if (adata->play_stream && adata->play_stream->runtime) {
-		struct i2s_stream_instance *rtd =
-			adata->play_stream->runtime->private_data;
+		rtd = adata->play_stream->runtime->private_data;
 		config_acp5x_dma(rtd, SNDRV_PCM_STREAM_PLAYBACK);
-		switch (rtd->i2s_instance) {
-		case I2S_HS_INSTANCE:
-			reg_val = ACP_HSTDM_ITER;
-			frmt_val = ACP_HSTDM_TXFRMT;
-			break;
-		case I2S_SP_INSTANCE:
-		default:
-			reg_val = ACP_I2STDM_ITER;
-			frmt_val = ACP_I2STDM_TXFRMT;
+		acp_writel((rtd->xfer_resolution  << 3), rtd->acp5x_base + ACP_HSTDM_ITER);
+		if (adata->tdm_mode == TDM_ENABLE) {
+			acp_writel(adata->tdm_fmt, adata->acp5x_base + ACP_HSTDM_TXFRMT);
+			val = acp_readl(adata->acp5x_base + ACP_HSTDM_ITER);
+			acp_writel(val | 0x2, adata->acp5x_base + ACP_HSTDM_ITER);
+		}
+	}
+	if (adata->i2ssp_play_stream && adata->i2ssp_play_stream->runtime) {
+		rtd = adata->i2ssp_play_stream->runtime->private_data;
+		config_acp5x_dma(rtd, SNDRV_PCM_STREAM_PLAYBACK);
+		acp_writel((rtd->xfer_resolution  << 3), rtd->acp5x_base + ACP_I2STDM_ITER);
+		if (adata->tdm_mode == TDM_ENABLE) {
+			acp_writel(adata->tdm_fmt, adata->acp5x_base + ACP_I2STDM_TXFRMT);
+			val = acp_readl(adata->acp5x_base + ACP_I2STDM_ITER);
+			acp_writel(val | 0x2, adata->acp5x_base + ACP_I2STDM_ITER);
 		}
-		acp_writel((rtd->xfer_resolution  << 3),
-			   rtd->acp5x_base + reg_val);
 	}
 
 	if (adata->capture_stream && adata->capture_stream->runtime) {
-		struct i2s_stream_instance *rtd =
-			adata->capture_stream->runtime->private_data;
+		rtd = adata->capture_stream->runtime->private_data;
 		config_acp5x_dma(rtd, SNDRV_PCM_STREAM_CAPTURE);
-		switch (rtd->i2s_instance) {
-		case I2S_HS_INSTANCE:
-			reg_val = ACP_HSTDM_IRER;
-			frmt_val = ACP_HSTDM_RXFRMT;
-			break;
-		case I2S_SP_INSTANCE:
-		default:
-			reg_val = ACP_I2STDM_IRER;
-			frmt_val = ACP_I2STDM_RXFRMT;
+		acp_writel((rtd->xfer_resolution  << 3), rtd->acp5x_base + ACP_HSTDM_IRER);
+		if (adata->tdm_mode == TDM_ENABLE) {
+			acp_writel(adata->tdm_fmt, adata->acp5x_base + ACP_HSTDM_RXFRMT);
+			val = acp_readl(adata->acp5x_base + ACP_HSTDM_IRER);
+			acp_writel(val | 0x2, adata->acp5x_base + ACP_HSTDM_IRER);
 		}
-		acp_writel((rtd->xfer_resolution  << 3),
-			   rtd->acp5x_base + reg_val);
 	}
-	if (adata->tdm_mode == TDM_ENABLE) {
-		acp_writel(adata->tdm_fmt, adata->acp5x_base + frmt_val);
-		val = acp_readl(adata->acp5x_base + reg_val);
-		acp_writel(val | 0x2, adata->acp5x_base + reg_val);
+	if (adata->i2ssp_capture_stream && adata->i2ssp_capture_stream->runtime) {
+		rtd = adata->i2ssp_capture_stream->runtime->private_data;
+		config_acp5x_dma(rtd, SNDRV_PCM_STREAM_CAPTURE);
+		acp_writel((rtd->xfer_resolution  << 3), rtd->acp5x_base + ACP_I2STDM_IRER);
+		if (adata->tdm_mode == TDM_ENABLE) {
+			acp_writel(adata->tdm_fmt, adata->acp5x_base + ACP_I2STDM_RXFRMT);
+			val = acp_readl(adata->acp5x_base + ACP_I2STDM_IRER);
+			acp_writel(val | 0x2, adata->acp5x_base + ACP_I2STDM_IRER);
+		}
 	}
 	acp_writel(1, adata->acp5x_base + ACP_EXTERNAL_INTR_ENB);
 	return 0;
-- 
2.17.1

