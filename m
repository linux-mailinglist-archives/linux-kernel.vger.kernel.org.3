Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B595A95A4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 13:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbiIALXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 07:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233046AbiIALXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 07:23:00 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5F1130AB5;
        Thu,  1 Sep 2022 04:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662031379; x=1693567379;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LJpwv4nmPcDFSfFd0jKborocjPGboSu89Q9vhnfXHdE=;
  b=CyczCA1V6JtMr6o7UEe7uH7fJCAA1jcQY1LeRF7DYQ39nVeIetNdwcy1
   3B7vH0UowO5DButcqWqXStdW4dYAqbygBj2ZCqHKDWX1qpwZeo6RPDNJn
   cTpWHuWpHqMtCzTsNKKrrUlh/tB4o+d0n9C3Kv920wn2U920/BIfJZ+fe
   c3+impoBa1rkvIkAgDJkVN+LFFJRo7Ra+oegrWAVbvcwF9FFZP/FOdDgD
   FvX2Gpt7D7owGNHrFfjSbtayew+uFwG43UMMJV7mzL1WNMbrBt0GiwUUW
   fN744Wh+uCVz62wIxInFxQw0H904T0GLEtkmBfIs76hc9mftoe2KGt0pf
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="357406120"
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="357406120"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 04:22:58 -0700
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="642291964"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.42.13])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 04:22:55 -0700
Message-ID: <86ca3041-3327-622c-1c23-67fc6af412f6@intel.com>
Date:   Thu, 1 Sep 2022 14:22:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 3/5] perf record: Read and inject LOST_SAMPLES events
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
References: <20220831210352.145753-1-namhyung@kernel.org>
 <20220831210352.145753-4-namhyung@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220831210352.145753-4-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/09/22 00:03, Namhyung Kim wrote:
> When there are lost samples, it can read the number of PERF_FORMAT_LOST and
> convert it to PERF_RECORD_LOST_SAMPLES and write to the data file at the end.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-record.c | 60 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index bce8c941d558..cb9881543a07 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -10,6 +10,7 @@
>  
>  #include "util/build-id.h"
>  #include <subcmd/parse-options.h>
> +#include <internal/xyarray.h>
>  #include "util/parse-events.h"
>  #include "util/config.h"
>  
> @@ -1852,6 +1853,64 @@ record__switch_output(struct record *rec, bool at_exit)
>  	return fd;
>  }
>  
> +static void __record__read_lost_samples(struct record *rec, struct evsel *evsel,
> +					struct perf_record_lost_samples *lost,
> +					int size, int cpu_idx, int thread_idx)
> +{
> +	struct perf_counts_values count;
> +	struct perf_sample_id *sid;
> +	struct perf_sample sample = {};
> +
> +	if (perf_evsel__read(&evsel->core, cpu_idx, thread_idx, &count) < 0) {
> +		pr_err("read LOST count failed\n");
> +		return;
> +	}
> +
> +	if (count.lost == 0)
> +		return;
> +
> +	lost->lost = count.lost;
> +	if (evsel->core.ids) {
> +		sid = xyarray__entry(evsel->core.sample_id, cpu_idx, thread_idx);
> +		sample.id = sid->id;
> +	}
> +
> +	perf_event__synthesize_id_sample((void *)(lost + 1),
> +					 evsel->core.attr.sample_type, &sample);

The ID sample size can vary with sample_type and is not necessarily the same as
machine->id_hdr_size.

The following might be more robust:

	id_hdr_size = perf_event__synthesize_id_sample((void *)(lost + 1), evsel->core.attr.sample_type, &sample);
	lost->header.size = sizeof(*lost) + id_hdr_size;

> +	record__write(rec, NULL, lost, size);
> +}
> +
> +static void record__read_lost_samples(struct record *rec)
> +{
> +	struct perf_session *session = rec->session;
> +	struct machine *machine = &session->machines.host;
> +	struct perf_record_lost_samples *lost;
> +	struct evsel *evsel;
> +	int size = sizeof(*lost) + machine->id_hdr_size;

  -	int size = sizeof(*lost) + machine->id_hdr_size;

> +
> +	lost = zalloc(size);

	lost = zalloc(PERF_SAMPLE_MAX_SIZE);


> +	lost->header.type = PERF_RECORD_LOST_SAMPLES;
> +	lost->header.size = size;

  -	lost->header.size = size;

> +
> +	evlist__for_each_entry(session->evlist, evsel) {
> +		struct xyarray *xy = evsel->core.sample_id;
> +
> +		if (xyarray__max_x(evsel->core.fd) != xyarray__max_x(xy) ||
> +		    xyarray__max_y(evsel->core.fd) != xyarray__max_y(xy)) {
> +			pr_debug("Unmatched FD vs. sample ID: skip reading LOST count\n");
> +			continue;
> +		}
> +
> +		for (int x = 0; x < xyarray__max_x(xy); x++) {
> +			for (int y = 0; y < xyarray__max_y(xy); y++) {
> +				__record__read_lost_samples(rec, evsel, lost,
> +							    size, x, y);
> +			}
> +		}
> +	}
> +
> +}
> +
>  static volatile int workload_exec_errno;
>  
>  /*
> @@ -2710,6 +2769,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  	if (rec->off_cpu)
>  		rec->bytes_written += off_cpu_write(rec->session);
>  
> +	record__read_lost_samples(rec);
>  	record__synthesize(rec, true);
>  	/* this will be recalculated during process_buildids() */
>  	rec->samples = 0;

