Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2600B591089
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 14:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238361AbiHLMKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 08:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238578AbiHLMKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 08:10:47 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA91711465
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 05:10:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AiCTFMaZy+Wfai6JgYUG+7ynEQdFfYOK69+r6a4UG4hwslOyNs6I9FCJ2b5ekgc0EMkm5bPeqmuU/s7X6+urCbPPvjED7WKz4UEXLOu3Pq3SwA7MLe2iSOLip29Vhcj3p9kJoRGTgGtxWkMV8iMZ/QI67IuRXxqxYg4nX55MIZL7N2Pl2MLBYQMNyIWPvJCOlNyt6lK5SIFtnYO+UIik+1Fk/WUoWrtoYzYNmmkxCzG1m3DrirIGoDVXRmLVPzASJc5/9lu92Vx6L5kfM2RcwrYt1SkuklBtFPZUjEM0B1wvog7FsozsISCWJkri8ivk8VncqKMpuoOnuWamlmuQ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zcjs7nhW7EblKioZwgrSs2unfr/lrCwRqSSkMW6MepM=;
 b=AmCkhUEb1Jltb3SvoCKRAeE9swKVSp8tXBZT3Co8gCrwuTtO8Ys0Erh4KykU7wTdL3S5VeBgBETgxMUtq1A9Rlyu5BtYAVo/0kg2X0WFOg5x1FCw50xp+/zVHL7qrx9mo4MuU+FkzfF8Uv+GSatu+98vxaNuFKVHOOdtYboFthblaejSSua3FmVCCQFkgKfn3Ok/J+OjnFewJGjkvVUe4czM5uQzzJUbLYj6sQNzSXwrdHCagMD/WiBQR76CLZLbkL9p+qj2kv7lur0RoDX22LOi6PP5Zji8Tbi24FFHIa05lcgjVT5Um3u5Y54A4b6F+XQ9ogON8717TjmNgwvyXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zcjs7nhW7EblKioZwgrSs2unfr/lrCwRqSSkMW6MepM=;
 b=ITVq+Shqn5DByCatIXKDtDWuL8+uan7hnfkhRltGFftlKVGexqMxy1A+0kMWU8uw92+OHCBu7sydVOAVmMWd1G8a/y2Zi/LRD01oxGIpQ+WHzuouqZ7XmBWHh7lgfev87gjlJOR39l3QgEs04cmHmL6zOGPuyGX+0AVj1mCB4W4=
