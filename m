Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E2E527DDA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 08:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240549AbiEPGwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 02:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240499AbiEPGwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 02:52:13 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0646369D1;
        Sun, 15 May 2022 23:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652683922; x=1684219922;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=vw6BYvIf0wDELIwK68I+roROejnu+MWgmdvMsOj975M=;
  b=N2anzz6Q4SpFrXiPiPQFV/xwHpQM+00O9Q6H8krDz789qZ0o7v1+vd3a
   yNc8XvMGosauwWm95dc54/kZ2Jiz8BQt3TOZkmdLNyDG5xwYcvYTf9HAg
   wPGfAm2B5z4pr7kxRhhz357WqOGXZjTwWCuwDpxDXLpB9FTLSG2DzdkHC
   gabDzrX1OxYtLjJIT/SwRks1Ohmvg85Y/rK8VNQYRJagKXXzXGUBC2kod
   Y0Q7nTjpaVq5T8bSWoHiUjro40Y6r9htJoKauPArOdITuHNsE0YPIsWIg
   K0HPohqaHfK9lTLxrQ5WdgmWAf+iBaSNEKNDBBk4mpoKXZzVnPRxbRCJU
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10348"; a="331374738"
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; 
   d="scan'208";a="331374738"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2022 23:52:00 -0700
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; 
   d="scan'208";a="596378031"
Received: from rhudecze-mobl.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.36.15])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2022 23:51:54 -0700
Message-ID: <afa9a665-5f6f-5ac8-f4a7-cdf2df5c20ae@intel.com>
Date:   Mon, 16 May 2022 09:51:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Subject: Re: [PATCH v5 1/2] perf scripting python: Expose dso and map
 information
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Tanmay Jagdale <tanmay@marvell.com>,
        "zengshun . wu" <zengshun.wu@outlook.com>,
        Al Grant <al.grant@arm.com>, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20220515071838.3077178-1-leo.yan@linaro.org>
 <20220515071838.3077178-2-leo.yan@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220515071838.3077178-2-leo.yan@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/22 10:18, Leo Yan wrote:
> This change adds dso build_id and corresponding map's start and end
> address.  The info of dso build_id can be used to find dso file path,
> and we can validate if a branch address falls into the range of map's
> start and end addresses.
> 
> In addition, the map's start address can be used as an offset for
> disassembly.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  .../scripting-engines/trace-event-python.c    | 21 +++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
> index 659eb4e4b34b..adba01b7d9dd 100644
> --- a/tools/perf/util/scripting-engines/trace-event-python.c
> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> @@ -755,12 +755,22 @@ static void set_regs_in_dict(PyObject *dict,
>  }
>  
>  static void set_sym_in_dict(PyObject *dict, struct addr_location *al,
> -			    const char *dso_field, const char *sym_field,
> -			    const char *symoff_field)
> +			    const char *dso_field, const char *dso_bid_field,
> +			    const char *dso_map_start, const char *dso_map_end,
> +			    const char *sym_field, const char *symoff_field)
>  {
> +	char sbuild_id[SBUILD_ID_SIZE];
> +
>  	if (al->map) {
>  		pydict_set_item_string_decref(dict, dso_field,
>  			_PyUnicode_FromString(al->map->dso->name));
> +		build_id__sprintf(&al->map->dso->bid, sbuild_id);
> +		pydict_set_item_string_decref(dict, dso_bid_field,
> +			_PyUnicode_FromString(sbuild_id));
> +		pydict_set_item_string_decref(dict, dso_map_start,
> +			PyLong_FromUnsignedLong(al->map->start));
> +		pydict_set_item_string_decref(dict, dso_map_end,
> +			PyLong_FromUnsignedLong(al->map->end));
>  	}
>  	if (al->sym) {
>  		pydict_set_item_string_decref(dict, sym_field,
> @@ -840,7 +850,8 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
>  			(const char *)sample->raw_data, sample->raw_size));
>  	pydict_set_item_string_decref(dict, "comm",
>  			_PyUnicode_FromString(thread__comm_str(al->thread)));
> -	set_sym_in_dict(dict, al, "dso", "symbol", "symoff");
> +	set_sym_in_dict(dict, al, "dso", "dso_bid", "dso_map_start", "dso_map_end",
> +			"symbol", "symoff");
>  
>  	pydict_set_item_string_decref(dict, "callchain", callchain);
>  
> @@ -856,7 +867,9 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
>  	if (addr_al) {
>  		pydict_set_item_string_decref(dict_sample, "addr_correlates_sym",
>  			PyBool_FromLong(1));
> -		set_sym_in_dict(dict_sample, addr_al, "addr_dso", "addr_symbol", "addr_symoff");
> +		set_sym_in_dict(dict_sample, addr_al, "addr_dso", "addr_dso_bid",
> +				"addr_dso_map_start", "addr_dso_map_end",
> +				"addr_symbol", "addr_symoff");
>  	}
>  
>  	if (sample->flags)

