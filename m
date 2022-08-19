Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDAF599E30
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 17:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349718AbiHSP0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 11:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349114AbiHSP0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 11:26:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F399412D;
        Fri, 19 Aug 2022 08:26:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4FB3EB82802;
        Fri, 19 Aug 2022 15:26:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A42C433D6;
        Fri, 19 Aug 2022 15:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660922791;
        bh=290iPq6XrUTOduo3MsR9/qMMKWLhl0oVMxDv8/pS1aQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MSqxW4r5pCkDl0IVhIw6oimHguJvd4K9Jr1oUuqw9p6V9q1E7I8D/lrqh/TUNr/aJ
         NJ+V5h4PXXnhv09V/N1hAQqzYrmx+ctXhbUvFvOAAcLHic1P1WnbxbYGIKXeS0BM4Z
         ky6WY+6TnzMp1UM8inJrO9aJygmh2F5s/g5iVTEz4oq3W23O8WKYxrLTeRYRnLK6mt
         H2NuNEi4A4kNsXX87aQfgjfqz17nGG1H1rG8Y6QzUOv5rHSPlgS0uq221qBolFmH6V
         ag6mdEP64uDOK+N2Ribfl+euNbTG4vuniRQG70yvTtUczYnTDw2iB4ylng2Va+RRXI
         teuy1gnN/x7Ww==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 23EF24035A; Fri, 19 Aug 2022 12:26:28 -0300 (-03)
Date:   Fri, 19 Aug 2022 12:26:28 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 0/4] perf tools: Support reading PERF_FORMAT_LOST (v3)
Message-ID: <Yv+rpO2Zvt1A5cp3@kernel.org>
References: <20220819003644.508916-1-namhyung@kernel.org>
 <Yv9rplmtHB5fZsv+@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yv9rplmtHB5fZsv+@krava>
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

Em Fri, Aug 19, 2022 at 12:53:26PM +0200, Jiri Olsa escreveu:
> On Thu, Aug 18, 2022 at 05:36:40PM -0700, Namhyung Kim wrote:
> > Hello,
> > 
> > The kernel v6.0 added PERF_FORMAT_LOST which can read a number of lost
> > samples for the given event.  As it can change the output format of
> > read(2) and perf sample data, it needs to access them carefully.
> > 
> > Changes in v3)
> >  * add sample_read_group__for_each()  (Jiri)
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks, updated the patchset in my branch.

- Arnaldo
 
> thanks,
> jirka
> 
> > 
> > Changes in v2)
> >  * add a comment in perf_evsel__read_group()  (Jiri)
> >  * simplify perf_evsel__adjust_values()  (Jiri)
> > 
> > 
> > You can get the code from 'perf/read-lost-v3' brach on
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> > 
> > Thanks,
> > Namhyung
> > 
> > Namhyung Kim (4):
> >   tools headers UAPI: Sync linux/perf_event.h with the kernel sources
> >   tools lib perf: Handle read format in perf_evsel__read()
> >   tools lib perf: Add a test case for read formats
> >   perf tools: Support reading PERF_FORMAT_LOST
> > 
> >  tools/include/uapi/linux/perf_event.h         |   5 +-
> >  tools/lib/perf/evsel.c                        |  79 ++++++++-
> >  tools/lib/perf/include/perf/event.h           |   3 +-
> >  tools/lib/perf/include/perf/evsel.h           |   4 +-
> >  tools/lib/perf/tests/test-evsel.c             | 161 ++++++++++++++++++
> >  tools/perf/tests/sample-parsing.c             |  14 +-
> >  tools/perf/util/event.h                       |  21 ++-
> >  tools/perf/util/evsel.c                       |  29 ++--
> >  .../scripting-engines/trace-event-python.c    |  19 ++-
> >  tools/perf/util/session.c                     |  35 ++--
> >  tools/perf/util/synthetic-events.c            |  32 +++-
> >  11 files changed, 356 insertions(+), 46 deletions(-)
> > 
> > 
> > base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
> > -- 
> > 2.37.1.595.g718a3a8f04-goog
> > 

-- 

- Arnaldo
