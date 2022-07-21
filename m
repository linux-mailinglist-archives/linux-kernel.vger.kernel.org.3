Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3111257C442
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 08:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbiGUGMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 02:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbiGUGMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 02:12:36 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76107B79C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 23:12:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpzMyf0mJQsMBWNml383oXi95mrubanbPCKzI4Qmo31kw7FFu/botFKG+FH/pYeI0/vVPpys2ERg+2/XYkq+UDlb4waj/1TqlYAgf0cDWY5kqIViOpdUTs+HpDZJYmeXTRIIt1oKSNDh7YhCdpQWA2oLC5Omn4OlNTkn24wy7KhJLQyqgx+tMzTbqH0+eX2iO2hdY0RLSEvFpw7cMNMWK9zl5klDeeotLCpf2lGef4LUzcwvaKdz9HGGNwaMh5dMkoH2fX7lfR/M03llWCmgGnCM1b8Qf0ctIL3YSJPk5p3dsFeGbRNsMMpO98k7h7ukYdzO3PUrWi5vS25JLNCo7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4rTEUPV/2gLD5QzgU2hYcduG5fsy8OER+SeUVUSxNY8=;
 b=Yv+fXbnlRGbAAh2psDuTRWmjuxauV7dluSC1yXhHhVSFLGG0/m4dSHa8mRv/lS5JJuvRdsVyAW4wttuOaNSl2hiCcRtiWF+G/dob2qsqqkUraAYG7bBr99mzkj52NQ7MslaChBnXrCLSzij5w/Ym/wAbqdrx7pf9dVa8xNk5dfLG1zrGsGgZMQHXxhywJuwZmRviTkVawilUsPg/TCodwyZvkxDGfibKp97DBjR1Es2bcGhZbqh4dXMSbYctH6778ZMV++0KDhdEVOd2rHwlGvBTj0QeMYF2nF9NfvPT5zJozwT4kjqO9FwZWr8k1gYba2OYTamZaHY6GJQY/PXMCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rTEUPV/2gLD5QzgU2hYcduG5fsy8OER+SeUVUSxNY8=;
 b=GKQzyVPYGBw1gme7fR3JmfmRHhuhdaKTPmg3LNVQUisZInRnAWipo4Cm2Motj9I2Al8b+4P/eGVbdgvskPI65/RHrkXyq0C1LuuaaNDHeLKnM8z5iNwa9jxrGybB+yEwjVMlpEG4peNQNpsXx17OIiyge49QxovUmBWd8+CTWLA=
Received: from MW4PR03CA0331.namprd03.prod.outlook.com (2603:10b6:303:dc::6)
 by MN2PR12MB4253.namprd12.prod.outlook.com (2603:10b6:208:1de::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Thu, 21 Jul
 2022 06:12:20 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::9b) by MW4PR03CA0331.outlook.office365.com
 (2603:10b6:303:dc::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23 via Frontend
 Transport; Thu, 21 Jul 2022 06:12:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Thu, 21 Jul 2022 06:12:19 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 21 Jul
 2022 01:12:19 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 21 Jul
 2022 01:12:18 -0500
Received: from amd-Z97X-UD7-TH.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Thu, 21 Jul 2022 01:12:10 -0500
From:   syed sabakareem <Syed.SabaKareem@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Alexander.Deucher@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <vijendar.mukunda@amd.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/5] ASoC: amd: add ACP PCI driver for RPL platform
Date:   Thu, 21 Jul 2022 11:39:59 +0530
Message-ID: <20220721061035.91139-2-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220721061035.91139-1-Syed.SabaKareem@amd.com>
References: <20220721061035.91139-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf4a2b86-5ca0-4f67-c63d-08da6adff829
X-MS-TrafficTypeDiagnostic: MN2PR12MB4253:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U9hrSXjJsSkV+OrDCyaOzAa+Kd4SlSP+FbCQO08cWJ+S5DxDUYd6Pg1FqvZMif14RsoKYL6tZJhQDp35QxBjYQw9a/YPBD/DMrf3Ey6X+VT2TdunMOIwtbgemVVrD0N0jiEBU24uccL0++KoLC7UEvpyIwiKz/eolw9bMI453UNP7WSNh2YnCOyv1JRu0Ang+dI7PSKKHWlnUQIzGgUEpfzm2BpVaiiJ6AMCwym1r6dt+q6n6Mr5Ftkh0FlaOSADRqWPlg9FKbkzRrZ+9mJhmjd/QUVCInjtL830YFKHIxONj5PB89RaJUYltCjVijuLvkl7xB6rKOzcbMGZw4T5tcsUqYJLgxudLAtIr6heOK145DpshswJvmE0D54fRJOix/6JOuIq7ZU/Aw4omOIGV7Peygg2i0uSBr3IiqXMkfFP1KQDnR6LAHsZgaWxTbHsFevSgnXf+a6gFbKh8pxurWqN07Nth/Hhl8LmVlcDTyM7obXhgWuyyMX4T8KgSs843gUdvfa9WLXdaNWFiPgvR+qHj6vlyzNgnv+EKDJd4s0HsqRZUgfkIlWzlazchlb5loNF7XzDG9/aVJKmUQG0oBvQb/RkKHe0WXj1slTkrgb8SYdBGBFySbXs14kFJ1ljXv2ugrZU4pZgQFNAsxQz8aHK2hi9whHRJY0RDR08n9V43Vnzj1R6o1aEebFsH4Fj3L8qF24ZR9OskwW5MYWgjoeLDqIRVomg0cEgaaSihSTaEd5IsV7pWO46iMfrVy5dBX6LFNuKZLC9eEpQWkiTeUHKVzhS0L66pK5ljG3QATS6ULkN/ZN7fxzGSCjVISGpiW632496ndQwyixOPzTK+Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(376002)(346002)(396003)(36840700001)(46966006)(40470700004)(356005)(70206006)(82740400003)(8676002)(83380400001)(426003)(186003)(2616005)(47076005)(1076003)(336012)(70586007)(5660300002)(2906002)(4326008)(36756003)(8936002)(7696005)(316002)(40460700003)(82310400005)(6666004)(26005)(41300700001)(36860700001)(81166007)(478600001)(40480700001)(86362001)(54906003)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 06:12:19.8210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf4a2b86-5ca0-4f67-c63d-08da6adff829
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4253
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Syed Saba Kareem <Syed.SabaKareem@amd.com>

