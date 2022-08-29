Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA035A4D1A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiH2NLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiH2NKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:10:53 -0400
Received: from outbound-smtp11.blacknight.com (outbound-smtp11.blacknight.com [46.22.139.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3346125B
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 06:09:45 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp11.blacknight.com (Postfix) with ESMTPS id 55C001C3CFE
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:09:43 +0100 (IST)
Received: (qmail 4219 invoked from network); 29 Aug 2022 13:08:36 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 29 Aug 2022 13:08:36 -0000
Date:   Mon, 29 Aug 2022 14:08:31 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] sched/fair: ignore SIS_UTIL when has idle core
Message-ID: <20220829130831.odhemmcmuecqxkbz@techsingularity.net>
References: <20220712082036.5130-1-wuyun.abel@bytedance.com>
 <20220712082036.5130-2-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220712082036.5130-2-wuyun.abel@bytedance.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 04:20:32PM +0800, Abel Wu wrote:
> When SIS_UTIL is enabled, SIS domain scan will be skipped if
> the LLC is overloaded. Since the overloaded status is checked
> in the load balancing at LLC level, the interval is llc_size
> miliseconds. The duration might be long enough to affect the
> overall system throughput if idle cores are out of reach in
> SIS domain scan.
> 
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>

Split this patch to move the this_sd lookup into the SIS_PROP section.

Otherwise, this is the most controversial patch in the series and the
most likely to cause problems where it wins on some machines and
workloads and loses on others.

The corner case to worry about is a workload that is rapidly idling and
the has_idle_core hint is often wrong. This can happen with hackbench for
example, or at least this was true when I last looked which is quite some
time ago. If this hint is often wrong, then there will be full scan cost
incurred regardless of SIS_UTIL that often fails to find a core.

So, first suggestion is to move this patch to the end of the series as
the other patches are relatively harmless. They could even be merged in
isolation as a cleanup.

Second, using the other patches as your baseline, include in the
changelog what you tested that showed a benefit, what type of machine
it was and in particular include the number of cores, nodes and the
span of the LLC.  If you measured any regressions, include that as well
and make a call on whether you think the patch wins more than it loses.
The reason to include that information is because the worst corner case
(all CPUs scanned uselessly) costs more the larger the span of LLC is.
If all the testing was done on a 2-core SMT-2 machine, the overhead of the
patch would be negligible but very different if the LLC span is 20 cores.
While the patch is not obviously wrong, it definitely needs better data,
Even if you do not have a large test machine available, it's still helpful
to have it in the changelog because a reviewer like me can decide "this
needs testing on a larger machine".

I did queue this up the entire series for testing and while it sometimes
benefitted, there were large counter-examples. tbench4 on Zen3 showed some
large regressions (e.g. 41% loss on 64 clients with a massive increase in
variability) which has multiple small L3 caches per node. tbench4 (slightly
modified in mmtests to produce a usable metric) in general showed issues
across multiple x86-64 machines both AMD and Intel, multiple generations
with a noticable increase in system CPU usage when the client counts reach
the stage where the machine is close to saturated. perfpipe for some
weird reason showed a large regression apparent regresion on Broadwell
but the variability was also crazy so probably can be ignored. hackbench
overall looked ok so it's possible I'm wrong about the idle_cores hint
being often wrong on that workload and I should double check that. It's
possible the hint is wrong some of the times but right often enough to
either benefit from using an idle core or by finding an idle sibling which
may be preferable to stacking tasks on the same CPU.

The lack of data and the lack of a note on the potential downside is the
main reason why I'm not acking patch. tbench4 was a particular concern on
my own tests and it's possible a better patch would be a hybrid approach
where a limited search of two cores (excluding target) is allowed even if
SIS_UTIL indicates overload but has_idle_cores is true.

-- 
Mel Gorman
SUSE Labs
