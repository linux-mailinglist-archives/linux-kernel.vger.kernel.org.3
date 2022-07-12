Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD0D571B89
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 15:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbiGLNlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 09:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbiGLNk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 09:40:56 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC73B8530
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:40:34 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-31c86fe1dddso81423847b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ALyPmALyKUZN850RRfbsMebRjTXHId7O0aEtI7++nZc=;
        b=LSt+DLU33Q6liALS8BuSSMkfOKSlRWDFuTo7po1O26Fv7bk7ore1ydtL7Hkh54hx5B
         9uSRjCaDwCvwdfWSzS7lnufwTmWr2b2BeYWR5YFP9ZU8F9VUUXmk6Zu5giNcEj2YbgpC
         uI4p1/JHiKYlEhx0fK1shW+TiQcG27FxZBVsXr+bZEYrVso0bpBwSBWJ2SnXgjmK3o2a
         TljCQ3HgMAtH+5k9+nmdR7HTEIpmR3g8H3YU3v/0m4e+3pVXNggO7+TOdghExzxY46ET
         DIp6u0LHdi2CFsZzjm9ZOB6D+HRRffEUqutrzlU2tzRGZr0L4jryw4F7HNyo/VTj61UD
         CAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ALyPmALyKUZN850RRfbsMebRjTXHId7O0aEtI7++nZc=;
        b=ad/s7U1yE3IjasSEsjIVEqwEFNmwRv86FPk7xCxMogqdUI9RQ3JPy4xHc9eqiRn8Cm
         TELMT+ZuXI/sLDvx0x2Jte509GGZ0mhQ3y7iCp65+hQUMpxnhHQdBtanKqvhdhsk9ae8
         y8HNjpLQOyhfaCzt3VKE6kbVA5mc/KqLjjPqA7wf8m4vlqdmT8z6ofrTU9GlzTpKEgvl
         QSvTrqrWo8CxpnMrCXDhuwIR2InH/N5fIKJYzcuQSehqO57GF4dE5e37USjlwh7IOLCd
         4e6gWkw+rAOD5oggVCwbaHDzK5ieLFcJS1PLaBEHCM97HDLfLBahF11kSpfZRVib9Zik
         xmHQ==
X-Gm-Message-State: AJIora8M6iMLLhcJ/uFL4KLiAx+e5XRRrSNHlMMvco01jt1uL+shFMlS
        4egSL3i+lhlTPnMpgHVETK4l609Kvsu3822khHJAEQ==
X-Google-Smtp-Source: AGRyM1vOJbA/kJ593A3ED5ZJMoh4prb03n/Kz2Y5PlZioljval/AgDFA11ABBXVIE5GqjlsCSBB2nghmV/bKBZoaO6Q=
X-Received: by 2002:a81:98d:0:b0:31c:921c:9783 with SMTP id
 135-20020a81098d000000b0031c921c9783mr25237173ywj.316.1657633233606; Tue, 12
 Jul 2022 06:40:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220704150514.48816-1-elver@google.com>
In-Reply-To: <20220704150514.48816-1-elver@google.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 12 Jul 2022 15:39:57 +0200
Message-ID: <CANpmjNP0hPuhXmZmkX1ytCDh56LOAmxJjf7RyfxOvoaem=2d8Q@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] perf/hw_breakpoint: Optimize for thousands of tasks
To:     elver@google.com, Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Jul 2022 at 17:05, Marco Elver <elver@google.com> wrote:
>
> The hw_breakpoint subsystem's code has seen little change in over 10
> years. In that time, systems with >100s of CPUs have become common,
> along with improvements to the perf subsystem: using breakpoints on
> thousands of concurrent tasks should be a supported usecase.
[...]
> Marco Elver (14):
>   perf/hw_breakpoint: Add KUnit test for constraints accounting
>   perf/hw_breakpoint: Provide hw_breakpoint_is_used() and use in test
>   perf/hw_breakpoint: Clean up headers
>   perf/hw_breakpoint: Optimize list of per-task breakpoints
>   perf/hw_breakpoint: Mark data __ro_after_init
>   perf/hw_breakpoint: Optimize constant number of breakpoint slots
>   perf/hw_breakpoint: Make hw_breakpoint_weight() inlinable
>   perf/hw_breakpoint: Remove useless code related to flexible
>     breakpoints
>   powerpc/hw_breakpoint: Avoid relying on caller synchronization
>   locking/percpu-rwsem: Add percpu_is_write_locked() and
>     percpu_is_read_locked()
>   perf/hw_breakpoint: Reduce contention with large number of tasks
>   perf/hw_breakpoint: Introduce bp_slots_histogram
>   perf/hw_breakpoint: Optimize max_bp_pinned_slots() for CPU-independent
>     task targets
>   perf/hw_breakpoint: Optimize toggle_bp_slot() for CPU-independent task
>     targets
[...]

This is ready from our side, and given the silence, assume it's ready
to pick up and/or have a maintainer take a look. Since this is mostly
kernel/events, would -tip/perf/core be appropriate?

Thanks,
-- Marco
