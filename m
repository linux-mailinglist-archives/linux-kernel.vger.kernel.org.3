Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551725AE8A5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 14:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239513AbiIFMpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 08:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240059AbiIFMpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 08:45:16 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D03B3B97F;
        Tue,  6 Sep 2022 05:45:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DE82ACE173B;
        Tue,  6 Sep 2022 12:45:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE68C433D6;
        Tue,  6 Sep 2022 12:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662468310;
        bh=QeHtG9X1lWUK95xHdfILY1ToyTHiAJs89SubC+l4SH0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qk6s8V0cUJ0BGyXuuVOQdYgilVDQC6LxZvyy3NDdxZ8N7UNtVdr+/+K1oBguy6DjR
         +BfPlwr+lfpMoxtF76Wav1IIll4qR6GDxEUr7tDynsrFMLifWLm9kUcuVNk8NU7Q7x
         VDC2zGriWHp82Sppio9npowjCFJvOl5OCSwXBm6mKE8gELt90/JjjRes4ml921QH6V
         tWhJIyg0WSO3PhrlxxIfx4T3wfAwdlWmbMJYFVgzX4fRgY/u5yh6IyaK++vjhzVNbl
         mYdrzmFmOq9/WVw4VSs+NeBni88D1YEnKbiXkYvlQmD6nTOwzpnoHntBb7j2lzCY9E
         eqzOZ7j0gVTsA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4338F404A1; Tue,  6 Sep 2022 09:45:08 -0300 (-03)
Date:   Tue, 6 Sep 2022 09:45:08 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf test: Skip sigtrap test on old kernels
Message-ID: <YxdA1CVzy9hzE3i1@kernel.org>
References: <20220903000210.1112014-1-namhyung@kernel.org>
 <CANpmjNMPh5QjdxXtrCc5FApjgzV=81CNNiwbeg_rE3NxN_WCZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMPh5QjdxXtrCc5FApjgzV=81CNNiwbeg_rE3NxN_WCZw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Sep 03, 2022 at 08:52:01AM +0200, Marco Elver escreveu:
> On Sat, 3 Sept 2022 at 02:02, Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > If it runs on an old kernel, perf_event_open would fail because of the
> > new fields sigtrap and sig_data.  Just skip the test if it failed.
> >
> > Cc: Marco Elver <elver@google.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/tests/sigtrap.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tools/perf/tests/sigtrap.c b/tools/perf/tests/sigtrap.c
> > index e32ece90e164..7057566e6ae4 100644
> > --- a/tools/perf/tests/sigtrap.c
> > +++ b/tools/perf/tests/sigtrap.c
> > @@ -140,6 +140,7 @@ static int test__sigtrap(struct test_suite *test __maybe_unused, int subtest __m
> >         fd = sys_perf_event_open(&attr, 0, -1, -1, perf_event_open_cloexec_flag());
> >         if (fd < 0) {
> >                 pr_debug("FAILED sys_perf_event_open(): %s\n", str_error_r(errno, sbuf, sizeof(sbuf)));
> > +               ret = TEST_SKIP;
> 
> Wouldn't we be interested if perf_event_open() fails because it could
> actually be a bug? By skipping we'll be more likely to miss the fact
> there's a real problem.
> 
> That's my naive thinking at least - what do other perf tests usually
> do in this case?

Yeah, I was going to try and check if this is the only way that, with
the given arguments, perf_event_open would fail, but its better to at
least check errno against -EINVAL or something?

- Arnaldo
