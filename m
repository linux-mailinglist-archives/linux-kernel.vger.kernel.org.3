Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54FA94A37E7
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 18:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355749AbiA3Rkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 12:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345419AbiA3Rke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 12:40:34 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4077FC06173B
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 09:40:34 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id e79so13925529iof.13
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 09:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ovqIVeDvtUw5d6sqZ5DWn4PqNMW0VC3mEcA+ogXQVk0=;
        b=IMNNPDAE4bY8LS3IMj1xwq5jvR74X9W6OjEVQ9kas++N5pe0d1PBWP67RWeBBizCk8
         VlW2QKusyrgWdcnO2GCM4NstoG6qAuRWe8/CqHRaExSEqlDEJuRXsoSolVZTdzF0/KqU
         Ol26om6JKNDjHSh/OXS4OIy03RRonnfezdgWWwcxHta5nZ/at71sXcHlyL1WMp/QtH3z
         vbppU1cUfg/Yjr4P91+uXOO6ySdrgCZPCsDQU9IwgWixRXMzWKJyFTIzod8oGZMp7tNP
         GDK4S0jt7H1WXuOAwMes/h8xx5Exn882WBa+VFnbZgT22odgCBQg0Zfd+VbT+zEIJvcp
         H1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ovqIVeDvtUw5d6sqZ5DWn4PqNMW0VC3mEcA+ogXQVk0=;
        b=oTQXiGfxhUkAVvuyBIRGHX4S++M1gU8oQmS6diu3itdiX+qPq4MOScKK6ssx/4/5xm
         /xrGQygw41mwkCd8E8SXUUwqACbbQaA4agTnC/emp9RIofPSixExUbob6MAVr0uLe8pp
         3vNd8a8E3Cq8A3xjTpOpRSQBVFIym5kO6TIuyuUCh1tRN692Y/V2gP6hdQYFojU6mZnt
         C7bQ74VShh2K0FFHt6dIZL5/VrL/Z9ukpr8Y1cDQoB1d/JTFweygC8/qMI6Gz+9IaUQK
         PKskeJVtlK/FRxQUPTOGNch3767h/VbJbXSx7YVb3twn16C6r/Upt7Qzs4umIwvd+58/
         v+KQ==
X-Gm-Message-State: AOAM533ys4uW5EGUmD/9LDLNQBmcTIKu2xmNh7D03VjqXNlqq/GmMQbp
        8uOE1KjwKLT9SHZWJ5sORVJ0SfG4YZW6UYXzyUeu7Q==
X-Google-Smtp-Source: ABdhPJz0Jzjq2YTJoIfYhYTIrqwA8H1H267lRPW4D3ffPrGhvsOvTa+3RDlm3lOROhDttPhHOoXgPSUhBsbpEfpy2ts=
X-Received: by 2002:a05:6602:15c8:: with SMTP id f8mr9688302iow.35.1643564432981;
 Sun, 30 Jan 2022 09:40:32 -0800 (PST)
MIME-Version: 1.0
References: <20220125204602.4137477-1-irogers@google.com> <CAP-5=fXyJeX3b3egcAOfPndmYhakrsdKu7HttnHEH2DKP-6Vxw@mail.gmail.com>
 <20220128142348.17d51894dbdb35c9a9449567@kernel.org> <CAP-5=fXHudKqO4+0rbO9X3Ny+Cq7+KsHbKf4P8P24SjF0S232Q@mail.gmail.com>
 <20220129003450.77116209763f7e06d285e654@kernel.org> <CAP-5=fVoP9MAVsj7SdrxRjkr1Jt=XZ7Vf_FAooXA7B2OrC=XMA@mail.gmail.com>
 <20220130165455.422f26c869bd3579c2d305a7@kernel.org>
In-Reply-To: <20220130165455.422f26c869bd3579c2d305a7@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Sun, 30 Jan 2022 09:40:21 -0800
Message-ID: <CAP-5=fVeQ4rzgpD3PS5-147xOp=wp+8U-rkLRqreJ616Vy89rA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Reference count checker and related fixes
To:     Masami Hiramatsu <mhiramat@kernel.org>
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
        =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@collabora.com>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2022 at 11:55 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> On Fri, 28 Jan 2022 10:26:20 -0800
