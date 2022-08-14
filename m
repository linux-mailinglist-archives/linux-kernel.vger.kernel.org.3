Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3205925F3
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 20:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbiHNSZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 14:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbiHNSZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 14:25:24 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3422640A;
        Sun, 14 Aug 2022 11:25:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHJUyecjav3ESAiyFG3r2yNH74CodKQlkGypoZKfl6k22B9AC55EydDnCVZE/mXRa7fcK9DgbtEpyJ8KwjOl/5838X59o0u35bpiGRwIRtLHhJiwX9efUqFjtFjwwjyT6CrmV9oLTK9nQAqTojPa2M6NMRLmRT0MHmRHsjnRH8JO+A/e9oCap5dyISB50hbPLPSXe5eN+C9VFR1cu4nnXjwSvO0ZrC4jf1aGpdxVHOwMa96i/atZrfXZSQluphYNFeeTGedSGp7FmJpv6fuIm/vp7kvtYb5mbMRZw27Te84SrJWQxJjVhsyLNYos5C8zhTclPPXeW1YqIdSyt1xV7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gf/CXVwSVWKWT06Ys9UyfVuUV+Kw5wpirBSvoq1O0Ng=;
 b=DqHklbZYgD1piHBxenwd2cGrQpqanErqXbWaY/Xeg3xbnvYhcS6Gg5ppkdZPTDcR5K/zqHfhXuswtteMdeBIvJFqb48nnzvBRjSaDfvzE9952zakBZN0nPUQRpmcUuRSUNQr5SCLRA/H4ri4XgNhn2/3oOFTVnr45qE4uPVAbFcGlvBIOKVYcXKc1XQTWCovWBD/uTPKfu53m0cLjwAdKLA51y+9sRT+OLT1uvPHJLKyc1h1Z1AfZSCZkE3ep/kTSIpOIVtrtjc0DVIRqN3ODDSCI3zpIVOGJtLw5T5FTrQL/5gRP1jO7qHY+0RDvxSdf30CPKj7VoNOsqAB2V1YRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gf/CXVwSVWKWT06Ys9UyfVuUV+Kw5wpirBSvoq1O0Ng=;
 b=ePVnfNbCE0vnEYGcymdOAkyLciNkYRNiMmI7TxprD4NuFLFx72XYxj8KrLlwtQGwYUpYNamQq+EFb5+QKbYRvO+M6Ajg2BQ69QkmezcCZJMDdwewiFxCY0D4V1AU8sTBb4wA+z2uvb9KvhgIWePMVK/Q4/DXind7sAcTJEt3iKBAWvNcQeASnRRgHH68ql/ZbnNq2rdD7m8JcKE0VJTy+Ku6ANxpwkrDqyh4TfG4+08W5+hYKdDCtaK5Y+N1UszadoVrptW+pW3MCwna7+r1efdLgjuatk1OCmMjOcCXMETsNpuvxV6QBVp7ol0159tx38C2S8BZuypJpDPvTDv7Mg==
