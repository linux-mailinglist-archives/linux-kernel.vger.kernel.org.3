Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0AE84C1068
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 11:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239666AbiBWKhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 05:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239655AbiBWKhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 05:37:09 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE230E5D;
        Wed, 23 Feb 2022 02:36:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FI5fVhv1vb+YH1jr74r/P8XkjaLoEDgwIMLfjPZNhcVfEyIAqsRgL+PNrolSrHPKhfOjfy3m1GMNADwWXOXb4FdtX+B5Ir1XMA4PmIu3olNaCX/jBpGs8tDTDhHtmVXUTxLOWpwUdrpOooho47ruhO9ask9huB1RaH+OQzc0ZpiHQ4pHdPv66KjX87iUyuxoJO29qpPRy6l7SVXen4YtKaqlGLV6fYVQGkbhb+9pbmYAmSEZKliasvGE/TvLY4eQUwtpBOVpcV/jojcw1C7N2rbx5SVEhflWjNr6lv6SS0wam4mXosxuvd3fddlm7XLighTJB3gcsfzfGjQpeU698w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iesuiAStf30v7Om+Zg1GH18yuu4r297DtzwmI7SrjeE=;
 b=YohsMB9VblWXnx+x+Rb1A6ipbgsI4mMmiGMVUIfjYpacOFVqVqIKzd86ZBVBEU5t1KZooyjYpK3GisfmCVoh7kEed7wDGmIeOQnZsfTmDIvRYHfVU7v/8ja0aTc5s1IQIL0z+u8eKOfIGg0NP3xXL5kMY1KxCIG3ZzyuvL3VG8BZGNsho4HAgzkAZsns12y4ZCOUsM9JEAZ2faw4Qq9bG+8aGIe0p7q137kwL07dP0MIZ3fKfSgSvkW1l7eW6EExCID0u/BOUXelJw9nhmKXc6fIcqICG2fsh8p4+vt7EF9iOZic9h/3F5hvOVh6qdyMhgOo7JV2pgA6PtXEVtvJQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=gondor.apana.org.au
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iesuiAStf30v7Om+Zg1GH18yuu4r297DtzwmI7SrjeE=;
 b=Y+ZOzh6H7ZB6hDNhjWz/SwwJZrjVEOIdkjMK69PaDs3NrUoMCoHdI1AO4Wb4YCvR6e1JNqlBOS1l7CwRjgzr8/Cp0ok26u4GxgpN4pgFHxJ/HOqB1Dg+D4xf/CuzKfUk4bqU9tUL2Mlt/V9oYWTjbzlOdRIp/Az1cYGB5PfIzrQ=
