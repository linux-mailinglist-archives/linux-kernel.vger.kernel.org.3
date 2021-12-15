Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC91475CED
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238342AbhLOQK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:10:28 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:32345 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235225AbhLOQK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:10:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1639584628; x=1671120628;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gpjK59UWJIiP0OWA2Shuz6k5+OjIBY6OKhF6hdfgM2w=;
  b=GDUrRQjo/l/ej/z8lP62yfAyU1pOuNCAioFpT2MfUlDoGwPM606oMcYe
   3kmvNfiFoz4EzEHsUx1YXmbZ7t4a1Nz3rfg6/8vyAPmgaB0/wxkD+Un0Y
   xxy2fAJ7J2pYC3cFD3JC4gVAv4urExaNdFnwmLd8CAK2cZf7ygja9DJrR
   g=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 15 Dec 2021 08:10:27 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 08:10:27 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 15 Dec 2021 08:10:26 -0800
Received: from [10.253.39.78] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Wed, 15 Dec
 2021 08:10:22 -0800
Message-ID: <85ad17fb-c885-831d-d841-4c6f10920355@quicinc.com>
Date:   Thu, 16 Dec 2021 00:10:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2 2/9] Coresight: Add coresight TPDM source driver
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>
References: <20211209141543.21314-1-quic_jinlmao@quicinc.com>
 <20211209141543.21314-3-quic_jinlmao@quicinc.com>
 <20211214185714.GB1549991@p14s>
From:   Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <20211214185714.GB1549991@p14s>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 12/15/2021 2:57 AM, Mathieu Poirier wrote:
> On Thu, Dec 09, 2021 at 10:15:36PM +0800, Mao Jinlong wrote:
>> Add driver to support Coresight device TPDM (Trace, Profiling and
>> Diagnostics Monitor). TPDM is a monitor to collect data from
>> different datasets. This change is to add probe/enable/disable
>> functions for tpdm source.
>>
>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>> ---
>>   MAINTAINERS                                  |   8 +
>>   drivers/hwtracing/coresight/Kconfig          |  13 ++
>>   drivers/hwtracing/coresight/Makefile         |   1 +
>>   drivers/hwtracing/coresight/coresight-core.c |   3 +-
>>   drivers/hwtracing/coresight/coresight-tpdm.c | 152 +++++++++++++++++++
>>   drivers/hwtracing/coresight/coresight-tpdm.h |  31 ++++
>>   include/linux/coresight.h                    |   1 +
>>   7 files changed, 208 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/hwtracing/coresight/coresight-tpdm.c
>>   create mode 100644 drivers/hwtracing/coresight/coresight-tpdm.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 7a2345ce8521..59f39b3194f6 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -15560,6 +15560,14 @@ L:	netdev@vger.kernel.org
>>   S:	Supported
>>   F:	drivers/net/ipa/
>>   
>> +QCOM CORESIGHT COMPONENTS DRIVER
>> +M:	Tao Zhang <quic_taozha@quicinc.com>
>> +M:	Jinlong Mao <quic_jinlmao@quicinc.com>
>> +M:	Mathieu Poirier <mathieu.poirier@linaro.org>
>> +M:	Suzuki K Poulose <suzuki.poulose@arm.com>
>> +S:	Maintained
>> +F:	drivers/hwtracing/coresight/coresight-tpdm.c
>> +
> There is no need for an extra entry in the MAINTAINERS file.  The checkpatch.pl
> script is smart enough to know when to CC you and Tao every time the TPDM/TPDA
> drivers are modified.  Suzuki and I will simply wait for you guys to add your RB
> tags before reviewing the patches.  I have explained this in the previous revision.

Hi Mathieu,

I will remove this  entry.

