Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83DAD4FA915
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 16:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242351AbiDIOqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 10:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbiDIOqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 10:46:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043A61F622;
        Sat,  9 Apr 2022 07:43:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B064EB8075F;
        Sat,  9 Apr 2022 14:43:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A67C385A4;
        Sat,  9 Apr 2022 14:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649515431;
        bh=LSsO7LPkMtldWiCiKMf+VYAQKsLfgroPVlxEg/sJGXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qVFdKrMxZAczZB294SkgrKI/S/OVT3OfW0dZTcRkmmLovolYNW6P2TT/2P9dyxLdK
         yehEhNh3X5OKJ2vIgE4KjLUoOJWBz2J/RmVrauNopMkIXjBo0EePKTe2h3cSfOwL9/
         5wCcOwNu53YaSdhVNSHEO5IPszvb8gtRqwudbnZGEq/SHNdkA9k2jkLtF43yEQW3XH
         QEDFmOb7FCOymp7mDMQHRudvWj4GID/Bj/YB+BW8ZXnWs9qA1lGLlHVdiqHCdbRqGD
         Mfiltx5iA39GCxxng9cwGQUqYdSONTTCo9PMM5KXzkC1ZYsjfvwyTMoSxQVcGYxMQg
         NWAQPJLC6PadA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7024C40407; Sat,  9 Apr 2022 11:43:48 -0300 (-03)
Date:   Sat, 9 Apr 2022 11:43:48 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Chengdong Li <brytonlee01@gmail.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, ak@linux.intel.com, likexu@tencent.com,
        chengdongli@tencent.com
Subject: Re: [PATCH v4] perf test tsc: Fix error message report when not
 supported.
Message-ID: <YlGbpO8nP32Iqkwb@kernel.org>
References: <CAC2pzGdMFmtV8YNR4DszoATjM80uYNwrnW5As6vgBsyXVcWueA@mail.gmail.com>
 <20220408084748.43707-1-chengdongli@tencent.com>
 <00e04618-f7ed-e016-cddf-0475fdc5fe91@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00e04618-f7ed-e016-cddf-0475fdc5fe91@intel.com>
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

Em Fri, Apr 08, 2022 at 12:16:36PM +0300, Adrian Hunter escreveu:
> On 08/04/2022 11.47, Chengdong Li wrote:
> > From: Chengdong Li <chengdongli@tencent.com>
> > 
> > By default `perf test tsc` does not return the error message
> > when the child process detected kernel does not support. Instead,
> > the child process print error message to stderr, unfortunately
> > the stderr is redirected to /dev/null when verbose <= 0.
> > 
> > This patch did three things:
> > - returns TEST_SKIP to the parent process instead of TEST_OK when
> >   perf_read_tsc_conversion() is not supported.
> > - add a new subtest of testing if TSC is supported on current
> >   architecture by moving exist code to a separate function.
> >   It avoids two places in test__perf_time_to_tsc() that return
> >   TEST_SKIP by doing this.
> > - extended test suite definition to contain above two subtests.
> >   Current test_suite and test_case structs do not support printing
> >   skip reason when the number of subtest less than 1. To print skip
> >   reason, it is necessary to extend current test suite definition.
> > 
> > Changes since v3:
> > - refine commit message again to make it clear. 
> > 
> > Changes since v2:
> > - refine error message format.
> > - refine commit log message according to Adrian's review comments.
> > 
> > Changes since v1 (thanks for the feedback from Adrian Hunter):
> > - rebase commit to current source.
> > 
> > Signed-off-by: Chengdong Li <chengdongli@tencent.com>
> 
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied.

- Arnaldo

 
> > ---
> >  tools/perf/tests/perf-time-to-tsc.c | 36 +++++++++++++++++++++--------
> >  1 file changed, 27 insertions(+), 9 deletions(-)
> > 
> > diff --git a/tools/perf/tests/perf-time-to-tsc.c b/tools/perf/tests/perf-time-to-tsc.c
> > index d12d0ad81801..cc6df49a65a1 100644
> > --- a/tools/perf/tests/perf-time-to-tsc.c
> > +++ b/tools/perf/tests/perf-time-to-tsc.c
> > @@ -47,6 +47,17 @@
> >  	}					\
> >  }
> >  
> > +static int test__tsc_is_supported(struct test_suite *test __maybe_unused,
> > +				  int subtest __maybe_unused)
> > +{
> > +	if (!TSC_IS_SUPPORTED) {
> > +		pr_debug("Test not supported on this architecture\n");
> > +		return TEST_SKIP;
> > +	}
> > +
> > +	return TEST_OK;
> > +}
> > +
> >  /**
> >   * test__perf_time_to_tsc - test converting perf time to TSC.
> >   *
> > @@ -70,7 +81,7 @@ static int test__perf_time_to_tsc(struct test_suite *test __maybe_unused, int su
> >  	struct perf_cpu_map *cpus = NULL;
> >  	struct evlist *evlist = NULL;
> >  	struct evsel *evsel = NULL;
> > -	int err = -1, ret, i;
> > +	int err = TEST_FAIL, ret, i;
> >  	const char *comm1, *comm2;
> >  	struct perf_tsc_conversion tc;
> >  	struct perf_event_mmap_page *pc;
> > @@ -79,10 +90,6 @@ static int test__perf_time_to_tsc(struct test_suite *test __maybe_unused, int su
> >  	u64 test_time, comm1_time = 0, comm2_time = 0;
> >  	struct mmap *md;
> >  
> > -	if (!TSC_IS_SUPPORTED) {
> > -		pr_debug("Test not supported on this architecture");
> > -		return TEST_SKIP;
> > -	}
> >  
> >  	threads = thread_map__new(-1, getpid(), UINT_MAX);
> >  	CHECK_NOT_NULL__(threads);
> > @@ -124,8 +131,8 @@ static int test__perf_time_to_tsc(struct test_suite *test __maybe_unused, int su
> >  	ret = perf_read_tsc_conversion(pc, &tc);
> >  	if (ret) {
> >  		if (ret == -EOPNOTSUPP) {
> > -			fprintf(stderr, " (not supported)");
> > -			return 0;
> > +			pr_debug("perf_read_tsc_conversion is not supported in current kernel\n");
> > +			err = TEST_SKIP;
> >  		}
> >  		goto out_err;
> >  	}
> > @@ -191,7 +198,7 @@ static int test__perf_time_to_tsc(struct test_suite *test __maybe_unused, int su
> >  	    test_tsc >= comm2_tsc)
> >  		goto out_err;
> >  
> > -	err = 0;
> > +	err = TEST_OK;
> >  
> >  out_err:
> >  	evlist__delete(evlist);
> > @@ -200,4 +207,15 @@ static int test__perf_time_to_tsc(struct test_suite *test __maybe_unused, int su
> >  	return err;
> >  }
> >  
> > -DEFINE_SUITE("Convert perf time to TSC", perf_time_to_tsc);
> > +static struct test_case time_to_tsc_tests[] = {
> > +	TEST_CASE_REASON("TSC support", tsc_is_supported,
> > +			 "This architecture does not support"),
> > +	TEST_CASE_REASON("Perf time to TSC", perf_time_to_tsc,
> > +			 "perf_read_tsc_conversion is not supported"),
> > +	{ .name = NULL, }
> > +};
> > +
> > +struct test_suite suite__perf_time_to_tsc = {
> > +	.desc = "Convert perf time to TSC",
> > +	.test_cases = time_to_tsc_tests,
> > +};

-- 

- Arnaldo
