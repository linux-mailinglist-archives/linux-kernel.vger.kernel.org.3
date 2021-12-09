Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9101546E35E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 08:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbhLIHmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 02:42:22 -0500
Received: from mail-bn8nam12on2083.outbound.protection.outlook.com ([40.107.237.83]:28128
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233923AbhLIHmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 02:42:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ixJhFWiorBiRttdLhK0HPR/6JjegRgEF/sUBc+Yj82bTDn4AlrVdh9D2k2SpnIcuXr1rf6nrZKSEEmin8HA843bCqD8EkGna+8Lcuzn5gzm9YT94tNw9QLotTioCmHLDZJEqQFgyIDAmdSSU4XLtJ85hZbCr3g1W+V/4ZgZrNIwDgz86IfLHdu2dwcZHSkfi91e9bABO2ciSvXYuEKXZry0lZX8jhpidhMKxYB3bg/1LnpPEqNag/jryj1upj/LwLnn3JVcHrCB5SA/5uH5BIx701dwA3ktzgY7EdklAUAEm9s/Uuyq0rOcenlX7m0xOdDXKVFSsMGFtQPLnLNbmLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fsCQVDe6IewBrU1aRb8iIWNyENyLRKuoX/y/1XS11o=;
 b=UaFD3EYOrcBcAkl5NQbF+LS1plbMy1gsWjtQ+GucKd5+2QKkeLmrz7pTmWpWwtZd3M5wPAfHCOcD024De8VmOaxm0xmkX2jamsB+YyBg/QlgPfEWKtV2SKmD7O2JCkCTjRpLc3AJjZ9YBGoJEhNWwdwlsvqcDidP/9N7i9Cbdp5SkPvYpBoHj3COHDYOnBuXDN3i0fHszHTa/xjU0UA2evq17YyoPqwqKToAfxMjNwFj854bWBUP740KxrdVRT/V5Dof3ZK2nJ67h/I36K+8WwaDFFmU/bonfelgZbbPB/9dIGqodWEaGQBcL75X4W/d9JcgMF4g82xSLXsReSF3QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.13) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fsCQVDe6IewBrU1aRb8iIWNyENyLRKuoX/y/1XS11o=;
 b=iH5NRE1ElUp56E3wR43+XMQHNaApDih97/XNxtOTAEpR+hiPAvFyjIesOY8eC+j9ebDY5C9QzwS9bJME73xl4MzI+MzdZkzCrJBeCAhVQk16cvGQgpQHsIMOU651Crqg7dmtTXmSRsiDX3oRH3AVn8f1fQaiHBPLTbryt8Dq05nnmjdbFY/kE4IoDAufLn5IrcT8+V7LevBVOSOSjx4M90efDUtUdoQ6eZzaIm4JpdXP1u0Rqq0xC75GoGGVjXtpzxahsqFpbw18D0UhpnQhu2wufgu+2TSZ4WQ6xr2Qz+Zo6IWX8ffUK+xQG7ZNpnE2EC9MhD36VJRgpq5CKV1e5w==
Received: from DM6PR07CA0115.namprd07.prod.outlook.com (2603:10b6:5:330::6) by
 DM6PR12MB4944.namprd12.prod.outlook.com (2603:10b6:5:1ba::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.22; Thu, 9 Dec 2021 07:38:31 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::de) by DM6PR07CA0115.outlook.office365.com
 (2603:10b6:5:330::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13 via Frontend
 Transport; Thu, 9 Dec 2021 07:38:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.13)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.13 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.13; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.13) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Thu, 9 Dec 2021 07:38:31 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 07:38:30 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 07:38:28 +0000
