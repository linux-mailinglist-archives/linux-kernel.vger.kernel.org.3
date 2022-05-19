Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8889152CF63
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 11:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236047AbiESJ3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 05:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbiESJ3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 05:29:18 -0400
Received: from outbound-smtp30.blacknight.com (outbound-smtp30.blacknight.com [81.17.249.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452CA65433
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 02:29:17 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp30.blacknight.com (Postfix) with ESMTPS id BA6B4BABEE
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 10:29:15 +0100 (IST)
Received: (qmail 14602 invoked from network); 19 May 2022 09:29:15 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 19 May 2022 09:29:15 -0000
Date:   Thu, 19 May 2022 10:29:13 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] sched/numa: Adjust imb_numa_nr to a better
 approximation of memory channels
Message-ID: <20220519092913.GU3441@techsingularity.net>
References: <20220511143038.4620-1-mgorman@techsingularity.net>
 <20220511143038.4620-5-mgorman@techsingularity.net>
 <20220518094112.GE10117@worktop.programming.kicks-ass.net>
 <20220518111539.GP3441@techsingularity.net>
 <YoT9D0YGlWwHQMQi@hirez.programming.kicks-ass.net>
 <20220518170625.GT3441@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220518170625.GT3441@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 06:06:25PM +0100, Mel Gorman wrote:
> I'm running the tests to recheck exactly how much impact this patch has
> on the peak performance. It takes a few hours so I won't have anything
> until tomorrow.
> 

It wasn't my imagination, the last path was worth a few percent

v5.3                                     Min  95.84 Max  96.55 Range   0.71 Mean  96.16
v5.7                                     Min  95.44 Max  96.51 Range   1.07 Mean  96.14
v5.8                                     Min  96.02 Max 197.08 Range 101.06 Mean 154.70
v5.12                                    Min 104.45 Max 111.03 Range   6.58 Mean 105.94
v5.13                                    Min 104.38 Max 170.37 Range  65.99 Mean 117.35
v5.13-revert-c6f886546cb8                Min 104.40 Max 110.70 Range   6.30 Mean 105.68
v5.18rc4-baseline                        Min 110.78 Max 169.84 Range  59.06 Mean 131.22
v5.18rc4-revert-c6f886546cb8             Min 113.98 Max 117.29 Range   3.31 Mean 114.71
v5.18rc4-shiftimb3-v2r2                  Min  95.34 Max 165.75 Range  70.41 Mean 120.92
v5.18rc4-consistimb-v2r2                 Min 104.02 Max 175.22 Range  71.20 Mean 116.62
v5.18rc4-consistimb-revert-c6f886546cb8  Min 104.02 Max 112.56 Range   8.54 Mean 105.52

v5.18rc4-shiftimb3-v2r2  is patches 1-4
v5.18rc4-consistimb-v2r2 is patches 1-3

The last path is worth around 8% and is what's necessary to bring best
performance back to kernel v5.7 levels. As you can see from the range,
the result is unstable but reverting c6f886546cb8 reduces it by a lot.
Not enough to be at v5.7 levels but enough to indicate that the allowed
NUMA balance changes are not the sole source of the problem.

-- 
Mel Gorman
SUSE Labs
