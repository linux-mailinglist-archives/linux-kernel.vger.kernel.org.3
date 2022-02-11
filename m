Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46EC04B1D7D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 05:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245415AbiBKEyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 23:54:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244157AbiBKEyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 23:54:13 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436162637;
        Thu, 10 Feb 2022 20:54:12 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21AMmBYb013177;
        Thu, 10 Feb 2022 20:54:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=yc6IiaGyFexbGpLCcGtmANWMJV1hO6YeYjb6Ijl0Wr0=;
 b=YF7ZMA/hPiUDHiQloBPFDKy1vcI4mqCea2tzs78DpEbMI6y9AJbGoWbryg3+R+MhzEOa
 eSchEihLXm5Mdvu2SKBbxGsrcbofcDCZ6LPp8AxJNt1KeCxcMyuhkFS4lgGYGU+Oegcz
 UMc4PHR/Kq8FO4tJjuFIR1Ag3wg0RRThUSx5diqoE4M/2g3DSA7jxwK03y6G59dlJFfN
 GgJEX43M5QGcXxs3slF74ikOeZlPydOww3EUBJrUXhknNFW3Jo3VWzWEyFiQcOaQ/73X
 pi1cp46rhw40CgJfTAyROLu4C5256F5uSqaEe6G9mlPmCYnAYRFNWkreilz5HNyTCbyM Iw== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3e5134c3cb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 10 Feb 2022 20:54:01 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 10 Feb
 2022 20:53:59 -0800
Received: from bbhushan2.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 10 Feb 2022 20:53:56 -0800
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <bbudiredla@marvell.com>, <sgoutham@marvell.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Bharat Bhushan <bbhushan2@marvell.com>
Subject: [PATCH v8 2/4] perf/marvell: CN10k DDR performance monitor support
Date:   Fri, 11 Feb 2022 10:23:44 +0530
Message-ID: <20220211045346.17894-3-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220211045346.17894-1-bbhushan2@marvell.com>
References: <20220211045346.17894-1-bbhushan2@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: CMGVa_xouwmSSLruvG2XNz799Qc94Our
X-Proofpoint-ORIG-GUID: CMGVa_xouwmSSLruvG2XNz799Qc94Our
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-11_01,2022-02-09_01,2021-12-02_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marvell CN10k DRAM Subsystem (DSS) supports eight event counters for
monitoring performance and software can program each counter to monitor
any of the defined performance event. Performance events are for
interface between the DDR controller and the PHY, interface between the
DDR Controller and the CHI interconnect, or within the DDR Controller.
Additionally DSS also supports two fixed performance event counters, one
for number of ddr reads and other for ddr writes.

This patch add basic support for these performance monitoring events
on CN10k.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
Reviewed-by: Bhaskara Budiredla <bbudiredla@marvell.com>
---
v7->v8:
 - Fixed warning when W=1 and CONFIG_OF=n

 drivers/perf/Makefile                |   1 +
 drivers/perf/marvell_cn10k_ddr_pmu.c | 601 +++++++++++++++++++++++++++
 2 files changed, 602 insertions(+)
 create mode 100644 drivers/perf/marvell_cn10k_ddr_pmu.c

diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index 2db5418d5b0a..df52fb5ea2a6 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -15,3 +15,4 @@ obj-$(CONFIG_XGENE_PMU) += xgene_pmu.o
 obj-$(CONFIG_ARM_SPE_PMU) += arm_spe_pmu.o
 obj-$(CONFIG_ARM_DMC620_PMU) += arm_dmc620_pmu.o
 obj-$(CONFIG_MARVELL_CN10K_TAD_PMU) += marvell_cn10k_tad_pmu.o
