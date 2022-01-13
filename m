Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42DC148DBE2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 17:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236759AbiAMQfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 11:35:33 -0500
Received: from mail-co1nam11on2075.outbound.protection.outlook.com ([40.107.220.75]:35137
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236737AbiAMQfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 11:35:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FOF6F8fsX37+lmaR6pPJI6ApgspgsIgcw8yv0eRtR2pAV6vZ5cp2VASEd1Kh446vO0kS9IBFzVhvT9enju0zYjNWWZvWbjbtHhLo+ioMqCGZVPRTW+jEP4q5tZLltLNnLR0JeCBJUJWYgctS/zHVyZ+vB9rJcfi1TJ9s7LF4oFG/JcapooNeZR5Ad9YRhHSd3UW2klZonDd9qfBpqmApZEr9by1R7P0jaLjSs/2SYgq5NldpeTUJfNNUAT9Qffq+vYCuwHMV0BuhY+g9XFaFD40mkDd3NZRdFkJhX6rf7Sjly2stlw7Hn9KZLogQwdJBSiChBbx5+kdAm8JuQmVACA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7QsjnhVQQdJ6icA/lVkJK190jwIitICsAqVkpGc5wYU=;
 b=THadA3jNEyNwKYro/YldYROEMqotzQRvQKkz/g50/MK0+zpxf2jOPCfMrP9/94DwKtyX68DnhXRSsF6XV4s4t20SelMCnty3zvgLwG6CZGaojlQaB8cU5xn4m/V0epFctcNZBPFt1kh820S5+gztjHeMNttjRItrYe+mHzH77/bsz+DLMFcK4h6XME9GxLHnP+GMkqvZTrq2e/3GsevmGTv4qeUoNGCxC99tfJX/y0uG3lBpZ95miE4y3zbrpRAQeG+pf/49WabceoIIEjnKtlA2TcGD1VH2SPebUFNdmHypVrYYXXqop4SXQaAmSFylrM3sIgjxZIzmlR8lKU/Jcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QsjnhVQQdJ6icA/lVkJK190jwIitICsAqVkpGc5wYU=;
 b=UNXbfKRdz+a2TxPrwYrv1MSUUe/0mmxDs3IawIBHJlltkISDdfQzrnmgoMwRNIbC/PAJsEknLdt630Zw5oH5cK0xqll8Xxt0DOzO9cAGGQOIkhnV6M7ujdasJrYcKLFZvwS0L+hfuuZlDOf5XTbsSRfOy5Sbe8YpYn20Qy/KNPo=
Received: from MWHPR15CA0042.namprd15.prod.outlook.com (2603:10b6:300:ad::28)
 by BN8PR12MB4595.namprd12.prod.outlook.com (2603:10b6:408:72::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Thu, 13 Jan
 2022 16:35:28 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ad:cafe::ab) by MWHPR15CA0042.outlook.office365.com
 (2603:10b6:300:ad::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Thu, 13 Jan 2022 16:35:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Thu, 13 Jan 2022 16:35:27 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 10:35:26 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 10:35:26 -0600
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 13 Jan 2022 10:35:22 -0600
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Alexander.Deucher@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        "Ajit Kumar Pandey" <AjitKumar.Pandey@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/6] ASoC: amd: acp: Add ACP init()/deinit() callback for Renoir.
Date:   Thu, 13 Jan 2022 22:03:46 +0530
Message-ID: <20220113163348.434108-5-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220113163348.434108-1-AjitKumar.Pandey@amd.com>
References: <20220113163348.434108-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f517c5d1-484b-4d9f-db4a-08d9d6b2b4ee
X-MS-TrafficTypeDiagnostic: BN8PR12MB4595:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB459520CC933DF246612CE0CD82539@BN8PR12MB4595.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x1F15wBlEvrZ3AEUISfUmrgg4wGm+7N/BJAlb/YTtQYmSqjo0EnzrXvp3OmKpxMlbUgKwrntbKk2q3YD19rLeOOsOieZwaRALmq2gQFEjSd+6wnVO+yqwM+9eZ+oZdUmK0SLFcwsUaBdI6Mb5jKqYhoezPIdNqeygEblsmNUim3qodVOZBCoqnVENLPK2hZTd6W9inqkU4lLyL9HzksM50NCwRXb2JWZmYoNKECwGJXK1+FL2LRqke5lppQs6VBpgPwiEJji1rhyj2XvnOVOXbFly0Y4EDStADCl2cDq9S35hj0oQ1NXbB3OWvViOSQT9/LOWAbXknbTNt1qfJyJU1Xx5BpatLo74l2f7AMyb84jtPbO9wkuTY9pK+9ronG4fGWrOxUZuO5uJ7vjGyz2PUEhLcsEuAGwocGR9a7DUZovMBbxu/H7Z+BUu9J1jd8kXHHb4qK70aBrEED+XHLzhV1sINtRCDzsX2/Cqsevo1Y1WD7aniVAoCblVn1gMzynSoyjrP9xmtYdrh4y2Ef1fOLj82rQP67oLaA0gdSop268/FSFrt0DrR8+S0vnKzIEH8jM+7hJtKZJcGOMZdu2kZoNyTpgqlj7tG7Nbbg0OHY9Aixw9kWwmFdkAQVV1S+SUo7eyHJYkANxhMXm3fdcRcBuWTtVAVETqfc5BxLXRrxYRj3MQkVYddCsRT3WgtkDQIisBXnYMJEnKeSOlApngkEWF62OnY3gDU1QslUSLAkHXMoBHNZ3n5PSgPpIEXTaXnzjoZf/bRRw6kTcxp0R7s1ZJuu/ZLVLw87OAnTicNI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(40470700002)(46966006)(70586007)(86362001)(47076005)(82310400004)(316002)(81166007)(40460700001)(70206006)(26005)(36860700001)(186003)(36756003)(83380400001)(6666004)(8676002)(336012)(8936002)(2906002)(426003)(110136005)(2616005)(508600001)(356005)(54906003)(7696005)(4326008)(1076003)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 16:35:27.6148
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f517c5d1-484b-4d9f-db4a-08d9d6b2b4ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4595
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACP hardware has PGFSM control registers that can be configured to
power On/Off the ACP IP block. Add acp init()/de_init() callbacks
in renoir platform driver probe()/remove() respectively to power
on and off ACP IP block on ACP3X device.

Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
---
 sound/soc/amd/acp/acp-renoir.c       | 170 +++++++++++++++++++++++++++
 sound/soc/amd/acp/chip_offset_byte.h |   6 +
 2 files changed, 176 insertions(+)

diff --git a/sound/soc/amd/acp/acp-renoir.c b/sound/soc/amd/acp/acp-renoir.c
index 770a57a0677b..a29f910f25d1 100644
--- a/sound/soc/amd/acp/acp-renoir.c
+++ b/sound/soc/amd/acp/acp-renoir.c
@@ -25,6 +25,19 @@
 
 #define DRV_NAME "acp_asoc_renoir"
 
+#define ACP_SOFT_RST_DONE_MASK	0x00010001
+
+#define ACP_PWR_ON_MASK		0x01
+#define ACP_PWR_OFF_MASK	0x00
+#define ACP_PGFSM_STAT_MASK	0x03
+#define ACP_POWERED_ON		0x00
+#define ACP_PWR_ON_IN_PROGRESS	0x01
+#define ACP_POWERED_OFF		0x02
+
+
+#define ACP_ERROR_MASK 0x20000000
+#define ACP_EXT_INTR_STAT_CLEAR_MASK 0xFFFFFFFF
+
 static struct snd_soc_acpi_codecs amp_rt1019 = {
 	.num_codecs = 1,
 	.codecs = {"10EC1019"}
@@ -112,11 +125,154 @@ static struct snd_soc_dai_driver acp_renoir_dai[] = {
 },
 };
 
+static int acp3x_power_on(void __iomem *base)
+{
+	u32 val;
+	int timeout = 0;
+
+	val = readl(base + ACP_PGFSM_STATUS);
+
+	if (val == ACP_POWERED_ON)
+		return 0;
+
+	if ((val & ACP_PGFSM_STAT_MASK) != ACP_PWR_ON_IN_PROGRESS)
+		writel(ACP_PWR_ON_MASK, base + ACP_PGFSM_CONTROL);
+
+	while (++timeout < 500) {
+		val = readl(base + ACP_PGFSM_STATUS);
+		if (!val)
+			return 0;
+		udelay(1);
+	}
+
+	return -ETIMEDOUT;
+}
+
+static int acp3x_power_off(void __iomem *base)
+{
+	u32 val;
+	int timeout = 0;
+
+	writel(ACP_PWR_OFF_MASK, base + ACP_PGFSM_CONTROL);
+
+	while (++timeout < 500) {
+		val = readl(base + ACP_PGFSM_STATUS);
+		if ((val & ACP_PGFSM_STAT_MASK) == ACP_POWERED_OFF)
+			return 0;
+		udelay(1);
+	}
+
+	return -ETIMEDOUT;
+}
+
+static int acp3x_reset(void __iomem *base)
+{
+	u32 val;
+	int timeout = 0;
+
+	writel(1, base + ACP_SOFT_RESET);
+
+	while (++timeout < 500) {
+		val = readl(base + ACP_SOFT_RESET);
+		if (val & ACP_SOFT_RST_DONE_MASK)
+			break;
+		cpu_relax();
+	}
+
+	writel(0, base + ACP_SOFT_RESET);
+
+	timeout = 0;
+	while (++timeout < 500) {
+		val = readl(base + ACP_SOFT_RESET);
+		if (!val)
+			return 0;
+		cpu_relax();
+	}
+
+	return -ETIMEDOUT;
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
@@ -155,6 +311,20 @@ static int renoir_audio_probe(struct platform_device *pdev)
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

