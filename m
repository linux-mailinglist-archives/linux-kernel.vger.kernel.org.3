Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A0552EDF4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 16:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350204AbiETORr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 10:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240895AbiETORm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 10:17:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5578041F8F;
        Fri, 20 May 2022 07:17:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0BD1DB82B3D;
        Fri, 20 May 2022 14:17:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D5BC385A9;
        Fri, 20 May 2022 14:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653056258;
        bh=F14/F9P0/AL5bgXbf41f1cTe10uS+wJN6iGkeUqAY8s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B6O8GTconuBxSD/Yc148TzSu3wNinzh6t3pv7gnRB2WUXCaq99EvetYrnh/BqD7wA
         4cTkTW8I7yZBzeek49avXhXMx5N3o2t1w1c/X8jBtPZhkh5nmOUrvyoS9jNwZVArAs
         VW/DwTtQnrb8z3La6aAzlpQ6rcpRn9d++oivtNAABYID3Uh4GR2GWRO6nhuA/Y4mSh
         GIDWV11TVsvpg59rq9Twdfe1We+PX2ue3pPbp2Klxc5YxBjWv7tHQfkH1m6z5J4ZvY
         sxc3bKvGiHtbogkgk4i45goA3tu1HT2xgzE51BYq76L0V8rVKYdXKXa3rdr4CloO1E
         Ox5Jwl6Ye2WxQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 25E6C400B1; Fri, 20 May 2022 11:17:36 -0300 (-03)
Date:   Fri, 20 May 2022 11:17:36 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Marco Elver <elver@google.com>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf test: Avoid shell test description infinite loop
Message-ID: <YoejAP5Yfnh7ViIZ@kernel.org>
References: <20220517204144.645913-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517204144.645913-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 17, 2022 at 01:41:44PM -0700, Ian Rogers escreveu:
> for_each_shell_test is already strict in expecting tests to be files and
> executable. It is sometimes possible when it iterates over all files
> that it finds one that is executable and lacks a newline character. When
> this happens the loop never terminates as it doesn't check for EOF. Add
> the EOF check to make this loop at least bounded by the file size.
> 
> If the description is returned as NULL then also skip the test.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/builtin-test.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index 3c34cb766724..aa40eae1c9cf 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -279,6 +279,7 @@ static const char *shell_test__description(char *description, size_t size,
>  {
>  	FILE *fp;
>  	char filename[PATH_MAX];
> +	int ch;
>  
>  	path__join(filename, sizeof(filename), path, name);
>  	fp = fopen(filename, "r");
> @@ -286,7 +287,9 @@ static const char *shell_test__description(char *description, size_t size,
>  		return NULL;
>  
>  	/* Skip shebang */
> -	while (fgetc(fp) != '\n');
> +	do {
> +		ch = fgetc(fp);
> +	} while (ch != EOF && ch != '\n');
>  
>  	description = fgets(description, size, fp);
>  	fclose(fp);
> @@ -419,7 +422,8 @@ static int run_shell_tests(int argc, const char *argv[], int i, int width,
>  			.priv = &st,
>  		};
>  
> -		if (!perf_test__matches(test_suite.desc, curr, argc, argv))
> +		if (test_suite.desc == NULL ||
> +		    !perf_test__matches(test_suite.desc, curr, argc, argv))
>  			continue;
>  
>  		st.file = ent->d_name;
> -- 
> 2.36.0.550.gb090851708-goog

-- 

- Arnaldo
