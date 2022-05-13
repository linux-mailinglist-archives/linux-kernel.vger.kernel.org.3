Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754DE526193
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 14:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbiEMML4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 08:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbiEMMLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 08:11:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D965DBEA
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 05:11:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B84561EAE
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 12:11:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4A2C34100;
        Fri, 13 May 2022 12:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652443905;
        bh=4hgHs2uetBGWruhbC3YMXipXWF1Og9xqgeUtgLqcWMg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GfUieOHDTiqfc5pXosFRKxyyIh5df4VpTftU2dJuEywS0UuxFIUDiUwMzOf7Iz9zN
         DMpJQXPeB970ERs5v1SRQT5mrzj8Ru0otPc2EIke1YNRaFDmadZnU1BDok/OyiI544
         LKrQKHJSMQpS8ctA1iV+4kx7OVzvFe/b30XBdI/YSh65MbnXK3MC/aGw1NjAKhs4BC
         qVM6MIRV4aBSrGbDpBHPQ9wlvDQyaNkd7RyJVkAUVkOrIwLfkeLHb2Jg5qPFkWLMT7
         772kMvD8Vi29sBUT23Q1IdEISUmX2MOMvhO1zxNM4aS5pzZgdqd/cPSvVLUiDJaa+R
         N5zYqS+li56kw==
Date:   Fri, 13 May 2022 13:11:39 +0100
From:   Will Deacon <will@kernel.org>
To:     Guangbin Huang <huangguangbin2@huawei.com>
Cc:     john.garry@huawei.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, liuqi115@huawei.com,
        zhangshaokun@hisilicon.com, f.fangjian@huawei.com,
        lipeng321@huawei.com, shenjian15@huawei.com
Subject: Re: [PATCH V6 2/2] drivers/perf: hisi: add driver for HNS3 PMU
Message-ID: <20220513121137.GA31733@willie-the-truck>
References: <20220427121000.56026-1-huangguangbin2@huawei.com>
 <20220427121000.56026-3-huangguangbin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427121000.56026-3-huangguangbin2@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 08:10:00PM +0800, Guangbin Huang wrote:
> HNS3(HiSilicon Network System 3) PMU is RCiEP device in HiSilicon SoC NIC,
> supports collection of performance statistics such as bandwidth, latency,
> packet rate and interrupt rate.
> 
> NIC of each SICL has one PMU device for it. Driver registers each PMU
> device to perf, and exports information of supported events, filter mode of
> each event, bdf range, hardware clock frequency, identifier and so on via
> sysfs.

Curioous, but how similar is this device to the one which we already support
in hisi_pcie_pmu.c? Can we reuse/share any of that existing code?

> Each PMU device has its own registers of control, counters and interrupt,
> and it supports 8 hardware events, each hardward event has its own
> registers for configuration, counters and interrupt.
> 
> Filter options contains:
> event        - select event
> port         - select physical port of nic
> tc           - select tc(must be used with port)
> func         - select PF/VF
> queue        - select queue of PF/VF(must be used with func)
> intr         - select interrupt number(must be used with func)
> global       - select all functions of IO DIE
> 
> Signed-off-by: Guangbin Huang <huangguangbin2@huawei.com>
> Reviewed-by: John Garry <john.garry@huawei.com>
> ---
>  MAINTAINERS                       |    6 +
>  drivers/perf/hisilicon/Kconfig    |   10 +
>  drivers/perf/hisilicon/Makefile   |    1 +
>  drivers/perf/hisilicon/hns3_pmu.c | 1654 +++++++++++++++++++++++++++++
>  include/linux/cpuhotplug.h        |    1 +
>  5 files changed, 1672 insertions(+)
>  create mode 100644 drivers/perf/hisilicon/hns3_pmu.c

Anyway, this mostly looks good to me, but I have a few small comments on the
user ABI:

> +#define HNS3_PMU_FILTER_ATTR(_name, _config, _start, _end)               \
> +	static inline u64 hns3_pmu_get_##_name(struct perf_event *event) \
> +	{                                                                \
> +		return FIELD_GET(GENMASK_ULL(_end, _start),              \
> +				 event->attr._config);                   \
> +	}
> +
> +HNS3_PMU_FILTER_ATTR(event, config, 0, 16);
> +HNS3_PMU_FILTER_ATTR(subevent, config, 0, 7);
> +HNS3_PMU_FILTER_ATTR(event_type, config, 8, 15);
> +HNS3_PMU_FILTER_ATTR(ext_counter_used, config, 16, 16);
> +HNS3_PMU_FILTER_ATTR(real_event, config, 0, 15);
> +HNS3_PMU_FILTER_ATTR(port, config1, 0, 3);
> +HNS3_PMU_FILTER_ATTR(tc, config1, 4, 7);
> +HNS3_PMU_FILTER_ATTR(bdf, config1, 8, 23);
> +HNS3_PMU_FILTER_ATTR(queue, config1, 24, 39);
> +HNS3_PMU_FILTER_ATTR(intr, config1, 40, 51);
> +HNS3_PMU_FILTER_ATTR(global, config1, 52, 52);
> +
> +#define HNS3_BW_EVT_BYTE_NUM(_name)	(&(struct hns3_pmu_event_attr) {\
> +	HNS3_PMU_EVT_BW_##_name##_BYTE_NUM,				\
> +	HNS3_PMU_FILTER_BW_##_name})
> +#define HNS3_BW_EVT_TIME(_name)		(&(struct hns3_pmu_event_attr) {\
> +	HNS3_PMU_EVT_BW_##_name##_TIME,					\
> +	HNS3_PMU_FILTER_BW_##_name})
> +#define HNS3_PPS_EVT_PACKET_NUM(_name)	(&(struct hns3_pmu_event_attr) {\
> +	HNS3_PMU_EVT_PPS_##_name##_PACKET_NUM,				\
> +	HNS3_PMU_FILTER_PPS_##_name})
> +#define HNS3_PPS_EVT_TIME(_name)	(&(struct hns3_pmu_event_attr) {\
> +	HNS3_PMU_EVT_PPS_##_name##_TIME,				\
> +	HNS3_PMU_FILTER_PPS_##_name})
> +#define HNS3_DLY_EVT_TIME(_name)	(&(struct hns3_pmu_event_attr) {\
> +	HNS3_PMU_EVT_DLY_##_name##_TIME,				\
> +	HNS3_PMU_FILTER_DLY_##_name})
> +#define HNS3_DLY_EVT_PACKET_NUM(_name)	(&(struct hns3_pmu_event_attr) {\
> +	HNS3_PMU_EVT_DLY_##_name##_PACKET_NUM,				\
> +	HNS3_PMU_FILTER_DLY_##_name})
> +#define HNS3_INTR_EVT_INTR_NUM(_name)	(&(struct hns3_pmu_event_attr) {\
> +	HNS3_PMU_EVT_PPS_##_name##_INTR_NUM,				\
> +	HNS3_PMU_FILTER_INTR_##_name})
> +#define HNS3_INTR_EVT_TIME(_name)	(&(struct hns3_pmu_event_attr) {\
> +	HNS3_PMU_EVT_PPS_##_name##_TIME,				\
> +	HNS3_PMU_FILTER_INTR_##_name})
> +
> +static ssize_t hns3_pmu_format_show(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	struct dev_ext_attribute *eattr;
> +
> +	eattr = container_of(attr, struct dev_ext_attribute, attr);
> +
> +	return sysfs_emit(buf, "%s\n", (char *)eattr->var);
> +}
> +
> +static ssize_t hns3_pmu_event_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct hns3_pmu_event_attr *event;
> +	struct dev_ext_attribute *eattr;
> +
> +	eattr = container_of(attr, struct dev_ext_attribute, attr);
> +	event = eattr->var;
> +
> +	return sysfs_emit(buf, "config=0x%05x\n", event->event);

Are you sure you want the %05 here? The format of the number is
user-visible, so you won't be able to change this in future. The other hisi
PMU drivers use %lx or %llx.