Received: from DS7PR05CA0087.namprd05.prod.outlook.com (2603:10b6:8:56::9) by
 DM6PR12MB2825.namprd12.prod.outlook.com (2603:10b6:5:75::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.15; Fri, 12 Aug 2022 12:10:43 +0000
Received: from DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::be) by DS7PR05CA0087.outlook.office365.com
 (2603:10b6:8:56::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.8 via Frontend
 Transport; Fri, 12 Aug 2022 12:10:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT039.mail.protection.outlook.com (10.13.172.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Fri, 12 Aug 2022 12:10:43 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 12 Aug
 2022 07:10:09 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 12 Aug
 2022 05:10:02 -0700
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 12 Aug 2022 07:09:59 -0500
From:   Syed Saba kareem <Syed.SabaKareem@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <mario.limonciello@amd.com>,
        Syed Saba kareem <Syed.SabaKareem@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 06/13] ASoC: amd: add acp6.2 irq handler
Date:   Fri, 12 Aug 2022 17:37:24 +0530
Message-ID: <20220812120731.788052-7-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812120731.788052-1-Syed.SabaKareem@amd.com>
References: <20220812120731.788052-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88105093-af48-467a-fa4e-08da7c5bae91
X-MS-TrafficTypeDiagnostic: DM6PR12MB2825:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fnf58pAWEq9OFKVhveNOoUZzPPSKb/18IslVOPa/lOnpiqcN+UPalicPntPXzW6iQIKKRyIs1LVoLJy2T85amTHUC3EuK/mMmnFcjAhEAM5zdG45l855ExDoFM5XQwln2Zw9qthwsqzUDwx5HOv2gY+LeQCfmflfzpn/2INJbNgfqqXaZHym85WPXji2Ark7EmvkjQjEZLKGe6BVkFO3y5MuwzBZkjsAVAXEzSFHYanfghuK5O0nU2N5BaX+CS8BhD8RXN/SdQEfZCGe8Yn7cWBP37Kiqxvd4vdLMst5jDjX3cyix/UqOLfmn2cw0LlqKAcctLG4hM+aodd0zO3RGZcmzlu1tFtZIH5NKP44CwJwwAG2Lr16omdnnHsQT1jPtC6547A+PYvwTbFf3ljpJBxKedNcg0BAGIG4Ehn+mVzhxm7O8BY8f+OH+CWO/4+3H+PQuJ8UuAEPs7pVfkdXLzFPCPMT5tnYyqlXND9CGl7hAxpCTS4N9ezctVQXpZrhCn0YBsSwrna0ydTlk3+5g5zVuwiQd8c7iRg9wF+/8n22VnDKKjKirIY9evk83zzS9V5j9F1YkGhrBgLljh38jCI26aDryAV5BmWoP5x9XLiOTP1hSE+8bL2p6F9N040Edr45hYwQXpT/O8ZLpvnygWq9zNzPLXtFndjqIwQ+LkkcpwhtC8l00xA7vCZq0oHhjikfmclSiSHhnJDMJHGlk8lV4QjA3LAYSBjhfRnjC4JsNAnyTSb3MIwgB0QiF04Er6LSlslEaqwpZ8b/esaMffmXJ6jfOYXPlCKoX40Dgmp/8u7tjyjKKECmwCPWl2QkN1X/c9PT17OOwUnEJJ96cA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(39860400002)(136003)(346002)(40470700004)(36840700001)(46966006)(2616005)(1076003)(336012)(186003)(81166007)(356005)(36860700001)(426003)(82740400003)(47076005)(40460700003)(8936002)(4326008)(5660300002)(83380400001)(8676002)(70586007)(70206006)(82310400005)(40480700001)(41300700001)(6666004)(478600001)(26005)(7696005)(2906002)(110136005)(54906003)(316002)(86362001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 12:10:43.7923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88105093-af48-467a-fa4e-08da7c5bae91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2825
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ACP6.2 irq handler for handling irq events for ACP IP.
Add pdm irq events handling.
Whenever audio data equal to the PDM watermark level are consumed,
interrupt is generated. Acknowledge the interrupt.

Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/ps/acp62.h  |  2 ++
 sound/soc/amd/ps/pci-ps.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/sound/soc/amd/ps/acp62.h b/sound/soc/amd/ps/acp62.h
index 7636bfeb8a8a..563252834b09 100644
--- a/sound/soc/amd/ps/acp62.h
+++ b/sound/soc/amd/ps/acp62.h
@@ -25,6 +25,7 @@
 
 #define ACP_ERROR_MASK 0x20000000
 #define ACP_EXT_INTR_STAT_CLEAR_MASK 0xFFFFFFFF
+#define PDM_DMA_STAT 0x10
 
 enum acp_config {
 	ACP_CONFIG_0 = 0,
@@ -46,6 +47,7 @@ enum acp_config {
 };
 
 struct pdm_dev_data {
+	u32 pdm_irq;
 	void __iomem *acp62_base;
 	struct snd_pcm_substream *capture_stream;
 };
diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index 94201f75427a..4140fb42a7f7 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -11,6 +11,8 @@
 #include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/acpi.h>
+#include <linux/interrupt.h>
+#include <sound/pcm_params.h>
 
 #include "acp62.h"
 
@@ -118,6 +120,27 @@ static int acp62_deinit(void __iomem *acp_base)
 	return 0;
 }
 
+static irqreturn_t acp62_irq_handler(int irq, void *dev_id)
+{
+	struct acp62_dev_data *adata;
+	struct pdm_dev_data *ps_pdm_data;
+	u32 val;
+
+	adata = dev_id;
+	if (!adata)
+		return IRQ_NONE;
+
+	val = acp62_readl(adata->acp62_base + ACP_EXTERNAL_INTR_STAT);
+	if (val & BIT(PDM_DMA_STAT)) {
+		ps_pdm_data = dev_get_drvdata(&adata->pdev[0]->dev);
+		acp62_writel(BIT(PDM_DMA_STAT), adata->acp62_base + ACP_EXTERNAL_INTR_STAT);
+		if (ps_pdm_data->capture_stream)
+			snd_pcm_period_elapsed(ps_pdm_data->capture_stream);
+		return IRQ_HANDLED;
+	}
+	return IRQ_NONE;
+}
+
 static int snd_acp62_probe(struct pci_dev *pci,
 			   const struct pci_device_id *pci_id)
 {
@@ -127,7 +150,9 @@ static int snd_acp62_probe(struct pci_dev *pci,
 	int val = 0x00;
 	struct acpi_device *adev;
 	u32 addr;
+	unsigned int irqflags;
 
+	irqflags = IRQF_SHARED;
 	/* Pink Sardine device check */
 	switch (pci->revision) {
 	case 0x63:
@@ -223,6 +248,12 @@ static int snd_acp62_probe(struct pci_dev *pci,
 						goto unregister_devs;
 					}
 				}
+				ret = devm_request_irq(&pci->dev, pci->irq, acp62_irq_handler,
+						       irqflags, "ACP_PCI_IRQ", adata);
+				if (ret) {
+					dev_err(&pci->dev, "ACP PCI IRQ request failed\n");
+					goto unregister_devs;
+				}
 			}
 		}
 		break;
-- 
2.25.1

