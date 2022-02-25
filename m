Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939A64C4EE9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 20:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235183AbiBYTfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 14:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235120AbiBYTfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 14:35:05 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547D01AAFEE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 11:34:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afh689PBRQN8zWpeYXG19m/RvOkePqhN4snsiDyksVZfGQBB5zYa9pV8PLoSS6yhH9TKGkOtu3lCrNP+5oa2n4+oOipkgXvev5VwIc/BxR41aq2nVYirimsxhTZj8S7NfxRwEv4HwQOdKEMKKTtNxw35s5/8o/l8G4MG/3tqS0eBdtysiolSf6v7Zw4bPjHXF1o+y4LIkJ3poHCvca04FeuAWIEr6DG4vyu0gizAKHgW9b6kk/FnWgxOs7nnqJcEDUjy18/WzHAve9XOizp1bJVtqcWhswl0lowTRaou4kS2GyrllhqKetOFuZb3WyVmO6AUFaYbHe95PsxwPyLuRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4iCuCH2MuvL1Pac9ZBzri5Qyjh60V/auyMMDJtpiN3I=;
 b=oI4ZB175W1JV1LqiptDpC9mVNprL3Wmx5OEvsmbk4OrbsTGRfmHTlfAb0d4zAns0PkmxE+E5GEnlS/heO8fu1DjrJijxsTVFEZXMdg45LvFYhV/w4Dw7jlNuj9hKmt4V267KM+QnO45sg95ZkpMAeGsz3DP3Ls6fOcSOASeHIAxwUBQQqZlmlui6FVWLJ44P//34mApo4chjX6HjTSqzOW11UTReqnox1PKXYcYQBcjEAssEohsBwFsbQ6AYi/g09ZjW870flzi4BPhkFD69CHEu4Jz9Y9/2fHUut7z4Yn4xia/vzdXNzhexSgib/fn2G85NeRREpaj+N7PlMXATEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4iCuCH2MuvL1Pac9ZBzri5Qyjh60V/auyMMDJtpiN3I=;
 b=ee1vhTjdQutwQB/IwlnUjC5+2EHVCqaVLdtfMqmGXcsVc7rAyCUMG/Mrm8lYnGBDKdwyxFzpJegUMMo8MDmH7XZQLP2z+6X9AiLzMsbGiGb2h5hlwlQXOT31Ly8D4mXEYYca4QsLJLDhD6D5YFx2rBnZuYduCLWg1OqecawTJp8=
Received: from MW2PR16CA0028.namprd16.prod.outlook.com (2603:10b6:907::41) by
 PH0PR12MB5646.namprd12.prod.outlook.com (2603:10b6:510:143::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.21; Fri, 25 Feb 2022 19:34:30 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::fa) by MW2PR16CA0028.outlook.office365.com
 (2603:10b6:907::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25 via Frontend
 Transport; Fri, 25 Feb 2022 19:34:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Fri, 25 Feb 2022 19:34:29 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 25 Feb
 2022 13:34:28 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 25 Feb
 2022 13:34:28 -0600
Received: from LinuxHost.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Fri, 25 Feb 2022 13:34:24 -0600
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Alexander.Deucher@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <krisman@collabora.com>, <dan.carpenter@oracle.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 1/4] ASoC: amd: vg: fix for pm resume callback sequence
Date:   Sat, 26 Feb 2022 01:00:22 +0530
Message-ID: <20220225193054.24916-1-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e55d1a29-88a9-41ca-c42f-08d9f895d71d
X-MS-TrafficTypeDiagnostic: PH0PR12MB5646:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB5646F92950A7C2A30AE7C974973E9@PH0PR12MB5646.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yUpMimJlp+6c0Q5tsXZqpj+lsqkrh+Yzu5/or25bmOcbuhRg4TWgeP50zXrXsrbtteO1EJCtmE0Yrhdb69ApMw2kdXS5b3q4hqubxDYVN1gg8T1e+VfSW7qp1i24Iuny6qBjBjTRwQCcHHBkMA9TuNhME62Fz4XF0NSlhXY7kX8+8od7qNHHJ8rqASoy4hd7DH9P8eTEkEKpvxcuazocBk+NhPdeWolw3q7moYooZpZ8e8i3K1O+U2n0QkpG+F1LDmd3PwE4LHbLsGkl7M+7OP1dVUCH0YbjRdZdjRnu1pR0RqgF5hdofflqcLsO2qsO0+zbLSMNSL4qm7Qf9UxomYGRtsYfuPQm+aL1jyDSbG80rxY43ZzYkeaNxMqxFpUxsh2ub4OMvtBNtRfi4Y6/5bVQhHc6RJ581+dpQCP6kTUnm95vCPg3TCypnWLgussA6vnc637v3bwmZaTxuUasQKuv2wzlc4sMlNOYEs4N5nJ1NQyyB2KwDphz/49sPNf1Ih8K75ZbqoGrkE2riTYHbjasOV2h6copRp8kXRhBgKMP0vw4de1bsKsih8bPrj0ApCeKTSMLE4tpNPSB5YGro9xI3grCceKgRP8gM0eSdD6ZthbC/zOEj7AQ6JbK0DbQYqNsA4JTwk9fBYx6JEyYJqstzfszf0bPx8ecTTdyWVg5V2xG9HnPN0S4CwR9u2BGBoz5yevybBnRSvictRM2qQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(81166007)(8676002)(2906002)(356005)(83380400001)(70586007)(4326008)(36860700001)(508600001)(47076005)(8936002)(5660300002)(82310400004)(7696005)(70206006)(26005)(186003)(2616005)(54906003)(1076003)(40460700003)(336012)(316002)(110136005)(36756003)(426003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 19:34:29.0628
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e55d1a29-88a9-41ca-c42f-08d9f895d71d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5646
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

This also fixes warnings reported by kernel robot:
"warning: variable 'frmt_val' set but not used"
"warning: variable 'reg_val' set but not used"

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
v1 -> v2: fixed kernel rebot warnings
 
 sound/soc/amd/vangogh/acp5x-pcm-dma.c | 66 +++++++++++++--------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/sound/soc/amd/vangogh/acp5x-pcm-dma.c b/sound/soc/amd/vangogh/acp5x-pcm-dma.c
index f10de38976cb..3aa2d9a36880 100644
--- a/sound/soc/amd/vangogh/acp5x-pcm-dma.c
+++ b/sound/soc/amd/vangogh/acp5x-pcm-dma.c
@@ -426,51 +426,51 @@ static int acp5x_audio_remove(struct platform_device *pdev)
 static int __maybe_unused acp5x_pcm_resume(struct device *dev)
 {
 	struct i2s_dev_data *adata;
-	u32 val, reg_val, frmt_val;
+	struct i2s_stream_instance *rtd;
+	u32 val;
 
-	reg_val = 0;
-	frmt_val = 0;
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