> +}
> +
> +static ssize_t hns3_pmu_filter_mode_show(struct device *dev,
> +					 struct device_attribute *attr,
> +					 char *buf)
> +{
> +	struct hns3_pmu_event_attr *event;
> +	struct dev_ext_attribute *eattr;
> +	int len;
> +
> +	eattr = container_of(attr, struct dev_ext_attribute, attr);
> +	event = eattr->var;
> +
> +	len = sysfs_emit_at(buf, 0, "filter mode supported: ");
> +	if (event->filter_support & HNS3_PMU_FILTER_SUPPORT_GLOBAL)
> +		len += sysfs_emit_at(buf, len, "global ");
> +	if (event->filter_support & HNS3_PMU_FILTER_SUPPORT_PORT)
> +		len += sysfs_emit_at(buf, len, "port ");
> +	if (event->filter_support & HNS3_PMU_FILTER_SUPPORT_PORT_TC)
> +		len += sysfs_emit_at(buf, len, "port-tc ");
> +	if (event->filter_support & HNS3_PMU_FILTER_SUPPORT_FUNC)
> +		len += sysfs_emit_at(buf, len, "func ");
> +	if (event->filter_support & HNS3_PMU_FILTER_SUPPORT_FUNC_QUEUE)
> +		len += sysfs_emit_at(buf, len, "func-queue ");
> +	if (event->filter_support & HNS3_PMU_FILTER_SUPPORT_FUNC_INTR)
> +		len += sysfs_emit_at(buf, len, "func-intr");

It's a bit odd to have a trailing space for everything other than
"func-intr" as it's not guaranteed to be the last entry (it might not be
present).

