Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CABC45718E2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 13:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbiGLLuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 07:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiGLLuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 07:50:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F793205A;
        Tue, 12 Jul 2022 04:50:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4458B81819;
        Tue, 12 Jul 2022 11:50:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D123C3411C;
        Tue, 12 Jul 2022 11:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657626632;
        bh=Bz9Ype+yvhBhtpW7oNpgoW9flH3NJEbZYubtc/oZzho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fw26E4NGZ6GIC01lt0vYMY0jbdkpVvl4q+0GL2iA9wT3xrkc3xNmv5fM9B8iTCmTX
         0Fd7jGnKtUb1vWq8Z/Jk7Sc6upgnXcnnWJfK7KXhvGU7w9lpgafttNwV4yrad8Q6eL
         4KUJYZBak1SWXkB9CbR5k3PAZzdzglQ5GI/WXmv1kAieRl+B8ZymzyZbLUTOOem31m
         aX09jDW5nKrClGX+jC0xZ/g5810AhxmF3Dt9uS6/tAqHWi2JDxzJ1OyEjYpMo/ohPw
         KrjnJta4gpvzoRlWgXNsmZU1zXzd/miAw7XwdFe7CiKL9qQfdCmymU7ZagHPEXoF2C
         nKhSD5LIPVcSw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A540A40088; Tue, 12 Jul 2022 08:50:29 -0300 (-03)
Date:   Tue, 12 Jul 2022 08:50:29 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 1/2] perf test: Add debug line to diagnose broken metrics
Message-ID: <Ys1gBdoqy2W51Rt+@kernel.org>
References: <20220707153449.202409-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707153449.202409-1-irogers@google.com>
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

Em Thu, Jul 07, 2022 at 08:34:48AM -0700, Ian Rogers escreveu:
> Printing out the metric name and architecture makes finding the source
> of a failure easier.

Thanks, applied both patches.

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/pmu-events.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
> index f13368569d8b..478b33825790 100644
> --- a/tools/perf/tests/pmu-events.c
> +++ b/tools/perf/tests/pmu-events.c
> @@ -1115,6 +1115,7 @@ static int test__parsing_fake(struct test_suite *test __maybe_unused,
>  				break;
>  			if (!pe->metric_expr)
>  				continue;
> +			pr_debug("Found metric '%s' for '%s'\n", pe->metric_name, map->cpuid);
>  			err = metric_parse_fake(pe->metric_expr);
>  			if (err)
>  				return err;
> -- 
> 2.37.0.rc0.161.g10f37bed90-goog

-- 

- Arnaldo
