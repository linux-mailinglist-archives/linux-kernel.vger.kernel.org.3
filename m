Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700564A9B87
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 15:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241015AbiBDO5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 09:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbiBDO5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 09:57:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F69C061714;
        Fri,  4 Feb 2022 06:57:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B1C461357;
        Fri,  4 Feb 2022 14:57:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24ADBC340E9;
        Fri,  4 Feb 2022 14:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643986667;
        bh=73kyMla1rARD0eouCsRmwt+XNkfQp2gCtf6K21kLxRU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=d3o+jZkCEx+EGHIgqj8zJtf/ominRCuBCnfTnii69KIYijpUajRPwx90Wr2ynm3Aj
         YA/xLYwUlMdNPMsjEGW66zZAujqmPOYWEMvNAmH3yejDjIBQH3mb+dftZqDMCcjvnh
         rgBCMXoVn/WAQUSN7dKZIwG2LSK22aFAsdBzYLjevWQZaOAKMtAUU0ifqEZzeuJD51
         +KTpnN0aqwJ0kMVVb3Ha1c/vnJQ+JUmgKTVqpbNBguM2rHn1ZBwparW3/D4lugoATi
         8yt5p803VgQF+MC1DmJvo8xzrfrDg5AwVRnedOEXXBLNdwCK34AGtb30GtDo7xDhKG
         FO1n05Q4AStWA==
Date:   Fri, 4 Feb 2022 23:57:37 +0900
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
Message-Id: <20220204235737.657675e6e468c367c13fc1b2@kernel.org>
In-Reply-To: <CAP-5=fVeQ4rzgpD3PS5-147xOp=wp+8U-rkLRqreJ616Vy89rA@mail.gmail.com>
References: <20220125204602.4137477-1-irogers@google.com>
        <CAP-5=fXyJeX3b3egcAOfPndmYhakrsdKu7HttnHEH2DKP-6Vxw@mail.gmail.com>
        <20220128142348.17d51894dbdb35c9a9449567@kernel.org>
        <CAP-5=fXHudKqO4+0rbO9X3Ny+Cq7+KsHbKf4P8P24SjF0S232Q@mail.gmail.com>
        <20220129003450.77116209763f7e06d285e654@kernel.org>
        <CAP-5=fVoP9MAVsj7SdrxRjkr1Jt=XZ7Vf_FAooXA7B2OrC=XMA@mail.gmail.com>
        <20220130165455.422f26c869bd3579c2d305a7@kernel.org>
        <CAP-5=fVeQ4rzgpD3PS5-147xOp=wp+8U-rkLRqreJ616Vy89rA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Jan 2022 09:40:21 -0800
Ian Rogers <irogers@google.com> wrote:

> > > > Hi Ian,
> > > >
> > > > Hmm, but such a macro is not usual for C which perf is written in.
> > > > If I understand correctly, you might want to use memory leak
> > > > analyzer to detect refcount leak, and that analyzer will show
> > > > what data structure is leaked.
> > >
> > > Firstly, thanks for the conversation - this is really useful to
> > > improve the code!
> >
> > Hi Ian,
> >
> > You're welcome! This conversation also useful to me to understand
> > the issue deeper :-)
> >
> > > I think in an ideal world we'd somehow educate things like address
> > > sanitizer of reference counted data structures and they would do a
> > > better job of tracking gets and puts. The problem is pairing gets and
> > > puts.
> >
> > Agreed. From my experience, pairing gets and puts are hard without
> > reviewing the source code, since the refcounter is not only used in a
> > single function, but it is for keeping the object not released until
> > some long process is finished.
> >
> > For example, if the correct pair is like below, funcA-funcD, funcB-funcC,
> > funcA (get)
> > funcB (get)
> > funcC (put)
> > funcD (put)
> >
> > But depending on the execution timing, funcC/funcD can be swapped.
> > funcA (get)
> > funcB (get)
> > funcD (put)
> > funcC (put)
> >
> > And if there is a bug, funcX may get the object by mistake.
> > funcA (get)
> > funcX (get)
> > funcB (get)
> > funcD (put)
> > funcC (put)
> >
> > Or, funcC() might miss to put.
> > funcA (get)
> > funcB (get)
> > funcD (put)
> >
> > In any case, just tracking the get/put, it is hard to know which pair
> > is not right. I saw these patterns when I debugged it. :(
> 
> Yep, I've found this issue too :-) The get is being used for the
> side-effect of incrementing a reference count rather than for
> returning the value. This happened in cpumap merge and was easy to fix
> there.
> 
> This problem is possible in general, but I think if it were common we
> are doomed. I don't think this pattern is common though. In general a
> reference count is owned by something, the scope of a function or the
> lifetime of a list. If puts were adhoc then it would mean that one
> occurring in a function could be doing it for the side effect of
> freeing on a list. I don't think the code aims to do that. Making the
> code clean with pairing gets and puts is an issue, like with the
> cpumap merge change.

Hi Ian,
Sorry for waiting.

I got the pairing of get/put is not so hard if we use your
programing pattern. The problem was the posession of the object.
As you proposed, if we force users to use the returning "token"
instead of object pointer itself as below;

funcA(obj) {
  token = get(obj);
  get_obj(token)->...
  put(token);
}

Then it is clear who leaks the token.

 funcA (get-> token1)
 funcX (get-> token3)
 funcB (get-> token2)
 funcD (put-> token2)
 funcC (put-> token1)

In this case token3 is not freed, thus the funcX's pair is lost.
Or,

 funcA (get-> token1)
 funcB (get-> token2)
 funcD (put-> token2)

In this case funcA's pair is lost.

And if the user access object with the token which already put,
it can be detected.


> 
> > > In C++ you use RAII types so that the destructor ensures a put -
> > > this can be complex when using data types like lists where you want to
> > > move or swap things onto the list, to keep the single pointer
> > > property. In the C code in Linux we use gotos, similarly to how defer
> > > is used in Go. Anyway, the ref_tracker that Eric Dumazet added solved
> > > the get/put pairing problem by adding a cookie that is passed around.
> >
> > Cool! I will check the ref_tracker :)
> >
> > > The problem with that is that then the cookie becomes part of the API.
> >
> > What the cookie is? some pairing function address??
> 
> As I understand it, a token to identify a get.

Yeah, I slightly missed that your API will force caller to use the
returning token instead of object.
So, what about using token always, instead of wrapping the object
pointer only when debugging?

I felt uncomfortable about changing the data structure name according
to the debug macro. Instead, it is better way for me if get() always
returns a token of the object and users need to convert the
token to the object. For example;

struct perf_cpu_map {
...
};

#ifdef REFCNT_CHECKING
typedef struct {struct perf_cpu_map *orig;} perf_cpu_map_token_t;
#else
typedef unsigned long perf_cpu_map_token_t;	/* actually this is "struct perf_cpu_map *" */
#endif

perf_cpu_map_token_t perf_cpu_map__get(struct perf_cpu_map *map);
void perf_cpu_map__put(struct perf_cpu_map_token_t tok);

This explicitly forces users to convert the token to the object
when using it. Of course if a user uses the object pointer ("map" here)
directly, the token is not used. But we can check such wrong usage by
compilation.

[...]
> > So my question is that we need to pay the cost to use UNWRAP_ macro
> > on all those object just for finding the "use-after-put" case.
> > Usually the case that "use-after-put" causes actual problem is very
> > limited, or it can be "use-after-free".
> 
> So the dso->nsinfo case was a use after put once we added in the
> missing put - it could also be thought of as a double put/free. In
> general use-after-put is going to show where a strict get-then-put
> isn't being followed, if we make sure of that property then the
> reference counting will be accurate.

The double free/put will be detected different way. But indeed the
use-after-put can be overlooked (I think there actually be the
case, it should be "use-after-free" but it depends on the timing.)

> 
> A case that came up previously was maps__find:
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/map.c#n974
> this code retuns a map but without doing a get on it, even though a
> map is reference counted:
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/map.h#n46
> If we change that code to return a get of the map then we add overhead
> for simple cases of checking a map is present - you can infer you have
> a reference count on the map if you have it on the maps. The
> indirection allows the code to remain as-is, while being able to catch
> misuse.

I don't think using the UNWRAP_* macro is "remain as-is" ;) but I agree
with you that can catch the misuse.

IMHO, I rather like using the explicit token. I don't like to see
"UNWRAP_map(map)->field", but "GET_map(token)->field" is good for me.
This is because the "map" should be a pointer of data structure (so
its field can be accessed without any wrapper), but token is just a
value (so this implies that it must be converted always). 
In other words, "map->field" looks natural for reviewing, but
"token->field" looks obviously strange.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