>>   QEMU MACHINE EMULATOR AND VIRTUALIZER SUPPORT
>>   M:	Gabriel Somlo <somlo@cmu.edu>
>>   M:	"Michael S. Tsirkin" <mst@redhat.com>
>> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
>> index 514a9b8086e3..5c506a1cd08f 100644
>> --- a/drivers/hwtracing/coresight/Kconfig
>> +++ b/drivers/hwtracing/coresight/Kconfig
>> @@ -201,4 +201,17 @@ config CORESIGHT_TRBE
>>   
>>   	  To compile this driver as a module, choose M here: the module will be
>>   	  called coresight-trbe.
>> +
>> +config CORESIGHT_TPDM
>> +	tristate "CoreSight Trace, Profiling & Diagnostics Monitor driver"
>> +	select CORESIGHT_LINKS_AND_SINKS
> Is this available on 32bit HW as well?  If not please make it dependent on ARM64
> as it for ETMv4x devices.
This is available on 32bit HW as well.
>> +	help
>> +	  This driver provides support for configuring monitor. Monitors are
>> +	  primarily responsible for data set collection and support the
>> +	  ability to collect any permutation of data set types. Monitors are
>> +	  also responsible for interaction with system cross triggering.
>> +
>> +	  To compile this driver as a module, choose M here: the module will be
>> +	  called coresight-tpdm.
>> +
>>   endif
>> diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
>> index b6c4a48140ec..e7392a0dddeb 100644
>> --- a/drivers/hwtracing/coresight/Makefile
>> +++ b/drivers/hwtracing/coresight/Makefile
>> @@ -25,5 +25,6 @@ obj-$(CONFIG_CORESIGHT_CPU_DEBUG) += coresight-cpu-debug.o
>>   obj-$(CONFIG_CORESIGHT_CATU) += coresight-catu.o
>>   obj-$(CONFIG_CORESIGHT_CTI) += coresight-cti.o
>>   obj-$(CONFIG_CORESIGHT_TRBE) += coresight-trbe.o
>> +obj-$(CONFIG_CORESIGHT_TPDM) += coresight-tpdm.o
>>   coresight-cti-y := coresight-cti-core.o	coresight-cti-platform.o \
>>   		   coresight-cti-sysfs.o
>> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
>> index cc6b6cabf85f..a7f1a6f09cfb 100644
>> --- a/drivers/hwtracing/coresight/coresight-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-core.c
>> @@ -1071,7 +1071,8 @@ static int coresight_validate_source(struct coresight_device *csdev,
>>   	}
>>   
>>   	if (subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_PROC &&
>> -	    subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE) {
>> +	    subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE &&
>> +	    subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_SYS) {
>>   		dev_err(&csdev->dev, "wrong device subtype in %s\n", function);
>>   		return -EINVAL;
>>   	}
>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
>> new file mode 100644
>> index 000000000000..f494cef4fb24
>> --- /dev/null
>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
>> @@ -0,0 +1,152 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2021 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#include <linux/amba/bus.h>
>> +#include <linux/bitmap.h>
>> +#include <linux/coresight.h>
>> +#include <linux/device.h>
>> +#include <linux/err.h>
>> +#include <linux/fs.h>
>> +#include <linux/io.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/regulator/consumer.h>
>> +
>> +#include "coresight-priv.h"
>> +#include "coresight-tpdm.h"
>> +
>> +DEFINE_CORESIGHT_DEVLIST(tpdm_devs, "tpdm");
>> +
>> +static int tpdm_enable(struct coresight_device *csdev,
>> +		       struct perf_event *event, u32 mode)
>> +{
>> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>> +
>> +	mutex_lock(&drvdata->lock);
>> +	if (drvdata->enable) {
>> +		mutex_unlock(&drvdata->lock);
>> +		return -EBUSY;
>> +	}
>> +
>> +	drvdata->enable = true;
>> +	mutex_unlock(&drvdata->lock);
>> +
>> +	dev_info(drvdata->dev, "TPDM tracing enabled\n");
>> +	return 0;
>> +}
>> +
>> +static void tpdm_disable(struct coresight_device *csdev,
>> +			 struct perf_event *event)
>> +{
>> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>> +
>> +	mutex_lock(&drvdata->lock);
>> +	if (!drvdata->enable) {
>> +		mutex_unlock(&drvdata->lock);
>> +		return;
>> +	}
>> +
>> +	drvdata->enable = false;
>> +	mutex_unlock(&drvdata->lock);
>> +
>> +	dev_info(drvdata->dev, "TPDM tracing disabled\n");
>> +}
>> +
>> +static int tpdm_trace_id(struct coresight_device *csdev)
>> +{
>> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>> +
>> +	return drvdata->traceid;
>> +}
>> +
>> +static const struct coresight_ops_source tpdm_source_ops = {
>> +	.trace_id	= tpdm_trace_id,
>> +	.enable		= tpdm_enable,
>> +	.disable	= tpdm_disable,
>> +};
>> +
>> +static const struct coresight_ops tpdm_cs_ops = {
>> +	.source_ops	= &tpdm_source_ops,
>> +};
>> +
>> +static void tpdm_init_default_data(struct tpdm_drvdata *drvdata)
>> +{
>> +	static int traceid = TPDM_TRACE_ID_START;
>> +
>> +	drvdata->traceid = traceid++;
>> +}
> I have been specific on how to properly do this in the last revision.  Given the
> above about the MAINTAINERS file, I am not sure that I will continue reviewing this set.
>
> There is also no need to rush another revision as I won't have the bandwidth to
> process it before the holidays.
>
> Thanks,
> Mathieu

Hi Mathieu,

Sorry, not addressed your previous comments here.

For the trace id, each coresight component has 7 bits to store the trace 
id. So the trace id should be from 1 to 127 as 0 is invalid.

Apart from TPDMs/STM/ETMs, we also have other coresight components in 
our internal device. About 80 ids are already used.

Some components have fixed trace id in HW. If we use functions below to 
count the trace id, there will be conflict to other components.

Can we use 1-15 for etm trace ids  and 16 - 127 for other coresight 
components ? And handle trace ids in its' own driver ?


static inline int coresight_get_system_trace_id(int id)
{
         /* Start system IDs above the highest per CPU trace ID. */
         return coresigth_get_trace_id(cpumask_last(cpu_possible_mask) + 1);
}

