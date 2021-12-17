Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B98D478AF5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 13:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236173AbhLQMIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 07:08:02 -0500
Received: from mail-dm6nam10on2042.outbound.protection.outlook.com ([40.107.93.42]:37985
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236090AbhLQMHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 07:07:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mIgTFPuwnV8L/MR6RMxfcRT1ixdH5LhLmY03tmfrAU7E+GyB9ldvvOgaFNbogjbdKcRi/14MAMnb62eunjWudoeeLnQ0Jk2n3YgBVgdS3FQBssAYvQl4LVoIk3DbdFyzt+ji0zawjaKq/0swOYQnXkTY35SBCKusq3plXTWVwpDeyW3WBifpAMW7/DgLojCEeAy4yUgJwWyGrdtsAhUXm/SXrcXwc6Oyyp6/yGIKxszB8VXkYXu58XZLsAsOOZZ46n8cIATNxRtz3gSA1/vzFbLrflXf3KJ3gJh8Q3GzgXC3aihASfKi1vott1Yn6Q3cFjmkfkVWK69V2IUoeLyJgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EbhFb/8/uGMrwhBW7UpTKhsUAOuSG3iW8GbW07UwsQA=;
 b=DoQFfOTLbkWI8gH9oYhuIxGJNsnUrBUh4kuqLvzBqddvYLB//GG6++Y2bMonkNOHT+KJmDAVwCLZHxpo5j2a1N6hlcoDG3G1tppYJo3pL/QBE3U5smorTOVS5qmczvlc4jWsg4LNEcUaa4Kl0zriW7lf+E+jQKxlYthm2dg6D0m9pHC8SHamvBca1SRyYm4CjOL3W3Dilxv4ezoNRAEEib1ypKdVZbRKaPVcPekqUpRI3DFT8hn9SbV7uHCsKGUfuYqzvXv9XNeyzSkjsltA5kvjkBUKabPkzbRODV24N++eGHQSxPgAbFiEFi2qr09Fc79ed34PJcThs0C/sc7z/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbhFb/8/uGMrwhBW7UpTKhsUAOuSG3iW8GbW07UwsQA=;
 b=O2nGjArGcdOBhlPZN7V/LWp3y/hjJ7YaRbYxRgTWE3F46A/ENqFSd720ByzdBZwaagVOUkUG9+OLXS5Dih6iM2TUS11a9UYoXjjPr64kl3S3HA1F0IFcs2C7hZ/dmX8o/bC3pYLavAXO5AQYXmJoIh5zbNkYa3aOE5HCedfu1GlvtleYLSPa5JSebCrq1Fo3BQzYS3tW+ahz05OHuhZjWE/Zn92j8kbCLpNCaMM508kNtPUGrCcNgrm4b+pIyAvG3ZzmoYciwoAUBLi/iuDGyhxhhUkXiaCcblHAskUj+qX7zdWZ5OUVTFd9bvCdY+R2uTpBZmNvATQ07FPUURIqAg==
Received: from MWHPR15CA0057.namprd15.prod.outlook.com (2603:10b6:301:4c::19)
 by MN2PR12MB3581.namprd12.prod.outlook.com (2603:10b6:208:c8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14; Fri, 17 Dec
 2021 12:07:37 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4c:cafe::39) by MWHPR15CA0057.outlook.office365.com
 (2603:10b6:301:4c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15 via Frontend
 Transport; Fri, 17 Dec 2021 12:07:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4801.14 via Frontend Transport; Fri, 17 Dec 2021 12:07:36 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 17 Dec
 2021 12:07:36 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 17 Dec
 2021 12:07:35 +0000
Received: from sumitg-l4t.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Fri, 17 Dec 2021 12:07:32 +0000
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>
CC:     <sumitg@nvidia.com>, <bbasu@nvidia.com>, <vsethi@nvidia.com>,
        <jsequeira@nvidia.com>
Subject: [Patch v2 9/9] soc: tegra: cbb: Add support for tegra-grace SOC
Date:   Fri, 17 Dec 2021 17:36:56 +0530
Message-ID: <20211217120656.16480-10-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211217120656.16480-1-sumitg@nvidia.com>
References: <20211217120656.16480-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b211292-8a41-4cdb-2b33-08d9c155d0d0
X-MS-TrafficTypeDiagnostic: MN2PR12MB3581:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB35817AA985F55E624F8C6CA4B9789@MN2PR12MB3581.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:334;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IiR5PP4Opiuq8jXrS3YGBuUNgqctg0vYS81wX93UFOQD12nRl8okxKkYHlhU0fT3Dt7v9mHGxqF9S9I+KVotSxDnEPj+zMIJ0t+0JvKyVH9lDzI9/Y2sS+Io7jKHbBhk9WyN3m+deg3yqlgTSIM/0VH//4BGeuB/YWtOSgS2cDfGpES4VADfMIAPQY4phljXuAPlofTpeOBwN5mEjLn8gUL0bhrYIXDWwoKO4nVvA/VocjJcRWYj/rnWLAyl3pqqMVWtnM6nbw08nO2/iev7hT7srewPVsgiKXfYu33YtLQ0/buUf+aBBHeO2yDfCZAKDKMCQpoCJ3uCK1pt9LVrFtqfgqMy6yG+VEt7UDBs9jqZ3aM0oP6XkRCFrWPtVtkAEd1N0c0rNTqXaT9sNOxVBNOM06XI4og+1eL1eHw5BiGDtWYMFH+gd5smeGifnc5zijJutv4qpFCYj+F+Ia2lSidpknAOnod9TaHCWROa4iWsghTSM8dFwzw1vlSHat3NolmP+u7vOnuHFFo8eV0RCOQBuYMYaOjzkfV8DP6LoAG68FBWnXTUcJeHX/2cytjxwq48P2VeKyj8tEeZA1M2ZSLEBc8/DoNS00ZA+iudjaEqI174T0jR0M1bsx2yu7iLF2BgdazdjScZ2Y/QDkdY31f/bH5WBDn/LBw17TRl1hSX3+JwuNkyjaK8z5MMYP2kYZNujJzyd1LM5UpMxSQfSbg5wDIdid+PagBTw+wmkX/1DJ9PqM3vABPt6u54ipRV+fyGL0bpp/AGZaEcUm+Og56rUju35G7bwpsTbb+vAgMQ5lGadHqJ65xZh1KPX5a8nySZoIMr/T+y4c8J+zHF/g==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(47076005)(110136005)(5660300002)(36860700001)(70206006)(70586007)(107886003)(81166007)(40460700001)(83380400001)(2906002)(86362001)(186003)(316002)(30864003)(356005)(426003)(508600001)(6666004)(2616005)(8676002)(36756003)(336012)(1076003)(8936002)(54906003)(26005)(7696005)(34020700004)(4326008)(82310400004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 12:07:36.7445
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b211292-8a41-4cdb-2b33-08d9c155d0d0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3581
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
 drivers/soc/tegra/cbb/tegra234-cbb.c |  93 +++++++++++-
 include/soc/tegra/tegra-grace-cbb.h  | 219 +++++++++++++++++++++++++++
 2 files changed, 310 insertions(+), 2 deletions(-)
 create mode 100644 include/soc/tegra/tegra-grace-cbb.h

diff --git a/drivers/soc/tegra/cbb/tegra234-cbb.c b/drivers/soc/tegra/cbb/tegra234-cbb.c
index 4df5d09ae2da..cbb305b80ad7 100644
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
 
@@ -278,7 +299,8 @@ static void print_errlog_err(struct seq_file *file, struct tegra_cbb_errmon_reco
 	beat_size    = FIELD_GET(FAB_EM_EL_BEATSIZE, errmon->mn_attr0);
 	access_type  = FIELD_GET(FAB_EM_EL_ACCESSTYPE, errmon->mn_attr0);
 
-	print_cbb_err(file, "\t  First logged Err Code : %s\n",
+	print_cbb_err(file, "\n");
+	print_cbb_err(file, "\t  Error Code\t\t: %s\n",
 		      t234_errmon_errors[errmon->err_type].errcode);
 
 	print_cbb_err(file, "\t  MASTER_ID\t\t: %s\n", errmon->tegra_cbb_master_id[mstr_id]);
@@ -296,6 +318,15 @@ static void print_errlog_err(struct seq_file *file, struct tegra_cbb_errmon_reco
 	else
 		strcpy(fabric_name, errmon->name);
 
+	if (is_numa) {
+		print_cbb_err(file, "\t  Requester_Socket_Id\t: 0x%x\n",
+			      requester_socket_id);
+		print_cbb_err(file, "\t  Local_Socket_Id\t: 0x%x\n",
+			      local_socket_id);
+		print_cbb_err(file, "\t  No. of NUMA_NODES\t: 0x%x\n",
+			      num_possible_nodes());
+	}
+
 	print_cbb_err(file, "\t  Fabric\t\t: %s\n", fabric_name);
 	print_cbb_err(file, "\t  Slave_Id\t\t: 0x%x\n", slave_id);
 	print_cbb_err(file, "\t  Burst_length\t\t: 0x%x\n", burst_length);
@@ -582,6 +613,23 @@ static struct tegra_cbb_fabric_data tegra234_sce_fab_data = {
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
@@ -599,6 +647,36 @@ static const struct of_device_id tegra234_cbb_dt_ids[] = {
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
@@ -643,10 +721,20 @@ static int tegra234_cbb_probe(struct platform_device *pdev)
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
@@ -715,6 +803,7 @@ static struct platform_driver tegra234_cbb_driver = {
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

