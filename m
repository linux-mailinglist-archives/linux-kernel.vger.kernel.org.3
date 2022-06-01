Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872A453AA5A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 17:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355790AbiFAPlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 11:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245526AbiFAPlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 11:41:50 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C94A60FC
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 08:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XJzDY301yKt0VVZM0rmEuWKeLHCV2Vkb2sofs525OQs=; b=PLabB5OtHoIB/4frWGMNVWA00O
        ZditpttdyZQWxCPoHckWtK0ija6YTapG5Q9NbpjWkhLjdkRjQBVxsiFHGUmoQAh3OU13xOKoS6CwS
        SkbOwYG7AkmrrUPlPoSvn4ZzPj7xCpTRhthTFiKUDE44qe/1evcoyiz6EVk7qw6wN7ZEAhXw57Bo1
        3CUIgr/3Wq021DYX1a1SBAFcwyH5pJSqLHeaUAaDe1obd89lKG5sWALX2etA4tYA+sinTRmsJm92B
        IYIrdzx0d1ahPreFBt+8FPX28tHJQ3NcAApTvu8PpJW2xBC6VIMv5QBgFac6SoWvZbZ3/anTsI/bG
        cQNuSsuQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwQTS-003oym-7w; Wed, 01 Jun 2022 15:41:31 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7E8CE98137D; Wed,  1 Jun 2022 17:41:27 +0200 (CEST)
Date:   Wed, 1 Jun 2022 17:41:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>, mingo@redhat.com,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        songmuchun@bytedance.com, zhengqi.arch@bytedance.com
Subject: Re: [PATCH v4] sched/fair: optimize and simplify rq leaf_cfs_rq_list
Message-ID: <YpeIp/Ljos6jNpKv@worktop.programming.kicks-ass.net>
References: <20220601021848.76943-1-zhouchengming@bytedance.com>
 <CAKfTPtBTj4u-NW4NDUORdWfdxsHwoMxzqEO4jAKVZDjyCKxL4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBTj4u-NW4NDUORdWfdxsHwoMxzqEO4jAKVZDjyCKxL4w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2022 at 03:22:12PM +0200, Vincent Guittot wrote:
> On Wed, 1 Jun 2022 at 04:19, Chengming Zhou <zhouchengming@bytedance.com> wrote:
> >
> > We notice the rq leaf_cfs_rq_list has two problems when do bugfix
> > backports and some test profiling.
> >
> > 1. cfs_rqs under throttled subtree could be added to the list, and
> >    make their fully decayed ancestors on the list, even though not needed.
> >
> > 2. #1 also make the leaf_cfs_rq_list management complex and error prone,
> >    this is the list of related bugfix so far:
> >
> >    commit 31bc6aeaab1d ("sched/fair: Optimize update_blocked_averages()")
> >    commit fe61468b2cbc ("sched/fair: Fix enqueue_task_fair warning")
> >    commit b34cb07dde7c ("sched/fair: Fix enqueue_task_fair() warning some more")
> >    commit 39f23ce07b93 ("sched/fair: Fix unthrottle_cfs_rq() for leaf_cfs_rq list")
> >    commit 0258bdfaff5b ("sched/fair: Fix unfairness caused by missing load decay")
> >    commit a7b359fc6a37 ("sched/fair: Correctly insert cfs_rq's to list on unthrottle")
> >    commit fdaba61ef8a2 ("sched/fair: Ensure that the CFS parent is added after unthrottling")
> >    commit 2630cde26711 ("sched/fair: Add ancestors of unthrottled undecayed cfs_rq")
> >
> > commit 31bc6aeaab1d ("sched/fair: Optimize update_blocked_averages()")
> > delete every cfs_rq under throttled subtree from rq->leaf_cfs_rq_list,
> > and delete the throttled_hierarchy() test in update_blocked_averages(),
> > which optimized update_blocked_averages().
> >
> > But those later bugfix add cfs_rqs under throttled subtree back to
> > rq->leaf_cfs_rq_list again, with their fully decayed ancestors, for
> > the integrity of rq->leaf_cfs_rq_list.
> >
> > This patch takes another method, skip all cfs_rqs under throttled
> > hierarchy when list_add_leaf_cfs_rq(), to completely make cfs_rqs
> > under throttled subtree off the leaf_cfs_rq_list.
> >
> > So we don't need to consider throttled related things in
> > enqueue_entity(), unthrottle_cfs_rq() and enqueue_task_fair(),
> > which simplify the code a lot. Also optimize update_blocked_averages()
> > since cfs_rqs under throttled hierarchy and their ancestors
> > won't be on the leaf_cfs_rq_list.
> >
> > Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> 
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

Thanks!
