Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA27349CE94
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 16:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242907AbiAZPep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 10:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242902AbiAZPel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 10:34:41 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF1CC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 07:34:41 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id j16so12205590plx.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 07:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Zlq95XEYA8t29+ZUK50ePkrc6VWvZvEpJO4Sweh0ies=;
        b=aMbvwm6r0K3y78Dz/fQSEB+Xn5ys922n8v6G7GvjDkGE/klEyJiDcPOiEFwgy8wkGX
         clRF/ORFRNUO3MbtwgXsZaVwdeC3X8uxUf26o/49uEJWxD8chbtYkA6/rOFDRQ10B8qY
         l27+x2ge+cE/CBBGC7dY5vF49FHIxbXUFWGL64vRo/xn8I84OadIa8FoUGoNzrjhUNOJ
         mhqy6Z57LMGXFyTZDQeuNS4xdV+7JgvaTGWnQxpVDVoomB5rPNk+0MlqCHS59PJpgDDs
         POUkCb86Oiy9QrynofGdzrbkLzXtp+tO9x1P54MxnQPCBfqWLIQ8tvsSqowIzVl62Eaa
         AEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Zlq95XEYA8t29+ZUK50ePkrc6VWvZvEpJO4Sweh0ies=;
        b=7jBPzcnIeIko/HxC6QEqFymd8wgJPCtwdSMk6KW0sz8AJRCbjXOePyCvAQ8AElT8ts
         W4Ltp26hwcKVmtQc1+D38utSoOVe0hk8/rDDkZrPshGjFDlC+hHpOWLXZdi4KoUj7W8x
         72O2+Ux8UwcDPZI04/roz8eVu5dq4FGeA+lXLhPRLoyz2Q/gotJBBWSU3oxE+XTEgymO
         PFp2YQsL0lOTsQuddftk6pXsJ+NNky3K1ASFOS+os2Gay+FD13X/SuO4iVV84Vvq3Rqh
         at7dIeQBKLj8KDBkGxdIE1Nnkv+NV92mbH9cnR1RcGK/9KqKZQPv4+TkA+NjPzEh97Xe
         kyoQ==
X-Gm-Message-State: AOAM5314gtbyWTedsO/GlkZ/Llu4dMumUiRuHh322sf5nqvGfwZI8R4n
        +MPuCVHGUqlFDs3X5di5wTZX9A==
X-Google-Smtp-Source: ABdhPJzlHXqQfDEJY6fNKPVmfdHF4I09sPw0b03P/eMmpo/sBKl5fW6u7RP8n2Iv5cd8seqO70Y1Ig==
X-Received: by 2002:a17:90a:7c0b:: with SMTP id v11mr9396176pjf.180.1643211280685;
        Wed, 26 Jan 2022 07:34:40 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id t2sm16615618pgt.12.2022.01.26.07.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 07:34:39 -0800 (PST)
Date:   Wed, 26 Jan 2022 08:34:37 -0700
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
Message-ID: <20220126153437.GA2144852@p14s>
References: <20211209141543.21314-1-quic_jinlmao@quicinc.com>
 <20211209141543.21314-3-quic_jinlmao@quicinc.com>
 <20211214185714.GB1549991@p14s>
 <85ad17fb-c885-831d-d841-4c6f10920355@quicinc.com>
 <CAJ9a7Vh2d79Ro72ZDsbQSVS8VrH3c+X+xo8849yGS4Z73+yq_w@mail.gmail.com>
 <20211216190223.GA78825@p14s>
 <2703bf83-3a87-e69f-2392-7e0568e91712@quicinc.com>
 <20220121171552.GA1811357@p14s>
 <24c09945-bcda-81e4-f53c-af871f696094@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <24c09945-bcda-81e4-f53c-af871f696094@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 03:07:38PM +0800, Jinlong Mao wrote:
> Hi Mathieu,
> 
> Good afternoon.
> 
> On 1/22/2022 1:15 AM, Mathieu Poirier wrote:
> > Hey Jinlong,
> > 
> > On Fri, Jan 21, 2022 at 10:01:47PM +0800, Jinlong Mao wrote:
> > > Hi Mathieu,
> > > 
> > > Good Day.
> > > 
> > > On 12/17/2021 3:02 AM, Mathieu Poirier wrote:
> > > > [...]
> > > > 
> > > > > > > > +
> > > > > > > > +static void tpdm_init_default_data(struct tpdm_drvdata *drvdata)
> > > > > > > > +{
> > > > > > > > +    static int traceid = TPDM_TRACE_ID_START;
> > > > > > > > +
> > > > > > > > +    drvdata->traceid = traceid++;
> > > > > > > > +}
> > > > > > > I have been specific on how to properly do this in the last revision.  Given the
> > > > > > > above about the MAINTAINERS file, I am not sure that I will continue reviewing this set.
> > > > > > > 
> > > > > > > There is also no need to rush another revision as I won't have the bandwidth to
> > > > > > > process it before the holidays.
> > > > > > > 
> > > > > > > Thanks,
> > > > > > > Mathieu
> > > > > > Hi Mathieu,
> > > > > > 
> > > > > > Sorry, not addressed your previous comments here.
> > > > > > 
> > > > > > For the trace id, each coresight component has 7 bits to store the trace
> > > > > > id. So the trace id should be from 1 to 127 as 0 is invalid.
> > > > > IDs 0x70 - 0x7F (`112 - 127 ) are reserved - see the ARM Coresight
> > > > > Architecture specification v3.0
> > > > > 
> > > > Correct
> > > > 
> > > > > > Apart from TPDMs/STM/ETMs, we also have other coresight components in
> > > > > > our internal device. About 80 ids are already used.
> > > > > > 
> > > > > > Some components have fixed trace id in HW. If we use functions below to
> > > > > > count the trace id, there will be conflict to other components.
> > > > > > 
> > > > > > Can we use 1-15 for etm trace ids  and 16 - 127 for other coresight
> > > > > > components ? And handle trace ids in its' own driver ?
> > > > > > 
> > > > > This will limit systems to 15 cores - some have more!
> > > > > 
> > > > Correct
> > > > 
> > > > > > static inline int coresight_get_system_trace_id(int id)
> > > > > > {
> > > > > >            /* Start system IDs above the highest per CPU trace ID. */
> > > > > >            return coresigth_get_trace_id(cpumask_last(cpu_possible_mask) + 1);
> > > > > > }
> > > > Looking at my own suggestion again this won't work since it returns the same traceID
> > > > when called multiple times.
> > > > 
> > > > For this patchset and _without_ taking into account internal devices that have
> > > > their traceID set in HW:
> > > > 
> > > > 1. Define a bitmask that is 7 bit wide.
> > > Should it be a 128 bit wide bitmask  (0--127)?
> > Yes, you are correct.
> > 
> > > > 2. By default, set bits under 0x10 and between 0x70 - 0x7F.
> > > > 3. In coresight_get_system_trace_id(), drop the @id parameter and allocate the
> > > > first available bit after cpumask_last(cpu_possible_mask) + 1.
> > > Should it allocate the first available bit after (cpumask_last(cpu_possible_mask) *2 ) + 0x10 ?
> > > Return the first zero bit position as the trace id and set the bit.
> > I need to clarify something with Mike on this - I will get back to you on
> > Monday.
> Do you have more comments on this ?

I just received clarifications on this - there is no need to continue enacting
the current scheme and as such reserving bits following the above formula will
not be needed either.  Simply assigning free traceIDs based on request will
work just fine.  

That of course is taking into account that 0x0, 0x1 and 0x70 - 0x7f are
reserved.  0x1 is currently used for STM and should eventually be fixed to
simply request a traceID the same way any other component do.  You can fix it as
part of this set but it is not mandatory.

Let me know if there are things I haven't been clear on.

Thanks,
Mathieu

> > 
> > > > 4. Define a new function called coresight_put_system_trace_id(int id) that
> > > > clears the bit in the mask corresponding to @id.
> > > > 
> > > > For now that should work.
> > > > 
> > > > > > static inline int coresight_get_trace_id(int cpu)
> > > > > > {
> > > > > >        /*
> > > > > >         * A trace ID of value 0 is invalid, so let's start at some
> > > > > >         * random value that fits in 7 bits and go from there.  Since
> > > > > >         * the common convention is to have data trace IDs be I(N) + 1,
> > > > > >         * set instruction trace IDs as a function of the CPU number.
> > > > > >         */
> > > > > >        return (CORESIGHT_ETM_PMU_SEED + (cpu * 2));
> > > > > > }
> > > > > > 
> > > > > This fixed relationship between cpu and trace ID is used in the perf
> > > > > tooling to populate the elements in the perf.data file to correctly
> > > > > allow association between CPU and trace data, and thus allow correct
> > > > > trace decode.
> > > > TraceIDs associated to CPUs are communicated to the perf tooling by way of the
> > > > perf header - theoretically we should be able to change the allocation scheme
> > > > without impacting the decoding process.
> > > > 
> > > > > It should be possible to create another more dynamic mapping scheme -
> > > > > but this must include a way to support the perf requirements too.
> > > > > 
> > > > TraceIDs have been a lurking problem for as long as the subsystem has existed.
> > > > For now what I have suggested above should be sufficient to provide an
> > > > in-between solution that doesn't hold back this patchset.
> > > > 
> > > > That being said, we need to start thinking about the best way to do this.  I
> > > > will put a patchset together in the new year that aims in that direction.
> > > > 
> > > > > Regards
> > > > > 
> > > > > Mike
> > > > > 
> > > > > > Thanks
> > > > > > 
> > > > > > Jinlong Mao
> > > > > > 
> > > > > > > > +
> > > > > > > > +static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
> > > > > > > > +{
> > > > > > > > +    struct device *dev = &adev->dev;
> > > > > > > > +    struct coresight_platform_data *pdata;
> > > > > > > > +    struct tpdm_drvdata *drvdata;
> > > > > > > > +    struct coresight_desc desc = { 0 };
> > > > > > > > +
> > > > > > > > +    desc.name = coresight_alloc_device_name(&tpdm_devs, dev);
> > > > > > > > +    if (!desc.name)
> > > > > > > > +            return -ENOMEM;
> > > > > > > > +    pdata = coresight_get_platform_data(dev);
> > > > > > > > +    if (IS_ERR(pdata))
> > > > > > > > +            return PTR_ERR(pdata);
> > > > > > > > +    adev->dev.platform_data = pdata;
> > > > > > > > +
> > > > > > > > +    drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
> > > > > > > > +    if (!drvdata)
> > > > > > > > +            return -ENOMEM;
> > > > > > > > +    drvdata->dev = &adev->dev;
> > > > > > > > +    dev_set_drvdata(dev, drvdata);
> > > > > > > > +
> > > > > > > > +    drvdata->base = devm_ioremap_resource(dev, &adev->res);
> > > > > > > > +    if (!drvdata->base)
> > > > > > > > +            return -ENOMEM;
> > > > > > > > +
> > > > > > > > +    mutex_init(&drvdata->lock);
> > > > > > > > +
> > > > > > > > +    desc.type = CORESIGHT_DEV_TYPE_SOURCE;
> > > > > > > > +    desc.subtype.source_subtype = CORESIGHT_DEV_SUBTYPE_SOURCE_SYS;
> > > > > > > > +    desc.ops = &tpdm_cs_ops;
> > > > > > > > +    desc.pdata = adev->dev.platform_data;
> > > > > > > > +    desc.dev = &adev->dev;
> > > > > > > > +    drvdata->csdev = coresight_register(&desc);
> > > > > > > > +    if (IS_ERR(drvdata->csdev))
> > > > > > > > +            return PTR_ERR(drvdata->csdev);
> > > > > > > > +
> > > > > > > > +    tpdm_init_default_data(drvdata);
> > > > > > > > +    pm_runtime_put(&adev->dev);
> > > > > > > > +
> > > > > > > > +    return 0;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static void __exit tpdm_remove(struct amba_device *adev)
> > > > > > > > +{
> > > > > > > > +    struct tpdm_drvdata *drvdata = dev_get_drvdata(&adev->dev);
> > > > > > > > +
> > > > > > > > +    coresight_unregister(drvdata->csdev);
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +static struct amba_id tpdm_ids[] = {
> > > > > > > > +    {
> > > > > > > > +            .id = 0x000f0e00,
> > > > > > > > +            .mask = 0x000fff00,
> > > > > > > > +    },
> > > > > > > > +    { 0, 0},
> > > > > > > > +};
> > > > > > > > +
> > > > > > > > +static struct amba_driver tpdm_driver = {
> > > > > > > > +    .drv = {
> > > > > > > > +            .name   = "coresight-tpdm",
> > > > > > > > +            .owner  = THIS_MODULE,
> > > > > > > > +            .suppress_bind_attrs = true,
> > > > > > > > +    },
> > > > > > > > +    .probe          = tpdm_probe,
> > > > > > > > +    .id_table       = tpdm_ids,
> > > > > > > > +};
> > > > > > > > +
> > > > > > > > +module_amba_driver(tpdm_driver);
> > > > > > > > +
> > > > > > > > +MODULE_LICENSE("GPL v2");
> > > > > > > > +MODULE_DESCRIPTION("Trace, Profiling & Diagnostic Monitor driver");
> > > > > > > > diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
> > > > > > > > new file mode 100644
> > > > > > > > index 000000000000..980ae90ff1c8
> > > > > > > > --- /dev/null
> > > > > > > > +++ b/drivers/hwtracing/coresight/coresight-tpdm.h
> > > > > > > > @@ -0,0 +1,31 @@
> > > > > > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > > > > > +/*
> > > > > > > > + * Copyright (c) 2021 Qualcomm Innovation Center, Inc. All rights reserved.
> > > > > > > > + */
> > > > > > > > +
> > > > > > > > +#ifndef _CORESIGHT_CORESIGHT_TPDM_H
> > > > > > > > +#define _CORESIGHT_CORESIGHT_TPDM_H
> > > > > > > > +
> > > > > > > > +/* Default value of the traceid */
> > > > > > > > +#define TPDM_TRACE_ID_START 128
> > > > > > > > +
> > > > > > > > +/**
> > > > > > > > + * struct tpdm_drvdata - specifics associated to an TPDM component
> > > > > > > > + * @base:       memory mapped base address for this component.
> > > > > > > > + * @dev:        The device entity associated to this component.
> > > > > > > > + * @csdev:      component vitals needed by the framework.
> > > > > > > > + * @lock:       lock for the enable value.
> > > > > > > > + * @enable:     enable status of the component.
> > > > > > > > + * @traceid:    value of the current ID for this component.
> > > > > > > > + */
> > > > > > > > +
> > > > > > > > +struct tpdm_drvdata {
> > > > > > > > +    void __iomem            *base;
> > > > > > > > +    struct device           *dev;
> > > > > > > > +    struct coresight_device *csdev;
> > > > > > > > +    struct mutex            lock;
> > > > > > > > +    bool                    enable;
> > > > > > > > +    int                     traceid;
> > > > > > > > +};
> > > > > > > > +
> > > > > > > > +#endif  /* _CORESIGHT_CORESIGHT_TPDM_H */
> > > > > > > > diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> > > > > > > > index 93a2922b7653..e48d463be63b 100644
> > > > > > > > --- a/include/linux/coresight.h
> > > > > > > > +++ b/include/linux/coresight.h
> > > > > > > > @@ -65,6 +65,7 @@ enum coresight_dev_subtype_source {
> > > > > > > >        CORESIGHT_DEV_SUBTYPE_SOURCE_PROC,
> > > > > > > >        CORESIGHT_DEV_SUBTYPE_SOURCE_BUS,
> > > > > > > >        CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE,
> > > > > > > > +    CORESIGHT_DEV_SUBTYPE_SOURCE_SYS,
> > > > > > > >     };
> > > > > > > > 
> > > > > > > >     enum coresight_dev_subtype_helper {
> > > > > > > > --
> > > > > > > > 2.17.1
> > > > > > > > 
> > > > > 
> > > > > -- 
> > > > > Mike Leach
> > > > > Principal Engineer, ARM Ltd.
> > > > > Manchester Design Centre. UK
