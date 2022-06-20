Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8DDA551EDF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 16:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241878AbiFTOfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 10:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345010AbiFTOeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 10:34:19 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5840D13DF6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:50:19 -0700 (PDT)
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LRWH84P6hz67vpG;
        Mon, 20 Jun 2022 21:49:56 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 20 Jun 2022 15:50:16 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 20 Jun
 2022 14:50:16 +0100
Date:   Mon, 20 Jun 2022 14:50:14 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <will@kernel.org>,
        <mark.rutland@arm.com>, <baolin.wang@linux.alibaba.com>,
        <yaohongbo@linux.alibaba.com>, <nengchen@linux.alibaba.com>,
        <zhuo.song@linux.alibaba.com>
Subject: Re: [PATCH v1 2/3] drivers/perf: add DDR Sub-System Driveway PMU
 driver for Yitian 710 SoC
Message-ID: <20220620145014.00000100@Huawei.com>
In-Reply-To: <20220617111825.92911-3-xueshuai@linux.alibaba.com>
References: <20220617111825.92911-1-xueshuai@linux.alibaba.com>
        <20220617111825.92911-3-xueshuai@linux.alibaba.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml748-chm.china.huawei.com (10.201.108.198) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jun 2022 19:18:24 +0800
Shuai Xue <xueshuai@linux.alibaba.com> wrote:

> Add the DDR Sub-System Driveway Performance Monitoring Unit (PMU) driver
> support for Alibaba T-Head Yitian 710 SoC chip. Yitian supports the most
> advanced DDR5/4 DRAM to provide tremendous memory bandwidth for cloud
> computing and HPC.

A little marketing heavy for a patch description but I suppose that's harmless!
Maybe the shorter option of something like

"Yitian supports DDR5/4 DRAM and targets cloud computing and HPC."
> 
> Each PMU is registered as a device in /sys/bus/event_source/devices, and
> users can select event to monitor in each sub-channel, independently. For
> example, ali_drw_21000 and ali_drw_21080 are two PMU devices for two
> sub-channels of the same channel in die 0. And the PMU device of die 1 is
> prefixed with ali_drw_400XXXXX, e.g. ali_drw_40021000.
> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Signed-off-by: Hongbo Yao <yaohongbo@linux.alibaba.com>
> Signed-off-by: Neng Chen <nengchen@linux.alibaba.com>

Unusual to have such a deep sign off list for a patch positing.  Is
Co-developed appropriate here?

A few comments inline, but I only took a fairly superficial look.

Thanks,

Jonathan


> ---
>  drivers/perf/Kconfig                  |   8 +
>  drivers/perf/Makefile                 |   1 +
>  drivers/perf/alibaba_uncore_drw_pmu.c | 771 ++++++++++++++++++++++++++
>  3 files changed, 780 insertions(+)
>  create mode 100644 drivers/perf/alibaba_uncore_drw_pmu.c
> 

> diff --git a/drivers/perf/alibaba_uncore_drw_pmu.c b/drivers/perf/alibaba_uncore_drw_pmu.c
> new file mode 100644
> index 000000000000..9228ff672276
> --- /dev/null
> +++ b/drivers/perf/alibaba_uncore_drw_pmu.c
> @@ -0,0 +1,771 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Alibaba DDR Sub-System Driveway PMU driver
> + *
> + * Copyright (C) 2022 Alibaba Inc
> + */
> +
> +#define ALI_DRW_PMUNAME		"ali_drw"
> +#define ALI_DRW_DRVNAME		ALI_DRW_PMUNAME "_pmu"
> +#define pr_fmt(fmt)		ALI_DRW_DRVNAME ": " fmt
> +
> +#include <linux/acpi.h>
> +#include <linux/perf_event.h>
> +#include <linux/platform_device.h>
> +

...

