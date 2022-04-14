Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B4750039D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 03:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239429AbiDNB0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 21:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiDNB0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 21:26:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C562152B39
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 18:23:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B83961AA0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:23:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82050C385A3;
        Thu, 14 Apr 2022 01:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649899416;
        bh=2gDG2+FMjzNamReNAqV/v1d3JwqgZuw1ddRLn9TCjhw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eOLqVMdQAa9hywnzp6hidDX7SZjrL2PvjXbDmgj/MeqKs5LUxYS0nPuwGOGBe5KlA
         UsZzVcJzY4gQn2tr0Qb3MVcADCqFWMbdY1A2YRNWLXPFPVAabJgNoHgNN2KUQPeA13
         YMjvC4qB8K6kODvg9diqAMs8uXGGCGIVgqLGBkFGVfV+lsrMM5vuj9h2ouSUUx5udb
         R0Wjh/2BuMqgnPzvKrLFVA9EJB5owanBIXR+DixRTLZ9kRPxU2X2oizJ3z8kaXAIWS
         hdjVbC22Q3IvOS3JCc90L1y4tBcLZ7yXe2J/UiDuO2CWx7LOIV4dL/yePdkRHEHIto
         7McIuBe3prSeQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A4DB640407; Wed, 13 Apr 2022 22:23:32 -0300 (-03)
Date:   Wed, 13 Apr 2022 22:23:32 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Fix segfault accessing sample_id xyarray
Message-ID: <Yld3lFmtBqmTscSs@kernel.org>
References: <20220413114232.26914-1-adrian.hunter@intel.com>
 <CAP-5=fUWHb=fSVQmURbxqOO=DvhjeczzJpuXbR2ebtEsmhf7TQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUWHb=fSVQmURbxqOO=DvhjeczzJpuXbR2ebtEsmhf7TQ@mail.gmail.com>
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

Em Wed, Apr 13, 2022 at 02:11:41PM -0700, Ian Rogers escreveu:
> On Wed, Apr 13, 2022 at 4:42 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >
> > perf_evsel sample_id is an xyarray which can cause a segfault when
> > accessed beyond its size. e.g.
> >
> >  # perf record -e intel_pt// -C 1 sleep 1
> >  Segmentation fault (core dumped)
> >
> > That is happening because a dummy event is opened to capture text poke
> > events accoss all CPUs, however the mmap logic is allocating according
> > to the number of user_requested_cpus.
> 
> Nit: typo on 'accoss'

Fixed
 
> > In general, perf sometimes uses the evsel cpus to open events, and
> > sometimes the evlist user_requested_cpus. However, it is not necessary
> > to determine which case is which because the opened event file
> > descriptors are also in an xyarray, the size of whch can be used
> > to correctly allocate the size of the sample_id xyarray, because there
> > is one ID per file descriptor. Note, in the affected code path,
> > perf_evsel fd array is subsequently used to get the file descriptor for
> > the mmap, so it makes sense for the xyarrays to be the same size there.
> >
> > Fixes: 246eba8e9041c4 ("perf tools: Add support for PERF_RECORD_TEXT_POKE")
> > Fixes: d1a177595b3a82 ("libperf: Adopt perf_evlist__mmap()/munmap() from tools/perf")
> > Cc: stable@vger.kernel.org # 5.5+
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo

 
> Thanks,
> Ian
> 
> > ---
> >  tools/lib/perf/evlist.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> > index 1b15ba13c477..a09315538a30 100644
> > --- a/tools/lib/perf/evlist.c
> > +++ b/tools/lib/perf/evlist.c
> > @@ -577,7 +577,6 @@ int perf_evlist__mmap_ops(struct perf_evlist *evlist,
> >  {
> >         struct perf_evsel *evsel;
> >         const struct perf_cpu_map *cpus = evlist->user_requested_cpus;
> > -       const struct perf_thread_map *threads = evlist->threads;
> >
> >         if (!ops || !ops->get || !ops->mmap)
> >                 return -EINVAL;
> > @@ -589,7 +588,7 @@ int perf_evlist__mmap_ops(struct perf_evlist *evlist,
> >         perf_evlist__for_each_entry(evlist, evsel) {
> >                 if ((evsel->attr.read_format & PERF_FORMAT_ID) &&
> >                     evsel->sample_id == NULL &&
> > -                   perf_evsel__alloc_id(evsel, perf_cpu_map__nr(cpus), threads->nr) < 0)
> > +                   perf_evsel__alloc_id(evsel, evsel->fd->max_x, evsel->fd->max_y) < 0)
> >                         return -ENOMEM;
> >         }
> >
> > --
> > 2.25.1
> >

-- 

- Arnaldo
