Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A64049ED6F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 22:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344373AbiA0Vdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 16:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234277AbiA0Vdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 16:33:36 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C5EC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 13:33:36 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id s18so5323993ioa.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 13:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AkWhkErOaaGeZL8ocxFDn7Kgolw0UYypjy3bMg4xiaY=;
        b=IJ+kN8654Be+0HkMyS3xFHIfpUa3lAjzIWoun/MqapoDbS1gN54UWJQUgcbzuDpid+
         81SK7rtZzhcrYmy9R6Njswk94bIDDlBYilaAYSrePm2rclsrwWRB0yAKtuLYkCH3AgR+
         GK9PJP/norofGVPdQu1YT3uZENoKMSbTu3au5kv6a8JfRd9tEjkjiDKNS1f3kqF8EoB5
         OczqEDpdSDVoa7ihLbBvnc9mxV1U1HRa8zaHqv789lxp8RAqV9ZNvBqoA4OeZQPCnWTF
         0rfM+nsYbcJjSqn0XkjsTwGMgZUIy5R/wPzqqYvY2Iuk86sw/ZPIXr0KSmY598CaghWN
         9bbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AkWhkErOaaGeZL8ocxFDn7Kgolw0UYypjy3bMg4xiaY=;
        b=FCWt2p5wigqgNZZDDD/KNhFyaQC8jIRorTVHinfDVlIK7ugOObsOc0g3HTMhiI5RX4
         ZxdhWtkbYQeLjgh4m7dScRmvBevAdwszyX2mjsnnG3muXp+CW3mBg8X6acX+EvNTMmqg
         YfNnmFh87KEVJYoZAPP9GM/mykj96NTbB7+RQ6vNOijLPNG2gs+5Lu8+tWZmBl/uhyKW
         D4sqKkb/b33Ong19aA7RDtnsO8arTW949yDGqzMTvrqkNWFDEt7heNlk1zrMbZ9KhEH/
         bgYw0OKvWfdiB2GmXgMWXfz5YWIzxouN4vY9rSjF+93IYBaf6eH+uu6aOFVdUr2xBHVw
         1K1A==
X-Gm-Message-State: AOAM532Pppt6cbkvGawBD4bPC/GGGafUNRuuH7ZHSPcgOgJdaIReLXv3
        r16jSwLw0olgiXLRXaepPKg8JiOtmB4vmvYY0OMTuQ==
X-Google-Smtp-Source: ABdhPJx+Wt35+dHf0k4Puv5RiPxMzx3gU6jSGtSplwV/cvOr/uZwYuLtKNhSZJMFRa11rhxmdDF3lI1eVsZgFxVE5t8=
X-Received: by 2002:a05:6638:3781:: with SMTP id w1mr1245882jal.26.1643319215804;
 Thu, 27 Jan 2022 13:33:35 -0800 (PST)
MIME-Version: 1.0
References: <20220125204602.4137477-1-irogers@google.com>
In-Reply-To: <20220125204602.4137477-1-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 27 Jan 2022 13:33:23 -0800
Message-ID: <CAP-5=fXyJeX3b3egcAOfPndmYhakrsdKu7HttnHEH2DKP-6Vxw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Reference count checker and related fixes
To:     Peter Zijlstra <peterz@infradead.org>,
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
        masami.hiramatsu.pt@hitachi.com
