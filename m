Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5B9571A25
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 14:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbiGLMgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 08:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiGLMgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 08:36:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0BC6230F68;
        Tue, 12 Jul 2022 05:36:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37BB71516;
        Tue, 12 Jul 2022 05:36:45 -0700 (PDT)
Received: from [10.57.85.194] (unknown [10.57.85.194])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB9793F70D;
        Tue, 12 Jul 2022 05:36:40 -0700 (PDT)
Message-ID: <55be073b-caf1-320b-dd42-165636b45a74@arm.com>
Date:   Tue, 12 Jul 2022 13:36:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/4] perf/amlogic: Add support for Amlogic meson G12 SoC
 DDR PMU driver
Content-Language: en-GB
To:     Jiucheng Xu <jiucheng.xu@amlogic.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chris Healy <cphealy@gmail.com>
References: <20220712063641.2790997-1-jiucheng.xu@amlogic.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220712063641.2790997-1-jiucheng.xu@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-12 07:36, Jiucheng Xu wrote:
> This patch adds support Amlogic meson G12 series SoC
> DDR bandwidth PMU driver framework and interfaces.
> 
> The PMU not only can monitor the total DDR bandwidth,
> but also the bandwidth which is from individual IP module.
> 
> Example usage:
> 
>   $ perf stat -a -e aml_ddr_bw/total_rw_bytes/ -I 1000 sleep 10
> 
> - or -
> 
>   $ perf stat -a -e \
>     aml_ddr_bw/total_rw_bytes/,\
>     aml_ddr_bw/chan_1_rw_bytes,arm=1/ -I 1000 \
>     sleep 10
> 
> g12 SoC support 4 channels to monitor DDR bandwidth
> simultaneously. Each channel can monitor up to 4 IP modules
> simultaneously.
> 
> For Instance, If you want to get the sum of DDR bandwidth
> from CPU, GPU, USB3.0 and VDEC. You can use the following
> command parameters to display.
> 
>   $ perf stat -a -e \
>     aml_ddr_bw/chan_2_rw_bytes,arm=1,gpu=1,usb3_0=1,nna=1/ -I 1000 \
>     sleep 10
> 
> Other events are supported, and advertised via perf list.
> 
> Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
> ---
>   MAINTAINERS                            |   7 +
>   drivers/perf/Kconfig                   |   2 +
>   drivers/perf/Makefile                  |   1 +
>   drivers/perf/amlogic/Kconfig           |  11 +
>   drivers/perf/amlogic/Makefile          |   3 +
>   drivers/perf/amlogic/aml_ddr_pmu.c     | 725 +++++++++++++++++++++++++
>   drivers/perf/amlogic/aml_ddr_pmu_g12.c | 398 ++++++++++++++
>   include/soc/amlogic/aml_ddr_pmu.h      |  63 +++
>   8 files changed, 1210 insertions(+)
>   create mode 100644 drivers/perf/amlogic/Kconfig
>   create mode 100644 drivers/perf/amlogic/Makefile
>   create mode 100644 drivers/perf/amlogic/aml_ddr_pmu.c
>   create mode 100644 drivers/perf/amlogic/aml_ddr_pmu_g12.c
>   create mode 100644 include/soc/amlogic/aml_ddr_pmu.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f679152bdbad..cb6ee59a4f44 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1050,6 +1050,13 @@ S:	Maintained
>   F:	Documentation/hid/amd-sfh*
>   F:	drivers/hid/amd-sfh-hid/
>   
> +AMLOGIC DDR PMU DRIVER
> +M:	Jiucheng Xu <jiucheng.xu@amlogic.com>
> +S:	Supported
> +W:	http://www.amlogic.com
> +F:	drivers/perf/amlogic/
> +F:	include/soc/amlogic/
> +
>   AMPHION VPU CODEC V4L2 DRIVER
>   M:	Ming Qian <ming.qian@nxp.com>
>   M:	Shijie Qin <shijie.qin@nxp.com>
> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index 1e2d69453771..68200c798128 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -192,4 +192,6 @@ config MARVELL_CN10K_DDR_PMU
>   	  Enable perf support for Marvell DDR Performance monitoring
>   	  event on CN10K platform.
>   
> +source "drivers/perf/amlogic/Kconfig"
> +
>   endmenu
> diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
> index 57a279c61df5..ef82b27e36d0 100644
> --- a/drivers/perf/Makefile
> +++ b/drivers/perf/Makefile
> @@ -1,4 +1,5 @@
>   # SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_AML_DDR_PMU) += amlogic/
>   obj-$(CONFIG_ARM_CCI_PMU) += arm-cci.o
>   obj-$(CONFIG_ARM_CCN) += arm-ccn.o
>   obj-$(CONFIG_ARM_CMN) += arm-cmn.o
> diff --git a/drivers/perf/amlogic/Kconfig b/drivers/perf/amlogic/Kconfig
> new file mode 100644
> index 000000000000..d88bd8371aba
> --- /dev/null
> +++ b/drivers/perf/amlogic/Kconfig
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config AML_DDR_PMU
> +	tristate "Amlogic DDR Bandwidth Performance Monitor"
> +	depends on ARCH_MESON || COMPILE_TEST
> +	default n

"n" is the automatic default anyway, so you don't need to specify this.

> +	help
> +          Provides support for the DDR performance monitor
> +          in Amlogic SoCs, which can give information about
> +          memory throughput and other related events. It
> +          supports multiple channels to monitor the memory
> +          bandwidth simultaneously.
> diff --git a/drivers/perf/amlogic/Makefile b/drivers/perf/amlogic/Makefile
> new file mode 100644
> index 000000000000..4dc11620292b
> --- /dev/null
> +++ b/drivers/perf/amlogic/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_AML_DDR_PMU) += aml_ddr_pmu.o \
> +			     aml_ddr_pmu_g12.o
> diff --git a/drivers/perf/amlogic/aml_ddr_pmu.c b/drivers/perf/amlogic/aml_ddr_pmu.c
> new file mode 100644
> index 000000000000..67956d2a4cfc
> --- /dev/null
> +++ b/drivers/perf/amlogic/aml_ddr_pmu.c
> @@ -0,0 +1,725 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2022 Amlogic, Inc. All rights reserved.
> + */
> +#include <linux/bitfield.h>
> +#include <linux/init.h>
> +#include <linux/irqreturn.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_irq.h>
> +#include <linux/perf_event.h>
> +#include <linux/platform_device.h>
> +#include <linux/printk.h>
> +#include <linux/sysfs.h>
> +#include <linux/types.h>
> +#include <linux/version.h>
> +
> +#include <soc/amlogic/aml_ddr_pmu.h>
> +
> +#define DDR_PERF_DEV_NAME "aml_ddr_bw"
> +#define MAX_AXI_PORTS_OF_CHANNEL	4	/* A DMC channel can monitor max 4 axi ports */
> +#define MAX_BITMAP			64	/* u64 event.attr.config1, 64 bits */
> +
> +#define to_ddr_pmu(p)		container_of(p, struct ddr_pmu, pmu)
> +
> +#define hw_info_to_pmu(p)	container_of(p, struct ddr_pmu, info)
> +
> +struct ddr_pmu {
> +	struct pmu pmu;
> +	struct dmc_hw_info info;
> +	struct dmc_counter counters;	/* save counters from hw */
> +	bool pmu_enabled;
> +	spinlock_t lock;		/* protect hw counter */
> +	struct device *dev;
> +	char *name;
> +	struct	hlist_node node;
> +	enum cpuhp_state cpuhp_state;
> +	int cpu;			/* for cpu hotplug */
> +};
> +
> +static inline void dmc_pmu_enable(struct ddr_pmu *pmu)

