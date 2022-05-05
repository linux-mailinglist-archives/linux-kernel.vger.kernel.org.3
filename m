Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5102A51C5CB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 19:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382630AbiEERLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382498AbiEERLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:11:06 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377F15C873;
        Thu,  5 May 2022 10:07:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7jFEzwDtyfN4SrQnsOKsi6dpHkJzrBy7FjGg/8nLqcjHfLbrSp1fFOfotMfXPVM9CUTVYIFYXw1BTZ1HP/KNaqyhXnYwvSOy8LmUApAp59orPc3TAjdg3VLZEHuXozjz2qdXu2thxU6bLoLcdCq8VV+v/p4i/B/oGj0UbmPqT3rPLCPvdeJibbLT5J9NywE7Jv4/YMbKaGy9iqvH0UK++1qb3bmWS8he2Iy2o+Uvy6AplIIFCG26P0f4Z5JDyFtuWhbIyBqD6Q6WMEoeEDpFX9MPT7TV+3kPz52To+zQwJ1hBD4dlM5DedG7IID1L3t9WkQUef+5WRWIrmBk8vkGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6GprxFpY+53Fvk0mpbTr6uOP07AMOxMbJsXQGySSqro=;
 b=BeZWr+VH8nj66xBA/kqLrPqS44hHceFKhNW741EiFYCwvY5n3rIBc9+w+gT1i3Q67AMz8Cy3mGfRaxPZJspynZAPm+AP7gdOXAZNtCoDeU98dsDj+qBWAgGSbkzvzxO/fAarbNLrylkJEBKTso9eAQzMSFA7rdSQ3gkCQVrimsz2cuuerUzskF4FdX2qdvynei1TwYQ0o/ziKiAM+jTv+AlxJzIwD7+QUrIGSccL5Vp8nL7y2KtXpnJgsIJPQnYU2mlEX0tu4YMfnzRqJ8hVBvHJpkTbdx+sArH4hXf7jxfBmbrDUPEDQKyvIsOrFv/JedVTCqsUeYiKV4VKlh3c2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GprxFpY+53Fvk0mpbTr6uOP07AMOxMbJsXQGySSqro=;
 b=i8aIkvIpPZEt2lxXz/+H5csnsshnrmNG/cB4W5NMlIsZ/JCHnBZW2YfoT1IXumd0R20UBNj7qdyS92KL0iAhYBxbdQvaU5/1Lw41zSZECzUQ/82T1OQiQOxoGGjEKBhbZcf4wyTOReVh7EtVa25uHoWvGHSIjvVNTCKzFS0qCOmKaSW4ZVjNgg7hVS/ZwOVTM6CN/Z9DkWYFAmRqzWIWBqdNoMKKVqtWAMALxHJ4O2a5BjiIDMe9ueVi/2mmWy5GrlqA6vXijUv+DPJTKInt5aCUWTvZOo34h8oYMN6wuK1PmJ4xiEkK3MTDQQNUP6+qIbFxy003EjvW+hvB+qGuaw==
