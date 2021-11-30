Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B84463E94
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 20:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbhK3T0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 14:26:17 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:55410 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhK3T0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 14:26:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 28487CE1AFF;
        Tue, 30 Nov 2021 19:22:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4DEC53FC7;
        Tue, 30 Nov 2021 19:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638300160;
        bh=g8FdUvCnQefFM7xkiIjUudQU6bahirskO/kIhCEVVJo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TogmKySseyWkz6Tbj9vbqvhn8qcWVh5rE/M9KwXoPuNNeOtKlpybqJYeR3O3sxkQx
         6nUu3NN2D4tPm4tIfbYfmdozRnwiEowd6gFzKgql83VoOrEaB0+vJe6sPlO35iq5Yc
         b2YIBiGk8PEjaFW1JnA3TXPjuLEQ32jrpeFbfel6xijqg2cYZqV0vU8CsZkATuZR2E
         OFz/fs6f+t2Wbja9bROlbdrMi5oEDJjt/bjz3DN4Wt7v4vkLE2KDOiIvnTqmGFKTWt
         zeRFWpAcMbpp4XU1LzqX4dSsWmzJskNuNVbyL3SBHXUmo6iuFj2JyyfE1axruK6buX
         D4p/sAWPT2ixA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3023140002; Tue, 30 Nov 2021 16:22:36 -0300 (-03)
Date:   Tue, 30 Nov 2021 16:22:36 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf header: Fix memory leaks
Message-ID: <YaZ5/Gg9a+5NbEVg@kernel.org>
References: <20211118201730.2302927-1-irogers@google.com>
 <YaOkbojVb2gZtfCk@krava>
 <CAP-5=fVRE8dcDtivYaAm=DQze4d2966X7oWTWVzstzWeC-xeSw@mail.gmail.com>
 <YaZqN5UQfhBmgznT@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaZqN5UQfhBmgznT@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 30, 2021 at 07:15:19PM +0100, Jiri Olsa escreveu:
> On Mon, Nov 29, 2021 at 03:38:28PM -0800, Ian Rogers wrote:
> > On Sun, Nov 28, 2021 at 7:47 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > On Thu, Nov 18, 2021 at 12:17:30PM -0800, Ian Rogers wrote:
> > > > These leaks were found with leak sanitizer running "perf pipe recording
> > > > and injection test". In pipe mode feat_fd may hold onto an events struct
> > > > that needs freeing. When string features are processed they may
> > > > overwrite an already created string, so free this before the overwrite.
> > > >
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > ---
> > > >  tools/perf/util/header.c | 15 ++++++++++-----
> > > >  1 file changed, 10 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> > > > index 79cce216727e..e3c1a532d059 100644
> > > > --- a/tools/perf/util/header.c
> > > > +++ b/tools/perf/util/header.c
> > > > @@ -2321,6 +2321,7 @@ static int perf_header__read_build_ids(struct perf_header *header,
> > > >  #define FEAT_PROCESS_STR_FUN(__feat, __feat_env) \
> > > >  static int process_##__feat(struct feat_fd *ff, void *data __maybe_unused) \
> > > >  {\
> > > > +     free(ff->ph->env.__feat_env);                \
> > >
> > > hm, how is this set before this callback is triggered?
> > 
> > I see it for cpuid which is initially set in:
> > #0  perf_env__read_cpuid (env=0x62b000007240) at util/env.c:363
> > #1  0x0000555556325153 in perf_env__cpuid (env=0x62b000007240) at util/env.c:456
> > #2  0x00005555564002ff in evlist__init_trace_event_sample_raw
> 
> ok, I forgot we do this one, thanks for explanation
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo

