Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B374C4653D3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 18:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351734AbhLARZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 12:25:28 -0500
Received: from mail-lf1-f50.google.com ([209.85.167.50]:36594 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241289AbhLARZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 12:25:26 -0500
Received: by mail-lf1-f50.google.com with SMTP id k37so64793598lfv.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 09:22:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ynAEeldrfhTXiWbzscmIfln0qdzp3kySOz2rANgS7jk=;
        b=mgsahdZEFXVUadj1tKuPmCLjGXWGZfvn+tEZ8SlvKPir/Z0dmtdwQKt4KWiIkcQWgt
         ciL+tV+3cdDj+3cMezMXEnNhK0jZ7Wzxv8lxNcerzl+kxfbmPZ5cJ9BwbtoxkF9atEJt
         QB1df+4qbqfZUu7tTOKv1+cLopS9EnW47oDrxi7l3whqzQr64f/yWbQ5z6qVo47BCSWr
         qV/uy2692aOmAe1AvPt4Arj4shf9PD3KcO59sl8nBBXLUqhft6MMQN/RHwEX7QDTbaQa
         /+oImHgRHDISVgmJmhRHaAaZ1ElO+hgRv/5+vUTrdPfcd15X3xHW2KeeWhRqjx82BSxB
         YvdA==
X-Gm-Message-State: AOAM533zSZefRhK8l3yyoJm6Q8KY/XuOQNNWK1p3jAc9/VA5l+W8pN3B
        HVCyDR2gIJc9Xgrj4VTJsTq5lSQOKhR00iEhmAk=
X-Google-Smtp-Source: ABdhPJyICI3z3GHmCaM8WmHTe+4tI8x0MXeBwNpdiUS0RPJQgpprUH69CP3uhsKhwQRUlzrBpEaaBV8M0Bc5k9AQ2Ko=
X-Received: by 2002:a19:4f42:: with SMTP id a2mr6995199lfk.47.1638379323791;
 Wed, 01 Dec 2021 09:22:03 -0800 (PST)
MIME-Version: 1.0
References: <20211129231830.1117781-1-namhyung@kernel.org> <YaY3JqOQ2XE22VId@kernel.org>
 <CAM9d7cjXncRRsH1Zf_yVrLeaYiHXLFM29sx0MYPAZ8HAsZaggw@mail.gmail.com>
 <CABPqkBQgr3ck_jnFbdLOKgpzrz4RhE3svTvkiOLY9KgvjQjU9w@mail.gmail.com> <YadjkVG14zgymjrh@kernel.org>
In-Reply-To: <YadjkVG14zgymjrh@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 1 Dec 2021 09:21:52 -0800
Message-ID: <CAM9d7cjU3JG8AwxXYSwVmWVE17wYr5QXR6TA1qUVjLB1U1jZ1g@mail.gmail.com>
Subject: Re: [RFC/PATCHSET 0/5] perf ftrace: Implement function latency
 histogram (v1)
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Stephane Eranian <eranian@google.com>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>,
        Changbin Du <changbin.du@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 1, 2021 at 3:59 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Tue, Nov 30, 2021 at 04:36:49PM -0800, Stephane Eranian escreveu:
> > On Tue, Nov 30, 2021 at 2:58 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > On Tue, Nov 30, 2021 at 6:37 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> > > > Em Mon, Nov 29, 2021 at 03:18:25PM -0800, Namhyung Kim escreveu:
> > > > > I've implemented 'latency' subcommand in the perf ftrace command to
> > > > > show a histogram of function latency.
>
> > > > > To handle new subcommands, the existing functionality is moved to
> > > > > 'trace' subcommand while preserving backward compatibility of not
> > > > > having a subcommand at all (defaults to 'trace').
>
> > > > > The latency subcommand accepts a target (kernel, for now) function
> > > > > with -T option and shows a histogram like below:
>
> > > > Humm, wouldn't be interesting to shorten this by having a new 'perf
> > > > flat' (function latency) tool, on the same level as 'perf ftrace' and
> > > > leave 'perf ftrace' to just being a convenient perf interface to what
> > > > ftrace provides?
>
> > > That would be fine.  I also think 'perf ftrace latency' is
> > > bit too long.  But if we would add a new feature
> > > like argdist (in BCC) later, I thought it'd be nice being
> > > a subcommand in the perf ftrace together.
>
> > > But it's up to you.  I'll make a change if you prefer
> > > 'flat' (or how about 'fnlat' instead?).
>
> fnlat would be ok, flat was just funny to avoid suggesting it :-)

:)

>
> > I am not too fond of the flat option because as we had more bpf tools
> > like function latency, then we keep extending the list of commands
> > each with a small span which is different
> > from what we have right now.
>
> I think we should focus on the tool end result, not on how it is
> implemented, i.e. in this specific "function latency" tool ftrace is
> used with BPF, but we could perhaps have used some other mechanism.

Agreed, but I think function latency belongs to function tracing
conceptually.  So I added it as a subcommand in perf ftrace
not just because of the implementation.

>
> I think all these tools should have as much as possible a common set of
> options, like the targets (cpu, cgroup, pid, tid, etc) so that one can
> go from different views for those targets by just changing the name of
> the tool.

Currently, perf ftrace shares the target options with both subcommands.
Please see common_options in cmd_ftrace().

Thanks,
Namhyung


>
> We have things like:
>
> $ perf sched
>
>  Usage: perf sched [<options>] {record|latency|map|replay|script|timehist}
>
>     -D, --dump-raw-trace  dump raw trace in ASCII
>     -f, --force           don't complain, do it
>     -i, --input <file>    input file name
>     -v, --verbose         be more verbose (show symbol address, etc)
>
> With different 3rd level subcommads, but in the 'perf sched' case is the
> component being observed, not the mechanism being used to obtain/present
> the observation data.
>
> - Arnaldo
