Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9994F6C19
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235144AbiDFVIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235367AbiDFVIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:08:15 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DBA1A8446
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 12:45:34 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j12so4765860wrb.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 12:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iI07HBj5WHTeMgx9RgQ2jLyu65z2I73PH6cCA8YjvMA=;
        b=P0qOKWivskhrziaNGTbc5ViVL9rYPSwcg2tPJ0Ok/8/4X4rXBnEjpJz3NN/3MwxaA4
         /LoIcd9MYxORyfdXaZaMvEOiojoErXtVxUXZmYED788gClLhD9T3BfouhcuFggE0IkjG
         lcp1nioGZS8oFpJoHf5IAm9+MzHSbNsxEJk6uy/N2tzCU7slEmnbQfXqNhQNYLCmYGIQ
         7Zw/MDMSAdy//3ET7cKtI69sIsYU+NLOVP63n8FlQ0hQXjHR5nbZmvADWaR4nFhgkEbI
         9m4+L1ORkrrJCCD7StZLaru4cOlz5x9p1h5kEKu7qzAMG847zXdhMJb6P7lPnt7zYuo1
         xvQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iI07HBj5WHTeMgx9RgQ2jLyu65z2I73PH6cCA8YjvMA=;
        b=uLoAg8Fg92uJi4YX/VEUrssQbgY/mLQ7CTEyurKHpcZxiL96c9cF3erUYbInt1oWt/
         sGrT+4if42pdyNsCQtfKH3Tx+dTlem8+/+wX8jG83VXL8qsU9D+pBfPFWCafPuBFtU+D
         WO//qkwA/zPxJ5r71yMhwGjUmZjMX4fBxSMdzU7c4PTBNWk+FDYAgErLq+CKDiAiKFzC
         3mxYfBXcH67dh0kZofMNzlP3dmpQK4b/WcrhLadYgDP80fXrBSLl3mdcqR2NFKmOnEAs
         8ybRLkpk7gdpvEokxGyexvNWsg0hztsCfRTKHLkZ+Y7Icj9mD6rw/y84j0e6DY53chPo
         S9/w==
X-Gm-Message-State: AOAM531lYihqlFAEU0udHsXbINZ4s1il2zJOIEpeYvMOQ9F0RyxkZ5uz
        Hynp6FVzfisNU1UYq8k0ueQhHYMqUb6nFOuFrJbcFQ==
X-Google-Smtp-Source: ABdhPJwxZL47hoKgH4O9BAj24V2CIHGKBmEx3g8s24+COPLq4L0v30hUBnDRG8g5VtJGcTyY1A7W/YG4D2/OR8Kx7Jk=
X-Received: by 2002:a05:6000:2c9:b0:204:1675:843e with SMTP id
 o9-20020a05600002c900b002041675843emr7857521wry.699.1649274332650; Wed, 06
 Apr 2022 12:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220308205000.27646-1-mike.leach@linaro.org> <20220308205000.27646-2-mike.leach@linaro.org>
 <20220405170223.GA4151723@p14s>
In-Reply-To: <20220405170223.GA4151723@p14s>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Wed, 6 Apr 2022 20:45:21 +0100
Message-ID: <CAJ9a7Vhc1qCST=jq-Qaa49SEohvGpV3k8pnwgjgZmVFnvU7giw@mail.gmail.com>
Subject: Re: [PATCH 01/10] coresight: trace-id: Add API to dynamically assign
 trace ID values
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org
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

Hi Mathieu,

