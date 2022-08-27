Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D775A38FA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 18:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbiH0Q7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 12:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233950AbiH0Q7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 12:59:42 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CCB5A177
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 09:59:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OyxVxeBuIYjq4IS91Gn77dyGoxNTOiq+/NH8XZQw/iCSLriGFNLLqKeMtKbMm49etWQA4nz0xPBYa2gD1B4XIJGQEphgtX+P9OZ5FW7DaiqL2c0fB9GTN0Y5Yi1Hd+hM1Q7TokUVY+3bpISYMVAiIm4Zm0UVe2ltOU1QYrj7Y4F581rpT6LyuCqtdXW+Kz7CEX5DxelR1bo5/4rwscSgV1jLFQH49fFGiuoCTfzcl/wJa1lnMpl3BpcZ1UCzypvho1sK8SSVrT63kyOMWuPRpppCpizrgK5wdPj5LUWg0RDkDgJlamG3m77M/y51Oqa56ToVxb72DTgTcxwS7W4wTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=latV6WYjA2o+ZGnYqiQTzTTy9CSBYFpwdpKF+gZpscc=;
 b=HR3lh/kggp/47PTPzjHc7dA3FU04TANmjWBaIWxTQmwT4X9pVuWaiz+kmtxXUHG7ZgJIAhR9GVWvYn5OXIb+AJ+EnxLrk1CsQEA+lcVYiSvqyt/6tv+pRelPOI8rkZO88vtwDKLEt6A2pCAmJQ0vfGqzpQiyInVCdtpADr/UeHxQq8dLTGMPwJVLAHEznPcFJRHZo8r1KivTgg69VTj6ckHJSFuVrZUDsc+MQYfgYVmqAREZccqSPdA+6D43hMZbcgHepFicD8GKlKRqtlqKQX1kD7V5Cy64pbJD/w4KiPfsMJ+eB0ZjyxULk18NIrhBJ+luZltpTfYzaM2pfdFvtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=latV6WYjA2o+ZGnYqiQTzTTy9CSBYFpwdpKF+gZpscc=;
 b=fstcHhKKeoibueX2sNofzocxLyOPyNmZ+U+pJU8haVDFk7u4b6MjwyA9YyXu6tWr3qW0cxB2RK+J/SvwPQ7Je0uCKzDGQY9p+y3/2fR1PFpUmo+TsHh6w8IcZaF/405kTuCz7TSSgfsrx/igaviUc+lGvNAjRn8zUAOgf5QxDhE=
