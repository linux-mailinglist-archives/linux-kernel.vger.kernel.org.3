Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C68B54A640
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 04:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354475AbiFNCXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 22:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354589AbiFNCT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 22:19:26 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD3C3EF02
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 19:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655172596; x=1686708596;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GHXdnxAmkJg8vHbVZX8LsCB8l7e7AN7h5WDsl3zlNLE=;
  b=XAFX5y6LGsxx1h/sq/tstGmVBdsJUi2yZNfHEu/EqJetCmSAapmoWEio
   tsbDfvl6C55CWd0720+gz6doRKVJaFEGT1zjBMZ8l+EOv+bIhP3Blzzjm
   Hgk+S6KFVQUJz/qwaIkvMC8hHKUDWXKt+8c4vxeeIpt4dJ+JKxBj6KiJr
   UAhX0e8qcb2osLJAKtFJctcAK1WQhCnAOQAjoz+nvi585Aa8PlVXaiVqB
   Z5fI2evqkkmcEUsNvmk0vQU6Nlv7OqfJJNjmCwEb5pGiW99tDnvzt3ymv
   jDoq4a6PuOVUHTvvmWUrr4LiSG78bXvIFcbcAdMXjfmaMzDgNXiEsu160
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="277249060"
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="277249060"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 19:09:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="673606654"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.138])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Jun 2022 19:09:30 -0700
Date:   Tue, 14 Jun 2022 10:09:30 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Lu, Aaron" <aaron.lu@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Sang, Oliver" <oliver.sang@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>, lkp <lkp@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [mm/page_alloc] f26b3fa046: netperf.Throughput_Mbps -18.0%
 regression
Message-ID: <20220614020930.GA31620@shbuild999.sh.intel.com>
References: <c11ae803-cea7-8b7f-9992-2f640c90f104@intel.com>
 <37dac785a08e3a341bf05d9ee35f19718ce83d26.camel@intel.com>
 <CAHk-=wjguW5nxjagV99GHvc_-E_7mSg+LMvGtFjJ9LUSx4Skig@mail.gmail.com>
 <41c08a5371957acac5310a2e608b2e42bd231558.camel@intel.com>
 <YnuYV3J2ljY88DyQ@ziqianlu-desk1>
 <dfc98503b11e2e54a5a82c21b8ef6afa10eda9b7.camel@intel.com>
 <Yn0BeRaUC9ailyzz@ziqianlu-desk1>
 <CAHk-=whmeWNC-YH_cGRofdW3Spt8Y5nfWpoX=CipQ5pBYgnt2g@mail.gmail.com>
 <20220512110634.712057e4663ecc5f697bf185@linux-foundation.org>
 <CAHk-=wiyjnKiCZyou+fHYi7tNh1FC-BYy_kubusd+jrkDRsExA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiyjnKiCZyou+fHYi7tNh1FC-BYy_kubusd+jrkDRsExA@mail.gmail.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Fri, May 13, 2022 at 02:49:53AM +0800, Linus Torvalds wrote:
> On Thu, May 12, 2022 at 11:06 AM Andrew Morton
> <akpm@linux-foundation.org> wrote:
> >
> > On Thu, 12 May 2022 10:42:09 -0700 Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > >
> > > In a perfect world, somebody would fix the locking to just not have as
> > > much contention. But assuming that isn't an option, maybe somebody
> > > should just look at that 'struct zone' layout a bit more.
> >
> > (hopefully adds linux-mm to cc)
> 
> So I suspect the people who do re-layout would have to be the intel
> people who actually see the regression.
> 
> Because the exact rules are quite complicated, and currently the
> comments about the layout don't really help much.

We've re-run some cases which could trigger zone lock contention: 
page_fault1 and page_fault2 case of 'will-it-scale'. From the test
results:

* The commit a368ab67aa55 ("mm: move zone lock to a different cache
  line than order-0 free page lists") is still valid, that if we
  revert it, there will be 9% ~ 26% regression for different 2/4
  sockets machines (page_fault1 case)

* With a368ab67aa55 reverted that zone lock sits in the same cache
  line as free_area[0], we tested with 1-thread case (no contention),
  which showed no performance diff. Maybe in this microbenchmark,
  one cacheline or two cache lines doesn't matter much.

* For the higher order 'free_area[]' in same cacheline as lock problem,
  it's a valid concern, but we haven't found case in 0Day to expose the
  cache bouncing. Network uses order-3 frequently, but it sits in the
  middle of the free_area[] array, and has no interference with 'lock'

  Another thing is the 'flag' and the 'lock' are still in the same
  cacheline, and perf-c2c does catch some false sharing between them.

  So adding a padding between 'flag' and 'lock' should help the 2 cases  
  above (except the 'adjacent cacheline prefetch' concern)

  @@ -634,6 +634,7 @@ struct zone {
	/* free areas of different sizes */
	struct free_area	free_area[MAX_ORDER];
		
	/* zone flags, see below */
	unsigned long		flags;
	 
  +	ZONE_PADDING(_pad4_)
	/* Primarily protects free_area */
	spinlock_t		lock;

  But this patch only shows some small(<=%3) improvement or even some
  regressions. We also tried putting aligned 'lock' in the start/end
  of structure 'zone', and the performance data is similar .

* While checking this, we found that the lruvec structure also has a
  similar layout pattern with similar false sharing (confirmed by
  perf c2c data)

   struct lruvec {
	struct list_head		lists[NR_LRU_LISTS];
	/* per lruvec lru_lock for memcg */
	spinlock_t			lru_lock;
	...
   }

   Anyway this should be put into anothe thread :)

> For example, the "Read-mostly fields" comment doesn't necessarily mean
> that the fields in question should be kept away from the lock.
> 
> Even if they are mostly read-only, if they are only read *under* the
> lock (because the lock still is what serializes them), then putting
> them in the same cacheline as the lock certainly won't hurt.
 
I Agree. And for structure zone, IIUC, these read-mostly fields at the
start of the structure are mostly read outside the lock's protection,
like the '_watermark', 'lowmem_reserve', so current layout seems to be
fine. 

> And the same is actually true of things that are actively written to:
> if they are written to under the lock, being in the same cacheline as
> the lock can be a *good* thing, since then you have only one dirty
> cacheline.
> 
> It only becomes a problem when (a) the lock is contended (so you get
> the bouncing from other lockers trying to get it) _and_ (b) the
> writing is fairly intense (so you get active bouncing back-and-forth,
> not just one or two bounces).
> 
> And so to actually do any real analysis, you probably have to have
> multiple sockets, because without numbers to guide you to exactly
> _which_ writes are problematic, you're bound to get the heuristic
> wrong.
> 
> And to make the issue even murkier, this whole thread is mixing up two
> different regressions that may not have all that much in common (ie
> the subject line is about one thing, but then we have that whole
> page_fault1 process mode results, and it's not clear that they have
> anything really to do with each other - just different examples of
> cache sensitivity).
 
In above tests, we only focused on the cache false sharing of the fields
of struct zone, and may likely have missed some of your concerns. Please
let us know if we went in wrong direction or want us to run some specific
tests (we do have difficulties in finding more real-world like cases
which can trigger the zone lock contentions than will-it-scale)

Thanks,
Feng

>                    Linus
