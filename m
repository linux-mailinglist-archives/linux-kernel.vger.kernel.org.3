Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D80B94A3504
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 08:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235719AbiA3HzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 02:55:08 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:44062 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231380AbiA3HzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 02:55:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D82F561021;
        Sun, 30 Jan 2022 07:55:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B3AC340E4;
        Sun, 30 Jan 2022 07:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643529306;
        bh=wa86M2ntPMPCOKPQVEvbx1CNwFf6STVbmQ73fhaGe5g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QgOvs2HzyScSvpdwxas9nJV1t6YaKW89rB6aqvx1eGyk8WOpXW6QDVsFYZBm9y+Uj
         tAIeTY+Wyg3wfRq5Fiu7hs4hXhqJWNDmmrmNYUHVKQzkj1jeFJatimi4t29yyPgDKW
         ck6PRQ/MDtFIjo84lpcy0LrIh5LoSIZEe0aYOdceT7OCO/suheJEJ12z21+IO6uvdY
         LoeHflypa9mjc7Kvz754SFRxArRJjEx0rOeWS7A7V4IeiD+EvGV9DpnXwz9awNZXHU
         b0U6zExQSZc0IToQlCHxWRPSMyoTHlX3nble8h+OqFOG8uwpTLscAaDYi7xbNKqHwp
         yY3xAN5gprTXw==
Date:   Sun, 30 Jan 2022 16:54:55 +0900
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
Message-Id: <20220130165455.422f26c869bd3579c2d305a7@kernel.org>
In-Reply-To: <CAP-5=fVoP9MAVsj7SdrxRjkr1Jt=XZ7Vf_FAooXA7B2OrC=XMA@mail.gmail.com>
References: <20220125204602.4137477-1-irogers@google.com>
        <CAP-5=fXyJeX3b3egcAOfPndmYhakrsdKu7HttnHEH2DKP-6Vxw@mail.gmail.com>
        <20220128142348.17d51894dbdb35c9a9449567@kernel.org>
        <CAP-5=fXHudKqO4+0rbO9X3Ny+Cq7+KsHbKf4P8P24SjF0S232Q@mail.gmail.com>
        <20220129003450.77116209763f7e06d285e654@kernel.org>
        <CAP-5=fVoP9MAVsj7SdrxRjkr1Jt=XZ7Vf_FAooXA7B2OrC=XMA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2022 10:26:20 -0800
Ian Rogers <irogers@google.com> wrote:

