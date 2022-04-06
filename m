Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC824F6C13
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234897AbiDFVFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234834AbiDFVFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:05:20 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88687B368F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 12:38:21 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id d29so4706340wra.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 12:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t/OlsO1FKFR5EhHV9ORO6nOTkIXhtzmPjFoAc9FJDKQ=;
        b=XDKGV13OWuTcpHQtxWsO2pGZJRHijPeLw1lbRH7aQAqCra/Xto8IkoJy+FHPQBBqzl
         n7QL7p9otGPG7HD1r3iEHoLODppCk6NYvyPIrrXGEJzDuN/b4mQJh7ucRV5HEKUG9oNX
         LmU02pkmW3bRXIPADpVyIH8lyA8xNakFXmcSU0MVt6juSgKk2GIOOT3Wv7hM7jFXTwcp
         MoGyktVuWPHTg1idcweYHQ6PYAy6d2mkF6g51Gfcpq7VazIXyEQHME2oWBciEYPZCqIu
         YbUBiKzmhK6MF3zbUl0Iwf3vNgRGf90MPFj/K20OhRwOHesuZ2sAUeoYEcc7MasYFimx
         rcGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t/OlsO1FKFR5EhHV9ORO6nOTkIXhtzmPjFoAc9FJDKQ=;
        b=QlgdUsGjsjCve9WczL24J4wxhNz0U/SYrz9wNbWhzdRQ17Hs8tLSR0hphwCngvWikq
         RW08fINNFvOs3nyIulxpOFfDkGhqSvLiRwmo44/h8ED9vopCopyC+TngOq8kWLDQZ7K+
         mY/h2NI52a36XOfoiwA5QbRJt/DYsckYW9FxIYSZS2yZypKxO8WDFaIzvX80qy8zItOc
         jr3xP9/3Vo50G62YaXNvAzbvLwimMzlX/ZnZbSqvRyzD2jkN7b//vttRM4Z3TGNsMSZN
         kIKA8bbhboFv2ViSqq9Z07Ji4Fs30gM8vpgK4obVgmlijZWQaGwL8NK4i1uFBSFyXZ7p
         RTkA==
X-Gm-Message-State: AOAM5303q43B8aT/uM4c/AWCnswn+UodWNn9CXfRZvp3PN5z60APkP1X
        1f4LDkiAzy/5GKUCfPhS2MIu40f9kNkGFOROSzqefA==
X-Google-Smtp-Source: ABdhPJykxlo2lmJKWzLIYXb1mqCY4+iNWrhFOThyodG19xkrBPGOHaSV5IhSMcQbjyGQs2xL+Y9Xi6Y+jdvxnUNKRqg=
X-Received: by 2002:a05:6000:16cd:b0:207:81ed:b733 with SMTP id
 h13-20020a05600016cd00b0020781edb733mr2507341wrf.111.1649273900001; Wed, 06
 Apr 2022 12:38:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220308205000.27646-1-mike.leach@linaro.org> <20220308205000.27646-7-mike.leach@linaro.org>
 <20220406171132.GA16110@p14s>
In-Reply-To: <20220406171132.GA16110@p14s>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Wed, 6 Apr 2022 20:38:08 +0100
Message-ID: <CAJ9a7Vjb0G4fSB6U33JruVWcBzpP459rYq+5CzMqxRcWeiJb0w@mail.gmail.com>
Subject: Re: [PATCH 06/10] coresight: perf: traceid: Add perf notifiers for
 trace ID
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

On Wed, 6 Apr 2022 at 18:11, Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
>
> On Tue, Mar 08, 2022 at 08:49:56PM +0000, Mike Leach wrote:
> > Adds in notifier calls to the trace ID allocator that perf
> > events are starting and stopping.
> >
> > This ensures that Trace IDs associated with CPUs remain the same
> > throughout the perf session, and are only release when all perf
> > sessions are complete.
> >
> > Signed-off-by: Mike Leach <mike.leach@linaro.org>
> > ---
> >  drivers/hwtracing/coresight/coresight-etm-perf.c | 16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > index c039b6ae206f..008f9dac429d 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > @@ -22,6 +22,7 @@
> >  #include "coresight-etm-perf.h"
> >  #include "coresight-priv.h"
> >  #include "coresight-syscfg.h"
> > +#include "coresight-trace-id.h"
> >
> >  static struct pmu etm_pmu;
> >  static bool etm_perf_up;
> > @@ -223,11 +224,21 @@ static void free_event_data(struct work_struct *work)
> >               struct list_head **ppath;
> >
> >               ppath = etm_event_cpu_path_ptr(event_data, cpu);
> > -             if (!(IS_ERR_OR_NULL(*ppath)))
> > +             if (!(IS_ERR_OR_NULL(*ppath))) {
> >                       coresight_release_path(*ppath);
> > +                     /*
> > +                      * perf may have read a trace id for a cpu, but never actually
> > +                      * executed code on that cpu - which means the trace id would
> > +                      * not release on disable. Re-release here to be sure.
> > +                      */
> > +                     coresight_trace_id_put_cpu_id(cpu, coresight_get_trace_id_map());
>
> A CPU gets a traceID in event_etm_start() when the event is installed for
> running.  Do you see a scenario where etm_free_aux() is called without
> previously calling event_etm_stop()?
>

To ensure that IDs are obtained in a timely manner, they assign on
read. Therefore when cs_etm.c::cs_etm_info_fill() is called,
potentially the ID will be read for all CPUs - and dumped into the
AUXINFO data at the top of the perf.data file.
However, a --per-thread execution may actually only start the event on
a subset of cpus, hence we ensure that all cpus are released.
This was proven during testing when I ran both --per-thread and cpu
wide tests with logging monitoring the ID assignments.

I have programmed this deliberately defensively - on the basis that
the timings and orderings of the code/callbacks in todays perf may not
necessarily be the same in tomorrows. perf.

In future we may be able to use Suzuki's idea of embedding the ID into
an alternative packet in the perf.data file. but I think that should
be a separate change as it affects decode in a big way.

Regards

Mike


> > +             }
> >               *ppath = NULL;
> >       }
> >
> > +     /* mark perf event as done for trace id allocator */
> > +     coresight_trace_id_perf_stop();
> > +
> >       free_percpu(event_data->path);
> >       kfree(event_data);
> >  }
> > @@ -314,6 +325,9 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
> >               sink = user_sink = coresight_get_sink_by_id(id);
> >       }
> >
> > +     /* tell the trace ID allocator that a perf event is starting up */
> > +     coresight_trace_id_perf_start();
> > +
> >       /* check if user wants a coresight configuration selected */
> >       cfg_hash = (u32)((event->attr.config2 & GENMASK_ULL(63, 32)) >> 32);
> >       if (cfg_hash) {
> > --
> > 2.17.1
> >



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
