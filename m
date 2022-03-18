Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA924DDBA5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 15:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237231AbiCRO3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 10:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236878AbiCRO3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 10:29:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7BD108F;
        Fri, 18 Mar 2022 07:28:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5774361A05;
        Fri, 18 Mar 2022 14:28:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FA08C340E8;
        Fri, 18 Mar 2022 14:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647613698;
        bh=EfCCn6hH8JAtyHAXhm+QKRSYBOclLCPgWjSBNZ1qSFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lZtbMiymJvCoKKwO5Rz06UaDHKL2bxrReiCfZIM04OGHST93Rj205QI1ppxZ02Lkw
         cJAQUq0i1ch0TM5bj9eNzPXh2nSM9cCT5KJ4+32GRRKG/ipt4eAkXGNCgISJ371qBO
         dfi/+Ik+DOH+D8Pud+OSiFWkUiaNNjYKVqsbIEg+KMJ3FZH90QFli0Ytz11Yeco5rB
         DQhBvvx3vuCPUsG+oYIgeg4x4ZNPyDagKDidkY1ZZYwaop3DUIzCVIUnlEK3wQndAK
         kiGI0KaImI+/rj5j9Jygxm3MilksbeMK2rIP4tapZhRx4NyyMwF+rlKXLgqTesIxa1
         mBy2ZfdfdFy7g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6A96340407; Fri, 18 Mar 2022 11:28:16 -0300 (-03)
Date:   Fri, 18 Mar 2022 11:28:16 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        Caleb Biggers <caleb.biggers@intel.com>
Subject: Re: [PATCH] perf parse-events: Ignore case in topdown.slots check
Message-ID: <YjSXAFDJDbrPao6d@kernel.org>
References: <20220317224309.543736-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317224309.543736-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 17, 2022 at 03:43:09PM -0700, Ian Rogers escreveu:
> An issue with icelakex metrics:
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json?h=perf/core&id=65eab2bc7dab326ee892ec5a4c749470b368b51a#n48
> That causes the slots not to be first.

Thanks, applied.

- Arnaldo

 
> Fixes: 94dbfd6781a0 ("perf parse-events: Architecture specific leader override")
> Reported-by: Caleb Biggers <caleb.biggers@intel.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/arch/x86/util/evlist.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
> index f924246eff78..8d9b55959256 100644
> --- a/tools/perf/arch/x86/util/evlist.c
> +++ b/tools/perf/arch/x86/util/evlist.c
> @@ -29,7 +29,7 @@ struct evsel *arch_evlist__leader(struct list_head *list)
>  
>  	__evlist__for_each_entry(list, evsel) {
>  		if (evsel->pmu_name && !strcmp(evsel->pmu_name, "cpu") &&
> -			evsel->name && strstr(evsel->name, "slots"))
> +			evsel->name && strcasestr(evsel->name, "slots"))
>  			return evsel;
>  	}
>  	return first;
> -- 
> 2.35.1.894.gb6a874cedc-goog

-- 

- Arnaldo