> On Fri, Jan 28, 2022 at 7:35 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Thu, 27 Jan 2022 22:24:59 -0800
> > Ian Rogers <irogers@google.com> wrote:
> >
> > > On Thu, Jan 27, 2022 at 9:24 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > > >
> > > > On Thu, 27 Jan 2022 13:33:23 -0800
> > > > Ian Rogers <irogers@google.com> wrote:
> > > >
> > > > > On Tue, Jan 25, 2022 at 12:46 PM Ian Rogers <irogers@google.com> wrote:
> > > > > >
> > > > > > This v2 patch set has the main reference count patch for cpu map from
> > > > > > the first set and then adds reference count checking to nsinfo. The
> > > > > > reference count checking on nsinfo helped diagnose a data race bug
> > > > > > which is fixed in the independent patches 2 and 3.
> > > > > >
> > > > > > The perf tool has a class of memory problems where reference counts
> > > > > > are used incorrectly. Memory/address sanitizers and valgrind don't
> > > > > > provide useful ways to debug these problems, you see a memory leak
> > > > > > where the only pertinent information is the original allocation
> > > > > > site. What would be more useful is knowing where a get fails to have a
> > > > > > corresponding put, where there are double puts, etc.
> > > > > >
> > > > > > This work was motivated by the roll-back of:
> > > > > > https://lore.kernel.org/linux-perf-users/20211118193714.2293728-1-irogers@google.com/
> > > > > > where fixing a missed put resulted in a use-after-free in a different
> > > > > > context. There was a sense in fixing the issue that a game of
> > > > > > wac-a-mole had been embarked upon in adding missed gets and puts.
> > > > > >
> > > > > > The basic approach of the change is to add a level of indirection at
> > > > > > the get and put calls. Get allocates a level of indirection that, if
> > > > > > no corresponding put is called, becomes a memory leak (and associated
> > > > > > stack trace) that leak sanitizer can report. Similarly if two puts are
> > > > > > called for the same get, then a double free can be detected by address
> > > > > > sanitizer. This can also detect the use after put, which should also
> > > > > > yield a segv without a sanitizer.
> > > > > >
> > > > > > Adding reference count checking to cpu map was done as a proof of
> > > > > > concept, it yielded little other than a location where the use of get
> > > > > > could be cleaner by using its result. Reference count checking on
> > > > > > nsinfo identified a double free of the indirection layer and the
> > > > > > related threads, thereby identifying a data race as discussed here:
> > > > > > https://lore.kernel.org/linux-perf-users/CAP-5=fWZH20L4kv-BwVtGLwR=Em3AOOT+Q4QGivvQuYn5AsPRg@mail.gmail.com/
> > > > > > Accordingly the dso->lock was extended and use to cover the race.
> > > > > >
> > > > > > An alternative that was considered was ref_tracker:
> > > > > >  https://lwn.net/Articles/877603/
> > > > > > ref_tracker requires use of a reference counted struct to also use a
> > > > > > cookie/tracker. The cookie is combined with data in a ref_tracker_dir
> > > > > > to spot double puts. When an object is finished with leaks can be
> > > > > > detected, as with this approach when leak analysis happens. This
> > > > > > approach was preferred as it doesn't introduce cookies, spots use
> > > > > > after put and appears moderately more neutral to the API. Weaknesses
> > > > > > of the implemented approcah are not being able to do adhoc leak
> > > > > > detection and a preference for adding an accessor API to structs. I
> > > > > > believe there are other issues and welcome suggestions.
> > > > >
> > > > > And so we've been here before (Dec 2015 to be exact). Namhyung pointed me to:
> > > > > https://lore.kernel.org/all/20151209021047.10245.8918.stgit@localhost.localdomain/
> > > > > by Masami Hiramatsu. In this work he adds a leak sanitizer style
> > > > > reference count checker that will describe locations of puts and gets
> > > > > for diagnosis. Firstly that's an awesome achievement! This work is
> > > > > different in that it isn't trying to invent a leak sanitizer, it is
> > > > > just using the existing one. By adding a level of indirection this
> > > > > work can catch use after put and pairs gets with puts to make lifetime
> > > > > analysis more automatic. An advantage of Masami's work is that it
> > > > > doesn't change data-structures and after the initial patch-set is
> > > > > somewhat transparent. Overall I prefer the approach in these patches,
> > > > > future patches can look to clean up the API as Masami has.
> > > >
> > > > Thanks for referring my series :-D The series aimed to solve the refcount
> > > > usage issue in the perf which lead the object leaks. At that moment,
> > > > I found that there were 2 patterns, refcount start from 0 and start from 1.
> > > > That made me confused what I should do for using a object.
> > > > But the perf uses linux/refcount.h now, I hope such issue has already gone.
> > > > (but the object leakage seems not fixed fully yet, as you found.)
> > > >
> > > > BTW, I think the introducing UNWRAP_* macro may put a burden on future
> > > > development. If it is inevitable, we should consider it as carefully as
> > > > possible. Or, it may cause another issue (it is easily missed that the new
> > > > patch does not use UNWRAP_* for object reference, because it is natual.)
> > > >
> > > > So I agree with you that you to clean up the API. :-)
> > > > I think we can make yet another refcount.h for user space debugging and
> > > > replace it with the linux/refcount.h.
> > >
> > > Thanks Masami,
> > >
> > > Agreed on the UNWRAP_ macros, hence wanting to hide them behind
> > > accessors. Making accessors could be automated with macros, for
> > > example, have a list of variables, have a macro declare the struct
> > > using the list, another macro can use the list to declare accessors. I
> > > didn't find adding the UNWRAP_ macros in this change particularly
> > > burdensome as any use of the wrapping pointer as the original type
> > > caused a compile time error telling you what and where to fix. The
> > > macro is extra stuff in the way of using just the raw object, but
> > > that's fairly typical in C++ with shared_ptr, scoped_lock, etc.
> >
> > Hi Ian,
> >
> > Hmm, but such a macro is not usual for C which perf is written in.
> > If I understand correctly, you might want to use memory leak
> > analyzer to detect refcount leak, and that analyzer will show
> > what data structure is leaked.
> 
> Firstly, thanks for the conversation - this is really useful to
> improve the code!

Hi Ian,

You're welcome! This conversation also useful to me to understand
the issue deeper :-)

> I think in an ideal world we'd somehow educate things like address
> sanitizer of reference counted data structures and they would do a
> better job of tracking gets and puts. The problem is pairing gets and
> puts.

Agreed. From my experience, pairing gets and puts are hard without
reviewing the source code, since the refcounter is not only used in a
single function, but it is for keeping the object not released until
some long process is finished.

For example, if the correct pair is like below, funcA-funcD, funcB-funcC,
funcA (get)
funcB (get)
funcC (put)
funcD (put)

