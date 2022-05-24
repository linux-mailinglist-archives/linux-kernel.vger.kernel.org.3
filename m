Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D55532426
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 09:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235266AbiEXHeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 03:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235275AbiEXHc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 03:32:28 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477F25520B;
        Tue, 24 May 2022 00:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653377545; x=1684913545;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CzzSmeGX2kWdBh6NeYT7O0/RAmfBnBQM0c//KGmVU8I=;
  b=N7KhQ4U5lIrVduN2gB9cNd1h/bYxlhibSVVzNB90O5RJiKb0OWNJ45Vx
   fmOp38/zh/+yoy8YqBQW0pPT3/K/5K7IhTURe8WhBB+CWJF7FsRQlROCS
   yn9/O2MOmKSA0YWI1JONf0O5qhY/boOYjoBGKE/VnSVq2VOddhX45855c
   8=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 24 May 2022 00:32:24 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 00:32:24 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 24 May 2022 00:32:23 -0700
Received: from [10.239.133.9] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 24 May
 2022 00:32:19 -0700
Message-ID: <7cde3e83-8176-8391-77db-3ca400a90e91@quicinc.com>
Date:   Tue, 24 May 2022 15:32:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v7 07/10] Coresight: Add TPDA link driver
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>
CC:     Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20220509133947.20987-1-quic_jinlmao@quicinc.com>
 <20220509133947.20987-8-quic_jinlmao@quicinc.com>
 <362a330e-593a-edbc-4360-4573c97a1479@arm.com>
