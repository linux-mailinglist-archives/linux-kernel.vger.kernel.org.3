Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2EBC57490D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 11:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237790AbiGNJbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 05:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238181AbiGNJ2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:28:50 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3C6D73;
        Thu, 14 Jul 2022 02:28:46 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Lk8J62kHczkX0f;
        Thu, 14 Jul 2022 17:26:30 +0800 (CST)
Received: from localhost.localdomain (10.67.164.66) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Jul 2022 17:28:43 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <gregkh@linuxfoundation.org>, <alexander.shishkin@linux.intel.com>,
        <leo.yan@linaro.org>, <james.clark@arm.com>, <will@kernel.org>,
        <robin.murphy@arm.com>, <acme@kernel.org>, <peterz@infradead.org>,
        <corbet@lwn.net>, <mathieu.poirier@linaro.org>,
        <mark.rutland@arm.com>, <jonathan.cameron@huawei.com>,
        <john.garry@huawei.com>
CC:     <helgaas@kernel.org>, <lorenzo.pieralisi@arm.com>,
        <suzuki.poulose@arm.com>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>, <mingo@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <iommu@lists.linux.dev>,
        <linux-doc@vger.kernel.org>, <prime.zeng@huawei.com>,
        <liuqi115@huawei.com>, <zhangshaokun@hisilicon.com>,
        <linuxarm@huawei.com>, <yangyicong@hisilicon.com>
Subject: [PATCH v10 2/8] hwtracing: hisi_ptt: Add trace function support for HiSilicon PCIe Tune and Trace device
Date:   Thu, 14 Jul 2022 17:27:04 +0800
Message-ID: <20220714092710.53486-3-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220714092710.53486-1-yangyicong@hisilicon.com>
References: <20220714092710.53486-1-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HiSilicon PCIe tune and trace device(PTT) is a PCIe Root Complex integrated
Endpoint(RCiEP) device, providing the capability to dynamically monitor and
tune the PCIe traffic and trace the TLP headers.

Add the driver for the device to enable the trace function. Register PMU
device of PTT trace, then users can use trace through perf command. The
driver makes use of perf AUX trace function and support the following
events to configure the trace:

- filter: select Root port or Endpoint to trace
- type: select the type of traced TLP headers
- direction: select the direction of traced TLP headers
- format: select the data format of the traced TLP headers

This patch initially add basic trace support of PTT device.

Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: John Garry <john.garry@huawei.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/Makefile                 |   1 +
 drivers/hwtracing/Kconfig        |   2 +
 drivers/hwtracing/ptt/Kconfig    |  12 +
 drivers/hwtracing/ptt/Makefile   |   2 +
 drivers/hwtracing/ptt/hisi_ptt.c | 901 +++++++++++++++++++++++++++++++
 drivers/hwtracing/ptt/hisi_ptt.h | 177 ++++++
 6 files changed, 1095 insertions(+)
 create mode 100644 drivers/hwtracing/ptt/Kconfig
 create mode 100644 drivers/hwtracing/ptt/Makefile
 create mode 100644 drivers/hwtracing/ptt/hisi_ptt.c
 create mode 100644 drivers/hwtracing/ptt/hisi_ptt.h

diff --git a/drivers/Makefile b/drivers/Makefile
index 9a30842b22c5..bf67e0e23c18 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -176,6 +176,7 @@ obj-$(CONFIG_USB4)		+= thunderbolt/
 obj-$(CONFIG_CORESIGHT)		+= hwtracing/coresight/
 obj-y				+= hwtracing/intel_th/
 obj-$(CONFIG_STM)		+= hwtracing/stm/
+obj-$(CONFIG_HISI_PTT)		+= hwtracing/ptt/
 obj-$(CONFIG_ANDROID)		+= android/
 obj-$(CONFIG_NVMEM)		+= nvmem/
 obj-$(CONFIG_FPGA)		+= fpga/
diff --git a/drivers/hwtracing/Kconfig b/drivers/hwtracing/Kconfig
index 13085835a636..911ee977103c 100644
--- a/drivers/hwtracing/Kconfig
+++ b/drivers/hwtracing/Kconfig
@@ -5,4 +5,6 @@ source "drivers/hwtracing/stm/Kconfig"
 
 source "drivers/hwtracing/intel_th/Kconfig"
 
+source "drivers/hwtracing/ptt/Kconfig"
+
 endmenu