> +static struct attribute *ali_drw_pmu_events_attrs[] = {
> +	ALI_DRW_PMU_EVENT_ATTR(perf_hif_rd_or_wr,		0x0),

As mentioned in review of patch 1, why perf_ prefix?
Also, what's hif, dfi, hpr, lpr wpr etc?

> +	ALI_DRW_PMU_EVENT_ATTR(perf_hif_wr,			0x1),
> +	ALI_DRW_PMU_EVENT_ATTR(perf_hif_rd,			0x2),
> +	ALI_DRW_PMU_EVENT_ATTR(perf_hif_rmw,			0x3),
> +	ALI_DRW_PMU_EVENT_ATTR(perf_hif_hi_pri_rd,		0x4),
> +	ALI_DRW_PMU_EVENT_ATTR(perf_dfi_wr_data_cycles,	0x7),
> +	ALI_DRW_PMU_EVENT_ATTR(perf_dfi_rd_data_cycles,	0x8),
> +	ALI_DRW_PMU_EVENT_ATTR(perf_hpr_xact_when_critical,	0x9),
> +	ALI_DRW_PMU_EVENT_ATTR(perf_lpr_xact_when_critical,	0xA),
> +	ALI_DRW_PMU_EVENT_ATTR(perf_wpr_xact_when_critical,	0xB),
> +	ALI_DRW_PMU_EVENT_ATTR(perf_op_is_activate,		0xC),
> +	ALI_DRW_PMU_EVENT_ATTR(perf_op_is_rd_or_wr,		0xD),
> +	ALI_DRW_PMU_EVENT_ATTR(perf_op_is_rd_activate,		0xE),
> +	ALI_DRW_PMU_EVENT_ATTR(perf_op_is_rd,			0xF),
> +	ALI_DRW_PMU_EVENT_ATTR(perf_op_is_wr,			0x10),
> +	ALI_DRW_PMU_EVENT_ATTR(perf_op_is_mwr,			0x11),
> +	ALI_DRW_PMU_EVENT_ATTR(perf_op_is_precharge,		0x12),
> +	ALI_DRW_PMU_EVENT_ATTR(perf_precharge_for_rdwr,	0x13),
> +	ALI_DRW_PMU_EVENT_ATTR(perf_precharge_for_other,	0x14),
> +	ALI_DRW_PMU_EVENT_ATTR(perf_rdwr_transitions,		0x15),
> +	ALI_DRW_PMU_EVENT_ATTR(perf_write_combine,		0x16),
> +	ALI_DRW_PMU_EVENT_ATTR(perf_war_hazard,		0x17),
> +	ALI_DRW_PMU_EVENT_ATTR(perf_raw_hazard,		0x18),
> +	ALI_DRW_PMU_EVENT_ATTR(perf_waw_hazard,		0x19),
> +	ALI_DRW_PMU_EVENT_ATTR(perf_op_is_enter_selfref_rk0,	0x1A),
> +	ALI_DRW_PMU_EVENT_ATTR(perf_op_is_enter_selfref_rk1,	0x1B),
> +	ALI_DRW_PMU_EVENT_ATTR(perf_op_is_enter_selfref_rk2,	0x1C),
> +	ALI_DRW_PMU_EVENT_ATTR(perf_op_is_enter_selfref_rk3,	0x1D),
> +	ALI_DRW_PMU_EVENT_ATTR(perf_op_is_enter_powerdown_rk0,	0x1E),
> +	ALI_DRW_PMU_EVENT_ATTR(perf_op_is_enter_powerdown_rk1,	0x1F),
> +	ALI_DRW_PMU_EVENT_ATTR(perf_op_is_enter_powerdown_rk2,	0x20),
> +	ALI_DRW_PMU_EVENT_ATTR(perf_op_is_enter_powerdown_rk3,	0x21),
> +	ALI_DRW_PMU_EVENT_ATTR(perf_selfref_mode_rk0,		0x26),
> +	ALI_DRW_PMU_EVENT_ATTR(perf_selfref_mode_rk1,		0x27),
> +	ALI_DRW_PMU_EVENT_ATTR(perf_selfref_mode_rk2,		0x28),
> +	ALI_DRW_PMU_EVENT_ATTR(perf_selfref_mode_rk3,		0x29),
> +	ALI_DRW_PMU_EVENT_ATTR(perf_op_is_refresh,		0x2A),
> +	ALI_DRW_PMU_EVENT_ATTR(perf_op_is_crit_ref,		0x2B),
> +	ALI_DRW_PMU_EVENT_ATTR(perf_op_is_load_mode,		0x2D),
> +	ALI_DRW_PMU_EVENT_ATTR(perf_op_is_zqcl,		0x2E),
> +	ALI_DRW_PMU_EVENT_ATTR(perf_visible_window_limit_reached_rd, 0x30),
> +	ALI_DRW_PMU_EVENT_ATTR(perf_visible_window_limit_reached_wr, 0x31),
> +	ALI_DRW_PMU_EVENT_ATTR(perf_op_is_dqsosc_mpc,		0x34),
> +	ALI_DRW_PMU_EVENT_ATTR(perf_op_is_dqsosc_mrr,		0x35),
> +	ALI_DRW_PMU_EVENT_ATTR(perf_op_is_tcr_mrr,		0x36),
> +	ALI_DRW_PMU_EVENT_ATTR(perf_op_is_zqstart,		0x37),
> +	ALI_DRW_PMU_EVENT_ATTR(perf_op_is_zqlatch,		0x38),
> +	ALI_DRW_PMU_EVENT_ATTR(perf_chi_txreq,			0x39),
> +	ALI_DRW_PMU_EVENT_ATTR(perf_chi_txdat,			0x3A),
> +	ALI_DRW_PMU_EVENT_ATTR(perf_chi_rxdat,			0x3B),
> +	ALI_DRW_PMU_EVENT_ATTR(perf_chi_rxrsp,			0x3C),
> +	ALI_DRW_PMU_EVENT_ATTR(perf_tsz_vio,			0x3D),
> +	ALI_DRW_PMU_EVENT_ATTR(perf_cycle,			0x80),
> +	NULL,
> +};



