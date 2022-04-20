Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13618508AF7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 16:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379747AbiDTOqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 10:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344885AbiDTOqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 10:46:17 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7012F2C64D;
        Wed, 20 Apr 2022 07:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650465810; x=1682001810;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ii4uzgy/fOsx88TZkK6pUnYdS+9T50Wpu5glELakSwc=;
  b=CnWqqT7RFhgfCthQEia89RkDVnA9NO+NOeurML71+iKBQJkxEKGnRMj+
   TvsO0RlXEPzpDfG+bz8JcHx6iwP+N4T3NWUWTvCFEg8P73fJUElAwNRgT
   OFITHwpp038iIiJepHBz3P2KWcgreS/n48rsi+FCFA8+fYHBW/yfCQTF5
   U=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 20 Apr 2022 07:43:30 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 07:43:29 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 20 Apr 2022 07:43:29 -0700
Received: from [10.239.133.9] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 20 Apr
 2022 07:43:26 -0700
Message-ID: <45cfcd4a-305b-0143-fb78-5d71b89858a0@quicinc.com>
Date:   Wed, 20 Apr 2022 22:43:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v5 07/10] Coresight: Add TPDA link driver
Content-Language: en-US
To:     Mike Leach <mike.leach@linaro.org>
CC:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>
References: <20220412125035.40312-1-quic_jinlmao@quicinc.com>
 <20220412125035.40312-8-quic_jinlmao@quicinc.com>
 <CAJ9a7VjL2JioFUJVF_z5+R3rdBw6ptcc3ufed+=GM5MH_0PLZg@mail.gmail.com>
