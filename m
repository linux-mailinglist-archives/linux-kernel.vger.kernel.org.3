Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89BA58DBAD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 18:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244637AbiHIQL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 12:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbiHIQLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 12:11:54 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E363219C1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 09:11:52 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id r17so17605922lfm.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 09:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ENI5b+/p0O/rYhtzOF+Lh3Dia5iT+fZ6g9G+vQPnlRs=;
        b=ZdUY1IwDhnYs12+XgKAe8WLH0xbjiVpXxvJiedN8pgqTGaei9cbN4iWl5tzgGFc11P
         tMPSPMAOgnXqvwFBZs2egoU9jlBGAOWYlB+wSXrOIXma6rF5prnyPcpjjMwH/ffoYg8/
         +rLeUibDbtyzla05T57Rtcu5Y2xVZjWF4f3Wi092UBOiJ7pq3LmuTXm5hQyMXf9/oAlF
         wg00r5fLuvvq/cig+tnP56qih1hPwSQO8UvfM0ZzyRWqbr4dqH9mjwWdFPKLmUcoUpLq
         u0GQe+4Lw4WY6c/gV6k441YQCzB8aLJNmdnJcEqd1AmaSkex8hJMJfNxBPXtrG+vOQFy
         AmbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ENI5b+/p0O/rYhtzOF+Lh3Dia5iT+fZ6g9G+vQPnlRs=;
        b=eOhHYykS5yoinRqfdKGnlSEZKVgTjmgscqFiUSxjIkf5+EPGBjtF0B4h3h/MraEquv
         eOSqMlWLa+3BqIZds+6hwqZncwd7gSiwCOQVQVCYyANthipmNJZKS1Okv/dWt3Xlw0Gk
         d9/shPYp/gOmyh8JtUxK5crdCMr38Ckc3VDHVJyxxrq6wuPMyeCocSHmXYgYAdEcQ7wT
         ZGFZn+VzhFO/BEp9k7TQFIn3o8iwmd3S9ITYKfTLuTV21Awe29iNvY7XwA978hIhSAYk
         9mStC5SyFMPFMjSUTfzm2JsLTK8e0m6NA9OWb9YDhsg5VpPDN0In0BXHLotegDWkf0PL
         vPOQ==
X-Gm-Message-State: ACgBeo2okNTYpbXqSXMu5kg0Xtme5aYQuaxMzHJUjfkE+dpoWtHlDcID
        t7KY+ghws8YKRwNpw+w/kFo+SNBhHkJDsKiBeLLaFA==
X-Google-Smtp-Source: AA6agR6NsQlR8kbRhbdw3pvkpiviTFBQGCiMA5TR2Hw59y9fwjeIJu8kiR943gYLtU4EWAWtdiNdZK8Mu2pX0KueZH4=
X-Received: by 2002:a05:6512:2314:b0:48c:f43c:3a39 with SMTP id
 o20-20020a056512231400b0048cf43c3a39mr2915370lfu.419.1660061511154; Tue, 09
 Aug 2022 09:11:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220704081149.16797-1-mike.leach@linaro.org> <20220704081149.16797-2-mike.leach@linaro.org>
 <ae61e907-cf88-873a-1925-878ad9293bc1@arm.com>
In-Reply-To: <ae61e907-cf88-873a-1925-878ad9293bc1@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 9 Aug 2022 17:11:40 +0100
Message-ID: <CAJ9a7VhoK33w0_pR0dptDWC4L1mcz172=T=N4PMpv3hj75zM_A@mail.gmail.com>
Subject: Re: [PATCH v2 01/13] coresight: trace-id: Add API to dynamically
 assign Trace ID values
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com
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

Hi Suzuki