> +static void ali_drw_pmu_enable_counter(struct perf_event *event)
> +{
> +	u32 val, reg;
> +	int counter = event->hw.idx;
> +	struct ali_drw_pmu *drw_pmu = to_ali_drw_pmu(event->pmu);
> +
> +	reg = ALI_DRW_PMU_EVENT_SELn(counter);
> +	val = readl(drw_pmu->cfg_base + reg);
> +	/* enable the common counter n */
> +	val |= (1 << ALI_DRW_PMCOM_CNT_EN_OFFSET(counter));
> +	/* decides the event which will be counted by the common counter n */
> +	val |= ((drw_pmu->evtids[counter] & 0x3F) << ALI_DRW_PMCOM_CNT_EVENT_OFFSET(counter));

You could use FIELD_PREP() to fill the 8 bit sub register then shift it based
on counter.  Would probably be more readable. Something like

	val = readl(drw_pmu->cfg_base + reg);
	subval = FIELD_PREP(ALI_DRAW_PMCOM_CNT_EN_MSK, 1) |
        	 FIELD_PREP(ALI_DRAW_PMCOM_CNT_EVENT_MSK, drw_pmu->evtids);

	shift = 8 * (counter % 4);
	val &= ~(GENMASK(7, 0) << shift);
	val |= subval << shift;


> +	writel(val, drw_pmu->cfg_base + reg);
> +}
> +
> +static void ali_drw_pmu_disable_counter(struct perf_event *event)
> +{
> +	u32 val, reg;
> +	struct ali_drw_pmu *drw_pmu = to_ali_drw_pmu(event->pmu);
> +	int counter = event->hw.idx;
> +
> +	reg = ALI_DRW_PMU_EVENT_SELn(counter);
> +	val = readl(drw_pmu->cfg_base + reg);
> +	val &= ~(1 << ALI_DRW_PMCOM_CNT_EN_OFFSET(counter));
> +	val &= ~(0x3F << ALI_DRW_PMCOM_CNT_EVENT_OFFSET(counter));

Use GENMASK() for that mask and maybe #define it got give it a name.

> +
> +	writel(val, drw_pmu->cfg_base + reg);
> +}
> +
> +static irqreturn_t ali_drw_pmu_isr(int irq_num, void *data)
> +{
> +	struct ali_drw_pmu_irq *irq = data;
> +	struct ali_drw_pmu *drw_pmu;
> +	irqreturn_t ret = IRQ_NONE;
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(drw_pmu, &irq->pmus_node, pmus_node) {

As mentioned below, I'm not clear this is actually worthwhile vs
just relying on IRQF_SHARED and registering each PMU separately.

> +		unsigned long status;
> +		struct perf_event *event;
> +		unsigned int idx;
> +
> +		for (idx = 0; idx < ALI_DRW_PMU_COMMON_MAX_COUNTERS; idx++) {
> +			event = drw_pmu->events[idx];
> +			if (!event)
> +				continue;
> +			ali_drw_pmu_disable_counter(event);
> +		}
> +
> +		/* common counter intr status */
> +		status = readl(drw_pmu->cfg_base + ALI_DRW_PMU_OV_INTR_STATUS);
> +		status = (status >> 8) & 0xFFFF;

Nice to use a MASK define and FIELD_GET()

> +		if (status) {
> +			for_each_set_bit(idx, &status,
> +					 ALI_DRW_PMU_COMMON_MAX_COUNTERS) {
> +				event = drw_pmu->events[idx];
> +				if (WARN_ON_ONCE(!event))
> +					continue;
> +				ali_drw_pmu_event_update(event);
> +				ali_drw_pmu_event_set_period(event);
> +			}
> +
> +			/* clear common counter intr status */
> +			writel((status & 0xFFFF) << 8,
> +				drw_pmu->cfg_base + ALI_DRW_PMU_OV_INTR_CLR);
> +		}
> +
> +		for (idx = 0; idx < ALI_DRW_PMU_COMMON_MAX_COUNTERS; idx++) {
> +			event = drw_pmu->events[idx];
> +			if (!event)
> +				continue;
> +			if (!(event->hw.state & PERF_HES_STOPPED))
> +				ali_drw_pmu_enable_counter(event);
> +		}
> +
> +		ret = IRQ_HANDLED;

If no bits were set in intr status, then should not set this.

> +	}
> +	rcu_read_unlock();
> +	return ret;
> +}
> +

