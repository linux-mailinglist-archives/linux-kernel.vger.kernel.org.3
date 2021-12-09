Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F3146F365
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 19:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhLISzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 13:55:20 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:38392 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbhLISzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 13:55:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 345DECE27AF;
        Thu,  9 Dec 2021 18:51:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432FDC004DD;
        Thu,  9 Dec 2021 18:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639075899;
        bh=6RDtEcVmRXZthfvwi1qdvQByNAKkBB0mgA+IKMkVDt4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TucwtocMnOQPXvaUYiMIpxkozppXxyfdabFA0TuTv/IwwfVCBtO66uqnPILGY0ltK
         QTMiLevMqHDwFyVNyrxknT5VDU2lOvlyPYA/Yf09Rs9w+8bL6VtD/JsfkftKRqiFBY
         mN2S9ZWo7Z3PlaZh8nOL39zNTAhe0AF26flFwgJFWbuVixnfo6X5vBO0XoXiWIwMae
         6ft/X5whx+zjOAwtT6xRM//fqEVofc9VISQr/k6SD3c0xJgfJzUQrvO6CZGhsfyXek
         ux46KBRWZRw4lb/+ZO90NWlvbA8qL5g9hJ/mrJNtKAx4+rHRahV8VKb0au9ZaxU8hI
         4Sur2eab51GIQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B7F7D405D8; Thu,  9 Dec 2021 15:51:37 -0300 (-03)
Date:   Thu, 9 Dec 2021 15:51:37 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Sohaib Mohamed <sohaib.amhmd@gmail.com>, irogers@google.com,
        Riccardo Mancini <rickyman7@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Fabian Hemmer <copy@copy.sh>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Unbuffered output when pipe/tee to a file
Message-ID: <YbJQOfeeAoJ1GzJZ@kernel.org>
References: <20211119061409.78004-1-sohaib.amhmd@gmail.com>
 <YaOhbfWzMv/uvKKi@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaOhbfWzMv/uvKKi@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Nov 28, 2021 at 04:34:05PM +0100, Jiri Olsa escreveu:
> On Fri, Nov 19, 2021 at 08:14:08AM +0200, Sohaib Mohamed wrote:
> > The output of Perf bench gets buffered when I pipe it to a file or to
> > tee, in such a way that I can see it only at the end.
> > 
> > E.g.
> > $ perf bench internals synthesize -t
> > < output comes out fine after each test run >
> > 
> > $ perf bench internals synthesize -t | tee file.txt
> > < output comes out only at the end of all tests >
> > 
> > This patch resolves this issue for 'bench' and 'test' subcommands.
> 
> I can reproduce this for bench, but not for test subcommand
> other that that it makes sense to me

I reproduced it, see my comment to Sohaib's message, its not at the end,
its when the buffer fills up.

From the "it makes sense to me" I'm deriving an Acked-by you, ok?

- Arnaldo
 
> jirka
> 
> > 
> > See, also:
> > $ perf bench mem all | tee file.txt
> > $ perf bench sched all | tee file.txt
> > $ perf bench internals all -t | tee file.txt
> > $ perf bench internals all | tee file.txt
> > 
> > Suggested-by: Riccardo Mancini <rickyman7@gmail.com>
> > Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
> > ---
> > v1 -> v2:
> > - Use setvbuf(), instead of sprinkling fflush() calls and missing some places.
> > 
> > v1: https://lore.kernel.org/linux-perf-users/20211112215313.108823-1-sohaib.amhmd@gmail.com/
> > ---
> >  tools/perf/builtin-bench.c      | 5 +++--
> >  tools/perf/tests/builtin-test.c | 3 +++
> >  2 files changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
> > index d0895162c2ba..d291f3a8af5f 100644
> > --- a/tools/perf/builtin-bench.c
> > +++ b/tools/perf/builtin-bench.c
> > @@ -226,7 +226,6 @@ static void run_collection(struct collection *coll)
> >  		if (!bench->fn)
> >  			break;
> >  		printf("# Running %s/%s benchmark...\n", coll->name, bench->name);
> > -		fflush(stdout);
> > 
> >  		argv[1] = bench->name;
> >  		run_bench(coll->name, bench->name, bench->fn, 1, argv);
> > @@ -247,6 +246,9 @@ int cmd_bench(int argc, const char **argv)
> >  	struct collection *coll;
> >  	int ret = 0;
> > 
> > +	/* Unbuffered output */
> > +	setvbuf(stdout, NULL, _IONBF, 0);
> > +
> >  	if (argc < 2) {
> >  		/* No collection specified. */
> >  		print_usage();
> > @@ -300,7 +302,6 @@ int cmd_bench(int argc, const char **argv)
> > 
> >  			if (bench_format == BENCH_FORMAT_DEFAULT)
> >  				printf("# Running '%s/%s' benchmark:\n", coll->name, bench->name);
> > -			fflush(stdout);
> >  			ret = run_bench(coll->name, bench->name, bench->fn, argc-1, argv+1);
> >  			goto end;
> >  		}
> > diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> > index 8cb5a1c3489e..d92ae4efd2e6 100644
> > --- a/tools/perf/tests/builtin-test.c
> > +++ b/tools/perf/tests/builtin-test.c
> > @@ -606,6 +606,9 @@ int cmd_test(int argc, const char **argv)
> >          if (ret < 0)
> >                  return ret;
> > 
> > +	/* Unbuffered output */
> > +	setvbuf(stdout, NULL, _IONBF, 0);
> > +
> >  	argc = parse_options_subcommand(argc, argv, test_options, test_subcommands, test_usage, 0);
> >  	if (argc >= 1 && !strcmp(argv[0], "list"))
> >  		return perf_test__list(argc - 1, argv + 1);
> > --
> > 2.25.1
> > 

-- 

- Arnaldo
