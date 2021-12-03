Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D96BB467F40
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 22:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383217AbhLCV1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 16:27:46 -0500
Received: from mail-co1nam11on2051.outbound.protection.outlook.com ([40.107.220.51]:64207
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344120AbhLCV1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 16:27:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgefmLivnr8Ha8XHUCyorE9ZeZsVwLpLUGCT/4Jrc8jtg1qNrenhjavVueyLBho2y3b0JfP9fnmn2xBE32d7aLbQVFyiToYmuY4ndlVs3EYUnqOSILRRILzuC8YOt/AzHpOp1Jo75Q+ZxEznuIm8IFqVs3SswYckg2un5+QeZpLnLf5TQXz+FPJ9LEj9EmUAadUXQ/DS/IDqj+/lMmvPQwzNud54iAj8oyK4bGpchquHP2j+iZgtVX+yKK1QM6O2XOoo57GBohjw3d2Mgoxr4honiRwmzzQysnHF0+/2qkppp295SL18tT5rzqbqTV14iWwpBgpznfmjadmHTXiIew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CsSV2w5x/qxc2kRbMe9L3uMRg8bbvrAsGwVt8jevvTk=;
 b=m8bTm4yE66iDovxCPlDJ61QUDtmX9Qjc/w6+mPAHnXlHuDUfxe3AeaQOmcfjLmgddwIm+GqMl85ouRbOoPcCLl9U3Vx8/nH36UopYoaUnrmAUWbZpZbTBOMtbi+Nyl0erQa4XIQwUHf/tEMdXIPLrM+dWTbpnCEm1EVU8zAQeIeg5V0UfkVZaB7Xd62pk6OwRVcs4AlPritpPTXIQTvXHmyMO0eB98Y/WHRhnyWJOGos4bFsakc7nq+9BHn0V85/+kPFNVZ0n//BD9jzO8Vz+JHYcgVNKGQA/GkyTtpOALHHBvz04GLF0ZOS0o7cD6qn+UQbgUTqS5UvK9Gbk6QwCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.80.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CsSV2w5x/qxc2kRbMe9L3uMRg8bbvrAsGwVt8jevvTk=;
 b=rMUJyOPcLdRIwzsMzllKZyUP4NW8+sVM2Gs4pAXMmc3b+rKOiTAv6g/YM/eI0s7K3u2ZLxXi8OwQ8dDFJXre/WZfcZlxQfexxDJVpnH0kg5Ea9/rligiqW2oWKnXaxBXWZSoTLt5TDdOjDVhwE0Qjjapzr+0g+dAX1TR6zpTim4=
Received: from SN4PR0801CA0013.namprd08.prod.outlook.com
 (2603:10b6:803:29::23) by DM6PR02MB4425.namprd02.prod.outlook.com
 (2603:10b6:5:2a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Fri, 3 Dec
 2021 21:24:12 +0000
Received: from SN1NAM02FT0022.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:29:cafe::97) by SN4PR0801CA0013.outlook.office365.com
 (2603:10b6:803:29::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Fri, 3 Dec 2021 21:24:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch02.xlnx.xilinx.com;
Received: from xir-pvapexch02.xlnx.xilinx.com (149.199.80.198) by
 SN1NAM02FT0022.mail.protection.outlook.com (10.97.5.0) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Fri, 3 Dec 2021 21:24:12 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 3 Dec 2021 21:24:09 +0000
Received: from smtp.xilinx.com (172.21.105.197) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 3 Dec 2021 21:24:09 +0000
Envelope-to: anand.ashok.dumbre@xilinx.com,
 git@xilinx.com,
 michals@xilinx.com,
 linux-kernel@vger.kernel.org,
 jic23@kernel.org,
 lars@metafoo.de,
 linux-iio@vger.kernel.org,
 gregkh@linuxfoundation.org,
 rafael@kernel.org,
 linux-acpi@vger.kernel.org,
 heikki.krogerus@linux.intel.com
Received: from [10.71.188.1] (port=14741 helo=xiranandash40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <anand.ashok.dumbre@xilinx.com>)
        id 1mtG2C-0005F8-7j; Fri, 03 Dec 2021 21:24:00 +0000
From:   Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
To:     <linux-kernel@vger.kernel.org>, <jic23@kernel.org>,
        <lars@metafoo.de>, <linux-iio@vger.kernel.org>, <git@xilinx.com>,
        <michals@xilinx.com>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <linux-acpi@vger.kernel.org>,
        <heikki.krogerus@linux.intel.com>
CC:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Subject: [PATCH v12 1/5] device property: Add fwnode_iomap()
Date:   Fri, 3 Dec 2021 21:23:54 +0000
Message-ID: <20211203212358.31444-2-anand.ashok.dumbre@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211203212358.31444-1-anand.ashok.dumbre@xilinx.com>
References: <20211203212358.31444-1-anand.ashok.dumbre@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb351570-7d72-4d49-4ea2-08d9b6a3405c
X-MS-TrafficTypeDiagnostic: DM6PR02MB4425:
X-Microsoft-Antispam-PRVS: <DM6PR02MB44254F05BC92022A4317E9FDA96A9@DM6PR02MB4425.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:541;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h0V5yQaSs/N+NXw+9ily75a9VA3JgfJU9mJn7J9/nJKWaTddXjac9ArhLfw7SKKZ0wOgAQSSGzuWNuajWYxZDkkkbAOlzuvoC/JHpJQAMJOR9A9Z45/wcDqk2tmvSsTfm5y5pH9EZi5DXvUQeGqmL1cUQAQbWd60nGS0oos0f9IJXiXZK4fsVsRiHAhPO781x1CPlyyCYwVK9c7skQg4J6Jo/L094dGDmKeeH0cFu4u4DUd1LenoLleE2hjbt+AhzUwe6M3v/O42F3L0QGZgxkEpfPtSGKtSE8VonUQ23xJYKTdtYMSE6ut7jyksXTrzLC5MLO08w3+ShRMSE9+3iDCl7FmxQlwe8lKpIbREVFkzI0zFujL5nmBRNCqkx0NC9TMSiLnIS2kEaEw5R7Gd9GBx7cxWIchGt8VLkxWFAIxkgve/lXLRZmbkauZ7oaoRnOPWSHbpf5Xf8TI8MzUXtEywjEN4FRP3JUi47OfEJ6kLyjjO2fDX5Nsgz/dGXrKV+ZOO75pL/wisMhQPL1SbyiM7mlhZSHYRWgkxcfKmTDdgbSPxg5xBEZDfW58elWOfOgDkaKT1QybCTnF5o125cQVAkkglTtBrBmD47wrr6GqWm6qxBGe2FsFEzLOLmHNwtC+mLoXnSvEvAgLSJ2tgXvA6HWHONe0hUZvAjL/FWnzi/8316r9MIWva90OO95ufbYhjzN348K7iQbOuF+92qWGdqAxtfHxysn8Hv7uhtS/oQ3T6gXNdmQAS+eKLmlzVvfvmRpELjkFQqLINb7CgnnkMSmgvNSoUhzFeFjgtw7M=
X-Forefront-Antispam-Report: CIP:149.199.80.198;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:xir-pvapexch02.xlnx.xilinx.com;PTR:unknown-80-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(186003)(4326008)(26005)(508600001)(426003)(336012)(5660300002)(2616005)(36756003)(103116003)(47076005)(107886003)(8936002)(7636003)(356005)(921005)(70586007)(1076003)(6666004)(70206006)(2906002)(36860700001)(110136005)(8676002)(82310400004)(9786002)(316002)(7696005)(102446001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 21:24:12.2695
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb351570-7d72-4d49-4ea2-08d9b6a3405c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0022.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4425
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a new helper routine - fwnode_iomap(), which
allows to map the memory mapped IO for a given device node.

This implementation does not cover the ACPI case and may be expanded
in the future. The main purpose here is to be able to develop resource
provider agnostic drivers.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/property.c  | 16 ++++++++++++++++
 include/linux/property.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index f1f35b48ab8b..ed4470410030 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -958,6 +958,22 @@ int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index)
 }
 EXPORT_SYMBOL(fwnode_irq_get);
 
+/**
+ * fwnode_iomap - Maps the memory mapped IO for a given fwnode
+ * @fwnode:	Pointer to the firmware node
+ * @index:	Index of the IO range
+ *
+ * Returns a pointer to the mapped memory.
+ */
+void __iomem *fwnode_iomap(struct fwnode_handle *fwnode, int index)
+{
+	if (IS_ENABLED(CONFIG_OF_ADDRESS) && is_of_node(fwnode))
+		return of_iomap(to_of_node(fwnode), index);
+
+	return NULL;
+}
+EXPORT_SYMBOL(fwnode_iomap);
+
 /**
  * fwnode_graph_get_next_endpoint - Get next endpoint firmware node
  * @fwnode: Pointer to the parent firmware node
diff --git a/include/linux/property.h b/include/linux/property.h
index 88fa726a76df..6670d5a1ec2a 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -122,6 +122,8 @@ void fwnode_handle_put(struct fwnode_handle *fwnode);
 
 int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index);
 
+void __iomem *fwnode_iomap(struct fwnode_handle *fwnode, int index);
+
 unsigned int device_get_child_node_count(struct device *dev);
 
 static inline bool device_property_read_bool(struct device *dev,
-- 
2.17.1

