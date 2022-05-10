Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13185224BD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 21:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbiEJT2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 15:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241186AbiEJT2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 15:28:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAE356416
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 12:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lsBeHLglJOApYF654Jir26FeEjZ4KihltVOnJfCQAmM=; b=GKSgMglUZZSziABl1xao9QbCdV
        aqxXhDHJ+8IRYN+Xq5ApUGjIzskCJY0HPTaukl7TVbQk1Ii9nAS5I0ZLjfLIZVuCa9+0HnruKfQS8
        ThDgkOAf/CWorsNa+06o6GjrDWpxVNkIEPajpdj7ouBz8aKetOHoHN99PdZKBBMEXdaDoNf9NLimP
        i/oXHlbjNdcy9tM5MQELU5fxUMZKVpjkUHsN+pYzMFlifx6g1rFqQxR+cr0XHOhG+5t+Ucd+TGYU1
        TKFfCItNd7OfSdnhCQBWe8wJB6IMX9N2/N6t3CpZ9vUShr7TuTO7va2ELvPVEnI3WsBdVzdys7Jev
        n5vgRQQw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1noVVm-004jum-DB; Tue, 10 May 2022 19:27:10 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3AE5A98100A; Tue, 10 May 2022 21:27:08 +0200 (CEST)
Date:   Tue, 10 May 2022 21:27:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "ying.huang@intel.com" <ying.huang@intel.com>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>, Aaron Lu <aaron.lu@intel.com>,
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
Subject: Re: [mm/page_alloc] f26b3fa046: netperf.Throughput_Mbps -18.0%
 regression
Message-ID: <20220510192708.GQ76023@worktop.programming.kicks-ass.net>
References: <bd3db4de223a010d1e06013e93b09879fc9b36a8.camel@intel.com>
 <YnURx04+hE0sQ3v3@ziqianlu-desk1>
 <7d20a9543f69523cfda280e3f5ab17d68db037ab.camel@intel.com>
 <YnXnLuYjmEWdVyBP@ziqianlu-desk1>
 <ae763d63e50d14650c5762103d113934412bef57.camel@intel.com>
 <ba83270a-4f37-7d5a-b37a-0b7a6df5f5b4@intel.com>
 <d13688d1483e9d87ec477292893f2916832b3bdc.camel@intel.com>
 <c11ae803-cea7-8b7f-9992-2f640c90f104@intel.com>
 <37dac785a08e3a341bf05d9ee35f19718ce83d26.camel@intel.com>
 <CAHk-=wjguW5nxjagV99GHvc_-E_7mSg+LMvGtFjJ9LUSx4Skig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjguW5nxjagV99GHvc_-E_7mSg+LMvGtFjJ9LUSx4Skig@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 11:05:01AM -0700, Linus Torvalds wrote:

> I think from a pure lock standpoint, it's the right thing to do (no
> unnecessary bouncing, with the lock releaser doing just one write, and
> the head waiter spinning on it is doing the right thing).
> 
> But I think this is an example of where you end up having that
> spinning on the lock possibly then being a disturbance on the other
> fields around the lock.
> 
> I wonder if Waiman / PeterZ / Will have any comments on that. Maybe
> that "spin on the lock itself" is just fundamentally the only correct
> thing, but since my initial reaction was "no, we're spinning on the
> mcs node", maybe that would be _possible_?
> 
> We do have a lot of those spinlocks embedded in other data structures
> cases. And if "somebody else is waiting for the lock" contends badly
> with "the lock holder is doing a lot of writes close to the lock",
> then that's not great.

The immediate problem is that we don't always have a node. Notably we
only do the whole MCS queueing thing when there's more than 1 contender.

Always doing the MCS thing had a hefty performance penalty vs the
simpler spinlock implementations for the uncontended and light contended
lock cases (by far the most common scenario) due to the extra cache-miss
of getting an MCS node.