On Tue, 5 Apr 2022 at 18:02, Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
>
> Good morning,
>
> To avoid getting tunnel vision, I haven't red any of the comments already posted
> about this set.  As such some of my observations may be redundant.
>
> On Tue, Mar 08, 2022 at 08:49:51PM +0000, Mike Leach wrote:
> > The existing mechanism to assign Trace ID values to sources is limited
> > and does not scale for larger multicore / multi trace source systems.
> >
> > The API introduces functions that reserve IDs based on availabilty
> > represented by a coresight_trace_id_map structure. This records the
> > used and free IDs in a bitmap.
> >
> > CPU bound sources such as ETMs use the coresight_trace_id_get_cpu_id /
> > coresight_trace_id_put_cpu_id pair of functions. The API will record
> > the ID associated with the CPU. This ensures that the same ID will be
> > re-used while perf events are active on the CPU. The put_cpu_id function
> > will pend release of the ID until all perf cs_etm sessions are complete.
> >
> > Non-cpu sources, such as the STM can use coresight_trace_id_get_system_id /
> > coresight_trace_id_put_system_id.
> >
> > Signed-off-by: Mike Leach <mike.leach@linaro.org>
> > ---
> >  drivers/hwtracing/coresight/Makefile          |   2 +-
> >  .../hwtracing/coresight/coresight-trace-id.c  | 222 ++++++++++++++++++
> >  .../hwtracing/coresight/coresight-trace-id.h  |  69 ++++++
> >  3 files changed, 292 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/hwtracing/coresight/coresight-trace-id.c
> >  create mode 100644 drivers/hwtracing/coresight/coresight-trace-id.h
> >
> > diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
> > index b6c4a48140ec..329a0c704b87 100644
> > --- a/drivers/hwtracing/coresight/Makefile
> > +++ b/drivers/hwtracing/coresight/Makefile
> > @@ -6,7 +6,7 @@ obj-$(CONFIG_CORESIGHT) += coresight.o
> >  coresight-y := coresight-core.o  coresight-etm-perf.o coresight-platform.o \
> >               coresight-sysfs.o coresight-syscfg.o coresight-config.o \
> >               coresight-cfg-preload.o coresight-cfg-afdo.o \
> > -             coresight-syscfg-configfs.o
> > +             coresight-syscfg-configfs.o coresight-trace-id.o
> >  obj-$(CONFIG_CORESIGHT_LINK_AND_SINK_TMC) += coresight-tmc.o
> >  coresight-tmc-y := coresight-tmc-core.o coresight-tmc-etf.o \
> >                     coresight-tmc-etr.o
> > diff --git a/drivers/hwtracing/coresight/coresight-trace-id.c b/drivers/hwtracing/coresight/coresight-trace-id.c
> > new file mode 100644
> > index 000000000000..ce6c7d7b55d6
> > --- /dev/null
> > +++ b/drivers/hwtracing/coresight/coresight-trace-id.c
> > @@ -0,0 +1,222 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2022, Linaro Limited, All rights reserved.
> > + * Author: Mike Leach <mike.leach@linaro.org>
> > + */
> > +#include <linux/kernel.h>
> > +#include <linux/types.h>
> > +#include <linux/spinlock.h>
> > +
> > +#include "coresight-trace-id.h"
> > +
> > +/* need to keep data on ids & association with cpus. */
> > +struct cpu_id_info {
> > +     int id;
> > +     bool pend_rel;
> > +};
> > +
> > +/* maintain a record of the current mapping of cpu IDs */
> > +static DEFINE_PER_CPU(struct cpu_id_info, cpu_ids);
> > +
> > +/* a list of currently used id_maps */
> > +static LIST_HEAD(id_map_list);
> > +
> > +/* perf session active flag */
> > +static int perf_cs_etm_session_active;
> > +
> > +/* lock to protect id_map list and cpu data  */
> > +static DEFINE_SPINLOCK(id_map_lock);
> > +
> > +/* ID 0 is reserved */
> > +#define CORESIGHT_TRACE_ID_RES_0 0
> > +
> > +/* ID 0x70 onwards are reserved */
> > +#define CORESIGHT_TRACE_ID_RES_RANGE_LO 0x70
> > +#define CORESIGHT_TRACE_ID_RES_RANGE_HI 0x7F
> > +
> > +#define IS_VALID_ID(id)      \
> > +     ((id > CORESIGHT_TRACE_ID_RES_0) && (id < CORESIGHT_TRACE_ID_RES_RANGE_LO))
> > +
> > +static void coresight_trace_id_set_inuse(int id, struct coresight_trace_id_map *id_map)
> > +{
> > +     if (IS_VALID_ID(id))
> > +             set_bit(id, id_map->avail_ids);
> > +}
> > +
> > +static void coresight_trace_id_clear_inuse(int id, struct coresight_trace_id_map *id_map)
> > +{
> > +     if (IS_VALID_ID(id))
> > +             clear_bit(id, id_map->avail_ids);
> > +}
> > +
> > +static void coresight_trace_id_set_pend_rel(int id, struct coresight_trace_id_map *id_map)
> > +{
> > +     if (IS_VALID_ID(id))
> > +             set_bit(id, id_map->pend_rel_ids);
> > +}
> > +
> > +static void coresight_trace_id_clear_pend_rel(int id, struct coresight_trace_id_map *id_map)
> > +{
> > +     if (IS_VALID_ID(id))
> > +             clear_bit(id, id_map->pend_rel_ids);
> > +}
> > +
> > +static int coresight_trace_id_find_new_id(struct coresight_trace_id_map *id_map)
> > +{
> > +     int id;
> > +
> > +     id = find_first_zero_bit(id_map->avail_ids, CORESIGHT_TRACE_IDS_MAX);
> > +     if (id >= CORESIGHT_TRACE_IDS_MAX)
> > +             id = -EINVAL;
> > +     return id;
> > +}
> > +
> > +/* release all pending IDs for all current maps & clear CPU associations */
> > +static void coresight_trace_id_release_all_pending(void)
> > +{
> > +     struct coresight_trace_id_map *id_map;
> > +     int cpu, bit;
> > +
> > +     list_for_each_entry(id_map, &id_map_list, node) {
> > +             for_each_set_bit(bit, id_map->pend_rel_ids, CORESIGHT_TRACE_IDS_MAX) {
> > +                     clear_bit(bit, id_map->avail_ids);
> > +                     clear_bit(bit, id_map->pend_rel_ids);
> > +             }
> > +     }
> > +
> > +     for_each_possible_cpu(cpu) {
> > +             if (per_cpu(cpu_ids, cpu).pend_rel) {
> > +                     per_cpu(cpu_ids, cpu).pend_rel = false;
> > +                     per_cpu(cpu_ids, cpu).id = 0;
> > +             }
> > +     }
> > +}
> > +
> > +int coresight_trace_id_get_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
> > +{
> > +     unsigned long flags;
> > +     int id;
> > +
> > +     spin_lock_irqsave(&id_map_lock, flags);
> > +     id = per_cpu(cpu_ids, cpu).id;
> > +     if (!id) {
> > +             id = coresight_trace_id_find_new_id(id_map);
> > +             if (id < 0)
> > +                     goto get_cpu_id_out;
> > +     }
> > +
> > +     per_cpu(cpu_ids, cpu).id = id;
> > +     per_cpu(cpu_ids, cpu).pend_rel = false;
> > +     coresight_trace_id_set_inuse(id, id_map);
> > +     coresight_trace_id_clear_pend_rel(id, id_map);
>
> The above should have been done when the ID for this CPU has been set for the
> first time.  Therefore we should simply release the spinlock and return if an ID
> has already been set.
>

Agreed.

> > +
> > +get_cpu_id_out:
> > +     spin_unlock_irqrestore(&id_map_lock, flags);
> > +     return id;
> > +}
> > +EXPORT_SYMBOL_GPL(coresight_trace_id_get_cpu_id);
> > +
> > +void coresight_trace_id_put_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
> > +{
> > +     unsigned long flags;
> > +     int id;
> > +
> > +     spin_lock_irqsave(&id_map_lock, flags);
> > +     id = per_cpu(cpu_ids, cpu).id;
> > +     if (!id)
> > +             goto put_cpu_id_out;
> > +
> > +     if (perf_cs_etm_session_active) {
> > +             /* set release at pending if perf still active */
> > +             coresight_trace_id_set_pend_rel(id, id_map);
> > +             per_cpu(cpu_ids, cpu).pend_rel = true;
> > +     } else {
> > +             /* otherwise clear id */
> > +             coresight_trace_id_clear_inuse(id, id_map);
> > +             per_cpu(cpu_ids, cpu).id = 0;
> > +     }
> > +
> > + put_cpu_id_out:
> > +     spin_unlock_irqrestore(&id_map_lock, flags);
> > +}
> > +EXPORT_SYMBOL_GPL(coresight_trace_id_put_cpu_id);
> > +
> > +int coresight_trace_id_get_system_id(struct coresight_trace_id_map *id_map)
> > +{
>
> So far I have reviewed until patch 05 and I find passing the id_map every time
> we need an ID quite heavy, especially since it is always the same one.
>

My initital thought was to ensure that the API would handle the
forthcoming requirements for per-sink id maps without having to change
too much code, both within the API and the client code.

However an alternative method could be to drop the id_map passing in
the external API calls - simplifying it and the client code, and
simply extend the API once passing in the id_map is really required.
This would mean being able to drop the list of maps for now, use a
default id_map withing the ID map code. However I would retain the
passing of the id_map for the internal functions as I feel it is
better practice to have functions operate on data passed to them
rather then a global blob.

Regards

Mike

> > +     unsigned long flags;
> > +     int id;
> > +
> > +     spin_lock_irqsave(&id_map_lock, flags);
> > +     id = coresight_trace_id_find_new_id(id_map);
> > +     if (id > 0)
> > +             coresight_trace_id_set_inuse(id, id_map);
> > +     spin_unlock_irqrestore(&id_map_lock, flags);
> > +
> > +     return id;
> > +}
> > +EXPORT_SYMBOL_GPL(coresight_trace_id_get_system_id);
> > +
> > +void coresight_trace_id_put_system_id(struct coresight_trace_id_map *id_map, int id)
> > +{
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&id_map_lock, flags);
> > +     coresight_trace_id_clear_inuse(id, id_map);
> > +     spin_unlock_irqrestore(&id_map_lock, flags);
> > +}
> > +EXPORT_SYMBOL_GPL(coresight_trace_id_put_system_id);
> > +
> > +void coresight_trace_id_perf_start(void)
> > +{
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&id_map_lock, flags);
> > +     perf_cs_etm_session_active++;
> > +     spin_unlock_irqrestore(&id_map_lock, flags);
> > +}
> > +EXPORT_SYMBOL_GPL(coresight_trace_id_perf_start);
> > +
> > +void coresight_trace_id_perf_stop(void)
> > +{
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&id_map_lock, flags);
> > +     perf_cs_etm_session_active--;
> > +     if (!perf_cs_etm_session_active)
> > +             coresight_trace_id_release_all_pending();
> > +     spin_unlock_irqrestore(&id_map_lock, flags);
> > +}
> > +EXPORT_SYMBOL_GPL(coresight_trace_id_perf_stop);
> > +
> > +void coresight_trace_id_init_id_map(struct coresight_trace_id_map *id_map)
> > +{
> > +     unsigned long flags;
> > +     int bit;
> > +
> > +     /* set all reserved bits as in-use */
> > +     set_bit(CORESIGHT_TRACE_ID_RES_0, id_map->avail_ids);
> > +     for (bit = CORESIGHT_TRACE_ID_RES_RANGE_LO;
> > +          bit <= CORESIGHT_TRACE_ID_RES_RANGE_HI; bit++)
> > +             set_bit(bit, id_map->avail_ids);
> > +
> > +     spin_lock_irqsave(&id_map_lock, flags);
> > +
> > +     /* add id_map to the list */
> > +     list_add(&id_map->node, &id_map_list);
> > +
> > +     spin_unlock_irqrestore(&id_map_lock, flags);
> > +}
> > +EXPORT_SYMBOL_GPL(coresight_trace_id_init_id_map);
> > +
> > +void coresight_trace_id_release_id_map(struct coresight_trace_id_map *id_map)
> > +{
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&id_map_lock, flags);
> > +
> > +     /* remove id_map from list */
> > +     list_del(&id_map->node);
> > +
> > +     spin_unlock_irqrestore(&id_map_lock, flags);
> > +}
> > +EXPORT_SYMBOL_GPL(coresight_trace_id_release_id_map);
> > diff --git a/drivers/hwtracing/coresight/coresight-trace-id.h b/drivers/hwtracing/coresight/coresight-trace-id.h
> > new file mode 100644
> > index 000000000000..01db2441cee6
> > --- /dev/null
> > +++ b/drivers/hwtracing/coresight/coresight-trace-id.h
> > @@ -0,0 +1,69 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright(C) 2022 Linaro Limited. All rights reserved.
> > + * Author: Mike Leach <mike.leach@linaro.org>
> > + */
> > +
> > +#ifndef _CORESIGHT_TRACE_ID_H
> > +#define _CORESIGHT_TRACE_ID_H
> > +
> > +/*
> > + * Coresight trace ID allocation API
> > + *
> > + * With multi cpu systems, and more additional trace sources a scalable
> > + * trace ID reservation system is required.
> > + *
> > + * The system will allocate Ids on a demand basis, and allow them to be
> > + * released when done.
> > + *
> > + * In order to ensure that a consistent cpu / ID matching is maintained
> > + * throughout a perf cs_etm event session - a session in progress flag will
> > + * be maintained, and released IDs not cleared until the perf session is
> > + * complete. This allows the same CPU to be re-allocated its prior ID.
> > + *
> > + *
> > + * Trace ID maps will be created and initialised to prevent architecturally
> > + * reserved IDs from being allocated.
> > + *
> > + * API permits multiple maps to be maintained - for large systems where
> > + * different sets of cpus trace into different independent sinks.
> > + */
> > +
> > +#include <linux/bitops.h>
> > +#include <linux/types.h>
> > +
> > +
> > +/* architecturally we have 128 IDs some of which are reserved */
> > +#define CORESIGHT_TRACE_IDS_MAX 128
> > +
> > +/**
> > + * Trace ID map.
> > + *
> > + * @avail_ids:       Bitmap to register available (bit = 0) and in use (bit = 1) IDs.
> > + *           Initialised so that the reserved IDs are permanently marked as in use.
> > + * @pend_rel_ids: CPU IDs that have been released by the trace source but not yet marked
> > + *                as available, to allow re-allocation to the same CPU during a perf session.
> > + * @node:    List entry to add to list of managed trace id maps.
> > + */
> > +struct coresight_trace_id_map {
> > +     DECLARE_BITMAP(avail_ids, CORESIGHT_TRACE_IDS_MAX);
> > +     DECLARE_BITMAP(pend_rel_ids, CORESIGHT_TRACE_IDS_MAX);
> > +     struct list_head node;
> > +};
> > +
> > +/* Allocate and release IDs */
> > +int coresight_trace_id_get_cpu_id(int cpu, struct coresight_trace_id_map *id_map);
> > +int coresight_trace_id_get_system_id(struct coresight_trace_id_map *id_map);
> > +void coresight_trace_id_put_cpu_id(int cpu, struct coresight_trace_id_map *id_map);
> > +void coresight_trace_id_put_system_id(struct coresight_trace_id_map *id_map, int id);
> > +
> > +/* initialise ID map - block reserved IDs, add to list of ID maps */
> > +void coresight_trace_id_init_id_map(struct coresight_trace_id_map *id_map);
> > +/* remove ID maps from list of maps */
> > +void coresight_trace_id_release_id_map(struct coresight_trace_id_map *id_map);
> > +
> > +/* notifiers for perf session start and stop */
> > +void coresight_trace_id_perf_start(void);
> > +void coresight_trace_id_perf_stop(void);
> > +
> > +#endif /* _CORESIGHT_TRACE_ID_H */
> > --
> > 2.17.1
> >



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