ACP is a PCI audio device.
This patch adds PCI driver to bind to this device and get
PCI resources.

Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
Reviewed-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/rpl/rpl-pci-acp6x.c | 95 +++++++++++++++++++++++++++++++
 sound/soc/amd/rpl/rpl_acp6x.h     | 21 +++++++
 2 files changed, 116 insertions(+)
 create mode 100644 sound/soc/amd/rpl/rpl-pci-acp6x.c
 create mode 100644 sound/soc/amd/rpl/rpl_acp6x.h

diff --git a/sound/soc/amd/rpl/rpl-pci-acp6x.c b/sound/soc/amd/rpl/rpl-pci-acp6x.c
new file mode 100644
index 000000000000..7a82a978cf24
--- /dev/null
+++ b/sound/soc/amd/rpl/rpl-pci-acp6x.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * AMD RPL ACP PCI Driver
+ *
+ * Copyright 2022 Advanced Micro Devices, Inc.
+ */
+
+#include <linux/pci.h>
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+
+#include "rpl_acp6x.h"
+
+struct rpl_dev_data {
+	void __iomem *acp6x_base;
+};
+
+static int snd_rpl_probe(struct pci_dev *pci,
+			 const struct pci_device_id *pci_id)
+{
+	struct rpl_dev_data *adata;
+	u32 addr;
+	int ret;
+
+	/* RPL device check */
+	switch (pci->revision) {
+	case 0x62:
+		break;
+	default:
+		dev_dbg(&pci->dev, "acp6x pci device not found\n");
+		return -ENODEV;
+	}
+	if (pci_enable_device(pci)) {
+		dev_err(&pci->dev, "pci_enable_device failed\n");
+		return -ENODEV;
+	}
+
+	ret = pci_request_regions(pci, "AMD ACP6x audio");
+	if (ret < 0) {
+		dev_err(&pci->dev, "pci_request_regions failed\n");
+		goto disable_pci;
+	}
+
+	adata = devm_kzalloc(&pci->dev, sizeof(struct rpl_dev_data),
+			     GFP_KERNEL);
+	if (!adata) {
+		ret = -ENOMEM;
+		goto release_regions;
+	}
+
+	addr = pci_resource_start(pci, 0);
+	adata->acp6x_base = devm_ioremap(&pci->dev, addr,
+					 pci_resource_len(pci, 0));
+	if (!adata->acp6x_base) {
+		ret = -ENOMEM;
+		goto release_regions;
+	}
+	pci_set_master(pci);
+	pci_set_drvdata(pci, adata);
+	return 0;
+release_regions:
+	pci_release_regions(pci);
+disable_pci:
+	pci_disable_device(pci);
+
+	return ret;
+}
+
+static void snd_rpl_remove(struct pci_dev *pci)
+{
+	pci_release_regions(pci);
+	pci_disable_device(pci);
+}
+
+static const struct pci_device_id snd_rpl_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, ACP_DEVICE_ID),
+	.class = PCI_CLASS_MULTIMEDIA_OTHER << 8,
+	.class_mask = 0xffffff },
+	{ 0, },
+};
+MODULE_DEVICE_TABLE(pci, snd_rpl_ids);
+
+static struct pci_driver rpl_acp6x_driver  = {
+	.name = KBUILD_MODNAME,
+	.id_table = snd_rpl_ids,
+	.probe = snd_rpl_probe,
+	.remove = snd_rpl_remove,
+};
+
+module_pci_driver(rpl_acp6x_driver);
+
+MODULE_DESCRIPTION("AMD ACP RPL PCI driver");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/amd/rpl/rpl_acp6x.h b/sound/soc/amd/rpl/rpl_acp6x.h
new file mode 100644
index 000000000000..5de19d5c892e
--- /dev/null
+++ b/sound/soc/amd/rpl/rpl_acp6x.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * AMD ACP Driver
+ *
+ * Copyright (C) 2021 Advanced Micro Devices, Inc. All rights reserved.
+ */
+
+#include "rpl_acp6x_chip_offset_byte.h"
+
+#define ACP_DEVICE_ID 0x15E2
+#define ACP6x_PHY_BASE_ADDRESS 0x1240000
+
+static inline u32 rpl_acp_readl(void __iomem *base_addr)
+{
+	return readl(base_addr - ACP6x_PHY_BASE_ADDRESS);
+}
+
+static inline void rpl_acp_writel(u32 val, void __iomem *base_addr)
+{
+	writel(val, base_addr - ACP6x_PHY_BASE_ADDRESS);
+}
-- 
2.25.1

