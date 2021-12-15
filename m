Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C30476047
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 19:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245413AbhLOSJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 13:09:07 -0500
Received: from mail-lj1-f182.google.com ([209.85.208.182]:37780 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238804AbhLOSJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 13:09:05 -0500
Received: by mail-lj1-f182.google.com with SMTP id k2so34549200lji.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 10:09:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wg92UbpxiHJQo9VenySQi0trc/483Lrpzxj0TRwK9+c=;
        b=TYRtasvq1ryZCnX7YNBewFweuRelvWaqraLUD5EJqKppd2Dc3hhYgoFyBu+U30brjM
         pfSFJgkjVyLsXApPvNRq9/+j9VGOGSkQtHw8ZtUvaX0WGjXzCnjAM5rV4EaYukweIVaI
         AFfxurENkm/J72wSl3HknMwAdmEaEFlmZH5V4K7g3o3kewyT1/Y3Y0E6sRLTJvJINABj
         FbHKzfRAClO30n9WtwAENoO97FYWflIFSwQtebOSzYb7KQ+ePmq4maVU0VvUP5PUwvAE
         W1w5x4vSEWGQRpkNituOtyKNDkmh2agziviHir6fjnUS47ixMzLNQs16F5ZHCdvH3TAm
         eFcw==
X-Gm-Message-State: AOAM530BBIHAOWz6JgaXPDfmRsMRB193vgYbyPaKA46oXMq0zXq7nBgW
        0kX56NIBMu8q10LrnyJZkLnKW5/AQEfKa/jRZRVZlDMW
X-Google-Smtp-Source: ABdhPJy5GYIsPJBjMWRE6xXhYYlfVYwgo4XUerOCy1snrADwmHlxNu52dgOCaFAxGsqw9PqLM1J9SJCiE/tNcKBKMzQ=
X-Received: by 2002:a2e:5450:: with SMTP id y16mr11493572ljd.241.1639591744371;
 Wed, 15 Dec 2021 10:09:04 -0800 (PST)
MIME-Version: 1.0
References: <20211129231830.1117781-1-namhyung@kernel.org> <YbePytGwg9Kb7hT1@kernel.org>
 <CAM9d7ciqzb4CArnzMf20x7XccwvmPSzCdk3w7Hhu=qg9TuD4vw@mail.gmail.com>
 <YboKAvgX7SIiUcoN@kernel.org> <YboNUk+ThCpEf8mQ@kernel.org>
In-Reply-To: <YboNUk+ThCpEf8mQ@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 15 Dec 2021 10:08:53 -0800
Message-ID: <CAM9d7cgKUHiJJXG5+OnzGv=5abS==ugxcnfrwgGxf35vyRb+Bw@mail.gmail.com>
Subject: Re: [RFC/PATCHSET 0/5] perf ftrace: Implement function latency
 histogram (v1)
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Song Liu <songliubraving@fb.com>,
        Changbin Du <changbin.du@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Wed, Dec 15, 2021 at 8:08 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Dec 15, 2021 at 12:30:10PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Mon, Dec 13, 2021 at 11:40:16AM -0800, Namhyung Kim escreveu:
> > > On Mon, Dec 13, 2021 at 10:24 AM Arnaldo Carvalho de Melo
> > > <acme@kernel.org> wrote:
> > > >
> > > > Em Mon, Nov 29, 2021 at 03:18:25PM -0800, Namhyung Kim escreveu:
> > > > > Hello,
> > > > >
> > > > > I've implemented 'latency' subcommand in the perf ftrace command to
> > > > > show a histogram of function latency.
> > > >
> > > > This still applies cleanly, I'll test it later.
> > >
> > > Thank you Arnaldo!  While I have some small modifications
> > > but the functionality should be the same.  Please let me know
> > > if you have any suggestions.
> >
> > So, it is failing here with:
>
> So that 'fd' variable and the cpumap.h problems goes away when the last
> patch is applied, but for bisection its better to apply the patch below
> to 4/5.

Sure, I will move them.  Thanks for pointing that out.

>
> I tested it all, cool stuff, will you resubmit soon?

Yep!

>
> I pushed it to the tmp.perf/ftrace_bpf branch on my repo at:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git
>
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=tmp.perf/ftrace_bpf
>
> With committer testing notes.

Thanks for the test!
Namhyung


>
> > Fixed with:
> >
> >
> > diff --git a/tools/perf/util/bpf_ftrace.c b/tools/perf/util/bpf_ftrace.c
> > index 1975a6fe73c9fa8b..f5b49fc056ab8b95 100644
> > --- a/tools/perf/util/bpf_ftrace.c
> > +++ b/tools/perf/util/bpf_ftrace.c
> > @@ -5,6 +5,7 @@
> >
> >  #include <linux/err.h>
> >
> > +#include "util/cpumap.h"
> >  #include "util/ftrace.h"
> >  #include "util/debug.h"
> >  #include "util/bpf_counter.h"
> > @@ -15,7 +16,7 @@ static struct func_latency_bpf *skel;
> >
> >  int perf_ftrace__latency_prepare_bpf(struct perf_ftrace *ftrace)
> >  {
> > -     int fd, err;
> > +     int err;
> >       struct filter_entry *func;
> >       struct bpf_link *begin_link, *end_link;
> >
>
> --
>
> - Arnaldo
