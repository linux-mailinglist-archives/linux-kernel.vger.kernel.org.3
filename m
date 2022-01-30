Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02C494A3509
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 09:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238198AbiA3IEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 03:04:35 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60676 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiA3IEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 03:04:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EF825B8285A;
        Sun, 30 Jan 2022 08:04:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D6BC340E4;
        Sun, 30 Jan 2022 08:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643529868;
        bh=600dPcJ4rCZdXhgeUQa3AhxZQ/MTAqDwVkJ7K/M7qv8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Qq/XlyAcP96dF2sCiqo84hbNFCdVxoea53ZpOV3PRJWiZehfX30z5QNwcamIMu25H
         xrOCVqGHAonZBUQ1oX+A6zL9NoS1QzgqCA/G5X0jumkAVKB70rjSr6KqivVNBn0usv
         KjRHQY/VWUDmuvPxlcRuu57jLW2SuFalzJsjaSl1eVnrJEoBBCqQ5Dfn1Kyy+6Rsbj
         D8xJKCRGjGIfno6lT62n23QeB3gmUGQ6T/FccFSMrShGmpLnSMwG3QQKaonGqpfSUf
         gVV9yz6ozNtHsJgi9UL1E+IhslTk6jothPpxm+xAknnaYlN5FE4ktphPVQ3JeMAkqg
         dGUR/qVKlKqyg==
Date:   Sun, 30 Jan 2022 17:04:18 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
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
Message-Id: <20220130170418.40d812169bcae1323f8b20bf@kernel.org>
In-Reply-To: <YfRLEel7/nxWSgIP@kernel.org>
References: <20220125204602.4137477-1-irogers@google.com>
        <CAP-5=fXyJeX3b3egcAOfPndmYhakrsdKu7HttnHEH2DKP-6Vxw@mail.gmail.com>
        <20220128142348.17d51894dbdb35c9a9449567@kernel.org>
        <CAP-5=fXHudKqO4+0rbO9X3Ny+Cq7+KsHbKf4P8P24SjF0S232Q@mail.gmail.com>
        <20220129003450.77116209763f7e06d285e654@kernel.org>
        <CAP-5=fVoP9MAVsj7SdrxRjkr1Jt=XZ7Vf_FAooXA7B2OrC=XMA@mail.gmail.com>
        <YfRLEel7/nxWSgIP@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2022 16:59:13 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Fri, Jan 28, 2022 at 10:26:20AM -0800, Ian Rogers escreveu:
> > On Fri, Jan 28, 2022 at 7:35 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > >
> > > On Thu, 27 Jan 2022 22:24:59 -0800
> > > Ian Rogers <irogers@google.com> wrote:
> > >
> > > > On Thu, Jan 27, 2022 at 9:24 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > > > >
> > > > > On Thu, 27 Jan 2022 13:33:23 -0800
> > > > > Ian Rogers <irogers@google.com> wrote:
> > > > >
> > > > > > On Tue, Jan 25, 2022 at 12:46 PM Ian Rogers <irogers@google.com> wrote:
> > > > > > >
> > > > > > > This v2 patch set has the main reference count patch for cpu map from
> > > > > > > the first set and then adds reference count checking to nsinfo. The
> > > > > > > reference count checking on nsinfo helped diagnose a data race bug
> > > > > > > which is fixed in the independent patches 2 and 3.
> > > > > > >
> > > > > > > The perf tool has a class of memory problems where reference counts
> > > > > > > are used incorrectly. Memory/address sanitizers and valgrind don't
> > > > > > > provide useful ways to debug these problems, you see a memory leak
> > > > > > > where the only pertinent information is the original allocation
> > > > > > > site. What would be more useful is knowing where a get fails to have a
> > > > > > > corresponding put, where there are double puts, etc.
> > > > > > >
> > > > > > > This work was motivated by the roll-back of:
> > > > > > > https://lore.kernel.org/linux-perf-users/20211118193714.2293728-1-irogers@google.com/
> > > > > > > where fixing a missed put resulted in a use-after-free in a different
> > > > > > > context. There was a sense in fixing the issue that a game of
> > > > > > > wac-a-mole had been embarked upon in adding missed gets and puts.
> > > > > > >
> > > > > > > The basic approach of the change is to add a level of indirection at
> > > > > > > the get and put calls. Get allocates a level of indirection that, if
> > > > > > > no corresponding put is called, becomes a memory leak (and associated
> > > > > > > stack trace) that leak sanitizer can report. Similarly if two puts are
> > > > > > > called for the same get, then a double free can be detected by address
> > > > > > > sanitizer. This can also detect the use after put, which should also
> > > > > > > yield a segv without a sanitizer.
> > > > > > >
> > > > > > > Adding reference count checking to cpu map was done as a proof of
> > > > > > > concept, it yielded little other than a location where the use of get
> > > > > > > could be cleaner by using its result. Reference count checking on
> > > > > > > nsinfo identified a double free of the indirection layer and the
> > > > > > > related threads, thereby identifying a data race as discussed here:
> > > > > > > https://lore.kernel.org/linux-perf-users/CAP-5=fWZH20L4kv-BwVtGLwR=Em3AOOT+Q4QGivvQuYn5AsPRg@mail.gmail.com/
> > > > > > > Accordingly the dso->lock was extended and use to cover the race.
> > > > > > >
> > > > > > > An alternative that was considered was ref_tracker:
> > > > > > >  https://lwn.net/Articles/877603/
> > > > > > > ref_tracker requires use of a reference counted struct to also use a
> > > > > > > cookie/tracker. The cookie is combined with data in a ref_tracker_dir
> > > > > > > to spot double puts. When an object is finished with leaks can be
> > > > > > > detected, as with this approach when leak analysis happens. This
> > > > > > > approach was preferred as it doesn't introduce cookies, spots use
> > > > > > > after put and appears moderately more neutral to the API. Weaknesses
> > > > > > > of the implemented approcah are not being able to do adhoc leak
> > > > > > > detection and a preference for adding an accessor API to structs. I
> > > > > > > believe there are other issues and welcome suggestions.
> > > > > >
> > > > > > And so we've been here before (Dec 2015 to be exact). Namhyung pointed me to:
> > > > > > https://lore.kernel.org/all/20151209021047.10245.8918.stgit@localhost.localdomain/
> > > > > > by Masami Hiramatsu. In this work he adds a leak sanitizer style
> > > > > > reference count checker that will describe locations of puts and gets
> > > > > > for diagnosis. Firstly that's an awesome achievement! This work is
> > > > > > different in that it isn't trying to invent a leak sanitizer, it is
> > > > > > just using the existing one. By adding a level of indirection this
> > > > > > work can catch use after put and pairs gets with puts to make lifetime
> > > > > > analysis more automatic. An advantage of Masami's work is that it
> > > > > > doesn't change data-structures and after the initial patch-set is
> > > > > > somewhat transparent. Overall I prefer the approach in these patches,
> > > > > > future patches can look to clean up the API as Masami has.
> > > > >
> > > > > Thanks for referring my series :-D The series aimed to solve the refcount
> > > > > usage issue in the perf which lead the object leaks. At that moment,
> > > > > I found that there were 2 patterns, refcount start from 0 and start from 1.
> > > > > That made me confused what I should do for using a object.
> > > > > But the perf uses linux/refcount.h now, I hope such issue has already gone.
> > > > > (but the object leakage seems not fixed fully yet, as you found.)
> > > > >
> > > > > BTW, I think the introducing UNWRAP_* macro may put a burden on future
> > > > > development. If it is inevitable, we should consider it as carefully as
> > > > > possible. Or, it may cause another issue (it is easily missed that the new
> > > > > patch does not use UNWRAP_* for object reference, because it is natual.)
> > > > >
> > > > > So I agree with you that you to clean up the API. :-)
> > > > > I think we can make yet another refcount.h for user space debugging and
> > > > > replace it with the linux/refcount.h.
> > > >
> > > > Thanks Masami,
> > > >
> > > > Agreed on the UNWRAP_ macros, hence wanting to hide them behind
> > > > accessors. Making accessors could be automated with macros, for
> > > > example, have a list of variables, have a macro declare the struct
> > > > using the list, another macro can use the list to declare accessors. I
> > > > didn't find adding the UNWRAP_ macros in this change particularly
> > > > burdensome as any use of the wrapping pointer as the original type
> > > > caused a compile time error telling you what and where to fix. The
> > > > macro is extra stuff in the way of using just the raw object, but
> > > > that's fairly typical in C++ with shared_ptr, scoped_lock, etc.
> > >
> > > Hi Ian,
> > >
> > > Hmm, but such a macro is not usual for C which perf is written in.
> > > If I understand correctly, you might want to use memory leak
> > > analyzer to detect refcount leak, and that analyzer will show
> > > what data structure is leaked.
> > 
> > Firstly, thanks for the conversation - this is really useful to
> > improve the code!
> > 
> > I think in an ideal world we'd somehow educate things like address
> > sanitizer of reference counted data structures and they would do a
> > better job of tracking gets and puts. The problem is pairing gets and
> > puts. In C++ you use RAII types so that the destructor ensures a put -
> > this can be complex when using data types like lists where you want to
> > move or swap things onto the list, to keep the single pointer
> > property. In the C code in Linux we use gotos, similarly to how defer
> > is used in Go. Anyway, the ref_tracker that Eric Dumazet added solved
> > the get/put pairing problem by adding a cookie that is passed around.
> > The problem with that is that then the cookie becomes part of the API.
> > To avoid that the approach here is just to change the original data
> > type and add in a layer of indirection, that layer has become the
> > cookie. A benefit of this approach is that once the cookie/indirection
> > is freed, use of it becomes an obvious failure - we leverage address
> > sanitizer for use after free.
> 
> I went back to that discussion and saw this part where I brainstormed
> about doing all this in unmodified binaries:
> 
> https://lore.kernel.org/all/20151209134138.GB15864@kernel.org/
> 
> Even Alexei chimed in and replied to that thinking it was doable:
> 
> https://lore.kernel.org/all/20151210033139.GA10056@ast-mbp.thefacebook.com/#t
> 
> And nowadays we have much better BPF infrastructure, much faster probes,
> etc.