> Ian Rogers <irogers@google.com> wrote:
>
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
>
> Hi Ian,
>
> You're welcome! This conversation also useful to me to understand
> the issue deeper :-)
>
> > I think in an ideal world we'd somehow educate things like address
> > sanitizer of reference counted data structures and they would do a
> > better job of tracking gets and puts. The problem is pairing gets and
> > puts.
>
> Agreed. From my experience, pairing gets and puts are hard without
> reviewing the source code, since the refcounter is not only used in a
> single function, but it is for keeping the object not released until
> some long process is finished.
>
> For example, if the correct pair is like below, funcA-funcD, funcB-funcC,
> funcA (get)
> funcB (get)
> funcC (put)
> funcD (put)
>
> But depending on the execution timing, funcC/funcD can be swapped.
> funcA (get)
> funcB (get)
> funcD (put)
> funcC (put)
>
> And if there is a bug, funcX may get the object by mistake.
> funcA (get)
> funcX (get)
> funcB (get)
> funcD (put)
> funcC (put)
>
> Or, funcC() might miss to put.
> funcA (get)
> funcB (get)
> funcD (put)
>
> In any case, just tracking the get/put, it is hard to know which pair
> is not right. I saw these patterns when I debugged it. :(

Yep, I've found this issue too :-) The get is being used for the
side-effect of incrementing a reference count rather than for
returning the value. This happened in cpumap merge and was easy to fix
there.

This problem is possible in general, but I think if it were common we
are doomed. I don't think this pattern is common though. In general a
reference count is owned by something, the scope of a function or the
lifetime of a list. If puts were adhoc then it would mean that one
occurring in a function could be doing it for the side effect of
freeing on a list. I don't think the code aims to do that. Making the
code clean with pairing gets and puts is an issue, like with the
cpumap merge change.

> > In C++ you use RAII types so that the destructor ensures a put -
> > this can be complex when using data types like lists where you want to
> > move or swap things onto the list, to keep the single pointer
> > property. In the C code in Linux we use gotos, similarly to how defer
> > is used in Go. Anyway, the ref_tracker that Eric Dumazet added solved
> > the get/put pairing problem by adding a cookie that is passed around.
>
> Cool! I will check the ref_tracker :)
>
> > The problem with that is that then the cookie becomes part of the API.
>
> What the cookie is? some pairing function address??

As I understand it, a token to identify a get.

> > To avoid that the approach here is just to change the original data
> > type and add in a layer of indirection, that layer has become the
> > cookie. A benefit of this approach is that once the cookie/indirection
> > is freed, use of it becomes an obvious failure - we leverage address
> > sanitizer for use after free.
>
> Ah, got it. I thought that was anyway caught by address sanitizer by default, wasn't?

