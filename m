Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072AF521373
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240806AbiEJLWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbiEJLWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:22:21 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088571868CB;
        Tue, 10 May 2022 04:18:24 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KyFrg0FHYzhYfG;
        Tue, 10 May 2022 19:17:55 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 10 May 2022 19:18:21 +0800
CC:     <prime.zeng@huawei.com>, <liuqi115@huawei.com>,
        <zhangshaokun@hisilicon.com>, <linuxarm@huawei.com>,
        <gregkh@linuxfoundation.org>, <helgaas@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <lorenzo.pieralisi@arm.com>,
        <will@kernel.org>, <mark.rutland@arm.com>,
        <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>, <leo.yan@linaro.org>,
        <jonathan.cameron@huawei.com>, <daniel.thompson@linaro.org>,
        <joro@8bytes.org>, <john.garry@huawei.com>,
        <shameerali.kolothum.thodi@huawei.com>, <robin.murphy@arm.com>,
        <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <coresight@lists.linaro.org>, <linux-pci@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH v7 2/7] hwtracing: Add trace function support for
 HiSilicon PCIe Tune and Trace device
To:     James Clark <james.clark@arm.com>
References: <20220407125841.3678-1-yangyicong@hisilicon.com>
 <20220407125841.3678-3-yangyicong@hisilicon.com>
 <e56c02c5-3696-c8d5-89e0-050bfe9edaa8@arm.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <ad518edf-425b-f2ab-08e9-5a00b712508c@huawei.com>