Don't bother with "inline" in .c files - it's effectively just noise, 
since the compiler will make its own decisions anyway.

> +{
> +	spin_lock(&pmu->lock);

You shouldn't need locking - perf core takes care to run all the 
callbacks on event->cpu, and expects the IRQ to be affine to that CPU as 
well (which is why we need to do the whole hotplug thing), so mutual 
exclusion should be inherent. Furthermore, as-is this locking all looks 
rather broken - at a glance I can see it can deadlock the IRQ handler, 
which is also racily accessing PMU state outside the lock anyway, so I'm 
just going to ignore it for the rest of this review.

> +	if (!pmu->pmu_enabled && pmu->info.ops->enable)
> +		pmu->info.ops->enable(&pmu->info);
> +
> +	pmu->pmu_enabled = true;
> +	spin_unlock(&pmu->lock);
> +}
> +
> +static inline void dmc_pmu_disable(struct ddr_pmu *pmu)
> +{
> +	spin_lock(&pmu->lock);
> +	if (pmu->pmu_enabled && pmu->info.ops->disable)
> +		pmu->info.ops->disable(&pmu->info);
> +
> +	pmu->pmu_enabled = false;
> +	spin_unlock(&pmu->lock);
> +}
> +
> +static inline void ddr_cnt_accumulate(struct ddr_pmu *pmu,
> +				      struct dmc_counter *c)
> +{
> +	struct dmc_counter *cnter = &pmu->counters;
> +	int chann_nr = pmu->info.chann_nr;
> +	int i;
> +
> +	cnter->all_cnt += c->all_cnt;
> +	cnter->all_req += c->all_req;
> +
> +	for (i = 0; i < chann_nr; i++)
> +		cnter->channel_cnt[i] += c->channel_cnt[i];
> +}
> +
> +static void aml_ddr_config_axi_id(struct ddr_pmu *pmu, int axi_id, int chann)
> +{
> +	if (pmu->info.ops->config_axi_id) {
> +		spin_lock(&pmu->lock);
> +		pmu->info.ops->config_axi_id(&pmu->info, axi_id, chann);
> +		spin_unlock(&pmu->lock);
> +	}
> +}
> +
> +static void aml_ddr_set_filter(struct perf_event *event, u8 axi_id)
> +{
> +	struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
> +	int chann;
> +
> +	if (event->attr.config > ALL_CHAN_COUNTER_ID &&
> +	    event->attr.config < COUNTER_MAX_ID) {
> +		chann = event->attr.config - CHAN1_COUNTER_ID;
> +
> +		aml_ddr_config_axi_id(pmu, axi_id, chann);
> +	}
> +}
> +
> +static inline void ddr_cnt_addition(struct dmc_counter *sum,
> +				    struct dmc_counter *add1,
> +				    struct dmc_counter *add2)
> +{
> +	int i;
> +	u64 cnt1, cnt2;
> +
> +	sum->all_cnt = add1->all_cnt + add2->all_cnt;
> +	sum->all_req = add1->all_req + add2->all_req;
> +	for (i = 0; i < MAX_CHANNEL_NUM; i++) {

AFAICS the caller knows the actual number of channels, so why not pass 
that as an argument to save unnecessary operations? Plus then there's 
really no reason at all to keep the redundant ddr_cnt_accumulate() 
implementation.

> +		cnt1 = add1->channel_cnt[i];
> +		cnt2 = add2->channel_cnt[i];
> +
> +		sum->channel_cnt[i] = cnt1 + cnt2;
> +	}
> +}
> +
> +static void aml_ddr_perf_event_update(struct perf_event *event)
> +{
> +	struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
> +	u64 new_raw_count = 0;
> +	struct dmc_counter dc = {0}, sum_dc = {0};
> +	int idx;
> +
> +	spin_lock(&pmu->lock);
> +	/* get the remain counters in register. */
> +	pmu->info.ops->get_counters(&pmu->info, &dc);
> +
> +	ddr_cnt_addition(&sum_dc, &pmu->counters, &dc);
> +	spin_unlock(&pmu->lock);
> +
> +	switch (event->attr.config) {
> +	case ALL_CHAN_COUNTER_ID:
> +		new_raw_count = sum_dc.all_cnt;
> +		break;
> +	case CHAN1_COUNTER_ID:
> +	case CHAN2_COUNTER_ID:
> +	case CHAN3_COUNTER_ID:
> +	case CHAN4_COUNTER_ID:
> +	case CHAN5_COUNTER_ID:
> +	case CHAN6_COUNTER_ID:
> +	case CHAN7_COUNTER_ID:
> +	case CHAN8_COUNTER_ID:
> +		idx = event->attr.config - CHAN1_COUNTER_ID;
> +		new_raw_count = sum_dc.channel_cnt[idx];
> +		break;
> +	default:
> +		dev_err(pmu->dev, "unsupported counter id\n ");

Don't print messages that only indicate a bug in the driver - an invalid 
config should never get past event_init.

> +	}
> +
> +	local64_set(&event->count, new_raw_count);
> +}
> +
> +static int aml_ddr_perf_event_init(struct perf_event *event)
> +{
> +	struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct perf_event *sibling;
> +	u64 config1 = event->attr.config1;
> +	int i, count = 0;
> +
> +	if (event->attr.type != event->pmu->type)
> +		return -ENOENT;
> +
> +	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
> +		return -EOPNOTSUPP;
> +
> +	if (event->cpu < 0) {
> +		dev_warn(pmu->dev, "Can't provide per-task data!\n");

Don't log a warning (or indeed anything, usually) for something which is 
perfectly valid for a user to try.

> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (event->group_leader->pmu != event->pmu &&
> +	    !is_software_event(event->group_leader))
> +		return -EINVAL;
> +
> +	if ((event)->group_leader == (event))

Random parentheses?

> +		list_for_each_entry((sibling), &(event)->sibling_list,
> +				    sibling_list) {
> +			if (sibling->pmu != event->pmu &&
> +			    !is_software_event(sibling))
> +				return -EINVAL;

It looks like you don't have multiple sets of hardware counters; if so 
you'd also need to reject the group if it contains more than one event 
for this PMU.

> +		}
> +
> +	/* check if the number of parameters is too much */
> +	if (event->attr.config != ALL_CHAN_COUNTER_ID) {
> +		for (i = 0; i < MAX_BITMAP; i++) {
> +			if (config1 & 0x1 && ++count > MAX_AXI_PORTS_OF_CHANNEL) {
> +				dev_warn(pmu->dev, "Too many parameters append the event\n");

Again, it's questionable whether this is a warning condition.

> +				return -EOPNOTSUPP;
> +			}
> +
> +			config1 >>= 1;
> +		}

Also consider the hweight64() helper rather than this whole loop.

> +	}
> +
> +	event->cpu = pmu->cpu;
> +	hwc->idx = -1;

You never read hwc->idx anywhere, so it's a bit pointless to set it.

> +
> +	return 0;
> +}
> +
> +static void aml_ddr_perf_event_start(struct perf_event *event, int flags)
> +{
> +	struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	local64_set(&hwc->prev_count, 0);
> +	local64_set(&event->count, 0);
> +	hwc->state = 0;

Ditto for hwc->prev_count and hwc->state. The point of event->hw is to 
hold driver-internal data, so if you don't need to keep track of any 
per-event data beyond the config you can ignore it entirely.

> +
> +	memset(&pmu->counters, 0, sizeof(pmu->counters));
> +	dmc_pmu_enable(pmu);
> +}
> +
> +static int aml_ddr_perf_event_add(struct perf_event *event, int flags)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	u64 config1 = event->attr.config1;
> +	int i, count = 0;
> +
> +	hwc->idx = event->attr.config;
> +	hwc->state |= PERF_HES_STOPPED;
> +
> +	/*
> +	 * for individual channel event , check if the number of axi_id
> +	 * supported is beyond the max
> +	 */

Again, you don't need to check things that have already been validated 
by event_init.

However it looks like you probably *should* be checking whether there's 
an event counting on the relevant PMU already - AFAICS this is just 
going to blindly reprogram the hardware and corrupt the other event's count.

> +	if (event->attr.config != ALL_CHAN_COUNTER_ID) {
> +		for (i = 0; i < MAX_BITMAP; i++) {
> +			if (config1 & 0x1) {
> +				aml_ddr_set_filter(event, i);
> +				if (++count > MAX_AXI_PORTS_OF_CHANNEL)
> +					break;
> +			}
> +
> +			config1 >>= 1;
> +		}

Consider the for_each_set_bit() helper.

> +	}
> +
> +	if (flags & PERF_EF_START)
> +		aml_ddr_perf_event_start(event, flags);
> +
> +	return 0;
> +}
> +
> +static void aml_ddr_perf_event_stop(struct perf_event *event, int flags)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
> +
> +	if (flags & PERF_EF_UPDATE)
> +		aml_ddr_perf_event_update(event);
> +
> +	dmc_pmu_disable(pmu);
> +	hwc->state |= PERF_HES_STOPPED;
> +}
> +
> +static void aml_ddr_perf_event_del(struct perf_event *event, int flags)
> +{
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	aml_ddr_perf_event_stop(event, PERF_EF_UPDATE);
> +	hwc->idx = -1;
> +}
> +
> +static ssize_t aml_ddr_perf_cpumask_show(struct device *dev,
> +					 struct device_attribute *attr,
> +					 char *buf)
> +{
> +	struct ddr_pmu *pmu = dev_get_drvdata(dev);
> +
> +	return cpumap_print_to_pagebuf(true, buf, cpumask_of(pmu->cpu));
> +}
> +
> +static struct device_attribute aml_ddr_perf_cpumask_attr =
> +__ATTR(cpumask, 0444, aml_ddr_perf_cpumask_show, NULL);
> +
> +static struct attribute *aml_ddr_perf_cpumask_attrs[] = {
> +	&aml_ddr_perf_cpumask_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group ddr_perf_cpumask_attr_group = {
> +	.attrs = aml_ddr_perf_cpumask_attrs,
> +};
> +
> +static ssize_t
> +pmu_event_show(struct device *dev, struct device_attribute *attr,
> +	       char *page)
> +{
> +	struct perf_pmu_events_attr *pmu_attr;
> +
> +	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
> +	return sprintf(page, "event=0x%02llx\n", pmu_attr->id);

Use sysfs_emit() for all of these.

> +}
> +
> +static ssize_t
> +event_show_unit(struct device *dev, struct device_attribute *attr,
> +		char *page)
> +{
> +	struct perf_pmu_events_attr *pmu_attr;
> +
> +	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
> +	return sprintf(page, "MB\n");
> +}
> +
> +static ssize_t
> +event_show_scale(struct device *dev, struct device_attribute *attr,
> +		 char *page)
> +{
> +	struct perf_pmu_events_attr *pmu_attr;
> +
> +	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
> +
> +	/* one count = 16byte = 1.52587890625e-05 MB */
> +	return sprintf(page, "1.52587890625e-05\n");
> +}
> +
> +#define AML_DDR_PMU_EVENT_ATTR(_name, _id)				\
> +{									\
> +	.attr = __ATTR(_name, 0444, pmu_event_show, NULL),		\
> +	.id = _id,							\
> +}
> +
> +#define AML_DDR_PMU_EVENT_UNIT_ATTR(_name)				\
> +	__ATTR(_name.unit, 0444, event_show_unit, NULL)
> +
> +#define AML_DDR_PMU_EVENT_SCALE_ATTR(_name)				\
> +	__ATTR(_name.scale, 0444, event_show_scale, NULL)
> +
> +static struct device_attribute event_unit_attrs[] = {
> +	AML_DDR_PMU_EVENT_UNIT_ATTR(total_rw_bytes),
> +	AML_DDR_PMU_EVENT_UNIT_ATTR(chan_1_rw_bytes),
> +	AML_DDR_PMU_EVENT_UNIT_ATTR(chan_2_rw_bytes),
> +	AML_DDR_PMU_EVENT_UNIT_ATTR(chan_3_rw_bytes),
> +	AML_DDR_PMU_EVENT_UNIT_ATTR(chan_4_rw_bytes),
> +	AML_DDR_PMU_EVENT_UNIT_ATTR(chan_5_rw_bytes),
> +	AML_DDR_PMU_EVENT_UNIT_ATTR(chan_6_rw_bytes),
> +	AML_DDR_PMU_EVENT_UNIT_ATTR(chan_7_rw_bytes),
> +	AML_DDR_PMU_EVENT_UNIT_ATTR(chan_8_rw_bytes),
> +};
> +
> +static struct device_attribute event_scale_attrs[] = {
> +	AML_DDR_PMU_EVENT_SCALE_ATTR(total_rw_bytes),
> +	AML_DDR_PMU_EVENT_SCALE_ATTR(chan_1_rw_bytes),
> +	AML_DDR_PMU_EVENT_SCALE_ATTR(chan_2_rw_bytes),
> +	AML_DDR_PMU_EVENT_SCALE_ATTR(chan_3_rw_bytes),
> +	AML_DDR_PMU_EVENT_SCALE_ATTR(chan_4_rw_bytes),
> +	AML_DDR_PMU_EVENT_SCALE_ATTR(chan_5_rw_bytes),
> +	AML_DDR_PMU_EVENT_SCALE_ATTR(chan_6_rw_bytes),
> +	AML_DDR_PMU_EVENT_SCALE_ATTR(chan_7_rw_bytes),
> +	AML_DDR_PMU_EVENT_SCALE_ATTR(chan_8_rw_bytes),
> +};
> +
> +static struct perf_pmu_events_attr event_attrs[] = {
> +	AML_DDR_PMU_EVENT_ATTR(total_rw_bytes, ALL_CHAN_COUNTER_ID),
> +	AML_DDR_PMU_EVENT_ATTR(chan_1_rw_bytes, CHAN1_COUNTER_ID),
> +	AML_DDR_PMU_EVENT_ATTR(chan_2_rw_bytes, CHAN2_COUNTER_ID),
> +	AML_DDR_PMU_EVENT_ATTR(chan_3_rw_bytes, CHAN3_COUNTER_ID),
> +	AML_DDR_PMU_EVENT_ATTR(chan_4_rw_bytes, CHAN4_COUNTER_ID),
> +	AML_DDR_PMU_EVENT_ATTR(chan_5_rw_bytes, CHAN5_COUNTER_ID),
> +	AML_DDR_PMU_EVENT_ATTR(chan_6_rw_bytes, CHAN6_COUNTER_ID),
> +	AML_DDR_PMU_EVENT_ATTR(chan_7_rw_bytes, CHAN7_COUNTER_ID),
> +	AML_DDR_PMU_EVENT_ATTR(chan_8_rw_bytes, CHAN8_COUNTER_ID),
> +};
> +
> +/* three attrs are combined an event */
> +static struct attribute *ddr_perf_events_attrs[COUNTER_MAX_ID * 3];
> +
> +static struct attribute_group ddr_perf_events_attr_group = {
> +	.name = "events",
> +	.attrs = ddr_perf_events_attrs,
> +};
> +
> +/* an attr represents axi id, the max id is less than 256 */
> +static struct attribute *ddr_perf_format_attrs[256];
> +
> +static struct attribute_group ddr_perf_format_attr_group = {
> +	.name = "format",
> +	.attrs = ddr_perf_format_attrs,
> +};
> +
> +static ssize_t aml_ddr_perf_identifier_show(struct device *dev,
> +					    struct device_attribute *attr,
> +					    char *page)
> +{
> +	struct ddr_pmu *pmu = dev_get_drvdata(dev);
> +
> +	return sprintf(page, "%s\n", pmu->name);
> +}
> +
> +static umode_t aml_ddr_perf_identifier_attr_visible(struct kobject *kobj,
> +						    struct attribute *attr,
> +						    int n)
> +{
> +	return attr->mode;
> +}

If you're not going to override the static mode then you don't need to 
implement .is_visible at all.

> +
> +static struct device_attribute aml_ddr_perf_identifier_attr =
> +__ATTR(identifier, 0444, aml_ddr_perf_identifier_show, NULL);
> +
> +static struct attribute *aml_ddr_perf_identifier_attrs[] = {
> +	&aml_ddr_perf_identifier_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group ddr_perf_identifier_attr_group = {
> +	.attrs = aml_ddr_perf_identifier_attrs,
> +	.is_visible = aml_ddr_perf_identifier_attr_visible,
> +};
> +
> +static const struct attribute_group *attr_groups[] = {
> +	&ddr_perf_events_attr_group,
> +	&ddr_perf_format_attr_group,
> +	&ddr_perf_cpumask_attr_group,
> +	&ddr_perf_identifier_attr_group,
> +	NULL,
> +};
> +
> +static irqreturn_t dmc_irq_handler(int irq, void *dev_id)
> +{
> +	struct dmc_hw_info *info = dev_id;
> +	struct ddr_pmu *pmu;
> +	struct dmc_counter counters;
> +
> +	if (irq != info->irq_num)
> +		return IRQ_HANDLED;

How could that even happen? And either way, claiming to have handled it 
is clearly untrue.

> +
> +	pmu = hw_info_to_pmu(info);
> +	WARN_ON(!info->ops->irq_handler);

Why? It's an obvious driver bug, and even if it was the case then you'd 
get just as good a backtrace from the crash when you subsequently call it.

> +
> +	if (pmu->pmu_enabled) {
> +		spin_lock(&pmu->lock);
> +		if (info->ops->irq_handler(info, &counters) != 0) {
> +			spin_unlock(&pmu->lock);
> +			goto out;
> +		}
> +		ddr_cnt_accumulate(pmu, &counters);
> +
> +		/*
> +		 * the timer interrupt only supprt
> +		 * one shot mode, we have to re-enable
> +		 * it in ISR to support continue mode.
> +		 */
> +		info->ops->enable(info);

Couldn't the .irq_handler routine do that for itself if it needs to? TBH 
this whole extra layer of abstraction is hard to reason about when it 
only has one user. How soon are you going to be adding more different 
DDR PMU backends which might make it make a bit more sense?

> +		spin_unlock(&pmu->lock);
> +	}
> +
> +	dev_dbg(pmu->dev, "counts: %llu %llu %llu, %llu, %llu, %llu\t\t"
> +			"sum: %llu %llu %llu, %llu, %llu, %llu\n",
> +			counters.all_req,
> +			counters.all_cnt,
> +			counters.channel_cnt[0],
> +			counters.channel_cnt[1],
> +			counters.channel_cnt[2],
> +			counters.channel_cnt[3],
> +
> +			pmu->counters.all_req,
> +			pmu->counters.all_cnt,
> +			pmu->counters.channel_cnt[0],
> +			pmu->counters.channel_cnt[1],
> +			pmu->counters.channel_cnt[2],
> +			pmu->counters.channel_cnt[3]);
> +out:
> +	return IRQ_HANDLED;
> +}
> +
> +static int ddr_perf_offline_cpu(unsigned int cpu, struct hlist_node *node)
> +{
> +	struct ddr_pmu *pmu = hlist_entry_safe(node, struct ddr_pmu, node);
> +	int target;
> +
> +	if (cpu != pmu->cpu)
> +		return 0;
> +
> +	target = cpumask_any_but(cpu_online_mask, cpu);
> +	if (target >= nr_cpu_ids)
> +		return 0;
> +
> +	perf_pmu_migrate_context(&pmu->pmu, cpu, target);
> +	pmu->cpu = target;
> +
> +	WARN_ON(irq_set_affinity_hint(pmu->info.irq_num, cpumask_of(pmu->cpu)));

This is wrong, it needs to be irq_set_affinity().

> +
> +	return 0;
> +}
> +
> +static int ddr_pmu_get_hw_info(struct platform_device *pdev,
> +			       struct dmc_hw_info *info)
> +{
> +	int ret = -EINVAL;
> +#ifdef CONFIG_OF

This shouldn't ne needed.

> +	struct device_node *node = pdev->dev.of_node;
> +	/*struct pinctrl *p;*/
> +	struct resource *res;
> +	resource_size_t *base;
> +	const char *irq_name;
> +	u32 dmc_nr, chann_nr;
> +	int i;
> +
> +	/* for multiple ddr controller */
> +	if (of_property_read_u32(node, "dmc_nr", &dmc_nr))
> +		info->dmc_nr = 1;
> +
> +	else
> +		info->dmc_nr = dmc_nr;
> +
> +	for (i = 0; i < dmc_nr; i++) {
> +		/* resource 0 for ddr register base */
> +		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
> +		if (!res) {
> +			dev_err(&pdev->dev, "can't get ddr reg base\n");
> +			return -EINVAL;
> +		}
> +		base = ioremap(res->start, res->end - res->start);
> +		if (!base) {
> +			dev_err(&pdev->dev, "couldn't ioremap ddr reg\n");
> +			return -EINVAL;
> +		}

Consider helpers like devm_platform_ioremap_resource().

> +		info->ddr_reg[i] = (void *)base;
> +	}
> +
> +	/* get DMC monitor channel number */
> +	if (of_property_read_u32(node, "chann_nr", &chann_nr))
> +		info->chann_nr = 4;	/* g12 serials support 4 channels */
> +	else
> +		info->chann_nr = chann_nr;
> +
> +	/* resource i for pll register base */
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, i);
> +	if (!res) {
> +		dev_err(&pdev->dev, "can't get ddr reg base\n");
> +		goto err1;
> +	}
> +	base = ioremap(res->start, res->end - res->start);
> +	if (!base) {
> +		dev_err(&pdev->dev, "couldn't ioremap for pll reg\n");
> +		goto err1;
> +	}
> +	info->pll_reg = (void *)base;
> +
> +	info->irq_num = of_irq_get(node, 0);

Use platform_get_irq().

> +	if (info->irq_num < 0) {
> +		dev_err(&pdev->dev, "couldn't get irq\n");

(...which also prints its own error message as well)

> +		goto err2;
> +	}
> +
> +	irq_name = of_get_property(node, "interrupt-names", NULL);
> +	if (!irq_name)
> +		irq_name = "ddr_pmu";

That's not how the "interrupt-names" property works. If you only have a 
single interrupt then there's not much need for it to be named in the DT 
at all. If you do want to use named interrupts then use 
platform_get_irq_byname(), and the name should probably have a bnit more 
functional meaning. Either way, please don't abuse the DT like this.

> +
> +	ret = request_irq(info->irq_num, dmc_irq_handler,
> +			  IRQF_SHARED, irq_name, (void *)info);

Who else is sharing the IRQ? If it's other instances of this PMU then 
that's still manageable under the normal paradigm, the driver just needs 
to coordinate affinity chanmges between all instances. If it's random 
other devices, then maybe it's time to reason about how system PMUs 
could use proper IRQ-safe locking and abandon the affinity stuff, since 
this seems to be coming up more and more.

> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "ddr request irq failed\n");
> +		goto err2;
> +	}
> +
> +	return 0;
> +
> +err2:
> +	iounmap(info->pll_reg);
> +err1:
> +	for (i = 0; i < info->dmc_nr; i++)
> +		iounmap(info->ddr_reg[i]);

