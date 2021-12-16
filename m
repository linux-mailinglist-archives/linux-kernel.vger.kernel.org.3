Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84B8A477C22
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 20:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240819AbhLPTC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 14:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236487AbhLPTC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 14:02:27 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B5DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 11:02:27 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id co15so43392pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 11:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yIzDAfP89KkAwrI/b9ZoIMiMvCVPqRfqsQV1ykh2dB8=;
        b=g+6SveIgq/Y7Ee+1oPbFEDf/jKfvb+BNqpwnoSdcNhu04ZQslM7AmyBbwvV7lWXq7Z
         GpqjXFaXmdNz0xcIpPR69YIiZvZU+9W+xCNANibXLJn7ozIRkBm2y6BHFKIwszmw/IPL
         pdoBKIybePWLo0NJxcJXD81u0abs9MGasVfhKbU4o3zgla5w2hWKTrxH4VhSmueW4moo
         8Vs451MYjv3o97mufnhgt4jH5XKK/M/Sjn1QVCdt+zWncd1bdKdG2SBv3PlUlYfdI0aB
         wzvwm4WiAC4xfaMHqVaO4YhbfhF7VaFFDDk7PVLmhmrq7RMk5NGzSdEbFwsLprz+iSz9
         JcbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yIzDAfP89KkAwrI/b9ZoIMiMvCVPqRfqsQV1ykh2dB8=;
        b=dvEiLSOYvP0sOXxTC0fPesig0frwXQ5WTxHs6hB6nzpFtmci/FQ+0MF142ekUTHAT/
         KUkfeYxRC/vNR1befXbf/hVUW5X3pgW5fFu6gCszsHjHTsDThrxkM6DI6sEqejU4vH7T
         LpuAZEyxbl11WiPQ4aAQeG2qau58N0ehDIE+iUUWyZJ4XQagf6kXsqN2bgdcKL2dCwzV
         KcoKeaAwHq9pbM79drMJCB0fMBydBcwPAdE/bFr3X+m+b/omnl4K4pkw7JwkGm/b0Fvv
         s3yxy3r5XhJPzYmjXOqxYEuPMXHNE73GSzgi7f+hRvlZTEZc9N4zMdsivg/Cg1+3RUAN
         OE2w==
X-Gm-Message-State: AOAM533n40PYiwXZFgIgEZ1bQdxQzws+xyW6rbQbzKMt4FhhcLqQ6PzE
        pvTRE3y8llQMnfEVnQ2WbznaIg==
X-Google-Smtp-Source: ABdhPJxpM+Mu84KTIECOB8X6rqlODeutOxWReh3Vnm7lSgUBDhcXn3GTq+QkhR0pE6T1yObZxuQY2w==
X-Received: by 2002:a17:902:e5c3:b0:148:a51b:d044 with SMTP id u3-20020a170902e5c300b00148a51bd044mr10282217plf.93.1639681346377;
        Thu, 16 Dec 2021 11:02:26 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id c19sm7858186pjr.2.2021.12.16.11.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 11:02:25 -0800 (PST)
Date:   Thu, 16 Dec 2021 12:02:23 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     Jinlong Mao <quic_jinlmao@quicinc.com>,
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
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 2/9] Coresight: Add coresight TPDM source driver
Message-ID: <20211216190223.GA78825@p14s>
References: <20211209141543.21314-1-quic_jinlmao@quicinc.com>
 <20211209141543.21314-3-quic_jinlmao@quicinc.com>
 <20211214185714.GB1549991@p14s>
 <85ad17fb-c885-831d-d841-4c6f10920355@quicinc.com>
 <CAJ9a7Vh2d79Ro72ZDsbQSVS8VrH3c+X+xo8849yGS4Z73+yq_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ9a7Vh2d79Ro72ZDsbQSVS8VrH3c+X+xo8849yGS4Z73+yq_w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> > >> +
