Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3915ACCE2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 09:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236474AbiIEHoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 03:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235915AbiIEHom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 03:44:42 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35A2B1DD
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 00:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662363881; x=1693899881;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=fmTDU5mmsQOUkVEh8rl4DMITt8+ONDUTqrcU64oVD+U=;
  b=dlhpZEPjAFPuokF7TmozFahHQsqASYWp2Gn6lqdeA9NkNeXr3016j79L
   iOVOWIbot1R8tRD8ma9IIrY1atOqdpaJGyUN3TW+L2fGnL1uBr9DcEmie
   arraNI+2jq36+1V8MrY05gdjXac4jtg1qvVFnMl9uy6idyOP0oeHAFLaj
   BT9G+lAa9/1IBn5aw1ToOCK6nIqIohG7XdZNRipDHF8wyw48EgNlhAUuW
   Ie53ZSzD87z5g8nKiguhQOzD410DrjQlLIDS8+fCVcax9uMopIi+0raUC
   TC9X/YYL8MsOjD+0y7iK3J4oFySZ9FgDMwvVkUNkDaGNgXzijHswRSUpJ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10460"; a="297641023"
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="297641023"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 00:44:41 -0700
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="609598212"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.56.151])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 00:44:39 -0700
Message-ID: <92890263-a876-0739-8ba2-e571a576c26c@intel.com>
Date:   Mon, 5 Sep 2022 10:44:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] perf dlfilter: dlfilter-show-cycles: Fix types for print
 format
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org
References: <20220905074221.4262-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220905074221.4262-1-adrian.hunter@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/09/22 10:42, Adrian Hunter wrote:
> Avoid compiler warning about format %llu that expects long long unsigned
> int but argument has type __u64.
> 

Fixes: c3afd6e50fce ("perf dlfilter: Add dlfilter-show-cycles")

> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/dlfilters/dlfilter-show-cycles.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/dlfilters/dlfilter-show-cycles.c b/tools/perf/dlfilters/dlfilter-show-cycles.c
> index 9eccc97bff82..6d47298ebe9f 100644
> --- a/tools/perf/dlfilters/dlfilter-show-cycles.c
> +++ b/tools/perf/dlfilters/dlfilter-show-cycles.c
> @@ -98,9 +98,9 @@ int filter_event_early(void *data, const struct perf_dlfilter_sample *sample, vo
>  static void print_vals(__u64 cycles, __u64 delta)
>  {
>  	if (delta)
> -		printf("%10llu %10llu ", cycles, delta);
> +		printf("%10llu %10llu ", (unsigned long long)cycles, (unsigned long long)delta);
>  	else
> -		printf("%10llu %10s ", cycles, "");
> +		printf("%10llu %10s ", (unsigned long long)cycles, "");
>  }
>  
>  int filter_event(void *data, const struct perf_dlfilter_sample *sample, void *ctx)