Note also that using devm_* helpers saves you all the manual cleanup.

> +#endif
> +	return ret;
> +}
> +
> +static void ddr_pmu_free_hw_info(struct dmc_hw_info *info)
> +{
> +	int i;
> +
> +	iounmap(info->pll_reg);
> +
> +	for (i = 0; i < info->dmc_nr; i++)
> +		iounmap(info->ddr_reg[i]);
> +}
> +
> +static void fill_event_attr(struct ddr_pmu *pmu)
> +{
> +	int i, j, k;
> +	struct attribute **dst = ddr_perf_events_attrs;
> +
> +	j = 0;
> +	k = 0;
> +
> +	/* fill ALL_CHAN_COUNTER_ID event */
> +	dst[j++] = &event_attrs[k].attr.attr;
> +	dst[j++] = &event_unit_attrs[k].attr;
> +	dst[j++] = &event_scale_attrs[k].attr;
> +
> +	k++;
> +
> +	pr_info("pmu->info.chann_nr %d\n", pmu->info.chann_nr);

That's a dev_dbg() at best, but TBH I'm not sure it's useful at all.

> +
> +	/* fill each channel event */
> +	for (i = 0; i < pmu->info.chann_nr; i++, k++) {
> +		dst[j++] = &event_attrs[k].attr.attr;
> +		dst[j++] = &event_unit_attrs[k].attr;
> +		dst[j++] = &event_scale_attrs[k].attr;
> +	}
> +
> +	dst[j] = NULL; /* mark end */
> +}
> +
> +static void fmt_attr_fill(struct attribute **fmt_attr)
> +{
> +	int i;
> +
> +	for (i = 0; fmt_attr[i]; i++)
> +		ddr_perf_format_attrs[i] = fmt_attr[i];
> +
> +	ddr_perf_format_attrs[i] = NULL;
> +}
> +
> +int aml_ddr_pmu_create(struct platform_device *pdev,
> +		       struct dmc_pmu_hw_ops *ops,
> +		       struct attribute **fmt_attr)
> +{
> +	int ret;
> +	char *name;
> +	struct ddr_pmu *pmu;
> +
> +	pmu = devm_kzalloc(&pdev->dev, sizeof(struct ddr_pmu), GFP_KERNEL);
> +	if (!pmu)
> +		return -ENOMEM;
> +
> +	*pmu = (struct ddr_pmu) {
> +		.pmu = (struct pmu) {
> +			.module		= THIS_MODULE,
> +			.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
> +			.task_ctx_nr	= perf_invalid_context,
> +			.attr_groups	= attr_groups,
> +			.event_init	= aml_ddr_perf_event_init,
> +			.add		= aml_ddr_perf_event_add,
> +			.del		= aml_ddr_perf_event_del,
> +			.start		= aml_ddr_perf_event_start,
> +			.stop		= aml_ddr_perf_event_stop,
> +			.read		= aml_ddr_perf_event_update,
> +		}
> +	};
> +
> +	ret = ddr_pmu_get_hw_info(pdev, &pmu->info);
> +	if (ret < 0)
> +		goto pmu_alloc_err;
> +
> +	fmt_attr_fill(fmt_attr);
> +
> +	pmu->info.ops = ops;
> +
> +	spin_lock_init(&pmu->lock);
> +
> +	pmu->cpu = raw_smp_processor_id();
> +
> +	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, DDR_PERF_DEV_NAME);
> +	if (!name) {
> +		dev_err(&pdev->dev, "couldn't alloc memory for name\n");

Don't print "out of memory" messages. If kmalloc() ever does actually 
fail, it's not quiet.

> +		ret = -ENOMEM;
> +		goto get_dev_name_err;
> +	}
> +
> +	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN, name, NULL,
> +				      ddr_perf_offline_cpu);

