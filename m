Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3D25282E5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 13:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239007AbiEPLMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 07:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242994AbiEPLLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 07:11:23 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42A4B31
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 04:11:20 -0700 (PDT)
Received: from kwepemi100002.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4L1xJd28G7zCslB;
        Mon, 16 May 2022 19:06:25 +0800 (CST)
Received: from kwepemm600016.china.huawei.com (7.193.23.20) by
 kwepemi100002.china.huawei.com (7.221.188.188) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 16 May 2022 19:11:17 +0800
Received: from [10.67.102.67] (10.67.102.67) by kwepemm600016.china.huawei.com
 (7.193.23.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 16 May
 2022 19:11:17 +0800
Subject: Re: [PATCH V6 2/2] drivers/perf: hisi: add driver for HNS3 PMU
To:     Will Deacon <will@kernel.org>
CC:     <john.garry@huawei.com>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <liuqi115@huawei.com>, <zhangshaokun@hisilicon.com>,
        <f.fangjian@huawei.com>, <lipeng321@huawei.com>,
        <shenjian15@huawei.com>
References: <20220427121000.56026-1-huangguangbin2@huawei.com>
 <20220427121000.56026-3-huangguangbin2@huawei.com>
 <20220513121137.GA31733@willie-the-truck>
From:   "huangguangbin (A)" <huangguangbin2@huawei.com>
Message-ID: <b0dc9de6-baf3-9c06-1f8c-c16a5d745ee3@huawei.com>
Date:   Mon, 16 May 2022 19:11:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20220513121137.GA31733@willie-the-truck>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.67]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600016.china.huawei.com (7.193.23.20)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/5/13 20:11, Will Deacon wrote:
> On Wed, Apr 27, 2022 at 08:10:00PM +0800, Guangbin Huang wrote:
>> HNS3(HiSilicon Network System 3) PMU is RCiEP device in HiSilicon SoC NIC,
>> supports collection of performance statistics such as bandwidth, latency,
>> packet rate and interrupt rate.
>>
>> NIC of each SICL has one PMU device for it. Driver registers each PMU
>> device to perf, and exports information of supported events, filter mode of
>> each event, bdf range, hardware clock frequency, identifier and so on via
>> sysfs.
> 
> Curioous, but how similar is this device to the one which we already support
> in hisi_pcie_pmu.c? Can we reuse/share any of that existing code?
> 
Hi Will,
Thanks very much for your comments!

HNS3 PMU is also a RCiEP device and also has two registers for each hardware event,
and I referred to code of hisi_pcie_pmu.c when writing this driver code, so this
driver is similar to hisi_pcie_pmu.c.

There is only a small amount of code in hisi_pcie_pmu.c can be reuse/share for HNS3
PMU driver, so I didn't reuse them because I think it is not very profitable. HNS3
PMU is different type of hardware and has it own iterative version in the future, so
I tend not to be coupled with code of hisi_pcie_pmu.c. And they have different prefix
too.

Do you think it is really necessary to reuse some code of hisi_pcie_pmu.c?


