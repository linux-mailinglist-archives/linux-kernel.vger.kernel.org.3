Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A49A5475DA5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244592AbhLOQhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:37:54 -0500
Received: from foss.arm.com ([217.140.110.172]:57304 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230350AbhLOQhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:37:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A94886D;
        Wed, 15 Dec 2021 08:37:52 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.67.176])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A283E3F5A1;
        Wed, 15 Dec 2021 08:37:50 -0800 (PST)
Date:   Wed, 15 Dec 2021 16:37:47 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     German Gomez <german.gomez@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, Alexandre Truong <alexandre.truong@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 4/6] perf tools: enable dwarf_callchain_users on arm64
Message-ID: <YboZ24EMD/4lVkyp@FVFF77S0Q05N>
References: <20211215151139.40854-1-german.gomez@arm.com>
 <20211215151139.40854-5-german.gomez@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215151139.40854-5-german.gomez@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 03:11:36PM +0000, German Gomez wrote:
> From: Alexandre Truong <alexandre.truong@arm.com>
> 
> On arm64, enable dwarf_callchain_users which will be needed
> to do a dwarf unwind in order to get the caller of the leaf frame.
> 
> Signed-off-by: Alexandre Truong <alexandre.truong@arm.com>
> Signed-off-by: German Gomez <german.gomez@arm.com>
> ---
>  tools/perf/builtin-report.c | 4 ++--
>  tools/perf/builtin-script.c | 4 ++--
>  tools/perf/util/callchain.c | 9 ++++++++-
>  tools/perf/util/callchain.h | 2 +-
>  4 files changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 8167ebfe776a..a31ad60ba66e 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -410,7 +410,7 @@ static int report__setup_sample_type(struct report *rep)
>  		}
>  	}
>  
> -	callchain_param_setup(sample_type);
> +	callchain_param_setup(sample_type, perf_env__arch(&rep->session->header.env));
>  
>  	if (rep->stitch_lbr && (callchain_param.record_mode != CALLCHAIN_LBR)) {
>  		ui__warning("Can't find LBR callchain. Switch off --stitch-lbr.\n"
> @@ -1124,7 +1124,7 @@ static int process_attr(struct perf_tool *tool __maybe_unused,
>  	 * on events sample_type.
>  	 */
>  	sample_type = evlist__combined_sample_type(*pevlist);
> -	callchain_param_setup(sample_type);
> +	callchain_param_setup(sample_type, perf_env__arch((*pevlist)->env));
>  	return 0;
>  }
>  
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index ab7d575f97f2..d308adfd1176 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -2318,7 +2318,7 @@ static int process_attr(struct perf_tool *tool, union perf_event *event,
>  	 * on events sample_type.
>  	 */
>  	sample_type = evlist__combined_sample_type(evlist);
> -	callchain_param_setup(sample_type);
> +	callchain_param_setup(sample_type, perf_env__arch((*pevlist)->env));
>  
>  	/* Enable fields for callchain entries */
>  	if (symbol_conf.use_callchain &&
> @@ -3468,7 +3468,7 @@ static void script__setup_sample_type(struct perf_script *script)
>  	struct perf_session *session = script->session;
>  	u64 sample_type = evlist__combined_sample_type(session->evlist);
>  
> -	callchain_param_setup(sample_type);
> +	callchain_param_setup(sample_type, perf_env__arch(session->machines.host.env));
>  
>  	if (script->stitch_lbr && (callchain_param.record_mode != CALLCHAIN_LBR)) {
>  		pr_warning("Can't find LBR callchain. Switch off --stitch-lbr.\n"
> diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> index 8e2777133bd9..aaab9a674807 100644
> --- a/tools/perf/util/callchain.c
> +++ b/tools/perf/util/callchain.c
> @@ -1600,7 +1600,7 @@ void callchain_cursor_reset(struct callchain_cursor *cursor)
>  		map__zput(node->ms.map);
>  }
>  
> -void callchain_param_setup(u64 sample_type)
> +void callchain_param_setup(u64 sample_type, const char *arch)
>  {
>  	if (symbol_conf.use_callchain || symbol_conf.cumulate_callchain) {
>  		if ((sample_type & PERF_SAMPLE_REGS_USER) &&
> @@ -1612,6 +1612,13 @@ void callchain_param_setup(u64 sample_type)
>  		else
>  			callchain_param.record_mode = CALLCHAIN_FP;
>  	}
> +
> +	/*
> +	 * It's possible to determine the caller of leaf frames with omitted
> +	 * frame pointers on aarch64 using libunwind, so enable it.
> +	 */

I reckon it's worth mentioning *why* we need to do this; how about:

	/*
	 * It's necessary to use libunwind to reliably determine the caller of
	 * a leaf function on aarch64, as otherwise we cannot know whether to
	 * start from the LR or FP.
	 *
	 * Always starting from the LR can result in duplicate or entirely
	 * erroneous entries. Always skipping the LR and starting from the FP
	 * can result in missing entries.
	 */

Other than that, this looks fine to me!

Thanks,
Mark.

> +	if (callchain_param.record_mode == CALLCHAIN_FP && !strcmp(arch, "arm64"))
> +		dwarf_callchain_users = true;
>  }
>  
>  static bool chain_match(struct callchain_list *base_chain,
> diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
> index 77fba053c677..d95615daed73 100644
> --- a/tools/perf/util/callchain.h
> +++ b/tools/perf/util/callchain.h
> @@ -300,7 +300,7 @@ int callchain_branch_counts(struct callchain_root *root,
>  			    u64 *branch_count, u64 *predicted_count,
>  			    u64 *abort_count, u64 *cycles_count);
>  
> -void callchain_param_setup(u64 sample_type);
> +void callchain_param_setup(u64 sample_type, const char *arch);
>  
>  bool callchain_cnode_matched(struct callchain_node *base_cnode,
>  			     struct callchain_node *pair_cnode);
> -- 
> 2.25.1
> 