static inline int coresight_get_trace_id(int cpu)
{
     /*
      * A trace ID of value 0 is invalid, so let's start at some
      * random value that fits in 7 bits and go from there.  Since
      * the common convention is to have data trace IDs be I(N) + 1,
      * set instruction trace IDs as a function of the CPU number.
      */
     return (CORESIGHT_ETM_PMU_SEED + (cpu * 2));
}

Thanks

Jinlong Mao

>> +
>> +static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
>> +{
>> +	struct device *dev = &adev->dev;
>> +	struct coresight_platform_data *pdata;
>> +	struct tpdm_drvdata *drvdata;
>> +	struct coresight_desc desc = { 0 };
>> +
>> +	desc.name = coresight_alloc_device_name(&tpdm_devs, dev);
>> +	if (!desc.name)
>> +		return -ENOMEM;
>> +	pdata = coresight_get_platform_data(dev);
>> +	if (IS_ERR(pdata))
>> +		return PTR_ERR(pdata);
>> +	adev->dev.platform_data = pdata;
>> +
>> +	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>> +	if (!drvdata)
>> +		return -ENOMEM;
>> +	drvdata->dev = &adev->dev;
>> +	dev_set_drvdata(dev, drvdata);
>> +
>> +	drvdata->base = devm_ioremap_resource(dev, &adev->res);
>> +	if (!drvdata->base)
>> +		return -ENOMEM;
>> +
>> +	mutex_init(&drvdata->lock);
>> +
>> +	desc.type = CORESIGHT_DEV_TYPE_SOURCE;
>> +	desc.subtype.source_subtype = CORESIGHT_DEV_SUBTYPE_SOURCE_SYS;
>> +	desc.ops = &tpdm_cs_ops;
>> +	desc.pdata = adev->dev.platform_data;
>> +	desc.dev = &adev->dev;
>> +	drvdata->csdev = coresight_register(&desc);
>> +	if (IS_ERR(drvdata->csdev))
>> +		return PTR_ERR(drvdata->csdev);
>> +
>> +	tpdm_init_default_data(drvdata);
>> +	pm_runtime_put(&adev->dev);
>> +
>> +	return 0;
>> +}
>> +
>> +static void __exit tpdm_remove(struct amba_device *adev)
>> +{
>> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(&adev->dev);
>> +
>> +	coresight_unregister(drvdata->csdev);
>> +}
>> +
>> +static struct amba_id tpdm_ids[] = {
>> +	{
>> +		.id = 0x000f0e00,
>> +		.mask = 0x000fff00,
>> +	},
>> +	{ 0, 0},
>> +};
>> +
>> +static struct amba_driver tpdm_driver = {
>> +	.drv = {
>> +		.name   = "coresight-tpdm",
>> +		.owner	= THIS_MODULE,
>> +		.suppress_bind_attrs = true,
>> +	},
>> +	.probe          = tpdm_probe,
>> +	.id_table	= tpdm_ids,
>> +};
>> +
>> +module_amba_driver(tpdm_driver);
>> +
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_DESCRIPTION("Trace, Profiling & Diagnostic Monitor driver");
>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
>> new file mode 100644
>> index 000000000000..980ae90ff1c8
>> --- /dev/null
>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.h
>> @@ -0,0 +1,31 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (c) 2021 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#ifndef _CORESIGHT_CORESIGHT_TPDM_H
>> +#define _CORESIGHT_CORESIGHT_TPDM_H
>> +
>> +/* Default value of the traceid */
>> +#define TPDM_TRACE_ID_START 128
>> +
>> +/**
>> + * struct tpdm_drvdata - specifics associated to an TPDM component
>> + * @base:       memory mapped base address for this component.
>> + * @dev:        The device entity associated to this component.
>> + * @csdev:      component vitals needed by the framework.
>> + * @lock:       lock for the enable value.
>> + * @enable:     enable status of the component.
>> + * @traceid:    value of the current ID for this component.
>> + */
>> +
>> +struct tpdm_drvdata {
>> +	void __iomem		*base;
>> +	struct device		*dev;
>> +	struct coresight_device	*csdev;
>> +	struct mutex		lock;
>> +	bool			enable;
>> +	int			traceid;
>> +};
>> +
>> +#endif  /* _CORESIGHT_CORESIGHT_TPDM_H */
>> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
>> index 93a2922b7653..e48d463be63b 100644
>> --- a/include/linux/coresight.h
>> +++ b/include/linux/coresight.h
>> @@ -65,6 +65,7 @@ enum coresight_dev_subtype_source {
>>   	CORESIGHT_DEV_SUBTYPE_SOURCE_PROC,
>>   	CORESIGHT_DEV_SUBTYPE_SOURCE_BUS,
>>   	CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE,
>> +	CORESIGHT_DEV_SUBTYPE_SOURCE_SYS,
>>   };
>>   
>>   enum coresight_dev_subtype_helper {
>> -- 
>> 2.17.1
>>