But depending on the execution timing, funcC/funcD can be swapped.
funcA (get)
funcB (get)
funcD (put)
funcC (put)

And if there is a bug, funcX may get the object by mistake.
funcA (get)
funcX (get)
funcB (get)
funcD (put)
funcC (put)

Or, funcC() might miss to put.
funcA (get)
funcB (get)
funcD (put)

In any case, just tracking the get/put, it is hard to know which pair
is not right. I saw these patterns when I debugged it. :(

> In C++ you use RAII types so that the destructor ensures a put -
> this can be complex when using data types like lists where you want to
> move or swap things onto the list, to keep the single pointer
> property. In the C code in Linux we use gotos, similarly to how defer
> is used in Go. Anyway, the ref_tracker that Eric Dumazet added solved
> the get/put pairing problem by adding a cookie that is passed around.

Cool! I will check the ref_tracker :)

> The problem with that is that then the cookie becomes part of the API.

What the cookie is? some pairing function address??

> To avoid that the approach here is just to change the original data
> type and add in a layer of indirection, that layer has become the
> cookie. A benefit of this approach is that once the cookie/indirection
> is freed, use of it becomes an obvious failure - we leverage address
> sanitizer for use after free.

Ah, got it. I thought that was anyway caught by address sanitizer by default, wasn't?

> 
> > If so, maybe you can do the same thing by introducing a dummy
> > list node for each data structure which you want to debug.
> >
> > struct perf_cpu_map__refdebug {
> >         struct perf_cpu_map__refdebug *orig;
> > };
> >
> > And expand refcount_t as.
> >
> > typedef struct refcount_struct {
> >         atomic_t refs;
> > #ifdef REFCNT_CHECKING
> >         void *orig;
> > #endif
> > } refcount_t;
> >
> > And change the get/put as below
> >
> > struct perf_cpu_map *perf_cpu_map__get(struct perf_cpu_map *map)
> > {
> >         if (map) {
> > #ifdef REFCNT_CHECKING
> >                 struct perf_cpu_map__refdebug *new_node;
> > #endif
> >                 refcount_inc(&map->refcnt);
> > #ifdef REFCNT_CHECKING
> >                 new_node = malloc(sizeof(*new_node));
> >                 new_node->orig = map->refcnt->orig;
> >                 map->refcnt->orig = new_node;
> > #endif
> >         }
> >         return map;
> > }
> >
> > void perf_cpu_map__put(struct perf_cpu_map *map)
> > {
> >         if (map) {
> >                 if (refcount_dec_and_test(&map->refcnt))
> >                         cpu_map__delete(map);
> >                 else {
> > #ifdef REFCNT_CHECKING
> >                         struct perf_cpu_map__refdebug *node = map->refcnt->orig;
> >
> >                         map->refcnt->orig = node->orig;
> >                         free(node);
> > #endif
> >                 }
> >         }
> > }
> >
> > This need a bit complex get/put, but no need to change other parts.
> 
> Adding a list like this gives an ability to say something like of the
> current reference count of 3 what indirection objects exist. This
> could be useful for diagnosis but you probably want to pair it with a
> stack trace, and the approach here is punting that problem to the
> address/leak sanitizer.

