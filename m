Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1D9524324
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 05:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245246AbiELDRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 23:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242503AbiELDRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 23:17:15 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4797C67D2F
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 20:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652325434; x=1683861434;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+4HfjcGMEpRvoXkWye5b+0bVYRxYpRWz8eb2MDT4nyg=;
  b=f8e0q76dpZsA47QI+zCmH+31uItT26X2aIbNlpLmUTAneSIk41CLCfm9
   Kekh3mTDSJdxOxX31Trv4NrM2RAtxO6gYYmGBOgAtdjJ9KxyaFXM8PBzJ
   zGMZnaPyh6fzzAVjTR9JCS3xrslBBtkl1gbU6Pdu2e99fWw3uCyI0o/VH
   ouvxtFuCRH2Xe6EIP9xDAUxRMIHAUqKZr/8VnwdDVKTQ1S7dLYonYdMxS
   IavjVitQD1LYa5qBB4jn9+KZ3WPpBb8cIrdXGwiipVE0/42NhaFWrp2KZ
   gcAjA5HVCG0EOMv4XxSrqK+Z9alzkXlMCmRLFmC9X0GZj1fQXu8Vg3ng+
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="267460418"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="267460418"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 20:17:13 -0700
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="594454884"
Received: from ruonanwa-mobl.ccr.corp.intel.com ([10.254.212.157])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 20:17:08 -0700
Message-ID: <dfc98503b11e2e54a5a82c21b8ef6afa10eda9b7.camel@intel.com>
Subject: Re: [mm/page_alloc] f26b3fa046: netperf.Throughput_Mbps -18.0%
 regression
From:   "ying.huang@intel.com" <ying.huang@intel.com>
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        kernel test robot <oliver.sang@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        fengwei.yin@intel.com
Date:   Thu, 12 May 2022 11:17:04 +0800
In-Reply-To: <YnuYV3J2ljY88DyQ@ziqianlu-desk1>
References: <YnURx04+hE0sQ3v3@ziqianlu-desk1>
         <7d20a9543f69523cfda280e3f5ab17d68db037ab.camel@intel.com>
         <YnXnLuYjmEWdVyBP@ziqianlu-desk1>
         <ae763d63e50d14650c5762103d113934412bef57.camel@intel.com>
         <ba83270a-4f37-7d5a-b37a-0b7a6df5f5b4@intel.com>
         <d13688d1483e9d87ec477292893f2916832b3bdc.camel@intel.com>
         <c11ae803-cea7-8b7f-9992-2f640c90f104@intel.com>
         <37dac785a08e3a341bf05d9ee35f19718ce83d26.camel@intel.com>
         <CAHk-=wjguW5nxjagV99GHvc_-E_7mSg+LMvGtFjJ9LUSx4Skig@mail.gmail.com>
         <41c08a5371957acac5310a2e608b2e42bd231558.camel@intel.com>
         <YnuYV3J2ljY88DyQ@ziqianlu-desk1>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-05-11 at 19:04 +0800, Aaron Lu wrote:
> On Wed, May 11, 2022 at 09:58:23AM +0800, ying.huang@intel.com wrote:
> > On Tue, 2022-05-10 at 11:05 -0700, Linus Torvalds wrote:
> > > [ Adding locking people in case they have any input ]
> > > 
> > > On Mon, May 9, 2022 at 11:23 PM ying.huang@intel.com
> > > <ying.huang@intel.com> wrote:
> > > > 
> > > > > 
> > > > > Can you point me to the regression report? I would like to take a look,
> > > > > thanks.
> > > > 
> > > > https://lore.kernel.org/all/1425108604.10337.84.camel@linux.intel.com/
> > > 
> > > Hmm.
> > > 
> > > That explanation looks believable, except that our qspinlocks
> > > shouldn't be spinning on the lock itself, but spinning on the mcs node
> > > it inserts into the lock.
> > 
> > The referenced regression report is very old (in Feb 2015 for 3.16-
> > 3.17).  The ticket spinlock was still used at that time.  I believe that
> > things become much better after we used qspinlock.  We can test that.
> 
> 'will-it-scale/page_fault1 process mode' can greatly stress both zone
> lock and LRU lock when nr_process = nr_cpu with thp disabled. So I run
> it to see if it still makes a difference with qspinlock.
> https://github.com/antonblanchard/will-it-scale/blob/master/tests/page_fault1.c
> 
> The result on an Icelake 2 sockets server with a total of 48cores/96cpus:
> 
> tbox_group/testcase/rootfs/kconfig/compiler/nr_task/mode/test/thp_enabled/cpufreq_governor/ucode:
>   lkp-icl-2sp4/will-it-scale/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-11/100%/process/page_fault1/never/performance/0xd000331
> 
> commit:
>   v5.18-rc4
>   731a704c0d8760cfd641af4bf57167d8c68f9b99
> 
>        v5.18-rc4 731a704c0d8760cfd641af4bf57
> ---------------- ---------------------------
>          %stddev     %change         %stddev
> 	     \          |                \
>   12323894           -26.0%    9125299        will-it-scale.128.processes
> 
>      22.33 ±  4%     -22.3        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.release_pages.tlb_flush_mmu
>       9.80            -9.2        0.57 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__pagevec_lru_add.folio_add_lru
>      36.25            +6.7       42.94        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.rmqueue_bulk.rmqueue.get_page_from_freelist
>       4.28 ± 10%     +34.6       38.93        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.free_pcppages_bulk.free_unref_page_list.release_pages
>      75.05            +7.8       82.83        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
> 
> commit 731a704c0d8760cfd641af4bf57 moves zone's lock back to above
> free_area by reverting commit a368ab67aa55("mm: move zone lock to a
> different cache line than order-0 free page lists") on top of v5.18-rc4.
> 
> The interpretation of the above result is: after the revert, performance
> dropped 26%, zone lock increased 41% from 40% to 81%, the overall lock
> contention increased 7.8% from 75% to 82.83%. So it appears it still
> makes a difference with qspinlock.

The performance impact is larger than what I have thought before.  The
test may be too stressing to be realistic?  Can you run the test with
less process number to check?

Best Regards,
Huang, Ying