+obj-$(CONFIG_MARVELL_CN10K_DDR_PMU) += marvell_cn10k_ddr_pmu.o
diff --git a/drivers/perf/marvell_cn10k_ddr_pmu.c b/drivers/perf/marvell_cn10k_ddr_pmu.c
new file mode 100644
index 000000000000..d93268943e23
--- /dev/null
+++ b/drivers/perf/marvell_cn10k_ddr_pmu.c
@@ -0,0 +1,601 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell CN10K DRAM Subsystem (DSS) Performance Monitor Driver
+ *
+ * Copyright (C) 2021 Marvell.
+ */
+
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/perf_event.h>
+
+/* Performance Counters Operating Mode Control Registers */
+#define DDRC_PERF_CNT_OP_MODE_CTRL	0x8020
+#define OP_MODE_CTRL_VAL_MANNUAL	0x1
+
+/* Performance Counters Start Operation Control Registers */
+#define DDRC_PERF_CNT_START_OP_CTRL	0x8028
+#define START_OP_CTRL_VAL_START		0x1ULL
+#define START_OP_CTRL_VAL_ACTIVE	0x2
+
+/* Performance Counters End Operation Control Registers */
+#define DDRC_PERF_CNT_END_OP_CTRL	0x8030
+#define END_OP_CTRL_VAL_END		0x1ULL
+
+/* Performance Counters End Status Registers */
+#define DDRC_PERF_CNT_END_STATUS		0x8038
+#define END_STATUS_VAL_END_TIMER_MODE_END	0x1
+
+/* Performance Counters Configuration Registers */
+#define DDRC_PERF_CFG_BASE		0x8040
+
+/* 8 Generic event counter + 2 fixed event counters */
+#define DDRC_PERF_NUM_GEN_COUNTERS	8
+#define DDRC_PERF_NUM_FIX_COUNTERS	2
+#define DDRC_PERF_READ_COUNTER_IDX	DDRC_PERF_NUM_GEN_COUNTERS
+#define DDRC_PERF_WRITE_COUNTER_IDX	(DDRC_PERF_NUM_GEN_COUNTERS + 1)
+#define DDRC_PERF_NUM_COUNTERS		(DDRC_PERF_NUM_GEN_COUNTERS + \
+					 DDRC_PERF_NUM_FIX_COUNTERS)
+
+/* Generic event counter registers */
+#define DDRC_PERF_CFG(n)		(DDRC_PERF_CFG_BASE + 8 * (n))
+#define EVENT_ENABLE			BIT_ULL(63)
+
+/* Two dedicated event counters for DDR reads and writes */
+#define EVENT_DDR_READS			101
+#define EVENT_DDR_WRITES		100
+
+/*
+ * programmable events IDs in programmable event counters.
+ * DO NOT change these event-id numbers, they are used to
+ * program event bitmap in h/w.
+ */
+#define EVENT_OP_IS_ZQLATCH			55
+#define EVENT_OP_IS_ZQSTART			54
+#define EVENT_OP_IS_TCR_MRR			53
+#define EVENT_OP_IS_DQSOSC_MRR			52
+#define EVENT_OP_IS_DQSOSC_MPC			51
+#define EVENT_VISIBLE_WIN_LIMIT_REACHED_WR	50
+#define EVENT_VISIBLE_WIN_LIMIT_REACHED_RD	49
+#define EVENT_BSM_STARVATION			48
+#define EVENT_BSM_ALLOC				47
+#define EVENT_LPR_REQ_WITH_NOCREDIT		46
+#define EVENT_HPR_REQ_WITH_NOCREDIT		45
+#define EVENT_OP_IS_ZQCS			44
+#define EVENT_OP_IS_ZQCL			43
+#define EVENT_OP_IS_LOAD_MODE			42
+#define EVENT_OP_IS_SPEC_REF			41
+#define EVENT_OP_IS_CRIT_REF			40
+#define EVENT_OP_IS_REFRESH			39
+#define EVENT_OP_IS_ENTER_MPSM			35
+#define EVENT_OP_IS_ENTER_POWERDOWN		31
+#define EVENT_OP_IS_ENTER_SELFREF		27
+#define EVENT_WAW_HAZARD			26
+#define EVENT_RAW_HAZARD			25
+#define EVENT_WAR_HAZARD			24
+#define EVENT_WRITE_COMBINE			23
+#define EVENT_RDWR_TRANSITIONS			22
+#define EVENT_PRECHARGE_FOR_OTHER		21
+#define EVENT_PRECHARGE_FOR_RDWR		20
+#define EVENT_OP_IS_PRECHARGE			19
+#define EVENT_OP_IS_MWR				18
+#define EVENT_OP_IS_WR				17
+#define EVENT_OP_IS_RD				16
+#define EVENT_OP_IS_RD_ACTIVATE			15
+#define EVENT_OP_IS_RD_OR_WR			14
+#define EVENT_OP_IS_ACTIVATE			13
+#define EVENT_WR_XACT_WHEN_CRITICAL		12
+#define EVENT_LPR_XACT_WHEN_CRITICAL		11
+#define EVENT_HPR_XACT_WHEN_CRITICAL		10
+#define EVENT_DFI_RD_DATA_CYCLES		9
+#define EVENT_DFI_WR_DATA_CYCLES		8
+#define EVENT_ACT_BYPASS			7
+#define EVENT_READ_BYPASS			6
+#define EVENT_HIF_HI_PRI_RD			5
+#define EVENT_HIF_RMW				4
+#define EVENT_HIF_RD				3
+#define EVENT_HIF_WR				2
+#define EVENT_HIF_RD_OR_WR			1
+
+/* Event counter value registers */
+#define DDRC_PERF_CNT_VALUE_BASE		0x8080
+#define DDRC_PERF_CNT_VALUE(n)	(DDRC_PERF_CNT_VALUE_BASE + 8 * (n))
+
+/* Fixed event counter enable/disable register */
+#define DDRC_PERF_CNT_FREERUN_EN	0x80C0
+#define DDRC_PERF_FREERUN_WRITE_EN	0x1
+#define DDRC_PERF_FREERUN_READ_EN	0x2
+
+/* Fixed event counter control register */
+#define DDRC_PERF_CNT_FREERUN_CTRL	0x80C8
+#define DDRC_FREERUN_WRITE_CNT_CLR	0x1
+#define DDRC_FREERUN_READ_CNT_CLR	0x2
+
+/* Fixed event counter value register */
+#define DDRC_PERF_CNT_VALUE_WR_OP	0x80D0
+#define DDRC_PERF_CNT_VALUE_RD_OP	0x80D8
+#define DDRC_PERF_CNT_VALUE_OVERFLOW	BIT_ULL(48)
+#define DDRC_PERF_CNT_MAX_VALUE		GENMASK_ULL(48, 0)
+
+struct cn10k_ddr_pmu {
+	struct pmu pmu;
+	void __iomem *base;
+	unsigned int cpu;
+	struct	device *dev;
+	int active_events;
+	struct perf_event *events[DDRC_PERF_NUM_COUNTERS];
+};
+
+#define to_cn10k_ddr_pmu(p)	container_of(p, struct cn10k_ddr_pmu, pmu)
+
+static ssize_t cn10k_ddr_pmu_event_show(struct device *dev,
+					struct device_attribute *attr,
+					char *page)
+{
+	struct perf_pmu_events_attr *pmu_attr;
+
+	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
+	return sysfs_emit(page, "event=0x%02llx\n", pmu_attr->id);
+
+}
+
+#define CN10K_DDR_PMU_EVENT_ATTR(_name, _id)				     \
+	PMU_EVENT_ATTR_ID(_name, cn10k_ddr_pmu_event_show, _id)
+
+static struct attribute *cn10k_ddr_perf_events_attrs[] = {
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_hif_rd_or_wr_access, EVENT_HIF_RD_OR_WR),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_hif_wr_access, EVENT_HIF_WR),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_hif_rd_access, EVENT_HIF_RD),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_hif_rmw_access, EVENT_HIF_RMW),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_hif_pri_rdaccess, EVENT_HIF_HI_PRI_RD),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_rd_bypass_access, EVENT_READ_BYPASS),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_act_bypass_access, EVENT_ACT_BYPASS),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_dif_wr_data_access, EVENT_DFI_WR_DATA_CYCLES),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_dif_rd_data_access, EVENT_DFI_RD_DATA_CYCLES),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_hpri_sched_rd_crit_access,
+					EVENT_HPR_XACT_WHEN_CRITICAL),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_lpri_sched_rd_crit_access,
+					EVENT_LPR_XACT_WHEN_CRITICAL),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_wr_trxn_crit_access,
+					EVENT_WR_XACT_WHEN_CRITICAL),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_cam_active_access, EVENT_OP_IS_ACTIVATE),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_cam_rd_or_wr_access, EVENT_OP_IS_RD_OR_WR),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_cam_rd_active_access, EVENT_OP_IS_RD_ACTIVATE),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_cam_read, EVENT_OP_IS_RD),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_cam_write, EVENT_OP_IS_WR),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_cam_mwr, EVENT_OP_IS_MWR),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_precharge, EVENT_OP_IS_PRECHARGE),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_precharge_for_rdwr, EVENT_PRECHARGE_FOR_RDWR),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_precharge_for_other,
+					EVENT_PRECHARGE_FOR_OTHER),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_rdwr_transitions, EVENT_RDWR_TRANSITIONS),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_write_combine, EVENT_WRITE_COMBINE),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_war_hazard, EVENT_WAR_HAZARD),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_raw_hazard, EVENT_RAW_HAZARD),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_waw_hazard, EVENT_WAW_HAZARD),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_enter_selfref, EVENT_OP_IS_ENTER_SELFREF),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_enter_powerdown, EVENT_OP_IS_ENTER_POWERDOWN),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_enter_mpsm, EVENT_OP_IS_ENTER_MPSM),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_refresh, EVENT_OP_IS_REFRESH),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_crit_ref, EVENT_OP_IS_CRIT_REF),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_spec_ref, EVENT_OP_IS_SPEC_REF),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_load_mode, EVENT_OP_IS_LOAD_MODE),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_zqcl, EVENT_OP_IS_ZQCL),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_cam_wr_access, EVENT_OP_IS_ZQCS),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_hpr_req_with_nocredit,
+					EVENT_HPR_REQ_WITH_NOCREDIT),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_lpr_req_with_nocredit,
+					EVENT_LPR_REQ_WITH_NOCREDIT),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_bsm_alloc, EVENT_BSM_ALLOC),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_bsm_starvation, EVENT_BSM_STARVATION),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_win_limit_reached_rd,
+					EVENT_VISIBLE_WIN_LIMIT_REACHED_RD),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_win_limit_reached_wr,
+					EVENT_VISIBLE_WIN_LIMIT_REACHED_WR),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_dqsosc_mpc, EVENT_OP_IS_DQSOSC_MPC),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_dqsosc_mrr, EVENT_OP_IS_DQSOSC_MRR),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_tcr_mrr, EVENT_OP_IS_TCR_MRR),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_zqstart, EVENT_OP_IS_ZQSTART),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_zqlatch, EVENT_OP_IS_ZQLATCH),
+	/* Free run event counters */
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_ddr_reads, EVENT_DDR_READS),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_ddr_writes, EVENT_DDR_WRITES),
+	NULL
+};
+
+static struct attribute_group cn10k_ddr_perf_events_attr_group = {
+	.name = "events",
+	.attrs = cn10k_ddr_perf_events_attrs,
+};
+
+PMU_FORMAT_ATTR(event, "config:0-8");
+
+static struct attribute *cn10k_ddr_perf_format_attrs[] = {
+	&format_attr_event.attr,
+	NULL,
+};
+
+static struct attribute_group cn10k_ddr_perf_format_attr_group = {
+	.name = "format",
+	.attrs = cn10k_ddr_perf_format_attrs,
+};
+
+static ssize_t cn10k_ddr_perf_cpumask_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct cn10k_ddr_pmu *pmu = dev_get_drvdata(dev);
+
+	return cpumap_print_to_pagebuf(true, buf, cpumask_of(pmu->cpu));
+}
+
+static struct device_attribute cn10k_ddr_perf_cpumask_attr =
+	__ATTR(cpumask, 0444, cn10k_ddr_perf_cpumask_show, NULL);
+
+static struct attribute *cn10k_ddr_perf_cpumask_attrs[] = {
+	&cn10k_ddr_perf_cpumask_attr.attr,
+	NULL,
+};
+
+static struct attribute_group cn10k_ddr_perf_cpumask_attr_group = {
+	.attrs = cn10k_ddr_perf_cpumask_attrs,
+};
+
+static const struct attribute_group *cn10k_attr_groups[] = {
+	&cn10k_ddr_perf_events_attr_group,
+	&cn10k_ddr_perf_format_attr_group,
+	&cn10k_ddr_perf_cpumask_attr_group,
+	NULL,
+};
+
+static int ddr_perf_get_event_bitmap(int eventid, u64 *event_bitmap)
+{
+	switch (eventid) {
+	case EVENT_HIF_RD_OR_WR ... EVENT_WAW_HAZARD:
+	case EVENT_OP_IS_REFRESH ... EVENT_OP_IS_ZQLATCH:
+		*event_bitmap = (1ULL << (eventid - 1));
+		break;
+	case EVENT_OP_IS_ENTER_SELFREF:
+	case EVENT_OP_IS_ENTER_POWERDOWN:
+	case EVENT_OP_IS_ENTER_MPSM:
+		*event_bitmap = (0xFULL << (eventid - 1));
+		break;
+	default:
+		pr_err("%s Invalid eventid %d\n", __func__, eventid);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int cn10k_ddr_perf_alloc_counter(struct cn10k_ddr_pmu *pmu,
+					struct perf_event *event)
+{
+	u8 config = event->attr.config;
+	int i;
+
+	/* DDR read free-run counter index */
+	if (config == EVENT_DDR_READS) {
+		pmu->events[DDRC_PERF_READ_COUNTER_IDX] = event;
+		return DDRC_PERF_READ_COUNTER_IDX;
+	}
+
+	/* DDR write free-run counter index */
+	if (config == EVENT_DDR_WRITES) {
+		pmu->events[DDRC_PERF_WRITE_COUNTER_IDX] = event;
+		return DDRC_PERF_WRITE_COUNTER_IDX;
+	}
+
+	/* Allocate DDR generic counters */
+	for (i = 0; i < DDRC_PERF_NUM_GEN_COUNTERS; i++) {
+		if (pmu->events[i] == NULL) {
+			pmu->events[i] = event;
+			return i;
+		}
+	}
+
+	return -ENOENT;
+}
+
+static void cn10k_ddr_perf_free_counter(struct cn10k_ddr_pmu *pmu, int counter)
+{
+	pmu->events[counter] = NULL;
+}
+
+static int cn10k_ddr_perf_event_init(struct perf_event *event)
+{
+	struct cn10k_ddr_pmu *pmu = to_cn10k_ddr_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
+	if (is_sampling_event(event)) {
+		dev_info(pmu->dev, "Sampling not supported!\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (event->cpu < 0) {
+		dev_warn(pmu->dev, "Can't provide per-task data!\n");
+		return -EOPNOTSUPP;
+	}
+
+	/*  We must NOT create groups containing mixed PMUs */
+	if (event->group_leader->pmu != event->pmu &&
+	    !is_software_event(event->group_leader))
+		return -EINVAL;
+
+	/* Set ownership of event to one CPU, same event can not be observed
+	 * on multiple cpus at same time.
+	 */
+	event->cpu = pmu->cpu;
+	hwc->idx = -1;
+	return 0;
+}
+
+static void cn10k_ddr_perf_counter_enable(struct cn10k_ddr_pmu *pmu,
+					  int counter, bool enable)
+{
+	u32 reg;
+	u64 val;
+
+	if (counter > DDRC_PERF_NUM_COUNTERS) {
+		pr_err("Error: unsupported counter %d\n", counter);
+		return;
+	}
+
+	if (counter < DDRC_PERF_NUM_GEN_COUNTERS) {
+		reg = DDRC_PERF_CFG(counter);
+		val = readq_relaxed(pmu->base + reg);
+
+		if (enable)
+			val |= EVENT_ENABLE;
+		else
+			val &= ~EVENT_ENABLE;
+
+		writeq_relaxed(val, pmu->base + reg);
+	} else {
+		val = readq_relaxed(pmu->base + DDRC_PERF_CNT_FREERUN_EN);
+		if (enable) {
+			if (counter == DDRC_PERF_READ_COUNTER_IDX)
+				val |= DDRC_PERF_FREERUN_READ_EN;
+			else
+				val |= DDRC_PERF_FREERUN_WRITE_EN;
+		} else {
+			if (counter == DDRC_PERF_READ_COUNTER_IDX)
+				val &= ~DDRC_PERF_FREERUN_READ_EN;
+			else
+				val &= ~DDRC_PERF_FREERUN_WRITE_EN;
+		}
+		writeq_relaxed(val, pmu->base + DDRC_PERF_CNT_FREERUN_EN);
+	}
+}
+
+static u64 cn10k_ddr_perf_read_counter(struct cn10k_ddr_pmu *pmu, int counter)
+{
+	u64 val;
+
+	if (counter == DDRC_PERF_READ_COUNTER_IDX)
+		return readq_relaxed(pmu->base + DDRC_PERF_CNT_VALUE_RD_OP);
+
+	if (counter == DDRC_PERF_WRITE_COUNTER_IDX)
+		return readq_relaxed(pmu->base + DDRC_PERF_CNT_VALUE_WR_OP);
+
+	val = readq_relaxed(pmu->base + DDRC_PERF_CNT_VALUE(counter));
+	return val;
+}
+
+static void cn10k_ddr_perf_event_update(struct perf_event *event)
+{
+	struct cn10k_ddr_pmu *pmu = to_cn10k_ddr_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	u64 prev_count, new_count, mask;
+
+	do {
+		prev_count = local64_read(&hwc->prev_count);
+		new_count = cn10k_ddr_perf_read_counter(pmu, hwc->idx);
+	} while (local64_xchg(&hwc->prev_count, new_count) != prev_count);
+
+	mask = DDRC_PERF_CNT_MAX_VALUE;
+
+	local64_add((new_count - prev_count) & mask, &event->count);
+}
+
+static void cn10k_ddr_perf_event_start(struct perf_event *event, int flags)
+{
+	struct cn10k_ddr_pmu *pmu = to_cn10k_ddr_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	int counter = hwc->idx;
+
+	local64_set(&hwc->prev_count, 0);
+
+	cn10k_ddr_perf_counter_enable(pmu, counter, true);
+
+	hwc->state = 0;
+}
+
+static int cn10k_ddr_perf_event_add(struct perf_event *event, int flags)
+{
+	struct cn10k_ddr_pmu *pmu = to_cn10k_ddr_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	u8 config = event->attr.config;
+	int counter, ret;
+	u32 reg_offset;
+	u64 val;
+
+	counter = cn10k_ddr_perf_alloc_counter(pmu, event);
+	if (counter < 0)
+		return -EAGAIN;
+
+	pmu->active_events++;
+	hwc->idx = counter;
+
+	if (counter < DDRC_PERF_NUM_GEN_COUNTERS) {
+		/* Generic counters, configure event id */
+		reg_offset = DDRC_PERF_CFG(counter);
+		ret = ddr_perf_get_event_bitmap(config, &val);
+		if (ret)
+			return ret;
+
+		writeq_relaxed(val, pmu->base + reg_offset);
+	} else {
+		/* fixed event counter, clear counter value */
+		if (counter == DDRC_PERF_READ_COUNTER_IDX)
+			val = DDRC_FREERUN_READ_CNT_CLR;
+		else
+			val = DDRC_FREERUN_WRITE_CNT_CLR;
+
+		writeq_relaxed(val, pmu->base + DDRC_PERF_CNT_FREERUN_CTRL);
+	}
+
+	hwc->state |= PERF_HES_STOPPED;
+
+	if (flags & PERF_EF_START)
+		cn10k_ddr_perf_event_start(event, flags);
+
+	return 0;
+}
+
+static void cn10k_ddr_perf_event_stop(struct perf_event *event, int flags)
+{
+	struct cn10k_ddr_pmu *pmu = to_cn10k_ddr_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	int counter = hwc->idx;
+
+	cn10k_ddr_perf_counter_enable(pmu, counter, false);
+
+	if (flags & PERF_EF_UPDATE)
+		cn10k_ddr_perf_event_update(event);
+
+	hwc->state |= PERF_HES_STOPPED;
+}
+
+static void cn10k_ddr_perf_event_del(struct perf_event *event, int flags)
+{
+	struct cn10k_ddr_pmu *pmu = to_cn10k_ddr_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	int counter = hwc->idx;
+
+	cn10k_ddr_perf_event_stop(event, PERF_EF_UPDATE);
+
+	cn10k_ddr_perf_free_counter(pmu, counter);
+	pmu->active_events--;
+	hwc->idx = -1;
+}
+
+static void cn10k_ddr_perf_pmu_enable(struct pmu *pmu)
+{
+	struct cn10k_ddr_pmu *ddr_pmu = to_cn10k_ddr_pmu(pmu);
+
+	writeq_relaxed(START_OP_CTRL_VAL_START, ddr_pmu->base +
+		       DDRC_PERF_CNT_START_OP_CTRL);
+}
+
+static void cn10k_ddr_perf_pmu_disable(struct pmu *pmu)
+{
+	struct cn10k_ddr_pmu *ddr_pmu = to_cn10k_ddr_pmu(pmu);
+
+	writeq_relaxed(END_OP_CTRL_VAL_END, ddr_pmu->base +
+		       DDRC_PERF_CNT_END_OP_CTRL);
+}
+
+static int cn10k_ddr_perf_probe(struct platform_device *pdev)
+{
+	struct cn10k_ddr_pmu *ddr_pmu;
+	struct resource *res;
+	void __iomem *base;
+	char *name;
+	int ret;
+
+	ddr_pmu = devm_kzalloc(&pdev->dev, sizeof(*ddr_pmu), GFP_KERNEL);
+	if (!ddr_pmu)
+		return -ENOMEM;
+
+	ddr_pmu->dev = &pdev->dev;
+	platform_set_drvdata(pdev, ddr_pmu);
+
+	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	ddr_pmu->base = base;
+
+	/* Setup the PMU counter to work in manual mode */
+	writeq_relaxed(OP_MODE_CTRL_VAL_MANNUAL, ddr_pmu->base +
+		       DDRC_PERF_CNT_OP_MODE_CTRL);
+
+	ddr_pmu->pmu = (struct pmu) {
+		.module	      = THIS_MODULE,
+		.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
+		.task_ctx_nr = perf_invalid_context,
+		.attr_groups = cn10k_attr_groups,
+		.event_init  = cn10k_ddr_perf_event_init,
+		.add	     = cn10k_ddr_perf_event_add,
+		.del	     = cn10k_ddr_perf_event_del,
+		.start	     = cn10k_ddr_perf_event_start,
+		.stop	     = cn10k_ddr_perf_event_stop,
+		.read	     = cn10k_ddr_perf_event_update,
+		.pmu_enable  = cn10k_ddr_perf_pmu_enable,
+		.pmu_disable = cn10k_ddr_perf_pmu_disable,
+	};
+
+	/* Choose this cpu to collect perf data */
+	ddr_pmu->cpu = raw_smp_processor_id();
+
+	name = devm_kasprintf(ddr_pmu->dev, GFP_KERNEL, "mrvl_ddr_pmu_%llx",
+			      res->start);
+	if (!name)
+		return -ENOMEM;
+
+	ret = perf_pmu_register(&ddr_pmu->pmu, name, -1);
+	if (ret)
+		return ret;
+
+	pr_info("CN10K DDR PMU Driver for ddrc@%llx\n", res->start);
+	return 0;
+}
+
+static int cn10k_ddr_perf_remove(struct platform_device *pdev)
+{
+	struct cn10k_ddr_pmu *ddr_pmu = platform_get_drvdata(pdev);
+
+	perf_pmu_unregister(&ddr_pmu->pmu);
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id cn10k_ddr_pmu_of_match[] = {
+	{ .compatible = "marvell,cn10k-ddr-pmu", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, cn10k_ddr_pmu_of_match);
+#endif
+
+static struct platform_driver cn10k_ddr_pmu_driver = {
+	.driver	= {
+		.name   = "cn10k-ddr-pmu",
+		.of_match_table = cn10k_ddr_pmu_of_match,
+		.suppress_bind_attrs = true,
+	},
+	.probe		= cn10k_ddr_perf_probe,
+	.remove		= cn10k_ddr_perf_remove,
+};
+
+static int __init cn10k_ddr_pmu_init(void)
+{
+	return platform_driver_register(&cn10k_ddr_pmu_driver);
+}
+
+static void __exit cn10k_ddr_pmu_exit(void)
+{
+	platform_driver_unregister(&cn10k_ddr_pmu_driver);
+}
+
+module_init(cn10k_ddr_pmu_init);
+module_exit(cn10k_ddr_pmu_exit);
+
+MODULE_AUTHOR("Bharat Bhushan <bbhushan2@marvell.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

