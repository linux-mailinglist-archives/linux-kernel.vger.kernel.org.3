Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 819AD5AB7B5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 19:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236697AbiIBRog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 13:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235631AbiIBRoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 13:44:34 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37686E3408;
        Fri,  2 Sep 2022 10:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662140674; x=1693676674;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qIvdGYBD3YC6tt4aOc/QdFM7ubHsW3RYHl90PZiacAY=;
  b=hYDqbwFwj2eWhyOncQ2xg736pu3Wn/bUI4d4z4ZTMLAb1sg2bsRXgowr
   m0e8hHT5/YpMxUoBEDs5CbJQXiRRjlVZWE8VsijZN6Do8gKcGuXtjo0lT
   OIY0am4d8TPFcKHN8Jsc5Ezk2ElzHq6+hswP0Joqs8r+kn7Wyen3CmSwh
   gUAdx8U+/kXD1zxwgMrY9HiyAyX78i4yMmKc+rU2c8XlLrTzOPctViuGn
   XO6Y+1wqKEgHYTyYJtJQ+NUq2anF1pMz1vzC9Q5ied2J9s2ecQMnzvI6N
   qpluVuKVs9svfX6UYOsP4zKqN0gBYVGctzvKhiLMnatuyLDTHxr8rBFRC
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="279050798"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="279050798"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 10:44:33 -0700
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="674442962"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.42.34])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 10:44:31 -0700
Message-ID: <5466ec6a-e964-ea8a-d253-f7d3d4af4ea1@intel.com>
Date:   Fri, 2 Sep 2022 20:44:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCHSET 0/5] perf tools: Show per-event lost sample count (v2)
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
References: <20220901195739.668604-1-namhyung@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220901195739.668604-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/09/22 22:57, Namhyung Kim wrote:
> Hello,
> 
> Now we have PERF_FORMAT_LOST support, add it to perf record and report so that
> it can show number of lost samples per event.  This can be useful if you want
> to reconstruct number of events from the samples like when using -c option.
> 
> Changes in v2)
>  * fix id_hdr_size calculation  (Adrian)
>  * fix a memory leak
>  * display lost samples even if no samples
>  
>  
> Currently it adds PERF_RECORD_LOST_SAMPLES at the end of perf data after reading
> event values by read(2).  The perf record unconditionally sets the lost bit if
> the kernel supports it.  Users can see the number with `perf report --stat`.
> 
> You can get the code from 'perf/report-lost-v2' brach on
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> 
> Thanks,
> Namhyung
> 
> Namhyung Kim (5):
>   perf tools: Print LOST read format in the verbose mode
>   perf record: Set PERF_FORMAT_LOST by default
>   perf record: Read and inject LOST_SAMPLES events
>   perf hist: Add nr_lost_samples to hist_stats
>   perf report: Show per-event LOST SAMPLES stat

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
