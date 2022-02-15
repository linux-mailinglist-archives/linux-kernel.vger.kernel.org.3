Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E209C4B7216
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbiBOPKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 10:10:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbiBOPKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 10:10:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260672B1A5;
        Tue, 15 Feb 2022 07:10:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B78F261536;
        Tue, 15 Feb 2022 15:10:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A85EC340EB;
        Tue, 15 Feb 2022 15:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644937840;
        bh=oFRbH9tdC6XlEEMR87cxogIXe8G78/ZTVwjpK2Nec6M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k5gtaQXleoGgX43yKTRxDkHYGYZZHDVJDR4UNg5XQMxB7FrSgmZy1Ffypb1lg9dgK
         Z9ECV87p/1RzLlV8dtuOuvOpRaWL/2xVimXc3TG2c9hHT1vHTZ5Jbu4XFw5H6RPLnW
         moTwxTbW6O3J63mawwaF9sbuFMyhgn2dC6J6o3U6Y8Tp4JiW1hZJ0qLqGVVUCRF59i
         f23pYq27FeHqlrcy8uJPQ33BXs7/b2bPd4hlQDJ3KHLybO2P/wTkKAcLrjd3fGTtzB
         XwkINh8y8xQzUtuOFoeOadAuj4BUTdEqaoEAIz/6cGMpaPMMrgNnrQDiBsBeugbUNi
         E13aUlozfmcPw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B5BC4400FE; Tue, 15 Feb 2022 12:10:37 -0300 (-03)
Date:   Tue, 15 Feb 2022 12:10:37 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
Subject: Re: [PATCH v3] perf test: Make metric testing more robust.
Message-ID: <YgvCbTBzVjBBP9/y@kernel.org>
References: <20211223185622.3435128-1-irogers@google.com>
 <e078ac0f-6165-9670-926f-d1f2c536ea9e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e078ac0f-6165-9670-926f-d1f2c536ea9e@huawei.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Dec 24, 2021 at 08:49:35AM +0000, John Garry escreveu:
> On 23/12/2021 18:56, Ian Rogers wrote:
> > When testing metric expressions we fake counter values from 1 going
> > upward. For some metrics this can yield negative values that are clipped
> > to zero, and then cause divide by zero failures. Such clipping is
> > questionable but may be a result of tools automatically generating
> > metrics. A workaround for this case is to try a second time with counter
> > values going in the opposite direction.
> > 
> > This case was seen in a metric like:
> >    event1 / max(event2 - event3, 0)
> > But it may also happen in more sensible metrics like:
> >    event1 / (event2 + event3 - 1 - event4)
> > 
> > v2. Rebase and more detail in commit message.
> > v3. Is a rebase.
> 
> Incorrect location for this info
> 
> > 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Reviewed-by: John Garry <john.garry@huawei.com>

Found thru the cracks, applying.

- Arnaldo
 
> > ---
> >   tools/perf/tests/pmu-events.c | 32 ++++++++++++++++++++++++++------
> >   1 file changed, 26 insertions(+), 6 deletions(-)
> > 
> > diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
> > index df1c9a3cc05b..b2ddf928d32a 100644
> > --- a/tools/perf/tests/pmu-events.c
> > +++ b/tools/perf/tests/pmu-events.c
> > @@ -962,8 +962,18 @@ static int test__parsing(struct test_suite *test __maybe_unused,
> >   			}
> >   			if (expr__parse(&result, ctx, pe->metric_expr)) {
> > -				expr_failure("Parse failed", map, pe);
> > -				ret++;
> > +				/*
> > +				 * Parsing failed, make numbers go from large to
> > +				 * small which can resolve divide by zero
> 
> can or may?
> 
> > +				 * issues.
> > +				 */
> > +				k = 1024;
> > +				hashmap__for_each_entry(ctx->ids, cur, bkt)
> > +					expr__add_id_val(ctx, strdup(cur->key), k--);
> > +				if (expr__parse(&result, ctx, pe->metric_expr)) {
> > +					expr_failure("Parse failed", map, pe);
> > +					ret++;
> > +				}
> >   			}
> >   		}
> >   	}
> > @@ -1022,10 +1032,20 @@ static int metric_parse_fake(const char *str)
> >   		}
> >   	}
> > -	if (expr__parse(&result, ctx, str))
> > -		pr_err("expr__parse failed\n");
> > -	else
> > -		ret = 0;
> > +	ret = 0;
> > +	if (expr__parse(&result, ctx, str)) {
> > +		/*
> > +		 * Parsing failed, make numbers go from large to small which can
> > +		 * resolve divide by zero issues.
> > +		 */
> > +		i = 1024;
> > +		hashmap__for_each_entry(ctx->ids, cur, bkt)
> > +			expr__add_id_val(ctx, strdup(cur->key), i--);
> > +		if (expr__parse(&result, ctx, str)) {
> > +			pr_err("expr__parse failed\n");
> > +			ret = -1;
> > +		}
> > +	}
> >   out:
> >   	expr__ctx_free(ctx);
> > 

-- 

- Arnaldo
