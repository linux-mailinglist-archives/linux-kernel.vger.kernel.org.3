Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2A0849FCEB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 16:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349606AbiA1PfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 10:35:04 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44726 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbiA1PfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 10:35:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E796AB80D34;
        Fri, 28 Jan 2022 15:35:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21FEBC340E0;
        Fri, 28 Jan 2022 15:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643384100;
        bh=snYj7c7/TwVUYzIhDNaseo1BOqe3SW9g5t1P88BhKiI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n4bMkAkbOqT9qr9rANED8rTJ26dGI8upXm25PStftO4lFgVB8NLoRzIUuPvfeOdnb
         UrblzYTmFyisq6/hpIjMSH+U84bqbjpjbilqhFMu7Nda8NYwuqYiXlbOhQjbPqdKjS
         4pFaFyj5m4F+fknjGi9yzy+Z9GPraMgIwiiE/S/a6XENB55agiZCfR7IL3rHLmp4n+
         xJ6YJgALlvCXosnWbMPqYIMMp9OGNZrNI+V1lB2kYhOCiuvc5OVJaESat6+2TOESFc
         fw1IZhorQEJYVoyuUHDLFcHbRK6Kn5yXRtJg+dQHK2s64r5xhVLCHEWEFNgAxVaPvy
         h9ronD8BusDGA==
Date:   Sat, 29 Jan 2022 00:34:50 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?B?QW5kcsOp?= Almeida <andrealmeid@collabora.com>,
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
        Steven Rostedt <rostedt@goodmis.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        masami.hiramatsu.pt@hitachi.com, eranian@google.com
Subject: Re: [PATCH v2 0/4] Reference count checker and related fixes
Message-Id: <20220129003450.77116209763f7e06d285e654@kernel.org>
In-Reply-To: <CAP-5=fXHudKqO4+0rbO9X3Ny+Cq7+KsHbKf4P8P24SjF0S232Q@mail.gmail.com>
References: <20220125204602.4137477-1-irogers@google.com>
        <CAP-5=fXyJeX3b3egcAOfPndmYhakrsdKu7HttnHEH2DKP-6Vxw@mail.gmail.com>
        <20220128142348.17d51894dbdb35c9a9449567@kernel.org>
        <CAP-5=fXHudKqO4+0rbO9X3Ny+Cq7+KsHbKf4P8P24SjF0S232Q@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2022 22:24:59 -0800
Ian Rogers <irogers@google.com> wrote:

> On Thu, Jan 27, 2022 at 9:24 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Thu, 27 Jan 2022 13:33:23 -0800
> > Ian Rogers <irogers@google.com> wrote:
> >
> > > On Tue, Jan 25, 2022 at 12:46 PM Ian Rogers <irogers@google.com> wrote:
> > > >
> > > > This v2 patch set has the main reference count patch for cpu map from
> > > > the first set and then adds reference count checking to nsinfo. The
> > > > reference count checking on nsinfo helped diagnose a data race bug
> > > > which is fixed in the independent patches 2 and 3.
> > > >
> > > > The perf tool has a class of memory problems where reference counts
> > > > are used incorrectly. Memory/address sanitizers and valgrind don't
> > > > provide useful ways to debug these problems, you see a memory leak
> > > > where the only pertinent information is the original allocation
> > > > site. What would be more useful is knowing where a get fails to have a
> > > > corresponding put, where there are double puts, etc.
> > > >
> > > > This work was motivated by the roll-back of:
> > > > https://lore.kernel.org/linux-perf-users/20211118193714.2293728-1-irogers@google.com/
> > > > where fixing a missed put resulted in a use-after-free in a different
> > > > context. There was a sense in fixing the issue that a game of
> > > > wac-a-mole had been embarked upon in adding missed gets and puts.
> > > >
> > > > The basic approach of the change is to add a level of indirection at
> > > > the get and put calls. Get allocates a level of indirection that, if
> > > > no corresponding put is called, becomes a memory leak (and associated
> > > > stack trace) that leak sanitizer can report. Similarly if two puts are
> > > > called for the same get, then a double free can be detected by address
> > > > sanitizer. This can also detect the use after put, which should also
> > > > yield a segv without a sanitizer.
> > > >
> > > > Adding reference count checking to cpu map was done as a proof of
> > > > concept, it yielded little other than a location where the use of get
> > > > could be cleaner by using its result. Reference count checking on
> > > > nsinfo identified a double free of the indirection layer and the
> > > > related threads, thereby identifying a data race as discussed here:
> > > > https://lore.kernel.org/linux-perf-users/CAP-5=fWZH20L4kv-BwVtGLwR=Em3AOOT+Q4QGivvQuYn5AsPRg@mail.gmail.com/
> > > > Accordingly the dso->lock was extended and use to cover the race.
> > > >
> > > > An alternative that was considered was ref_tracker:
> > > >  https://lwn.net/Articles/877603/
> > > > ref_tracker requires use of a reference counted struct to also use a
> > > > cookie/tracker. The cookie is combined with data in a ref_tracker_dir
> > > > to spot double puts. When an object is finished with leaks can be
> > > > detected, as with this approach when leak analysis happens. This
> > > > approach was preferred as it doesn't introduce cookies, spots use
> > > > after put and appears moderately more neutral to the API. Weaknesses
> > > > of the implemented approcah are not being able to do adhoc leak
> > > > detection and a preference for adding an accessor API to structs. I
> > > > believe there are other issues and welcome suggestions.
> > >
> > > And so we've been here before (Dec 2015 to be exact). Namhyung pointed me to:
> > > https://lore.kernel.org/all/20151209021047.10245.8918.stgit@localhost.localdomain/
> > > by Masami Hiramatsu. In this work he adds a leak sanitizer style
> > > reference count checker that will describe locations of puts and gets
> > > for diagnosis. Firstly that's an awesome achievement! This work is
> > > different in that it isn't trying to invent a leak sanitizer, it is
> > > just using the existing one. By adding a level of indirection this
> > > work can catch use after put and pairs gets with puts to make lifetime
> > > analysis more automatic. An advantage of Masami's work is that it
> > > doesn't change data-structures and after the initial patch-set is
> > > somewhat transparent. Overall I prefer the approach in these patches,
> > > future patches can look to clean up the API as Masami has.
> >
> > Thanks for referring my series :-D The series aimed to solve the refcount
> > usage issue in the perf which lead the object leaks. At that moment,
> > I found that there were 2 patterns, refcount start from 0 and start from 1.
> > That made me confused what I should do for using a object.
> > But the perf uses linux/refcount.h now, I hope such issue has already gone.
> > (but the object leakage seems not fixed fully yet, as you found.)
> >
> > BTW, I think the introducing UNWRAP_* macro may put a burden on future
> > development. If it is inevitable, we should consider it as carefully as
> > possible. Or, it may cause another issue (it is easily missed that the new
> > patch does not use UNWRAP_* for object reference, because it is natual.)
> >
> > So I agree with you that you to clean up the API. :-)
> > I think we can make yet another refcount.h for user space debugging and
> > replace it with the linux/refcount.h.
> 
> Thanks Masami,
> 
> Agreed on the UNWRAP_ macros, hence wanting to hide them behind
> accessors. Making accessors could be automated with macros, for
> example, have a list of variables, have a macro declare the struct
> using the list, another macro can use the list to declare accessors. I
> didn't find adding the UNWRAP_ macros in this change particularly
> burdensome as any use of the wrapping pointer as the original type
> caused a compile time error telling you what and where to fix. The
> macro is extra stuff in the way of using just the raw object, but
> that's fairly typical in C++ with shared_ptr, scoped_lock, etc.

