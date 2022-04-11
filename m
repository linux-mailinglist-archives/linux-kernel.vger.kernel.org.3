Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8018E4FC3BC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 19:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349003AbiDKSB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 14:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347148AbiDKSB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 14:01:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F27340DB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 10:59:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 645AAB817F4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 17:59:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01FA6C385A3;
        Mon, 11 Apr 2022 17:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649699978;
        bh=15s7sZtMG3WeX+8zNc41BYgj8Fdf9eZ5HkCyQvIdChc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sM/ysuLOVy/KUq72gaypEBWUenpsMXMnA1knwMkED2NMGeeg82lZCRgR3TNqfDxkt
         mJrVJMz7JSTlyYa0ZsOQs0fhvXHD/jTV2i+XHdbDNGLRNZ5Q2y5YVn9bGVmq+UiVPy
         /pRAwiJ80zUwmOOEQiM8d896r1r2rxYWCChnK551kaOk3BHzPfjqqzMIXbc2Qg0P+z
         LJHYE3MIYEeu75bCMdbWLWKTRhAlG0tnePH270IXfXlaLJvAjydgM4r3+MUMxF7R5w
         18grR74f04FkoJuKqhDxPeWxEZD15USh/L7XCu8ge934KDCAJmdkj1t+N4tkq9zY60
         yO1CNSZEC/b/w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D6BD040407; Mon, 11 Apr 2022 14:59:33 -0300 (-03)
Date:   Mon, 11 Apr 2022 14:59:33 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Fix misleading add event pmu debug message
Message-ID: <YlRshf1/FVSaQEXJ@kernel.org>
References: <20220411061758.2458417-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411061758.2458417-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Apr 11, 2022 at 09:17:58AM +0300, Adrian Hunter escreveu:
> Fix incorrect debug message:
> 
>    Attempting to add event pmu 'intel_pt' with '' that may result in
>    non-fatal errors
> 
> which always appears with perf record -vv and intel_pt e.g.
> 
>     perf record -vv -e intel_pt//u uname
> 
> The message is incorrect because there will never be non-fatal errors.
> 
> Suppress the message if the pmu is 'selectable' i.e. meant to be selected
> directly as an event.

Thanks, applied.

- Arnaldo

 
> Fixes: 4ac22b484d4c79 ("perf parse-events: Make add PMU verbose output clearer")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/util/parse-events.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 24997925ae00..dd84fed698a3 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1523,7 +1523,9 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
>  	bool use_uncore_alias;
>  	LIST_HEAD(config_terms);
>  
> -	if (verbose > 1) {
> +	pmu = parse_state->fake_pmu ?: perf_pmu__find(name);
> +
> +	if (verbose > 1 && !(pmu && pmu->selectable)) {
>  		fprintf(stderr, "Attempting to add event pmu '%s' with '",
>  			name);
>  		if (head_config) {
> @@ -1536,7 +1538,6 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
>  		fprintf(stderr, "' that may result in non-fatal errors\n");
>  	}
>  
> -	pmu = parse_state->fake_pmu ?: perf_pmu__find(name);
>  	if (!pmu) {
>  		char *err_str;
>  
> -- 
> 2.25.1

-- 

- Arnaldo