From:   Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <CAJ9a7VjL2JioFUJVF_z5+R3rdBw6ptcc3ufed+=GM5MH_0PLZg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On 4/19/2022 5:51 PM, Mike Leach wrote:
> Hi
>
> On Tue, 12 Apr 2022 at 13:51, Mao Jinlong <quic_jinlmao@quicinc.com> wrote:
>> TPDA(Trace, Profiling and Diagnostics Aggregator) is
>> to provide packetization, funneling and timestamping of
>> TPDM data. Multiple monitors are connected to different
>> input ports of TPDA.This change is to add tpda
>> enable/disable/probe functions for coresight tpda driver.
>>
>>   - - - -         - - - -        - - - -
>> | TPDM 0|      | TPDM 1 |     | TPDM 2|
>>   - - - -         - - - -        - - - -
>>      |               |             |
>>      |_ _ _ _ _ _    |     _ _ _ _ |
>>                  |   |    |
>>                  |   |    |
>>             ------------------
>>            |        TPDA      |
>>             ------------------
>>
>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>> ---
>>   drivers/hwtracing/coresight/Kconfig          |  11 ++
>>   drivers/hwtracing/coresight/Makefile         |   1 +
>>   drivers/hwtracing/coresight/coresight-tpda.c | 192 +++++++++++++++++++
>>   drivers/hwtracing/coresight/coresight-tpda.h |  32 ++++
>>   4 files changed, 236 insertions(+)
>>   create mode 100644 drivers/hwtracing/coresight/coresight-tpda.c
>>   create mode 100644 drivers/hwtracing/coresight/coresight-tpda.h
>>
>> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
>> index 60248fef4089..317c5e7f4819 100644
>> --- a/drivers/hwtracing/coresight/Kconfig
>> +++ b/drivers/hwtracing/coresight/Kconfig
>> @@ -223,4 +223,15 @@ config CORESIGHT_TPDM_INTEGRATION_TEST
>>            operation to facilitate integration testing and software bringup
>>            and/or to instrument topology discovery. The TPDM utilizes integration
>>            mode to accomplish integration testing and software bringup.
>> +
>> +config CORESIGHT_TPDA
>> +       tristate "CoreSight Trace, Profiling & Diagnostics Aggregator driver"
>> +       help
>> +         This driver provides support for configuring aggregator. This is
>> +         primarily useful for pulling the data sets from one or more
>> +         attached monitors and pushing the resultant data out. Multiple
>> +         monitors are connected on different input ports of TPDA.
>> +
>> +         To compile this driver as a module, choose M here: the module will be
>> +         called coresight-tpda.
>>   endif
> TDPA / TDPM are functionally linked - it does not make sense to
> configure one without the other.
> Kernel configuration should reflect this - as a minimum TDPM
> configuration should select TDPA.
>
>
>
>> diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
>> index 6bb9b1746bc7..1712d82e7260 100644
>> --- a/drivers/hwtracing/coresight/Makefile
>> +++ b/drivers/hwtracing/coresight/Makefile
>> @@ -26,5 +26,6 @@ obj-$(CONFIG_CORESIGHT_CATU) += coresight-catu.o
>>   obj-$(CONFIG_CORESIGHT_CTI) += coresight-cti.o
>>   obj-$(CONFIG_CORESIGHT_TRBE) += coresight-trbe.o
>>   obj-$(CONFIG_CORESIGHT_TPDM) += coresight-tpdm.o
>> +obj-$(CONFIG_CORESIGHT_TPDA) += coresight-tpda.o
>>   coresight-cti-y := coresight-cti-core.o        coresight-cti-platform.o \
>>                     coresight-cti-sysfs.o
>> diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/hwtracing/coresight/coresight-tpda.c
>> new file mode 100644
>> index 000000000000..9519990c68e2
>> --- /dev/null
>> +++ b/drivers/hwtracing/coresight/coresight-tpda.c
>> @@ -0,0 +1,192 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
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
>> +       u32 val;
>> +
>> +       val = readl_relaxed(drvdata->base + TPDA_CR);
>> +       val |= (drvdata->atid << 6);
>> +       writel_relaxed(val, drvdata->base + TPDA_CR);
>> +}
>> +
>> +static void tpda_enable_port(struct tpda_drvdata *drvdata, int port)
>> +{
>> +       u32 val;
>> +
>> +       val = readl_relaxed(drvdata->base + TPDA_Pn_CR(port));
>> +       /* Enable the port */
>> +       val = val | BIT(0);
> #define a constant in the header to use here.
I will update it.
>
>> +       writel_relaxed(val, drvdata->base + TPDA_Pn_CR(port));
>> +}
>> +
>> +static void _tpda_enable(struct tpda_drvdata *drvdata, int port)
>> +{
>> +       CS_UNLOCK(drvdata->base);
>> +
>> +       if (!drvdata->enable)
>> +               tpda_enable_pre_port(drvdata);
>> +
>> +       tpda_enable_port(drvdata, port);
>> +
>> +       CS_LOCK(drvdata->base);
>> +}
>> +
>> +static int tpda_enable(struct coresight_device *csdev, int inport, int outport)
>> +{
>> +       struct tpda_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>> +
>> +       mutex_lock(&drvdata->lock);
>> +       _tpda_enable(drvdata, inport);
>> +       drvdata->enable = true;
>> +       mutex_unlock(&drvdata->lock);
>> +
>> +       dev_info(drvdata->dev, "TPDA inport %d enabled\n", inport);
>> +       return 0;
>> +}
>> +
>> +static void _tpda_disable(struct tpda_drvdata *drvdata, int port)
>> +{
>> +       u32 val;
>> +
>> +       CS_UNLOCK(drvdata->base);
>> +
>> +       val = readl_relaxed(drvdata->base + TPDA_Pn_CR(port));
>> +       val = val & ~BIT(0);
> use a #defined constant.
>
>> +       writel_relaxed(val, drvdata->base + TPDA_Pn_CR(port));
>> +
>> +       CS_LOCK(drvdata->base);
>> +}
>> +
>> +static void tpda_disable(struct coresight_device *csdev, int inport,
>> +                          int outport)
>> +{
>> +       struct tpda_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>> +
>> +       mutex_lock(&drvdata->lock);
>> +       _tpda_disable(drvdata, inport);
>> +       drvdata->enable = false;
>> +       mutex_unlock(&drvdata->lock);
>> +
>> +       dev_info(drvdata->dev, "TPDA inport %d disabled\n", inport);
>> +}
>> +
>> +static const struct coresight_ops_link tpda_link_ops = {
>> +       .enable         = tpda_enable,
>> +       .disable        = tpda_disable,
>> +};
>> +
>> +static const struct coresight_ops tpda_cs_ops = {
>> +       .link_ops       = &tpda_link_ops,
>> +};
>> +
>> +static int tpda_init_default_data(struct tpda_drvdata *drvdata)
>> +{
>> +       int atid;
>> +       /*
>> +        * TPDA must has a unique atid. This atid can uniquely
>> +        * identify the TPDM trace source connect to the TPDA.
>> +        */
>> +       atid = coresight_trace_id_get_system_id(coresight_get_trace_id_map());
>> +       if (atid < 0)
>> +               return atid;
>> +
>> +       drvdata->atid = atid;
>> +       return 0;
>> +}
>> +
>> +static int tpda_probe(struct amba_device *adev, const struct amba_id *id)
>> +{
>> +       int ret;
>> +       struct device *dev = &adev->dev;
>> +       struct coresight_platform_data *pdata;
>> +       struct tpda_drvdata *drvdata;
>> +       struct coresight_desc desc = { 0 };
>> +
>> +       pdata = coresight_get_platform_data(dev);
>> +       if (IS_ERR(pdata))
>> +               return PTR_ERR(pdata);
>> +       adev->dev.platform_data = pdata;
>> +
>> +       drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>> +       if (!drvdata)
>> +               return -ENOMEM;
>> +
>> +       drvdata->dev = &adev->dev;
>> +       dev_set_drvdata(dev, drvdata);
>> +
>> +       drvdata->base = devm_ioremap_resource(dev, &adev->res);
>> +       if (!drvdata->base)
>> +               return -ENOMEM;
>> +
>> +       mutex_init(&drvdata->lock);
>> +
>> +       ret = tpda_init_default_data(drvdata);
>> +       if (ret)
>> +               return ret;
>> +
>> +       desc.name = coresight_alloc_device_name(&tpda_devs, dev);
>> +       if (!desc.name)
>> +               return -ENOMEM;
>> +       desc.type = CORESIGHT_DEV_TYPE_LINK;
>> +       desc.subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_MERG;
>> +       desc.ops = &tpda_cs_ops;
>> +       desc.pdata = adev->dev.platform_data;
>> +       desc.dev = &adev->dev;
>> +       drvdata->csdev = coresight_register(&desc);
>> +       if (IS_ERR(drvdata->csdev))
>> +               return PTR_ERR(drvdata->csdev);
>> +
>> +       pm_runtime_put(&adev->dev);
>> +
>> +       dev_dbg(drvdata->dev, "TPDA initialized\n");
>> +       return 0;
>> +}
>> +
>> +/*
>> + * Different TPDA has different periph id.
>> + * The difference is 0-7 bits' value. So ignore 0-7 bits.
>> + */
>> +static struct amba_id tpda_ids[] = {
>> +       {
>> +               .id     = 0x000f0f00,
>> +               .mask   = 0x000fff00,
>> +       },
>> +       { 0, 0},
>> +};
>> +
>> +static struct amba_driver tpda_driver = {
>> +       .drv = {
>> +               .name   = "coresight-tpda",
>> +               .owner  = THIS_MODULE,
>> +               .suppress_bind_attrs = true,
>> +       },
>> +       .probe          = tpda_probe,
>> +       .id_table       = tpda_ids,
>> +};
>> +
> There is no code to release resources when this module is unloaded.
> You need a .remove function, that as a minimum calls
> coresight_unregister().
>
> Regards
>
> Mike
Yes. Need add remove function for tpda driver.
>
>> +module_amba_driver(tpda_driver);
>> +
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_DESCRIPTION("Trace, Profiling & Diagnostic Aggregator driver");
>> diff --git a/drivers/hwtracing/coresight/coresight-tpda.h b/drivers/hwtracing/coresight/coresight-tpda.h
>> new file mode 100644
>> index 000000000000..6ac33b9c1ea4
>> --- /dev/null
>> +++ b/drivers/hwtracing/coresight/coresight-tpda.h
>> @@ -0,0 +1,32 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#ifndef _CORESIGHT_CORESIGHT_TPDA_H
>> +#define _CORESIGHT_CORESIGHT_TPDA_H
>> +
>> +#define TPDA_CR                        (0x000)
>> +#define TPDA_Pn_CR(n)          (0x004 + (n * 4))
>> +
>> +#define TPDA_MAX_INPORTS       32
>> +
>> +/**
>> + * struct tpda_drvdata - specifics associated to an TPDA component
>> + * @base:       memory mapped base address for this component.
>> + * @dev:        The device entity associated to this component.
>> + * @csdev:      component vitals needed by the framework.
>> + * @lock:       lock for the enable value.
>> + * @enable:     enable status of the component.
>> + * @traceid:    trace source identification for the data packet by TPDA.
>> + */
>> +struct tpda_drvdata {
>> +       void __iomem            *base;
>> +       struct device           *dev;
>> +       struct coresight_device *csdev;
>> +       struct mutex            lock;
>> +       bool                    enable;
>> +       u32                     atid;
>> +};
>> +
>> +#endif  /* _CORESIGHT_CORESIGHT_TPDA_H */
>> --
>> 2.17.1
>>
>
> --
> Mike Leach
> Principal Engineer, ARM Ltd.
> Manchester Design Centre. UK