Out of the box, address sanitizer will tell you where the reference
counted thing was created and about double frees. Leak sanitizer, that
runs with address sanitizer, will tell about leaks.  Our problem is
knowing we have leaks but not having enough information to debug the
unpaired gets and puts.

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
> > address/leak sanitizer.
>
> I think the pairing get/put should be done by manual. Without
> reviewing the code, it is hard to know what was expected by the
> original developer. :(
>
> > I'm also concerned that there should be a lock
> > around the list. I think pursuing this ends up with something like
> > ref_tracker.
>
> Good catch! Indeed, a lock is needed.
>
> > If we're using indirection, as in my proposal, then adding a common
> > indirection struct is problematic as anything declared to be a "struct
> > cpumap" now needs to be either the indirection or the original type -
> > hence using macros to hide that in the code. If we embed the
> > information into the refcount_t then we end up with something like
> > ref_tracker, API problems and losing use-after-put checking. Outside
> > of the macros, I think there is a simplicity to the approach I've put
> > forward.
>
> OK, so the "use-after-put" is what you solve. That is indeed hard to
> check without introducing indirect pointer, because "use-after-put"
> is different from "use-after-free", it will use the same "object"
> but that has just a decremented refcounter.
>
> funcA(obj) {
>   get(obj);
>   ...
>   put(obj);
> }
>
> funcA2(obj) {
>   ...
>   obj_access(obj); <- //use-after-put? (or use-no-get?)
> }
>
> funcB() {
>   obj = new_obj()
>   get(obj);
>   funcA(obj);
>   funcA2(obj);
>   put(obj);
> }
>
> So my question is that we need to pay the cost to use UNWRAP_ macro
> on all those object just for finding the "use-after-put" case.
> Usually the case that "use-after-put" causes actual problem is very
> limited, or it can be "use-after-free".

So the dso->nsinfo case was a use after put once we added in the
missing put - it could also be thought of as a double put/free. In
general use-after-put is going to show where a strict get-then-put
isn't being followed, if we make sure of that property then the
reference counting will be accurate.

A case that came up previously was maps__find:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/map.c#n974
this code retuns a map but without doing a get on it, even though a
map is reference counted:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/map.h#n46
If we change that code to return a get of the map then we add overhead
for simple cases of checking a map is present - you can infer you have
a reference count on the map if you have it on the maps. The
indirection allows the code to remain as-is, while being able to catch
misuse.

> funcA(obj) {
>   get(obj);
>   ...
>   put(obj);     // without funcB()'s get, obj will be freed here.
> }
>
> funcB() {
>   obj = new_obj()
>   // get(obj) <-- forgot to get the refcounter
>   funcA(obj)
>   obj_access(obj) <- //use after put!
> }
>
> In above case, use-after-put will be use-after-free, because obj is
> freed.
>
> If we can re-define the '->' operator, this is completely hidden
> from programmers, but C has no such feature. Maybe we can use a
> hidden data structure and accessors to prohibit user using '->'
> on such object (e.g. elfutils) but it may increase runtime
> overhead (LTO might be a remedy). And anyway inside the object
> definition file, it need to use UNWRAP_ macro (also, it must use
> object pointer returned from get() method.)

Yeah, I could imagine adding attributes to the struct that address
sanitizer in the compiler could use to inject things.

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
>
> Yeah, OK. and I think this can be done without anything because "obj"
> is not released anyway. Am I correct?

It needs the indirection otherwise you don't know which get is the leak.

> >
> > as the put on the indirection object was missed and this is now a leak
> > of the indirection object. For funcC we should see:
> >
> > Memory leak of ... at:
> > malloc..
> > get..
> > funcA
> > funcC
>
> And this is also be done with my proposal too. (of course the leaked
> object type name will be perf_cpu_map__refdebug)
>
> >
> > So from the stack traces we can see that there is an unpaired get
> > happening in funcA called from either funcB and funcC, which means we
> > need to a put there. In the funcC case we can see the put was missed
> > from a call to funcA, rather than a get it made.
>
> So you meant we only need a log of the malloced (== get) place with
> backtrace, right? Yeah, I think that may be enoguh. When I wrote my
> previous work (2015), I tried to expose information as much as possible.
>
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
>
> Got it. So we need to make the global object visible to leak sanitizer.
> For this reason you made get() to malloc() (get will allocate a
> local object.)
>
> >
> > Anyway, I think I'm still at the same point I was when I posted these
> > changes. That an indirection object is the simplest, smallest,
> > cleanest way to get the most information. I think making the rest of
> > the reference counted data structures have this feature would be
> > great, so I'd like to merge the 4 patches here and work to add more. I
> > think we can also build on that foundation for extra debug
> > information.
>
> For me, your change aims to 2 goals, (1) catch the global object leak,
> (2) catch the "use-after-put". And I think (1) is possible to be solved
> without the indirection object because the required technic is changing
> get() into malloc() some data. On the other hand, the (2) is solved only
> by the indirection object. And I think the case that (2) becomes real
> problem is when it turns into "use-after-free". So I think it may be
> possible to be caught by the address sanitizer.

I think use-after-free can be a good signal, but for trying to get the
hygiene right use-after-put is what we need. I'm basically using the
leak sanitizer and the indirection as a scoped thing, using a scoped
thing outside of its scope is only caught by use-after-put.

Thanks,
Ian

> Thank you,
>
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
>
> --
> Masami Hiramatsu <mhiramat@kernel.org>
