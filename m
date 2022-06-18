Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56DED55014A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 02:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383845AbiFRAXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 20:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236761AbiFRAXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 20:23:16 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A8E193EC;
        Fri, 17 Jun 2022 17:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655511794; x=1687047794;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YVZMZ6CuM9J6HG/7e/2qU0ngKmlhfdW6KSLvag4Nf7c=;
  b=MEhyIV39i0tjoXoPcEOVga+JtPIUZuAROIx5GIV4dFyXga2O/rONMYmw
   x4isjtnO8V4ARUB+aAcpftlqKdlUNBFbpE82AgKNwGYyOmA2jU5SuHkIf
   kTkbKbl2f6A6nqd3St8rYyMG3MQkO917vz58JwjVwxeG7epd28b1GtvA9
   9SWRMBEewLEgKnbaWQLzNdjbnxLd9lUkkTI4MzaaS0nqrMnbIEn46CKNu
   nqWBVWuEmNapun1EBBxFzOsU/dlaelIKPfsg97SUflJgnGihjawC/vbuq
   20Pa0BzVq1KT2+CJ8Bw0nlTs3NgAVyaSvhIUdXAvBR+2rAikRLXCOzW0a
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="268328903"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="268328903"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 17:23:13 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="642241041"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.249.173.113]) ([10.249.173.113])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 17:23:06 -0700
Message-ID: <d3b39b1c-7d2e-0acd-fa92-8e05a3bad1fb@linux.intel.com>
Date:   Sat, 18 Jun 2022 08:23:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v6 0/4] Rewrite jevents program in python
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Felix Fietkau <nbd@nbd.name>,
        Qi Liu <liuqi115@huawei.com>, Like Xu <likexu@tencent.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Nick Forrington <nick.forrington@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com, sandipan.das@amd.com,
        Caleb Biggers <caleb.biggers@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Kshipra Bopardikar <kshipra.bopardikar@intel.com>
Cc:     Stephane Eranian <eranian@google.com>
References: <20220618000907.433350-1-irogers@google.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
In-Reply-To: <20220618000907.433350-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On 6/18/2022 8:09 AM, Ian Rogers wrote:
> New architectures bring new complexity, such as Intel's hybrid
> models. jevents provides an alternative to specifying events in the
> kernel and exposing them through sysfs, however, it is difficult to
> work with. For example, an error in the json input would yield an
> error message but no json file or location. It is also a challenge to
> update jsmn.c given its forked nature.
> 
> The changes here switch from jevents.c to a rewrite in python called
> jevents.py. This means there is a build time dependency on python, but
> such a dependency already exists for asciidoc (used to generate perf's
> man pages). If the build detects that python isn't present or is older
> than version 3.6 (released Dec. 2016) then an empty file is
> substituted for the generated one.
> 
> A challenge with this code is in avoiding regressions. For this reason
> the jevents.py produces identical output to jevents.c, validated with a
> test script and build target.
> 
> v6. Fixes an annotation and use of removesuffix that aren't present in
>      Python 3.6. Linter issues are also fixed.The code was tested on
>      Python 3.6 and 3.8 with docker.

I just test it, now it can be built successfully with python 3.8.

> v5. Adds a 2>/dev/null as suggested by David Laight
>      <David.Laight@aculab.com>.
> v4. Fixes the build for systems with python2 installed by adding a
>      patch that makes python3 the preferred python (Reported-by: John
>      Garry <john.garry@huawei.com>). It also fixes a bash-ism in the
>      jevents-test.sh and fixes the handling of an empty string for a
>      metric BriefDescription as one was added for sapphirerapids in the
>      metric Execute.
> v3. Updates the patches for merged changes (on
>      acme/tmp.perf/core). Re-runs all comparisons to make sure the
>      generated pmu-events.c isn't altered at all by this change. Adds
>      the jevents.c ExtSel fix in:
>      https://lore.kernel.org/lkml/20220525140410.1706851-1-zhengjun.xing@linux.intel.com/
>      Bumps the python version from 3.5 to 3.6, as f-strings weren't
>      introduced until 3.6.
> 
> v2. Fixes the build for architectures that don't have pmu-events json
>      (Suggested-by: John Garry <john.garry@huawei.com>) and fixes the
>      build for python not being present or too old (Suggested-by: Peter
>      Zijlstra <peterz@infradead.org>/John Garry <john.garry@huawei.com>).
> 
> Ian Rogers (4):
>    perf python: Prefer python3
>    perf jevents: Add python converter script
>    perf jevents: Switch build to use jevents.py
>    perf jevents: Remove jevents.c
> 
>   tools/perf/Makefile.config               |   27 +-
>   tools/perf/Makefile.perf                 |   16 +-
>   tools/perf/pmu-events/Build              |   15 +-
>   tools/perf/pmu-events/empty-pmu-events.c |   21 +
>   tools/perf/pmu-events/jevents.c          | 1342 ----------------------
>   tools/perf/pmu-events/jevents.py         |  409 +++++++
>   tools/perf/pmu-events/jsmn.h             |   68 --
>   tools/perf/pmu-events/json.c             |  162 ---
>   tools/perf/pmu-events/json.h             |   39 -
>   9 files changed, 465 insertions(+), 1634 deletions(-)
>   create mode 100644 tools/perf/pmu-events/empty-pmu-events.c
>   delete mode 100644 tools/perf/pmu-events/jevents.c
>   create mode 100755 tools/perf/pmu-events/jevents.py
>   delete mode 100644 tools/perf/pmu-events/jsmn.h
>   delete mode 100644 tools/perf/pmu-events/json.c
>   delete mode 100644 tools/perf/pmu-events/json.h
> 

-- 
Zhengjun Xing
