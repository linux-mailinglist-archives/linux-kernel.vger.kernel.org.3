Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5AF14963A1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 18:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379428AbiAURQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 12:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235906AbiAURP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 12:15:57 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14230C06173D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 09:15:57 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id s2-20020a17090ad48200b001b501977b23so9231865pju.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 09:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=K02TfDJswqE9tV0xWJk1EnsHkHdcprQzen8J5NZz700=;
        b=TS0yzC8OZsTAoeA90oXwPTHGlGNDfqivpU1dwRTid9E/mJd1mMplol4mMoBux3t5Fz
         sMsTlbmTD+IrPcaAxsOz1PaoMEKRSdbXyTwEhoHT8qu0F5f9thvh1Be9y06fZxaI6RhQ
         ySIV26zWD6pGr01gGuCdW8wRwaHhJPesgCCb9yfA9Gw0NmTliqP19V3VIljFd+GcNgz1
         gTXg/s43k2Vsohju6iTY6Soa3Gj3c8FoYCKi7SfSZUE1FGjDzDrgtgOzwMpgnqwTB8XN
         EqUlxrJ/eS4paeJWOnPDoXdvsCmOLSs51B8PdwDEKWwkv4DypLNSHeg8tIV4aCm8BiMi
         jDyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=K02TfDJswqE9tV0xWJk1EnsHkHdcprQzen8J5NZz700=;
        b=5NMyxQiNOLLZqtHYp2YDJkOaOZYUNl+FZoIou4eeFPatVBEdzya2mKYtj2DWBfRKVu
         xx7hoKEXaiJMSk/WAQTQBecFdg2Wj9Fzcm61iGyi35yxZLK7Qc5x+EUzMelmMP0sNTrH
         1OYiV5FdxPvbBkP6R4hvI+oGupcg7in0qApU9YXlfkUGngM9B3DohTQI9aA8SSrnIZgi
         087Le+OhBv0l2YKBimd97yRluNN5zC8EyuQZIXgwbVEPG2LhkCxsXg7U9zNQ7IRDtE+o
         sK5GOG1Ww0dNqEAjGi1hWUIaTKOp0UqhpSu0SDQP/LT7yRq2eHLqU8tpxzdeUw6MCkD+
         CU6Q==
X-Gm-Message-State: AOAM531eqoj9bsrXAL66ggFJJkhlm2gyxEAzJjBc/+Rlbq3OpM80PVzh
        y6fEZHJe36Jx9w2u04CavXto/Q==
X-Google-Smtp-Source: ABdhPJxAzKU4mxUSe3BXH4XKO4E9h2cUEcSgpzifRiK+mdLzPZdXTW0rxJwRnXWoqzOLk83PhhZ5fQ==
X-Received: by 2002:a17:90b:4d11:: with SMTP id mw17mr1765554pjb.32.1642785356445;
        Fri, 21 Jan 2022 09:15:56 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id t1sm7916902pfj.115.2022.01.21.09.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 09:15:54 -0800 (PST)
Date:   Fri, 21 Jan 2022 10:15:52 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Jinlong Mao <quic_jinlmao@quicinc.com>
Cc:     Mike Leach <mike.leach@linaro.org>,
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
Message-ID: <20220121171552.GA1811357@p14s>
References: <20211209141543.21314-1-quic_jinlmao@quicinc.com>
 <20211209141543.21314-3-quic_jinlmao@quicinc.com>
 <20211214185714.GB1549991@p14s>
 <85ad17fb-c885-831d-d841-4c6f10920355@quicinc.com>
 <CAJ9a7Vh2d79Ro72ZDsbQSVS8VrH3c+X+xo8849yGS4Z73+yq_w@mail.gmail.com>
 <20211216190223.GA78825@p14s>
 <2703bf83-3a87-e69f-2392-7e0568e91712@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2703bf83-3a87-e69f-2392-7e0568e91712@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Jinlong,