>> Each PMU device has its own registers of control, counters and interrupt,
>> and it supports 8 hardware events, each hardward event has its own
>> registers for configuration, counters and interrupt.
>>
>> Filter options contains:
>> event        - select event
>> port         - select physical port of nic
>> tc           - select tc(must be used with port)
>> func         - select PF/VF
>> queue        - select queue of PF/VF(must be used with func)
>> intr         - select interrupt number(must be used with func)
>> global       - select all functions of IO DIE
>>
>> Signed-off-by: Guangbin Huang <huangguangbin2@huawei.com>
>> Reviewed-by: John Garry <john.garry@huawei.com>
>> ---
>>   MAINTAINERS                       |    6 +
>>   drivers/perf/hisilicon/Kconfig    |   10 +
>>   drivers/perf/hisilicon/Makefile   |    1 +
>>   drivers/perf/hisilicon/hns3_pmu.c | 1654 +++++++++++++++++++++++++++++
>>   include/linux/cpuhotplug.h        |    1 +
>>   5 files changed, 1672 insertions(+)
>>   create mode 100644 drivers/perf/hisilicon/hns3_pmu.c
> 
> Anyway, this mostly looks good to me, but I have a few small comments on the
> user ABI:
> 
>> +#define HNS3_PMU_FILTER_ATTR(_name, _config, _start, _end)               \
>> +	static inline u64 hns3_pmu_get_##_name(struct perf_event *event) \
>> +	{                                                                \
>> +		return FIELD_GET(GENMASK_ULL(_end, _start),              \
>> +				 event->attr._config);                   \
>> +	}
>> +
>> +HNS3_PMU_FILTER_ATTR(event, config, 0, 16);
>> +HNS3_PMU_FILTER_ATTR(subevent, config, 0, 7);
>> +HNS3_PMU_FILTER_ATTR(event_type, config, 8, 15);
>> +HNS3_PMU_FILTER_ATTR(ext_counter_used, config, 16, 16);
>> +HNS3_PMU_FILTER_ATTR(real_event, config, 0, 15);
>> +HNS3_PMU_FILTER_ATTR(port, config1, 0, 3);
>> +HNS3_PMU_FILTER_ATTR(tc, config1, 4, 7);
>> +HNS3_PMU_FILTER_ATTR(bdf, config1, 8, 23);
>> +HNS3_PMU_FILTER_ATTR(queue, config1, 24, 39);
>> +HNS3_PMU_FILTER_ATTR(intr, config1, 40, 51);
>> +HNS3_PMU_FILTER_ATTR(global, config1, 52, 52);
>> +
>> +#define HNS3_BW_EVT_BYTE_NUM(_name)	(&(struct hns3_pmu_event_attr) {\
>> +	HNS3_PMU_EVT_BW_##_name##_BYTE_NUM,				\
>> +	HNS3_PMU_FILTER_BW_##_name})
>> +#define HNS3_BW_EVT_TIME(_name)		(&(struct hns3_pmu_event_attr) {\
>> +	HNS3_PMU_EVT_BW_##_name##_TIME,					\
>> +	HNS3_PMU_FILTER_BW_##_name})
>> +#define HNS3_PPS_EVT_PACKET_NUM(_name)	(&(struct hns3_pmu_event_attr) {\
>> +	HNS3_PMU_EVT_PPS_##_name##_PACKET_NUM,				\
>> +	HNS3_PMU_FILTER_PPS_##_name})
>> +#define HNS3_PPS_EVT_TIME(_name)	(&(struct hns3_pmu_event_attr) {\
>> +	HNS3_PMU_EVT_PPS_##_name##_TIME,				\
>> +	HNS3_PMU_FILTER_PPS_##_name})
>> +#define HNS3_DLY_EVT_TIME(_name)	(&(struct hns3_pmu_event_attr) {\
>> +	HNS3_PMU_EVT_DLY_##_name##_TIME,				\
>> +	HNS3_PMU_FILTER_DLY_##_name})
>> +#define HNS3_DLY_EVT_PACKET_NUM(_name)	(&(struct hns3_pmu_event_attr) {\
>> +	HNS3_PMU_EVT_DLY_##_name##_PACKET_NUM,				\
>> +	HNS3_PMU_FILTER_DLY_##_name})
>> +#define HNS3_INTR_EVT_INTR_NUM(_name)	(&(struct hns3_pmu_event_attr) {\
>> +	HNS3_PMU_EVT_PPS_##_name##_INTR_NUM,				\
>> +	HNS3_PMU_FILTER_INTR_##_name})
>> +#define HNS3_INTR_EVT_TIME(_name)	(&(struct hns3_pmu_event_attr) {\
>> +	HNS3_PMU_EVT_PPS_##_name##_TIME,				\
>> +	HNS3_PMU_FILTER_INTR_##_name})
>> +
>> +static ssize_t hns3_pmu_format_show(struct device *dev,
>> +				    struct device_attribute *attr, char *buf)
>> +{
>> +	struct dev_ext_attribute *eattr;
>> +
>> +	eattr = container_of(attr, struct dev_ext_attribute, attr);
>> +
>> +	return sysfs_emit(buf, "%s\n", (char *)eattr->var);
>> +}
>> +
>> +static ssize_t hns3_pmu_event_show(struct device *dev,
>> +				   struct device_attribute *attr, char *buf)
>> +{
>> +	struct hns3_pmu_event_attr *event;
>> +	struct dev_ext_attribute *eattr;
>> +
>> +	eattr = container_of(attr, struct dev_ext_attribute, attr);
>> +	event = eattr->var;
>> +
>> +	return sysfs_emit(buf, "config=0x%05x\n", event->event);
> 
> Are you sure you want the %05 here? The format of the number is
> user-visible, so you won't be able to change this in future. The other hisi
> PMU drivers use %lx or %llx.
> 
Ok, I think you are right, I will modify it.

>> +}
>> +
>> +static ssize_t hns3_pmu_filter_mode_show(struct device *dev,
>> +					 struct device_attribute *attr,
>> +					 char *buf)
>> +{
>> +	struct hns3_pmu_event_attr *event;
>> +	struct dev_ext_attribute *eattr;
>> +	int len;
>> +
>> +	eattr = container_of(attr, struct dev_ext_attribute, attr);
>> +	event = eattr->var;
>> +
>> +	len = sysfs_emit_at(buf, 0, "filter mode supported: ");
>> +	if (event->filter_support & HNS3_PMU_FILTER_SUPPORT_GLOBAL)
>> +		len += sysfs_emit_at(buf, len, "global ");
>> +	if (event->filter_support & HNS3_PMU_FILTER_SUPPORT_PORT)
>> +		len += sysfs_emit_at(buf, len, "port ");
>> +	if (event->filter_support & HNS3_PMU_FILTER_SUPPORT_PORT_TC)
>> +		len += sysfs_emit_at(buf, len, "port-tc ");
>> +	if (event->filter_support & HNS3_PMU_FILTER_SUPPORT_FUNC)
>> +		len += sysfs_emit_at(buf, len, "func ");
>> +	if (event->filter_support & HNS3_PMU_FILTER_SUPPORT_FUNC_QUEUE)
>> +		len += sysfs_emit_at(buf, len, "func-queue ");
>> +	if (event->filter_support & HNS3_PMU_FILTER_SUPPORT_FUNC_INTR)
>> +		len += sysfs_emit_at(buf, len, "func-intr");
> 
> It's a bit odd to have a trailing space for everything other than
> "func-intr" as it's not guaranteed to be the last entry (it might not be
> present).
> 
Ok, I will modify it.

