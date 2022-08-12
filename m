Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9C35912B7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 17:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238816AbiHLPOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 11:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238923AbiHLPNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 11:13:52 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CE2A347F;
        Fri, 12 Aug 2022 08:13:49 -0700 (PDT)
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M46Z84FDHz689Nh;
        Fri, 12 Aug 2022 23:10:56 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Fri, 12 Aug 2022 17:13:47 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 12 Aug 2022 16:13:46 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <john.garry@huawei.com>, Peter Zijlstra <peterz@infradead.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [RFC PATCH 3/4] cxl: CXL Performance Monitoring Unit driver
Date:   Fri, 12 Aug 2022 16:12:13 +0100
Message-ID: <20220812151214.2025-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220812151214.2025-1-Jonathan.Cameron@huawei.com>
References: <20220812151214.2025-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CXL rev 3.0 introduces a standard performance monitoring hardware
block to CXL. Instances are discovered using CXL Register Locator DVSEC
entries. Each CXL component may have multiple PMUs.

This initial driver supports only a subset of types of counter.
It support counters that are either fixed or configurable, but requires
that they support the ability to freeze and write value whilst frozen.

Development done with QEMU model which will be posted shortly.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

--
RFC questions:
- Creation of the devices.  Currently hung off the cxl_pci driver.
  May want to rethink to avoid needing to replicate registration code
  for other CXL components.
- Needs more testing, but wanted to share early in case major refactoring
  needed.
- Where to put the driver. Previous discussions on similar drivers
  led to them being under drivers/perf (hisi_pcie_pmu)
- Whether to prefer the use of freeze for global counter enable or
  rely on the always supported per counter registers (one register
  write per counter) with reduced cross counter synchronization.
  Freeze is a multipurpose feature:
  - Hardware support stopping all counters on one counter overflowing
    so you can do fixed period counting across all counters.
    (we may want to enable this at some stage)
  - Freeze is also usable as a global enable as you can freeze all
    counters then enable them 'frozen', followed by unfreezing to
    start them counting.
  Either way, the optional nature of "writeable when frozen" means we
  will need to support the slow method too at some point as someone
  won't implement freeze on their device.
---
 drivers/cxl/Kconfig  |  12 +
 drivers/cxl/Makefile |   1 +
 drivers/cxl/cpmu.c   | 942 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 955 insertions(+)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 768ced3d6fe8..d9e6775c05a5 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -111,4 +111,16 @@ config CXL_REGION
 	select MEMREGION
 	select GET_FREE_REGION
 
+config CXL_CPMU
+	tristate "CXL Performance Monitoring Unit"
+	default CXL_BUS
+	help
+	  Support performance monitoring as defined in CXL rev 3.0
+	  section 13.2: Performance Monitoring. CXL components may have
+	  one or more CXL Performance Monitoring Units (CPMUs).
+
+	  Say 'y/m' to enable a driver that will attach to performance
+	  monitoring units and provide standard perf based interfaces.
+
+	  If unsure say 'm'.
 endif
diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
index a78270794150..f55c2751ac10 100644
--- a/drivers/cxl/Makefile
+++ b/drivers/cxl/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_CXL_MEM) += cxl_mem.o
 obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
 obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
 obj-$(CONFIG_CXL_PORT) += cxl_port.o
+obj-$(CONFIG_CXL_CPMU) += cpmu.o
 
 cxl_mem-y := mem.o
 cxl_pci-y := pci.o
