Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75847583550
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 00:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236007AbiG0WX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 18:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiG0WXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 18:23:25 -0400
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1D957246;
        Wed, 27 Jul 2022 15:23:24 -0700 (PDT)
Received: by mail-qv1-f41.google.com with SMTP id v2so198291qvs.12;
        Wed, 27 Jul 2022 15:23:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oy5RoLKG40jkr/f7xmBtTV08633/f8xQVyqFC8sXuLo=;
        b=5WcTyG6uVM1skmhyhFvnvFTYZuyuPFSTjXPPCphspbb2rx5l+c6A8qaSwQ+U8ffZdM
         WpPnyRudATOqzzh13Ihb4enxRImLuEmugTuGddXe4+mgGdPL29DlnbnJbeCczEOeZW0l
         JoSWFfE3Dpg3HQ8hQjOz0+dm+kuwO7wdQ3S0MPgaaY5nGoVgCiVh9qPBhy0pOQe8qYhU
         wP8mLME7yHk2KMODcIzJkpPdGTIuTks1LRppT2VJloM1NObkqHo7exFzlAQt/cYlJL5W
         k71oxuCUmxZymI0A7lqWqOg4JbNnGFGp0M9QECQoX2WuLZ7ogXidi+NzZhxcc5h7H8zf
         6trg==
X-Gm-Message-State: AJIora+wPK3EFkkaL0nhR06n/4W2McvVk+JpW2qttmVUWFSyGWjivUE0
        Q9R0Jghqa789W7RdzqWO8M94ReSdAxNPfR9a4tVKDN4+pnY+MW1m
X-Google-Smtp-Source: AGRyM1sAPmZzDWkI51Eqr6vfkZTZLpmKyCgr96weXem6uLkULRtvAqw96C13ikedxBsI4jOTm5fOZlTo8JJr7NJN34o=
X-Received: by 2002:ad4:5be9:0:b0:474:552c:26e8 with SMTP id
 k9-20020ad45be9000000b00474552c26e8mr12313234qvc.102.1658960603824; Wed, 27
 Jul 2022 15:23:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220727111954.105118-1-gpavithrasha@gmail.com> <YuGTjvLUbehHe/Pj@kernel.org>
In-Reply-To: <YuGTjvLUbehHe/Pj@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 27 Jul 2022 15:23:12 -0700
Message-ID: <CAM9d7cjPTOx2vTHzYxjxOK7j9KSf8FjG1QRaUqKHt3-_o5MvXw@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] perf mutex: Wrapped usage of pthread_mutex_t
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     gpavithrasha@gmail.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 27, 2022 at 12:35 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Jul 27, 2022 at 04:49:51PM +0530, gpavithrasha@gmail.com escreveu:
> > From: pavithra <gpavithrasha@gmail.com>

Please set the author name to be a full name.

> >
> > Added a new header file mutex.h that wraps the
> > usage of pthread_mutex_t and updated lock in dso.h.

What is the point of the wrapping?  I think it's to add
error checks.  Then you need to describe it here and/or
in the file comment.

>
> Hi,
>
>         You should create a first patch with just the new mutex.c and
> mutex.h files, then you go on to change the users of
> pthread_mutex_lock/unlock to the wrappers.
>
>         Also please add the license on the first line of the new
> mutex.[ch] files, see Documentation/process/license-rules.rst.
>
>         tldr; probably what you want is to have this single line in
> those the two new files (mutex.[ch]):
>
> // SPDX-License-Identifier: GPL-2.0
>
>
>
> > Signed-off-by: pavithra <gpavithrasha@gmail.com>
> > ---

[SNIP]
> > diff --git a/tools/perf/util/mutex.c b/tools/perf/util/mutex.c
> > new file mode 100644
> > index 000000000000..b7264a1438c4
> > --- /dev/null
> > +++ b/tools/perf/util/mutex.c
> > @@ -0,0 +1,32 @@
> > +#include <mutex.h>
> > +#include <pthread.h>
> > +
> > +//to avoid the warning : implicit declaration of BUG_ON,
> > +//we add the following 2 headers.

We usually omit this kind of information.  But if you really
think it's necessary, you can add a single line comment like:

#include <linux/kernel.h>  /* BUG_ON */

> > +#include <linux/compiler.h>
> > +#include <linux/kernel.h>
> > +
> > +void mutex_init(struct mutex *mtx)
> > +{
> > +pthread_mutexattr_t lock_attr;

No indentation?

> > +pthread_mutexattr_init(&lock_attr);
> > +pthread_mutexattr_settype(&lock_attr, PTHREAD_MUTEX_ERRORCHECK);
> > +BUG_ON(pthread_mutex_init(&mtx->lock, &lock_attr));
> > +//on success, returns 0.

I believe this belongs to the above line, but it can just be omitted.

> > +pthread_mutexattr_destroy(&lock_attr);
> > +}
> > +
> > +void mutex_destroy(struct mutex *mtx)
> > +{
> > +BUG_ON(pthread_mutex_destroy(&mtx->lock));     //on success, returns 0.
> > +}
> > +
> > +void mutex_lock(struct mutex *mtx)
> > +{
> > +BUG_ON(pthread_mutex_lock(&mtx->lock) != 0);

Maybe this form is better to indicate it returns 0 on success.

Thanks,
Namhyung


> > +}
> > +
> > +void mutex_unlock(struct mutex *mtx)
> > +{
> > +BUG_ON(pthread_mutex_unlock(&mtx->lock) != 0);
> > +}
> > diff --git a/tools/perf/util/mutex.h b/tools/perf/util/mutex.h
> > new file mode 100644
> > index 000000000000..ab2ebb98b24a
> > --- /dev/null
> > +++ b/tools/perf/util/mutex.h
> > @@ -0,0 +1,15 @@
> > +#ifndef __PERF_MUTEX_H
> > +#define _PERF_MUTEX_H
> > +
> > +#include <pthread.h>
> > +
> > +struct mutex {
> > +pthread_mutex_t lock;
> > +};
> > +
> > +void mutex_lock(struct mutex *mtx);
> > +void mutex_unlock(struct mutex *mtx);
> > +void mutex_init(struct mutex *mtx);
> > +void mutex_destroy(struct mutex *mtx);
> > +
> > +#endif /* _PERF_MUTEX_H */
> > diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> > index a8f80e427674..342be12cfa1e 100644
> > --- a/tools/perf/util/symbol.c
> > +++ b/tools/perf/util/symbol.c
> > @@ -1629,7 +1629,7 @@ int dso__load(struct dso *dso, struct map *map)
> >       }
> >
> >       nsinfo__mountns_enter(dso->nsinfo, &nsc);
> > -     pthread_mutex_lock(&dso->lock);
> > +     mutex_lock(&dso->lock);
> >
> >       /* check again under the dso->lock */
> >       if (dso__loaded(dso)) {
> > @@ -1778,7 +1778,7 @@ int dso__load(struct dso *dso, struct map *map)
> >               ret = 0;
> >  out:
> >       dso__set_loaded(dso);
> > -     pthread_mutex_unlock(&dso->lock);
> > +     mutex_unlock(&dso->lock);
> >       nsinfo__mountns_exit(&nsc);
> >
> >       return ret;
> > --
> > 2.25.1
> >
>
> --
>
> - Arnaldo
