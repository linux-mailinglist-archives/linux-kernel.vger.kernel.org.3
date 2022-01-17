Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3202C490814
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 13:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239352AbiAQMAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 07:00:49 -0500
Received: from mail-mw2nam10on2045.outbound.protection.outlook.com ([40.107.94.45]:50150
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239457AbiAQMAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 07:00:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kEDLw9WP9pIBuwpXCDrBK6DUqa6eIqeaTCLMd0wI8QlnGUcTWKlSy14XsZiQBBBILeKxWuTMUN24giJRWvTVX5ZQNHwaBUCOctRjmdb4ApsTAk21OPWYqFGd2tsyWKPrn5w8QrEI6npIMnWAzx8exjjKBn9cr4K8kgEkkkH0FcVnBaFNW3UAuiq3+h7QTfHd+oMmN1XHrTf2EGYVyF6Ox1CG3pZc7CcAU+8kAiXmmrpppoYadGbVlvoJDUt5ZIC0oLiYWYaRm/rQQWu7qmTQs0/5YUB5j+44Dhn3hTN5l+rpa3rhnHEpvDBs+cG4AaCEh3aAhYFiHoH7hUGa5n3Exg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TzTcVMMMj0ErWsJGvbWFv8c2Fr5u5NMCvMAdDQFTLrM=;
 b=FvYcwMR7KSP8Jyhz1hs8/Ol/WYl/Thzhfn8fpRPXYQYbHh5stb3nWEgF09CPDLYeCVS35ytWoG5c6aR3VueKx8ZAOYv04JDrHjK9o5Xw1USdMWOnq7bIg+VjHQuQZkbvaaronHRNCzTZhxigaY7CEPcDnyc/0ExkZx3kCRE35LKS/OFXG5D7tQ0MqSjiQ/QEIUtr3xDnnrzvctNyXW1HBUPJy1kk9xpzsBH+AN/GpWMfgK8++16nNfA6Vt6+bd3IaMH+3vYM3zAZvHXlsdto+YlLRLE+IX77W0yaftkrkE7QhY4uS5Io1AXu+doRD+L65j2cTLA87rn9pLlXxN7Yvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TzTcVMMMj0ErWsJGvbWFv8c2Fr5u5NMCvMAdDQFTLrM=;
 b=YNPTeObyXEF/3sz1zlI3XITv6AoTlwxKmym2v8Lz8/g9YFK5UuumhSQ6TTHk2hmtryLxvrennJwHnSCxgjm/TvCr/YGciEBgcIpAtJiUVHyHih+oJEkYyHHcGZ17LJUU8lDMmxRWktCtRQp/lHOEbUJry0WAYh+B3iEt34wXFmQ=
Received: from MWHPR12CA0056.namprd12.prod.outlook.com (2603:10b6:300:103::18)
 by CH2PR12MB3831.namprd12.prod.outlook.com (2603:10b6:610:29::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Mon, 17 Jan
 2022 12:00:38 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:103:cafe::7b) by MWHPR12CA0056.outlook.office365.com
 (2603:10b6:300:103::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Mon, 17 Jan 2022 12:00:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Mon, 17 Jan 2022 12:00:38 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 17 Jan
 2022 06:00:37 -0600
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Mon, 17 Jan 2022 06:00:34 -0600
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Alexander.Deucher@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        "Ajit Kumar Pandey" <AjitKumar.Pandey@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 4/6] ASoC: amd: acp: Add ACP init()/deinit() callback for Renoir.
Date:   Mon, 17 Jan 2022 17:28:52 +0530
Message-ID: <20220117115854.455995-5-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220117115854.455995-1-AjitKumar.Pandey@amd.com>
References: <20220117115854.455995-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 939d054b-65f9-477e-b084-08d9d9b0fa5e
X-MS-TrafficTypeDiagnostic: CH2PR12MB3831:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB3831FE20B2942DCA553B667582579@CH2PR12MB3831.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YMo/fRZ+wDMNzdpf8U5Xhg9PPkK/XhCEorN97no/wF1MlQfAFdM8LOlrgZ6FVSEOBW9qzZcU7Y1dkJYoII0GxFzpFOlROWBhBpk3MqKtlP8Z/7dLBtzcKrLnK518wewGKC96YY6qvaSjApvPUJVCMvpJQv0NMascUbi6R+pYNmptiZ2a3gMzfEsilt+szjRczA6xEYKCQghTRTw4DM6l8vm0r4fs3R+WK+xK2yY2cuYQGhkBOqbTLSKFFckYqe2yrtF2MeicgeuKFnlW8+7lCsx65qt39DyjvvStXXKAhSaSVf6Int1zvHsqiE3s40/bCwK//2miPbnapBvUlqnlF5jpF6AW/d1SjTMJsgp9INCmD3WCsqvPdFTKdbMAObQxrtsjYLfj1aYOLTwfU1+4dCXOP48kLAGuUWpVtGIExPCwWygITwI7bvp8s/rwfIqFrCqoWAwUVUaK58IrAhNlOwgswVu6WC6z00ckti4sDkXv8P5ip1z44UvfS7Lacnku3f6R/iDednssWrklhsv6Rjr/DSWuBT4qtvAmSvO1WhMsHn/Yrm08yLDTpCliy/oMkG739XRJw/JmXoamIqjaFETYAZve33pluvv7V2HgAtVf20WJcxhovApjqCkfJfC9s0m38TStAoMp5o8xElk47H9VLvy+ApSEu2dgqHUoWvecjXNjRP4H4BnakL3Zg1gw4FQ2R/43mCnQ69ZPnkIrW3a9wYyfrwXVTIg07bn91+lP0LCkm4STh20BjcflCdkt7JaBGbj0DtnepNcJa4tWe9tJK9TroE9ToJJ9jLjuohQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(40470700002)(46966006)(36840700001)(508600001)(36860700001)(5660300002)(86362001)(316002)(110136005)(54906003)(47076005)(70206006)(70586007)(83380400001)(7696005)(186003)(2616005)(356005)(6666004)(426003)(336012)(36756003)(2906002)(8676002)(8936002)(4326008)(1076003)(82310400004)(26005)(40460700001)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 12:00:38.5898
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 939d054b-65f9-477e-b084-08d9d9b0fa5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3831
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACP hardware has PGFSM control registers that can be configured to
power On/Off the ACP IP block. Add acp init()/de_init() callbacks
in renoir platform driver probe()/remove() respectively to power
on and off ACP IP block on ACP3X device.

Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
---
 sound/soc/amd/acp/acp-renoir.c       | 147 +++++++++++++++++++++++++++
 sound/soc/amd/acp/chip_offset_byte.h |   6 ++
 2 files changed, 153 insertions(+)

diff --git a/sound/soc/amd/acp/acp-renoir.c b/sound/soc/amd/acp/acp-renoir.c
index 770a57a0677b..d06ad5ce7fec 100644
--- a/sound/soc/amd/acp/acp-renoir.c
+++ b/sound/soc/amd/acp/acp-renoir.c
@@ -25,6 +25,20 @@
 
 #define DRV_NAME "acp_asoc_renoir"
 
+#define ACP_SOFT_RST_DONE_MASK	0x00010001
+
+#define ACP_PWR_ON_MASK		0x01
+#define ACP_PWR_OFF_MASK	0x00
+#define ACP_PGFSM_STAT_MASK	0x03
+#define ACP_POWERED_ON		0x00
+#define ACP_PWR_ON_IN_PROGRESS	0x01
+#define ACP_POWERED_OFF		0x02
+#define DELAY_US		5
+#define ACP_TIMEOUT		500
+
+#define ACP_ERROR_MASK 0x20000000
+#define ACP_EXT_INTR_STAT_CLEAR_MASK 0xFFFFFFFF
+
 static struct snd_soc_acpi_codecs amp_rt1019 = {
 	.num_codecs = 1,
 	.codecs = {"10EC1019"}
@@ -112,11 +126,130 @@ static struct snd_soc_dai_driver acp_renoir_dai[] = {
 },
 };
 
+static int acp3x_power_on(void __iomem *base)
+{
+	u32 val;
+
+	val = readl(base + ACP_PGFSM_STATUS);
+
+	if (val == ACP_POWERED_ON)
+		return 0;
+
+	if ((val & ACP_PGFSM_STAT_MASK) != ACP_PWR_ON_IN_PROGRESS)
+		writel(ACP_PWR_ON_MASK, base + ACP_PGFSM_CONTROL);
+
+	return readl_poll_timeout(base + ACP_PGFSM_STATUS, val, !val, DELAY_US, ACP_TIMEOUT);
+}
+
+static int acp3x_power_off(void __iomem *base)
+{
+	u32 val;
+
+	writel(ACP_PWR_OFF_MASK, base + ACP_PGFSM_CONTROL);
+
+	return readl_poll_timeout(base + ACP_PGFSM_STATUS, val,
+				  (val & ACP_PGFSM_STAT_MASK) == ACP_POWERED_OFF,
+				  DELAY_US, ACP_TIMEOUT);
+}
+
+static int acp3x_reset(void __iomem *base)
+{
+	u32 val;
+	int ret;
+
+	writel(1, base + ACP_SOFT_RESET);
+
+	ret = readl_poll_timeout(base + ACP_SOFT_RESET, val, val & ACP_SOFT_RST_DONE_MASK,
+				 DELAY_US, ACP_TIMEOUT);
+	if (ret)
+		return ret;
+
+	writel(0, base + ACP_SOFT_RESET);
+
+	return readl_poll_timeout(base + ACP_SOFT_RESET, val, !val, DELAY_US, ACP_TIMEOUT);
+}
+
+static void acp3x_enable_interrupts(void __iomem *base)
+{
+	u32 ext_intr_ctrl;
+
+	writel(0x01, base + ACP_EXTERNAL_INTR_ENB);
+	ext_intr_ctrl = readl(base + ACP_EXTERNAL_INTR_CNTL);
+	ext_intr_ctrl |= ACP_ERROR_MASK;
+	writel(ext_intr_ctrl, base + ACP_EXTERNAL_INTR_CNTL);
+}
+
+static void acp3x_disable_interrupts(void __iomem *base)
+{
+	writel(ACP_EXT_INTR_STAT_CLEAR_MASK, base + ACP_EXTERNAL_INTR_STAT);
+	writel(0x00, base + ACP_EXTERNAL_INTR_ENB);
+}
+
+static int rn_acp_init(void __iomem *base)
+{
+	int ret;
+
+	/* power on */
+	ret = acp3x_power_on(base);
+	if (ret)
+		return ret;
+
+	writel(0x01, base + ACP_CONTROL);
+
+	/* Reset */
+	ret = acp3x_reset(base);
+	if (ret)
+		return ret;
+
+	acp3x_enable_interrupts(base);
+
+	return 0;
+}
+
+static int rn_acp_deinit(void __iomem *base)
+{
+	int ret = 0;
+
+	acp3x_disable_interrupts(base);
+
+	/* Reset */
+	ret = acp3x_reset(base);
+	if (ret)
+		return ret;
+
+	writel(0x00, base + ACP_CONTROL);
+
+	/* power off */
+	ret = acp3x_power_off(base);
+	if (ret)
+		return ret;
+
+	return 0;
+}
 static int renoir_audio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct acp_chip_info *chip;
 	struct acp_dev_data *adata;
 	struct resource *res;
+	int ret;
+
+	chip = dev_get_platdata(&pdev->dev);
+	if (!chip || !chip->base) {
+		dev_err(&pdev->dev, "ACP chip data is NULL\n");
+		return -ENODEV;
+	}
+
+	if (chip->acp_rev != ACP3X_DEV) {
+		dev_err(&pdev->dev, "Un-supported ACP Revision %d\n", chip->acp_rev);
+		return -ENODEV;
+	}
+
+	ret = rn_acp_init(chip->base);
+	if (ret) {
+		dev_err(&pdev->dev, "ACP Init failed\n");
+		return -EINVAL;
+	}
 
 	adata = devm_kzalloc(dev, sizeof(struct acp_dev_data), GFP_KERNEL);
 	if (!adata)
@@ -155,6 +288,20 @@ static int renoir_audio_probe(struct platform_device *pdev)
 static int renoir_audio_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct acp_chip_info *chip;
+	int ret;
+
+	chip = dev_get_platdata(&pdev->dev);
+	if (!chip || !chip->base) {
+		dev_err(&pdev->dev, "ACP chip data is NULL\n");
+		return -ENODEV;
+	}
+
+	ret = rn_acp_deinit(chip->base);
+	if (ret) {
+		dev_err(&pdev->dev, "ACP de-init Failed\n");
+		return -EINVAL;
+	}
 
 	acp_platform_unregister(dev);
 	return 0;
diff --git a/sound/soc/amd/acp/chip_offset_byte.h b/sound/soc/amd/acp/chip_offset_byte.h
index e38589a142e9..88f6fa597cd6 100644
--- a/sound/soc/amd/acp/chip_offset_byte.h
+++ b/sound/soc/amd/acp/chip_offset_byte.h
@@ -14,6 +14,12 @@
 #define ACPAXI2AXI_ATU_CTRL                           0xC40
 #define ACPAXI2AXI_ATU_PAGE_SIZE_GRP_5                0xC20
 #define ACPAXI2AXI_ATU_BASE_ADDR_GRP_5                0xC24
+
+#define ACP_PGFSM_CONTROL			0x141C
+#define ACP_PGFSM_STATUS                        0x1420
+#define ACP_SOFT_RESET                          0x1000
+#define ACP_CONTROL                             0x1004
+
 #define ACP_EXTERNAL_INTR_ENB                         0x1800
 #define ACP_EXTERNAL_INTR_CNTL                        0x1804
 #define ACP_EXTERNAL_INTR_STAT                        0x1808
-- 
2.25.1

