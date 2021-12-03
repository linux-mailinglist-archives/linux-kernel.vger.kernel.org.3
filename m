Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96393467CFF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 19:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353511AbhLCSPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 13:15:12 -0500
Received: from mail-lj1-f174.google.com ([209.85.208.174]:38459 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234979AbhLCSPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 13:15:11 -0500
Received: by mail-lj1-f174.google.com with SMTP id p8so7796716ljo.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 10:11:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zchs0UygqKQ5o+ZgycyOo7m3hHuM8Weo+46IYiRf+yg=;
        b=4rfW4QlOT0uCy9ftArSEaDltqUFYPVU5R5pFszy8lWcd9zFZD45KhShLWhBtIaE8ds
         t2oOKokAGxzmMn2+7QafRUp4BJKG65sW5BkvhXJI6/3M+lhXFN3v5uLjkLu1d8AcU4NS
         QRQwZko4Qe0Z2vlsBcVGod740Eo2Y435EDWrPDHD2zqS0hrSyEK2+mywQ9jm9F/wn+TB
         jrXTj9dHJQC7vVN4wCbdWajo4O655VvZf1dtTmETQFQdVGOgS7ZxOF9AKyWlNQ2HUzyu
         dDBANCopGFotyioBtt0Cyn9w/pGJ05oqbQ+ZPRfWTGTzWRHiqfj6xnDoGJmHH6ZEjlE7
         MtOQ==
X-Gm-Message-State: AOAM530IyGuNXKFJFQNB4A7mbI7mQDVuftCgQe6aAlqLNF+iI8QCy2nc
        Y/S3+YaTQnlGn2vBaAJXq3K1lKCJYHh0rhHyehg=
X-Google-Smtp-Source: ABdhPJy/+qMjUH4F318C644V4YJBnMCyAKPaUD7BKFw3n0YxH9BeJ/JeGLQir6Goy8bwtyW7BZvd+1TCEyDgCdMleW8=
X-Received: by 2002:a2e:5450:: with SMTP id y16mr20221407ljd.241.1638555105658;
 Fri, 03 Dec 2021 10:11:45 -0800 (PST)
MIME-Version: 1.0
References: <20211129231830.1117781-1-namhyung@kernel.org> <YaY3JqOQ2XE22VId@kernel.org>
 <CAM9d7cjXncRRsH1Zf_yVrLeaYiHXLFM29sx0MYPAZ8HAsZaggw@mail.gmail.com>
 <CABPqkBQgr3ck_jnFbdLOKgpzrz4RhE3svTvkiOLY9KgvjQjU9w@mail.gmail.com>
 <YadjkVG14zgymjrh@kernel.org> <CAM9d7cjU3JG8AwxXYSwVmWVE17wYr5QXR6TA1qUVjLB1U1jZ1g@mail.gmail.com>
 <Yaoe7YWV0m4RYXnd@kernel.org>
In-Reply-To: <Yaoe7YWV0m4RYXnd@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 3 Dec 2021 10:11:34 -0800
Message-ID: <CAM9d7cgJXVofGqcbDbvL8feKHkJVxNNYiPUQ2zDGFzzbcFnk3w@mail.gmail.com>
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

On Fri, Dec 3, 2021 at 5:43 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> Em Wed, Dec 01, 2021 at 09:21:52AM -0800, Namhyung Kim escreveu:
> > On Wed, Dec 1, 2021 at 3:59 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > Em Tue, Nov 30, 2021 at 04:36:49PM -0800, Stephane Eranian escreveu:
> > > > I am not too fond of the flat option because as we had more bpf tools
> > > > like function latency, then we keep extending the list of commands
> > > > each with a small span which is different
> > > > from what we have right now.
>
> > > I think we should focus on the tool end result, not on how it is
> > > implemented, i.e. in this specific "function latency" tool ftrace is
> > > used with BPF, but we could perhaps have used some other mechanism.
>
> > Agreed, but I think function latency belongs to function tracing
> > conceptually.  So I added it as a subcommand in perf ftrace
> > not just because of the implementation.
>
> Fair enough, I think we can go as-is then, whoever finds this overly
> long can do:
>
> alias flat="perf ftrace latency"
>
> And go:
>
> flat -p `pidof firefox`
>
> etc.

Looks good!  Thanks.

>
> > > I think all these tools should have as much as possible a common set of
> > > options, like the targets (cpu, cgroup, pid, tid, etc) so that one can
> > > go from different views for those targets by just changing the name of
> > > the tool.
>
> > Currently, perf ftrace shares the target options with both subcommands.
> > Please see common_options in cmd_ftrace().
>
> Sure, but I was alluding to all perf tools, not just 'perf ftrace'
> subcommands, i.e. one can go from:
>
> perf ftrace trace --pid `pidof firefox`
>
> to:
>
> perf trace --pid `pidof firefox`
>
> to:
>
> perf stat --pid `pidof firefox`
>
> to:
>
> perf top --pid `pidof firefox`
>
> and get different views of that workload.

Right, that's what I want too.  Unfortunately, perf ftrace uses
the -t option for a different purpose.  But it follows other
conventions like -a for system-wide, -p for pid already.


>
> Have you thought about userspace function latencies? What tech would you
> use for that, since ftrace doesn't cover those?
>
> Would be nice that a single tool could be used to obtain userspace and
> kernel space function latencies, just like 'perf probe' can be used for
> kernel and userspace, choosing, behind the scenes, kprobes or uprobes.

Yep, that's the next step.  I think we can use uprobes
like 'perf probe' does.

Thanks,
Namhyung
