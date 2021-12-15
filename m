Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA4FF475CC7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbhLOQI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:08:27 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34762 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbhLOQI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:08:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A1214B81D40
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 16:08:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ECE1C36AE0;
        Wed, 15 Dec 2021 16:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639584504;
        bh=8YG2JENArVBvYW8B91rzcckGA1CH/iL+tioRy0Z4Wo8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q2hhUKwXEy7Tg9fIRvlZnVIVRpeVN3PEie8EN4bDQzVGEyULzpghGEISA/duRKT0n
         IGDCnDu19voUeOPp65tJu1HzqoHnLXmWNwheroRx2pBlVcEzHrFleByJ48Flnwn67X
         JpJ/7NFVFwiIeABOAS4H5iVB+Ob0I3kSjEDfcQ052xnEpUlhUkqAFqikzuZID0OQUM
         hrfu+AVuZc3uOfGlfEx+c0sKwucmy1AMgX0eEi2NoGUMHwSYzZCvI/zS82vq0Lp0Zd
         lnIp6FVC2I4uvpgigP+nq7ud1s2Q/nudPRYKuIzL/XkOCahehJzY+Gldjat+/PnXfp
         tcvCjUym8pdKA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8E3C5405D8; Wed, 15 Dec 2021 12:44:18 -0300 (-03)
Date:   Wed, 15 Dec 2021 12:44:18 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Song Liu <songliubraving@fb.com>,
        Changbin Du <changbin.du@gmail.com>
Subject: Re: [RFC/PATCHSET 0/5] perf ftrace: Implement function latency
 histogram (v1)
Message-ID: <YboNUk+ThCpEf8mQ@kernel.org>
References: <20211129231830.1117781-1-namhyung@kernel.org>
 <YbePytGwg9Kb7hT1@kernel.org>
 <CAM9d7ciqzb4CArnzMf20x7XccwvmPSzCdk3w7Hhu=qg9TuD4vw@mail.gmail.com>
 <YboKAvgX7SIiUcoN@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YboKAvgX7SIiUcoN@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Dec 15, 2021 at 12:30:10PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Dec 13, 2021 at 11:40:16AM -0800, Namhyung Kim escreveu:
> > On Mon, Dec 13, 2021 at 10:24 AM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > Em Mon, Nov 29, 2021 at 03:18:25PM -0800, Namhyung Kim escreveu:
> > > > Hello,
> > > >
> > > > I've implemented 'latency' subcommand in the perf ftrace command to
> > > > show a histogram of function latency.
> > >
> > > This still applies cleanly, I'll test it later.
> > 
> > Thank you Arnaldo!  While I have some small modifications
> > but the functionality should be the same.  Please let me know
> > if you have any suggestions.
> 
> So, it is failing here with:

So that 'fd' variable and the cpumap.h problems goes away when the last
patch is applied, but for bisection its better to apply the patch below
to 4/5.

I tested it all, cool stuff, will you resubmit soon?

I pushed it to the tmp.perf/ftrace_bpf branch on my repo at:

git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=tmp.perf/ftrace_bpf

With committer testing notes.

- Arnaldo
 
> Fixed with:
> 
> 
> diff --git a/tools/perf/util/bpf_ftrace.c b/tools/perf/util/bpf_ftrace.c
> index 1975a6fe73c9fa8b..f5b49fc056ab8b95 100644
> --- a/tools/perf/util/bpf_ftrace.c
> +++ b/tools/perf/util/bpf_ftrace.c
> @@ -5,6 +5,7 @@
>  
>  #include <linux/err.h>
>  
> +#include "util/cpumap.h"
>  #include "util/ftrace.h"
>  #include "util/debug.h"
>  #include "util/bpf_counter.h"
> @@ -15,7 +16,7 @@ static struct func_latency_bpf *skel;
>  
>  int perf_ftrace__latency_prepare_bpf(struct perf_ftrace *ftrace)
>  {
> -	int fd, err;
> +	int err;
>  	struct filter_entry *func;
>  	struct bpf_link *begin_link, *end_link;
>  

-- 

- Arnaldo
