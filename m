Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508E3535199
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 17:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348017AbiEZPnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 11:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241189AbiEZPne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 11:43:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B48CFE14;
        Thu, 26 May 2022 08:43:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8AB5761C5D;
        Thu, 26 May 2022 15:43:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF43C385A9;
        Thu, 26 May 2022 15:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653579812;
        bh=pFghZH5p3iCT67+6+qFAycKoXgf4wVflFH4Pzv1Zafg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XS2jyPL+qEzQ2AGzNMdt+HVvmW9X4FKi09Q4984DWRc/B8tYjMNSoDaImK243LIVI
         sCGUIz1NmcO5WOigq3gHyZ28djV7pWYR6RSMf3Qfng2t8BZyvGKoDOIh0/KFY3QiDV
         GtabaZtQ1yx4v8LBvW6TBsYHxSlhvVzFKJJtUrJAcBvmaAkRhsFz8jdqxYh7KFzQYD
         d8CityTroJ8r8lfPjjMZXYX0BOtxtNayOoFWVsnhHQVzGc5i2u6CjNg15a6fLsIhup
         WymQx36hDU0eSWOFb2/u14sreiLKBY8FN2PoRjnMokW6bUUxzkTwrqR8LgvHLx0San
         93+IHvfahNeOQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A289D4036D; Thu, 26 May 2022 12:43:29 -0300 (-03)
Date:   Thu, 26 May 2022 12:43:29 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Tanmay Jagdale <tanmay@marvell.com>,
        "zengshun . wu" <zengshun.wu@outlook.com>,
        Al Grant <al.grant@arm.com>, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v6 1/2] perf scripting python: Expose dso and map
 information
Message-ID: <Yo+gIQgElkOg/3EN@kernel.org>
References: <20220521130446.4163597-1-leo.yan@linaro.org>
 <20220521130446.4163597-2-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521130446.4163597-2-leo.yan@linaro.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, May 21, 2022 at 09:04:45PM +0800, Leo Yan escreveu:
> This change adds dso build_id and corresponding map's start and end
> address.  The info of dso build_id can be used to find dso file path,
> and we can validate if a branch address falls into the range of map's
> start and end addresses.
> 
> In addition, the map's start address can be used as an offset for
> disassembly.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied both patches.

- Arnaldo

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
> -- 
> 2.25.1

-- 

- Arnaldo
