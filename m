Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28C952BEEC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 18:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239503AbiERPkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 11:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239494AbiERPjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 11:39:52 -0400
Received: from outbound-smtp03.blacknight.com (outbound-smtp03.blacknight.com [81.17.249.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168B9163F66
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 08:39:50 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp03.blacknight.com (Postfix) with ESMTPS id 5FA68C0AF9
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 16:39:49 +0100 (IST)
Received: (qmail 812 invoked from network); 18 May 2022 15:39:49 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 18 May 2022 15:39:49 -0000
Date:   Wed, 18 May 2022 16:39:47 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] sched/numa: Apply imbalance limitations consistently
Message-ID: <20220518153947.GS3441@techsingularity.net>
References: <20220511143038.4620-1-mgorman@techsingularity.net>
 <20220511143038.4620-4-mgorman@techsingularity.net>
 <20220518093156.GD10117@worktop.programming.kicks-ass.net>
 <20220518104652.GO3441@techsingularity.net>
 <YoT7xtVc0f3DVCKL@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <YoT7xtVc0f3DVCKL@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 03:59:34PM +0200, Peter Zijlstra wrote:
> On Wed, May 18, 2022 at 11:46:52AM +0100, Mel Gorman wrote:
> 
> > > (Although I do wonder about that 25% figure in the comment; that doesn't
> > > seem to relate to any actual code anymore)
> > > 
> > 
> > You're right, by the end of the series it's completely inaccurate and
> > currently it's not accurate if there are multiple LLCs per node. I
> > adjusted the wording to "Allow a NUMA imbalance if busy CPUs is less
> > than the maximum threshold. Above this threshold, individual tasks may
> > be contending for both memory bandwidth and any shared HT resources."
> > 
> 
> Looks good. Meanwhile I saw a 0-day complaint that this regresses
> something something unixbench by a bit. Do we care enough? I suppose
> this is one of those trade-off patches again, win some, loose some.

I think it's a trade-off. I made a more complete response to the 0-day
people at https://lore.kernel.org/all/20220518152258.GR3441@techsingularity.net/

-- 
Mel Gorman
SUSE Labs
