Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08DCE48B607
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 19:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345887AbiAKSqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 13:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346266AbiAKSqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 13:46:09 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61A4C061748
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 10:46:08 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id g14so21455436ybs.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 10:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sM8wuZyLOamyQ+NaAWxgxygW9jRKD3OsUdPukmMlL1U=;
        b=OpLYe3hGobUDsobWW/zx65mRZbZ+bnV73uNhO5xjHnaneVs0YX2ZC/o290orDokc0u
         WNiWHsAC9xKw+VU2KOnbLTcKHOqsdO5P1aE1IXFuxwY4ZDxpzzL/jn+Lw37Pt6HUlJdW
         LTMdizaDElo92GlzxfbX8joJBw9EPa9Fmw2r0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sM8wuZyLOamyQ+NaAWxgxygW9jRKD3OsUdPukmMlL1U=;
        b=dLQc4s0rJXzE1jGGuF1vpxajhM59wNFcXNA9idJ3iYYpd+dtwLieW3LlI/r9YCK+RS
         8WFuNeYozSW3qGqRAV3jqbvwO0Vo7buMwSPeGC9Q7BHyi9UvsvomjKS0pzyG3d5UemLF
         lw+Py+J9FezDUlhZr8t2FFGcBtnMrUSX05Gpm/B1qkd5kJ+EP2Wy3dJyEQ2jbLDLHrw0
         rNY6qeoZM6qLdtxR2rJnu1B/122m7xZbB6XbJP9MnOYWCVpcXGQtkm9/IL/YPzxirkmE
         eRBBDjpWvr0a8540bg2tz7k3Hr/ILPKfwbIX8J+RoDibHoncYnjP5QT9xMff6+ADwyaQ
         i7ww==
X-Gm-Message-State: AOAM532cZ7jG9xfHKWZ2FrGsDxjsKqJAp9taTOTUft1pWuvIl990DBPt
        tP6yqlSbMXFMrB80nmb1g8jk0+5cLUc4xz0XVUWU
X-Google-Smtp-Source: ABdhPJx0Y8SQdmOLymALspxxE440M5sdcmWqHQIm5ZCLL7vr2lFtY9Dk3p4WLCtnG5DHhsKNkV8pIQcewm2Nq+Si/qc=
X-Received: by 2002:a25:d14c:: with SMTP id i73mr832991ybg.713.1641926766802;
 Tue, 11 Jan 2022 10:46:06 -0800 (PST)
MIME-Version: 1.0
References: <20220111142054.18733-1-nikita.shubin@maquefel.me> <B6E7919C-9414-4CC1-BB86-7D358085CECD@jrtc27.com>
In-Reply-To: <B6E7919C-9414-4CC1-BB86-7D358085CECD@jrtc27.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 11 Jan 2022 10:45:56 -0800
Message-ID: <CAOnJCUJ6JNY9eWrPhGi3XK3omDwXhM37oimsZoqxbOP_f7vUog@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] perf tools: Add 'm' event modifier for counting
To:     Jessica Clarke <jrtc27@jrtc27.com>
Cc:     Nikita Shubin <nikita.shubin@maquefel.me>,
        Atish Patra <atishp@rivosinc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux <linux@yadro.com>, Nikita Shubin <n.shubin@yadro.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Song Liu <song@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        linux-perf-users@vger.kernel.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 6:29 AM Jessica Clarke <jrtc27@jrtc27.com> wrote:
>
> On 11 Jan 2022, at 14:20, Nikita Shubin <nikita.shubin@maquefel.me> wrote:
> >
> > From: Nikita Shubin <n.shubin@yadro.com>
> >
> > This patch is a proposal to add Machine Mode modifier that is currently
> > available only for RISC-V for perf tool.
> >
> > We don't currently have a level that is lower than kernel, so i don't
> > see we can reuse something existing for this purpose.
> >

Thanks for a quick turnaround with a working patch!!

However, the use case can be applied to other arch as well. It would
be good to classify this
as excluding "firmware" events instead of machine mode which is a
RISC-V terminology.
Ofcourse, the current documentation should indicate that this option
is only useful
for RISC-V right now.

I would like to understand if this idea is appealing to the broader community.

> > The exclude_machine bit seems harmless to as no one will proccess it apart
> > of riscv.
>
> Armv8 has equivalent bits in PMEVTYPER<n>_EL0 and PMCCFILTR_EL0 for
> EL-based filtering, which includes filtering EL3.
>
> Jess
>
> > Patch depends on Atish Patra PMU series:
> > https://lwn.net/Articles/879905/
> > + some modifications to pass execlude event to SBI PMU extension
> >
> > Tested with qemu.
> >
> > Nikita Shubin (1):
> >  perf tools: Add 'm' event modifier for counting machine
> >
> > include/uapi/linux/perf_event.h        |  3 ++-
> > tools/include/uapi/linux/perf_event.h  |  3 ++-
> > tools/perf/Documentation/perf-list.txt |  1 +
> > tools/perf/tests/parse-events.c        | 18 ++++++++++++++++++
> > tools/perf/util/evsel.c                |  4 +++-
> > tools/perf/util/parse-events.c         | 18 +++++++++++++-----
> > tools/perf/util/parse-events.l         |  2 +-
> > 7 files changed, 40 insertions(+), 9 deletions(-)
> >
> > --
> > 2.31.1
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Regards,
Atish
