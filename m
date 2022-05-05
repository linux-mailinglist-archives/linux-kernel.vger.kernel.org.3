Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8602051C642
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 19:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382299AbiEERnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359669AbiEERnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:43:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293235AA71;
        Thu,  5 May 2022 10:39:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D862CB82E0F;
        Thu,  5 May 2022 17:39:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 650BAC385A4;
        Thu,  5 May 2022 17:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651772380;
        bh=MP4FGxU0cT0HKuYaYoJR7vQCDWINocb0Kh7IqE1yM/k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A0d8mDv8eQS0cy+QeEcpBQjV+h0XnRDsth6FV/0cU4rTUsFS90MtfPDWCvD1zzeWJ
         0Eh89QRxK4r0SyGanFAYF5NluizqIdtRhYpcmm44vcROBIhDDtnLK3nIm7BwIXvPLA
         jlJUgE56vDtRnVUsp2FTt7lZu543uMxDThIEi4VgGp5mmb+3IuSl9F4uBmV8nO4yiG
         fsFzoLELM6BHmncThff+rKHvKxTIi7PW3DpsbC3I1IRVkWN+TTj7AGZvFCwtlXZQCS
         dVh/K4WlHKPoxQrANlUuiU0oN5YGc/MaRb/7FhcSvwDDkAdbuL2OwXmsxtRIlLDB9r
         VY2ZvibPScFNA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 35EB1400B1; Thu,  5 May 2022 14:39:38 -0300 (-03)
Date:   Thu, 5 May 2022 14:39:38 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v5 2/6] perf evlist: Clear all_cpus before propagating
Message-ID: <YnQL2rHZhvZPDeEZ@kernel.org>
References: <20220503041757.2365696-1-irogers@google.com>
 <20220503041757.2365696-3-irogers@google.com>
 <9e862a01-b955-70c0-25ae-2efc03f636bf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e862a01-b955-70c0-25ae-2efc03f636bf@intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 04, 2022 at 05:15:57PM +0300, Adrian Hunter escreveu:
> On 3/05/22 07:17, Ian Rogers wrote:
> > all_cpus is merged into during propagation. Initially all_cpus is set
> > from PMU sysfs. perf_evlist__set_maps will recompute it and change
> > evsel->cpus to user_requested_cpus if they are given. If all_cpus isn't
> > cleared then the union of the user_requested_cpus and PMU sysfs values
> > is set to all_cpus, whereas just user_requested_cpus is necessary. To
> > avoid this make all_cpus empty prior to propagation.
> > 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied.

- Arnaldo

 
> > ---
> >  tools/lib/perf/evlist.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> > index a09315538a30..974b4585f93e 100644
> > --- a/tools/lib/perf/evlist.c
> > +++ b/tools/lib/perf/evlist.c
> > @@ -59,6 +59,10 @@ static void perf_evlist__propagate_maps(struct perf_evlist *evlist)
> >  {
> >  	struct perf_evsel *evsel;
> >  
> > +	/* Recomputing all_cpus, so start with a blank slate. */
> > +	perf_cpu_map__put(evlist->all_cpus);
> > +	evlist->all_cpus = NULL;
> > +
> >  	perf_evlist__for_each_evsel(evlist, evsel)
> >  		__perf_evlist__propagate_maps(evlist, evsel);
> >  }

-- 

- Arnaldo