This IRQ handling is nasty.  It would be good for the patch description to
explain what the constraints are.  What hardware shares an IRQ etc.
Seems like the MPAM driver is going to be fighting with this to migrate the
interrupt if needed.

I'm also not clear how bad it would be to just have each PMU register
shared IRQ and HP handler. That would simplify this code a fair bit
and the excess HP handler calls shouldn't matter (cpu_num wouldn't
match once first one has migrated it).

> +static struct ali_drw_pmu_irq *__ali_drw_pmu_init_irq(struct platform_device
> +						      *pdev, int irq_num)
> +{
> +	int ret;
> +	struct ali_drw_pmu_irq *irq;
> +
> +	list_for_each_entry(irq, &ali_drw_pmu_irqs, irqs_node) {
> +		if (irq->irq_num == irq_num
> +		    && refcount_inc_not_zero(&irq->refcount))
> +			return irq;
> +	}
> +
> +	irq = kzalloc(sizeof(*irq), GFP_KERNEL);
> +	if (!irq)
> +		return ERR_PTR(-ENOMEM);
> +
> +	INIT_LIST_HEAD(&irq->pmus_node);
> +
> +	/* Pick one CPU to be the preferred one to use */
> +	irq->cpu = smp_processor_id();
> +	refcount_set(&irq->refcount, 1);
> +
> +	/*
> +	 * FIXME: DDRSS Driveway PMU overflow interrupt shares the same irq
> +	 * number with MPAM ERR_IRQ. To register DDRSS PMU and MPAM drivers
> +	 * successfully, add IRQF_SHARED flag.

You have it already for this driver, so what does this FIXME refer to?

> +	 */
> +	ret = devm_request_irq(&pdev->dev, irq_num, ali_drw_pmu_isr,
> +			       IRQF_SHARED, dev_name(&pdev->dev), irq);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev,
> +			"Fail to request IRQ:%d ret:%d\n", irq_num, ret);
> +		goto out_free;
> +	}
> +
> +	ret = irq_set_affinity_hint(irq_num, cpumask_of(irq->cpu));
> +	if (ret)
> +		goto out_free;
> +
> +	ret = cpuhp_state_add_instance_nocalls(ali_drw_cpuhp_state_num, &irq->node);
> +	if (ret)
> +		goto out_free;
> +
> +	irq->irq_num = irq_num;
> +	list_add(&irq->irqs_node, &ali_drw_pmu_irqs);
> +
> +	return irq;
> +
> +out_free:
> +	kfree(irq);
> +	return ERR_PTR(ret);
> +}
> +
> +static int ali_drw_pmu_init_irq(struct ali_drw_pmu *drw_pmu,
> +				struct platform_device *pdev)
> +{
> +	int irq_num;
> +	struct ali_drw_pmu_irq *irq;
> +
> +	/* Read and init IRQ */
> +	irq_num = platform_get_irq(pdev, 0);
> +	if (irq_num < 0)
> +		return irq_num;
> +
> +	mutex_lock(&ali_drw_pmu_irqs_lock);
> +	irq = __ali_drw_pmu_init_irq(pdev, irq_num);
> +	mutex_unlock(&ali_drw_pmu_irqs_lock);
> +
> +	if (IS_ERR(irq))
> +		return PTR_ERR(irq);
> +
> +	drw_pmu->irq = irq;
> +
> +	mutex_lock(&ali_drw_pmu_irqs_lock);
> +	list_add_rcu(&drw_pmu->pmus_node, &irq->pmus_node);
> +	mutex_unlock(&ali_drw_pmu_irqs_lock);
> +
> +	return 0;
> +}
> +
> +static void ali_drw_pmu_uninit_irq(struct ali_drw_pmu *drw_pmu)
> +{
> +	struct ali_drw_pmu_irq *irq = drw_pmu->irq;
> +
> +	mutex_lock(&ali_drw_pmu_irqs_lock);
> +	list_del_rcu(&drw_pmu->pmus_node);
> +
> +	if (!refcount_dec_and_test(&irq->refcount)) {
> +		mutex_unlock(&ali_drw_pmu_irqs_lock);
> +		return;
> +	}
> +
> +	list_del(&irq->irqs_node);
> +	mutex_unlock(&ali_drw_pmu_irqs_lock);
> +
> +	WARN_ON(irq_set_affinity_hint(irq->irq_num, NULL));
> +	cpuhp_state_remove_instance_nocalls(ali_drw_cpuhp_state_num,
> +					    &irq->node);
> +	kfree(irq);
> +}
> +

