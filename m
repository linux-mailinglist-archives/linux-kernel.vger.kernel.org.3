Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766A74B8AD3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 14:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234747AbiBPNyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 08:54:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiBPNya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 08:54:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3ED11E8BEF;
        Wed, 16 Feb 2022 05:54:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D3C361842;
        Wed, 16 Feb 2022 13:54:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6039CC004E1;
        Wed, 16 Feb 2022 13:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645019656;
        bh=5LiTn6S1BtQcKTOgrNN+zF552+0LYUwUIv2x9y/AqUs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e0oICphKag0wyoyhALIw8XeWx6i+LFa5qFFG9nExd7SgahhHhWGtQyCcZIyhgzsOn
         DlWr4miMUdixkvvDuA9AHdhZD06Uc8/E+Q47GUVsUIYSsivMOFrjhGAoAF5yz6JZ2h
         41u/KZVytB2Yo+6u7K+HKhdb3HrbsICvReCz69q/8gDAfPSbIoCPkNVeb/YEKJzh0D
         6DuM8eFo2iwNCcZIPA7JSt8UaFgyxzHcR4FeCz02Wob2egM8F5agAIYdnOG47J5oz4
         lS0Zp6nOlzU4rzU/axPSQRx/aGAm3UgcBjMwB/Na4IxWPYBcqOuMr9lPwhtEGOPBX0
         b7coHIYqg1KlA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BBCDE400FE; Wed, 16 Feb 2022 10:54:13 -0300 (-03)
Date:   Wed, 16 Feb 2022 10:54:13 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libperf: Add API for allocating new thread map
Message-ID: <Yg0CBc4gEQDX4/WD@kernel.org>
References: <20220210085225.551891-1-tz.stoyanov@gmail.com>
 <YguaF9kmFyoZ1ZhC@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YguaF9kmFyoZ1ZhC@krava>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Feb 15, 2022 at 01:18:31PM +0100, Jiri Olsa escreveu:
> On Thu, Feb 10, 2022 at 10:52:25AM +0200, Tzvetomir Stoyanov (VMware) wrote:
> > The existing API perf_thread_map__new_dummy() allocates new thread map
> > for one thread. I couldn't find a way to reallocate the map with more
> > threads, or to allocate a new map for more than one thread. Having
> > multiple threads in a thread map is essential for some use cases.
> > That's why a new API is proposed, which allocates a new thread map
> > for given number of threads:
> >  perf_thread_map__new()
> 
> I'm ok with that, just wondering if we should call it 'perf_thread_map__new_nr'
> because we already have perf_cpu_map__new(const char *cpu_list) so
> it might be better to keep perf_cpu_map and perf_thread_map in sync
 
> Arnaldo, thoughts on this?

Agreed on trying to have similar semantics for the default, main
constructor, so we probably need perf_thread_map__new(const char *thread_list).

In tools/perf/util/thread_map.c, from where tools/lib/threadmap.c came
from we have many alternative constructors:

⬢[acme@toolbox perf]$ grep 'struct perf_thread_map \*thread_map__new' tools/perf/util/thread_map.c
struct perf_thread_map *thread_map__new_by_pid(pid_t pid)
struct perf_thread_map *thread_map__new_by_tid(pid_t tid)
struct perf_thread_map *thread_map__new_all_cpus(void)
struct perf_thread_map *thread_map__new_by_uid(uid_t uid)
struct perf_thread_map *thread_map__new(pid_t pid, pid_t tid, uid_t uid)
static struct perf_thread_map *thread_map__new_by_pid_str(const char *pid_str)
struct perf_thread_map *thread_map__new_by_tid_str(const char *tid_str)
struct perf_thread_map *thread_map__new_str(const char *pid, const char *tid,
struct perf_thread_map *thread_map__new_event(struct perf_record_thread_map *event)
⬢[acme@toolbox perf]$

The one you want is almost:

	thread_map__new_by_tid_str(const char *tid_str)

but perhaps it would be better to have:

struct perf_thread_map *thread_map__new_array(int nr_threads, pid_t *array);

But yeah, if your logic needs to first allocate space for the thread_map
and then populate it, make it so that array == NULL is supported for
that case, then thread_map__new_array() will not touch it and set
everything to -1, to be populated later using perf_thread_map__set_pid().

With that thread_map__new_by_tid_str() could be reimplemented as a
wrapper around thread_map__new_array(). :-)

While we're on this, shouldn't we rename 'thread' in
tools/lib/perf/include/perf/threadmap.h and threadmap.c to be 'idx' to
avoid confusion?

- Arnaldo
 
