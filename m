Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9416D5A9A5D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbiIAOcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234012AbiIAOcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:32:05 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000CE6B65E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 07:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662042725; x=1693578725;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CZxbqF9/vLf49S+XBMtfozZOfHg/oLVqBFznMkTiK24=;
  b=Xv2f9hV6BhFYZ7WfWPIJ5wmJqe8vTCJZKr74S1tKHOtjmnoJ+Pj/6S/2
   Ypcl3jYxVRouUyuY19mBWHBCW+mqRWKC7jEl1bGL5EsyJmxbKlBSbuueg
   H2pU+8mgTfnnM7KsI2o4PygrL/BJdbqwEZtGJzQeEomulCFtXAgNXc5IV
   v7lm76SbRINkrtSs2Yr1CNcYSxohGRNqG2itcylNysD5v+4JmsyHs84bJ
   drAm2E4epEWLc2ZAQixYTzTuxymxKZsQA3gsXPiZ+csRIVJgiBqQ6Hkst
   OtwIPZ8u88poawANuXrZ8rUdILegb3dCUIM+QCXxXPb6bCa/N4CSvUhXl
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="294469475"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="294469475"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 07:32:04 -0700
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="589521291"
Received: from tlschnex-mobl.amr.corp.intel.com (HELO [10.212.222.1]) ([10.212.222.1])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 07:32:04 -0700
Message-ID: <dadd6179-4867-211a-ad6e-30fcd66a8e0a@linux.intel.com>
Date:   Thu, 1 Sep 2022 07:31:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 5/5] perf intel-pt: Support itrace option flag d+e to log
 on error
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org
References: <20220901110032.9226-1-adrian.hunter@intel.com>
 <20220901110032.9226-6-adrian.hunter@intel.com>
