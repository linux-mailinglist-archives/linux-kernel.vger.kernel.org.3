Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7015E488FDD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 06:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238832AbiAJFpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 00:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbiAJFpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 00:45:33 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6756EC06173F
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 21:45:33 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id c4so10381464iln.7
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jan 2022 21:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I2Rp9THzxzMq/ttRbcNPqtEt7HusqSb4QCZKzlGP+9A=;
        b=juiqSHTVJOaVRhq5m+ZrXvTTrRVYb0CHU0nTSgQ5EbBBT6MbUr4A4GuiOClsTB/gdQ
         t34ORL1fAqvpdOtpu9hdVHt5yRe8CL0QMc/SFFsE2WrOtSRobmC2J0uS+w/+EJP4ySoU
         D7q84Pbg8+Ehz6bPkf5vsRmN6j9mys6WAR8oDkxPkN1u6Q15e0hWQsnld0wus+p/hqlo
         Jf5jSTlEyS6kVAY37Pa9zi8xDocpNnjuR+F1IVvqvhVE2pwFA8Xo3vXQvv2vXMNqEmuv
         K0b+L5hwH7MUOJre3i47A81eMI6K61WfeclIM8FYc824gFN3ez3zrBVu8ZIr4YBAySTw
         iOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I2Rp9THzxzMq/ttRbcNPqtEt7HusqSb4QCZKzlGP+9A=;
        b=iuc5iXjpF7nKpbbTTcaquilHgdr3ovRc24lW7ugl9RR+ZnaQv9H+2P8IWLOrLLFesa
         NIdzOHdF4aDERYusu+XF8BrC26lBgQD63mss3xMQYBRjb7Qi6WKRW9H/l1kc4cZAgrPF
         wjc240Tmcdvve8Nu7CiK4JiCUFU3EmagDvWZvn4kPdFfaIZN464bT4E6RCJvsdBszQ9m
         alhNysqTVIOY9V+mo1IrHuHlJZGf39gpUnRsMHf1PzOY61uvncupgLRao0MO8wDGL9sG
         Wo8bnzbBynVc7/eLsGePQ3D736YOJuA4oL3jOBSJbgCm/LAyUbCDkPdGpQpHnzNNG5wd
         BnwQ==
X-Gm-Message-State: AOAM533j0OIb7ObSPJz6sjxh02f7KvofuMnfTnsoK0PAd/cfolHKrDbi
        xvfbO3wGLkhMKjU0fWXaG9cWYOrlGyAz+1r3w6n1Ww==
X-Google-Smtp-Source: ABdhPJxyWGUAtz2QGisVN7rf6M/TgAXD97oRuJ2SmHNnR7fpvWKGhupRiQN2k/CqPMiyRGdiVhxTK3dqHhAXr2Cyq74=
X-Received: by 2002:a92:da07:: with SMTP id z7mr5541162ilm.2.1641793532644;
 Sun, 09 Jan 2022 21:45:32 -0800 (PST)
MIME-Version: 1.0
References: <20220105061351.120843-1-irogers@google.com> <20220105061351.120843-49-irogers@google.com>
 <Ydspzl2aWpufl/yR@krava>
In-Reply-To: <Ydspzl2aWpufl/yR@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Sun, 9 Jan 2022 21:45:19 -0800
Message-ID: <CAP-5=fUQsd21cxFiXBi2pCh9rakMReiNWxbrKn+1CesCamrtdg@mail.gmail.com>
Subject: Re: [PATCH v4 48/48] perf cpumap: Give CPUs their own type.
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Singh <vineet.singh@intel.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, zhengjun.xing@intel.com,
        eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 9, 2022 at 10:30 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Jan 04, 2022 at 10:13:51PM -0800, Ian Rogers wrote:
> > A common problem is confusing CPU map indices with the CPU, by wrapping
> > the CPU with a struct then this is avoided. This approach is similar to
> > atomic_t.
> >
> > Suggested-by: John Garry <john.garry@huawei.com>
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> SNIP
>
> >  tools/perf/util/stat.h                        |   2 +-
> >  tools/perf/util/svghelper.c                   |   6 +-
> >  tools/perf/util/synthetic-events.c            |  12 +-
> >  tools/perf/util/synthetic-events.h            |   3 +-
> >  tools/perf/util/util.h                        |   5 +-
> >  59 files changed, 408 insertions(+), 347 deletions(-)
>
> that's massive ;-) did it find any mis-use of the index/value?

It did. The fixes precede this patch so that we can have the fixes
without the large rename.

> how about the same for threads?

Agreed, but the patch set was already big enough.

> > diff --git a/tools/lib/perf/include/internal/cpumap.h b/tools/lib/perf/include/internal/cpumap.h
> > index 71a31ed738c9..581f9ffb4237 100644
> > --- a/tools/lib/perf/include/internal/cpumap.h
> > +++ b/tools/lib/perf/include/internal/cpumap.h
> > @@ -4,6 +4,11 @@
> >
> >  #include <linux/refcount.h>
> >
> > +/** A wrapper around a CPU to avoid confusion with the perf_cpu_map's map's indices. */
> > +struct perf_cpu {
> > +     int cpu;
> > +};
>
> should we use 'int val' or 'int v' instead, so we don't have cpu.cpu ?

I can rename it if you have a preference.

Thanks,
Ian

> jirka
>
> SNIP
>
