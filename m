Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9E149838A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 16:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240850AbiAXPaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 10:30:22 -0500
Received: from foss.arm.com ([217.140.110.172]:37896 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240713AbiAXPaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 10:30:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 949CD6D;
        Mon, 24 Jan 2022 07:30:20 -0800 (PST)
Received: from [10.57.39.131] (unknown [10.57.39.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 915183F7D8;
        Mon, 24 Jan 2022 07:30:18 -0800 (PST)
Subject: Re: [PATCH] perf session: check for null pointer before derefernce
To:     Ameer Hamza <amhamza.mgc@gmail.com>,
        German Gomez <german.gomez@arm.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        rickyman7@gmail.com, alexey.v.bayduraev@linux.intel.com,
        adrian.hunter@intel.com, leo.yan@linaro.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
References: <20220124150001.93145-1-amhamza.mgc@gmail.com>
From:   James Clark <james.clark@arm.com>
Message-ID: <7c068167-e8bb-74f3-97d9-dd0c5858ee19@arm.com>
Date:   Mon, 24 Jan 2022 15:30:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220124150001.93145-1-amhamza.mgc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/01/2022 15:00, Ameer Hamza wrote:
> Move null pointer check before dereferncing the variable
> 
> Addresses-Coverity: 1497622 ("Derereference before null check")
> 
> Signed-off-by: Ameer Hamza <amhamza.mgc@gmail.com>
> ---
>  tools/perf/util/session.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index f19348dddd55..e1014ab62c10 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1503,11 +1503,11 @@ static int machines__deliver_event(struct machines *machines,
>  			++evlist->stats.nr_unknown_id;
>  			return 0;
>  		}
> -		dump_sample(evsel, event, sample, perf_env__arch(machine->env));
>  		if (machine == NULL) {
>  			++evlist->stats.nr_unprocessable_samples;
>  			return 0;
>  		}
> +		dump_sample(evsel, event, sample, perf_env__arch(machine->env));
>  		return evlist__deliver_sample(evlist, tool, event, sample, evsel, machine);
>  	case PERF_RECORD_MMAP:
>  		return tool->mmap(tool, event, sample, machine);
> 

Hi Ameer,

This mistake was made recently, but I don't think your change is the desired behavior.

It should be possible to dump stuff if machine is null. null or an empty string
should be passed to dump_sample(). It looks like some of the printfs still attempt to
show something in this case, although I didn't check them all.

James
