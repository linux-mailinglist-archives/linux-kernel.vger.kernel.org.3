Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618D952546E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 20:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357466AbiELSGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 14:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243594AbiELSGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 14:06:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D818A4A3C9
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 11:06:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62B61615FA
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 18:06:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 195E3C385B8;
        Thu, 12 May 2022 18:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652378795;
        bh=Z83eG3p+kTpRWNVo3X1S7ImubJc9khpP2Bx1OiOMN18=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kCp0SYUU/LJxTqwunAMws1EkGrUVJNlkWLPl0A0JxAUdjPYvT0yQT//j42UwOeYZd
         +rVQQDwLUPSdFMZOGa01Mj6vqlu7jYJws/HW2fxII5HY5Ubx18bp9sh5BfVjB3Xxzh
         WDBPAGEYTnCbxtVV03WBDLF8G5D3NVaiGQGzO8Jc=
Date:   Thu, 12 May 2022 11:06:34 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Aaron Lu <aaron.lu@intel.com>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        kernel test robot <oliver.sang@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        fengwei.yin@intel.com, linux-mm@kvack.org
Subject: Re: [mm/page_alloc] f26b3fa046: netperf.Throughput_Mbps -18.0%
 regression
Message-Id: <20220512110634.712057e4663ecc5f697bf185@linux-foundation.org>
In-Reply-To: <CAHk-=whmeWNC-YH_cGRofdW3Spt8Y5nfWpoX=CipQ5pBYgnt2g@mail.gmail.com>
References: <YnXnLuYjmEWdVyBP@ziqianlu-desk1>
        <ae763d63e50d14650c5762103d113934412bef57.camel@intel.com>
        <ba83270a-4f37-7d5a-b37a-0b7a6df5f5b4@intel.com>
        <d13688d1483e9d87ec477292893f2916832b3bdc.camel@intel.com>
        <c11ae803-cea7-8b7f-9992-2f640c90f104@intel.com>
        <37dac785a08e3a341bf05d9ee35f19718ce83d26.camel@intel.com>
        <CAHk-=wjguW5nxjagV99GHvc_-E_7mSg+LMvGtFjJ9LUSx4Skig@mail.gmail.com>
        <41c08a5371957acac5310a2e608b2e42bd231558.camel@intel.com>
        <YnuYV3J2ljY88DyQ@ziqianlu-desk1>
        <dfc98503b11e2e54a5a82c21b8ef6afa10eda9b7.camel@intel.com>
        <Yn0BeRaUC9ailyzz@ziqianlu-desk1>
        <CAHk-=whmeWNC-YH_cGRofdW3Spt8Y5nfWpoX=CipQ5pBYgnt2g@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 May 2022 10:42:09 -0700 Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, May 12, 2022 at 5:46 AM Aaron Lu <aaron.lu@intel.com> wrote:
> >
> > When nr_process=16, zone lock contention increased about 21% from 6% to
> > 27%, performance dropped 17.8%, overall lock contention increased 14.3%:
> 
> So the contention issue seems real and nasty, and while the queued
> locks may have helped a bit, I don't think they ended up making a
> *huge* change: the queued locks help make sure the lock itself doesn't
> bounce all over the place, but clearly if the lock holder writes close
> to the lock, it will still bounce with at least *one* lock waiter.
> 
> And having looked at the qspinlock code, I have to agree with Waiman
> and PeterZ that I don't think the locking code can reasonably eb
> changed - I'm sure this particular case could be improved, but the
> downsides for other cases would be quite large enough to make that a
> bad idea.
> 
> So I think the issue is that
> 
>  (a) that zone lock is too hot.
> 
>  (b) given lock contention, the fields that get written to under the
> lock are too close to the lock
> 
> Now, the optimal fix would of course be to just fix the lock so that
> it isn't so hot. But assuming that's not possible, just looking at the
> definition of that 'struct zone', I do have to say that the
> ZONE_PADDING fields seem to have bit-rotted over the years.
> 
> The whole and only reason for them would be to avoid the cache
> bouncing, but commit 6168d0da2b47 ("mm/lru: replace pgdat lru_lock
> with lruvec lock") actively undid that for the 'lru_lock' case, and
> way back when commit a368ab67aa55 ("mm: move zone lock to a different
> cache line than order-0 free page lists") tried to make it true for
> the 'lock' vs free_area[] cases, but did it without actually using the
> ZONE_PADDING thing, but by moving things around, and not really
> *guaranteeing* that 'lock' was in a different cacheline, but really
> just making 'free_area[]' aligned, but still potentially in the same
> cache-line as 'lock' (so now the lower-order 'free_area[]' entries are
> not sharing a cache-line, but the higher-order 'free_area[]' ones
> probably are).
> 
> So I get the feeling that those 'ZONE_PADDING' things are a bit random
> and not really effective.
> 
> In a perfect world, somebody would fix the locking to just not have as
> much contention. But assuming that isn't an option, maybe somebody
> should just look at that 'struct zone' layout a bit more.

(hopefully adds linux-mm to cc)
