Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E90508A91
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 16:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379486AbiDTOTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 10:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380253AbiDTOSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 10:18:45 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48E24578D;
        Wed, 20 Apr 2022 07:14:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nng9i5CuUaWMolgJCtAzclqf23mm1ljNFFaKs37pfin81rNqmPjCVy1ux7OZJZirN6Zfr8J9mNwR+Vu+jhj1NMieQcnw3nycdJiTKAXeKVMcBqq8U8cuBYzxEmZJu246GXxb0LpqP5Itb6dp1Fa7HsBPeujbeIGtOQTG5LMGBG8Ju2NUbLs4AXL1NA3cRXiKLgJRLb772O1w/WeFeQcx6JqOYK93DiicY+MjnCROKu7D61nqbD1sx2rfregnx+J2qneLi7h49t+3B2A8x8h5o1IilE9XIqNwoQ0CNzR+CCjk28DbJucIZESeK0oUeG8bauYI7hmNVNSNK1WZWkxFkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XdLEhiTqfCvxSidHdtl/3pGmi2GJNT4acmJALX9x68U=;
 b=hcWN23jT3bjsJvnikoRBF4zfRNb+8P8DLG+PpuaMriLBsJvBTrK9yw3kSOEH+Q5zX9mGKVM2VItOXd27ZAv0TMpV3+praaBjqTOVndXvfW3nx6Cbv6EJU0POCtdQkLuRcqwgvBL05GlOQdMyStKaIvqWo5hqFi71U8O2dVHQYbSf6t1kjIHWqCdanKX+6JUpOHNjkG+repga52+jZqFGswYWHnoWV67KR6xdR4xP1n7LgJ7prw7u7OH1yP1tQ0LQiCqL9YPkqaRxkc6iBRr4YK2IFjQVjuif050nIDu/G0cngcQS/jeGrXjr5afUES49xjZINfwQ5nKiFa2T8wUffw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XdLEhiTqfCvxSidHdtl/3pGmi2GJNT4acmJALX9x68U=;
 b=UKsDylss9MnhNR1nf2IXQHblql9lpirKNjvHQyL2pnJELB5ax36Hw9AZFo97YaH5VLlLN4cRPyM7zKpJL7HkDAZSj/05yI+Xt5AAqITQIJnDyNg9D3WbBZH7IPY9rd319wrduzqqq0rdEoMwnxPvD8VYhnm7HOvsV3gWUzHC30M=
