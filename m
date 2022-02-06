Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86CE4AAF13
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 12:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbiBFLxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 06:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234592AbiBFLld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 06:41:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AF2C06173B;
        Sun,  6 Feb 2022 03:41:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0703760F6A;
        Sun,  6 Feb 2022 11:41:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B856C340E9;
        Sun,  6 Feb 2022 11:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644147691;
        bh=FSobEMJAK/NwOtYWPruGcvTq24jw7zYFBv6+hsMP0eI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LxCfANQ8XIuBZsh2jOoR+dU53Px+UhlQLmk9ig3nL1U2FYTtackbUCe4gMoYWarex
         R1hfoLhgYFoGssT5Zs60s7Si9FfGZxgaSdtbHTSnrdxFzZ1fWrEjZWB8DuOdp0DBH0
         8AyMotMC0wmS6ZauG5HqlEPQnpiPP+GqLNFwf3ZkZUn8lwJSSYya4fgk1OS1zvdNMV
         SsiJ3pUQfdrCX4BV6v/h7zLgaKyXNLV8d9wDiRU/2FCkpWKx5FhTS0mMuoyi2J+3ZX
         EyGX8wVENcuBxGKKgmTPSXzfDwLn82QP3mnBAJoW4cnygBtsfkd1XFLmcO1Sh7SvDU
         GOfBF4g3xskvg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E9872404A6; Sun,  6 Feb 2022 08:41:28 -0300 (-03)
Date:   Sun, 6 Feb 2022 08:41:28 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     Ameer Hamza <amhamza.mgc@gmail.com>,
        German Gomez <german.gomez@arm.com>, peterz@infradead.org,
        mingo@redhat.com, rickyman7@gmail.com,
        alexey.v.bayduraev@linux.intel.com, adrian.hunter@intel.com,
        leo.yan@linaro.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
Subject: Re: [PATCH] perf session: check for null pointer before derefernce
Message-ID: <Yf+z6LmCsyymABcN@kernel.org>
References: <20220124150001.93145-1-amhamza.mgc@gmail.com>
 <7c068167-e8bb-74f3-97d9-dd0c5858ee19@arm.com>
 <20220124202907.GA5741@hamza-OptiPlex-7040>
 <8983b963-2139-ecb3-3a31-b5e225db389c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8983b963-2139-ecb3-3a31-b5e225db389c@arm.com>
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

Em Tue, Jan 25, 2022 at 09:35:49AM +0000, James Clark escreveu:
> 
> 
> On 24/01/2022 20:29, Ameer Hamza wrote:
> > On Mon, Jan 24, 2022 at 03:30:17PM +0000, James Clark wrote:
> >>
> >>
> >> On 24/01/2022 15:00, Ameer Hamza wrote:
> >>> Move null pointer check before dereferncing the variable
> >>>
> >>> Addresses-Coverity: 1497622 ("Derereference before null check")
> >>>
> >>> Signed-off-by: Ameer Hamza <amhamza.mgc@gmail.com>
> >>> ---
> >>>  tools/perf/util/session.c | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> >>> index f19348dddd55..e1014ab62c10 100644
> >>> --- a/tools/perf/util/session.c
> >>> +++ b/tools/perf/util/session.c
> >>> @@ -1503,11 +1503,11 @@ static int machines__deliver_event(struct machines *machines,
> >>>  			++evlist->stats.nr_unknown_id;
> >>>  			return 0;
> >>>  		}
> >>> -		dump_sample(evsel, event, sample, perf_env__arch(machine->env));
> >>>  		if (machine == NULL) {
> >>>  			++evlist->stats.nr_unprocessable_samples;
> >>>  			return 0;
> >>>  		}
> >>> +		dump_sample(evsel, event, sample, perf_env__arch(machine->env));
> >>>  		return evlist__deliver_sample(evlist, tool, event, sample, evsel, machine);
> >>>  	case PERF_RECORD_MMAP:
> >>>  		return tool->mmap(tool, event, sample, machine);
> >>>
> >>
> >> Hi Ameer,
> >>
> >> This mistake was made recently, but I don't think your change is the desired behavior.
> >>
> >> It should be possible to dump stuff if machine is null. null or an empty string
> >> should be passed to dump_sample(). It looks like some of the printfs still attempt to
> >> show something in this case, although I didn't check them all.
> > 
> > Hi James,
> > 
> > Thank you for your response. I understand your point.
> > 
> > Do you think following changes would be ok?
> 
> Yep looks good. With that change:
> 
> Reviewed-by: James Clark <james.clark@arm.com>

Thanks, applied.

- Arnaldo

 
> > 
> > diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> > index f19348dddd55..210eeee3dd70 100644
> > --- a/tools/perf/util/session.c
> > +++ b/tools/perf/util/session.c
> > @@ -1503,11 +1503,12 @@ static int machines__deliver_event(struct machines *machines,
> >                         ++evlist->stats.nr_unknown_id;
> >                         return 0;
> >                 }
> > -               dump_sample(evsel, event, sample, perf_env__arch(machine->env));
> >                 if (machine == NULL) {
> >                         ++evlist->stats.nr_unprocessable_samples;
> > +                       dump_sample(evsel, event, sample, perf_env__arch(NULL));
> >                         return 0;
> >                 }
> > +               dump_sample(evsel, event, sample, perf_env__arch(machine->env));
> >                 return evlist__deliver_sample(evlist, tool, event, sample, evsel, machine);
> >         case PERF_RECORD_MMAP:
> >                 return tool->mmap(tool, event, sample, machine);
> > 
> > Thanks,
> > Hamza
> > 

-- 

- Arnaldo
