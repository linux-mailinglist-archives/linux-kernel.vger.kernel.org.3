Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23BEB4C16CC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 16:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242075AbiBWPaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 10:30:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242073AbiBWPaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 10:30:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C364D74DDE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 07:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645630181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lDvsZLGMcy42Kz83/SKdUVLKGuw2EB/u2DP8NSmc4HU=;
        b=P8oARu0hJ3H75CfI7bownX32KRYMcMmJdbrSXZE3QYIGtmuk5L+m946wFlfuvB2eNZHEGj
        bHA79wBhmG/7QUxGlWuWovR0BSySNBkMR4BclbjQy3ADrvMsjLVr/mk6pCGQuTJGUHFQjN
        YGHcPBa48fYM+Kv/qHJr1OK+DF5DBsc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-112-_ftGpdz6NIqOzdWzTM9_eg-1; Wed, 23 Feb 2022 10:29:39 -0500
X-MC-Unique: _ftGpdz6NIqOzdWzTM9_eg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D847804311;
        Wed, 23 Feb 2022 15:29:38 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.10.120])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 570791077CB9;
        Wed, 23 Feb 2022 15:28:43 +0000 (UTC)
Date:   Wed, 23 Feb 2022 10:28:41 -0500
From:   Phil Auld <pauld@redhat.com>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/sched: Update schedstats when migrating threads
Message-ID: <YhZSqd+d03oWUPP6@lorien.usersys.redhat.com>
References: <20220126152222.5429-1-carlos.bilbao@amd.com>
 <YhYKL4hxx4TNKHGD@hirez.programming.kicks-ass.net>
 <aac8f860-c01f-bda0-9f1b-029b234213c2@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aac8f860-c01f-bda0-9f1b-029b234213c2@amd.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 09:14:45AM -0600 Carlos Bilbao wrote:
> On 2/23/2022 4:19 AM, Peter Zijlstra wrote:
> > On Wed, Jan 26, 2022 at 09:22:23AM -0600, Carlos Bilbao wrote:
> >> The kernel manages per-task scheduler statistics or schedstats. Such
> >> counters should be reinitialized when the thread is migrated to a
> >> different core rq, except for the values recording number of migrations.
> > 
> > I'm confused, why should we reset schedstats on migrate? I'm thinking
> > this breaks per-task, since tasks tend to bounce around quite a lot.
> > 
> 
> Thanks for your comments, Peter. 
> 
> Looking at the documentation of schedstats I see that most values are 
> actually linked to the particular CPU: time spent on the cpu, timeslices 
> run on this cpu, number of times _something_ was called when the cpu was 
> idle, and so forth. Those values lose their meaning after migration and we 
> should reinitialize their counters. However, reviewing sched_statistics I 
> identify two fields that we should definitely keep increasing even after 
> migration (nr_migrations_cold, nr_forced_migrations).
>

The documentation is a little off. I think it should say "any cpu" instead
of "this cpu".  If you reset these per task counters (time on cpu, number
of timeslices etc) on every migration then they become meaningless (and
useless).


Cheers,
Phil

> So this patch will have to be upgraded if there's some other value(s) in
> schedstats that we do not want to reinitialize either.
> 
> >> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
> >> ---
> >>  kernel/sched/core.c | 10 +++++++++-
> >>  1 file changed, 9 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> >> index fe53e510e711..d64c2a290176 100644
> >> --- a/kernel/sched/core.c
> >> +++ b/kernel/sched/core.c
> >> @@ -8757,6 +8757,7 @@ bool sched_smp_initialized __read_mostly;
> >>  int migrate_task_to(struct task_struct *p, int target_cpu)
> >>  {
> >>  	struct migration_arg arg = { p, target_cpu };
> >> +	uint64_t forced_migrations, migrations_cold;
> >>  	int curr_cpu = task_cpu(p);
> >>  
> >>  	if (curr_cpu == target_cpu)
> >> @@ -8765,7 +8766,14 @@ int migrate_task_to(struct task_struct *p, int target_cpu)
> >>  	if (!cpumask_test_cpu(target_cpu, p->cpus_ptr))
> >>  		return -EINVAL;
> >>  
> >> -	/* TODO: This is not properly updating schedstats */
> >> +	if (schedstat_enabled()) {
> >> +		forced_migrations = schedstat_val(p->stats.nr_forced_migrations);
> >> +		migrations_cold = schedstat_val(p->stats.nr_migrations_cold);
> >> +		memset(&p->stats, 0, sizeof(p->stats));
> >> +		schedstat_set(p->stats.nr_forced_migrations, forced_migrations);
> >> +		schedstat_set(p->stats.nr_migrations_cold, migrations_cold);
> >> +		schedstat_inc(p->stats.nr_migrations_cold);
> >> +	}
> >>  
> >>  	trace_sched_move_numa(p, curr_cpu, target_cpu);
> >>  	return stop_one_cpu(curr_cpu, migration_cpu_stop, &arg);
> >> -- 
> >> 2.27.0
> >>
> 
> Thanks,
> Carlos
> 

-- 