On Fri, Jan 21, 2022 at 10:01:47PM +0800, Jinlong Mao wrote:
> Hi Mathieu,
> 
> Good Day.
> 
> On 12/17/2021 3:02 AM, Mathieu Poirier wrote:
> > [...]
> > 
> > > > > > +
> > > > > > +static void tpdm_init_default_data(struct tpdm_drvdata *drvdata)
> > > > > > +{
> > > > > > +    static int traceid = TPDM_TRACE_ID_START;
> > > > > > +
> > > > > > +    drvdata->traceid = traceid++;
> > > > > > +}
> > > > > I have been specific on how to properly do this in the last revision.  Given the
> > > > > above about the MAINTAINERS file, I am not sure that I will continue reviewing this set.
> > > > > 
> > > > > There is also no need to rush another revision as I won't have the bandwidth to
> > > > > process it before the holidays.
> > > > > 
> > > > > Thanks,
> > > > > Mathieu
> > > > Hi Mathieu,
> > > > 
> > > > Sorry, not addressed your previous comments here.
> > > > 
> > > > For the trace id, each coresight component has 7 bits to store the trace
> > > > id. So the trace id should be from 1 to 127 as 0 is invalid.
> > > IDs 0x70 - 0x7F (`112 - 127 ) are reserved - see the ARM Coresight
> > > Architecture specification v3.0
> > > 
> > Correct
> > 
> > > > Apart from TPDMs/STM/ETMs, we also have other coresight components in
> > > > our internal device. About 80 ids are already used.
> > > > 
> > > > Some components have fixed trace id in HW. If we use functions below to
> > > > count the trace id, there will be conflict to other components.
> > > > 
> > > > Can we use 1-15 for etm trace ids  and 16 - 127 for other coresight
> > > > components ? And handle trace ids in its' own driver ?
> > > > 
> > > This will limit systems to 15 cores - some have more!
> > > 
> > Correct
> > 
> > > > static inline int coresight_get_system_trace_id(int id)
> > > > {
> > > >           /* Start system IDs above the highest per CPU trace ID. */
> > > >           return coresigth_get_trace_id(cpumask_last(cpu_possible_mask) + 1);
> > > > }
> > Looking at my own suggestion again this won't work since it returns the same traceID
> > when called multiple times.
> > 
> > For this patchset and _without_ taking into account internal devices that have
> > their traceID set in HW:
> > 
> > 1. Define a bitmask that is 7 bit wide.
> Should it be a 128 bit wide bitmask  (0--127)?

Yes, you are correct.

> > 2. By default, set bits under 0x10 and between 0x70 - 0x7F.
> > 3. In coresight_get_system_trace_id(), drop the @id parameter and allocate the
> > first available bit after cpumask_last(cpu_possible_mask) + 1.
> 
> Should it allocate the first available bit after (cpumask_last(cpu_possible_mask) *2 ) + 0x10 ?
> Return the first zero bit position as the trace id and set the bit.

I need to clarify something with Mike on this - I will get back to you on
Monday.

> 
> > 4. Define a new function called coresight_put_system_trace_id(int id) that
> > clears the bit in the mask corresponding to @id.
> > 
> > For now that should work.
> > 
> > > > static inline int coresight_get_trace_id(int cpu)
> > > > {
> > > >       /*
> > > >        * A trace ID of value 0 is invalid, so let's start at some
> > > >        * random value that fits in 7 bits and go from there.  Since
> > > >        * the common convention is to have data trace IDs be I(N) + 1,
> > > >        * set instruction trace IDs as a function of the CPU number.
> > > >        */
> > > >       return (CORESIGHT_ETM_PMU_SEED + (cpu * 2));
> > > > }
> > > > 
> > > This fixed relationship between cpu and trace ID is used in the perf
> > > tooling to populate the elements in the perf.data file to correctly
> > > allow association between CPU and trace data, and thus allow correct
> > > trace decode.
> > TraceIDs associated to CPUs are communicated to the perf tooling by way of the
> > perf header - theoretically we should be able to change the allocation scheme
> > without impacting the decoding process.
> > 
> > > It should be possible to create another more dynamic mapping scheme -
> > > but this must include a way to support the perf requirements too.
> > > 
> > TraceIDs have been a lurking problem for as long as the subsystem has existed.
> > For now what I have suggested above should be sufficient to provide an
> > in-between solution that doesn't hold back this patchset.
> > 
> > That being said, we need to start thinking about the best way to do this.  I
> > will put a patchset together in the new year that aims in that direction.
> > 
> > > Regards
> > > 
> > > Mike
> > > 
> > > > Thanks
> > > > 
> > > > Jinlong Mao
> > > > 
> > > > > > +
> > > > > > +static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
> > > > > > +{
> > > > > > +    struct device *dev = &adev->dev;
> > > > > > +    struct coresight_platform_data *pdata;
> > > > > > +    struct tpdm_drvdata *drvdata;
> > > > > > +    struct coresight_desc desc = { 0 };
> > > > > > +
> > > > > > +    desc.name = coresight_alloc_device_name(&tpdm_devs, dev);
> > > > > > +    if (!desc.name)
> > > > > > +            return -ENOMEM;
> > > > > > +    pdata = coresight_get_platform_data(dev);
> > > > > > +    if (IS_ERR(pdata))
> > > > > > +            return PTR_ERR(pdata);
> > > > > > +    adev->dev.platform_data = pdata;
> > > > > > +
> > > > > > +    drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
> > > > > > +    if (!drvdata)
> > > > > > +            return -ENOMEM;
> > > > > > +    drvdata->dev = &adev->dev;
> > > > > > +    dev_set_drvdata(dev, drvdata);
> > > > > > +
> > > > > > +    drvdata->base = devm_ioremap_resource(dev, &adev->res);
> > > > > > +    if (!drvdata->base)
> > > > > > +            return -ENOMEM;
> > > > > > +
> > > > > > +    mutex_init(&drvdata->lock);
> > > > > > +
> > > > > > +    desc.type = CORESIGHT_DEV_TYPE_SOURCE;
> > > > > > +    desc.subtype.source_subtype = CORESIGHT_DEV_SUBTYPE_SOURCE_SYS;
> > > > > > +    desc.ops = &tpdm_cs_ops;
> > > > > > +    desc.pdata = adev->dev.platform_data;
> > > > > > +    desc.dev = &adev->dev;
> > > > > > +    drvdata->csdev = coresight_register(&desc);
> > > > > > +    if (IS_ERR(drvdata->csdev))
> > > > > > +            return PTR_ERR(drvdata->csdev);
> > > > > > +
> > > > > > +    tpdm_init_default_data(drvdata);
> > > > > > +    pm_runtime_put(&adev->dev);
> > > > > > +
> > > > > > +    return 0;
> > > > > > +}
> > > > > > +
> > > > > > +static void __exit tpdm_remove(struct amba_device *adev)
> > > > > > +{
> > > > > > +    struct tpdm_drvdata *drvdata = dev_get_drvdata(&adev->dev);
> > > > > > +
> > > > > > +    coresight_unregister(drvdata->csdev);
> > > > > > +}
> > > > > > +
> > > > > > +static struct amba_id tpdm_ids[] = {
> > > > > > +    {
> > > > > > +            .id = 0x000f0e00,
> > > > > > +            .mask = 0x000fff00,
> > > > > > +    },
> > > > > > +    { 0, 0},
> > > > > > +};
> > > > > > +
> > > > > > +static struct amba_driver tpdm_driver = {
> > > > > > +    .drv = {
> > > > > > +            .name   = "coresight-tpdm",
> > > > > > +            .owner  = THIS_MODULE,
> > > > > > +            .suppress_bind_attrs = true,
> > > > > > +    },
> > > > > > +    .probe          = tpdm_probe,
> > > > > > +    .id_table       = tpdm_ids,
> > > > > > +};
> > > > > > +
> > > > > > +module_amba_driver(tpdm_driver);
> > > > > > +
> > > > > > +MODULE_LICENSE("GPL v2");
> > > > > > +MODULE_DESCRIPTION("Trace, Profiling & Diagnostic Monitor driver");
> > > > > > diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
> > > > > > new file mode 100644
> > > > > > index 000000000000..980ae90ff1c8
> > > > > > --- /dev/null
> > > > > > +++ b/drivers/hwtracing/coresight/coresight-tpdm.h
> > > > > > @@ -0,0 +1,31 @@
> > > > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > > > +/*
> > > > > > + * Copyright (c) 2021 Qualcomm Innovation Center, Inc. All rights reserved.
> > > > > > + */
> > > > > > +
> > > > > > +#ifndef _CORESIGHT_CORESIGHT_TPDM_H
> > > > > > +#define _CORESIGHT_CORESIGHT_TPDM_H
> > > > > > +
> > > > > > +/* Default value of the traceid */
> > > > > > +#define TPDM_TRACE_ID_START 128
> > > > > > +
> > > > > > +/**
> > > > > > + * struct tpdm_drvdata - specifics associated to an TPDM component
> > > > > > + * @base:       memory mapped base address for this component.
> > > > > > + * @dev:        The device entity associated to this component.
> > > > > > + * @csdev:      component vitals needed by the framework.
> > > > > > + * @lock:       lock for the enable value.
> > > > > > + * @enable:     enable status of the component.
> > > > > > + * @traceid:    value of the current ID for this component.
> > > > > > + */
> > > > > > +
> > > > > > +struct tpdm_drvdata {
> > > > > > +    void __iomem            *base;
> > > > > > +    struct device           *dev;
> > > > > > +    struct coresight_device *csdev;
> > > > > > +    struct mutex            lock;
> > > > > > +    bool                    enable;
> > > > > > +    int                     traceid;
> > > > > > +};
> > > > > > +
> > > > > > +#endif  /* _CORESIGHT_CORESIGHT_TPDM_H */
> > > > > > diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> > > > > > index 93a2922b7653..e48d463be63b 100644
> > > > > > --- a/include/linux/coresight.h
> > > > > > +++ b/include/linux/coresight.h
> > > > > > @@ -65,6 +65,7 @@ enum coresight_dev_subtype_source {
> > > > > >       CORESIGHT_DEV_SUBTYPE_SOURCE_PROC,
> > > > > >       CORESIGHT_DEV_SUBTYPE_SOURCE_BUS,
> > > > > >       CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE,
> > > > > > +    CORESIGHT_DEV_SUBTYPE_SOURCE_SYS,
> > > > > >    };
> > > > > > 
> > > > > >    enum coresight_dev_subtype_helper {
> > > > > > --
> > > > > > 2.17.1
> > > > > > 
> > > 
> > > 
> > > -- 
> > > Mike Leach
> > > Principal Engineer, ARM Ltd.
> > > Manchester Design Centre. UK
