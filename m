Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06354B35ED
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 16:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236440AbiBLPsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 10:48:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236418AbiBLPsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 10:48:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C1B212;
        Sat, 12 Feb 2022 07:48:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23DF760B3A;
        Sat, 12 Feb 2022 15:48:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41FD6C340E7;
        Sat, 12 Feb 2022 15:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644680920;
        bh=sHucLdS9llTT7mQGMwgL7LyvrTQpGgnSuaf9PJ2pqtk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OAt1vBoVJaMX7yvdYOYVPUcqzK6ncJM3qA/JcVlWQAZoFryfj3kIoaOelU3cCW3Bt
         kltb0KSnhkxrGlMy7dhUM/qKAy/wGi0SSPB+qOqoQBqy2nDyI66Y5zkcbJHBFBSC4B
         k5eF4N++mFrcSFZ5FZdQDIY+tPlxVYItdDYtiEZ40yI2+zj7Qy4rO2pzVwv93nSasL
         92oTf6qWG0a9MFH3QeTN63uIBMx/3UhL6hpAxoKuqkQvS0vmhTGQ3uUhpROj2XjNMK
         2GjUi2OWolfS8L1fyNO2TpRXXx5m6ptzxBLUpqSpBEVY8GiaDt/MKSGTr7tFN/AiuR
         C41BKorbZpK7g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6E826400FE; Sat, 12 Feb 2022 12:48:37 -0300 (-03)
Date:   Sat, 12 Feb 2022 12:48:37 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Song Liu <song@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hao Luo <haoluo@google.com>, eranian@google.com
Subject: Re: [PATCH v3 03/22] perf dso: Make lock error check and add BUG_ONs
Message-ID: <YgfW1SOXN++UZRKj@kernel.org>
References: <20220211103415.2737789-1-irogers@google.com>
 <20220211103415.2737789-4-irogers@google.com>
 <YgaZSk8h6rQ6MgLy@kernel.org>
 <CAP-5=fWZTmbQpmoXRKt9HdMU-E_B2uo5b4BHOW6RC6w5VkQ0AQ@mail.gmail.com>
 <Yga3JNhTfSBR3btI@kernel.org>
 <CAP-5=fVb=1prv6kkUzJRiPNSsudBhU1+YLBqnBrWiut3XQLJqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVb=1prv6kkUzJRiPNSsudBhU1+YLBqnBrWiut3XQLJqg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 11, 2022 at 11:35:05AM -0800, Ian Rogers escreveu:
> On Fri, Feb 11, 2022 at 11:21 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Fri, Feb 11, 2022 at 09:43:19AM -0800, Ian Rogers escreveu:
> > > On Fri, Feb 11, 2022 at 9:13 AM Arnaldo Carvalho de Melo
> > > <acme@kernel.org> wrote:
> > > >
> > > > Em Fri, Feb 11, 2022 at 02:33:56AM -0800, Ian Rogers escreveu:
> > > > > Make the pthread mutex on dso use the error check type. This allows
> > > > > deadlock checking via the return type. Assert the returned value from
> > > > > mutex lock is always 0.
> > > >
> > > > I think this is too blunt/pervasive source code wise, perhaps we should
> > > > wrap this like its done with rwsem in tools/perf/util/rwsem.h to get
> > > > away from pthreads primitives and make the source code look more like
> > > > a kernel one and then, taking advantage of the so far ideologic
> > > > needless indirection, add this BUG_ON if we build with "DEBUG=1" or
> > > > something, wdyt?
> > >
> >
> > > My concern with semaphores is that they are a concurrency primitive
> >
> > I'm not suggesting we switch over to semaphores, just to use the same
> > technique of wrapping pthread_mutex_t with some other API that then
> > allows us to add these BUG_ON() calls without polluting the source code
> > in many places.
> 
> Sounds simple enough and would ensure consistency too. I can add it to
> the front of this set of changes. A different approach would be to
> take what's here and then refactor and cleanup as a follow on patch
> set. I'd prefer that as the size of this set of changes is already
> larger than I like - albeit that most of it is just introducing the

So, the first 4 patches in this series were already merged, as they are
just prep work that don't add clutter, having those in the front of the
patchkit helps picking up the low hanging fruit.

I usually try to pick even if it comes later, to make progress, I'll
recheck the rest of the patchkit to see what more I can pick to reduce
its size.

- Arnaldo

