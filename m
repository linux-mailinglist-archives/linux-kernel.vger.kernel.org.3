Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEA74E3971
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 08:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237327AbiCVHPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 03:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237320AbiCVHPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 03:15:13 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB0336320;
        Tue, 22 Mar 2022 00:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647933226; x=1679469226;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Dgb3zGuH24ZT83Y0v1ZBxBUIyLa593GK3jKu3O8OKLY=;
  b=Zohx89bqCoUxP3iXPP7lTFfG41o7vOolwoM7yrrI5EUoGgjHjVFZ1nWA
   sBIyMkhDSIo26SlgMzG87PL/3URfFT+OlQDCdqQl7REUcBvoxNn5wJz3g
   lS3tsvsns3QtKq8r91+t+yPqckyu2r5oamze+sn+JZPJAEYtVFInPac19
   6CjcZhXCQ3IW7cp0sdlQtm08fj9OF5JO0dyWhDalsEjZict/dYS9r4bNt
   VXBLWkDVq5UHR8PiHhrrfMjYxsUhzZEeZ9WXmV9dVqBfA3Nys8K2y/iKx
   LZRtSRcY/5hMQAPbe3xVkUsqL+JTw4vZkgKLpcPZAFg9hE++1GZomi0ea
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="344173871"
X-IronPort-AV: E=Sophos;i="5.90,201,1643702400"; 
   d="scan'208";a="344173871"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 00:13:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,201,1643702400"; 
   d="scan'208";a="583156907"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.92]) ([10.237.72.92])
  by orsmga001.jf.intel.com with ESMTP; 22 Mar 2022 00:13:43 -0700
Message-ID: <e9126f11-177c-cc2f-7620-fdd7b3f363c0@intel.com>
Date:   Tue, 22 Mar 2022 09:13:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH v2] perf intel-pt: Synthesize cycle events
Content-Language: en-US
To:     "Steinar H. Gunderson" <sesse@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220321181447.1323742-1-sesse@google.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220321181447.1323742-1-sesse@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2022 20:14, Steinar H. Gunderson wrote:
> There is no good reason why we cannot synthesize "cycle" events
> from Intel PT just as we can synthesize "instruction" events,
> in particular when CYC packets are available. This enables using
> PT to getting much more accurate cycle profiles than regular sampling
> (record -e cycles) when the work last for very short periods (<10 ms).
> Thus, add support for this, based off of the existing IPC calculation
> framework. The new option to --itrace is "y" (for cYcles), as c was
> taken for calls. Cycle and instruction events can be synthesized
> together, and are by default.
> 
> The only real caveat is that CYC packets are only emitted whenever
> some other packet is, which in practice is when a branch instruction
> is encountered (and not even all branches). Thus, even at no subsampling
> (e.g. --itrace=y0ns), it is impossible to get more accuracy than
> a single basic block, and all cycles spent executing that block
> will get attributed to the branch instruction that ends the packet.
> Thus, one cannot know whether the cycles came from e.g. a specific load,
> a mispredicted branch, or something else. When subsampling (which
> is the default), the cycle events will get smeared out even more,
> but will still be generally useful to attribute cycle counts to functions.
> 
> Signed-off-by: Steinar H. Gunderson <sesse@google.com>
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/Documentation/itrace.txt        |  3 +-
>  tools/perf/Documentation/perf-intel-pt.txt | 36 ++++++++----
>  tools/perf/util/auxtrace.c                 |  9 ++-
>  tools/perf/util/auxtrace.h                 |  7 ++-
>  tools/perf/util/intel-pt.c                 | 68 ++++++++++++++++++++--
>  5 files changed, 102 insertions(+), 21 deletions(-)

Thanks for sending the patch.  There is one variable leftover from my
earlier suggestions - see below.

> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index e8613cbda331..364fdfe59828 100644
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c
> @@ -5,6 +5,7 @@
>   */
>  
>  #include <inttypes.h>
> +#include <linux/perf_event.h>
>  #include <stdio.h>
>  #include <stdbool.h>
>  #include <errno.h>
> @@ -89,6 +90,10 @@ struct intel_pt {
>  	u64 instructions_sample_type;
>  	u64 instructions_id;
>  
> +	bool sample_cycles;
> +	u64 cycles_sample_type;
> +	u64 cycles_id;
> +
>  	bool sample_branches;
>  	u32 branches_filter;
>  	u64 branches_sample_type;
> @@ -191,10 +196,13 @@ struct intel_pt_queue {
>  	u32 flags;
>  	u16 insn_len;
>  	u64 last_insn_cnt;
> +	u64 last_cyc_cnt;

last_cyc_cnt is an unused

>  	u64 ipc_insn_cnt;
>  	u64 ipc_cyc_cnt;
>  	u64 last_in_insn_cnt;
>  	u64 last_in_cyc_cnt;
> +	u64 last_cy_insn_cnt;
> +	u64 last_cy_cyc_cnt;
>  	u64 last_br_insn_cnt;
>  	u64 last_br_cyc_cnt;
>  	unsigned int cbr_seen;
