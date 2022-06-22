Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661FB55445A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 10:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352974AbiFVHg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 03:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352299AbiFVHg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 03:36:56 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB7937038;
        Wed, 22 Jun 2022 00:36:54 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id v1so32254331ejg.13;
        Wed, 22 Jun 2022 00:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Wi0CQ/UGQQa8acXiq8dwtuqTzl9sInEfXQBc7BMoppw=;
        b=DqrcfCmBLC0Ke+WEOWgvjXumJE7blXqIJgqHBH7e5uC+iHuDPSQ8kp4nc9Zzs9Qfi5
         ZHLdvM9PgZhyokyuvQk6EBFjQmHmGd98Bl6xErf0j+rND/uiYkFZydxiU0cZE/9HpGLp
         nbajezoUf1Xsm1IE403wDXnok7ijrF8mbm+dhRrgs0/l616YocyoD4PdHkHSxRVigO4J
         pbJQV1bYzrutFyMk63IvBaA0tynoD2ci/OQebj3MLS9nsQykGglRSWcK/STDxb8SX929
         Q+/BUfS0cc/uoU1nPjZJEQyxStbdfpzzGrosDR00Qkn94giNUUq4ZK1oT9dDVE1PO3BI
         12iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wi0CQ/UGQQa8acXiq8dwtuqTzl9sInEfXQBc7BMoppw=;
        b=oSTCUI8t0/pUJY1S3C6ncid/lm6JcFOK6bughEldpMDYi805rxPawQUop8FO6a/aCP
         44pS4XpTC/HHv6Xpyq58FvNj2VLIKjpS80KENgUFmZVz1g1dqaCHhLZbcfIV7pZUTHai
         pIPB10sCKfcdKM+u0PQpUiBWaFdeeWsw4nGQ+0qAH6rqjfXqgCiccjzsOZSLzS4QOLWd
         GV67aOSIefu8B1HFb3CF+AywVN9oW1+SbE0OlMNJ01d1Gt20cHHz43BkCMBUYN5851+P
         qE3MAY9yqUbx/uuDTsMAf7aWUuyp0PMuvtIgdIzdl3lD04EJhRR6HJHoAQEeawxhwws+
         u8Dg==
X-Gm-Message-State: AJIora/SYUIHB6tO4EPsuoFE2pJczmCJayTn9nj849rlH22UTRCGQybW
        iLi+gB89Hgf1Y5gopCosQAM=
X-Google-Smtp-Source: AGRyM1u2AcyiwmXFX1qnKFR0vamIGSdZGUt9vwlSs+rmTCuno7vG9j/9ZiKwM3GC/xJLbrxL2Fqing==
X-Received: by 2002:a17:906:5187:b0:712:477:df9b with SMTP id y7-20020a170906518700b007120477df9bmr1847867ejk.424.1655883413335;
        Wed, 22 Jun 2022 00:36:53 -0700 (PDT)
Received: from krava ([83.240.60.54])
        by smtp.gmail.com with ESMTPSA id qn25-20020a170907211900b00722e49c06e8sm2238289ejb.216.2022.06.22.00.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 00:36:53 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 22 Jun 2022 09:36:50 +0200
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
Message-ID: <YrLGkqDMVidTtFMG@krava>
References: <20220618000907.433350-1-irogers@google.com>
 <YrLA5NMBv1uIx7UD@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrLA5NMBv1uIx7UD@krava>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 09:12:40AM +0200, Jiri Olsa wrote:
> On Fri, Jun 17, 2022 at 05:09:03PM -0700, Ian Rogers wrote:
> > New architectures bring new complexity, such as Intel's hybrid
> > models. jevents provides an alternative to specifying events in the
> > kernel and exposing them through sysfs, however, it is difficult to
> > work with. For example, an error in the json input would yield an
> > error message but no json file or location. It is also a challenge to
> > update jsmn.c given its forked nature.
> > 
> > The changes here switch from jevents.c to a rewrite in python called
> > jevents.py. This means there is a build time dependency on python, but
> > such a dependency already exists for asciidoc (used to generate perf's
> > man pages). If the build detects that python isn't present or is older
> > than version 3.6 (released Dec. 2016) then an empty file is
> > substituted for the generated one.
> > 
> > A challenge with this code is in avoiding regressions. For this reason
> > the jevents.py produces identical output to jevents.c, validated with a
> > test script and build target.
> > 
> > v6. Fixes an annotation and use of removesuffix that aren't present in
> >     Python 3.6. Linter issues are also fixed.The code was tested on
> >     Python 3.6 and 3.8 with docker.
> 
> hi,
> I'm getting test failures with this:
> 
>  10: PMU events                                                      :
>  10.1: PMU event table sanity                                        : FAILED!
>  10.2: PMU event map aliases                                         : FAILED!
>  10.3: Parsing of PMU event table metrics                            : Ok
>  10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
> 
> I can see that pass without the patchset, verbose run shows:
> 
> 	[jolsa@krava perf]$ sudo ./perf test -vv 'PMU event map aliases'
> 	 10: PMU events                                                      :
> 	 10.2: PMU event map aliases                                         :
> 	--- start ---
> 	test child forked, pid 272763
> 	Using CPUID GenuineIntel-6-8C-1
> 	intel_pt default config: tsc,mtc,mtc_period=3,psb_period=3,pt,branch
> 	could not find test events map
> 	testing core PMU cpu aliases: failed
> 	test child finished with -1
> 	---- end ----
> 	PMU events subtest 2: FAILED!
> 	[jolsa@krava perf]$ sudo ./perf test -vv 'PMU event table sanity'
> 	 10: PMU events                                                      :
> 	 10.1: PMU event table sanity                                        :
> 	--- start ---
> 	test child forked, pid 272771
> 	could not find test events map
> 	test child finished with -1
> 	---- end ----
> 	PMU events subtest 1: FAILED!

ah, ok I did not notice:

Makefile.config:909: Python interpreter too old (older than 3.6) disabling jevent generation

I installed python3-devel and it's ok

should we make above tests SKIP in case there's empty pmu-events.c ?

thanks,
jirka
