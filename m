Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8915A3900
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 19:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbiH0RA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 13:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233995AbiH0RA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 13:00:26 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A7E13F66
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 10:00:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvoKNe2Jmjra++t0YR3dC+MYzMDaOzbuGkGyQcTxl8hjEQskv3ozhp2xMGsIhAq2cpt4n6vsMYKcjhpoFhc0hjyvCcocU3mLXETPyV96SqKLaDnavkxpFs36LCV3/qp3cTOMrIs7m10VgOpMS+0E7bV3CoFVsX/Z32Q7HlDARBrllPMJHkoQm3UcPq0+xwi2jUWh37+2TZOw1eZY+eA/z63f3LbIulT2EX4NShqRFDY7r4bPJbNeuwHP1z+jKj3/n0cs7naY9qpp1yu8Pn1QyUiXcg7qwEWwISBg/ZwIdaEfaFTbmBGxWMpixP7NBu0e/zrO7N787RxlnzFP1ag26Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+A6pifyQDg/l63ROFoM82QaH3YUvAaLsMSM85BByALA=;
 b=THbZ55z+MOyaoWZoIa73FfSo7uTkLs0gpg35Cqs0x3ZAC/Qji8DX3jGfp6STeNx5jswF3THn72wtvWRj8qvCY+N9IpvukkQ9fi3076/5Ccu0EpGCIogFvhYq/Mi+Ebt+O5Iu9O1Jv9C173H1mr1sPdrvCQakKBFPtfIK7KeZtPybv/sZ2K9AjEFFlhIL/VMqz1fwe+YDICCiY3YFNZFNZI8+qwz0jn9vAfaUO/tTGOpAfh3+rpTPfBktxnyUcTkvKf22P08RAm8rtSNBxYgNTWRSaBKONKSzNXcw5KhpwGqZo89FbimIgjzvusTd49mzopm3/OOgfCEn/Xm71B/JFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+A6pifyQDg/l63ROFoM82QaH3YUvAaLsMSM85BByALA=;
 b=v2Xo9tDPcsgErtAwjKNznDLyu2+Yk76aYpuFOF5wWSMp6WgAw/lWGDJBsTPSU2bdznXKTR9pYDJ20T2MXqhPjDZPKT0e1jg/VPdPpC3PqgRCE9J5rqGzdab+qUBOi658FuhPlVmbC9We+i17lbrI8ziyYf82dBJ4xwn1in6wRZ0=
