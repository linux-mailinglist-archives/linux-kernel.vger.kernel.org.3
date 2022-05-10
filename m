Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7CBD5222ED
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 19:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348321AbiEJRnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 13:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245615AbiEJRnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:43:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAE52764D2;
        Tue, 10 May 2022 10:39:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5B1B619E2;
        Tue, 10 May 2022 17:39:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1EDAC385A6;
        Tue, 10 May 2022 17:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652204358;
        bh=cpGX1kgRy3el9acV31jAE9GzbuFSlL1gBzdae8nD62I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vMvrTdgU9As8GpHkd4gSyW+f0NV7kjDPvAMFPdLV7HI2a70KGkYNieWz0su6D0oxZ
         4OZOgkNt6xTFX+i2jEswPW5kAxqkUXuyxHrFSWb/K1gyQAVaEm8w3gXs4ydSfXJGBE
         GVlP9CBymHgdFkF4/OWYOu3dC7nSUzvh0WbmeyIYAI7rgaHwSnlM5CeAQv1XL5qQvj
         rO/gPYQlf0rTJQXpdvjTvkMyskqfRmm7afbz20GTwQQHcTjONqZZwgl/M8TnL9RO8S
         MFuhcvU/HVPy45tNmaXJS0BiJx136K8GRrolB82foWpZuJiD3DXsQMpHt06kvnYyIn
         APJb4NK1GPAlQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EFF16400B1; Tue, 10 May 2022 14:39:14 -0300 (-03)
Date:   Tue, 10 May 2022 14:39:14 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf annotate: Add --percent-limit option
Message-ID: <YnqjQmgXebK4itXj@kernel.org>
References: <20220502232015.697243-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502232015.697243-1-namhyung@kernel.org>
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

Em Mon, May 02, 2022 at 04:20:15PM -0700, Namhyung Kim escreveu:
> Like in perf report and perf top, Add this option to limit the number
> of functions it displays based on the overhead value in percent.
> 
> This affects only stdio and stdio2 output modes.  Without this, it
> shows very long disassembly lines for every function in the data
> file.  If users don't want this behavior, they can set a value in
> percent to suppress that.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/Documentation/perf-annotate.txt |  5 +++++
>  tools/perf/builtin-annotate.c              | 24 ++++++++++++++++++++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-annotate.txt b/tools/perf/Documentation/perf-annotate.txt
> index 33c2521cba4a..18fcc52809fb 100644
> --- a/tools/perf/Documentation/perf-annotate.txt
> +++ b/tools/perf/Documentation/perf-annotate.txt
> @@ -147,6 +147,11 @@ include::itrace.txt[]
>  	The period/hits keywords set the base the percentage is computed
>  	on - the samples period or the number of samples (hits).
>  
> +--percent-limit::
> +	Do not show functions which have an overhead under that percent on
> +	stdio or stdio2 (Default: 0).  Note that this is about selection of
> +	functions to display, not about lines within the function.
> +
>  SEE ALSO
>  --------
>  linkperf:perf-record[1], linkperf:perf-report[1]
> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> index e65dc380be15..2ffe071dbcff 100644
> --- a/tools/perf/builtin-annotate.c
> +++ b/tools/perf/builtin-annotate.c
> @@ -54,6 +54,7 @@ struct perf_annotate {
>  	bool	   skip_missing;
>  	bool	   has_br_stack;
>  	bool	   group_set;
> +	float	   min_percent;
>  	const char *sym_hist_filter;
>  	const char *cpu_list;
>  	DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
> @@ -324,6 +325,17 @@ static void hists__find_annotations(struct hists *hists,
>  		    (strcmp(he->ms.sym->name, ann->sym_hist_filter) != 0))
>  			goto find_next;
>  
> +		if (ann->min_percent) {
> +			float percent = 0;
> +			u64 total = hists__total_period(hists);
> +
> +			if (total)
> +				percent = 100.0 * he->stat.period / total;
> +
> +			if (percent < ann->min_percent)
> +				goto find_next;
> +		}
> +
>  		notes = symbol__annotation(he->ms.sym);
>  		if (notes->src == NULL) {
>  find_next:
> @@ -457,6 +469,16 @@ static int __cmd_annotate(struct perf_annotate *ann)
>  	return ret;
>  }
>  
> +static int parse_percent_limit(const struct option *opt, const char *str,
> +			       int unset __maybe_unused)
> +{
> +	struct perf_annotate *ann = opt->value;
> +	double pcnt = strtof(str, NULL);
> +
> +	ann->min_percent = pcnt;
> +	return 0;
> +}
> +
>  static const char * const annotate_usage[] = {
>  	"perf annotate [<options>]",
>  	NULL
> @@ -557,6 +579,8 @@ int cmd_annotate(int argc, const char **argv)
>  	OPT_CALLBACK(0, "percent-type", &annotate.opts, "local-period",
>  		     "Set percent type local/global-period/hits",
>  		     annotate_parse_percent_type),
> +	OPT_CALLBACK(0, "percent-limit", &annotate, "percent",
> +		     "Don't show entries under that percent", parse_percent_limit),
>  	OPT_CALLBACK_OPTARG(0, "itrace", &itrace_synth_opts, NULL, "opts",
>  			    "Instruction Tracing options\n" ITRACE_HELP,
>  			    itrace_parse_synth_opts),
> -- 
> 2.36.0.464.gb9c8b46e94-goog

-- 

- Arnaldo