> +
> +static int ali_drw_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
> +{
> +	struct ali_drw_pmu_irq *irq;
> +	struct ali_drw_pmu *drw_pmu;
> +	unsigned int target;
> +
> +	irq = hlist_entry_safe(node, struct ali_drw_pmu_irq, node);
> +	if (cpu != irq->cpu)
> +		return 0;
> +
> +	target = cpumask_any_but(cpu_online_mask, cpu);

Preference for something on the same die if available?  I'm guessing that'll
reduce overheads for access.  Obviously you'll then want an online callback
to move back to the die if 1st cpu is onlined on it.

> +	if (target >= nr_cpu_ids)
> +		return 0;
> +
> +	/* We're only reading, but this isn't the place to be involving RCU */
> +	mutex_lock(&ali_drw_pmu_irqs_lock);
> +	list_for_each_entry(drw_pmu, &irq->pmus_node, pmus_node)
> +		perf_pmu_migrate_context(&drw_pmu->pmu, irq->cpu, target);
> +	mutex_unlock(&ali_drw_pmu_irqs_lock);
> +
> +	WARN_ON(irq_set_affinity_hint(irq->irq_num, cpumask_of(target)));
> +	irq->cpu = target;
> +
> +	return 0;
> +}
> +
> +static const struct acpi_device_id ali_drw_acpi_match[] = {
> +	{"ARMHD700", 0},

THEAD IP but with an ARM HID?  That needs at very least to have
a comment.  If this is a generic IP, then it should be documented
as such and the driver written with that in mind.

> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(acpi, ali_drw_acpi_match);
> +
> +static struct platform_driver ali_drw_pmu_driver = {
> +	.driver = {
> +		   .name = "ali_drw_pmu",
> +		   .acpi_match_table = ACPI_PTR(ali_drw_acpi_match),
> +		   },
> +	.probe = ali_drw_pmu_probe,
> +	.remove = ali_drw_pmu_remove,
> +};
> +
> +static int __init ali_drw_pmu_init(void)
> +{
> +	int ret;
> +
> +	ali_drw_cpuhp_state_num = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
> +							  "ali_drw_pmu:online",
> +							  NULL,
> +							  ali_drw_pmu_offline_cpu);
> +
> +	if (ali_drw_cpuhp_state_num < 0) {
> +		pr_err("DRW Driveway PMU: setup hotplug failed, ret = %d\n",
> +		       ali_drw_cpuhp_state_num);
> +		return ali_drw_cpuhp_state_num;
> +	}

Slightly more readable as

	ret = cpuhp_setup_state...
	if (ret < 0) {
		pr_err(..);
		return ret;
	}

	ali_drw_cpuhp_state_num = ret;
...

		
> +
> +	ret = platform_driver_register(&ali_drw_pmu_driver);
> +	if (ret)
> +		cpuhp_remove_multi_state(ali_drw_cpuhp_state_num);
> +
> +	return ret;
> +}
> +
> +static void __exit ali_drw_pmu_exit(void)
> +{
> +	platform_driver_unregister(&ali_drw_pmu_driver);
> +	cpuhp_remove_multi_state(ali_drw_cpuhp_state_num);
> +}
> +
> +module_init(ali_drw_pmu_init);
> +module_exit(ali_drw_pmu_exit);
> +
> +MODULE_AUTHOR("Hongbo Yao <yaohongbo@linux.alibaba.com>");
> +MODULE_AUTHOR("Neng Chen <nengchen@linux.alibaba.com>");
> +MODULE_AUTHOR("Shuai Xue <xueshuai@linux.alibaba.com>");
> +MODULE_DESCRIPTION("DDR Sub-System PMU driver");
> +MODULE_LICENSE("GPL v2");