> +
> +	len += sysfs_emit_at(buf, len, "\n");
> +
> +	return len;
> +}
> +
> +#define HNS3_PMU_ATTR(_name, _func, _config)				\
> +	(&((struct dev_ext_attribute[]) {				\
> +		{ __ATTR(_name, 0444, _func, NULL), (void *)_config }	\
> +	})[0].attr.attr)
> +
> +#define HNS3_PMU_FORMAT_ATTR(_name, _format) \
> +	HNS3_PMU_ATTR(_name, hns3_pmu_format_show, (void *)_format)
> +#define HNS3_PMU_EVENT_ATTR(_name, _event) \
> +	HNS3_PMU_ATTR(_name, hns3_pmu_event_show, (void *)_event)
> +#define HNS3_PMU_FLT_MODE_ATTR(_name, _event) \
> +	HNS3_PMU_ATTR(_name, hns3_pmu_filter_mode_show, (void *)_event)
> +
> +#define HNS3_PMU_BW_EVT_PAIR(_name, _macro) \
> +	HNS3_PMU_EVENT_ATTR(_name##_byte_num, HNS3_BW_EVT_BYTE_NUM(_macro)), \
> +	HNS3_PMU_EVENT_ATTR(_name##_time, HNS3_BW_EVT_TIME(_macro))
> +#define HNS3_PMU_PPS_EVT_PAIR(_name, _macro) \
> +	HNS3_PMU_EVENT_ATTR(_name##_packet_num, HNS3_PPS_EVT_PACKET_NUM(_macro)), \
> +	HNS3_PMU_EVENT_ATTR(_name##_time, HNS3_PPS_EVT_TIME(_macro))
> +#define HNS3_PMU_DLY_EVT_PAIR(_name, _macro) \
> +	HNS3_PMU_EVENT_ATTR(_name##_time, HNS3_DLY_EVT_TIME(_macro)), \
> +	HNS3_PMU_EVENT_ATTR(_name##_packet_num, HNS3_DLY_EVT_PACKET_NUM(_macro))
> +#define HNS3_PMU_INTR_EVT_PAIR(_name, _macro) \
> +	HNS3_PMU_EVENT_ATTR(_name##_intr_num, HNS3_INTR_EVT_INTR_NUM(_macro)), \
> +	HNS3_PMU_EVENT_ATTR(_name##_time, HNS3_INTR_EVT_TIME(_macro))
> +
> +#define HNS3_PMU_BW_FLT_MODE_PAIR(_name, _macro) \
> +	HNS3_PMU_FLT_MODE_ATTR(_name##_byte_num, HNS3_BW_EVT_BYTE_NUM(_macro)), \
> +	HNS3_PMU_FLT_MODE_ATTR(_name##_time, HNS3_BW_EVT_TIME(_macro))
> +#define HNS3_PMU_PPS_FLT_MODE_PAIR(_name, _macro) \
> +	HNS3_PMU_FLT_MODE_ATTR(_name##_packet_num, HNS3_PPS_EVT_PACKET_NUM(_macro)), \
> +	HNS3_PMU_FLT_MODE_ATTR(_name##_time, HNS3_PPS_EVT_TIME(_macro))
> +#define HNS3_PMU_DLY_FLT_MODE_PAIR(_name, _macro) \
> +	HNS3_PMU_FLT_MODE_ATTR(_name##_time, HNS3_DLY_EVT_TIME(_macro)), \
> +	HNS3_PMU_FLT_MODE_ATTR(_name##_packet_num, HNS3_DLY_EVT_PACKET_NUM(_macro))
> +#define HNS3_PMU_INTR_FLT_MODE_PAIR(_name, _macro) \
> +	HNS3_PMU_FLT_MODE_ATTR(_name##_intr_num, HNS3_INTR_EVT_INTR_NUM(_macro)), \
> +	HNS3_PMU_FLT_MODE_ATTR(_name##_time, HNS3_INTR_EVT_TIME(_macro))
> +
> +static u8 hns3_pmu_hw_filter_modes[] = {
> +	HNS3_PMU_HW_FILTER_GLOBAL,
> +	HNS3_PMU_HW_FILTER_PORT,
> +	HNS3_PMU_HW_FILTER_PORT_TC,
> +	HNS3_PMU_HW_FILTER_FUNC,
> +	HNS3_PMU_HW_FILTER_FUNC_QUEUE,
> +	HNS3_PMU_HW_FILTER_FUNC_INTR,
> +};
> +
> +#define HNS3_PMU_SET_HW_FILTER(_hwc, _mode) \
> +	((_hwc)->addr_filters = (void *)&hns3_pmu_hw_filter_modes[(_mode)])
> +
> +static ssize_t identifier_show(struct device *dev,
> +			       struct device_attribute *attr, char *buf)
> +{
> +	struct hns3_pmu *hns3_pmu = to_hns3_pmu(dev_get_drvdata(dev));
> +
> +	return sysfs_emit(buf, "0x%x\n", hns3_pmu->identifier);
> +}
> +static DEVICE_ATTR_RO(identifier);
> +
> +static ssize_t cpumask_show(struct device *dev, struct device_attribute *attr,
> +			    char *buf)
> +{
> +	struct hns3_pmu *hns3_pmu = to_hns3_pmu(dev_get_drvdata(dev));
> +
> +	return sysfs_emit(buf, "%d\n", hns3_pmu->on_cpu);
> +}
> +static DEVICE_ATTR_RO(cpumask);
> +
> +static ssize_t bdf_min_show(struct device *dev, struct device_attribute *attr,
> +			    char *buf)
> +{
> +	struct hns3_pmu *hns3_pmu = to_hns3_pmu(dev_get_drvdata(dev));
> +
> +	return sysfs_emit(buf, "0x%4x\n", hns3_pmu->bdf_min);

Is it worth formatting the bdf in the usual way ("b:d.f") rather than a
plain 16-bit number.

> +}
> +static DEVICE_ATTR_RO(bdf_min);
> +
> +static ssize_t bdf_max_show(struct device *dev, struct device_attribute *attr,
> +			    char *buf)
> +{
> +	struct hns3_pmu *hns3_pmu = to_hns3_pmu(dev_get_drvdata(dev));
> +
> +	return sysfs_emit(buf, "0x%4x\n", hns3_pmu->bdf_max);

Likewise.

> +static struct attribute *hns3_pmu_format_attr[] = {
> +	HNS3_PMU_FORMAT_ATTR(event, "config:0-16"),

Earlier you split this into event, subevent, event_type and
ext_counter_used. Why isn't that same structure used here? Ideally, you'd
derive the strings and the accessors from the same set of definitions so
you don't run the risk of them falling out of sync. I did that in
arm_spe_pmu.c but it's not the prettiest code in the world.

> +	HNS3_PMU_FORMAT_ATTR(port, "config1:0-3"),
> +	HNS3_PMU_FORMAT_ATTR(tc, "config1:4-7"),
> +	HNS3_PMU_FORMAT_ATTR(bdf, "config1:8-23"),
> +	HNS3_PMU_FORMAT_ATTR(queue, "config1:24-39"),
> +	HNS3_PMU_FORMAT_ATTR(intr, "config1:40-51"),
> +	HNS3_PMU_FORMAT_ATTR(global, "config1:52-52"),

"52-52" is a bit weird; PMU drivers would usually just do "config1:52"
for a single-bit field. Is perf tool happy with this?

Will
