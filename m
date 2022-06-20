Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47BEC55244D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 20:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245151AbiFTSyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 14:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238373AbiFTSyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 14:54:35 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BCC1D0E8;
        Mon, 20 Jun 2022 11:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655751275; x=1687287275;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ewo2bLmHNlV27v8ay/BYFSDyEOkDLvqdjbmT2NDjg9A=;
  b=b3XlZUEaBOEdEcymatrVot094PlWki+/UMNe0vyY802pkSIWX35VYqnM
   0YZFUPgtIQ/FpCGYQmUyh569W6vsSpp1EnEeQnZ6SXyqe6DsvaswrQLFB
   6W1wMtJ5fSnrbYqxbfS9UQi0PykU/k7AbkyMYn60iZfRz9iHPLz2T+F7+
   IWigC/rc/nZ/RZ1dQABPkB/WedBoyfbT6pR0vJo4yzW95EmG0BehLE3zP
   vEI9sMs42PzFqTbJlsDUMc6LRvQnCXkK0H5td3PUV99EY0z5947ioUTsV
   RWNFEFOo+qo+AJapHYsXIWCHkFb1dDEpNngvc8PCMoWVrUncdcIsmkvca
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="305394137"
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="305394137"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 11:54:34 -0700
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="591296723"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.58.69])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 11:54:30 -0700
Message-ID: <a651ca26-6aae-fe7f-66b1-18fdbad40f41@intel.com>
Date:   Mon, 20 Jun 2022 21:54:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH] perf: Adjust perf-inject output data offset for backward
 compatibility
Content-Language: en-US
To:     Raul Silvera <rsilvera@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Colin Ian King <colin.king@intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220620164953.1503934-1-rsilvera@google.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220620164953.1503934-1-rsilvera@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/06/22 19:49, Raul Silvera wrote:
> When perf inject creates a new file, it reuses the data offset from the
> input file. If there has been a change on the size of the header, as
> happened in v5.12 -> v5.13, the new offsets will be wrong, resulting in
> a corrupted output file.
> 
> This change adds the function perf_session__data_offset to compute the
> data offset based on the current header size, and uses that instead of
> the offset from the original input file.
> 
> Signed-off-by: Raul Silvera <rsilvera@google.com>
> ---
>  tools/perf/builtin-inject.c |  2 +-
>  tools/perf/util/header.c    | 16 +++++++++++++++-
>  tools/perf/util/header.h    |  2 ++
>  3 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index a75bf11585b5..1dfdcef36607 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -916,7 +916,7 @@ static int __cmd_inject(struct perf_inject *inject)
>  		inject->tool.tracing_data = perf_event__repipe_tracing_data;
>  	}
>  
> -	output_data_offset = session->header.data_offset;
> +	output_data_offset = perf_session__data_offset(session->evlist);
>  
>  	if (inject->build_id_all) {
>  		inject->tool.mmap	  = perf_event__repipe_buildid_mmap;
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 53332da100e8..93706ae827f1 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -3660,7 +3660,7 @@ static int perf_session__do_write_header(struct perf_session *session,
>  			.size   = evlist->core.nr_entries * sizeof(f_attr),
>  		},
>  		.data = {
> -			.offset = header->data_offset,
> +			.offset = attr_offset + evlist->core.nr_entries * sizeof(f_attr),

This looks too late since, although the header comes before the data,
it also gets written afterwards (at_exit == true).  It would be
better if we could rely on header->data_offset at this point.

>  			.size	= header->data_size,
>  		},
>  		/* event_types is ignored, store zeros */
> @@ -3686,6 +3686,20 @@ int perf_session__write_header(struct perf_session *session,
>  	return perf_session__do_write_header(session, evlist, fd, at_exit, NULL);
>  }
>  
> +size_t perf_session__data_offset(const struct evlist *evlist)
> +{
> +	struct evsel *evsel;
> +	size_t data_offset;
> +
> +	data_offset = sizeof(struct perf_file_header);
> +	evlist__for_each_entry(evlist, evsel) {
> +		data_offset += evsel->core.ids * sizeof(u64);
> +	}
> +	data_offset += evlist->core.nr_entries * sizeof(struct perf_file_attr);
> +
> +	return data_offset;
> +}
> +
>  int perf_session__inject_header(struct perf_session *session,
>  				struct evlist *evlist,
>  				int fd,
> diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
> index 08563c1f1bff..56916dabce7b 100644
> --- a/tools/perf/util/header.h
> +++ b/tools/perf/util/header.h
> @@ -136,6 +136,8 @@ int perf_session__inject_header(struct perf_session *session,
>  				int fd,
>  				struct feat_copier *fc);
>  
> +size_t perf_session__data_offset(const struct evlist *evlist);
> +
>  void perf_header__set_feat(struct perf_header *header, int feat);
>  void perf_header__clear_feat(struct perf_header *header, int feat);
>  bool perf_header__has_feat(const struct perf_header *header, int feat);

