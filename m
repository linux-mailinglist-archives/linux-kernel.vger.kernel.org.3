Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43084B7FD3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 06:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbiBPFBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 00:01:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiBPFBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 00:01:35 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E61AA0;
        Tue, 15 Feb 2022 21:01:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dk+23GikTQKRfv097+6zT3EjmXTheAVZyNdv667OgLJw8m2/s7vnQEYTTLAmDBonPospM4OHKqT0ALhCO9iIRbDroztMVxmUM52tsXy0hvg8D7BaUQyNweDKc/h0b54oXpubljGINN0a5aR/lOppUy5wlYcNLcHMSfuROgvvDsRJ7TC0Moq2tEHieHoZiLu3PaGGP84fZJd63V962TGwjJVfTAjzzbuHau/KL99lGOYQeoumJYB+UbuKJU9ozaROA9LQhJ6v4TWnIaJkU38IQyVsf5zcZxs+hsLpj1FCyQaA/bUQOU1UgBUFCZSm40l/56ZzH4DiyagMR7tGbUfh3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6ZUn7Qf7HwMYxNiZ7VT+lF0ZlQ23+k+n6i8Xlo/j7o=;
 b=oLzl3iZPHCh5mf2m/uUvGhplRbxRhxUNgfsesaOXuEnzSpLZ4KLHDOc7KXco+q+zP7Ia0GgeZquH0/FNLlKAG360DygZ9h7aPzU6egtvDaJJKh8HfQ/8vKYhIZ08Tb2uEyKTweNNvvYDZxum0S2Dmn5TCZ1IJJCrLFP2fVbuprWElATxTX8+wkrf7FNL82n5AWQYpNBzTY0xzFtA/HNeh2WfKni89BCxRyI2ebSACr550C5w7Hr0N8QyuHAs3v2wObsykNlPb1xYoQIZ556ES1Aiao3J72kvM0DlD+Azcw9B6LE+B3tVJFObT9zY39rdbiMeQn2kd2QOsi4zjDzsDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=infradead.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6ZUn7Qf7HwMYxNiZ7VT+lF0ZlQ23+k+n6i8Xlo/j7o=;
 b=UpVqyrHRFXKemM3dAyp7XrsVuv7WpT0f9h6n3sviQrSoTtPK1y9SgtDPup4Phxxg2aHAy4xuGdGFJuL2xN+Nmf1DWw+QLZ5SR/C44r0kAqZfY54Wto+qgR6Dbl1Iw0b/Ly2Dj16jsXvJCaR64C/IHd+nPpuTxydtL8/pzGtwnP0=