Received: from MW4P222CA0006.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::11)
 by BL1PR12MB5969.namprd12.prod.outlook.com (2603:10b6:208:398::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Thu, 5 May
 2022 17:07:17 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::5f) by MW4P222CA0006.outlook.office365.com
 (2603:10b6:303:114::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Thu, 5 May 2022 17:07:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 17:07:16 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL109.nvidia.com (10.27.9.19) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Thu, 5 May 2022 17:07:15 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 5 May 2022 10:07:15 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Thu, 5 May 2022 10:07:12 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <kbuild-all@lists.01.org>
CC:     <sumitg@nvidia.com>, <bbasu@nvidia.com>, <vsethi@nvidia.com>,
        <jsequeira@nvidia.com>
Subject: [Patch v4 9/9] soc: tegra: cbb: Add support for tegra-grace SOC
Date:   Thu, 5 May 2022 22:36:37 +0530
Message-ID: <20220505170637.26538-10-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220505170637.26538-1-sumitg@nvidia.com>
References: <20220505170637.26538-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d459f75-ab44-452c-353f-08da2eb9b4cf
X-MS-TrafficTypeDiagnostic: BL1PR12MB5969:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB59691C5D74C0AAE7E12570D4B9C29@BL1PR12MB5969.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y54uyi15CxPBaQ6rgVy2YSS6wh/kCLC62cFb/gj7nI5c8A1DLYHFPjm2SDI6bk76ukw7PFZMtX0Zg3sPOyqZlRMaLrDe2+MtQcZ6MIXo4LLzCluRy7uLx4Ay8ZkIT5mX7Bcr8+b0et/Cqs7lGIbUopBpLepH3T7k2Bel0Mw3+Gf5MIfSAVBZ/N6sT1nQkJpc3aOwE7OEQ337VwJ7FqzcjL8lS8CwHpFPmtT3dPWMvy4Pt6yuM9VgVJcPX8J30jTJnec7VrBnaEz/2YSZCQ95n9KKcRVFAi/YsvIkF+wCDnAMl+gXpveI8yCWoLjfs8pi5i87DZcQqLQbaFUwfnxGESzXtH5KGmMT2NjrHsy1CNtwtSty0G7618WBM8qihuQjrsDW7ZjtWZxkvsfsfO1k8dbe72I6uRlKFpZlAhjhbXFYO2mT+femNKdjCNJ1ekJQRhPoJFb2fEtXHaYAinDHXPhaWQOc2RRpnHCbtLVOIZ97fqtsuwtJ9fn2lcZJVIlRcWA/qRALB0GmnIbE9PgRl/4mZirrdzMe0sGlP/OR+mMSVWaDpwlxuw89idYu3a7wWfJWB9fZUgxbSdRLZS5paIILKL7I7SkV1toiwSDPp+nsNzO2Ht7KN2zqh8LnuQQ8xW1HzN7Ti28lHCZrh1IShqnHnmYohnDAOkf0SKPZVHMkCaqzy6LcZc/r9t5UpqvwGAtKbT0DoHgkyzKXgmatxQ==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(2906002)(26005)(86362001)(508600001)(8936002)(356005)(30864003)(36756003)(6666004)(7696005)(5660300002)(107886003)(81166007)(4326008)(70206006)(70586007)(83380400001)(40460700003)(47076005)(336012)(426003)(1076003)(186003)(316002)(54906003)(110136005)(36860700001)(2616005)(82310400005)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 17:07:16.2090
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d459f75-ab44-452c-353f-08da2eb9b4cf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5969
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding support for Tegra Grace SOC which uses CBB2.0 architecture
based fabrics. Also, adding ACPI support required for Grace.
Fabrics reporting errors in Grace are "CBB Fabric" and "BPMP Fabric".
"CBB Fabric" connects various other CBB2.0 based fabrics and also
services the Initiators and Targets which are connected to itself.
"BPMP Fabric" is present in BPMP cluster.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/soc/tegra/cbb/tegra234-cbb.c |  90 ++++++++++-
 include/soc/tegra/tegra-grace-cbb.h  | 219 +++++++++++++++++++++++++++
 2 files changed, 308 insertions(+), 1 deletion(-)
 create mode 100644 include/soc/tegra/tegra-grace-cbb.h

diff --git a/drivers/soc/tegra/cbb/tegra234-cbb.c b/drivers/soc/tegra/cbb/tegra234-cbb.c
index 782d28e50ca1..1889331ddb22 100644
--- a/drivers/soc/tegra/cbb/tegra234-cbb.c
+++ b/drivers/soc/tegra/cbb/tegra234-cbb.c
@@ -11,6 +11,7 @@
  */
 
 #include <asm/cpufeature.h>
+#include <linux/acpi.h>
 #include <linux/clk.h>
 #include <linux/debugfs.h>
 #include <linux/module.h>
@@ -27,6 +28,7 @@
 #include <soc/tegra/fuse.h>
 #include <soc/tegra/tegra-cbb.h>
 #include <soc/tegra/tegra234-cbb.h>
+#include <soc/tegra/tegra-grace-cbb.h>
 
 static LIST_HEAD(cbb_errmon_list);
 static DEFINE_SPINLOCK(cbb_errmon_lock);
@@ -258,14 +260,33 @@ static void print_errlog_err(struct seq_file *file, struct tegra_cbb_errmon_reco
 	u8 cache_type = 0, prot_type = 0, burst_length = 0;
 	u8 mstr_id = 0, grpsec = 0, vqc = 0, falconsec = 0;
 	u8 beat_size = 0, access_type = 0, access_id = 0;
+	u8 requester_socket_id = 0, local_socket_id = 0;
 	u8 slave_id = 0, fab_id = 0, burst_type = 0;
 	char fabric_name[20];
+	bool is_numa = 0;
+
+	if (num_possible_nodes() > 1)
+		is_numa = true;
 
 	mstr_id   = FIELD_GET(FAB_EM_EL_MSTRID, errmon->mn_user_bits);
 	vqc	  = FIELD_GET(FAB_EM_EL_VQC, errmon->mn_user_bits);
 	grpsec	  = FIELD_GET(FAB_EM_EL_GRPSEC, errmon->mn_user_bits);
 	falconsec = FIELD_GET(FAB_EM_EL_FALCONSEC, errmon->mn_user_bits);
 
+	/*
+	 * For SOC with multiple NUMA nodes, print cross socket access
+	 * errors only if initiator/master_id is CCPLEX, CPMU or GPU.
+	 */
+	if (is_numa) {
+		local_socket_id = numa_node_id();
+		requester_socket_id = FIELD_GET(REQ_SOCKET_ID, errmon->mn_attr2);
+
+		if (requester_socket_id != local_socket_id) {
+			if ((mstr_id != 0x1) && (mstr_id != 0x2) && (mstr_id != 0xB))
+				return;
+		}
+	}
+
 	fab_id	   = FIELD_GET(FAB_EM_EL_FABID, errmon->mn_attr2);
 	slave_id   = FIELD_GET(FAB_EM_EL_SLAVEID, errmon->mn_attr2);
 
@@ -298,6 +319,15 @@ static void print_errlog_err(struct seq_file *file, struct tegra_cbb_errmon_reco
 	else
 		strcpy(fabric_name, errmon->name);
 
+	if (is_numa) {
+		tegra_cbb_print_err(file, "\t  Requester_Socket_Id\t: 0x%x\n",
+				    requester_socket_id);
+		tegra_cbb_print_err(file, "\t  Local_Socket_Id\t: 0x%x\n",
+				    local_socket_id);
+		tegra_cbb_print_err(file, "\t  No. of NUMA_NODES\t: 0x%x\n",
+				    num_possible_nodes());
+	}
+
 	tegra_cbb_print_err(file, "\t  Fabric\t\t: %s\n", fabric_name);
 	tegra_cbb_print_err(file, "\t  Slave_Id\t\t: 0x%x\n", slave_id);
 	tegra_cbb_print_err(file, "\t  Burst_length\t\t: 0x%x\n", burst_length);
@@ -585,6 +615,23 @@ static struct tegra_cbb_fabric_data tegra234_sce_fab_data = {
 	.err_notifier_base = 0x19000
 };
 
+static struct tegra_cbb_fabric_data tegra_grace_cbb_fab_data = {
+	.name   = "cbb-fabric",
+	.tegra_cbb_master_id = tegra_grace_master_id,
+	.sn_addr_map = tegra_grace_cbb_sn_lookup,
+	.noc_errors = tegra_grace_errmon_errors,
+	.err_notifier_base = 0x60000,
+	.off_mask_erd = 0x40004
+};
+
+static struct tegra_cbb_fabric_data tegra_grace_bpmp_fab_data = {
+	.name   = "bpmp-fabric",
+	.tegra_cbb_master_id = tegra_grace_master_id,
+	.sn_addr_map = tegra_grace_bpmp_sn_lookup,
+	.noc_errors = tegra_grace_errmon_errors,
+	.err_notifier_base = 0x19000
+};
+
 static const struct of_device_id tegra234_cbb_dt_ids[] = {
 	{.compatible    = "nvidia,tegra234-cbb-fabric",
 		.data = &tegra234_cbb_fab_data},
@@ -602,6 +649,36 @@ static const struct of_device_id tegra234_cbb_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, tegra234_cbb_dt_ids);
 
+struct cbb_acpi_uid_noc {
+	const char *hid;
+	const char *uid;
+	const struct tegra_cbb_fabric_data *fab;
+};
+
+static const struct cbb_acpi_uid_noc cbb_acpi_uids[] = {
+	{ "NVDA1070", "1", &tegra_grace_cbb_fab_data },
+	{ "NVDA1070", "2", &tegra_grace_bpmp_fab_data },
+	{ },
+};
+
+static const struct acpi_device_id tegra_grace_cbb_acpi_ids[] = {
+	{ "NVDA1070" },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, tegra_grace_cbb_acpi_ids);
+
+static const struct
+tegra_cbb_fabric_data *cbb_acpi_get_fab_data(struct acpi_device *adev)
+{
+	const struct cbb_acpi_uid_noc *u;
+
+	for (u = cbb_acpi_uids; u->hid; u++) {
+		if (acpi_dev_hid_uid_match(adev, u->hid, u->uid))
+			return u->fab;
+	}
+	return NULL;
+}
+
 static int
 tegra234_cbb_errmon_init(const struct tegra_cbb_fabric_data *pdata,
 			 struct tegra_cbb *cbb, struct resource *res_base)
@@ -646,10 +723,20 @@ static int tegra234_cbb_probe(struct platform_device *pdev)
 	struct tegra_cbb_errmon_record *errmon = NULL;
 	const struct tegra_cbb_fabric_data *pdata = NULL;
 	struct resource *res_base = NULL;
+	struct device *dev = &pdev->dev;
+	struct acpi_device *device;
 	struct tegra_cbb *cbb;
 	int err = 0;
 
-	pdata = of_device_get_match_data(&pdev->dev);
+	if (of_machine_is_compatible("nvidia,tegra23x") ||
+	    of_machine_is_compatible("nvidia,tegra234")) {
+		pdata = of_device_get_match_data(&pdev->dev);
+	} else {
+		device = ACPI_COMPANION(dev);
+		if (!device)
+			return -ENODEV;
+		pdata = cbb_acpi_get_fab_data(device);
+	}
 	if (!pdata) {
 		dev_err(&pdev->dev, "No device match found\n");
 		return -EINVAL;
@@ -720,6 +807,7 @@ static struct platform_driver tegra234_cbb_driver = {
 		.owner  = THIS_MODULE,
 		.name   = "tegra234-cbb",
 		.of_match_table = of_match_ptr(tegra234_cbb_dt_ids),
+		.acpi_match_table = ACPI_PTR(tegra_grace_cbb_acpi_ids),
 #ifdef CONFIG_PM_SLEEP
 		.pm     = &tegra234_cbb_pm,
 #endif
diff --git a/include/soc/tegra/tegra-grace-cbb.h b/include/soc/tegra/tegra-grace-cbb.h
new file mode 100644
index 000000000000..91cde80e773a
--- /dev/null
+++ b/include/soc/tegra/tegra-grace-cbb.h
@@ -0,0 +1,219 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021, NVIDIA CORPORATION. All rights reserved
+ */
+
+static char *tegra_grace_master_id[] = {
+	"TZ",                           /* 0x0  */
+	"CCPLEX",                       /* 0x1  */
+	"CCPMU",                        /* 0x2  */
+	"BPMP_FW",                      /* 0x3  */
+	"PSC_FW_USER",                  /* 0x4  */
+	"PSC_FW_SUPERVISOR",            /* 0x5  */
+	"PSC_FW_MACHINE",               /* 0x6  */
+	"PSC_BOOT",                     /* 0x7  */
+	"BPMP_BOOT",                    /* 0x8  */
+	"JTAGM_DFT",                    /* 0x9  */
+	"CORESIGHT",                    /* 0xA  */
+	"GPU",                          /* 0xB  */
+	"PEATRANS",                     /* 0xC  */
+	"RSVD"                          /* 0x3F */
+};
+
+/*
+ * Possible causes for Slave and Timeout errors.
+ * SLAVE_ERR:
+ * Slave being accessed responded with an error. Slave could return
+ * an error for various cases :
+ *   Unsupported access, clamp setting when power gated, register
+ *   level firewall(SCR), address hole within the slave, etc
+ *
+ * TIMEOUT_ERR:
+ * No response returned by slave. Can be due to slave being clock
+ * gated, under reset, powered down or slave inability to respond
+ * for an internal slave issue
+ */
+
+static struct tegra_noc_errors tegra_grace_errmon_errors[] = {
+	{.errcode = "SLAVE_ERR",
+	 .type = "Slave being accessed responded with an error."
+	},
+	{.errcode = "DECODE_ERR",
+	 .type = "Attempt to access an address hole or Reserved region of memory."
+	},
+	{.errcode = "FIREWALL_ERR",
+	 .type = "Attempt to access a region which is firewalled."
+	},
+	{.errcode = "TIMEOUT_ERR",
+	 .type = "No response returned by slave."
+	},
+	{.errcode = "PWRDOWN_ERR",
+	 .type = "Attempt to access a portion of the fabric that is powered down."
+	},
+	{.errcode = "UNSUPPORTED_ERR",
+	 .type = "Attempt to access a slave through an unsupported access."
+	},
+	{.errcode = "POISON_ERR",
+	 .type = "Slave responds with poison error to indicate error in data."
+	},
+	{.errcode = "RSVD"},
+	{.errcode = "RSVD"},
+	{.errcode = "RSVD"},
+	{.errcode = "RSVD"},
+	{.errcode = "RSVD"},
+	{.errcode = "RSVD"},
+	{.errcode = "RSVD"},
+	{.errcode = "RSVD"},
+	{.errcode = "RSVD"},
+	{.errcode = "NO_SUCH_ADDRESS_ERR",
+	 .type = "The address belongs to the pri_target range but there is no register implemented at the address."
+	},
+	{.errcode = "TASK_ERR",
+	 .type = "Attempt to update a PRI task when the current task has still not completed."
+	},
+	{.errcode = "EXTERNAL_ERR",
+	 .type = "Indicates that an external PRI register access met with an error due to any issue in the unit."
+	},
+	{.errcode = "INDEX_ERR",
+	 .type = "Applicable to PRI index aperture pair, when the programmed index is outside the range defined in the manual."
+	},
+	{.errcode = "RESET_ERR",
+	 .type = "Target in Reset Error: Attempt to access a SubPri or external PRI register but they are in reset."
+	},
+	{.errcode = "REGISTER_RST_ERR",
+	 .type = "Attempt to access a PRI register but the register is partial or completely in reset."
+	},
+	{.errcode = "POWER_GATED_ERR",
+	 .type = "Returned by external PRI client when the external access goes to a power gated domain."
+	},
+	{.errcode = "SUBPRI_FS_ERR",
+	 .type = "Subpri is floorswept: Attempt to access a subpri through the main pri target but subPri logic is floorswept."
+	},
+	{.errcode = "SUBPRI_CLK_OFF_ERR",
+	 .type = "Subpri clock is off: Attempt to access a subpri through the main pri target but subPris clock is gated/off."
+	}
+};
+
+#define REQ_SOCKET_ID		GENMASK(27, 24)
+
+#define BPMP_SN_AXI2APB_1_BASE	0x00000
+#define BPMP_SN_CBB_T_BASE	0x15000
+#define BPMP_SN_CPU_T_BASE	0x16000
+#define BPMP_SN_DBB0_T_BASE	0x17000
+#define BPMP_SN_DBB1_T_BASE	0x18000
+
+#define CBB_SN_CCPLEX_SLAVE_BASE 0x50000
+#define CBB_SN_PCIE_C8_BASE	0x51000
+#define CBB_SN_PCIE_C9_BASE	0x52000
+#define CBB_SN_PCIE_C4_BASE	0x53000
+#define CBB_SN_PCIE_C5_BASE	0x54000
+#define CBB_SN_PCIE_C6_BASE	0x55000
+#define CBB_SN_PCIE_C7_BASE	0x56000
+#define CBB_SN_PCIE_C2_BASE	0x57000
+#define CBB_SN_PCIE_C3_BASE	0x58000
+#define CBB_SN_PCIE_C0_BASE	0x59000
+#define CBB_SN_PCIE_C1_BASE	0x5A000
+#define CBB_SN_AON_SLAVE_BASE	0x5B000
+#define CBB_SN_BPMP_SLAVE_BASE	0x5C000
+#define CBB_SN_PSC_SLAVE_BASE	0x5D000
+#define CBB_SN_STM_BASE		0x5E000
+#define CBB_SN_AXI2APB_1_BASE	0x70000
+#define CBB_SN_AXI2APB_10_BASE	0x71000
+#define CBB_SN_AXI2APB_11_BASE	0x72000
+#define CBB_SN_AXI2APB_12_BASE	0x73000
+#define CBB_SN_AXI2APB_13_BASE	0x74000
+#define CBB_SN_AXI2APB_14_BASE	0x75000
+#define CBB_SN_AXI2APB_15_BASE	0x76000
+#define CBB_SN_AXI2APB_16_BASE	0x77000
+#define CBB_SN_AXI2APB_17_BASE	0x78000
+#define CBB_SN_AXI2APB_18_BASE	0x79000
+#define CBB_SN_AXI2APB_19_BASE	0x7A000
+#define CBB_SN_AXI2APB_2_BASE	0x7B000
+#define CBB_SN_AXI2APB_20_BASE	0x7C000
+#define CBB_SN_AXI2APB_21_BASE	0x7D000
+#define CBB_SN_AXI2APB_22_BASE	0x7E000
+#define CBB_SN_AXI2APB_23_BASE	0x7F000
+#define CBB_SN_AXI2APB_24_BASE	0x80000
+#define CBB_SN_AXI2APB_25_BASE	0x81000
+#define CBB_SN_AXI2APB_26_BASE	0x82000
+#define CBB_SN_AXI2APB_27_BASE	0x83000
+#define CBB_SN_AXI2APB_28_BASE	0x84000
+#define CBB_SN_AXI2APB_29_BASE	0x85000
+#define CBB_SN_AXI2APB_30_BASE	0x86000
+#define CBB_SN_AXI2APB_4_BASE	0x87000
+#define CBB_SN_AXI2APB_5_BASE	0x88000
+#define CBB_SN_AXI2APB_6_BASE	0x89000
+#define CBB_SN_AXI2APB_7_BASE	0x8A000
+#define CBB_SN_AXI2APB_8_BASE	0x8B000
+#define CBB_SN_AXI2APB_9_BASE	0x8C000
+#define CBB_SN_AXI2APB_3_BASE	0x8D000
+
+#define SLAVE_LOOKUP(sn) #sn, sn
+
+static struct tegra_sn_addr_map tegra_grace_bpmp_sn_lookup[] = {
+	{ "RSVD", 0 },
+	{ "RSVD", 0 },
+	{ SLAVE_LOOKUP(BPMP_SN_CBB_T_BASE) },
+	{ SLAVE_LOOKUP(BPMP_SN_CPU_T_BASE) },
+	{ SLAVE_LOOKUP(BPMP_SN_AXI2APB_1_BASE) },
+	{ SLAVE_LOOKUP(BPMP_SN_DBB0_T_BASE) },
+	{ SLAVE_LOOKUP(BPMP_SN_DBB1_T_BASE) }
+};
+
+static struct tegra_sn_addr_map tegra_grace_cbb_sn_lookup[] = {
+	{ SLAVE_LOOKUP(CBB_SN_PCIE_C8_BASE) },
+	{ SLAVE_LOOKUP(CBB_SN_PCIE_C9_BASE) },
+	{ "RSVD", 0 },
+	{ "RSVD", 0 },
+	{ "RSVD", 0 },
+	{ "RSVD", 0 },
+	{ "RSVD", 0 },
+	{ "RSVD", 0 },
+	{ "RSVD", 0 },
+	{ "RSVD", 0 },
+	{ SLAVE_LOOKUP(CBB_SN_AON_SLAVE_BASE) },
+	{ SLAVE_LOOKUP(CBB_SN_BPMP_SLAVE_BASE) },
+	{ "RSVD", 0 },
+	{ "RSVD", 0 },
+	{ SLAVE_LOOKUP(CBB_SN_PSC_SLAVE_BASE) },
+	{ SLAVE_LOOKUP(CBB_SN_STM_BASE) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_1_BASE) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_10_BASE) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_11_BASE) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_12_BASE) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_13_BASE) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_14_BASE) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_15_BASE) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_16_BASE) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_17_BASE) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_18_BASE) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_19_BASE) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_2_BASE) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_20_BASE) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_4_BASE) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_5_BASE) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_6_BASE) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_7_BASE) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_8_BASE) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_9_BASE) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_3_BASE) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_21_BASE) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_22_BASE) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_23_BASE) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_24_BASE) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_25_BASE) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_26_BASE) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_27_BASE) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_28_BASE) },
+	{ SLAVE_LOOKUP(CBB_SN_PCIE_C4_BASE) },
+	{ SLAVE_LOOKUP(CBB_SN_PCIE_C5_BASE) },
+	{ SLAVE_LOOKUP(CBB_SN_PCIE_C6_BASE) },
+	{ SLAVE_LOOKUP(CBB_SN_PCIE_C7_BASE) },
+	{ SLAVE_LOOKUP(CBB_SN_PCIE_C2_BASE) },
+	{ SLAVE_LOOKUP(CBB_SN_PCIE_C3_BASE) },
+	{ SLAVE_LOOKUP(CBB_SN_PCIE_C0_BASE) },
+	{ SLAVE_LOOKUP(CBB_SN_PCIE_C1_BASE) },
+	{ SLAVE_LOOKUP(CBB_SN_CCPLEX_SLAVE_BASE) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_29_BASE) },
+	{ SLAVE_LOOKUP(CBB_SN_AXI2APB_30_BASE) }
+};
-- 
2.17.1

