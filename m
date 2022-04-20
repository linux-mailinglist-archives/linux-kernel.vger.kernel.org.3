Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B56508DC8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 18:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380783AbiDTQzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 12:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234342AbiDTQy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:54:57 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEFB3E0CD;
        Wed, 20 Apr 2022 09:52:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 20DE3CE1F35;
        Wed, 20 Apr 2022 16:52:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11BE9C385A1;
        Wed, 20 Apr 2022 16:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650473527;
        bh=FC490u1W61U7N1WZsU8ZxxqqwdjaPJpwQjP4Ffy5Dec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VFfeqOvEoJa7DizXqbls1AKo0ueBd7D3h+OuaL+6LTQJFam8KtYRqkFcuYlbVKKs3
         Nsmg6ZJKnI0dnNOTTNTPgN3OBLub9EknOVzRW+i6Yjh5kuuQjapnVNfx+PbEF+bh/e
         RYxC4ITKgYEfkW1W7YhLNGi3EKI6jocd7W9sb+Ztxs7jAYa22Uu9TJOgLg8mxxiqOZ
         102SepDDEHCtoEUJAD6/U9Mici9D056Bk+ocpQl73kvk90lsMYrr8KQQYBKjYGQSES
         28VViaWhWCpfKX73xWb7RKu4jV4tXiO+5C/gPR+Cdykt4+KI2N/wJBcrsRSw/AtI8H
         w//6zUTAkBI/A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 54752400B1; Wed, 20 Apr 2022 13:52:03 -0300 (-03)
Date:   Wed, 20 Apr 2022 13:52:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        chengdongli@tencent.com, adrian.hunter@intel.com,
        svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com
Subject: Re: [PATCH] perf/test: test case 71 fails on s390
Message-ID: <YmA6M8mM44Hvv/jI@kernel.org>
References: <20220420062921.1211825-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420062921.1211825-1-tmricht@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 20, 2022 at 08:29:21AM +0200, Thomas Richter escreveu:
> Test case 71 'Convert perf time to TSC' is not supported on s390.
> Subtest 71.1 is skipped with the correct message, but
> subtest 71.2 is not skipped and fails.
> 
> The root cause is function evlist__open() called from
> test__perf_time_to_tsc().  evlist__open() returns -ENOENT because the
> event cycles:u is not supported by the selected PMU, for example 
> platform s390 on z/VM or an x86_64 virtual machine.
> The PMU driver returns -ENOENT in this case. This error is leads to
> the failure.
> Fix this by returning TEST_SKIP on -ENOENT.

Thanks, applied and tested it on x86_64, where it continues to work.

- Arnaldo

 
> Output before:
>  71: Convert perf time to TSC:
>  71.1: TSC support:             Skip (This architecture does not support)
>  71.2: Perf time to TSC:        FAILED!
> 
> Output after:
>  71: Convert perf time to TSC:
>  71.1: TSC support:             Skip (This architecture does not support)
>  71.2: Perf time to TSC:        Skip (perf_read_tsc_conversion is not supported)
> 
> This also happens on an x86_64 virtual machine:
>    # uname -m
>    x86_64
>    $ ./perf test -F 71
>     71: Convert perf time to TSC  :
>     71.1: TSC support             : Ok
>     71.2: Perf time to TSC        : FAILED!
>    $ 
> 
> Fixes: 290fa68bdc45 ("perf test tsc: Fix error message when not supported")
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> ---
>  tools/perf/tests/perf-time-to-tsc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/perf/tests/perf-time-to-tsc.c b/tools/perf/tests/perf-time-to-tsc.c
> index cc6df49a65a1..4ad0dfbc8b21 100644
> --- a/tools/perf/tests/perf-time-to-tsc.c
> +++ b/tools/perf/tests/perf-time-to-tsc.c
> @@ -123,6 +123,10 @@ static int test__perf_time_to_tsc(struct test_suite *test __maybe_unused, int su
>  		evsel->core.attr.enable_on_exec = 0;
>  	}
>  
> +	if (evlist__open(evlist) == -ENOENT) {
> +		err = TEST_SKIP;
> +		goto out_err;
> +	}
>  	CHECK__(evlist__open(evlist));
>  
>  	CHECK__(evlist__mmap(evlist, UINT_MAX));
> -- 
> 2.35.1

-- 

- Arnaldo
