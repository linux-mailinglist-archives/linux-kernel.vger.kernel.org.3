Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C2B52294B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 03:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240924AbiEKB6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 21:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240919AbiEKB6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 21:58:34 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25354A3CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 18:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652234311; x=1683770311;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iN1Fkrsl+QmnVro/odOcjaQezWH2OHwK6t9GN9q9rpM=;
  b=VKrUYYtFQyc1FZnuoA126Y7M5dXwQ0ej8nhJRbBjNMsBx+bObJfQqWNY
   u23nPPpQyDehi+euRW3qcl2S40ccO1TdNiyd/grGCy5KKtd2C7TExCWDI
   sTUBSHibGn31v/k4RRjzWYVJ2/r8Oo6r+QT1QHfaetZq5131xDx/FWhYd
   JkMGQTl1dDCG4yX/0722iAtWDbRtHcmQXAuDUORQYiKJNjgx8OlAYtIjq
   po57DP3A0ZHulk/84bHA4AlWAm4UJEipW1tR6C3aOwuFrzlVon+OdrIls
   LEgAP6gEaCIIYRA3czRNu8PxeIbvaCPoLUw6hK/aJKv8SlpTUzUgETDpb
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="268393321"
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="268393321"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 18:58:31 -0700
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="593856606"
Received: from rliu1-mobl1.ccr.corp.intel.com ([10.254.213.20])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 18:58:26 -0700
Message-ID: <41c08a5371957acac5310a2e608b2e42bd231558.camel@intel.com>
Subject: Re: [mm/page_alloc] f26b3fa046: netperf.Throughput_Mbps -18.0%
 regression
From:   "ying.huang@intel.com" <ying.huang@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Cc:     Aaron Lu <aaron.lu@intel.com>,
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
Date:   Wed, 11 May 2022 09:58:23 +0800
In-Reply-To: <CAHk-=wjguW5nxjagV99GHvc_-E_7mSg+LMvGtFjJ9LUSx4Skig@mail.gmail.com>
References: <20220420013526.GB14333@xsang-OptiPlex-9020>
         <YmvMDyx05UoPFtQy@ziqianlu-desk1>
         <bd3db4de223a010d1e06013e93b09879fc9b36a8.camel@intel.com>
         <YnURx04+hE0sQ3v3@ziqianlu-desk1>
         <7d20a9543f69523cfda280e3f5ab17d68db037ab.camel@intel.com>
         <YnXnLuYjmEWdVyBP@ziqianlu-desk1>
         <ae763d63e50d14650c5762103d113934412bef57.camel@intel.com>
         <ba83270a-4f37-7d5a-b37a-0b7a6df5f5b4@intel.com>
         <d13688d1483e9d87ec477292893f2916832b3bdc.camel@intel.com>
         <c11ae803-cea7-8b7f-9992-2f640c90f104@intel.com>
         <37dac785a08e3a341bf05d9ee35f19718ce83d26.camel@intel.com>
         <CAHk-=wjguW5nxjagV99GHvc_-E_7mSg+LMvGtFjJ9LUSx4Skig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-05-10 at 11:05 -0700, Linus Torvalds wrote:
> [ Adding locking people in case they have any input ]
> 
> On Mon, May 9, 2022 at 11:23 PM ying.huang@intel.com
> <ying.huang@intel.com> wrote:
> > 
> > > 
> > > Can you point me to the regression report? I would like to take a look,
> > > thanks.
> > 
> > https://lore.kernel.org/all/1425108604.10337.84.camel@linux.intel.com/
> 
> Hmm.
> 
> That explanation looks believable, except that our qspinlocks
> shouldn't be spinning on the lock itself, but spinning on the mcs node
> it inserts into the lock.

The referenced regression report is very old (in Feb 2015 for 3.16-
3.17).  The ticket spinlock was still used at that time.  I believe that
things become much better after we used qspinlock.  We can test that.

Best Regards,
Huang, Ying

