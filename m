Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C121549C35C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 06:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbiAZFsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 00:48:32 -0500
Received: from mail-bn7nam10on2051.outbound.protection.outlook.com ([40.107.92.51]:22817
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233890AbiAZFsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 00:48:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTzyM40igAV6mbi2fVJLxo86MzXFKgB0a4TvCzgcfsVZbGtgSQ8ZTQgjmRCztZCSDxdpmtUaLDGf5O3c6Yi6kl3XFFstm2uRW6IdLSnWaJrECinEWqpmPOp+aBTcehVC7iJeUjnIZshlWJ63Q1y05cP2KW8Ybqry2UiahK5EI845IeOKpth/ksLlLgSNErN5mZDUGWc0hfnDFiJfrDD0cQSIdD7BTaE0GuH7oUgjAti14livlPaQZKOessEEzgYrdiw9QWOABMiDsmFiolul3Cdwh8apbwr131DQzKELkgZeupuBEoiKTnksqfB7uuNYYZBEHwdAQOREV2q7R0Pk7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xr9B+Kx0US12sVs9d4AsSjmHW8XyACGIbfeQYqjmBF0=;
 b=Q9X1aWd9Z73OO4EDDn565q9URtLCKu2bsudeHd663iNWziN9+tEf6vYUvnDQKQeeJwPg5JLHO2BqbECb7kKDJImXzG9Bvtc3c971N+MBhM3AaI9LktBQzmgJO90nLTWIF5oO/3BD8ggx1mBDENUN7gCVjeJRx+v3eWBWn+GxVlNilT3fQ3ONUDdCIf0RJVlAsHYTXJmt/z0Civ9ZgGye1HPLzMaSLP/74Vtwq+twxhuXv/0qj/+Mh0TBZyWv9zD6wp3Ltj8nQo1BM54kf5G5IGGtCS+FL2MOdgquNvxTvaPJsQXtYU73geYmfC9QIdaE64CoshAJtrX4Mmq2V3/rlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=infradead.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xr9B+Kx0US12sVs9d4AsSjmHW8XyACGIbfeQYqjmBF0=;
 b=OxhWbWgQKRXKN5FDkvXwcxQCqscYxpLwzrY1uXBj5gERGbjsnexAA8d+e6YOaOtka1PKIVGlez80eROSprqTA25gBi1lCWJtSccLw8xOTGtxbLnJ9SuBc14reyWxdYbh/CZsCeXLpVwoao8bLMAVHY2LusPXEhVKbqy91sbIUFo=
Received: from BN9PR03CA0664.namprd03.prod.outlook.com (2603:10b6:408:10e::9)
 by CH2PR02MB6087.namprd02.prod.outlook.com (2603:10b6:610:4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Wed, 26 Jan
 2022 05:48:29 +0000
Received: from BN1NAM02FT003.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::d4) by BN9PR03CA0664.outlook.office365.com
 (2603:10b6:408:10e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Wed, 26 Jan 2022 05:48:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT003.mail.protection.outlook.com (10.13.2.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.8 via Frontend Transport; Wed, 26 Jan 2022 05:48:28 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 25 Jan 2022 21:48:23 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 25 Jan 2022 21:48:22 -0800
Envelope-to: dwmw2@infradead.org,
 yilun.xu@intel.com,
 mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.93] (port=40718 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1nCbAM-000GsH-Sz; Tue, 25 Jan 2022 21:48:22 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id AC556600142; Tue, 25 Jan 2022 21:48:10 -0800 (PST)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <devicetree@vger.kernel.org>, <robh@kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-kernel@vger.kernel.org>,
        <yilun.xu@intel.com>, <maxz@xilinx.com>, <sonal.santan@xilinx.com>,
        <yliu@xilinx.com>, <michal.simek@xilinx.com>,
        <stefanos@xilinx.com>, <trix@redhat.com>, <mdf@kernel.org>,
        <dwmw2@infradead.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V1 Create empty OF root 1/1] of: create empty of root
Date:   Tue, 25 Jan 2022 21:48:07 -0800
Message-ID: <20220126054807.492651-2-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220126054807.492651-1-lizhi.hou@xilinx.com>
References: <20220126054807.492651-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 462f8425-3c85-4ac0-1cae-08d9e08f7a36
X-MS-TrafficTypeDiagnostic: CH2PR02MB6087:EE_
X-Microsoft-Antispam-PRVS: <CH2PR02MB6087104D46B721EC03CEE8B5A1209@CH2PR02MB6087.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CO/MUSB26q8uFYdc8tg84ICQfC873JrxAX9m0wLndOkzmusF0+mpjbOviQeyciJgrT3C8F4L/Ow47wmtZSBwBV9+ia1VoYO6x7C+zOJv4yzfURtAjt06kwlzDg36Zsgz7aGVoIs+8FA+DmiD4Wj4qmvwVAHOvkm4xPf4Qo59ng0zSQXBNy+LEeqRt9ebe5DxxM0fuUpJ/IE3j+ORJ2FR+zjT1UYySs/mAV1dkfa9jxjem5eqibUzCmLHz+niVzUKemjLaLeEWg0ZpCCcFv5hzdUbjOdC8hSMbJVPBnmqKY3XWqzHLx5KYM37SEt6GgFdZ2nM0nHdEY+l5pMU2hsgJe+PLwAfKFkp3iGdE4didOfGXTfo0tdoAQMO5cYuWyryOnEdL5Ss3N5mYS9v5zV+gpSqaLiuWMh3Cb9q9HKeeBa6xEOuOZsjrTvGx5pLrpyTd0FQhm7ITVdrmNshMvr8f6t72yAamgziZ2stgLSOQ4K1Ywe5dyMO/CUtM8v/2bQ+PlHK+lZns4N9hemZ2sfkoqg5BfA4+/t85VrhU5dXO3KbLSx++XCut23JLF3Xa/jxKi16UmDxUvKALCZXS55KouFJ53tYiGFVS9G+YLmRcl7pjMso2II6iLiAbpd7yUfCa3quXhWDx2KrzMxK6+3qmQk2D3b5VqHYfmu12FKMXGG9rF3XCG/M31xm61a+4eSPepJXVn6wHg4FuHPs6KsFM8G979xQXAu5b8k3DFNNBtnt8UsUaeuOhTihASDys5AEiikM7gBSShVTXWg+sTzEXQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(40470700004)(46966006)(36840700001)(8676002)(6266002)(54906003)(2906002)(107886003)(508600001)(47076005)(6666004)(356005)(36860700001)(426003)(8936002)(336012)(42186006)(316002)(40460700003)(82310400004)(44832011)(36756003)(2616005)(186003)(5660300002)(70206006)(110136005)(4326008)(70586007)(1076003)(7636003)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 05:48:28.3697
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 462f8425-3c85-4ac0-1cae-08d9e08f7a36
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT003.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6087
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add OF_EMPTY_ROOT config. When it is selected and there is not a device
tree, create an empty device tree root node.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
---
 drivers/of/Kconfig         |  3 +++
 drivers/of/Makefile        |  1 +
 drivers/of/of_empty_root.c | 51 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+)
 create mode 100644 drivers/of/of_empty_root.c

diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index 80b5fd44ab1c..42afb126f91a 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -94,4 +94,7 @@ config OF_DMA_DEFAULT_COHERENT
 	# arches should select this if DMA is coherent by default for OF devices
 	bool
 
+config OF_EMPTY_ROOT
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

