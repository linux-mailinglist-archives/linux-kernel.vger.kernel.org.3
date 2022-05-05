Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B079F51BF31
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 14:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376667AbiEEMY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 08:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357745AbiEEMYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 08:24:54 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F445522C;
        Thu,  5 May 2022 05:21:14 -0700 (PDT)
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KvCQs2wvXzGpJx;
        Thu,  5 May 2022 20:18:29 +0800 (CST)
Received: from dggpeml500008.china.huawei.com (7.185.36.147) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 5 May 2022 20:21:13 +0800
Received: from huawei.com (10.67.175.34) by dggpeml500008.china.huawei.com
 (7.185.36.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 20:21:12 +0800
From:   Ren Zhijie <renzhijie2@huawei.com>
To:     <Shyam-sundar.S-k@amd.com>, <hdegoede@redhat.com>,
        <markgross@kernel.org>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Ren Zhijie" <renzhijie2@huawei.com>
Subject: [PATCH -next] platform/x86: amd-pmc: Fix build error unused-function
Date:   Thu, 5 May 2022 20:19:58 +0800
Message-ID: <20220505121958.138905-1-renzhijie2@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.175.34]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500008.china.huawei.com (7.185.36.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_SUSPEND and CONFIG_DEBUG_FS are not set.

compile error:
drivers/platform/x86/amd-pmc.c:323:12: error: ‘get_metrics_table’ defined but not used [-Werror=unused-function]
 static int get_metrics_table(struct amd_pmc_dev *pdev, struct smu_metrics *table)
            ^~~~~~~~~~~~~~~~~
drivers/platform/x86/amd-pmc.c:298:12: error: ‘amd_pmc_idlemask_read’ defined but not used [-Werror=unused-function]
 static int amd_pmc_idlemask_read(struct amd_pmc_dev *pdev, struct device *dev,
            ^~~~~~~~~~~~~~~~~~~~~
drivers/platform/x86/amd-pmc.c:196:12: error: ‘amd_pmc_get_smu_version’ defined but not used [-Werror=unused-function]
 static int amd_pmc_get_smu_version(struct amd_pmc_dev *dev)
            ^~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

To fix building warning, wrap all related code with CONFIG_SUSPEND or CONFIG_DEBUG_FS.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
---
 drivers/platform/x86/amd-pmc.c | 72 ++++++++++++++++++----------------
 1 file changed, 39 insertions(+), 33 deletions(-)

diff --git a/drivers/platform/x86/amd-pmc.c b/drivers/platform/x86/amd-pmc.c
index 668a1d6c11ee..8f004673b23f 100644
--- a/drivers/platform/x86/amd-pmc.c
+++ b/drivers/platform/x86/amd-pmc.c
@@ -164,7 +164,6 @@ static int amd_pmc_read_stb(struct amd_pmc_dev *dev, u32 *buf);
 #ifdef CONFIG_SUSPEND
 static int amd_pmc_write_stb(struct amd_pmc_dev *dev, u32 data);
 #endif
-static int amd_pmc_setup_smu_logging(struct amd_pmc_dev *dev);
 
 static inline u32 amd_pmc_reg_read(struct amd_pmc_dev *dev, int reg_offset)
 {
@@ -193,6 +192,7 @@ struct smu_metrics {
 	u64 timecondition_notmet_totaltime[SOC_SUBSYSTEM_IP_MAX];
 } __packed;
 
+#ifdef CONFIG_DEBUG_FS
 static int amd_pmc_get_smu_version(struct amd_pmc_dev *dev)
 {
 	int rc;
@@ -212,6 +212,7 @@ static int amd_pmc_get_smu_version(struct amd_pmc_dev *dev)
 
 	return 0;
 }
+#endif /* CONFIG_DEBUG_FS */
 
 static int amd_pmc_stb_debugfs_open(struct inode *inode, struct file *filp)
 {
@@ -295,6 +296,9 @@ static const struct file_operations amd_pmc_stb_debugfs_fops_v2 = {
 	.release = amd_pmc_stb_debugfs_release_v2,
 };
 
+#if defined(CONFIG_SUSPEND) || defined(CONFIG_DEBUG_FS)
+static int amd_pmc_setup_smu_logging(struct amd_pmc_dev *dev);
+
 static int amd_pmc_idlemask_read(struct amd_pmc_dev *pdev, struct device *dev,
 				 struct seq_file *s)
 {
@@ -335,6 +339,40 @@ static int get_metrics_table(struct amd_pmc_dev *pdev, struct smu_metrics *table
 	return 0;
 }
 
+static int amd_pmc_setup_smu_logging(struct amd_pmc_dev *dev)
+{
+	if (dev->cpu_id == AMD_CPU_ID_PCO) {
+		dev_warn_once(dev->dev, "SMU debugging info not supported on this platform\n");
+		return -EINVAL;
+	}
+
+	/* Get Active devices list from SMU */
+	if (!dev->active_ips)
+		amd_pmc_send_cmd(dev, 0, &dev->active_ips, SMU_MSG_GET_SUP_CONSTRAINTS, 1);
+
+	/* Get dram address */
+	if (!dev->smu_virt_addr) {
+		u32 phys_addr_low, phys_addr_hi;
+		u64 smu_phys_addr;
+
+		amd_pmc_send_cmd(dev, 0, &phys_addr_low, SMU_MSG_LOG_GETDRAM_ADDR_LO, 1);
+		amd_pmc_send_cmd(dev, 0, &phys_addr_hi, SMU_MSG_LOG_GETDRAM_ADDR_HI, 1);
+		smu_phys_addr = ((u64)phys_addr_hi << 32 | phys_addr_low);
+
+		dev->smu_virt_addr = devm_ioremap(dev->dev, smu_phys_addr,
+						  sizeof(struct smu_metrics));
+		if (!dev->smu_virt_addr)
+			return -ENOMEM;
+	}
+
+	/* Start the logging */
+	amd_pmc_send_cmd(dev, 0, NULL, SMU_MSG_LOG_RESET, 0);
+	amd_pmc_send_cmd(dev, 0, NULL, SMU_MSG_LOG_START, 0);
+
+	return 0;
+}
+#endif /* CONFIG_SUSPEND || CONFIG_DEBUG_FS */
+
 #ifdef CONFIG_SUSPEND
 static void amd_pmc_validate_deepest(struct amd_pmc_dev *pdev)
 {
@@ -475,38 +513,6 @@ static inline void amd_pmc_dbgfs_unregister(struct amd_pmc_dev *dev)
 }
 #endif /* CONFIG_DEBUG_FS */
 
-static int amd_pmc_setup_smu_logging(struct amd_pmc_dev *dev)
-{
-	if (dev->cpu_id == AMD_CPU_ID_PCO) {
-		dev_warn_once(dev->dev, "SMU debugging info not supported on this platform\n");
-		return -EINVAL;
-	}
-
-	/* Get Active devices list from SMU */
-	if (!dev->active_ips)
-		amd_pmc_send_cmd(dev, 0, &dev->active_ips, SMU_MSG_GET_SUP_CONSTRAINTS, 1);
-
-	/* Get dram address */
-	if (!dev->smu_virt_addr) {
-		u32 phys_addr_low, phys_addr_hi;
-		u64 smu_phys_addr;
-
-		amd_pmc_send_cmd(dev, 0, &phys_addr_low, SMU_MSG_LOG_GETDRAM_ADDR_LO, 1);
-		amd_pmc_send_cmd(dev, 0, &phys_addr_hi, SMU_MSG_LOG_GETDRAM_ADDR_HI, 1);
-		smu_phys_addr = ((u64)phys_addr_hi << 32 | phys_addr_low);
-
-		dev->smu_virt_addr = devm_ioremap(dev->dev, smu_phys_addr,
-						  sizeof(struct smu_metrics));
-		if (!dev->smu_virt_addr)
-			return -ENOMEM;
-	}
-
-	/* Start the logging */
-	amd_pmc_send_cmd(dev, 0, NULL, SMU_MSG_LOG_RESET, 0);
-	amd_pmc_send_cmd(dev, 0, NULL, SMU_MSG_LOG_START, 0);
-
-	return 0;
-}
 
 static void amd_pmc_dump_registers(struct amd_pmc_dev *dev)
 {
-- 
2.17.1