From:   Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <362a330e-593a-edbc-4360-4573c97a1479@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On 5/23/2022 5:40 PM, Suzuki K Poulose wrote:
> On 09/05/2022 14:39, Mao Jinlong wrote:
>> TPDA(Trace, Profiling and Diagnostics Aggregator) is
>> to provide packetization, funneling and timestamping of
>> TPDM data. Multiple monitors are connected to different
>> input ports of TPDA.This change is to add tpda
>> enable/disable/probe functions for coresight tpda driver.
>>
>>   - - - -         - - - -        - - - -
>> | TPDM 0|      | TPDM 1 |     | TPDM 2|
>>   - - - -         - - - -        - - - -
>>      |               |             |
>>      |_ _ _ _ _ _    |     _ _ _ _ |
>>                  |   |    |
>>                  |   |    |
>>             ------------------
>>            |        TPDA      |
>>             ------------------
>>
>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>> ---
>>   drivers/hwtracing/coresight/Kconfig          |  11 +
>>   drivers/hwtracing/coresight/Makefile         |   1 +
>>   drivers/hwtracing/coresight/coresight-tpda.c | 201 +++++++++++++++++++
>>   drivers/hwtracing/coresight/coresight-tpda.h |  33 +++
>>   4 files changed, 246 insertions(+)
>>   create mode 100644 drivers/hwtracing/coresight/coresight-tpda.c
>>   create mode 100644 drivers/hwtracing/coresight/coresight-tpda.h
>>
>> diff --git a/drivers/hwtracing/coresight/Kconfig 
>> b/drivers/hwtracing/coresight/Kconfig
>> index 5c506a1cd08f..447919565326 100644
>> --- a/drivers/hwtracing/coresight/Kconfig
>> +++ b/drivers/hwtracing/coresight/Kconfig
>> @@ -205,6 +205,7 @@ config CORESIGHT_TRBE
>>   config CORESIGHT_TPDM
>>       tristate "CoreSight Trace, Profiling & Diagnostics Monitor driver"
>>       select CORESIGHT_LINKS_AND_SINKS
>> +    select CORESIGHT_TPDA
>>       help
>>         This driver provides support for configuring monitor. 
>> Monitors are
>>         primarily responsible for data set collection and support the
>> @@ -214,4 +215,14 @@ config CORESIGHT_TPDM
>>         To compile this driver as a module, choose M here: the module 
>> will be
>>         called coresight-tpdm.
>>   +config CORESIGHT_TPDA
>> +    tristate "CoreSight Trace, Profiling & Diagnostics Aggregator 
>> driver"
>> +    help
>> +      This driver provides support for configuring aggregator. This is
>> +      primarily useful for pulling the data sets from one or more
>> +      attached monitors and pushing the resultant data out. Multiple
>> +      monitors are connected on different input ports of TPDA.
>> +
>> +      To compile this driver as a module, choose M here: the module 
>> will be
>> +      called coresight-tpda.
>>   endif
>> diff --git a/drivers/hwtracing/coresight/Makefile 
>> b/drivers/hwtracing/coresight/Makefile
>> index 6bb9b1746bc7..1712d82e7260 100644
>> --- a/drivers/hwtracing/coresight/Makefile
>> +++ b/drivers/hwtracing/coresight/Makefile
>> @@ -26,5 +26,6 @@ obj-$(CONFIG_CORESIGHT_CATU) += coresight-catu.o
>>   obj-$(CONFIG_CORESIGHT_CTI) += coresight-cti.o
>>   obj-$(CONFIG_CORESIGHT_TRBE) += coresight-trbe.o
>>   obj-$(CONFIG_CORESIGHT_TPDM) += coresight-tpdm.o
>> +obj-$(CONFIG_CORESIGHT_TPDA) += coresight-tpda.o
>>   coresight-cti-y := coresight-cti-core.o coresight-cti-platform.o \
>>              coresight-cti-sysfs.o
>> diff --git a/drivers/hwtracing/coresight/coresight-tpda.c 
>> b/drivers/hwtracing/coresight/coresight-tpda.c
>> new file mode 100644
>> index 000000000000..126286e89679
>> --- /dev/null
>> +++ b/drivers/hwtracing/coresight/coresight-tpda.c
>> @@ -0,0 +1,201 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights 
>> reserved.
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
>> +#include <linux/platform_device.h>
>> +
>> +#include "coresight-priv.h"
>> +#include "coresight-tpda.h"
>> +#include "coresight-trace-id.h"
>> +
>> +DEFINE_CORESIGHT_DEVLIST(tpda_devs, "tpda");
>> +
>> +/* Settings pre enabling port control register */
>> +static void tpda_enable_pre_port(struct tpda_drvdata *drvdata)
>> +{
>> +    u32 val;
>> +
>> +    val = readl_relaxed(drvdata->base + TPDA_CR);
>> +    /* Bits 6 ~ 12 is for atid value */
>
> minor nit, please could we use FIELD_PREP() and define the
> ATID field in the TPDA_CR accordingly ?
I will check and update.
>
>> +    val |= (drvdata->atid << 6)
>
> then we could have :
>
>     val |= FIELD_PREP(TPDA_CR_ATID, drvdata->atid);
>
>> +    writel_relaxed(val, drvdata->base + TPDA_CR);
>> +}
>> +
>> +static void tpda_enable_port(struct tpda_drvdata *drvdata, int port)
>> +{
>> +    u32 val;
>> +
>> +    val = readl_relaxed(drvdata->base + TPDA_Pn_CR(port));
>> +    /* Enable the port */
>> +    val |= TPDA_Pn_CR_ENA;
>> +    writel_relaxed(val, drvdata->base + TPDA_Pn_CR(port));
>> +}
>> +
>> +static void _tpda_enable(struct tpda_drvdata *drvdata, int port)
>
> minor nit: Similar to the tpdm, comment please use 
> __tpda_{enable,disable}()
I will address this.
>
>> +{
>> +    CS_UNLOCK(drvdata->base);
>> +
>> +    if (!drvdata->enable)
>> +        tpda_enable_pre_port(drvdata);
>> +
>> +    tpda_enable_port(drvdata, port);
>> +
>> +    CS_LOCK(drvdata->base);
>> +}
>> +
>> +static int tpda_enable(struct coresight_device *csdev, int inport, 
>> int outport)
>> +{
>> +    struct tpda_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>> +
>> +    mutex_lock(&drvdata->lock);
>> +    _tpda_enable(drvdata, inport);
>> +    drvdata->enable = true;
>
> I am wondering if this is good enough ? Do we need a refcount ?
> e.g, multiple TPDMs could be enabled independently and disabled
> indpendently. And the tpda must stay alive until the last "source"
> is gone away ?
it makes sense.
>
>> +    mutex_unlock(&drvdata->lock);
>> +
>> +    dev_info(drvdata->dev, "TPDA inport %d enabled\n", inport);
>> +    return 0;
>> +}
>> +
>> +static void _tpda_disable(struct tpda_drvdata *drvdata, int port)
>> +{
>> +    u32 val;
>> +
>> +    CS_UNLOCK(drvdata->base);
>> +
>> +    val = readl_relaxed(drvdata->base + TPDA_Pn_CR(port));
>> +    val &= ~TPDA_Pn_CR_ENA;
>> +    writel_relaxed(val, drvdata->base + TPDA_Pn_CR(port));
>> +
>> +    CS_LOCK(drvdata->base);
>> +}
>> +
>> +static void tpda_disable(struct coresight_device *csdev, int inport,
>> +               int outport)
>> +{
>> +    struct tpda_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>> +
>> +    mutex_lock(&drvdata->lock);
>> +    _tpda_disable(drvdata, inport);
>> +    drvdata->enable = false;
>
> This is not sufficient. We need to make sure the TPDA has a refcount of
> the enabled ports.
I will update.
>
>> +    mutex_unlock(&drvdata->lock);
>> +
>> +    dev_info(drvdata->dev, "TPDA inport %d disabled\n", inport);
>> +}
>> +
>> +static const struct coresight_ops_link tpda_link_ops = {
>> +    .enable        = tpda_enable,
>> +    .disable    = tpda_disable,
>> +};
>> +
>> +static const struct coresight_ops tpda_cs_ops = {
>> +    .link_ops    = &tpda_link_ops,
>> +};
>> +
>> +static int tpda_init_default_data(struct tpda_drvdata *drvdata)
>> +{
>> +    int atid;
>> +    /*
>> +     * TPDA must has a unique atid. This atid can uniquely
>> +     * identify the TPDM trace source connect to the TPDA.
>
> nit: s/connect/connected/
>
> Also how do we identify the different TPDM sources
> connected using a single atid ? Looking at the patch description
> it is possible to have multiple TPDMs connected to a single TPDA.
>
>> +     */
>> +    atid = 
>> coresight_trace_id_get_system_id(coresight_get_trace_id_map());
>> +    if (atid < 0)
>> +        return atid;
>> +
>> +    drvdata->atid = atid;
>> +    return 0;
>> +}
>> +
>> +static int tpda_probe(struct amba_device *adev, const struct amba_id 
>> *id)
>> +{
>> +    int ret;
>> +    struct device *dev = &adev->dev;
>> +    struct coresight_platform_data *pdata;
>> +    struct tpda_drvdata *drvdata;
>> +    struct coresight_desc desc = { 0 };
>> +
>> +    pdata = coresight_get_platform_data(dev);
>> +    if (IS_ERR(pdata))
>> +        return PTR_ERR(pdata);
>> +    adev->dev.platform_data = pdata;
>> +
>> +    drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>> +    if (!drvdata)
>> +        return -ENOMEM;
>> +
>> +    drvdata->dev = &adev->dev;
>> +    dev_set_drvdata(dev, drvdata);
>> +
>> +    drvdata->base = devm_ioremap_resource(dev, &adev->res);
>> +    if (!drvdata->base)
>> +        return -ENOMEM;
>> +
>> +    mutex_init(&drvdata->lock);
>> +
>> +    ret = tpda_init_default_data(drvdata);
>> +    if (ret)
>> +        return ret;
>> +
>> +    desc.name = coresight_alloc_device_name(&tpda_devs, dev);
>> +    if (!desc.name)
>> +        return -ENOMEM;
>> +    desc.type = CORESIGHT_DEV_TYPE_LINK;
>> +    desc.subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_MERG;
>> +    desc.ops = &tpda_cs_ops;
>> +    desc.pdata = adev->dev.platform_data;
>> +    desc.dev = &adev->dev;
>
> desc.access must be initialised.
I will address it.
>
>> +    drvdata->csdev = coresight_register(&desc);
>> +    if (IS_ERR(drvdata->csdev))
>> +        return PTR_ERR(drvdata->csdev);
>> +
>> +    pm_runtime_put(&adev->dev);
>> +
>> +    dev_dbg(drvdata->dev, "TPDA initialized\n");
>> +    return 0;
>> +}
>> +
>> +static void __exit tpda_remove(struct amba_device *adev)
>> +{
>> +    struct tpda_drvdata *drvdata = dev_get_drvdata(&adev->dev);
>> +
>> +    coresight_unregister(drvdata->csdev);
>> +}
>> +
>> +/*
>> + * Different TPDA has different periph id.
>> + * The difference is 0-7 bits' value. So ignore 0-7 bits.
>> + */
>> +static struct amba_id tpda_ids[] = {
>> +    {
>> +        .id     = 0x000f0f00,
>> +        .mask   = 0x000fff00,
>> +    },
>> +    { 0, 0},
>> +};
>> +
>> +static struct amba_driver tpda_driver = {
>> +    .drv = {
>> +        .name   = "coresight-tpda",
>> +        .owner    = THIS_MODULE,
>> +        .suppress_bind_attrs = true,
>> +    },
>> +    .probe          = tpda_probe,
>> +    .remove        = tpda_remove,
>> +    .id_table    = tpda_ids,
>> +};
>> +
>> +module_amba_driver(tpda_driver);
>> +
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_DESCRIPTION("Trace, Profiling & Diagnostic Aggregator driver");
>> diff --git a/drivers/hwtracing/coresight/coresight-tpda.h 
>> b/drivers/hwtracing/coresight/coresight-tpda.h
>> new file mode 100644
>> index 000000000000..6df1b72b3b76
>> --- /dev/null
>> +++ b/drivers/hwtracing/coresight/coresight-tpda.h
>> @@ -0,0 +1,33 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights 
>> reserved.
>> + */
>> +
>> +#ifndef _CORESIGHT_CORESIGHT_TPDA_H
>> +#define _CORESIGHT_CORESIGHT_TPDA_H
>> +
>> +#define TPDA_CR            (0x000)
>> +#define TPDA_Pn_CR(n)        (0x004 + (n * 4))
>> +/* Aggregator port enable bit */
>> +#define TPDA_Pn_CR_ENA        BIT(0)
>> +
>> +#define TPDA_MAX_INPORTS    32
>
> Please add the bit fields for  TPDA_CR_ATID here and use
> the FIELD_PREP()
>
> #define TPDA_CR_ATID            GENMASK(12, 6)
I will check and update.
>
>> +
>> +/**
>> + * struct tpda_drvdata - specifics associated to an TPDA component
>> + * @base:       memory mapped base address for this component.
>> + * @dev:        The device entity associated to this component.
>> + * @csdev:      component vitals needed by the framework.
>> + * @lock:       lock for the enable value.
>> + * @enable:     enable status of the component.
>> + */
>> +struct tpda_drvdata {
>> +    void __iomem        *base;
>> +    struct device        *dev;
>> +    struct coresight_device    *csdev;
>> +    struct mutex        lock;
>
> Why mutex and not spinlock ?

Same as tpdm.

1. There is no irq for TPDA
2. There will be many registers to configure during enable/disable which 
may cause
some time.
>
>> +    bool            enable;
>> +    u32            atid;
>
>     u8 atid ?
I will check.
>
>
> Suzuki