On Tue, 19 Jul 2022 at 18:30, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
>
> Hi Mike,
>
> Thanks for the patch, please find my comments inline.
>
>
> On 04/07/2022 09:11, Mike Leach wrote:
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
> >   drivers/hwtracing/coresight/Makefile          |   2 +-
> >   .../hwtracing/coresight/coresight-trace-id.c  | 230 ++++++++++++++++++
> >   .../hwtracing/coresight/coresight-trace-id.h  |  65 +++++
> >   3 files changed, 296 insertions(+), 1 deletion(-)
> >   create mode 100644 drivers/hwtracing/coresight/coresight-trace-id.c
> >   create mode 100644 drivers/hwtracing/coresight/coresight-trace-id.h
> >
> > diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
> > index b6c4a48140ec..329a0c704b87 100644
> > --- a/drivers/hwtracing/coresight/Makefile
> > +++ b/drivers/hwtracing/coresight/Makefile
> > @@ -6,7 +6,7 @@ obj-$(CONFIG_CORESIGHT) += coresight.o
> >   coresight-y := coresight-core.o  coresight-etm-perf.o coresight-platform.o \
> >               coresight-sysfs.o coresight-syscfg.o coresight-config.o \
> >               coresight-cfg-preload.o coresight-cfg-afdo.o \
> > -             coresight-syscfg-configfs.o
> > +             coresight-syscfg-configfs.o coresight-trace-id.o
> >   obj-$(CONFIG_CORESIGHT_LINK_AND_SINK_TMC) += coresight-tmc.o
> >   coresight-tmc-y := coresight-tmc-core.o coresight-tmc-etf.o \
> >                     coresight-tmc-etr.o
> > diff --git a/drivers/hwtracing/coresight/coresight-trace-id.c b/drivers/hwtracing/coresight/coresight-trace-id.c
> > new file mode 100644
> > index 000000000000..dac9c89ae00d
> > --- /dev/null
> > +++ b/drivers/hwtracing/coresight/coresight-trace-id.c
> > @@ -0,0 +1,230 @@
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
> > +/* default trace ID map. Used for systems that do not require per sink mappings */
> > +static struct coresight_trace_id_map id_map_default;
> > +
> > +/* maintain a record of the current mapping of cpu IDs */
> > +static DEFINE_PER_CPU(struct cpu_id_info, cpu_ids);
> > +
> > +/* perf session active flag */
> > +static int perf_cs_etm_session_active;
> > +
> > +/* lock to protect id_map and cpu data  */
> > +static DEFINE_SPINLOCK(id_map_lock);
> > +
> > +/* ID 0 is reserved */
> > +#define CORESIGHT_TRACE_ID_RES_0 0
> > +
> > +/* ID 0x70 onwards are reserved */
> > +#define CORESIGHT_TRACE_ID_RES_RANGE_LO 0x70
> > +#define CORESIGHT_TRACE_ID_RES_RANGE_HI 0x7F
>
> Since this range is at the end of top, we could clip the
> MAX_IDS to 0x70 and skip all these unnecessary checks and reservations.
> Also, by modifying the find_bit and for_each_bit slightly we could
> get away with this reservation scheme and the IS_VALID(id) checks.
>
> > +#define IS_VALID_ID(id)      \
> > +     ((id > CORESIGHT_TRACE_ID_RES_0) && (id < CORESIGHT_TRACE_ID_RES_RANGE_LO))
> > +
> > +static void coresight_trace_id_set_inuse(int id, struct coresight_trace_id_map *id_map)
> > +{
> > +     if (IS_VALID_ID(id))
> > +             set_bit(id, id_map->avail_ids);
> > +}
>
> Please see my comment around the definition of avail_ids.
>
> > +
> > +static void coresight_trace_id_clear_inuse(int id, struct coresight_trace_id_map *id_map)
> > +{
> > +     if (IS_VALID_ID(id))
> > +             clear_bit(id, id_map->avail_ids);
> > +}
>
> This could be :
>
> coresight_trace_id_free_id()
>
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
>
>
> > +static int coresight_trace_id_find_new_id(struct coresight_trace_id_map *id_map)
>
> minor nit: Could we call this :
>
> coresight_trace_id_alloc_new_id(id_map) and
>
> > +{
> > +     int id;
> > +
> > +     id = find_first_zero_bit(id_map->avail_ids, CORESIGHT_TRACE_IDS_MAX);
>
> minor nit: You could also do, to explicitly skip 0.
>
>      id = find_next_zero_bit(id_map->avail_ids, 1, CORESIGHT_TRACE_IDS_MAX);
>
>
> > +     if (id >= CORESIGHT_TRACE_IDS_MAX)
> > +             id = -EINVAL;
>
> Could we also mark the id as in use here itself ? All callers of this
> function have to do that explicitly, anyways.
>
> > +     return id;
> > +}
> > +
> > +/* release all pending IDs for all current maps & clear CPU associations */
> > +static void coresight_trace_id_release_all_pending(void)
> > +{
> > +     struct coresight_trace_id_map *id_map = &id_map_default;
> > +     int cpu, bit;
> > +
>         int cpu, bit = 1;
>
> > +     for_each_set_bit(bit, id_map->pend_rel_ids, CORESIGHT_TRACE_IDS_MAX) {
>
> for_each_set_bit_from(bit, id_map...)
>
> > +             clear_bit(bit, id_map->avail_ids);
> > +             clear_bit(bit, id_map->pend_rel_ids);
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
> > +static void coresight_trace_id_init_id_map(struct coresight_trace_id_map *id_map)
> > +{
> > +     int bit;
> > +
> > +     /* set all reserved bits as in-use */
> > +     set_bit(CORESIGHT_TRACE_ID_RES_0, id_map->avail_ids);
>
> > +     for (bit = CORESIGHT_TRACE_ID_RES_RANGE_LO;
> > +          bit <= CORESIGHT_TRACE_ID_RES_RANGE_HI; bit++)
> > +             set_bit(bit, id_map->avail_ids);
>
>
> > +}
> > +
> > +static int coresight_trace_id_map_get_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
> > +{
> > +     unsigned long flags;
> > +     int id;
> > +
> > +     spin_lock_irqsave(&id_map_lock, flags);
> > +
> > +     /* check for existing allocation for this CPU */
> > +     id = per_cpu(cpu_ids, cpu).id;
> > +     if (id)
> > +             goto get_cpu_id_out;
> > +
> > +     /* find a new ID */
> > +     id = coresight_trace_id_find_new_id(id_map);
> > +     if (id < 0)
> > +             goto get_cpu_id_out;
> > +
> > +     /* got a valid new ID - save details */
> > +     per_cpu(cpu_ids, cpu).id = id;
> > +     per_cpu(cpu_ids, cpu).pend_rel = false;
> > +     coresight_trace_id_set_inuse(id, id_map);
> > +     coresight_trace_id_clear_pend_rel(id, id_map);
> > +
> > +get_cpu_id_out:
> > +     spin_unlock_irqrestore(&id_map_lock, flags);
> > +     return id;
> > +}
> > +
> > +static void coresight_trace_id_map_put_cpu_id(int cpu, struct coresight_trace_id_map *id_map)
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
> > +
> > +static int coresight_trace_id_map_get_system_id(struct coresight_trace_id_map *id_map)
> > +{
> > +     unsigned long flags;
> > +     int id;
> > +
> > +     spin_lock_irqsave(&id_map_lock, flags);
> > +     id = coresight_trace_id_find_new_id(id_map);
> > +     if (id > 0)
> > +             coresight_trace_id_set_inuse(id, id_map);
>
> Please see my suggestion above on moving this to the place where we find
> the bit.
>
> > +     spin_unlock_irqrestore(&id_map_lock, flags);
> > +
> > +     return id;
> > +}
> > +
> > +static void coresight_trace_id_map_put_system_id(struct coresight_trace_id_map *id_map, int id)
> > +{
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&id_map_lock, flags);
> > +     coresight_trace_id_clear_inuse(id, id_map);
> > +     spin_unlock_irqrestore(&id_map_lock, flags);
> > +}
> > +
> > +/* API functions */
> > +int coresight_trace_id_get_cpu_id(int cpu)
> > +{
> > +     return coresight_trace_id_map_get_cpu_id(cpu, &id_map_default);
> > +}
> > +EXPORT_SYMBOL_GPL(coresight_trace_id_get_cpu_id);
> > +
> > +void coresight_trace_id_put_cpu_id(int cpu)
> > +{
> > +     coresight_trace_id_map_put_cpu_id(cpu, &id_map_default);
> > +}
> > +EXPORT_SYMBOL_GPL(coresight_trace_id_put_cpu_id);
> > +
> > +int coresight_trace_id_get_system_id(void)
> > +{
> > +     return coresight_trace_id_map_get_system_id(&id_map_default);
> > +}
> > +EXPORT_SYMBOL_GPL(coresight_trace_id_get_system_id);
> > +
> > +void coresight_trace_id_put_system_id(int id)
> > +{
> > +     coresight_trace_id_map_put_system_id(&id_map_default, id);
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
> > +void coresight_trace_id_init_default_map(void)
> > +{
> > +     coresight_trace_id_init_id_map(&id_map_default);
> > +}
> > +EXPORT_SYMBOL_GPL(coresight_trace_id_init_default_map);
>
> We may be able to get rid of this init. Otherwise we may convert this to
> a module_initcall() in the worst case. No need to export this.
>
> > diff --git a/drivers/hwtracing/coresight/coresight-trace-id.h b/drivers/hwtracing/coresight/coresight-trace-id.h
> > new file mode 100644
> > index 000000000000..63950087edf6
> > --- /dev/null
> > +++ b/drivers/hwtracing/coresight/coresight-trace-id.h
> > @@ -0,0 +1,65 @@
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
>
> Thanks for the detailed comment above.
>
> > +
> > +#include <linux/bitops.h>
> > +#include <linux/types.h>
> > +
> > +
> > +/* architecturally we have 128 IDs some of which are reserved */
> > +#define CORESIGHT_TRACE_IDS_MAX 128
>
> Could we restrict the CORESIGHT_TRACE_IDS_MAX to 0x70, clipping the
> upper range of reserved ids ? That way, we could skip bothering about
> checking it everywhere.
>
> > +
> > +/**
> > + * Trace ID map.
> > + *
> > + * @avail_ids:       Bitmap to register available (bit = 0) and in use (bit = 1) IDs.
> > + *           Initialised so that the reserved IDs are permanently marked as in use.
>
> To be honest this inverses the intution. Could we instead name this
> used_ids ?
>
> i.e BIT(i) = 1 => implies trace id is in use.
>
>
> > + * @pend_rel_ids: CPU IDs that have been released by the trace source but not yet marked
> > + *                as available, to allow re-allocation to the same CPU during a perf session.
> > + */
> > +struct coresight_trace_id_map {
> > +     DECLARE_BITMAP(avail_ids, CORESIGHT_TRACE_IDS_MAX);
> > +     DECLARE_BITMAP(pend_rel_ids, CORESIGHT_TRACE_IDS_MAX);
> > +};
>
> Also, the definitions are split between the .c and .h. Could we keep all
> of them at one place, .h preferrably ? Or if this is not at all needed
> for the consumers of the API, we should keep all of this in the .c file.
>
> I guess in the future, with the sink specific scheme, we may need to
> expose the helpers which accept an id_map. So may be even move it here.
>

I have updated the set pretty much along the lines you suggested.
However there have been some changes to cope with issues thrown up by
lockdep as ever, so the new set has a slightly different approach
depending on perf or sysfs

Thanks for the review. New set to follow shortly.

Mike

>
> Thanks
> Suzuki



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
