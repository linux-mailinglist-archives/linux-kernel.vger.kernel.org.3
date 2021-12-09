Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBF446F0CD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242385AbhLIRLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:11:24 -0500
Received: from mail-mw2nam10on2087.outbound.protection.outlook.com ([40.107.94.87]:55905
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232389AbhLIRLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:11:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LhDYOs1hoKseL1X1+/OPjd8kKFqxYBVczRValGd5QL4jDzF1gqRuyBVTKSstkoWa+5c3HtBvomNvv9DLwOkXwhShjNH4iS07yUStyUWgrApQjkSOe2dzUxpu+Ofa8fsw1s02Vx23onOsdLR5xb8QXTsROE/aC+0yfF6/Dm9Ni69L7NF9skr1i7y/hvTYUj+7En8Vt1dI5/a1eluXvbzawDtEnBY5+9yCrkkXRl2aQw3nI5vt58ynuu16Z1uC40JkhNAjn3mRSwcmWb749eyeSaHg7u7/XK7LcqoPddk/WhYvQHO+xMk+mLLeDwhBmy9Wpgiy1WsuSqsJg135P/PODQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xla7sR2H29rh4MpXRRLt3MHkCU4tzomUjxCC2nLNvkU=;
 b=VnhAPjQUaR1wHeLoEzbmTwcOaB9der3by/9HhRgdnWp0TbghA0ur5cfKcnELTwyjo+H5Rh9i9odMPlqDnHw13/vLDj1AvOTvkFOmzBSgD6EnuRwgUXpKt93stNT/uzjz+MH1Fofu4S46JUXFSWJiEKmGTXr1/Qq6vL6zjpYP/U0JQ+w1rT+yiU2YR7aOc0sNEIwZEBaWD9hGq/60fGnkWraTeGGmsD3OQ3JLAVgjgJw1tLqlFtHMWa/aOJoJu6ULHOqzxUoPaiVeVyVn8slDddkyZ+D0TTVo4hsKeBc4Xc0SK04/p2T7P3QtNHImSoa0a1PV3Rrsyh2csm8pfot7MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xla7sR2H29rh4MpXRRLt3MHkCU4tzomUjxCC2nLNvkU=;
 b=c3n1ieg9NYY/Ul+kfPiP74toGDTgx5yoYEdUA9af1JV35uNfnEFHN9qBzChI8QIw40aiAtD5pczpkL5mgVrhhHx82919x6oNyUs9BWTtt1x+37MdOyyJWk6X6XDlX4JQFRqySsAu3iPbDvA+G/GaNGKj6PLV+0F3gyhIhci5RW0kxTcexVvyAgfQSpxxgk+CGrF0cD+H4Q9JQkS3lJs1XqTwHVEhZF9ZGWVER5LFsK11mZKCkYhAl+NuL28qWZ27vMdmguedlVqBYLEyyo+OpgPnjCyNcXk2mQ7Y5cHrwRHTAYRF8+hOfxVjV5lecJGr9mvxFdvdoEiBy0Vb1tlANQ==
Received: from BN1PR12CA0029.namprd12.prod.outlook.com (2603:10b6:408:e1::34)
 by MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Thu, 9 Dec
 2021 17:07:48 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::7c) by BN1PR12CA0029.outlook.office365.com
 (2603:10b6:408:e1::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13 via Frontend
 Transport; Thu, 9 Dec 2021 17:07:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.12)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.12; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.12) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Thu, 9 Dec 2021 17:07:47 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 17:07:43 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 17:07:43 +0000
Received: from sumitg-l4t.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 9 Dec 2021 17:07:40 +0000
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>
CC:     <sumitg@nvidia.com>, <bbasu@nvidia.com>, <vsethi@nvidia.com>,
        <jsequeira@nvidia.com>