Cc:     eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 12:46 PM Ian Rogers <irogers@google.com> wrote:
>
> This v2 patch set has the main reference count patch for cpu map from
> the first set and then adds reference count checking to nsinfo. The
> reference count checking on nsinfo helped diagnose a data race bug
> which is fixed in the independent patches 2 and 3.
>
> The perf tool has a class of memory problems where reference counts
> are used incorrectly. Memory/address sanitizers and valgrind don't
> provide useful ways to debug these problems, you see a memory leak
> where the only pertinent information is the original allocation
> site. What would be more useful is knowing where a get fails to have a
> corresponding put, where there are double puts, etc.
>
> This work was motivated by the roll-back of:
> https://lore.kernel.org/linux-perf-users/20211118193714.2293728-1-irogers@google.com/
> where fixing a missed put resulted in a use-after-free in a different
> context. There was a sense in fixing the issue that a game of
> wac-a-mole had been embarked upon in adding missed gets and puts.
>
> The basic approach of the change is to add a level of indirection at
> the get and put calls. Get allocates a level of indirection that, if
> no corresponding put is called, becomes a memory leak (and associated
> stack trace) that leak sanitizer can report. Similarly if two puts are
> called for the same get, then a double free can be detected by address
> sanitizer. This can also detect the use after put, which should also
> yield a segv without a sanitizer.
>
> Adding reference count checking to cpu map was done as a proof of
> concept, it yielded little other than a location where the use of get
> could be cleaner by using its result. Reference count checking on
> nsinfo identified a double free of the indirection layer and the
> related threads, thereby identifying a data race as discussed here:
> https://lore.kernel.org/linux-perf-users/CAP-5=fWZH20L4kv-BwVtGLwR=Em3AOOT+Q4QGivvQuYn5AsPRg@mail.gmail.com/
> Accordingly the dso->lock was extended and use to cover the race.
>
> An alternative that was considered was ref_tracker:
>  https://lwn.net/Articles/877603/
> ref_tracker requires use of a reference counted struct to also use a
> cookie/tracker. The cookie is combined with data in a ref_tracker_dir
> to spot double puts. When an object is finished with leaks can be
> detected, as with this approach when leak analysis happens. This
> approach was preferred as it doesn't introduce cookies, spots use
> after put and appears moderately more neutral to the API. Weaknesses
> of the implemented approcah are not being able to do adhoc leak
> detection and a preference for adding an accessor API to structs. I
> believe there are other issues and welcome suggestions.

And so we've been here before (Dec 2015 to be exact). Namhyung pointed me to:
https://lore.kernel.org/all/20151209021047.10245.8918.stgit@localhost.localdomain/
by Masami Hiramatsu. In this work he adds a leak sanitizer style
reference count checker that will describe locations of puts and gets
for diagnosis. Firstly that's an awesome achievement! This work is
different in that it isn't trying to invent a leak sanitizer, it is
just using the existing one. By adding a level of indirection this
work can catch use after put and pairs gets with puts to make lifetime
analysis more automatic. An advantage of Masami's work is that it
doesn't change data-structures and after the initial patch-set is
somewhat transparent. Overall I prefer the approach in these patches,
future patches can look to clean up the API as Masami has.

Thanks,
Ian

> Ian Rogers (4):
>   perf cpumap: Add reference count checking
>   perf dso: Make lock error check and add BUG_ONs
>   perf dso: Hold lock when accessing nsinfo
>   perf namespaces: Add reference count checking
>
>  tools/lib/perf/cpumap.c                  | 120 ++++++++++-----
>  tools/lib/perf/include/internal/cpumap.h |  14 +-
>  tools/perf/builtin-inject.c              |   6 +-
>  tools/perf/builtin-probe.c               |   2 +-
>  tools/perf/tests/cpumap.c                |  20 ++-
>  tools/perf/util/build-id.c               |   4 +-
>  tools/perf/util/cpumap.c                 |  42 ++---
>  tools/perf/util/dso.c                    |  17 ++-
>  tools/perf/util/jitdump.c                |  10 +-
>  tools/perf/util/map.c                    |   7 +-
>  tools/perf/util/namespaces.c             | 187 ++++++++++++++++-------
>  tools/perf/util/namespaces.h             |  23 ++-
>  tools/perf/util/pmu.c                    |  24 +--
>  tools/perf/util/probe-event.c            |   2 +
>  tools/perf/util/symbol.c                 |  10 +-
>  15 files changed, 337 insertions(+), 151 deletions(-)
>
> --
> 2.35.0.rc0.227.g00780c9af4-goog
>
