Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4F2531083
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235722AbiEWMqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 08:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235659AbiEWMqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 08:46:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41282527FD;
        Mon, 23 May 2022 05:46:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2A5061336;
        Mon, 23 May 2022 12:46:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEEADC385A9;
        Mon, 23 May 2022 12:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653310004;
        bh=n362nAZJp3aj4NcxskSm616SiABVTuWrekUeDWsgm3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dXdMkL8P/85JhD6HxonwoORKJUbAJ+0Q8xKxRSB7qgk13+QpOZSL9zExrylTX/Wgp
         mkOk6eSUsZXxdDeRG3bBHhJ8mEJQH/g48d9SwF1TM52+iir/jyf4FoGV/xaaOrqsAq
         Zeqah/xMchem7xnZmwQWna3iFx/GHKYfsADGAp6IEQVk4bb6A/uyS6joPP/32IetcP
         awRHWUOBR3Jsb69uPWiW1XOMWrTNdjlZacjmEiV/9Zxkmd7nIR0rln7gqHW0h10a/m
         FAEgIilBPc+vMhmTdPZFizvrJY47wS8tLcIbgbJ+0x7Wrnz9jw1PmUnTYvDiVnXaYM
         vWAeNfR4EJ55w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5E492400B1; Mon, 23 May 2022 09:46:41 -0300 (-03)
Date:   Mon, 23 May 2022 09:46:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Like Xu <likexu@tencent.com>, Alyssa Ross <hi@alyssa.is>,
        Ian Rogers <irogers@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Adam Li <adamli@amperemail.onmicrosoft.com>,
        Li Huafei <lihuafei1@huawei.com>,
        German Gomez <german.gomez@arm.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ali Saidi <alisaidi@amazon.com>, Joe Mario <jmario@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/11] perf mem: Add statistics for peer snooping
Message-ID: <YouCMUI1L8Ojy7Vt@kernel.org>
References: <20220518055729.1869566-1-leo.yan@linaro.org>
 <20220518055729.1869566-5-leo.yan@linaro.org>
 <YouAR+9Mi9AtX+g3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YouAR+9Mi9AtX+g3@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, May 23, 2022 at 09:38:31AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, May 18, 2022 at 01:57:22PM +0800, Leo Yan escreveu:
> > Since the flag PERF_MEM_SNOOPX_PEER is added to support cache snooping
> > from peer cache line, it can come from a peer core, a peer cluster, or
> > a remote NUMA node.
> > 
> > This patch adds statistics for the flag PERF_MEM_SNOOPX_PEER.  Note, we
> > take PERF_MEM_SNOOPX_PEER as an affiliated info, it needs to cooperate
> > with cache level statistics.  Therefore, we account the load operations
> > for both the cache level's metrics (e.g. ld_l2hit, ld_llchit, etc.) and
> > the metric 'ld_peer' when flag PERF_MEM_SNOOPX_PEER is set.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > Tested-by: Ali Saidi <alisaidi@amazon.com>
> 
> util/mem-events.c: In function ‘c2c_decode_stats’:
> util/mem-events.c:536:17: error: ‘PERF_MEM_SNOOPX_PEER’ undeclared (first use in this function); did you mean ‘PERF_MEM_SNOOPX_FWD’?

So I kept the first three patches:

⬢[acme@toolbox perf]$ git log --oneline -5
12aeaaba087d6d92 (HEAD -> perf/core) perf c2c: Update documentation for store metric 'N/A'
550b4d6f9a7e5ddc perf c2c: Add dimensions for 'N/A' metrics of store operation
9845063710725424 perf mem: Add stats for store operation with no available memory level
508c9fbce0d30da3 perf build: Error for BPF skeletons without LIBBPF
0869331fbaa2c11c Merge remote-tracking branch 'torvalds/master' into perf/core
⬢[acme@toolbox perf]$

With Jiri's ack, now waiting for clarification about the v9 discussion
on the base patchkit.

- Arnaldo
 