Content-Language: en-US
From:   Andi Kleen <ak@linux.intel.com>
In-Reply-To: <20220901110032.9226-6-adrian.hunter@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/1/2022 4:00 AM, Adrian Hunter wrote:
> Pass d+e option and log size via intel_pt_log_enable(). Allocate a buffer
> for log messages and provide intel_pt_log_dump_buf() to dump and reset the
> buffer upon decoder errors.
>
> Example:
>
>   $ sudo perf record -e intel_pt// sleep 1
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.094 MB perf.data ]
>   $ sudo perf config itrace.debug-log-buffer-size=300
>   $ sudo perf script --itrace=ed+e+o | head -20
>   Dumping debug log buffer (first line may be sliced)
>                                           Other
>             ffffffff96ca22f6:  48 89 e5                                        Other
>             ffffffff96ca22f9:  65 48 8b 05 ff e0 38 69                         Other
>             ffffffff96ca2301:  48 3d c0 a5 c1 98                               Other
>             ffffffff96ca2307:  74 08                                           Jcc +8
>             ffffffff96ca2311:  5d                                              Other
>             ffffffff96ca2312:  c3                                              Ret
>   ERROR: Bad RET compression (TNT=N) at 0xffffffff96ca2312
>   End of debug log buffer dump
>    instruction trace error type 1 time 15913.537143482 cpu 5 pid 36292 tid 36292 ip 0xffffffff96ca2312 code 6: Trace doesn't match instruction
>   Dumping debug log buffer (first line may be sliced)
>                                          Other
>             ffffffff96ce7fe9:  f6 47 2e 20                                     Other
>             ffffffff96ce7fed:  74 11                                           Jcc +17
>             ffffffff96ce7fef:  48 8b 87 28 0a 00 00                            Other
>             ffffffff96ce7ff6:  5d                                              Other
>             ffffffff96ce7ff7:  48 8b 40 18                                     Other
>             ffffffff96ce7ffb:  c3                                              Ret
>   ERROR: Bad RET compression (TNT=N) at 0xffffffff96ce7ffb
>   Warning:
>   8 instruction trace errors
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>   tools/perf/Documentation/perf-intel-pt.txt    |  5 +-
>   .../perf/util/intel-pt-decoder/intel-pt-log.c | 94 ++++++++++++++++++-
>   .../perf/util/intel-pt-decoder/intel-pt-log.h |  3 +-
>   tools/perf/util/intel-pt.c                    | 20 +++-
>   4 files changed, 117 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
> index d5ddb968bcf4..92464a5d7eaf 100644
> --- a/tools/perf/Documentation/perf-intel-pt.txt
> +++ b/tools/perf/Documentation/perf-intel-pt.txt
> @@ -989,10 +989,13 @@ must be preceded by either '+' or '-'. The flags support by Intel PT are:
>   
>   		-a	Suppress logging of perf events
>   		+a	Log all perf events
> +		+e	Output only on decoding errors (size configurable)
>   		+o	Output to stdout instead of "intel_pt.log"
>   
>   By default, logged perf events are filtered by any specified time ranges, but
> -flag +a overrides that.
> +flag +a overrides that.  The +e flag can be useful for analyzing errors.  By
> +default, the log size in that case is 16384 bytes, but can be altered by
> +linkperf:perf-config[1] e.g. perf config itrace.debug-log-buffer-size=30000
>   
>   In addition, the period of the "instructions" event can be specified. e.g.
>   
> diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-log.c b/tools/perf/util/intel-pt-decoder/intel-pt-log.c
> index 5f5dfc8753f3..ea96dcae187a 100644
> --- a/tools/perf/util/intel-pt-decoder/intel-pt-log.c
> +++ b/tools/perf/util/intel-pt-decoder/intel-pt-log.c
> @@ -5,12 +5,16 @@
>    */
>   
>   #include <stdio.h>
> +#include <stdlib.h>
>   #include <stdint.h>
>   #include <inttypes.h>
>   #include <stdarg.h>
>   #include <stdbool.h>
>   #include <string.h>
>   
> +#include <linux/zalloc.h>
> +#include <linux/kernel.h>
> +
>   #include "intel-pt-log.h"
>   #include "intel-pt-insn-decoder.h"
>   
> @@ -21,15 +25,20 @@
>   static FILE *f;
>   static char log_name[MAX_LOG_NAME];
>   bool intel_pt_enable_logging;
> +static bool intel_pt_dump_log_on_error;
> +static unsigned int intel_pt_log_on_error_size;
> +static struct log_buf log_buf;
>   
>   void *intel_pt_log_fp(void)
>   {
>   	return f;
>   }
>   
> -void intel_pt_log_enable(void)
> +void intel_pt_log_enable(bool dump_log_on_error, unsigned int log_on_error_size)
>   {
>   	intel_pt_enable_logging = true;
> +	intel_pt_dump_log_on_error = dump_log_on_error;
> +	intel_pt_log_on_error_size = log_on_error_size;
>   }
>   
>   void intel_pt_log_disable(void)
> @@ -74,6 +83,87 @@ static void intel_pt_print_no_data(uint64_t pos, int indent)
>   	fprintf(f, " ");
>   }
>   
> +#define DFLT_BUF_SZ	(16 * 1024)
> +
> +struct log_buf {
> +	char			*buf;
> +	size_t			buf_sz;
> +	size_t			head;
> +	bool			wrapped;
> +	FILE			*backend;
> +};
> +
> +static ssize_t log_buf__write(void *cookie, const char *buf, size_t size)
> +{
> +	struct log_buf *b = cookie;
> +	size_t sz = size;
> +
> +	if (!b->buf)
> +		return size;
> +
> +	while (sz) {
> +		size_t space = b->buf_sz - b->head;
> +		size_t n = min(space, sz);
> +
> +		memcpy(b->buf + b->head, buf, n);
> +		sz -= n;
> +		buf += n;
> +		b->head += n;
> +		if (sz && b->head >= b->buf_sz) {
> +			b->head = 0;
> +			b->wrapped = true;
> +		}
> +	}


I would add an assert or somesuch for the case where sz is larger than 
the buffer size, which would otherwise loop forever.


> +
> +static void log_buf__dump(struct log_buf *b)
> +{
> +	if (!b->buf)
> +		return;
> +
> +	fflush(f);
> +	fprintf(b->backend, "Dumping debug log buffer (first line may be sliced)\n");


Should be easy to skip the first line, no?


Rest looks good.

Reviewed-by: Andi Kleen <ak@linux.intel.com>


-Andi


