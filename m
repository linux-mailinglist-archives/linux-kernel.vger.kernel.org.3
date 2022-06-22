Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDF555440A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 10:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352351AbiFVHMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 03:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352309AbiFVHMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 03:12:43 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D494636B7D;
        Wed, 22 Jun 2022 00:12:41 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id h23so32158759ejj.12;
        Wed, 22 Jun 2022 00:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T/oBWtZlAaa1zy8Ki8EAbozaehzugDrI6LzbJis+ljU=;
        b=WbdTJTyLptfjK2P4wNF8nuDSCHfPSAn5xPfiwzVz+aYbK6GIkuhmaOR7k5ZUyMoROP
         BXXjgFhAm/o5/4vi6Dv9MfXEWh1FWwzd3QIVPJAerDKwDPjMJizSBldCrMGGeE4wQ6Ux
         mk8KKmilSFamEj4hjABc1CbAizZBdMvQCbgkkgveqPeqdLWsVt2pysWfMvQLKDQ4v1KU
         I8AIiaFBDPNMh8QLvMLR2kNxvdfw0d+3ZBt2amAZYE+Jv0xPZ2LX5Oon9qSAry4rBRSt
         dOwtH0W1XPWqBLnyKhS1u5jJGDfjJOrmOg2hLrDC9Fri/vy+yFzqI9tW8gyvj0+nQ4D1
         dlVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T/oBWtZlAaa1zy8Ki8EAbozaehzugDrI6LzbJis+ljU=;
        b=ud4FWUElviit7sxZ4WyiK/T7EpqphMrBc7sUHDi3mCQomLhWuJzmcpzoVMuZpUCXzZ
         ZTZ+5YWpcDEKYsRj7iX9jXHaRjrM7zJVCeMMd6W7XxIqbpMPxuDVMN+4YxI+zSC9VO8V
         7Y+xpz+h12nBULis+yd5ayblKcYJ4zInRcagExdbrzg+WqPoBAL6E+tQ8WBjPO/GxYnO
         jjWw7bWQOrO/3ifqNbQjh4dLPsCcDxGUiP/zqD5dtj0GAh6sV1lISAFvS8vM8xgyn6zU
         wYsdneslIWL89ONI+jsn7G++H1n/pYC/6hC7al8ixwFtvVdhkp4SOB5/zHsRmh9CSobw
         ciKA==
X-Gm-Message-State: AJIora/rHrlh8sw0b/eLbwFudwHmIU1UzGfDtli89IUV/EeALoLYYC2m
        N8t46IaUnZxQdv3kfCWQ0/I=
X-Google-Smtp-Source: AGRyM1sPFgb0jyBERMTQll2ATCZxaJopXzPAq3FNkBSe+pRdvC4nFWeW4CCS7sMYM5uPSbyGVeQDhQ==
X-Received: by 2002:a17:906:180c:b0:6fe:9a3e:3d5b with SMTP id v12-20020a170906180c00b006fe9a3e3d5bmr1744547eje.202.1655881960197;
        Wed, 22 Jun 2022 00:12:40 -0700 (PDT)
Received: from krava ([83.240.60.54])
        by smtp.gmail.com with ESMTPSA id g18-20020a17090604d200b006fec8e8eff6sm650532eja.176.2022.06.22.00.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 00:12:39 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 22 Jun 2022 09:12:36 +0200
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Felix Fietkau <nbd@nbd.name>, Qi Liu <liuqi115@huawei.com>,
        Like Xu <likexu@tencent.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
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
        Kshipra Bopardikar <kshipra.bopardikar@intel.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v6 0/4] Rewrite jevents program in python
Message-ID: <YrLA5NMBv1uIx7UD@krava>
References: <20220618000907.433350-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220618000907.433350-1-irogers@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 05:09:03PM -0700, Ian Rogers wrote:
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
>     Python 3.6. Linter issues are also fixed.The code was tested on
>     Python 3.6 and 3.8 with docker.