Hi Ian,

Hmm, but such a macro is not usual for C which perf is written in.
If I understand correctly, you might want to use memory leak
analyzer to detect refcount leak, and that analyzer will show
what data structure is leaked.

If so, maybe you can do the same thing by introducing a dummy
list node for each data structure which you want to debug.

struct perf_cpu_map__refdebug {
	struct perf_cpu_map__refdebug *orig;
};

And expand refcount_t as.

typedef struct refcount_struct {
	atomic_t refs;
#ifdef REFCNT_CHECKING
	void *orig;
#endif
} refcount_t;

And change the get/put as below

struct perf_cpu_map *perf_cpu_map__get(struct perf_cpu_map *map)
{
	if (map) {
#ifdef REFCNT_CHECKING
		struct perf_cpu_map__refdebug *new_node;
#endif
		refcount_inc(&map->refcnt);
#ifdef REFCNT_CHECKING
		new_node = malloc(sizeof(*new_node));
		new_node->orig = map->refcnt->orig;
		map->refcnt->orig = new_node;
#endif
	}
	return map;
}

void perf_cpu_map__put(struct perf_cpu_map *map)
{
	if (map) {
		if (refcount_dec_and_test(&map->refcnt))
			cpu_map__delete(map);
		else {
#ifdef REFCNT_CHECKING
			struct perf_cpu_map__refdebug *node = map->refcnt->orig;

			map->refcnt->orig = node->orig;
			free(node);
#endif
		}
	}
}

This need a bit complex get/put, but no need to change other parts.

> The
> question is, is it worth it to make sure use of the reference counted
> object is correct and misuse is easier to diagnose?

You mean the stackdump for every get/put as I did? That's a good
question. Let's think what may happen.

For example, if funcA() expects its caller funcB() will put the object
but actually funcB() doesn't, or the funcC() which is the another
caller of funcA()) doesn't expect the funcA() gets the object.

funcA() {
	get(obj);
	return obj;
}

funcB() {
	obj = funcA();
	...
	// wrong! it should do put(obj);
}

funcC() {
	obj = funcA();
	get(obj);		// this is wrong get().
	...
	put(obj);
}

If we just list the non-released object, both logs seems same because
funcB()'s get/put pair will be skipped. If the analyzer shows the
stacktrace when the object was got, maybe we can notice the difference
of funcB() and funcC() path, but this is the simplest case. funcA()
can be called from funcB/C via several different functions.
But perhaps I'm too worried.

Thank you,

> I think it is near
> as least offensive as possible while providing the best information -
> hence being able to solve the dso->nsinfo put data race, that has been
> a problem to solve up to this point. I'm open to better suggestions
> though :-)
> 
> Thanks again,
> Ian
> 
> > Thank you,
> >
> > --
> > Masami Hiramatsu <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