Received: from MW4PR03CA0164.namprd03.prod.outlook.com (2603:10b6:303:8d::19)
 by MN2PR12MB4014.namprd12.prod.outlook.com (2603:10b6:208:16d::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Wed, 20 Apr
 2022 14:14:37 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::5a) by MW4PR03CA0164.outlook.office365.com
 (2603:10b6:303:8d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Wed, 20 Apr 2022 14:14:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Wed, 20 Apr 2022 14:14:36 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 20 Apr
 2022 09:14:33 -0500
From:   Tom Lendacky <thomas.lendacky@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-doc@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Joerg Roedel <jroedel@suse.de>,
        "Michael Roth" <michael.roth@amd.com>
Subject: [PATCH 1/2] virt: sevguest: Change driver name to reflect generic SEV support
Date:   Wed, 20 Apr 2022 09:14:13 -0500
Message-ID: <307710bb5515c9088a19fd0b930268c7300479b2.1650464054.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650464054.git.thomas.lendacky@amd.com>
References: <cover.1650464054.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88c96bfa-04a9-456f-7eb4-08da22d81a03
X-MS-TrafficTypeDiagnostic: MN2PR12MB4014:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB40140E09B781E2D0FDF1FCCEECF59@MN2PR12MB4014.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2x7zTrZTGbtjVcjeWTKxArt6m4+hJABkCnOG2T1NNNsAdJZuD479nQlFGplcjHr1z9Q6Wvbq3TakVhSy+TIpcmxBrk9JXszKDCdcAJO494qOJRMjm2XSSdhrBA5gZkCEvuVXYEXheTmvbHKLwk5aHM4OqQAnMofWQXS5/bBPX7UspB4n5KAaW0DADh6V7uJcghajyhRZ/5prhdKoE407f3pHwuWKnb/3zdzzRirW4Hg/Q95aofb1od8igG4n/1dEeR805/+ZQAEwtUmmBxDyzBpnvqe1dRcb53KfuaIsZ+fdDHg83WTmR8qPBSgbZcUiN97B6fF79ngJG7t3LLmYQzQ9WapWcyNpxAWUDiCL9KK4Tb/8tDFNUCIusIswMU7+HpdIrepJD1p7q+jiC7Yvz3LAZJHgZRi0YJTOwX1qWqpQ0aTnPsWwKbjaN0TeWURMcj7FrC0CTQyycwF1J4QJDiYUM+sAZifBKMfzKXDiwZDof0ofVTst/shptpwtPkxYEKFt+JRYN1YRiXwNXUp38eKJk4kuB/Z+yLl0V5OrI0snbafCv0cFuN8BUEPTsUMN8D4d6pOKs+mIUK3u3wKfLwCndo2HmTn/fpYMZvQu1iDij/08+sek/mQBwL0pIQTvgi/HBydS228UX700cj962P5CjhxyxqVf51J2EcIFfhr9Iz12s+ldU7hAlkCTAeZTwfnqxWkzOOvChmWlaTgE8Ljn+R8B+SZT2W8gFT2kI00=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(508600001)(70206006)(8936002)(6666004)(2906002)(36860700001)(70586007)(7696005)(356005)(81166007)(16526019)(316002)(83380400001)(26005)(47076005)(186003)(426003)(336012)(5660300002)(2616005)(4326008)(8676002)(36756003)(86362001)(54906003)(82310400005)(110136005)(40460700003)(41533002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 14:14:36.9344
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c96bfa-04a9-456f-7eb4-08da22d81a03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4014
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During patch review, it was decided the SNP guest driver name should not
be SEV-SNP specific, but should be generic for use with anything SEV.
However, this feedback was missed and the driver name, and many of the
driver functions and structures, are SEV-SNP name specific. Rename the
driver to "sev-guest" (to match the misc device that is created) and
update some of the function and structure names, too.

While in the file, adjust the one pr_err() message to be a dev_err()
message so that the message, if issued, uses the driver name.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/include/asm/sev.h            |  2 +-
 arch/x86/kernel/sev.c                 | 10 +++----
 drivers/virt/coco/sevguest/sevguest.c | 39 ++++++++++++++-------------
 3 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 9c2d33f1cfee..6e3dda4f82b5 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -95,7 +95,7 @@ struct snp_req_data {
 	unsigned int data_npages;
 };
 
-struct snp_guest_platform_data {
+struct sev_guest_platform_data {
 	u64 secrets_gpa;
 };
 
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index f01f4550e2c6..2fa87a07ab30 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -2166,8 +2166,8 @@ int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned
 }
 EXPORT_SYMBOL_GPL(snp_issue_guest_request);
 
-static struct platform_device guest_req_device = {
-	.name		= "snp-guest",
+static struct platform_device sev_guest_device = {
+	.name		= "sev-guest",
 	.id		= -1,
 };
 
@@ -2197,7 +2197,7 @@ static u64 get_secrets_page(void)
 
 static int __init snp_init_platform_device(void)
 {
-	struct snp_guest_platform_data data;
+	struct sev_guest_platform_data data;
 	u64 gpa;
 
 	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
@@ -2208,10 +2208,10 @@ static int __init snp_init_platform_device(void)
 		return -ENODEV;
 
 	data.secrets_gpa = gpa;
-	if (platform_device_add_data(&guest_req_device, &data, sizeof(data)))
+	if (platform_device_add_data(&sev_guest_device, &data, sizeof(data)))
 		return -ENODEV;
 
-	if (platform_device_register(&guest_req_device))
+	if (platform_device_register(&sev_guest_device))
 		return -ENODEV;
 
 	pr_info("SNP guest platform device initialized.\n");
diff --git a/drivers/virt/coco/sevguest/sevguest.c b/drivers/virt/coco/sevguest/sevguest.c
index aaa6134d1d40..f3b93bd92f2f 100644
--- a/drivers/virt/coco/sevguest/sevguest.c
+++ b/drivers/virt/coco/sevguest/sevguest.c
@@ -1,14 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * AMD Secure Encrypted Virtualization Nested Paging (SEV-SNP) guest request interface
+ * AMD Secure Encrypted Virtualization (SEV) guest driver interface
  *
  * Copyright (C) 2021 Advanced Micro Devices, Inc.
  *
  * Author: Brijesh Singh <brijesh.singh@amd.com>
  */
 
-#define pr_fmt(fmt) "SNP: GUEST: " fmt
-
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
@@ -574,7 +572,7 @@ static void free_shared_pages(void *buf, size_t sz)
 	__free_pages(virt_to_page(buf), get_order(sz));
 }
 
-static void *alloc_shared_pages(size_t sz)
+static void *alloc_shared_pages(struct device *dev, size_t sz)
 {
 	unsigned int npages = PAGE_ALIGN(sz) >> PAGE_SHIFT;
 	struct page *page;
@@ -586,7 +584,7 @@ static void *alloc_shared_pages(size_t sz)
 
 	ret = set_memory_decrypted((unsigned long)page_address(page), npages);
 	if (ret) {
-		pr_err("failed to mark page shared, ret=%d\n", ret);
+		dev_err(dev, "failed to mark page shared, ret=%d\n", ret);
 		__free_pages(page, get_order(sz));
 		return NULL;
 	}
@@ -627,10 +625,10 @@ static u8 *get_vmpck(int id, struct snp_secrets_page_layout *layout, u32 **seqno
 	return key;
 }
 
-static int __init snp_guest_probe(struct platform_device *pdev)
+static int __init sev_guest_probe(struct platform_device *pdev)
 {
 	struct snp_secrets_page_layout *layout;
-	struct snp_guest_platform_data *data;
+	struct sev_guest_platform_data *data;
 	struct device *dev = &pdev->dev;
 	struct snp_guest_dev *snp_dev;
 	struct miscdevice *misc;
@@ -639,7 +637,7 @@ static int __init snp_guest_probe(struct platform_device *pdev)
 	if (!dev->platform_data)
 		return -ENODEV;
 
-	data = (struct snp_guest_platform_data *)dev->platform_data;
+	data = (struct sev_guest_platform_data *)dev->platform_data;
 	layout = (__force void *)ioremap_encrypted(data->secrets_gpa, PAGE_SIZE);
 	if (!layout)
 		return -ENODEV;
@@ -667,15 +665,15 @@ static int __init snp_guest_probe(struct platform_device *pdev)
 	snp_dev->layout = layout;
 
 	/* Allocate the shared page used for the request and response message. */
-	snp_dev->request = alloc_shared_pages(sizeof(struct snp_guest_msg));
+	snp_dev->request = alloc_shared_pages(dev, sizeof(struct snp_guest_msg));
 	if (!snp_dev->request)
 		goto e_unmap;
 
-	snp_dev->response = alloc_shared_pages(sizeof(struct snp_guest_msg));
+	snp_dev->response = alloc_shared_pages(dev, sizeof(struct snp_guest_msg));
 	if (!snp_dev->response)
 		goto e_free_request;
 
-	snp_dev->certs_data = alloc_shared_pages(SEV_FW_BLOB_MAX_SIZE);
+	snp_dev->certs_data = alloc_shared_pages(dev, SEV_FW_BLOB_MAX_SIZE);
 	if (!snp_dev->certs_data)
 		goto e_free_response;
 
@@ -698,7 +696,7 @@ static int __init snp_guest_probe(struct platform_device *pdev)
 	if (ret)
 		goto e_free_cert_data;
 
-	dev_info(dev, "Initialized SNP guest driver (using vmpck_id %d)\n", vmpck_id);
+	dev_info(dev, "Initialized SEV guest driver (using vmpck_id %d)\n", vmpck_id);
 	return 0;
 
 e_free_cert_data:
@@ -712,7 +710,7 @@ static int __init snp_guest_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __exit snp_guest_remove(struct platform_device *pdev)
+static int __exit sev_guest_remove(struct platform_device *pdev)
 {
 	struct snp_guest_dev *snp_dev = platform_get_drvdata(pdev);
 
@@ -725,16 +723,21 @@ static int __exit snp_guest_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_driver snp_guest_driver = {
-	.remove		= __exit_p(snp_guest_remove),
+/*
+ * This driver is a common SEV guest interface driver and meant to support
+ * any SEV guest API. As such, even though it has been introduced along with
+ * the SEV-SNP support, it is named "sev-guest".
+ */
+static struct platform_driver sev_guest_driver = {
+	.remove		= __exit_p(sev_guest_remove),
 	.driver		= {
-		.name = "snp-guest",
+		.name = "sev-guest",
 	},
 };
 
-module_platform_driver_probe(snp_guest_driver, snp_guest_probe);
+module_platform_driver_probe(sev_guest_driver, sev_guest_probe);
 
 MODULE_AUTHOR("Brijesh Singh <brijesh.singh@amd.com>");
 MODULE_LICENSE("GPL");
 MODULE_VERSION("1.0.0");
-MODULE_DESCRIPTION("AMD SNP Guest Driver");
+MODULE_DESCRIPTION("AMD SEV Guest Driver");
-- 
2.34.1

