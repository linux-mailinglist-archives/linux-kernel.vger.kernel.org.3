Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9D6508DA2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 18:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380769AbiDTQum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 12:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239724AbiDTQui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:50:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E69E4507F;
        Wed, 20 Apr 2022 09:47:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37FFBB81FB6;
        Wed, 20 Apr 2022 16:47:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0C8C385A0;
        Wed, 20 Apr 2022 16:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650473269;
        bh=ZFEnnoJ0V3bmUpNbtwzofwaKYze8ukC5EiqVvI8/chI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gFLKEXNI7atLTte+D+RjS5mY62ZGdhYdWUzcWdX5tyaAcvNeto4awO7jteIRXntTS
         K+V+Lv9Fahx0ul8Hf49u5gf1QijaJunhK6dCn8ix/R7484RJtO+BlAH8/2JZyHXt5c
         rb2w6FSwJg8xfPMBuiFLxZ6DehuBPrIFnhnn1fu7/Xys1nbMm+wb0X5e2hGZ8zyHHZ
         he2IZVVKSzX/k3jYTPRbOn0XXJYeCjI0fcdiXWt2mBfA3QNd/w6uDWVN0yiavOwbIN
         LzQiaqlQJuE4uHVZ0M5EUNULpQKbxiYTTL5cXMRPQmE8eSGZfXnFwIkzz86Wzi5tig
         Gpz0prn917Acw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 31D9F400B1; Wed, 20 Apr 2022 13:47:46 -0300 (-03)
Date:   Wed, 20 Apr 2022 13:47:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     German Gomez <german.gomez@arm.com>,
        Ali Saidi <alisaidi@amazon.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, benh@kernel.crashing.org,
        Nick.Forrington@arm.com, alexander.shishkin@linux.intel.com,
        andrew.kilroy@arm.com, james.clark@arm.com, john.garry@huawei.com,
        jolsa@kernel.org, kjain@linux.ibm.com, lihuafei1@huawei.com,
        mark.rutland@arm.com, mathieu.poirier@linaro.org, mingo@redhat.com,
        namhyung@kernel.org, peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH v5 5/5] perf mem: Support mem_lvl_num in c2c command
Message-ID: <YmA5MqWxxLCp1Nff@kernel.org>
References: <20220408195344.32764-1-alisaidi@amazon.com>
 <20220408195344.32764-6-alisaidi@amazon.com>
 <3ad0128a-1b3d-37a7-81f6-fd597b565b18@arm.com>
 <20220420084823.GE843168@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420084823.GE843168@leoy-ThinkPad-X240s>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 20, 2022 at 04:48:23PM +0800, Leo Yan escreveu:
> On Mon, Apr 11, 2022 at 11:04:28AM +0100, German Gomez wrote:
> > 
> > On 08/04/2022 20:53, Ali Saidi wrote:
> > > In addition to summarizing data encoded in mem_lvl also support data
> > > encoded in mem_lvl_num.
> > >
> > > Since other architectures don't seem to populate the mem_lvl_num field
> > > here there shouldn't be a change in functionality.
> > >
> > > Signed-off-by: Ali Saidi <alisaidi@amazon.com>
> > > ---
> > >  tools/perf/util/mem-events.c | 11 +++++++----
> > >  1 file changed, 7 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> > > index ed0ab838bcc5..e5e405185498 100644
> > > --- a/tools/perf/util/mem-events.c
> > > +++ b/tools/perf/util/mem-events.c
> > > @@ -485,6 +485,7 @@ int c2c_decode_stats(struct c2c_stats *stats, struct mem_info *mi)
> > >  	u64 daddr  = mi->daddr.addr;
> > >  	u64 op     = data_src->mem_op;
> > >  	u64 lvl    = data_src->mem_lvl;
> > > +	u64 lnum   = data_src->mem_lvl_num;
> > >  	u64 snoop  = data_src->mem_snoop;
> > >  	u64 lock   = data_src->mem_lock;
> > >  	u64 blk    = data_src->mem_blk;
> > > @@ -527,16 +528,18 @@ do {				\
> > >  			if (lvl & P(LVL, UNC)) stats->ld_uncache++;
> > >  			if (lvl & P(LVL, IO))  stats->ld_io++;
> > >  			if (lvl & P(LVL, LFB)) stats->ld_fbhit++;
> > 
> > Just for completion, can we also handle LFB as it seems to be being set
> > in "/arch/x86/events/intel/ds.c"? (Sorry I missed this in the v4)
> 
> With fixing LFB issue pointed by German, the change looks good to me:

Waiting for a v6 then, please collect Leo's reviewed-by tag when
submitting it.

- Arnaldo
 
> Reviewed-by: Leo Yan <leo.yan@linaro.org>
> 
> It would be appreciate if x86 or PowerPC maintainers could take a look
> for this patch.  Thanks!
 

> Leo
> 
> > > -			if (lvl & P(LVL, L1 )) stats->ld_l1hit++;
> > > -			if (lvl & P(LVL, L2 )) stats->ld_l2hit++;
> > > -			if (lvl & P(LVL, L3 )) {
> > > +			if (lvl & P(LVL, L1) || lnum == P(LVLNUM, L1))
> > > +				stats->ld_l1hit++;
> > > +			if (lvl & P(LVL, L2) || lnum == P(LVLNUM, L2))
> > > +				stats->ld_l2hit++;
> > > +			if (lvl & P(LVL, L3) || lnum == P(LVLNUM, L3)) {
> > >  				if (snoop & P(SNOOP, HITM))
> > >  					HITM_INC(lcl_hitm);
> > >  				else
> > >  					stats->ld_llchit++;
> > >  			}
> > >  
> > > -			if (lvl & P(LVL, LOC_RAM)) {
> > > +			if (lvl & P(LVL, LOC_RAM) || lnum == P(LVLNUM, RAM)) {
> > >  				stats->lcl_dram++;
> > >  				if (snoop & P(SNOOP, HIT))
> > >  					stats->ld_shared++;

-- 

- Arnaldo
