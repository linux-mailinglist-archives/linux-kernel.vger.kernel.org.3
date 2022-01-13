Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2F8C48D504
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 10:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbiAMJaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 04:30:39 -0500
Received: from mail-bn8nam12on2051.outbound.protection.outlook.com ([40.107.237.51]:24801
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233449AbiAMJaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 04:30:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nA+mqBwMnngODCA+ilEWZwD0AVzPYX8r3LCbGjv1mZr/eHgN9z3d/WoUGbc9qComsZO+VfP+oyIqvUC8pINzOcX8tvdpRg8rab50/acKqnLxvrwa6GeYXGRyLjFVT8s2JMAfj6XXCKhrBvAI1NCJ/ud5Nrsk1HNQuu+DzY6UsqCTQ0LDtaZDUQ5ZyHY/VNB8XwTjFqKedWFqzYQCmbbJ+sx3bP7wMuNOyskrxPK/Q4nXgB5hETPbxOjAIY1S4vus6u1G+MH8I8XtHi79KxRz6fEodUxYjTScPpwIEFp8oK7HKZebGKZF1qzZMnONMVs7732zYdkDCjEHlyW3z78UpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7QsjnhVQQdJ6icA/lVkJK190jwIitICsAqVkpGc5wYU=;
 b=RfbBHJQoOnMgF5zE6l+9bFfBiWzNfQP8XvygTUq+lo06WWWc74M1CgIiRtjLYIlg47OhkFzwivCYnsVpqBsI6gz6fH8egphzEqEhEDz3sGxUpxoXuYL1U+SlipmCJo6SvpqBMFTOkZm+ycqlkOGKfmPsZDrio+q+9W1X+iyACwDwQ8XHcn4yzHhPg556bIGsnOOy18XODQ5hi14ulGU1qYENBqBDPpFe77tWNC/8jECErZLzU5yRRHXCj0UOWSNvnMO1FT5BoU3OHjg+dUi4u24zj7hePboXX7LSICIp7CMglbc9YHC4xH1ycjCkYuzkv77phyjCnUJ5sS70M9v3EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QsjnhVQQdJ6icA/lVkJK190jwIitICsAqVkpGc5wYU=;
 b=Df7CIQU2bFMPfZ233/y2I6QVoTqMCYJoFJoREaetQomumSoyVb6yJB9u778NR8RXwcyGcR9YCjMW4b236PH5enkyhdPwQqApT0B0V/MfeLzKzyyAIPKFKpsw+vl7/RH0oc+Dm6Lx4aG/JU2Ox2BvSa3qqJmHtJY5DpPvLE8msHw=
Received: from BN6PR16CA0045.namprd16.prod.outlook.com (2603:10b6:405:14::31)
 by BN6PR12MB1649.namprd12.prod.outlook.com (2603:10b6:405:5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Thu, 13 Jan
 2022 09:30:33 +0000
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:14:cafe::81) by BN6PR16CA0045.outlook.office365.com
 (2603:10b6:405:14::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Thu, 13 Jan 2022 09:30:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT010.mail.protection.outlook.com (10.13.177.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Thu, 13 Jan 2022 09:30:33 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 03:30:32 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 03:30:32 -0600
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 13 Jan 2022 03:30:29 -0600
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Alexander.Deucher@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        "Ajit Kumar Pandey" <AjitKumar.Pandey@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/6] ASoC: amd: acp: Add ACP init()/deinit() callback for Renoir.
Date:   Thu, 13 Jan 2022 14:58:40 +0530
Message-ID: <20220113092842.432101-5-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220113092842.432101-1-AjitKumar.Pandey@amd.com>
References: <20220113092842.432101-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de829060-2882-42ce-945e-08d9d6775934
X-MS-TrafficTypeDiagnostic: BN6PR12MB1649:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1649B974C25756AFFE87975682539@BN6PR12MB1649.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CQ8JZACZi574BKgzjw1psSAHs0ELO3QnOkxH2B5+rhF8pj84aIz4imNFJpdIhhmFHhuLQm/5S7+RJFUFiLGoDEp1b1EwMF/kHhEC7DpyUbi7oygahKL9h70k+B+Z6m2HVBZ8uJ9iHb58YFVFcucvnd8g7moRdykPj21t4h8Bw0WkP33gDdRpNujKxhdOWR5x9HVFgmKN3yzsOOPruxMAhV6UuPPBVAsq1Ehv8XMQ0BTO+lS8m9kOR7g3X41PvcCizUnkbShZxIXPxm1DLDbVu12Rl8//joKuumsaqBPyMP+igznPS75EH9TguoESyMdB8oil+38583nJ2mlhvfRAmm0TZT+ueUWKbRJfjQ3I76gDAM0SprxPiOR/LoTbcrSFZp3n+yH4AjfLKtHJdp5unaWDJO8L26oxa7oJIEwFfzDFcNnjkanSneySOW5tpPJUQn6bvqJyFw0pdKMBDtRAIrTu+vBOWs6E5e1uE025URj/biQiPpV96k+IP5EMYWJr8IO6a3ZQsurmv6N4ubGXNsb/FEpiO6S67CDrYmEBOdys0dHljRjiRvbQJQklhbGoJrN3tUefIRw/wtWfYSu0F0tUsOcPNVkZUUxrLkBl8Dg9RX0aig0KHplVnzLrYlBLwISl0vAv7qD7S3ETIZrPZNGth1WZM9H73IoRioOrWtAE8TsnN6C1OBgjs6xGHb7enCLwZgqzFRlZPhEsOD163chONschtQDjtogg6RhthqOAIlyCUDnO6Xi9REzh85U+pBYe029sKRYvcgS4QR4BgMG7qkr071STjS1iJIzVqYY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700002)(83380400001)(2616005)(36756003)(8676002)(86362001)(426003)(70586007)(36860700001)(2906002)(7696005)(26005)(54906003)(5660300002)(356005)(1076003)(47076005)(186003)(70206006)(8936002)(6666004)(4326008)(82310400004)(81166007)(316002)(336012)(40460700001)(110136005)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 09:30:33.4768
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de829060-2882-42ce-945e-08d9d6775934
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1649
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

