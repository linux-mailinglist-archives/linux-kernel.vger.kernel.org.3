Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3214A464D5F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 12:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347322AbhLAMCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 07:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbhLAMCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 07:02:41 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9C3C061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 03:59:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6593FCE1DE3
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 11:59:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E82FC53FCC;
        Wed,  1 Dec 2021 11:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638359956;
        bh=aiTCkk0TikyuBdLvGGGBmK+UpBVpXvaHV0+Zl+wcJl0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q54XZdZzjgqdhkfHAFxrPRY3LaKQNXRFEeNkVkD8sIVPSm+ZdBuxIR06yqmhRBoVB
         20l3n0nV+6+1beDqbE8XM/cqZZmdKzSIhvH2nGZAD1cUWcCPJlppfheJLY5Plb49Bw
         nprmyg+ioViJmQJvGecOKl4Wf5KFxBwg9KY1CPqU/UJmUCmnWrxxVxUpR0IwA1n/aD
         f8/DayFSkiquPbMBhQ6qCfhZS6UicPHjbuhEOGrxdsWlH/BkZsRcmbmiQGNu/MEADo
         AB++CHYCM0jheWBlLHKU3wV1OOgKeFgx3DNhL2QExN7c1pN9i0EMBIDVmSHX4O43Es
         8JiY8tmbNGgrQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1F99E40002; Wed,  1 Dec 2021 08:59:13 -0300 (-03)
Date:   Wed, 1 Dec 2021 08:59:13 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>,
        Changbin Du <changbin.du@gmail.com>
Subject: Re: [RFC/PATCHSET 0/5] perf ftrace: Implement function latency
 histogram (v1)
Message-ID: <YadjkVG14zgymjrh@kernel.org>
References: <20211129231830.1117781-1-namhyung@kernel.org>
 <YaY3JqOQ2XE22VId@kernel.org>
 <CAM9d7cjXncRRsH1Zf_yVrLeaYiHXLFM29sx0MYPAZ8HAsZaggw@mail.gmail.com>
 <CABPqkBQgr3ck_jnFbdLOKgpzrz4RhE3svTvkiOLY9KgvjQjU9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBQgr3ck_jnFbdLOKgpzrz4RhE3svTvkiOLY9KgvjQjU9w@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 30, 2021 at 04:36:49PM -0800, Stephane Eranian escreveu:
> On Tue, Nov 30, 2021 at 2:58 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > On Tue, Nov 30, 2021 at 6:37 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> > > Em Mon, Nov 29, 2021 at 03:18:25PM -0800, Namhyung Kim escreveu:
> > > > I've implemented 'latency' subcommand in the perf ftrace command to
> > > > show a histogram of function latency.

> > > > To handle new subcommands, the existing functionality is moved to
> > > > 'trace' subcommand while preserving backward compatibility of not
> > > > having a subcommand at all (defaults to 'trace').

> > > > The latency subcommand accepts a target (kernel, for now) function
> > > > with -T option and shows a histogram like below:

> > > Humm, wouldn't be interesting to shorten this by having a new 'perf
> > > flat' (function latency) tool, on the same level as 'perf ftrace' and
> > > leave 'perf ftrace' to just being a convenient perf interface to what
> > > ftrace provides?

> > That would be fine.  I also think 'perf ftrace latency' is
> > bit too long.  But if we would add a new feature
> > like argdist (in BCC) later, I thought it'd be nice being
> > a subcommand in the perf ftrace together.

> > But it's up to you.  I'll make a change if you prefer
> > 'flat' (or how about 'fnlat' instead?).

fnlat would be ok, flat was just funny to avoid suggesting it :-)

> I am not too fond of the flat option because as we had more bpf tools
> like function latency, then we keep extending the list of commands
> each with a small span which is different
> from what we have right now.

I think we should focus on the tool end result, not on how it is
implemented, i.e. in this specific "function latency" tool ftrace is
used with BPF, but we could perhaps have used some other mechanism.

I think all these tools should have as much as possible a common set of
options, like the targets (cpu, cgroup, pid, tid, etc) so that one can
go from different views for those targets by just changing the name of
the tool.

We have things like:

$ perf sched

 Usage: perf sched [<options>] {record|latency|map|replay|script|timehist}

    -D, --dump-raw-trace  dump raw trace in ASCII
    -f, --force           don't complain, do it
    -i, --input <file>    input file name
    -v, --verbose         be more verbose (show symbol address, etc)

With different 3rd level subcommads, but in the 'perf sched' case is the
component being observed, not the mechanism being used to obtain/present
the observation data.

- Arnaldo
