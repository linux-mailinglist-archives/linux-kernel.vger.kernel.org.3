Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5384B462F00
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 09:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239905AbhK3I6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 03:58:04 -0500
Received: from mail-dm6nam11on2053.outbound.protection.outlook.com ([40.107.223.53]:30464
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239889AbhK3I6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 03:58:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4TCMRpdiCDYmdGZB4XNusRfwilbBBRbngc9BCVmuJw4uNU6a2PJ9Ov7kVvRQOWf8M3q6AH0K9JWSsv7zc8NvCjdFvn04WenqaA6GFPbZToNCJxNaZUstoMAkb9CWub7YMpHcAdYJF4Ms2Pk+ox3cSuYQ7pKFoVnYb+MbqsBkmJa4qrcSBZ89qxCy7Hu34AzsQj6Pxs8HfzlIgFe5t4THwHWn1aPiCm44+MKjZEs+QV1Kz1E31wijUjMQ+x6MzIbVuuQHvjzUKwFckSKJxcF8BODx00CtFPJejHJpdtY1R+bW8FhPLSO1mrnOl+gz9fEoZRJtTobOVEImnBanpaNVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8KsoEK/E5flaUtXpeiB1VxfXCpdMm2TkAxCfqtb1SQ=;
 b=SgUa9AvGmgIhDozIln/XrPalwwbzHvzIQhiTOy0vKp2Wrb7MlgGiNGf+Zexf+Fay6L74IOhEjDlWeRmjsBy93GNnOQ7d06T/iD3+ag/l4+RB3AapE/UZ1mkyW5cgEld2zRYBXBuIEblsy+D6yQ2/67keesaUDH+Xhixn4HDopFC/ewK+z4IpG8lFb6B49k5dpD92u5XaJiYCVr2Sn5iR8rjdIYhi/cpIe7NnhkQ9nrpeFHxXtIzLdeqPlEz7TcimThFW7cKVLIrYkq6CTeuXXGkKDJzHMd8Uzhr9jA3azld/MAREn7tZVhCrYqgfbzZOU0fg0j11jshimhZu/Palaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=gondor.apana.org.au
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8KsoEK/E5flaUtXpeiB1VxfXCpdMm2TkAxCfqtb1SQ=;
 b=daDTv3PSkG2ojcwhnC1Lh7zxT+N3XZmkm2emSxtMe6AvjD7AzeYQXTqStnqprTbLtk1HXu6w82RQI+1vu66ULTq2Wou/wqeEugUlnpp4yhuct9COCHQIVuCmjFmA6yiWul6x9+7uDL7Vt2eUY6RivXfHDyjFi6o8t+W1GujfDHA=
Received: from DM6PR02CA0060.namprd02.prod.outlook.com (2603:10b6:5:177::37)
 by BYAPR02MB3941.namprd02.prod.outlook.com (2603:10b6:a02:f8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Tue, 30 Nov
 2021 08:54:41 +0000
Received: from DM3NAM02FT017.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::b7) by DM6PR02CA0060.outlook.office365.com
 (2603:10b6:5:177::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend
 Transport; Tue, 30 Nov 2021 08:54:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT017.mail.protection.outlook.com (10.13.5.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.20 via Frontend Transport; Tue, 30 Nov 2021 08:54:41 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 30 Nov 2021 00:54:38 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 30 Nov 2021 00:54:38 -0800
Envelope-to: herbert@gondor.apana.org.au,
 davem@davemloft.net,
 linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 robh+dt@kernel.org,
 devicetree@vger.kernel.org
Received: from [10.140.6.6] (port=56576 helo=xhdappanad40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <harsha.harsha@xilinx.com>)
        id 1mryuL-000GNC-Mu; Tue, 30 Nov 2021 00:54:38 -0800
From:   Harsha <harsha.harsha@xilinx.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <saratcha@xilinx.com>, <harshj@xilinx.com>,
        Harsha <harsha.harsha@xilinx.com>
Subject: [RFC PATCH 2/6] firmware: xilinx: Add ZynqMP SHA API for SHA3 functionality
Date:   Tue, 30 Nov 2021 14:24:21 +0530
Message-ID: <1638262465-10790-3-git-send-email-harsha.harsha@xilinx.com>
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1638262465-10790-1-git-send-email-harsha.harsha@xilinx.com>
References: <1638262465-10790-1-git-send-email-harsha.harsha@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b1a2dd8-db45-481f-dc33-08d9b3df0c25
X-MS-TrafficTypeDiagnostic: BYAPR02MB3941:
X-Microsoft-Antispam-PRVS: <BYAPR02MB3941FE6C2D82905A4D62BB6CDE679@BYAPR02MB3941.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FbiP75DugbDiSrTnoqzgQ6UAU5DKfQ4sp5pUHVlBUx95LGsHo/j5rKKry44YbQMkRbjs/Pj05VcCG2odaXvlyZAdxP8j4e60YieMWtlvEqUVMWK5QGvi68qr2b9yXgUxxZxKjHoOl0Ik3tQxEJwfXVdnCNzUihiJvMtOFNL4Un/mzAxKOvTyq2KIqZUCOtNWOW1LM4j2uu2rwLpF9MwsTK8jDJARtIB+G5nOC/jR2Oo4LkQWBybdbun8v1ohugpO0N5aITBuLONaQAr55yhUvHyMhrjiWrBAfjc/Izmuz02P56qr3LlsAIdRtwSsLoHEBUdeJQFnnq4gBz29yV3MkwRMyzA588kIK1oK0FW/6L7CYCuBbJawfXVfKDjF5pu4N4RGe6ablcN/jlnZ6SAbGrYeS9GaAwURAJqt3PhB9GAEe5L2aHgCUiBaCDDw3Uvlvx1mraBCFX1e5AKpwSgiEIXp9pWnQ6SsOi3O2Cm/OstDhx9akw8WueZ/YtDp1MNo8d5M8i/YHk3tRo9J0OrYHtv7NcdZ5PFpuQls+hpdcIl0R/0Iw8UNIxwZ3dV8P68Umu/hPbQYulSJzulAMa8+lfySFdtUNcZNFP3ERGwnBARa6wubnZ6XVsLHG39zBFUNHxlo47HHxvXnfGz692s4GuvhQJWNJFw+q00UjIQu+lMmnfnIzFc3A7A7FM4DzPX95bYgFFvd/avnrZLSZfbbK5Hkarla2ok3sosdHMVC65g=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(82310400004)(186003)(54906003)(8936002)(110136005)(7696005)(508600001)(36756003)(5660300002)(4326008)(26005)(36860700001)(8676002)(6666004)(336012)(70206006)(47076005)(70586007)(356005)(316002)(426003)(9786002)(2906002)(7636003)(83380400001)(2616005)(107886003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 08:54:41.1612
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b1a2dd8-db45-481f-dc33-08d9b3df0c25
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT017.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB3941
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds zynqmp_pm_sha_hash API in the ZynqMP firmware to compute
SHA3 hash of given data.

Signed-off-by: Harsha <harsha.harsha@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 26 ++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h |  8 ++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 3dd45a7..a84c5ea 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -1117,6 +1117,32 @@ int zynqmp_pm_aes_engine(const u64 address, u32 *out)
 EXPORT_SYMBOL_GPL(zynqmp_pm_aes_engine);
 
 /**
+ * zynqmp_pm_sha_hash - Access the SHA engine to calculate the hash
+ * @address:	Address of the data/ Address of output buffer where
+ *		hash should be stored.
+ * @size:	Size of the data.
+ * @flags:
+ *	BIT(0) - for initializing csudma driver and SHA3(Here address
+ *		 and size inputs can be NULL).
+ *	BIT(1) - to call Sha3_Update API which can be called multiple
+ *		 times when data is not contiguous.
+ *	BIT(2) - to get final hash of the whole updated data.
+ *		 Hash will be overwritten at provided address with
+ *		 48 bytes.
+ *
+ * Return:	Returns status, either success or error code.
+ */
+int zynqmp_pm_sha_hash(const u64 address, const u32 size, const u32 flags)
+{
+	u32 lower_addr = lower_32_bits(address);
+	u32 upper_addr = upper_32_bits(address);
+
+	return zynqmp_pm_invoke_fn(PM_SECURE_SHA, upper_addr, lower_addr,
+				   size, flags, NULL);
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_sha_hash);
+
+/**
  * zynqmp_pm_system_shutdown - PM call to request a system shutdown or restart
  * @type:	Shutdown or restart? 0 for shutdown, 1 for restart
  * @subtype:	Specifies which system should be restarted or shut down
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 47fd4e5..38ef708 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -78,6 +78,7 @@ enum pm_api_id {
 	PM_FPGA_LOAD = 22,
 	PM_FPGA_GET_STATUS = 23,
 	PM_GET_CHIPID = 24,
+	PM_SECURE_SHA = 26,
 	PM_PINCTRL_REQUEST = 28,
 	PM_PINCTRL_RELEASE = 29,
 	PM_PINCTRL_GET_FUNCTION = 30,
@@ -410,6 +411,7 @@ int zynqmp_pm_set_requirement(const u32 node, const u32 capabilities,
 			      const u32 qos,
 			      const enum zynqmp_pm_request_ack ack);
 int zynqmp_pm_aes_engine(const u64 address, u32 *out);
+int zynqmp_pm_sha_hash(const u64 address, const u32 size, const u32 flags);
 int zynqmp_pm_fpga_load(const u64 address, const u32 size, const u32 flags);
 int zynqmp_pm_fpga_get_status(u32 *value);
 int zynqmp_pm_write_ggs(u32 index, u32 value);
@@ -581,6 +583,12 @@ static inline int zynqmp_pm_aes_engine(const u64 address, u32 *out)
 	return -ENODEV;
 }
 
+static inline int zynqmp_pm_sha_hash(const u64 address, const u32 size,
+				     const u32 flags)
+{
+	return -ENODEV;
+}
+
 static inline int zynqmp_pm_fpga_load(const u64 address, const u32 size,
 				      const u32 flags)
 {
-- 
1.8.2.1