Received: from DM5PR08CA0047.namprd08.prod.outlook.com (2603:10b6:4:60::36) by
 CY5PR12MB6382.namprd12.prod.outlook.com (2603:10b6:930:3e::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.16; Sat, 27 Aug 2022 16:59:39 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::4f) by DM5PR08CA0047.outlook.office365.com
 (2603:10b6:4:60::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Sat, 27 Aug 2022 16:59:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Sat, 27 Aug 2022 16:59:39 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sat, 27 Aug
 2022 11:59:39 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sat, 27 Aug
 2022 11:59:38 -0500
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Sat, 27 Aug 2022 11:59:34 -0500
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
Subject: [PATCH v2 03/13] ASoC: amd: add acp6.2 init/de-init functions
Date:   Sat, 27 Aug 2022 22:26:47 +0530
Message-ID: <20220827165657.2343818-4-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220827165657.2343818-1-Syed.SabaKareem@amd.com>
References: <20220827165657.2343818-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 419235a8-0f1f-4880-4cf1-08da884d87c2
X-MS-TrafficTypeDiagnostic: CY5PR12MB6382:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ViOa2R6UN/ykxd3UmlJ9Cr+NVSkGTlt+eGQiTVq/GrVfPXdV7xvY5M1tVkhzqoxe75zs6VnYH3vlCfPql5UP1CUVfyakFGqxDYs08DL6wOnVZm0oosRfuQrkx5A+ARa1gwAekkUlMIinEzD0iyzsE9w2a12ihqVo5yVsR8o+AHCfzXsNelRO+s0PrbkwD+UWP2k18QyS5Zjp22POpp7RmVqSbyvSPV07R/HLsVjgYBFhh/uj+EezeCS0yFjpZffRZUNzOkiMLklBRpil6Bc1C7Tc+z6sPM81z1IWjnJlQmH1SZ44y6uf9av1Tay5bAt5HuKhhOe28OjSuaJ+zwdhDG6Iq8nX8vkALDzjRg3bHQ692zA22ConWzHCjyYlsY3cxdWwW7zaSiSEmNRScOVX/tYRdohv3TaRMVC3vTMefjX27QgK7Mm3eRw0ZRfIk8Gd4DKtkiLMkPYLYm8FTs5hwbMqWl6dnRbneDl+CgWof79/+Muhvkeckj8lyY4/sIdJr8KpvRerVSnqWO1ai9KtXr+vt2pnEFvenyYPg7YCCnnMm9WTIpZKvzLPfGYFThHWTRZ2+tUe5r6dkNCGYZxwMZo6TOA4haOfhQjztqkh8qI6R8Y/fUeeQFTzWUcAnAHlZRjqOufMnAPo79aVwm6Du7LzhQBSA5DIxt73Uf0ayXnR4gXXVQZjBieinsGsurTKX0dUsvc+WaX3/I1yJd5C2RAETGc0wYhcSycESxDOXuKB3/X9/rygJ39OcLa4AEPapzrNvGqWG3zIIxfrrHvxTeWPU3j5tmPl2a22ZLsydyhN80J1JTg9f4HkH0vsxN/I
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(346002)(396003)(376002)(40470700004)(46966006)(36840700001)(8936002)(7696005)(26005)(6666004)(40460700003)(40480700001)(478600001)(41300700001)(426003)(82310400005)(2616005)(47076005)(186003)(336012)(5660300002)(1076003)(4326008)(8676002)(2906002)(36756003)(110136005)(70206006)(70586007)(316002)(82740400003)(36860700001)(356005)(81166007)(86362001)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 16:59:39.6769
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 419235a8-0f1f-4880-4cf1-08da884d87c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6382
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Pink Sardine platform ACP6.2 PCI driver init/deinit functions.

Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/ps/acp62.h  |  12 +++++
 sound/soc/amd/ps/pci-ps.c | 106 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 118 insertions(+)

diff --git a/sound/soc/amd/ps/acp62.h b/sound/soc/amd/ps/acp62.h
index 5291585f45f9..1f5e7d758f9f 100644
--- a/sound/soc/amd/ps/acp62.h
+++ b/sound/soc/amd/ps/acp62.h
@@ -9,6 +9,18 @@
 
 #define ACP_DEVICE_ID 0x15E2
 
+#define ACP_SOFT_RESET_SOFTRESET_AUDDONE_MASK	0x00010001
+#define ACP_PGFSM_CNTL_POWER_ON_MASK	1
+#define ACP_PGFSM_CNTL_POWER_OFF_MASK	0
+#define ACP_PGFSM_STATUS_MASK		3
+#define ACP_POWERED_ON			0
+#define ACP_POWER_ON_IN_PROGRESS	1
+#define ACP_POWERED_OFF		2
+#define ACP_POWER_OFF_IN_PROGRESS	3
+
+#define ACP_ERROR_MASK 0x20000000
+#define ACP_EXT_INTR_STAT_CLEAR_MASK 0xFFFFFFFF
+
 static inline u32 acp62_readl(void __iomem *base_addr)
 {
 	return readl(base_addr);
diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index 8bb33845622a..a87dbf8847e6 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -8,6 +8,7 @@
 #include <linux/pci.h>
 #include <linux/module.h>
 #include <linux/io.h>
+#include <linux/delay.h>
 
 #include "acp62.h"
 
@@ -15,6 +16,100 @@ struct acp62_dev_data {
 	void __iomem *acp62_base;
 };
 
+static int acp62_power_on(void __iomem *acp_base)
+{
+	u32 val;
+	int timeout;
+
+	val = acp62_readl(acp_base + ACP_PGFSM_STATUS);
+
+	if (!val)
+		return val;
+
+	if ((val & ACP_PGFSM_STATUS_MASK) != ACP_POWER_ON_IN_PROGRESS)
+		acp62_writel(ACP_PGFSM_CNTL_POWER_ON_MASK, acp_base + ACP_PGFSM_CONTROL);
+	timeout = 0;
+	while (++timeout < 500) {
+		val = acp62_readl(acp_base + ACP_PGFSM_STATUS);
+		if (!val)
+			return 0;
+		udelay(1);
+	}
+	return -ETIMEDOUT;
+}
+
+static int acp62_reset(void __iomem *acp_base)
+{
+	u32 val;
+	int timeout;
+
+	acp62_writel(1, acp_base + ACP_SOFT_RESET);
+	timeout = 0;
+	while (++timeout < 500) {
+		val = acp62_readl(acp_base + ACP_SOFT_RESET);
+		if (val & ACP_SOFT_RESET_SOFTRESET_AUDDONE_MASK)
+			break;
+		cpu_relax();
+	}
+	acp62_writel(0, acp_base + ACP_SOFT_RESET);
+	timeout = 0;
+	while (++timeout < 500) {
+		val = acp62_readl(acp_base + ACP_SOFT_RESET);
+		if (!val)
+			return 0;
+		cpu_relax();
+	}
+	return -ETIMEDOUT;
+}
+
+static void acp62_enable_interrupts(void __iomem *acp_base)
+{
+	acp62_writel(1, acp_base + ACP_EXTERNAL_INTR_ENB);
+}
+
+static void acp62_disable_interrupts(void __iomem *acp_base)
+{
+	acp62_writel(ACP_EXT_INTR_STAT_CLEAR_MASK, acp_base +
+		     ACP_EXTERNAL_INTR_STAT);
+	acp62_writel(0, acp_base + ACP_EXTERNAL_INTR_CNTL);
+	acp62_writel(0, acp_base + ACP_EXTERNAL_INTR_ENB);
+}
+
+static int acp62_init(void __iomem *acp_base, struct device *dev)
+{
+	int ret;
+
+	ret = acp62_power_on(acp_base);
+	if (ret) {
+		dev_err(dev, "ACP power on failed\n");
+		return ret;
+	}
+	acp62_writel(0x01, acp_base + ACP_CONTROL);
+	ret = acp62_reset(acp_base);
+	if (ret) {
+		dev_err(dev, "ACP reset failed\n");
+		return ret;
+	}
+	acp62_writel(0x03, acp_base + ACP_CLKMUX_SEL);
+	acp62_enable_interrupts(acp_base);
+	return 0;
+}
+
+static int acp62_deinit(void __iomem *acp_base, struct device *dev)
+{
+	int ret;
+
+	acp62_disable_interrupts(acp_base);
+	ret = acp62_reset(acp_base);
+	if (ret) {
+		dev_err(dev, "ACP reset failed\n");
+		return ret;
+	}
+	acp62_writel(0, acp_base + ACP_CLKMUX_SEL);
+	acp62_writel(0, acp_base + ACP_CONTROL);
+	return 0;
+}
+
 static int snd_acp62_probe(struct pci_dev *pci,
 			   const struct pci_device_id *pci_id)
 {
@@ -56,6 +151,10 @@ static int snd_acp62_probe(struct pci_dev *pci,
 	}
 	pci_set_master(pci);
 	pci_set_drvdata(pci, adata);
+	ret = acp62_init(adata->acp62_base, &pci->dev);
+	if (ret)
+		goto release_regions;
+
 	return 0;
 release_regions:
 	pci_release_regions(pci);
@@ -67,6 +166,13 @@ static int snd_acp62_probe(struct pci_dev *pci,
 
 static void snd_acp62_remove(struct pci_dev *pci)
 {
+	struct acp62_dev_data *adata;
+	int ret;
+
+	adata = pci_get_drvdata(pci);
+	ret = acp62_deinit(adata->acp62_base, &pci->dev);
+	if (ret)
+		dev_err(&pci->dev, "ACP de-init failed\n");
 	pci_release_regions(pci);
 	pci_disable_device(pci);
 }
-- 
2.25.1