Received: from BN9PR03CA0633.namprd03.prod.outlook.com (2603:10b6:408:13b::8)
 by BYAPR02MB4405.namprd02.prod.outlook.com (2603:10b6:a03:57::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Wed, 23 Feb
 2022 10:36:36 +0000
Received: from BN1NAM02FT054.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::ef) by BN9PR03CA0633.outlook.office365.com
 (2603:10b6:408:13b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Wed, 23 Feb 2022 10:36:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT054.mail.protection.outlook.com (10.13.2.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Wed, 23 Feb 2022 10:36:35 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 23 Feb 2022 02:36:09 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 23 Feb 2022 02:36:09 -0800
Envelope-to: git@xilinx.com,
 herbert@gondor.apana.org.au,
 davem@davemloft.net,
 linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [10.140.6.15] (port=60324 helo=xhdharshah40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <harsha.harsha@xilinx.com>)
        id 1nMp0D-0000KH-1a; Wed, 23 Feb 2022 02:36:09 -0800
From:   Harsha <harsha.harsha@xilinx.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <michals@xilinx.com>
CC:     <saratcha@xilinx.com>, <harshj@xilinx.com>, <git@xilinx.com>,
        Harsha <harsha.harsha@xilinx.com>,
        Kalyani Akula <kalyani.akula@xilinx.com>
Subject: [PATCH V3 2/4] firmware: xilinx: Add ZynqMP SHA API for SHA3 functionality
Date:   Wed, 23 Feb 2022 16:05:02 +0530
Message-ID: <1645612504-3047-3-git-send-email-harsha.harsha@xilinx.com>
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1645612504-3047-1-git-send-email-harsha.harsha@xilinx.com>
References: <1645612504-3047-1-git-send-email-harsha.harsha@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df930b8f-6240-43b2-fba9-08d9f6b85dac
X-MS-TrafficTypeDiagnostic: BYAPR02MB4405:EE_
X-Microsoft-Antispam-PRVS: <BYAPR02MB4405E30CCAB629FDE121AD9BDE3C9@BYAPR02MB4405.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Q11f4ciH+krWO6tMsvl7rFGZjkTc/FOoA1SVYRTcgw7PfWHmxnKFJhlBjyJXkQIg/wtel+4SARcyXflz2mrEba6dtvtWpV6F3bJQFnKZs5Ybv+88/cvZ05535Y4qZRuE6eEArI6+gEcaQnSWIqDVKbHUg+xbdgWY3AC5O1yP27OQihjYsEippYZusNg9AxXuGgvRDn4Zk/YnabSSNYoMTqV5Ci5UgCZLrWNp5aOGmnu3NdbG+3shaiCt5lemqn0XMYd2tLnP0NAhBt/XemlSgYElwVyvI2iB++VtIr2fsSpSOwudFM76yX0gceTdg588HoJ/UwueafSdaOOO8vPMIVbmJpSv5SMxkabL7p+nNSi44Z+ZTBjmzUoXLXE7NT1Dm9r8/TziPiCna7bkKfjI1ivD0v6yRsYiBsl5J2MvtR5VTAGyIaacAhCfNRXonVWMNyEi9xzD+wHR6pIGeuVnOQJCMNmx12Ywd2zOVYFSHdSiVDxitItm8YzLTIpcKzza0X3SvwJVY4BKwrzDwZP0x+LLVzRd3fQ39ij+vGPiIQTlGFQON3ap+4W/dpK17THCBfaIw8vUrEPF4kg+OVQjw1cbO/BGg9RbSEIyvr5cHYEaZzbSk8wMgnVLvZY1kxAp1tQTSYcTm6Onjzak3wbU0uZGmpU3qLZuCZSwC/RqcZRRF4xIEAAEbMpVw9tzdrncilsKh/+GU/DvJsOoggwrrEoH8MlHK9lSeBvyU2V86I=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(4326008)(70586007)(8676002)(7636003)(316002)(2616005)(107886003)(70206006)(186003)(26005)(508600001)(82310400004)(356005)(426003)(110136005)(54906003)(2906002)(40460700003)(6636002)(7696005)(8936002)(47076005)(36860700001)(36756003)(9786002)(83380400001)(336012)(6666004)(5660300002)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 10:36:35.4106
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df930b8f-6240-43b2-fba9-08d9f6b85dac
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT054.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4405
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds zynqmp_pm_sha_hash API in the ZynqMP firmware to compute
SHA3 hash of given data.

Signed-off-by: Harsha <harsha.harsha@xilinx.com>
Signed-off-by: Kalyani Akula <kalyani.akula@xilinx.com>
Acked-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 26 ++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h |  8 ++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 450c5f6..5e5b0bb 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -1121,6 +1121,32 @@ int zynqmp_pm_aes_engine(const u64 address, u32 *out)
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
  * zynqmp_pm_register_notifier() - PM API for register a subsystem
  *                                to be notified about specific
  *                                event/error.
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 907cb01..f6783f5 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -93,6 +93,7 @@ enum pm_api_id {
 	PM_FPGA_LOAD = 22,
 	PM_FPGA_GET_STATUS = 23,
 	PM_GET_CHIPID = 24,
+	PM_SECURE_SHA = 26,
 	PM_PINCTRL_REQUEST = 28,
 	PM_PINCTRL_RELEASE = 29,
 	PM_PINCTRL_GET_FUNCTION = 30,
@@ -427,6 +428,7 @@ int zynqmp_pm_set_requirement(const u32 node, const u32 capabilities,
 			      const u32 qos,
 			      const enum zynqmp_pm_request_ack ack);
 int zynqmp_pm_aes_engine(const u64 address, u32 *out);
+int zynqmp_pm_sha_hash(const u64 address, const u32 size, const u32 flags);
 int zynqmp_pm_fpga_load(const u64 address, const u32 size, const u32 flags);
 int zynqmp_pm_fpga_get_status(u32 *value);
 int zynqmp_pm_write_ggs(u32 index, u32 value);
@@ -601,6 +603,12 @@ static inline int zynqmp_pm_aes_engine(const u64 address, u32 *out)
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

