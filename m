Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44F3559EB7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 18:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbiFXQkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 12:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiFXQkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 12:40:17 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCC420BF6;
        Fri, 24 Jun 2022 09:40:16 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id p8so4237466oip.8;
        Fri, 24 Jun 2022 09:40:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uJ6qtHcqOz6w1LeyYAylMDSTeSEr5a9i/a+y4bB03pY=;
        b=y9CSZ4Mshp7oP5LTIawjFZoLvQO39FA/Con4siN4CR2Do4BnPDE3aTFSs0OUYdqePs
         nqvJmBCW/nCYUywxBUQJRykF57BLd4hao9OKJfIJhzl4uba8XmhuYFGrE+/he1YOlTCn
         sC2bkrACHCLO4qOVviDFv0PR5eF7s1JrJ0sIgn/KDorXjdMRT/JENw26AG2ZX4wdpxlL
         OaLPEzHG25ZaMN7evtXVRp/UVmzrJ5QqqkXheVejexdP6R054swIHO2bSJZdE/lLIeor
         e6GkAPkkxohkthzY8x3fL+b8ZndkVfYClflze91ZlBHhybGL/lY+8sMJQr5cD+syN72K
         fCdg==
X-Gm-Message-State: AJIora9vhc1jaVuI9GWKN5Sdsm72BiO3T76tmgHE9Q064jBVLWqNQuIU
        +DKKEp+y2Naycf+Prubyf8egHVjlLpuKvK+T1b4=
X-Google-Smtp-Source: AGRyM1v932IX/+v8BNb8d1qQRB7XL1BzzRvueyhyfQbrsI0opkZOQG+QgjlV7MxQW8BxMr5mMrMuYfbB7VI7eQyITCQ=
X-Received: by 2002:a05:6808:1385:b0:32f:729e:4869 with SMTP id
 c5-20020a056808138500b0032f729e4869mr2501390oiw.5.1656088816047; Fri, 24 Jun
 2022 09:40:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220615163222.1275500-1-namhyung@kernel.org>
In-Reply-To: <20220615163222.1275500-1-namhyung@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 24 Jun 2022 09:40:05 -0700
Message-ID: <CAM9d7cjD=at=AtKmvMLogjN6mieWVR2kk-HigxO01cvPPRGFBg@mail.gmail.com>
Subject: Re: [PATCHSET 0/7] perf lock: New lock contention tracepoints support (v4)
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping!  Any comments?


On Wed, Jun 15, 2022 at 9:32 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hello,
>
> Kernel v5.19 will have a new set of tracepoints to track lock
> contentions for various lock types.  Unlike tracepoints in LOCKDEP and
> LOCK_STAT, it's hit only for contended locks and lock names are not
> available.  So it needs to collect stack traces and display the caller
> function instead.
>
> Changes in v4)
>  * add Acked-by from Ian
>  * more comments on trace_lock_handler
>  * don't create stats in the contention_end handler
>
> Changes in v3)
>  * fix build error
>  * support data from different kernels/machines
>  * skip bad stat unless there's actual bad ones
>
> Changes in v2)
>  * add Acked-by from Ian
>  * print time with a unit for compact output
>  * add some comments  (Ian)
>  * remove already applied patch
>
> This patchset merely adds support for the new tracepoints to the
> existing perf lock commands.  So there's no change to the user.  Later
> I'll add new a sub-command dedicated to the tracepoints to make use of
> the additional information.
>
> Example output:
>
>   $ sudo perf lock record -a sleep 3
>
>   $ perf lock report -F acquired,contended,avg_wait,wait_total
>
>                   Name   acquired  contended     avg wait    total wait
>
>    update_blocked_a...         40         40      3.61 us     144.45 us
>    kernfs_fop_open+...          5          5      3.64 us      18.18 us
>     _nohz_idle_balance          3          3      2.65 us       7.95 us
>    tick_do_update_j...          1          1      6.04 us       6.04 us
>     ep_scan_ready_list          1          1      3.93 us       3.93 us
>   ...
>
> You can find the code in the 'perf/lock-contention-v4' branch at
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
>
> Thanks,
> Namhyung
>
>
> Namhyung Kim (7):
>   perf lock: Print wait times with unit
>   perf lock: Allow to use different kernel symbols
>   perf lock: Skip print_bad_events() if nothing bad
>   perf lock: Add lock contention tracepoints record support
>   perf lock: Handle lock contention tracepoints
>   perf record: Allow to specify max stack depth of fp callchain
>   perf lock: Look up callchain for the contended locks
>
>  tools/perf/Documentation/perf-lock.txt   |   7 +
>  tools/perf/Documentation/perf-record.txt |   5 +
>  tools/perf/builtin-lock.c                | 426 ++++++++++++++++++++++-
>  tools/perf/util/callchain.c              |  18 +-
>  4 files changed, 434 insertions(+), 22 deletions(-)
>
>
> base-commit: 9886142c7a2226439c1e3f7d9b69f9c7094c3ef6
> --
> 2.36.1.476.g0c4daa206d-goog
>
