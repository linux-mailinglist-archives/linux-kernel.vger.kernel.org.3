Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C5053D25C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 21:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349273AbiFCT2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 15:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244845AbiFCT2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 15:28:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8D956FB5;
        Fri,  3 Jun 2022 12:28:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19BCE61A5F;
        Fri,  3 Jun 2022 19:28:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 493CEC385A9;
        Fri,  3 Jun 2022 19:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654284529;
        bh=4gv4IEpTaFP2QCjC2iXwNPdffpE5b9Mjy7L03jXTa4Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JlRBbwHu5MQMJ4fZjaalTOo3AZ4iWdRZvhYLnDTfzpntZEsWvq5TsbuB5/OSmmaE0
         w/DfN4uxvg8IBwXnJ9uUD5XZ81+pkIWEYplhFNNqGb98RYQddXrIOdFRhxZA0n1RY9
         4Aoep7UAAk//OT9dvsl22hzmfrgxJdkrhkVLI9lsepq5dId54uX33XfNn2YFBHAw9/
         1O2T03DpmyIXuwODm8ZYQFv/zgKO51GE1hj/Y8hMFtLXd//JJDQiR1PXrpnyW/fWjz
         2Kj7MvYacP5cGLTBzOIx0JJ/2hWswJhuupMC1ZNbpyc3ynrugEeJzDr/j7pV0gs7ky
         OCOIpqjMy/6IA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7BC324096F; Fri,  3 Jun 2022 21:28:47 +0200 (CEST)
Date:   Fri, 3 Jun 2022 21:28:47 +0200
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH 1/5] perf lock: Change to synthesize task events
Message-ID: <Yppg7yCks8JWEjK9@kernel.org>
References: <20220601065846.456965-1-namhyung@kernel.org>
 <20220601065846.456965-2-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601065846.456965-2-namhyung@kernel.org>
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

Em Tue, May 31, 2022 at 11:58:42PM -0700, Namhyung Kim escreveu:
> With -t/--threads option, it needs to display task names so synthesize
> task related events at the beginning.

Cherry picked this one.
 
> Fixes: 7c3bcbdf449f ("perf lock: Add -t/--thread option for report")
> Acked-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-lock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index b1200b7340a6..23a33ac15e68 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -1083,7 +1083,7 @@ static int __cmd_report(bool display_info)
>  static int __cmd_record(int argc, const char **argv)
>  {
>  	const char *record_args[] = {
> -		"record", "-R", "-m", "1024", "-c", "1", "--synth", "no",
> +		"record", "-R", "-m", "1024", "-c", "1", "--synth", "task",
>  	};
>  	unsigned int rec_argc, i, j, ret;
>  	const char **rec_argv;
> 
> base-commit: 9dde6cadb92b5670b23b97ec53091df0530ec38b
> -- 
> 2.36.1.255.ge46751e96f-goog

-- 

- Arnaldo
