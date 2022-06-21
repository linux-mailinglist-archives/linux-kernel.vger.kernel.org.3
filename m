Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D93552AA0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 07:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345460AbiFUFvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 01:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345434AbiFUFvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 01:51:16 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on20630.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e83::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FE4220D5;
        Mon, 20 Jun 2022 22:51:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LwIIsc+q0IPW99VhVmosvro1BQqAG3Yn686aZc0iUlJw3xvfDTvCbBZJc2cnqiRsrljAA72d8fObzJUv0Qji9x8qht7vxPeERHSpJHYxsVQPZBcqQaNBQqfM6kwDj5D22BOuONvK0BayXGYp0wctAJmqxsUhl/b2cLDjMS5xt3su0TJZxFTSxn0bgqPLOZIp73BpK6+hzBWHeVCGCub8SFzaCgMC9gK8JlF1zlnm+M58Y55FshuyKZB3KMLuJTl/O1rAxRg6WjfRKcaacolSnMAZkjpZChX+JJ4nk6Pqg0xQjG6104zcdnLuCz9TQRqoUcTHGjnq9hy1wU/PS09rVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbppUhzliKXdeDVwSnfgACIR4/tltG84+1OIAl6vIRE=;
 b=ZGbPldD/hrdew12XWs2N+liAwEUTZinLkS7NJd5QScnVmtNEh0rVHIHULWn52hz67Gj5TO7dc71v4wwMgOfbqSevhb/RhwQqQ5YxbdZYRA55qNRvNKXRZh+3HPJRsUYZKRyNmOLmhWXQdZ+bvXm4L6qo9p90UFoKP0IRxgYb55ldxfYKlcBNw50GQnPOwZl++gWwAjFroRfQuYOXq1mED7YAlnKPZ1Q0X+RGJaXwJqVCv84COQAvyQYoS5Atygcj9xzeZB0VORwaoWqynZ1s2TJ3KsVLzHwkeEFLnBp4pEXtiLwaz59YNtbWoKwrcBFv2N+sibj/I1nsNSqAFkMeoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbppUhzliKXdeDVwSnfgACIR4/tltG84+1OIAl6vIRE=;
 b=hAO4fW28k7GinTOk4i0cLT49fjuETLBaXsFVoHQ9+R/nOOEEg2Dy76oM0D7/++jtf6mphDPdM/yrp/BwyXyfcqLrdHdrJN62DJhzBcGo6FqNA7j8n9PgFMFnqTZmW/uOkk40UZAbAl8lTeuhODFFLlogWI7wNW1DlkUr4IJdoAU1Jb/Y3Omxun83Vnx0uBvr1veFzDYOPAtjkSv/MHuSkpY5r1RQbM1GlTrtD4LpgeWi4B6bhVyYd31HOmVZi1FXXPSKTTslJXWsdp21BMhaMt4AhmrBw31iS/xGPDe6vOeBw9xwCDMTAY4Qcp7gZbsvCQbp1hlHfoVajDb8gRvhCw==