> > >> +static void tpdm_init_default_data(struct tpdm_drvdata *drvdata)
> > >> +{
> > >> +    static int traceid = TPDM_TRACE_ID_START;
> > >> +
> > >> +    drvdata->traceid = traceid++;
> > >> +}
> > > I have been specific on how to properly do this in the last revision.  Given the
> > > above about the MAINTAINERS file, I am not sure that I will continue reviewing this set.
> > >
> > > There is also no need to rush another revision as I won't have the bandwidth to
> > > process it before the holidays.
> > >
> > > Thanks,
> > > Mathieu
> >
> > Hi Mathieu,
> >
> > Sorry, not addressed your previous comments here.
> >
> > For the trace id, each coresight component has 7 bits to store the trace
> > id. So the trace id should be from 1 to 127 as 0 is invalid.
> 
> IDs 0x70 - 0x7F (`112 - 127 ) are reserved - see the ARM Coresight
> Architecture specification v3.0
> 

Correct

> >
> > Apart from TPDMs/STM/ETMs, we also have other coresight components in
> > our internal device. About 80 ids are already used.
> >
> > Some components have fixed trace id in HW. If we use functions below to
> > count the trace id, there will be conflict to other components.
> >
> > Can we use 1-15 for etm trace ids  and 16 - 127 for other coresight
> > components ? And handle trace ids in its' own driver ?
> >
> 
> This will limit systems to 15 cores - some have more!
> 

Correct

> 
> >
> > static inline int coresight_get_system_trace_id(int id)
> > {
> >          /* Start system IDs above the highest per CPU trace ID. */
> >          return coresigth_get_trace_id(cpumask_last(cpu_possible_mask) + 1);
> > }

Looking at my own suggestion again this won't work since it returns the same traceID
when called multiple times.

For this patchset and _without_ taking into account internal devices that have
their traceID set in HW:

1. Define a bitmask that is 7 bit wide.
2. By default, set bits under 0x10 and between 0x70 - 0x7F. 
3. In coresight_get_system_trace_id(), drop the @id parameter and allocate the
first available bit after cpumask_last(cpu_possible_mask) + 1.
4. Define a new function called coresight_put_system_trace_id(int id) that
clears the bit in the mask corresponding to @id.

For now that should work.

> >
> > static inline int coresight_get_trace_id(int cpu)
> > {
> >      /*
> >       * A trace ID of value 0 is invalid, so let's start at some
> >       * random value that fits in 7 bits and go from there.  Since
> >       * the common convention is to have data trace IDs be I(N) + 1,
> >       * set instruction trace IDs as a function of the CPU number.
> >       */
> >      return (CORESIGHT_ETM_PMU_SEED + (cpu * 2));
> > }
> >
> 
> This fixed relationship between cpu and trace ID is used in the perf
> tooling to populate the elements in the perf.data file to correctly
> allow association between CPU and trace data, and thus allow correct
> trace decode.

TraceIDs associated to CPUs are communicated to the perf tooling by way of the
perf header - theoretically we should be able to change the allocation scheme
without impacting the decoding process.

> 
> It should be possible to create another more dynamic mapping scheme -
> but this must include a way to support the perf requirements too.
>

TraceIDs have been a lurking problem for as long as the subsystem has existed.
For now what I have suggested above should be sufficient to provide an
in-between solution that doesn't hold back this patchset.

That being said, we need to start thinking about the best way to do this.  I
will put a patchset together in the new year that aims in that direction.

> Regards
> 
> Mike
> 
> > Thanks
> >
> > Jinlong Mao
> >
> > >> +
> > >> +static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
> > >> +{
> > >> +    struct device *dev = &adev->dev;
> > >> +    struct coresight_platform_data *pdata;
> > >> +    struct tpdm_drvdata *drvdata;
> > >> +    struct coresight_desc desc = { 0 };
> > >> +
> > >> +    desc.name = coresight_alloc_device_name(&tpdm_devs, dev);
> > >> +    if (!desc.name)
> > >> +            return -ENOMEM;
> > >> +    pdata = coresight_get_platform_data(dev);
> > >> +    if (IS_ERR(pdata))
> > >> +            return PTR_ERR(pdata);
> > >> +    adev->dev.platform_data = pdata;
> > >> +
> > >> +    drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
> > >> +    if (!drvdata)
> > >> +            return -ENOMEM;
> > >> +    drvdata->dev = &adev->dev;
> > >> +    dev_set_drvdata(dev, drvdata);
> > >> +
> > >> +    drvdata->base = devm_ioremap_resource(dev, &adev->res);
> > >> +    if (!drvdata->base)
> > >> +            return -ENOMEM;
> > >> +
> > >> +    mutex_init(&drvdata->lock);
> > >> +
> > >> +    desc.type = CORESIGHT_DEV_TYPE_SOURCE;
> > >> +    desc.subtype.source_subtype = CORESIGHT_DEV_SUBTYPE_SOURCE_SYS;
> > >> +    desc.ops = &tpdm_cs_ops;
> > >> +    desc.pdata = adev->dev.platform_data;
> > >> +    desc.dev = &adev->dev;
> > >> +    drvdata->csdev = coresight_register(&desc);
> > >> +    if (IS_ERR(drvdata->csdev))
> > >> +            return PTR_ERR(drvdata->csdev);
> > >> +
> > >> +    tpdm_init_default_data(drvdata);
> > >> +    pm_runtime_put(&adev->dev);
> > >> +
> > >> +    return 0;
> > >> +}
> > >> +
> > >> +static void __exit tpdm_remove(struct amba_device *adev)
> > >> +{
> > >> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(&adev->dev);
> > >> +
> > >> +    coresight_unregister(drvdata->csdev);
> > >> +}
> > >> +
> > >> +static struct amba_id tpdm_ids[] = {
> > >> +    {
> > >> +            .id = 0x000f0e00,
> > >> +            .mask = 0x000fff00,
> > >> +    },
> > >> +    { 0, 0},
> > >> +};
> > >> +
> > >> +static struct amba_driver tpdm_driver = {
> > >> +    .drv = {
> > >> +            .name   = "coresight-tpdm",
> > >> +            .owner  = THIS_MODULE,
> > >> +            .suppress_bind_attrs = true,
> > >> +    },
> > >> +    .probe          = tpdm_probe,
> > >> +    .id_table       = tpdm_ids,
> > >> +};
> > >> +
> > >> +module_amba_driver(tpdm_driver);
> > >> +
> > >> +MODULE_LICENSE("GPL v2");
> > >> +MODULE_DESCRIPTION("Trace, Profiling & Diagnostic Monitor driver");
> > >> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
> > >> new file mode 100644
> > >> index 000000000000..980ae90ff1c8
> > >> --- /dev/null
> > >> +++ b/drivers/hwtracing/coresight/coresight-tpdm.h
> > >> @@ -0,0 +1,31 @@
> > >> +/* SPDX-License-Identifier: GPL-2.0 */
> > >> +/*
> > >> + * Copyright (c) 2021 Qualcomm Innovation Center, Inc. All rights reserved.
> > >> + */
> > >> +
> > >> +#ifndef _CORESIGHT_CORESIGHT_TPDM_H
> > >> +#define _CORESIGHT_CORESIGHT_TPDM_H
> > >> +
> > >> +/* Default value of the traceid */
> > >> +#define TPDM_TRACE_ID_START 128
> > >> +
> > >> +/**
> > >> + * struct tpdm_drvdata - specifics associated to an TPDM component
> > >> + * @base:       memory mapped base address for this component.
> > >> + * @dev:        The device entity associated to this component.
> > >> + * @csdev:      component vitals needed by the framework.
> > >> + * @lock:       lock for the enable value.
> > >> + * @enable:     enable status of the component.
> > >> + * @traceid:    value of the current ID for this component.
> > >> + */
> > >> +
> > >> +struct tpdm_drvdata {
> > >> +    void __iomem            *base;
> > >> +    struct device           *dev;
> > >> +    struct coresight_device *csdev;
> > >> +    struct mutex            lock;
> > >> +    bool                    enable;
> > >> +    int                     traceid;
> > >> +};
> > >> +
> > >> +#endif  /* _CORESIGHT_CORESIGHT_TPDM_H */
> > >> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> > >> index 93a2922b7653..e48d463be63b 100644
> > >> --- a/include/linux/coresight.h
> > >> +++ b/include/linux/coresight.h
> > >> @@ -65,6 +65,7 @@ enum coresight_dev_subtype_source {
> > >>      CORESIGHT_DEV_SUBTYPE_SOURCE_PROC,
> > >>      CORESIGHT_DEV_SUBTYPE_SOURCE_BUS,
> > >>      CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE,
> > >> +    CORESIGHT_DEV_SUBTYPE_SOURCE_SYS,
> > >>   };
> > >>
> > >>   enum coresight_dev_subtype_helper {
> > >> --
> > >> 2.17.1
> > >>
> 
> 
> 
> -- 
> Mike Leach
> Principal Engineer, ARM Ltd.
> Manchester Design Centre. UK
