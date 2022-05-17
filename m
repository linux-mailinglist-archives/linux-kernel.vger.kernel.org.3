Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00DBC52A58D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 17:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349538AbiEQPDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 11:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243507AbiEQPDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 11:03:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BF96410;
        Tue, 17 May 2022 08:03:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DBECDB818FF;
        Tue, 17 May 2022 15:03:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 630F4C385B8;
        Tue, 17 May 2022 15:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652799793;
        bh=byrQErYFQlhTfmVu1YurdHSZ08z5LZgcXvlnYcs4SNQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PfOhPDT8JZh+i0Zzmvh43u+bFH15pqQHxC336x4IG8IhA0fOYeHf7sozb4ZDErIe4
         +BuRy6sTNNOHxYJAJJP/LF6A6UqAPJxrmZxVSmV5EoQpTLODj+ITlUA0yS9YOPcuUF
         vEcEEQlHoIxpS/HGtKxEILNFjDVjqYYaweWKzVg7yQMb/vE7lMhuYl+ehVfAi/gkaH
         T+LWH1Ze8q2tUdEGk41szWe12+t9IMlcBTxH75eEMAZTm8NO76MIdiko3l0yGiPAb4
         jXkliKItJblCTFEjnuPzGqGca7eZMhXtIniJZKFv9uBhhYKAPdNkKgWX7Rd4yat+rc
         MiiVMevf0KThA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 07C8F400B1; Tue, 17 May 2022 12:03:10 -0300 (-03)
Date:   Tue, 17 May 2022 12:03:10 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v3 0/2] Fix topdown event weak grouping
Message-ID: <YoO5Lp1UHMowHLmH@kernel.org>
References: <20220517052724.283874-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517052724.283874-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, May 16, 2022 at 10:27:22PM -0700, Ian Rogers escreveu:
> Keep topdown events within a group when a weak group is broken. This
> is a requirement as topdown events must form a group.
> 
> Add perf stat testing including for required topdown event group
> behaviors.
> 
> Note: as with existing topdown evsel/evlist code topdown events are
> assumed to be on the PMU "cpu". On Alderlake the PMU "cpu_core" should
> also be tested. Future changes can fix Alderlake.

Thanks, applied.

- Arnaldo

 
> v3. Fix computation of number of events in leader's group.
>     Adds reviewed-by: Liang, Kan <kan.liang@linux.intel.com
> v2. Correct behavior wrt pmu prefixed events and avoid the test using
>     deprecated events: Suggested-by: Liang, Kan <kan.liang@linux.intel.com>
> 
> Ian Rogers (2):
>   perf evlist: Keep topdown counters in weak group
>   perf test: Add basic stat and topdown group test
> 
>  tools/perf/arch/x86/util/evsel.c | 12 ++++++
>  tools/perf/tests/shell/stat.sh   | 67 ++++++++++++++++++++++++++++++++
>  tools/perf/util/evlist.c         | 16 +++++++-
>  tools/perf/util/evsel.c          | 10 +++++
>  tools/perf/util/evsel.h          |  3 ++
>  5 files changed, 106 insertions(+), 2 deletions(-)
>  create mode 100755 tools/perf/tests/shell/stat.sh
> 
> -- 
> 2.36.0.550.gb090851708-goog

-- 

- Arnaldo
