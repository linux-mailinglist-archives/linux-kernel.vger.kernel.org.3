Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC754E4854
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 22:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235762AbiCVViX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 17:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiCVViW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 17:38:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D616252;
        Tue, 22 Mar 2022 14:36:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA67561749;
        Tue, 22 Mar 2022 21:36:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E01C340EC;
        Tue, 22 Mar 2022 21:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647985013;
        bh=xsxczdu0hsS3aRebxYXBIx2vI0JCWxkg6df2LNuNEEQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HVcboc+Y6NhYdxSAJ0/p/RYHJqaE8j05xgeLLHuSoSGTnCG26IwvN+m60IZ879p2c
         kKg/jtKi6Q7DmhW9H/fCV02qiW0cyDMQGz6aoLJxnRKFiyfjPYgr1r3zevtDfyiyYK
         Rvx6UNJaH5Wn6q0PQgc7LU+IeuES9q/IPbUhhLZQ6rq6AwBxN6i0U3aU0TRFXLsoUA
         fDrSqC5c47JKOHQSiqiOsrZ+GgVX88GgolGWhw+1B6nIYYpgepP/2f2PzXh8ljeT08
         S7YanT8WulzBw0O+xw1NzmiShF7ncyj38zo7YsYNQC12eLaQJvt5kU6PSC2sq/JlEJ
         61ege9VC5oQDg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 71A3240407; Tue, 22 Mar 2022 18:36:50 -0300 (-03)
Date:   Tue, 22 Mar 2022 18:36:50 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     kajoljain <kjain@linux.ibm.com>
Cc:     Kim Phillips <kim.phillips@amd.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Robert Richter <robert.richter@amd.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 1/2] perf evsel: Make evsel__env always return a valid env
Message-ID: <YjpBch/kqSn3Bmfy@kernel.org>
References: <20211004214114.188477-1-kim.phillips@amd.com>
 <00c83305-7654-132d-a734-1746dd9f34f2@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00c83305-7654-132d-a734-1746dd9f34f2@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 23, 2021 at 01:56:38PM +0530, kajoljain escreveu:
> 
> 
> On 10/5/21 3:11 AM, Kim Phillips wrote:
> > It's possible to have an evsel and evsel->evlist populated without
> > an evsel->evlist->env, when, e.g., cmd_record is in its error path.
> > 
> > Future patches will add support for evsel__open_strerror to be able
> > to customize error messaging based on perf_env__{arch,cpuid}, so
> > let's have evsel__env return &perf_env instead of NULL in that case.
> > 
> 
> Patch looks good to me.
> 
> Reviewed-by: Kajol Jain<kjain@linux.ibm.com>

Collecting this one now, found it thru the cracks.

- Arnaldo
 
> Thanks,
> Kajol Jain
> 
> > Signed-off-by: Kim Phillips <kim.phillips@amd.com>
> > Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Jiri Olsa <jolsa@redhat.com>
> > Cc: Joao Martins <joao.m.martins@oracle.com>
> > Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Michael Petlan <mpetlan@redhat.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Robert Richter <robert.richter@amd.com>
> > Cc: Stephane Eranian <eranian@google.com>
> > ---
> >  tools/perf/util/evsel.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index dbfeceb2546c..b915840690d4 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -2857,7 +2857,7 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
> >  
> >  struct perf_env *evsel__env(struct evsel *evsel)
> >  {
> > -	if (evsel && evsel->evlist)
> > +	if (evsel && evsel->evlist && evsel->evlist->env)
> >  		return evsel->evlist->env;
> >  	return &perf_env;
> >  }
> > 

-- 

- Arnaldo
