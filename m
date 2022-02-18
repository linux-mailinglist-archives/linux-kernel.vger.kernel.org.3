Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8494BBD11
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 17:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237513AbiBRQKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 11:10:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237506AbiBRQKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 11:10:46 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38158106114
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:10:29 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id x5so10538967wrg.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mksSfWyE4AgHu3cecrzistClTS4cZGtWRnbiCsAgXHU=;
        b=UQk9R7B/GVCAbhqSzFCLT4eQ9jDsoMBN/C/2eQjWaC/doTQr/cB9NACZk/P9r/hicH
         7cxjGSsMaQUCcFfo0uFqOOWdpM2VJ+kZWSooFi+/HhM1bCZsRrpqnmJ3Qh3FlAQVVZBi
         b2EBi+YBXz/ba2r9ssjHSP5Gmx4CwHmjVZCaeyITYvmug+k+AkvJEXBgS1zrK9eL8Yrq
         qME2/GZ1U2+pTMW11O95d0i7ELN0jR62SUQ1zB4/DgqpgzKwF72WN2uc8c61+WTKEP3H
         q7qU0cQ3bgvKCeKTqYLCeqz7TRJNpYTHmGmqRg5lCzeQAWd/pSlo9hriS4r3dSfrZuUP
         MQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mksSfWyE4AgHu3cecrzistClTS4cZGtWRnbiCsAgXHU=;
        b=D7gnDqcdPZEsODExHqepOOG88rofgt03rYN9C0byeB/YG+k8Ioeri58WyEOOAceQtA
         ZwNpsmfp/WUc/jWIhtPaV9NZWZqYJCdE4fKD/t0eSkNLeAwn4TnsKUmzHBytdkp0kLe3
         wQwGAlhSBsUUgWYQ/M6N1qeRUDoGYiGqnGRdhCo5q1fKMGy/BWHQwbJbztB0ojIdSqG4
         V+qUnl8Q3+txDcx7FvApUHayZkXTskG3FkBz6v3qDvws6LY18idmD9lARKIuTrGSzvkN
         K6XnOjLeJ6xjNA6pgOM+pAD80nno5ejTqg3yme+VaIh8tinWMDxN1FbifbhgITWg55So
         oy8Q==
X-Gm-Message-State: AOAM531nKYsZyhU3rvg6COWX8apZK2uBMlEOFeKW01hGf2TAC6LJaARP
        jJllAUz4d4boYm1kN0VdOuSsIA1/At5zUMHlfdkXSQ==
X-Google-Smtp-Source: ABdhPJxSKsbxiIZwVoO3YP1pa0P5/veOsZtSe1n4t1m6YKrfDXsZHkJhQAL94UQmL9tqJfUGqE9ZIOlygsGppBkje7Y=
X-Received: by 2002:a5d:4e50:0:b0:1e3:c2c:979f with SMTP id
 r16-20020a5d4e50000000b001e30c2c979fmr6679547wrt.699.1645200627697; Fri, 18
 Feb 2022 08:10:27 -0800 (PST)
MIME-Version: 1.0
References: <20220209105706.18852-1-quic_jinlmao@quicinc.com> <20220209105706.18852-4-quic_jinlmao@quicinc.com>
In-Reply-To: <20220209105706.18852-4-quic_jinlmao@quicinc.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Fri, 18 Feb 2022 16:10:16 +0000
Message-ID: <CAJ9a7VgvmNh5hCcr=vTB+ZA=ni=XBgS=4EqBobXxFaFLiDhQng@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] Coresight: Add coresight TPDM source driver
To:     Mao Jinlong <quic_jinlmao@quicinc.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI,

