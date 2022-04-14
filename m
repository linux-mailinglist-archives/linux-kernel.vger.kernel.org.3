Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1581850179A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358898AbiDNPmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343875AbiDNPM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 11:12:58 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C931B18A7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 07:53:14 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id u3so7283510wrg.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 07:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QI8lD7XbQk1BfveDDmKDIM0YNm1W3OSAHogkwLnpMQU=;
        b=EMUEZKxmHdzg4BJgKlszWLPR+Neo6BXumorjAZTczAnbAShqVdhSyG8CszhVE5NiuB
         ilp7AyG8cc1Zv8cxgln1N4PqF1k958y9TXlFf/XeBRopTgtD+zZXtZpz6XiD0RInIZ9E
         3hZhKUHlU/80qNoSOOSnAHbrJRABVnOR1OZpSPmdSnVFx3wJlpA7EEJUtAUkjvyZf7N0
         NhKTcBxilrTfmM+rrnVflkPC4ARhdy2oLNxLr2zgLksl4XS0qXCIgj557caEunQX+Ppy
         W7GxpYj5iGLv0+W+7IMQe+Vm/dZQGUZ0X3vsNB3+4V1cM0kt60BSIa0/LlqZ5/fgu8eh
         NDVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QI8lD7XbQk1BfveDDmKDIM0YNm1W3OSAHogkwLnpMQU=;
        b=mxSPKbBB7HCtrQ66G+RNv8AEMTJIeOb6M7AtAER2ykikLG4Id07Yx8HAinI70MoZxr
         +3JVvwYNhUQIsb8gnI86/tUz/x5TrT9krW+Z9ODXSpLOF3mayWI4nTbyZp2TMzb5MP73
         /EVXa9eFG/nrmNfG7bgRamUDbAKvFmdnrjFeLCOCJCuym6YXiQ4pNvEv0ut2ikezUxPC
         Fov9S41d5qHEaBUgkM4rgqXdPj3z4p9OkYRDWMLNhXZdcqrxIV2hKi8Ut5cGp8li90m3
         /GbziiEFJlvh2MS+fdlvVIv+ttjOZ4FS93v0XG1uXw6OZq0SnB/92TJ9GfEdPIVa+udn
         ULmg==
X-Gm-Message-State: AOAM530X9nRak5gqKh7q6F3HSvt6MxHoEITFGCF0ECNIjvzbw9h5xnZA
        CkjSMvNDgTJUVEuzThRIvQTxpFDBbhAVos0NZ/xmeA==
X-Google-Smtp-Source: ABdhPJz4XnDor898w0IMTEXyJPfrIZWgND6L+p6n6wYtRU+XZqv2HA09vg7AQfgI0AM2HpoVhUwE8FiDDNpHakUu3ec=
X-Received: by 2002:adf:cd87:0:b0:207:b0ad:6d8 with SMTP id
 q7-20020adfcd87000000b00207b0ad06d8mr2395716wrj.111.1649947992773; Thu, 14
 Apr 2022 07:53:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220412125035.40312-1-quic_jinlmao@quicinc.com> <20220412125035.40312-3-quic_jinlmao@quicinc.com>
In-Reply-To: <20220412125035.40312-3-quic_jinlmao@quicinc.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Thu, 14 Apr 2022 15:53:01 +0100
Message-ID: <CAJ9a7ViS+waaw+wAVVYvisM4ObfsMZCG6+DGJBNX92+PJ9MHug@mail.gmail.com>
Subject: Re: [PATCH v5 02/10] Coresight: Add coresight TPDM source driver
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

Hi,

On Tue, 12 Apr 2022 at 13:51, Mao Jinlong <quic_jinlmao@quicinc.com> wrote:
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
>  drivers/hwtracing/coresight/coresight-core.c |   5 +-
>  drivers/hwtracing/coresight/coresight-tpdm.c | 145 +++++++++++++++++++
>  drivers/hwtracing/coresight/coresight-tpdm.h |  26 ++++
>  include/linux/coresight.h                    |   1 +
>  6 files changed, 190 insertions(+), 1 deletion(-)
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
> index 329a0c704b87..6bb9b1746bc7 100644
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
> index 23ab16dd9b5d..75fe1781df20 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -1047,7 +1047,8 @@ static int coresight_validate_source(struct coresight_device *csdev,
>         }
>
>         if (subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_PROC &&
> -           subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE) {
> +           subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE &&
> +           subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_DATA_ONLY) {
>                 dev_err(&csdev->dev, "wrong device subtype in %s\n", function);
>                 return -EINVAL;
>         }
> @@ -1116,6 +1117,7 @@ int coresight_enable(struct coresight_device *csdev)
>                 per_cpu(tracer_path, cpu) = path;
>                 break;
>         case CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE:
> +       case CORESIGHT_DEV_SUBTYPE_SOURCE_DATA_ONLY:
>                 /*
>                  * Use the hash of source's device name as ID
>                  * and map the ID to the pointer of the path.
> @@ -1165,6 +1167,7 @@ void coresight_disable(struct coresight_device *csdev)
>                 per_cpu(tracer_path, cpu) = NULL;
>                 break;
>         case CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE:
> +       case CORESIGHT_DEV_SUBTYPE_SOURCE_DATA_ONLY:
>                 hash = hashlen_hash(hashlen_string(NULL, dev_name(&csdev->dev)));
>                 /* Find the path by the hash. */
>                 path = idr_find(&path_idr, hash);
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
> new file mode 100644
> index 000000000000..3900ae50670a
> --- /dev/null
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
> @@ -0,0 +1,145 @@
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
> +static const struct coresight_ops_source tpdm_source_ops = {
> +       .enable         = tpdm_enable,
> +       .disable        = tpdm_disable,
> +};
> +
> +static const struct coresight_ops tpdm_cs_ops = {
> +       .source_ops     = &tpdm_source_ops,
> +};
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
> +
> +       /* Set up coresight component description */
> +       desc.name = coresight_alloc_device_name(&tpdm_devs, dev);
> +       if (!desc.name)
> +               return -ENOMEM;
> +       desc.type = CORESIGHT_DEV_TYPE_SOURCE;
> +       desc.subtype.source_subtype = CORESIGHT_DEV_SUBTYPE_SOURCE_DATA_ONLY;
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

How is this function called? The other coresight devices set the
.remove function pointer in the amba_driver structure.


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

Do you need:-
       .remove = tpdm_remove;
in here?

Regards

Mike

> +       .id_table       = tpdm_ids,
> +};
> +
> +module_amba_driver(tpdm_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Trace, Profiling & Diagnostic Monitor driver");
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
> new file mode 100644
> index 000000000000..94a7748a5426
> --- /dev/null
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.h
> @@ -0,0 +1,26 @@
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
> + */
> +
> +struct tpdm_drvdata {
> +       void __iomem            *base;
> +       struct device           *dev;
> +       struct coresight_device *csdev;
> +       struct mutex            lock;
> +       bool                    enable;
> +};
> +
> +#endif  /* _CORESIGHT_CORESIGHT_TPDM_H */
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 247147c11231..a9efac55029d 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -61,6 +61,7 @@ enum coresight_dev_subtype_source {
>         CORESIGHT_DEV_SUBTYPE_SOURCE_PROC,
>         CORESIGHT_DEV_SUBTYPE_SOURCE_BUS,
>         CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE,
> +       CORESIGHT_DEV_SUBTYPE_SOURCE_DATA_ONLY,
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