I think the pairing get/put should be done by manual. Without
reviewing the code, it is hard to know what was expected by the
original developer. :(

> I'm also concerned that there should be a lock
> around the list. I think pursuing this ends up with something like
> ref_tracker.

Good catch! Indeed, a lock is needed.

> If we're using indirection, as in my proposal, then adding a common
> indirection struct is problematic as anything declared to be a "struct
> cpumap" now needs to be either the indirection or the original type -
> hence using macros to hide that in the code. If we embed the
> information into the refcount_t then we end up with something like
> ref_tracker, API problems and losing use-after-put checking. Outside
> of the macros, I think there is a simplicity to the approach I've put
> forward.

OK, so the "use-after-put" is what you solve. That is indeed hard to
check without introducing indirect pointer, because "use-after-put"
is different from "use-after-free", it will use the same "object"
but that has just a decremented refcounter.

funcA(obj) {
  get(obj);
  ...
  put(obj);
}

funcA2(obj) {
  ...
  obj_access(obj); <- //use-after-put? (or use-no-get?)
}

funcB() {
  obj = new_obj()
  get(obj);
  funcA(obj);
  funcA2(obj);
  put(obj);
}

So my question is that we need to pay the cost to use UNWRAP_ macro
on all those object just for finding the "use-after-put" case.
Usually the case that "use-after-put" causes actual problem is very
limited, or it can be "use-after-free".

funcA(obj) {
  get(obj);
  ...
  put(obj);	// without funcB()'s get, obj will be freed here.
}

funcB() {
  obj = new_obj()
  // get(obj) <-- forgot to get the refcounter
  funcA(obj)
  obj_access(obj) <- //use after put!
}

In above case, use-after-put will be use-after-free, because obj is
freed.

If we can re-define the '->' operator, this is completely hidden
from programmers, but C has no such feature. Maybe we can use a
hidden data structure and accessors to prohibit user using '->'
on such object (e.g. elfutils) but it may increase runtime
overhead (LTO might be a remedy). And anyway inside the object
definition file, it need to use UNWRAP_ macro (also, it must use
object pointer returned from get() method.)

> 
> > > The
> > > question is, is it worth it to make sure use of the reference counted
> > > object is correct and misuse is easier to diagnose?
> >
> > You mean the stackdump for every get/put as I did? That's a good
> > question. Let's think what may happen.
> >
> > For example, if funcA() expects its caller funcB() will put the object
> > but actually funcB() doesn't, or the funcC() which is the another
> > caller of funcA()) doesn't expect the funcA() gets the object.
> >
> > funcA() {
> >         get(obj);
> >         return obj;
> > }
> >
> > funcB() {
> >         obj = funcA();
> >         ...
> >         // wrong! it should do put(obj);
> > }
> >
> > funcC() {
> >         obj = funcA();
> >         get(obj);               // this is wrong get().
> >         ...
> >         put(obj);
> > }
> >
> > If we just list the non-released object, both logs seems same because
> > funcB()'s get/put pair will be skipped. If the analyzer shows the
> > stacktrace when the object was got, maybe we can notice the difference
> > of funcB() and funcC() path, but this is the simplest case. funcA()
> > can be called from funcB/C via several different functions.
> > But perhaps I'm too worried.
> 
> So in the logs we should see for funcB:
> 
> Memory leak of ... at:
> malloc...
> get...
> funcA
> funcB
> ...

Yeah, OK. and I think this can be done without anything because "obj"
is not released anyway. Am I correct?

> 
> as the put on the indirection object was missed and this is now a leak
> of the indirection object. For funcC we should see:
> 
> Memory leak of ... at:
> malloc..
> get..
> funcA
> funcC

And this is also be done with my proposal too. (of course the leaked
object type name will be perf_cpu_map__refdebug)

> 
> So from the stack traces we can see that there is an unpaired get
> happening in funcA called from either funcB and funcC, which means we
> need to a put there. In the funcC case we can see the put was missed
> from a call to funcA, rather than a get it made.

So you meant we only need a log of the malloced (== get) place with
backtrace, right? Yeah, I think that may be enoguh. When I wrote my
previous work (2015), I tried to expose information as much as possible. 

> 
> As the code in perf is complex, multi-threaded and sometimes
> unintentionally racy a get may happen on 1 thread, the object is
> placed in a global, the object is put by another thread and also
> accessed by a 3rd thread. This is what was happening in the
> dso->nsinfo case. The bug there is that there was a double put
> happening by the third thread because of a race. Leak sanitizer treats
> memory visible from a global as not a leak, this can mean to get the
> most information on leaks in perf we need to aggressively
> free/delete/deconstruct when terminating so that leaks become visible.
> This feels to me like good hygiene, but it could also be argued to be
> a tax.

Got it. So we need to make the global object visible to leak sanitizer.
For this reason you made get() to malloc() (get will allocate a
local object.)

> 
> Anyway, I think I'm still at the same point I was when I posted these
> changes. That an indirection object is the simplest, smallest,
> cleanest way to get the most information. I think making the rest of
> the reference counted data structures have this feature would be
> great, so I'd like to merge the 4 patches here and work to add more. I
> think we can also build on that foundation for extra debug
> information.

For me, your change aims to 2 goals, (1) catch the global object leak,
(2) catch the "use-after-put". And I think (1) is possible to be solved
without the indirection object because the required technic is changing
get() into malloc() some data. On the other hand, the (2) is solved only
by the indirection object. And I think the case that (2) becomes real
problem is when it turns into "use-after-free". So I think it may be
possible to be caught by the address sanitizer.


Thank you,

> 
> Thanks,
> Ian
> 
> > Thank you,
> >
> > > I think it is near
> > > as least offensive as possible while providing the best information -
> > > hence being able to solve the dso->nsinfo put data race, that has been
> > > a problem to solve up to this point. I'm open to better suggestions
> > > though :-)
> > >
> > > Thanks again,
> > > Ian
> > >
> > > > Thank you,
> > > >
> > > > --
> > > > Masami Hiramatsu <mhiramat@kernel.org>
> >
> >
> > --
> > Masami Hiramatsu <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