> 
> Should I fix this as suggested by the compiler?
> 
>   536 | #define P(a, b) PERF_MEM_##a##_##b
>       |                 ^~~~~~~~~
> util/mem-events.c:562:46: note: in expansion of macro ‘P’
>   562 |                                 if (snoopx & P(SNOOPX, PEER))
>       |                                              ^
> util/mem-events.c:536:17: note: each undeclared identifier is reported only once for each function it appears in
>   536 | #define P(a, b) PERF_MEM_##a##_##b
>       |                 ^~~~~~~~~
> util/mem-events.c:562:46: note: in expansion of macro ‘P’
>   562 |                                 if (snoopx & P(SNOOPX, PEER))
>       |                                              ^
> make[4]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:96: /tmp/build/perf/util/mem-events.o] Error 1
> make[4]: *** Waiting for unfinished jobs....
>   LD      /tmp/build/perf/util/scripting-engines/perf-in.o
> make[3]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:139: util] Error 2
> make[2]: *** [Makefile.perf:664: /tmp/build/perf/perf-in.o] Error 2
> make[1]: *** [Makefile.perf:240: sub-make] Error 2
> make: *** [Makefile:113: install-bin] Error 2
> make: Leaving directory '/var/home/acme/git/perf/tools/perf'
> 
>  Performance counter stats for 'make -k BUILD_BPF_SKEL=1 CORESIGHT=1 PYTHON=python3 O=/tmp/build/perf -C tools/perf install-bin':
> 
>     31,749,639,340      cycles:u
>     57,052,398,827      instructions:u            #    1.80  insn per cycle
> 
>        2.123830023 seconds time elapsed
> 
>        7.146520000 seconds user
>        1.707080000 seconds sys
> 
> 
> ⬢[acme@toolbox perf]$
> 
> > ---
> >  tools/perf/util/mem-events.c | 22 +++++++++++++++++++---
> >  tools/perf/util/mem-events.h |  1 +
> >  2 files changed, 20 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> > index 5dca1882c284..9de0eb3a1200 100644
> > --- a/tools/perf/util/mem-events.c
> > +++ b/tools/perf/util/mem-events.c
> > @@ -525,6 +525,7 @@ int c2c_decode_stats(struct c2c_stats *stats, struct mem_info *mi)
> >  	u64 op     = data_src->mem_op;
> >  	u64 lvl    = data_src->mem_lvl;
> >  	u64 snoop  = data_src->mem_snoop;
> > +	u64 snoopx = data_src->mem_snoopx;
> >  	u64 lock   = data_src->mem_lock;
> >  	u64 blk    = data_src->mem_blk;
> >  	/*
> > @@ -567,18 +568,28 @@ do {				\
> >  			if (lvl & P(LVL, IO))  stats->ld_io++;
> >  			if (lvl & P(LVL, LFB)) stats->ld_fbhit++;
> >  			if (lvl & P(LVL, L1 )) stats->ld_l1hit++;
> > -			if (lvl & P(LVL, L2 )) stats->ld_l2hit++;
> > +			if (lvl & P(LVL, L2)) {
> > +				stats->ld_l2hit++;
> > +
> > +				if (snoopx & P(SNOOPX, PEER))
> > +					stats->ld_peer++;
> > +			}
> >  			if (lvl & P(LVL, L3 )) {
> >  				if (snoop & P(SNOOP, HITM))
> >  					HITM_INC(lcl_hitm);
> >  				else
> >  					stats->ld_llchit++;
> > +
> > +				if (snoopx & P(SNOOPX, PEER))
> > +					stats->ld_peer++;
> >  			}
> >  
> >  			if (lvl & P(LVL, LOC_RAM)) {
> >  				stats->lcl_dram++;
> >  				if (snoop & P(SNOOP, HIT))
> >  					stats->ld_shared++;
> > +				else if (snoopx & P(SNOOPX, PEER))
> > +					stats->ld_peer++;
> >  				else
> >  					stats->ld_excl++;
> >  			}
> > @@ -597,10 +608,14 @@ do {				\
> >  		if ((lvl & P(LVL, REM_CCE1)) ||
> >  		    (lvl & P(LVL, REM_CCE2)) ||
> >  		     mrem) {
> > -			if (snoop & P(SNOOP, HIT))
> > +			if (snoop & P(SNOOP, HIT)) {
> >  				stats->rmt_hit++;
> > -			else if (snoop & P(SNOOP, HITM))
> > +			} else if (snoop & P(SNOOP, HITM)) {
> >  				HITM_INC(rmt_hitm);
> > +			} else if (snoopx & P(SNOOPX, PEER)) {
> > +				stats->rmt_hit++;
> > +				stats->ld_peer++;
> > +			}
> >  		}
> >  
> >  		if ((lvl & P(LVL, MISS)))
> > @@ -661,6 +676,7 @@ void c2c_add_stats(struct c2c_stats *stats, struct c2c_stats *add)
> >  	stats->ld_l1hit		+= add->ld_l1hit;
> >  	stats->ld_l2hit		+= add->ld_l2hit;
> >  	stats->ld_llchit	+= add->ld_llchit;
> > +	stats->ld_peer		+= add->ld_peer;
> >  	stats->lcl_hitm		+= add->lcl_hitm;
> >  	stats->rmt_hitm		+= add->rmt_hitm;
> >  	stats->tot_hitm		+= add->tot_hitm;
> > diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
> > index 8a8b568baeee..4879b841c841 100644
> > --- a/tools/perf/util/mem-events.h
> > +++ b/tools/perf/util/mem-events.h
> > @@ -75,6 +75,7 @@ struct c2c_stats {
> >  	u32	ld_l1hit;            /* count of loads that hit L1D */
> >  	u32	ld_l2hit;            /* count of loads that hit L2D */
> >  	u32	ld_llchit;           /* count of loads that hit LLC */
> > +	u32	ld_peer;             /* count of loads that hit peer core or cluster cache */
> >  	u32	lcl_hitm;            /* count of loads with local HITM  */
> >  	u32	rmt_hitm;            /* count of loads with remote HITM */
> >  	u32	tot_hitm;            /* count of loads with local and remote HITM */
> > -- 
> > 2.25.1
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
