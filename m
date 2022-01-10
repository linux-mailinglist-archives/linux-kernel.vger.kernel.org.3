Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A115489497
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 10:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242180AbiAJJAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 04:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242456AbiAJI6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:58:37 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51262C034007
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 00:58:36 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id x6so41753848lfa.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 00:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pqk1BZUjJr6GePpivx5SbVQCLLHcBuWWSQmMASNOalQ=;
        b=Eq1wu1eHl9pTqvJMugMq4SHkTObBT2pGw5mUG/TlHHMm3ck9BqsUt09EiHVUyslBEl
         mIF+LJHvVtyflwVq4bhTCb5Zcav8QBd+aufRRtbajQ/T4DH0llJsJIqEljmSp6qcaKRH
         a0Dzs1tobZj3u27/Kqzccu9IU882D6tniJovqo98P304t8sxEbZ5wKbSm4m0Sm8c2Xs2
         wIT67Z+fetKd/E+I4dlKcLKrid8FcC/pn1hFKksTRskgj7XfzalAZcrM0C1JcWpNcKef
         rL77R5LWqU1nhz1/bs1O4iscPH/mO6ez6TBd1mw2bdAuA2SZNtbWaDsklG5ejseZoctB
         aIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pqk1BZUjJr6GePpivx5SbVQCLLHcBuWWSQmMASNOalQ=;
        b=19bvQnaTBVCrqjP1e6mr3ZVeg7+Z5LcIlSGqPzMp7Cb4f4qBOEd3OHBNzej5M7dwhp
         54bUhYBNWhXXXho/fLGSmNJM8iGrTM83mlvX0skANxQzCWIgBvz5+f+UJKluinR6Sv0u
         EW4l5L5LI4y2Sce0fOD83tV1jE4CwKVfq4SgeQa8k77mBJshtdB4e53tfKRUvkwfKDgc
         m1jbOdAxPQKt0DdQxaJRdSa5gpqktyr/Siy9bmswRZWHj+dWCbuw2+/7SMKN973UJf4V
         GGFjav7JZ00QX7SWFFnPywWL5kFsWG29tQalKPVIPFqTNF7K0Q/X8qv9gErcv/hv+gL7
         g5fw==
X-Gm-Message-State: AOAM530iN49Cu5n3xzfFXDDxcE2uIkUl31D2rNE/A9HW/jK6UHr9my+g
        s7HFzBtgRNu9my+G1QMfDA+7F0PAMC3eYiW+h8upufzuIitumA==
X-Google-Smtp-Source: ABdhPJw/AKGwgUGYBuAwj2uFM9qju4HAfWCZS2wef6UxtsGrKV1KXsER1HnSvPOzSR67xwziNAnCDXx4q+wBywOEfMM=
X-Received: by 2002:a05:651c:1508:: with SMTP id e8mr55769779ljf.313.1641805114163;
 Mon, 10 Jan 2022 00:58:34 -0800 (PST)
MIME-Version: 1.0
References: <20211213232224.2023465-1-namhyung@kernel.org>
In-Reply-To: <20211213232224.2023465-1-namhyung@kernel.org>
From:   Marco Elver <elver@google.com>
Date:   Mon, 10 Jan 2022 09:58:23 +0100
Message-ID: <CANpmjNPuDUwrLH9GKEs6BgeRiL6uZ_tqa5NX_6J83E121+CUqg@mail.gmail.com>
Subject: Re: [PATCH v3] perf/core: Fix cgroup event list management
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Dec 2021 at 00:22, Namhyung Kim <namhyung@kernel.org> wrote:
>
> The active cgroup events are managed in the per-cpu cgrp_cpuctx_list.
> This list is only accessed from current cpu and not protected by any
> locks.  But from the commit ef54c1a476ae ("perf: Rework
> perf_event_exit_event()"), it's possible to access (actually modify)
> the list from another cpu.
>
> In the perf_remove_from_context(), it can remove an event from the
> context without an IPI when the context is not active.  This is not
> safe with cgroup events which can have some active events in the
> context even if ctx->is_active is 0 at the moment.  The target cpu
> might be in the middle of list iteration at the same time.
>
> If the event is enabled when it's about to be closed, it might call
> perf_cgroup_event_disable() and list_del() with the cgrp_cpuctx_list
> on a different cpu.
>
> This resulted in a crash due to an invalid list pointer access during
> the cgroup list traversal on the cpu which the event belongs to.
>
> Let's fallback to IPI to access the cgrp_cpuctx_list from that cpu.
> Similarly, perf_install_in_context() should use IPI for the cgroup
> events too.
>
> Cc: Marco Elver <elver@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

The final version needs:

Fixes: ef54c1a476ae ("perf: Rework perf_event_exit_event()")

so stable kernels will see it, unless this has already been picked up
in which case we need to email stable.

Thanks,
-- Marco
