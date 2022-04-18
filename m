Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AECA505B15
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238374AbiDRPeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345164AbiDRPcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:32:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4F91D32D;
        Mon, 18 Apr 2022 07:45:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 237D3B80EE5;
        Mon, 18 Apr 2022 14:45:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4A2C385A1;
        Mon, 18 Apr 2022 14:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650293120;
        bh=9D22M32rTqd0DBd1ckR6AUneXhxPz8jtuLV0DeZTXHA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WWlxb99HzpfEXZeoExxYz9hMaA8AFKDteltrZlmAUzInzqKMU2yF233Esj2tbTVFC
         JPXsNGZO4cWlUsOtqcey3RXyR+TP8qj+WHfDyEeUf4LudGZKnmN1iBpWJQ3Fzlg0qW
         lQAX3s/qUyvuN9Hf3MkHqXwNP3ZkE7HoFwSi71wQxTrfNmQ5dArwwgDr7HHFtKpB60
         dZQ3bdLdfLu803zKw35+4RVyyriUeDfV68Olx+tmSoHwtDdz9jzoHF30bzyoIHX8z/
         q+w1tkSoRNRVMmCwws3Rg5fVNALYEzY2Q9I+tAnGXUIIN+K9Ljlj2ViqIY1WbOsB4F
         if8aaEyKK9kkg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7BD7040407; Mon, 18 Apr 2022 11:45:18 -0300 (-03)
Date:   Mon, 18 Apr 2022 11:45:18 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf script: Always allow field 'data_src' for auxtrace
Message-ID: <Yl15fnAwfu3pDg2d@kernel.org>
References: <20220417114837.839896-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220417114837.839896-1-leo.yan@linaro.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Apr 17, 2022 at 07:48:37PM +0800, Leo Yan escreveu:
> If use command 'perf script -F,+data_src' to dump memory samples with
> Arm SPE trace data, it reports error:
> 
>   # perf script -F,+data_src
>   Samples for 'dummy:u' event do not have DATA_SRC attribute set. Cannot print 'data_src' field.
> 
> This is because the 'dummy:u' event is absent DATA_SRC bit in its sample
> type, so if a file contains AUX area tracing data then always allow
> field 'data_src' to be selected as an option for perf script.

Thanks, applied to perf/urgent.

- Arnaldo

 
> Fixes: e55ed3423c1b ("perf arm-spe: Synthesize memory event")
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/builtin-script.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index a2f117936188..cf5eab5431b4 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -461,7 +461,7 @@ static int evsel__check_attr(struct evsel *evsel, struct perf_session *session)
>  		return -EINVAL;
>  
>  	if (PRINT_FIELD(DATA_SRC) &&
> -	    evsel__check_stype(evsel, PERF_SAMPLE_DATA_SRC, "DATA_SRC", PERF_OUTPUT_DATA_SRC))
> +	    evsel__do_check_stype(evsel, PERF_SAMPLE_DATA_SRC, "DATA_SRC", PERF_OUTPUT_DATA_SRC, allow_user_set))
>  		return -EINVAL;
>  
>  	if (PRINT_FIELD(WEIGHT) &&
> -- 
> 2.25.1

-- 

- Arnaldo
