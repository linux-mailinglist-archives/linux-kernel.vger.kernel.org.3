Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90924E8113
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 14:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbiCZNcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 09:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiCZNcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 09:32:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591D2DFB9;
        Sat, 26 Mar 2022 06:30:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0EC1B802BD;
        Sat, 26 Mar 2022 13:30:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37BE2C2BBE4;
        Sat, 26 Mar 2022 13:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648301434;
        bh=NyuGf8K5/oZMvDcUwcrdiQlO2P8PFwGIswM7cxqDaRE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fH3uZyYe9KXPYp3FSg7/S6FuQSWQ3zf8pUJdx/Me7vFSo2s6RJQ728FSEDLYDvTq1
         GZyqR+NM3ZOlb2Z4mLWO4fj6lajqQNj3l37Kxh96qHfDQvuYBD1NkCpdbDmnhKOJtc
         Nb20kJuszKUbtuAOOfmRr4d2XPSpDXoM1zs3ZVMOD57K2A1QQrtQkWxGryxbrNdbaQ
         w7QKatxJTs5vBXzt+9WTnkY0TgVfNxpsGW2h6hI+TcrwNCmp32qi+49p4EJ+6vH6/l
         2gH65j7rACTxgkhm+BGeGWe6KAtEijwEz+rXp+0/DH9M2EJNVrKwd/ecAg/D+bkKDf
         3TmdUgaVEiB2Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 13E1840407; Sat, 26 Mar 2022 10:30:31 -0300 (-03)
Date:   Sat, 26 Mar 2022 10:30:31 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Ali Saidi <alisaidi@amazon.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, german.gomez@arm.com,
        benh@kernel.crashing.org, Nick.Forrington@arm.com,
        alexander.shishkin@linux.intel.com, andrew.kilroy@arm.com,
        james.clark@arm.com, john.garry@huawei.com, jolsa@kernel.org,
        kjain@linux.ibm.com, lihuafei1@huawei.com, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH v4 4/4] perf mem: Support HITM for when mem_lvl_num is any
Message-ID: <Yj8Vd2vsw8yJ8b4x@kernel.org>
References: <20220324183323.31414-1-alisaidi@amazon.com>
 <20220324183323.31414-5-alisaidi@amazon.com>
 <20220326062303.GC20556@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220326062303.GC20556@leoy-ThinkPad-X240s>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Mar 26, 2022 at 02:23:03PM +0800, Leo Yan escreveu:
> On Thu, Mar 24, 2022 at 06:33:23PM +0000, Ali Saidi wrote:
> > For loads that hit in a the LLC snoop filter and are fulfilled from a
> > higher level cache on arm64 Neoverse cores, it's not usually clear what
> > the true level of the cache the data came from (i.e. a transfer from a
> > core could come from it's L1 or L2). Instead of making an assumption of
> > where the line came from, add support for incrementing HITM if the
> > source is CACHE_ANY.
> > 
> > Since other architectures don't seem to populate the mem_lvl_num field
> > here there shouldn't be a change in functionality.
> > 
> > Signed-off-by: Ali Saidi <alisaidi@amazon.com>
> > Tested-by: German Gomez <german.gomez@arm.com>
> > Reviewed-by: German Gomez <german.gomez@arm.com>
> > ---
> >  tools/perf/util/mem-events.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> > index e5e405185498..084977cfebef 100644
> > --- a/tools/perf/util/mem-events.c
> > +++ b/tools/perf/util/mem-events.c
> > @@ -539,6 +539,15 @@ do {				\
> >  					stats->ld_llchit++;
> >  			}
> >  
> > +			/*
> > +			 * A hit in another cores cache must mean a llc snoop
> > +			 * filter hit
> > +			 */
> > +			if (lnum == P(LVLNUM, ANY_CACHE)) {
> > +				if (snoop & P(SNOOP, HITM))
> > +					HITM_INC(lcl_hitm);
> > +			}
> 
> This might break the memory profiling result for x86, see file
> arch/x86/events/intel/ds.c:
> 
>   97 void __init intel_pmu_pebs_data_source_skl(bool pmem)
>   98 {
>   99         u64 pmem_or_l4 = pmem ? LEVEL(PMEM) : LEVEL(L4);
>   ...
>  105         pebs_data_source[0x0d] = OP_LH | LEVEL(ANY_CACHE) | REM | P(SNOOP, HITM);
>  106 }
> 
> Which means that it's possible that it's a remote access and the cache
> level is ANY_CACHE, it's good to add checking for bit
> PERF_MEM_REMOTE_REMOTE:
> 
> 	u64 remote = data_src->mem_remote;
> 
> 	/*
> 	 * A hit in another cores cache must mean a llc snoop
> 	 * filter hit
> 	 */
> 	if (lnum == P(LVLNUM, ANY_CACHE) && remote != P(REMOTE, REMOTE)) {
> 	        if (snoop & P(SNOOP, HITM))
> 	                HITM_INC(lcl_hitm);
> 	}
> 
> Appreciate German's reviewing and testing, and sorry I jumped in very
> late.

I have not published this on perf/core, its just in tmp.perf/core while
tests ran, so I'll remove this specific patch and rerun tests, thanks
for reviewing.

- Arnaldo
