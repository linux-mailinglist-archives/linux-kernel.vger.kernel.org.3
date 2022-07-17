Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B51A57767A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 15:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiGQN6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 09:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGQN6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 09:58:12 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731F213D08
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 06:58:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E2670CE0E93
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 13:58:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0238FC341C0;
        Sun, 17 Jul 2022 13:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658066286;
        bh=gFzywpH6TXqi8fDaFqzuOgh+qfaPUafApTkKNZEkKB0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f31SjSwvp0nMjAZzWmGqoNNS1Eib/C0hKPb8z0gjBuijtuKqD5oTiPMj3s0aYu+wX
         F0S+H8CHPjfzKfZdcj3VOp2BMM5YWrQusIHR8IXePAR9HRyLCAoUWIaq9ipc1pEpgV
         4gxyLYsZY0azHdgrsSPkwEp8haHHJC1JRBPG3+hGOLpZ0Dz8atgtuexLy3Frlgt/hg
         GwiZOSyqcy1K2roHvCN6d2wu+Y+Y/u7mlUCEHYVSvgBsrnEcON+cTFy2NMu1BlMvWs
         U89tym3GA+Kq7fEDnd0k/hwEUfAq3Ru9GbMQUI4iB8oX88gepNw7I4ZeRcRQYaFbWZ
         Xv8OZSDZm30kA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EDDE340374; Sun, 17 Jul 2022 10:58:03 -0300 (-03)
Date:   Sun, 17 Jul 2022 10:58:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] perf tests: Fix Convert perf time to TSC test for
 hybrid
Message-ID: <YtQVa189ATKJ5Ey1@kernel.org>
References: <20220713123459.24145-1-adrian.hunter@intel.com>
 <20220713123459.24145-3-adrian.hunter@intel.com>
 <75aaa2a8-7956-84bb-a811-f70802753e21@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75aaa2a8-7956-84bb-a811-f70802753e21@linux.intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jul 13, 2022 at 09:05:21AM -0400, Liang, Kan escreveu:
> 
> 
> On 2022-07-13 8:34 a.m., Adrian Hunter wrote:
> > The test does not always correctly determine the number of events for
> > hybrids, nor allow for more than 1 evsel when parsing.
> > 
> > Fix by iterating the events actually created and getting the correct
> > evsel for the events processed.
> > 
> 
> Yes, we cannot always assume there are two events for hybrid.
> 
> > Fixes: d9da6f70eb23 ("perf tests: Support 'Convert perf time to TSC' test for hybrid")
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> 
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks, applied.

- Arnaldo

 
> Thanks,
> Kan
> > ---
> >  tools/perf/tests/perf-time-to-tsc.c | 18 ++++--------------
> >  1 file changed, 4 insertions(+), 14 deletions(-)
> > 
> > diff --git a/tools/perf/tests/perf-time-to-tsc.c b/tools/perf/tests/perf-time-to-tsc.c
> > index 8d6d60173693..7c7d20fc503a 100644
> > --- a/tools/perf/tests/perf-time-to-tsc.c
> > +++ b/tools/perf/tests/perf-time-to-tsc.c
> > @@ -20,8 +20,6 @@
> >  #include "tsc.h"
> >  #include "mmap.h"
> >  #include "tests.h"
> > -#include "pmu.h"
> > -#include "pmu-hybrid.h"
> >  
> >  /*
> >   * Except x86_64/i386 and Arm64, other archs don't support TSC in perf.  Just
> > @@ -106,18 +104,8 @@ static int test__perf_time_to_tsc(struct test_suite *test __maybe_unused, int su
> >  
> >  	evlist__config(evlist, &opts, NULL);
> >  
> > -	evsel = evlist__first(evlist);
> > -
> > -	evsel->core.attr.comm = 1;
> > -	evsel->core.attr.disabled = 1;
> > -	evsel->core.attr.enable_on_exec = 0;
> > -
> > -	/*
> > -	 * For hybrid "cycles:u", it creates two events.
> > -	 * Init the second evsel here.
> > -	 */
> > -	if (perf_pmu__has_hybrid() && perf_pmu__hybrid_mounted("cpu_atom")) {
> > -		evsel = evsel__next(evsel);
> > +	/* For hybrid "cycles:u", it creates two events */
> > +	evlist__for_each_entry(evlist, evsel) {
> >  		evsel->core.attr.comm = 1;
> >  		evsel->core.attr.disabled = 1;
> >  		evsel->core.attr.enable_on_exec = 0;
> > @@ -170,10 +158,12 @@ static int test__perf_time_to_tsc(struct test_suite *test __maybe_unused, int su
> >  				goto next_event;
> >  
> >  			if (strcmp(event->comm.comm, comm1) == 0) {
> > +				CHECK_NOT_NULL__(evsel = evlist__event2evsel(evlist, event));
> >  				CHECK__(evsel__parse_sample(evsel, event, &sample));
> >  				comm1_time = sample.time;
> >  			}
> >  			if (strcmp(event->comm.comm, comm2) == 0) {
> > +				CHECK_NOT_NULL__(evsel = evlist__event2evsel(evlist, event));
> >  				CHECK__(evsel__parse_sample(evsel, event, &sample));
> >  				comm2_time = sample.time;
> >  			}

-- 

- Arnaldo
