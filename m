Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24C54F86EB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 20:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346772AbiDGSKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 14:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbiDGSKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 14:10:39 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923DD21796F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 11:08:37 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id z16so6184810pfh.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 11:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/y+I2irHgSpeuvIioppOP/qTwcbi047VDhezyO8y4Uw=;
        b=F4U4px9PoAe4WH8ghwMXXqUXryp4lJIl8nvLjOtp8yOgaJEI0+2Qx2ffGLqRGiSBUi
         jW8WawAAK9l0eZdQtVq5ud94oWvtb+b73RnJkigmb400CufRaL7wEEjxPHw26BJa06wh
         dPtYOJdSTq4IE0SyXFe7nbcdBock9LepsO9BqaZTegq+LqfoFl45jwP44ejnAv/Aerev
         70RgcVVMocPJYNnKGacYwEK1kblo9U63qBMfC+LuCzo9qDtFmVd5pbgdgUsPYTMXofV+
         IgTm34Sb+ZCZVsgwGDJJvLiNTYoUxHxIMQsGHR8dA8mJ2LvkzU55KyeumJ6DvIKBl2F4
         oJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/y+I2irHgSpeuvIioppOP/qTwcbi047VDhezyO8y4Uw=;
        b=KPM+cxD1xhSZDlUtdbLpc6HVePVCDl3IxkFKl07MkzSdTteZSYjnarXA83RCiBbudQ
         cTFAPukU5klCd7/pJN1GdOVJ7b2EYtBX5k/2muIcjvvaiUFQ2WwBp1dxxxdAd6BW0Urg
         sm/fWGYekQRrWxOWm508yeH0IkP7lYxhWD2f410xwEHTETmDVzzJ5JVK0RDl/o+xjK6v
         LrDkl7K2tNj1XRxtJQfeKqdD2F0G9STVq7Z/FefTbwHro+N5OXPABsdyGxYsTd6rLYXH
         LMdR2VyM+6a7DDKpmdq9bodrb0LVvccoSmxlcNv9HY/Ov3KOIPjafRXDSJxOnrCJhVEo
         d0XQ==
X-Gm-Message-State: AOAM533ZbiF8lOkclFrRX+ZqPqgWVQyZp2p0M4qeolO784Bs0FgyBmHd
        aK/19uJlRKOmnXobd55Nemy5kQ==
X-Google-Smtp-Source: ABdhPJyRZXngtVbN34YXtSd2ia8wOmctP6eOaF60YtZ3OBVr48GlV264bHlGcjrL8ulr5Iw78Z/RZQ==
X-Received: by 2002:a63:6a85:0:b0:398:9e2b:afd6 with SMTP id f127-20020a636a85000000b003989e2bafd6mr12435658pgc.582.1649354916875;
        Thu, 07 Apr 2022 11:08:36 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id u3-20020a17090add4300b001ca56ea162bsm9155086pjv.33.2022.04.07.11.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 11:08:35 -0700 (PDT)
Date:   Thu, 7 Apr 2022 12:08:33 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org
Subject: Re: [PATCH 01/10] coresight: trace-id: Add API to dynamically assign
 trace ID values
Message-ID: <20220407180833.GB102085@p14s>
References: <20220308205000.27646-1-mike.leach@linaro.org>
 <20220308205000.27646-2-mike.leach@linaro.org>
 <20220405170223.GA4151723@p14s>
 <CAJ9a7Vhc1qCST=jq-Qaa49SEohvGpV3k8pnwgjgZmVFnvU7giw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ9a7Vhc1qCST=jq-Qaa49SEohvGpV3k8pnwgjgZmVFnvU7giw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 08:45:21PM +0100, Mike Leach wrote:
> Hi Mathieu,
> 
> On Tue, 5 Apr 2022 at 18:02, Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
> >
> > Good morning,
> >
> > To avoid getting tunnel vision, I haven't red any of the comments already posted
> > about this set.  As such some of my observations may be redundant.
> >
> > On Tue, Mar 08, 2022 at 08:49:51PM +0000, Mike Leach wrote:
> > > The existing mechanism to assign Trace ID values to sources is limited
> > > and does not scale for larger multicore / multi trace source systems.
> > >
> > > The API introduces functions that reserve IDs based on availabilty
> > > represented by a coresight_trace_id_map structure. This records the
> > > used and free IDs in a bitmap.
> > >
> > > CPU bound sources such as ETMs use the coresight_trace_id_get_cpu_id /
> > > coresight_trace_id_put_cpu_id pair of functions. The API will record
> > > the ID associated with the CPU. This ensures that the same ID will be
> > > re-used while perf events are active on the CPU. The put_cpu_id function
> > > will pend release of the ID until all perf cs_etm sessions are complete.
> > >
> > > Non-cpu sources, such as the STM can use coresight_trace_id_get_system_id /
> > > coresight_trace_id_put_system_id.
> > >
> > > Signed-off-by: Mike Leach <mike.leach@linaro.org>
> > > ---
> > >  drivers/hwtracing/coresight/Makefile          |   2 +-
> > >  .../hwtracing/coresight/coresight-trace-id.c  | 222 ++++++++++++++++++
> > >  .../hwtracing/coresight/coresight-trace-id.h  |  69 ++++++
> > >  3 files changed, 292 insertions(+), 1 deletion(-)
> > >  create mode 100644 drivers/hwtracing/coresight/coresight-trace-id.c
> > >  create mode 100644 drivers/hwtracing/coresight/coresight-trace-id.h
> > >
> > > diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
> > > index b6c4a48140ec..329a0c704b87 100644
> > > --- a/drivers/hwtracing/coresight/Makefile
> > > +++ b/drivers/hwtracing/coresight/Makefile
> > > @@ -6,7 +6,7 @@ obj-$(CONFIG_CORESIGHT) += coresight.o
> > >  coresight-y := coresight-core.o  coresight-etm-perf.o coresight-platform.o \
> > >               coresight-sysfs.o coresight-syscfg.o coresight-config.o \
> > >               coresight-cfg-preload.o coresight-cfg-afdo.o \
> > > -             coresight-syscfg-configfs.o
> > > +             coresight-syscfg-configfs.o coresight-trace-id.o
> > >  obj-$(CONFIG_CORESIGHT_LINK_AND_SINK_TMC) += coresight-tmc.o
> > >  coresight-tmc-y := coresight-tmc-core.o coresight-tmc-etf.o \
> > >                     coresight-tmc-etr.o
> > > diff --git a/drivers/hwtracing/coresight/coresight-trace-id.c b/drivers/hwtracing/coresight/coresight-trace-id.c
> > > new file mode 100644
> > > index 000000000000..ce6c7d7b55d6
> > > --- /dev/null
> > > +++ b/drivers/hwtracing/coresight/coresight-trace-id.c
> > > @@ -0,0 +1,222 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (c) 2022, Linaro Limited, All rights reserved.
> > > + * Author: Mike Leach <mike.leach@linaro.org>
> > > + */
> > > +#include <linux/kernel.h>
> > > +#include <linux/types.h>
> > > +#include <linux/spinlock.h>
> > > +
> > > +#include "coresight-trace-id.h"
> > > +
> > > +/* need to keep data on ids & association with cpus. */
> > > +struct cpu_id_info {
> > > +     int id;
> > > +     bool pend_rel;
> > > +};
> > > +
> > > +/* maintain a record of the current mapping of cpu IDs */
> > > +static DEFINE_PER_CPU(struct cpu_id_info, cpu_ids);
> > > +
> > > +/* a list of currently used id_maps */
> > > +static LIST_HEAD(id_map_list);
> > > +
> > > +/* perf session active flag */
> > > +static int perf_cs_etm_session_active;
> > > +
> > > +/* lock to protect id_map list and cpu data  */
> > > +static DEFINE_SPINLOCK(id_map_lock);
> > > +
> > > +/* ID 0 is reserved */
> > > +#define CORESIGHT_TRACE_ID_RES_0 0
> > > +
> > > +/* ID 0x70 onwards are reserved */
> > > +#define CORESIGHT_TRACE_ID_RES_RANGE_LO 0x70
> > > +#define CORESIGHT_TRACE_ID_RES_RANGE_HI 0x7F
> > > +
> > > +#define IS_VALID_ID(id)      \
> > > +     ((id > CORESIGHT_TRACE_ID_RES_0) && (id < CORESIGHT_TRACE_ID_RES_RANGE_LO))
> > > +
> > > +static void coresight_trace_id_set_inuse(int id, struct coresight_trace_id_map *id_map)
> > > +{
> > > +     if (IS_VALID_ID(id))
> > > +             set_bit(id, id_map->avail_ids);
> > > +}
> > > +
> > > +static void coresight_trace_id_clear_inuse(int id, struct coresight_trace_id_map *id_map)
> > > +{
> > > +     if (IS_VALID_ID(id))
> > > +             clear_bit(id, id_map->avail_ids);
> > > +}
> > > +
> > > +static void coresight_trace_id_set_pend_rel(int id, struct coresight_trace_id_map *id_map)
> > > +{
> > > +     if (IS_VALID_ID(id))
> > > +             set_bit(id, id_map->pend_rel_ids);
> > > +}
> > > +
> > > +static void coresight_trace_id_clear_pend_rel(int id, struct coresight_trace_id_map *id_map)
> > > +{
> > > +     if (IS_VALID_ID(id))
> > > +             clear_bit(id, id_map->pend_rel_ids);
> > > +}
> > > +
> > > +static int coresight_trace_id_find_new_id(struct coresight_trace_id_map *id_map)
> > > +{
> > > +     int id;
> > > +
> > > +     id = find_first_zero_bit(id_map->avail_ids, CORESIGHT_TRACE_IDS_MAX);
> > > +     if (id >= CORESIGHT_TRACE_IDS_MAX)
> > > +             id = -EINVAL;
> > > +     return id;
> > > +}
> > > +
> > > +/* release all pending IDs for all current maps & clear CPU associations */
> > > +static void coresight_trace_id_release_all_pending(void)
> > > +{
> > > +     struct coresight_trace_id_map *id_map;
> > > +     int cpu, bit;
> > > +
> > > +     list_for_each_entry(id_map, &id_map_list, node) {
> > > +             for_each_set_bit(bit, id_map->pend_rel_ids, CORESIGHT_TRACE_IDS_MAX) {
> > > +                     clear_bit(bit, id_map->avail_ids);
> > > +                     clear_bit(bit, id_map->pend_rel_ids);
> > > +             }
> > > +     }
> > > +
> > > +     for_each_possible_cpu(cpu) {
> > > +             if (per_cpu(cpu_ids, cpu).pend_rel) {
> > > +                     per_cpu(cpu_ids, cpu).pend_rel = false;
> > > +                     per_cpu(cpu_ids, cpu).id = 0;
> > > +             }
> > > +     }
> > > +}
> > > +
> > > +int coresight_trace_id_get_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
> > > +{
> > > +     unsigned long flags;
> > > +     int id;
> > > +
> > > +     spin_lock_irqsave(&id_map_lock, flags);
> > > +     id = per_cpu(cpu_ids, cpu).id;
> > > +     if (!id) {
> > > +             id = coresight_trace_id_find_new_id(id_map);
> > > +             if (id < 0)
> > > +                     goto get_cpu_id_out;
> > > +     }
> > > +
> > > +     per_cpu(cpu_ids, cpu).id = id;
> > > +     per_cpu(cpu_ids, cpu).pend_rel = false;
> > > +     coresight_trace_id_set_inuse(id, id_map);
> > > +     coresight_trace_id_clear_pend_rel(id, id_map);
> >
> > The above should have been done when the ID for this CPU has been set for the
> > first time.  Therefore we should simply release the spinlock and return if an ID
> > has already been set.
> >
> 
> Agreed.
> 
> > > +
> > > +get_cpu_id_out:
> > > +     spin_unlock_irqrestore(&id_map_lock, flags);
> > > +     return id;
> > > +}
> > > +EXPORT_SYMBOL_GPL(coresight_trace_id_get_cpu_id);
> > > +
> > > +void coresight_trace_id_put_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
> > > +{
> > > +     unsigned long flags;
> > > +     int id;
> > > +
> > > +     spin_lock_irqsave(&id_map_lock, flags);
> > > +     id = per_cpu(cpu_ids, cpu).id;
> > > +     if (!id)
> > > +             goto put_cpu_id_out;
> > > +
> > > +     if (perf_cs_etm_session_active) {
> > > +             /* set release at pending if perf still active */
> > > +             coresight_trace_id_set_pend_rel(id, id_map);
> > > +             per_cpu(cpu_ids, cpu).pend_rel = true;
> > > +     } else {
> > > +             /* otherwise clear id */
> > > +             coresight_trace_id_clear_inuse(id, id_map);
> > > +             per_cpu(cpu_ids, cpu).id = 0;
> > > +     }
> > > +
> > > + put_cpu_id_out:
> > > +     spin_unlock_irqrestore(&id_map_lock, flags);
> > > +}
> > > +EXPORT_SYMBOL_GPL(coresight_trace_id_put_cpu_id);
> > > +
> > > +int coresight_trace_id_get_system_id(struct coresight_trace_id_map *id_map)
> > > +{
> >
> > So far I have reviewed until patch 05 and I find passing the id_map every time
> > we need an ID quite heavy, especially since it is always the same one.
> >
> 
> My initital thought was to ensure that the API would handle the
> forthcoming requirements for per-sink id maps without having to change
> too much code, both within the API and the client code.

I think going with a perf-sink id map would fix a lot of
problems.  The id map would need to be linked with the perf session, as we
already do with sink buffers, i.e CPUs in the same perf session id would get the
same id map.  

In etm_event_start() a CPU's traceID could be fetch from the etm_event_data and
sent down to the driver with an additional parameter to source_ops()->enable().

I am done revewing this set.

Thanks,
Mathieu

> 
> However an alternative method could be to drop the id_map passing in
> the external API calls - simplifying it and the client code, and
> simply extend the API once passing in the id_map is really required.
> This would mean being able to drop the list of maps for now, use a
> default id_map withing the ID map code. However I would retain the
> passing of the id_map for the internal functions as I feel it is
> better practice to have functions operate on data passed to them
> rather then a global blob.
> 
> Regards
> 
> Mike
> 
> > > +     unsigned long flags;
> > > +     int id;
> > > +
> > > +     spin_lock_irqsave(&id_map_lock, flags);
> > > +     id = coresight_trace_id_find_new_id(id_map);
> > > +     if (id > 0)
> > > +             coresight_trace_id_set_inuse(id, id_map);
> > > +     spin_unlock_irqrestore(&id_map_lock, flags);
> > > +
> > > +     return id;
> > > +}
> > > +EXPORT_SYMBOL_GPL(coresight_trace_id_get_system_id);
> > > +
> > > +void coresight_trace_id_put_system_id(struct coresight_trace_id_map *id_map, int id)
> > > +{
> > > +     unsigned long flags;
> > > +
> > > +     spin_lock_irqsave(&id_map_lock, flags);
> > > +     coresight_trace_id_clear_inuse(id, id_map);
> > > +     spin_unlock_irqrestore(&id_map_lock, flags);
> > > +}
> > > +EXPORT_SYMBOL_GPL(coresight_trace_id_put_system_id);
> > > +
> > > +void coresight_trace_id_perf_start(void)
> > > +{
> > > +     unsigned long flags;
> > > +
> > > +     spin_lock_irqsave(&id_map_lock, flags);
> > > +     perf_cs_etm_session_active++;
> > > +     spin_unlock_irqrestore(&id_map_lock, flags);
> > > +}
> > > +EXPORT_SYMBOL_GPL(coresight_trace_id_perf_start);
> > > +
> > > +void coresight_trace_id_perf_stop(void)
> > > +{
> > > +     unsigned long flags;
> > > +
> > > +     spin_lock_irqsave(&id_map_lock, flags);
> > > +     perf_cs_etm_session_active--;
> > > +     if (!perf_cs_etm_session_active)
> > > +             coresight_trace_id_release_all_pending();
> > > +     spin_unlock_irqrestore(&id_map_lock, flags);
> > > +}
> > > +EXPORT_SYMBOL_GPL(coresight_trace_id_perf_stop);
> > > +
> > > +void coresight_trace_id_init_id_map(struct coresight_trace_id_map *id_map)
> > > +{
> > > +     unsigned long flags;
> > > +     int bit;
> > > +
> > > +     /* set all reserved bits as in-use */
> > > +     set_bit(CORESIGHT_TRACE_ID_RES_0, id_map->avail_ids);
> > > +     for (bit = CORESIGHT_TRACE_ID_RES_RANGE_LO;
> > > +          bit <= CORESIGHT_TRACE_ID_RES_RANGE_HI; bit++)
> > > +             set_bit(bit, id_map->avail_ids);
> > > +
> > > +     spin_lock_irqsave(&id_map_lock, flags);
> > > +
> > > +     /* add id_map to the list */
> > > +     list_add(&id_map->node, &id_map_list);
> > > +
> > > +     spin_unlock_irqrestore(&id_map_lock, flags);
> > > +}
> > > +EXPORT_SYMBOL_GPL(coresight_trace_id_init_id_map);
> > > +
> > > +void coresight_trace_id_release_id_map(struct coresight_trace_id_map *id_map)
> > > +{
> > > +     unsigned long flags;
> > > +
> > > +     spin_lock_irqsave(&id_map_lock, flags);
> > > +
> > > +     /* remove id_map from list */
> > > +     list_del(&id_map->node);
> > > +
> > > +     spin_unlock_irqrestore(&id_map_lock, flags);
> > > +}
> > > +EXPORT_SYMBOL_GPL(coresight_trace_id_release_id_map);
> > > diff --git a/drivers/hwtracing/coresight/coresight-trace-id.h b/drivers/hwtracing/coresight/coresight-trace-id.h
> > > new file mode 100644
> > > index 000000000000..01db2441cee6
> > > --- /dev/null
> > > +++ b/drivers/hwtracing/coresight/coresight-trace-id.h
> > > @@ -0,0 +1,69 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/*
> > > + * Copyright(C) 2022 Linaro Limited. All rights reserved.
> > > + * Author: Mike Leach <mike.leach@linaro.org>
> > > + */
> > > +
> > > +#ifndef _CORESIGHT_TRACE_ID_H
> > > +#define _CORESIGHT_TRACE_ID_H
> > > +
> > > +/*
> > > + * Coresight trace ID allocation API
> > > + *
> > > + * With multi cpu systems, and more additional trace sources a scalable
> > > + * trace ID reservation system is required.
> > > + *
> > > + * The system will allocate Ids on a demand basis, and allow them to be
> > > + * released when done.
> > > + *
> > > + * In order to ensure that a consistent cpu / ID matching is maintained
> > > + * throughout a perf cs_etm event session - a session in progress flag will
> > > + * be maintained, and released IDs not cleared until the perf session is
> > > + * complete. This allows the same CPU to be re-allocated its prior ID.
> > > + *
> > > + *
> > > + * Trace ID maps will be created and initialised to prevent architecturally
> > > + * reserved IDs from being allocated.
> > > + *
> > > + * API permits multiple maps to be maintained - for large systems where
> > > + * different sets of cpus trace into different independent sinks.
> > > + */
> > > +
> > > +#include <linux/bitops.h>
> > > +#include <linux/types.h>
> > > +
> > > +
> > > +/* architecturally we have 128 IDs some of which are reserved */
> > > +#define CORESIGHT_TRACE_IDS_MAX 128
> > > +
> > > +/**
> > > + * Trace ID map.
> > > + *
> > > + * @avail_ids:       Bitmap to register available (bit = 0) and in use (bit = 1) IDs.
> > > + *           Initialised so that the reserved IDs are permanently marked as in use.
> > > + * @pend_rel_ids: CPU IDs that have been released by the trace source but not yet marked
> > > + *                as available, to allow re-allocation to the same CPU during a perf session.
> > > + * @node:    List entry to add to list of managed trace id maps.
> > > + */
> > > +struct coresight_trace_id_map {
> > > +     DECLARE_BITMAP(avail_ids, CORESIGHT_TRACE_IDS_MAX);
> > > +     DECLARE_BITMAP(pend_rel_ids, CORESIGHT_TRACE_IDS_MAX);
> > > +     struct list_head node;
> > > +};
> > > +
> > > +/* Allocate and release IDs */
> > > +int coresight_trace_id_get_cpu_id(int cpu, struct coresight_trace_id_map *id_map);
> > > +int coresight_trace_id_get_system_id(struct coresight_trace_id_map *id_map);
> > > +void coresight_trace_id_put_cpu_id(int cpu, struct coresight_trace_id_map *id_map);
> > > +void coresight_trace_id_put_system_id(struct coresight_trace_id_map *id_map, int id);
> > > +
> > > +/* initialise ID map - block reserved IDs, add to list of ID maps */
> > > +void coresight_trace_id_init_id_map(struct coresight_trace_id_map *id_map);
> > > +/* remove ID maps from list of maps */
> > > +void coresight_trace_id_release_id_map(struct coresight_trace_id_map *id_map);
> > > +
> > > +/* notifiers for perf session start and stop */
> > > +void coresight_trace_id_perf_start(void);
> > > +void coresight_trace_id_perf_stop(void);
> > > +
> > > +#endif /* _CORESIGHT_TRACE_ID_H */
> > > --
> > > 2.17.1
> > >
> 
> 
> 
> -- 
> Mike Leach
> Principal Engineer, ARM Ltd.
> Manchester Design Centre. UK
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