> jirka
> 
> > 
> > Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
> > ---
> >  tools/lib/perf/Documentation/libperf.txt |  1 +
> >  tools/lib/perf/include/perf/threadmap.h  |  1 +
> >  tools/lib/perf/libperf.map               |  1 +
> >  tools/lib/perf/tests/test-threadmap.c    | 27 ++++++++++++++++++++++++
> >  tools/lib/perf/threadmap.c               | 15 +++++++++----
> >  5 files changed, 41 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
> > index 32c5051c24eb..9cbd41c29bff 100644
> > --- a/tools/lib/perf/Documentation/libperf.txt
> > +++ b/tools/lib/perf/Documentation/libperf.txt
> > @@ -62,6 +62,7 @@ SYNOPSIS
> >    struct perf_thread_map;
> >  
> >    struct perf_thread_map *perf_thread_map__new_dummy(void);
> > +  struct perf_thread_map *perf_thread_map__new(int nr);
> >  
> >    void perf_thread_map__set_pid(struct perf_thread_map *map, int thread, pid_t pid);
> >    char *perf_thread_map__comm(struct perf_thread_map *map, int thread);
> > diff --git a/tools/lib/perf/include/perf/threadmap.h b/tools/lib/perf/include/perf/threadmap.h
> > index a7c50de8d010..47d433416040 100644
> > --- a/tools/lib/perf/include/perf/threadmap.h
> > +++ b/tools/lib/perf/include/perf/threadmap.h
> > @@ -8,6 +8,7 @@
> >  struct perf_thread_map;
> >  
> >  LIBPERF_API struct perf_thread_map *perf_thread_map__new_dummy(void);
> > +LIBPERF_API struct perf_thread_map *perf_thread_map__new(int nr);
> >  
> >  LIBPERF_API void perf_thread_map__set_pid(struct perf_thread_map *map, int thread, pid_t pid);
> >  LIBPERF_API char *perf_thread_map__comm(struct perf_thread_map *map, int thread);
> > diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
> > index 93696affda2e..240a2f087b70 100644
> > --- a/tools/lib/perf/libperf.map
> > +++ b/tools/lib/perf/libperf.map
> > @@ -11,6 +11,7 @@ LIBPERF_0.0.1 {
> >  		perf_cpu_map__empty;
> >  		perf_cpu_map__max;
> >  		perf_cpu_map__has;
> > +		perf_thread_map__new;
> >  		perf_thread_map__new_dummy;
> >  		perf_thread_map__set_pid;
> >  		perf_thread_map__comm;
> > diff --git a/tools/lib/perf/tests/test-threadmap.c b/tools/lib/perf/tests/test-threadmap.c
> > index 5e2a0291e94c..3388bf36dfc0 100644
> > --- a/tools/lib/perf/tests/test-threadmap.c
> > +++ b/tools/lib/perf/tests/test-threadmap.c
> > @@ -11,9 +11,12 @@ static int libperf_print(enum libperf_print_level level,
> >  	return vfprintf(stderr, fmt, ap);
> >  }
> >  
> > +#define THREADS_NR	5
> > +
> >  int test_threadmap(int argc, char **argv)
> >  {
> >  	struct perf_thread_map *threads;
> > +	int i;
> >  
> >  	__T_START;
> >  
> > @@ -27,6 +30,30 @@ int test_threadmap(int argc, char **argv)
> >  	perf_thread_map__put(threads);
> >  	perf_thread_map__put(threads);
> >  
> > +	threads = perf_thread_map__new(THREADS_NR);
> > +	if (!threads)
> > +		tests_failed++;
> > +
> > +	if (perf_thread_map__nr(threads) != THREADS_NR)
> > +		tests_failed++;
> > +
> > +	for (i = 0; i < THREADS_NR; i++) {
> > +		if (perf_thread_map__pid(threads, i) != -1)
> > +			tests_failed++;
> > +	}
> > +
> > +	for (i = 1; i < THREADS_NR; i++)
> > +		perf_thread_map__set_pid(threads, i, i * 100);
> > +
> > +	if (perf_thread_map__pid(threads, 0) != -1)
> > +		tests_failed++;
> > +
> > +	for (i = 1; i < THREADS_NR; i++) {
> > +		if (perf_thread_map__pid(threads, i) != i * 100)
> > +			tests_failed++;
> > +	}
> > +	perf_thread_map__put(threads);
> > +
> >  	__T_END;
> >  	return tests_failed == 0 ? 0 : -1;
> >  }
> > diff --git a/tools/lib/perf/threadmap.c b/tools/lib/perf/threadmap.c
> > index e92c368b0a6c..843fe1070cc9 100644
> > --- a/tools/lib/perf/threadmap.c
> > +++ b/tools/lib/perf/threadmap.c
> > @@ -42,18 +42,25 @@ char *perf_thread_map__comm(struct perf_thread_map *map, int thread)
> >  	return map->map[thread].comm;
> >  }
> >  
> > -struct perf_thread_map *perf_thread_map__new_dummy(void)
> > +struct perf_thread_map *perf_thread_map__new(int nr)
> >  {
> > -	struct perf_thread_map *threads = thread_map__alloc(1);
> > +	struct perf_thread_map *threads = thread_map__alloc(nr);
> > +	int i;
> >  
> >  	if (threads != NULL) {
> > -		perf_thread_map__set_pid(threads, 0, -1);
> > -		threads->nr = 1;
> > +		for (i = 0; i < nr; i++)
> > +			perf_thread_map__set_pid(threads, i, -1);
> > +		threads->nr = nr;
> >  		refcount_set(&threads->refcnt, 1);
> >  	}
> >  	return threads;
> >  }
> >  
> > +struct perf_thread_map *perf_thread_map__new_dummy(void)
> > +{
> > +	return perf_thread_map__new(1);
> > +}
> > +
> >  static void perf_thread_map__delete(struct perf_thread_map *threads)
> >  {
> >  	if (threads) {
> > -- 
> > 2.34.1
> > 

-- 

- Arnaldo