Received: from BN9PR03CA0617.namprd03.prod.outlook.com (2603:10b6:408:106::22)
 by MW2PR12MB2347.namprd12.prod.outlook.com (2603:10b6:907:7::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Tue, 21 Jun
 2022 05:51:11 +0000
Received: from BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::da) by BN9PR03CA0617.outlook.office365.com
 (2603:10b6:408:106::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16 via Frontend
 Transport; Tue, 21 Jun 2022 05:51:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT042.mail.protection.outlook.com (10.13.177.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5353.14 via Frontend Transport; Tue, 21 Jun 2022 05:51:10 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Tue, 21 Jun
 2022 05:51:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 20 Jun
 2022 22:51:09 -0700
Received: from msst-build.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Mon, 20 Jun 2022 22:51:08 -0700
From:   Besar Wicaksono <bwicaksono@nvidia.com>
To:     <suzuki.poulose@arm.com>, <robin.murphy@arm.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <sudeep.holla@arm.com>, <thanu.rangarajan@arm.com>,
        <Michael.Williams@arm.com>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
        <mathieu.poirier@linaro.org>, <mike.leach@linaro.org>,
        <leo.yan@linaro.org>, Besar Wicaksono <bwicaksono@nvidia.com>
Subject: [RESEND PATCH v3 2/2] perf: coresight_pmu: Add support for NVIDIA SCF and MCF attribute
Date:   Tue, 21 Jun 2022 00:50:35 -0500
Message-ID: <20220621055035.31766-3-bwicaksono@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220621055035.31766-1-bwicaksono@nvidia.com>
References: <20220621055035.31766-1-bwicaksono@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15ba9d58-9058-475d-7771-08da534a0b68
X-MS-TrafficTypeDiagnostic: MW2PR12MB2347:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB2347E6B265584D505F0EBE23A0B39@MW2PR12MB2347.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: brz7yr+cqHTybOdKe3Uq7G8B4IjwL8hZbF7zKr1iJwZpjl0c+ycUqARY66Xz+3y8qVVQ6pnIpvu0YVesWLvh10WFFhyeZPM+EPXzGfJtNNSInaOWbFZBiAKUvKD1N9VGULUcFFoP6xkA6he0m9t23bFvaldNcGzVldFwYbj7FiPG0e1PqGuXPmnTjl+UReEEWRVWv3owL0wr2NOknbidAcjbvNa2S+1FEk8bfFZ81rI3Wf7a+vji9xcG3pNxl6SrNkdLhwIe2i9zWjXU4dDmyu2QVCQ4k39osYCgk5MhLGSOR1gakb+owty28gOQA0oCE7bJi2Ev3ablD6W0Kh5wOaHhB0Fj6ge63bLYiPZ/Ae6ycFE7M+F/yWvGMbTdRtPn/e5YaT+0lJbqCuxOdbRcwbTD5I9MCNnCF8zk6US6vifllZkbRnGZahUGPw0Msn4UEJ2OPqtmuKHG7hWwjzzULGsj9S6A1Sw83bLvTvj9RC7ubUfCevmlsy0Y6TEUb91HUwWuAwyHWsB4QReUUDQSptIrC2z3Ju/yFffhyuPd9sd+C5pv2fgJscjuMe2cmKyv5QbE2SIq/ZieOMXnqQU2EpMJec+J3iU25N0Yzh1UjTYibr+7UOi1Lyme443dZMU+xNup6FS8AaMzIqIlQLueC99b1/+AzSQ8pTQExZf4qozfiS9l+X+uGcld4QXbtmk7LUkpXxIwbrs9ECOuzds1vGDIZVHEA9rNCsueL3X5oP8c0uRLROd7lbMfTX9341OI
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(346002)(39860400002)(136003)(46966006)(36840700001)(40470700004)(26005)(2906002)(5660300002)(30864003)(7416002)(478600001)(8936002)(7696005)(86362001)(6666004)(54906003)(110136005)(316002)(4326008)(107886003)(70586007)(81166007)(2616005)(356005)(36860700001)(82740400003)(70206006)(8676002)(426003)(36756003)(40480700001)(336012)(47076005)(83380400001)(186003)(1076003)(41300700001)(40460700003)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 05:51:10.8083
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ba9d58-9058-475d-7771-08da534a0b68
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2347
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
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
 .../coresight_pmu/arm_coresight_pmu_nvidia.c  | 312 ++++++++++++++++++
 .../coresight_pmu/arm_coresight_pmu_nvidia.h  |  17 +
 4 files changed, 335 insertions(+), 1 deletion(-)
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
index ba52cc592b2d..12179d029bfd 100644
--- a/drivers/perf/coresight_pmu/arm_coresight_pmu.c
+++ b/drivers/perf/coresight_pmu/arm_coresight_pmu.c
@@ -42,6 +42,7 @@
 #include <acpi/processor.h>
 
 #include "arm_coresight_pmu.h"
+#include "arm_coresight_pmu_nvidia.h"
 
 #define PMUNAME "arm_system_pmu"
 
@@ -396,6 +397,9 @@ struct impl_match {
 };
 
 static const struct impl_match impl_match[] = {
+	{ .pmiidr = 0x36B,
+	  .mask = PMIIDR_IMPLEMENTER_MASK,
+	  .impl_init_ops = nv_coresight_init_ops },
 	{}
 };
 
diff --git a/drivers/perf/coresight_pmu/arm_coresight_pmu_nvidia.c b/drivers/perf/coresight_pmu/arm_coresight_pmu_nvidia.c
new file mode 100644
index 000000000000..54f4eae4c529
--- /dev/null
+++ b/drivers/perf/coresight_pmu/arm_coresight_pmu_nvidia.c
@@ -0,0 +1,312 @@
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
+	const char *name;
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
+nv_coresight_pmu_get_name(const struct coresight_pmu *coresight_pmu)
+{
+	const struct nv_pmu_impl *impl = to_nv_pmu_impl(coresight_pmu);
+
+	return impl->name;
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
+	struct device *dev;
+	struct nv_pmu_impl *impl;
+	static atomic_t pmu_idx = {0};
+
+	dev = coresight_pmu->dev;
+
+	impl = devm_kzalloc(dev, sizeof(struct nv_pmu_impl), GFP_KERNEL);
+	if (!impl)
+		return -ENOMEM;
+
+	product_id = (coresight_pmu->impl.pmiidr >> PMIIDR_PRODUCTID_SHIFT) &
+		     PMIIDR_PRODUCTID_MASK;
+
+	switch (product_id) {
+	case 0x103:
+		impl->name =
+			devm_kasprintf(dev, GFP_KERNEL,
+				       "nvidia_mcf_pcie_pmu_%u",
+				       coresight_pmu->apmt_node->proc_affinity);
+		impl->filter_mask	= NV_MCF_PCIE_FILTER_ID_MASK;
+		impl->event_attr	= mcf_pmu_event_attrs;
+		impl->format_attr	= mcf_pcie_pmu_format_attrs;
+		break;
+	case 0x104:
+		impl->name =
+			devm_kasprintf(dev, GFP_KERNEL,
+				       "nvidia_mcf_gpuvir_pmu_%u",
+				       coresight_pmu->apmt_node->proc_affinity);
+		impl->filter_mask	= NV_MCF_GPU_FILTER_ID_MASK;
+		impl->event_attr	= mcf_pmu_event_attrs;
+		impl->format_attr	= mcf_gpu_pmu_format_attrs;
+		break;
+	case 0x105:
+		impl->name =
+			devm_kasprintf(dev, GFP_KERNEL,
+				       "nvidia_mcf_gpu_pmu_%u",
+				       coresight_pmu->apmt_node->proc_affinity);
+		impl->filter_mask	= NV_MCF_GPU_FILTER_ID_MASK;
+		impl->event_attr	= mcf_pmu_event_attrs;
+		impl->format_attr	= mcf_gpu_pmu_format_attrs;
+		break;
+	case 0x106:
+		impl->name =
+			devm_kasprintf(dev, GFP_KERNEL,
+				       "nvidia_mcf_nvlink_pmu_%u",
+				       coresight_pmu->apmt_node->proc_affinity);
+		impl->filter_mask	= NV_MCF_NVLINK_FILTER_ID_MASK;
+		impl->event_attr	= mcf_pmu_event_attrs;
+		impl->format_attr	= mcf_nvlink_pmu_format_attrs;
+		break;
+	case 0x2CF:
+		impl->name =
+			devm_kasprintf(dev, GFP_KERNEL, "nvidia_scf_pmu_%u",
+				       coresight_pmu->apmt_node->proc_affinity);
+		impl->filter_mask	= 0x0;
+		impl->event_attr	= scf_pmu_event_attrs;
+		impl->format_attr	= scf_pmu_format_attrs;
+		break;
+	default:
+		impl->name =
+			devm_kasprintf(dev, GFP_KERNEL, "nvidia_uncore_pmu_%u",
+				       atomic_fetch_inc(&pmu_idx));
+		impl->filter_mask = CORESIGHT_FILTER_MASK;
+		impl->event_attr  = coresight_pmu_get_event_attrs(coresight_pmu);
+		impl->format_attr =
+			coresight_pmu_get_format_attrs(coresight_pmu);
+		break;
+	}
+
+	impl->ops.get_event_attrs	= nv_coresight_pmu_get_event_attrs;
+	impl->ops.get_format_attrs	= nv_coresight_pmu_get_format_attrs;
+	impl->ops.get_identifier	= coresight_pmu_get_identifier;
+	impl->ops.get_name		= nv_coresight_pmu_get_name;
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

