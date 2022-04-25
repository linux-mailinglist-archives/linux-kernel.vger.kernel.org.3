Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F60E50D616
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 02:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238258AbiDYAEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 20:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbiDYAEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 20:04:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAEB13FA1;
        Sun, 24 Apr 2022 17:01:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D55A861445;
        Mon, 25 Apr 2022 00:01:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10875C385A7;
        Mon, 25 Apr 2022 00:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650844900;
        bh=AXUSPHv7THGMSpb2syDr1mXuJfo2LnfUvKNKQYDoZUw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BBhmBoJD+fiMgPEAjaDIpXNT0ADVaiysGclLJpwWol0yylWb5BaGrkeE3NSAyED4u
         LEafhR6+Og+08Iv7EW3STyfOommREqkxUt9j04ev9Xxzsy0tabQgVZAgepVz/Bf7Tq
         LVzHm0RK+011aeLOLAoEsh0O98v5NxIWAp2EcEa2+w2MYJHV6S+RKZklflRcXEHCWm
         iJSTacMF1FtERzNvV5ZoW6w844ZoUXt04WRPtFDsnlZdKViX+mPFCVuXtxof7nGXJC
         BPiyz/svatS3Yy6HQGvEYQI5fVkzh8KsbVEDsg+OWaTVe7kmd3XRwySzTCxdYUzmBw
         A/x87m4k60Wgg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 31F56400B1; Sun, 24 Apr 2022 21:01:36 -0300 (-03)
Date:   Sun, 24 Apr 2022 21:01:36 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kael_w@yeah.net
Subject: Re: [PATCH] perf sched: simplify if-if to if-else
Message-ID: <YmXk4K/w9+j+tRki@kernel.org>
References: <20220424090727.97865-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220424090727.97865-1-wanjiabing@vivo.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Apr 24, 2022 at 05:07:27PM +0800, Wan Jiabing escreveu:
> Use if and else instead of if(A) and if (!A).

I'm now looking for a brown paper bag... There is some hope, but I'm not
in a mood, will check tomorrow, but certainly this should go in, thanks!

- Arnaldo
 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  tools/perf/builtin-sched.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 646bd938927a..66f8e9318123 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -3070,8 +3070,7 @@ static int perf_sched__timehist(struct perf_sched *sched)
>  	/* summary_only implies summary option, but don't overwrite summary if set */
>  	if (sched->summary_only)
>  		sched->summary = sched->summary_only;
> -
> -	if (!sched->summary_only)
> +	else
>  		timehist_header(sched);
>  
>  	err = perf_session__process_events(session);
> -- 
> 2.35.1

-- 

- Arnaldo