Date:   Tue, 10 May 2022 19:18:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <e56c02c5-3696-c8d5-89e0-050bfe9edaa8@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/10 17:46, James Clark wrote:
> 
> 
> On 07/04/2022 13:58, Yicong Yang wrote:
>> HiSilicon PCIe tune and trace device(PTT) is a PCIe Root Complex integrated
>> Endpoint(RCiEP) device, providing the capability to dynamically monitor and
>> tune the PCIe traffic, and trace the TLP headers.
>>
>> Add the driver for the device to enable the trace function. Register PMU
>> device of PTT trace, then users can use trace through perf command. The
>> driver makes use of perf AUX trace and support following events to
>> configure the trace:
>>
>> - filter: select Root port or Endpoint to trace
>> - type: select the type of traced TLP headers
>> - direction: select the direction of traced TLP headers
>> - format: select the data format of the traced TLP headers
>>
>> This patch adds the driver part of PTT trace. The perf command support of
>> PTT trace is added in the following patch.
>>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>  drivers/Makefile                 |   1 +
>>  drivers/hwtracing/Kconfig        |   2 +
>>  drivers/hwtracing/ptt/Kconfig    |  12 +
>>  drivers/hwtracing/ptt/Makefile   |   2 +
>>  drivers/hwtracing/ptt/hisi_ptt.c | 874 +++++++++++++++++++++++++++++++
>>  drivers/hwtracing/ptt/hisi_ptt.h | 166 ++++++
>>  6 files changed, 1057 insertions(+)
>>  create mode 100644 drivers/hwtracing/ptt/Kconfig
>>  create mode 100644 drivers/hwtracing/ptt/Makefile
>>  create mode 100644 drivers/hwtracing/ptt/hisi_ptt.c
>>  create mode 100644 drivers/hwtracing/ptt/hisi_ptt.h
>>
>> diff --git a/drivers/Makefile b/drivers/Makefile
>> index 020780b6b4d2..662d50599467 100644
>> --- a/drivers/Makefile
>> +++ b/drivers/Makefile
>> @@ -175,6 +175,7 @@ obj-$(CONFIG_USB4)		+= thunderbolt/
>>  obj-$(CONFIG_CORESIGHT)		+= hwtracing/coresight/
>>  obj-y				+= hwtracing/intel_th/
>>  obj-$(CONFIG_STM)		+= hwtracing/stm/
>> +obj-$(CONFIG_HISI_PTT)		+= hwtracing/ptt/
>>  obj-$(CONFIG_ANDROID)		+= android/
>>  obj-$(CONFIG_NVMEM)		+= nvmem/
>>  obj-$(CONFIG_FPGA)		+= fpga/
>> diff --git a/drivers/hwtracing/Kconfig b/drivers/hwtracing/Kconfig
>> index 13085835a636..911ee977103c 100644
>> --- a/drivers/hwtracing/Kconfig
>> +++ b/drivers/hwtracing/Kconfig
>> @@ -5,4 +5,6 @@ source "drivers/hwtracing/stm/Kconfig"
>>  
>>  source "drivers/hwtracing/intel_th/Kconfig"
>>  
>> +source "drivers/hwtracing/ptt/Kconfig"
>> +
>>  endmenu
>> diff --git a/drivers/hwtracing/ptt/Kconfig b/drivers/hwtracing/ptt/Kconfig
>> new file mode 100644
>> index 000000000000..8902a6f27563
>> --- /dev/null
>> +++ b/drivers/hwtracing/ptt/Kconfig
>> @@ -0,0 +1,12 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +config HISI_PTT
>> +	tristate "HiSilicon PCIe Tune and Trace Device"
>> +	depends on ARM64 || (COMPILE_TEST && 64BIT)
>> +	depends on PCI && HAS_DMA && HAS_IOMEM && PERF_EVENTS
>> +	help
>> +	  HiSilicon PCIe Tune and Trace Device exists as a PCIe RCiEP
>> +	  device, and it provides support for PCIe traffic tuning and
>> +	  tracing TLP headers to the memory.
>> +
>> +	  This driver can also be built as a module. If so, the module
>> +	  will be called hisi_ptt.
>> diff --git a/drivers/hwtracing/ptt/Makefile b/drivers/hwtracing/ptt/Makefile
>> new file mode 100644
>> index 000000000000..908c09a98161
>> --- /dev/null
>> +++ b/drivers/hwtracing/ptt/Makefile
>> @@ -0,0 +1,2 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +obj-$(CONFIG_HISI_PTT) += hisi_ptt.o
>> diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
>> new file mode 100644
>> index 000000000000..242b41870380
>> --- /dev/null
>> +++ b/drivers/hwtracing/ptt/hisi_ptt.c
>> @@ -0,0 +1,874 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Driver for HiSilicon PCIe tune and trace device
>> + *
>> + * Copyright (c) 2022 HiSilicon Technologies Co., Ltd.
>> + * Author: Yicong Yang <yangyicong@hisilicon.com>
>> + */
>> +
>> +#include <linux/bitfield.h>
>> +#include <linux/bitops.h>
>> +#include <linux/delay.h>
>> +#include <linux/dma-iommu.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/iommu.h>
>> +#include <linux/iopoll.h>
>> +#include <linux/module.h>
>> +#include <linux/sysfs.h>
>> +#include <linux/vmalloc.h>
>> +
>> +#include "hisi_ptt.h"
>> +
>> +static u16 hisi_ptt_get_filter_val(struct pci_dev *pdev)
>> +{
>> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT)
>> +		return BIT(HISI_PCIE_CORE_PORT_ID(PCI_SLOT(pdev->devfn)));
>> +
>> +	return PCI_DEVID(pdev->bus->number, pdev->devfn);
>> +}
>> +
>> +static bool hisi_ptt_wait_trace_hw_idle(struct hisi_ptt *hisi_ptt)
>> +{
>> +	u32 val;
>> +
>> +	return !readl_poll_timeout_atomic(hisi_ptt->iobase + HISI_PTT_TRACE_STS,
>> +					  val, val & HISI_PTT_TRACE_IDLE,
>> +					  HISI_PTT_WAIT_POLL_INTERVAL_US,
>> +					  HISI_PTT_WAIT_TRACE_TIMEOUT_US);
>> +}
>> +
>> +static bool hisi_ptt_wait_dma_reset_done(struct hisi_ptt *hisi_ptt)
>> +{
>> +	u32 val;
>> +
>> +	return !readl_poll_timeout_atomic(hisi_ptt->iobase + HISI_PTT_TRACE_WR_STS,
>> +					  val, !val, HISI_PTT_RESET_POLL_INTERVAL_US,
>> +					  HISI_PTT_RESET_TIMEOUT_US);
>> +}
>> +
>> +static void hisi_ptt_free_trace_buf(struct hisi_ptt *hisi_ptt)
>> +{
>> +	struct hisi_ptt_trace_ctrl *ctrl = &hisi_ptt->trace_ctrl;
>> +	struct device *dev = &hisi_ptt->pdev->dev;
>> +	int i;
>> +
>> +	if (!ctrl->trace_buf)
>> +		return;
>> +
>> +	for (i = 0; i < HISI_PTT_TRACE_BUF_CNT; i++) {
>> +		if (ctrl->trace_buf[i].addr)
>> +			dmam_free_coherent(dev, HISI_PTT_TRACE_BUF_SIZE,
>> +					   ctrl->trace_buf[i].addr,
>> +					   ctrl->trace_buf[i].dma);
>> +	}
>> +
>> +	devm_kfree(dev, ctrl->trace_buf);
>> +	ctrl->trace_buf = NULL;
>> +}
>> +
>> +static int hisi_ptt_alloc_trace_buf(struct hisi_ptt *hisi_ptt)
>> +{
>> +	struct hisi_ptt_trace_ctrl *ctrl = &hisi_ptt->trace_ctrl;
>> +	struct device *dev = &hisi_ptt->pdev->dev;
>> +	int i;
>> +
>> +	hisi_ptt->trace_ctrl.buf_index = 0;
>> +
>> +	/* If the trace buffer has already been allocated, zero it. */
>> +	if (ctrl->trace_buf) {
>> +		for (i = 0; i < HISI_PTT_TRACE_BUF_CNT; i++)
>> +			memset(ctrl->trace_buf[i].addr, 0, HISI_PTT_TRACE_BUF_SIZE);
>> +		return 0;
>> +	}
>> +
>> +	ctrl->trace_buf = devm_kcalloc(dev, HISI_PTT_TRACE_BUF_CNT,
>> +				       sizeof(struct hisi_ptt_dma_buffer), GFP_KERNEL);
>> +	if (!ctrl->trace_buf)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < HISI_PTT_TRACE_BUF_CNT; ++i) {
>> +		ctrl->trace_buf[i].addr = dmam_alloc_coherent(dev, HISI_PTT_TRACE_BUF_SIZE,
>> +							     &ctrl->trace_buf[i].dma,
>> +							     GFP_KERNEL);
>> +		if (!ctrl->trace_buf[i].addr) {
>> +			hisi_ptt_free_trace_buf(hisi_ptt);
>> +			return -ENOMEM;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void hisi_ptt_trace_end(struct hisi_ptt *hisi_ptt)
>> +{
>> +	writel(0, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
>> +	hisi_ptt->trace_ctrl.started = false;
>> +}
>> +
>> +static int hisi_ptt_trace_start(struct hisi_ptt *hisi_ptt)
>> +{
>> +	struct hisi_ptt_trace_ctrl *ctrl = &hisi_ptt->trace_ctrl;
>> +	u32 val;
>> +	int i;
>> +
>> +	/* Check device idle before start trace */
>> +	if (!hisi_ptt_wait_trace_hw_idle(hisi_ptt)) {
>> +		pci_err(hisi_ptt->pdev, "Failed to start trace, the device is still busy\n");
>> +		return -EBUSY;
>> +	}
>> +
>> +	ctrl->started = true;
>> +
>> +	/* Reset the DMA before start tracing */
>> +	val = readl(hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
>> +	val |= HISI_PTT_TRACE_CTRL_RST;
>> +	writel(val, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
>> +
>> +	hisi_ptt_wait_dma_reset_done(hisi_ptt);
>> +
>> +	val = readl(hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
>> +	val &= ~HISI_PTT_TRACE_CTRL_RST;
>> +	writel(val, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
>> +
>> +	/* Clear the interrupt status */
>> +	writel(HISI_PTT_TRACE_INT_STAT_MASK, hisi_ptt->iobase + HISI_PTT_TRACE_INT_STAT);
>> +	writel(0, hisi_ptt->iobase + HISI_PTT_TRACE_INT_MASK);
>> +
>> +	/* Configure the trace DMA buffer */
>> +	for (i = 0; i < HISI_PTT_TRACE_BUF_CNT; i++) {
>> +		writel(lower_32_bits(ctrl->trace_buf[i].dma),
>> +		       hisi_ptt->iobase + HISI_PTT_TRACE_ADDR_BASE_LO_0 +
>> +		       i * HISI_PTT_TRACE_ADDR_STRIDE);
>> +		writel(upper_32_bits(ctrl->trace_buf[i].dma),
>> +		       hisi_ptt->iobase + HISI_PTT_TRACE_ADDR_BASE_HI_0 +
>> +		       i * HISI_PTT_TRACE_ADDR_STRIDE);
>> +	}
>> +	writel(HISI_PTT_TRACE_BUF_SIZE, hisi_ptt->iobase + HISI_PTT_TRACE_ADDR_SIZE);
>> +
>> +	/* Set the trace control register */
>> +	val = FIELD_PREP(HISI_PTT_TRACE_CTRL_TYPE_SEL, ctrl->type);
>> +	val |= FIELD_PREP(HISI_PTT_TRACE_CTRL_RXTX_SEL, ctrl->direction);
>> +	val |= FIELD_PREP(HISI_PTT_TRACE_CTRL_DATA_FORMAT, ctrl->format);
>> +	val |= FIELD_PREP(HISI_PTT_TRACE_CTRL_TARGET_SEL, hisi_ptt->trace_ctrl.filter);
>> +	if (!hisi_ptt->trace_ctrl.is_port)
>> +		val |= HISI_PTT_TRACE_CTRL_FILTER_MODE;
>> +
>> +	/* Start the Trace */
>> +	val |= HISI_PTT_TRACE_CTRL_EN;
>> +	writel(val, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
>> +
>> +	return 0;
>> +}
>> +
>> +static int hisi_ptt_update_aux(struct hisi_ptt *hisi_ptt, int index, bool stop)
>> +{
>> +	struct hisi_ptt_trace_ctrl *ctrl = &hisi_ptt->trace_ctrl;
>> +	struct perf_output_handle *handle = &ctrl->handle;
>> +	struct perf_event *event = handle->event;
>> +	struct hisi_ptt_pmu_buf *buf;
>> +	void *addr;
>> +
>> +	buf = perf_get_aux(handle);
>> +	if (!buf || !handle->size)
>> +		return -EINVAL;
>> +
>> +	addr = ctrl->trace_buf[ctrl->buf_index].addr;
>> +
>> +	memcpy(buf->base + buf->pos, addr, HISI_PTT_TRACE_BUF_SIZE);
>> +	memset(addr, 0, HISI_PTT_TRACE_BUF_SIZE);
> 
> Hi Kicong,
> 
> I also have the same comment as Leo here, I don't think the memset is
> required.
> 

It's necessary in the current approach as we always commit HISI_PTT_TRACE_BUF_SIZE
data but the buffer maybe partly filled (called when perf going to stopp, not by the
interrupt). The buffer is cleared so the unfilled part of the buffer will have
empty data (normal traced TLP headers won't be all 0), then the user can distinguish
the valid part of the data.

I'm trying to only copy the traced data rather than the whole buffer then the
clear operation here will be unnecessary. The hardware provide a register indicating
which offset of which buffer it's currently writing to and it canbe used here.

>> +	buf->pos += HISI_PTT_TRACE_BUF_SIZE;
>> +
>> +	if (stop) {
>> +		perf_aux_output_end(handle, buf->pos);
>> +	} else if (buf->length - buf->pos < HISI_PTT_TRACE_BUF_SIZE) {
>> +		perf_aux_output_skip(handle, buf->length - buf->pos);
> 
> perf_aux_output_skip() can also return an error so should probably also
> be checked like perf_aux_output_begin()
> 

ok it should be checked.

> I'm also wondering why there is a skip for every output_end()? Is that
> to avoid having two memcpy calls to handle the wrap around if the data
> to be copied goes past the end of the aux buffer?
> 
> For example if your buffers are 4MB each and the aux buffer that the
> user picked isn't a multiple of 4 I can see you needing to write the
> first part of the 4MB to the end of the aux buffer and then the last
> part to the beginning which would be two memcpy() calls. And then a
> skip wouldn't be required.
> 

I intended to handle the case that AUX buffer is not a multiple of 4 MiB.
When the resident AUX buffer size is less than 4MiB, we're not going to
commit data to it and will apply a new AUX buffer instead. I think you're
right that the perf_aux_output_skip() is unnecessary here. Thanks for
catching this.

> I looked at all the other uses of perf_output_end() and perf_output_skip()
> in the kernel and didn't see a pattern like yours so it seems suspicous to
> me. Maybe at least some comments around this section are needed.
> 

Will add some comments of the handling here.

Regards,
Yicong