Yeah I think now we (will) have faster user-event[1] too. :)

[1] https://lore.kernel.org/all/20220118204326.2169-1-beaub@linux.microsoft.com/T/#u

So instead of allocating an indirect object on get(), we also can define
an event and send it to the kernel, and run a BPF to analyze it.
Note that this will *NOT* be able to detect the "use-after-put" unless
we automatically trace the all object field access ;-)

Hm, apart from this topic, isn't it good to introduce user-space trace
event( macro)s in perf tools? :-)

Thank you,

> 
> But anyway, like at that opportunity, I thank you guys for working on
> such infrastructure, in 2015 several bugs were found and fixed with that
> refcount debbuger, as is now the case with Ian's attempt.
> 
> Thanks!
> 
> - Arnaldo
>  
> > > If so, maybe you can do the same thing by introducing a dummy
> > > list node for each data structure which you want to debug.
> > >
> > > struct perf_cpu_map__refdebug {
> > >         struct perf_cpu_map__refdebug *orig;
> > > };
> > >
> > > And expand refcount_t as.
> > >
> > > typedef struct refcount_struct {
> > >         atomic_t refs;
> > > #ifdef REFCNT_CHECKING
> > >         void *orig;
> > > #endif
> > > } refcount_t;
> > >
> > > And change the get/put as below
> > >
> > > struct perf_cpu_map *perf_cpu_map__get(struct perf_cpu_map *map)
> > > {
> > >         if (map) {
> > > #ifdef REFCNT_CHECKING
> > >                 struct perf_cpu_map__refdebug *new_node;
> > > #endif
> > >                 refcount_inc(&map->refcnt);
> > > #ifdef REFCNT_CHECKING
> > >                 new_node = malloc(sizeof(*new_node));
> > >                 new_node->orig = map->refcnt->orig;
> > >                 map->refcnt->orig = new_node;
> > > #endif
> > >         }
> > >         return map;
> > > }
> > >
> > > void perf_cpu_map__put(struct perf_cpu_map *map)
> > > {
> > >         if (map) {
> > >                 if (refcount_dec_and_test(&map->refcnt))
> > >                         cpu_map__delete(map);
> > >                 else {
> > > #ifdef REFCNT_CHECKING
> > >                         struct perf_cpu_map__refdebug *node = map->refcnt->orig;
> > >
> > >                         map->refcnt->orig = node->orig;
> > >                         free(node);
> > > #endif
> > >                 }
> > >         }
> > > }
> > >
> > > This need a bit complex get/put, but no need to change other parts.
> > 
> > Adding a list like this gives an ability to say something like of the
> > current reference count of 3 what indirection objects exist. This
> > could be useful for diagnosis but you probably want to pair it with a
> > stack trace, and the approach here is punting that problem to the
> > address/leak sanitizer. I'm also concerned that there should be a lock
> > around the list. I think pursuing this ends up with something like
> > ref_tracker.
> > 
> > If we're using indirection, as in my proposal, then adding a common
> > indirection struct is problematic as anything declared to be a "struct
> > cpumap" now needs to be either the indirection or the original type -
> > hence using macros to hide that in the code. If we embed the
> > information into the refcount_t then we end up with something like
> > ref_tracker, API problems and losing use-after-put checking. Outside
> > of the macros, I think there is a simplicity to the approach I've put
> > forward.
> > 
> > > > The
> > > > question is, is it worth it to make sure use of the reference counted
> > > > object is correct and misuse is easier to diagnose?
> > >
> > > You mean the stackdump for every get/put as I did? That's a good
> > > question. Let's think what may happen.
> > >
> > > For example, if funcA() expects its caller funcB() will put the object
> > > but actually funcB() doesn't, or the funcC() which is the another
> > > caller of funcA()) doesn't expect the funcA() gets the object.
> > >
> > > funcA() {
> > >         get(obj);
> > >         return obj;
> > > }
> > >
> > > funcB() {
> > >         obj = funcA();
> > >         ...
> > >         // wrong! it should do put(obj);
> > > }
> > >
> > > funcC() {
> > >         obj = funcA();
> > >         get(obj);               // this is wrong get().
> > >         ...
> > >         put(obj);
> > > }
> > >
> > > If we just list the non-released object, both logs seems same because
> > > funcB()'s get/put pair will be skipped. If the analyzer shows the
> > > stacktrace when the object was got, maybe we can notice the difference
> > > of funcB() and funcC() path, but this is the simplest case. funcA()
> > > can be called from funcB/C via several different functions.
> > > But perhaps I'm too worried.
> > 
> > So in the logs we should see for funcB:
> > 
> > Memory leak of ... at:
> > malloc...
> > get...
> > funcA
> > funcB
> > ...
> > 
> > as the put on the indirection object was missed and this is now a leak
> > of the indirection object. For funcC we should see:
> > 
> > Memory leak of ... at:
> > malloc..
> > get..
> > funcA
> > funcC
> > 
> > So from the stack traces we can see that there is an unpaired get
> > happening in funcA called from either funcB and funcC, which means we
> > need to a put there. In the funcC case we can see the put was missed
> > from a call to funcA, rather than a get it made.
> > 
> > As the code in perf is complex, multi-threaded and sometimes
> > unintentionally racy a get may happen on 1 thread, the object is
> > placed in a global, the object is put by another thread and also
> > accessed by a 3rd thread. This is what was happening in the
> > dso->nsinfo case. The bug there is that there was a double put
> > happening by the third thread because of a race. Leak sanitizer treats
> > memory visible from a global as not a leak, this can mean to get the
> > most information on leaks in perf we need to aggressively
> > free/delete/deconstruct when terminating so that leaks become visible.
> > This feels to me like good hygiene, but it could also be argued to be
> > a tax.
> > 
> > Anyway, I think I'm still at the same point I was when I posted these
> > changes. That an indirection object is the simplest, smallest,
> > cleanest way to get the most information. I think making the rest of
> > the reference counted data structures have this feature would be
> > great, so I'd like to merge the 4 patches here and work to add more. I
> > think we can also build on that foundation for extra debug
> > information.
> > 
> > Thanks,
> > Ian
> > 
> > > Thank you,
> > >
> > > > I think it is near
> > > > as least offensive as possible while providing the best information -
> > > > hence being able to solve the dso->nsinfo put data race, that has been
> > > > a problem to solve up to this point. I'm open to better suggestions
> > > > though :-)
> > > >
> > > > Thanks again,
> > > > Ian
> > > >
> > > > > Thank you,
> > > > >
> > > > > --
> > > > > Masami Hiramatsu <mhiramat@kernel.org>
> > >
> > >
> > > --
> > > Masami Hiramatsu <mhiramat@kernel.org>
> 
> -- 
> 
> - Arnaldo


-- 
Masami Hiramatsu <mhiramat@kernel.org>
