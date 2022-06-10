Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A550546C9E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 20:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347530AbiFJSlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 14:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347017AbiFJSlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 14:41:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272233ED37;
        Fri, 10 Jun 2022 11:41:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C208CB83306;
        Fri, 10 Jun 2022 18:41:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DD19C34114;
        Fri, 10 Jun 2022 18:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654886470;
        bh=8OzaaS+ZSMPsh31JB7Ah5CaSRa2016oEc+BQxWbwMfo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c75X+wXAL5ajJev5A/S5OVvUwVqCjyv2Cfzrrf8ptQHUjc98XbeKpoA1kapS27sx9
         HokPACvaZrYWSD+JHRmSUFhCJj6G6wRUOmHr5zbdCPuIiizzF7DlAvgfI7uwucv17D
         1GUxh8tE3PDiJmfglVWnmEo3rFnwkkiCRNQz5W2vmyvoS2Tzdw2m4G1aNRE0r3Isz0
         Jyz8qwSpd/bmEcXf+L7SzRPAWC2CAz8heOGVeqyYsqFu+32G1zETb7+MobtEHYis7C
         05ysCbOJfVuH1siY6lmQ0W38gDIP9xcWi1/JZ0PW63DULfWuuWx2S0dezLi1rT3kUL
         Q9uw1YGQi8yPw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2EBB24096F; Fri, 10 Jun 2022 15:41:08 -0300 (-03)
Date:   Fri, 10 Jun 2022 15:41:08 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf test: Fix undefined behavior in bp_account
Message-ID: <YqOQRD62FIDNBkcH@kernel.org>
References: <20220610180247.444798-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610180247.444798-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jun 10, 2022 at 11:02:47AM -0700, Ian Rogers escreveu:
> Fix:
> tests/bp_account.c:154:9: runtime error: variable length array bound evaluates to non-positive value 0
> by switching from a variable length to an allocated array.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/bp_account.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/tests/bp_account.c b/tools/perf/tests/bp_account.c
> index d1ebb5561e5b..6f921db33cf9 100644
> --- a/tools/perf/tests/bp_account.c
> +++ b/tools/perf/tests/bp_account.c
> @@ -151,11 +151,21 @@ static int detect_ioctl(void)
>  static int detect_share(int wp_cnt, int bp_cnt)
>  {
>  	struct perf_event_attr attr;
> -	int i, fd[wp_cnt + bp_cnt], ret;
> +	int i, *fd = NULL, ret = -1;
> +
> +	if (wp_cnt + bp_cnt == 0)
> +		return 0;
> +
> +	fd = malloc(sizeof(int) * (wp_cnt + bp_cnt));
> +	if (!fd)
> +		return -1;
>  
>  	for (i = 0; i < wp_cnt; i++) {
>  		fd[i] = wp_event((void *)&the_var, &attr);
> -		TEST_ASSERT_VAL("failed to create wp\n", fd[i] != -1);
> +		if (fd[i] == -1) {
> +			pr_err("failed to create wp\n");
> +			goto out;
> +		}
>  	}
>  
>  	for (; i < (bp_cnt + wp_cnt); i++) {
> @@ -166,9 +176,11 @@ static int detect_share(int wp_cnt, int bp_cnt)
>  
>  	ret = i != (bp_cnt + wp_cnt);
>  
> +out:
>  	while (i--)
>  		close(fd[i]);
>  
> +	free(fd);
>  	return ret;
>  }
>  
> -- 
> 2.36.1.476.g0c4daa206d-goog

-- 

- Arnaldo
