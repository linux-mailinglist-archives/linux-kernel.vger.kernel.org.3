Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C845003AC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 03:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239448AbiDNBdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 21:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiDNBdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 21:33:41 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C400522F1;
        Wed, 13 Apr 2022 18:31:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8077CCE27EB;
        Thu, 14 Apr 2022 01:31:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 849B7C385A3;
        Thu, 14 Apr 2022 01:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649899874;
        bh=pXA3UcvmQhe78Hg2wD2xtbuY0R4lUU4THOixPj3r68Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u++qsKMzV6jk9yB2AqTiqhYcOboL2TMX1glvdTxM+ZZuV40ix3zj7Z5NVRbaKq8oh
         zO/LkfW63vSukVKzS2riw8V7/JSh24VvjQxi9EcS7zPtgEek91WxBC22N1+zFeaBns
         hrArs1zAeWWpSbsljO2jibI8NDTzgT/UuQEX6AWxV852n6cVOlW9MsSC9l+da0BCp8
         fj7xqjt/YCg9oQMPMbxGrBVkquwG9uwLVev3WBIx+Ws6ouvY0RGPMhl47TaVEYp5nw
         Z6g4vaEFXPAQR7irwQJDL0d2Z9F00FXNQGGzgVaJsrQHn867iNXgabYjhf25rdiinH
         DLx1ZtsJKeSOw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E76A740407; Wed, 13 Apr 2022 22:31:11 -0300 (-03)
Date:   Wed, 13 Apr 2022 22:31:11 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexey Bayduraev <alexey.bayduraev@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/3] perf record: Fix per-thread option.
Message-ID: <Yld5X7sPshUEUgBT@kernel.org>
References: <20220412062133.2546080-1-irogers@google.com>
 <e1ce0d93-88cc-af79-e67e-d3c79d166ca6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1ce0d93-88cc-af79-e67e-d3c79d166ca6@gmail.com>
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

Em Wed, Apr 13, 2022 at 04:42:07AM +0300, Alexey Bayduraev escreveu:
> On 12.04.2022 09:21, Ian Rogers wrote:
> 
> > From: Alexey Bayduraev <alexey.bayduraev@gmail.com>
> 
> Thanks,
> 
> The tag
> Signed-off-by: Alexey Bayduraev <alexey.bayduraev@gmail.com>
> can be added to this patch.

Thanks, will add that to the cset,

Best regards,

- Arnaldo
 
> Regards,
> Alexey
> 
> > 
> > Per-thread mode doesn't have specific CPUs for events, add checks for
> > this case.
> > 
> > Minor fix to a pr_debug by Ian Rogers <irogers@google.com> to avoid an
> > out of bound array access.
> > 
> > Reported-by: Ian Rogers <irogers@google.com>
> > Fixes: 7954f71689f9 ("perf record: Introduce thread affinity and mmap masks")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-record.c | 22 +++++++++++++++++-----
> >  1 file changed, 17 insertions(+), 5 deletions(-)
> > 
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index ba74fab02e62..069825c48d40 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -989,8 +989,11 @@ static int record__thread_data_init_maps(struct record_thread *thread_data, stru
> >  	struct mmap *overwrite_mmap = evlist->overwrite_mmap;
> >  	struct perf_cpu_map *cpus = evlist->core.user_requested_cpus;
> >  
> > -	thread_data->nr_mmaps = bitmap_weight(thread_data->mask->maps.bits,
> > -					      thread_data->mask->maps.nbits);
> > +	if (cpu_map__is_dummy(cpus))
> > +		thread_data->nr_mmaps = nr_mmaps;
> > +	else
> > +		thread_data->nr_mmaps = bitmap_weight(thread_data->mask->maps.bits,
> > +						      thread_data->mask->maps.nbits);
> >  	if (mmap) {
> >  		thread_data->maps = zalloc(thread_data->nr_mmaps * sizeof(struct mmap *));
> >  		if (!thread_data->maps)
> > @@ -1007,16 +1010,17 @@ static int record__thread_data_init_maps(struct record_thread *thread_data, stru
> >  		 thread_data->nr_mmaps, thread_data->maps, thread_data->overwrite_maps);
> >  
> >  	for (m = 0, tm = 0; m < nr_mmaps && tm < thread_data->nr_mmaps; m++) {
> > -		if (test_bit(cpus->map[m].cpu, thread_data->mask->maps.bits)) {
> > +		if (cpu_map__is_dummy(cpus) ||
> > +		    test_bit(cpus->map[m].cpu, thread_data->mask->maps.bits)) {
> >  			if (thread_data->maps) {
> >  				thread_data->maps[tm] = &mmap[m];
> >  				pr_debug2("thread_data[%p]: cpu%d: maps[%d] -> mmap[%d]\n",
> > -					  thread_data, cpus->map[m].cpu, tm, m);
> > +					  thread_data, perf_cpu_map__cpu(cpus, m).cpu, tm, m);
> >  			}
> >  			if (thread_data->overwrite_maps) {
> >  				thread_data->overwrite_maps[tm] = &overwrite_mmap[m];
> >  				pr_debug2("thread_data[%p]: cpu%d: ow_maps[%d] -> ow_mmap[%d]\n",
> > -					  thread_data, cpus->map[m].cpu, tm, m);
> > +					  thread_data, perf_cpu_map__cpu(cpus, m).cpu, tm, m);
> >  			}
> >  			tm++;
> >  		}
> > @@ -3329,6 +3333,9 @@ static void record__mmap_cpu_mask_init(struct mmap_cpu_mask *mask, struct perf_c
> >  {
> >  	int c;
> >  
> > +	if (cpu_map__is_dummy(cpus))
> > +		return;
> > +
> >  	for (c = 0; c < cpus->nr; c++)
> >  		set_bit(cpus->map[c].cpu, mask->bits);
> >  }
> > @@ -3680,6 +3687,11 @@ static int record__init_thread_masks(struct record *rec)
> >  	if (!record__threads_enabled(rec))
> >  		return record__init_thread_default_masks(rec, cpus);
> >  
> > +	if (cpu_map__is_dummy(cpus)) {
> > +		pr_err("--per-thread option is mutually exclusive to parallel streaming mode.\n");
> > +		return -EINVAL;
> > +	}
> > +
> >  	switch (rec->opts.threads_spec) {
> >  	case THREAD_SPEC__CPU:
> >  		ret = record__init_thread_cpu_masks(rec, cpus);
> > 

-- 

- Arnaldo
