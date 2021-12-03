Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1D334678A8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 14:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381211AbhLCNqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 08:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346278AbhLCNqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 08:46:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09925C06173E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 05:43:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8841262AE9
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 13:43:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A45CAC53FAD;
        Fri,  3 Dec 2021 13:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638538992;
        bh=yWYWJNqnV3j9JUQbCtf++FFsohhSq8aIjW4kc9VLhZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KNWPZVkuSCQqHe3oBjKJJJA3gHpjo7wUBpTByet3Bulae1QO83VraWcBPAfEeU268
         1a2bD1pDZKt7S7fDqJHQWG/GczuYn20BrYsATDtp5esvztoMEfuM/K6M7cTtQKchec
         AI+HeYHCFNMT1lw2Q048t7y6uEJfBWuGh7u0t2pQT3FiCWNXP2fmqvITqTDLHdhDz1
         xyNAowV484a2PSL83sgomgpG7PY0s8nyFn6Pwz9wwsCFoUnnloJJ8KLJ7F7tbNmerh
         L4nyxoIIqhSh6zWzmRS214ts2QE0F1Zv4g0WXq/vXj4MSlLjitvvKf5rBLNBJP/i4j
         Vuq1n69v1F0xg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 239C240002; Fri,  3 Dec 2021 10:43:09 -0300 (-03)
Date:   Fri, 3 Dec 2021 10:43:09 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Stephane Eranian <eranian@google.com>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>,
        Changbin Du <changbin.du@gmail.com>
Subject: Re: [RFC/PATCHSET 0/5] perf ftrace: Implement function latency
 histogram (v1)
Message-ID: <Yaoe7YWV0m4RYXnd@kernel.org>
References: <20211129231830.1117781-1-namhyung@kernel.org>
 <YaY3JqOQ2XE22VId@kernel.org>
 <CAM9d7cjXncRRsH1Zf_yVrLeaYiHXLFM29sx0MYPAZ8HAsZaggw@mail.gmail.com>
 <CABPqkBQgr3ck_jnFbdLOKgpzrz4RhE3svTvkiOLY9KgvjQjU9w@mail.gmail.com>
 <YadjkVG14zgymjrh@kernel.org>
 <CAM9d7cjU3JG8AwxXYSwVmWVE17wYr5QXR6TA1qUVjLB1U1jZ1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cjU3JG8AwxXYSwVmWVE17wYr5QXR6TA1qUVjLB1U1jZ1g@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Dec 01, 2021 at 09:21:52AM -0800, Namhyung Kim escreveu:
> On Wed, Dec 1, 2021 at 3:59 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > Em Tue, Nov 30, 2021 at 04:36:49PM -0800, Stephane Eranian escreveu:
> > > I am not too fond of the flat option because as we had more bpf tools
> > > like function latency, then we keep extending the list of commands
> > > each with a small span which is different
> > > from what we have right now.

> > I think we should focus on the tool end result, not on how it is
> > implemented, i.e. in this specific "function latency" tool ftrace is
> > used with BPF, but we could perhaps have used some other mechanism.

> Agreed, but I think function latency belongs to function tracing
> conceptually.  So I added it as a subcommand in perf ftrace
> not just because of the implementation.

Fair enough, I think we can go as-is then, whoever finds this overly
long can do:

alias flat="perf ftrace latency"

And go:

flat -p `pidof firefox`

etc.
 
> > I think all these tools should have as much as possible a common set of
> > options, like the targets (cpu, cgroup, pid, tid, etc) so that one can
> > go from different views for those targets by just changing the name of
> > the tool.
 
> Currently, perf ftrace shares the target options with both subcommands.
> Please see common_options in cmd_ftrace().

Sure, but I was alluding to all perf tools, not just 'perf ftrace'
subcommands, i.e. one can go from:

perf ftrace trace --pid `pidof firefox`

to:

perf trace --pid `pidof firefox`

to:

perf stat --pid `pidof firefox`

to:

perf top --pid `pidof firefox`

and get different views of that workload.

Have you thought about userspace function latencies? What tech would you
use for that, since ftrace doesn't cover those?

Would be nice that a single tool could be used to obtain userspace and
kernel space function latencies, just like 'perf probe' can be used for
kernel and userspace, choosing, behind the scenes, kprobes or uprobes.

- Arnaldo
