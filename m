Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656F959E89C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343861AbiHWRHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344509AbiHWRFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:05:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF3F151422;
        Tue, 23 Aug 2022 06:34:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9F04B81D63;
        Tue, 23 Aug 2022 13:34:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85250C433D6;
        Tue, 23 Aug 2022 13:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661261665;
        bh=BJ7Rg49eR0G7P7lgLM1TFnK6mbu8N114hwyTrcEWg2Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E27pXfPA740voGk5FfEbycGgfLATrixU1QTQHOI6tg8+PY1PM32eqTgKzkS5wJuPX
         Xmjg+HI6+eYX0fkj9T+IOAYw3N9LYkJgiii5TEOp6QxGPRZMT3MKljWTNKUlcJdt6u
         PJm5Qjs881niM/gIG/wwqo7jK07DeWLpqi0nxbRqn041xAvpQFhJ1DCBCoK65mBHyc
         +3tI/jIgZkEvf2tnbL+7C+oPk9cAkevJy3ZQsAqbDfrxPjR4qLz66YePw/iYNKOH/Z
         U+pJKWaV0yYopTLzP6U8s2v/RHHrlgEKCLSsYHASiCrHQIBag6h77yowkR7s+GVvw6
         k/IwPys/9JU3w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EADBE404A1; Tue, 23 Aug 2022 10:34:22 -0300 (-03)
Date:   Tue, 23 Aug 2022 10:34:22 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v1 1/2] perf stat: Clear reset_group for each stat run
Message-ID: <YwTXXhVHeYAcXWmO@kernel.org>
References: <20220822213352.75721-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822213352.75721-1-irogers@google.com>
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

Em Mon, Aug 22, 2022 at 02:33:51PM -0700, Ian Rogers escreveu:
> If a weak group is broken then the reset_group flag remains set for
> the next run. Having reset_group set means the counter isn't created
> and ultimately a segfault.
> 
> A simple reproduction of this is:
> perf stat -r2 -e '{cycles,cycles,cycles,cycles,cycles,cycles,cycles,cycles,cycles,cycles}:W
> which will be added as a test in the next patch.

So doing this on that existing BPF related loop may solve the problem,
but for someone looking just at the source code, without any comment,
may be cryptic, no?

And then the fixes tags talks about affinity, adding a bit more
confusion, albeit being the part that does the weak logic :-\

Can we have a comment just before:

+             counter->reset_group = false;

Stating that this is needed only when using -r?

- Arnaldo
 
> Fixes: 4804e0111662 ("perf stat: Use affinity for opening events")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-stat.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 7fb81a44672d..54cd29d07ca8 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -826,6 +826,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  	}
>  
>  	evlist__for_each_entry(evsel_list, counter) {
> +		counter->reset_group = false;
>  		if (bpf_counter__load(counter, &target))
>  			return -1;
>  		if (!evsel__is_bpf(counter))
> -- 
> 2.37.2.609.g9ff673ca1a-goog

-- 

- Arnaldo