Received: from DM6PR14CA0072.namprd14.prod.outlook.com (2603:10b6:5:18f::49)
 by DM5PR02MB2220.namprd02.prod.outlook.com (2603:10b6:3:53::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 16 Feb
 2022 05:01:20 +0000
Received: from DM3NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::ed) by DM6PR14CA0072.outlook.office365.com
 (2603:10b6:5:18f::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16 via Frontend
 Transport; Wed, 16 Feb 2022 05:01:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT060.mail.protection.outlook.com (10.13.4.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 16 Feb 2022 05:01:20 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 15 Feb 2022 21:01:13 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 15 Feb 2022 21:01:13 -0800
Envelope-to: dwmw2@infradead.org,
 yilun.xu@intel.com,
 mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.93] (port=55280 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1nKCRF-0009ZN-OV; Tue, 15 Feb 2022 21:01:13 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 249FE600066; Tue, 15 Feb 2022 21:01:00 -0800 (PST)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <devicetree@vger.kernel.org>, <robh@kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-kernel@vger.kernel.org>,
        <yilun.xu@intel.com>, <maxz@xilinx.com>, <sonal.santan@xilinx.com>,
        <yliu@xilinx.com>, <michal.simek@xilinx.com>,
        <stefanos@xilinx.com>, <trix@redhat.com>, <mdf@kernel.org>,
        <dwmw2@infradead.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V2 Create empty OF root 1/1] of: create empty of root
Date:   Tue, 15 Feb 2022 21:00:56 -0800
Message-ID: <20220216050056.311496-2-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220216050056.311496-1-lizhi.hou@xilinx.com>
References: <20220216050056.311496-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fe63f8d-53a3-4416-e9f2-08d9f1095f1f
X-MS-TrafficTypeDiagnostic: DM5PR02MB2220:EE_
X-Microsoft-Antispam-PRVS: <DM5PR02MB22208078C016B293E8250CE7A1359@DM5PR02MB2220.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0YWHaWKqosSVA5ZTTPfW4F8CeR67k099CUrSODlD0gZoEMuaRZ7XDXaNQNyirqP4n55INaaVZerDElRD5flPJSlXFqhtJHXVMWyBxYSLL3zd6xFzooQYj/mQzcpjb2I9rVOV+vCF3mbw9HCrx+dmKePHhIfYTJy0RSwMCV1uPaS0YumCpqk6xpi5ARIsxkD5V3FlLRDbnt0pTe5E1MMODr25Yx3unpPIxGUNqi03bCGSNWEb8uW6MJvtowbu76wJ6GY35KIjLEbY3ivNSYDZP7GiuuKn2XJBoczb9TWedjOKo/RGcTaNmofw4Xp/uhOmqLmGVet0d7ZAqh4lddb8XgrYO0fTC8ksZtdvfBACS8w0aPRQqJVERU8tZlL2NlBoPRTO9I8dhOOyYmUtTOfBlELzz9BAt9VZMPf6dFjGESxPNbP9jtuFlMoW6B0bw0r6iEUjl7QwrTTzznKseF5/zfhALvBZTEXOBazTPHH8DLEIT0UGc2NBfaOxwK5f+BGrSAM7ks5xt+hv5QJ5JI6B5+Q/7zkjE9843vaBJj9CKdHy6mnVj69jtR4I4U8c+glafeU8BqSTcD2u67zsvvpU2Q2tiGrtqJpu1oWZ1x8iUF1vPAwrq97SWtq3E7bQ7Huz0djpoDR8PgL4DwU2vlJvucX9TNMTgwTMrBI0wX0sVaclR1FOX2EF2cQBigTMu0W8pvzXPBo4Ifo0PwV2lhljyFJOQQlYvmKT+RLMo3InSXYcuWYEOX6OmI0jhbjSIbcUOGbGsJcZKFa/9RwzSFTguw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(36756003)(47076005)(36860700001)(6266002)(26005)(70586007)(70206006)(4326008)(8676002)(1076003)(316002)(426003)(186003)(336012)(8936002)(2616005)(107886003)(44832011)(966005)(2906002)(5660300002)(82310400004)(54906003)(42186006)(356005)(110136005)(6666004)(40460700003)(508600001)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 05:01:20.1625
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fe63f8d-53a3-4416-e9f2-08d9f1095f1f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT060.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2220
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xilinx Alveo PCIe accelerator cards use flattened device tree to describe
describe apertures in its PCIe BARs. Each device tree node represents an
aperture and each aperture is an hardware unit which requires a driver.
The product detail:
    https://www.xilinx.com/products/boards-and-kits/alveo.html

Thus a base device tree is required. Then the Alveo card driver can load
its flattened device tree and overlay it to the base tree. However device
tree does not always exist. To resolve this, add OF_EMPTY_ROOT config.
When it is selected and there is not a device tree, create an empty device
tree root node.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
---
 drivers/of/Kconfig         |  5 ++++
 drivers/of/Makefile        |  1 +
 drivers/of/of_empty_root.c | 51 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+)
 create mode 100644 drivers/of/of_empty_root.c

diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index 80b5fd44ab1c..452d2316b47b 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -94,4 +94,9 @@ config OF_DMA_DEFAULT_COHERENT
 	# arches should select this if DMA is coherent by default for OF devices
 	bool
 
+config OF_EMPTY_ROOT
+	# driver which requires at least the empty base device tree to
+	# overlay its own device nodes should select this.
+	bool
+
 endif # OF
diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index e0360a44306e..c65364f32935 100644
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_OF_RESERVED_MEM) += of_reserved_mem.o
 obj-$(CONFIG_OF_RESOLVE)  += resolver.o
 obj-$(CONFIG_OF_OVERLAY) += overlay.o
 obj-$(CONFIG_OF_NUMA) += of_numa.o
+obj-$(CONFIG_OF_EMPTY_ROOT) += of_empty_root.o
 
 ifdef CONFIG_KEXEC_FILE
 ifdef CONFIG_OF_FLATTREE
diff --git a/drivers/of/of_empty_root.c b/drivers/of/of_empty_root.c
new file mode 100644
index 000000000000..5c429c7a27bd
--- /dev/null
+++ b/drivers/of/of_empty_root.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Xilinx, Inc.
+ */
+
+#include <linux/of.h>
+#include <linux/slab.h>
+
+#include "of_private.h"
+
+static int __init of_root_init(void)
+{
+	struct property *prop = NULL;
+	struct device_node *node;
+	__be32 *val = NULL;
+
+	if (of_root)
+		return 0;
+
+	pr_info("Create empty OF root node\n");
+	node = kzalloc(sizeof(*node), GFP_KERNEL);
+	if (!node)
+		return -ENOMEM;
+	of_node_init(node);
+	node->full_name = "/";
+
+	prop = kcalloc(2, sizeof(*prop), GFP_KERNEL);
+	if (!prop)
+		return -ENOMEM;
+
+	val = kzalloc(sizeof(*val), GFP_KERNEL);
+	if (!val)
+		return -ENOMEM;
+	*val = cpu_to_be32(sizeof(void *) / sizeof(u32));
+
+	prop->name = "#address-cells";
+	prop->value = val;
+	prop->length = sizeof(u32);
+	of_add_property(node, prop);
+	prop++;
+	prop->name = "#size-cells";
+	prop->value = val;
+	prop->length = sizeof(u32);
+	of_add_property(node, prop);
+	of_root = node;
+	for_each_of_allnodes(node)
+		__of_attach_node_sysfs(node);
+
+	return 0;
+}
+pure_initcall(of_root_init);
-- 
2.27.0

