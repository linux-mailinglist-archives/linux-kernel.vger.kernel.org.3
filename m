Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC6848A06E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 20:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241042AbiAJTtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 14:49:36 -0500
Received: from mail-lf1-f46.google.com ([209.85.167.46]:40801 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239916AbiAJTtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 14:49:35 -0500
Received: by mail-lf1-f46.google.com with SMTP id s30so20480415lfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 11:49:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cBC7ur9q8uCn3+fYNxbDAjBWUMfYxRVgK+nrhQ/hAA0=;
        b=oLeYvtjjBv6ObUdVJcT0IrOhgHPZfoXtrAgWSao5kQKPfd2SAmInef8+BdKxh/qC91
         IBsCdN3v8LmJ0EOl2mv7zflhALRabZQdRcIYZreUBpnjMpW7l66VPD8aOqd3JmbdArIN
         O1J8PpZKlY1uLds174E6kn8Li8+V1paEM6beePuTGTsCjHP1kJFgnCZoEAtAc5rwhu/h
         0w9fdSWXEQAWIaXCCzPOl9Z8BiKxncCPNeYJQlxbNg+E9TtDrC0xrsOdtK7GM/yyICFn
         xhW+QHzH8vHbiyJzHIiDtV2qIVL9eIh59LI9XGsYrMaZ5Sagv10EHo6vcbV9bXhExuy5
         5Z0g==
X-Gm-Message-State: AOAM531NTSFothk09KgTALRPc4Sg22WA4NEy5l7fvoSCS+2yY74WwbFc
        3O+0wPV438QoXjXCLGHKvsFweAikKndiumpvNzQ=
X-Google-Smtp-Source: ABdhPJxrDpHfZFk8hTVowuDtiIKYHMVkE7JTEc9K7AVKPZhX0SLk+inUNhxFf/N3uoIRWvsdOKesIEOkjbpjKig+pX8=
X-Received: by 2002:a05:651c:a09:: with SMTP id k9mr689016ljq.180.1641844173631;
 Mon, 10 Jan 2022 11:49:33 -0800 (PST)
MIME-Version: 1.0
References: <20211213232224.2023465-1-namhyung@kernel.org> <CANpmjNPuDUwrLH9GKEs6BgeRiL6uZ_tqa5NX_6J83E121+CUqg@mail.gmail.com>
In-Reply-To: <CANpmjNPuDUwrLH9GKEs6BgeRiL6uZ_tqa5NX_6J83E121+CUqg@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 10 Jan 2022 11:49:22 -0800
Message-ID: <CAM9d7ci-xAWYJEspm8VXRy257vG9r7HDVuQ0Uoej49OG4f5qKQ@mail.gmail.com>
Subject: Re: [PATCH v3] perf/core: Fix cgroup event list management
To:     Marco Elver <elver@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
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

Hi Marco,

On Mon, Jan 10, 2022 at 12:58 AM Marco Elver <elver@google.com> wrote:
>
> On Tue, 14 Dec 2021 at 00:22, Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > The active cgroup events are managed in the per-cpu cgrp_cpuctx_list.
> > This list is only accessed from current cpu and not protected by any
> > locks.  But from the commit ef54c1a476ae ("perf: Rework
> > perf_event_exit_event()"), it's possible to access (actually modify)
> > the list from another cpu.
> >
> > In the perf_remove_from_context(), it can remove an event from the
> > context without an IPI when the context is not active.  This is not
> > safe with cgroup events which can have some active events in the
> > context even if ctx->is_active is 0 at the moment.  The target cpu
> > might be in the middle of list iteration at the same time.
> >
> > If the event is enabled when it's about to be closed, it might call
> > perf_cgroup_event_disable() and list_del() with the cgrp_cpuctx_list
> > on a different cpu.
> >
> > This resulted in a crash due to an invalid list pointer access during
> > the cgroup list traversal on the cpu which the event belongs to.
> >
> > Let's fallback to IPI to access the cgrp_cpuctx_list from that cpu.
> > Similarly, perf_install_in_context() should use IPI for the cgroup
> > events too.
> >
> > Cc: Marco Elver <elver@google.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>
> The final version needs:
>
> Fixes: ef54c1a476ae ("perf: Rework perf_event_exit_event()")
>
> so stable kernels will see it, unless this has already been picked up
> in which case we need to email stable.

Right, it should go to the stable tree.

Peter, do you want me to resend a new version?

Thanks,
Namhyung
