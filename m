Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9349C496DDE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 21:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiAVUGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 15:06:11 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:37292 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiAVUGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 15:06:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5FAE60EC1;
        Sat, 22 Jan 2022 20:06:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15B36C004E1;
        Sat, 22 Jan 2022 20:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642881969;
        bh=TzlIuH0eohtwYq5erGMyQFRL/wM3ys8GwJ+OKgjQoKY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VIfyIMbGswf/HxetoMXm5oUp/m83n4NHiWrQ0ynZ8c+CgEYnpu41HojHOrWBslhDD
         iYXmMuVTyMeZ7hdCxSOtKuTGGx0G2hNRXGYbwkUK3qeNZfQXd2sfbDt84Wuwx4srgm
         DHA1Q7jnykzgLsUz3JC8bofeK6NRn+xgbvfNnOJN/P1V/UJVZ/sRj69pDQbsQPLRuK
         3B5ihGXSC2Ct/WDJDrIYaQkDtZhSnAbEDkvIBs9z6lq2vXxc8Ymml9hIVEkt52c+JI
         kaLtpC/2lKANLA7VVWS/l4eF1XW7OGk/1xiSwR/tT09aee/iZ925nZ81LmzyLMOkDz
         O5R21SnU9MrVg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6C21340C99; Sat, 22 Jan 2022 17:04:07 -0300 (-03)
Date:   Sat, 22 Jan 2022 17:04:07 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     Wei Li <liwei391@huawei.com>, Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        guohanjun@huawei.com, jinyao5@huawei.com
Subject: Re: [PATCH] perf script: Fix printing 'phys_addr' failure issue
Message-ID: <YexjN1tV27bBQBkJ@kernel.org>
References: <20220121065954.2121900-1-liwei391@huawei.com>
 <1c38c70b-d165-acf9-1c98-eeb234fbbe99@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c38c70b-d165-acf9-1c98-eeb234fbbe99@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jan 21, 2022 at 11:24:57AM +0000, German Gomez escreveu:
> Hi Wei,
> 
> This looks good to me. As a followup we could also fix the 'weight'
> field, which was introduced recently.
> 
> On 21/01/2022 06:59, Wei Li wrote:
> > From: Yao Jin <jinyao5@huawei.com>
> >
> > Perf script was failed to print the phys_addr for SPE profiling.
> > One 'dummy' event is added by SPE profiling but it doesn't have PHYS_ADDR
> > attribute set, perf script then exits with error.
> >
> > Now referring to 'addr', use evsel__do_check_stype() to check the type.
> >
> > Before:
> >
> >   # perf record -e arm_spe_0/branch_filter=0,ts_enable=1,pa_enable=1,load_filter=1,jitter=0,\
> > 		store_filter=0,min_latency=0,event_filter=2/ -p 4064384 -- sleep 3
> >   # perf script -F pid,tid,addr,phys_addr
> >   Samples for 'dummy:u' event do not have PHYS_ADDR attribute set. Cannot print 'phys_addr' field.
> >
> > After:
> >
> >   # perf record -e arm_spe_0/branch_filter=0,ts_enable=1,pa_enable=1,load_filter=1,jitter=0,\
> > 		store_filter=0,min_latency=0,event_filter=2/ -p 4064384 -- sleep 3
> >   # perf script -F pid,tid,addr,phys_addr
> >   4064384/4064384 ffff802f921be0d0      2f921be0d0
> >   4064384/4064384 ffff802f921be0d0      2f921be0d0
> >
> > Signed-off-by: Yao Jin <jinyao5@huawei.com>
> > Signed-off-by: Wei Li <liwei391@huawei.com>
> 
> Reviewed-by: German Gomez <german.gomez@arm.com>
> 
> Also it looks like the SPE samples are also missing the PHYS_ADDR flag.
> I think we'll need to fix the consistency of the flags.

Thanks, applied.

- Arnaldo

 
> Many thanks,
> German
> 
> > ---
> >  tools/perf/builtin-script.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> > index ecd4f99a6c14..abae8184e171 100644
> > --- a/tools/perf/builtin-script.c
> > +++ b/tools/perf/builtin-script.c
> > @@ -515,7 +515,7 @@ static int evsel__check_attr(struct evsel *evsel, struct perf_session *session)
> >  		return -EINVAL;
> >  
> >  	if (PRINT_FIELD(PHYS_ADDR) &&
> > -	    evsel__check_stype(evsel, PERF_SAMPLE_PHYS_ADDR, "PHYS_ADDR", PERF_OUTPUT_PHYS_ADDR))
> > +	    evsel__do_check_stype(evsel, PERF_SAMPLE_PHYS_ADDR, "PHYS_ADDR", PERF_OUTPUT_PHYS_ADDR, allow_user_set))
> >  		return -EINVAL;
> >  
> >  	if (PRINT_FIELD(DATA_PAGE_SIZE) &&

-- 

- Arnaldo
