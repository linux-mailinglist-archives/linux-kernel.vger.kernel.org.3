Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B930758EDD4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 16:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbiHJOEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 10:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbiHJOEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 10:04:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884976CF40;
        Wed, 10 Aug 2022 07:03:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0896A614A0;
        Wed, 10 Aug 2022 14:03:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321EAC433D6;
        Wed, 10 Aug 2022 14:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660140237;
        bh=1KTmBlLq0NKoIz0vQ5b4km7Q5MbjLcHiFJFmjGSEGhI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=af6tEYp02TKzXQwpYwpfpCoBYRFgDQyE5JLEUs9Ny2kjXAL6FxMeAr270X0mH3Zix
         Fd1ntoCocpigVQsEj6O2H7GACEJabLXRmZqgIZg+CpoHmX0zztiV73WDRgEP3F2SAZ
         QGuwqsQEFW5o4gfrxXQNo5Hf0zZgr1pBm/U+iPE8Na0tAyjXW3qNzR/xD/8h1a9UYg
         YV/+jvGG2eMLuqMQeT0v8j79wiRs6Rg6FifI4+D1TCSNVU6INmqacfawdAsT0NioDu
         I2+v1dcnU6iUPfk5WQL6XUOHqX21YMmda/jf/4iJtKZUm82mApIUxyGHT/+lCAmQot
         QOFM8d3LmK+1g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 18EF34035A; Wed, 10 Aug 2022 11:03:53 -0300 (-03)
Date:   Wed, 10 Aug 2022 11:03:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Claire Jensen <cjense@google.com>, Alyssa Ross <hi@alyssa.is>,
        Like Xu <likexu@tencent.com>,
        James Clark <james.clark@arm.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Claire Jensen <clairej735@gmail.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v4 2/3] perf stat: Add JSON output option
Message-ID: <YvO6yY9Cxm2km9Qq@kernel.org>
References: <20220525053814.3265216-1-irogers@google.com>
 <20220525053814.3265216-3-irogers@google.com>
 <CAM9d7cgA4fr3G7wjpaTKyEPF1JuAsQO-Ucoe9Ahd56KMz5RNBw@mail.gmail.com>
 <CAP-5=fXcskdtN_dz5jcVywq8S1=pC5TdEN25LcEXzd0Gyk+o+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXcskdtN_dz5jcVywq8S1=pC5TdEN25LcEXzd0Gyk+o+w@mail.gmail.com>
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

Em Tue, May 31, 2022 at 04:13:59PM -0700, Ian Rogers escreveu:
> On Tue, May 31, 2022 at 3:46 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hi Ian,
> >
> > On Tue, May 24, 2022 at 10:38 PM Ian Rogers <irogers@google.com> wrote:
> > >
> > > From: Claire Jensen <cjense@google.com>
> > >
> > > CSV output is tricky to format and column layout changes are susceptible
> > > to breaking parsers. New JSON-formatted output has variable names to
> > > identify fields that are consistent and informative, making
> > > the output parseable.
> > >
> > > CSV output example:
> > >
> > > 1.20,msec,task-clock:u,1204272,100.00,0.697,CPUs utilized
> > > 0,,context-switches:u,1204272,100.00,0.000,/sec
> > > 0,,cpu-migrations:u,1204272,100.00,0.000,/sec
> > > 70,,page-faults:u,1204272,100.00,58.126,K/sec
> > >
> > > JSON output example:
> > >
> > > {"counter-value" : "3805.723968", "unit" : "msec", "event" :
> > > "cpu-clock", "event-runtime" : 3805731510100.00, "pcnt-running"
> > > : 100.00, "metric-value" : 4.007571, "metric-unit" : "CPUs utilized"}
> > > {"counter-value" : "6166.000000", "unit" : "", "event" :
> > > "context-switches", "event-runtime" : 3805723045100.00, "pcnt-running"
> > > : 100.00, "metric-value" : 1.620191, "metric-unit" : "K/sec"}
> > > {"counter-value" : "466.000000", "unit" : "", "event" :
> > > "cpu-migrations", "event-runtime" : 3805727613100.00, "pcnt-running"
> > > : 100.00, "metric-value" : 122.447136, "metric-unit" : "/sec"}
> > > {"counter-value" : "208.000000", "unit" : "", "event" :
> > > "page-faults", "event-runtime" : 3805726799100.00, "pcnt-running"
> > > : 100.00, "metric-value" : 54.654516, "metric-unit" : "/sec"}
> > >
> > > Also added documentation for JSON option.
> > > There is some tidy up of CSV code including a potential memory over run
> > > in the os.nfields set up. To facilitate this an AGGR_MAX value is added.
> > >
> > > Signed-off-by: Claire Jensen <cjense@google.com>
> >
> > Your sign-off as well?
> 
> Doh:
> Signed-off-by: Ian Rogers <irogers@google.com>

Added it (b4 did it really) and also added the fixup below.

- Arnaldo

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 33e0ee9633291fd5..b82844cb0ce77845 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -35,7 +35,7 @@ static void print_running(struct perf_stat_config *config,
 		enabled_percent = 100 * run / ena;
 	if (config->json_output)
 		fprintf(config->output,
-			"\"event-runtime\" : %lu, \"pcnt-running\" : %.2f, ",
+			"\"event-runtime\" : %" PRIu64 ", \"pcnt-running\" : %.2f, ",
 			run, enabled_percent);
 	else if (config->csv_output)
 		fprintf(config->output,