>> +
>> +	len += sysfs_emit_at(buf, len, "\n");
>> +
>> +	return len;
>> +}
>> +
>> +#define HNS3_PMU_ATTR(_name, _func, _config)				\
>> +	(&((struct dev_ext_attribute[]) {				\
>> +		{ __ATTR(_name, 0444, _func, NULL), (void *)_config }	\
>> +	})[0].attr.attr)
>> +
>> +#define HNS3_PMU_FORMAT_ATTR(_name, _format) \
>> +	HNS3_PMU_ATTR(_name, hns3_pmu_format_show, (void *)_format)
>> +#define HNS3_PMU_EVENT_ATTR(_name, _event) \
>> +	HNS3_PMU_ATTR(_name, hns3_pmu_event_show, (void *)_event)
>> +#define HNS3_PMU_FLT_MODE_ATTR(_name, _event) \
>> +	HNS3_PMU_ATTR(_name, hns3_pmu_filter_mode_show, (void *)_event)
>> +
>> +#define HNS3_PMU_BW_EVT_PAIR(_name, _macro) \
>> +	HNS3_PMU_EVENT_ATTR(_name##_byte_num, HNS3_BW_EVT_BYTE_NUM(_macro)), \
>> +	HNS3_PMU_EVENT_ATTR(_name##_time, HNS3_BW_EVT_TIME(_macro))
>> +#define HNS3_PMU_PPS_EVT_PAIR(_name, _macro) \
>> +	HNS3_PMU_EVENT_ATTR(_name##_packet_num, HNS3_PPS_EVT_PACKET_NUM(_macro)), \
>> +	HNS3_PMU_EVENT_ATTR(_name##_time, HNS3_PPS_EVT_TIME(_macro))
>> +#define HNS3_PMU_DLY_EVT_PAIR(_name, _macro) \
>> +	HNS3_PMU_EVENT_ATTR(_name##_time, HNS3_DLY_EVT_TIME(_macro)), \
>> +	HNS3_PMU_EVENT_ATTR(_name##_packet_num, HNS3_DLY_EVT_PACKET_NUM(_macro))
>> +#define HNS3_PMU_INTR_EVT_PAIR(_name, _macro) \
>> +	HNS3_PMU_EVENT_ATTR(_name##_intr_num, HNS3_INTR_EVT_INTR_NUM(_macro)), \
>> +	HNS3_PMU_EVENT_ATTR(_name##_time, HNS3_INTR_EVT_TIME(_macro))
>> +
>> +#define HNS3_PMU_BW_FLT_MODE_PAIR(_name, _macro) \
>> +	HNS3_PMU_FLT_MODE_ATTR(_name##_byte_num, HNS3_BW_EVT_BYTE_NUM(_macro)), \
>> +	HNS3_PMU_FLT_MODE_ATTR(_name##_time, HNS3_BW_EVT_TIME(_macro))
>> +#define HNS3_PMU_PPS_FLT_MODE_PAIR(_name, _macro) \
>> +	HNS3_PMU_FLT_MODE_ATTR(_name##_packet_num, HNS3_PPS_EVT_PACKET_NUM(_macro)), \
>> +	HNS3_PMU_FLT_MODE_ATTR(_name##_time, HNS3_PPS_EVT_TIME(_macro))
>> +#define HNS3_PMU_DLY_FLT_MODE_PAIR(_name, _macro) \
>> +	HNS3_PMU_FLT_MODE_ATTR(_name##_time, HNS3_DLY_EVT_TIME(_macro)), \
>> +	HNS3_PMU_FLT_MODE_ATTR(_name##_packet_num, HNS3_DLY_EVT_PACKET_NUM(_macro))
>> +#define HNS3_PMU_INTR_FLT_MODE_PAIR(_name, _macro) \
>> +	HNS3_PMU_FLT_MODE_ATTR(_name##_intr_num, HNS3_INTR_EVT_INTR_NUM(_macro)), \
>> +	HNS3_PMU_FLT_MODE_ATTR(_name##_time, HNS3_INTR_EVT_TIME(_macro))
>> +
>> +static u8 hns3_pmu_hw_filter_modes[] = {
>> +	HNS3_PMU_HW_FILTER_GLOBAL,
>> +	HNS3_PMU_HW_FILTER_PORT,
>> +	HNS3_PMU_HW_FILTER_PORT_TC,
>> +	HNS3_PMU_HW_FILTER_FUNC,
>> +	HNS3_PMU_HW_FILTER_FUNC_QUEUE,
>> +	HNS3_PMU_HW_FILTER_FUNC_INTR,
>> +};
>> +
>> +#define HNS3_PMU_SET_HW_FILTER(_hwc, _mode) \
>> +	((_hwc)->addr_filters = (void *)&hns3_pmu_hw_filter_modes[(_mode)])
>> +
>> +static ssize_t identifier_show(struct device *dev,
>> +			       struct device_attribute *attr, char *buf)
>> +{
>> +	struct hns3_pmu *hns3_pmu = to_hns3_pmu(dev_get_drvdata(dev));
>> +
>> +	return sysfs_emit(buf, "0x%x\n", hns3_pmu->identifier);
>> +}
>> +static DEVICE_ATTR_RO(identifier);
>> +
>> +static ssize_t cpumask_show(struct device *dev, struct device_attribute *attr,
>> +			    char *buf)
>> +{
>> +	struct hns3_pmu *hns3_pmu = to_hns3_pmu(dev_get_drvdata(dev));
>> +
>> +	return sysfs_emit(buf, "%d\n", hns3_pmu->on_cpu);
>> +}
>> +static DEVICE_ATTR_RO(cpumask);
>> +
>> +static ssize_t bdf_min_show(struct device *dev, struct device_attribute *attr,
>> +			    char *buf)
>> +{
>> +	struct hns3_pmu *hns3_pmu = to_hns3_pmu(dev_get_drvdata(dev));
>> +
>> +	return sysfs_emit(buf, "0x%4x\n", hns3_pmu->bdf_min);
> 
> Is it worth formatting the bdf in the usual way ("b:d.f") rather than a
> plain 16-bit number.
> 
Ok, I will modify it.

>> +}
>> +static DEVICE_ATTR_RO(bdf_min);
>> +
>> +static ssize_t bdf_max_show(struct device *dev, struct device_attribute *attr,
>> +			    char *buf)
>> +{
>> +	struct hns3_pmu *hns3_pmu = to_hns3_pmu(dev_get_drvdata(dev));
>> +
>> +	return sysfs_emit(buf, "0x%4x\n", hns3_pmu->bdf_max);
> 
> Likewise.
> 
Ok.

>> +static struct attribute *hns3_pmu_format_attr[] = {
>> +	HNS3_PMU_FORMAT_ATTR(event, "config:0-16"),
> 
> Earlier you split this into event, subevent, event_type and
> ext_counter_used. Why isn't that same structure used here? Ideally, you'd
> derive the strings and the accessors from the same set of definitions so
> you don't run the risk of them falling out of sync. I did that in
> arm_spe_pmu.c but it's not the prettiest code in the world.
> 
Ok. I will modify it.

>> +	HNS3_PMU_FORMAT_ATTR(port, "config1:0-3"),
>> +	HNS3_PMU_FORMAT_ATTR(tc, "config1:4-7"),
>> +	HNS3_PMU_FORMAT_ATTR(bdf, "config1:8-23"),
>> +	HNS3_PMU_FORMAT_ATTR(queue, "config1:24-39"),
>> +	HNS3_PMU_FORMAT_ATTR(intr, "config1:40-51"),
>> +	HNS3_PMU_FORMAT_ATTR(global, "config1:52-52"),
> 
> "52-52" is a bit weird; PMU drivers would usually just do "config1:52"
> for a single-bit field. Is perf tool happy with this?
> 
Ok, I will modify it.

> Will
> .
> 
Thanks very much!
Guangbin
.