hi,
I'm getting test failures with this:

 10: PMU events                                                      :
 10.1: PMU event table sanity                                        : FAILED!
 10.2: PMU event map aliases                                         : FAILED!
 10.3: Parsing of PMU event table metrics                            : Ok
 10.4: Parsing of PMU event table metrics with fake PMUs             : Ok

I can see that pass without the patchset, verbose run shows:

	[jolsa@krava perf]$ sudo ./perf test -vv 'PMU event map aliases'
	 10: PMU events                                                      :
	 10.2: PMU event map aliases                                         :
	--- start ---
	test child forked, pid 272763
	Using CPUID GenuineIntel-6-8C-1
	intel_pt default config: tsc,mtc,mtc_period=3,psb_period=3,pt,branch
	could not find test events map
	testing core PMU cpu aliases: failed
	test child finished with -1
	---- end ----
	PMU events subtest 2: FAILED!
	[jolsa@krava perf]$ sudo ./perf test -vv 'PMU event table sanity'
	 10: PMU events                                                      :
	 10.1: PMU event table sanity                                        :
	--- start ---
	test child forked, pid 272771
	could not find test events map
	test child finished with -1
	---- end ----
	PMU events subtest 1: FAILED!

jirka


> v5. Adds a 2>/dev/null as suggested by David Laight
>     <David.Laight@aculab.com>.
> v4. Fixes the build for systems with python2 installed by adding a
>     patch that makes python3 the preferred python (Reported-by: John
>     Garry <john.garry@huawei.com>). It also fixes a bash-ism in the
>     jevents-test.sh and fixes the handling of an empty string for a
>     metric BriefDescription as one was added for sapphirerapids in the
>     metric Execute.
> v3. Updates the patches for merged changes (on
>     acme/tmp.perf/core). Re-runs all comparisons to make sure the
>     generated pmu-events.c isn't altered at all by this change. Adds
>     the jevents.c ExtSel fix in:
>     https://lore.kernel.org/lkml/20220525140410.1706851-1-zhengjun.xing@linux.intel.com/
>     Bumps the python version from 3.5 to 3.6, as f-strings weren't
>     introduced until 3.6.
> 
> v2. Fixes the build for architectures that don't have pmu-events json
>     (Suggested-by: John Garry <john.garry@huawei.com>) and fixes the
>     build for python not being present or too old (Suggested-by: Peter
>     Zijlstra <peterz@infradead.org>/John Garry <john.garry@huawei.com>).
> 
> Ian Rogers (4):
>   perf python: Prefer python3
>   perf jevents: Add python converter script
>   perf jevents: Switch build to use jevents.py
>   perf jevents: Remove jevents.c
> 
>  tools/perf/Makefile.config               |   27 +-
>  tools/perf/Makefile.perf                 |   16 +-
>  tools/perf/pmu-events/Build              |   15 +-
>  tools/perf/pmu-events/empty-pmu-events.c |   21 +
>  tools/perf/pmu-events/jevents.c          | 1342 ----------------------
>  tools/perf/pmu-events/jevents.py         |  409 +++++++
>  tools/perf/pmu-events/jsmn.h             |   68 --
>  tools/perf/pmu-events/json.c             |  162 ---
>  tools/perf/pmu-events/json.h             |   39 -
>  9 files changed, 465 insertions(+), 1634 deletions(-)
>  create mode 100644 tools/perf/pmu-events/empty-pmu-events.c
>  delete mode 100644 tools/perf/pmu-events/jevents.c
>  create mode 100755 tools/perf/pmu-events/jevents.py
>  delete mode 100644 tools/perf/pmu-events/jsmn.h
>  delete mode 100644 tools/perf/pmu-events/json.c
>  delete mode 100644 tools/perf/pmu-events/json.h
> 
> -- 
> 2.36.1.476.g0c4daa206d-goog
> 