> use of functions to access struct variables. Perhaps I just remove the
> BUG_ON and pthread changes here, we work to get this landed and in a
> separate set of patches clean up the pthread mutex code to have better
> bug checking.
> 
> Thanks,
> Ian
> 
> > - Arnaldo
> >
> > > that has more flexibility and power than a mutex. I like a mutex as it
> > > is quite obvious what is going on and that is good from a tooling
> > > point of view. A deadlock with two mutexes is easy to understand. On a
> > > semaphore, were we using it like a condition variable? There's more to
> > > figure out. I also like the idea of compiling the perf command with
> > > emscripten, we could then generate say perf annotate output in your
> > > web browser. Emscripten has implementations of standard posix
> > > libraries including pthreads, but we may need to have two approaches
> > > in the perf code if we want to compile with emscripten and use
> > > semaphores when targeting linux.
> > >
> > > Where this change comes from is that I worried that extending the
> > > locked regions to cover the race that'd been found would then expose
> > > the kind of recursive deadlock that pthread mutexes all too willingly
> > > allow. With this code we at least see the bug and don't just hang. I
> > > don't think we need the change to the mutexes for this change, but we
> > > do need to extend the regions to fix the data race.
> > >
> > > Let me know how you prefer it and I can roll it into a v4 version.
> > >
> > > Thanks,
> > > Ian
> > >
> > > > - Arnaldo
> > > >
> > > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > > ---
> > > > >  tools/perf/util/dso.c    | 12 +++++++++---
> > > > >  tools/perf/util/symbol.c |  2 +-
> > > > >  2 files changed, 10 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> > > > > index 9cc8a1772b4b..6beccffeef7b 100644
> > > > > --- a/tools/perf/util/dso.c
> > > > > +++ b/tools/perf/util/dso.c
> > > > > @@ -784,7 +784,7 @@ dso_cache__free(struct dso *dso)
> > > > >       struct rb_root *root = &dso->data.cache;
> > > > >       struct rb_node *next = rb_first(root);
> > > > >
> > > > > -     pthread_mutex_lock(&dso->lock);
> > > > > +     BUG_ON(pthread_mutex_lock(&dso->lock) != 0);
> > > > >       while (next) {
> > > > >               struct dso_cache *cache;
> > > > >
> > > > > @@ -830,7 +830,7 @@ dso_cache__insert(struct dso *dso, struct dso_cache *new)
> > > > >       struct dso_cache *cache;
> > > > >       u64 offset = new->offset;
> > > > >
> > > > > -     pthread_mutex_lock(&dso->lock);
> > > > > +     BUG_ON(pthread_mutex_lock(&dso->lock) != 0);
> > > > >       while (*p != NULL) {
> > > > >               u64 end;
> > > > >
> > > > > @@ -1259,6 +1259,8 @@ struct dso *dso__new_id(const char *name, struct dso_id *id)
> > > > >       struct dso *dso = calloc(1, sizeof(*dso) + strlen(name) + 1);
> > > > >
> > > > >       if (dso != NULL) {
> > > > > +             pthread_mutexattr_t lock_attr;
> > > > > +
> > > > >               strcpy(dso->name, name);
> > > > >               if (id)
> > > > >                       dso->id = *id;
> > > > > @@ -1286,8 +1288,12 @@ struct dso *dso__new_id(const char *name, struct dso_id *id)
> > > > >               dso->root = NULL;
> > > > >               INIT_LIST_HEAD(&dso->node);
> > > > >               INIT_LIST_HEAD(&dso->data.open_entry);
> > > > > -             pthread_mutex_init(&dso->lock, NULL);
> > > > > +             pthread_mutexattr_init(&lock_attr);
> > > > > +             pthread_mutexattr_settype(&lock_attr, PTHREAD_MUTEX_ERRORCHECK);
> > > > > +             pthread_mutex_init(&dso->lock, &lock_attr);
> > > > > +             pthread_mutexattr_destroy(&lock_attr);
> > > > >               refcount_set(&dso->refcnt, 1);
> > > > > +
> > > > >       }
> > > > >
> > > > >       return dso;
> > > > > diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> > > > > index b2ed3140a1fa..43f47532696f 100644
> > > > > --- a/tools/perf/util/symbol.c
> > > > > +++ b/tools/perf/util/symbol.c
> > > > > @@ -1783,7 +1783,7 @@ int dso__load(struct dso *dso, struct map *map)
> > > > >       }
> > > > >
> > > > >       nsinfo__mountns_enter(dso->nsinfo, &nsc);
> > > > > -     pthread_mutex_lock(&dso->lock);
> > > > > +     BUG_ON(pthread_mutex_lock(&dso->lock) != 0);
> > > > >
> > > > >       /* check again under the dso->lock */
> > > > >       if (dso__loaded(dso)) {
> > > > > --
> > > > > 2.35.1.265.g69c8d7142f-goog
> > > >
> > > > --
> > > >
> > > > - Arnaldo
> >
> > --
> >
> > - Arnaldo

-- 

- Arnaldo