Received: from MW4PR04CA0137.namprd04.prod.outlook.com (2603:10b6:303:84::22)
 by CY4PR12MB1397.namprd12.prod.outlook.com (2603:10b6:903:41::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Sun, 14 Aug
 2022 18:25:19 +0000
Received: from CO1NAM11FT108.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::84) by MW4PR04CA0137.outlook.office365.com
 (2603:10b6:303:84::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.16 via Frontend
 Transport; Sun, 14 Aug 2022 18:25:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT108.mail.protection.outlook.com (10.13.175.226) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5546.7 via Frontend Transport; Sun, 14 Aug 2022 18:25:17 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL101.nvidia.com (10.27.9.10) with Microsoft SMTP Server (TLS) id
 15.0.1497.38; Sun, 14 Aug 2022 18:25:17 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Sun, 14 Aug 2022 11:25:16 -0700
Received: from msst-build.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Sun, 14 Aug 2022 11:25:15 -0700
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
Subject: [PATCH v4 2/2] perf: arm_cspmu: Add support for NVIDIA SCF and MCF attribute
Date:   Sun, 14 Aug 2022 13:23:51 -0500
Message-ID: <20220814182351.8861-3-bwicaksono@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220814182351.8861-1-bwicaksono@nvidia.com>
References: <20220814182351.8861-1-bwicaksono@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c990286f-1c02-454a-9be5-08da7e225710
X-MS-TrafficTypeDiagnostic: CY4PR12MB1397:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f6hhyDYok0kSTWx2K+KqfJ6xlZEGxwzZ4p20cLBHrb2qoNr81ngHgesHSRVKoZ1xxyFDHPVNtYcMMyvlK2pfOjOz6Zd7wqpIiPrlyVnTIUmy0JqpovsE5i29WgpxAq/Nn2869M73OiApu7AfrnFOYLJuGmoMbBEvzmUuNMn4chwPM8iZ7m7VlkdNxaxdwVjkHE+2S0a7T4oeJCBelFw9FYl6tWzVuLm4Ayaa1D5EXyX07YimFR/BWPZX2yM+UWkKxOMn/nhSQiRGSUsJE9qGRg71/wQrocONp0k22sPaX3YhC6XGYraNgj7nVjgbxWZnSRJO82Ys8TlFKUXMR20l8ylgsIz1kVk6xXngmDw7lRGd3maoB6lvwkK3bCX0jvhINfawlCFi5to7QrNOuCE9lJ4W+8avlCM5YOcJ0B8IvpXtGkdKBkNIL2/mk7r5X6CGPCeA8Yyr0eJg/vO6HXSf6ixYf8cS7pKC2lVpe/jOVhdsKCc1X55zY+/S8s/XQcTOfFAYsgLPRFddrGP87qwR1IGHbTKnCjCwiLbyuBoulRXXOoJI0S4rwbX3ezG1rp5p28+53XJr7iJjOH4unYQmR/uWK2qTb6hp7zCKceIDK65l/Itk79Deqde+C3YPW/M6TSRg7+1+HUXTiGj/hs+sv2wJyAuATb1cmciU2ZtaEikTmX2eIdPoRmajwz5OxQd9vvuhDjEmo96lW80WwQaDDoXkKW4BY8eYA7uKGFa8JJo+yo8OQGrjjqGhC0Cvoh+pegXFr+ByaNYvivozenoxC9iDTspZ0qRS+uMOsBoEpkd19fZz6OegJ/9IRF2qapmh9HCzrzemnsjqY90UDX3sOQ==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(396003)(136003)(376002)(46966006)(40470700004)(36840700001)(36860700001)(426003)(336012)(186003)(107886003)(47076005)(1076003)(2616005)(356005)(82740400003)(81166007)(83380400001)(30864003)(5660300002)(8936002)(7416002)(4326008)(70586007)(70206006)(8676002)(40480700001)(82310400005)(2906002)(478600001)(86362001)(7696005)(6666004)(40460700003)(26005)(41300700001)(316002)(54906003)(110136005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2022 18:25:17.9634
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c990286f-1c02-454a-9be5-08da7e225710
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT108.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1397
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
 Documentation/admin-guide/perf/index.rst      |   1 +
 Documentation/admin-guide/perf/nvidia-pmu.rst | 120 ++++++
 drivers/perf/arm_cspmu/Makefile               |   3 +-
 drivers/perf/arm_cspmu/arm_cspmu.c            |   7 +
 drivers/perf/arm_cspmu/nvidia_cspmu.c         | 367 ++++++++++++++++++
 drivers/perf/arm_cspmu/nvidia_cspmu.h         |  17 +
 6 files changed, 514 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/admin-guide/perf/nvidia-pmu.rst
 create mode 100644 drivers/perf/arm_cspmu/nvidia_cspmu.c
 create mode 100644 drivers/perf/arm_cspmu/nvidia_cspmu.h

diff --git a/Documentation/admin-guide/perf/index.rst b/Documentation/admin-guide/perf/index.rst
index 69b23f087c05..cf05fed1f67f 100644
--- a/Documentation/admin-guide/perf/index.rst
+++ b/Documentation/admin-guide/perf/index.rst
@@ -17,3 +17,4 @@ Performance monitor support
    xgene-pmu
    arm_dsu_pmu
    thunderx2-pmu
+   nvidia-pmu
diff --git a/Documentation/admin-guide/perf/nvidia-pmu.rst b/Documentation/admin-guide/perf/nvidia-pmu.rst
new file mode 100644
index 000000000000..c41b93965824
--- /dev/null
+++ b/Documentation/admin-guide/perf/nvidia-pmu.rst
@@ -0,0 +1,120 @@
+=========================================================
+NVIDIA Tegra SoC Uncore Performance Monitoring Unit (PMU)
+=========================================================
+
+The NVIDIA Tegra SoC includes various system PMUs to measure key performance
+metrics like memory bandwidth, latency, and utilization:
+
+* Scalable Coherency Fabric (SCF)
+* Memory Controller Fabric (MCF) GPU physical interface
+* MCF GPU virtual interface
+* MCF NVLINK interface
+* MCF PCIE interface
+
+PMU Driver
+----------
+
+The PMUs in this document are based on ARM CoreSight PMU Architecture as
+described in document: ARM IHI 0091. Since this is a standard architecture, the
+PMUs are managed by a common driver "arm-cs-arch-pmu". This driver describes
+the available events and configuration of each PMU in sysfs. Please see the
+sections below to get the sysfs path of each PMU. Like other uncore PMU driver,
+the driver provides "cpumask" sysfs attribute to show the CPU id used to handle
+the PMU event. There is also "associated_cpus" sysfs attribute, which contains a
+list of CPUs associated with the PMU instance.
+
+SCF PMU
+-------
+
+The SCF PMU monitors system level cache events, CPU traffic, and
+strongly-ordered PCIE traffic to local/remote memory.
+
+The events and configuration options of this PMU device are described in sysfs,
+see /sys/bus/event_sources/devices/nvidia_scf_pmu_<socket-id>.
+
+Example usage::
+
+  perf stat -a -e nvidia_scf_pmu_0/config=0x0/
+
+This will count the events in socket 0.
+
+MCF GPU Physical PMU
+--------------------
+
+The MCF GPU physical PMU monitors ATS translated traffic from GPU to
+local/remote memory via Nvlink C2C.
+
+The events and configuration options of this PMU device are described in sysfs,
+see /sys/bus/event_sources/devices/nvidia_mcf_gpu_pmu_<socket-id>.
+
+Multiple GPUs can be connected to the SoC. The user can use "gpu" bitmap
+parameter to select the GPU(s) to monitor, i.e. "gpu=0xF" corresponds to GPU 0
+to 3. /sys/bus/event_sources/devices/nvidia_mcf_gpu_pmu_<socket-id>/format/gpu
+shows the valid bits that can be set in the "gpu" parameter.
+
+Example usage::
+
+  perf stat -a -e nvidia_mcf_gpu_pmu_0/config=0x0,gpu=0x3/
+
+This will count the events on GPU 0 and 1 that are connected to SoC in socket 0.
+
+MCF GPU Virtual PMU
+-------------------
+
+The MCF GPU virtual PMU monitors SMMU inline translated traffic (as opposed to
+ATS) from GPU to local/remote memory via Nvlink C2C.
+
+The events and configuration options of this PMU device are described in sysfs,
+see /sys/bus/event_sources/devices/nvidia_mcf_gpuvir_pmu_<socket-id>.
+
+Multiple GPUs can be connected to the SoC. The user can use "gpu" bitmap
+parameter to select the GPU(s) to monitor, i.e. "gpu=0xF" corresponds to GPU 0
+to 3. /sys/bus/event_sources/devices/nvidia_mcf_gpuvir_pmu_<socket-id>/format/gpu
+shows the valid bits that can be set in the "gpu" parameter.
+
+Example usage::
+
+  perf stat -a -e nvidia_mcf_gpuvir_pmu_0/config=0x0,gpu=0x3/
+
+This will count the events on GPU 0 and 1 that are connected to SoC in socket 0.
+
+MCF NVLINK PMU
+--------------
+
+The MCF NVLINK PMU monitors I/O coherent traffic from external socket to local
+memory.
+
+The events and configuration options of this PMU device are described in sysfs,
+see /sys/bus/event_sources/devices/nvidia_mcf_nvlink_pmu_<socket-id>.
+
+Each SoC socket can be connected to one or more sockets via NVLINK. The user can
+use "rem_socket" bitmap parameter to select the remote socket(s) to monitor,
+i.e. "rem_socket=0xE" corresponds to socket 1 to 3.
+/sys/bus/event_sources/devices/nvidia_mcf_nvlink_pmu_<socket-id>/format/rem_socket
+shows the valid bits that can be set in the "rem_socket" parameter.
+
+Example usage::
+
+  perf stat -a -e nvidia_mcf_nvlink_pmu_0/config=0x0,rem_socket=0x6/
+
+This will count the events from remote socket 1 and 2 to socket 0.
+
+MCF PCIE PMU
+------------
+
+The MCF PCIE PMU monitors traffic from PCIE root ports to local/remote memory.
+
+The events and configuration options of this PMU device are described in sysfs,
+see /sys/bus/event_sources/devices/nvidia_mcf_pcie_pmu_<socket-id>.
+
+Each SoC socket can support multiple root ports. The user can use
+"root_port" bitmap parameter to select the port(s) to monitor, i.e.
+"root_port=0xF" corresponds to root port 0 to 3.
+/sys/bus/event_sources/devices/nvidia_mcf_pcie_pmu_<socket-id>/format/root_port
+shows the valid bits that can be set in the "root_port" parameter.
+
+Example usage::
+
+  perf stat -a -e nvidia_mcf_pcie_pmu_0/config=0x0,root_port=0x3/
+
+This will count the events from root port 0 and 1 of socket 0.
diff --git a/drivers/perf/arm_cspmu/Makefile b/drivers/perf/arm_cspmu/Makefile
index cdc3455f74d8..1b586064bd77 100644
--- a/drivers/perf/arm_cspmu/Makefile
+++ b/drivers/perf/arm_cspmu/Makefile
@@ -3,4 +3,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += \
-	arm_cspmu.o
+	arm_cspmu.o \
+	nvidia_cspmu.o
diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index 410876f86eb0..7a0beb515e53 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -31,6 +31,7 @@
 #include <acpi/processor.h>
 
 #include "arm_cspmu.h"
+#include "nvidia_cspmu.h"
 
 #define PMUNAME "arm_cspmu"
 #define DRVNAME "arm-cs-arch-pmu"
@@ -118,6 +119,9 @@ static_assert(
 			ops->callback = arm_cspmu_ ## callback;	\
 	} while (0)
 
+/* JEDEC-assigned JEP106 identification code */
+#define ARM_CSPMU_IMPL_ID_NVIDIA		0x36B
+
 static unsigned long arm_cspmu_cpuhp_state;
 
 /*
@@ -369,6 +373,9 @@ struct impl_match {
 };
 
 static const struct impl_match impl_match[] = {
+	{ .pmiidr = ARM_CSPMU_IMPL_ID_NVIDIA,
+	  .mask = ARM_CSPMU_PMIIDR_IMPLEMENTER,
+	  .impl_init_ops = nv_cspmu_init_ops },
 	{}
 };
 
diff --git a/drivers/perf/arm_cspmu/nvidia_cspmu.c b/drivers/perf/arm_cspmu/nvidia_cspmu.c
new file mode 100644
index 000000000000..261f20680bc1
--- /dev/null
+++ b/drivers/perf/arm_cspmu/nvidia_cspmu.c
@@ -0,0 +1,367 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES.
+ *
+ */
+
+/* Support for NVIDIA specific attributes. */
+
+#include "nvidia_cspmu.h"
+
+#define NV_MCF_PCIE_PORT_COUNT       10ULL
+#define NV_MCF_PCIE_FILTER_ID_MASK   GENMASK_ULL(NV_MCF_PCIE_PORT_COUNT - 1, 0)
+
+#define NV_MCF_GPU_PORT_COUNT        2ULL
+#define NV_MCF_GPU_FILTER_ID_MASK    GENMASK_ULL(NV_MCF_GPU_PORT_COUNT - 1, 0)
+
+#define NV_MCF_NVL_PORT_COUNT        4ULL
+#define NV_MCF_NVL_FILTER_ID_MASK    GENMASK_ULL(NV_MCF_NVL_PORT_COUNT - 1, 0)
+
+#define NV_SCF_MCF_PRODID_MASK       GENMASK(31, 0)
+
+#define NV_FORMAT_NAME_GENERIC	0
+
+#define to_nv_cspmu_ctx(cspmu)	((struct nv_cspmu_ctx *)(cspmu->impl.ctx))
+
+#define NV_CSPMU_EVENT_ATTR_4_INNER(_pref, _num, _suff, _config)	\
+	ARM_CSPMU_EVENT_ATTR(_pref##_num##_suff, _config)
+
+#define NV_CSPMU_EVENT_ATTR_4(_pref, _suff, _config)			\
+	NV_CSPMU_EVENT_ATTR_4_INNER(_pref, _0_, _suff, _config),	\
+	NV_CSPMU_EVENT_ATTR_4_INNER(_pref, _1_, _suff, _config + 1),	\
+	NV_CSPMU_EVENT_ATTR_4_INNER(_pref, _2_, _suff, _config + 2),	\
+	NV_CSPMU_EVENT_ATTR_4_INNER(_pref, _3_, _suff, _config + 3)
+
+struct nv_cspmu_ctx {
+	const char *name;
+	u32 filter_mask;
+	struct attribute **event_attr;
+	struct attribute **format_attr;
+};
+
+static struct attribute *scf_pmu_event_attrs[] = {
+	ARM_CSPMU_EVENT_ATTR(bus_cycles,			0x1d),
+
+	ARM_CSPMU_EVENT_ATTR(scf_cache_allocate,		0xF0),
+	ARM_CSPMU_EVENT_ATTR(scf_cache_refill,			0xF1),
+	ARM_CSPMU_EVENT_ATTR(scf_cache,				0xF2),
+	ARM_CSPMU_EVENT_ATTR(scf_cache_wb,			0xF3),
+
+	NV_CSPMU_EVENT_ATTR_4(socket, rd_data,			0x101),
+	NV_CSPMU_EVENT_ATTR_4(socket, dl_rsp,			0x105),
+	NV_CSPMU_EVENT_ATTR_4(socket, wb_data,			0x109),
+	NV_CSPMU_EVENT_ATTR_4(socket, ev_rsp,			0x10d),
+	NV_CSPMU_EVENT_ATTR_4(socket, prb_data,			0x111),
+
+	NV_CSPMU_EVENT_ATTR_4(socket, rd_outstanding,		0x115),
+	NV_CSPMU_EVENT_ATTR_4(socket, dl_outstanding,		0x119),
+	NV_CSPMU_EVENT_ATTR_4(socket, wb_outstanding,		0x11d),
+	NV_CSPMU_EVENT_ATTR_4(socket, wr_outstanding,		0x121),
+	NV_CSPMU_EVENT_ATTR_4(socket, ev_outstanding,		0x125),
+	NV_CSPMU_EVENT_ATTR_4(socket, prb_outstanding,		0x129),
+
+	NV_CSPMU_EVENT_ATTR_4(socket, rd_access,		0x12d),
+	NV_CSPMU_EVENT_ATTR_4(socket, dl_access,		0x131),
+	NV_CSPMU_EVENT_ATTR_4(socket, wb_access,		0x135),
+	NV_CSPMU_EVENT_ATTR_4(socket, wr_access,		0x139),
+	NV_CSPMU_EVENT_ATTR_4(socket, ev_access,		0x13d),
+	NV_CSPMU_EVENT_ATTR_4(socket, prb_access,		0x141),
+
+	NV_CSPMU_EVENT_ATTR_4(ocu, gmem_rd_data,		0x145),
+	NV_CSPMU_EVENT_ATTR_4(ocu, gmem_rd_access,		0x149),
+	NV_CSPMU_EVENT_ATTR_4(ocu, gmem_wb_access,		0x14d),
+	NV_CSPMU_EVENT_ATTR_4(ocu, gmem_rd_outstanding,		0x151),
+	NV_CSPMU_EVENT_ATTR_4(ocu, gmem_wr_outstanding,		0x155),
+
+	NV_CSPMU_EVENT_ATTR_4(ocu, rem_rd_data,			0x159),
+	NV_CSPMU_EVENT_ATTR_4(ocu, rem_rd_access,		0x15d),
+	NV_CSPMU_EVENT_ATTR_4(ocu, rem_wb_access,		0x161),
+	NV_CSPMU_EVENT_ATTR_4(ocu, rem_rd_outstanding,		0x165),
+	NV_CSPMU_EVENT_ATTR_4(ocu, rem_wr_outstanding,		0x169),
+
+	ARM_CSPMU_EVENT_ATTR(gmem_rd_data,			0x16d),
+	ARM_CSPMU_EVENT_ATTR(gmem_rd_access,			0x16e),
+	ARM_CSPMU_EVENT_ATTR(gmem_rd_outstanding,		0x16f),
+	ARM_CSPMU_EVENT_ATTR(gmem_dl_rsp,			0x170),
+	ARM_CSPMU_EVENT_ATTR(gmem_dl_access,			0x171),
+	ARM_CSPMU_EVENT_ATTR(gmem_dl_outstanding,		0x172),
+	ARM_CSPMU_EVENT_ATTR(gmem_wb_data,			0x173),
+	ARM_CSPMU_EVENT_ATTR(gmem_wb_access,			0x174),
+	ARM_CSPMU_EVENT_ATTR(gmem_wb_outstanding,		0x175),
+	ARM_CSPMU_EVENT_ATTR(gmem_ev_rsp,			0x176),
+	ARM_CSPMU_EVENT_ATTR(gmem_ev_access,			0x177),
+	ARM_CSPMU_EVENT_ATTR(gmem_ev_outstanding,		0x178),
+	ARM_CSPMU_EVENT_ATTR(gmem_wr_data,			0x179),
+	ARM_CSPMU_EVENT_ATTR(gmem_wr_outstanding,		0x17a),
+	ARM_CSPMU_EVENT_ATTR(gmem_wr_access,			0x17b),
+
+	NV_CSPMU_EVENT_ATTR_4(socket, wr_data,			0x17c),
+
+	NV_CSPMU_EVENT_ATTR_4(ocu, gmem_wr_data,		0x180),
+	NV_CSPMU_EVENT_ATTR_4(ocu, gmem_wb_data,		0x184),
+	NV_CSPMU_EVENT_ATTR_4(ocu, gmem_wr_access,		0x188),
+	NV_CSPMU_EVENT_ATTR_4(ocu, gmem_wb_outstanding,		0x18c),
+
+	NV_CSPMU_EVENT_ATTR_4(ocu, rem_wr_data,			0x190),
+	NV_CSPMU_EVENT_ATTR_4(ocu, rem_wb_data,			0x194),
+	NV_CSPMU_EVENT_ATTR_4(ocu, rem_wr_access,		0x198),
+	NV_CSPMU_EVENT_ATTR_4(ocu, rem_wb_outstanding,		0x19c),
+
+	ARM_CSPMU_EVENT_ATTR(gmem_wr_total_bytes,		0x1a0),
+	ARM_CSPMU_EVENT_ATTR(remote_socket_wr_total_bytes,	0x1a1),
+	ARM_CSPMU_EVENT_ATTR(remote_socket_rd_data,		0x1a2),
+	ARM_CSPMU_EVENT_ATTR(remote_socket_rd_outstanding,	0x1a3),
+	ARM_CSPMU_EVENT_ATTR(remote_socket_rd_access,		0x1a4),
+
+	ARM_CSPMU_EVENT_ATTR(cmem_rd_data,			0x1a5),
+	ARM_CSPMU_EVENT_ATTR(cmem_rd_access,			0x1a6),
+	ARM_CSPMU_EVENT_ATTR(cmem_rd_outstanding,		0x1a7),
+	ARM_CSPMU_EVENT_ATTR(cmem_dl_rsp,			0x1a8),
+	ARM_CSPMU_EVENT_ATTR(cmem_dl_access,			0x1a9),
+	ARM_CSPMU_EVENT_ATTR(cmem_dl_outstanding,		0x1aa),
+	ARM_CSPMU_EVENT_ATTR(cmem_wb_data,			0x1ab),
+	ARM_CSPMU_EVENT_ATTR(cmem_wb_access,			0x1ac),
+	ARM_CSPMU_EVENT_ATTR(cmem_wb_outstanding,		0x1ad),
+	ARM_CSPMU_EVENT_ATTR(cmem_ev_rsp,			0x1ae),
+	ARM_CSPMU_EVENT_ATTR(cmem_ev_access,			0x1af),
+	ARM_CSPMU_EVENT_ATTR(cmem_ev_outstanding,		0x1b0),
+	ARM_CSPMU_EVENT_ATTR(cmem_wr_data,			0x1b1),
+	ARM_CSPMU_EVENT_ATTR(cmem_wr_outstanding,		0x1b2),
+
+	NV_CSPMU_EVENT_ATTR_4(ocu, cmem_rd_data,		0x1b3),
+	NV_CSPMU_EVENT_ATTR_4(ocu, cmem_rd_access,		0x1b7),
+	NV_CSPMU_EVENT_ATTR_4(ocu, cmem_wb_access,		0x1bb),
+	NV_CSPMU_EVENT_ATTR_4(ocu, cmem_rd_outstanding,		0x1bf),
+	NV_CSPMU_EVENT_ATTR_4(ocu, cmem_wr_outstanding,		0x1c3),
+
+	ARM_CSPMU_EVENT_ATTR(ocu_prb_access,			0x1c7),
+	ARM_CSPMU_EVENT_ATTR(ocu_prb_data,			0x1c8),
+	ARM_CSPMU_EVENT_ATTR(ocu_prb_outstanding,		0x1c9),
+
+	ARM_CSPMU_EVENT_ATTR(cmem_wr_access,			0x1ca),
+
+	NV_CSPMU_EVENT_ATTR_4(ocu, cmem_wr_access,		0x1cb),
+	NV_CSPMU_EVENT_ATTR_4(ocu, cmem_wb_data,		0x1cf),
+	NV_CSPMU_EVENT_ATTR_4(ocu, cmem_wr_data,		0x1d3),
+	NV_CSPMU_EVENT_ATTR_4(ocu, cmem_wb_outstanding,		0x1d7),
+
+	ARM_CSPMU_EVENT_ATTR(cmem_wr_total_bytes,		0x1db),
+
+	ARM_CSPMU_EVENT_ATTR(cycles, ARM_CSPMU_EVT_CYCLES_DEFAULT),
+	NULL,
+};
+
+static struct attribute *mcf_pmu_event_attrs[] = {
+	ARM_CSPMU_EVENT_ATTR(rd_bytes_loc,			0x0),
+	ARM_CSPMU_EVENT_ATTR(rd_bytes_rem,			0x1),
+	ARM_CSPMU_EVENT_ATTR(wr_bytes_loc,			0x2),
+	ARM_CSPMU_EVENT_ATTR(wr_bytes_rem,			0x3),
+	ARM_CSPMU_EVENT_ATTR(total_bytes_loc,			0x4),
+	ARM_CSPMU_EVENT_ATTR(total_bytes_rem,			0x5),
+	ARM_CSPMU_EVENT_ATTR(rd_req_loc,			0x6),
+	ARM_CSPMU_EVENT_ATTR(rd_req_rem,			0x7),
+	ARM_CSPMU_EVENT_ATTR(wr_req_loc,			0x8),
+	ARM_CSPMU_EVENT_ATTR(wr_req_rem,			0x9),
+	ARM_CSPMU_EVENT_ATTR(total_req_loc,			0xa),
+	ARM_CSPMU_EVENT_ATTR(total_req_rem,			0xb),
+	ARM_CSPMU_EVENT_ATTR(rd_cum_outs_loc,			0xc),
+	ARM_CSPMU_EVENT_ATTR(rd_cum_outs_rem,			0xd),
+	ARM_CSPMU_EVENT_ATTR(cycles, ARM_CSPMU_EVT_CYCLES_DEFAULT),
+	NULL,
+};
+
+static struct attribute *generic_pmu_event_attrs[] = {
+	ARM_CSPMU_EVENT_ATTR(cycles, ARM_CSPMU_EVT_CYCLES_DEFAULT),
+	NULL,
+};
+
+static struct attribute *scf_pmu_format_attrs[] = {
+	ARM_CSPMU_FORMAT_EVENT_ATTR,
+	NULL,
+};
+
+static struct attribute *mcf_pcie_pmu_format_attrs[] = {
+	ARM_CSPMU_FORMAT_EVENT_ATTR,
+	ARM_CSPMU_FORMAT_ATTR(root_port, "config1:0-9"),
+	NULL,
+};
+
+static struct attribute *mcf_gpu_pmu_format_attrs[] = {
+	ARM_CSPMU_FORMAT_EVENT_ATTR,
+	ARM_CSPMU_FORMAT_ATTR(gpu, "config1:0-1"),
+	NULL,
+};
+
+static struct attribute *mcf_nvlink_pmu_format_attrs[] = {
+	ARM_CSPMU_FORMAT_EVENT_ATTR,
+	ARM_CSPMU_FORMAT_ATTR(rem_socket, "config1:0-3"),
+	NULL,
+};
+
+static struct attribute *generic_pmu_format_attrs[] = {
+	ARM_CSPMU_FORMAT_EVENT_ATTR,
+	ARM_CSPMU_FORMAT_FILTER_ATTR,
+	NULL,
+};
+
+static struct attribute **
+nv_cspmu_get_event_attrs(const struct arm_cspmu *cspmu)
+{
+	const struct nv_cspmu_ctx *ctx = to_nv_cspmu_ctx(cspmu);
+
+	return ctx->event_attr;
+}
+
+static struct attribute **
+nv_cspmu_get_format_attrs(const struct arm_cspmu *cspmu)
+{
+	const struct nv_cspmu_ctx *ctx = to_nv_cspmu_ctx(cspmu);
+
+	return ctx->format_attr;
+}
+
+static const char *
+nv_cspmu_get_name(const struct arm_cspmu *cspmu)
+{
+	const struct nv_cspmu_ctx *ctx = to_nv_cspmu_ctx(cspmu);
+
+	return ctx->name;
+}
+
+static u32 nv_cspmu_event_filter(const struct perf_event *event)
+{
+	const struct nv_cspmu_ctx *ctx =
+		to_nv_cspmu_ctx(to_arm_cspmu(event->pmu));
+
+	return event->attr.config1 & ctx->filter_mask;
+}
+
+enum nv_cspmu_name_fmt {
+	NAME_FMT_GENERIC,
+	NAME_FMT_PROC
+};
+
+struct nv_cspmu_match {
+	u32 prodid;
+	u32 prodid_mask;
+	u64 filter_mask;
+	const char *name_pattern;
+	enum nv_cspmu_name_fmt name_fmt;
+	struct attribute **event_attr;
+	struct attribute **format_attr;
+};
+
+static const struct nv_cspmu_match nv_cspmu_match[] = {
+	{ .prodid = 0x103,
+	  .prodid_mask = NV_SCF_MCF_PRODID_MASK,
+	  .filter_mask = NV_MCF_PCIE_FILTER_ID_MASK,
+	  .name_pattern = "nvidia_mcf_pcie_pmu_%u",
+	  .name_fmt = NAME_FMT_PROC,
+	  .event_attr = mcf_pmu_event_attrs,
+	  .format_attr = mcf_pcie_pmu_format_attrs },
+	{ .prodid = 0x104,
+	  .prodid_mask = NV_SCF_MCF_PRODID_MASK,
+	  .filter_mask = NV_MCF_GPU_FILTER_ID_MASK,
+	  .name_pattern = "nvidia_mcf_gpuvir_pmu_%u",
+	  .name_fmt = NAME_FMT_PROC,
+	  .event_attr = mcf_pmu_event_attrs,
+	  .format_attr = mcf_gpu_pmu_format_attrs },
+	{ .prodid = 0x105,
+	  .prodid_mask = NV_SCF_MCF_PRODID_MASK,
+	  .filter_mask = NV_MCF_GPU_FILTER_ID_MASK,
+	  .name_pattern = "nvidia_mcf_gpu_pmu_%u",
+	  .name_fmt = NAME_FMT_PROC,
+	  .event_attr = mcf_pmu_event_attrs,
+	  .format_attr = mcf_gpu_pmu_format_attrs },
+	{ .prodid = 0x106,
+	  .prodid_mask = NV_SCF_MCF_PRODID_MASK,
+	  .filter_mask = NV_MCF_NVL_FILTER_ID_MASK,
+	  .name_pattern = "nvidia_mcf_nvlink_pmu_%u",
+	  .name_fmt = NAME_FMT_PROC,
+	  .event_attr = mcf_pmu_event_attrs,
+	  .format_attr = mcf_nvlink_pmu_format_attrs },
+	{ .prodid = 0x2CF,
+	  .prodid_mask = NV_SCF_MCF_PRODID_MASK,
+	  .filter_mask = 0x0,
+	  .name_pattern = "nvidia_scf_pmu_%u",
+	  .name_fmt = NAME_FMT_PROC,
+	  .event_attr = scf_pmu_event_attrs,
+	  .format_attr = scf_pmu_format_attrs },
+	{ .prodid = 0,
+	  .prodid_mask = 0,
+	  .filter_mask = ARM_CSPMU_FILTER_MASK,
+	  .name_pattern = "nvidia_uncore_pmu_%u",
+	  .name_fmt = NAME_FMT_GENERIC,
+	  .event_attr = generic_pmu_event_attrs,
+	  .format_attr = generic_pmu_format_attrs },
+};
+
+static char *nv_cspmu_format_name(const struct arm_cspmu *cspmu,
+				  const struct nv_cspmu_match *match)
+{
+	char *name;
+	struct device *dev = cspmu->dev;
+
+	static atomic_t pmu_generic_idx = {0};
+
+	switch (match->name_fmt) {
+	case NAME_FMT_PROC:
+		name = devm_kasprintf(dev, GFP_KERNEL, match->name_pattern,
+				       cspmu->apmt_node->proc_affinity);
+		break;
+	case NAME_FMT_GENERIC:
+		name = devm_kasprintf(dev, GFP_KERNEL, match->name_pattern,
+				       atomic_fetch_inc(&pmu_generic_idx));
+		break;
+	default:
+		name = NULL;
+		break;
+	}
+
+	return name;
+}
+
+int nv_cspmu_init_ops(struct arm_cspmu *cspmu)
+{
+	u32 prodid;
+	struct nv_cspmu_ctx *ctx;
+	struct device *dev = cspmu->dev;
+	struct arm_cspmu_impl_ops *impl_ops = &cspmu->impl.ops;
+	const struct nv_cspmu_match *match = nv_cspmu_match;
+
+	ctx = devm_kzalloc(dev, sizeof(struct nv_cspmu_ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	prodid = FIELD_GET(ARM_CSPMU_PMIIDR_PRODUCTID, cspmu->impl.pmiidr);
+
+	/* Find matching PMU. */
+	for (; match->prodid; match++) {
+		const u32 prodid_mask = match->prodid_mask;
+
+		if ((match->prodid & prodid_mask) == (prodid & prodid_mask))
+			break;
+	}
+
+	ctx->name		= nv_cspmu_format_name(cspmu, match);
+	ctx->filter_mask	= match->filter_mask;
+	ctx->event_attr		= match->event_attr;
+	ctx->format_attr	= match->format_attr;
+
+	cspmu->impl.ctx = ctx;
+
+	/* NVIDIA specific callbacks. */
+	impl_ops->event_filter			= nv_cspmu_event_filter;
+	impl_ops->get_event_attrs		= nv_cspmu_get_event_attrs;
+	impl_ops->get_format_attrs		= nv_cspmu_get_format_attrs;
+	impl_ops->get_name			= nv_cspmu_get_name;
+
+	/* Set others to NULL to use default callback. */
+	impl_ops->event_type			= NULL;
+	impl_ops->event_attr_is_visible		= NULL;
+	impl_ops->get_identifier		= NULL;
+	impl_ops->is_cycle_counter_event	= NULL;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nv_cspmu_init_ops);
diff --git a/drivers/perf/arm_cspmu/nvidia_cspmu.h b/drivers/perf/arm_cspmu/nvidia_cspmu.h
new file mode 100644
index 000000000000..eefba85644f6
--- /dev/null
+++ b/drivers/perf/arm_cspmu/nvidia_cspmu.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES.
+ *
+ */
+
+/* Support for NVIDIA specific attributes. */
+
+#ifndef __NVIDIA_CSPMU_H__
+#define __NVIDIA_CSPMU_H__
+
+#include "arm_cspmu.h"
+
+/* Allocate NVIDIA descriptor. */
+int nv_cspmu_init_ops(struct arm_cspmu *cspmu);
+
+#endif /* __NVIDIA_CSPMU_H__ */
-- 
2.17.1