diff --git a/drivers/hwtracing/ptt/Kconfig b/drivers/hwtracing/ptt/Kconfig
new file mode 100644
index 000000000000..6d46a09ffeb9
--- /dev/null
+++ b/drivers/hwtracing/ptt/Kconfig
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config HISI_PTT
+	tristate "HiSilicon PCIe Tune and Trace Device"
+	depends on ARM64 || (COMPILE_TEST && 64BIT)
+	depends on PCI && HAS_DMA && HAS_IOMEM && PERF_EVENTS
+	help
+	  HiSilicon PCIe Tune and Trace device exists as a PCIe RCiEP
+	  device, and it provides support for PCIe traffic tuning and
+	  tracing TLP headers to the memory.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called hisi_ptt.
diff --git a/drivers/hwtracing/ptt/Makefile b/drivers/hwtracing/ptt/Makefile
new file mode 100644
index 000000000000..908c09a98161
--- /dev/null
+++ b/drivers/hwtracing/ptt/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_HISI_PTT) += hisi_ptt.o
diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
new file mode 100644
index 000000000000..c64642097f8b
--- /dev/null
+++ b/drivers/hwtracing/ptt/hisi_ptt.c
@@ -0,0 +1,901 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for HiSilicon PCIe tune and trace device
+ *
+ * Copyright (c) 2022 HiSilicon Technologies Co., Ltd.
+ * Author: Yicong Yang <yangyicong@hisilicon.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/cpuhotplug.h>
+#include <linux/delay.h>
+#include <linux/dma-iommu.h>
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iommu.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/sysfs.h>
+#include <linux/vmalloc.h>
+
+#include "hisi_ptt.h"
+
+/* Dynamic CPU hotplug state used by PTT */
+static enum cpuhp_state hisi_ptt_pmu_online;
+
+static u16 hisi_ptt_get_filter_val(u16 devid, bool is_port)
+{
+	if (is_port)
+		return BIT(HISI_PCIE_CORE_PORT_ID(devid & 0xff));
+
+	return devid;
+}
+
+static bool hisi_ptt_wait_trace_hw_idle(struct hisi_ptt *hisi_ptt)
+{
+	u32 val;
+
+	return !readl_poll_timeout_atomic(hisi_ptt->iobase + HISI_PTT_TRACE_STS,
+					  val, val & HISI_PTT_TRACE_IDLE,
+					  HISI_PTT_WAIT_POLL_INTERVAL_US,
+					  HISI_PTT_WAIT_TRACE_TIMEOUT_US);
+}
+
+static void hisi_ptt_wait_dma_reset_done(struct hisi_ptt *hisi_ptt)
+{
+	u32 val;
+
+	readl_poll_timeout_atomic(hisi_ptt->iobase + HISI_PTT_TRACE_WR_STS,
+				  val, !val, HISI_PTT_RESET_POLL_INTERVAL_US,
+				  HISI_PTT_RESET_TIMEOUT_US);
+}
+
+static void hisi_ptt_trace_end(struct hisi_ptt *hisi_ptt)
+{
+	writel(0, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
+	hisi_ptt->trace_ctrl.started = false;
+}
+
+static int hisi_ptt_trace_start(struct hisi_ptt *hisi_ptt)
+{
+	struct hisi_ptt_trace_ctrl *ctrl = &hisi_ptt->trace_ctrl;
+	u32 val;
+	int i;
+
+	/* Check device idle before start trace */
+	if (!hisi_ptt_wait_trace_hw_idle(hisi_ptt)) {
+		pci_err(hisi_ptt->pdev, "Failed to start trace, the device is still busy\n");
+		return -EBUSY;
+	}
+
+	ctrl->started = true;
+
+	/* Reset the DMA before start tracing */
+	val = readl(hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
+	val |= HISI_PTT_TRACE_CTRL_RST;
+	writel(val, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
+
+	hisi_ptt_wait_dma_reset_done(hisi_ptt);
+
+	val = readl(hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
+	val &= ~HISI_PTT_TRACE_CTRL_RST;
+	writel(val, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
+
+	/* Reset the index of current buffer */
+	hisi_ptt->trace_ctrl.buf_index = 0;
+
+	/* Zero the trace buffers */
+	for (i = 0; i < HISI_PTT_TRACE_BUF_CNT; i++)
+		memset(ctrl->trace_buf[i].addr, 0, HISI_PTT_TRACE_BUF_SIZE);
+
+	/* Clear the interrupt status */
+	writel(HISI_PTT_TRACE_INT_STAT_MASK, hisi_ptt->iobase + HISI_PTT_TRACE_INT_STAT);
+	writel(0, hisi_ptt->iobase + HISI_PTT_TRACE_INT_MASK);
+
+	/* Set the trace control register */
+	val = FIELD_PREP(HISI_PTT_TRACE_CTRL_TYPE_SEL, ctrl->type);
+	val |= FIELD_PREP(HISI_PTT_TRACE_CTRL_RXTX_SEL, ctrl->direction);
+	val |= FIELD_PREP(HISI_PTT_TRACE_CTRL_DATA_FORMAT, ctrl->format);
+	val |= FIELD_PREP(HISI_PTT_TRACE_CTRL_TARGET_SEL, hisi_ptt->trace_ctrl.filter);
+	if (!hisi_ptt->trace_ctrl.is_port)
+		val |= HISI_PTT_TRACE_CTRL_FILTER_MODE;
+
+	/* Start the Trace */
+	val |= HISI_PTT_TRACE_CTRL_EN;
+	writel(val, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
+
+	return 0;
+}
+
+static int hisi_ptt_update_aux(struct hisi_ptt *hisi_ptt, int index, bool stop)
+{
+	struct hisi_ptt_trace_ctrl *ctrl = &hisi_ptt->trace_ctrl;
+	struct perf_output_handle *handle = &ctrl->handle;
+	struct perf_event *event = handle->event;
+	struct hisi_ptt_pmu_buf *buf;
+	size_t size;
+	void *addr;
+
+	buf = perf_get_aux(handle);
+	if (!buf || !handle->size)
+		return -EINVAL;
+
+	addr = ctrl->trace_buf[ctrl->buf_index].addr;
+
+	/*
+	 * If we're going to stop, read the size of already traced data from
+	 * HISI_PTT_TRACE_WR_STS. Otherwise we're coming from the interrupt,
+	 * the data size is always HISI_PTT_TRACE_BUF_SIZE.
+	 */
+	if (stop) {
+		u32 reg;
+
+		reg = readl(hisi_ptt->iobase + HISI_PTT_TRACE_WR_STS);
+		size = FIELD_GET(HISI_PTT_TRACE_WR_STS_WRITE, reg);
+	} else {
+		size = HISI_PTT_TRACE_BUF_SIZE;
+	}
+
+	memcpy(buf->base + buf->pos, addr, size);
+	buf->pos += size;
+
+	/*
+	 * Just commit the traced data if we're going to stop. Otherwise if the
+	 * resident AUX buffer cannot contain the data of next trace buffer,
+	 * apply a new one.
+	 */
+	if (stop) {
+		perf_aux_output_end(handle, buf->pos);
+	} else if (buf->length - buf->pos < HISI_PTT_TRACE_BUF_SIZE) {
+		perf_aux_output_end(handle, buf->pos);
+
+		buf = perf_aux_output_begin(handle, event);
+		if (!buf)
+			return -EINVAL;
+
+		buf->pos = handle->head % buf->length;
+		if (buf->length - buf->pos < HISI_PTT_TRACE_BUF_SIZE) {
+			perf_aux_output_end(handle, 0);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static irqreturn_t hisi_ptt_isr(int irq, void *context)
+{
+	struct hisi_ptt *hisi_ptt = context;
+	u32 status, buf_idx;
+
+	status = readl(hisi_ptt->iobase + HISI_PTT_TRACE_INT_STAT);
+	if (!(status & HISI_PTT_TRACE_INT_STAT_MASK))
+		return IRQ_NONE;
+
+	buf_idx = ffs(status) - 1;
+
+	/* Clear the interrupt status of buffer @buf_idx */
+	writel(status, hisi_ptt->iobase + HISI_PTT_TRACE_INT_STAT);
+
+	/*
+	 * Update the AUX buffer and cache the current buffer index,
+	 * as we need to know this and save the data when the trace
+	 * is ended out of the interrupt handler. End the trace
+	 * if the updating fails.
+	 */
+	if (hisi_ptt_update_aux(hisi_ptt, buf_idx, false))
+		hisi_ptt_trace_end(hisi_ptt);
+	else
+		hisi_ptt->trace_ctrl.buf_index = (buf_idx + 1) % HISI_PTT_TRACE_BUF_CNT;
+
+	return IRQ_HANDLED;
+}
+
+static void hisi_ptt_irq_free_vectors(void *pdev)
+{
+	pci_free_irq_vectors(pdev);
+}
+
+static int hisi_ptt_register_irq(struct hisi_ptt *hisi_ptt)
+{
+	struct pci_dev *pdev = hisi_ptt->pdev;
+	int ret;
+
+	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI);
+	if (ret < 0) {
+		pci_err(pdev, "failed to allocate irq vector, ret = %d\n", ret);
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(&pdev->dev, hisi_ptt_irq_free_vectors, pdev);
+	if (ret < 0)
+		return ret;
+
+	ret = devm_request_threaded_irq(&pdev->dev,
+					pci_irq_vector(pdev, HISI_PTT_TRACE_DMA_IRQ),
+					NULL, hisi_ptt_isr, 0,
+					DRV_NAME, hisi_ptt);
+	if (ret) {
+		pci_err(pdev, "failed to request irq %d, ret = %d\n",
+			pci_irq_vector(pdev, HISI_PTT_TRACE_DMA_IRQ), ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int hisi_ptt_init_filters(struct pci_dev *pdev, void *data)
+{
+	struct hisi_ptt_filter_desc *filter;
+	struct hisi_ptt *hisi_ptt = data;
+
+	/*
+	 * We won't fail the probe if filter allocation failed here. The filters
+	 * should be partial initialized and users would know which filter fails
+	 * through the log. Other functions of PTT device are still available.
+	 */
+	filter = kzalloc(sizeof(*filter), GFP_KERNEL);
+	if (!filter) {
+		pci_err(hisi_ptt->pdev, "failed to add filter %s\n", pci_name(pdev));
+		return -ENOMEM;
+	}
+
+	filter->devid = PCI_DEVID(pdev->bus->number, pdev->devfn);
+
+	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) {
+		filter->is_port = true;
+		list_add_tail(&filter->list, &hisi_ptt->port_filters);
+
+		/* Update the available port mask */
+		hisi_ptt->port_mask |= hisi_ptt_get_filter_val(filter->devid, true);
+	} else {
+		list_add_tail(&filter->list, &hisi_ptt->req_filters);
+	}
+
+	return 0;
+}
+
+static void hisi_ptt_release_filters(void *data)
+{
+	struct hisi_ptt_filter_desc *filter, *tmp;
+	struct hisi_ptt *hisi_ptt = data;
+
+	list_for_each_entry_safe(filter, tmp, &hisi_ptt->req_filters, list) {
+		list_del(&filter->list);
+		kfree(filter);
+	}
+
+	list_for_each_entry_safe(filter, tmp, &hisi_ptt->port_filters, list) {
+		list_del(&filter->list);
+		kfree(filter);
+	}
+}
+
+static int hisi_ptt_config_trace_buf(struct hisi_ptt *hisi_ptt)
+{
+	struct hisi_ptt_trace_ctrl *ctrl = &hisi_ptt->trace_ctrl;
+	struct device *dev = &hisi_ptt->pdev->dev;
+	int i;
+
+	ctrl->trace_buf = devm_kcalloc(dev, HISI_PTT_TRACE_BUF_CNT,
+				       sizeof(*ctrl->trace_buf), GFP_KERNEL);
+	if (!ctrl->trace_buf)
+		return -ENOMEM;
+
+	for (i = 0; i < HISI_PTT_TRACE_BUF_CNT; ++i) {
+		ctrl->trace_buf[i].addr = dmam_alloc_coherent(dev, HISI_PTT_TRACE_BUF_SIZE,
+							     &ctrl->trace_buf[i].dma,
+							     GFP_KERNEL);
+		if (!ctrl->trace_buf[i].addr)
+			return -ENOMEM;
+	}
+
+	/* Configure the trace DMA buffer */
+	for (i = 0; i < HISI_PTT_TRACE_BUF_CNT; i++) {
+		writel(lower_32_bits(ctrl->trace_buf[i].dma),
+		       hisi_ptt->iobase + HISI_PTT_TRACE_ADDR_BASE_LO_0 +
+		       i * HISI_PTT_TRACE_ADDR_STRIDE);
+		writel(upper_32_bits(ctrl->trace_buf[i].dma),
+		       hisi_ptt->iobase + HISI_PTT_TRACE_ADDR_BASE_HI_0 +
+		       i * HISI_PTT_TRACE_ADDR_STRIDE);
+	}
+	writel(HISI_PTT_TRACE_BUF_SIZE, hisi_ptt->iobase + HISI_PTT_TRACE_ADDR_SIZE);
+
+	return 0;
+}
+
+static int hisi_ptt_init_ctrls(struct hisi_ptt *hisi_ptt)
+{
+	struct pci_dev *pdev = hisi_ptt->pdev;
+	struct pci_bus *bus;
+	int ret;
+	u32 reg;
+
+	INIT_LIST_HEAD(&hisi_ptt->port_filters);
+	INIT_LIST_HEAD(&hisi_ptt->req_filters);
+
+	ret = hisi_ptt_config_trace_buf(hisi_ptt);
+	if (ret)
+		return ret;
+
+	/*
+	 * The device range register provides the information about the root
+	 * ports which the RCiEP can control and trace. The RCiEP and the root
+	 * ports which it supports are on the same PCIe core, with same domain
+	 * number but maybe different bus number. The device range register
+	 * will tell us which root ports we can support, Bit[31:16] indicates
+	 * the upper BDF numbers of the root port, while Bit[15:0] indicates
+	 * the lower.
+	 */
+	reg = readl(hisi_ptt->iobase + HISI_PTT_DEVICE_RANGE);
+	hisi_ptt->upper_bdf = FIELD_GET(HISI_PTT_DEVICE_RANGE_UPPER, reg);
+	hisi_ptt->lower_bdf = FIELD_GET(HISI_PTT_DEVICE_RANGE_LOWER, reg);
+
+	bus = pci_find_bus(pci_domain_nr(pdev->bus), PCI_BUS_NUM(hisi_ptt->upper_bdf));
+	if (bus)
+		pci_walk_bus(bus, hisi_ptt_init_filters, hisi_ptt);
+
+	ret = devm_add_action_or_reset(&pdev->dev, hisi_ptt_release_filters, hisi_ptt);
+	if (ret)
+		return ret;
+
+	hisi_ptt->trace_ctrl.on_cpu = -1;
+	return 0;
+}
+
+static ssize_t cpumask_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	struct hisi_ptt *hisi_ptt = to_hisi_ptt(dev_get_drvdata(dev));
+	const cpumask_t *cpumask = cpumask_of_node(dev_to_node(&hisi_ptt->pdev->dev));
+
+	return cpumap_print_to_pagebuf(true, buf, cpumask);
+}
+static DEVICE_ATTR_RO(cpumask);
+
+static struct attribute *hisi_ptt_cpumask_attrs[] = {
+	&dev_attr_cpumask.attr,
+	NULL
+};
+
+static const struct attribute_group hisi_ptt_cpumask_attr_group = {
+	.attrs = hisi_ptt_cpumask_attrs,
+};
+
+/*
+ * Bit 19 indicates the filter type, 1 for Root Port filter and 0 for Requester
+ * filter. Bit[15:0] indicates the filter value, for Root Port filter it's
+ * a bit mask of desired ports and for Requester filter it's the Requester ID
+ * of the desired PCIe function. Bit[18:16] is reserved for extension.
+ *
+ * See hisi_ptt.rst documentation for detailed information.
+ */
+PMU_FORMAT_ATTR(filter,		"config:0-19");
+PMU_FORMAT_ATTR(direction,	"config:20-23");
+PMU_FORMAT_ATTR(type,		"config:24-31");
+PMU_FORMAT_ATTR(format,		"config:32-35");
+
+static struct attribute *hisi_ptt_pmu_format_attrs[] = {
+	&format_attr_filter.attr,
+	&format_attr_direction.attr,
+	&format_attr_type.attr,
+	&format_attr_format.attr,
+	NULL
+};
+
+static struct attribute_group hisi_ptt_pmu_format_group = {
+	.name = "format",
+	.attrs = hisi_ptt_pmu_format_attrs,
+};
+
+static const struct attribute_group *hisi_ptt_pmu_groups[] = {
+	&hisi_ptt_cpumask_attr_group,
+	&hisi_ptt_pmu_format_group,
+	NULL
+};
+
+static int hisi_ptt_trace_valid_direction(u32 val)
+{
+	/*
+	 * The direction values have different effects according to the data
+	 * format (specified in the parentheses). TLP set A/B means different
+	 * set of TLP types. See hisi_ptt.rst documentation for more details.
+	 */
+	static const u32 hisi_ptt_trace_available_direction[] = {
+		0,	/* inbound(4DW) or reserved(8DW) */
+		1,	/* outbound(4DW) */
+		2,	/* {in, out}bound(4DW) or inbound(8DW), TLP set A */
+		3,	/* {in, out}bound(4DW) or inbound(8DW), TLP set B */
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(hisi_ptt_trace_available_direction); i++) {
+		if (val == hisi_ptt_trace_available_direction[i])
+			return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int hisi_ptt_trace_valid_type(u32 val)
+{
+	/* Different types can be set simultaneously */
+	static const u32 hisi_ptt_trace_available_type[] = {
+		1,	/* posted_request */
+		2,	/* non-posted_request */
+		4,	/* completion */
+	};
+	int i;
+
+	if (!val)
+		return -EINVAL;
+
+	/*
+	 * Walk the available list and clear the valid bits of
+	 * the config. If there is any resident bit after the
+	 * walk then the config is invalid.
+	 */
+	for (i = 0; i < ARRAY_SIZE(hisi_ptt_trace_available_type); i++)
+		val &= ~hisi_ptt_trace_available_type[i];
+
+	if (val)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int hisi_ptt_trace_valid_format(u32 val)
+{
+	static const u32 hisi_ptt_trace_availble_format[] = {
+		0,	/* 4DW */
+		1,	/* 8DW */
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(hisi_ptt_trace_availble_format); i++) {
+		if (val == hisi_ptt_trace_availble_format[i])
+			return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int hisi_ptt_trace_valid_filter(struct hisi_ptt *hisi_ptt, u64 config)
+{
+	unsigned long val, port_mask = hisi_ptt->port_mask;
+	struct hisi_ptt_filter_desc *filter;
+
+	hisi_ptt->trace_ctrl.is_port = FIELD_GET(HISI_PTT_PMU_FILTER_IS_PORT, config);
+	val = FIELD_GET(HISI_PTT_PMU_FILTER_VAL_MASK, config);
+
+	/*
+	 * Port filters are defined as bit mask. For port filters, check
+	 * the bits in the @val are within the range of hisi_ptt->port_mask
+	 * and whether it's empty or not, otherwise user has specified
+	 * some unsupported root ports.
+	 *
+	 * For Requester ID filters, walk the available filter list to see
+	 * whether we have one matched.
+	 */
+	if (!hisi_ptt->trace_ctrl.is_port) {
+		list_for_each_entry(filter, &hisi_ptt->req_filters, list) {
+			if (val == hisi_ptt_get_filter_val(filter->devid, filter->is_port))
+				return 0;
+		}
+	} else if (bitmap_subset(&val, &port_mask, BITS_PER_LONG)) {
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static void hisi_ptt_pmu_init_configs(struct hisi_ptt *hisi_ptt, struct perf_event *event)
+{
+	struct hisi_ptt_trace_ctrl *ctrl = &hisi_ptt->trace_ctrl;
+	u32 val;
+
+	val = FIELD_GET(HISI_PTT_PMU_FILTER_VAL_MASK, event->attr.config);
+	hisi_ptt->trace_ctrl.filter = val;
+
+	val = FIELD_GET(HISI_PTT_PMU_DIRECTION_MASK, event->attr.config);
+	ctrl->direction = val;
+
+	val = FIELD_GET(HISI_PTT_PMU_TYPE_MASK, event->attr.config);
+	ctrl->type = val;
+
+	val = FIELD_GET(HISI_PTT_PMU_FORMAT_MASK, event->attr.config);
+	ctrl->format = val;
+}
+
+static int hisi_ptt_pmu_event_init(struct perf_event *event)
+{
+	struct hisi_ptt *hisi_ptt = to_hisi_ptt(event->pmu);
+	int ret;
+	u32 val;
+
+	if (event->cpu < 0) {
+		dev_dbg(event->pmu->dev, "Per-task mode not supported\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (event->attr.type != hisi_ptt->hisi_ptt_pmu.type)
+		return -ENOENT;
+
+	ret = hisi_ptt_trace_valid_filter(hisi_ptt, event->attr.config);
+	if (ret < 0)
+		return ret;
+
+	val = FIELD_GET(HISI_PTT_PMU_DIRECTION_MASK, event->attr.config);
+	ret = hisi_ptt_trace_valid_direction(val);
+	if (ret < 0)
+		return ret;
+
+	val = FIELD_GET(HISI_PTT_PMU_TYPE_MASK, event->attr.config);
+	ret = hisi_ptt_trace_valid_type(val);
+	if (ret < 0)
+		return ret;
+
+	val = FIELD_GET(HISI_PTT_PMU_FORMAT_MASK, event->attr.config);
+	return hisi_ptt_trace_valid_format(val);
+}
+
+static void *hisi_ptt_pmu_setup_aux(struct perf_event *event, void **pages,
+				    int nr_pages, bool overwrite)
+{
+	struct hisi_ptt_pmu_buf *buf;
+	struct page **pagelist;
+	int i;
+
+	if (overwrite) {
+		dev_warn(event->pmu->dev, "Overwrite mode is not supported\n");
+		return NULL;
+	}
+
+	/* If the pages size less than buffers, we cannot start trace */
+	if (nr_pages < HISI_PTT_TRACE_TOTAL_BUF_SIZE / PAGE_SIZE)
+		return NULL;
+
+	buf = kzalloc(sizeof(*buf), GFP_KERNEL);
+	if (!buf)
+		return NULL;
+
+	pagelist = kcalloc(nr_pages, sizeof(*pagelist), GFP_KERNEL);
+	if (!pagelist)
+		goto err;
+
+	for (i = 0; i < nr_pages; i++)
+		pagelist[i] = virt_to_page(pages[i]);
+
+	buf->base = vmap(pagelist, nr_pages, VM_MAP, PAGE_KERNEL);
+	if (!buf->base) {
+		kfree(pagelist);
+		goto err;
+	}
+
+	buf->nr_pages = nr_pages;
+	buf->length = nr_pages * PAGE_SIZE;
+	buf->pos = 0;
+
+	kfree(pagelist);
+	return buf;
+err:
+	kfree(buf);
+	return NULL;
+}
+
+static void hisi_ptt_pmu_free_aux(void *aux)
+{
+	struct hisi_ptt_pmu_buf *buf = aux;
+
+	vunmap(buf->base);
+	kfree(buf);
+}
+
+static void hisi_ptt_pmu_start(struct perf_event *event, int flags)
+{
+	struct hisi_ptt *hisi_ptt = to_hisi_ptt(event->pmu);
+	struct perf_output_handle *handle = &hisi_ptt->trace_ctrl.handle;
+	struct hw_perf_event *hwc = &event->hw;
+	struct device *dev = event->pmu->dev;
+	struct hisi_ptt_pmu_buf *buf;
+	int cpu = event->cpu;
+	int ret;
+
+	hwc->state = 0;
+
+	/* Serialize the perf process if user specified several CPUs */
+	spin_lock(&hisi_ptt->pmu_lock);
+	if (hisi_ptt->trace_ctrl.started) {
+		dev_dbg(dev, "trace has already started\n");
+		goto stop;
+	}
+
+	/*
+	 * Handle the interrupt on the same cpu which starts the trace to avoid
+	 * context mismatch. Otherwise we'll trigger the WARN from the perf
+	 * core in event_function_local().
+	 */
+	WARN_ON(irq_set_affinity(pci_irq_vector(hisi_ptt->pdev, HISI_PTT_TRACE_DMA_IRQ),
+				 cpumask_of(cpu)));
+	hisi_ptt->trace_ctrl.on_cpu = cpu;
+
+	buf = perf_aux_output_begin(handle, event);
+	if (!buf) {
+		dev_dbg(dev, "aux output begin failed\n");
+		goto stop;
+	}
+
+	buf->pos = handle->head % buf->length;
+
+	hisi_ptt_pmu_init_configs(hisi_ptt, event);
+
+	ret = hisi_ptt_trace_start(hisi_ptt);
+	if (ret) {
+		dev_dbg(dev, "trace start failed, ret = %d\n", ret);
+		perf_aux_output_end(handle, 0);
+		goto stop;
+	}
+
+	spin_unlock(&hisi_ptt->pmu_lock);
+	return;
+stop:
+	event->hw.state |= PERF_HES_STOPPED;
+	spin_unlock(&hisi_ptt->pmu_lock);
+}
+
+static void hisi_ptt_pmu_stop(struct perf_event *event, int flags)
+{
+	struct hisi_ptt *hisi_ptt = to_hisi_ptt(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (hwc->state & PERF_HES_STOPPED)
+		return;
+
+	spin_lock(&hisi_ptt->pmu_lock);
+	if (hisi_ptt->trace_ctrl.started) {
+		hisi_ptt_trace_end(hisi_ptt);
+		WARN(!hisi_ptt_wait_trace_hw_idle(hisi_ptt), "Device is still busy");
+		hisi_ptt_update_aux(hisi_ptt, hisi_ptt->trace_ctrl.buf_index, true);
+	}
+	spin_unlock(&hisi_ptt->pmu_lock);
+
+	hwc->state |= PERF_HES_STOPPED;
+	perf_event_update_userpage(event);
+	hwc->state |= PERF_HES_UPTODATE;
+}
+
+static int hisi_ptt_pmu_add(struct perf_event *event, int flags)
+{
+	struct hisi_ptt *hisi_ptt = to_hisi_ptt(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	int cpu = event->cpu;
+
+	/* Only allow the cpus on the device's node to add the event */
+	if (!cpumask_test_cpu(cpu, cpumask_of_node(dev_to_node(&hisi_ptt->pdev->dev))))
+		return 0;
+
+	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
+
+	if (flags & PERF_EF_START) {
+		hisi_ptt_pmu_start(event, PERF_EF_RELOAD);
+		if (hwc->state & PERF_HES_STOPPED)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void hisi_ptt_pmu_del(struct perf_event *event, int flags)
+{
+	hisi_ptt_pmu_stop(event, PERF_EF_UPDATE);
+}
+
+static void hisi_ptt_remove_cpuhp_instance(void *hotplug_node)
+{
+	cpuhp_state_remove_instance(hisi_ptt_pmu_online, hotplug_node);
+}
+
+static void hisi_ptt_unregister_pmu(void *pmu)
+{
+	perf_pmu_unregister(pmu);
+}
+
+static int hisi_ptt_register_pmu(struct hisi_ptt *hisi_ptt)
+{
+	u16 core_id, sicl_id;
+	char *pmu_name;
+	u32 reg;
+	int ret;
+
+	ret = cpuhp_state_add_instance(hisi_ptt_pmu_online, &hisi_ptt->hotplug_node);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(&hisi_ptt->pdev->dev,
+				       hisi_ptt_remove_cpuhp_instance,
+				       &hisi_ptt->hotplug_node);
+	if (ret)
+		return ret;
+
+	spin_lock_init(&hisi_ptt->pmu_lock);
+
+	hisi_ptt->hisi_ptt_pmu = (struct pmu) {
+		.module		= THIS_MODULE,
+		.capabilities	= PERF_PMU_CAP_EXCLUSIVE | PERF_PMU_CAP_ITRACE,
+		.task_ctx_nr	= perf_sw_context,
+		.attr_groups	= hisi_ptt_pmu_groups,
+		.event_init	= hisi_ptt_pmu_event_init,
+		.setup_aux	= hisi_ptt_pmu_setup_aux,
+		.free_aux	= hisi_ptt_pmu_free_aux,
+		.start		= hisi_ptt_pmu_start,
+		.stop		= hisi_ptt_pmu_stop,
+		.add		= hisi_ptt_pmu_add,
+		.del		= hisi_ptt_pmu_del,
+	};
+
+	reg = readl(hisi_ptt->iobase + HISI_PTT_LOCATION);
+	core_id = FIELD_GET(HISI_PTT_CORE_ID, reg);
+	sicl_id = FIELD_GET(HISI_PTT_SICL_ID, reg);
+
+	pmu_name = devm_kasprintf(&hisi_ptt->pdev->dev, GFP_KERNEL, "hisi_ptt%u_%u",
+				  sicl_id, core_id);
+	if (!pmu_name)
+		return -ENOMEM;
+
+	ret = perf_pmu_register(&hisi_ptt->hisi_ptt_pmu, pmu_name, -1);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(&hisi_ptt->pdev->dev,
+					hisi_ptt_unregister_pmu,
+					&hisi_ptt->hisi_ptt_pmu);
+}
+
+/*
+ * The DMA of PTT trace can only use direct mappings due to some
+ * hardware restriction. Check whether there is no IOMMU or the
+ * policy of the IOMMU domain is passthrough, otherwise the trace
+ * cannot work.
+ *
+ * The PTT device is supposed to behind an ARM SMMUv3, which
+ * should have passthrough the device by a quirk.
+ */
+static int hisi_ptt_check_iommu_mapping(struct pci_dev *pdev)
+{
+	struct iommu_domain *iommu_domain;
+
+	iommu_domain = iommu_get_domain_for_dev(&pdev->dev);
+	if (!iommu_domain || iommu_domain->type == IOMMU_DOMAIN_IDENTITY)
+		return 0;
+
+	return -EOPNOTSUPP;
+}
+
+static int hisi_ptt_probe(struct pci_dev *pdev,
+			  const struct pci_device_id *id)
+{
+	struct hisi_ptt *hisi_ptt;
+	int ret;
+
+	ret = hisi_ptt_check_iommu_mapping(pdev);
+	if (ret) {
+		pci_err(pdev, "requires direct DMA mappings\n");
+		return ret;
+	}
+
+	hisi_ptt = devm_kzalloc(&pdev->dev, sizeof(*hisi_ptt), GFP_KERNEL);
+	if (!hisi_ptt)
+		return -ENOMEM;
+
+	hisi_ptt->pdev = pdev;
+	pci_set_drvdata(pdev, hisi_ptt);
+
+	ret = pcim_enable_device(pdev);
+	if (ret) {
+		pci_err(pdev, "failed to enable device, ret = %d\n", ret);
+		return ret;
+	}
+
+	ret = pcim_iomap_regions(pdev, BIT(2), DRV_NAME);
+	if (ret) {
+		pci_err(pdev, "failed to remap io memory, ret = %d\n", ret);
+		return ret;
+	}
+
+	hisi_ptt->iobase = pcim_iomap_table(pdev)[2];
+
+	ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
+	if (ret) {
+		pci_err(pdev, "failed to set 64 bit dma mask, ret = %d\n", ret);
+		return ret;
+	}
+
+	pci_set_master(pdev);
+
+	ret = hisi_ptt_register_irq(hisi_ptt);
+	if (ret)
+		return ret;
+
+	ret = hisi_ptt_init_ctrls(hisi_ptt);
+	if (ret) {
+		pci_err(pdev, "failed to init controls, ret = %d\n", ret);
+		return ret;
+	}
+
+	ret = hisi_ptt_register_pmu(hisi_ptt);
+	if (ret) {
+		pci_err(pdev, "failed to register PMU device, ret = %d", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct pci_device_id hisi_ptt_id_tbl[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, 0xa12e) },
+	{ }
+};
+MODULE_DEVICE_TABLE(pci, hisi_ptt_id_tbl);
+
+static struct pci_driver hisi_ptt_driver = {
+	.name = DRV_NAME,
+	.id_table = hisi_ptt_id_tbl,
+	.probe = hisi_ptt_probe,
+};
+
+static int hisi_ptt_cpu_teardown(unsigned int cpu, struct hlist_node *node)
+{
+	struct hisi_ptt *hisi_ptt;
+	int target, src;
+
+	hisi_ptt = hlist_entry_safe(node, struct hisi_ptt, hotplug_node);
+	src = hisi_ptt->trace_ctrl.on_cpu;
+
+	if (!hisi_ptt->trace_ctrl.started || src != cpu)
+		return 0;
+
+	target = cpumask_any(cpumask_of_node(dev_to_node(&hisi_ptt->pdev->dev)));
+	if (target >= nr_cpu_ids) {
+		dev_err(hisi_ptt->hisi_ptt_pmu.dev,
+			"no available cpu for perf context migration\n");
+		return 0;
+	}
+
+	perf_pmu_migrate_context(&hisi_ptt->hisi_ptt_pmu, src, target);
+	WARN_ON(irq_set_affinity(pci_irq_vector(hisi_ptt->pdev, HISI_PTT_TRACE_DMA_IRQ),
+				 cpumask_of(cpu)));
+	hisi_ptt->trace_ctrl.on_cpu = target;
+
+	return 0;
+}
+
+static int __init hisi_ptt_init(void)
+{
+	int ret;
+
+	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN, DRV_NAME, NULL,
+				      hisi_ptt_cpu_teardown);
+	if (ret < 0)
+		return ret;
+	hisi_ptt_pmu_online = ret;
+
+	ret = pci_register_driver(&hisi_ptt_driver);
+	if (ret)
+		cpuhp_remove_multi_state(hisi_ptt_pmu_online);
+
+	return ret;
+}
+module_init(hisi_ptt_init);
+
+static void __exit hisi_ptt_exit(void)
+{
+	pci_unregister_driver(&hisi_ptt_driver);
+	cpuhp_remove_multi_state(hisi_ptt_pmu_online);
+}
+module_exit(hisi_ptt_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Yicong Yang <yangyicong@hisilicon.com>");
+MODULE_DESCRIPTION("Driver for HiSilicon PCIe tune and trace device");
diff --git a/drivers/hwtracing/ptt/hisi_ptt.h b/drivers/hwtracing/ptt/hisi_ptt.h
new file mode 100644
index 000000000000..10446dce8a86
--- /dev/null
+++ b/drivers/hwtracing/ptt/hisi_ptt.h
@@ -0,0 +1,177 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Driver for HiSilicon PCIe tune and trace device
+ *
+ * Copyright (c) 2022 HiSilicon Technologies Co., Ltd.
+ * Author: Yicong Yang <yangyicong@hisilicon.com>
+ */
+
+#ifndef _HISI_PTT_H
+#define _HISI_PTT_H
+
+#include <linux/bits.h>
+#include <linux/cpumask.h>
+#include <linux/list.h>
+#include <linux/pci.h>
+#include <linux/perf_event.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+#define DRV_NAME "hisi_ptt"
+
+/*
+ * The definition of the device registers and register fields.
+ */
+#define HISI_PTT_TRACE_ADDR_SIZE	0x0800
+#define HISI_PTT_TRACE_ADDR_BASE_LO_0	0x0810
+#define HISI_PTT_TRACE_ADDR_BASE_HI_0	0x0814
+#define HISI_PTT_TRACE_ADDR_STRIDE	0x8
+#define HISI_PTT_TRACE_CTRL		0x0850
+#define   HISI_PTT_TRACE_CTRL_EN	BIT(0)
+#define   HISI_PTT_TRACE_CTRL_RST	BIT(1)
+#define   HISI_PTT_TRACE_CTRL_RXTX_SEL	GENMASK(3, 2)
+#define   HISI_PTT_TRACE_CTRL_TYPE_SEL	GENMASK(7, 4)
+#define   HISI_PTT_TRACE_CTRL_DATA_FORMAT	BIT(14)
+#define   HISI_PTT_TRACE_CTRL_FILTER_MODE	BIT(15)
+#define   HISI_PTT_TRACE_CTRL_TARGET_SEL	GENMASK(31, 16)
+#define HISI_PTT_TRACE_INT_STAT		0x0890
+#define   HISI_PTT_TRACE_INT_STAT_MASK	GENMASK(3, 0)
+#define HISI_PTT_TRACE_INT_MASK		0x0894
+#define HISI_PTT_TRACE_WR_STS		0x08a0
+#define   HISI_PTT_TRACE_WR_STS_WRITE	GENMASK(27, 0)
+#define   HISI_PTT_TRACE_WR_STS_BUFFER	GENMASK(29, 28)
+#define HISI_PTT_TRACE_STS		0x08b0
+#define   HISI_PTT_TRACE_IDLE		BIT(0)
+#define HISI_PTT_DEVICE_RANGE		0x0fe0
+#define   HISI_PTT_DEVICE_RANGE_UPPER	GENMASK(31, 16)
+#define   HISI_PTT_DEVICE_RANGE_LOWER	GENMASK(15, 0)
+#define HISI_PTT_LOCATION		0x0fe8
+#define   HISI_PTT_CORE_ID		GENMASK(15, 0)
+#define   HISI_PTT_SICL_ID		GENMASK(31, 16)
+
+/* Parameters of PTT trace DMA part. */
+#define HISI_PTT_TRACE_DMA_IRQ			0
+#define HISI_PTT_TRACE_BUF_CNT			4
+#define HISI_PTT_TRACE_BUF_SIZE			SZ_4M
+#define HISI_PTT_TRACE_TOTAL_BUF_SIZE		(HISI_PTT_TRACE_BUF_SIZE * \
+						 HISI_PTT_TRACE_BUF_CNT)
+/* Wait time for hardware DMA to reset */
+#define HISI_PTT_RESET_TIMEOUT_US	10UL
+#define HISI_PTT_RESET_POLL_INTERVAL_US	1UL
+/* Poll timeout and interval for waiting hardware work to finish */
+#define HISI_PTT_WAIT_TRACE_TIMEOUT_US	100UL
+#define HISI_PTT_WAIT_POLL_INTERVAL_US	10UL
+
+#define HISI_PCIE_CORE_PORT_ID(devfn)	((PCI_SLOT(devfn) & 0x7) << 1)
+
+/* Definition of the PMU configs */
+#define HISI_PTT_PMU_FILTER_IS_PORT	BIT(19)
+#define HISI_PTT_PMU_FILTER_VAL_MASK	GENMASK(15, 0)
+#define HISI_PTT_PMU_DIRECTION_MASK	GENMASK(23, 20)
+#define HISI_PTT_PMU_TYPE_MASK		GENMASK(31, 24)
+#define HISI_PTT_PMU_FORMAT_MASK	GENMASK(35, 32)
+
+/**
+ * struct hisi_ptt_dma_buffer - Describe a single trace buffer of PTT trace.
+ *                              The detail of the data format is described
+ *                              in the documentation of PTT device.
+ * @dma:   DMA address of this buffer visible to the device
+ * @addr:  virtual address of this buffer visible to the cpu
+ */
+struct hisi_ptt_dma_buffer {
+	dma_addr_t dma;
+	void *addr;
+};
+
+/**
+ * struct hisi_ptt_trace_ctrl - Control and status of PTT trace
+ * @trace_buf: array of the trace buffers for holding the trace data.
+ *             the length will be HISI_PTT_TRACE_BUF_CNT.
+ * @handle:    perf output handle of current trace session
+ * @buf_index: the index of current using trace buffer
+ * @on_cpu:    current tracing cpu
+ * @started:   current trace status, true for started
+ * @is_port:   whether we're tracing root port or not
+ * @direction: direction of the TLP headers to trace
+ * @filter:    filter value for tracing the TLP headers
+ * @format:    format of the TLP headers to trace
+ * @type:      type of the TLP headers to trace
+ */
+struct hisi_ptt_trace_ctrl {
+	struct hisi_ptt_dma_buffer *trace_buf;
+	struct perf_output_handle handle;
+	u32 buf_index;
+	int on_cpu;
+	bool started;
+	bool is_port;
+	u32 direction:2;
+	u32 filter:16;
+	u32 format:1;
+	u32 type:4;
+};
+
+/**
+ * struct hisi_ptt_filter_desc - Descriptor of the PTT trace filter
+ * @list:    entry of this descriptor in the filter list
+ * @is_port: the PCI device of the filter is a Root Port or not
+ * @devid:   the PCI device's devid of the filter
+ */
+struct hisi_ptt_filter_desc {
+	struct list_head list;
+	bool is_port;
+	u16 devid;
+};
+
+/**
+ * struct hisi_ptt_pmu_buf - Descriptor of the AUX buffer of PTT trace
+ * @length:   size of the AUX buffer
+ * @nr_pages: number of pages of the AUX buffer
+ * @base:     start address of AUX buffer
+ * @pos:      position in the AUX buffer to commit traced data
+ */
+struct hisi_ptt_pmu_buf {
+	size_t length;
+	int nr_pages;
+	void *base;
+	long pos;
+};
+
+/**
+ * struct hisi_ptt - Per PTT device data
+ * @trace_ctrl:   the control information of PTT trace
+ * @hotplug_node: node for register cpu hotplug event
+ * @hisi_ptt_pmu: the pum device of trace
+ * @iobase:       base IO address of the device
+ * @pdev:         pci_dev of this PTT device
+ * @pmu_lock:     lock to serialize the perf process
+ * @upper_bdf:    the upper BDF range of the PCI devices managed by this PTT device
+ * @lower_bdf:    the lower BDF range of the PCI devices managed by this PTT device
+ * @port_filters: the filter list of root ports
+ * @req_filters:  the filter list of requester ID
+ * @port_mask:    port mask of the managed root ports
+ */
+struct hisi_ptt {
+	struct hisi_ptt_trace_ctrl trace_ctrl;
+	struct hlist_node hotplug_node;
+	struct pmu hisi_ptt_pmu;
+	void __iomem *iobase;
+	struct pci_dev *pdev;
+	spinlock_t pmu_lock;
+	u32 upper_bdf;
+	u32 lower_bdf;
+
+	/*
+	 * The trace TLP headers can either be filtered by certain
+	 * root port, or by the requester ID. Organize the filters
+	 * by @port_filters and @req_filters here. The mask of all
+	 * the valid ports is also cached for doing sanity check
+	 * of user input.
+	 */
+	struct list_head port_filters;
+	struct list_head req_filters;
+	u16 port_mask;
+};
+
+#define to_hisi_ptt(pmu) container_of(pmu, struct hisi_ptt, hisi_ptt_pmu)
+
+#endif /* _HISI_PTT_H */
-- 
2.24.0

