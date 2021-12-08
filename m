Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A36746CF73
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 09:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbhLHIvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 03:51:38 -0500
Received: from mail-bn8nam11on2087.outbound.protection.outlook.com ([40.107.236.87]:54162
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229737AbhLHIv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 03:51:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJovRGmO8khC5HQBQWkQeb72BwVKgA7FPGkgmceOSCFjHEqLTvicNSgl+3Yp8i8BK4Ojg7q/y/Mw0T2ge4QdriMTTglOWVLzKtja3GwIKRuDdxm/bxdGKc1D5A46obLpQk3autN5Ux+UTAItGKrGSBuhfRFmu2mv6EC+tVT7lccOxI1WUCpi84btiJ2evTUHEOKdijqFOx749fU2Jw/KImTLeZjNPUkyUHwaCBpHxFiMUyRGs7jHdR4q1vDI/90YF8vHShCCn1vTN5C+TFdeSpMDra9PAn6OFHP0Zh95H87FqPQ/iGNKzhQpv59Fkk3hdwXXMJWej+75krGpPQvTiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+WcwR2KjmakTtfKzuDqiBJZX6tV78R/TPo+FM/oblY=;
 b=dRfhMuILqX+Ebc1Ms3vJklRZpSrwS0KCCDxEBn62Mzz+BLYgthqdk8fqGbhk0pl9sY3eglQwESqi+AjZ9akxa7DY9df3lxeVgZEQ4cFDHWIbaP5n+mFkFeEQt+vNXw/LqxgPY2UY+II9/5wHHisSom8acLbM8vh1UXDPPsoLVdMTh+n5qwGKqzzuhjeK+V+Jdsw9GSeE6paHm3WVeuSEN7m3IImH03beYS0rG9kXt4kHMZiXSMpmKezWSZzJrhkEhIPCrqp7s1EcrrJiEI21qeaOrUqK74CFP/V1aUboHNf/9y2Pp/2umVrlmnx3jPVDBvTWHaQeXw2gieH4lv5nwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.12) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+WcwR2KjmakTtfKzuDqiBJZX6tV78R/TPo+FM/oblY=;
 b=Sk5RSXHw2C7KLrCORALT7F+SixM36KDtNd7vwCJq3QnSh96IQ6IYm+CGaZYdUee45UdIj0wDns1entV3Yshw7RNBlNAlSTiLhPcfLLXOa9Ii0b+8cmoFAcP/HCJmc3WqcNoBIerapsP1dML7xDAX0qX8mYwoM6jbFTC1XPn7xDvO977i5MCYyL7UOCPoiPNOPKbf2yDMEVm47s5Mw0nNLYQh10zRyq6LO0eOfXgWy4zPpPO09R3MZVgLhGWJ3Dn6NkaUNglewPlLtAJaotvxnR5xXm3l9UpGelNjC3mPXjsIrwszScbrIvmYAFbhelqXi7TFz8WGIPM+X9iImWyXCQ==
Received: from MWHPR21CA0032.namprd21.prod.outlook.com (2603:10b6:300:129::18)
 by BN6PR1201MB0033.namprd12.prod.outlook.com (2603:10b6:405:54::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Wed, 8 Dec
 2021 08:47:49 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:129:cafe::69) by MWHPR21CA0032.outlook.office365.com
 (2603:10b6:300:129::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.6 via Frontend
 Transport; Wed, 8 Dec 2021 08:47:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.12)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.12; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.12) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Wed, 8 Dec 2021 08:47:49 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 8 Dec
 2021 08:47:45 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 8 Dec
 2021 08:47:44 +0000