On Wed, 9 Feb 2022 at 10:57, Mao Jinlong <quic_jinlmao@quicinc.com> wrote:
>
> Add driver to support Coresight device TPDM (Trace, Profiling and
> Diagnostics Monitor). TPDM is a monitor to collect data from
> different datasets. This change is to add probe/enable/disable
> functions for tpdm source.
>
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>  drivers/hwtracing/coresight/Kconfig          |  13 ++
>  drivers/hwtracing/coresight/Makefile         |   1 +
>  drivers/hwtracing/coresight/coresight-core.c |   3 +-
>  drivers/hwtracing/coresight/coresight-tpdm.c | 159 +++++++++++++++++++
>  drivers/hwtracing/coresight/coresight-tpdm.h |  28 ++++
>  include/linux/coresight.h                    |   1 +
>  6 files changed, 204 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/hwtracing/coresight/coresight-tpdm.c
>  create mode 100644 drivers/hwtracing/coresight/coresight-tpdm.h
>
> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
> index 514a9b8086e3..5c506a1cd08f 100644
> --- a/drivers/hwtracing/coresight/Kconfig
> +++ b/drivers/hwtracing/coresight/Kconfig
> @@ -201,4 +201,17 @@ config CORESIGHT_TRBE
>
>           To compile this driver as a module, choose M here: the module will be
>           called coresight-trbe.
> +
> +config CORESIGHT_TPDM
> +       tristate "CoreSight Trace, Profiling & Diagnostics Monitor driver"
> +       select CORESIGHT_LINKS_AND_SINKS
> +       help
> +         This driver provides support for configuring monitor. Monitors are
> +         primarily responsible for data set collection and support the
> +         ability to collect any permutation of data set types. Monitors are
> +         also responsible for interaction with system cross triggering.
> +
> +         To compile this driver as a module, choose M here: the module will be
> +         called coresight-tpdm.
> +
>  endif
> diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
> index b6c4a48140ec..e7392a0dddeb 100644
> --- a/drivers/hwtracing/coresight/Makefile
> +++ b/drivers/hwtracing/coresight/Makefile
> @@ -25,5 +25,6 @@ obj-$(CONFIG_CORESIGHT_CPU_DEBUG) += coresight-cpu-debug.o
>  obj-$(CONFIG_CORESIGHT_CATU) += coresight-catu.o
>  obj-$(CONFIG_CORESIGHT_CTI) += coresight-cti.o
>  obj-$(CONFIG_CORESIGHT_TRBE) += coresight-trbe.o
> +obj-$(CONFIG_CORESIGHT_TPDM) += coresight-tpdm.o
>  coresight-cti-y := coresight-cti-core.o        coresight-cti-platform.o \
>                    coresight-cti-sysfs.o
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 6cb55c3f41d5..b56826d9a2b3 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -1117,7 +1117,8 @@ static int coresight_validate_source(struct coresight_device *csdev,
>         }
>
>         if (subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_PROC &&
> -           subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE) {
> +           subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE &&
> +           subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_SYS) {
>                 dev_err(&csdev->dev, "wrong device subtype in %s\n", function);
>                 return -EINVAL;
>         }
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
> new file mode 100644
> index 000000000000..51b8b17e6a80
> --- /dev/null
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
> @@ -0,0 +1,159 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/amba/bus.h>
> +#include <linux/bitmap.h>
> +#include <linux/coresight.h>
> +#include <linux/coresight-pmu.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/fs.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +
> +#include "coresight-priv.h"
> +#include "coresight-tpdm.h"
> +
> +DEFINE_CORESIGHT_DEVLIST(tpdm_devs, "tpdm");
> +
> +/* TPDM enable operations */
> +static int tpdm_enable(struct coresight_device *csdev,
> +                      struct perf_event *event, u32 mode)
> +{
> +       struct tpdm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +
> +       mutex_lock(&drvdata->lock);
> +       if (drvdata->enable) {
> +               mutex_unlock(&drvdata->lock);
> +               return -EBUSY;
> +       }
> +
> +       drvdata->enable = true;
> +       mutex_unlock(&drvdata->lock);
> +
> +       dev_info(drvdata->dev, "TPDM tracing enabled\n");
> +       return 0;
> +}
> +
> +/* TPDM disable operations */
> +static void tpdm_disable(struct coresight_device *csdev,
> +                        struct perf_event *event)
> +{
> +       struct tpdm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +
> +       mutex_lock(&drvdata->lock);
> +       if (!drvdata->enable) {
> +               mutex_unlock(&drvdata->lock);
> +               return;
> +       }
> +
> +       drvdata->enable = false;
> +       mutex_unlock(&drvdata->lock);
> +
> +       dev_info(drvdata->dev, "TPDM tracing disabled\n");
> +}
> +
> +static int tpdm_trace_id(struct coresight_device *csdev)
> +{
> +       struct tpdm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +
> +       return drvdata->traceid;
> +}
> +
> +static const struct coresight_ops_source tpdm_source_ops = {
> +       .trace_id       = tpdm_trace_id,
> +       .enable         = tpdm_enable,
> +       .disable        = tpdm_disable,
> +};
> +
> +static const struct coresight_ops tpdm_cs_ops = {
> +       .source_ops     = &tpdm_source_ops,
> +};
> +
> +static void tpdm_init_default_data(struct tpdm_drvdata *drvdata)
> +{
> +       drvdata->traceid = coresight_get_system_trace_id();
> +}
> +
> +static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
> +{
> +       struct device *dev = &adev->dev;
> +       struct coresight_platform_data *pdata;
> +       struct tpdm_drvdata *drvdata;
> +       struct coresight_desc desc = { 0 };
> +
> +       pdata = coresight_get_platform_data(dev);
> +       if (IS_ERR(pdata))
> +               return PTR_ERR(pdata);
> +       adev->dev.platform_data = pdata;
> +
> +       /* driver data*/
> +       drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
> +       if (!drvdata)
> +               return -ENOMEM;
> +       drvdata->dev = &adev->dev;
> +       dev_set_drvdata(dev, drvdata);
> +
> +       drvdata->base = devm_ioremap_resource(dev, &adev->res);
> +       if (!drvdata->base)
> +               return -ENOMEM;
> +
> +       mutex_init(&drvdata->lock);
> +       tpdm_init_default_data(drvdata);
> +
> +       /* Set up coresight component description */
> +       desc.name = coresight_alloc_device_name(&tpdm_devs, dev);
> +       if (!desc.name)
> +               return -ENOMEM;
> +       desc.type = CORESIGHT_DEV_TYPE_SOURCE;
> +       desc.subtype.source_subtype = CORESIGHT_DEV_SUBTYPE_SOURCE_SYS;
> +       desc.ops = &tpdm_cs_ops;
> +       desc.pdata = adev->dev.platform_data;
> +       desc.dev = &adev->dev;
> +       drvdata->csdev = coresight_register(&desc);
> +       if (IS_ERR(drvdata->csdev))
> +               return PTR_ERR(drvdata->csdev);
> +
> +       /* Decrease pm refcount when probe is done.*/
> +       pm_runtime_put(&adev->dev);
> +
> +       return 0;
> +}
> +
> +static void __exit tpdm_remove(struct amba_device *adev)
> +{
> +       struct tpdm_drvdata *drvdata = dev_get_drvdata(&adev->dev);
> +
> +       coresight_unregister(drvdata->csdev);
> +}
> +
> +/*
> + * Different TPDM has different periph id.
> + * The difference is 0-7 bits' value. So ignore 0-7 bits.
> + */
> +static struct amba_id tpdm_ids[] = {
> +       {
> +               .id = 0x000f0e00,
> +               .mask = 0x000fff00,
> +       },
> +       { 0, 0},
> +};
> +
> +static struct amba_driver tpdm_driver = {
> +       .drv = {
> +               .name   = "coresight-tpdm",
> +               .owner  = THIS_MODULE,
> +               .suppress_bind_attrs = true,
> +       },
> +       .probe          = tpdm_probe,
> +       .id_table       = tpdm_ids,
> +};
> +
> +module_amba_driver(tpdm_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Trace, Profiling & Diagnostic Monitor driver");
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
> new file mode 100644
> index 000000000000..2effbabf349b
> --- /dev/null
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#ifndef _CORESIGHT_CORESIGHT_TPDM_H
> +#define _CORESIGHT_CORESIGHT_TPDM_H
> +
> +/**
> + * struct tpdm_drvdata - specifics associated to an TPDM component
> + * @base:       memory mapped base address for this component.
> + * @dev:        The device entity associated to this component.
> + * @csdev:      component vitals needed by the framework.
> + * @lock:       lock for the enable value.
> + * @enable:     enable status of the component.
> + * @traceid:    value of the current ID for this component.
> + */
> +
> +struct tpdm_drvdata {
> +       void __iomem            *base;
> +       struct device           *dev;
> +       struct coresight_device *csdev;
> +       struct mutex            lock;
> +       bool                    enable;
> +       int                     traceid;

TraceID appears to have no purpose in the hardware and does not
apparently drive onto the ATB - ATID signals from this device.
This should be dropped and the core code fixed to allow for sources
that have no trace id.

Regards

Mike


> +};
> +
> +#endif  /* _CORESIGHT_CORESIGHT_TPDM_H */
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 93a2922b7653..e48d463be63b 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -65,6 +65,7 @@ enum coresight_dev_subtype_source {
>         CORESIGHT_DEV_SUBTYPE_SOURCE_PROC,
>         CORESIGHT_DEV_SUBTYPE_SOURCE_BUS,
>         CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE,
> +       CORESIGHT_DEV_SUBTYPE_SOURCE_SYS,
>  };
>
>  enum coresight_dev_subtype_helper {
> --
> 2.17.1
>


--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
