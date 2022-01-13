Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2021048DBE1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 17:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236746AbiAMQfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 11:35:20 -0500
Received: from mail-dm6nam10on2064.outbound.protection.outlook.com ([40.107.93.64]:57657
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236737AbiAMQfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 11:35:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sz5JRA2eWFg/tOdbjXD5O9ZETiNqFeL897qYWuZ+JknySmC0uMg03/yxAN9snGP1PqC9ylKLaSfWtwR4MADbM490vko3AqNLq38t0ktV6goNUiOcYVOGtFOh4KwnzoVnahSganFH+ad8U7jxJKkuWbpibnWVRVynDYcdlzTjOQgwpBl/b2AHNAvXBZnLNnEw2ON2PT/mkRiZ2SudVzaKFNHbGH7T5b33JAzw0WDt9U4u4EbhQ/sz+gSU9Bd1anMCz3XkR2Uj/yrd4lcz8zKbdRk3mcWfwyJtV0snHBBg9n5DV8ZyY5L5v9TdEUuObm3Cm9TqjgPxPhzSqoj3iGPfgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ncvFO67k+u1YwrIXZVC/C42wVfltGT6uVef5TwD5Ugw=;
 b=BGCdFOnq1ZxmpJt575MrhuzqZsLVcLRsv8pSZeC8y57CMPdYDVkUALnk6Px8MPjMlc++R4eHvQaErwJnzRcAiOfnRpVK/1YZbQaGXerWW3tqa60L+QuRvh2MkKi0TlutWrVST2rzDxs+Pi1//ntuNafQudxS/AAVmUktdAOJOt/9vIBUl2eLmEfWFyDx7SLFlLTp6VKpuOpr0NUdcRDzn/RCroVOwurFiyxor1uzNa2rxoazNCYGC3kz8hDthkuX/c9lCueYid2ZBS0zBKsiDGrhkf43nnHNOgZAciKk93dnKNtGY3367quQ1ezbMsdDthVUSIU0v0BdJNJ8tnbRWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ncvFO67k+u1YwrIXZVC/C42wVfltGT6uVef5TwD5Ugw=;
 b=CvYMegMbzTjQuAi7qJY6hga/7F5q7olQ+VCi1tVceMYd3PINBjoarQ0nbCDlQAM73G//oqP1qxge8QOA9tmzlDNlP3N7iUMhRQMcf54wlYwvUvNuBPiBOU7W21Zo4C1S7oqLkCvWzNtSUho+82yotW1Ov2fq5J7Ai9cG0vxXBC4=
Received: from BN9PR03CA0968.namprd03.prod.outlook.com (2603:10b6:408:109::13)
 by CY4PR12MB1927.namprd12.prod.outlook.com (2603:10b6:903:127::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Thu, 13 Jan
 2022 16:35:16 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::6f) by BN9PR03CA0968.outlook.office365.com
 (2603:10b6:408:109::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Thu, 13 Jan 2022 16:35:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Thu, 13 Jan 2022 16:35:15 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 10:35:15 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 10:35:15 -0600
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 13 Jan 2022 10:35:10 -0600
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Alexander.Deucher@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        "Ajit Kumar Pandey" <AjitKumar.Pandey@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        "V sujith kumar Reddy" <vsujithkumar.reddy@amd.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Bard Liao <bard.liao@intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/6] ASoC: amd: acp: Add generic PCI driver module for ACP device
Date:   Thu, 13 Jan 2022 22:03:45 +0530
Message-ID: <20220113163348.434108-4-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220113163348.434108-1-AjitKumar.Pandey@amd.com>
References: <20220113163348.434108-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 993a38e7-1c9f-4ab0-bd60-08d9d6b2aded
X-MS-TrafficTypeDiagnostic: CY4PR12MB1927:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1927310594CD2CFFA4C53C0582539@CY4PR12MB1927.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wVOK2VJsFaRaoiBCGPTOMbG55WXw2g/30KMM3JgfNuLp4n6B9NozeJathJtQWOI8qa37TpoGHmq6XfE1QCv0DRm5+Uq1KMMl/B8imlXF25loT7U3aSTJ4foSA3+L9kgXdlX0oTt7UDwLco5M/Z6JrWb54Y4HZNj2SH9cmkK5ah3WUas0gdxkLg1e9YrMz/jsW5e+Z117Q9mmrG44uhxsBOq5lNpJVX6h8wP5QpTw5QgDjeQSOzN8FkzzWXqwwsLI0Den8dvqe5H9aSXmsjpg4jVpwKnYP/8Fuw7BZOuQtJCAhzCm2YWDK4cFHVCxTJcqg+C4IkT/KdP3bSwIc0poc3O4QeRV2imH828xr+qnyUtXyJB+aKWTL63Tu0tMDRln2aguJ3Z0DRuj9dkJhZ4nAsGNeSwO44Y9qeXDN1CKURt0JYg/G33JJ32Pxs5mBQgsB6PFiiXai+oF4oozlYU69ehH6dUAmyfQP4xNg0phEiAGyA7Z+axyPF53m4SNcwel6P5Z7lXNO+h0GSQQHbPvz3UEeCEaE2emkbx3yHL8b0ysHfDJ0VIThSymoeZSRAzRBKGIppFVwFDV9xs3tf57YURtHhi3l8WtQT8CZsPycx0UHwOvJRWj7PZJ/jml0VbZHslFoBfenhIhMke66H6jhfmlrQbd/bz8OehHyHiIQsgG5LWZmDub5GUAiX8UcjW6EzBElpEzYJcaGEh4oFQnpwcRc/5Ld6cSAeD0oBBEcSwt8sCYMqKzNJ82axMF1yyQMZsdk9IZp7enwWkwzIGhwHFDSBAYtA9YG/7nOubmgj6QBRuXw6WIKDp2wVMLLKDdBLFV4BURzT4jmjHHNBVRoA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(40470700002)(36840700001)(8936002)(36756003)(36860700001)(336012)(82310400004)(5660300002)(1076003)(47076005)(70206006)(86362001)(4326008)(40460700001)(426003)(70586007)(2616005)(26005)(508600001)(8676002)(83380400001)(186003)(81166007)(316002)(2906002)(6666004)(110136005)(7696005)(7416002)(54906003)(356005)(41533002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 16:35:15.9728
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 993a38e7-1c9f-4ab0-bd60-08d9d6b2aded
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1927
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Audio Co-processor or ACP IP block on AMD's SOC is connected via
PCI bus interface, hence needs to be register as a PCI device. We
have same PCI device ID across multiple SOC's but with different
revision id for PCI hw. Add a generic PCI driver module for ACP
that registers ACP as a PCI device and also register a platform
device based on pci revision id. Any SOC's specific configuration
for ACP block will be done in platform driver probe. We have added
an initial support for ACP revision id 3 or ACP3X device.

Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
---
 sound/soc/amd/acp/Kconfig   |   6 ++
 sound/soc/amd/acp/Makefile  |   2 +
 sound/soc/amd/acp/acp-pci.c | 160 ++++++++++++++++++++++++++++++++++++
 sound/soc/amd/acp/amd.h     |  14 ++++
 sound/soc/amd/mach-config.h |   1 +
 5 files changed, 183 insertions(+)
 create mode 100644 sound/soc/amd/acp/acp-pci.c

diff --git a/sound/soc/amd/acp/Kconfig b/sound/soc/amd/acp/Kconfig
index f4ca7843391b..626e4a5cb06a 100644
--- a/sound/soc/amd/acp/Kconfig
+++ b/sound/soc/amd/acp/Kconfig
@@ -25,6 +25,12 @@ config SND_SOC_AMD_ACP_PCM
 	tristate
 	select SND_SOC_ACPI if ACPI
 
+config SND_SOC_AMD_ACP_PCI
+	tristate "AMD ACP PCI Driver Support"
+	depends on X86 && PCI
+	help
+	  This options enables generic PCI driver for ACP device.
+
 config SND_AMD_ASOC_RENOIR
 	tristate "AMD ACP ASOC Renoir Support"
 	select SND_SOC_AMD_ACP_PCM
diff --git a/sound/soc/amd/acp/Makefile b/sound/soc/amd/acp/Makefile
index 66cac95432f6..657ddfadf0bb 100644
--- a/sound/soc/amd/acp/Makefile
+++ b/sound/soc/amd/acp/Makefile
@@ -8,6 +8,7 @@
 snd-acp-pcm-objs     := acp-platform.o
 snd-acp-i2s-objs     := acp-i2s.o
 snd-acp-pdm-objs     := acp-pdm.o
+snd-acp-pci-objs     := acp-pci.o
 
 #platform specific driver
 snd-acp-renoir-objs     := acp-renoir.o
@@ -20,6 +21,7 @@ snd-acp-sof-mach-objs     := acp-sof-mach.o
 obj-$(CONFIG_SND_SOC_AMD_ACP_PCM) += snd-acp-pcm.o
 obj-$(CONFIG_SND_SOC_AMD_ACP_I2S) += snd-acp-i2s.o
 obj-$(CONFIG_SND_SOC_AMD_ACP_PDM) += snd-acp-pdm.o
+obj-$(CONFIG_SND_SOC_AMD_ACP_PCI) += snd-acp-pci.o
 
 obj-$(CONFIG_SND_AMD_ASOC_RENOIR) += snd-acp-renoir.o
 
diff --git a/sound/soc/amd/acp/acp-pci.c b/sound/soc/amd/acp/acp-pci.c
new file mode 100644
index 000000000000..3a0511fd1de2
--- /dev/null
+++ b/sound/soc/amd/acp/acp-pci.c
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+//
+// This file is provided under a dual BSD/GPLv2 license. When using or
+// redistributing this file, you may do so under either license.
+//
+// Copyright(c) 2021 Advanced Micro Devices, Inc. All rights reserved.
+//
+// Authors: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
+
+/*
+ * Generic PCI interface for ACP device
+ */
+
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/pm_runtime.h>
+
+#include "amd.h"
+#include "../mach-config.h"
+
+#define DRV_NAME "acp_pci"
+
+#define ACP3x_REG_START	0x1240000
+#define ACP3x_REG_END	0x125C000
+
+static struct platform_device *dmic_dev;
+static struct platform_device *pdev;
+
+static const struct resource acp3x_res[] = {
+	{
+		.start = 0,
+		.end = ACP3x_REG_END - ACP3x_REG_START,
+		.name = "acp_mem",
+		.flags = IORESOURCE_MEM,
+	},
+	{
+		.start = 0,
+		.end = 0,
+		.name = "acp_dai_irq",
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+static int acp_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
+{
+	struct platform_device_info pdevinfo;
+	struct device *dev = &pci->dev;
+	const struct resource *res_acp;
+	struct acp_chip_info *chip;
+	struct resource *res;
+	unsigned int flag, addr, num_res, i;
+	int ret;
+
+	flag = snd_amd_acp_find_config(pci);
+	if (flag != FLAG_AMD_LEGACY)
+		return -ENODEV;
+
+	chip = devm_kzalloc(&pci->dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	if (pci_enable_device(pci)) {
+		dev_err(&pci->dev, "pci_enable_device failed\n");
+		return -ENODEV;
+	}
+
+	ret = pci_request_regions(pci, "AMD ACP3x audio");
+	if (ret < 0) {
+		dev_err(&pci->dev, "pci_request_regions failed\n");
+		return -ENOMEM;
+	}
+
+	pci_set_master(pci);
+
+	switch (pci->revision) {
+	case 0x01:
+		res_acp = acp3x_res;
+		num_res = ARRAY_SIZE(acp3x_res);
+		chip->name = "acp_asoc_renoir";
+		chip->acp_rev = ACP3X_DEV;
+		break;
+	default:
+		dev_err(dev, "Unsupported device revision:0x%x\n", pci->revision);
+		return -EINVAL;
+	}
+
+	dmic_dev = platform_device_register_data(dev, "dmic-codec", PLATFORM_DEVID_NONE, NULL, 0);
+	if (IS_ERR(dmic_dev)) {
+		dev_err(dev, "failed to create DMIC device\n");
+		return PTR_ERR(dmic_dev);
+	}
+
+	addr = pci_resource_start(pci, 0);
+	chip->base = devm_ioremap(&pci->dev, addr, pci_resource_len(pci, 0));
+
+	res = devm_kzalloc(&pci->dev, sizeof(struct resource) * num_res, GFP_KERNEL);
+	if (!res) {
+		platform_device_unregister(dmic_dev);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < num_res; i++, res_acp++) {
+		res[i].name = res_acp->name;
+		res[i].flags = res_acp->flags;
+		res[i].start = addr + res_acp->start;
+		res[i].end = addr + res_acp->end;
+		if (res_acp->flags == IORESOURCE_IRQ) {
+			res[i].start = pci->irq;
+			res[i].end = res[i].start;
+		}
+	}
+
+	memset(&pdevinfo, 0, sizeof(pdevinfo));
+
+	pdevinfo.name = chip->name;
+	pdevinfo.id = 0;
+	pdevinfo.parent = &pci->dev;
+	pdevinfo.num_res = num_res;
+	pdevinfo.res = &res[0];
+	pdevinfo.data = chip;
+	pdevinfo.size_data = sizeof(*chip);
+
+	pdev = platform_device_register_full(&pdevinfo);
+	if (IS_ERR(pdev)) {
+		dev_err(&pci->dev, "cannot register %s device\n", pdevinfo.name);
+		platform_device_unregister(dmic_dev);
+		ret = PTR_ERR(pdev);
+	}
+
+	return ret;
+};
+
+static void acp_pci_remove(struct pci_dev *pci)
+{
+	if (dmic_dev)
+		platform_device_unregister(dmic_dev);
+	if (pdev)
+		platform_device_unregister(pdev);
+}
+
+/* PCI IDs */
+static const struct pci_device_id acp_pci_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, ACP_PCI_DEV_ID)},
+	{ 0, }
+};
+MODULE_DEVICE_TABLE(pci, acp_pci_ids);
+
+/* pci_driver definition */
+static struct pci_driver snd_amd_acp_pci_driver = {
+	.name = KBUILD_MODNAME,
+	.id_table = acp_pci_ids,
+	.probe = acp_pci_probe,
+	.remove = acp_pci_remove,
+};
+module_pci_driver(snd_amd_acp_pci_driver);
+
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_ALIAS(DRV_NAME);
diff --git a/sound/soc/amd/acp/amd.h b/sound/soc/amd/acp/amd.h
index 567355209a5c..8fd38bf4d3bd 100644
--- a/sound/soc/amd/acp/amd.h
+++ b/sound/soc/amd/acp/amd.h
@@ -12,9 +12,14 @@
 #define __AMD_ACP_H
 
 #include <sound/pcm.h>
+#include <sound/soc.h>
 #include <sound/soc-acpi.h>
+#include <sound/soc-dai.h>
+
 #include "chip_offset_byte.h"
 
+#define ACP3X_DEV			3
+
 #define I2S_SP_INSTANCE			0x00
 #define I2S_BT_INSTANCE			0x01
 #define DMIC_INSTANCE			0x02
@@ -70,6 +75,12 @@
 
 #define ACP_MAX_STREAM			6
 
+struct acp_chip_info {
+	char *name;		/* Platform name */
+	unsigned int acp_rev;	/* ACP Revision id */
+	void __iomem *base;	/* ACP memory PCI base */
+};
+
 struct acp_stream {
 	struct snd_pcm_substream *substream;
 	int irq_bit;
@@ -106,6 +117,9 @@ int acp_platform_unregister(struct device *dev);
 
 int acp_machine_select(struct acp_dev_data *adata);
 
+/* Machine configuration */
+int snd_amd_acp_find_config(struct pci_dev *pci);
+
 static inline u64 acp_get_byte_count(struct acp_dev_data *adata, int dai_id, int direction)
 {
 	u64 byte_count, low = 0, high = 0;
diff --git a/sound/soc/amd/mach-config.h b/sound/soc/amd/mach-config.h
index feb3756d9ac4..0a54567a2841 100644
--- a/sound/soc/amd/mach-config.h
+++ b/sound/soc/amd/mach-config.h
@@ -14,6 +14,7 @@
 
 #define FLAG_AMD_SOF			BIT(1)
 #define FLAG_AMD_SOF_ONLY_DMIC		BIT(2)
+#define FLAG_AMD_LEGACY			BIT(3)
 
 #define ACP_PCI_DEV_ID			0x15E2
 
-- 
2.25.1