Received: from DM6PR17CA0012.namprd17.prod.outlook.com (2603:10b6:5:1b3::25)
 by BL0PR12MB2497.namprd12.prod.outlook.com (2603:10b6:207:4c::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16; Sat, 27 Aug
 2022 17:00:11 +0000
Received: from DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::8d) by DM6PR17CA0012.outlook.office365.com
 (2603:10b6:5:1b3::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19 via Frontend
 Transport; Sat, 27 Aug 2022 17:00:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT038.mail.protection.outlook.com (10.13.173.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Sat, 27 Aug 2022 17:00:10 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sat, 27 Aug
 2022 12:00:04 -0500
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Sat, 27 Aug 2022 12:00:01 -0500
From:   Syed Saba Kareem <Syed.SabaKareem@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <mario.limonciello@amd.com>,
        <alexander.deucher@amd.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 06/13] ASoC: amd: add acp6.2 irq handler
Date:   Sat, 27 Aug 2022 22:26:50 +0530
Message-ID: <20220827165657.2343818-7-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220827165657.2343818-1-Syed.SabaKareem@amd.com>
References: <20220827165657.2343818-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 210e3286-30c8-4281-1c14-08da884d9a4e
X-MS-TrafficTypeDiagnostic: BL0PR12MB2497:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /lV41KBYRliCHrbrZUp+i4YfAsenWJxBUUrOs3YWzP3kpXuDDUeIgcjKgUCZLN4UK10xWHoDsc+HkSV63eKgLc4F4OQEZ4OY4DHZBbKrz2/Qs8H5S6g6CFNnHeQzOXEkHH81UCTQfAj+T5y7SJ71GUXOeMxEMznqj+q48DVgf4fgrAx/R5r6qmnaEAzgiYQKilxUFPAXPguTeo9qmPqR3NiO/XHJ6oxF1BGZxR9flTq5WnuzkxuRoUGOaTeRso1nrkM7vhgnGhf/ca+1hVdJZ6ItYwFY6Dv+BPuNhzMNqVRU3hJbna/PBp1rVvOHg+cwuHiWd1r2Hi1IFY3L9Ki+4UVR+LGsFBXvPIcz2fcSQFOPIxTuiiHKinorbyZxDZTaQRIPDQWpLOSr0LoJqkoBRRYqnvrHmE48tW2d0RE0Qr4dsCAjWSRgvN5NotEq3h0eLymXYLgW3cF8Rtg1rrT+xsF804WMXZfqNcYdwGvWih6XJWdyS+p+dDMjUzNupr3JO6tZsIeAkv/rVxK2J38AKIn7/YdNFUpjARyvjV2PY92AI0oxZzkLRXNC2B7061LYrDr80QCYsgv98mNMrxxwUBv9HGLirrP2PuH0Z5SdHbNOqKqcRlVCRDb25sQnWL/Yv/RFSnDPHUww3S6ES3y4HrFBiaarcvZ4a7W6MLp7sb1WIUQ2ObdCR6a/fFNhf60loWXRynG4WYNUTowJmg4JjC7lxps2/L+qXKq0RfrYkJAWyLhWnI1HjRfBf7H69qWpniMpRFuuGRu11UnpVKEHK1zzuwpTq5keQqeG9EpzkVOOe0E1538ItY6v0sShuUnX
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(136003)(396003)(346002)(36840700001)(40470700004)(46966006)(83380400001)(478600001)(336012)(1076003)(426003)(186003)(47076005)(2616005)(36860700001)(5660300002)(4326008)(54906003)(316002)(110136005)(70586007)(70206006)(8676002)(81166007)(2906002)(36756003)(40460700003)(82310400005)(82740400003)(8936002)(41300700001)(26005)(356005)(7696005)(6666004)(86362001)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 17:00:10.7922
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 210e3286-30c8-4281-1c14-08da884d9a4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2497
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
index 9026df7ab169..9e359006b06b 100644
--- a/sound/soc/amd/ps/acp62.h
+++ b/sound/soc/amd/ps/acp62.h
@@ -24,6 +24,7 @@
 
 #define ACP_ERROR_MASK 0x20000000
 #define ACP_EXT_INTR_STAT_CLEAR_MASK 0xFFFFFFFF
+#define PDM_DMA_STAT 0x10
 
 enum acp_config {
 	ACP_CONFIG_0 = 0,
@@ -45,6 +46,7 @@ enum acp_config {
 };
 
 struct pdm_dev_data {
+	u32 pdm_irq;
 	void __iomem *acp62_base;
 	struct snd_pcm_substream *capture_stream;
 };
diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index adad29667791..e4ddd80d0dd4 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -11,6 +11,8 @@
 #include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/acpi.h>
+#include <linux/interrupt.h>
+#include <sound/pcm_params.h>
 
 #include "acp62.h"
 
@@ -115,6 +117,27 @@ static int acp62_deinit(void __iomem *acp_base, struct device *dev)
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
@@ -125,7 +148,9 @@ static int snd_acp62_probe(struct pci_dev *pci,
 	struct acpi_device *adev;
 	const union acpi_object *obj;
 	u32 addr;
+	unsigned int irqflags;
 
+	irqflags = IRQF_SHARED;
 	/* Pink Sardine device check */
 	switch (pci->revision) {
 	case 0x63:
@@ -218,6 +243,12 @@ static int snd_acp62_probe(struct pci_dev *pci,
 					ret = PTR_ERR(adata->pdev[index]);
 					goto unregister_devs;
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

