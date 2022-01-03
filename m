Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1E5E483408
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 16:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbiACPP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 10:15:57 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38616 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiACPPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 10:15:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55623B80EFC;
        Mon,  3 Jan 2022 15:15:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A17F0C36AED;
        Mon,  3 Jan 2022 15:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641222950;
        bh=JlsPW+XrEU2GAaGgYw+gRc7fXysdOHvhf4ucIuTXWwA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j+TKAu/VWbwINQiN+cy4dJvGI4Pp93ZQQ9Xw8Q0568LoeqlZQ9HMtxajwxbzg7Q7N
         rFWdSJqWRFOu04e8JZGN3suKf7UCYUtKJfAq0/mCZyp0Fj5bGT2xIfEv9m2u0zLfuC
         bojiet0Jg7yx6/5cngumnJHmKjsgMvQK1WFGnccMMcbvGWt/ejIpqbNz1xkff8fVyN
         KDF8tv55FQgwdSmvShKUAU59yPRuFWt/4cod+CPoiBlYAPowu3xNF3TUj+mBBNim7m
         ytP6oO8zJB62z1UZP9R7wWLP3dmhMZElhYqOqmgm112d4xWXhUOTl1JGf2uGJ46B7c
         ViYJuDJq/xxAw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0889840B92; Mon,  3 Jan 2022 12:15:47 -0300 (-03)
Date:   Mon, 3 Jan 2022 12:15:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        eranian@google.com
Subject: Re: [was: libtraceevent: Increase libtraceevent logging when verbose]
Message-ID: <YdMTIl7jn25XrUn8@kernel.org>
References: <20210923001024.550263-1-irogers@google.com>
 <20210923001024.550263-4-irogers@google.com>
 <bc2b0786-8965-1bcd-2316-9d9bb37b9c31@kernel.org>
 <c19ca2a2-54c9-88b1-b705-5a2cd4dd9580@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c19ca2a2-54c9-88b1-b705-5a2cd4dd9580@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 03, 2022 at 09:25:26AM +0100, Jiri Slaby escreveu:
> Ping -- perf build is still broken in 5.16-rc8 due to this.
> 
> On 16. 12. 21, 9:07, Jiri Slaby wrote:
> > Hi,
> > 
> > On 23. 09. 21, 2:10, Ian Rogers wrote:
> > > libtraceevent has added more levels of debug printout and with changes
> > > like:
> > > https://lore.kernel.org/linux-trace-devel/20210507095022.1079364-3-tz.stoyanov@gmail.com
> > > 
> > > previously generated output like "registering plugin" is no longer
> > > displayed. This change makes it so that if perf's verbose debug output
> > > is enabled then the debug and info libtraceevent messages can be
> > > displayed.
> > > The code is conditionally enabled based on the libtraceevent version as
> > > discussed in the RFC:
> > > https://lore.kernel.org/lkml/20210610060643.595673-1-irogers@google.com/
> > > 
> > > v2. Is a rebase and handles the case of building without
> > >      LIBTRACEEVENT_DYNAMIC.
> > 
> > It breaks build with LIBTRACEEVENT_DYNAMIC and version 1.3.0:
> >  > util/debug.c: In function ‘perf_debug_option’:
> >  > util/debug.c:243:17: error: implicit declaration of function
> > ‘tep_set_loglevel’ [-Werror=implicit-function-declaration]
> >  >   243 |                 tep_set_loglevel(TEP_LOG_INFO);
> >  >       |                 ^~~~~~~~~~~~~~~~
> >  > util/debug.c:243:34: error: ‘TEP_LOG_INFO’ undeclared (first use in
> > this function); did you mean ‘TEP_PRINT_INFO’?
> >  >   243 |                 tep_set_loglevel(TEP_LOG_INFO);
> >  >       |                                  ^~~~~~~~~~~~
> >  >       |                                  TEP_PRINT_INFO
> >  > util/debug.c:243:34: note: each undeclared identifier is reported
> > only once for each function it appears in
> >  > util/debug.c:245:34: error: ‘TEP_LOG_DEBUG’ undeclared (first use in
> > this function)
> >  >   245 |                 tep_set_loglevel(TEP_LOG_DEBUG);
> >  >       |                                  ^~~~~~~~~~~~~
> >  > util/debug.c:247:34: error: ‘TEP_LOG_ALL’ undeclared (first use in
> > this function)
> >  >   247 |                 tep_set_loglevel(TEP_LOG_ALL);
> >  >       |                                  ^~~~~~~~~~~
> > 
> > It is because the gcc's command line looks like:
> > gcc
> > ...
> > -I/home/abuild/rpmbuild/BUILD/tools/lib/
> > ...
> > -DLIBTRACEEVENT_VERSION=65790
> > ...
> > 
> > So:
> > 
> > 
> > > --- a/tools/perf/util/debug.c
> > > +++ b/tools/perf/util/debug.c
> > > @@ -24,6 +24,16 @@
> > >   #include "util/parse-sublevel-options.h"
> > >   #include <linux/ctype.h>
> > > +#include <traceevent/event-parse.h>
> > 
> > /home/abuild/rpmbuild/BUILD/tools/lib/traceevent/event-parse.h is taken
> > here.
> > 
> > > @@ -228,6 +238,15 @@ int perf_debug_option(const char *str)
> > >       /* Allow only verbose value in range (0, 10), otherwise set 0. */
> > >       verbose = (verbose < 0) || (verbose > 10) ? 0 : verbose;
> > > +#if MAKE_LIBTRACEEVENT_VERSION(1, 3, 0) <= LIBTRACEEVENT_VERSION
> > 
> > But
> > -DLIBTRACEEVENT_VERSION=65790
> > is taken here (which is 1.3.0).
> > 
> > > +    if (verbose == 1)
> > > +        tep_set_loglevel(TEP_LOG_INFO);
> > > +    else if (verbose == 2)
> > > +        tep_set_loglevel(TEP_LOG_DEBUG);
> > > +    else if (verbose >= 3)
> > > +        tep_set_loglevel(TEP_LOG_ALL);
> > > +#endif
> > > +
> > >       return 0;
> > >   }

Tried reproducing here on fedora 34 but it is at 1.1.1:

make: Leaving directory '/var/home/acme/git/perf/tools/perf'

 Performance counter stats for 'make -k LIBTRACEEVENT_DYNAMIC=1 BUILD_BPF_SKEL=1 CORESIGHT=1 PYTHON=python3 O=/tmp/build/perf -C tools/perf install-bin':

   397,176,418,790      cycles:u                                                    
   493,885,896,752      instructions:u            #    1.24  insn per cycle         

       8.664957770 seconds time elapsed

      97.706894000 seconds user
      23.714293000 seconds sys


On branch perf/urgent
Your branch is ahead of 'quaco/perf/urgent' by 369 commits.
  (use "git push" to publish your local commits)

nothing to commit, working tree clean
19: 'import perf' in python                                         : Ok
⬢[acme@toolbox perf]$ git diff
⬢[acme@toolbox perf]$ rpm -q libtraceevent-devel
libtraceevent-devel-1.1.1-2.fc34.x86_64

Lemme see in a container so that I can also test the fix.

- Arnaldo
