Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4395278C3
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 18:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237735AbiEOQcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 12:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237738AbiEOQcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 12:32:07 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2055.outbound.protection.outlook.com [40.107.212.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699A61B7A3;
        Sun, 15 May 2022 09:32:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BmAJKoTL3+SxmR9D9dSuJAP4xteSiFTiVEv5fmmn3a8S2z9TfDteeBIpS0ISf1XWE8j2bW/DL6aGn/pcyIMxDSbaeJ1d95sBTlKJPjgcUFs0TpbXIUV2DkwGztpLxy5Q5pmG9CtAX75xwMntnXjCxtGCfO1JbOkSw25VjgiD4REY0sW+dnUkGaaT1hWMhufhsjfQZ+It9Vbaie7E8ArHthPILfdxQdFLz3tWxdoiDyEB9ToY6WeMF/xUcbEbedG5GofMiYnWxoiQlCEQrrdkEW1Zr3Em+4gcm3driHmXbg/7QL/9dNn5eQnvdbZfCVItfTjlho+ibjqXgg3DmdVhhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJCtvQ/SooZHbBRhHGqlR4jLK3qLpVubklMSl24XlDk=;
 b=IGmwccxkacRL4i86iaMCSFhyfqHlNu+5OfBdXj1UBSU7JU2XPEpau222f1NLKcIdkB5vg+O6ERyjV4SjAboccQ/k7QMi+NiRIjCVzgP6mfQQxNSbcj7BNJRaE0bYhx2Ni9PJ3BNkJi1+r9PqGmTqpn5qRENFAs5aj+XOrfaCldIsVsVxLU5qsT9hfzrsM24szzkngjgpvEHwYkyfVVFFjZ9HeeiEb1BhQDarZSBf6IpOigJnChvnFekQBghy2TvC1c8i8utZL+4/bbIN9sgcfRWs4/74BBA+5lNKLr2+OGaRZmcSDfs2D/UfXeY8uw/gtdqLl1tzibHZMztxgyOU0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJCtvQ/SooZHbBRhHGqlR4jLK3qLpVubklMSl24XlDk=;
 b=hwD0MD+qKnX7dFjkktJh7Mo29qFw4OJVb+zvrO/K5QP/kZ+CGMVlswuSuWr2g1HFu0HWNS5P/6CEW/JaihjVddKXeucLayMoEgl3QjmuZh9k3wzbEelzVA/y3i8JhD4dbHZYI8WhQgTNirThyaR8qKUAt03aNCdO/iIKfVP/IjA+DSHr4ClcravgsbLBLScDDgT2xaBa0iXEHhklU5SlJykg1c4fzY9jQsndtdtzx28H6J21IY5H07O+xOk8W3UABspYrsdP9Sg155ftl1kCX5C/JEexVdWsWCtXZOaMgcbFcUwnwt/gAu2xoHgo44Vn6Z2+KaTkjJ+IrScwnaRGrA==
Received: from BN9PR03CA0955.namprd03.prod.outlook.com (2603:10b6:408:108::30)
 by CH0PR12MB5314.namprd12.prod.outlook.com (2603:10b6:610:d5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Sun, 15 May
 2022 16:32:00 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::90) by BN9PR03CA0955.outlook.office365.com
 (2603:10b6:408:108::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Sun, 15 May 2022 16:32:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5250.13 via Frontend Transport; Sun, 15 May 2022 16:32:00 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL105.nvidia.com (10.27.9.14) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Sun, 15 May 2022 16:31:59 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 15 May 2022 09:31:59 -0700
Received: from msst-build.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Sun, 15 May 2022 09:31:58 -0700
From:   Besar Wicaksono <bwicaksono@nvidia.com>
To:     <robin.murphy@arm.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <sudeep.holla@arm.com>, <thanu.rangarajan@arm.com>,
        <Michael.Williams@arm.com>, <suzuki.poulose@arm.com>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>
Subject: [PATCH v2 2/2] perf: coresight_pmu: Add support for NVIDIA SCF and MCF attribute
Date:   Sun, 15 May 2022 11:30:44 -0500
Message-ID: <20220515163044.50055-3-bwicaksono@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220515163044.50055-1-bwicaksono@nvidia.com>
References: <20220509002810.12412-1-bwicaksono@nvidia.com>
 <20220515163044.50055-1-bwicaksono@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6df028fb-9fb9-4084-6485-08da36906fa8
X-MS-TrafficTypeDiagnostic: CH0PR12MB5314:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5314297CA2C55B4433617AF9A0CC9@CH0PR12MB5314.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ErCSQsDvw0WMrcpXi9QayJHGX3iro7IwOkRi2KyQJmHTbg+t2frzmdCYvwz5EpG8sVZThEnwbWmeBXxUqJhdCfCCFzBPVY1t7CywBJlNF4XOV7jO0lbyuU9Up6RChjMcfBW49h8F15Bo2kizy1FcGzSauUiECA8tKgFa9ynWarKAK07m5r4/75w4sTxtgabPcKKaFj+TOHgZ0rXfD8T2HRIIv302zpzM+rGCTi23/hY04vWyPqf5+zy1hrqJlsDVeKd1z/FmWINqXI+P9vw77pOrj/elZ3GezOZ0e1ORQ0AFYc7R0y+9JT7IlhnmhWvu3kr5trxmDXZ2ECNIJH0uAPQeW8KGjg1Tx3Uziu8nJjo1muM/9gJ0BSQjmTjjGiV3jeVGlajCiQllQwi7sg4Vqw/4ss1OJQfr6eGSib9CDLZWBzCV7sekFS/Dbh05OampxAYS/JFD4MAzY6MontWNxXOai2/69b/95BxRM3GjPRGxzD90K9vR/iHzHD24mMOxCuWHWzKGgKi53VKSDR2JjjL4RXFoYpMyRCWCFTgkODGT3kQZhH6ZBtPug5DJ/WulhKNZbBhjUdGb9W5FG7tocTj4hPZTuXzjQo7dp7uBX9giicvQZkOfb7meYKnsanALktTzuofZ9vKnFRr6D2KD+m/4ty4tKVFxOaWfcIMYeN+ci09gs4Zcg2Wd7wcUaQ7PRjEVx35aTMCnUEL1pwT3sw==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(7696005)(186003)(6666004)(40460700003)(8676002)(2616005)(5660300002)(26005)(7416002)(316002)(1076003)(107886003)(8936002)(508600001)(2906002)(30864003)(82310400005)(36756003)(356005)(86362001)(4326008)(70586007)(81166007)(70206006)(54906003)(36860700001)(83380400001)(47076005)(336012)(426003)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2022 16:32:00.1125
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df028fb-9fb9-4084-6485-08da36906fa8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5314
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for NVIDIA System Cache Fabric (SCF) and Memory Control
Fabric (MCF) PMU attributes for CoreSight PMU implementation in
NVIDIA devices.

Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
---
 drivers/perf/coresight_pmu/Makefile           |   3 +-
 .../perf/coresight_pmu/arm_coresight_pmu.c    |   4 +
 .../coresight_pmu/arm_coresight_pmu_nvidia.c  | 292 ++++++++++++++++++
 .../coresight_pmu/arm_coresight_pmu_nvidia.h  |  17 +
 4 files changed, 315 insertions(+), 1 deletion(-)
 create mode 100644 drivers/perf/coresight_pmu/arm_coresight_pmu_nvidia.c
 create mode 100644 drivers/perf/coresight_pmu/arm_coresight_pmu_nvidia.h

diff --git a/drivers/perf/coresight_pmu/Makefile b/drivers/perf/coresight_pmu/Makefile
index a2a7a5fbbc16..181b1b0dbaa1 100644
--- a/drivers/perf/coresight_pmu/Makefile
+++ b/drivers/perf/coresight_pmu/Makefile
@@ -3,4 +3,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_ARM_CORESIGHT_PMU) += \
-	arm_coresight_pmu.o
+	arm_coresight_pmu.o \
+	arm_coresight_pmu_nvidia.o
diff --git a/drivers/perf/coresight_pmu/arm_coresight_pmu.c b/drivers/perf/coresight_pmu/arm_coresight_pmu.c
index 36ac77ab85cd..85ef653e238d 100644
--- a/drivers/perf/coresight_pmu/arm_coresight_pmu.c
+++ b/drivers/perf/coresight_pmu/arm_coresight_pmu.c
@@ -40,6 +40,7 @@
 #include <acpi/processor.h>
 
 #include "arm_coresight_pmu.h"
+#include "arm_coresight_pmu_nvidia.h"
 
 #define PMUNAME "arm_coresight_pmu"
 
@@ -351,6 +352,9 @@ struct impl_match {
 };
 
 static const struct impl_match impl_match[] = {
+	{ .pmiidr = 0x36B,
+	  .mask = PMIIDR_IMPLEMENTER_MASK,
+	  .impl_init_ops = nv_coresight_init_ops },
 	{}
 };
 
diff --git a/drivers/perf/coresight_pmu/arm_coresight_pmu_nvidia.c b/drivers/perf/coresight_pmu/arm_coresight_pmu_nvidia.c
new file mode 100644
index 000000000000..21f96e95b2a6
--- /dev/null
+++ b/drivers/perf/coresight_pmu/arm_coresight_pmu_nvidia.c
@@ -0,0 +1,292 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES.
+ *
+ */
+
+/* Support for NVIDIA specific attributes. */
+
+#include "arm_coresight_pmu_nvidia.h"
+
+#define NV_MCF_PCIE_PORT_COUNT		10ULL
+#define NV_MCF_PCIE_FILTER_ID_MASK	((1ULL << NV_MCF_PCIE_PORT_COUNT) - 1)
+
+#define NV_MCF_GPU_PORT_COUNT		2ULL
+#define NV_MCF_GPU_FILTER_ID_MASK	((1ULL << NV_MCF_GPU_PORT_COUNT) - 1)
+
+#define NV_MCF_NVLINK_PORT_COUNT	4ULL
+#define NV_MCF_NVLINK_FILTER_ID_MASK	((1ULL << NV_MCF_NVLINK_PORT_COUNT) - 1)
+
+#define PMIIDR_PRODUCTID_MASK		0xFFF
+#define PMIIDR_PRODUCTID_SHIFT		20
+
+#define to_nv_pmu_impl(coresight_pmu)	\
+	(container_of(coresight_pmu->impl.ops, struct nv_pmu_impl, ops))
+
+#define CORESIGHT_EVENT_ATTR_4_INNER(_pref, _num, _suff, _config)	\
+	CORESIGHT_EVENT_ATTR(_pref##_num##_suff, _config)
+
+#define CORESIGHT_EVENT_ATTR_4(_pref, _suff, _config)			\
+	CORESIGHT_EVENT_ATTR_4_INNER(_pref, _0_, _suff, _config),	\
+	CORESIGHT_EVENT_ATTR_4_INNER(_pref, _1_, _suff, _config + 1),	\
+	CORESIGHT_EVENT_ATTR_4_INNER(_pref, _2_, _suff, _config + 2),	\
+	CORESIGHT_EVENT_ATTR_4_INNER(_pref, _3_, _suff, _config + 3)
+
+struct nv_pmu_impl {
+	struct coresight_pmu_impl_ops ops;
+	const char *identifier;
+	u32 filter_mask;
+	struct attribute **event_attr;
+	struct attribute **format_attr;
+};
+
+static struct attribute *scf_pmu_event_attrs[] = {
+	CORESIGHT_EVENT_ATTR(bus_cycles,			0x1d),
+
+	CORESIGHT_EVENT_ATTR(scf_cache_allocate,		0xF0),
+	CORESIGHT_EVENT_ATTR(scf_cache_refill,			0xF1),
+	CORESIGHT_EVENT_ATTR(scf_cache,				0xF2),
+	CORESIGHT_EVENT_ATTR(scf_cache_wb,			0xF3),
+
+	CORESIGHT_EVENT_ATTR_4(socket, rd_data,			0x101),
+	CORESIGHT_EVENT_ATTR_4(socket, dl_rsp,			0x105),
+	CORESIGHT_EVENT_ATTR_4(socket, wb_data,			0x109),
+	CORESIGHT_EVENT_ATTR_4(socket, ev_rsp,			0x10d),
+	CORESIGHT_EVENT_ATTR_4(socket, prb_data,		0x111),
+
+	CORESIGHT_EVENT_ATTR_4(socket, rd_outstanding,		0x115),
+	CORESIGHT_EVENT_ATTR_4(socket, dl_outstanding,		0x119),
+	CORESIGHT_EVENT_ATTR_4(socket, wb_outstanding,		0x11d),
+	CORESIGHT_EVENT_ATTR_4(socket, wr_outstanding,		0x121),
+	CORESIGHT_EVENT_ATTR_4(socket, ev_outstanding,		0x125),
+	CORESIGHT_EVENT_ATTR_4(socket, prb_outstanding,		0x129),
+
+	CORESIGHT_EVENT_ATTR_4(socket, rd_access,		0x12d),
+	CORESIGHT_EVENT_ATTR_4(socket, dl_access,		0x131),
+	CORESIGHT_EVENT_ATTR_4(socket, wb_access,		0x135),
+	CORESIGHT_EVENT_ATTR_4(socket, wr_access,		0x139),
+	CORESIGHT_EVENT_ATTR_4(socket, ev_access,		0x13d),
+	CORESIGHT_EVENT_ATTR_4(socket, prb_access,		0x141),
+
+	CORESIGHT_EVENT_ATTR_4(ocu, gmem_rd_data,		0x145),
+	CORESIGHT_EVENT_ATTR_4(ocu, gmem_rd_access,		0x149),
+	CORESIGHT_EVENT_ATTR_4(ocu, gmem_wb_access,		0x14d),
+	CORESIGHT_EVENT_ATTR_4(ocu, gmem_rd_outstanding,	0x151),
+	CORESIGHT_EVENT_ATTR_4(ocu, gmem_wr_outstanding,	0x155),
+
+	CORESIGHT_EVENT_ATTR_4(ocu, rem_rd_data,		0x159),
+	CORESIGHT_EVENT_ATTR_4(ocu, rem_rd_access,		0x15d),
+	CORESIGHT_EVENT_ATTR_4(ocu, rem_wb_access,		0x161),
+	CORESIGHT_EVENT_ATTR_4(ocu, rem_rd_outstanding,		0x165),
+	CORESIGHT_EVENT_ATTR_4(ocu, rem_wr_outstanding,		0x169),
+
+	CORESIGHT_EVENT_ATTR(gmem_rd_data,			0x16d),
+	CORESIGHT_EVENT_ATTR(gmem_rd_access,			0x16e),
+	CORESIGHT_EVENT_ATTR(gmem_rd_outstanding,		0x16f),
+	CORESIGHT_EVENT_ATTR(gmem_dl_rsp,			0x170),
+	CORESIGHT_EVENT_ATTR(gmem_dl_access,			0x171),
+	CORESIGHT_EVENT_ATTR(gmem_dl_outstanding,		0x172),
+	CORESIGHT_EVENT_ATTR(gmem_wb_data,			0x173),
+	CORESIGHT_EVENT_ATTR(gmem_wb_access,			0x174),
+	CORESIGHT_EVENT_ATTR(gmem_wb_outstanding,		0x175),
+	CORESIGHT_EVENT_ATTR(gmem_ev_rsp,			0x176),
+	CORESIGHT_EVENT_ATTR(gmem_ev_access,			0x177),
+	CORESIGHT_EVENT_ATTR(gmem_ev_outstanding,		0x178),
+	CORESIGHT_EVENT_ATTR(gmem_wr_data,			0x179),
+	CORESIGHT_EVENT_ATTR(gmem_wr_outstanding,		0x17a),
+	CORESIGHT_EVENT_ATTR(gmem_wr_access,			0x17b),
+
+	CORESIGHT_EVENT_ATTR_4(socket, wr_data,			0x17c),
+
+	CORESIGHT_EVENT_ATTR_4(ocu, gmem_wr_data,		0x180),
+	CORESIGHT_EVENT_ATTR_4(ocu, gmem_wb_data,		0x184),
+	CORESIGHT_EVENT_ATTR_4(ocu, gmem_wr_access,		0x188),
+	CORESIGHT_EVENT_ATTR_4(ocu, gmem_wb_outstanding,	0x18c),
+
+	CORESIGHT_EVENT_ATTR_4(ocu, rem_wr_data,		0x190),
+	CORESIGHT_EVENT_ATTR_4(ocu, rem_wb_data,		0x194),
+	CORESIGHT_EVENT_ATTR_4(ocu, rem_wr_access,		0x198),
+	CORESIGHT_EVENT_ATTR_4(ocu, rem_wb_outstanding,		0x19c),
+
+	CORESIGHT_EVENT_ATTR(gmem_wr_total_bytes,		0x1a0),
+	CORESIGHT_EVENT_ATTR(remote_socket_wr_total_bytes,	0x1a1),
+	CORESIGHT_EVENT_ATTR(remote_socket_rd_data,		0x1a2),
+	CORESIGHT_EVENT_ATTR(remote_socket_rd_outstanding,	0x1a3),
+	CORESIGHT_EVENT_ATTR(remote_socket_rd_access,		0x1a4),
+
+	CORESIGHT_EVENT_ATTR(cmem_rd_data,			0x1a5),
+	CORESIGHT_EVENT_ATTR(cmem_rd_access,			0x1a6),
+	CORESIGHT_EVENT_ATTR(cmem_rd_outstanding,		0x1a7),
+	CORESIGHT_EVENT_ATTR(cmem_dl_rsp,			0x1a8),
+	CORESIGHT_EVENT_ATTR(cmem_dl_access,			0x1a9),
+	CORESIGHT_EVENT_ATTR(cmem_dl_outstanding,		0x1aa),
+	CORESIGHT_EVENT_ATTR(cmem_wb_data,			0x1ab),
+	CORESIGHT_EVENT_ATTR(cmem_wb_access,			0x1ac),
+	CORESIGHT_EVENT_ATTR(cmem_wb_outstanding,		0x1ad),
+	CORESIGHT_EVENT_ATTR(cmem_ev_rsp,			0x1ae),
+	CORESIGHT_EVENT_ATTR(cmem_ev_access,			0x1af),
+	CORESIGHT_EVENT_ATTR(cmem_ev_outstanding,		0x1b0),
+	CORESIGHT_EVENT_ATTR(cmem_wr_data,			0x1b1),
+	CORESIGHT_EVENT_ATTR(cmem_wr_outstanding,		0x1b2),
+
+	CORESIGHT_EVENT_ATTR_4(ocu, cmem_rd_data,		0x1b3),
+	CORESIGHT_EVENT_ATTR_4(ocu, cmem_rd_access,		0x1b7),
+	CORESIGHT_EVENT_ATTR_4(ocu, cmem_wb_access,		0x1bb),
+	CORESIGHT_EVENT_ATTR_4(ocu, cmem_rd_outstanding,	0x1bf),
+	CORESIGHT_EVENT_ATTR_4(ocu, cmem_wr_outstanding,	0x1c3),
+
+	CORESIGHT_EVENT_ATTR(ocu_prb_access,			0x1c7),
+	CORESIGHT_EVENT_ATTR(ocu_prb_data,			0x1c8),
+	CORESIGHT_EVENT_ATTR(ocu_prb_outstanding,		0x1c9),
+
+	CORESIGHT_EVENT_ATTR(cmem_wr_access,			0x1ca),
+
+	CORESIGHT_EVENT_ATTR_4(ocu, cmem_wr_access,		0x1cb),
+	CORESIGHT_EVENT_ATTR_4(ocu, cmem_wb_data,		0x1cf),
+	CORESIGHT_EVENT_ATTR_4(ocu, cmem_wr_data,		0x1d3),
+	CORESIGHT_EVENT_ATTR_4(ocu, cmem_wb_outstanding,	0x1d7),
+
+	CORESIGHT_EVENT_ATTR(cmem_wr_total_bytes,		0x1db),
+
+	CORESIGHT_EVENT_ATTR(cycles, CORESIGHT_PMU_EVT_CYCLES_DEFAULT),
+	NULL,
+};
+
+static struct attribute *mcf_pmu_event_attrs[] = {
+	CORESIGHT_EVENT_ATTR(rd_bytes_loc,			0x0),
+	CORESIGHT_EVENT_ATTR(rd_bytes_rem,			0x1),
+	CORESIGHT_EVENT_ATTR(wr_bytes_loc,			0x2),
+	CORESIGHT_EVENT_ATTR(wr_bytes_rem,			0x3),
+	CORESIGHT_EVENT_ATTR(total_bytes_loc,			0x4),
+	CORESIGHT_EVENT_ATTR(total_bytes_rem,			0x5),
+	CORESIGHT_EVENT_ATTR(rd_req_loc,			0x6),
+	CORESIGHT_EVENT_ATTR(rd_req_rem,			0x7),
+	CORESIGHT_EVENT_ATTR(wr_req_loc,			0x8),
+	CORESIGHT_EVENT_ATTR(wr_req_rem,			0x9),
+	CORESIGHT_EVENT_ATTR(total_req_loc,			0xa),
+	CORESIGHT_EVENT_ATTR(total_req_rem,			0xb),
+	CORESIGHT_EVENT_ATTR(rd_cum_outs_loc,			0xc),
+	CORESIGHT_EVENT_ATTR(rd_cum_outs_rem,			0xd),
+	CORESIGHT_EVENT_ATTR(cycles, CORESIGHT_PMU_EVT_CYCLES_DEFAULT),
+	NULL,
+};
+
+static struct attribute *scf_pmu_format_attrs[] = {
+	CORESIGHT_FORMAT_EVENT_ATTR,
+	NULL,
+};
+
+static struct attribute *mcf_pcie_pmu_format_attrs[] = {
+	CORESIGHT_FORMAT_EVENT_ATTR,
+	CORESIGHT_FORMAT_ATTR(root_port, "config1:0-9"),
+	NULL,
+};
+
+static struct attribute *mcf_gpu_pmu_format_attrs[] = {
+	CORESIGHT_FORMAT_EVENT_ATTR,
+	CORESIGHT_FORMAT_ATTR(gpu, "config1:0-1"),
+	NULL,
+};
+
+static struct attribute *mcf_nvlink_pmu_format_attrs[] = {
+	CORESIGHT_FORMAT_EVENT_ATTR,
+	CORESIGHT_FORMAT_ATTR(socket, "config1:0-3"),
+	NULL,
+};
+
+static struct attribute **
+nv_coresight_pmu_get_event_attrs(const struct coresight_pmu *coresight_pmu)
+{
+	const struct nv_pmu_impl *impl = to_nv_pmu_impl(coresight_pmu);
+
+	return impl->event_attr;
+}
+
+static struct attribute **
+nv_coresight_pmu_get_format_attrs(const struct coresight_pmu *coresight_pmu)
+{
+	const struct nv_pmu_impl *impl = to_nv_pmu_impl(coresight_pmu);
+
+	return impl->format_attr;
+}
+
+static const char *
+nv_coresight_pmu_get_identifier(const struct coresight_pmu *coresight_pmu)
+{
+	const struct nv_pmu_impl *impl = to_nv_pmu_impl(coresight_pmu);
+
+	return impl->identifier;
+}
+
+static u32 nv_coresight_pmu_event_filter(const struct perf_event *event)
+{
+	const struct nv_pmu_impl *impl =
+		to_nv_pmu_impl(to_coresight_pmu(event->pmu));
+	return event->attr.config1 & impl->filter_mask;
+}
+
+int nv_coresight_init_ops(struct coresight_pmu *coresight_pmu)
+{
+	u32 product_id;
+	struct nv_pmu_impl *impl;
+
+	impl = devm_kzalloc(coresight_pmu->dev, sizeof(struct nv_pmu_impl),
+			   GFP_KERNEL);
+	if (!impl)
+		return -ENOMEM;
+
+	product_id = (coresight_pmu->impl.pmiidr >> PMIIDR_PRODUCTID_SHIFT) &
+		     PMIIDR_PRODUCTID_MASK;
+
+	switch (product_id) {
+	case 0x103:
+		impl->identifier	= "nvidia_mcf_pcie";
+		impl->filter_mask	= NV_MCF_PCIE_FILTER_ID_MASK;
+		impl->event_attr	= mcf_pmu_event_attrs;
+		impl->format_attr	= mcf_pcie_pmu_format_attrs;
+		break;
+	case 0x104:
+		impl->identifier	= "nvidia_mcf_gpuvir";
+		impl->filter_mask	= NV_MCF_GPU_FILTER_ID_MASK;
+		impl->event_attr	= mcf_pmu_event_attrs;
+		impl->format_attr	= mcf_gpu_pmu_format_attrs;
+		break;
+	case 0x105:
+		impl->identifier	= "nvidia_mcf_gpu";
+		impl->filter_mask	= NV_MCF_GPU_FILTER_ID_MASK;
+		impl->event_attr	= mcf_pmu_event_attrs;
+		impl->format_attr	= mcf_gpu_pmu_format_attrs;
+		break;
+	case 0x106:
+		impl->identifier	= "nvidia_mcf_nvlink";
+		impl->filter_mask	= NV_MCF_NVLINK_FILTER_ID_MASK;
+		impl->event_attr	= mcf_pmu_event_attrs;
+		impl->format_attr	= mcf_nvlink_pmu_format_attrs;
+		break;
+	case 0x2CF:
+		impl->identifier	= "nvidia_scf";
+		impl->filter_mask	= 0x0;
+		impl->event_attr	= scf_pmu_event_attrs;
+		impl->format_attr	= scf_pmu_format_attrs;
+		break;
+	default:
+		impl->identifier  = coresight_pmu_get_identifier(coresight_pmu);
+		impl->filter_mask = CORESIGHT_FILTER_MASK;
+		impl->event_attr  = coresight_pmu_get_event_attrs(coresight_pmu);
+		impl->format_attr =
+			coresight_pmu_get_format_attrs(coresight_pmu);
+		break;
+	}
+
+	impl->ops.get_event_attrs	= nv_coresight_pmu_get_event_attrs;
+	impl->ops.get_format_attrs	= nv_coresight_pmu_get_format_attrs;
+	impl->ops.get_identifier	= nv_coresight_pmu_get_identifier;
+	impl->ops.event_filter		= nv_coresight_pmu_event_filter;
+	impl->ops.event_type		= coresight_pmu_event_type;
+	impl->ops.event_attr_is_visible	= coresight_pmu_event_attr_is_visible;
+	impl->ops.is_cc_event		= coresight_pmu_is_cc_event;
+
+	coresight_pmu->impl.ops = &impl->ops;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nv_coresight_init_ops);
diff --git a/drivers/perf/coresight_pmu/arm_coresight_pmu_nvidia.h b/drivers/perf/coresight_pmu/arm_coresight_pmu_nvidia.h
new file mode 100644
index 000000000000..3c81c16c14f4
--- /dev/null
+++ b/drivers/perf/coresight_pmu/arm_coresight_pmu_nvidia.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES.
+ *
+ */
+
+/* Support for NVIDIA specific attributes. */
+
+#ifndef __ARM_CORESIGHT_PMU_NVIDIA_H__
+#define __ARM_CORESIGHT_PMU_NVIDIA_H__
+
+#include "arm_coresight_pmu.h"
+
+/* Allocate NVIDIA descriptor. */
+int nv_coresight_init_ops(struct coresight_pmu *coresight_pmu);
+
+#endif /* __ARM_CORESIGHT_PMU_NVIDIA_H__ */
-- 
2.17.1