Why set up a multiple-instance state that's private to a single instance?

> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "cpuhp_setup_state_multi failed\n");
> +		goto cpuhp_state_err;
> +	}
> +	pmu->cpuhp_state = ret;
> +
> +	/* Register the pmu instance for cpu hotplug */
> +	ret = cpuhp_state_add_instance_nocalls(pmu->cpuhp_state, &pmu->node);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Error %d registering hotplug\n", ret);
> +		goto cpuhp_instance_err;
> +	}
> +
> +	fill_event_attr(pmu);
> +
> +	ret = perf_pmu_register(&pmu->pmu, name, -1);
> +	if (ret) {
> +		dev_err(&pdev->dev, "perf pmu register failed\n");
> +		goto pmu_register_err;
> +	}
> +
> +	pmu->name = name;
> +	pmu->dev = &pdev->dev;
> +	pmu->pmu_enabled = false;
> +
> +	platform_set_drvdata(pdev, pmu);
> +
> +	dev_info(&pdev->dev, "ddr perf init ok\n");

Don't print meaningless log spam. The driver core already has plenty of 
debug messages you can enable to monitor driver binding.

> +
> +	return 0;
> +
> +pmu_register_err:
> +	cpuhp_state_remove_instance_nocalls(pmu->cpuhp_state, &pmu->node);
> +cpuhp_instance_err:
> +	cpuhp_remove_multi_state(pmu->cpuhp_state);
> +cpuhp_state_err:
> +	devm_kfree(&pdev->dev, name);

