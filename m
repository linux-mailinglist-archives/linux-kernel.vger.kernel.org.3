Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B626C5AFF94
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 10:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiIGIu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 04:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiIGIuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 04:50:51 -0400
Received: from outbound-smtp40.blacknight.com (outbound-smtp40.blacknight.com [46.22.139.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24CA6CD0D
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 01:50:48 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp40.blacknight.com (Postfix) with ESMTPS id 76E091C4147
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 09:41:41 +0100 (IST)
Received: (qmail 27017 invoked from network); 7 Sep 2022 08:41:41 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 7 Sep 2022 08:41:41 -0000
Date:   Wed, 7 Sep 2022 09:41:35 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Abel Wu <wuyun.abel@bytedance.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Josh Don <joshdon@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] sched/fair: ignore SIS_UTIL when has idle core
Message-ID: <20220907084135.izfqd7rga7fdk6u3@techsingularity.net>
References: <20220712082036.5130-1-wuyun.abel@bytedance.com>
 <20220712082036.5130-2-wuyun.abel@bytedance.com>
 <20220829130831.odhemmcmuecqxkbz@techsingularity.net>
 <51009414-5ffb-b6ec-a501-7b2514a0f3cc@bytedance.com>
 <20220829145621.7cxrywgxow5ov7ki@techsingularity.net>
 <0ffb0903-431f-88fe-3a56-150b283f5304@bytedance.com>
 <20220902102528.keooutttg3hq3sy5@techsingularity.net>
 <1fc40679-b7c3-24f2-aa27-f1edab71228e@bytedance.com>
 <20220906095717.maao4qtel4fhbmfq@techsingularity.net>
 <YxhH7cB+OIMAB0dM@chenyu5-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <YxhH7cB+OIMAB0dM@chenyu5-mobl1>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 03:27:41PM +0800, Chen Yu wrote:
> > Ok, that's rational. There will be corner cases where there was no idle
> > CPU near the target when there is an idle core far away but it would be
> > counter to the purpose of SIS_UTIL to care about that corner case.
> > 
> > >  2) Unconditionally full scan when has_idle_core is not good
> > >     for netperf_{udp,tcp} and tbench4. It is probably because
> > >     the SIS success rate of these workloads is already high
> > >     enough (netperf ~= 100%, tbench4 ~= 50%, compared to that
> > >     hackbench ~= 3.5%) which negate a lot of the benefit full
> > >     scan brings.
> > > 
> > 
> > That's also rational. For a single client/server on netperf, it's expected
> > that the SIS success rate is high and scanning is minimal. As the client
> > and server are sharing data on localhost and somewhat synchronous, it may
> > even partially benefit from SMT sharing.
> >
> Maybe off-topic, since we monitor the success rate and also other metrics
> for each optimization in SIS path, is it possible to merge your statistics
> patch [1] into upstream so we don't need to rebase in the future(although
> it is targeting kernel development)?
> 

I am doubtful it is a merge candidate. While it's very useful when modifying
SIS and gathering data on whether SIS is behaving as expected, it has little
practical benefit when debugging problems on normal systems.  Crude estimates
can be obtained by other methods. Probing when select_idle_sibling and
select_idle_cpu are called reveals the SIS fast and slow paths and the
ratio between time. Tracking the time spent in select_idle_cpu reveals
how much time is spent finding idle cores and cpus.

I would not object to someone trying but the changlog would benefit from
explaining why it's practically useful. Every time I've used it, it was to
justify another patch being merged or investigating various SIS corner cases.

-- 
Mel Gorman
SUSE Labs