Received: from Asurada-Nvidia.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 8 Dec 2021 00:47:43 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <thierry.reding@gmail.com>, <joro@8bytes.org>, <will@kernel.org>
CC:     <digetx@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 6/6] iommu/tegra-smmu: Add pagetable mappings to debugfs
Date:   Wed, 8 Dec 2021 00:47:32 -0800
Message-ID: <20211208084732.23363-7-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211208084732.23363-1-nicolinc@nvidia.com>
References: <20211208084732.23363-1-nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22a31f85-eacf-4b8c-609b-08d9ba276a24
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0033:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB00337B6BA505C63C9124B838AB6F9@BN6PR1201MB0033.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:338;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jgMtZ6UsRdrlThB46tjEqwNd0eGyGdgamcxKo4E0JYRMT/mAZx6rPjDqh2kZDh/+rbgefiNljlVo9uJZRB6Po1aBjs8Myrwndh+1Lu+Q3va3WwgJhdrN1JRnuSeoVIjlGYq4O4M1P7g2BBk/dV07yrWYEpvv5BJlHdchkhlGpAIvhFC4yF6MXqW5DdHC6+etht/2hhcArKzZDGRRCtA7jmy7eW6Js9Ogbjo8QhHNupubdUaht1aj/kuwloMwnNYOoI2KbLhQcZHcWu64du+ZN5j4WK8gkj+pV0t8GkwDlV+Yu1xFIlg+c9venvLBJU6NiP7SFoTSVrjbzWPSvX/chdmhNbH1d+hvt8T3mJQyeu8EM9y/sVrApm2lhVFdhXgdpPVJLbVUkv+VDZwIFpbze/z6itKFjvdT2k7kTlcxR0UoWAbyzJjUGBtqweAZF4bGrX4tNiYw89eLgAfXLoIXH3XzDSDpZ/nwOLJrueFjfEGPz6ksQFldHFJMiFGkuTVMTxQZIdNjvcU9DN0S5Vt9wF75eLpUxG0AgkiHFC2PlQmesxsBkL+9iytnTb2/uopO1JZGcxcs1Vf6n2M5fRMtUDV0AQrMLf1AWRGhfY18Bv30uQdDcWgWBXepIZNVNnv7topAOQbHVNxr5Y3vdIIPg+4+6+nM8QPltw5++JoUFGtcnNa6+Pf679FbB0I3tRLbtKJZSYaTXNwrho1hdHH8kHvOdZito1/5N5XJp+nHUYXq/yfdzsRIl5ztwi4g9wsq1UsZaqWh9l4aybTUOaYd1RcsplU5VMiY8I6/fcQD/1c=
X-Forefront-Antispam-Report: CIP:203.18.50.12;CTRY:HK;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:hkhybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(2906002)(8676002)(8936002)(7696005)(316002)(83380400001)(26005)(5660300002)(110136005)(54906003)(426003)(1076003)(2616005)(6666004)(336012)(186003)(356005)(70206006)(7636003)(508600001)(36860700001)(70586007)(47076005)(40460700001)(34070700002)(82310400004)(36756003)(4326008)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 08:47:49.3614
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22a31f85-eacf-4b8c-609b-08d9ba276a24
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[203.18.50.12];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0033
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch dumps all active mapping entries from pagetable to a
debugfs directory named "mappings".

Attaching an example:

[SWGROUP: xusb_host] [as: (id: 5), (attr: R|W|-), (pd_dma: 0x0000000080005000)]
{
        [index: 1023] 0xf0080040 (count: 52)
        {
                PTE RANGE      | ATTR | PHYS               | IOVA               | SIZE
                [#913 , #913 ] | 0x7  | 0x0000000102674000 | 0x00000000fff91000 | 0x1000
                [#914 , #914 ] | 0x7  | 0x0000000102672000 | 0x00000000fff92000 | 0x1000
                [#915 , #915 ] | 0x7  | 0x0000000102671000 | 0x00000000fff93000 | 0x1000
                [#916 , #916 ] | 0x7  | 0x0000000102670000 | 0x00000000fff94000 | 0x1000
                [#921 , #921 ] | 0x7  | 0x00000000fcc00000 | 0x00000000fff99000 | 0x1000
                [#922 , #922 ] | 0x7  | 0x000000010266d000 | 0x00000000fff9a000 | 0x1000
                [#923 , #923 ] | 0x7  | 0x000000010266c000 | 0x00000000fff9b000 | 0x1000
                [#948 , #948 ] | 0x7  | 0x0000000102668000 | 0x00000000fffb4000 | 0x1000
                [#949 , #949 ] | 0x7  | 0x0000000102667000 | 0x00000000fffb5000 | 0x1000
                [#950 , #950 ] | 0x7  | 0x0000000102666000 | 0x00000000fffb6000 | 0x1000
                [#951 , #951 ] | 0x7  | 0x0000000102665000 | 0x00000000fffb7000 | 0x1000
                [#952 , #952 ] | 0x7  | 0x000000010264b000 | 0x00000000fffb8000 | 0x1000
                [#953 , #953 ] | 0x7  | 0x000000010264a000 | 0x00000000fffb9000 | 0x1000
                [#954 , #954 ] | 0x7  | 0x0000000102649000 | 0x00000000fffba000 | 0x1000
                [#955 , #955 ] | 0x7  | 0x0000000102648000 | 0x00000000fffbb000 | 0x1000
                [#956 , #956 ] | 0x7  | 0x000000010260f000 | 0x00000000fffbc000 | 0x1000
                [#957 , #957 ] | 0x7  | 0x000000010260e000 | 0x00000000fffbd000 | 0x1000
                [#958 , #958 ] | 0x7  | 0x000000010260d000 | 0x00000000fffbe000 | 0x1000
                [#959 , #959 ] | 0x7  | 0x000000010260b000 | 0x00000000fffbf000 | 0x1000
                [#960 , #992 ] | 0x7  | 0x00000001025ea000 | 0x00000000fffc0000 | 0x21000
        }
}
Total PDEs: 1, total PTEs: 52

Note that the example above was output after I locally enabled
IOMMU_DOMAIN_DMA, which is not merged to mainline yet due to a
known framebuffer issue.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/tegra-smmu.c | 143 +++++++++++++++++++++++++++++++++++++
 1 file changed, 143 insertions(+)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 1fbb93215463..575e82076270 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -46,6 +46,7 @@ struct tegra_smmu {
 	struct list_head list;
 
 	struct dentry *debugfs;
+	struct dentry *debugfs_mappings;
 
 	struct iommu_device iommu;	/* IOMMU Core code handle */
 };
@@ -153,6 +154,9 @@ static inline u32 smmu_readl(struct tegra_smmu *smmu, unsigned long offset)
 
 #define SMMU_PDE_ATTR		(SMMU_PDE_READABLE | SMMU_PDE_WRITABLE | \
 				 SMMU_PDE_NONSECURE)
+#define SMMU_PTE_ATTR		(SMMU_PTE_READABLE | SMMU_PTE_WRITABLE | \
+				 SMMU_PTE_NONSECURE)
+#define SMMU_PTE_ATTR_SHIFT	29
 
 static unsigned int iova_pd_index(unsigned long iova)
 {
@@ -164,6 +168,12 @@ static unsigned int iova_pt_index(unsigned long iova)
 	return (iova >> SMMU_PTE_SHIFT) & (SMMU_NUM_PTE - 1);
 }
 
+static unsigned long pd_pt_index_iova(unsigned int pd_index, unsigned int pt_index)
+{
+	return (pd_index & (SMMU_NUM_PDE - 1)) << SMMU_PDE_SHIFT |
+	       (pt_index & (SMMU_NUM_PTE - 1)) << SMMU_PTE_SHIFT;
+}
+
 static bool smmu_dma_addr_valid(struct tegra_smmu *smmu, dma_addr_t addr)
 {
 	addr >>= 12;
@@ -496,6 +506,125 @@ static void tegra_smmu_as_unprepare(struct tegra_smmu *smmu,
 	mutex_unlock(&smmu->lock);
 }
 
+static int tegra_smmu_debugfs_mappings_show(struct seq_file *s, void *data)
+{
+	struct tegra_smmu_group *group = s->private;
+	const struct tegra_smmu_swgroup *swgrp;
+	struct tegra_smmu_as *as;
+	struct tegra_smmu *smmu;
+	unsigned int pd_index;
+	unsigned int pt_index;
+	unsigned long flags;
+	u64 pte_count = 0;
+	u32 pde_count = 0;
+	u32 *pd, val;
+
+	if (!group || !group->as || !group->swgrp)
+		return 0;
+
+	swgrp = group->swgrp;
+	smmu = group->smmu;
+	as = group->as;
+
+	mutex_lock(&smmu->lock);
+
+	val = smmu_readl(smmu, swgrp->reg) & SMMU_ASID_ENABLE;
+	if (!val)
+		goto unlock;
+
+	pd = page_address(as->pd);
+	if (!pd)
+		goto unlock;
+
+	seq_printf(s, "[SWGROUP: %s] ", swgrp->name);
+	seq_printf(s, "[as: (id: %d), ", as->id);
+	seq_printf(s, "(attr: %c|%c|%c), ",
+		   as->attr & SMMU_PD_READABLE ? 'R' : '-',
+		   as->attr & SMMU_PD_WRITABLE ? 'W' : '-',
+		   as->attr & SMMU_PD_NONSECURE ? '-' : 'S');
+	seq_printf(s, "(pd_dma: %pad)]\n", &as->pd_dma);
+	seq_puts(s, "{\n");
+
+	spin_lock_irqsave(&as->lock, flags);
+
+	for (pd_index = 0; pd_index < SMMU_NUM_PDE; pd_index++) {
+		struct page *pt_page;
+		unsigned int i;
+		u32 *addr;
+
+		/* An empty PDE should not have a pte use count */
+		WARN_ON_ONCE(!pd[pd_index] ^ !as->count[pd_index]);
+
+		/* Skip this empty PDE */
+		if (!pd[pd_index])
+			continue;
+
+		pde_count++;
+		pte_count += as->count[pd_index];
+		seq_printf(s, "\t[index: %u] 0x%x (count: %d)\n",
+			   pd_index, pd[pd_index], as->count[pd_index]);
+		pt_page = as->pts[pd_index];
+		addr = page_address(pt_page);
+
+		seq_puts(s, "\t{\n");
+		seq_printf(s, "\t\t%-14s | %-4s | %-10s%s | %-10s%s | %-11s\n",
+			   "PTE RANGE", "ATTR",
+			   "PHYS", sizeof(phys_addr_t) > 4 ? "        " : "",
+			   "IOVA", sizeof(dma_addr_t)  > 4 ? "        " : "",
+			   "SIZE");
+		for (pt_index = 0; pt_index < SMMU_NUM_PTE; pt_index += i) {
+			size_t size = SMMU_SIZE_PT;
+			dma_addr_t iova;
+			phys_addr_t pa;
+
+			i = 1;
+
+			if (!addr[pt_index])
+				continue;
+
+			iova = pd_pt_index_iova(pd_index, pt_index);
+			pa = SMMU_PFN_PHYS(addr[pt_index] & ~SMMU_PTE_ATTR);
+
+			/* Check contiguous mappings and increase size */
+			while (pt_index + i < SMMU_NUM_PTE) {
+				dma_addr_t next_iova;
+				phys_addr_t next_pa;
+
+				if (!addr[pt_index + i])
+					break;
+
+				next_iova = pd_pt_index_iova(pd_index, pt_index + i);
+				next_pa = SMMU_PFN_PHYS(addr[pt_index + i] & ~SMMU_PTE_ATTR);
+
+				/* Break at the end of a linear mapping */
+				if ((next_iova - iova != SMMU_SIZE_PT * i) ||
+				    (next_pa - pa != SMMU_SIZE_PT * i))
+					break;
+
+				i++;
+			}
+
+			seq_printf(s, "\t\t[#%-4u, #%-4u] | 0x%-2x | %pa | %pad | 0x%-9zx\n",
+				   pt_index, pt_index + i - 1,
+				   addr[pt_index] >> SMMU_PTE_ATTR_SHIFT,
+				   &pa, &iova, size * i);
+		}
+		seq_puts(s, "\t}\n");
+	}
+
+	spin_unlock_irqrestore(&as->lock, flags);
+
+	seq_puts(s, "}\n");
+	seq_printf(s, "Total PDEs: %u, total PTEs: %llu\n ", pde_count, pte_count);
+
+unlock:
+	mutex_unlock(&smmu->lock);
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(tegra_smmu_debugfs_mappings);
+
 static void tegra_smmu_attach_as(struct tegra_smmu *smmu,
 				 struct tegra_smmu_as *as,
 				 unsigned int swgroup)
@@ -517,6 +646,12 @@ static void tegra_smmu_attach_as(struct tegra_smmu *smmu,
 			dev_warn(smmu->dev,
 				 "overwriting group->as for swgroup: %s\n", swgrp->name);
 		group->as = as;
+
+		if (smmu->debugfs_mappings)
+			debugfs_create_file(group->swgrp->name, 0444,
+					    smmu->debugfs_mappings, group,
+					    &tegra_smmu_debugfs_mappings_fops);
+
 		break;
 	}
 
@@ -541,6 +676,12 @@ static void tegra_smmu_detach_as(struct tegra_smmu *smmu,
 		if (group->swgrp != swgrp)
 			continue;
 		group->as = NULL;
+
+		if (smmu->debugfs_mappings) {
+			d = debugfs_lookup(group->swgrp->name, smmu->debugfs_mappings);
+			debugfs_remove(d);
+		}
+
 		break;
 	}
 
@@ -1133,6 +1274,8 @@ static void tegra_smmu_debugfs_init(struct tegra_smmu *smmu)
 			    &tegra_smmu_swgroups_fops);
 	debugfs_create_file("clients", S_IRUGO, smmu->debugfs, smmu,
 			    &tegra_smmu_clients_fops);
+
+	smmu->debugfs_mappings = debugfs_create_dir("mappings", smmu->debugfs);
 }
 
 static void tegra_smmu_debugfs_exit(struct tegra_smmu *smmu)
-- 
2.17.1

