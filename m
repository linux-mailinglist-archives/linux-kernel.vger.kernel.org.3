Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1144BFFEA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 18:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234588AbiBVRQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 12:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbiBVRQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 12:16:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C111F108744
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 09:15:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 224F76118F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 17:15:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79ED3C340E8;
        Tue, 22 Feb 2022 17:15:47 +0000 (UTC)
Date:   Tue, 22 Feb 2022 12:15:46 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/sched: Update schedstats when migrating threads
Message-ID: <20220222121546.4a45e049@gandalf.local.home>
In-Reply-To: <6b4d8615-4c60-3d89-5210-b495344cabd4@amd.com>
References: <20220126152222.5429-1-carlos.bilbao@amd.com>
        <6b4d8615-4c60-3d89-5210-b495344cabd4@amd.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Feb 2022 10:32:32 -0600
Carlos Bilbao <carlos.bilbao@amd.com> wrote:

> > @@ -8765,7 +8766,14 @@ int migrate_task_to(struct task_struct *p, int target_cpu)
> >  	if (!cpumask_test_cpu(target_cpu, p->cpus_ptr))
> >  		return -EINVAL;
> >  
> > -	/* TODO: This is not properly updating schedstats */
> > +	if (schedstat_enabled()) {
> > +		forced_migrations = schedstat_val(p->stats.nr_forced_migrations);
> > +		migrations_cold = schedstat_val(p->stats.nr_migrations_cold);
> > +		memset(&p->stats, 0, sizeof(p->stats));
> > +		schedstat_set(p->stats.nr_forced_migrations, forced_migrations);
> > +		schedstat_set(p->stats.nr_migrations_cold, migrations_cold);
> > +		schedstat_inc(p->stats.nr_migrations_cold);
> > +	}
> >  
> >  	trace_sched_move_numa(p, curr_cpu, target_cpu);
> >  	return stop_one_cpu(curr_cpu, migration_cpu_stop, &arg);  
> 
> 
> I would love to hear some thoughts on this. 

I have no issues with this.

Peter?

-- Steve
