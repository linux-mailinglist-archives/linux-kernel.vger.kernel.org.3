Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B417A48B083
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 16:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241778AbiAKPMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 10:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbiAKPMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 10:12:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A045C06173F;
        Tue, 11 Jan 2022 07:12:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB392615F7;
        Tue, 11 Jan 2022 15:12:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD21AC36AE3;
        Tue, 11 Jan 2022 15:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641913926;
        bh=I5Qc8vbwvVy/aqgno0y7bTdjb1/0xZxYIZ9CJ8/dEkE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jm3cHJ2IYC8yoVpreoW55qBNFJM3U6rRNS3SXF3hqh9uBdae+TKd24UeBAssffL7j
         iQWsg8QGaxy2DQlwhD7qxgitqp2YGZeo+pCDqn6C2GV2Vy51K7S2PigUZVcE8AtiYu
         UProDwtygPX/u27z7Ub5TVu74+6HgOg/A7uBSiruPgfy5ewU/hmq5DjdSlMWdhJkBh
         zuKy/+USNq3R4moFRADNs1z0Sm8zNSgMIc32RW8tT24/vYr1CMn68E4e3+td1xCLGG
         S7CGBEzvbu53Sly6UBQQqPWmpqtHXpSQSZsrezLk+BpRFdVggWiz78soofbrURaFy1
         PCVuKOXgy1oYw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BA16140714; Tue, 11 Jan 2022 12:12:02 -0300 (-03)
Date:   Tue, 11 Jan 2022 12:12:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Singh <vineet.singh@intel.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, zhengjun.xing@intel.com,
        eranian@google.com
Subject: Re: [PATCH v3 06/48] perf cpumap: Switch cpu_map__build_map to cpu
 function
Message-ID: <Yd2eQiPIvEf0c42x@kernel.org>
References: <20211230072030.302559-1-irogers@google.com>
 <20211230072030.302559-8-irogers@google.com>
 <YdybPJKjqx6zb28/@kernel.org>
 <YdyfCN1/JWJtJHTO@kernel.org>
 <Ydyjvcma/wMTPwbn@kernel.org>
 <Ydymdm/PoB0hQVUT@kernel.org>
 <CAP-5=fVAa3JVbdzNZg0LrVfw__9U9Q8PkHcro+TJiFVyvTho+A@mail.gmail.com>
 <YdzSKOWJRC0dRnSn@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdzSKOWJRC0dRnSn@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 10, 2022 at 09:41:12PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Jan 10, 2022 at 02:29:58PM -0800, Ian Rogers escreveu:
> > On Mon, Jan 10, 2022 at 1:34 PM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > Em Mon, Jan 10, 2022 at 06:23:09PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > Em Mon, Jan 10, 2022 at 06:03:04PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > > Em Mon, Jan 10, 2022 at 05:46:52PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > > > At this point we need to remove the now unused perf_env__get_cpu(), and
> > > > > > then deal with the fallout in the following patches that needlessly
> > > > > > modify this unused function.
> > > > > >
> > > > > > Doing that now.
> > > > >
> > > > > Done, force pushed to tmp.perf/perf_cpu, now it is going again thru the
> > > > > build containers, a better start now:
> > >
> > > > So far so good:
> > >
> > > perf test ok, just that one that is failing, but before this series as
> > > well:
> > >
> > >  89: perf all metricgroups test                                      : FAILED!
> > 
> > Could you add the verbose output? I suspect it is fixed by this:
> > https://lore.kernel.org/lkml/20211223183948.3423989-1-irogers@google.com/
> 
> I'll try it.
> 
> BTW, here are the final tests, problems with arm 32 and 64-bit, I'll go thru
> them tomorrow, to fix in the cset the problem appears, so that we keep it
> bisectable, else you can get what I have in tmp.perf/perf_cpu, fix it and
> tomorrow I'll retest.
> 
>   27    85.67 debian:11                     : Ok   gcc (Debian 10.2.1-6) 10.2.1 20210110 , Debian clang version 11.0.1-2
>   28    98.65 debian:experimental           : Ok   gcc (Debian 11.2.0-13) 11.2.0 , Debian clang version 13.0.0-9+b2
>   29     8.69 debian:experimental-x-arm64   : FAIL gcc version 11.2.0 (Debian 11.2.0-9)
>     arch/arm64/util/pmu.c: In function 'pmu_events_map__find':
>     arch/arm64/util/pmu.c:18:35: error: invalid operands to binary != (have 'int' and 'struct perf_cpu')
>        18 |                 if (pmu->cpus->nr != cpu__max_cpu())
>           |                     ~~~~~~~~~~~~~ ^~ ~~~~~~~~~~~~~~
>           |                              |       |
>           |                              int     struct perf_cpu
>     make[5]: *** [/git/perf-5.16.0/tools/build/Makefile.build:139: util] Error 2
>     make[4]: *** [/git/perf-5.16.0/tools/build/Makefile.build:139: arm64] Error 2
>     make[3]: *** [/git/perf-5.16.0/tools/build/Makefile.build:139: arch] Error 2
>   30    19.15 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110