The point of devres is that you don't need to do that.

> +get_dev_name_err:
> +	ddr_pmu_free_hw_info(&pmu->info);
> +pmu_alloc_err:
> +	devm_kfree(&pdev->dev, pmu);

Ditto.

> +
> +	return ret;
> +}
> +
> +int aml_ddr_pmu_remove(struct platform_device *pdev)
> +{
> +	struct ddr_pmu *pmu = platform_get_drvdata(pdev);
> +
> +	perf_pmu_unregister(&pmu->pmu);
> +	cpuhp_state_remove_instance_nocalls(pmu->cpuhp_state, &pmu->node);
> +	cpuhp_remove_multi_state(pmu->cpuhp_state);
> +	devm_kfree(pmu->dev, pmu->name);
> +	free_irq(pmu->info.irq_num, &pmu->info);
> +	ddr_pmu_free_hw_info(&pmu->info);
> +	devm_kfree(&pdev->dev, pmu);
> +
> +	dev_info(&pdev->dev, "ddr perf finit ok\n");

Again, no.

> +
> +	return 0;
> +}
> +
> diff --git a/drivers/perf/amlogic/aml_ddr_pmu_g12.c b/drivers/perf/amlogic/aml_ddr_pmu_g12.c
> new file mode 100644
> index 000000000000..29e351157f49
> --- /dev/null
> +++ b/drivers/perf/amlogic/aml_ddr_pmu_g12.c
> @@ -0,0 +1,398 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2022 Amlogic, Inc. All rights reserved.
> + */
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/perf_event.h>
> +#include <linux/platform_device.h>
> +#include <linux/printk.h>
> +#include <linux/types.h>
> +#include <linux/version.h>
> +
> +#include <soc/amlogic/aml_ddr_pmu.h>
> +
> +#define PORT_MAJOR		32
> +#define DEFAULT_XTAL_FREQ	24000000UL
> +
> +#define DMC_QOS_IRQ		BIT(30)
> +
> +/* DMC bandwidth monitor register address offset */
> +#define DMC_MON_G12_CTRL0		(0x20  << 2)
> +#define DMC_MON_G12_CTRL1		(0x21  << 2)
> +#define DMC_MON_G12_CTRL2		(0x22  << 2)
> +#define DMC_MON_G12_CTRL3		(0x23  << 2)
> +#define DMC_MON_G12_CTRL4		(0x24  << 2)
> +#define DMC_MON_G12_CTRL5		(0x25  << 2)
> +#define DMC_MON_G12_CTRL6		(0x26  << 2)
> +#define DMC_MON_G12_CTRL7		(0x27  << 2)
> +#define DMC_MON_G12_CTRL8		(0x28  << 2)
> +
> +#define DMC_MON_G12_ALL_REQ_CNT		(0x29  << 2)
> +#define DMC_MON_G12_ALL_GRANT_CNT	(0x2a  << 2)
> +#define DMC_MON_G12_ONE_GRANT_CNT	(0x2b  << 2)
> +#define DMC_MON_G12_SEC_GRANT_CNT	(0x2c  << 2)
> +#define DMC_MON_G12_THD_GRANT_CNT	(0x2d  << 2)
> +#define DMC_MON_G12_FOR_GRANT_CNT	(0x2e  << 2)
> +#define DMC_MON_G12_TIMER		(0x2f  << 2)
> +
> +/* Each bit represent a axi line */
> +PMU_FORMAT_ATTR(event, "config:0-7");
> +PMU_FORMAT_ATTR(arm, "config1:0");
> +PMU_FORMAT_ATTR(gpu, "config1:1");
> +PMU_FORMAT_ATTR(pcie, "config1:2");
> +PMU_FORMAT_ATTR(hdcp, "config1:3");
> +PMU_FORMAT_ATTR(hevc_front, "config1:4");
> +PMU_FORMAT_ATTR(usb3_0, "config1:6");
> +PMU_FORMAT_ATTR(device, "config1:7");
> +PMU_FORMAT_ATTR(hevc_back, "config1:8");
> +PMU_FORMAT_ATTR(h265enc, "config1:9");
> +PMU_FORMAT_ATTR(vpu_read1, "config1:16");
> +PMU_FORMAT_ATTR(vpu_read2, "config1:17");
> +PMU_FORMAT_ATTR(vpu_read3, "config1:18");
> +PMU_FORMAT_ATTR(vpu_write1, "config1:19");
> +PMU_FORMAT_ATTR(vpu_write2, "config1:20");
> +PMU_FORMAT_ATTR(vdec, "config1:21");
> +PMU_FORMAT_ATTR(hcodec, "config1:22");
> +PMU_FORMAT_ATTR(ge2d, "config1:23");
> +
> +PMU_FORMAT_ATTR(spicc1, "config1:32");
> +PMU_FORMAT_ATTR(usb0, "config1:33");
> +PMU_FORMAT_ATTR(dma, "config1:34");
> +PMU_FORMAT_ATTR(arb0, "config1:35");
> +PMU_FORMAT_ATTR(sd_emmc_b, "config1:36");
> +PMU_FORMAT_ATTR(usb1, "config1:37");
> +PMU_FORMAT_ATTR(audio, "config1:38");
> +PMU_FORMAT_ATTR(aififo, "config1:39");
> +PMU_FORMAT_ATTR(parser, "config1:41");
> +PMU_FORMAT_ATTR(ao_cpu, "config1:42");
> +PMU_FORMAT_ATTR(sd_emmc_c, "config1:43");
> +PMU_FORMAT_ATTR(spicc2, "config1:44");
> +PMU_FORMAT_ATTR(ethernet, "config1:45");
> +PMU_FORMAT_ATTR(sana, "config1:46");
> +
> +/* for sm1 and g12b */
> +PMU_FORMAT_ATTR(nna, "config1:10");
> +
> +/* for g12b only */
> +PMU_FORMAT_ATTR(gdc, "config1:11");
> +PMU_FORMAT_ATTR(mipi_isp, "config1:12");
> +PMU_FORMAT_ATTR(arm1, "config1:13");
> +PMU_FORMAT_ATTR(sd_emmc_a, "config1:40");
> +
> +/* 256 is enough for axi id */
> +static struct attribute *g12_pmu_format_attrs[256] = {

But a statically-initialised array already knows exactly how large it 
needs to be, why explicitly size it at all?

> +	&format_attr_event.attr,
> +	&format_attr_arm.attr,
> +	&format_attr_gpu.attr,
> +	&format_attr_pcie.attr,
> +	&format_attr_hdcp.attr,
> +	&format_attr_hevc_front.attr,
> +	&format_attr_usb3_0.attr,
> +	&format_attr_device.attr,
> +	&format_attr_hevc_back.attr,
> +	&format_attr_h265enc.attr,
> +	&format_attr_vpu_read1.attr,
> +	&format_attr_vpu_read2.attr,
> +	&format_attr_vpu_read3.attr,
> +	&format_attr_vpu_write1.attr,
> +	&format_attr_vpu_write2.attr,
> +	&format_attr_vdec.attr,
> +	&format_attr_hcodec.attr,
> +	&format_attr_ge2d.attr,
> +	&format_attr_spicc1.attr,
> +	&format_attr_usb0.attr,
> +	&format_attr_dma.attr,
> +	&format_attr_arb0.attr,
> +	&format_attr_sd_emmc_b.attr,
> +	&format_attr_usb1.attr,
> +	&format_attr_audio.attr,
> +	&format_attr_aififo.attr,
> +	&format_attr_parser.attr,
> +	&format_attr_ao_cpu.attr,
> +	&format_attr_sd_emmc_c.attr,
> +	&format_attr_spicc2.attr,
> +	&format_attr_ethernet.attr,
> +	&format_attr_sana.attr,
> +	NULL,
> +};
> +
> +static void append_attr_list(struct attribute *attr)
> +{
> +	int i;
> +
> +	for (i = 0; g12_pmu_format_attrs[i] && i < 255; i++)
> +		;

Eww, what? :(

> +
> +	g12_pmu_format_attrs[i] = attr;
> +
> +	g12_pmu_format_attrs[i + 1] = NULL;

(that's pointless either way)

OK, I think I see what's going on here now. Dynamically patching the 
attribute arrays is pretty grim - it's far cleaner and more sustainable 
to statically define the whole array with all the possible attributes, 
then use .is_visible to hide the ones which aren't relevant to the 
current system.

> +}
> +
> +/* calculate ddr clock */
> +static unsigned long dmc_g12_get_freq_quick(struct dmc_hw_info *info)
> +{
> +	unsigned int val;
> +	unsigned int n, m, od1;
> +	unsigned int od_div = 0xfff;
> +	unsigned long freq = 0;
> +
> +	val = readl(info->pll_reg);
> +	val = val & 0xfffff;
> +	switch ((val >> 16) & 7) {
> +	case 0:
> +		od_div = 2;
> +		break;
> +
> +	case 1:
> +		od_div = 3;
> +		break;
> +
> +	case 2:
> +		od_div = 4;
> +		break;
> +
> +	case 3:
> +		od_div = 6;
> +		break;
> +
> +	case 4:
> +		od_div = 8;
> +		break;
> +
> +	default:
> +		break;
> +	}
> +
> +	m = val & 0x1ff;
> +	n = ((val >> 10) & 0x1f);
> +	od1 = (((val >> 19) & 0x1)) == 1 ? 2 : 1;
> +	freq = DEFAULT_XTAL_FREQ / 1000;        /* avoid overflow */
> +	if (n)
> +		freq = ((((freq * m) / n) >> od1) / od_div) * 1000;
> +
> +	return freq;
> +}
> +
> +#ifdef DEBUG
> +static void g12_dump_reg(struct dmc_hw_info *db)
> +{
> +	int s = 0, i;
> +	unsigned int r;
> +
> +	for (i = 0; i < 9; i++) {
> +		r  = readl(db->ddr_reg[0] + (DMC_MON_G12_CTRL0 + (i << 2)));
> +		pr_notice("DMC_MON_CTRL%d:        %08x\n", i, r);
> +	}
> +	r  = readl(db->ddr_reg[0] + DMC_MON_G12_ALL_REQ_CNT);
> +	pr_notice("DMC_MON_ALL_REQ_CNT:  %08x\n", r);
> +	r  = readl(db->ddr_reg[0] + DMC_MON_G12_ALL_GRANT_CNT);
> +	pr_notice("DMC_MON_ALL_GRANT_CNT:%08x\n", r);
> +	r  = readl(db->ddr_reg[0] + DMC_MON_G12_ONE_GRANT_CNT);
> +	pr_notice("DMC_MON_ONE_GRANT_CNT:%08x\n", r);
> +	r  = readl(db->ddr_reg[0] + DMC_MON_G12_SEC_GRANT_CNT);
> +	pr_notice("DMC_MON_SEC_GRANT_CNT:%08x\n", r);
> +	r  = readl(db->ddr_reg[0] + DMC_MON_G12_THD_GRANT_CNT);
> +	pr_notice("DMC_MON_THD_GRANT_CNT:%08x\n", r);
> +	r  = readl(db->ddr_reg[0] + DMC_MON_G12_FOR_GRANT_CNT);
> +	pr_notice("DMC_MON_FOR_GRANT_CNT:%08x\n", r);
> +	r  = readl(db->ddr_reg[0] + DMC_MON_G12_TIMER);
> +	pr_notice("DMC_MON_TIMER:        %08x\n", r);
> +}
> +#endif
> +
> +static void dmc_g12_counter_enable(struct dmc_hw_info *info)
> +{
> +	unsigned int val;
> +	unsigned long clock_count = dmc_g12_get_freq_quick(info) / 10; /* 100ms */
> +
> +	writel(clock_count, info->ddr_reg[0] + DMC_MON_G12_TIMER);
> +
> +	val = readl(info->ddr_reg[0] + DMC_MON_G12_CTRL0);
> +
> +	/* enable all channel */
> +	val =  BIT(31) |	/* enable bit */
> +	       BIT(20) |	/* use timer  */
> +	       0x0f;		/* 4 channels */
> +
> +	writel(val, info->ddr_reg[0] + DMC_MON_G12_CTRL0);
> +
> +#ifdef DEBUG
> +	g12_dump_reg(info);
> +#endif
> +}
> +
> +static void dmc_g12_config_fiter(struct dmc_hw_info *info,
> +				 int port, int channel)
> +{
> +	u32 val;
> +	u32 rp[MAX_CHANNEL_NUM] = {DMC_MON_G12_CTRL1, DMC_MON_G12_CTRL3,
> +					DMC_MON_G12_CTRL5, DMC_MON_G12_CTRL7};
> +	u32 rs[MAX_CHANNEL_NUM] = {DMC_MON_G12_CTRL2, DMC_MON_G12_CTRL4,
> +					DMC_MON_G12_CTRL6, DMC_MON_G12_CTRL8};
> +	int subport = -1;
> +
> +	/* clear all port mask */
> +	if (port < 0) {
> +		writel(0, info->ddr_reg[0] + rp[channel]);
> +		writel(0, info->ddr_reg[0] + rs[channel]);
> +		return;
> +	}
> +
> +	if (port >= PORT_MAJOR)
> +		subport = port - PORT_MAJOR;
> +
> +	if (subport < 0) {
> +		val = readl(info->ddr_reg[0] + rp[channel]);
> +		val |=  (1 << port);
> +		writel(val, info->ddr_reg[0] + rp[channel]);
> +		val = 0xffff;
> +		writel(val, info->ddr_reg[0] + rs[channel]);
> +	} else {
> +		val = BIT(23);		/* select device */
> +		writel(val, info->ddr_reg[0] + rp[channel]);
> +		val = readl(info->ddr_reg[0] + rs[channel]);
> +		val |= (1 << subport);
> +		writel(val, info->ddr_reg[0] + rs[channel]);
> +	}
> +}
> +
> +static void dmc_g12_config_axi_id(struct dmc_hw_info *info, int axi_id, int channel)
> +{
> +	if (channel > info->chann_nr)
> +		return;
> +
> +	dmc_g12_config_fiter(info, axi_id, channel);
> +}
> +
> +static void dmc_g12_counter_disable(struct dmc_hw_info *info)
> +{
> +	int i;
> +
> +	/* clear timer */
> +	writel(0, info->ddr_reg[0] + DMC_MON_G12_CTRL0);
> +	writel(0, info->ddr_reg[0] + DMC_MON_G12_TIMER);
> +
> +	writel(0, info->ddr_reg[0] + DMC_MON_G12_ALL_REQ_CNT);
> +	writel(0, info->ddr_reg[0] + DMC_MON_G12_ALL_GRANT_CNT);
> +	writel(0, info->ddr_reg[0] + DMC_MON_G12_ONE_GRANT_CNT);
> +	writel(0, info->ddr_reg[0] + DMC_MON_G12_SEC_GRANT_CNT);
> +	writel(0, info->ddr_reg[0] + DMC_MON_G12_THD_GRANT_CNT);
> +	writel(0, info->ddr_reg[0] + DMC_MON_G12_FOR_GRANT_CNT);
> +
> +	/* clear port channel mapping */
> +	for (i = 0; i < info->chann_nr; i++)
> +		dmc_g12_config_fiter(info, -1, i);
> +}
> +
> +static void dmc_g12_get_counters(struct dmc_hw_info *info,
> +				 struct dmc_counter *counter)
> +{
> +	int i;
> +	unsigned int reg;
> +
> +	counter->all_cnt = readl(info->ddr_reg[0] + DMC_MON_G12_ALL_GRANT_CNT);
> +	counter->all_req   = readl(info->ddr_reg[0] + DMC_MON_G12_ALL_REQ_CNT);
> +
> +	for (i = 0; i < info->chann_nr; i++) {
> +		reg = DMC_MON_G12_ONE_GRANT_CNT + (i << 2);
> +		counter->channel_cnt[i] = readl(info->ddr_reg[0] + reg);
> +	}
> +}
> +
> +static int dmc_g12_irq_handler(struct dmc_hw_info *info,
> +			       struct dmc_counter *counter)
> +{
> +	unsigned int val;
> +	int ret = -1;
> +
> +	val = readl(info->ddr_reg[0] + DMC_MON_G12_CTRL0);
> +	if (val & DMC_QOS_IRQ) {
> +		dmc_g12_get_counters(info, counter);
> +		/* clear irq flags */
> +		writel(val, info->ddr_reg[0] + DMC_MON_G12_CTRL0);
> +		ret = 0;
> +	}
> +	return ret;
> +}
> +
> +static struct dmc_pmu_hw_ops g12_ops = {
> +	.enable		= dmc_g12_counter_enable,
> +	.disable	= dmc_g12_counter_disable,
> +	.irq_handler	= dmc_g12_irq_handler,
> +	.get_counters	= dmc_g12_get_counters,
> +	.config_axi_id	= dmc_g12_config_axi_id,
> +};
> +
> +static int __init g12_ddr_pmu_probe(struct platform_device *pdev)
> +{
> +#ifdef CONFIG_OF

As before, remove all these. The of_* APIs should be stubbed out well 
enough that it still compile-tests OK.

> +	struct device_node *node = pdev->dev.of_node;
> +	const char *model;
> +
> +	if (of_property_read_string(node, "model", &model))
> +		return -EINVAL;

No, use of_device_is_compatible(), and define the binding properly.

> +	dev_info(&pdev->dev, "%s", model);
> +
> +	if (strcmp(model, "g12a") == 0) {
> +		dev_info(&pdev->dev, "ddr pmu for g12a\n");
> +	} else if (strcmp(model, "g12b") == 0) {
> +		dev_info(&pdev->dev, "ddr pmu for g12b\n");
> +
> +		append_attr_list(&format_attr_nna.attr);
> +		append_attr_list(&format_attr_gdc.attr);
> +		append_attr_list(&format_attr_arm1.attr);
> +		append_attr_list(&format_attr_mipi_isp.attr);
> +		append_attr_list(&format_attr_sd_emmc_a.attr);
> +	} else if (strcmp(model, "sm1") == 0) {
> +		dev_info(&pdev->dev, "ddr pmu for sm1\n");
> +
> +		append_attr_list(&format_attr_nna.attr);
> +	}
> +#endif
> +	return aml_ddr_pmu_create(pdev, &g12_ops, g12_pmu_format_attrs);
> +}
> +
> +static int  __exit g12_ddr_pmu_remove(struct platform_device *pdev)
> +{
> +	aml_ddr_pmu_remove(pdev);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id aml_ddr_pmu_dt_match[] = {
> +	{
> +		.compatible = "amlogic,g12-ddr-pmu",
> +	},
> +	{}
> +};
> +#endif
> +
> +static struct platform_driver g12_ddr_pmu_driver = {
> +	.driver = {
> +		.name = "amlogic,ddr-pmu",
> +		.owner = THIS_MODULE,

The driver core sets this automatically.

> +	#ifdef CONFIG_OF
> +		.of_match_table = aml_ddr_pmu_dt_match,
> +	#endif
> +	},
> +	.remove = g12_ddr_pmu_remove,
> +};
> +
> +static int __init aml_g12_ddr_pmu_init(void)
> +{
> +	return platform_driver_probe(&g12_ddr_pmu_driver, g12_ddr_pmu_probe);
> +}
> +
> +static void __exit aml_g12_ddr_pmu_exit(void)
> +{
> +	platform_driver_unregister(&g12_ddr_pmu_driver);
> +}
> +
> +module_init(aml_g12_ddr_pmu_init);
> +module_exit(aml_g12_ddr_pmu_exit);

Use module_platform_driver_probe() (if of course you really think the 
__init shenanigans are beneficial, otherwise just use regular 
module_platform_driver() for even less surprise).

Thanks,
Robin.

> +MODULE_LICENSE("GPL");
> diff --git a/include/soc/amlogic/aml_ddr_pmu.h b/include/soc/amlogic/aml_ddr_pmu.h
> new file mode 100644
> index 000000000000..4f60a9f4fa4a
> --- /dev/null
> +++ b/include/soc/amlogic/aml_ddr_pmu.h
> @@ -0,0 +1,63 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2022 Amlogic, Inc. All rights reserved.
> + */
> +
> +#ifndef __AML_DDR_PMU_H__
> +#define __AML_DDR_PMU_H__
> +
> +#define MAX_CHANNEL_NUM		8
> +
> +enum {
> +	ALL_CHAN_COUNTER_ID,
> +	CHAN1_COUNTER_ID,
> +	CHAN2_COUNTER_ID,
> +	CHAN3_COUNTER_ID,
> +	CHAN4_COUNTER_ID,
> +	CHAN5_COUNTER_ID,
> +	CHAN6_COUNTER_ID,
> +	CHAN7_COUNTER_ID,
> +	CHAN8_COUNTER_ID,
> +	COUNTER_MAX_ID,
> +};
> +
> +struct dmc_hw_info {
> +	struct dmc_pmu_hw_ops *ops;
> +	void __iomem *ddr_reg[4];
> +	unsigned long timer_value;	/* Timer value in TIMER register */
> +	void __iomem *pll_reg;
> +	int irq_num;			/* irq vector number */
> +	int dmc_nr;			/* The number of dmc controller */
> +	int chann_nr;			/* The number of dmc bandwidth monitor channels */
> +	int id;				/* The number of supported channels */
> +};
> +
> +struct dmc_counter {
> +	u64 all_cnt;	/* The count of all requests come in/out ddr controller */
> +	union {
> +		u64 all_req;
> +		struct {
> +			u64 all_idle_cnt;
> +			u64 all_16bit_cnt;
> +		};
> +	};
> +	u64 channel_cnt[MAX_CHANNEL_NUM]; /* To save a DMC bandwidth-monitor channel counter */
> +};
> +
> +struct dmc_pmu_hw_ops {
> +	void (*enable)(struct dmc_hw_info *info);
> +	void (*disable)(struct dmc_hw_info *info);
> +	/* Bind an axi line to a bandwidth-monitor channel */
> +	void (*config_axi_id)(struct dmc_hw_info *info, int axi_id, int chann);
> +	int (*irq_handler)(struct dmc_hw_info *info,
> +			   struct dmc_counter *counter);
> +	void (*get_counters)(struct dmc_hw_info *info,
> +			     struct dmc_counter *counter);
> +};
> +
> +int aml_ddr_pmu_create(struct platform_device *pdev,
> +		       struct dmc_pmu_hw_ops *ops,
> +		       struct attribute **fmt_attr);
> +int aml_ddr_pmu_remove(struct platform_device *pdev);
> +
> +#endif /* __AML_DDR_PMU_H__ */