diff --git a/drivers/cxl/cpmu.c b/drivers/cxl/cpmu.c
new file mode 100644
index 000000000000..f8cd7e55dab9
--- /dev/null
+++ b/drivers/cxl/cpmu.c
@@ -0,0 +1,942 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright(c) 2022 Huawei
+ *
+ * The CXL 3.0 specification includes a standard performance monitoring unit,
+ * called the CLX PMU, or CPMU. In order to allow a high degree of
+ * implementation flexibility the specification provides a wide range of
+ * options all of which are self describing.
+ *
+ * Details in CXL rev 3.0 section 8.2.7 CPMU Register Interface
+ *
+ * TODO:
+ * o May be useful to name some summed event groups. Figure out which.
+ *   CPMU event selection is based on summing of bitmaps of events within
+ *   a given event group. With a limited supply of configurable counters, this
+ *   provides flexibility between very specific events such as d2h_req_rdcurr
+ *   (one type of read request) or combining events counted by the hardware
+ *   counter to allow d2h_req_rd to be counted as sum of fine grained events
+ *   d2h_req_rd = d2h_req_rdcurr + d2h_req_rdown + d2h_req_rdshared +
+ *                d2h_req_rdany + d2h_req_rdownnodata
+ *   Thus d2h_req_rd requires one configurable counter instead of 5 if the
+ *   counters were summed in userspace.
+ *   Current interface allows userspace to specify the bitmap directly, but
+ *   it may make sense to provide explicit attributes for commonly used
+ *   combinations.
+ * o Support free running counters - copy the intel uncore PMU handling for these.
+ * o CPMUs which do not support freeze.
+ * o Add filter validation in cpmu_event_init() so problems are detected earlier.
+ * o Reject configurations that the hardware is ignoring
+ *   (e.g. invert when not invertable)
+ * o Support CPMUs with no interrupts using an HRTIMER.
+ */
+
+#include <linux/bitops.h>
+#include <linux/bits.h>
+#include <linux/bug.h>
+#include <linux/device.h>
+#include <linux/list.h>
+#include <linux/pci.h>
+#include <linux/perf_event.h>
+#include "cpmu.h"
+#include "cxl.h"
+
+/* CXL rev 3.0 Table 13-5 Events under CXL Vendor ID */
+#define CPMU_GID_CLOCK_TICKS		0x00
+#define CPMU_GID_D2H_REQ		0x0010
+#define CPMU_GID_D2H_RSP		0x0011
+#define CPMU_GID_H2D_REQ		0x0012
+#define CPMU_GID_H2D_RSP		0x0013
+#define CPMU_GID_CACHE_DATA		0x0014
+#define CPMU_GID_M2S_REQ		0x0020
+#define CPMU_GID_M2S_RWD		0x0021
+#define CPMU_GID_M2S_BIRSP		0x0022
+#define CPMU_GID_S2M_BISNP		0x0023
+#define CPMU_GID_S2M_NDR		0x0024
+#define CPMU_GID_S2M_DRS		0x0025
+#define CPMU_GID_DDR			0x8000
+
+static int cpmu_cpuhp_state_num;
+
+struct cpmu_event {
+	u16 vid;
+	u16 gid;
+	u32 msk;
+	bool configurable;
+	union {
+		int counter_idx; /* fixed counters */
+		int event_idx; /* configurable counters */
+	};
+	struct list_head node;
+};
+
+struct cpmu_info {
+	struct pmu pmu;
+	void __iomem *base;
+	struct perf_event **hw_events;
+	struct list_head cpmu_events;
+	DECLARE_BITMAP(conf_counter_bm, 32);
+	u16 counter_width;
+	u8 num_counters;
+	u8 num_event_capabilities;
+	int on_cpu;
+	struct hlist_node node;
+	bool freeze_for_enable;
+	bool filter_hdm;
+	int irq;
+};
+
+#define pmu_to_cpmu_info(_pmu) container_of(_pmu, struct cpmu_info, pmu)
+
+/*
+ * All CPMU counters are discoverable via the Event Capabilities Registers.
+ * Each Event Capability register contains a a VID / GroupID.
+ * A counter may then count any combination (by summing) of events in
+ * that group which are in the Supported Events Bitmask.
+ * However, there are some complexities to the scheme.
+ *  - Fixed function counters refer to an Event Capabilities register.
+ *    That event capability register is not then used for Configurable
+ *    counters.
+ * TODO: Support summed events.
+ */
+static int cpmu_parse_caps(struct device *dev, struct cpmu_info *info)
+{
+	DECLARE_BITMAP(fixed_counter_event_cap_bm, 32) = {0};
+	void __iomem *base = info->base;
+	u64 val, eval;
+	int i;
+
+	val = readq(base + CPMU_CAP_REG);
+	info->freeze_for_enable = FIELD_GET(CPMU_CAP_WRITEABLE_WHEN_FROZEN, val) &
+		FIELD_GET(CPMU_CAP_FREEZE, val);
+	if (!info->freeze_for_enable) {
+		dev_err(dev, "Driver does not support CPMUs that do not support freeze for enable\n");
+		return -ENODEV;
+	}
+
+	info->num_counters = FIELD_GET(CPMU_CAP_NUM_COUNTERS_MSK, val) + 1;
+	info->counter_width = FIELD_GET(CPMU_CAP_COUNTER_WIDTH_MSK, val);
+	info->num_event_capabilities = FIELD_GET(CPMU_CAP_NUM_EVN_CAP_REG_SUP_MSK, val) + 1;
+
+	info->filter_hdm = FIELD_GET(CPMU_CAP_FILTERS_SUP_MSK, val);
+	if (FIELD_GET(CPMU_CAP_INT, val))
+		info->irq = FIELD_GET(CPMU_CAP_MSI_N_MSK, val);
+	else
+		info->irq = -1;
+
+	/* First handle fixed function counters; note if configurable counters found */
+	for (i = 0; i < info->num_counters; i++) {
+		struct cpmu_event *cpmu_ev;
+		u32 events_msk;
+		u8 group_idx;
+
+		val = readq(base + CPMU_COUNTER_CFG_REG(i));
+
+		if (FIELD_GET(CPMU_COUNTER_CFG_TYPE_MSK, val) ==
+			CPMU_COUNTER_CFG_TYPE_CONFIGURABLE) {
+			set_bit(i, info->conf_counter_bm);
+		}
+
+		if (FIELD_GET(CPMU_COUNTER_CFG_TYPE_MSK, val) !=
+		    CPMU_COUNTER_CFG_TYPE_FIXED_FUN)
+			continue;
+
+		/* In this case we know which fields are const */
+		group_idx = FIELD_GET(CPMU_COUNTER_CFG_EVENT_GRP_ID_IDX_MSK, val);
+		events_msk = FIELD_GET(CPMU_COUNTER_CFG_EVENTS_MSK, val);
+		eval = readq(base + CPMU_EVENT_CAP_REG(group_idx));
+		cpmu_ev = devm_kzalloc(dev, sizeof(*cpmu_ev), GFP_KERNEL);
+		if (!cpmu_ev)
+			return -ENOMEM;
+
+		cpmu_ev->vid = FIELD_GET(CPMU_EVENT_CAP_VENDOR_ID_MSK, eval);
+		cpmu_ev->gid = FIELD_GET(CPMU_EVENT_CAP_GROUP_ID_MSK, eval);
+		/* For a fixed purpose counter use the events mask from the counter CFG */
+		cpmu_ev->msk = events_msk;
+		cpmu_ev->configurable = false;
+		cpmu_ev->counter_idx = i;
+		/* This list add is never unwound as all entries deleted on remove */
+		list_add(&cpmu_ev->node, &info->cpmu_events);
+		/*
+		 * Configurable counters must not use an Event Capability registers that
+		 * is in use for a Fixed counter
+		 */
+		set_bit(group_idx, fixed_counter_event_cap_bm);
+	}
+
+	if (info->conf_counter_bm) {
+		struct cpmu_event *cpmu_ev;
+		int j;
+		/* Walk event capabilities unused by fixed counters */
+		for_each_clear_bit(j, fixed_counter_event_cap_bm,
+				   info->num_event_capabilities) {
+			cpmu_ev = devm_kzalloc(dev, sizeof(*cpmu_ev), GFP_KERNEL);
+			if (!cpmu_ev)
+				return -ENOMEM;
+
+			eval = readq(base + CPMU_EVENT_CAP_REG(j));
+			cpmu_ev->vid = FIELD_GET(CPMU_EVENT_CAP_VENDOR_ID_MSK, eval);
+			cpmu_ev->gid = FIELD_GET(CPMU_EVENT_CAP_GROUP_ID_MSK, eval);
+			cpmu_ev->msk = FIELD_GET(CPMU_EVENT_CAP_SUPPORTED_EVENTS_MSK, eval);
+			cpmu_ev->event_idx = j;
+			cpmu_ev->configurable = true;
+			list_add(&cpmu_ev->node, &info->cpmu_events);
+		}
+	}
+
+	return 0;
+}
+
+static ssize_t cpmu_event_sysfs_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct perf_pmu_events_attr *pmu_attr =
+		container_of(attr, struct perf_pmu_events_attr, attr);
+
+	return sysfs_emit(buf, "config=%#llx\n", pmu_attr->id);
+}
+
+#define CPMU_PMU_EVENT_ATTR(_name, _vid, _gid, _msk)			\
+	PMU_EVENT_ATTR_ID(_name, cpmu_event_sysfs_show,			\
+			  ((u64)(_vid) << 48) | ((u64)(_gid) << 32) | (u64)(_msk))
+
+static struct attribute *cpmu_event_attrs[] = {
+	CPMU_PMU_EVENT_ATTR(clock_ticks,	0x1e98, CPMU_GID_CLOCK_TICKS, BIT(0)),
+	/* CXL rev 3.0 Table 3-17 - Device to Host Requests */
+	CPMU_PMU_EVENT_ATTR(d2h_req_rdcurr,		0x1e98, CPMU_GID_D2H_REQ, BIT(1)),
+	CPMU_PMU_EVENT_ATTR(d2h_req_rdown,		0x1e98, CPMU_GID_D2H_REQ, BIT(2)),
+	CPMU_PMU_EVENT_ATTR(d2h_req_rdshared,		0x1e98, CPMU_GID_D2H_REQ, BIT(3)),
+	CPMU_PMU_EVENT_ATTR(d2h_req_rdany,		0x1e98, CPMU_GID_D2H_REQ, BIT(4)),
+	CPMU_PMU_EVENT_ATTR(d2h_req_rdownnodata,	0x1e98, CPMU_GID_D2H_REQ, BIT(5)),
+	CPMU_PMU_EVENT_ATTR(d2h_req_itomwr,		0x1e98, CPMU_GID_D2H_REQ, BIT(6)),
+	CPMU_PMU_EVENT_ATTR(d2h_req_wrcurr,		0x1e98, CPMU_GID_D2H_REQ, BIT(7)),
+	CPMU_PMU_EVENT_ATTR(d2h_req_clflush,		0x1e98, CPMU_GID_D2H_REQ, BIT(8)),
+	CPMU_PMU_EVENT_ATTR(d2h_req_cleanevict,		0x1e98, CPMU_GID_D2H_REQ, BIT(9)),
+	CPMU_PMU_EVENT_ATTR(d2h_req_dirtyevict,		0x1e98, CPMU_GID_D2H_REQ, BIT(10)),
+	CPMU_PMU_EVENT_ATTR(d2h_req_cleanevictnodata,	0x1e98, CPMU_GID_D2H_REQ, BIT(11)),
+	CPMU_PMU_EVENT_ATTR(d2h_req_wowrinv,		0x1e98, CPMU_GID_D2H_REQ, BIT(12)),
+	CPMU_PMU_EVENT_ATTR(d2h_req_wowrinvf,		0x1e98, CPMU_GID_D2H_REQ, BIT(13)),
+	CPMU_PMU_EVENT_ATTR(d2h_req_wrinv,		0x1e98, CPMU_GID_D2H_REQ, BIT(14)),
+	CPMU_PMU_EVENT_ATTR(d2h_req_cacheflushed,	0x1e98, CPMU_GID_D2H_REQ, BIT(16)),
+	/* CXL rev 3.0 Table 3-20 - D2H Repsonse Encodings */
+	CPMU_PMU_EVENT_ATTR(d2h_rsp_rspihiti,		0x1e98, CPMU_GID_D2H_RSP, BIT(4)),
+	CPMU_PMU_EVENT_ATTR(d2h_rsp_rspvhitv,		0x1e98, CPMU_GID_D2H_RSP, BIT(6)),
+	CPMU_PMU_EVENT_ATTR(d2h_rsp_rspihitse,		0x1e98, CPMU_GID_D2H_RSP, BIT(5)),
+	CPMU_PMU_EVENT_ATTR(d2h_rsp_rspshitse,		0x1e98, CPMU_GID_D2H_RSP, BIT(1)),
+	CPMU_PMU_EVENT_ATTR(d2h_rsp_rspsfwdm,		0x1e98, CPMU_GID_D2H_RSP, BIT(7)),
+	CPMU_PMU_EVENT_ATTR(d2h_rsp_rspifwdm,		0x1e98, CPMU_GID_D2H_RSP, BIT(15)),
+	CPMU_PMU_EVENT_ATTR(d2h_rsp_rspvfwdv,		0x1e98, CPMU_GID_D2H_RSP, BIT(22)),
+	/* CXL rev 3.0 Table 3-21 - CXL.cache - Mapping of H2D Requests to D2H Responses */
+	CPMU_PMU_EVENT_ATTR(h2d_req_snpdata,		0x1e98, CPMU_GID_H2D_REQ, BIT(1)),
+	CPMU_PMU_EVENT_ATTR(h2d_req_snpinv,		0x1e98, CPMU_GID_H2D_REQ, BIT(2)),
+	CPMU_PMU_EVENT_ATTR(h2d_req_snpcur,		0x1e98, CPMU_GID_H2D_REQ, BIT(3)),
+	/* CXL rev 3.0 Table 3-22 - H2D Response Opcode Encodings */
+	CPMU_PMU_EVENT_ATTR(h2d_rsp_writepull,		0x1e98, CPMU_GID_H2D_RSP, BIT(1)),
+	CPMU_PMU_EVENT_ATTR(h2d_rsp_go,			0x1e98, CPMU_GID_H2D_RSP, BIT(4)),
+	CPMU_PMU_EVENT_ATTR(h2d_rsp_gowritepull,	0x1e98, CPMU_GID_H2D_RSP, BIT(5)),
+	CPMU_PMU_EVENT_ATTR(h2d_rsp_extcmp,		0x1e98, CPMU_GID_H2D_RSP, BIT(6)),
+	CPMU_PMU_EVENT_ATTR(h2d_rsp_gowritepulldrop,	0x1e98, CPMU_GID_H2D_RSP, BIT(8)),
+	CPMU_PMU_EVENT_ATTR(h2d_rsp_fastgowritepull,	0x1e98, CPMU_GID_H2D_RSP, BIT(13)),
+	CPMU_PMU_EVENT_ATTR(h2d_rsp_goerrwritepull,	0x1e98, CPMU_GID_H2D_RSP, BIT(15)),
+	/* CXL rev 3.0 Table 13-5 directly lists these */
+	CPMU_PMU_EVENT_ATTR(cachedata_d2h_data,		0x1e98, CPMU_GID_CACHE_DATA, BIT(0)),
+	CPMU_PMU_EVENT_ATTR(cachedata_h2d_data,		0x1e98, CPMU_GID_CACHE_DATA, BIT(1)),
+	/* CXL rev 3.0 Table 3-29 M2S Req Memory Opcodes */
+	CPMU_PMU_EVENT_ATTR(m2s_req_meminv,		0x1e98, CPMU_GID_M2S_REQ, BIT(0)),
+	CPMU_PMU_EVENT_ATTR(m2s_req_memrd,		0x1e98, CPMU_GID_M2S_REQ, BIT(1)),
+	CPMU_PMU_EVENT_ATTR(m2s_req_memrddata,		0x1e98, CPMU_GID_M2S_REQ, BIT(2)),
+	CPMU_PMU_EVENT_ATTR(m2s_req_memrdfwd,		0x1e98, CPMU_GID_M2S_REQ, BIT(3)),
+	CPMU_PMU_EVENT_ATTR(m2s_req_memwrfwd,		0x1e98, CPMU_GID_M2S_REQ, BIT(4)),
+	CPMU_PMU_EVENT_ATTR(m2s_req_memspecrd,		0x1e98, CPMU_GID_M2S_REQ, BIT(8)),
+	CPMU_PMU_EVENT_ATTR(m2s_req_meminvnt,		0x1e98, CPMU_GID_M2S_REQ, BIT(9)),
+	CPMU_PMU_EVENT_ATTR(m2s_req_memcleanevict,	0x1e98, CPMU_GID_M2S_REQ, BIT(10)),
+	/* CXL rev 3.0 Table 3-35 M2S RwD Memory Opcodes */
+	CPMU_PMU_EVENT_ATTR(m2s_rwd_memwr,		0x1e98, CPMU_GID_M2S_RWD, BIT(1)),
+	CPMU_PMU_EVENT_ATTR(m2s_rwd_memwrptl,		0x1e98, CPMU_GID_M2S_RWD, BIT(2)),
+	CPMU_PMU_EVENT_ATTR(m2s_rwd_biconflict,		0x1e98, CPMU_GID_M2S_RWD, BIT(4)),
+	/* CXL rev 3.0 Table 3-38 M2S BIRsp Memory Opcodes */
+	CPMU_PMU_EVENT_ATTR(m2s_birsp_i,		0x1e98, CPMU_GID_M2S_BIRSP, BIT(0)),
+	CPMU_PMU_EVENT_ATTR(m2s_birsp_s,		0x1e98, CPMU_GID_M2S_BIRSP, BIT(1)),
+	CPMU_PMU_EVENT_ATTR(m2s_birsp_e,		0x1e98, CPMU_GID_M2S_BIRSP, BIT(2)),
+	CPMU_PMU_EVENT_ATTR(m2s_birsp_iblk,		0x1e98, CPMU_GID_M2S_BIRSP, BIT(4)),
+	CPMU_PMU_EVENT_ATTR(m2s_birsp_sblk,		0x1e98, CPMU_GID_M2S_BIRSP, BIT(5)),
+	CPMU_PMU_EVENT_ATTR(m2s_birsp_eblk,		0x1e98, CPMU_GID_M2S_BIRSP, BIT(6)),
+	/* CXL rev 3.0 Table 3-40 S2M BISnp Opcodes */
+	CPMU_PMU_EVENT_ATTR(s2m_bisnp_cur,		0x1e98, CPMU_GID_S2M_BISNP, BIT(0)),
+	CPMU_PMU_EVENT_ATTR(s2m_bisnp_data,		0x1e98, CPMU_GID_S2M_BISNP, BIT(1)),
+	CPMU_PMU_EVENT_ATTR(s2m_bisnp_inv,		0x1e98, CPMU_GID_S2M_BISNP, BIT(2)),
+	CPMU_PMU_EVENT_ATTR(s2m_bisnp_curblk,		0x1e98, CPMU_GID_S2M_BISNP, BIT(4)),
+	CPMU_PMU_EVENT_ATTR(s2m_bisnp_datblk,		0x1e98, CPMU_GID_S2M_BISNP, BIT(5)),
+	CPMU_PMU_EVENT_ATTR(s2m_bisnp_invblk,		0x1e98, CPMU_GID_S2M_BISNP, BIT(6)),
+	/* CXL rev 3.0 Table 3-43 S2M NDR Opcopdes */
+	CPMU_PMU_EVENT_ATTR(s2m_ndr_cmp,		0x1e98, CPMU_GID_S2M_NDR, BIT(0)),
+	CPMU_PMU_EVENT_ATTR(s2m_ndr_cmps,		0x1e98, CPMU_GID_S2M_NDR, BIT(1)),
+	CPMU_PMU_EVENT_ATTR(s2m_ndr_cmpe,		0x1e98, CPMU_GID_S2M_NDR, BIT(2)),
+	CPMU_PMU_EVENT_ATTR(s2m_ndr_biconflictack,	0x1e98, CPMU_GID_S2M_NDR, BIT(3)),
+	/* CXL rev 3.0 Table 3-46 S2M DRS opcodes */
+	CPMU_PMU_EVENT_ATTR(s2m_drs_memdata,		0x1e98, CPMU_GID_S2M_DRS, BIT(0)),
+	CPMU_PMU_EVENT_ATTR(s2m_drs_memdatanxm,		0x1e98, CPMU_GID_S2M_DRS, BIT(1)),
+	/* CXL rev 3.0 Table 13-5 directly lists these */
+	CPMU_PMU_EVENT_ATTR(ddr_act,			0x1e98, CPMU_GID_DDR, BIT(0)),
+	CPMU_PMU_EVENT_ATTR(ddr_pre,			0x1e98, CPMU_GID_DDR, BIT(1)),
+	CPMU_PMU_EVENT_ATTR(ddr_casrd,			0x1e98, CPMU_GID_DDR, BIT(2)),
+	CPMU_PMU_EVENT_ATTR(ddr_caswr,			0x1e98, CPMU_GID_DDR, BIT(3)),
+	CPMU_PMU_EVENT_ATTR(ddr_refresh,		0x1e98, CPMU_GID_DDR, BIT(4)),
+	CPMU_PMU_EVENT_ATTR(ddr_selfrefreshent,		0x1e98, CPMU_GID_DDR, BIT(5)),
+	CPMU_PMU_EVENT_ATTR(ddr_rfm,			0x1e98, CPMU_GID_DDR, BIT(6)),
+	NULL
+};
+
+static umode_t cpmu_event_is_visible(struct kobject *kobj, struct attribute *attr, int a)
+{
+	struct device_attribute *dev_attr = container_of(attr, struct device_attribute, attr);
+	struct perf_pmu_events_attr *pmu_attr =
+		container_of(dev_attr, struct perf_pmu_events_attr, attr);
+	struct device *dev = kobj_to_dev(kobj);
+	struct cpmu_info *info = dev_get_drvdata(dev);
+	struct cpmu_event *cpmu_ev;
+	int match_vid = FIELD_GET(GENMASK(63, 48), pmu_attr->id);
+	int match_gid = FIELD_GET(GENMASK(47, 32), pmu_attr->id);
+	int match_msk = FIELD_GET(GENMASK(31, 0), pmu_attr->id);
+
+	list_for_each_entry(cpmu_ev, &info->cpmu_events, node) {
+		if (match_vid != cpmu_ev->vid || match_gid != cpmu_ev->gid)
+			continue;
+
+		if (!cpmu_ev->configurable) {
+			/* Precise match for fixed counter */
+			if (match_msk == cpmu_ev->msk)
+				return attr->mode;
+		} else {
+			/* Request mask must be subset of supported */
+			if (!(match_msk & ~cpmu_ev->msk))
+				return attr->mode;
+		}
+	}
+
+	return 0;
+}
+
+static const struct attribute_group cpmu_events = {
+	.name = "events",
+	.attrs = cpmu_event_attrs,
+	.is_visible = cpmu_event_is_visible,
+};
+
+static ssize_t cpmu_format_sysfs_show(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	struct dev_ext_attribute *eattr;
+
+	eattr = container_of(attr, struct dev_ext_attribute, attr);
+
+	return sysfs_emit(buf, "%s\n", (char *)eattr->var);
+}
+
+#define CPMU_FORMAT_ATTR(_name, _format)\
+	(&((struct dev_ext_attribute[]) {				\
+		{							\
+			.attr = __ATTR(_name, 0444,			\
+				       cpmu_format_sysfs_show, NULL),	\
+			.var = (void *)_format				\
+		}							  \
+		})[0].attr.attr)
+
+enum {
+	cpmu_mask_attr,
+	cpmu_gid_attr,
+	cpmu_vid_attr,
+	cpmu_threshold_attr,
+	cpmu_invert_attr,
+	cpmu_edge_attr,
+	cpmu_hdm_filter_en_attr,
+	cpmu_hdm_attr,
+};
+
+static struct attribute *cpmu_format_attr[] = {
+	[cpmu_mask_attr] = CPMU_FORMAT_ATTR(mask, "config:0-31"),
+	[cpmu_gid_attr] = CPMU_FORMAT_ATTR(gid, "config:32-47"),
+	[cpmu_vid_attr] = CPMU_FORMAT_ATTR(vid, "config:48-63"),
+	[cpmu_threshold_attr] = CPMU_FORMAT_ATTR(threshold, "config1:0-15"),
+	[cpmu_invert_attr] = CPMU_FORMAT_ATTR(invert, "config1:16"),
+	[cpmu_edge_attr] = CPMU_FORMAT_ATTR(edge, "config1:17"),
+	[cpmu_hdm_filter_en_attr] = CPMU_FORMAT_ATTR(hdm_filter_en, "config1:18"),
+	[cpmu_hdm_attr] = CPMU_FORMAT_ATTR(hdm, "config2:0-15"),
+	NULL
+};
+
+static umode_t cpmu_format_is_visible(struct kobject *kobj, struct attribute *attr, int a)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct cpmu_info *info = dev_get_drvdata(dev);
+
+	/*
+	 * Filter capability at the CPMU level, so hide the attributes if the particular
+	 * filter is not supported.
+	 */
+	if (attr == cpmu_format_attr[cpmu_hdm_filter_en_attr] ||
+	    attr == cpmu_format_attr[cpmu_hdm_attr]) {
+		if (info->filter_hdm)
+			return 0444;
+		else
+			return 0;
+	} else {
+		return 0444;
+	}
+}
+
+static const struct attribute_group cpmu_format_group = {
+	.name = "format",
+	.attrs = cpmu_format_attr,
+	.is_visible = cpmu_format_is_visible,
+};
+
+static u32 cpmu_config_get_mask(struct perf_event *event)
+{
+	return FIELD_GET(GENMASK(31, 0), event->attr.config);
+}
+
+static u16 cpmu_config_get_gid(struct perf_event *event)
+{
+	return FIELD_GET(GENMASK(47, 32), event->attr.config);
+}
+
+static u16 cpmu_config_get_vid(struct perf_event *event)
+{
+	return FIELD_GET(GENMASK(63, 48), event->attr.config);
+}
+
+static u8 cpmu_config1_get_threshold(struct perf_event *event)
+{
+	return FIELD_GET(GENMASK(15, 0), event->attr.config1);
+}
+
+static bool cpmu_config1_get_invert(struct perf_event *event)
+{
+	return FIELD_GET(BIT(16), event->attr.config1);
+}
+
+static bool cpmu_config1_get_edge(struct perf_event *event)
+{
+	return FIELD_GET(BIT(17), event->attr.config1);
+}
+
+/*
+ * CPMU specification allows for 8 filters, each with a 16 bit value...
+ * So we need to find 8x16bits to store it in.
+ * So far only one filter has been defined - HDM Decoder.
+ * As the value used for disable is 0xffff, a separate enable switch
+ * is needed.
+ */
+
+static bool cpmu_config1_hdm_filter_en(struct perf_event *event)
+{
+	return FIELD_GET(BIT(14), event->attr.config1);
+}
+
+static u16 cpmu_config2_get_hdm_decoder(struct perf_event *event)
+{
+	return FIELD_GET(GENMASK(15, 0), event->attr.config2);
+}
+
+static ssize_t cpumask_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	struct cpmu_info *info = dev_get_drvdata(dev);
+
+	return cpumap_print_to_pagebuf(true, buf, cpumask_of(info->on_cpu));
+}
+static DEVICE_ATTR_RO(cpumask);
+
+static struct attribute *cpmu_cpumask_attrs[] = {
+	&dev_attr_cpumask.attr,
+	NULL
+};
+
+static const struct attribute_group cpmu_cpumask_group = {
+	.attrs = cpmu_cpumask_attrs,
+};
+
+static const struct attribute_group *cpmu_attr_groups[] = {
+	&cpmu_events,
+	&cpmu_format_group,
+	&cpmu_cpumask_group,
+	NULL
+};
+
+static int cpmu_event_init(struct perf_event *event)
+{
+	struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
+
+	event->cpu = info->on_cpu;
+	/* Top level type sanity check - is this a Hardware Event being requested */
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
+	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
+		return -EOPNOTSUPP;
+	/* TODO: Validation of any filter */
+
+	return 0;
+}
+
+static void cpmu_pmu_enable(struct pmu *pmu)
+{
+	struct cpmu_info *info = pmu_to_cpmu_info(pmu);
+	void __iomem *base = info->base;
+	int num;
+
+	/* We don't have a global enable, but we 'might' have a global freeze which we can use */
+	if (info->freeze_for_enable) {
+		/* Check if something is enabled */
+		for (num = 0; num < info->num_counters; num++) {
+			if (info->hw_events[num])
+				break;
+		}
+		if (num == info->num_counters)
+			return;
+
+		/* Can assume frozen at this stage */
+		writeq(0, base + CPMU_FREEZE_REG);
+
+		return;
+	}
+}
+
+static void cpmu_pmu_disable(struct pmu *pmu)
+{
+	struct cpmu_info *info = pmu_to_cpmu_info(pmu);
+	void __iomem *base = info->base;
+
+	if (info->freeze_for_enable) {
+		/*
+		 * Whilst bits above number of counters are RsvdZ
+		 * they are unlikely to be repurposed given
+		 * number of counters is allowed be 64 leaving
+		 * no reserved bits.  Hence this is only slightly
+		 * naughty.
+		 */
+		writeq(GENMASK(63, 0), base + CPMU_FREEZE_REG);
+		return;
+	}
+}
+
+static int cpmu_find_matching_event_cap(struct cpmu_info *info,
+					struct perf_event *event)
+{
+	struct cpmu_event *cpmu_ev;
+	u16 gid = cpmu_config_get_gid(event);
+	u16 vid = cpmu_config_get_vid(event);
+	u32 mask = cpmu_config_get_mask(event);
+
+	list_for_each_entry(cpmu_ev, &info->cpmu_events, node) {
+		if (vid != cpmu_ev->vid || gid != cpmu_ev->gid)
+			continue;
+
+		if (~cpmu_ev->msk & mask)
+			break;
+		return cpmu_ev->event_idx;
+	}
+
+	return -EINVAL;
+}
+
+static void cpmu_event_start(struct perf_event *event, int flags)
+{
+	struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	void __iomem *base = info->base;
+	u64 cfg;
+	u64 prev_cnt;
+
+	if (WARN_ON_ONCE(!(hwc->state & PERF_HES_STOPPED)))
+		return;
+
+	WARN_ON_ONCE(!(hwc->state & PERF_HES_UPTODATE));
+	hwc->state = 0;
+
+	/*
+	 * Currently only hdm filter is defined, this code will
+	 * want generalizing when more are defined.
+	 */
+	if (info->filter_hdm) {
+		if (cpmu_config1_hdm_filter_en(event))
+			cfg = cpmu_config2_get_hdm_decoder(event);
+
+		else
+			cfg = GENMASK(15, 0);
+		writeq(cfg, base + CPMU_FILTER_CFG_REG(hwc->idx, 0));
+	}
+
+	cfg = readq(base + CPMU_COUNTER_CFG_REG(hwc->idx));
+	cfg |= FIELD_PREP(CPMU_COUNTER_CFG_INT_ON_OVRFLW, 1);
+	cfg |= FIELD_PREP(CPMU_COUNTER_CFG_ENABLE, 1);
+	cfg |= FIELD_PREP(CPMU_COUNTER_CFG_EDGE, cpmu_config1_get_edge(event) ? 1 : 0);
+	cfg |= FIELD_PREP(CPMU_COUNTER_CFG_INVERT, cpmu_config1_get_invert(event) ? 1 : 0);
+
+	/* Fixed purpose counters have next two fields RO */
+	if (test_bit(hwc->idx, info->conf_counter_bm)) {
+		int event_idx = cpmu_find_matching_event_cap(info, event);
+
+		if (event_idx < 0) {
+			dev_dbg(info->pmu.dev, "Could not find matching event capability\n");
+			return;
+		}
+		cfg |= FIELD_PREP(CPMU_COUNTER_CFG_EVENT_GRP_ID_IDX_MSK, event_idx);
+		cfg |= FIELD_PREP(CPMU_COUNTER_CFG_EVENTS_MSK, cpmu_config_get_mask(event));
+	}
+	cfg &= ~CPMU_COUNTER_CFG_THRESHOLD_MSK;
+	/*
+	 * For events that generate only 1 count per clock the CXL 3.0 spec
+	 * states the threshold shall be set to 1 but if set to 0 it will
+	 * count the raw value anwyay?
+	 * There is definition ofwhat events will count multiple per cycle
+	 * and hence to which non 1 values of threshold can apply.
+	 * (CXL 3.0 8.2.7.2.1 Counter Configuration - threshold field definition)
+	 */
+	cfg |= FIELD_PREP(CPMU_COUNTER_CFG_THRESHOLD_MSK,
+			  cpmu_config1_get_threshold(event));
+	writeq(cfg, base + CPMU_COUNTER_CFG_REG(hwc->idx));
+
+	local64_set(&hwc->prev_count, 0);
+	writeq(0, base + CPMU_COUNTER_REG(hwc->idx));
+
+	if (flags & PERF_EF_RELOAD) {
+		prev_cnt = local64_read(&hwc->prev_count);
+		writeq(prev_cnt, base + CPMU_COUNTER_REG(hwc->idx));
+	}
+
+	perf_event_update_userpage(event);
+}
+
+static u64 cpmu_read_counter(struct perf_event *event)
+{
+	struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
+	void __iomem *base = info->base;
+
+	return readq(base + CPMU_COUNTER_REG(event->hw.idx));
+}
+
+static void __cpmu_read(struct perf_event *event, bool overflow)
+{
+	struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	u64 new_cnt, prev_cnt, delta;
+
+	do {
+		prev_cnt = local64_read(&hwc->prev_count);
+		new_cnt = cpmu_read_counter(event);
+	} while (local64_cmpxchg(&hwc->prev_count, prev_cnt, new_cnt) != prev_cnt);
+
+	/*
+	 * If we know an overflow occur then take that into account.
+	 * Note counter is not reset as that would lose events
+	 */
+	delta = (new_cnt - prev_cnt) & GENMASK(info->counter_width - 1, 0);
+	if (overflow && delta < GENMASK(info->counter_width - 1, 0))
+		delta += (1UL << info->counter_width);
+
+	local64_add(delta, &event->count);
+}
+
+static void cpmu_read(struct perf_event *event)
+{
+	__cpmu_read(event, false);
+}
+
+static void cpmu_event_stop(struct perf_event *event, int flags)
+{
+	struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
+	void __iomem *base = info->base;
+	struct hw_perf_event *hwc = &event->hw;
+	u64 cfg;
+
+	cpmu_read(event);
+	WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
+	hwc->state |= PERF_HES_STOPPED;
+
+	cfg = readq(base + CPMU_COUNTER_CFG_REG(hwc->idx));
+	cfg &= ~(FIELD_PREP(CPMU_COUNTER_CFG_INT_ON_OVRFLW, 1) |
+		 FIELD_PREP(CPMU_COUNTER_CFG_ENABLE, 1));
+	writeq(cfg, base + CPMU_COUNTER_CFG_REG(hwc->idx));
+
+	if (hwc->state & PERF_HES_UPTODATE)
+		return;
+
+	hwc->state |= PERF_HES_UPTODATE;
+}
+
+static int cpmu_get_event_idx(struct perf_event *event)
+{
+	struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
+	struct cpmu_event *cpmu_ev;
+	u32 mask;
+	u16 gid, vid;
+
+	vid = cpmu_config_get_vid(event);
+	gid = cpmu_config_get_gid(event);
+	mask = cpmu_config_get_mask(event);
+
+	list_for_each_entry(cpmu_ev, &info->cpmu_events, node) {
+		int idx;
+
+		if (vid != cpmu_ev->vid || gid != cpmu_ev->gid)
+			continue;
+
+		/*
+		 * For fixed counters, must match exactly.
+		 * No need to support duplicates so if first in use
+		 * return an error.
+		 */
+		if (!cpmu_ev->configurable) {
+			if (cpmu_ev->msk != mask)
+				continue;
+			if (info->hw_events[cpmu_ev->counter_idx])
+				return -EINVAL;
+
+			return cpmu_ev->counter_idx;
+		}
+
+		/* Requested mask needs to be subset of available */
+		if (~cpmu_ev->msk & mask)
+			continue;
+
+		/* Found the group, now see if any configurable counters left */
+		for_each_set_bit(idx, info->conf_counter_bm, 64) {
+			if (!info->hw_events[idx])
+				return idx;
+		}
+	}
+
+	return -EINVAL;
+}
+
+/*
+ * Reset ensures no possibility of any information leaking to wrong
+ * counter. Note that all fields written during start()
+ */
+static void cpmu_reset_counter(struct cpmu_info *info, int idx)
+{
+	void __iomem *base = info->base;
+
+	/* Much of this register is read only */
+	writeq(0, base + CPMU_EVENT_CAP_REG(idx));
+	/* Filters are not per counter, so not reset here */
+	writeq(0, base + CPMU_COUNTER_REG(idx));
+}
+
+static int cpmu_event_add(struct perf_event *event, int flags)
+{
+	struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	int idx;
+
+	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
+
+	idx = cpmu_get_event_idx(event);
+	if (idx < 0)
+		return idx;
+
+	hwc->idx = idx;
+	info->hw_events[idx] = event;
+
+	cpmu_reset_counter(info, idx);
+
+	if (flags & PERF_EF_START)
+		cpmu_event_start(event, PERF_EF_RELOAD);
+
+	return 0;
+}
+
+static void cpmu_event_del(struct perf_event *event, int flags)
+{
+	struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+
+	cpmu_event_stop(event, PERF_EF_UPDATE);
+	info->hw_events[hwc->idx] = NULL;
+	perf_event_update_userpage(event);
+}
+
+static irqreturn_t cpmu_irq(int irq, void *data)
+{
+	struct cpmu_info *info = data;
+	void __iomem *base = info->base;
+	unsigned long overflowed;
+	int i;
+
+	overflowed = readq(base + CPMU_OVERFLOW_REG);
+
+	/* Interrupt may be shared, so maybe it isn't ours */
+	if (!overflowed)
+		return IRQ_NONE;
+
+	for_each_set_bit(i, &overflowed, info->num_counters) {
+		struct perf_event *event = info->hw_events[i];
+
+		if (!event) {
+			dev_dbg(info->pmu.dev,
+				"overflow but on non enabled counter %d\n", i);
+			continue;
+		}
+
+		__cpmu_read(event, true);
+	}
+
+	writeq(overflowed, base + CPMU_OVERFLOW_REG);
+
+	return IRQ_HANDLED;
+}
+
+static int cxl_cpmu_probe(struct device *dev)
+{
+	struct cxl_cpmu *cpmu = to_cxl_cpmu(dev);
+	struct pci_dev *pdev = to_pci_dev(dev->parent);
+	struct cpmu_info *info;
+	char *irq_name;
+	int rc, irq;
+
+	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&info->cpmu_events);
+
+	info->base = cpmu->base;
+
+	info->on_cpu = -1;
+	rc = cpmu_parse_caps(dev, info);
+	if (rc)
+		return rc;
+
+	info->hw_events = devm_kcalloc(dev, sizeof(*info->hw_events),
+				       info->num_counters, GFP_KERNEL);
+	if (!info->hw_events)
+		return -ENOMEM;
+
+	info->pmu = (struct pmu) {
+		.name = dev_name(dev),
+		.module = THIS_MODULE,
+		.event_init = cpmu_event_init,
+		.pmu_enable = cpmu_pmu_enable,
+		.pmu_disable = cpmu_pmu_disable,
+		.add = cpmu_event_add,
+		.del = cpmu_event_del,
+		.start = cpmu_event_start,
+		.stop = cpmu_event_stop,
+		.read = cpmu_read,
+		.task_ctx_nr = perf_invalid_context,
+		.attr_groups = cpmu_attr_groups,
+		.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
+	};
+
+	if (info->irq <= 0)
+		return -EINVAL;
+
+
+	rc = pci_irq_vector(pdev, info->irq);
+	if (rc < 0)
+		return rc;
+	irq = rc;
+
+	irq_name = devm_kasprintf(dev, GFP_KERNEL, "%s_overflow\n", dev_name(dev));
+	if (!irq_name)
+		return -ENOMEM;
+
+	rc = devm_request_irq(dev, irq, cpmu_irq, IRQF_SHARED, irq_name, info);
+	if (rc)
+		return rc;
+	info->irq = irq;
+
+	rc = cpuhp_state_add_instance(cpmu_cpuhp_state_num, &info->node);
+	if (rc)
+		return rc;
+
+	rc = perf_pmu_register(&info->pmu, info->pmu.name, -1);
+	if (rc)
+		return rc;
+
+	dev_set_drvdata(dev, info);
+
+	return 0;
+}
+
+static void cxl_cpmu_remove(struct device *dev)
+{
+	struct cpmu_info *info = dev_get_drvdata(dev);
+
+	perf_pmu_unregister(&info->pmu);
+	cpuhp_state_remove_instance_nocalls(cpmu_cpuhp_state_num, &info->node);
+}
+
+static struct cxl_driver cxl_cpmu_driver = {
+	.name = "cxl_cpmu",
+	.probe = cxl_cpmu_probe,
+	.remove = cxl_cpmu_remove,
+	.id = CXL_DEVICE_CPMU,
+};
+
+static int cpmu_online_cpu(unsigned int cpu, struct hlist_node *node)
+{
+	struct cpmu_info *info = hlist_entry_safe(node, struct cpmu_info, node);
+
+	if (info->on_cpu != -1)
+		return 0;
+
+	info->on_cpu = cpu;
+	WARN_ON(irq_set_affinity(info->irq, cpumask_of(cpu)));
+
+	return 0;
+}
+
+static int cpmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
+{
+	struct cpmu_info *info = hlist_entry_safe(node, struct cpmu_info, node);
+	unsigned int target;
+
+	if (info->on_cpu != cpu)
+		return 0;
+
+	info->on_cpu = -1;
+	target = cpumask_first(cpu_online_mask);
+	if (target >= nr_cpu_ids) {
+		dev_err(info->pmu.dev, "Unable to find a suitable CPU\n");
+		return 0;
+	}
+
+	perf_pmu_migrate_context(&info->pmu, cpu, target);
+	info->on_cpu = target;
+	WARN_ON(irq_set_affinity(info->irq, cpumask_of(target)));
+
+	return 0;
+}
+
+static __init int cxl_cpmu_init(void)
+{
+	int rc;
+
+	rc = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
+				     "AP_PERF_CPMU_ONLINE",
+				     cpmu_online_cpu, cpmu_offline_cpu);
+	if (rc < 0)
+		return rc;
+	cpmu_cpuhp_state_num = rc;
+
+	rc = cxl_driver_register(&cxl_cpmu_driver);
+	if (rc)
+		cpuhp_remove_multi_state(cpmu_cpuhp_state_num);
+
+	return rc;
+}
+
+static __exit void cxl_cpmu_exit(void)
+{
+	cxl_driver_unregister(&cxl_cpmu_driver);
+	cpuhp_remove_multi_state(cpmu_cpuhp_state_num);
+}
+
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(CXL);
+module_init(cxl_cpmu_init);
+module_exit(cxl_cpmu_exit);
-- 
2.32.0