Subject: [Patch v1 8/8] soc: tegra: cbb: Add support for tegra-grace SOC
Date:   Thu, 9 Dec 2021 22:37:38 +0530
Message-ID: <20211209170738.17491-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 505f2e2b-c805-4535-4dbf-08d9bb366d0f
X-MS-TrafficTypeDiagnostic: MW3PR12MB4379:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB43791BEFF5D58CDAA9742DC5B9709@MW3PR12MB4379.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I1ttQBd85k8PuiW5CYHeO2S0z9nbfOHjyaIb65IYrbn95kEKUgccfilTajyA0lOc3RDKa/mekxHODt7CNILUDb6fHNrm84feCiXkq/tFbdS3i0zYTga3qSDzukl5d7rmqk2V6wGt6t7vveJaubdVJYB8IGURKho+eJxZ7BEDp7P4oKgx29IaPVmr477gOUrDe13mz5e+Ig0+VAPkkwdWtZHz44so/O1WHvC+WluQsgZC2EBjuwfvk83kr6BvInloEUplZG7WX+GKrCqxdT6jIUL8IQt4ENYflluNGTSBZTPJ4puuNRix23KMeCu6KGte6GsEEi9EhgqxA6AUIWiixNGmKDnf8gP5mUbs3jenr8wNWTOmQqN3gMrgBM9AepWQXdMqpKZaPtcbKP0CQ3oqGWekHz4GON8Ep3xBCYWKLrt/Rp2VR3lwZzUB52b6g3cZl319xkR+7DjycwJf17bhZ462OSUyeUbLBzXHXOEiLU+6Mmr5+NsAWk/OU5x6L68EXNHZ94QMXblpboIRSZszTgxc9/VQRfwCy33PsSEnacdQJoHTSeSPBfYbH502x2HDA6ZqFDp4JTdTUqQKlBf9CIE+Q9tui4mSsEfS6x+hg1vmI7eG5Y46B+QF8tQD9QAHbXgMpGtKg6VXgqMCn79xif8JPiB3AoXBaEWmSrZuLscxtcSJ138Sz1fk62x8sthqQcAYPSOOycF3p1j8I+NRW9nXOLiMCc+kbdnmqceejYqlSlk0c2V550WdcA0xMAe4CGzbhSCqLJ06TRJ2X2NMDJN8njsMbCr/Mk8bzw6Jz+A=
X-Forefront-Antispam-Report: CIP:203.18.50.12;CTRY:HK;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:hkhybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(82310400004)(2616005)(4326008)(36860700001)(26005)(86362001)(107886003)(508600001)(5660300002)(30864003)(36756003)(1076003)(8676002)(426003)(356005)(7636003)(336012)(186003)(34020700004)(7696005)(70206006)(54906003)(316002)(2906002)(110136005)(40460700001)(83380400001)(8936002)(70586007)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 17:07:47.6984
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 505f2e2b-c805-4535-4dbf-08d9bb366d0f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[203.18.50.12];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4379
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
 drivers/soc/tegra/cbb/tegra234-cbb.c |  94 +++++++++++-
 include/soc/tegra/tegra-grace-cbb.h  | 219 +++++++++++++++++++++++++++
 2 files changed, 308 insertions(+), 5 deletions(-)
 create mode 100644 include/soc/tegra/tegra-grace-cbb.h

diff --git a/drivers/soc/tegra/cbb/tegra234-cbb.c b/drivers/soc/tegra/cbb/tegra234-cbb.c
index 1d344f18df2e..94b9bd217fea 100644
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
 
@@ -296,6 +317,15 @@ static void print_errlog_err(struct seq_file *file, struct tegra_cbb_errmon_reco
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
@@ -575,6 +605,20 @@ static struct tegra_cbb_fabric_data tegra234_sce_fab_data = {
 	.sn_addr_map = t234_sce_sn_lookup
 };
 
+static struct tegra_cbb_fabric_data tegra_grace_cbb_fab_data = {
+	.name   = "cbb-fabric",
+	.tegra_cbb_master_id = tegra_grace_master_id,
+	.noc_errors = tegra_grace_errmon_errors,
+	.sn_addr_map = tegra_grace_cbb_sn_lookup
+};
+
+static struct tegra_cbb_fabric_data tegra_grace_bpmp_fab_data = {
+	.name   = "bpmp-fabric",
+	.tegra_cbb_master_id = tegra_grace_master_id,
+	.noc_errors = tegra_grace_errmon_errors,
+	.sn_addr_map = tegra_grace_bpmp_sn_lookup
+};
+
 static const struct of_device_id tegra234_cbb_dt_ids[] = {
 	{.compatible    = "nvidia,tegra234-cbb-fabric",
 		.data = &tegra234_cbb_fab_data},
@@ -592,13 +636,42 @@ static const struct of_device_id tegra234_cbb_dt_ids[] = {
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
 {
 	struct platform_device *pdev = cbb->pdev;
 	struct tegra_cbb_errmon_record *errmon;
-	struct device_node *np = NULL;
 	unsigned long flags = 0;
 	int err = 0;
 
@@ -614,14 +687,15 @@ tegra234_cbb_errmon_init(const struct tegra_cbb_fabric_data *pdata,
 	errmon->sn_addr_map = pdata->sn_addr_map;
 	errmon->cbb = cbb;
 
-	np = of_node_get(pdev->dev.of_node);
-	err = of_property_read_u64(np, "nvidia,err-notifier-base", &errmon->err_notifier_base);
+	err = device_property_read_u64(&pdev->dev, "nvidia,err-notifier-base",
+				       &errmon->err_notifier_base);
 	if (err) {
 		dev_err(&pdev->dev, "Can't parse err-notifier-base\n");
 		return -ENOENT;
 	}
 
-	err = of_property_read_u64(np, "nvidia,off-mask-erd", &errmon->off_mask_erd);
+	err = device_property_read_u64(&pdev->dev, "nvidia,off-mask-erd",
+				       &errmon->off_mask_erd);
 	if (!err)
 		errmon->erd_mask_inband_err = 1;
 
@@ -643,10 +717,19 @@ static int tegra234_cbb_probe(struct platform_device *pdev)
 	struct tegra_cbb_errmon_record *errmon = NULL;
 	const struct tegra_cbb_fabric_data *pdata = NULL;
 	struct resource *res_base = NULL;
+	struct device *dev = &pdev->dev;
+	struct acpi_device *device;
 	struct tegra_cbb *cbb;
 	int err = 0;
 
-	pdata = of_device_get_match_data(&pdev->dev);
+	if (of_machine_is_compatible("nvidia,tegra234")) {
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
@@ -715,6 +798,7 @@ static struct platform_driver tegra234_cbb_driver = {
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

