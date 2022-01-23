Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 197794970C6
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 10:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235610AbiAWJsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 04:48:13 -0500
Received: from mail-dm6nam11on2047.outbound.protection.outlook.com ([40.107.223.47]:2848
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231782AbiAWJsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 04:48:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/GEVEvxfKkUN1tFCqzpbqDUsHCLha/O7AwtKaFpXE+rDwQ5ekTQygc5qGAVEfZAhSJfcjSBH0yn8mgzDQS5Y/8nWg96E6v3O6LB9IMW7x6motMUK0UxrFVq9l9N0miDGW2VSIFUGGog7h0iCkZH9k+9xJSpwvheqSlv+lLyBebP2JxPComkS1GhlzS2E7wQqTe9J9mwrGdtkUCJaLvmQuyreEbUZUoV8SulmTUjvA3KZAHS0njQZj9RfwKsWGgnAyr6+EN1sPhqus4wzV/CkLvOlWyitVm5dChcRYYnWvqnW3pmyoaUj/jE6+8c+6TUHCaE15DBh7LvM5WV1k5oww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8KsoEK/E5flaUtXpeiB1VxfXCpdMm2TkAxCfqtb1SQ=;
 b=jbf7aDfoFXmXkUHBhHPzYQqU3IWl48F56HwwOTw631Ux2r65AYiqloTDc7v1GQslIFUnH7UfqHnj8QFhCM16EaBHJ0ooD8/XeOEC0eQmSTkSVN9216pbln9UIDQBAe4Hvmj9+/ldFjJpcMVghdLSl9sX4N1hzRsnsv3yboZFgehJq3b+AkJRI/m4rAbIuWjMwVZHuVQsQ/lDzD8Yp6ldPqEf9B4pNWrwA5hNfHhlWvqLjT5dIt9NjL4WzvgQqXxIi63cX1ptLM5yz76fMYdHxkTusocqRW2yWTmzKGEutgUN0ABaeLGZpjUWmZ8PjiT5YNif9LtmIz/fuCsAIF5yHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=gondor.apana.org.au
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8KsoEK/E5flaUtXpeiB1VxfXCpdMm2TkAxCfqtb1SQ=;
 b=TILBZvcH8eOMqosWUQaqWIACbib/g2t1cxnhuQpVg51LTIvDpr2JVx4FN7litG56oa/hbZNmg/JyYUaCUgajJUZKugOZ3l5CKnFaORZH1JrrBLyrCYyJphmIGNIDmWdl2hbOmjjzlrWr0Eusxd0t+y5tMwAFUy+uQCAL0lmX0oE=
Received: from BN6PR19CA0076.namprd19.prod.outlook.com (2603:10b6:404:133::14)
 by CH2PR02MB6327.namprd02.prod.outlook.com (2603:10b6:610:b::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Sun, 23 Jan
 2022 09:48:09 +0000
Received: from BN1NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2603:10b6:404:133:cafe::c8) by BN6PR19CA0076.outlook.office365.com
 (2603:10b6:404:133::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.15 via Frontend
 Transport; Sun, 23 Jan 2022 09:48:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT040.mail.protection.outlook.com (10.13.2.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.8 via Frontend Transport; Sun, 23 Jan 2022 09:48:08 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sun, 23 Jan 2022 01:47:51 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sun, 23 Jan 2022 01:47:51 -0800
Envelope-to: git@xilinx.com,
 herbert@gondor.apana.org.au,
 davem@davemloft.net,
 linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 robh+dt@kernel.org,
 devicetree@vger.kernel.org
Received: from [10.140.6.15] (port=60078 helo=xhdharshah40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <harsha.harsha@xilinx.com>)
        id 1nBZTS-0001bj-Fc; Sun, 23 Jan 2022 01:47:50 -0800
From:   Harsha <harsha.harsha@xilinx.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michals@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <saratcha@xilinx.com>, <harshj@xilinx.com>, <git@xilinx.com>,
        Harsha <harsha.harsha@xilinx.com>
Subject: [PATCH 2/4] firmware: xilinx: Add ZynqMP SHA API for SHA3 functionality
Date:   Sun, 23 Jan 2022 15:17:05 +0530
Message-ID: <1642931227-20706-3-git-send-email-harsha.harsha@xilinx.com>
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1642931227-20706-1-git-send-email-harsha.harsha@xilinx.com>
References: <1642931227-20706-1-git-send-email-harsha.harsha@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76f377bd-a7f3-4c83-8c45-08d9de5575ed
X-MS-TrafficTypeDiagnostic: CH2PR02MB6327:EE_
X-Microsoft-Antispam-PRVS: <CH2PR02MB6327F4EFAC243BBB9CADD6C7DE5D9@CH2PR02MB6327.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hPC+CCLpxwUOjmDVsMqnyYeVzy79zcDYApiCgVcDrONwg7WfXbmZDBZDQMVEQOsQbh3a5FaJcSPB46CJ3wpHuPKOWGg7/znonUX54mYsRYxH6zBRcZALtsigIY6fJ2aMIdyYXOJ/VpBVC7K3GZDGZCxN+AtzhEFMpfD4fjttYFwFrkI3zngquQl1kILvq+SmXF5tcCaPDDRvpNVS6hZj5RpyXlvSYCVlpIo/hWDOFJlc68M9A63SwJxQ6WywJzBIsZZuEvxcoKOOe37coHIuCprXalT1vh52xvGT7qmAZOb4AHT24QeHSMlYVbfUOAMqfwdC0iTbZtf3BQbvOqrMMH+sCrURQ+RRCBsSaFCZw4iyB0pSP2X3sail0GxX4DkzKDbmIdxx/NN3MADsFnj/DJirgaOqnrZgNun4lcp/ZGuqKpcc+7XnoJBrHLb3DqNeDTS5d8ZJLRNUSXEl1RI0x1zfOBKR73QgRtKRwqXTuxSv4FYUDBMf67qJzXBoXsv2GJio/Q0NGTv3H74R63FKSHg7pRYbgVkOwP3gptFTnkWqPH8zbeVc79nfgLCv0MYBLGd6kUNKk1k5qLjpRBjaX0Rl9K7xpkeJYEW5QCL0/ja3JSp6SQP/m9rBSYRu4J3xmrVuvxKHtqzHDCpn8hAyy0J019AP4m1ePLbh6ijH8t2mcIeDS5HscHli0o/Hx6O9MM0h9JGKwZePtel8qE6jJfnizfUsw1h/LQLbNZTk4Co=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(316002)(36756003)(9786002)(336012)(508600001)(4326008)(426003)(2616005)(2906002)(110136005)(54906003)(6666004)(83380400001)(356005)(26005)(8936002)(7696005)(7636003)(82310400004)(5660300002)(36860700001)(186003)(70206006)(107886003)(70586007)(47076005)(8676002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2022 09:48:08.0318
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f377bd-a7f3-4c83-8c45-08d9de5575ed
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT040.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6327
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