Received: from Asurada-Nvidia.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 8 Dec 2021 23:38:27 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <thierry.reding@gmail.com>, <joro@8bytes.org>, <will@kernel.org>
CC:     <digetx@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 6/6] iommu/tegra-smmu: Add pagetable mappings to debugfs
Date:   Wed, 8 Dec 2021 23:38:22 -0800
Message-ID: <20211209073822.26728-7-nicolinc@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211209073822.26728-1-nicolinc@nvidia.com>
References: <20211209073822.26728-1-nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1825133c-c72f-4569-219a-08d9bae6e632
X-MS-TrafficTypeDiagnostic: DM6PR12MB4944:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB49443E53DAB924885C774E57AB709@DM6PR12MB4944.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:392;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jIKPXEoQKK67PLy3Qh9DHlvprXgvIfHFat/3Q03c9RjHAd4nIsz81bxCZinSnVn4pkIbWeQUT09Tz97VAmyRFJTnO487fSieAh0zG2EAeS2rGCOP3iDIBrqnLbY68MrT3rbGWoVrnJNKAeBItREcEYfyqsNqcw7RqSOp2vkrylAlA+s+Xe6TYeCYtODeOcHK1Kl1cvnc+EnHRJYmqKOaYU1xmrQkZEu21nkfqbHyVv+xO2X9hp9Of6BOHBPAfzOpe5V/MzZGtIJixHYADVMUdKTC5mncgp+H5wuco3QPPZPFySRB3MsmasRt7RxOWSvK84Aiguw2zmRMdwizKV9oTkLe9f/xdJMnAtf2yFUK89amyRD7blsNTPuFRToGL3BC+YsoddK+CAyme49QhmibrkwvPo1URl4liyhbWkTFFeh8gmHyzoQgZjjTAA/hHTjYx6BM96ppiIARr2Yml0kYySkIMM3Uan7LVozMA6mpLlrxqijtF+QLrnomiClQ3cRcJeVpiARspWoJbl8eK8mcuZ33O/Egtnh10qc0x20iGkNtPhzF9y6aT8s2WjfyE84FJnDLcqSu1B5tNRq0Qugis1s/vceU9p93Qht53u5FtXqaYh4c0uu4KznmFeZViNirDDmhGFWMtHeDuIvtpC+I/ve5VDiw9fv31PZ9I6JOkE4/u2A9YGbAipG0p3rexOSvs3FjBk+rNBJcIQA3byc5rOHyivihO7m1O7vxt/JVkQ2S3Qns1yqRCv0uS9hwj79sL89bwi+CpPPELwRb08KX+54h6Lj14cwXO9rHJC+aBGo=
X-Forefront-Antispam-Report: CIP:203.18.50.13;CTRY:HK;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:hkhybrid02.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(70206006)(7696005)(186003)(36860700001)(70586007)(8676002)(40460700001)(316002)(82310400004)(26005)(4326008)(508600001)(86362001)(1076003)(36756003)(5660300002)(2906002)(7636003)(54906003)(6666004)(110136005)(83380400001)(356005)(8936002)(34070700002)(2616005)(336012)(47076005)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 07:38:31.1457
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1825133c-c72f-4569-219a-08d9bae6e632
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[203.18.50.13];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4944
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch dumps all active mapping entries from pagetable to a
debugfs directory named "mappings".

Part of this patch for listing all swgroup names in a group_soc
is provided by Dmitry Osipenko <digetx@gmail.com>

Attaching an example:

[SWGROUP: xusb_host] [as: (id: 5), (attr: R|W|-), (pd_dma: 0x0000000080005000)]
{
        [index: 1023] 0xf0080007 (count: 52)
        {
                PTE RANGE      | ATTR | PHYS               | IOVA       | SIZE
                [#913 , #913 ] | 0x7  | 0x0000000101fbe000 | 0xfff91000 | 0x1000
                [#914 , #914 ] | 0x7  | 0x0000000101fbd000 | 0xfff92000 | 0x1000
                [#915 , #915 ] | 0x7  | 0x0000000101fbc000 | 0xfff93000 | 0x1000
                [#916 , #916 ] | 0x7  | 0x0000000101fbb000 | 0xfff94000 | 0x1000
                [#921 , #921 ] | 0x7  | 0x00000000fcc02000 | 0xfff99000 | 0x1000
                [#922 , #922 ] | 0x7  | 0x0000000101fb7000 | 0xfff9a000 | 0x1000
                [#923 , #923 ] | 0x7  | 0x0000000101fb5000 | 0xfff9b000 | 0x1000
                [#948 , #948 ] | 0x7  | 0x0000000101fb2000 | 0xfffb4000 | 0x1000
                [#949 , #949 ] | 0x7  | 0x0000000101fb1000 | 0xfffb5000 | 0x1000
                [#950 , #950 ] | 0x7  | 0x0000000101faf000 | 0xfffb6000 | 0x1000
                [#951 , #951 ] | 0x7  | 0x0000000101fae000 | 0xfffb7000 | 0x1000
                [#952 , #952 ] | 0x7  | 0x000000010263d000 | 0xfffb8000 | 0x1000
                [#953 , #953 ] | 0x7  | 0x000000010263c000 | 0xfffb9000 | 0x1000
                [#954 , #954 ] | 0x7  | 0x000000010263b000 | 0xfffba000 | 0x1000
                [#955 , #955 ] | 0x7  | 0x000000010263a000 | 0xfffbb000 | 0x1000
                [#956 , #956 ] | 0x7  | 0x0000000102639000 | 0xfffbc000 | 0x1000
                [#957 , #957 ] | 0x7  | 0x0000000102638000 | 0xfffbd000 | 0x1000
                [#958 , #958 ] | 0x7  | 0x0000000102637000 | 0xfffbe000 | 0x1000
                [#959 , #959 ] | 0x7  | 0x0000000102636000 | 0xfffbf000 | 0x1000
                [#960 , #992 ] | 0x7  | 0x0000000102613000 | 0xfffc0000 | 0x21000
        }
}
Total PDEs: 1, total PTEs: 52

Note that the example above was output after I locally enabled
IOMMU_DOMAIN_DMA, which is not merged to mainline yet due to a
known framebuffer issue.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/tegra-smmu.c | 185 +++++++++++++++++++++++++++++++++++++
 1 file changed, 185 insertions(+)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 454504aa6602..cbd1a52f2a9f 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -47,6 +47,7 @@ struct tegra_smmu {
 	struct list_head list;
 
 	struct dentry *debugfs;
+	struct dentry *debugfs_mappings;
 
 	struct iommu_device iommu;	/* IOMMU Core code handle */
 };
@@ -154,6 +155,9 @@ static inline u32 smmu_readl(struct tegra_smmu *smmu, unsigned long offset)
 
 #define SMMU_PDE_ATTR		(SMMU_PDE_READABLE | SMMU_PDE_WRITABLE | \
 				 SMMU_PDE_NONSECURE)
+#define SMMU_PTE_ATTR		(SMMU_PTE_READABLE | SMMU_PTE_WRITABLE | \
+				 SMMU_PTE_NONSECURE)
+#define SMMU_PTE_ATTR_SHIFT	29
 
 static unsigned int iova_pd_index(unsigned long iova)
 {
@@ -165,6 +169,12 @@ static unsigned int iova_pt_index(unsigned long iova)
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
@@ -498,6 +508,156 @@ static void tegra_smmu_as_unprepare(struct tegra_smmu *smmu,
 	mutex_unlock(&smmu->lock);
 }
 
+static int tegra_smmu_debugfs_mappings_show(struct seq_file *s, void *data)
+{
+	struct tegra_smmu_group *group = s->private;
+	const struct tegra_smmu_group_soc *soc;
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
+	soc = group->soc;
+	as = group->as;
+
+	mutex_lock(&smmu->lock);
+
+	val = smmu_readl(smmu, swgrp->reg);
+	if (!(val & SMMU_ASID_ENABLE))
+		goto unlock;
+
+	pd = page_address(as->pd);
+	if (!pd)
+		goto unlock;
+
+	seq_puts(s, "[SWGROUP: ");
+	/* List all the swgroup names in the same group_soc */
+	if (soc) {
+		bool first_swgroup = true;
+		unsigned int i;
+
+		for (i = 0; i < soc->num_swgroups; i++) {
+			swgrp = tegra_smmu_find_swgrp(smmu, soc->swgroups[i]);
+			if (WARN_ON(!swgrp))
+				goto unlock;
+
+			val = smmu_readl(smmu, swgrp->reg);
+			if (!(val & SMMU_ASID_ENABLE))
+				continue;
+
+			if (WARN_ON((val & SMMU_ASID_MASK) != as->id))
+				continue;
+
+			if (first_swgroup)
+				first_swgroup = false;
+			else
+				seq_puts(s, ", ");
+
+			seq_printf(s, "%s", swgrp->name);
+		}
+	} else {
+		WARN_ON((val & SMMU_ASID_MASK) != as->id);
+		seq_printf(s, "%s", swgrp->name);
+	}
+	seq_puts(s, "] ");
+
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
+		seq_printf(s, "\t\t%-14s | %-4s | %-10s%s | %-10s | %-11s\n",
+			   "PTE RANGE", "ATTR",
+			   "PHYS", sizeof(phys_addr_t) > 4 ? "        " : "",
+			   "IOVA", "SIZE");
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
+			seq_printf(s, "\t\t[#%-4u, #%-4u] | 0x%-2x | %pa | 0x%-8x | 0x%-9zx\n",
+				   pt_index, pt_index + i - 1,
+				   addr[pt_index] >> SMMU_PTE_ATTR_SHIFT,
+				   &pa, (u32)iova, size * i);
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
@@ -522,6 +682,20 @@ static void tegra_smmu_attach_as(struct tegra_smmu *smmu,
 			dev_warn(smmu->dev,
 				 "overwriting group->as for swgroup: %s\n", swgrp->name);
 		group->as = as;
+
+		if (smmu->debugfs_mappings) {
+			const char *name;
+
+			if (group->soc)
+				name = group->soc->name;
+			else
+				name = group->swgrp->name;
+
+			debugfs_create_file(name, 0444,
+					    smmu->debugfs_mappings, group,
+					    &tegra_smmu_debugfs_mappings_fops);
+		}
+
 		break;
 	}
 
@@ -545,6 +719,15 @@ static void tegra_smmu_detach_as(struct tegra_smmu *smmu,
 		if (group->swgrp != swgrp)
 			continue;
 		group->as = NULL;
+
+		if (smmu->debugfs_mappings) {
+			struct dentry *d;
+
+			d = debugfs_lookup(group->swgrp->name,
+					   smmu->debugfs_mappings);
+			debugfs_remove(d);
+		}
+
 		break;
 	}
 
@@ -1137,6 +1320,8 @@ static void tegra_smmu_debugfs_init(struct tegra_smmu *smmu)
 			    &tegra_smmu_swgroups_fops);
 	debugfs_create_file("clients", S_IRUGO, smmu->debugfs, smmu,
 			    &tegra_smmu_clients_fops);
+
+	smmu->debugfs_mappings = debugfs_create_dir("mappings", smmu->debugfs);
 }
 
 static void tegra_smmu_debugfs_exit(struct tegra_smmu *smmu)
-- 
2.17.1

