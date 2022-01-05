Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A1F4856F7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 18:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242087AbiAERAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 12:00:12 -0500
Received: from foss.arm.com ([217.140.110.172]:45960 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242066AbiAERAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 12:00:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6CB6311D4;
        Wed,  5 Jan 2022 09:00:03 -0800 (PST)
Received: from [10.57.37.41] (unknown [10.57.37.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9FBF33F774;
        Wed,  5 Jan 2022 09:00:00 -0800 (PST)
Message-ID: <6ba550d1-61bc-e229-2a64-331cfa59c388@arm.com>
Date:   Wed, 5 Jan 2022 16:58:42 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC PATCH 1/1] perf arm64: Implement --topdown with metrics
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Cc:     Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <4c375d34-bf20-496d-22fc-aed8597126e2@huawei.com>
 <20211214184240.24215-1-andrew.kilroy@arm.com>
 <20211214184240.24215-2-andrew.kilroy@arm.com>
 <48437bee-9c39-38ba-e990-ba9a6a5378b4@huawei.com>
From:   Andrew Kilroy <andrew.kilroy@arm.com>
In-Reply-To: <48437bee-9c39-38ba-e990-ba9a6a5378b4@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/12/2021 10:19, John Garry wrote:
> 
> And there is no colouring for results which are above/below standard 
> thresholds (see stat-shadow.c:get_radio_color()).
> 
> My impression is that we're not plugging the results from 
> metricgroup__parse_groups_to_evlist() into the --topdown print 
> functionality properly.
> 

The --topdown kernel event colouring is dictated by a large if-else 
statement in stat-shadow.c:perf_stat__print_shadow_stats.

There are branches depending on what is returned by 
perf_stat_evsel__is() for example

	} else if (perf_stat_evsel__is(evsel, TOPDOWN_FETCH_BUBBLES)) {
		double fe_bound = td_fe_bound(cpu, st, &rsd);

		if (fe_bound > 0.2)
			color = PERF_COLOR_RED;
		print_metric(config, ctxp, color, "%8.1f%%", "frontend bound",
				fe_bound * 100.);
	} else if (perf_stat_evsel__is(evsel, TOPDOWN_SLOTS_RETIRED)) {



Because the patches are enabling metrics (equivalent of the -M 
'somemetricname' option), the perf_stat__print_shadow_stats function 
always makes calls to generic_metric(), where colours are never picked.

Seeing thresholds like:

   retiring > 0.7
   fe_bound > 0.2
   be_bound > 0.2
   bad_spec > 0.1


I'm not sure about adding the colouring really.  Are these thresholds 
x86 specific?


> Thanks,
> John


Andrew