Fixed with the patch below squashed into 48/48 where the problem
was introduced.

tmp.perf/perf_cpu updated.

[perfbuilder@five ~]$ dm debian:experimental-x-arm64 ubuntu:16.04-x-arm ubuntu:16.04-x-arm64 ubuntu:18.04-x-arm  ubuntu:18.04-x-arm64
   1    26.08 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 11.2.0-9) 11.2.0
   2    21.68 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
   3    21.53 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
   4    61.22 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0
   5   108.41 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0
BUILD_TARBALL_HEAD=5610e6f0b9e64a02dfc906c9db9d18fd198200d9
 6 238.918
[perfbuilder@five ~]$

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 129c0272d65b8596..2e8b2c4365a0003f 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -203,9 +203,11 @@ static int cs_etm_set_option(struct auxtrace_record *itr,
 	struct perf_cpu_map *online_cpus = perf_cpu_map__new(NULL);
 
 	/* Set option of each CPU we have */
-	for (i = 0; i < cpu__max_cpu(); i++) {
-		if (!perf_cpu_map__has(event_cpus, i) ||
-		    !perf_cpu_map__has(online_cpus, i))
+	for (i = 0; i < cpu__max_cpu().cpu; i++) {
+		struct perf_cpu cpu = { .cpu = i, };
+
+		if (!perf_cpu_map__has(event_cpus, cpu) ||
+		    !perf_cpu_map__has(online_cpus, cpu))
 			continue;
 
 		if (option & BIT(ETM_OPT_CTXTID)) {
@@ -522,9 +524,11 @@ cs_etm_info_priv_size(struct auxtrace_record *itr __maybe_unused,
 
 	/* cpu map is not empty, we have specific CPUs to work with */
 	if (!perf_cpu_map__empty(event_cpus)) {
-		for (i = 0; i < cpu__max_cpu(); i++) {
-			if (!perf_cpu_map__has(event_cpus, i) ||
-			    !perf_cpu_map__has(online_cpus, i))
+		for (i = 0; i < cpu__max_cpu().cpu; i++) {
+			struct perf_cpu cpu = { .cpu = i, };
+
+			if (!perf_cpu_map__has(event_cpus, cpu) ||
+			    !perf_cpu_map__has(online_cpus, cpu))
 				continue;
 
 			if (cs_etm_is_ete(itr, i))
@@ -536,8 +540,10 @@ cs_etm_info_priv_size(struct auxtrace_record *itr __maybe_unused,
 		}
 	} else {
 		/* get configuration for all CPUs in the system */
-		for (i = 0; i < cpu__max_cpu(); i++) {
-			if (!perf_cpu_map__has(online_cpus, i))
+		for (i = 0; i < cpu__max_cpu().cpu; i++) {
+			struct perf_cpu cpu = { .cpu = i, };
+
+			if (!perf_cpu_map__has(online_cpus, cpu))
 				continue;
 
 			if (cs_etm_is_ete(itr, i))
@@ -722,8 +728,10 @@ static int cs_etm_info_fill(struct auxtrace_record *itr,
 	} else {
 		/* Make sure all specified CPUs are online */
 		for (i = 0; i < perf_cpu_map__nr(event_cpus); i++) {
-			if (perf_cpu_map__has(event_cpus, i) &&
-			    !perf_cpu_map__has(online_cpus, i))
+			struct perf_cpu cpu = { .cpu = i, };
+
+			if (perf_cpu_map__has(event_cpus, cpu) &&
+			    !perf_cpu_map__has(online_cpus, cpu))
 				return -EINVAL;
 		}
 
@@ -743,9 +751,12 @@ static int cs_etm_info_fill(struct auxtrace_record *itr,
 
 	offset = CS_ETM_SNAPSHOT + 1;
 
-	for (i = 0; i < cpu__max_cpu() && offset < priv_size; i++)
-		if (perf_cpu_map__has(cpu_map, i))
+	for (i = 0; i < cpu__max_cpu().cpu && offset < priv_size; i++) {
+		struct perf_cpu cpu = { .cpu = i, };
+
+		if (perf_cpu_map__has(cpu_map, cpu))
 			cs_etm_get_metadata(i, &offset, itr, info);
+	}
 
 	perf_cpu_map__put(online_cpus);
 
diff --git a/tools/perf/arch/arm64/util/pmu.c b/tools/perf/arch/arm64/util/pmu.c
index d3a18f9c85f6a731..79124bba713e5f0d 100644
--- a/tools/perf/arch/arm64/util/pmu.c
+++ b/tools/perf/arch/arm64/util/pmu.c
@@ -15,7 +15,7 @@ const struct pmu_events_map *pmu_events_map__find(void)
 		 * The cpumap should cover all CPUs. Otherwise, some CPUs may
 		 * not support some events or have different event IDs.
 		 */
-		if (pmu->cpus->nr != cpu__max_cpu())
+		if (pmu->cpus->nr != cpu__max_cpu().cpu)
 			return NULL;
 
 		return perf_pmu__find_map(pmu);
