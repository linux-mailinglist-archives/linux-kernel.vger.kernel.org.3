Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E949F480DF7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 00:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237772AbhL1XsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 18:48:24 -0500
Received: from mail-lf1-f45.google.com ([209.85.167.45]:38568 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbhL1XsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 18:48:22 -0500
Received: by mail-lf1-f45.google.com with SMTP id x21so44399542lfa.5;
        Tue, 28 Dec 2021 15:48:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=43RunENc9BGgUTy24GSL/O+U7jxvlHOGKJ/isDXkZcY=;
        b=bSsctSbok+AR/lieV93EniDu3PelUAZg4u1qgAkeW5XGc830HCh2aHvZOYA8maWIhu
         B6aJX/uzhOeIu+lSRIpBMGn7kXify0n0Yq8sgPhL3jJ9mvN0ykhYKSuUA5nrVsZfwEIs
         /NS1HhdU0BJTpm+4KG4yz8Es4rp0+DAy/2YDxuKizbZ6cIrAV45vbS8gm4lowC6+UdbX
         y/EMMFz+b9gK3tEolI0DfIcoP+YN8F0lIJqcc7+idNIroQkOR17M9hl09+3qvudUxcO5
         vL/HzFt/KH9P5rjOjmEtELdUxNnxdQec46mcN+tAB9y+0x3XHB7sXK5nAfAi2JJYkFiU
         JhMA==
X-Gm-Message-State: AOAM5320kuqJmEen6SZb61xQrZIkw1FWxoWLfmF2AkOBaVWt5rSXheEP
        6KooO9EcKgBQ964T7Lo5kr8u52EwNxtjKtTmczI=
X-Google-Smtp-Source: ABdhPJwoibq9jpmkzRcCRwexFVs7p98pjuahrASVfI9ZwKiJdXNKZHZCJTbxHkq4sU3L57ahFbfSr/Ltc8ZyxsZJAUg=
X-Received: by 2002:a05:6512:3d21:: with SMTP id d33mr21678706lfv.481.1640735301239;
 Tue, 28 Dec 2021 15:48:21 -0800 (PST)
MIME-Version: 1.0
References: <20211223074541.3318938-1-irogers@google.com> <20211223074541.3318938-21-irogers@google.com>
In-Reply-To: <20211223074541.3318938-21-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 28 Dec 2021 15:48:10 -0800
Message-ID: <CAM9d7chcAXiqWTSUxniPrdYM5hdbwPV1oyxUVvg6B-JfL89vNw@mail.gmail.com>
Subject: Re: [PATCH v2 20/48] perf cpumap: Move 'has' function to libperf
To:     Ian Rogers <irogers@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
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
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Vineet Singh <vineet.singh@intel.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On Wed, Dec 22, 2021 at 11:47 PM Ian Rogers <irogers@google.com> wrote:
>
> Make the cpu map argument const for consistency with the rest of the
> API. Modify cpu_map__idx accordingly.
>
> Reviewed-by: James Clark <james.clark@arm.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/perf/cpumap.c                  |  7 ++++++-
>  tools/lib/perf/include/internal/cpumap.h |  2 +-
>  tools/lib/perf/include/perf/cpumap.h     |  1 +

You need to update tools/lib/perf/libperf.map to have
the new API.

Thanks,
Namhyung


>  tools/perf/arch/arm/util/cs-etm.c        | 16 ++++++++--------
>  tools/perf/builtin-sched.c               |  6 +++---
>  tools/perf/tests/topology.c              |  2 +-
>  tools/perf/util/cpumap.c                 |  5 -----
>  tools/perf/util/cpumap.h                 |  2 --
>  tools/perf/util/cputopo.c                |  2 +-
>  9 files changed, 21 insertions(+), 22 deletions(-)
>
